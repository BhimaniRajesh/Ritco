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

public partial class GUI_issue_serverPage : System.Web.UI.Page
{
    
    DataTable DT = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        string ManualCode = Request.QueryString["ManualCode"].ToString() + "";
        string SystemCode = Request.QueryString["SystemCode"].ToString() + "";
        if (ManualCode != "")
        {
            DataAccess DAccess = new DataAccess();
            DT = DAccess.gettable("select count(*) as numcode from WebX_Groups where Company_Groupcode= '" + ManualCode + "'");
            string num1 = DT.Rows[0]["numcode"].ToString();
            string num2 = "0";
            if (SystemCode != "System Generated")
            {
                DT = DAccess.gettable("select count(*) as numcode from WebX_Groups where Groupcode= '" + SystemCode + "'");
                num2 = DT.Rows[0]["numcode"].ToString();
            }
            if (SystemCode == "System Generated")
            {
                DT = DAccess.gettable("select count(*) as numcode from WebX_Groups where Groupcode= '" + ManualCode + "'");
                num2 = DT.Rows[0]["numcode"].ToString();
            }
            Response.Write(num1 + "," + num2);
        }
    }
}
