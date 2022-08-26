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

public partial class SFM_ProspectReassign : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtCustCode').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnCust.Attributes.Add("onclick", "window.open('TDS_Cust_PopupReschedule1.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string final;
        final = "?ProspectCode=" + txtCustCode.Text;
        Response.Redirect("ProspectReassign1.aspx" + final);
    }
}
