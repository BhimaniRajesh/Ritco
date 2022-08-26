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


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRN_Done : System.Web.UI.Page
{
    string TranXaction = "";
    public static string DDMRNo = "", ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //DDMRNo = Request.QueryString.Get("DDMRSNO");
        //Lbl_DDMRNo.Text = DDMRNo.ToString();
        //TranXaction = Request.QueryString.Get("TranXaction");
        //if (TranXaction != "Done")
        //{
        //    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "DDMR Process" + "&ErrorMsg=" + TranXaction);
        //    // Response.End();
        //}
    }
}
