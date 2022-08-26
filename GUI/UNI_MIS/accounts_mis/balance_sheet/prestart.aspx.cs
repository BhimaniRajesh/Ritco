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

public partial class GUI_UNI_MIS_accounts_mis_balance_sheet_prestart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql;
        SqlDataAdapter da;
        DateFunction DAccess = new DateFunction();
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string loccode = Session["brcd"].ToString();

            if (loccode == Session["HeadOfficeCode"].ToString())
            {
                sql = "select loccode,locname + ' : ' + loccode as locname from webx_location where activeFlag='Y' order by locName";
            }
            else
            {
                sql = "select loccode,locname + '' + loccode as locname from webx_location where activeFlag='Y' and loccode='" + loccode + "' order by locName";
            }
            da = new SqlDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Load");
            dlstBranch.DataSource = ds;
            dlstBranch.DataValueField = "loccode";
            dlstBranch.DataTextField = "locname";
            dlstBranch.DataBind();
            dlstBranch.Items.Insert(0, "Select");
            dlstBranch.Items[0].Value = "";
            dlstBranch.SelectedValue = loccode;
            DateTime dt = DateTime.Now;
            OnDate.CalendarDate = dt.ToString("dd/MM/yyyy");
            conn.Dispose();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string branch = dlstBranch.SelectedItem.Value;
        string strTranType = dlstTranType.SelectedItem.Value;
        string asOnDate= OnDate.CalendarDate;
        Response.Redirect("result.aspx?branch=" + branch + "&strTranType=" + strTranType + "&asOnDate=" + asOnDate, true);

    }
}
