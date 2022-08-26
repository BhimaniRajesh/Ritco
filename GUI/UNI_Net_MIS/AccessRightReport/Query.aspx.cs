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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_UNI_Net_MIS_AccessRightReport_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 23/5/2014
        txtUsers.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
        BindCheckBox();
    }
    private void BindCheckBox()
    {
        string strQ = "SELECT UserID, Name FROM dbo.Webx_Master_Users WHERE Status='100' ORDER BY UserID";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        chklstUsers.DataSource = ds;
        chklstUsers.DataValueField = "UserID";
        chklstUsers.DataTextField = "UserID";
        chklstUsers.DataBind();
    }
    protected void btnView_OnClick(object sender, EventArgs e)
    {
        string _page = "";
        if (redFor.SelectedValue == "1")
            _page = "Menu_Result.aspx";
        if (redFor.SelectedValue == "2")
            _page = "Report_Result.aspx";
        _page = _page + "?Users=" + txtUsers.Text;
        _page = _page + "&hdnRptId=" + hdnRptId.Value.ToString();
        Response.Redirect(_page);
		
		System.Text.StringBuilder sb = new System.Text.StringBuilder();
          sb.Append("<");
         sb.Append("script language='javascript'>");
         //sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
		 sb.Append("window.open('./" + _page + "', '_blank',");
         sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
         sb.Append("<");
         sb.Append("/script>");

         if (!this.IsStartupScriptRegistered("PopupWindow"))
         {
          // //Register the script
           this.RegisterStartupScript("PopupWindow", sb.ToString());
         }
		
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

    }
}
