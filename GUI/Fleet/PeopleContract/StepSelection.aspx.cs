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
using WebX.Controllers;
using WebX.Entity;
using WebX.Controllers;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CustomerContractMaster_StepSelection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdncustcode.Value = Request.QueryString["Customer_Code"].ToString();
            cstheader.CustCode = hdncustcode.Value;
            if (Request.QueryString["Contract_Code"] != null)
            {
                hdncontractid.Value = Request.QueryString["Contract_Code"].ToString();
                cstheader.ContractID = hdncontractid.Value;
            }
            else
            {
                hdncontractid.Value = "New";
                cstheader.ContractID = "System Generated";
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (optintro.Checked == true)
        {
            Server.Transfer("CCMStep1.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Code=" + hdncontractid.Value + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString().Trim());
        }
        else if (optservices.Checked == true)
        {
            Server.Transfer("PMContractEntry.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Code=" + hdncontractid.Value + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString().Trim());
        }
    }

}
