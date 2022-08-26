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

public partial class GUI_UNI_MIS_Route_summary_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string DWN_XLS, Route, Vehno, Rtyp, fromdt, todt, RO, Vendor;
    protected void Page_Load(object sender, EventArgs e)
    {
        DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
        if (DWN_XLS == "1")
        {
            // Response.ContentType = "application/vnd.ms-excel";
            // Response.AddHeader("content-disposition", "attachment; filename=Trail_balance.xls");
            XLS_DWN();
            //BindGrid();
        }
        else if (DWN_XLS == "0")
        {
            BindGrid();
        }
        //else if (DWN_XLS == "2")
        //{
        //    CSV_DWN();
        //}
    }


     public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;
            //Cri.BorderWidth = 1;
            //Cri..CssClass = "blackfnt";
           // Cri.Font.Size = 10;
            if (Rtyp == "1")
            {
                dgROute.AllowPaging = false;
                dgROute.BorderWidth = 1;
                dgROute.CssClass = "blackfnt";
                dgROute.Font.Size = 10;
            }
            else if (Rtyp == "2")
            {
                dg_LOC.AllowPaging = false;
                dg_LOC.BorderWidth = 1;
                dg_LOC.CssClass = "blackfnt";
                dg_LOC.Font.Size = 10;

            }
            else if (Rtyp == "3")
            {
                dg_CUST.AllowPaging = false;
                dg_CUST.BorderWidth = 1;
                dg_CUST.CssClass = "blackfnt";
                dg_CUST.Font.Size = 10;

            }
                    

            BindGrid();
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=Route Summary.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(Cri);

            if (Rtyp == "1")
            {
                frm.Controls.Add(dgROute);
            }
            else if (Rtyp == "2")
            {
                frm.Controls.Add(dg_LOC);
            }
            else if (Rtyp == "3")
            {
                frm.Controls.Add(dg_CUST);
            }
            

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

    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        fromdt = Request.QueryString["dateFrom"].ToString();
        todt = Request.QueryString["dateTo"].ToString();

        Route = Request.QueryString["Route"].ToString();
        Vehno = Request.QueryString["Vehno"].ToString();
        Rtyp = Request.QueryString["Rtyp"].ToString();
        RO = Request.QueryString["Route"].ToString();
        Vendor = Request.QueryString["Vendor"].ToString();
        lblVendor.Text = Request.QueryString["Vendor"].ToString();
        if (Vendor == "All")
        {
            Vendor = "%%";
        }
         LBLDATE.Text = fromdt + " - " + todt;
         if (Rtyp == "1")
        {
            LBLRPT.Text = "Route Wise";
        }
        else if (Rtyp == "2")
        {
            LBLRPT.Text = "Location Wise";
        }
        else if (Rtyp == "3")
        {
            LBLRPT.Text = "Customer Wise";
        }
        LBLBRANCH.Text = RO;
        //LBLSUBRPT.Text = TYP_CD;
        string[] ARR_Route = Route.Split(':');
        SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        string SQL = "";
        try
        {
            SQL = "exec Webx_ROute_summary_Ver1 '" + fromdt + "','" + todt + "','" + ARR_Route[1].ToString().Trim() + "','%" + Vehno + "%','"+ Vendor +"','" + Rtyp + "'";
            //Response.Write("<BR> SQL_TB : " + SQL);
            //Rtyp = "1";
            SqlCommand sqlcmd12 = new SqlCommand(SQL, Conn);
            sqlcmd12.Transaction = trans;
            //SqlDataReader dr;
            //dr = sqlcmd12.ExecuteReader();
           
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (Rtyp == "1")
            {
                dgROute.DataSource = ds;
                dgROute.DataBind();
                dgROute.Visible = true;
            }
            else if (Rtyp == "2")
            {
                dg_LOC.DataSource = ds;
                dg_LOC.DataBind();
                dg_LOC.Visible = true;
            }
            else if (Rtyp == "3")
            {
                dg_CUST.DataSource = ds;
                dg_CUST.DataBind();
                dg_CUST.Visible = true;
            }

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
            Response.Write("<BR><BR> SQL_TB : " + SQL);
            trans.Rollback();


            Conn.Close();
            Response.End();
        }

    }

    protected void dgROute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[3].Text.ToString().Trim() == "")
            {
                e.Row.Cells[14].Font.Bold = true;
                e.Row.Cells[15].Font.Bold = true;
                e.Row.Cells[16].Font.Bold = true;
                e.Row.Cells[17].Font.Bold = true;
                e.Row.Cells[18].Font.Bold = true;
            }
            else
            {
                e.Row.Cells[14].Font.Bold = false;
                e.Row.Cells[15].Font.Bold = false;
                e.Row.Cells[16].Font.Bold = false;
                e.Row.Cells[17].Font.Bold = false;
                e.Row.Cells[18].Font.Bold = false;
            }
        }
       
    }

       
}
