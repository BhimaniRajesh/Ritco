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

public partial class Usercontrol_ChangePassword : System.Web.UI.UserControl
{
    #region Variable[s]  
    string userName = "";
    bool doRedirect = false, askforOldPass = true;
    string redirectURL = "";
    private string m_UserID = string.Empty, m_BtnText = string.Empty;
    #endregion

    #region Property
    public string UserID
    {
        get
        {
            return m_UserID;
        }
        set
        {
            m_UserID = value;
        }
    }
    public string BtnText
    {
        get
        {
            return m_BtnText;
        }
        set
        {
            m_BtnText = value;
        }
    }
    public bool DoRedirect
    {
        get
        {
            return doRedirect;
        }
        set
        {
            doRedirect = value;
        }
    }
    public string RedirectURL
    {
        get
        {
            return redirectURL;
        }
        set
        {
            redirectURL = value;
        }
    }
    public string DisplayMessage
    {
        get { return lblTitleMsg.Text; }
        set { lblTitleMsg.Text = value; }
    }
    public bool AskForOldPass
    {
        get { return askforOldPass; }
        set { askforOldPass = value; }
    }
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Visible = false;
            lblMsg.ForeColor = System.Drawing.Color.Black;          

            if (!string.IsNullOrEmpty(UserID))
                userName = UserID;

            if (!IsPostBack)
            {
                cvLastPass.Enabled = false;
                initData();
            }
            trOldPass.Visible = AskForOldPass;
            cvOldPass.Enabled = AskForOldPass;
            cvOldPassValue.Enabled = !AskForOldPass;
            //if (AskForOldPass)
            //{               
            //    cvOldPass.Enabled = true;
            //    cvOldPassValue.Enabled = false;
            //}   
            //else
            //{
            //    cvOldPass.Enabled = false;
            //    cvOldPassValue.Enabled = true;
            //}
        }
        catch (Exception Exc)
        {
            lblMsg.Text = Exc.Message;
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btpUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            EmployeeMasterController objEmployeeMaster = new EmployeeMasterController();
            
            DataTable dtEmployeeMaster = new DataTable();

            if (!string.IsNullOrEmpty(userName))
            {
                dtEmployeeMaster = objEmployeeMaster.getEmployeeByUserID(userName);               
            }

            if (dtEmployeeMaster != null && dtEmployeeMaster.Rows.Count > 0)
            {
                string crrpass = Convert.ToString(dtEmployeeMaster.Rows[0]["UserPwd"]);
                
                if (Convert.ToString(dtEmployeeMaster.Rows[0]["IsPassEncrypted"]).ToUpper() == "Y")
                    crrpass = SSTCryptographer.Decrypt(crrpass, ConfigurationManager.AppSettings["PasswordSult"]);

                bool doChg = true;
                if (trOldPass.Visible)
                {
                    if (crrpass.ToUpper() != txtOldPass.Text.Trim().ToUpper())
                        doChg = false;
                }
                if (doChg)
                {
                    string newPass = txtNewPass.Text.Trim();
                    PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.USE_ENCRYPTED_PASSWORD);
                    if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
                    {
                        newPass = SSTCryptographer.Encrypt(newPass, ConfigurationManager.AppSettings["PasswordSult"]);
                        crrpass = SSTCryptographer.Encrypt(crrpass, ConfigurationManager.AppSettings["PasswordSult"]);
                    }

                    objEmployeeMaster.updateEmployeePassword(newPass, crrpass, userName);

                    if (doRedirect)
                    {
                        tblMsg.Visible = true; 
                        lblMsg.Visible = true;                      
                        btnMain.Text = m_BtnText; 
                        tblMain.Visible = false;                        
                        lblMsg.Font.Bold = true;
                        lblMsg.Text = "Password has been changed.";
                    }                                
                }
            }           
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void btpMain_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(redirectURL.Trim()))
            {
                Response.Redirect(redirectURL);
            }            
        }
        catch (Exception Exc)
        {
            lblMsg.Text = Exc.Message;  
        }
    }
    #endregion

    #region Private Function[s]
    private void initData()
    {
        try
        {
            EmployeeMasterController objEmployeeMaster = new EmployeeMasterController();
            
            DataTable dtEmployeeMaster = new DataTable();

            if (!string.IsNullOrEmpty(userName))
            {
                dtEmployeeMaster = objEmployeeMaster.getEmployeeByUserID(userName);               
            }

            if (dtEmployeeMaster != null && dtEmployeeMaster.Rows.Count > 0)
            {
                PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.REMEMBER_LAST_PASSWORD);
                if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
                {
                    cvLastPass.Enabled = true;
                    string pass = Convert.ToString(dtEmployeeMaster.Rows[0]["LastPwd"]);
                    if (Convert.ToString(dtEmployeeMaster.Rows[0]["IsPassEncrypted"]).ToUpper() == "Y")
                        pass = SSTCryptographer.Decrypt(pass, ConfigurationManager.AppSettings["PasswordSult"]);
                    cvLastPass.ValueToCompare = pass;

                    string oldPass = Convert.ToString(dtEmployeeMaster.Rows[0]["UserPwd"]);
                    if (Convert.ToString(dtEmployeeMaster.Rows[0]["IsPassEncrypted"]).ToUpper() == "Y")
                        oldPass = SSTCryptographer.Decrypt(oldPass, ConfigurationManager.AppSettings["PasswordSult"]);
                    cvOldPassValue.ValueToCompare = oldPass;
                    pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.ENABLE_PASSWORD_COPLEXCITY);
                    if (pp.Active.ToUpper() == "Y" && pp.SetValue.ToUpper() == "Y")
                    {
                        pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.COMPLEXITY_EXPRESSION);
                        revNewPass.ValidationExpression = pp.SetValue;
                    }
                }
            }            
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    #endregion
}
