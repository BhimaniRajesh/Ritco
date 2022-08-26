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

public partial class GUI_Tracking_New_Webxsite_DocketTrack : System.Web.UI.Page
{

    DataSet ds = new DataSet();
    public static string strcust, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        imgLogo.Src = "../../../GUI/images/Ritco_Logo.gif";
        dkt_call = Session["DocketCalledAs"].ToString();
        hdClient.Value = Session["Client"].ToString();
        BindGrid();
    }
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection("Data Source=103.1.115.38;Initial Catalog=Ritco_Live;User ID=sa;Password=R1i2T3c4O5");
        conn.Open();



        string RO = "";
        string LO = "";
        string RO_TO = "";
        string LO_TO = "";
        string DateType = "";
        string fromdt = "";
        string todt = "";
        string st_Docnolist = Request.QueryString.Get("st_Docnolist");
        string St_Manualnolist = "";

        string st_Vehnolist = "";
        string st_Freetext = "";
        string st_doctyp = "";
        string str_doctyp = "";

        string strPaybas = "";
        string str_Paybas = "";
        string strMode = "";
        string str_Mode = "";
        string strType = "";
        string str_Type = "";


        //lblseldet.Text = fromdt + " - " + todt;
        //lblro.Text = RO + " - " + RO_TO;
        //lblloc.Text = LO + " - " + LO_TO;
        //lblflow.Text = str_doctyp;
        //lblCust.Text = Session["empcd"].ToString().Trim() + " : " + Session["empnm"].ToString().Trim();
        //lblpaybas.Text = str_Paybas;
        //lblMode.Text = str_Mode;
        //lblTypem.Text = str_Type;
        string sql_st = "exec WebxNet_Customer_Tracking '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','','" + strPaybas + "','" + strMode + "','" + strType + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "'";
       // Response.Write("<br>sql_st : " + sql_st);

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
        //string DocumentName;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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

            conn.Open();
            HiddenField dktst = (HiddenField)e.Row.FindControl("dktst");
            //Label lbldockno = (Label)e.Row.FindControl("lbldockno");
            Label hypPODDoc = (Label)e.Row.FindControl("hypPODDoc");
            string strDOcName = DataBinder.Eval(e.Row.DataItem, "doc_no").ToString();
            string SQL_POD = "select top 1 documentname from Webx_FM_Scan_Documents where docketno+'.'='" + strDOcName + "'";
            //Response.Write(SQL_POD);
            
            SqlCommand cmd = new SqlCommand(SQL_POD, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while(dr.Read())
            {
                if (dr["documentname"] != DBNull.Value)
                {
                    string DocumentName = dr["documentname"].ToString();
                    hypPODDoc.Text = "View POD";
                    string str = "<a href='JavaScript:OpenPopupWindow(\"" + DocumentName + "\")'>" +
                          "<font cssclass='Blackfnt'><u>View POD </u></a>";
                    hypPODDoc.Text = str;
                    hypPODDoc.Enabled = true;
                }
                else
                {
                    hypPODDoc.Text = "No POD Uploaded";
                    hypPODDoc.Enabled = false;
                }                
            }    
            dr.Close();
            conn.Close();
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




    


}
