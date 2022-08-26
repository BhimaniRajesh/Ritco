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
public partial class GUI_UNI_Net_MIS_User_Rights_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
        }

   }

    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        string Location = Request.QueryString["Location"].ToString();
        string Employee = Request.QueryString["Employee"].ToString();


        string SQL_PNL = "exec SUmmaryReport 'select loccode,Employee from VWNET_USERS_Module_rights  where loccode like ''%" + Location + "%'' and  userid like ''%" + Employee + "%''   group by loccode,Employee order by loccode,Employee','YN','Module','VWNET_USERS_Module_rights'  ";
        SqlCommand sqlcmd12_PNL = new SqlCommand(SQL_PNL, Conn);
       // Response.Write("<BR> SQL_TB : " + SQL_PNL);
        //Response.End();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12_PNL);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GRVUSRERight.DataSource = ds;
        GRVUSRERight.DataBind();
        GRVUSRERight.Visible = true;
        Conn.Close();
    }


   protected void btn_csv_Click(object sender, EventArgs e)
   {
       XLS_DWN();
   }
   public bool isNumeric(string val, System.Globalization.NumberStyles NumberStyle)
   {
       Double result;
       return Double.TryParse(val, NumberStyle,
           System.Globalization.CultureInfo.CurrentCulture, out result);
   }
   public void XLS_DWN()
   {
       int ind = 0;
       int a = 0;
       try
       {
           //GV_Booking.AllowPaging = false;

           // TBL_BS_Det.BorderStyle = BorderStyle.Double;
           // TBL_BS_Det.BorderWidth = 1;


           GRVUSRERight.AllowPaging = false;
           GRVUSRERight.BorderWidth = 1;
           //GRVUSRERight.CssClass = "blackfnt";
           GRVUSRERight.Font.Size = 10;

          // TBLPNL.Border = 1;

           BindGrid();
           StringWriter stringWrite;
           HtmlTextWriter htmlWrite;
           HtmlForm frm = new HtmlForm();
           Response.Clear();
           Response.AddHeader("content-disposition", "attachment;filename=PNL.xls");
           Response.Charset = "";
           Response.ContentType = "application/vnd.ms-xls";
           stringWrite = new System.IO.StringWriter();
           htmlWrite = new HtmlTextWriter(stringWrite);
           Controls.Add(frm);


          // frm.Controls.Add(TBLPNL);
           frm.Controls.Add(GRVUSRERight);


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
          int i = 0;
          if (e.Row.RowType == DataControlRowType.Header)
          {
              for (int ih = 0; ih < e.Row.Cells.Count; ih++)
              {
                  e.Row.Cells[ih].Wrap = false;

                  if (e.Row.Cells[ih].Text.Trim().ToString() == "Employee")
                      e.Row.Cells[ih].HorizontalAlign = HorizontalAlign.Left;
              }

          }

          if (e.Row.RowType == DataControlRowType.DataRow)
          {
              for (int ic = 0; ic < e.Row.Cells.Count; ic++)
              {
                  e.Row.Cells[ic].Wrap = false;
                  if (e.Row.Cells[ic].Text.ToString() == "1")
                      e.Row.Cells[ic].Text = "Yes";
                  else if (e.Row.Cells[ic].Text.ToString() == "0")
                      e.Row.Cells[ic].Text = "No";

              }

          }
    }

}
