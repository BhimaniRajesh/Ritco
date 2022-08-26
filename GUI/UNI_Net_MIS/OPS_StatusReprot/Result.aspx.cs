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
public partial class GUI_UNI_Net_MIS_OPS_StatusReprot_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public int TOTPg = 0, MaxPgsize = 0;
    public static string strcust, dkt_call;
    int ij = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        string DWN_XLS = "";
        if (!IsPostBack)
        {
            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "1")
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
        dkt_call = Session["DocketCalledAs"].ToString();
        string dtFrom = Request.QueryString["dtFrom"].ToString();
        string dtTo = Request.QueryString["dtTo"].ToString();
        string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
        string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

        string DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
       string st_status = Request.QueryString["st_status"].ToString();
        string str_status = Request.QueryString["str_status"].ToString();

        string st_status_sub = Request.QueryString["st_status_sub"].ToString();
        string str_status_sub = Request.QueryString["str_status_sub"].ToString();
        string strdays = Request.QueryString["strdays"].ToString();

        string PGNO = Request.QueryString["PGNO"].ToString();
        string PGSIZE = Request.QueryString["Psize"].ToString();   

        string DocketLsit = "", strcustcd = "";
        DocketLsit = Request.QueryString["DocketLsit"].ToString();
        strcustcd = Request.QueryString["strcustcd"].ToString();
        if (strcustcd == "")
            strcustcd = "All";
        if (DocketLsit == "")
            DocketLsit = "All";



        string st_paybasis = Request.QueryString["st_paybasis"].ToString();
        string st_trnmod = Request.QueryString["st_trnmod"].ToString();
        string st_type = Request.QueryString["st_type"].ToString();
        string st_busttype = Request.QueryString["st_busttype"].ToString();
        string str_paybasis = Request.QueryString["str_paybasis"].ToString();
        string str_trnmod = Request.QueryString["str_trnmod"].ToString();
        string str_busttype = Request.QueryString["str_busttype"].ToString();
        string str_type = Request.QueryString["str_type"].ToString();
        string DTTYPE = Request.QueryString["DTTYPE"].ToString();

        LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
        LBLBRANCH.Text = MAxStr_VAL;
        lblPaybasis.Text = str_paybasis;
        lblmode.Text = str_trnmod;
        lblBKGTYP.Text = str_type;
        Label1.Text = str_busttype;
        lblStatus.Text = str_status;

        if (st_status_sub!="All")
            lblStatus.Text = str_status +" - "+str_status_sub;
        if (strdays != "All" )
            lblStatus.Text = str_status + " - " + str_status_sub + " - " + strdays +" Days";


        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string sqlQuery1 = "exec WebxNet_OPSSTATUSREport '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + DTTYPE + "','1','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "','" + st_status + "','" + st_status_sub + "','" + strdays + "','0','100'";
        SqlCommand sqlcmd121 = new SqlCommand(sqlQuery1, Conn);
	sqlcmd121.CommandTimeout = 300;
        SqlDataReader dread = sqlcmd121.ExecuteReader();
        while (dread.Read())
        {
            TOTPg = Convert.ToInt32(dread.GetValue(2).ToString());
            MaxPgsize = Convert.ToInt32(dread.GetValue(0).ToString());
        }
        dread.Close();


        if (DWN_XLS == "1")
            PGSIZE = MaxPgsize.ToString();


        for (int i = 1; i < TOTPg + 1; i++)
        {
            PAging.Items.Add(new ListItem(i.ToString(), i.ToString()));

        }
        if (TOTPg == 0)
        {
            PAging.Items.Clear();
            PAging.DataTextField = PGNO.ToString();
            PAging.DataValueField = PGNO.ToString();
        }
        PAging.SelectedValue = PGNO.ToString();
        PAging.AutoPostBack = true;

        if (PAging.Items.Count == 1 || TOTPg == 0)
        {
            TRPG.Style["display"] = "none";
        }

        if (PGNO == "1")
        {
            imgPrev.Style["display"] = "none";
        }
        if (Convert.ToInt16(PGNO) > 1 || Convert.ToInt16(PGNO) == TOTPg)
        {
            imgNext.Style["display"] = "none";
        }


        string sqlQuery = "exec WebxNet_OPSSTATUSREport '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + DTTYPE + "','1','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "','" + st_status + "','" + st_status_sub + "','" + strdays + "'," + PGNO + "," + PGSIZE + "";
        //Response.Write("<br><br><br> abcd :   " + sqlQuery);
        SqlCommand sqlcmd12_PNL = new SqlCommand(sqlQuery, Conn);
        sqlcmd12_PNL.CommandTimeout = 300;
        // Response.Write("<BR> SQL_TB : " + SQL_PNL);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12_PNL);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GRVPNL.DataSource = ds;
        GRVPNL.DataBind();
        GRVPNL.Visible = true;
        Conn.Close();
    }
    public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;


            GRVPNL.AllowPaging = false;
            GRVPNL.BorderWidth = 1;
            GRVPNL.CssClass = "blackfnt";
            GRVPNL.Font.Size = 10;

            Cri.Border = 1;

            BindGrid();
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=OPS_Performance_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);


            frm.Controls.Add(Cri);
            frm.Controls.Add(GRVPNL);


            //frm.Controls.Add(dgDocket);
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
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname"); 
            dkt_colname.Text = dkt_call + " No.";           
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int PGNO = Convert.ToInt32(Request.QueryString["PGNO"]);
            int Psize = Convert.ToInt32(Request.QueryString["Psize"]);
            //if (e.Row.Cells[0].Text != "")
            e.Row.Cells[0].Text = (((PGNO - 1) * Psize) + ij).ToString();

            ij += 1;
        }
    }

    protected void PAging_SelectedIndexChanged(object sender, EventArgs e)
    {
        string final;
        final = "?st_paybasis=" + Request.QueryString["st_paybasis"].ToString();
        final += "&st_trnmod=" + Request.QueryString["st_trnmod"].ToString();
        final += "&st_type=" + Request.QueryString["st_type"].ToString();
        final += "&st_busttype=" + Request.QueryString["st_busttype"].ToString();
        final += "&str_paybasis=" + Request.QueryString["str_paybasis"].ToString();
        final += "&str_trnmod=" + Request.QueryString["str_trnmod"].ToString();
        final += "&str_type=" + Request.QueryString["str_type"].ToString();
        final += "&str_busttype=" + Request.QueryString["str_busttype"].ToString();
        final += "&dtFrom=" + Request.QueryString["dtfrom"].ToString();
        final += "&dtTo=" + Request.QueryString["dtTo"].ToString();
        final += "&MAxStr_VAL=" + Request.QueryString["MAxStr_VAL"].ToString();
        final += "&MAxSTR_LV=" + Request.QueryString["MAxSTR_LV"].ToString();
        final += "&DTTYPE=" + Request.QueryString["DTTYPE"].ToString();
        final += "&DTTYPE_str=" + Request.QueryString["DTTYPE_str"].ToString();
        final += "&strcustcd=" + Request.QueryString["strcustcd"].ToString();
        final += "&DocketLsit=" + Request.QueryString["DocketLsit"].ToString();
        final += "&st_status=" + Request.QueryString["st_status"].ToString();
        final += "&str_status=" + Request.QueryString["str_status"].ToString();
        final += "&st_status_sub=" + Request.QueryString["st_status_sub"].ToString();
        final += "&str_status_sub=" + Request.QueryString["str_status_sub"].ToString();
        final += "&strdays=" + Request.QueryString["strdays"].ToString();
         final += "&Psize=" + Request.QueryString["Psize"].ToString();
        final += "&PGNO=" + PAging.SelectedValue.ToString();
        final += "&DWN_XLS=0";

        Response.Redirect("Result.aspx" + final);
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        string final;
        final = "?st_paybasis=" + Request.QueryString["st_paybasis"].ToString();
        final += "&st_trnmod=" + Request.QueryString["st_trnmod"].ToString();
        final += "&st_type=" + Request.QueryString["st_type"].ToString();
        final += "&st_busttype=" + Request.QueryString["st_busttype"].ToString();
        final += "&str_paybasis=" + Request.QueryString["str_paybasis"].ToString();
        final += "&str_trnmod=" + Request.QueryString["str_trnmod"].ToString();
        final += "&str_type=" + Request.QueryString["str_type"].ToString();
        final += "&str_busttype=" + Request.QueryString["str_busttype"].ToString();
        final += "&dtFrom=" + Request.QueryString["dtfrom"].ToString();
        final += "&dtTo=" + Request.QueryString["dtTo"].ToString();
        final += "&MAxStr_VAL=" + Request.QueryString["MAxStr_VAL"].ToString();
        final += "&MAxSTR_LV=" + Request.QueryString["MAxSTR_LV"].ToString();
        final += "&DTTYPE=" + Request.QueryString["DTTYPE"].ToString();
        final += "&DTTYPE_str=" + Request.QueryString["DTTYPE_str"].ToString();
        final += "&strcustcd=" + Request.QueryString["strcustcd"].ToString();
        final += "&DocketLsit=" + Request.QueryString["DocketLsit"].ToString();
        final += "&st_status=" + Request.QueryString["st_status"].ToString();
        final += "&str_status=" + Request.QueryString["str_status"].ToString();
        final += "&st_status_sub=" + Request.QueryString["st_status_sub"].ToString();
        final += "&str_status_sub=" + Request.QueryString["str_status_sub"].ToString();
        final += "&strdays=" + Request.QueryString["strdays"].ToString();
        final += "&Psize=" + Request.QueryString["Psize"].ToString();
        final += "&PGNO=1";
        final += "&DWN_XLS=1";


        Response.Redirect("Result.aspx" + final);
    }
}
