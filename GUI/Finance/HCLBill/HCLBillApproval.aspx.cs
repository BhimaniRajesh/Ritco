using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillApproval : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();

        if (!IsPostBack)
        {
            try
            {
                var oHCLMasterController = new HCLMasterController();
                var ds = new DataSet();

                var dt = new DataTable();
                var FromDate = Convert.ToString(Request.QueryString["Fromdt"]);
                var ToDate = Convert.ToString(Request.QueryString["Todt"]);
                var BillNo = Convert.ToString(Request.QueryString["BillNo"]);
                var BranchCode = Convert.ToString(Request.QueryString["BranchCode"]);
                dt = oHCLMasterController.GetListForHCLBillApproval(FromDate, ToDate, BillNo,BranchCode);

                if (dt.Rows.Count > 0)
                {
                    RptBillApproval.DataSource = dt;
                    RptBillApproval.DataBind();
                }
                else
                {  
                   UserMessage.Show("No Records Found !");
                   //Response.Redirect("HCLBillApprovalCriteria.aspx",false);
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
        }
    }
   

    protected void btnNext_Click(object sender, EventArgs e)
    {
        string BillNo = "";
        string BranchCode= Convert.ToString(Request.QueryString["BranchCode"]);


        try
        { 
           foreach(RepeaterItem item in RptBillApproval.Items)
            {
                RadioButton rbd=(RadioButton)item.FindControl("RdHCLApproval");
                HiddenField hdnBillNumber = (HiddenField)item.FindControl("hdnBillNo");
                if(rbd.Checked==true)
                {
                    BillNo = hdnBillNumber.Value;
                    Response.Redirect("HCLBillApprovalStep3.aspx?BillNo=" + BillNo +"&BranchCode="+ BranchCode, false);
                }
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show(Ex.Message);
        }
    }
}