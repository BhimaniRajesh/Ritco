using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcAuditCriteria : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Type = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
         //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //Session["SqlProvider"] = "Data Source=13.76.131.1;Initial Catalog=Ritco_Test;UID=anupam;pwd=anupam@123;Connect Timeout=120;Connection Lifetime=40;Max Pool Size=80000";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        Type = Request.QueryString.Get("type");
        if (!IsPostBack)
        {
            fn.Fill_Customer_Dataset();
        }
        Button1.Attributes.Add("onclick", "javascript:return OnSubmit_Submission()");
    }
    protected void Button1_Click(object sender, EventArgs e)
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
            strrightnow1 = txtDateTo.Text.ToString();
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
        string tripsheetNo;
        tripsheetNo = txtTripsheetNo.Text.ToString();
        //string party_detail = Txt_Customer.Text.ToString(), custcd = "", custnm = "";
        string custcd = "";
        //string[] party_arr;
        //if (Txt_Customer.Text != "")
        //{
        //    party_arr = party_detail.Split('~');
        //    custcd = party_arr[1].ToString();
        //    custnm = party_arr[0].ToString();
        //}
        string Final_str = "TripsheetNo=" + tripsheetNo.ToString();
        Final_str = Final_str + "&party_code=" + custcd.ToString();
        Final_str = Final_str + "&fromtdate=" + dtFrom.ToString();
        Final_str = Final_str + "&todate=" + dtTo.ToString();
        Response.Redirect("ExternalThcCriteriaDetails.aspx?" + Final_str);
    }
}