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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Bill_MR_Cancellation_Bill_MR_Cancellation_step_1 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Attributes.Add("onclick", "javascript:return Check_Submit()");
        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            showBillMrtype();
            lblmrno.Text = "Enter MR No. :";
            lblbillmrtype.Text = "MR Type :";
        }
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string FromDtae = fn.Mydate1(txtDateFrom.Text.ToString());
            string ToDtae = fn.Mydate1(txtDateTo.Text.ToString());
            string final = "";

            final = "?FromDtae=" + FromDtae;
            final += "&ToDtae=" + ToDtae;
            final += "&MRStype=" + ddrbillmrtype.SelectedValue.ToString();
            final += "&MRSNO=" + txtMrNo.Text;
            Response.Redirect("MR_Cancellation_step_2.aspx" + final);
        }
    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        if (txtDateFrom.Text == "")
        {
            value.IsValid = false;
            return;
        }
        if (txtDateTo.Text == "")
        {
            value.IsValid = false;
            return;
        }

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);

        if (dt1 > dt2)
        {
            CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
            value.IsValid = false;
            return;
        }
    }
    protected void showDetails(object sender, EventArgs e)
    {
        showBillMrtype();
    }
    protected void showBillMrtype()
    {
        string sql = "";
        txtMrNo.Text = "";

        lblmrno.Text = "Enter MR No. :";
        lblbillmrtype.Text = "MR Type :";
        sql = "select '' as Codeid,'Select' as CodeDesc union select Codeid,CodeDesc from webx_master_general where codetype='mrstype' and statuscode='Y' and Codeid in('11')";
        DataTable dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (dtl.Rows.Count > 0)
        {
            ddrbillmrtype.DataSource = dtl;
            ddrbillmrtype.DataBind();
        }
    }
    protected void showtype(object sender, EventArgs e)
    {
        showBillMrtype();
    }
}
