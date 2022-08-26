using System;

public partial class GUI_Operations_Indent_ProposedEntryDone : System.Web.UI.Page
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
                lblProposedIndentNo.Text = Convert.ToString(Request.QueryString["ProposedIndentNo"]);
                if (lblIndentNo.Text != "")
                    trindent.Visible = true;
                if (Convert.ToString(Request.QueryString["Type"]) == "P")
                {
                    lblTitle.Text = "Proposed Indent Number " + lblProposedIndentNo.Text + " Generated Successfully";
                }
                else
                {
                    lblTitle.Text = "Proposed Indent Number " + lblProposedIndentNo.Text + " Generated Successfully<br/>" + "Indent Number " + lblIndentNo.Text + " Generated Successfully";
                    trPindet.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + ex.Message.Replace('\n', '_'));
        }
    }
    #endregion
}