using System;
using System.Web.UI;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Reports_JobOrderTrackerReport_JobOrderTracker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            string SQLString = "select Job_Order_No from WEBX_FLEET_PM_JOBORDER_HDR where Job_Order_No='" + txtJONumber.Text + "'";
            DataTable dtJobOrder = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLString).Tables[0];
            if (dtJobOrder.Rows.Count > 0)
            {
                string final;
                final = "?JONO=" + txtJONumber.Text.ToString();

                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<");
                sb.Append("script language='JavaScript'>");

                sb.Append("function NoConfirm()");
                sb.Append("{");
                sb.Append("win = top;");
                sb.Append("win.opener = top;");
                sb.Append("win.close ();");
                sb.Append("}");

                sb.Append("window.open('./JobOrderTrackerView.aspx" + final + "', '_blank',");

                sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");

                sb.Append("<");
                sb.Append("/script>");

                if (!this.IsStartupScriptRegistered("PopupWindow"))
                {
                    //Register the script
                    this.RegisterStartupScript("PopupWindow", sb.ToString());
                }

            }
            else
            {
                txtJONumber.Text = "";
                string textForMessage = @"<script language='JavaScript'> alert('In Valid JobSheet Number');</script>";
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "UserPopup", textForMessage);
            }
        }
        catch (Exception)
        {

            //throw;
        }

    }
}