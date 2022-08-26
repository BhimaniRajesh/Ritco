using System;
using System.Data;

public partial class GUI_Finance_HCLBill_HCLBillPayement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {
            try
            {
                var oHCLMasterController = new HCLMasterController();
                var dt = new DataTable();
                var FromDate = Convert.ToString(Request.QueryString["Fromdt"]);
                var ToDate = Convert.ToString(Request.QueryString["Todt"]);
                var BillNo = Convert.ToString(Request.QueryString["BillNo"]);
                dt= oHCLMasterController.GetBillListForHCLBillPayment(FromDate, ToDate, BillNo);

                if (dt.Rows.Count > 0)
                {
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
                else
                {
                    UserMessage.Show("No Bills Found !");
                }

                dt= oHCLMasterController.GetBankList();
                if (dt.Rows.Count > 0)
                {
                    ddlBankName.DataSource=dt;
                    ddlBankName.DataTextField = "accdesc";
                    ddlBankName.DataValueField ="Acccode";
                    ddlBankName.DataBind();
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show("Error Messege : " + Ex.Message);
            }
        }
    }
}