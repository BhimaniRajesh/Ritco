using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Reports_TyreTrackReport_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string final = "";
        ////if (txtActTyreNo.Text != "")
        ////{
        ////    final += "?ActTyreNo=" + txtActTyreNo.Text;
        ////    final += "&ManTyreNo=";
        ////}
        ////else if (txtManTyreNo.Text != "")
        ////{
        ////    final += "?ActTyreNo=";
        ////    final += "&ManTyreNo=" + txtManTyreNo.Text;
        ////}
        ////else
        ////{
        ////    final += "?ActTyreNo=";
        ////    final += "&ManTyreNo=";
        ////}

        if (txtManTyreNo.Text != "")
        {
            final += "?ActTyreNo=";
            final += "&ManTyreNo=" + txtManTyreNo.Text;
        }
        else
        {
            final += "?ActTyreNo=";
            final += "&ManTyreNo=";
        }

        ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft= (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open('./Result.aspx" + final + "', null, 'height=700,width=900,status=yes,toolbar=no,scrollbars=yes,resizable=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'');", true);
    }
}