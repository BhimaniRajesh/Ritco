using System;

public partial class GUI_Exception_Indent_ProposedIndentCancelDone : System.Web.UI.Page
{
    #region Variable[s]
    public static string IndentNo = "";
    #endregion
    #region Page Load Event
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                lblIndentNo.Text = Convert.ToString(Request.QueryString["IndentNo"]);
                lblTitle.Text = "Indent Number " + lblIndentNo.Text + " Cancelled Successfully";
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + ex.Message.Replace('\n', '_'));
        }
    }
    #endregion
}