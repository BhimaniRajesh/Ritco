using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using WebX.Controllers;

public partial class GUI_Operations_THCAudit_THCAuditStep2 : System.Web.UI.Page
{
    public string FromDate = "", ToDate = "", ThcNo = "",Loc="";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            FromDate = Request.QueryString["FromDate"].ToString();
            ToDate = Request.QueryString["ToDate"].ToString();
            ThcNo = Request.QueryString["ThcNo"].ToString();
			 Loc = Request.QueryString["Loc"].ToString();
            if (!IsPostBack)
            {
                lblSelectedDate.Text = FromDate + " - " + ToDate;
                lblTHCno.Text = ThcNo;
                BindData();
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
            throw ex;
        }
    }

    public void BindData()
    {
        DataTable dtTHCList= THCController.GetTHCListForAudit(ThcNo, FromDate, ToDate,Loc);

        if (dtTHCList.Rows.Count > 0) {
            rptThcDetail.DataSource = dtTHCList;
            rptThcDetail.DataBind();
            btnSubmit.Visible = true;
            lblRecord.Text = "";
        }
        else
        {

            lblRecord.Text = "No record found.!";
        }
    }

    public void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Visible = false;
            DataTable dtTHCNo = new DataTable();
            dtTHCNo.Columns.Add("THCNumber");
            dtTHCNo.Columns.Add("IsPending");
            dtTHCNo.Columns.Add("IsAudited");
            dtTHCNo.Columns.Add("Remark");


            for (int i = 0; i <= rptThcDetail.Items.Count - 1; i++)
            {
                HiddenField hdnTHCNo = rptThcDetail.Items[i].FindControl("hdnTHCNo") as HiddenField;
                TextBox txtRemark = rptThcDetail.Items[i].FindControl("txtRemark") as TextBox;
                RadioButton rdbPending = rptThcDetail.Items[i].FindControl("rdbPending") as RadioButton;
                RadioButton rdbSelect = rptThcDetail.Items[i].FindControl("rdbSelect") as RadioButton;
                
                dtTHCNo.Rows.Add(hdnTHCNo.Value, rdbPending.Checked,rdbSelect.Checked, txtRemark.Text);
            }
            if (dtTHCNo.Rows.Count > 0) {
                THCController objTHCController = new THCController();

                objTHCController.UpdateAuditedTHC(dtTHCNo);
                Response.Redirect("THCAuditStep3.aspx");
            }
            

        }
        catch (Exception ex)
        {
           
            ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
            throw ex;
        }
    }
}
