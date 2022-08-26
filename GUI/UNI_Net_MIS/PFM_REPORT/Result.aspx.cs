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

public partial class GUI_UNI_MIS_Reassign_Report_ReassignReportResult : System.Web.UI.Page
{
    public static string DateType, fromdt, todt, RO, LO, dtFrom, dtTo, Type, DWN_XLS,TypeD;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "Y")
            {
                XLS_DWN();
            }
            else
            {
                BindGrid();
            }
        }

    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        //DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        Type = Request.QueryString["Type"].ToString();
        Session["TypeD"] = Request.QueryString["Type"].ToString();
        TypeD = Request.QueryString["Type"].ToString();
        //DWN_XLS = Request.QueryString["DWN_XLS"].ToString();

        //string strrightnow, strrightnow1;
        //System.DateTime righnow = System.DateTime.Today;
        //strrightnow = righnow.ToString("dd/MM/yyyy");
        //strrightnow1 = righnow.ToString("dd/MM/yyyy");
        //if (DateType == "Date")
        //{
        //    strrightnow = Request.QueryString.Get("fromdt");
        //    strrightnow1 = Request.QueryString.Get("todt");
        //}
        //else if (DateType == "Week")
        //{
        //    strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
        //    strrightnow1 = righnow.ToString("dd/MM/yyyy");
        //}
        //else if (DateType == "Today")
        //{
        //    strrightnow = righnow.ToString("dd/MM/yyyy");
        //    strrightnow1 = righnow.ToString("dd/MM/yyyy");

        //}
        //else if (DateType == "Tilldate")
        //{
        //    strrightnow = "01/04/1990";
        //    strrightnow1 = righnow.ToString("dd/MM/yyyy");

        //}
        //string[] strArrDtFrom = strrightnow.Split('/');
        //string[] strArrDtTo = strrightnow1.Split('/');
        //dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        //dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        lblseldet.Text = fromdt + " - " + todt;
        Session["ReDate"] = lblseldet.Text;
        lblro.Text = RO;
        lblloc.Text = LO;

        if (TypeD == "dockdt")
            lblTypeD.Text = "Booking Date";
        else if (TypeD == "dely_date")
            lblTypeD.Text = "Delivery Date";

        string sql_st = "exec webx_PFM_Report_net '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + Type + "'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

        conn.Close();
    }
    
    protected void btn_csv_Click(object sender, EventArgs e)
    {
       
    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {
        XLS_DWN();
    }
    public void XLS_DWN()
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=PFM_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
   
}
