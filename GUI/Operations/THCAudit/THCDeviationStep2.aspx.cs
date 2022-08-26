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

public partial class GUI_Operations_THCAudit_THCDeviationStep2 : System.Web.UI.Page
{
    public string FromDate = "", ToDate = "", ThcNo = "", Loc="";
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
        DataTable dtTHCList= THCController.GetTHCListForDeviationAudit(ThcNo, FromDate, ToDate,Loc);

        if (dtTHCList.Rows.Count > 0)
        {
            rptThcDetail.DataSource = dtTHCList;
            rptThcDetail.DataBind();
            TRsubmit.Visible = true;
            lblRecord.Text = "";
        }
        else {

            lblRecord.Text = "No record found.!";
        }
    }

    public void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            TRsubmit.Visible = false;
            
            DataTable dtTHCNo = new DataTable();
            dtTHCNo.Columns.Add("THCNumber");
            dtTHCNo.Columns.Add("IsPending");
            dtTHCNo.Columns.Add("IsAudited");
            dtTHCNo.Columns.Add("Remark");


            for (int i = 0; i <= rptThcDetail.Items.Count - 1; i++)
            {
                HiddenField hdnTHCNo = rptThcDetail.Items[i].FindControl("hdnTHCNo") as HiddenField;
                TextBox txtRemark = rptThcDetail.Items[i].FindControl("txtRemark") as TextBox;
 CheckBox ChkSelect = rptThcDetail.Items[i].FindControl("ChkSelect") as CheckBox;
                if (ChkSelect.Checked)
                {
                     dtTHCNo.Rows.Add(hdnTHCNo.Value, false,true, txtRemark.Text);
                }
               
            }
            if (dtTHCNo.Rows.Count > 0) {
                THCController objTHCController = new THCController();

                objTHCController.UpdateDeviationTHC(dtTHCNo);
                Response.Redirect("THCDeviationStep3.aspx");
            }
            

        }
        catch (Exception ex)
        {
           
            ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
            throw ex;
        }
    }

    protected void btnKeepPending_Click(object sender, EventArgs e)
    {
        try
        {
            TRsubmit.Visible = false;
            DataTable dtTHCNo = new DataTable();
            dtTHCNo.Columns.Add("THCNumber");
            dtTHCNo.Columns.Add("IsPending");
            dtTHCNo.Columns.Add("IsAudited");
            dtTHCNo.Columns.Add("Remark");


            for (int i = 0; i <= rptThcDetail.Items.Count - 1; i++)
            {
                HiddenField hdnTHCNo = rptThcDetail.Items[i].FindControl("hdnTHCNo") as HiddenField;
                TextBox txtRemark = rptThcDetail.Items[i].FindControl("txtRemark") as TextBox;
CheckBox ChkSelect = rptThcDetail.Items[i].FindControl("ChkSelect") as CheckBox;
                if (ChkSelect.Checked)
                {
                     dtTHCNo.Rows.Add(hdnTHCNo.Value, true,false, txtRemark.Text);
                }
                
            }
            if (dtTHCNo.Rows.Count > 0)
            {
                THCController objTHCController = new THCController();

                objTHCController.UpdateDeviationTHC(dtTHCNo);
                Response.Redirect("THCDeviationStep3.aspx");
            }


        }
        catch (Exception ex)
        {

            ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
            throw ex;
        }
    }
}
