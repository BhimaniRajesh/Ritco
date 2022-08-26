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

public partial class admin_TireSearch : System.Web.UI.Page
{

    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);

        //Common objCommon = new Common();
        //objCommon.doCacheRoutine();
        //this.Title = pagetitle;

        if (!IsPostBack)
        {


            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 21/5/2014
            //conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //Do Work
            DropDownStatus();
            DropDownVendorType();
            DropDownVendorName();
            BindReportViewer();
        }
        //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
        //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
        //img_CalendarAt.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFromA.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFromA.ClientID + @"\')')");
        //img_CalendarAf.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateToA.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateToA.ClientID + @"\')')");
    }
    public void DropDownStatus()
    {
        ddlStatus.Items.Clear();
        ddlStatus.Items.Add("");
        ddlStatus.Items.Add("");
        ddlStatus.Items.Add("");
        ddlStatus.Items.Add("");
        ddlStatus.Items[0].Text = "ALL";
        ddlStatus.Items[0].Value = "ALL";
        ddlStatus.Items[1].Text = "Paid";
        ddlStatus.Items[1].Value = "1";
        ddlStatus.Items[2].Text = "Balance";
        ddlStatus.Items[2].Value = "2";
        ddlStatus.Items[3].Text = "Cancelled";
        ddlStatus.Items[3].Value = "3";
    }
    public void DropDownVendorType()
    {
        //string strVendorType = "SELECT Type_Code,Type_Name FROM dbo.webx_Vendor_Type UNION SELECT 0,'ALL' FROM dbo.webx_Vendor_Type ORDER BY Type_Name ";
        string strVendorType = "SELECT CodeId,CodeDesc FROM dbo.webx_master_general where codetype= 'vendty' and statuscode = 'Y' UNION SELECT 'ALL','ALL' FROM dbo.webx_master_general ORDER BY CodeDesc  ";
        DataSet ds = new DataSet();
        SqlDataAdapter adp = new SqlDataAdapter(strVendorType, conn);
        adp.Fill(ds);
        ddlVendorType.DataSource = ds;
        ddlVendorType.DataTextField = "CodeDesc";
        ddlVendorType.DataValueField = "CodeId";
        ddlVendorType.DataBind();
    }
    public void DropDownVendorName()
    {
        string strVendorNm = "SELECT VENDORCODE,VENDORNAME FROM dbo.webx_VENDOR_HDR UNION SELECT '0','ALL' FROM dbo.webx_VENDOR_HDR ORDER BY VENDORCODE";
        DataSet ds = new DataSet();
        SqlDataAdapter adp = new SqlDataAdapter(strVendorNm, conn);
        adp.Fill(ds);
        ddlVendorName.DataSource = ds;
        ddlVendorName.DataTextField = "VENDORNAME";
        ddlVendorName.DataValueField = "VENDORCODE";
        ddlVendorName.DataBind();
    }
    //protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    //{
    //    //txtDateFrom.ReadOnly = false;
    //    //txtDateTo.ReadOnly = false;

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");

    //    RadioButtonList rbl = new RadioButtonList();
    //    rbl = (RadioButtonList)sender;
    //    if (!(rbl.Items[0].Selected))
    //    {
    //        txtDateFrom.Text = strrightnow;
    //        txtDateTo.Text = strrightnow;
    //        txtDateFrom.ReadOnly = true;
    //        txtDateTo.ReadOnly = true;
    //    }

    //    if (rbl.Items[1].Selected)
    //    {
    //        righnow = righnow.AddDays(-7);
    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom.Text = strrightnow;
    //    }

    //    if (rbl.Items[3].Selected)
    //    {
    //        //righnow = righnow.AddMonths(-12);
    //        strrightnow = "01/01/1950";
    //        txtDateFrom.Text = strrightnow;
    //    }

    //}
    public void BindReportViewer()
    {
        //ReportViewer1.Visible = true;


        //conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AgilityERP_TestConnectionString"].ConnectionString);
        //conn.Open();
        //SqlCommand sqlcmd = new SqlCommand("usp_Vendor_Bill_Register", conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //da.SelectCommand.Parameters.Add("@CreatedFrom", SqlDbType.VarChar).Value = txtDateFrom.Text;
        //da.SelectCommand.Parameters.Add("@CreatedTo", SqlDbType.VarChar).Value = txtDateTo.Text;
        //if (ddlStatus.SelectedItem.Text.ToString() == "ALL")
        //{
        //    da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = "";
        //}
        //else
        //{
        //    da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = ddlStatus.SelectedItem.Text.ToString();
        //}
        //if (ddlVendorType.SelectedItem.Text.ToString() == "ALL")
        //{
        //    da.SelectCommand.Parameters.Add("@VendorType", SqlDbType.VarChar).Value = "";
        //}
        //else
        //{
        //    da.SelectCommand.Parameters.Add("@VendorType", SqlDbType.VarChar).Value = ddlVendorType.SelectedItem.Text.ToString();
        //}
        //if (ddlVendorName.SelectedItem.Text.ToString() == "ALL")
        //{
        //    da.SelectCommand.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = "";
        //}
        //else
        //{
        //    da.SelectCommand.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = ddlVendorName.SelectedItem.Text.ToString();
        //}
        //sqlcmd.ExecuteReader();
        //conn.Close();

        //DataSet ds = new DataSet();
        //da.Fill(ds);
        //ReportDataSource rds = new ReportDataSource("MyFleetDataSet_VendorBillRegisterReport", ds.Tables[0]);
        //ReportViewer1.LocalReport.DataSources.Clear();
        //ReportViewer1.LocalReport.DataSources.Add(rds);
        //ReportViewer1.LocalReport.Refresh();
      
    }
    
    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    Cls_VendorBill.strCreatedFrom = txtDateFrom.Text;
    //    Cls_VendorBill.strCreatedTo = txtDateTo.Text;
    //    Cls_VendorBill.strStatus = ddlStatus.SelectedItem.Text.ToString();
    //    Cls_VendorBill.strVendorType = ddlVendorType.SelectedItem.Text.ToString();
    //    Cls_VendorBill.strVendorName = ddlVendorName.SelectedItem.Text.ToString();
    //    Cls_VendorBill.strCompany = company.SelectedValue.ToString().Trim();

    //    Response.Redirect("VendorBillRegisterResult.aspx?CreatedFrom=" + txtDateFrom.Text + "&CreatedTo=" + txtDateTo.Text + "&Status=" + ddlStatus.SelectedItem.Text.ToString() + "&VendorType=" + ddlVendorType.SelectedItem.Text.ToString() + "&VendorName=" + ddlVendorName.SelectedItem.Text.ToString() + "&Company_Code=" + company.SelectedValue.ToString() + "");

       // Response.Redirect("VendorBillRegisterResult.aspx?CreatedFrom=" + txtDateFrom.Text + "&CreatedTo=" + txtDateTo.Text + "&Status=" + ddlStatus.SelectedItem.Text.ToString() + "&VendorType=" + ddlVendorType.SelectedItem.Text.ToString() + "&VendorName=" + ddlVendorName.SelectedItem.Text.ToString()+"");
    //}
}
