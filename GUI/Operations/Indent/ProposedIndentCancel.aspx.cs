using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Exception_Indent_ProposedIndentCancel : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            txtCanceldate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        }
    }
    /// <summary>
    /// Submit Event
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        var objIndentController = new IndentController();
        DataTable dt = objIndentController.GetListingForCancellation(dtFrom.ToString(), dtTo.ToString(), txtIndentNumber.Text);
        if (dt.Rows.Count > 0)
        {
            rptFinnalIndentDktPendingList.DataSource = dt;
            rptFinnalIndentDktPendingList.DataBind();
        }
        divIndentCancelResult.Visible = true;
        divIndentCancelCriteria.Visible = false;
    }
    protected void lnkbtnCancelIndent_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "CancelIndent")
        {
            //HiddenField hdnIndentNumber = (HiddenField)e.CommandArgument.ToString();
            LinkButton lnkbtnCancelIndent = (LinkButton)(sender);
            string IndentNumber = lnkbtnCancelIndent.CommandArgument;
            divIndentCancelUpdate.Visible = true;
            divIndentCancelResult.Visible = false;
            lblIndentNumber.Text = IndentNumber;
        }
    }
    /// <summary>
    /// Cancel Indent on Submit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmitCancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                var objIndentController = new IndentController();
                string[] CancelDate = txtCanceldate.Text.Split('/');
                objIndentController.CancelIndent(lblIndentNumber.Text, txtCancelReason.Text, Convert.ToDateTime(CancelDate[1] + "/" + CancelDate[0] + "/" + CancelDate[2]).ToString("dd MMM yy"));
                ConsumeToken();
                Response.Redirect("ProposedIndentCancelDone.aspx?IndentNo=" + lblIndentNumber.Text, false);
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
}