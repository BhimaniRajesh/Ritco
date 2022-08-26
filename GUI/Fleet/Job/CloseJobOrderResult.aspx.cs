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

public partial class GUI_Fleet_Job_CloseJobOrderResult : System.Web.UI.Page
{
    string OrderNo = "", Flag = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["OrderNo"] != null)
        {
            OrderNo = Request.QueryString["OrderNo"];
            Flag = Request.QueryString["Flag"];
            lblDocNo.Text = OrderNo;
            CheckCloseJS();
        }
    }
    public void CheckCloseJS()
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        DataTable dt = new DataTable();
        objJs.JobOrderNo = OrderNo;
        dt = objJs.CheckCloseJS();
        if (dt.Rows.Count > 0)
        {
            if (Convert.ToInt32(dt.Rows[0]["totCount"].ToString()) > 0)
            {
                rowCloseError.Visible = true;
                lblCloseError.Text = "Jobsheet was closed,but not Approved.";
            }
            else
            {
                rowCloseError.Visible = false;
                lblCloseError.Text = "";
            }
        }
    }
}
