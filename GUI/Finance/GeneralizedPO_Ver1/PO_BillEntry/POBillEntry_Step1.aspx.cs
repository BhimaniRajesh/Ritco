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
using Microsoft.ApplicationBlocks.Data;

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
            BindDropDown();
            fn.Fill_Vendor_Dataset();
        }
        con.Close();

        Button3.Attributes.Add("onclick", "javascript:return Submit()");
    }
    public void BindDropDown()
    {
        string SQLStr = "";
        SQLStr = "SELECT '' AS CodeID, '--SELECT--' AS CodeDesc UNION SELECT CodeID,CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' order by CodeDesc";
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        DDLMatCat.DataSource = dt;
        DDLMatCat.DataTextField = "CodeDesc";
        DDLMatCat.DataValueField = "CodeID";
        DDLMatCat.DataBind();
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
            if ((rb2.Items[0].Selected))
            {
                report_mode = "Date";
            }
            if ((rb2.Items[1].Selected))
            {
                report_mode = "Week";
            }
            if ((rb2.Items[2].Selected))
            {
                report_mode = "Today";
            }

            string strrightnow, strrightnow1;
            System.DateTime righnow = System.DateTime.Today;
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
            if (report_mode == "Date")
            {
                strrightnow = txtDateFrom.Text.ToString();
                strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
            }
            else if (report_mode == "Week")
            {
                strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            else if (report_mode == "Today")
            {
                strrightnow = righnow.ToString("dd/MM/yyyy");
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            else if (report_mode == "Tilldate")
            {
                strrightnow = "01/04/1990";
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            if (strrightnow == "")
            {
                strrightnow = righnow.ToString("dd/MM/yyyy");
            }

            if (strrightnow1 == "")
            {
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }

            string[] strArrDtFrom = strrightnow.Split('/');
            string[] strArrDtTo = strrightnow1.Split('/');

            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string VendorName = "", Vendorcode = "";
            string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');

            if (Txt_Vendor.Text.ToString() != "")
            {
                VendorName = Vendor_Cls_Arr[0];
                Vendorcode = Vendor_Cls_Arr[1];
            }

            string strFinalQS = "?Fromdt=" + dtFrom;
            strFinalQS = strFinalQS + "&Todate=" + dtTo;
            strFinalQS = strFinalQS + "&Vendorcode=" + Vendorcode;
            strFinalQS = strFinalQS + "&VendorName=" + VendorName;
            strFinalQS = strFinalQS + "&POno=" + txtpono.Text;
            strFinalQS = strFinalQS + "&ManualPOno=" + txtmanualpono.Text;
            strFinalQS = strFinalQS + "&MatCat=" + DDLMatCat.SelectedValue.ToString();

            Response.Redirect("POBillEntry_Step2.aspx" + strFinalQS);


        }


    }
}
