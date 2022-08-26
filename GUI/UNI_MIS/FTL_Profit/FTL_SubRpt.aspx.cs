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

public partial class GUI_UNI_MIS_FTL_Profit_FTL_SubRpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string sql, i, LocCode, RoCode, DateType;
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
            lblBookLoc.Text = Request.QueryString["Ro"];
            lblCust.Text = Request.QueryString["CustCode"];
            RoCode = Request.QueryString["RoCode"];
            LocCode = Request.QueryString["LocCode"];

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

        sqlCommand.CommandText = "webx_DKT_FTL_profitability";

        sqlCommand.Parameters.AddWithValue("@FROMDT", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@TODT", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@RO", RoCode);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", LocCode);
        sqlCommand.Parameters.AddWithValue("@CSGNCD", lblCust.Text);

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
            dt.Columns.Add("Doc_No", typeof(string));
            dt.Columns.Add("BkgDate", typeof(string));
            dt.Columns.Add("Book_Loc", typeof(string));
            dt.Columns.Add("Desti", typeof(string));
            dt.Columns.Add("Consignor", typeof(string));
            dt.Columns.Add("Consignee", typeof(string));
            dt.Columns.Add("Pay", typeof(string));
            dt.Columns.Add("Doc_Sub", typeof(string));
            dt.Columns.Add("STax", typeof(string));
            dt.Columns.Add("Cess", typeof(string));
            dt.Columns.Add("Doc_Tot", typeof(string));
            dt.Columns.Add("Thc_No", typeof(string));
            dt.Columns.Add("Thc_Date", typeof(string));
            dt.Columns.Add("Thc_Amt", typeof(string));
            dt.Columns.Add("Profit", typeof(string));
            dt.Columns.Add("Profit_Per", typeof(string));
            dt.Columns.Add("Bill_No", typeof(string));
            dt.Columns.Add("Bill_Date", typeof(string));
            dt.Columns.Add("Bill_Amt", typeof(string));
            dt.Columns.Add("MR_No", typeof(string));
            dt.Columns.Add("MR_Date", typeof(string));
            dt.Columns.Add("MR_Amt", typeof(string));
            dt.Columns.Add("Recovery", typeof(string));
            dt.Columns.Add("Realised", typeof(string));
            dt.Columns.Add("Percent", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Doc_No"] = drRows["dockno"].ToString() + "" + drRows["docksf"].ToString();
                if (drRows["Dockdt"] is DBNull)
                {
                    dr["BkgDate"] = "-";
                }
                else
                {
                    dr["BkgDate"] = Convert.ToDateTime(drRows["Dockdt"]).ToString("dd MMM yyyy");
                }

                dr["Book_Loc"] = drRows["orgncd"].ToString();
                dr["Desti"] = drRows["destcd"].ToString();
                dr["Consignor"] = drRows["csgncd"].ToString() + " : " + drRows["csgnnm"].ToString();
                dr["Consignee"] = drRows["csgncd"].ToString() + " : " + drRows["csgnnm"].ToString();
                if (drRows["paybas"].ToString().Trim() == "P02")
                {
                    dr["Pay"] = "TBB";
                }
                else
                {
                    dr["Pay"] = "Paid";
                }
                dr["Doc_Sub"] = drRows["freight"].ToString();
                dr["STax"] = drRows["svctax"].ToString();
                dr["Cess"] = drRows["cess"].ToString();
                dr["Doc_Tot"] = drRows["dkttot"].ToString();
                dr["Thc_No"] = drRows["thcno"].ToString();
                if (drRows["thcdt"] is DBNull)
                {
                    dr["Thc_Date"] = "-";
                }
                else
                {
                    dr["Thc_Date"] = Convert.ToDateTime(drRows["thcdt"]).ToString("dd MMM yyyy");
                }
                dr["Thc_Amt"] = drRows["thcamt"].ToString();
                dr["Profit"] = Convert.ToDouble(drRows["fin_profit"]).ToString("0.00");

                dr["Profit_Per"] =Convert.ToDouble(drRows["Profit_PERc"]).ToString("0.00");

                dr["Bill_No"] = drRows["billno"].ToString();
                if (drRows["bgndt"] is DBNull)
                {
                    dr["Bill_Date"] = "-";
                }
                else
                {
                    dr["Bill_Date"] = Convert.ToDateTime(drRows["bgndt"]).ToString("dd MMM yyyy");
                }
                dr["Bill_Amt"] = drRows["billamt"].ToString();
                dr["MR_No"] = drRows["mrsno"].ToString();
                if (drRows["mrsdt"] is DBNull)
                {
                    dr["MR_Date"] = "-";
                }
                else
                {
                    dr["MR_Date"] = Convert.ToDateTime(drRows["mrsdt"]).ToString("dd MMM yyyy");
                }
                dr["MR_Amt"] = drRows["mrsamt"].ToString();
                dr["Recovery"] = drRows["Recovr_days"].ToString();
                dr["Realised"] = drRows["Realis_profit"].ToString();
                dr["Percent"] =Convert.ToDouble(drRows["fin_profit"]).ToString("0.00");

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();
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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("FTL_Summary.csv"), false);

        //DataTable dt = ds.Tables[0];
        //int iColCount = dt.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(ds.Tables[0].Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);

        //foreach (DataRow dr in dt.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();

        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("FTL_Summary.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "FTL_Summary.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=FTL_Profit.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        FTL_Profit.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
