using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using Microsoft.ApplicationBlocks.Data;


public partial class UserControls_WebUserControl : System.Web.UI.UserControl
{
    private string sAccCode;
    private string sAccDesc;
    //Catches the OnPreRender event of the page lifecycle
    public string connStr;  //System.Configuration.ConfigurationManager.AppSettings["dbWebxConnection"];


    public UserControls_WebUserControl()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
  
        //if (AccCode == null)
        //    AccCode = "";

        //if (AccDesc == null)
        //    AccDesc = "";
    }
    protected override void OnPreRender(EventArgs e)
    {
        //If the developer specifies the username in the public property,
        //use that one. Otherwise, we could get the username from 
        //another source (i.e. A cookie on the client or a context 
        //object attached to the user).
        //if (AccCode == null)
        //    AccCode = "";

        //if (AccDesc == null)
        //    AccDesc = "";

        //if (sAccCode != "")
        //{
        //    txtAcccode.Text = sAccCode;
        //}
        //else
        //{
        //    txtAcccode.Text = "";
        //    Logic to get the username goes here.
        //}
        //if (sAccDesc != null)
        //{
        //    txtAccdesc.Text = sAccDesc;
        //}
        //else
        //{
        //    txtAccdesc.Text = "";
        //    Logic to get the username goes here.
        //}
    }
    public string AccCode
    {

        get { return sAccCode; }
        set { sAccCode = value; }
    }

    public string AccDesc
    {
        get { return sAccDesc;}
        set { sAccDesc = value;}
    }
    //public string getAccount()
    //{
    //    return (txtAcccode.Text);
    //}
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
       // {
        string validacctcodes = getValidAcct();
        string strjs= " javascript:this.value=this.value.toUpperCase();" +
                      " var validAcctcodes='"+ validacctcodes + "';" +
                      " if ((this.value!='')&&(validAcctcodes.indexOf(this.value)<=0)){ " +
                      "  alert('Please enter valid Account Code!!!');" + 
                      "  this.focus();return;}";
        connStr = Session["SqlProvider"].ToString().Trim();
        txtAcccode.Attributes.Add("onBlur", strjs);
        cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=1&ctrCodeName=" + txtAcccode.ClientID + "&ctrDescName=" + txtAccdesc.ClientID + "',null,'height=285, width=450,status= no, resizable= yes, scrollbars=yes, toolbar=no,location=no,menubar=no ');");
       // }
    }

    protected void getAccountDesc(object sender, EventArgs e)
    {
        AccCode = txtAcccode.Text;
        if (AccCode != "")
        {
            string sql = "Select Accdesc from webx_AcctInfo where Company_Acccode='" + AccCode + "'";
            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            AccDesc = "";
            if (rdr.Read())
            {
                AccDesc = rdr[0].ToString().ToUpper() +"";
            }
            rdr.Close();
        }
        txtAcccode.Text = AccCode;
        txtAccdesc.Text = AccDesc;
    }
    public string getAccCode()
    {
        return (txtAcccode.Text);
    }
    public string getAccDesc()
    {
        return (txtAccdesc.Text);
    }
    public string getValidAcct()
    {
        SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_Acct_codes");
        string acctcodes = "";
        while (rdr.Read())
        {
            if (acctcodes == "")
                acctcodes = rdr[0].ToString();
            else
                acctcodes = acctcodes + "," + rdr[0].ToString();

        }
        rdr.Close();
        return (acctcodes);
    }
   

}
