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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteAll : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        //this.Title = pagetitle;

        //string EmpBranch = Session["mainbrcd"].ToString().Trim();
        //string EmpBranch1 = Session["brcd"].ToString().Trim();



        //if (EmpBranch1 != "HQTR")
        //{
        //    trbuttons.Visible = false;
        //    lblMsg.Text = "Can be Accessed from HQTR only!";

        //}
    }

}