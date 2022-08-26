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

public partial class GUI_UNI_MIS_OUTSTD_BILL_MR_result : System.Web.UI.Page
{
    string Doc_type;
    public static string strDateRange;
    public static string strro, strro_val;
    public static string strloc;
    public static string strcust, dkt_call, Rtyp, thc_call, roval = "", Preroval = "";
    double dbltotdoc = 0.00, dbltols = 0.00, dbltomf = 0.00, dbltothc = 0.00, dbltoprs = 0.00, dbltodrs = 0.00;
   // double totdkts = 0, totls = 0, totmf = 0, totthc = 0, totprs = 0, totdrs = 0;
    double totbill = 0, totbill_amt = 0, totPbill = 0, totPbill_amt = 0, totTbill = 0, totTbill_amt = 0, totObill = 0, totObill_amt = 0;
    double totbill_CL = 0, totbill_CL_amt = 0, totPbill_CL = 0, totPbill_CL_amt = 0, totTbill_CL = 0, totTbill_CL_amt = 0, totObill_CL = 0, totObill_CL_amt = 0;
    double totbill_OS = 0, totbill_OS_amt = 0, totPbill_OS = 0, totPbill_OS_amt = 0, totTbill_OS = 0, totTbill_OS_amt = 0, totObill_OS = 0, totObill_OS_amt = 0;
    double totbill_CLT = 0, totbill_CLT_amt = 0, totPbill_CLT = 0, totPbill_CLT_amt = 0, totTbill_CLT = 0, totTbill_CLT_amt = 0, totObill_CLT = 0, totObill_CLT_amt = 0;
    double totbill_OST = 0, totbill_OST_amt = 0, totPbill_OST = 0, totPbill_OST_amt = 0, totTbill_OST = 0, totTbill_OST_amt = 0, totObill_OST = 0, totObill_OST_amt = 0;

    //double RO_totdkts = 0, RO_totls = 0, RO_totmf = 0, RO_totthc = 0, RO_totprs = 0, RO_totdrs = 0;
    double RO_totbill = 0, RO_totbill_amt = 0, RO_totPbill = 0, RO_totPbill_amt = 0, RO_totTbill = 0, RO_totTbill_amt = 0, RO_totObill = 0, RO_totObill_amt = 0;
    double RO_totbill_CL = 0, RO_totbill_CL_amt = 0, RO_totPbill_CL = 0, RO_totPbill_CL_amt = 0, RO_totTbill_CL = 0, RO_totTbill_CL_amt = 0, RO_totObill_CL = 0, RO_totObill_CL_amt = 0;
    double RO_totbill_OS = 0, RO_totbill_OS_amt = 0, RO_totPbill_OS = 0, RO_totPbill_OS_amt = 0, RO_totTbill_OS = 0, RO_totTbill_OS_amt = 0, RO_totObill_OS = 0, RO_totObill_OS_amt = 0;
    double RO_totbill_CLT = 0, RO_totbill_CLT_amt = 0, RO_totPbill_CLT = 0, RO_totPbill_CLT_amt = 0, RO_totTbill_CLT = 0, RO_totTbill_CLT_amt = 0, RO_totObill_CLT = 0, RO_totObill_CLT_amt = 0;
    double RO_totbill_OST = 0, RO_totbill_OST_amt = 0, RO_totPbill_OST = 0, RO_totPbill_OST_amt = 0, RO_totTbill_OST = 0, RO_totTbill_OST_amt = 0, RO_totObill_OST = 0, RO_totObill_OST_amt = 0;

  
    private GridViewHelper helper;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

        dkt_call = Session["DocketCalledAs"].ToString();
        thc_call = Session["THCCalledAs"].ToString();

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
       
            dgDocket.PageIndex = e.NewPageIndex;
        

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

        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        Doc_type = Request.QueryString.Get("Rtyp");
        Rtyp = Request.QueryString.Get("Rtyp");
        string custcd = Request.QueryString.Get("St_custcd");
        // string st_vendcd = Request.QueryString.Get("st_vendcd");
        string st_orderlist = Request.QueryString.Get("st_orderlist");
        string st_asondt = "", st_asondtTo="";
        string[] st_asondt_Arr = Request.QueryString.Get("st_asondt").Split('/');
        string[] st_asondtTo_Arr = Request.QueryString.Get("st_asondtTo").Split('/');
        
        st_asondt = Convert.ToDateTime(st_asondt_Arr[1] + "/" + st_asondt_Arr[0] + "/" + st_asondt_Arr[2]).ToString("dd MMM yy");
        st_asondtTo = Convert.ToDateTime(st_asondtTo_Arr[1] + "/" + st_asondtTo_Arr[0] + "/" + st_asondtTo_Arr[2]).ToString("dd MMM yy");

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO;
        lblloc.Text = LO;
        lblcust.Text = custcd;
        //st_orderlist = "";
        //if (Doc_type.ToUpper() == "THC")
        //{
        //    custcd = st_vendcd;
        //    st_orderlist = Request.QueryString.Get("st_orderlist");
        //}

        //lblflow string custcd = "";

        if (custcd.ToString() == "")
        {
            custcd = "";

        }

        if (Rtyp == "L")
        {
            if (st_orderlist == "B")
            {
                lblflow.Text = "Location Wise :- Bill Outstanding";
            }
            else
            {
                lblflow.Text = "Location Wise :- MR Outstanding";
            }
        }
        else
        {
            if (st_orderlist == "B")
            {
                lblflow.Text = "Employee Wise :- Bill Outstanding";
            }
            else
            {
                lblflow.Text = "Employee Wise :- MR Outstanding";
            }
        }

        string docname = "",bl="", docname1 = "", docname3 = "", docname4 = "";
        if (st_orderlist == "B")
        {
            docname = "Bill";
            docname1 = "Freight Bill";
            docname3 = "Misc. Bill";
            docname4 = "Octroi Bill";
        }
        else
        {
            docname = "MR";
            docname1 = "Paid MR";
            docname3 = "Topay MR";
            docname4 = "Octroi MR";
        }

