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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;

public partial class GUI_UNI_MIS_OCT_RPT_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string strcust, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();

        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string RO = "", LO = "", DateType = "", fromdt = "", todt = "", RPT = "", ST_CAT = "";
        string st_Docnolist = "", St_OCTBILLlist = "", st_OCTMRlist = "", STATUS = "", STR_STATUS = "";

        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        STATUS = Request.QueryString["STATUS"].ToString();
        st_Docnolist = Request.QueryString["st_Docnolist"].ToString();
        St_OCTBILLlist = Request.QueryString["St_OCTBILLlist"].ToString();
        st_OCTMRlist = Request.QueryString["st_OCTMRlist"].ToString();
        STR_STATUS = Request.QueryString["STR_STATUS"].ToString();
        LBLDATE.Text = fromdt + " - " + todt;
        LBLSUBRPT.Text = STR_STATUS;

        string sql_st = "exec WebxNet_octroi '" + fromdt + "','" + todt + "','" + STATUS + "','" + st_Docnolist + "','" + St_OCTBILLlist + "','" + st_OCTMRlist + "'";
        //Response.Write(sql_st);
        //Response.End();
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, Conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();

        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

        Conn.Close();

    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColdockno1");
            // Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                //lblColDockdt.Text = dkt_call + " Date";
            }

        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    public void DWN_XLS()
    {
        try
        {

            TBL_CRI.Border = 1;

            dgDocket.AllowPaging = false;
            dgDocket.BorderWidth = 1;
            dgDocket.BorderColor = System.Drawing.Color.Gray;
            dgDocket.Font.Name = "verdana";
            dgDocket.Font.Size = 8;

            BindGrid();

            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=Octroi_REPort.xls");
            Response.Charset = "";

            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);

            //TBL_CRI.RenderControl(htmlWrite);
            //dgDocket.RenderControl(htmlWrite);
            frm.Controls.Add(TBL_CRI);
            frm.Controls.Add(dgDocket);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {      
            dgDocket.PageIndex = e.NewPageIndex;
            BindGrid();
    }
}
