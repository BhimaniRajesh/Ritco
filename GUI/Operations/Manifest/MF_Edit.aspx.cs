using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Xml;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_Manifest_MF_Edit : System.Web.UI.Page
{
    string EmployeeID = "", BranchCode = "", MFNo="";

    DataTable dtNewDockets { get { return (ViewState["dtNewDockets"] != null) ? ViewState["dtNewDockets"] as DataTable : new DataTable(); } set { ViewState["dtNewDockets"] = value; } }
     
    protected void Page_Load(object sender, EventArgs e)
    {
        lblError.Visible = false;
        try
        {
            EmployeeID = SessionUtilities.CurrentEmployeeID;
            BranchCode = SessionUtilities.CurrentBranchCode;
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/TimeOut.aspx", false);
        }        
        MFNo = (Request.QueryString["MFNo"] != null) ? Request.QueryString["MFNo"].ToString() : "";
        if (!IsPostBack && !IsCallback)
        {
            if (MFNo != "")
            {
                try
                {
                    BindDetails();
                }
                catch (Exception ex)
                {
                    lblError.Visible = true;
                    lblError.Text = ex.Message;
                }
            }
        }
        else
        {
            txttotaldockets.Text = hidtotaldockets.Value;
            txttotalpackages.Text = hidtotalpackages.Value;
            txttotalweight.Text = hidtotalweight.Value;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            float iDKT = float.Parse(hidtotaldockets.Value);
            if (iDKT > 0)
            {
                XmlDocument XDoc = GenerateXML();
                XmlDocument XDocAdd = GenerateXML_Add();

                string sp = "usp_MF_Edit";

                SqlParameter[] prms = new SqlParameter[4];
                prms[0] = new SqlParameter("@XML", XDoc.InnerXml);
                prms[1] = new SqlParameter("@XML_ADD", XDocAdd.InnerXml);
                prms[2] = new SqlParameter("@UpdateBy", EmployeeID);
                prms[3] = new SqlParameter("@MFCode", lblmfno.Text.Trim());

                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, prms);
                if (obj != null)
                {
                    string[] strRes = obj.ToString().Split('|');
                    if (strRes[0] == "0")
                        throw new Exception(strRes[1]);


                    Response.Redirect("DisplayMFResult.aspx?MFNo=" + lblmfno.Text + "&ManMFNo=");
                    //BindDetails();   
                }
                else
                    throw new Exception("Operation fail: Unknown exception");
            }
            else
                throw new Exception("Can not delete all "+SessionUtilities.DocketCalledAs);
        }
        catch (Exception ex)
        {
            lblError.Visible = true;
            lblError.Text = ex.Message; // +"<br/>" + ex.StackTrace;
        }
    }
    private void BindDetails()
    {
        string cmd = "";
        cmd = "SELECT TCNo,TCDT,TCDate=Convert(varchar,TCDT,106),TOT_DKT,TOT_PKGS,TOT_LOAD_PKGS,TOT_ACTUWT=Convert(Numeric(18,2),"+
              "TOT_ACTUWT),TOT_LOAD_ACTWT=Convert(Numeric(18,2),TOT_LOAD_ACTWT),ToBH_CODE,WTADJ_PM=ISNULL(WTADJ_PM,'+'),WTADJ=ISNULL(WTADJ,0) " +
              "FROM [webx_TCHDR] WHERE TCNo='" + MFNo + "'";

        SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, cmd);
        while (dr.Read())
        {
            lblmfno.Text = MFNo;
            lblmfdate.Text = dr["TCDate"].ToString();
            hidmfdate.Value = dr["TCDT"].ToString();
            lblnextstop.Text = dr["ToBH_CODE"].ToString();
            txttotaldockets.Text = dr["TOT_DKT"].ToString();
            hidtotaldockets.Value = dr["TOT_DKT"].ToString();
            txttotalpackages.Text = dr["TOT_LOAD_PKGS"].ToString();
            hidtotalpackages.Value = dr["TOT_LOAD_PKGS"].ToString();
            txttotalweight.Text = dr["TOT_LOAD_ACTWT"].ToString();
            hidtotalweight.Value = dr["TOT_LOAD_ACTWT"].ToString();
            hidTotActWt.Value = dr["TOT_ACTUWT"].ToString();
            hidTotActPkg.Value = dr["TOT_PKGS"].ToString();
            lblTotActWt.Text = dr["TOT_ACTUWT"].ToString();
            lblTotActPkg.Text = dr["TOT_PKGS"].ToString();            
            DDLWTADJ.SelectedValue = dr["WTADJ_PM"].ToString();
            txtWtAdj.Text = dr["WTADJ"].ToString();
            lblTOTWT.Text = dr["TOT_LOAD_ACTWT"].ToString();
            lblTotAdjAmt.Text = ((DDLWTADJ.SelectedValue == "+") ? (Convert.ToDouble(dr["TOT_LOAD_ACTWT"]) + Convert.ToDouble(dr["WTADJ"])).ToString("0.00")
                                                             : (Convert.ToDouble(dr["TOT_LOAD_ACTWT"]) - Convert.ToDouble(dr["WTADJ"])).ToString("0.00"));
        }
        dr.Close();
        dr.Dispose();

        cmd = "SELECT DOCKET=(T.DOCKNO+T.DOCKSF),T.DOCKNO,T.DOCKSF,D.ORGNCD,DESTCD=ISNULL(D.Reassign_DestCD,D.DESTCD),D.FROM_LOC,D.TO_LOC,D.PKGSNO,T.LOADPKGSNO," +
              "ACTUWT=Convert(Numeric(18,2),D.ACTUWT),LOADACTUWT=Convert(Numeric(18,2),T.LOADACTUWT), LS " +
              "FROM WebX_Master_Docket D " +
              "Inner Join Webx_Trans_Docket_Status S On S.DOCKNO=D.DOCKNO " +
              "Inner join webx_TCTRN T On S.DOCKNO=T.DOCKNO AND S.DOCKSF=T.DOCKSF WHERE T.TCNo='" + MFNo + "'";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, cmd);

        gvmfdetails.DataSource = ds;
        gvmfdetails.DataBind();       
    }
    private XmlDocument GenerateXML()
    {
        XmlDocument XDoc = new XmlDocument();

        XmlElement root = XDoc.CreateElement("root");
        XmlElement TCHDR = XDoc.CreateElement("TCHDR");
        XmlElement TCTRN = XDoc.CreateElement("TCTRN"); 
        XmlElement TCTRN_DEL = XDoc.CreateElement("TCTRN_DEL");
        //XmlElement TCTRN_ADD = XDoc.CreateElement("TCTRN_ADD"); 

        TCHDR.AppendChild(CreateElement(XDoc, "TCNO", lblmfno.Text));
        TCHDR.AppendChild(CreateElement(XDoc, "TCBR", BranchCode));
        TCHDR.AppendChild(CreateElement(XDoc, "TOT_DKT", hidtotaldockets.Value));
        TCHDR.AppendChild(CreateElement(XDoc, "TOT_PKGS", hidTotActPkg.Value));
        TCHDR.AppendChild(CreateElement(XDoc, "TOT_ACTUWT", hidTotActWt.Value));
        TCHDR.AppendChild(CreateElement(XDoc, "TOT_LOAD_PKGS", hidtotalpackages.Value));
        TCHDR.AppendChild(CreateElement(XDoc, "TOT_LOAD_ACTUWT", hidtotalweight.Value));
        TCHDR.AppendChild(CreateElement(XDoc, "WTADJ_PM", DDLWTADJ.SelectedValue));
        TCHDR.AppendChild(CreateElement(XDoc, "WTADJ", txtWtAdj.Text));

        root.AppendChild(TCHDR);

        foreach (GridViewRow gvr in gvmfdetails.Rows)
        {
            CheckBox chkDocket = gvr.FindControl("chkDocket") as CheckBox;
            HiddenField hidDockNo = gvr.FindControl("hidDockNo") as HiddenField;
            HiddenField hidDockSF = gvr.FindControl("hidDockSF") as HiddenField;
            HiddenField hidPkgsLoad = gvr.FindControl("hidPkgsLoad") as HiddenField;
            HiddenField hidWeightLoad = gvr.FindControl("hidWeightLoad") as HiddenField;

            if (chkDocket.Checked)
            {
                XmlElement DET = XDoc.CreateElement("DET");
                DET.AppendChild(CreateElement(XDoc, "TCNO", lblmfno.Text));
                DET.AppendChild(CreateElement(XDoc, "TCBR", BranchCode));
                DET.AppendChild(CreateElement(XDoc, "DOCKNO", hidDockNo.Value));
                DET.AppendChild(CreateElement(XDoc, "DOCKSF", hidDockSF.Value));
                DET.AppendChild(CreateElement(XDoc, "LOADPKGSNO", hidPkgsLoad.Value));
                DET.AppendChild(CreateElement(XDoc, "LOADACTUWT", Convert.ToDouble(hidWeightLoad.Value).ToString("0.0")));
                TCTRN_DEL.AppendChild(DET);
            }
            else
            {
                XmlElement DET = XDoc.CreateElement("DET");
                DET.AppendChild(CreateElement(XDoc, "TCNO", lblmfno.Text));
                DET.AppendChild(CreateElement(XDoc, "TCBR", BranchCode));
                DET.AppendChild(CreateElement(XDoc, "DOCKNO", hidDockNo.Value));
                DET.AppendChild(CreateElement(XDoc, "DOCKSF", hidDockSF.Value));
                DET.AppendChild(CreateElement(XDoc, "LOADPKGSNO", hidPkgsLoad.Value));
                DET.AppendChild(CreateElement(XDoc, "LOADACTUWT", Convert.ToDouble(hidWeightLoad.Value).ToString("0.0")));
                TCTRN.AppendChild(DET);
            }
        }
        
        root.AppendChild(TCTRN);
        root.AppendChild(TCTRN_DEL);
        XDoc.AppendChild(root);

        return XDoc;
    }

    private XmlDocument GenerateXML_Add()
    {
        XmlDocument XDoc = new XmlDocument();

        XmlElement root = XDoc.CreateElement("root");
        XmlElement TCTRN_ADD = XDoc.CreateElement("TCTRN_ADD");
                
        int index = 0;
        foreach (GridViewRow gvr in dgDockets.Rows)
        {
            CheckBox chkDocket = gvr.FindControl("chkDocket") as CheckBox;
            TextBox txtPkgs = (TextBox)dgDockets.Rows[index].FindControl("txtPkgs");
            TextBox txtWt = (TextBox)dgDockets.Rows[index].FindControl("txtWt");
            
            if (chkDocket.Checked)
            {
                XmlElement DET = XDoc.CreateElement("tctrn");
                DET.AppendChild(CreateElement(XDoc, "TCNO", lblmfno.Text));
                DET.AppendChild(CreateElement(XDoc, "TCSF", "."));
                DET.AppendChild(CreateElement(XDoc, "TCBR", BranchCode));
                DET.AppendChild(CreateElement(XDoc, "DOCKNO", dgDockets.DataKeys[index].Values[0].ToString().Trim()));
                DET.AppendChild(CreateElement(XDoc, "DOCKSF", dgDockets.DataKeys[index].Values[1].ToString().Trim()));
                DET.AppendChild(CreateElement(XDoc, "LOADPKGSNO", txtPkgs.Text));
                DET.AppendChild(CreateElement(XDoc, "LOADACTUWT", Convert.ToDouble(txtWt.Text).ToString("0.0")));
                DET.AppendChild(CreateElement(XDoc, "LOADCFTWT", Convert.ToDouble(txtWt.Text).ToString("0.0")));
                DET.AppendChild(CreateElement(XDoc, "TCDT", lblmfdate.Text.Trim()));
                DET.AppendChild(CreateElement(XDoc, "NEXTLOC", lblnextstop.Text.Trim()));

                XmlElement wtds = XDoc.CreateElement("wtds");
                wtds.AppendChild(CreateElement(XDoc, "TCNO", lblmfno.Text));
                DET.AppendChild(CreateElement(XDoc, "TCSF", "."));
                wtds.AppendChild(CreateElement(XDoc, "TCBR", BranchCode));
                wtds.AppendChild(CreateElement(XDoc, "DOCKNO", dgDockets.DataKeys[index].Values[0].ToString().Trim()));
                wtds.AppendChild(CreateElement(XDoc, "DOCKSF", dgDockets.DataKeys[index].Values[1].ToString().Trim()));
                wtds.AppendChild(CreateElement(XDoc, "LOADPKGSNO", txtPkgs.Text));
                wtds.AppendChild(CreateElement(XDoc, "LOADACTUWT", Convert.ToDouble(txtWt.Text).ToString("0.0")));
                wtds.AppendChild(CreateElement(XDoc, "TCDT", lblmfdate.Text.Trim()));
                wtds.AppendChild(CreateElement(XDoc, "NEXTLOC", lblnextstop.Text.Trim()));

                TCTRN_ADD.AppendChild(DET);
                TCTRN_ADD.AppendChild(wtds);
            }
            index++;
        }
        root.AppendChild(TCTRN_ADD);
        XDoc.AppendChild(root);

        return XDoc;
    }

    private XmlElement CreateElement(XmlDocument XDoc, string name, string value)
    {
        XmlElement xa = XDoc.CreateElement(name);
        xa.InnerText = value;
        return xa;
    }
    protected void btnAddDkt_Click(object sender, EventArgs e)
    {
        if (txtDockNos.Text.Trim() != "")
        {
            //string[] Docknos = txtDockNos.Text.Split(',');

            //Make & Open Connection
            SqlConnection sqlCon = new SqlConnection(SessionUtilities.ConnectionString);
            sqlCon.Open();

            string sql = "usp_DocketList_For_MF_Generation";
            SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
            sqlCmd.Parameters.Add("@nextstop", SqlDbType.VarChar).Value = lblnextstop.Text.Trim();
            sqlCmd.Parameters.Add("@trnmod", SqlDbType.Char).Value = "";
            sqlCmd.Parameters.Add("@dockdatefrom", SqlDbType.DateTime).Value = DateTime.Now;
            sqlCmd.Parameters.Add("@dockdateto", SqlDbType.DateTime).Value = DateTime.Now;
            sqlCmd.Parameters.Add("@destlist", SqlDbType.Char).Value = "";
            sqlCmd.Parameters.Add("@regionlist", SqlDbType.VarChar).Value = "";
            sqlCmd.Parameters.Add("@city_from", SqlDbType.VarChar).Value = "";
            sqlCmd.Parameters.Add("@city_to", SqlDbType.VarChar).Value = "";
            sqlCmd.Parameters.Add("@docketlist", SqlDbType.Char).Value = txtDockNos.Text.Trim();
            sqlCmd.Parameters.Add("@mfdate", SqlDbType.DateTime).Value = Convert.ToDateTime(lblmfdate.Text.Trim());

            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            DataSet ds = new DataSet();
            //DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();

            if (ds.Tables.Count > 0)
            {
                dtNewDockets = ds.Tables[0];
                dgDockets.DataSource = dtNewDockets;
                dgDockets.DataBind();
            }
        }
    }
}
