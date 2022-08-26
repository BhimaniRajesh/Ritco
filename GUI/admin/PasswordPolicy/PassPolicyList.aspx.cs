using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_PasswordPolicy_PassPolicyList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindGrid();
    }

    private void BindGrid()
    {
        List<PasswordPolicy> listPP = PasswordPolicyController.GetAll();
        gvResult.DataSource = listPP;
        gvResult.DataBind();
    }

    protected void gvResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PasswordPolicy pp = e.Row.DataItem as PasswordPolicy;
            
            TextBox txtSetValue = e.Row.FindControl("txtSetValue") as TextBox;
            CheckBox chkActive = e.Row.FindControl("chkActive") as CheckBox;

            txtSetValue.Text = pp.SetValue;
            chkActive.Checked = (pp.Active == "Y") ? true : false;
        }
    }
}
