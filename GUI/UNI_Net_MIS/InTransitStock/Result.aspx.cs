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

public partial class GUI_UNI_Net_MIS_InTransitStock_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP = "", RTP_DT_str = "";
    string RO_EMP = "";
    double RO_LOGIN = 0;
    double TOTRO_LOGIN = 0;
    int ij = 1;
    string qs;
    string RO, LO, toRO, toLO, DateType, fromdt, todt, daysfrom, daysto, RPT;
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
        dkt_call = Session["DocketCalledAs"].ToString();
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        toRO = Request.QueryString["RO_to"].ToString();
        toLO = Request.QueryString["LO_to"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        daysfrom = Request.QueryString["daysfrom"].ToString();
        daysto = Request.QueryString["daysto"].ToString();
        RPT = Request.QueryString["RPT"].ToString();


        qs = "RO=[RO]&LO=[LO]&RO_to=[RO_to]&LO_to=[LO_to]&fromdt=[fromdt]&todt=[todt]&daysfrom=[daysfrom]&daysto=[daysto]&RPT=[RPT]";

        string dtFrom = fromdt;
        string dtTo = todt;

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;
        lblToRO.Text = toRO;
        lblToLoc.Text = toLO;


        string sql_st = "exec WebxNet_InTransit_Stock_ver1 '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + toRO + "','" + toLO + "','" + daysfrom + "','" + daysto + "','" + RPT + "'";
        //Response.Write(sql_st);
        //Response.End();
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        conn.Close();


    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;
        selection.Border = 1;
        selection.CellSpacing = 0;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=InTrasitStock.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(selection);
        frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    public bool isNumeric(string val, System.Globalization.NumberStyles NumberStyle)
    {
        Double result;
        return Double.TryParse(val, NumberStyle,
            System.Globalization.CultureInfo.CurrentCulture, out result);
    }


    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            for (int ih = 0; ih < e.Row.Cells.Count; ih++)
            {

                if (e.Row.Cells[ih].Text.ToString().Trim() == "FromLOC")
                    e.Row.Cells[ih].Text = "From Location";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "ToLOc")
                    e.Row.Cells[ih].Text = "To Location";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock")
                    e.Row.Cells[ih].Text = "Total Stock";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "actuwt")
                    e.Row.Cells[ih].Text = "Actu.Wt.";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "chrgwt")
                    e.Row.Cells[ih].Text = "Charg.Wt.";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "subtotal")
                    e.Row.Cells[ih].Text = "SubTotal";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "dkttot")
                    e.Row.Cells[ih].Text = "Amount";

                for (int id = 0; id < 5; id++)
                {
                    if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock_" + id.ToString())
                    {
                        e.Row.Cells[ih].Text = "InTransit Days " + id.ToString();
                        if (id == 4)
                            e.Row.Cells[ih].Text = "InTransit Days >" + (id - 1).ToString();
                    }

                    if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock_" + id.ToString() + "_actualwt")
                    {
                        e.Row.Cells[ih].Text = "Days " + id.ToString() + " Actu.Wt.";
                        if (id == 4)
                            e.Row.Cells[ih].Text = "Days >" + (id - 1).ToString() + " Actu.Wt.";
                    }

                    if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock_" + id.ToString() + "_chrgwt")
                    {
                        e.Row.Cells[ih].Text = "Days " + id.ToString() + " Charg.Wt.";
                        if (id == 4)
                            e.Row.Cells[ih].Text = "Days >" + (id - 1).ToString() + " Charg.Wt.";
                    }

                    if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock_" + id.ToString() + "_subtotal")
                    {
                        e.Row.Cells[ih].Text = "Days " + id.ToString() + " SubTotal";
                        if (id == 4)
                            e.Row.Cells[ih].Text = "Days >" + (id - 1).ToString() + " SubTotal";
                    }

                    if (e.Row.Cells[ih].Text.ToString().Trim() == "InTransitStock_" + id.ToString() + "_dkttotal")
                    {
                        e.Row.Cells[ih].Text = "Days " + id.ToString() + " Docket Total";
                        if (id == 4)
                            e.Row.Cells[ih].Text = "Days >" + (id - 1).ToString() + " Docket Total";
                    }


                }
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            for (int ic = 0; ic < e.Row.Cells.Count; ic++)
            {
                e.Row.Cells[0].Text = ij.ToString();
                if (isNumeric(e.Row.Cells[ic].Text.ToString(), System.Globalization.NumberStyles.Number) == true)
                {
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Right;
                }
                else
                {
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Left;
                }
                if (e.Row.Cells[3].Text.ToString() != "0")
                {
                    string[] LOa = e.Row.Cells[1].Text.ToString().Split(':');
                    string[] LO_Toa = e.Row.Cells[2].Text.ToString().Split(':');

                    string LOs = Convert.ToString(LOa[0]);
                    string LO_Tos = Convert.ToString(LO_Toa[0]);

                    if (LO_Tos != "ZZZ")
                    {
                        string viewTxt = "<a href='./Result_Detail.aspx?LO=" + LOs + "&LO_to=" + LO_Tos + "&FromDt=" + fromdt + "&ToDt=" + todt + "&daysFrom=" + daysfrom + "&daysTo=" + daysto + "&reportTYPE=" + RPT + "'>" + e.Row.Cells[3].Text + "</a>";
                        e.Row.Cells[3].Text = viewTxt;
                    }
                    else
                    {
                        e.Row.Cells[3].Text = e.Row.Cells[3].Text;
                    }
                    
                }
                else
                {
                    e.Row.Cells[3].Text = "0";
                }
                if (e.Row.Cells[2].Text.ToString() == "ZZZ")
                {
                    if (e.Row.Cells[1].Text == "ZZZ")
                        e.Row.Cells[1].Text = "Total";
                    else
                        e.Row.Cells[1].Text = "Total " + e.Row.Cells[1].Text.ToString();

                    e.Row.Cells[1].Wrap = false;

                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[0].Text = "";
                    e.Row.CssClass = "bluefnt";
                    e.Row.Font.Bold = true;

                    ij = 0;
                }
            }
            if (e.Row.Cells[0].Text == "0")
                e.Row.Cells[0].Text = "";
            e.Row.Cells[2].Wrap = false;

            ij += 1;
        }
    }
}
