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
using System.Text;
using System.IO;


public partial class GUI_Fleet_Reports_TripResult : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();


        if (!IsPostBack)
        {

            
        }


    }


    public void BindGrid()
    {
        string sql = "usp_Driver_Settlement_Report";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        {
            dtFrom = Convert.ToDateTime(Session["dtFrom"].ToString().Trim(), dtfi);
            dtTo = Convert.ToDateTime(Session["dtTo"].ToString().Trim(), dtfi);
        }
        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.VarChar).Value = Session["dtFrom"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.VarChar).Value = Session["dtTo"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = Session["Status"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = Session["Branch"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@DateGNorCL", SqlDbType.VarChar).Value = Session["DateGNorCL"].ToString().Trim();
        sqlcmd.ExecuteReader();
        conn.Close();
        
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // reference the Delete Link Command Column.
            //LinkButton db = (LinkButton)e.Row.Cells[6].Controls[0];
            //db.OnClientClick = string.Format("return confirm('Are you want to delete the Order?');");
        }
    }





    protected void btnXML_Click(object sender, EventArgs e)
    {
        GridView1.AllowPaging = false;
        GridView1.BorderWidth = 1;
        GridView1.CssClass = "blackfnt";
        GridView1.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TripsheetRegister.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);


        Controls.Add(frm);

        frm.Controls.Add(GridView1);

        frm.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
    }   
}
