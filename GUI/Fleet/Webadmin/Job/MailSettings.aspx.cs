using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class GUI_Fleet_Webadmin_Job_MailSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFrom.Attributes.Add("OnBlur", "javascript:validateMultipleEmailsCommaSeparated(this," + lbl_Err_From.ClientID.ToString() + "," + hfFrom.ClientID.Trim() + ");");
            txtTo.Attributes.Add("OnBlur", "javascript:validateMultipleEmailsCommaSeparated(this," + lbl_Err_To.ClientID.ToString() + "," + hfTo.ClientID.ToString().Trim() + ");");
            txtSMTPServer.Attributes.Add("OnBlur", "javascript:CheckSMTP(this," + lbl_Err_SMTPSrv.ClientID.ToString() + ");");
            btnMailSave.Attributes.Add("onClick", "javascript:OnOk();");
            btnMailSave.OnClientClick = String.Format("fnClickUpdate('{0}','{1}')", btnMailSave.UniqueID, "");
            GetMailData();
        }
    }
    protected void btnMailSave_Click(object sender, EventArgs e)
    {
        UpdateMailData();
        GetMailData();
    }
    public void UpdateMailData()
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        try
        {
            objJs.SMTP_Server = txtSMTPServer.Text;
            objJs.From_Address = txtFrom.Text.ToString().Trim();
            objJs.From_To = txtTo.Text.ToString().Trim();
            objJs.Update_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            objJs.BeginTransaction();
            objJs.UpdateMailData();
            objJs.CommitTransaction();
            MsgBox.Show("Record is updated.");
        }
        catch(Exception ex)
        {
            objJs.RollBackTransaction();
            MsgBox.Show(ex.Message.ToString());
        }
    }
    public void GetMailData()
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        DataTable dt = new DataTable();
        dt = objJs.GetMailData();
        if (dt.Rows.Count > 0)
        {
            txtSMTPServer.Text = dt.Rows[0]["SMTP_Server"].ToString();
            txtFrom.Text = dt.Rows[0]["From_Address"].ToString();
            txtTo.Text = dt.Rows[0]["From_To"].ToString();
            hfSMTPSrv.Value = dt.Rows[0]["SMTP_Server"].ToString();
            hfFrom.Value = dt.Rows[0]["From_Address"].ToString();
            hfTo.Value = dt.Rows[0]["From_To"].ToString();
        }
    }
}
