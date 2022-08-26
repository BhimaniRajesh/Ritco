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

public partial class GUI_UNI_Net_MIS_Expected_Arrival_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP = "", RTP_DT_str = "";
    string RO_EMP = "";
    double RO_LOGIN = 0;
    double TOTRO_LOGIN = 0;
    int ij = 1;
    string RO, LO, toRO, toLO, fromdt, todt, daysfrom, daysto, RPT;
    string dateselection, MAxStr_VAL, MAxSTR_LV, MAxStr_VAL_to, MAxSTR_LV_to, DateType, Status;
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

        fromdt = Request.QueryString["dtFrom"].ToString();
        todt = Request.QueryString["dtTo"].ToString();
        MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
        MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
        MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
        MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();
        DateType = Request.QueryString["DTTYPE"].ToString();
        Status = Request.QueryString["Status"].ToString();

        if (Status == "")
        {
            Status = "ALL";
        }
        
        string dtFrom = fromdt;
        string dtTo = todt;

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;
        //exec WebxNet_Expexted_Arrival 'All','1','All','1','01 Dec 08','30 dec 08','1','1'
        string sql_st = "exec WebxNet_Expexted_Arrival '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + fromdt + "','" + todt + "','" + Status + "','" + DateType + "'";
        Response.Write(sql_st);
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
        //dgDocket.AllowPaging = false;
        //dgDocket.BorderWidth = 1;
        //dgDocket.CssClass = "blackfnt";
        //dgDocket.Font.Size = 10;
        //selection.Border = 1;
        //selection.CellSpacing = 0;

        //BindGrid();
        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=InTrasitStock.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-xls";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(selection);
        //frm.Controls.Add(dgDocket);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
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

                if (e.Row.Cells[ih].Text.ToString().Trim() == "THCno")
                    e.Row.Cells[ih].Text = "THC NO";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "THC_DT")
                    e.Row.Cells[ih].Text = "THC Date";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "thcbr")
                    e.Row.Cells[ih].Text = "Branch";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "sourcehb")
                    e.Row.Cells[ih].Text = "Origin";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "tobh_code")
                    e.Row.Cells[ih].Text = "Destination";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "Vehno")
                    e.Row.Cells[ih].Text = "Vehicle No";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "ROutenm")
                    e.Row.Cells[ih].Text = "Route";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "DKT")
                    e.Row.Cells[ih].Text = "Total Docket";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "LDWT")
                    e.Row.Cells[ih].Text = "Loaded Wt.";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "STATUS")
                    e.Row.Cells[ih].Text = "Status";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "ARRDT")
                    e.Row.Cells[ih].Text = "Arr Date";
                else if (e.Row.Cells[ih].Text.ToString().Trim() == "DeptDT")
                    e.Row.Cells[ih].Text = "Dept Date";
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            for (int ic = 0; ic < e.Row.Cells.Count; ic++)
            {

                if (isNumeric(e.Row.Cells[ic].Text.ToString(), System.Globalization.NumberStyles.Number) == true)
                {
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Right;
                }
                else
                {
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Left;
                }
            }
        }
        
    }
}
