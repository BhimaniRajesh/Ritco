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

public partial class GUI_admin_dcr_ChangeBusType : System.Web.UI.Page
{
    string docKey = "";
    string connString = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        connString = Session["SqlProvider"].ToString().Trim();
        if (Request.QueryString["ID"] != null)
            docKey = Request.QueryString["ID"].ToString();

        if (!IsPostBack && !IsCallback)
        {
            GetData();
        }
    }

    private void GetData()
    {
        string cmd = "Select * from webx_dcr_header Where doc_key='" + docKey + "'";
        DataTable dt = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd).Tables[0];

        hidDocKey.Value = docKey;
        lblBookCode.Text = dt.Rows[0]["BookCode"].ToString();
        lblDcrFrom.Text = dt.Rows[0]["doc_sr_from"].ToString();
        lblDcrTo.Text = dt.Rows[0]["doc_sr_to"].ToString();

        DataSet ds = SqlHelper.ExecuteDataset(connString, CommandType.Text, "SELECT CodeId, CodeDesc FROM webx_master_general WHERE CodeType='BUT'");
        ddlBusType.DataSource = ds;
        ddlBusType.DataTextField = "CodeDesc";
        ddlBusType.DataValueField = "CodeId";
        ddlBusType.DataBind();
        ddlBusType.SelectedValue = dt.Rows[0]["Business_Type_Id"].ToString(); ;
    }    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string cmd = "Update Webx_DCR_Header Set Business_Type_ID='{0}' Where Doc_Key='{1}'";
        cmd = string.Format(cmd, ddlBusType.SelectedValue, hidDocKey.Value);
        SqlHelper.ExecuteNonQuery(connString, CommandType.Text, cmd);
        Response.Redirect("dcr_ChangeBusType_List.aspx");
    }
}
