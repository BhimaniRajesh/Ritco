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

public partial class GUI_UNI_MIS_chequemgt_result : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataSet ds1 = new DataSet();
    private double runningTotal = 0;
    private double runningTotal1 = 0;
    private double runningTotal2 = 0;
    SqlDataReader dtr;  
    DateFunction Daccess = new DateFunction();
    public static string location;
  
    protected void Page_Load(object sender, EventArgs e)
    {


       //   GUI/UNI_MIS/chequemgt/Issuecheque_viewstep1.aspx

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string CV, strFromDate, strToDate, strLocation, strVendorType, strVendorCode, amountFrom, amountTo, strChequeNumber,location;
        strFromDate = "";
        strToDate = "";
        string CHQ_NO = Request.QueryString["CHQ_NO"].ToString().Trim();
        CV = Request.QueryString["CV"].ToString();
        amountFrom = Request.QueryString["amountFrom"].ToString();
        amountTo = Request.QueryString["amountTo"].ToString();
        strChequeNumber = Request.QueryString["ChequeNumber"].ToString();
        location = Session["brcd"].ToString();
        //location = Request.QueryString["LocCode"].ToString();
        if (!IsPostBack)
        {
            myGrid.Visible = false;
            DataGrid1.Visible = false;
            location = Session["brcd"].ToString();
        }
        DataTable DT = new DataTable();
        if (CHQ_NO != "")
        {
            
                myGrid.Visible = false;
                location = Session["brcd"].ToString();
                DataGrid2.Visible = true;
               
                string str = "select distinct a.voucherNo,a.transtype,d.CHQNO AS CHQNO,CHQDT,convert(varchar,CHQDT,106) as CHQDTT,CHQAMT, ";
                str += "convert(varchar,a.transdate,106) as transdate,CHQINDEX,ADJUSTAMT,DEPOFLAG,PTMSPTCD,PTMSPTNM,empcd,(CHQAMT-ADJUSTAMT) as Unaccounted, ";
                str += "d.ENTRYDT,d.acccode,ISNULL((E.Company_Acccode + ' : ' + E.Accdesc), ' ') AS Issued_from, ";
                str += "l.LocName as Location from webx_location l, ";    
                str += " webx_CHQ_DET d, webx_acctinfo e,VW_acctrans a where D.acccode *= E.Acccode ";
                str += "and d.voucherNo = a.voucherNo and l.LocCode = a.brcd and d.CHQNO='" + CHQ_NO + "'";

                DataGrid2.DataSource = Daccess.getdataset(str);
                DataGrid2.DataBind();
                
             

        }
        else if (CV == "V")
        {

            table1.Style["display"] = "block";
            myGrid.Visible = true;
            Label1.Text = "Issue Date";

            Label2.Text = "Issue Location";
            Label3.Text = "Vendor Type";
            Label4.Text = "Vendor";

            strFromDate = Request.QueryString["DateFrom"].ToString();
            strToDate = Request.QueryString["DateTo"].ToString();
            strLocation = Request.QueryString["LocationCode"].ToString();

            string strLocName = "";
            string strLocCode = "";
            string HeadOffice = Session["HeadOfficeCode"].ToString();
            string BRCD = Session["brcd"].ToString();
            //if (HeadOffice == BRCD)
            //{
                if (strLocation != "All")
                {
                    dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + strLocation + "'");
                    while (dtr.Read())
                    {
                        strLocName = dtr["LocName"].ToString();
                        strLocCode = dtr["LocCode"].ToString();
                    }
                    dtr.Close();
                    strLocation = strLocCode;
                }
                else
                {
                    strLocName = "All";
                    strLocation = "All";
                }

            //}
            //else
            //{
            //    if (strLocation != "All")
            //    {
            //        dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + strLocation + "'");
            //        while (dtr.Read())
            //        {
            //            strLocName = dtr["LocName"].ToString();
            //            strLocCode = dtr["LocCode"].ToString();
            //        }
            //        dtr.Close();
            //        strLocation = strLocCode;
            //    }
            //    else
            //    {
            //        dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + BRCD + "'");
            //        while (dtr.Read())
            //        {
            //            strLocName = dtr["LocName"].ToString();
            //            strLocCode = dtr["LocCode"].ToString();
            //        }
            //        dtr.Close();
            //        strLocation = strLocCode;
            //    }
            //}

            string strType_Name = "";
            strVendorType = Request.QueryString["VendorType"].ToString();
            if (strVendorType != "All")
            {
                conn.Open();
                dtr = Daccess.getreader("select Type_Code,Type_Name from webx_Vendor_Type where Type_Code='" + strVendorType + "'");
                while (dtr.Read())
                {
                    strType_Name = dtr["Type_Name"].ToString();
                }
                dtr.Close();
                conn.Close();
            }
            else
            {
                strType_Name = "All";
            }


            string strVendor_Name = "";
            strVendorCode = Request.QueryString["VendorCode"].ToString();
            if (strVendorCode != "All")
            {
                conn.Open();
                dtr = Daccess.getreader("select vendorCode, vendorname from webx_VENDOR_HDR where vendorCode='" + strVendorCode + "'");
                while (dtr.Read())
                {

                    strVendor_Name = dtr["vendorname"].ToString();
                }
                dtr.Close();
                conn.Close();
            }
            else
            {
                strVendor_Name = "All";
            }

            

            lblEntryDate.Text = strFromDate + " " + strToDate;
            lblParty.Text = strLocName;
            lblCS.Text = strType_Name;
            lblChqAmtStatus.Text = strVendor_Name;

            SqlCommand cmd = new SqlCommand("webx_CHQMGT_VIEWISSUECHQ_v2", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@VENDCD", SqlDbType.VarChar).Value = strVendorCode;
            cmd.Parameters.AddWithValue("@DATEFROM", SqlDbType.VarChar).Value = strFromDate;
            cmd.Parameters.AddWithValue("@DATETO", SqlDbType.VarChar).Value = strToDate;
            cmd.Parameters.AddWithValue("@CHQNO", SqlDbType.VarChar).Value = strChequeNumber;
            cmd.Parameters.AddWithValue("@COLBRCD", SqlDbType.VarChar).Value = strLocation;
            cmd.Parameters.AddWithValue("@VENDTYPE", SqlDbType.VarChar).Value = strVendorType;
            cmd.Parameters.AddWithValue("@AMUTFROM", SqlDbType.VarChar).Value = amountFrom;
            cmd.Parameters.AddWithValue("@AMUTTO", SqlDbType.VarChar).Value = amountTo;
            da.Fill(ds, "Load");
            foreach (DataRow dr in ds.Tables["Load"].Rows)
            {
                string s = "";
                if (dr["PTMSPTcd"] is DBNull)
                {

                }
                else
                {
                    s = dr["PTMSPTcd"].ToString() + " : " + dr["PTMSPTNM"].ToString();
                }

                dr["PTMSPTNM"] = s;

            }
            myGrid.DataSource = ds;
            myGrid.DataBind();
        }
        else
        {
            DataGrid1.Visible = true;

            Label1.Text = "Entry Date";

            Label2.Text = "Party";
            Label3.Text = "Cheque Status";
            Label4.Text = "Cheque Amount Status";

            strFromDate = Request.QueryString["DateFrom"].ToString();
            strToDate = Request.QueryString["DateTo"].ToString();
            strLocation = Request.QueryString["LocationCode"].ToString();
            string strChequeStatus = Request.QueryString["ChequeStatus"].ToString();
            string strChqAmtStatus = Request.QueryString["ChqAmtStatus"].ToString();

            string strLocName = "";
            string strLocCode = "";
            string HeadOffice = Session["HeadOfficeCode"].ToString();
            string BRCD = Session["brcd"].ToString();
            if (HeadOffice == BRCD)
            {
                if (strLocation != "All")
                {
                    dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + strLocation + "'");
                    while (dtr.Read())
                    {
                        strLocName = dtr["LocName"].ToString();
                        strLocCode = dtr["LocCode"].ToString();
                    }
                    dtr.Close();
                    strLocation = strLocCode;
                }
                else
                {
                    strLocation = "All";
                }
            }
            else
            {
                if (strLocation != "All")
                {
                    dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + strLocation + "'");
                    while (dtr.Read())
                    {
                        strLocName = dtr["LocName"].ToString();
                        strLocCode = dtr["LocCode"].ToString();
                    }
                    dtr.Close();
                    strLocation = strLocCode;
                }
                else
                {
                    dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + BRCD + "'");
                    while (dtr.Read())
                    {
                        strLocName = dtr["LocName"].ToString();
                        strLocCode = dtr["LocCode"].ToString();
                    }
                    dtr.Close();
                    strLocation = strLocCode;
                }
            }
            //string strLocName = "";
            //if (strLocation != "All")
            //{
            //    conn.Open();
            //    dtr = Daccess.getreader("select LocCode, LocName from webx_location where LocCode='" + strLocation + "'");
            //    while (dtr.Read())
            //    {

            //        strLocName = dtr["LocName"].ToString();
            //    }
            //    dtr.Close();
            //    conn.Close();
            //}
            //else
            //{
            //    strLocName = "All";
            //}
            string strCustCode = "";
            string CustCode = Request.QueryString["CustCode"].ToString();
            if (CustCode == "")
            {
                CustCode = "All";
            }
            if (CustCode != "All")
            {
                conn.Open();
                dtr = Daccess.getreader("select vendorCode, vendorname from webx_VENDOR_HDR where vendorCode='" + CustCode + "'");
                while (dtr.Read())
                {

                    strCustCode = dtr["vendorname"].ToString();
                }
                dtr.Close();
                conn.Close();
            }
            else
            {
                strCustCode = "All";
            }
            string chk="";
            if (strChequeStatus == "All")
            {
                chk = "All";
            }
            else if (strChequeStatus == "B")
            {
                chk = "Bounced";
            }
            else if (strChequeStatus == "D")
            {
                chk = "Deposited";
            }
            else if (strChequeStatus == "ND")
            {
                chk = "Not-Deposited";
            }
            lblEntryDate.Text = strFromDate + " " + strToDate;
            lblParty.Text = strCustCode;
            lblCS.Text = chk;
            lblChqAmtStatus.Text = strChqAmtStatus;

            string searchType = Request.QueryString["searchType"].ToString();
            SqlCommand cmd1 = new SqlCommand("webx_CHQMGT_VIEWRECVDCHQ_v2_san", conn);
            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@CUSTCD", SqlDbType.VarChar).Value = CustCode;
            cmd1.Parameters.AddWithValue("@DATEFROM", SqlDbType.VarChar).Value = strFromDate;
            cmd1.Parameters.AddWithValue("@DATETO", SqlDbType.VarChar).Value = strToDate;
            cmd1.Parameters.AddWithValue("@CHQSTATUS", SqlDbType.VarChar).Value = strChequeStatus;
            cmd1.Parameters.AddWithValue("@CHQAMTSTATUS", SqlDbType.VarChar).Value = strChqAmtStatus;
            cmd1.Parameters.AddWithValue("@CHQNO", SqlDbType.VarChar).Value = strChequeNumber;
            cmd1.Parameters.AddWithValue("@COLBRCD", SqlDbType.VarChar).Value = strLocation;
            cmd1.Parameters.AddWithValue("@CHQDATE", SqlDbType.VarChar).Value = searchType;
            cmd1.Parameters.AddWithValue("@AMUTFROM", SqlDbType.VarChar).Value = amountFrom;
            cmd1.Parameters.AddWithValue("@AMUTTO", SqlDbType.VarChar).Value = amountTo;
            da1.Fill(ds1, "Load");
            foreach (DataRow dr in ds1.Tables["Load"].Rows)
            {
                string s = "";
                if (dr["PTMSPTcd"] is DBNull)
                {

                }
                else
                {
                    s = dr["PTMSPTcd"].ToString() + " : " + dr["PTMSPTNM"].ToString();
                }

                dr["PTMSPTNM"] = s;

            }
            DataGrid1.DataSource = ds1;
            DataGrid1.DataBind();
        }
    }

   
    private void CalcTotal(string _price)
    {
        try
        {
            runningTotal += Double.Parse(_price);
        }
        catch
        {
            //A value was null
        }
    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CalcTotal1(e.Item.Cells[3].Text);
            e.Item.Cells[3].Text = string.Format("{0:0.00}", Convert.ToDouble(e.Item.Cells[3].Text));

            CalcTotal2(e.Item.Cells[4].Text);
            e.Item.Cells[4].Text = string.Format("{0:0.00}", Convert.ToDouble(e.Item.Cells[4].Text));

            CalcTotal3(e.Item.Cells[5].Text);
            e.Item.Cells[5].Text = string.Format("{0:0.00}", Convert.ToDouble(e.Item.Cells[5].Text));
        }
        else if (e.Item.ItemType == ListItemType.Footer)
        {
            e.Item.Cells[2].Text = "Total";
            e.Item.Cells[3].Text = string.Format("{0:0.00}", runningTotal);
            e.Item.Cells[4].Text = string.Format("{0:0.00}", runningTotal1);
            e.Item.Cells[5].Text = string.Format("{0:0.00}", runningTotal2);
        } 
    }
    private void CalcTotal1(string _price)
    {
        try
        {
            runningTotal += Double.Parse(_price);
        }
        catch
        {
            //A value was null
        }
    }
    private void CalcTotal2(string _price)
    {
        try
        {
            runningTotal1 += Double.Parse(_price);
        }
        catch
        {
            //A value was null
        }
    }
    private void CalcTotal3(string _price)
    {
        try
        {
            runningTotal2 += Double.Parse(_price);
        }
        catch
        {
            //A value was null
        }
    }
    
    protected void myGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
 if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CalcTotal(e.Item.Cells[3].Text);
            e.Item.Cells[3].Text = string.Format("{0:0.00}", Convert.ToDouble(e.Item.Cells[3].Text));
        }
        else if (e.Item.ItemType == ListItemType.Footer)
        {
            e.Item.Cells[2].Text = "Total";
            e.Item.Cells[3].Text = string.Format("{0:0.00}", runningTotal);
        }
    }
}
