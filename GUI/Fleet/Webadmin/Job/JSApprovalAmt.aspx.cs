using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class GUI_Fleet_Webadmin_Job_JSApprovalAmt : System.Web.UI.Page
{
    string str_Connection_String;
    JobSheet objJs;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SqlProvider"] != null)
        {
            str_Connection_String = Convert.ToString(Session["SqlProvider"]);
            objJs = new JobSheet(str_Connection_String);
        }
        if (!IsPostBack)
        {
            objJs.BindLocationHierarchy(ddlLocationHierarchy);
            BindGridData();
        }
    }
    public void BindGridData()
    {
        objJs = new JobSheet(str_Connection_String);
        objJs.BindGVApprovedAmt(gvApprovedAmt);
    }
    public void Clear()
    {
        ddlJobsheetType.SelectedIndex = 0;
        ddlLocationHierarchy.SelectedIndex = 0;
        txtApprovedAmt.Text = "";
        hfID.Value = "";
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
        lbl_Error.Text = "";
        BindGridData();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        objJs = new JobSheet(str_Connection_String);
        bool IsCommited = false;

        objJs.JS_TYPE = ddlJobsheetType.SelectedValue;
        objJs.LOC_HRCHY_CODE = ddlLocationHierarchy.SelectedValue;
        objJs.LOC_APPROVE_AMT = txtApprovedAmt.Text.ToString().Trim();
        objJs.Entry_By = Convert.ToString(SessionUtilities.CurrentEmployeeID);
        if (hfID.Value == "")
        {
            objJs.BeginTransaction();
            try
            {
                objJs.Insert_JS_Approval_Amt();
                IsCommited = objJs.CommitTransaction();
            }
            catch (Exception ex)
            {
                objJs.RollBackTransaction();
                lbl_Error.Text = ex.Message.ToString();
            }
        }
        else
        {
            objJs.BeginTransaction();
            try                
            {
                objJs.ID = hfID.Value; 
                objJs.Update_JS_Approval_Amt();
                IsCommited = objJs.CommitTransaction();
            }
            catch (Exception ex)
            {
                objJs.RollBackTransaction();
                lbl_Error.Text = ex.Message.ToString();
            }
        }
        if (IsCommited)
        {
            lbl_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Error.Text = "Update Record.";
            BindGridData();
        }
    }
}
