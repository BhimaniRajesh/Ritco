using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_Indent_ViewPrint_ExecutionIndentViewQuery : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    public void BindRept()
    {
        var objIndent = new Indent();
        var objIndentController = new IndentController();

        string dtFrom = DT.FromDate;
        string dtTo = DT.ToDate;
        objIndent.IndentNumber = txtIndentNumber.Text;
        objIndent.DocketNumber = txtDocketNo.Text;
        objIndent.DeliveryPartyName = txtDiliverPartyname.Text;
        objIndent.BillingPartyName = txtBillingPartyname.Text;
        objIndent.Status = rblAllDeliveredPending.SelectedValue.ToString().Trim();


        if (txtDocketNo.Text.Trim() != "")
        {

            char last_char = txtDocketNo.Text.Trim()[txtDocketNo.Text.Trim().Length - 1];
            if (last_char.ToString().Trim() == ",")
            { objIndent.DocketNumber = txtDocketNo.Text.Trim(); }
            else { objIndent.DocketNumber = txtDocketNo.Text.Trim() + ","; }
        }

        //DataTable dt = objIndentController.ExecutionIndentDetails(dtFrom, dtTo, objIndent);
        //if (dt.Rows.Count > 0)
        //{
        //    rptExIndentDktPendingList.DataSource = dt;
        //    rptExIndentDktPendingList.DataBind();
        //}
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //BindRept();
        //divExecutionIndentDetails.Visible = true;
       

        string FromDate = DT.FromDate;
        string ToDate = DT.ToDate;
        string Status = rblAllDeliveredPending.SelectedValue;
        string IndentNo = txtIndentNumber.Text;
        string IndentNumber = txtIndentNumber.Text;
        string DocketNo = txtDocketNo.Text;
        string DeliveryPartyName = txtDiliverPartyname.Text;
        string BillingPartyName = txtBillingPartyname.Text;
        string final;
        final = "ExecutionIndentViewResult.aspx?FromDate=" + FromDate;
        final += "&ToDate=" + ToDate;
        final += "&Status=" + Status;
        final += "&IndentNo=" + IndentNo;
        final += "&IndentNumber=" + IndentNumber;
        final += "&DocketNo=" + DocketNo;
        final += "&DeliveryPartyName=" + DeliveryPartyName;
        final += "&BillingPartyName=" + BillingPartyName;

        //divExecutionIndentCriteria.Visible = false;
        //divExecutionIndentHdr.Visible = false;

       Page.RegisterStartupScript("ExecutionIndentView", @"<script language='JavaScript' type='text/javascript'>window.open('" + final + "', '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800 ,height=600,status=no,left=60,top=50');</script>");
       
    }
}