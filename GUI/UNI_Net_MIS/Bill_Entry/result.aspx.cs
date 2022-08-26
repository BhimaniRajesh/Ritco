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
public partial class GUI_UNI_MIS_Bill_Entry_result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string strrightnow = "", strrightnow1 = "", dtFrom = "", dtTo = "";
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");

        string RO = Request.QueryString.Get("RO");
        if (RO == "")
        {
            RO = "All";
        }
        string LO = Request.QueryString.Get("LO");
        if (LO == "")
        {
            LO = "All";
        }
        string DateType = Request.QueryString.Get("DateType");

        // string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        dtFrom = Request.QueryString.Get("fromdt");
        dtTo = Request.QueryString.Get("todt");
         
       string Doc_type = Request.QueryString.Get("Rtyp");
       string Rtyp = Request.QueryString.Get("Rtyp");
        string custcd = Request.QueryString.Get("St_custcd");
        // string st_vendcd = Request.QueryString.Get("st_vendcd");
        string st_orderlist = Request.QueryString.Get("st_orderlist");

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO;
        lblloc.Text = LO;
       
        //st_orderlist = "";
        //if (Doc_type.ToUpper() == "THC")
        //{
        //    custcd = st_vendcd;
        //    st_orderlist = Request.QueryString.Get("st_orderlist");
        //}

        //lblflow string custcd = "";

        if (custcd.ToString() == "")
        {
            custcd = "All";

        }
        if (Rtyp.ToString() == "")
        {
            Rtyp = "All";

        }
        lblflow.Text = Rtyp;
        lblcust.Text = custcd;

        string SQL_grid = "exec webx_BILLENtry_register '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + Rtyp + "','" + st_orderlist + "','" + custcd + "'";

       // Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
       // SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;


        BindGrid();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
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
        Response.AddHeader("content-disposition", "attachment;filename=BILL_ENTRY_Register_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);


        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
}
