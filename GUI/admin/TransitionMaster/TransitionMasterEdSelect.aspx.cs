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

public partial class GUI_admin_TransitionMaster_TransitionMasterEdSelect : System.Web.UI.Page
{
   // SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Session["tOrgnBranch"] = txtOrgnBranch.Text;
        //Session["tDestBranch"] = txtDestBranch.Text;
        //Session["tTransLocCod"] = txtTransLocCod.Text;
        //Server.Transfer("TransitionMasterEdit.aspx");

        if (txtTransLocCod.Text == "") // && txtOrgnBranch.Text != "" && txtDestBranch.Text != "")
        {
            Session["tOrgnBranch"] = txtOrgnBranch.Text;
            Session["tDestBranch"] = txtDestBranch.Text;
            Session["tTransLocCod"] = "";
            Server.Transfer("TransitionMasterEdit.aspx");
        }
        else //if (txtTransLocCod.Text != "" && txtOrgnBranch.Text == "" && txtDestBranch.Text == "")
        {
            Session["tTransLocCod"] = txtTransLocCod.Text;
            Session["tOrgnBranch"] = "";
            Session["tDestBranch"] = "";
            Server.Transfer("TransitionMasterEdit.aspx");
        }
    }
}
