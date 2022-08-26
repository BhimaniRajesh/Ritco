using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_UNI_MIS_ServiceTax_Servies_Tax_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    string Number;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string No, sql, i, LocCode, RoCode, MRTypeValue, Amount;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!(IsPostBack))
        {
           
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");
            lblParty.Text = Request.QueryString["Party"];
            lblType.Text = Request.QueryString["Type"];
            lblRO.Text = Request.QueryString["Ro"];
            lblBranch.Text = Request.QueryString["Loc"];
            Amount = Request.QueryString["Amount"];
            if (Amount.ToString() == "ALL")
            {
                lblAmount.Text = Amount;
                Amount = "0";
            }
            No = Request.QueryString["MRNumber"];
            LocCode = Request.QueryString["LocCode"];
            RoCode = Request.QueryString["RoCode"];
            MRTypeValue = Request.QueryString["MRTypeValue"];

            BindGrid();
        }
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "webx_SVCTAX_REGISTER_new";

        sqlCommand.Parameters.AddWithValue("@CUSTCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@DATEFROM", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@DATETO", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@MRTYP", MRTypeValue);
        sqlCommand.Parameters.AddWithValue("@MRSTATUS", "ALL");
        sqlCommand.Parameters.AddWithValue("@MRAMT", Amount);
        sqlCommand.Parameters.AddWithValue("@MRBRCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@BOOKBRCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@DELBRCD", LocCode);
        sqlCommand.Parameters.AddWithValue("@RO", RoCode);
        sqlCommand.Parameters.AddWithValue("@DOCNO", No);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        ds = new DataSet();
        dsPages = new DataSet();

        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtMRDetails");
        sqlDA.Fill(dsPages);

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
            HIDCurrentPageNo.Value = "1";
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;

            // trForTotalValues.Visible = false;
            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;
        }
        else
        {
            double dblTotalRecords = dsPages.Tables[0].Rows.Count;
            double dblTotalPages = Convert.ToDouble(System.Math.Ceiling(Convert.ToDecimal(dblTotalRecords / intPageSize)));
            if (dblTotalPages <= 1)
            {
                tblPageNavigation.Visible = false;
            }
            //Logic for Managing Page Navigation Links
            if (intCurrentPageNo == 1)
            {
                FirstPage.Enabled = false;
                PreviousPage.Enabled = false;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }
            else if (intCurrentPageNo == dblTotalPages)
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = false;
                LastPage.Enabled = false;
            }
            else
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }

            ddlPages.Items.Clear();

            ListItem lItem;

            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                ddlPages.Items.Add(lItem);

                if (i == Convert.ToInt32(HIDCurrentPageNo.Value))
                {
                    ddlPages.SelectedIndex = ddlPages.Items.Count - 1;
                }

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("MR_Number", typeof(string));
            dt.Columns.Add("DocNo", typeof(string));
            dt.Columns.Add("MR_Type", typeof(string));
            dt.Columns.Add("MR_Date", typeof(string));
            dt.Columns.Add("MR_Party", typeof(string));
            dt.Columns.Add("MR_Branch", typeof(string));
            dt.Columns.Add("MR_Amt", typeof(string));
            dt.Columns.Add("Svc_Tax", typeof(string));
            dt.Columns.Add("Cess_Rate", typeof(string));
            dt.Columns.Add("Doc_Fre", typeof(string));
            dt.Columns.Add("Doc_Svc", typeof(string));
            dt.Columns.Add("Doc_Cess", typeof(string));
            dt.Columns.Add("Dedu_Fre", typeof(string));
            dt.Columns.Add("Dedu_Svc", typeof(string));
            dt.Columns.Add("Dedu_Cess", typeof(string));
            dt.Columns.Add("Chrg_Fre", typeof(string));
            dt.Columns.Add("Chrg_Svc", typeof(string));
            dt.Columns.Add("Chrg_Cess", typeof(string));
            dt.Columns.Add("Rec_Fre", typeof(string));
            dt.Columns.Add("Rec_Svc", typeof(string));
            dt.Columns.Add("Rec_Cess", typeof(string));
            dt.Columns.Add("TDS", typeof(string));
            dt.Columns.Add("Net_Amt", typeof(string));
            dt.Columns.Add("NavURL", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double MRAmt = 0;
            double DocFre = 0;
            double DocSvc = 0;
            double DocCess = 0;
            double DeduFre = 0;
            double DeduSvc = 0;
            double DeduCess = 0;
            double ChrgFre = 0;
            double ChrgSvc = 0;
            double ChrgCess = 0;
            double RecFre = 0;
            double RecSvc = 0;
            double RecCess = 0;
            double TDS = 0;
            double NetAmt = 0;


            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["NavURL"] = "javascript:OpenPopup('" + drRows["MRSNo"].ToString() + "')";
                dr["MR_Number"] = drRows["MRSNo"].ToString();
                dr["DocNo"] = drRows["dockno"].ToString();
                string Type = drRows["MRSTYPE"].ToString();
                if (Type.ToString() == "1")
                {
                    dr["MR_Type"] = "Paid";
                }
                if (Type.ToString() == "2")
                {
                    dr["MR_Type"] = "TBB";
                }
                if (Type.ToString() == "3")
                {
                    dr["MR_Type"] = "ToPay";
                }
                
                dr["MR_Date"] =Convert.ToDateTime(drRows["MRSDT"]).ToString("dd/MM/yyyy");

                dr["MR_Party"] = drRows["PTCD"].ToString() + " : " + drRows["PTNAME"].ToString();
                dr["MR_Branch"] = drRows["MRSBR"].ToString();

                if (drRows["MRSAMT"] is DBNull)
                {
                    dr["MR_Amt"] = "0.00";
                }
                else
                {
                    dr["MR_Amt"] = Convert.ToDouble(drRows["MRSAMT"].ToString());
                    MRAmt += Convert.ToDouble(drRows["MRSAMT"]);
                }
                dr["Svc_Tax"] = drRows["svctax_rate"].ToString();
                dr["Cess_Rate"] = drRows["cess_rate"].ToString();
                if (drRows["COL_FRT"] is DBNull)
                {
                    dr["Doc_Fre"] = "0.00";
                }
                else
                {
                    dr["Doc_Fre"] = Convert.ToDouble(drRows["COL_FRT"].ToString());
                    DocFre += Convert.ToDouble(drRows["COL_FRT"]);
                }
                if (drRows["COL_STAX"] is DBNull)
                {
                    dr["Doc_Svc"] = "0.00";
                }
                else
                {
                    dr["Doc_Svc"] = Convert.ToDouble(drRows["COL_STAX"].ToString());
                    DocSvc += Convert.ToDouble(drRows["COL_STAX"]);
                }
                if (drRows["COL_CESS"] is DBNull)
                {
                    dr["Doc_Cess"] = "0.00";
                }
                else
                {
                    dr["Doc_Cess"] = Convert.ToDouble(drRows["COL_CESS"].ToString());
                    DocCess += Convert.ToDouble(drRows["COL_CESS"]);
                }
                if (drRows["Othded_frt"] is DBNull)
                {
                    dr["Dedu_Fre"] = "0.00";
                }
                else
                {
                    dr["Dedu_Fre"] = Convert.ToDouble(drRows["Othded_frt"].ToString());
                    DeduFre += Convert.ToDouble(drRows["Othded_frt"]);
                }
                if (drRows["Othded_svctax"] is DBNull)
                {
                    dr["Dedu_Svc"] = "0.00";
                }
                else
                {
                    dr["Dedu_Svc"] = Convert.ToDouble(drRows["Othded_svctax"].ToString());
                    DeduSvc += Convert.ToDouble(drRows["Othded_svctax"]);
                }
                if (drRows["Othded_cess"] is DBNull)
                {
                    dr["Dedu_Cess"] = "0.00";
                }
                else
                {
                    dr["Dedu_Cess"] = Convert.ToDouble(drRows["Othded_cess"].ToString());
                    DeduCess += Convert.ToDouble(drRows["Othded_cess"]);
                }
                if (drRows["Othchrg_frt"] is DBNull)
                {
                    dr["Chrg_Fre"] = "0.00";
                }
                else
                {
                    dr["Chrg_Fre"] = Convert.ToDouble(drRows["Othchrg_frt"].ToString());
                    ChrgFre += Convert.ToDouble(drRows["Othchrg_frt"]);
                }
                if (drRows["Othchrg_svctax"] is DBNull)
                {
                    dr["Chrg_Svc"] = "0.00";
                }
                else
                {
                    dr["Chrg_Svc"] = Convert.ToDouble(drRows["Othchrg_svctax"].ToString());
                    ChrgSvc += Convert.ToDouble(drRows["Othchrg_svctax"]);
                }
                if (drRows["Othchrg_cess"] is DBNull)
                {
                    dr["Chrg_Cess"] = "0.00";
                }
                else
                {
                    dr["Chrg_Cess"] = Convert.ToDouble(drRows["Othchrg_cess"].ToString());
                    ChrgCess += Convert.ToDouble(drRows["Othchrg_cess"]);
                }

                dr["Rec_Fre"] = Convert.ToDouble(dr["Doc_Fre"]) - Convert.ToDouble(dr["Dedu_Fre"]) + Convert.ToDouble(dr["Chrg_Fre"]);
                RecFre += Convert.ToDouble(dr["Rec_Fre"]);
                dr["Rec_Svc"] = Convert.ToDouble(dr["Doc_Svc"]) - Convert.ToDouble(dr["Dedu_Svc"]) + Convert.ToDouble(dr["Chrg_Svc"]);
                RecSvc += Convert.ToDouble(dr["Rec_Svc"]);
                dr["Rec_Cess"] = Convert.ToDouble(dr["Doc_Cess"]) - Convert.ToDouble(dr["Dedu_Cess"]) + Convert.ToDouble(dr["Chrg_Cess"]);
                RecCess += Convert.ToDouble(dr["Rec_Cess"]);
                if (drRows["DED_TDS"] is DBNull)
                {
                    dr["TDS"] = "0.00";
                }
                else
                {
                    dr["TDS"] = Convert.ToDouble(drRows["DED_TDS"].ToString());
                    TDS += Convert.ToDouble(drRows["DED_TDS"]);
                }
                if (drRows["NETAMT"] is DBNull)
                {
                    dr["Net_Amt"] = "0.00";
                }
                else
                {
                    dr["Net_Amt"] = Convert.ToDouble(drRows["NETAMT"].ToString());
                    NetAmt += Convert.ToDouble(drRows["NETAMT"]);
                }

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblMRAmt.Text = MRAmt.ToString();
                lblDocFre.Text = DocFre.ToString();
                lblDocSer.Text = DocSvc.ToString();
                lblDocCess.Text = DocCess.ToString();
                lblDeduFre.Text = DeduFre.ToString();
                lblDeduSer.Text = DeduSvc.ToString();
                lblDeduCess.Text = DeduCess.ToString();
                lblChrgFre.Text = ChrgFre.ToString();
                lblChrgSer.Text = ChrgSvc.ToString();
                lblChrgCess.Text = ChrgCess.ToString();
                lblRecFre.Text = RecFre.ToString();
                lblRecSer.Text = RecSvc.ToString();
                lblRecCess.Text = RecCess.ToString();
                lblTDS.Text = TDS.ToString();
                lblNetAmt.Text = NetAmt.ToString();
            }
        }
    }
    protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "First":
                intCurrentPageNo = 1;
                break;
            case "Last":
                intCurrentPageNo = Int32.Parse(TotalPages.Text);
                break;
            case "Next":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
                break;
            case "Prev":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
                break;
        }
        HIDCurrentPageNo.Value = intCurrentPageNo.ToString();
        BindGrid();

    }    
    protected void btnXLS_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("MR_Summary.csv"), false);

        DataTable dt = ds.Tables[0];
        int iColCount = dt.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(ds.Tables[0].Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);

        foreach (DataRow dr in dt.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();

        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("DMRV_Summary.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "DMRV_Summary.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
    }
}
