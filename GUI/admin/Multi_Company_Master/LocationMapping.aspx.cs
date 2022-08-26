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

public partial class GUI_admin_Multi_Company_Master_LocationMapping : System.Web.UI.Page
{
    Company_Master Company_Dtl = new Company_Master();
    DataTable dt = new DataTable();
    string ActiveFlag = "Y";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtLocCode.Attributes.Add("onblur", "LocBlur('" + txtLocCode.ClientID.ToString() + "')");
        btnLocCode.Attributes.Add("onclick", "popuplist('LocCode','" + txtLocCode.ClientID.ToString() + "','none')");
    }
    protected void btnLocSubmit_Click(object sender, EventArgs e)
    {
        dt = Company_Dtl.CompanyMasterEmpLocLoadData(txtLocCode.Text,"Location");
        if (dt.Rows.Count > 0)
        {
            trgridview.Visible = true;
            trsubmit.Visible = true;
            tractive.Visible = true;

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }

        DataTable Dt = Company_Dtl.EmpLocCheckExists(txtLocCode.Text, "Location");
        if (Dt.Rows.Count > 0)
        {
            if (Convert.ToDouble(Dt.Rows[0]["COUNT"]) > 0)
                HdnInsUpFlag.Value = "2";
            else
                HdnInsUpFlag.Value = "1";

            if (Convert.ToString(Dt.Rows[0]["ACTIVEFLAG"]) == "Y")
                ActiveFlag = "Y";
            else
                ActiveFlag = "N";
        }
        else
        {
            HdnInsUpFlag.Value = "1";
            ActiveFlag = "N";
        }

        if (ActiveFlag == "Y")
            chkActive.Checked = true;
        else
            chkActive.Checked = false;

    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox checkyn = ((CheckBox)e.Row.FindControl("checkyn"));
            HiddenField hdncheckyn = ((HiddenField)e.Row.FindControl("hdncheckyn"));

            RadioButton defaultyn = ((RadioButton)e.Row.FindControl("defaultyn"));
            HiddenField hdndefaultyn = ((HiddenField)e.Row.FindControl("hdndefaultyn"));

            if (hdncheckyn.Value == "TRUE")
                checkyn.Checked = true;
            else
                checkyn.Checked = false;

            if (hdndefaultyn.Value == "TRUE")
                defaultyn.Checked = true;
            else
                defaultyn.Checked = false;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Company_List = "", Default_Company = "";

        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            Label lblcmpcode = ((Label)gridrow.FindControl("lblcmpcode"));
            CheckBox checkyn = ((CheckBox)gridrow.FindControl("checkyn"));
            RadioButton defaultyn = ((RadioButton)gridrow.FindControl("defaultyn"));

            if (checkyn.Checked)
                Company_List += lblcmpcode.Text + ",";

            if (defaultyn.Checked)
                Default_Company = lblcmpcode.Text;
        }

        if (Company_List.Length > 0)
            Company_List = Company_List.Substring(0, Company_List.Length - 1).ToString();

        if (chkActive.Checked)
            ActiveFlag = "Y";
        else
            ActiveFlag = "N";
        
        string Xml_Location_Details = "<root><LocMapping>";
        Xml_Location_Details += "<LOCCODE>" + txtLocCode.Text.Trim() + "</LOCCODE>";
        Xml_Location_Details += "<COMPANY_LIST>" + Company_List.Trim() + "</COMPANY_LIST>";
        Xml_Location_Details += "<DEFAULT_COMPANY>" + Default_Company.Trim() + "</DEFAULT_COMPANY>";
        Xml_Location_Details += "<ACTIVEFLAG>" + ActiveFlag.Trim() + "</ACTIVEFLAG>";
        Xml_Location_Details += "<ENTRYBY>" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "</ENTRYBY>";
        Xml_Location_Details += "<INSUPFLAG>" + HdnInsUpFlag.Value.Trim() + "</INSUPFLAG>";
        Xml_Location_Details += "</LocMapping></root>";

        con = new SqlConnection(SessionUtilities.ConnectionString.ToString().Trim());
        con.Open();

        SqlTransaction trans;
        trans = con.BeginTransaction();

        string LocCode = "";

        try
        {
            LocCode = Company_Dtl.InsertUpdateLocMapping(Xml_Location_Details, trans);
            trans.Commit();
        }
        catch (Exception e1)
        {
            string ErrorMsg = e1.Message.ToString();
            ErrorMsg = ErrorMsg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("../../ErrorPage.aspx?PageHead=" + "Transaction Error" + "&ErrorMsg=" + ErrorMsg);
            Response.End();
        }
        con.Close();

        Response.Redirect("Company_Master_Done.aspx?Type=Location&Flag=" + HdnInsUpFlag.Value.ToString() + "&Code=" + LocCode, false);
    }
}
