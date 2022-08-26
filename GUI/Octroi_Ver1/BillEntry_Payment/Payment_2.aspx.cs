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


public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{
    string Fromdt = "", Todate = "";
    string  Vendorcode = "", AcctHead = "", VBillno = "", Billno="";
    protected void Page_Load(object sender, EventArgs e)
    {
            Fromdt = Request.QueryString["Fromdt"].ToString();
            Todate = Request.QueryString["Todate"].ToString();
            Vendorcode = Request.QueryString["Vendorcode"].ToString();
            Billno = Request.QueryString["Billno"].ToString();
            VBillno = Request.QueryString["VBillno"].ToString();

            if (VBillno != "")
                Lbl_VBillno.Text = VBillno.ToString();
            if (Billno != "")
                Lbl_Billno.Text = Billno.ToString();
            if (Vendorcode != "")
                Lbl_Vendor.Text = Vendorcode.ToString();
            if (Fromdt != "" && Todate != "")
                Lbl_Date.Text = Fromdt.ToString() + "-" + Todate.ToString();

            if (!IsPostBack)
            {
                DipsplayReport();
            }
    }
    public void DipsplayReport()
    {
        Octroi.BillEntryBindGrid(GV_BillList, Fromdt, Todate, Vendorcode, Billno, VBillno);
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string Docnos = "";
        foreach (GridViewRow gridrow in GV_BillList.Rows)
        {
            CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
            Label LblBillno = (Label)gridrow.FindControl("LblBillno");
            if (Chk_Docno.Checked)
            {
                if (Docnos == "")
                    Docnos = LblBillno.Text.ToString().Trim();
                else
                    Docnos = Docnos + "," + LblBillno.Text.ToString().Trim();
            }
        }
        string VBillno1 = "";
        string strFinalQS = "?Vendorcode=" + Vendorcode;
        strFinalQS = strFinalQS + "&Todate=" + Todate;
        strFinalQS = strFinalQS + "&Fromdt=" + Fromdt;
        strFinalQS = strFinalQS + "&Billno=" + Docnos;
        strFinalQS = strFinalQS + "&VBillno=" + VBillno1;

        Response.Redirect("Payment_3.aspx" + strFinalQS);

    }
}
