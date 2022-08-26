using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_DocketFinalization_DocketFinalizationDone : System.Web.UI.Page
{
    protected string Finalized = "", DocTypeFlag;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["Type"].ToString() == "PO")
                {
                    lblTitle.Text = "Following Details of Finalized Purchase Order";
                    tdFinalizedDocket.Text = "Finalized Purchase Order";
                    lblFinalizedDocket.Text = Convert.ToString(Request.QueryString["PONos"]);
                    Finalized = lblFinalizedDocket.Text;
                    lnkBtnNewDocket.Text = "Click Here to Finalized More Purchase Order";   
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
}
