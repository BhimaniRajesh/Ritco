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

public partial class SFM_callreg_inter : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    SqlCommand cmd = new SqlCommand();
    string ProspectCode;
    public string callvisit;
    protected void Page_Load(object sender, EventArgs e)
    {
        //ProspectCode = Request.QueryString.Get("ProspectCode");
        //txtProspectId.Text = ProspectCode; 
        if (!IsPostBack)
        {
            string client = Session["Client"].ToString();
            if (client == "Varuna" || client == "VARUNA")
            {
                callvisit = "Visit";
            }
            else
            {
                callvisit = "Call";
            }
            string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtCustCode').value=elemValue;        
        }
        </script>";

            Page.RegisterClientScriptBlock("update1", scr1);
            btnCust.Attributes.Add("onclick", "window.open('./CallEntry_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ProspectCode = txtCustCode.Text.Trim();
        //Response.Write("ProspectCode -" + ProspectCode);
        //Response.End();
        //string prodid_desc = txtCustCode.Text.Trim();

        //string[] prospectCode_arr = prodid_desc.Split(new Char[] { ':' });
        //ProspectCode = Convert.ToString(prospectCode_arr[0]);
        Response.Redirect("CallReg_Step1.aspx?ProspectCode=" + ProspectCode );
    }
}
