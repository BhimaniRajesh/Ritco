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
public partial class GUI_UNI_MIS_Account_Reports_Trail_bal_Result_GL : System.Web.UI.Page
{
    SqlConnection Conn;
    DataSet ds = new DataSet();
    public static string RO, LO,DWN_XLS, custcd, empcd, ACC_cd, Cumulative, vendcd, TYP_CD, RO_TO, LO_TO, Rtyp, View_Sales, DateType, st_paybasis, st_status, st_custcd, st_type, st_trnmod, fromdt, todt, st_Docnolist, select_list, select_Text, st_doctyp;
    public static string lv, RPT_flag, YearString, yearSuffix, finyearstart, strFinalQS = "", mHeadOfficeCode;
    public int i = 0;
    string title = "", title1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "1")
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

            tblGl.Border = 1;

            BindGrid();
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=Ledger.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);

           
            frm.Controls.Add(tblGl);
            frm.Controls.Add(dgDocket);


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


    protected void btn_csv_Click(object sender, EventArgs e)
    {
        XLS_DWN();
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim() +";TimeOut=1000;");
        
        Conn.Open();
        

        fromdt = Request.QueryString["dateFrom"].ToString();
        string Rtyp = Request.QueryString["Rtyp"].ToString();
        todt = Request.QueryString["dateTo"].ToString();
        TYP_CD = Request.QueryString["TYP_CD"].ToString();
        ACC_cd = Request.QueryString["ACCODE"].ToString();
        Cumulative = Request.QueryString["Cumlative"].ToString();
        RO = Request.QueryString["branch"].ToString();
        LBLDATE.Text = fromdt + " - " + todt;
        if (Cumulative == "Y")
        {
            LBLRPT.Text = "Cumulative (Including All Branches)";
        }
        else
        {
            LBLRPT.Text = "Individual";
        }
        LBLBRANCH.Text = RO;
        //LBLSUBRPT.Text = TYP_CD;

        if (ACC_cd != "All" || ACC_cd != "")
        {
            string SELACC = "exec WebxNet_Get_DocName '" + ACC_cd + "','A' ";
            SqlCommand cmd = new SqlCommand(SELACC, Conn);
            SqlDataReader dr = cmd.ExecuteReader();
            string STR_ACCD="";
            while (dr.Read())
            {
                if (STR_ACCD == "")
                    STR_ACCD = dr[0].ToString();
                else
                    STR_ACCD = STR_ACCD + "," + dr[0].ToString();

            }
            dr.Close();

            lblLdger.Text = STR_ACCD;

        }
        if (Rtyp != "1")
        {
            string SELACC1 = "exec WebxNet_Get_DocName '" + ACC_cd + "','A' ";
            if(Rtyp=="2")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','C' ";
            if (Rtyp == "3")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','V' ";
            if (Rtyp == "4")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','E' ";
            if (Rtyp == "5")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','D' ";
            SqlCommand cmd1 = new SqlCommand(SELACC1, Conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            string STR_ACCD1 = "";
            while (dr1.Read())
            {
                if (STR_ACCD1 == "")
                    STR_ACCD1 = dr1[0].ToString();
                else
                    STR_ACCD1 = STR_ACCD1 + "," + dr1[0].ToString();

            }
            dr1.Close();

            LBLSUBRPT.Text = STR_ACCD1;
        }



        YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        finyearstart = "01 APR " + YearString;
        yrstartdt = Convert.ToDateTime(finyearstart);
        mHeadOfficeCode = Session["HeadOfficeCode"].ToString();

        if (ACC_cd == "")
        {
            ACC_cd = "";
        }
        //lblLdger.Text = ACC_cd;
        SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        string SQL_TB = "";
        try
        {
            SQL_TB = "exec Webx_GG_Ledger '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + ACC_cd + "','" + TYP_CD + "','" + RO + "','" + Rtyp + "'";
           //Response.Write("<BR> SQL_TB : " + SQL_TB);
           // Response.End();
            Rtyp = "1";
            SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
            sqlcmd12.Transaction = trans;
            //SqlDataReader dr;
            //dr = sqlcmd12.ExecuteReader();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            
            da.Fill(ds);
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Visible = true;

            trans.Commit();

            Conn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                //abc = "Insert Susccessfully !!!!!!!";
            }
            Response.Write("<BR><BR> SQL_TB : " + SQL_TB);
            trans.Rollback();


            Conn.Close();
            Response.End();
        }
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            string RPT = Request.QueryString["Rtyp"].ToString();

            if (RPT == "2")
            {                
                e.Row.Cells[1].Text = "Customer ";
            }
            else if (RPT == "3")
            {
                e.Row.Cells[1].Text = "Vendor ";
            }
            else if (RPT == "4")
            {
                e.Row.Cells[1].Text = "Employee ";
            }
            else if (RPT == "5")
            {
                e.Row.Cells[1].Text = "Driver ";
            }
            else
            {
                e.Row.Cells[1].Visible = false;
            }
            
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string TYP_CD = Request.QueryString["TYP_CD"].ToString();
            string ACC_cd = Request.QueryString["ACCODE"].ToString();
            string RPT = Request.QueryString["Rtyp"].ToString();
            Label titleLabel = (Label)e.Row.FindControl("lblACC");
            string strval = ((Label)(titleLabel)).Text;

            title = (string)ViewState["lblACC"];
            if (title == strval && e.Row.RowIndex > 0)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["lblACC"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";

                //if (ACC_cd != "")
                //{
                //    if (lblLdger.Text == "")
                //    {
                //        lblLdger.Text = title;
                //    }
                //    else
                //    {
                //        lblLdger.Text = lblLdger.Text.ToString() + "," + title;
                //    }
                //}
                //else
                //{
                //    lblLdger.Text = "All";
                //}
            }

            if (RPT != "1")
            {
                e.Row.Cells[1].Visible = true;
                Label lblcust_vend = (Label)e.Row.FindControl("lblCust");
                string strval1 = ((Label)(lblcust_vend)).Text;
                title1 = (string)ViewState["lblCust"];
                if (title1 == strval1 && e.Row.RowIndex > 0)
                {
                    lblcust_vend.Visible = false;
                    lblcust_vend.Text = string.Empty;
                }
                else
                {
                    title1 = strval1;
                    ViewState["lblCust"] = title1;
                    //lblcust_vend.Visible = true;
                    //lblcust_vend.Text = "<b>" + title1 + "</b>";
                    //i = 0;
                    //if (TYP_CD != "")
                    //{
                    //    if (LBLSUBRPT.Text == "")
                    //    {
                    //        LBLSUBRPT.Text = title1;
                    //    }
                    //    else
                    //    {
                    //        LBLSUBRPT.Text = LBLSUBRPT.Text.ToString() + "," + title1;
                    //    }
                    //}
                    //else
                    //{
                    //    lblLdger.Text = "All";
                    //}
                }

               
            }
            else
            {
                e.Row.Cells[1].Visible = false;
            }

            if (e.Row.Cells[0].Text.ToString().Trim() == "Opening Balance :")
            {                              
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;               
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Total Transaction :")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Total for A/C (Dr./Cr.) :")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Closing Balance :")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else
            {
                i += 1;
                e.Row.Cells[0].Text = i.ToString();
                e.Row.Cells[0].Font.Bold = false;
            }

        }

    }
}

