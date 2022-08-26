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
using System.Globalization;

public partial class GUI_UNI_MIS_Bill_Summary_Bill_Sum_Cust_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DateTime RptDate = new DateTime();
    DataView dv;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    string Number, sql, i;
    Array str, str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!(IsPostBack))
        {
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");
            lblRo.Text = Request.QueryString["Ro"];
            lblLoc.Text = Request.QueryString["Loc"];
            lblSub.Text = Request.QueryString["SubLoc"];
            lblCollLoc.Text = Request.QueryString["ColLoc"];
            lblCustCode.Text = Request.QueryString["Cust"];
            lblBillType.Text = Request.QueryString["BillType"];
            lblBillAmt.Text = Request.QueryString["BillAmt"];
            lblList.Text = Request.QueryString["CustWise"];
            RptDate = Convert.ToDateTime(Request.QueryString["RptDate"]);
            lblRptDate.Text = RptDate.ToString("dd MMM yy");

            BindGrid();
        }
    }

    private void BindGrid()
    {
        //string FromDate, ToDate;
        //FromDate = lblDtFrom.Text;
        //ToDate = lblDtTo.Text;

        //str = FromDate.Split('/');
        //str1 = ToDate.Split('/');

        //string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        //string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name

        //string FDate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        //string TDate = TmonthName + " " + ((string[])(str1))[1] + " " + ((string[])(str1))[2];


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = "select c.PTMSCD,c.PTMSNM, sum(case when (BGNDT is not null)then 1 else 0 end)as BIllgenerated,sum(case when (BGNDT is not null)then BillAMT else 0 end) as BIllgenerated_amt,sum(case when (billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106))then 1 else 0 end) as Billsubmited,sum(case when (billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106))then BillAMT else 0 end) as Billsubmited_amt,sum(case when (billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106))then 1 else 0 end) as Billsubmited_notdue,sum(case when (billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106))then BillAMT else 0 end) as Billsubmited_notdue_amt,sum(case when (BSBDT is NULL and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106))then 1 else 0 end) as Billunsubmited,sum(case when (BSBDT is NULL and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106))then BillAMT else 0 end) as Billunsubmited_amt,sum(case when (BSBDT is NULL and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106))then 1 else 0 end) as Billunsubmited_notdue,sum(case when (BSBDT is NULL and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106))then BillAMT else 0 end) as Billunsubmited_notdue_amt,sum(case when (BCLDT is not null)then 1 else 0 end) as Collected,sum(case when (BCLDT is not null)then BillAMT else 0 end) as Collected_amt from webx_billmst c with(NOLOCK) inner join webx_location a on a.loccode=c.BBRCD where Convert(varchar,c.BGNDT,106) between Convert(datetime,'" + lblDtFrom.Text + "',106) and Convert(datetime,'" + lblDtTo.Text + "',106) and BillAMT > '" + lblBillAmt.Text + "'";

        if (lblCustCode.Text != "ALL")
        {
            sql = sql + " and  c.PTMSCD='" + lblCustCode.Text + "'";
        }
        if (lblSub.Text != "ALL")
        {
            sql = sql + "and  c.BILLSUBBRCD='" + lblSub.Text + "'";
        }
        if (lblCollLoc.Text != "ALL")
        {
            sql = sql + " and c.BILLcolBRCD='" + lblCollLoc.Text + "'";
        }
        if (lblLoc.Text != "All" && lblRo.Text != "All")
        {
            sql = sql + " and c.BBRCD='" + lblLoc.Text + "'";
        }
        if (lblLoc.Text == "All" && lblRo.Text != "All")
        {
            sql = sql + "and ( a.report_loc='" + lblRo.Text + "' or c.BBRCD ='" + lblRo.Text + "')";
        }

        sql = sql + "group by c.PTMSCD,c.PTMSNM order by c.PTMSCD,c.PTMSNM";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        ds = new DataSet();
        dsPages = new DataSet();

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;

            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        try
        {
            sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "Summary");
            sqlDA.Fill(dsPages);
        }
        catch (Exception e1)
        {
            lblRo.Text = e1.Message;
        }

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;

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
            ListItem lItem;

            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("loccode", typeof(string));
            dt.Columns.Add("Bill_No", typeof(string));
            dt.Columns.Add("Bill_Amt", typeof(string));
            dt.Columns.Add("Sub_No", typeof(string));
            dt.Columns.Add("Sub_Amt", typeof(string));
            dt.Columns.Add("Sub_Due_No", typeof(string));
            dt.Columns.Add("Sub_Due_Amt", typeof(string));
            dt.Columns.Add("UnSub_No", typeof(string));
            dt.Columns.Add("UnSub_Amt", typeof(string));
            dt.Columns.Add("UnSub_Due_No", typeof(string));
            dt.Columns.Add("UnSub_Due_Amt", typeof(string));
            dt.Columns.Add("Coll_No", typeof(string));
            dt.Columns.Add("Coll_Amt", typeof(string));
            dt.Columns.Add("loccodeforURL", typeof(string));
            dt.Columns.Add("LabelVisible", typeof(bool));
            dt.Columns.Add("LinkVisible", typeof(bool));
            dt.Columns.Add("LabelVisible1", typeof(bool));
            dt.Columns.Add("LinkVisible1", typeof(bool));
            dt.Columns.Add("LabelVisible2", typeof(bool));
            dt.Columns.Add("LinkVisible2", typeof(bool));
            dt.Columns.Add("LabelVisible3", typeof(bool));
            dt.Columns.Add("LinkVisible3", typeof(bool));
            dt.Columns.Add("LabelVisible4", typeof(bool));
            dt.Columns.Add("LinkVisible4", typeof(bool));
            dt.Columns.Add("LabelVisible5", typeof(bool));
            dt.Columns.Add("LinkVisible5", typeof(bool));
            
            DataRow dr;

            TimeSpan ts;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["loccode"] = drRows["ptmscd"].ToString() + " : " + drRows["PTMSNM"].ToString();
                dr["loccodeforURL"] = drRows["ptmscd"].ToString();
                dr["Bill_No"] = drRows["Billgenerated"].ToString();
                dr["LabelVisible"] = (Convert.ToInt32(drRows["Billgenerated"].ToString()) == 0 ? true : false);
                dr["LinkVisible"] = (Convert.ToInt32(drRows["Billgenerated"].ToString()) == 0 ? false : true);
                dr["Bill_Amt"] = drRows["Billgenerated_amt"].ToString();
                dr["Sub_No"] = drRows["Billsubmited"].ToString();
                dr["LabelVisible1"] = (Convert.ToInt32(drRows["Billsubmited"].ToString()) == 0 ? true : false);
                dr["LinkVisible1"] = (Convert.ToInt32(drRows["Billsubmited"].ToString()) == 0 ? false : true);
                dr["Sub_Amt"] = drRows["Billsubmited_amt"].ToString();
                dr["Sub_Due_No"] = drRows["Billsubmited_notdue"].ToString();
                dr["LabelVisible2"] = (Convert.ToInt32(drRows["Billsubmited_notdue"].ToString()) == 0 ? true : false);
                dr["LinkVisible2"] = (Convert.ToInt32(drRows["Billsubmited_notdue"].ToString()) == 0 ? false : true);
                dr["Sub_Due_Amt"] = drRows["Billsubmited_notdue_amt"].ToString();
                dr["UnSub_No"] = drRows["Billunsubmited"].ToString();
                dr["LabelVisible3"] = (Convert.ToInt32(drRows["Billunsubmited"].ToString()) == 0 ? true : false);
                dr["LinkVisible3"] = (Convert.ToInt32(drRows["Billunsubmited"].ToString()) == 0 ? false : true);
                dr["UnSub_Amt"] = drRows["Billunsubmited_amt"].ToString();
                dr["UnSub_Due_No"] = drRows["Billunsubmited_notdue"].ToString();
                dr["LabelVisible4"] = (Convert.ToInt32(drRows["Billunsubmited_notdue"].ToString()) == 0 ? true : false);
                dr["LinkVisible4"] = (Convert.ToInt32(drRows["Billunsubmited_notdue"].ToString()) == 0 ? false : true);
                dr["UnSub_Due_Amt"] = drRows["Billunsubmited_notdue_amt"].ToString();
                dr["Coll_No"] = drRows["Collected"].ToString();
                dr["LabelVisible5"] = (Convert.ToInt32(drRows["Collected"].ToString()) == 0 ? true : false);
                dr["LinkVisible5"] = (Convert.ToInt32(drRows["Collected"].ToString()) == 0 ? false : true);
                dr["Coll_Amt"] = drRows["Collected_amt"].ToString();

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
    }
    protected void btnXLS_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Bill_Summary.csv"), false);

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

        //// Now write all the rows.
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
        //fs = System.IO.File.Open(Server.MapPath("Bill_Summary.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Bill_Summary.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Bill_Summary.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Bill_Summary.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
