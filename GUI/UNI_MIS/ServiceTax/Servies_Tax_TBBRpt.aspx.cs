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

public partial class GUI_UNI_MIS_ServiceTax_Servies_Tax_TBBRpt : System.Web.UI.Page
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
            dt.Columns.Add("MR_Date", typeof(string));
            dt.Columns.Add("Bill_No", typeof(string));
            dt.Columns.Add("Bill_Date", typeof(string));
            dt.Columns.Add("Party", typeof(string));
            dt.Columns.Add("Bill_Branch", typeof(string));
            dt.Columns.Add("Bill_Amt", typeof(string));
            dt.Columns.Add("Svc_Tax", typeof(string));
            dt.Columns.Add("Cess_Rate", typeof(string));
            dt.Columns.Add("Bill_Fre", typeof(string));
            dt.Columns.Add("Bill_Svc", typeof(string));
            dt.Columns.Add("Bill_Cess", typeof(string));
            dt.Columns.Add("Dedu_Fre", typeof(string));
            dt.Columns.Add("Dedu_Svc", typeof(string));
            dt.Columns.Add("Dedu_Cess", typeof(string));
            dt.Columns.Add("Rec_Fre", typeof(string));
            dt.Columns.Add("Rec_Svc", typeof(string));
            dt.Columns.Add("Rec_Cess", typeof(string));
            dt.Columns.Add("TDS", typeof(string));
            dt.Columns.Add("Dedu", typeof(string));
            dt.Columns.Add("Bal_Fre", typeof(string));
            dt.Columns.Add("Bal_Svc", typeof(string));
            dt.Columns.Add("Bal_Cess", typeof(string));
            dt.Columns.Add("Net_Amt", typeof(string));
            dt.Columns.Add("NavURL", typeof(string));
            dt.Columns.Add("NavURL1", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double BillAmt = 0;
            double BillFre = 0;
            double BillSvc = 0;
            double BillCess = 0;
            double DeduFre = 0;
            double DeduSvc = 0;
            double DeduCess = 0;
            double RecFre = 0;
            double RecSvc = 0;
            double RecCess = 0;
            double TDS = 0;
            double Dedu = 0;
            double BalFre = 0;
            double BalSvc = 0;
            double BalCess = 0;
            double NetAmt = 0;


            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["NavURL"] = "javascript:OpenPopup('" + drRows["MRSNo"].ToString() + "')";
                dr["MR_Number"] = drRows["MRSNo"].ToString();
                
                dr["MR_Date"] = Convert.ToDateTime(drRows["MRSDT"]).ToString("dd MMM yyyy");

                dr["NavURL1"] = "javascript:OpenBillPopup('" + drRows["billno"].ToString() + "')";
                dr["Bill_No"] = drRows["billno"].ToString();
                
                dr["Bill_Date"] = Convert.ToDateTime(drRows["bgndt"]).ToString("dd MMM yyyy");

                dr["Party"] = drRows["ptmscd"].ToString() + " : " + drRows["ptmsnm"].ToString();
                dr["Bill_Branch"] = drRows["billsubbrcd"].ToString();
                if (drRows["billamt"] is DBNull)
                {
                    dr["Bill_Amt"] = "0.00";
                }
                else
                {
                    dr["Bill_Amt"] = Convert.ToDouble(drRows["billamt"].ToString());
                    BillAmt += Convert.ToDouble(drRows["billamt"].ToString());
                }
                dr["Svc_Tax"] = drRows["svctax_rate"].ToString();
                dr["Cess_Rate"] = drRows["cess_rate"].ToString();

                if (drRows["bill_frt"] is DBNull)
                {
                    dr["Bill_Fre"] = "0.00";
                }
                else
                {
                    dr["Bill_Fre"] = Convert.ToDouble(drRows["bill_frt"].ToString());
                    BillFre += Convert.ToDouble(drRows["bill_frt"].ToString());
                }
                if (drRows["bill_stax"] is DBNull)
                {
                    dr["Bill_Svc"] = "0.00";
                }
                else
                {
                    dr["Bill_Svc"] = Convert.ToDouble(drRows["bill_stax"].ToString());
                    BillSvc += Convert.ToDouble(drRows["bill_stax"].ToString());
                }
                if (drRows["bill_cess"] is DBNull)
                {
                    dr["Bill_Cess"] = "0.00";
                }
                else
                {
                    dr["Bill_Cess"] = Convert.ToDouble(drRows["bill_cess"].ToString());
                    BillCess += Convert.ToDouble(drRows["bill_cess"].ToString());
                }
                if (drRows["FRTDED_frt"] is DBNull)
                {
                    dr["Dedu_Fre"] = "0.00";
                }
                else
                {
                    dr["Dedu_Fre"] = Convert.ToDouble(drRows["FRTDED_frt"].ToString());
                    DeduFre += Convert.ToDouble(drRows["FRTDED_frt"].ToString());
                }
                if (drRows["FRTDED_svctax"] is DBNull)
                {
                    dr["Dedu_Svc"] = "0.00";
                }
                else
                {
                    dr["Dedu_Svc"] = Convert.ToDouble(drRows["FRTDED_scvtax"].ToString());
                    DeduSvc += Convert.ToDouble(drRows["FRTDED_svctax"].ToString());
                }
                if (drRows["FRTDED_cess"] is DBNull)
                {
                    dr["Dedu_Cess"] = "0.00";
                }
                else
                {
                    dr["Dedu_Cess"] = Convert.ToDouble(drRows["FRTDED_cess"].ToString());
                    DeduCess += Convert.ToDouble(drRows["FRTDED_cess"].ToString());
                }
                dr["Rec_Fre"] = Convert.ToDouble(dr["Bill_Fre"]) - Convert.ToDouble(dr["Dedu_Fre"]);
                RecFre += Convert.ToDouble(dr["Rec_Fre"]);
                dr["Rec_Svc"] = Convert.ToDouble(dr["Bill_Svc"]) - Convert.ToDouble(dr["Dedu_Svc"]);
                RecSvc += Convert.ToDouble(dr["Rec_Svc"]);
                dr["Rec_Cess"] = Convert.ToDouble(dr["Bill_Cess"]) - Convert.ToDouble(dr["Dedu_Cess"]);
                RecCess += Convert.ToDouble(dr["Rec_Cess"]);
                if (drRows["tdsded"] is DBNull)
                {
                    dr["TDS"] = "0.00";
                }
                else
                {
                    dr["TDS"] = Convert.ToDouble(drRows["tdsded"].ToString());
                    TDS += Convert.ToDouble(drRows["tdsded"].ToString());
                }
                if (drRows["clmded"] is DBNull)
                {
                    dr["Dedu"] = "0.00";
                }
                else
                {
                    dr["Dedu"] = Convert.ToDouble(drRows["clmded"].ToString());
                    Dedu += Convert.ToDouble(drRows["clmded"].ToString());
                }
                if (drRows["balance_frt"] is DBNull)
                {
                    dr["Bal_Fre"] = "0.00";
                }
                else
                {
                    dr["Bal_Fre"] = Convert.ToDouble(drRows["balance_frt"].ToString());
                    BalFre += Convert.ToDouble(drRows["balance_frt"].ToString());
                }
                if (drRows["balance_stax"] is DBNull)
                {
                    dr["Bal_Svc"] = "0.00";
                }
                else
                {
                    dr["Bal_Svc"] = Convert.ToDouble(drRows["balance_stax"].ToString());
                    BalSvc += Convert.ToDouble(drRows["balance_stax"].ToString());
                }
                if (drRows["balance_cess"] is DBNull)
                {
                    dr["Bal_Cess"] = "0.00";
                }
                else
                {
                    dr["Bal_Cess"] = Convert.ToDouble(drRows["balance_cess"].ToString());
                }
                if (drRows["balamt"] is DBNull)
                {
                    dr["Net_Amt"] = "0.00";
                }
                else
                {
                    dr["Net_Amt"] = Convert.ToDouble(drRows["balamt"].ToString());
                    NetAmt += Convert.ToDouble(drRows["balamt"].ToString());
                }

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblBillAmt.Text = BillAmt.ToString();
                lblBillFre.Text = BillFre.ToString();
                lblBillSer.Text = BillSvc.ToString();
                lblBillCess.Text = BillCess.ToString();
                lblDeduFre.Text = DeduFre.ToString();
                lblDeduSer.Text = DeduSvc.ToString();
                lblDeduCess.Text = DeduCess.ToString();
                lblRecFre.Text = RecFre.ToString();
                lblRecSer.Text = RecSvc.ToString();
                lblRecCess.Text = RecCess.ToString();
                lblTDS.Text = TDS.ToString();
                lblCalim.Text = Dedu.ToString();
                lblBalFre.Text = BalFre.ToString();
                lblBalSer.Text = BalSvc.ToString();
                lblBalCess.Text = BalCess.ToString();
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
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Tax_Summary.csv"), false);

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
