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

public partial class GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_GL : System.Web.UI.Page
{
    public int i = 0;
    public int TOTPg = 0, MaxPgsize = 0;
    string title = "", title1 = "";
     DataSet ds = new DataSet();
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
            if (DWN_XLS == "1")
            {
                CSV_DWN();
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


          //  frm.Controls.Add(tblGl);
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
    public void CSV_DWN()
    {
    }
   
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        string final;
        final = "?branch=" + Request.QueryString["branch"].ToString();
        final += "&Rtyp=" + Request.QueryString["Rtyp"].ToString();
        final += "&dateFrom=" + Request.QueryString["dateFrom"].ToString();
        final += "&dateTo=" + Request.QueryString["dateTo"].ToString();
        final += "&Psize=" + Request.QueryString["Psize"].ToString();
        final += "&PGNO=" + PAging.SelectedValue.ToString();
        final += "&Cumlative=" + Request.QueryString["Cumlative"].ToString();
        final += "&TYP_CD=" + Request.QueryString["TYP_CD"].ToString();
        final += "&ACCODE=" + Request.QueryString["ACCODE"].ToString();
        final += "&DWN_XLS=1";

        Response.Redirect("Result_GL.aspx" + final);
    }
    public void BindGrid()
    {
      SqlConnection  Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim() + ";TimeOut=1000;");

        Conn.Open();
       string fromdt = Request.QueryString["dateFrom"].ToString();      
       string Rtyp = Request.QueryString["Rtyp"].ToString();
       string todt = Request.QueryString["dateTo"].ToString();
       string TYP_CD = Request.QueryString["TYP_CD"].ToString();
       string  ACC_cd = Request.QueryString["ACCODE"].ToString();
       string Cumulative = Request.QueryString["Cumlative"].ToString();
       string RO = Request.QueryString["branch"].ToString();
       string PGNO = Request.QueryString["PGNO"].ToString();
       string PGSIZE = Request.QueryString["Psize"].ToString();
       string DWN_XLS = Request.QueryString["DWN_XLS"].ToString();

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
           string STR_ACCD = "";
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
           if (Rtyp == "2")
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


       string YearString = Session["FinYear"].ToString().Substring(2, 2);
       string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
       if (CloseYear.Length == 1)
       {
           CloseYear = "0" + CloseYear;
       }
       DateTime yrstartdt;
       string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
       string finyearstart = "01 APR " + YearString;
        yrstartdt = Convert.ToDateTime(finyearstart);
       string mHeadOfficeCode = Session["HeadOfficeCode"].ToString();

       if (ACC_cd == "")
       {
           ACC_cd = "";
       }
       //lblLdger.Text = ACC_cd;

        
       string SQL_TB1 = "exec WebxNet_GeneralLedger '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + ACC_cd + "','" + TYP_CD + "','" + RO + "','0'," + PGNO + "," + PGSIZE + "";
     //Response.Write("<BR> SQL_TB1 : " + SQL_TB1);
     //Response.End();
       SqlCommand sqlcmd121 = new SqlCommand(SQL_TB1, Conn);
       // int TOTPg = Convert.ToInt16(sqlcmd121.ExecuteScalar());
       
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

        if (PGNO=="1")
        {
            imgPrev.Style["display"] = "none";
        }
        if (Convert.ToInt16(PGNO) > 1 || Convert.ToInt16(PGNO)==TOTPg)
        {
            imgNext.Style["display"] = "none";
        }

       string SQL_TB = "exec WebxNet_GeneralLedger '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + ACC_cd + "','" + TYP_CD + "','" + RO + "','" + Rtyp + "'," + PGNO + "," + PGSIZE + "";
       //Response.Write("<BR> SQL_TB : " + SQL_TB);
      // Response.End();
       SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
      
       //SqlDataReader dr;
       //dr = sqlcmd12.ExecuteReader();
       SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

       da.Fill(ds);
       dgDocket.DataSource = ds;
       dgDocket.DataBind();
       dgDocket.Visible = true;

       Conn.Close();
    }
    protected void PAging_SelectedIndexChanged(object sender, EventArgs e)
    {
        string final;
        final = "?branch=" + Request.QueryString["branch"].ToString();
        final += "&Rtyp=" + Request.QueryString["Rtyp"].ToString();
        final += "&dateFrom=" + Request.QueryString["dateFrom"].ToString();
        final += "&dateTo=" + Request.QueryString["dateTo"].ToString();
        final += "&Psize=" + Request.QueryString["Psize"].ToString();
        final += "&PGNO=" + PAging.SelectedValue.ToString();
        final += "&Cumlative=" + Request.QueryString["Cumlative"].ToString();
        final += "&TYP_CD=" + Request.QueryString["TYP_CD"].ToString();
        final += "&ACCODE=" + Request.QueryString["ACCODE"].ToString();
        final += "&DWN_XLS=0";

        Response.Redirect("Result_GL.aspx" + final);
    }
   
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.Header)
        {
            
           string Rtyp = Request.QueryString["Rtyp"].ToString();
         

            if (Rtyp == "2")
            {
                e.Row.Cells[1].Text = "Customer ";
            }
            else if (Rtyp == "3")
            {
                e.Row.Cells[1].Text = "Vendor ";
            }
            else if (Rtyp == "4")
            {
                e.Row.Cells[1].Text = "Employee ";
            }
            else if (Rtyp == "5")
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
                    lblcust_vend.Visible = true;
                    lblcust_vend.Text = "<b>" + title1 + "</b>";
                    i = 0;
                    
                }


            }
            else
            {
                e.Row.Cells[1].Visible = false;
            }

            if (e.Row.Cells[0].Text.ToString().Trim() == "000")
            {
                e.Row.Cells[0].Text = "Opening Balance : ";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "7777777")
            {
                e.Row.Cells[0].Text = "Total Transaction : ";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "8888888")
            {
                e.Row.Cells[0].Text = "Total for A/C (Dr./Cr.) : ";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "9999999")
            {
                e.Row.Cells[0].Text = "Closing Balance : ";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else
            {
                //i += 1;
              //  e.Row.Cells[0].Text = i.ToString();
                e.Row.Cells[0].Font.Bold = false;
            }

        }

    }



   
}
