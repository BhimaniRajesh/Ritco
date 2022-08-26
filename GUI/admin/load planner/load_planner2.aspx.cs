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

public partial class GUI_admin_VehicleMaster_VehicleMasterAdd : System.Web.UI.Page
{
    public static SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strToday;
    public byte byteRadButtonSelection;
    public static Double cap = 0, cap2 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //getstring();
        //getallvehno();

        if (!IsPostBack)
        {
            lblload.Text += Request.QueryString["res"].ToString();
            lblvehcap.Text += Request.QueryString["cap"].ToString();
            lblwht.Text += Request.QueryString["tot"].ToString();
            disp();

        }


    }
    public void disp()
    {
        string d = Request.QueryString["dno"].ToString();
        d = d.Substring(0, d.Length - 1);
        SqlConnection cnn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "SELECT dockno,(convert(VARCHAR,dockdt,106)) AS DT,actuwt,chrgwt FROM webx_master_docket where DOCKNO IN(" + d + ")";
        SqlDataAdapter da = new SqlDataAdapter(sql, cnn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_Booking.DataSource = ds;
        GV_Booking.DataBind();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {

        int ind = 0;
        int a = 0;
        try
        {
            GV_Booking.AllowPaging = false;
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=LoadPlanner.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            disp();
            pnl2.RenderControl(hw);
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            btn_csv.Text = ex1.Message;
        }
    }







}





