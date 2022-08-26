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
    string GRNNO = "", vendorcd = "";
    MyFunctions fn = new MyFunctions();
    public static string ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string Financial_Year = "", fin_year = "";
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');


        GRNNO = Request.QueryString["GRNNO"];
        //vendorcd = Request.QueryString["vendorcd"];

        if (!Page.IsPostBack)
        {
            Lbl_GRNNo.Text = GRNNO;
            Lbl_GRN.CssClass = "blackfnt";
            Lbl_GRNNo.CssClass = "blackfnt";
        }
    }
}
