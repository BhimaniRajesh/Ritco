using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Collections.Generic;
using System.Drawing;

public partial class GUI_admin_FuelSlipMaster_MIS_FuelBillVendor : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";

    decimal TotalAmt = 0, TotalLtr = 0;
    int TotalSlip = 0;

    string FillingDate, VendorName, VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    string Quantity, Rate, Amount;
    string Prod;
    bool success = false;
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        
        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
           // btnSubmitBills.Visible = false;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
            sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT  Vendorcode,vendorname FROM webx_VENDOR_HDR WHERE Vendor_Type='12' ORDER BY Vendorcode ASC";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            ddVendorName.Items.Clear();

            while (dr.Read())
            {
                ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["Vendorcode"].ToString()));
            }
            dr.Close();
            conn.Close();


        }
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        if (txtDateFrom.Text == "")
        {
            value.IsValid = false;
            return;
        }
        if (txtDateTo.Text == "")
        {
            value.IsValid = false;
            return;
        }
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);

        if (dt1 > dt2)
        {
            CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
            value.IsValid = false;
            return; 
        }
    }

    protected void ShowBillDetails(object sender, EventArgs e)
    {

        //tblDCR.Visible = true;
        string VendorCode = ddVendorName.SelectedValue.ToString();
        string BillStatus = ddlStatus.SelectedItem.ToString();

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        var StartTime = TimeSpan.Parse("00:00:00");
        var EndTime = TimeSpan.Parse("23:59:59");
        var StartDate = d1 + StartTime;
        var EndDate = d2 + EndTime;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_MISFuelBill_GetDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        cmd.Parameters.AddWithValue("@BillStatus", BillStatus); 

        SqlDataReader dr = cmd.ExecuteReader();
        if (ddlStatus.SelectedValue == "Paid")
        {
            gvPending.Visible = false;
            gvPaid.Visible = true;
            gvPaid.DataSource = dr;
            gvPaid.DataBind();
        }
        else {
            gvPaid.Visible = false;
            gvPending.Visible = true;
            gvPending.DataSource = dr;
            gvPending.DataBind();
        }
       
    }

    /*
   protected void btnEdit_Click(object sender, EventArgs e)
   {
       GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
       int index = gvRow.RowIndex;
       Button btnEdit = (Button)gvPending.Rows[index].FindControl("btnEdit");
       Prod = gvPending.Rows[index].Cells[8].Text;
       UserSlipNo = gvPending.Rows[index].Cells[9].Text;
       SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       con.Open();
       SqlTransaction trn;
       trn = con.BeginTransaction();
       string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

       try
       {
           string sql = "UPDATE webx_fuel_issue_slip SET IsFillingDate='N', Sentfor_Fillingdt='" + EntryDate + "' WHERE UserSlipNo='" + UserSlipNo + "' AND FuelType ='" + Prod + "'  AND FillingDate IS NULL";
           SqlCommand cmdTC = new SqlCommand(sql, con, trn);
           cmdTC.ExecuteNonQuery();
           trn.Commit();
           con.Close();
           //ShowVendorDetails(sender, e);

       }
       catch (Exception e1)
       {
           trn.Rollback();
       }
   }

   protected void btnSubmitBills_Click(object sender, EventArgs e)
   {
       string VCode = ddVendorName.SelectedValue.ToString();


       for (int i = 0; i < gvPending.Rows.Count; i++)
       {
           CheckBox chkbxCheck = (CheckBox)gvPending.Rows[i].FindControl("chkbxCheck");

           if (chkbxCheck.Checked == true)
           {


               FillingDate = gvPending.Rows[i].Cells[2].Text;
               VendorName = gvPending.Rows[i].Cells[3].Text;
               VehicleNo = gvPending.Rows[i].Cells[4].Text;
               TripsheetNo = gvPending.Rows[i].Cells[5].Text;
               TripsheetOpen_Dt = gvPending.Rows[i].Cells[6].Text;
               VendorCity = gvPending.Rows[i].Cells[7].Text;
               Product = gvPending.Rows[i].Cells[8].Text;
               UserSlipNo = gvPending.Rows[i].Cells[9].Text;
               UserSlip_Dt = gvPending.Rows[i].Cells[10].Text;
               Quantity = gvPending.Rows[i].Cells[11].Text;
               Rate = gvPending.Rows[i].Cells[12].Text;
               Amount = gvPending.Rows[i].Cells[13].Text;

               TotalAmt = TotalAmt + decimal.Parse(Amount);
               TotalLtr = TotalLtr + decimal.Parse(Quantity);
               TotalSlip = TotalSlip + 1;

               SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
               con.Open();
               SqlTransaction tran;
               tran = con.BeginTransaction();
               string EntryBy = Session["empcd"].ToString();
               string UpdateBy = Session["empcd"].ToString();
               string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

               try
               {
                   SqlCommand cmd = new SqlCommand("usp_FuelBills_Insert", con, tran);
                   cmd.CommandType = CommandType.StoredProcedure;

                   cmd.Parameters.Add("@FillingDate", SqlDbType.VarChar).Value = FillingDate;
                   cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VCode;
                   cmd.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = VendorName;
                   cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehicleNo;
                   cmd.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = TripsheetNo;
                   cmd.Parameters.Add("@TripsheetOpen_Dt", SqlDbType.DateTime).Value = TripsheetOpen_Dt;
                   cmd.Parameters.Add("@VendorCity", SqlDbType.VarChar).Value = VendorCity;
                   cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = Product;
                   cmd.Parameters.Add("@UserSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
                   cmd.Parameters.Add("@UserSlip_Dt", SqlDbType.DateTime).Value = UserSlip_Dt;
                   cmd.Parameters.Add("@Quantity", SqlDbType.VarChar).Value = Quantity;
                   cmd.Parameters.Add("@Rate", SqlDbType.VarChar).Value = Rate;
                   cmd.Parameters.Add("@Amount", SqlDbType.VarChar).Value = Amount;
                   cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                   cmd.Parameters.Add("@Entry_Dt", SqlDbType.DateTime).Value = EntryDate;
                   //cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text;
                   cmd.Parameters.Add("@BillDate", SqlDbType.DateTime).Value = EntryDate;
                   cmd.ExecuteNonQuery();


                   //string sql = "UPDATE webx_fuel_issue_slip SET IsBilled='Y',  BillNo= '" + txtBillNo.Text + " ' ,  BillingDt= '" + EntryDate + " '   WHERE UserSlipNo='" + UserSlipNo + "' ";
                   //SqlCommand cmdTC = new SqlCommand(sql, con, tran);
                   //cmdTC.ExecuteNonQuery();



                   SqlCommand cmd1 = new SqlCommand("usp_FuelBills_Hdr_Insert", con, tran);
                   cmd1.CommandType = CommandType.StoredProcedure;
                   //cmd1.Parameters.Add("@Bill_No", SqlDbType.VarChar).Value = txtBillNo.Text;
                   cmd1.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VCode;
                   cmd1.Parameters.Add("@TotalAmount", SqlDbType.VarChar).Value = TotalAmt;
                   cmd1.Parameters.Add("@TotalLtr", SqlDbType.VarChar).Value = TotalLtr;
                   cmd1.Parameters.Add("@TotalSlips", SqlDbType.VarChar).Value = TotalSlip;
                   cmd1.Parameters.Add("@BillDate", SqlDbType.VarChar).Value = EntryDate;
                   cmd1.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                   cmd1.Parameters.Add("@Entry_Dt", SqlDbType.VarChar).Value = EntryDate;
                   cmd1.ExecuteNonQuery();

                   tran.Commit();
                   success = true;

               }
               catch (Exception e1)
               {
                   tran.Rollback();
               }
               finally
               {
                   con.Close();
               }
           }
           else
           {
               i++;
           }


       }

       if (success == true)
       {
           //Response.Redirect("PendingFuelView.aspx?QBillNo=" + txtBillNo.Text);
       }
   }


    private DataTable GetData(SqlCommand cmd)
    {
        DataTable dt = new DataTable();
        String strConnString = System.Configuration.ConfigurationManager.
             ConnectionStrings["conString"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnString);
        SqlDataAdapter sda = new SqlDataAdapter();
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            sda.Dispose();
            con.Dispose();
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
      
    }
    protected void lbStockNumber_Click(object sender, EventArgs e)
    {
    //    string BillNo = "Bill003";
        //Response.Redirect("Download.aspx?+BillNo");
        //Response.Redirect("WebForm2.aspx?BillNo=123");
        Response.Redirect("Download.aspx?BillNo");
        //SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //con.Open();
        //SqlCommand cmd = new SqlCommand("USP_GET_IMS_FuelBillVendor", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@BillNo", BillNo);

        //setBorderWidth();
        //DownloadXLS();
        //SqlDataReader dr = cmd.ExecuteReader();
        //grddownload.DataSource = dr;
        //grddownload.DataBind();




        //Response.Clear();  
        //Response.Buffer = true;  
        //Response.ClearContent();  
        //Response.ClearHeaders();  
        //Response.Charset = "";  
        //string FileName ="Vithal"+DateTime.Now+".xls";  
        //StringWriter strwritter = new StringWriter();  
        //HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);        
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);  
        //Response.ContentType ="application/vnd.ms-excel";    
        //Response.AddHeader("Content-Disposition","attachment;filename=" + FileName);  
        //grddownload.GridLines = GridLines.Both;  
        //grddownload.HeaderStyle.Font.Bold = true;  
        //grddownload.RenderControl(htmltextwrtter);  
        //Response.Write(strwritter.ToString());  
        //Response.End(); 
        
    }
    private void setBorderWidth()
    {
        //lblHeader.BorderWidth = 1;
        //tblmain.BorderWidth = 1;
        //grddownload.BorderWidth = 1;
    }
    private void DownloadXLS()
    {
        try
        {
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=ABC.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            //frm.Controls.Add(tblmain);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }*/
}

