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

public partial class BillRegister_ShowBillDetails : System.Web.UI.Page
{
    public static string strDateRange;
    public static string strBillingParty;
    public static string strBillType;
    public static string strBilledAt;
    public static string strSubmittedAt;
    public static string strCollectedAt;
    public static string strStatus;
    public static string strOverDueDays;
    public static string strAmtGrThan;
    public static string strBillNo;


    public static int intPageSize = 10;
    DataSet dsPages = new DataSet();
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DateTime RDate = new DateTime();

    //static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE;";
    static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");

    public static int intCurrentPageNo;
    static string LocCode,Code;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }

        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);
        
        if (!IsPostBack)
        {
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");
            lblRo.Text = Request.QueryString["Ro"];
            lblLoc.Text = Request.QueryString["Loc"];
            lblSub.Text = Request.QueryString["Sub"];
            lblCollLoc.Text = Request.QueryString["CollLoc"];
            lblCustCode.Text = Request.QueryString["CustCode"];
            lblBillType.Text = Request.QueryString["BillType"];
            lblBillAmt.Text = Request.QueryString["BillAmt"];
            lblList.Text = Request.QueryString["List"];
            RDate =Convert.ToDateTime(Request.QueryString["RDate"]);
            lblRptDate.Text = RDate.ToString("dd MMM yyyy");
            lblBillStatus.Text = Request.QueryString["BillTyped"];
            LocCode = Request.QueryString["LocCode"];
            Code = Request.QueryString["Code"];
        }
        displayBillDetails();
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

        displayBillDetails();
    }

    private void displayBillDetails()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "";
        if (Code == "ALL")
        {
            sql = "select * from webx_billmst where PTMSCD='" + LocCode + "' and Convert(varchar,BGNDT,106) between Convert(datetime,'" + lblDtFrom.Text + "',106) and Convert(datetime,'" + lblDtTo.Text + "',106) and Billamt > '" + lblBillAmt.Text + "'";

            if (lblBillStatus.Text == "BIllgenerated")
            {
                sql = sql + "and  BGNDT is not null";
            }
            if (lblBillStatus.Text == "Billsubmited")
            {
                sql = sql + "and  billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billsubmited_Not_Due")
            {
                sql = sql + "and billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billunsubmited")
            {
                sql = sql + "and BSBDT is NULL and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billunsubmited_Not_Due")
            {
                sql = sql + "and  BSBDT is  null and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Collected")
            {
                sql = sql + "and  BCLDT  is not null";
            }
        }
        else
        {
            sql = "select * from webx_billmst where bbrcd='" + Code + "' and Convert(varchar,BGNDT,106) between Convert(datetime,'" + lblDtFrom.Text + "',106) and Convert(datetime,'" + lblDtTo.Text + "',106) and Billamt > '" + lblBillAmt.Text + "'";

            if (lblBillStatus.Text == "BIllgenerated")
            {
                sql = sql + "and  BGNDT is not null";
            }
            if (lblBillStatus.Text == "Billsubmited")
            {
                sql = sql + "and  billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billsubmited_Not_Due")
            {
                sql = sql + "and billstatus='Bill Submitted' and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billunsubmited")
            {
                sql = sql + "and BSBDT is NULL and Convert(varchar,BDUEDT,106) >= Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Billunsubmited_Not_Due")
            {
                sql = sql + "and  BSBDT is  null and Convert(varchar,BDUEDT,106) < Convert(datetime,'" + lblDtTo.Text + "',106)";
            }
            if (lblBillStatus.Text == "Collected")
            {
                sql = sql + "and  BCLDT  is not null";
            }
        }
    

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        //DataSet dsPages = new DataSet();

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
        
        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtBillDetails");
        dsPages.Clear();
        sqlDA.Fill(dsPages);

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;
            btnXML.Visible = false;
            
            tblPageNavigation.Visible = false;            
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

            //Logic for populating Page No.'s in Drop Down List for Page
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
            dt.Columns.Add("aHrefLink", typeof(string));
            dt.Columns.Add("BillNo", typeof(string));
            dt.Columns.Add("BillBrnach", typeof(string));
            dt.Columns.Add("PartyName", typeof(string));
            dt.Columns.Add("BillType", typeof(string));
            dt.Columns.Add("BillAmount", typeof(string));
            dt.Columns.Add("Gen_Date", typeof(string));
            dt.Columns.Add("Sub_Date", typeof(string));
            dt.Columns.Add("DueDate", typeof(string));
            dt.Columns.Add("Coll_Date", typeof(string));
            dt.Columns.Add("Sub_Loc", typeof(string));
            dt.Columns.Add("Coll_Loc", typeof(string));
            dt.Columns.Add("NavURL", typeof(string));

            DataRow dr;

            string strHrefLink = "";
            string BLCDT = "";
            string strOSDAYSDesc = "";

            TimeSpan ts;

            int intOSDAYS1 = 0;
            int intBillType = 0;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            //Total variables declaration

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;
                //Logic for Link on Bill No. column
                intBillType = Convert.ToInt32(drRows["PAYBAS"]);

                dr["NavURL"] = "javascript:OpenPopup('" + drRows["BILLNO"].ToString() + "')";
                dr["BillNo"] = drRows["BILLNO"].ToString();
                dr["BillBrnach"] = drRows["BBRCD"];
                dr["PartyName"] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();
                if (drRows["PAYBAS"].ToString().Trim() == "2")
                {
                    dr["BillType"] = "TBB";
                }                
                dr["BillAmount"] = drRows["BILLAMT"].ToString();
                if (drRows["BGNDT"] is DBNull)
                {
                    dr["Gen_Date"] = "-";
                }
                else
                {
                    dr["Gen_Date"] = Convert.ToDateTime(drRows["BGNDT"]).ToString("dd MMM yyyy");
                }
                if (drRows["BSBDT"] is DBNull)
                {
                    dr["Sub_Date"] = "-";
                }
                else
                {
                    dr["Sub_Date"] = Convert.ToDateTime(drRows["BSBDT"]).ToString("dd MMM yyyy");
                }
                if (drRows["BDUEDT"] is DBNull)
                {
                    dr["DueDate"] = "-";
                }
                else
                {
                    dr["DueDate"] = Convert.ToDateTime(drRows["BDUEDT"]).ToString("dd MMM yyyy");
                }
                if (drRows["BCLDT"] is DBNull)
                {
                    dr["Coll_Date"] = "-";
                }
                else
                {
                    dr["Coll_Date"] = Convert.ToDateTime(drRows["BCLDT"]).ToString("dd MMM yyyy");
                }
                dr["Sub_Loc"] = drRows["BILLSUBBRCD"].ToString();
                dr["Coll_Loc"] = drRows["BILLCOLBRCD"].ToString();

                

                dt.Rows.Add(dr);
            }

            rptBillDetails.DataSource = dt;
            rptBillDetails.DataBind();            
        }
    }

    private string GetBillType(int intBillTypeValue)
    {
        string strBillType = "";
        switch (intBillTypeValue)
        {
            case 1:
                strBillType = "Paid";
                break;
            case 2:
                strBillType = "TBB";
                break;
            case 3:
                strBillType = "To Pay";
                break;
            case 4:
                strBillType = "Misc.";
                break;
            case 5:
                strBillType = "Cancelled";
                break;
            case 6:
                strBillType = "Octroi";
                break;
            case 7:
                strBillType = "Supplimentry";
                break;
            case 8:
                strBillType = "Trial TBB";
                break;
        }

        return strBillType;
    }
    
    
    protected void btnXML_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Bill_Summary.csv"), false);

        //DataTable dt = dsPages.Tables[0];
        //int iColCount = dt.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(dsPages.Tables[0].Columns[i]);
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
        Response.AddHeader("Content-Disposition", "attachment;Filename=Bill_Sumarry.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Bill_Sumarry.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
