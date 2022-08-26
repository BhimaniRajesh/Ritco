using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApprovalStep1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        var FromDate = Convert.ToString(Request.QueryString["Fromdt"]);
        var ToDate = Convert.ToString(Request.QueryString["Todt"]);
        var Ethcno = Convert.ToString(Request.QueryString["Ethcno"]);
        var RO = Convert.ToString(Request.QueryString["RO"]);
        var LO = Convert.ToString(Request.QueryString["LO"]);

        if (!IsPostBack)
        {
            try
            {
                DataTable dt = new DataTable();
                using (var oWebXHelper = new WebXHelper())
                {
                    dt = oWebXHelper.ExecuteDataTable("WEBX_ETHCBILLCollection_ApprovalList", new[] {
                    new SqlParameter("@Fromdt", FromDate) ,
                    new SqlParameter("@Todt", ToDate),
                    new SqlParameter("@EthcNo",Ethcno),
                    new SqlParameter("@RO",RO),
                    new SqlParameter("@LO",LO)
                    });
                }
                RptApproval.DataSource = dt;
                RptApproval.DataBind();
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
            foreach (RepeaterItem item in RptApproval.Items)
            {
                RadioButton rbd=(RadioButton)item.FindControl("RdHCLApproval");
                HiddenField hdnMRNo = (HiddenField)item.FindControl("hdnMRNo");
                if (rbd.Checked==true)
                {
                    Response.Redirect("ETHCBillApproval.aspx?MRNo=" + hdnMRNo.Value, false);
                }
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show(Ex.Message);
        }
    }
}