        string SQL_grid = "exec webx_outstd_bill_mr '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + custcd + "','" + st_orderlist + "','" + Rtyp + "','" + st_asondt + "','" + st_asondtTo + "'";

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);

        if (Rtyp == "C2")
        {
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

            DataSet ds = new DataSet();

            da.Fill(ds);


            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            // lblflow.Text = dkt_call;
            dgDocket.Visible = true;
        }
        else
        {

            SqlDataReader dr = sqlcmd12.ExecuteReader();



            TableRow tr1a = new TableRow();
            TableCell tr1atc1 = new TableCell();
            TableCell tr1atc2 = new TableCell();

            TableCell tr1atc3 = new TableCell();
            TableCell tr1atc4 = new TableCell();
            TableCell tr1atc5 = new TableCell();
            TableCell tr1atc6 = new TableCell();
            TableCell tr1atc7 = new TableCell();
            TableCell tr1atc8 = new TableCell();
            TableCell tr1atc9 = new TableCell();
            TableCell tr1atc10 = new TableCell();
            TableCell tr1atc11 = new TableCell();
            TableCell tr1atc12 = new TableCell();

            TableCell tr1atc13 = new TableCell();
            TableCell tr1atc14 = new TableCell();
            TableCell tr1atc15 = new TableCell();
            TableCell tr1atc16 = new TableCell();
            TableCell tr1atc17 = new TableCell();
            TableCell tr1atc18 = new TableCell();
            TableCell tr1atc19 = new TableCell();
            TableCell tr1atc20 = new TableCell();
            TableCell tr1atc21 = new TableCell();
            TableCell tr1atc22 = new TableCell();

            TableCell tr1atc23 = new TableCell();
            TableCell tr1atc24 = new TableCell();
            TableCell tr1atc25 = new TableCell();
            TableCell tr1atc26 = new TableCell();
            TableCell tr1atc27 = new TableCell();
            TableCell tr1atc28 = new TableCell();
            TableCell tr1atc29 = new TableCell();
            TableCell tr1atc30 = new TableCell();
            TableCell tr1atc31 = new TableCell();
            TableCell tr1atc32 = new TableCell();

            TableCell tr1atc33 = new TableCell();
            TableCell tr1atc34 = new TableCell();
            TableCell tr1atc35 = new TableCell();
            TableCell tr1atc36 = new TableCell();
            TableCell tr1atc37 = new TableCell();
            TableCell tr1atc38 = new TableCell();
            TableCell tr1atc39 = new TableCell();
            TableCell tr1atc40 = new TableCell();
            TableCell tr1atc41 = new TableCell();
            TableCell tr1atc42 = new TableCell();

            tr1atc1.Text = "Sr No.";
            tr1atc1.CssClass = "blackboldfnt";
            tr1atc1.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc1);

            if (Rtyp == "L")
            {
                tr1atc2.Text = "Location";
            }
            else
            {
                tr1atc2.Text = "Customer";
            }

            tr1atc2.CssClass = "blackboldfnt";
            tr1atc2.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc2);

            tr1atc3.Text = "Total " + docname + "<br> " + bl + " Generated";
            tr1atc3.CssClass = "blackboldfnt";
            tr1atc3.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc3);

            tr1atc4.Text = "Amount";
            tr1atc4.CssClass = "blackboldfnt";
            tr1atc4.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc4);

            tr1atc5.Text = docname + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + st_asondt;
            tr1atc5.CssClass = "blackboldfnt";
            tr1atc5.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc5);

            tr1atc6.Text = "Amount";
            tr1atc6.CssClass = "blackboldfnt";
            tr1atc6.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc6);

            tr1atc7.Text = docname + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + st_asondt;
            tr1atc7.CssClass = "blackboldfnt";
            tr1atc7.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc7);

            tr1atc8.Text = "Amount";
            tr1atc8.CssClass = "blackboldfnt";
            tr1atc8.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc8);

            tr1atc9.Text = docname + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + bl + "Today";
            tr1atc9.CssClass = "blackboldfnt";
            tr1atc9.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc9);

            tr1atc10.Text = "Amount";
            tr1atc10.CssClass = "blackboldfnt";
            tr1atc10.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc10);

            tr1atc11.Text = docname + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + bl + "Today";
            tr1atc11.CssClass = "blackboldfnt";
            tr1atc11.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc11);

            tr1atc12.Text = "Amount";
            tr1atc12.CssClass = "blackboldfnt";
            tr1atc12.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc12);

            tr1atc3.Text = "Total " + docname + "<br> " + bl + " Generated";
            tr1atc3.CssClass = "blackboldfnt";
            tr1atc3.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc3);

            tr1atc4.Text = "Amount";
            tr1atc4.CssClass = "blackboldfnt";
            tr1atc4.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc4);

            tr1atc5.Text = docname + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + st_asondt;
            tr1atc5.CssClass = "blackboldfnt";
            tr1atc5.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc5);

            tr1atc6.Text = "Amount";
            tr1atc6.CssClass = "blackboldfnt";
            tr1atc6.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc6);

            tr1atc7.Text = docname + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + st_asondt;
            tr1atc7.CssClass = "blackboldfnt";
            tr1atc7.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc7);

            tr1atc8.Text = "Amount";
            tr1atc8.CssClass = "blackboldfnt";
            tr1atc8.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc8);

            tr1atc9.Text = docname + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + bl + "Today";
            tr1atc9.CssClass = "blackboldfnt";
            tr1atc9.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc9);

            tr1atc10.Text = "Amount";
            tr1atc10.CssClass = "blackboldfnt";
            tr1atc10.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc10);

            tr1atc11.Text = docname + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + bl + "Today";
            tr1atc11.CssClass = "blackboldfnt";
            tr1atc11.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc11);

            tr1atc12.Text = "Amount";
            tr1atc12.CssClass = "blackboldfnt";
            tr1atc12.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc12);

            tr1atc13.Text = "Total " + docname1 + "<br> " + bl + " Generated";
            tr1atc13.CssClass = "blackboldfnt";
            tr1atc13.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc13);

            tr1atc14.Text = "Amount";
            tr1atc14.CssClass = "blackboldfnt";
            tr1atc14.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc14);

            tr1atc15.Text = docname1 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + st_asondt;
            tr1atc15.CssClass = "blackboldfnt";
            tr1atc15.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc15);

            tr1atc16.Text = "Amount";
            tr1atc16.CssClass = "blackboldfnt";
            tr1atc16.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc16);

            tr1atc17.Text = docname1 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + st_asondt;
            tr1atc17.CssClass = "blackboldfnt";
            tr1atc17.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc17);

            tr1atc18.Text = "Amount";
            tr1atc18.CssClass = "blackboldfnt";
            tr1atc18.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc18);

            tr1atc19.Text = docname1 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + bl + "Today";
            tr1atc19.CssClass = "blackboldfnt";
            tr1atc19.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc19);

            tr1atc20.Text = "Amount";
            tr1atc20.CssClass = "blackboldfnt";
            tr1atc20.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc20);

            tr1atc21.Text = docname1 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + bl + "Today";
            tr1atc21.CssClass = "blackboldfnt";
            tr1atc21.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc21);

            tr1atc22.Text = "Amount";
            tr1atc22.CssClass = "blackboldfnt";
            tr1atc22.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc22);


            tr1atc23.Text = "Total " + docname3 + "<br> " + bl + " Generated";
            tr1atc23.CssClass = "blackboldfnt";
            tr1atc23.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc23);

            tr1atc24.Text = "Amount";
            tr1atc24.CssClass = "blackboldfnt";
            tr1atc24.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc24);

            tr1atc25.Text = docname3 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + st_asondt;
            tr1atc25.CssClass = "blackboldfnt";
            tr1atc25.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc25);

            tr1atc26.Text = "Amount";
            tr1atc26.CssClass = "blackboldfnt";
            tr1atc26.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc26);

            tr1atc27.Text = docname3 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + st_asondt;
            tr1atc27.CssClass = "blackboldfnt";
            tr1atc27.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc27);

            tr1atc28.Text = "Amount";
            tr1atc28.CssClass = "blackboldfnt";
            tr1atc28.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc28);

            tr1atc29.Text = docname3 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + bl + "Today";
            tr1atc29.CssClass = "blackboldfnt";
            tr1atc29.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc29);

            tr1atc30.Text = "Amount";
            tr1atc30.CssClass = "blackboldfnt";
            tr1atc30.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc30);

            tr1atc31.Text = docname3 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + bl + "Today";
            tr1atc31.CssClass = "blackboldfnt";
            tr1atc31.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc31);

            tr1atc32.Text = "Amount";
            tr1atc32.CssClass = "blackboldfnt";
            tr1atc32.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc32);

            tr1atc33.Text = "Total " + docname4 + "<br> " + bl + " Generated";
            tr1atc33.CssClass = "blackboldfnt";
            tr1atc33.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc33);

            tr1atc34.Text = "Amount";
            tr1atc34.CssClass = "blackboldfnt";
            tr1atc34.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc34);

            tr1atc35.Text = docname4 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + st_asondt;
            tr1atc35.CssClass = "blackboldfnt";
            tr1atc35.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc35);

            tr1atc36.Text = "Amount";
            tr1atc36.CssClass = "blackboldfnt";
            tr1atc36.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc36);

            tr1atc37.Text = docname4 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + st_asondt;
            tr1atc37.CssClass = "blackboldfnt";
            tr1atc37.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc37);

            tr1atc38.Text = "Amount";
            tr1atc38.CssClass = "blackboldfnt";
            tr1atc38.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc38);

            tr1atc39.Text = docname4 + "  Close " + bl + "<br> " + bl + "As On " + bl + "<br> " + bl + "Today";
            tr1atc39.CssClass = "blackboldfnt";
            tr1atc39.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc39);

            tr1atc40.Text = "Amount";
            tr1atc40.CssClass = "blackboldfnt";
            tr1atc40.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc40);

            tr1atc41.Text = docname4 + "  Outstanding " + bl + "<br> " + bl + " As On " + bl + "<br> " + bl + "Today";
            tr1atc41.CssClass = "blackboldfnt";
            tr1atc41.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc41);

            tr1atc42.Text = "Amount";
            tr1atc42.CssClass = "blackboldfnt";
            tr1atc42.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1a.Cells.Add(tr1atc42);

            tr1a.HorizontalAlign = HorizontalAlign.Center;
            TBL_MonthlySales.Rows.Add(tr1a);
            //dgDocket.DataSource = ds;
            //dgDocket.DataBind();
            //dgDocket.Visible = true;
            int i = 1;
            string CRo = "", PrevRO = "";
            while (dr.Read())
            {

                CRo = dr["report_loc"].ToString();
                if (CRo != PrevRO && PrevRO != "")
                {
                    TableRow tr2aa = new TableRow();
                    TableCell tr2aatc1 = new TableCell();
                    TableCell tr2aatc2 = new TableCell();
                    TableCell tr2aatc3 = new TableCell();
                    TableCell tr2aatc4 = new TableCell();
                    TableCell tr2aatc5 = new TableCell();
                    TableCell tr2aatc6 = new TableCell();
                    TableCell tr2aatc7 = new TableCell();
                    TableCell tr2aatc8 = new TableCell();
                    TableCell tr2aatc9 = new TableCell();
                    TableCell tr2aatc10 = new TableCell();

                    TableCell tr2aatc11 = new TableCell();
                    TableCell tr2aatc12 = new TableCell();
                    TableCell tr2aatc13 = new TableCell();
                    TableCell tr2aatc14 = new TableCell();
                    TableCell tr2aatc15 = new TableCell();
                    TableCell tr2aatc16 = new TableCell();
                    TableCell tr2aatc17 = new TableCell();
                    TableCell tr2aatc18 = new TableCell();
                    TableCell tr2aatc19 = new TableCell();
                    TableCell tr2aatc20 = new TableCell();

                    TableCell tr2aatc21 = new TableCell();
                    TableCell tr2aatc22 = new TableCell();
                    TableCell tr2aatc23 = new TableCell();
                    TableCell tr2aatc24 = new TableCell();
                    TableCell tr2aatc25 = new TableCell();
                    TableCell tr2aatc26 = new TableCell();
                    TableCell tr2aatc27 = new TableCell();
                    TableCell tr2aatc28 = new TableCell();
                    TableCell tr2aatc29 = new TableCell();
                    TableCell tr2aatc30 = new TableCell();

                    TableCell tr2aatc31 = new TableCell();
                    TableCell tr2aatc32 = new TableCell();
                    TableCell tr2aatc33 = new TableCell();
                    TableCell tr2aatc34 = new TableCell();
                    TableCell tr2aatc35 = new TableCell();
                    TableCell tr2aatc36 = new TableCell();
                    TableCell tr2aatc37 = new TableCell();
                    TableCell tr2aatc38 = new TableCell();
                    TableCell tr2aatc39 = new TableCell();
                    TableCell tr2aatc40 = new TableCell();

                    TableCell tr2aatc41 = new TableCell();
                    TableCell tr2aatc42 = new TableCell();

                    //tr2aatc1.Text = i.ToString();
                    //tr2aatc1.CssClass = "blackfnt";
                    //tr2aatc1.Wrap = false;
                    //tr2aa.CssClass = "blackfnt";
                    //tr2aa.Cells.Add(tr2aatc1);

                    tr2aatc2.Text = strro_val;
                    tr2aatc2.CssClass = "blackfnt";
                    tr2aatc2.Wrap = false;
                    tr2aatc2.HorizontalAlign = HorizontalAlign.Center;
                    tr2aatc2.ColumnSpan = 2;
                    tr2aatc2.Font.Bold = true;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc2);

                    tr2aatc3.Text = RO_totbill.ToString();
                    tr2aatc3.CssClass = "blackfnt";
                    tr2aatc3.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc3);

                    tr2aatc4.Text = RO_totbill_amt.ToString("F2");
                    tr2aatc4.CssClass = "blackfnt";
                    tr2aatc4.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc4);

                    tr2aatc5.Text = RO_totbill_CL.ToString();
                    tr2aatc5.CssClass = "blackfnt";
                    tr2aatc5.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc5);

                    tr2aatc6.Text = RO_totbill_CL_amt.ToString("F2");
                    tr2aatc6.CssClass = "blackfnt";
                    tr2aatc6.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc6);

                    tr2aatc7.Text = RO_totbill_OS.ToString();
                    tr2aatc7.CssClass = "blackfnt";
                    tr2aatc7.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc7);

                    tr2aatc8.Text = RO_totbill_OS_amt.ToString("F2");
                    tr2aatc8.CssClass = "blackfnt";
                    tr2aatc8.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc8);

                    tr2aatc9.Text = RO_totbill_CLT.ToString();
                    tr2aatc9.CssClass = "blackfnt";
                    tr2aatc9.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc9);

                    tr2aatc10.Text = RO_totbill_CLT_amt.ToString("F2");
                    tr2aatc10.CssClass = "blackfnt";
                    tr2aatc10.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc10);

                    tr2aatc11.Text = RO_totbill_OST.ToString();
                    tr2aatc11.CssClass = "blackfnt";
                    tr2aatc11.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc11);

                    tr2aatc12.Text = RO_totbill_OST_amt.ToString("F2");
                    tr2aatc12.CssClass = "blackfnt";
                    tr2aatc12.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc12);

                    tr2aatc13.Text = RO_totPbill.ToString();
                    tr2aatc13.CssClass = "blackfnt";
                    tr2aatc13.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc13);

                    tr2aatc14.Text = RO_totPbill_amt.ToString("F2");
                    tr2aatc14.CssClass = "blackfnt";
                    tr2aatc14.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc14);

                    tr2aatc15.Text = RO_totPbill_CL.ToString();
                    tr2aatc15.CssClass = "blackfnt";
                    tr2aatc15.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc15);

                    tr2aatc16.Text = RO_totPbill_CL_amt.ToString("F2");
                    tr2aatc16.CssClass = "blackfnt";
                    tr2aatc16.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc16);

                    tr2aatc17.Text = RO_totPbill_OS.ToString();
                    tr2aatc17.CssClass = "blackfnt";
                    tr2aatc17.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc17);

                    tr2aatc18.Text = RO_totPbill_OS_amt.ToString("F2");
                    tr2aatc18.CssClass = "blackfnt";
                    tr2aatc18.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc18);

                    tr2aatc19.Text = RO_totPbill_CLT.ToString();
                    tr2aatc19.CssClass = "blackfnt";
                    tr2aatc19.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc19);

                    tr2aatc20.Text = RO_totPbill_CLT_amt.ToString("F2");
                    tr2aatc20.CssClass = "blackfnt";
                    tr2aatc20.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc20);

                    tr2aatc21.Text = RO_totPbill_OST.ToString();
                    tr2aatc21.CssClass = "blackfnt";
                    tr2aatc21.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc21);

                    tr2aatc22.Text = RO_totPbill_OST_amt.ToString("F2");
                    tr2aatc22.CssClass = "blackfnt";
                    tr2aatc22.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc22);

                    tr2aatc23.Text = RO_totTbill.ToString();
                    tr2aatc23.CssClass = "blackfnt";
                    tr2aatc23.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc23);

                    tr2aatc24.Text = RO_totTbill_amt.ToString("F2");
                    tr2aatc24.CssClass = "blackfnt";
                    tr2aatc24.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc24);

                    tr2aatc25.Text = RO_totTbill_CL.ToString();
                    tr2aatc25.CssClass = "blackfnt";
                    tr2aatc25.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc25);

                    tr2aatc26.Text = RO_totTbill_CL_amt.ToString("F2");
                    tr2aatc26.CssClass = "blackfnt";
                    tr2aatc26.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc26);

                    tr2aatc27.Text = RO_totTbill_OS.ToString();
                    tr2aatc27.CssClass = "blackfnt";
                    tr2aatc27.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc27);

                    tr2aatc28.Text = RO_totTbill_OS_amt.ToString("F2");
                    tr2aatc28.CssClass = "blackfnt";
                    tr2aatc28.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc28);

                    tr2aatc29.Text = RO_totTbill_CLT.ToString();
                    tr2aatc29.CssClass = "blackfnt";
                    tr2aatc29.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc29);

                    tr2aatc30.Text = RO_totTbill_CLT_amt.ToString("F2");
                    tr2aatc30.CssClass = "blackfnt";
                    tr2aatc30.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc30);

                    tr2aatc31.Text = RO_totTbill_OST.ToString();
                    tr2aatc31.CssClass = "blackfnt";
                    tr2aatc31.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc31);

                    tr2aatc32.Text = RO_totTbill_OST_amt.ToString("F2");
                    tr2aatc32.CssClass = "blackfnt";
                    tr2aatc32.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc32);


                    tr2aatc33.Text = RO_totObill.ToString();
                    tr2aatc33.CssClass = "blackfnt";
                    tr2aatc33.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc33);

                    tr2aatc34.Text = RO_totObill_amt.ToString("F2");
                    tr2aatc34.CssClass = "blackfnt";
                    tr2aatc34.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc34);

                    tr2aatc35.Text = RO_totObill_CL.ToString();
                    tr2aatc35.CssClass = "blackfnt";
                    tr2aatc35.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc35);

                    tr2aatc36.Text = RO_totObill_CL_amt.ToString("F2");
                    tr2aatc36.CssClass = "blackfnt";
                    tr2aatc36.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc36);

                    tr2aatc37.Text = RO_totObill_OS.ToString();
                    tr2aatc37.CssClass = "blackfnt";
                    tr2aatc37.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc37);

                    tr2aatc38.Text = RO_totObill_OS_amt.ToString("F2");
                    tr2aatc38.CssClass = "blackfnt";
                    tr2aatc38.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc38);

                    tr2aatc39.Text = RO_totObill_CLT.ToString();
                    tr2aatc39.CssClass = "blackfnt";
                    tr2aatc39.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc39);

                    tr2aatc40.Text = RO_totObill_CLT_amt.ToString("F2");
                    tr2aatc40.CssClass = "blackfnt";
                    tr2aatc40.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc40);

                    tr2aatc41.Text = RO_totObill_OST.ToString();
                    tr2aatc41.CssClass = "blackfnt";
                    tr2aatc41.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc41);

                    tr2aatc42.Text = RO_totObill_OST_amt.ToString("F2");
                    tr2aatc42.CssClass = "blackfnt";
                    tr2aatc42.Wrap = false;
                    tr2aa.CssClass = "blackfnt";
                    tr2aa.Cells.Add(tr2aatc42);
                    tr2aa.CssClass = "bluefnt";

                    tr2aa.BackColor = System.Drawing.Color.White;
                    tr2aa.HorizontalAlign = HorizontalAlign.Center;
                    TBL_MonthlySales.Rows.Add(tr2aa);



                    RO_totbill = 0;
                    RO_totbill_amt = 0;
                    RO_totPbill = 0;
                    RO_totPbill_amt = 0;
                    RO_totTbill = 0;
                    RO_totTbill_amt = 0;
                    RO_totObill = 0;
                    RO_totObill_amt = 0;
                    RO_totbill_CL = 0;
                    RO_totbill_CL_amt = 0;
                    RO_totPbill_CL = 0;
                    RO_totPbill_CL_amt = 0;
                    RO_totTbill_CL = 0;
                    RO_totTbill_CL_amt = 0;
                    RO_totObill_CL = 0;
                    RO_totObill_CL_amt = 0;
                    RO_totbill_OS = 0;
                    RO_totbill_OS_amt = 0;
                    RO_totPbill_OS = 0;
                    RO_totPbill_OS_amt = 0;
                    RO_totTbill_OS = 0;
                    RO_totTbill_OS_amt = 0;
                    RO_totObill_OS = 0;
                    RO_totObill_OS_amt = 0;
                    RO_totbill_CLT = 0;
                    RO_totbill_CLT_amt = 0;
                    RO_totPbill_CLT = 0;
                    RO_totPbill_CLT_amt = 0;
                    RO_totTbill_CLT = 0;
                    RO_totTbill_CLT_amt = 0;
                    RO_totObill_CLT = 0;
                    RO_totObill_CLT_amt = 0;
                    RO_totbill_OST = 0;
                    RO_totbill_OST_amt = 0;
                    RO_totPbill_OST = 0;
                    RO_totPbill_OST_amt = 0;
                    RO_totTbill_OST = 0;
                    RO_totTbill_OST_amt = 0;
                    RO_totObill_OST = 0;
                    RO_totObill_OST_amt = 0;

                }



                TableRow tr2a = new TableRow();
                TableCell tr2atc1 = new TableCell();
                TableCell tr2atc2 = new TableCell();
                TableCell tr2atc3 = new TableCell();
                TableCell tr2atc4 = new TableCell();
                TableCell tr2atc5 = new TableCell();
                TableCell tr2atc6 = new TableCell();
                TableCell tr2atc7 = new TableCell();
                TableCell tr2atc8 = new TableCell();
                TableCell tr2atc9 = new TableCell();
                TableCell tr2atc10 = new TableCell();

                TableCell tr2atc11 = new TableCell();
                TableCell tr2atc12 = new TableCell();
                TableCell tr2atc13 = new TableCell();
                TableCell tr2atc14 = new TableCell();
                TableCell tr2atc15 = new TableCell();
                TableCell tr2atc16 = new TableCell();
                TableCell tr2atc17 = new TableCell();
                TableCell tr2atc18 = new TableCell();
                TableCell tr2atc19 = new TableCell();
                TableCell tr2atc20 = new TableCell();

                TableCell tr2atc21 = new TableCell();
                TableCell tr2atc22 = new TableCell();
                TableCell tr2atc23 = new TableCell();
                TableCell tr2atc24 = new TableCell();
                TableCell tr2atc25 = new TableCell();
                TableCell tr2atc26 = new TableCell();
                TableCell tr2atc27 = new TableCell();
                TableCell tr2atc28 = new TableCell();
                TableCell tr2atc29 = new TableCell();
                TableCell tr2atc30 = new TableCell();

                TableCell tr2atc31 = new TableCell();
                TableCell tr2atc32 = new TableCell();
                TableCell tr2atc33 = new TableCell();
                TableCell tr2atc34 = new TableCell();
                TableCell tr2atc35 = new TableCell();
                TableCell tr2atc36 = new TableCell();
                TableCell tr2atc37 = new TableCell();
                TableCell tr2atc38 = new TableCell();
                TableCell tr2atc39 = new TableCell();
                TableCell tr2atc40 = new TableCell();

                TableCell tr2atc41 = new TableCell();
                TableCell tr2atc42 = new TableCell();

                tr2atc1.Text = i.ToString();
                tr2atc1.CssClass = "blackfnt";
                tr2atc1.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc1);

                tr2atc2.Text = dr["loccode"].ToString() + " : " + dr["locname"].ToString();
                tr2atc2.CssClass = "blackfnt";
                tr2atc2.Wrap = false;
                tr2atc2.HorizontalAlign = HorizontalAlign.Left;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc2);

                string rptno = "", dirlldown = "";
                rptno = "1";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc3.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["doc"].ToString() + "</u></a>";
                tr2atc3.CssClass = "blackfnt";
                tr2atc3.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc3);

                tr2atc4.Text = dr["doc_amt"].ToString();
                tr2atc4.CssClass = "blackfnt";
                tr2atc4.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc4);

                rptno = "2";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc5.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["doc_close"].ToString() + "</u></a>";
                tr2atc5.CssClass = "blackfnt";
                tr2atc5.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc5);

                tr2atc6.Text = dr["doc_close_amt"].ToString();
                tr2atc6.CssClass = "blackfnt";
                tr2atc6.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc6);

                rptno = "3";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc7.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["doc_Outstd"].ToString() + "</u></a>";
                tr2atc7.CssClass = "blackfnt";
                tr2atc7.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc7);

                tr2atc8.Text = dr["doc_Outstd_amt"].ToString();
                tr2atc8.CssClass = "blackfnt";
                tr2atc8.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc8);

                rptno = "4";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc9.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["doc_today"].ToString() + "</u></a>";
                tr2atc9.CssClass = "blackfnt";
                tr2atc9.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc9);

                tr2atc10.Text = dr["doc_today_amt"].ToString();
                tr2atc10.CssClass = "blackfnt";
                tr2atc10.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc10);

                rptno = "5";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc11.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["doc_Outstd_today"].ToString() + "</u></a>";
                tr2atc11.CssClass = "blackfnt";
                tr2atc11.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc11);

                tr2atc12.Text = dr["doc_Outstd_today_amt"].ToString();
                tr2atc12.CssClass = "blackfnt";
                tr2atc12.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc12);

                rptno = "6";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc13.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["paid_tbb_doc"].ToString() + "</u></a>";
                tr2atc13.CssClass = "blackfnt";
                tr2atc13.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc13);

                tr2atc14.Text = dr["paid_tbb_doc_amt"].ToString();
                tr2atc14.CssClass = "blackfnt";
                tr2atc14.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc14);

                rptno = "7";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc15.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["paid_tbb_doc_close"].ToString() + "</u></a>";
                tr2atc15.CssClass = "blackfnt";
                tr2atc15.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc15);

                tr2atc16.Text = dr["paid_tbb_doc_close_amt"].ToString();
                tr2atc16.CssClass = "blackfnt";
                tr2atc16.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc16);

                rptno = "8";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc17.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["paid_tbb_doc_Outstd"].ToString() + "</u></a>";
                tr2atc17.CssClass = "blackfnt";
                tr2atc17.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc17);

                tr2atc18.Text = dr["paid_tbb_doc_Outstd_amt"].ToString();
                tr2atc18.CssClass = "blackfnt";
                tr2atc18.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc18);

                rptno = "9";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc19.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["paid_tbb_doc_today"].ToString() + "</u></a>";
                tr2atc19.CssClass = "blackfnt";
                tr2atc19.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc19);

                tr2atc20.Text = dr["paid_tbb_doc_today_amt"].ToString();
                tr2atc20.CssClass = "blackfnt";
                tr2atc20.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc20);

                rptno = "10";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;


                tr2atc21.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["paid_tbb_doc_Outstd_today"].ToString() + "</u></a>";
                tr2atc21.CssClass = "blackfnt";
                tr2atc21.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc21);


                tr2atc22.Text = dr["paid_tbb_doc_Outstd_today_amt"].ToString();
                tr2atc22.CssClass = "blackfnt";
                tr2atc22.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc22);

                rptno = "11";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc23.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["topay_mis_doc"].ToString() + "</u></a>";
                tr2atc23.CssClass = "blackfnt";
                tr2atc23.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc23);

                tr2atc24.Text = dr["topay_mis_doc_amt"].ToString();
                tr2atc24.CssClass = "blackfnt";
                tr2atc24.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc24);

                rptno = "12";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc25.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["topay_mis_doc_close"].ToString() + "</u></a>";
                tr2atc25.CssClass = "blackfnt";
                tr2atc25.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc25);

                tr2atc26.Text = dr["topay_mis_doc_close_amt"].ToString();
                tr2atc26.CssClass = "blackfnt";
                tr2atc26.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc26);

                rptno = "13";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc27.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["topay_mis_doc_Outstd"].ToString() + "</u></a>";
                tr2atc27.CssClass = "blackfnt";
                tr2atc27.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc27);

                tr2atc28.Text = dr["topay_mis_doc_Outstd_amt"].ToString();
                tr2atc28.CssClass = "blackfnt";
                tr2atc28.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc28);

                rptno = "14";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc29.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["topay_mis_doc_today"].ToString() + "</u></a>";
                tr2atc29.CssClass = "blackfnt";
                tr2atc29.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc29);

                tr2atc30.Text = dr["topay_mis_doc_today_amt"].ToString();
                tr2atc30.CssClass = "blackfnt";
                tr2atc30.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc30);

                rptno = "15";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc31.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["topay_mis_doc_Outstd_today"].ToString() + "</u></a>";
                tr2atc31.CssClass = "blackfnt";
                tr2atc31.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc31);


                tr2atc32.Text = dr["topay_mis_doc_Outstd_today_amt"].ToString();
                tr2atc32.CssClass = "blackfnt";
                tr2atc32.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc32);

                rptno = "16";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc33.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["oct_doc"].ToString() + "</u></a>";
                tr2atc33.CssClass = "blackfnt";
                tr2atc33.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc33);

                tr2atc34.Text = dr["oct_doc_amt"].ToString();
                tr2atc34.CssClass = "blackfnt";
                tr2atc34.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc34);

                rptno = "17";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc35.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["oct_doc_close"].ToString() + "</u></a>";
                tr2atc35.CssClass = "blackfnt";
                tr2atc35.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc35);

                tr2atc36.Text = dr["oct_doc_close_amt"].ToString();
                tr2atc36.CssClass = "blackfnt";
                tr2atc36.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc36);

                rptno = "18";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc37.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["oct_doc_Outstd"].ToString() + "</u></a>";
                tr2atc37.CssClass = "blackfnt";
                tr2atc37.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc37);

                tr2atc38.Text = dr["oct_doc_Outstd_amt"].ToString();
                tr2atc38.CssClass = "blackfnt";
                tr2atc38.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc38);

                rptno = "19";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc39.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["oct_doc_today"].ToString() + "</u></a>";
                tr2atc39.CssClass = "blackfnt";
                tr2atc39.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc39);

                tr2atc40.Text = dr["oct_doc_today_amt"].ToString();
                tr2atc40.CssClass = "blackfnt";
                tr2atc40.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc40);

                rptno = "20";
                dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&custcd=" + custcd + "&RPT_SUBTY=" + st_orderlist + "&RPT_no=" + rptno + "&asondt=" + st_asondt + "&RPT_TY=" + Rtyp;

                tr2atc41.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["oct_doc_Outstd_today"].ToString() + "</u></a>";
                tr2atc41.CssClass = "blackfnt";
                tr2atc41.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc41);

                tr2atc42.Text = dr["oct_doc_Outstd_today_amt"].ToString();
                tr2atc42.CssClass = "blackfnt";
                tr2atc42.Wrap = false;
                tr2a.CssClass = "blackfnt";
                tr2a.Cells.Add(tr2atc42);

                tr2a.BackColor = System.Drawing.Color.White;
                tr2a.HorizontalAlign = HorizontalAlign.Center;
                TBL_MonthlySales.Rows.Add(tr2a);

                i = i + 1;

                // totdkts = totdkts + Convert.ToDouble(dr["doc_Outstd_today_amt"].ToString());

                RO_totbill += Convert.ToDouble(dr["doc"].ToString());
                RO_totbill_amt += Convert.ToDouble(dr["doc_amt"].ToString());
                RO_totPbill += Convert.ToDouble(dr["paid_tbb_doc"].ToString());
                RO_totPbill_amt += Convert.ToDouble(dr["paid_tbb_doc_amt"].ToString());
                RO_totTbill += Convert.ToDouble(dr["topay_mis_doc"].ToString());
                RO_totTbill_amt += Convert.ToDouble(dr["topay_mis_doc_amt"].ToString());
                RO_totObill += Convert.ToDouble(dr["oct_doc"].ToString());
                RO_totObill_amt += Convert.ToDouble(dr["oct_doc_amt"].ToString());

                RO_totbill_CL += Convert.ToDouble(dr["doc_close"].ToString());
                RO_totbill_CL_amt += Convert.ToDouble(dr["doc_close_amt"].ToString());
                RO_totPbill_CL += Convert.ToDouble(dr["paid_tbb_doc_close"].ToString());
                RO_totPbill_CL_amt += Convert.ToDouble(dr["paid_tbb_doc_close_amt"].ToString());
                RO_totTbill_CL += Convert.ToDouble(dr["topay_mis_doc_close"].ToString());
                RO_totTbill_CL_amt += Convert.ToDouble(dr["topay_mis_doc_close_amt"].ToString());
                RO_totObill_CL += Convert.ToDouble(dr["oct_doc_close"].ToString());
                RO_totObill_CL_amt += Convert.ToDouble(dr["oct_doc_Outstd_today_amt"].ToString());

                RO_totbill_OS += Convert.ToDouble(dr["doc_Outstd"].ToString());
                RO_totbill_OS_amt += Convert.ToDouble(dr["doc_Outstd_amt"].ToString());
                RO_totPbill_OS += Convert.ToDouble(dr["paid_tbb_doc_Outstd"].ToString());
                RO_totPbill_OS_amt += Convert.ToDouble(dr["paid_tbb_doc_Outstd_amt"].ToString());
                RO_totTbill_OS += Convert.ToDouble(dr["topay_mis_doc_Outstd"].ToString());
                RO_totTbill_OS_amt += Convert.ToDouble(dr["topay_mis_doc_Outstd_amt"].ToString());
                RO_totObill_OS += Convert.ToDouble(dr["oct_doc_Outstd"].ToString());
                RO_totObill_OS_amt += Convert.ToDouble(dr["oct_doc_Outstd_amt"].ToString());

                RO_totbill_CLT += Convert.ToDouble(dr["doc_today"].ToString());
                RO_totbill_CLT_amt += Convert.ToDouble(dr["doc_today_amt"].ToString());
                RO_totPbill_CLT += Convert.ToDouble(dr["paid_tbb_doc_today"].ToString());
                RO_totPbill_CLT_amt += Convert.ToDouble(dr["paid_tbb_doc_today_amt"].ToString());
                RO_totTbill_CLT += Convert.ToDouble(dr["topay_mis_doc_today"].ToString());
                RO_totTbill_CLT_amt += Convert.ToDouble(dr["topay_mis_doc_today_amt"].ToString());
                RO_totObill_CLT += Convert.ToDouble(dr["oct_doc_today"].ToString());
                RO_totObill_CLT_amt += Convert.ToDouble(dr["oct_doc_today_amt"].ToString());

                RO_totbill_OST += Convert.ToDouble(dr["doc_Outstd_today"].ToString());
                RO_totbill_OST_amt += Convert.ToDouble(dr["doc_Outstd_today_amt"].ToString());
                RO_totPbill_OST += Convert.ToDouble(dr["paid_tbb_doc_Outstd_today"].ToString());
                RO_totPbill_OST_amt += Convert.ToDouble(dr["paid_tbb_doc_Outstd_today_amt"].ToString());
                RO_totTbill_OST += Convert.ToDouble(dr["topay_mis_doc_Outstd_today"].ToString());
                RO_totTbill_OST_amt += Convert.ToDouble(dr["topay_mis_doc_Outstd_today_amt"].ToString());
                RO_totObill_OST += Convert.ToDouble(dr["oct_doc_Outstd_today"].ToString());
                RO_totObill_OST_amt += Convert.ToDouble(dr["oct_doc_Outstd_today_amt"].ToString());


                totbill += Convert.ToDouble(dr["doc"].ToString());
                totbill_amt += Convert.ToDouble(dr["doc_amt"].ToString());
                totPbill += Convert.ToDouble(dr["paid_tbb_doc"].ToString());
                totPbill_amt += Convert.ToDouble(dr["paid_tbb_doc_amt"].ToString());
                totTbill += Convert.ToDouble(dr["topay_mis_doc"].ToString());
                totTbill_amt += Convert.ToDouble(dr["topay_mis_doc_amt"].ToString());
                totObill += Convert.ToDouble(dr["oct_doc"].ToString());
                totObill_amt += Convert.ToDouble(dr["oct_doc_amt"].ToString());

                totbill_CL += Convert.ToDouble(dr["doc_close"].ToString());
                totbill_CL_amt += Convert.ToDouble(dr["doc_close_amt"].ToString());
                totPbill_CL += Convert.ToDouble(dr["paid_tbb_doc_close"].ToString());
                totPbill_CL_amt += Convert.ToDouble(dr["paid_tbb_doc_close_amt"].ToString());
                totTbill_CL += Convert.ToDouble(dr["topay_mis_doc_close"].ToString());
                totTbill_CL_amt += Convert.ToDouble(dr["topay_mis_doc_close_amt"].ToString());
                totObill_CL += Convert.ToDouble(dr["oct_doc_close"].ToString());
                totObill_CL_amt += Convert.ToDouble(dr["oct_doc_Outstd_today_amt"].ToString());

                totbill_OS += Convert.ToDouble(dr["doc_Outstd"].ToString());
                totbill_OS_amt += Convert.ToDouble(dr["doc_Outstd_amt"].ToString());
                totPbill_OS += Convert.ToDouble(dr["paid_tbb_doc_Outstd"].ToString());
                totPbill_OS_amt += Convert.ToDouble(dr["paid_tbb_doc_Outstd_amt"].ToString());
                totTbill_OS += Convert.ToDouble(dr["topay_mis_doc_Outstd"].ToString());
                totTbill_OS_amt += Convert.ToDouble(dr["topay_mis_doc_Outstd_amt"].ToString());
                totObill_OS += Convert.ToDouble(dr["oct_doc_Outstd"].ToString());
                totObill_OS_amt += Convert.ToDouble(dr["oct_doc_Outstd_amt"].ToString());

                totbill_CLT += Convert.ToDouble(dr["doc_today"].ToString());
                totbill_CLT_amt += Convert.ToDouble(dr["doc_today_amt"].ToString());
                totPbill_CLT += Convert.ToDouble(dr["paid_tbb_doc_today"].ToString());
                totPbill_CLT_amt += Convert.ToDouble(dr["paid_tbb_doc_today_amt"].ToString());
                totTbill_CLT += Convert.ToDouble(dr["topay_mis_doc_today"].ToString());
                totTbill_CLT_amt += Convert.ToDouble(dr["topay_mis_doc_today_amt"].ToString());
                totObill_CLT += Convert.ToDouble(dr["oct_doc_today"].ToString());
                totObill_CLT_amt += Convert.ToDouble(dr["oct_doc_today_amt"].ToString());

                totbill_OST += Convert.ToDouble(dr["doc_Outstd_today"].ToString());
                totbill_OST_amt += Convert.ToDouble(dr["doc_Outstd_today_amt"].ToString());
                totPbill_OST += Convert.ToDouble(dr["paid_tbb_doc_Outstd_today"].ToString());
                totPbill_OST_amt += Convert.ToDouble(dr["paid_tbb_doc_Outstd_today_amt"].ToString());
                totTbill_OST += Convert.ToDouble(dr["topay_mis_doc_Outstd_today"].ToString());
                totTbill_OST_amt += Convert.ToDouble(dr["topay_mis_doc_Outstd_today_amt"].ToString());
                totObill_OST += Convert.ToDouble(dr["oct_doc_Outstd_today"].ToString());
                totObill_OST_amt += Convert.ToDouble(dr["oct_doc_Outstd_today_amt"].ToString());

                // RO_totdkts = RO_totdkts + Convert.ToDouble(dr["doc_Outstd_today_amt"].ToString());


                PrevRO = dr["report_loc"].ToString();
                strro_val = dr["report_name"].ToString();
            }

            conn.Close();

            TableRow tr2ab = new TableRow();
            TableCell tr2abtc1 = new TableCell();
            TableCell tr2abtc2 = new TableCell();
            TableCell tr2abtc3 = new TableCell();
            TableCell tr2abtc4 = new TableCell();
            TableCell tr2abtc5 = new TableCell();
            TableCell tr2abtc6 = new TableCell();
            TableCell tr2abtc7 = new TableCell();
            TableCell tr2abtc8 = new TableCell();
            TableCell tr2abtc9 = new TableCell();
            TableCell tr2abtc10 = new TableCell();

            TableCell tr2abtc11 = new TableCell();
            TableCell tr2abtc12 = new TableCell();
            TableCell tr2abtc13 = new TableCell();
            TableCell tr2abtc14 = new TableCell();
            TableCell tr2abtc15 = new TableCell();
            TableCell tr2abtc16 = new TableCell();
            TableCell tr2abtc17 = new TableCell();
            TableCell tr2abtc18 = new TableCell();
            TableCell tr2abtc19 = new TableCell();
            TableCell tr2abtc20 = new TableCell();

            TableCell tr2abtc21 = new TableCell();
            TableCell tr2abtc22 = new TableCell();
            TableCell tr2abtc23 = new TableCell();
            TableCell tr2abtc24 = new TableCell();
            TableCell tr2abtc25 = new TableCell();
            TableCell tr2abtc26 = new TableCell();
            TableCell tr2abtc27 = new TableCell();
            TableCell tr2abtc28 = new TableCell();
            TableCell tr2abtc29 = new TableCell();
            TableCell tr2abtc30 = new TableCell();

            TableCell tr2abtc31 = new TableCell();
            TableCell tr2abtc32 = new TableCell();
            TableCell tr2abtc33 = new TableCell();
            TableCell tr2abtc34 = new TableCell();
            TableCell tr2abtc35 = new TableCell();
            TableCell tr2abtc36 = new TableCell();
            TableCell tr2abtc37 = new TableCell();
            TableCell tr2abtc38 = new TableCell();
            TableCell tr2abtc39 = new TableCell();
            TableCell tr2abtc40 = new TableCell();

            TableCell tr2abtc41 = new TableCell();
            TableCell tr2abtc42 = new TableCell();

            //tr2abtc1.Text = i.ToString();
            //tr2abtc1.CssClass = "blackfnt";
            //tr2abtc1.Wrap = false;
            //tr2ab.CssClass = "blackfnt";
            //tr2ab.Cells.Add(tr2abtc1);

            tr2abtc2.Text = strro_val;
            tr2abtc2.CssClass = "blackfnt";
            tr2abtc2.Wrap = false;
            tr2abtc2.HorizontalAlign = HorizontalAlign.Center;
            tr2abtc2.ColumnSpan = 2;
            tr2abtc2.Font.Bold = true;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc2);

            tr2abtc3.Text = RO_totbill.ToString();
            tr2abtc3.CssClass = "blackfnt";
            tr2abtc3.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc3);

            tr2abtc4.Text = RO_totbill_amt.ToString("F2");
            tr2abtc4.CssClass = "blackfnt";
            tr2abtc4.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc4);

            tr2abtc5.Text = RO_totbill_CL.ToString();
            tr2abtc5.CssClass = "blackfnt";
            tr2abtc5.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc5);

            tr2abtc6.Text = RO_totbill_CL_amt.ToString("F2");
            tr2abtc6.CssClass = "blackfnt";
            tr2abtc6.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc6);

            tr2abtc7.Text = RO_totbill_OS.ToString();
            tr2abtc7.CssClass = "blackfnt";
            tr2abtc7.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc7);

            tr2abtc8.Text = RO_totbill_OS_amt.ToString("F2");
            tr2abtc8.CssClass = "blackfnt";
            tr2abtc8.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc8);

            tr2abtc9.Text = RO_totbill_CLT.ToString();
            tr2abtc9.CssClass = "blackfnt";
            tr2abtc9.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc9);

            tr2abtc10.Text = RO_totbill_CLT_amt.ToString("F2");
            tr2abtc10.CssClass = "blackfnt";
            tr2abtc10.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc10);

            tr2abtc11.Text = RO_totbill_OST.ToString();
            tr2abtc11.CssClass = "blackfnt";
            tr2abtc11.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc11);

            tr2abtc12.Text = RO_totbill_OST_amt.ToString("F2");
            tr2abtc12.CssClass = "blackfnt";
            tr2abtc12.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc12);

            tr2abtc13.Text = RO_totPbill.ToString();
            tr2abtc13.CssClass = "blackfnt";
            tr2abtc13.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc13);

            tr2abtc14.Text = RO_totPbill_amt.ToString("F2");
            tr2abtc14.CssClass = "blackfnt";
            tr2abtc14.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc14);

            tr2abtc15.Text = RO_totPbill_CL.ToString();
            tr2abtc15.CssClass = "blackfnt";
            tr2abtc15.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc15);

            tr2abtc16.Text = RO_totPbill_CL_amt.ToString("F2");
            tr2abtc16.CssClass = "blackfnt";
            tr2abtc16.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc16);

            tr2abtc17.Text = RO_totPbill_OS.ToString();
            tr2abtc17.CssClass = "blackfnt";
            tr2abtc17.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc17);

            tr2abtc18.Text = RO_totPbill_OS_amt.ToString("F2");
            tr2abtc18.CssClass = "blackfnt";
            tr2abtc18.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc18);

            tr2abtc19.Text = RO_totPbill_CLT.ToString();
            tr2abtc19.CssClass = "blackfnt";
            tr2abtc19.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc19);

            tr2abtc20.Text = RO_totPbill_CLT_amt.ToString("F2");
            tr2abtc20.CssClass = "blackfnt";
            tr2abtc20.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc20);

            tr2abtc21.Text = RO_totPbill_OST.ToString();
            tr2abtc21.CssClass = "blackfnt";
            tr2abtc21.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc21);

            tr2abtc22.Text = RO_totPbill_OST_amt.ToString("F2");
            tr2abtc22.CssClass = "blackfnt";
            tr2abtc22.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc22);

            tr2abtc23.Text = RO_totTbill.ToString();
            tr2abtc23.CssClass = "blackfnt";
            tr2abtc23.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc23);

            tr2abtc24.Text = RO_totTbill_amt.ToString("F2");
            tr2abtc24.CssClass = "blackfnt";
            tr2abtc24.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc24);

            tr2abtc25.Text = RO_totTbill_CL.ToString();
            tr2abtc25.CssClass = "blackfnt";
            tr2abtc25.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc25);

            tr2abtc26.Text = RO_totTbill_CL_amt.ToString("F2");
            tr2abtc26.CssClass = "blackfnt";
            tr2abtc26.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc26);

            tr2abtc27.Text = RO_totTbill_OS.ToString();
            tr2abtc27.CssClass = "blackfnt";
            tr2abtc27.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc27);

            tr2abtc28.Text = RO_totTbill_OS_amt.ToString("F2");
            tr2abtc28.CssClass = "blackfnt";
            tr2abtc28.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc28);

            tr2abtc29.Text = RO_totTbill_CLT.ToString();
            tr2abtc29.CssClass = "blackfnt";
            tr2abtc29.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc29);

            tr2abtc30.Text = RO_totTbill_CLT_amt.ToString("F2");
            tr2abtc30.CssClass = "blackfnt";
            tr2abtc30.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc30);

            tr2abtc31.Text = RO_totTbill_OST.ToString();
            tr2abtc31.CssClass = "blackfnt";
            tr2abtc31.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc31);

            tr2abtc32.Text = RO_totTbill_OST_amt.ToString("F2");
            tr2abtc32.CssClass = "blackfnt";
            tr2abtc32.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc32);


            tr2abtc33.Text = RO_totObill.ToString();
            tr2abtc33.CssClass = "blackfnt";
            tr2abtc33.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc33);

            tr2abtc34.Text = RO_totObill_amt.ToString("F2");
            tr2abtc34.CssClass = "blackfnt";
            tr2abtc34.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc34);

            tr2abtc35.Text = RO_totObill_CL.ToString();
            tr2abtc35.CssClass = "blackfnt";
            tr2abtc35.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc35);

            tr2abtc36.Text = RO_totObill_CL_amt.ToString("F2");
            tr2abtc36.CssClass = "blackfnt";
            tr2abtc36.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc36);

            tr2abtc37.Text = RO_totObill_OS.ToString();
            tr2abtc37.CssClass = "blackfnt";
            tr2abtc37.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc37);

            tr2abtc38.Text = RO_totObill_OS_amt.ToString("F2");
            tr2abtc38.CssClass = "blackfnt";
            tr2abtc38.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc38);

            tr2abtc39.Text = RO_totObill_CLT.ToString();
            tr2abtc39.CssClass = "blackfnt";
            tr2abtc39.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc39);

            tr2abtc40.Text = RO_totObill_CLT_amt.ToString("F2");
            tr2abtc40.CssClass = "blackfnt";
            tr2abtc40.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc40);

            tr2abtc41.Text = RO_totObill_OST.ToString();
            tr2abtc41.CssClass = "blackfnt";
            tr2abtc41.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc41);

            tr2abtc42.Text = RO_totObill_OST_amt.ToString("F2");
            tr2abtc42.CssClass = "blackfnt";
            tr2abtc42.Wrap = false;
            tr2ab.CssClass = "blackfnt";
            tr2ab.Cells.Add(tr2abtc42);
            tr2ab.CssClass = "bluefnt";

            tr2ab.BackColor = System.Drawing.Color.White;
            tr2ab.HorizontalAlign = HorizontalAlign.Center;
            TBL_MonthlySales.Rows.Add(tr2ab);


            TableRow tr2ac = new TableRow();
            TableCell tr2actc1 = new TableCell();
            TableCell tr2actc2 = new TableCell();
            TableCell tr2actc3 = new TableCell();
            TableCell tr2actc4 = new TableCell();
            TableCell tr2actc5 = new TableCell();
            TableCell tr2actc6 = new TableCell();
            TableCell tr2actc7 = new TableCell();
            TableCell tr2actc8 = new TableCell();
            TableCell tr2actc9 = new TableCell();
            TableCell tr2actc10 = new TableCell();

            TableCell tr2actc11 = new TableCell();
            TableCell tr2actc12 = new TableCell();
            TableCell tr2actc13 = new TableCell();
            TableCell tr2actc14 = new TableCell();
            TableCell tr2actc15 = new TableCell();
            TableCell tr2actc16 = new TableCell();
            TableCell tr2actc17 = new TableCell();
            TableCell tr2actc18 = new TableCell();
            TableCell tr2actc19 = new TableCell();
            TableCell tr2actc20 = new TableCell();

            TableCell tr2actc21 = new TableCell();
            TableCell tr2actc22 = new TableCell();
            TableCell tr2actc23 = new TableCell();
            TableCell tr2actc24 = new TableCell();
            TableCell tr2actc25 = new TableCell();
            TableCell tr2actc26 = new TableCell();
            TableCell tr2actc27 = new TableCell();
            TableCell tr2actc28 = new TableCell();
            TableCell tr2actc29 = new TableCell();
            TableCell tr2actc30 = new TableCell();

            TableCell tr2actc31 = new TableCell();
            TableCell tr2actc32 = new TableCell();
            TableCell tr2actc33 = new TableCell();
            TableCell tr2actc34 = new TableCell();
            TableCell tr2actc35 = new TableCell();
            TableCell tr2actc36 = new TableCell();
            TableCell tr2actc37 = new TableCell();
            TableCell tr2actc38 = new TableCell();
            TableCell tr2actc39 = new TableCell();
            TableCell tr2actc40 = new TableCell();

            TableCell tr2actc41 = new TableCell();
            TableCell tr2actc42 = new TableCell();

            //tr2actc1.Text = i.ToString();
            //tr2actc1.CssClass = "blackfnt";
            //tr2actc1.Wrap = false;
            //tr2ac.CssClass = "blackfnt";
            //tr2ac.Cells.Add(tr2actc1);

            tr2actc2.Text = "Total";
            //tr2actc2.CssClass = "blackfnt";
            tr2actc2.Wrap = false;
            tr2actc2.HorizontalAlign = HorizontalAlign.Center;
            tr2actc2.ColumnSpan = 2;
            tr2actc2.Font.Bold = true;
            //tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc2);

            tr2actc3.Text = totbill.ToString();
            //tr2actc3.CssClass = "blackfnt";
            tr2actc3.Wrap = false;
            //tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc3);

            tr2actc4.Text = totbill_amt.ToString("F2");
            //tr2actc4.CssClass = "blackfnt";
            tr2actc4.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc4);

            tr2actc5.Text = totbill_CL.ToString();
            // tr2actc5.CssClass = "blackfnt";
            tr2actc5.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc5);

            tr2actc6.Text = totbill_CL_amt.ToString("F2");
            //tr2actc6.CssClass = "blackfnt";
            tr2actc6.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc6);

            tr2actc7.Text = totbill_OS.ToString();
            //tr2actc7.CssClass = "blackfnt";
            tr2actc7.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc7);

            tr2actc8.Text = totbill_OS_amt.ToString("F2");
            // tr2actc8.CssClass = "blackfnt";
            tr2actc8.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc8);

            tr2actc9.Text = totbill_CLT.ToString();
            //tr2actc9.CssClass = "blackfnt";
            tr2actc9.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc9);

            tr2actc10.Text = totbill_CLT_amt.ToString("F2");
            //tr2actc10.CssClass = "blackfnt";
            tr2actc10.Wrap = false;
            //tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc10);

            tr2actc11.Text = totbill_OST.ToString();
            // tr2actc11.CssClass = "blackfnt";
            tr2actc11.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc11);

            tr2actc12.Text = totbill_OST_amt.ToString("F2");
            // tr2actc12.CssClass = "blackfnt";
            tr2actc12.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc12);

            tr2actc13.Text = totPbill.ToString();
            // tr2actc13.CssClass = "blackfnt";
            tr2actc13.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc13);

            tr2actc14.Text = totPbill_amt.ToString("F2");
            // tr2actc14.CssClass = "blackfnt";
            tr2actc14.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc14);

            tr2actc15.Text = totPbill_CL.ToString();
            // tr2actc15.CssClass = "blackfnt";
            tr2actc15.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc15);

            tr2actc16.Text = totPbill_CL_amt.ToString("F2");
            // tr2actc16.CssClass = "blackfnt";
            tr2actc16.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc16);

            tr2actc17.Text = totPbill_OS.ToString();
            // tr2actc17.CssClass = "blackfnt";
            tr2actc17.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc17);

            tr2actc18.Text = totPbill_OS_amt.ToString("F2");
            // tr2actc18.CssClass = "blackfnt";
            tr2actc18.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc18);

            tr2actc19.Text = totPbill_CLT.ToString();
            //tr2actc19.CssClass = "blackfnt";
            tr2actc19.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc19);

            tr2actc20.Text = totPbill_CLT_amt.ToString("F2");
            //tr2actc20.CssClass = "blackfnt";
            tr2actc20.Wrap = false;
            //tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc20);

            tr2actc21.Text = totPbill_OST.ToString();
            // tr2actc21.CssClass = "blackfnt";
            tr2actc21.Wrap = false;
            // tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc21);

            tr2actc22.Text = totPbill_OST_amt.ToString("F2");
            //  tr2actc22.CssClass = "blackfnt";
            tr2actc22.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc22);

            tr2actc23.Text = totTbill.ToString();
            //  tr2actc23.CssClass = "blackfnt";
            tr2actc23.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc23);

            tr2actc24.Text = totTbill_amt.ToString("F2");
            //   tr2actc24.CssClass = "blackfnt";
            tr2actc24.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc24);

            tr2actc25.Text = totTbill_CL.ToString();
            //   tr2actc25.CssClass = "blackfnt";
            tr2actc25.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc25);

            tr2actc26.Text = totTbill_CL_amt.ToString("F2");
            //  tr2actc26.CssClass = "blackfnt";
            tr2actc26.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc26);

            tr2actc27.Text = totTbill_OS.ToString();
            //  tr2actc27.CssClass = "blackfnt";
            tr2actc27.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc27);

            tr2actc28.Text = totTbill_OS_amt.ToString("F2");
            //  tr2actc28.CssClass = "blackfnt";
            tr2actc28.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc28);

            tr2actc29.Text = totTbill_CLT.ToString();
            //   tr2actc29.CssClass = "blackfnt";
            tr2actc29.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc29);

            tr2actc30.Text = totTbill_CLT_amt.ToString("F2");
            //   tr2actc30.CssClass = "blackfnt";
            tr2actc30.Wrap = false;
            //    tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc30);

            tr2actc31.Text = totTbill_OST.ToString();
            //  tr2actc31.CssClass = "blackfnt";
            tr2actc31.Wrap = false;
            //  tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc31);

            tr2actc32.Text = totTbill_OST_amt.ToString("F2");
            //   tr2actc32.CssClass = "blackfnt";
            tr2actc32.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc32);


            tr2actc33.Text = totObill.ToString();
            //    tr2actc33.CssClass = "blackfnt";
            tr2actc33.Wrap = false;
            //    tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc33);

            tr2actc34.Text = totObill_amt.ToString("F2");
            //   tr2actc34.CssClass = "blackfnt";
            tr2actc34.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc34);

            tr2actc35.Text = totObill_CL.ToString();
            //   tr2actc35.CssClass = "blackfnt";
            tr2actc35.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc35);

            tr2actc36.Text = totObill_CL_amt.ToString("F2");
            //   tr2actc36.CssClass = "blackfnt";
            tr2actc36.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc36);

            tr2actc37.Text = totObill_OS.ToString();
            //   tr2actc37.CssClass = "blackfnt";
            tr2actc37.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc37);

            tr2actc38.Text = totObill_OS_amt.ToString("F2");
            //   tr2actc38.CssClass = "blackfnt";
            tr2actc38.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc38);

            tr2actc39.Text = totObill_CLT.ToString();
            //  tr2actc39.CssClass = "blackfnt";
            tr2actc39.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc39);

            tr2actc40.Text = totObill_CLT_amt.ToString("F2");
            //    tr2actc40.CssClass = "blackfnt";
            tr2actc40.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc40);

            tr2actc41.Text = totObill_OST.ToString();
            //  tr2actc41.CssClass = "blackfnt";
            tr2actc41.Wrap = false;
            //   tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc41);

            tr2actc42.Text = totObill_OST_amt.ToString("F2");
            //  tr2actc42.CssClass = "blackfnt";
            tr2actc42.Wrap = false;
            tr2ac.CssClass = "blackfnt";
            tr2ac.Cells.Add(tr2actc42);
            tr2ac.CssClass = "bluefnt";
            tr2ac.Font.Bold = true;
            tr2ac.BackColor = System.Drawing.Color.White;
            tr2ac.HorizontalAlign = HorizontalAlign.Center;

            TBL_MonthlySales.Rows.Add(tr2ac);

        }

        conn.Close();

    }



    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{

    //    dgDocket.PageIndex = e.NewPageIndex;

    //    //   BindGrid();

    //}

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        //int ind = 0;
        //int a = 0;
        //try
        //{

        //    dgDocket.AllowPaging = false;
        //    dgDocket.BorderWidth = 1;


        //    Response.Clear();
        //    Response.AddHeader("Content-Disposition", "attachment;Filename=Booking_Register.xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.xls";
        //    System.IO.StringWriter tw = new System.IO.StringWriter();
        //    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //    BindGrid();

        //    dgDocket.RenderControl(hw);


        //    Response.Write(tw.ToString());
        //    Response.End();

        //}
        //catch (Exception ex1)
        //{
        //    throw ex1;
        //    // lblloc.Text = ex1.Message;
        //}

        //dgDocket.AllowPaging = false;
        //dgDocket.BorderWidth = 1;
        //dgDocket.CssClass = "blackfnt";
        //dgDocket.Font.Size = 8;
        ////GrdLoadUnload.Font.Names = verdana;
        //dgDocket.BackColor = System.Drawing.Color.White;
        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-xls";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //dgDocket.RenderControl(htmlWrite);

        ////frm.Controls.Add(GrdLoadUnload);
        ////frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();

        TBL_MonthlySales.BorderStyle = BorderStyle.Double;
        TBL_MonthlySales.BorderWidth = 1;
        TBL_MonthlySales.CellSpacing = 2;

        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 8;

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Work_Done.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //DipsplayReport();
        BindGrid();
        dgDocket.RenderControl(hw);
        TBL_MonthlySales.RenderControl(hw);
        //TBL_MonthlySales.BorderWidth = 1;
        Response.Write(tw.ToString());
        Response.End();


    }
}
