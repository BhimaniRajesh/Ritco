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
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_EmployeeMaster_ChangePassword : System.Web.UI.Page
{
    string connStr = "";
    string userName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        lblWelcome.Text = System.Configuration.ConfigurationManager.AppSettings["WelcomeNote"];
       
        connStr = SessionUtilities.ConnectionString;
        if (Request.QueryString["UID"] != null)
            userName = Request.QueryString["UID"].ToString();
        ucChangePass.UserID = userName;
        ucChangePass.DisplayMessage = "Your password is expired please change password to login...";

        #region OldCode commented By Harshad
        //cvLastPass.Enabled = false;
        //lblMsg.Visible = false;
        //lblMsg.ForeColor = System.Drawing.Color.Black;
        //if (!IsPostBack)
        //    initData();
        #endregion
    }

    #region OldCode commented By Harshad
    //private void initData()
    //{
    //    try
    //    {
    //        string cmd = "Select * from webx_master_users where userid='" + userName + "'";
    //        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
    //        if (ds.Tables.Count > 0)
    //        {
    //            DataRow dr = ds.Tables[0].Rows[0];
    //            PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.REMEMBER_LAST_PASSWORD);
    //            if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
    //            {
    //                cvLastPass.Enabled = true;
    //                string pass = dr["LastPwd"].ToString();
    //                if (dr["IsPassEncrypted"].ToString().ToUpper() == "Y")
    //                    pass = SSTCryptographer.Decrypt(pass, ConfigurationManager.AppSettings["PasswordSult"]);

    //                cvLastPass.ValueToCompare = pass;
    //            }

    //            pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.ENABLE_PASSWORD_COPLEXCITY);
    //            if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
    //            {
    //                pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.COMPLEXITY_EXPRESSION);
    //                revNewPass.ValidationExpression = pp.SetValue;
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = ex.Message;
    //        lblMsg.Visible = true;
    //        lblMsg.ForeColor = System.Drawing.Color.Red;
    //    }        
    //}
    //protected void btpUpdate_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string cmd = "Select * from webx_master_users where userid='" + userName + "'";
    //        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
    //        if (ds.Tables.Count > 0)
    //        {
    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                DataRow dr = ds.Tables[0].Rows[0];
    //                string crrpass = dr["UserPwd"].ToString();
    //                cmd = "Update webx_master_users Set userpwd='{0}',lastpwd='{1}',pwdlastchangeon=getdate() where userid='{2}'";
    //                if (dr["IsPassEncrypted"].ToString().ToUpper() == "Y")
    //                    crrpass = SSTCryptographer.Decrypt(crrpass, ConfigurationManager.AppSettings["PasswordSult"]);
    //                if (crrpass == txtOldPass.Text.Trim())
    //                {
    //                    string newPass = txtNewPass.Text.Trim();
    //                    PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.USE_ENCRYPTED_PASSWORD);
    //                    if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
    //                    {
    //                        newPass = SSTCryptographer.Encrypt(newPass, ConfigurationManager.AppSettings["PasswordSult"]);
    //                        crrpass = SSTCryptographer.Encrypt(crrpass, ConfigurationManager.AppSettings["PasswordSult"]);
    //                    }
    //                    cmd = string.Format(cmd, newPass, crrpass, userName);
    //                    SqlHelper.ExecuteNonQuery(connStr, CommandType.Text, cmd);
    //                    Response.Redirect("~/GUI/default.aspx");
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = ex.Message;
    //        lblMsg.Visible = true;
    //        lblMsg.ForeColor = System.Drawing.Color.Red;
    //    }
    //}
    #endregion
}
