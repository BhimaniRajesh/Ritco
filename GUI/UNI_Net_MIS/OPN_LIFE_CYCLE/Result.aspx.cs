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
using System.IO;
public partial class GUI_UNI_MIS_OPN_LIFE_CYCLE_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    int loclevel;
    public static string strcust, dkt_call, THC_call;
    public static string RO, brcd,DWN_XLS, LO, empcd, DateType, fromdt, todt, st_columnlist, selyear, dkt_Call, thc_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();
        if (!IsPostBack)
        {
            
            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "Y")
            {
                // Response.ContentType = "application/vnd.ms-excel";
                // Response.AddHeader("content-disposition", "attachment; filename=Trail_balance.xls");

                XLS_DWN();
            }
            else
            {
                BindGrid();
            }
        }

    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                lblColDockdt.Text = dkt_call + " Date";
            }
        }
    }
     public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            dgDocket.AllowPaging = false;
            dgDocket.BorderWidth = 1;
            dgDocket.CssClass = "blackfnt";
            dgDocket.Font.Size = 10;

            TB_CRI.Border = 1;

            BindGrid();
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=Consignment_Lifecycle_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);

            frm.Controls.Add(TB_CRI);


            frm.Controls.Add(dgDocket);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            //throw ex1;
            // lblloc.Text = ex1.Message;
        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        st_columnlist = Request.QueryString["st_columnlist"].ToString();
        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = LO;
        LBLRPT.Text = RO;
       // LO = Request.QueryString["LO"].ToString();
        string SQL_TB = "exec Webx_DKT_OPN_LIFE_CYCLE   '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + st_columnlist + "'";
        //Response.Write("<BR> SQL_TB : " + SQL_TB);
       // Rtyp = "1";
        SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
        //SqlDataReader dr;
        //dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

        Conn.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;


        BindGrid();

    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        XLS_DWN();
    }
}
