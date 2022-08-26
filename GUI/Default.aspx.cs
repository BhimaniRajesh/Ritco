using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using WebX.Controllers;

public partial class _Default : System.Web.UI.Page
{
    //string mydbcon = System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
    private const string USE_ENCRYPTED_PASSWORD = "USE_ENCRYPTED_PASSWORD";
    private const string EXPIRE_AFTER = "EXPIRE_AFTER";

    bool IsPassEncrypted = false;
    int expireAfter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        lblWelcome.Text = System.Configuration.ConfigurationManager.AppSettings["WelcomeNote"];
        if (Session["SqlProvider"] == null)
        {
            Server.Transfer("~/GUI/TimeOut.aspx");
        }
        else
        {
            if (Session["empcd"] != null)
            {
                Server.Transfer("~/GUI/welcome.aspx");
            }
        }
		if (!IsPostBack)
        {
            Login1.Enabled = true;
        }
    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        //SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);

        PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.USE_ENCRYPTED_PASSWORD);
        if (pp.Active == "Y")
            IsPassEncrypted = (pp.SetValue == "Y") ? true : false;
        
        string psSult = ConfigurationManager.AppSettings["PasswordSult"].ToString();
        string pwd = Login1.Password.Trim();
        if(IsPassEncrypted)
            pwd = SSTCryptographer.Encrypt(pwd, psSult);
        //string pwd = Login1.Password.Trim();
        //string strCmd = "Select userid,[Name],BranchCode,BrachName=(select top 1 locname from webx_location where loccode=BranchCode) From WebX_Master_Users Where STATUS='100' and userid='" + Login1.UserName.Trim() + "' and userpwd='" + pwd + "'";
        
        //added by vidya on 18 Jul 2014
        ////string strCmd = "Select BrachName=(select top 1 locname from webx_location where loccode=BranchCode),* From WebX_Master_Users Where STATUS='100' and userid='" + Login1.UserName.Trim() + "'  and userpwd='" + pwd + "'";
        //DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strCmd).Tables[0];
        string strsql = @"Select BrachName=(select top 1 locname from webx_location where loccode=BranchCode),* From WebX_Master_Users Where STATUS='100' and userid=@USERID and userpwd=@PWD";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@USERID", Login1.UserName.Trim());
        param[1] = new SqlParameter("@PWD", pwd);
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql, param).Tables[0];

        
        try
        {            
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                Session["empcd"] = dr["userid"].ToString().Trim();
                Session["empnm"] = dr["Name"].ToString().Trim();
                Session["mainbrcd"] = dr["BranchCode"].ToString().Trim();
                Session["brcd"] = dr["BranchCode"].ToString().Trim();
                Session["brcdName"] = dr["BrachName"].ToString().Trim();
                Session["DefaultCompany"] = "C001";

                bool IsLogin = false;
                pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.EXPIRE_AFTER);
                if (pp.Active.ToUpper() == "Y")
                {
                    expireAfter = Convert.ToInt32(pp.SetValue);
                }
                if (expireAfter > 0)
                {
                    DateTime dtChangeOn = Convert.ToDateTime(dr["EntryDate"]);
                    if (dr["PwdLastChangeOn"] != DBNull.Value)
                        dtChangeOn = Convert.ToDateTime(dr["PwdLastChangeOn"]);
                    DateTime dtNow = DateTime.Now.Date;
                    DateTime expDt = dtChangeOn.Date.AddDays(expireAfter);

                    if (dtNow >= expDt)
                        Response.Redirect("~/GUI/Admin/EmployeeMaster/ChangePassword.aspx?UID=" + Login1.UserName.Trim());
                    else
                        IsLogin = true;
                }
                else
                    IsLogin = true;
                if (IsLogin)
                {                    
                    //Part 1 the same code as before
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("<");
                    sb.Append("script language='javascript'>");

                    sb.Append("function NoConfirm()");
                    sb.Append("{");
                    sb.Append("win = top;");
                    sb.Append("win.opener = top;");
                    sb.Append("win.close ();");
                    sb.Append("}");

                    if (Session["empcd"].ToString().Trim() == "sa")
                    {
                        sb.Append("window.open('./admin/sa.aspx', 'CustomPopUp',");
                    }
                    else
                    {
                        sb.Append("window.open('welcome.aspx', 'CustomPopUp',");
                    }
                    sb.Append("'top=0, left=0, width=700, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
                    sb.Append("NoConfirm();");
                    sb.Append("<");
                    sb.Append("/script>");

                    //Part 2 Registering The ClientScriptBlock
                    //Type t = this.GetType();

                    //if (!ClientScript.IsClientScriptBlockRegistered("PopupScript"))
                    //    ClientScript.RegisterClientScriptBlock("PopupScript", sb.ToString());

                    //Check whether they are already registered
                    if (!this.IsStartupScriptRegistered("PopupWindow"))
                    {
                        //Register the script
                        this.RegisterStartupScript("PopupWindow", sb.ToString());
                    }                   

                    string sql1 = "insert into webx_Login (EMPCD,SessionID,EMPNM,CURRBRCD,locname,LASTLOGINDT) values ('" + Session["empcd"].ToString() + "','" + Session.SessionID + "','" + Session["empnm"].ToString() + "','" + Session["brcd"] + "','" + Session["brcdName"] + "',getdate())";
                    SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, sql1);

                    Login1.FailureText = "You are successfully logged in...";                     
                    //Server.Transfer("welcome.aspx");

                    Login1.Enabled = false;
                }
            }
            else
            {
                Login1.FailureText = "Authentification Failed....";
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
        }
    }
               
}
