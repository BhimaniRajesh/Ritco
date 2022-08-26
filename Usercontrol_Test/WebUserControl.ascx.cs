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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class Usercontrol_WebUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        txtindclamt.Attributes.Add("onblur", "javascript:fcaltotchqamt1(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
        txtchqdt.Attributes.Add("onblur", "javascript:OnBlurChqDetail(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + "," + Hnd_party.ClientID + ")");
       // txtchqdt.Attributes.Add("onblur", "javascript:fcaltotchqamt1(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + ")");
        txtbanknm.Attributes.Add("onblur", "javascript:fcaltotchqamt1(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
        txtbankbrn.Attributes.Add("onblur", "javascript:fcaltotchqamt1(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
        cbopaytype.Attributes.Add("onblur", "javascript:Javascript:ChequeText_validation(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
       
        
        if (!IsPostBack)
        {

            SqlDataReader drtds;

            string sql = "select acccode,accdesc,acccategory,acccode+'~'+accdesc as accval from webx_acctinfo where acccode='CLA0014' order by accdesc";
            SqlCommand cmd = new SqlCommand(sql, conn);
            drtds = cmd.ExecuteReader();

            tdsacccode.Items.Clear();
            while (drtds.Read())
            {
                tdsacccode.Items.Add(new ListItem("Select",""));
                tdsacccode.Items.Add(new ListItem(drtds.GetValue(1).ToString(), drtds.GetValue(3).ToString()));

            }

            drtds.Close();
        }
    }
}
