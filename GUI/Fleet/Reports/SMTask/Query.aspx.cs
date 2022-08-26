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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TripsheetQueryNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
   
        if (!IsPostBack)
        {


            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 20/5/2014

        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        Cls_SMTask.strVehicleNo = txtVehicle.Text.ToString().Trim();
     
        //Response.Redirect("Result.aspx");
    }
}
