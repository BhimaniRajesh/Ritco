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

public partial class GUI_admin_CustomerContract : System.Web.UI.Page
{

    MyFunctions fn = new MyFunctions();
    static DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        string custid = Request.QueryString["custcode"].ToString();
        hdncustcode.Value = custid;
        lblcustcodename.Text = custid + " : " + fn.Getcustomer(custid);
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        if (!IsPostBack)
        {
            SqlCommand cmd;

            DateTime dtstartfinyear = new DateTime(Convert.ToInt16(Session["finyear"]), 4, 1);
            DateTime dtendfinyear = new DateTime(Convert.ToInt16(Session["finyear"]) + 1, 3, 31);

            string sqlstr = "SELECT custcode,contractid,ISNULL(activeflag,'N') AS activeflag,status=(CASE activeflag WHEN 'Y' THEN 'Active' ELSE 'InActive' END),";
            sqlstr = sqlstr + "CONVERT(VARCHAR,contract_effectdate,106) AS startdate,";
            sqlstr = sqlstr + "CONVERT(VARCHAR,contract_eddate,106) AS enddate,";
            sqlstr = sqlstr + "contract_type,contracttype=(SELECT codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=contract_type)";
            sqlstr = sqlstr + " FROM webx_custcontract_hdr WHERE custcode='" + custid + "'";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count <= 0)
            {
                grvcontractlist.CssClass = "redfnt";
                grvcontractlist.HorizontalAlign = HorizontalAlign.Center;
            }

            if (dt.Rows.Count <= 0)
            {
                grvcontractlist.Style["display"] = "none";
                tblgrid.Style["display"] = "block";
            }

            dataBind();
        }
    }

    protected void grvcontractlist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdncontractid = (HiddenField)e.Row.FindControl("hdncontractid");
            HiddenField hdnstatus = (HiddenField)e.Row.FindControl("hdnstatus");
            LinkButton lnkdeactivate = (LinkButton)e.Row.FindControl("lnkdeactivate");
            LinkButton lnkedit = (LinkButton)e.Row.FindControl("lnkedit");
            if (hdnstatus.Value.ToUpper().CompareTo("Y") == 0)
            {
                lnkdeactivate.Text = "DeActivate";

            }
            else
            {
                lnkdeactivate.Text = "Activate";
                lnkedit.Style["display"] = "none";
            }
        }
    }

    protected void lnkcontractedit_Click(object sender, EventArgs e)
    {
        LinkButton lnkedit = (LinkButton)sender;
        HiddenField hdncontractid = (HiddenField)lnkedit.Parent.FindControl("hdncontractid");
        Response.Redirect("StepSelection.aspx?custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value);
    }

    protected void lnkdockview_Click(object sender, EventArgs e)
    {
        LinkButton lnkview = (LinkButton)sender;
        HiddenField hdncontractid = (HiddenField)lnkview.Parent.FindControl("hdncontractid");
        Response.Redirect("ViewContract.aspx?custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value);
    }



    protected void lnkcontractdeactivate_Click(object sender, EventArgs e)
    {
        LinkButton lnkdeactivate = (LinkButton)sender;
        HiddenField hdncontractid = (HiddenField)lnkdeactivate.Parent.FindControl("hdncontractid");
        HiddenField hdncontractstatus = (HiddenField)lnkdeactivate.Parent.FindControl("hdnstatus");


        if (hdncontractstatus.Value.CompareTo("Y") == 0)
        {
            Response.Redirect("ContractConfirmation.aspx?contractid=" + hdncontractid.Value + "&custcode=" + hdncustcode.Value + "&action=deactivate");
            return;
        }
        else
        {
            Response.Redirect("ContractConfirmation.aspx?contractid=" + hdncontractid.Value + "&custcode=" + hdncustcode.Value + "&action=activate");
            return;
        }


    }

    protected void lnkaddnew_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddNewContract.aspx?custcode=" + hdncustcode.Value);
    }


    protected void dataBind()
    {
        grvcontractlist.DataSource = dt;
        grvcontractlist.DataBind();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        grvcontractlist.PageIndex = e.NewPageIndex;
        dataBind();
    }


}
