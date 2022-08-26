using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Globalization;
using System.IO;

public partial class GUI_Cust_Tracking_Result : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    public static string strcust, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        BindGrid();
    }
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

      
      
       string RO = Request.QueryString.Get("RO");
       string LO = Request.QueryString.Get("LO");
       string RO_TO = Request.QueryString.Get("RO_TO");
       string LO_TO = Request.QueryString.Get("LO_TO");
       string DateType = Request.QueryString.Get("DateType");
       string fromdt = Request.QueryString.Get("fromdt");
       string todt = Request.QueryString.Get("todt");
       string st_Docnolist = Request.QueryString.Get("st_Docnolist");
       string St_Manualnolist = Request.QueryString.Get("St_Manualnolist");

       string st_Vehnolist = Request.QueryString.Get("st_Vehnolist");
       string st_Freetext = Request.QueryString.Get("st_Freetext");
       string st_doctyp = Request.QueryString.Get("st_doctyp");
       string str_doctyp = Request.QueryString.Get("str_doctyp");

       string strPaybas = Request.QueryString.Get("strPaybas");
       string str_Paybas = Request.QueryString.Get("str_Paybas");
       string strMode = Request.QueryString.Get("strMode");
       string str_Mode = Request.QueryString.Get("str_Mode");
       string strType = Request.QueryString.Get("strType");
       string str_Type = Request.QueryString.Get("str_Type");


       lblseldet.Text = fromdt + " - " + todt;
       lblro.Text = RO + " - " + RO_TO;
       lblloc.Text = LO + " - " + LO_TO;
       lblflow.Text = str_doctyp;
       lblCust.Text = Session["empcd"].ToString().Trim() + " : " + Session["empnm"].ToString().Trim();
       lblpaybas.Text = str_Paybas;
       lblMode.Text = str_Mode;
       lblTypem.Text = str_Type;
       string sql_st = "exec WebxNet_Customer_Tracking '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','" + Session["empcd"].ToString().Trim() + "','" + strPaybas + "','" + strMode + "','" + strType + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "'";
       //Response.Write("<br>sql_st : " + sql_st);
      
       SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
       //SqlDataReader dr = sqlcmd12.ExecuteReader();
       SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
      // DataSet ds = new DataSet();

       da.Fill(ds);

       dgDocket.DataSource = ds;
       dgDocket.DataBind();
       // lblflow.Text = dkt_call;
       dgDocket.Visible = true;
        conn.Close();

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
            dgDocket.PageIndex = e.NewPageIndex;
            BindGrid();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

            dkt_colname.Text = dkt_call + " No.";
            lblColDockdt.Text = dkt_call + " Date";
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dktst


            HiddenField dktst = (HiddenField)e.Row.FindControl("dktst");

            Table table = (Table)this.dgDocket.Controls[0];
            GridView oGridView = (GridView)sender;
            int realindex = table.Rows.GetRowIndex(e.Row);
            GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();

            oTableCell.Text = "Status : ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
            //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
            oTableCell.ColumnSpan = 3;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Right;
            oGridViewRow.Cells.Add(oTableCell);

            e.Row.BackColor = System.Drawing.Color.White;
            Label lbldockno = (Label)e.Row.FindControl("lbldockno");

            oTableCell = new TableCell();
            oTableCell.Text = dktst.Value.ToString();
            oTableCell.ColumnSpan = 7;
            
            oTableCell.CssClass = "bluefnt";
            oTableCell.Wrap = false;


            oTableCell.HorizontalAlign = HorizontalAlign.Left;
            oGridViewRow.Cells.Add(oTableCell);
            oGridViewRow.BackColor = System.Drawing.Color.White;
            table.Controls.AddAt(realindex + 1, oGridViewRow);
        }   
    }

   


    protected void btn_csv_Click(object sender, EventArgs e)
    {

        string final;
        final = "?RO=" + Request.QueryString.Get("RO"); 
        final += "&LO=" + Request.QueryString.Get("LO"); 
        final += "&RO_TO=" + Request.QueryString.Get("RO_TO"); 
        final += "&LO_TO=" + Request.QueryString.Get("LO_TO");
        final += "&DateType=" + Request.QueryString.Get("DateType");
        final += "&fromdt=" + Request.QueryString.Get("fromdt");
        final += "&todt=" + Request.QueryString.Get("todt");
        final += "&st_Docnolist=" + Request.QueryString.Get("st_Docnolist");
        final += "&St_Manualnolist=" + Request.QueryString.Get("St_Manualnolist");
        final += "&st_Vehnolist=" + Request.QueryString.Get("st_Vehnolist");
        final += "&st_Freetext=" + Request.QueryString.Get("st_Freetext");
        final += "&st_doctyp=" + Request.QueryString.Get("st_doctyp");
        final += "&str_doctyp=" + Request.QueryString.Get("str_doctyp");
        final += "&strPaybas=" + Request.QueryString.Get("strPaybas");
        final += "&str_Paybas=" + Request.QueryString.Get("str_Paybas");
        final += "&strMode=" + Request.QueryString.Get("strMode");
        final += "&str_Mode=" + Request.QueryString.Get("str_Mode");
        final += "&strType=" + Request.QueryString.Get("strType");
        final += "&str_Type=" + Request.QueryString.Get("str_Type");
       
            Response.Redirect("./Result_XLS.aspx" + final);

    }

   
}
