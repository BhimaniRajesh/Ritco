using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class GUI_admin_GeneralMaster_GeneralMasterView : System.Web.UI.Page
{

    string mastercode = ""; //, statuscode, mastertype, headeraccess;
    int i = 0;
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {
        mastercode = Request.QueryString["mastercode"].ToString();
        hdnCode.Value = Convert.ToString(Request.QueryString["mastercode"]);

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       

        if (!IsPostBack)
        {
            hdnflagprint.Value = Convert.ToString(Request.QueryString["print"]);
            bindgrid();

            string strsql = "SELECT HeaderDesc FROM webx_master_codetypes where HeaderCode='" + mastercode + "'";
            string headerDesc = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
            lblHeader.Text = headerDesc + " Master";
            if (hdnflagprint.Value.CompareTo("N") == 0)
            {
                lnkBtnPrint.Visible = true;
            }
            else if (hdnflagprint.Value.CompareTo("Y") == 0)
            {
                tblmain.CssClass = "prnttbl";
                grvgeneral.CssClass = "prnttbl";
                lnkBtnPrint.Visible = false;
            }
            else
            {
                setBorderWidth();
                DownloadXLS();
            }

        }
    }
    private void bindgrid()
    {
        DataTable dtgeneral;

        try
        {
            string strsql1 = "SELECT CodeId, CodeDesc, StatusCode FROM webx_master_general WHERE codetype='" + mastercode + "' order by CodeDesc";
            dtgeneral = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql1).Tables[0];

            grvgeneral.DataSource = dtgeneral;
            grvgeneral.DataBind();
        }
        catch (Exception exp)
        {
            throw exp;
        }
    }

    public void grvgeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow dr = (e.Row.DataItem as DataRowView).Row as DataRow;

            Label lblcodeid = (Label)e.Row.FindControl("lblcodeid");
            Label lblcodedesc = (Label)e.Row.FindControl("lblcodedesc");
            Label lblActiveFlag = (Label)e.Row.FindControl("lblActiveFlag");

            lblcodeid.Text = Convert.ToString(dr["codeid"]);
            lblcodedesc.Text = Convert.ToString(dr["codedesc"]);

            if (Convert.ToString(dr["StatusCode"]).Trim() == "Y")
            {
                lblActiveFlag.Text = "Yes";
            }
            else
            {
                lblActiveFlag.Text = "No";
            }

        }
    }

    protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        try
        {

            setBorderWidth();
            DownloadXLS();

        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in download excel file.&detail1=" + Exc.Message.Replace('\n', '_'), true);
        }
        finally
        {

            Response.End();
        }
    }

    private void setBorderWidth()
    {
        lblHeader.BorderWidth = 1;
        tblmain.BorderWidth = 1;
        grvgeneral.BorderWidth = 1;
    }
    private void DownloadXLS()
    {
        try
        {
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + lblHeader.Text.Trim() + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(tblmain);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }

}
