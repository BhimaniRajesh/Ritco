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


public partial class GUI_admin_AutoEmail_ReportList : System.Web.UI.Page
{
    string title = "",title1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string sqlstr = "select t.srno,Reportname,type,Freq=(case when Freq=4 then 'Daily' when Freq=8 then 'Weekly' when Freq=16 then 'Monthly' end ) from Webx_AutoEmail_Reports R inner join Webx_AutoEmail_Schedule T on r.srno=t.ReportID order by Reportname,type,Freq";
        SqlCommand sqlcmd12 = new SqlCommand(sqlstr, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;
        conn.Close();
    }

    protected void GVRowDEL(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string ClassId = dgDocket.DataKeys[thisRow].Values[0].ToString();
            ClassId = ClassId.Trim().ToString();
            string Query = "exec WebxNet_DELETE_job '" + ClassId + "'";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }

    protected void GVRowDB(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label titleLabel = (Label)e.Row.FindControl("lnk0");
            string strval = ((Label)(titleLabel)).Text;
            title = (string)ViewState["lnk0"];
            if (title == strval && e.Row.RowIndex > 0)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["lnk0"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";
            }

            Label titleLabel1 = (Label)e.Row.FindControl("lnk1");
            string strval1 = ((Label)(titleLabel1)).Text;
            title1 = (string)ViewState["lnk1"];
            if (title1 == strval1 && e.Row.RowIndex > 0)
            {
                titleLabel1.Visible = false;
                titleLabel1.Text = string.Empty;
            }
            else
            {
                title1 = strval1;
                ViewState["lnk1"] = title1;
                titleLabel1.Visible = true;
                titleLabel1.Text = "<b>" + title1 + "</b>";
            }
        }
    }
}
