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
using ApplicationManager;

public partial class GUI_Fleet_Webadmin_Job_JSApprovalAmtMatrix : System.Web.UI.Page
{
    string str_Connection_String;
    JobSheet objJs;
    protected void Page_Load(object sender, EventArgs e)
    {     
        if (!IsPostBack)
        {
            Bindgrid();
        }
    }

    protected void Bindgrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand("Select * from VW_FLEET_JS_APPROVAL_AMT_MATRIX", conn);
        sqlcmd.CommandType = CommandType.Text;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvApprovedAmtMatrix.DataSource = ds;
        gvApprovedAmtMatrix.DataBind();
        conn.Close();
    }

    protected void gvApprovedAmtMatrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtApprove_UserId = (TextBox)e.Row.FindControl("txtApprove_UserId");
            TextBox txtCC_UserId = (TextBox)e.Row.FindControl("txtCC_UserId");
            Label lbl_JS_Error = (Label)e.Row.FindControl("lbl_JS_Error");
            Label lbl_JS_PageError = (Label)e.Row.FindControl("lbl_JS_PageError");
            Button btn_PopUp1 = (Button)e.Row.FindControl("btn_PopUp1");
            Button btn_PopUp2 = (Button)e.Row.FindControl("btn_PopUp2");

            if (txtApprove_UserId.Text == "Enter Multiple Users Separated By Comma")
            {
                txtApprove_UserId.Text = "";
            }

            if (txtCC_UserId.Text == "Enter Multiple Users Separated By Comma")
            {
                txtCC_UserId.Text = "";
            }

            txtApprove_UserId.Attributes.Add("OnBlur", "javascript:CheckApproveUserID(" + txtApprove_UserId.ClientID.ToString() + "," + lbl_JS_Error.ClientID.ToString() + ");");
            txtCC_UserId.Attributes.Add("OnBlur", "javascript:CheckCCUserID(" + txtCC_UserId.ClientID.ToString() + "," + lbl_JS_PageError.ClientID.ToString() + ");");
            btn_PopUp1.Attributes.Add("OnClick", "javascript:window.open('popup_MultiValueSelection.aspx?OpenerCtl=" + txtApprove_UserId.ClientID.Trim()  + "',null,'left=300, top=150, height=300, width=500, status=no, resizable=no, scrollbars=no, toolbar=no,location=no, menubar= no');return false;");
            btn_PopUp2.Attributes.Add("OnClick", "javascript:window.open('popup_MultiValueSelection.aspx?OpenerCtl=" + txtCC_UserId.ClientID.Trim() + "',null,'left=300, top=150, height=300, width=500, status=no, resizable=no, scrollbars=no, toolbar=no,location=no, menubar= no');return false;");
          
        }
    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false;
        bool IsCommited = false;
        //string strApproveUserID = "";
        //string strCCUserID = "";

        try
        {
            foreach (GridViewRow gridrow in gvApprovedAmtMatrix.Rows)
            {
                TextBox txtApprove_UserId = (TextBox)gridrow.FindControl("txtApprove_UserId");
                TextBox txtCC_UserId = (TextBox)gridrow.FindControl("txtCC_UserId");
                HiddenField hfApproved_Id = (HiddenField)gridrow.FindControl("hfApproved_Id");
                HiddenField hfId = (HiddenField)gridrow.FindControl("hfId");
                HiddenField hfJobID = (HiddenField)gridrow.FindControl("hfJobID");

                //DataTable dtApproveUserID = new DataTable();
                //DataTable dtCCUserID = new DataTable();

                objJs.Approved_Id = hfId.Value.ToString();
                objJs.Approver_UserId = txtApprove_UserId.Text.ToString();
                objJs.CC_UserId = txtCC_UserId.Text.ToString();
                objJs.JS_TYPE = gvApprovedAmtMatrix.Rows[gridrow.RowIndex].Cells[2].Text.ToString().Trim();
                objJs.LOC_APPROVE_AMT = gvApprovedAmtMatrix.Rows[gridrow.RowIndex].Cells[3].Text.ToString().Trim();
                objJs.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                //objJs.Updated_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();

                //strApproveUserID=txtApprove_UserId.Text.ToString();
                //strCCUserID = txtCC_UserId.Text.ToString();

                objJs.BeginTransaction();
                try
                {
                    if (lbl_Page_Error.Text == "")
                    {
                        if (hfJobID.Value == "")
                        {
                            objJs.Job_ID = "";
                            objJs.InsertJobApprovalMatrix();
                        }
                        else
                        {
                            objJs.Job_ID = hfJobID.Value;
                            objJs.UpdateJobApprovalMatrix();
                        }
                        IsCommitted = objJs.CommitTransaction();
                    }
                }
                catch (Exception ex)
                {
                    objJs.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
            
         }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted == true)
        {
            //lbl_button_Page.ForeColor = System.Drawing.Color.Green;
            lbl_button_Page.Text = "Record Updated";     
        }
    }

}
