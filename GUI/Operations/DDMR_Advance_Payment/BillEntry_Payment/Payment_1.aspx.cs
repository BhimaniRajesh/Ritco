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

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
    SqlConnection con;
    public static string straccd, p;
    DataTable dt = new DataTable("table1");
    public DataTable dt_san = new DataTable();
    MyFunctions fn = new MyFunctions();
    
    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sql_display_pbov = "";
        if (!IsPostBack)
        {
            fn.Fill_Vendor_Dataset();
        }
        con.Close();

        Button3.Attributes.Add("onclick", "javascript:return Submit()");
    }
     
     
    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
            RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
            string report_mode = "";
            RadioButtonList rb2 = new RadioButtonList();
            rb2 = (RadioButtonList)radDate;
            string dtFrom = VendorPayment_Utility.Get_From_To_Date("F", txtDateFrom.Text, txtDateTo.Text, rb2);
            string dtTo = VendorPayment_Utility.Get_From_To_Date("T", txtDateFrom.Text, txtDateTo.Text, rb2);
            string VendorName = "", Vendorcode = "", Vehicle_Type_Name, Vechicl_Type_Code = "";
            if (Txt_Vendor.Text.ToString() != "")
            {
                string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');
                VendorName = Vendor_Cls_Arr[0];
                Vendorcode = Vendor_Cls_Arr[1];
            }
            string strFinalQS = "?Fromdt=" + dtFrom;
            strFinalQS = strFinalQS + "&Todate=" + dtTo;
            strFinalQS = strFinalQS + "&Vendorcode=" + Vendorcode;
            strFinalQS = strFinalQS + "&Billno=" + Txt_Billno.Text.ToString();
            strFinalQS = strFinalQS + "&VBillno=" + Txt_V_Billno.Text.ToString();
            strFinalQS = strFinalQS + "&Betype=" + ddlBetype.SelectedValue.ToString();
            Response.Redirect("Payment_2.aspx" + strFinalQS);
        }
    }
}
