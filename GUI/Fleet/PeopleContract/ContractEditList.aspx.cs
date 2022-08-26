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
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_CustomerContract : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());

        if (!IsPostBack)
        {
            hdncustcode.Value = Request.QueryString["Customer_Code"].ToString();
            //dt = objPeopleContract.GetDataTable("Select CONVERT(varchar,Contract_From_Dt,106) as Contract_From_Dt,CONVERT(varchar,Contract_To_Dt,106) as Contract_To_Dt,(case when Contract_Based_On='FTL' then 'FTL Type wise' else 'Vehicle wise' end) as Contract_Based_On,ISNULL(Active_Flag,'N') AS Active_Flag,(CASE Active_Flag WHEN 'Y' THEN 'Active' ELSE 'InActive' END) as [Status],*from [Webx_Fleet_People_Contract_Hdr] where Customer_Code = 'C00010003'");
            dataBind();
        }
    }
    public void dataBind()
    {
        People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());
        objPeopleContract.Customer_Code = hdncustcode.Value;
        objPeopleContract.Contract_Code = Request.QueryString["Contract_Type"].ToString();   
        objPeopleContract.BindGridContract(grvcontractlist);
    }
    protected void grvcontractlist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdncontractid = (HiddenField)e.Row.FindControl("hdncontractid");
            HiddenField hdnstatus = (HiddenField)e.Row.FindControl("hdnstatus");
            LinkButton lnkdeactivate = (LinkButton)e.Row.FindControl("lnkdeactivate");
            LinkButton lnkview = (LinkButton)e.Row.FindControl("lnkview");
            LinkButton lnkedit = (LinkButton)e.Row.FindControl("lnkedit");
            //LinkButton lnkscancopy = (LinkButton)e.Row.FindControl("lnkscancopy");
            LinkButton lnkviewscancopy = (LinkButton)e.Row.FindControl("lnkviewscancopy");
            //lnkscancopy.Attributes.Add("onclick", "javascript:return openScanUpload('" + hdncustcode.Value + "','" + hdncontractid.Value + "')");
            lnkview.Attributes.Add("onclick", "javascript:window.open('People_Contract_View.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Code=" + hdncontractid.Value + "','','scrollbars=yes,resizable=yes,statusbar=yes,width=1000,height=600');return false;");

            if (lnkdeactivate.Text != "Active")
            {
                //lnkdeactivate.Text = "InActive";
                lnkedit.Visible = false;
            }
            else
            {
                //lnkdeactivate.Text = "Active";
                lnkedit.Visible = true;
            }
        }
    }

    protected void lnkcontractedit_Click(object sender, EventArgs e)
    {
        LinkButton lnkedit = (LinkButton)sender;
        HiddenField hdncontractid = (HiddenField)lnkedit.Parent.FindControl("hdncontractid");
        Response.Redirect("StepSelection.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Code=" + hdncontractid.Value + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString().Trim());
    }

    protected void lnkaddnew_Click(object sender, EventArgs e)
    {
        //Server.Transfer("PMContractEntry.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString());
        Server.Transfer("StepSelection.aspx?Customer_Code=" + hdncustcode.Value + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString());
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        grvcontractlist.PageIndex = e.NewPageIndex;
        dataBind();
    }
    protected void lnkcontractdeactivate_Click(object sender, EventArgs e)
    {
        People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());

        LinkButton lnkdeactivate = (LinkButton)sender;
        HiddenField hdncontractid = (HiddenField)lnkdeactivate.Parent.FindControl("hdncontractid");
        LinkButton lnkedit = (LinkButton)lnkdeactivate.Parent.FindControl("lnkedit");

        if (lnkdeactivate.Text == "Active")
        {
            lnkdeactivate.Text = "InActive";
            objPeopleContract.ExecureQry("Update Webx_Fleet_Contract_People Set Active_Flag='N' Where Contract_Code='" + hdncontractid.Value + "'");
            objPeopleContract.ExecureQry("Update webx_custcontract_hdr Set ActiveFlag='N' Where ContractId='" + hdncontractid.Value + "'");
            lnkedit.Visible = false;
            //dataBind();
        }
        else
        {
            lnkdeactivate.Text = "Active";
            objPeopleContract.ExecureQry("Update Webx_Fleet_Contract_People Set Active_Flag='Y' Where Contract_Code='" + hdncontractid.Value + "'");
            objPeopleContract.ExecureQry("Update webx_custcontract_hdr Set ActiveFlag='Y' Where ContractId='" + hdncontractid.Value + "'");
            lnkedit.Visible = true;
            //dataBind();
        }
    }
}
