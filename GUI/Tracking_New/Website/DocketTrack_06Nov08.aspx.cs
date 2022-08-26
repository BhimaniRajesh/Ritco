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

    public static string dkt_call, st_Docnolist;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        imgLogo.Src = "../../../GUI/images/Ritco_Logo.gif";
       
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
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
                //Build custom header.
                //string docknofrom, docknoto;
                //docknofrom = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from"));
                //docknoto = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to"));
                Table table = (Table)this.dgDocket.Controls[0];
                GridView oGridView = (GridView)sender;
                int realindex = table.Rows.GetRowIndex(e.Row);
                GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();

                // Label lblColname=(Label)e.Row

                //Add Department
                oTableCell.Text = "Status : ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell.ColumnSpan = 3;
                oTableCell.CssClass = "blackfnt";
                oTableCell.Font.Bold = true;
                oTableCell.HorizontalAlign = HorizontalAlign.Right;
                oGridViewRow.Cells.Add(oTableCell);

                e.Row.BackColor = System.Drawing.Color.White;
                Label lbldockno = (Label)e.Row.FindControl("lbldockno");


                string MDockets = lbldockno.Text.ToString();

                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();


                String SQL_status = "exec webxNet_DKT_STATUS '" + MDockets + "'";
                SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
                SqlDataReader dr21;
                dr21 = sqlcmd21.ExecuteReader();

                String status_doc = "", st_docloc = "", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
                while (dr21.Read())
                {
                    status_doc = dr21["Docket_Status"].ToString();
                    //attech_doc = dr21["doc_no"].ToString();
                    //st_docdate = dr21["doc_dt"].ToString();

                    //st_docname = dr21["docname"].ToString();
                    //st_docloc = dr21["curr_loc"].ToString();
                    //st_docmadby = dr21["doc_PreBy"].ToString();
                }
                dr21.Close();

                //string sql_rec = " select top 1  recd_person from webx_pdctrn with(NOLOCK) where dockno+docksf='" + MDockets + "'  order by dely_dt desc  ";
                //SqlCommand cmd_rec = new SqlCommand(sql_rec, conn);
                //SqlDataReader dr_rec = cmd_rec.ExecuteReader();

                //string recd_person = "";
                //while (dr_rec.Read())
                //{
                //    recd_person = dr_rec["recd_person"].ToString();
                //}

                //dr_rec.Close();

                oTableCell = new TableCell();
                //oTableCell.Text = "Employee";
                oTableCell.ColumnSpan = 8;
               // oTableCell.Text = status_doc + " - " + attech_doc;
                //oTableCell.CssClass = "blackboldfnt";
                //if (st_docname.ToUpper() == "DRS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenPopupWindowPDC('" + attech_doc + "','D')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>  Received By " + recd_person;
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "THC")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowTHC('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "MF")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowManifest('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "LS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowLSNO('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "CAN" || st_docname.ToUpper() == "DEN")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by " + st_docmadby + "  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "redfnt";
                //}
                //if (st_docname.ToUpper() == "DRS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by " + attech_doc + "  on <b>" + st_docdate + "</b>  Received By " + recd_person;
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "THC")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by " + attech_doc + "  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "MF")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by " + attech_doc + "  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "LS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by " + attech_doc + "  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "CAN" || st_docname.ToUpper() == "DEN")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by " + st_docmadby + "  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "redfnt";
                //}

                oTableCell.Text = status_doc;// +"</b>    by " + attech_doc + "  on <b>" + st_docdate + "</b>";
                oTableCell.CssClass = "bluefnt";
                ///oTableCell.Width = 50;
                oTableCell.Wrap = false;


                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell);
                oGridViewRow.BackColor = System.Drawing.Color.White;
                table.Controls.AddAt(realindex + 1, oGridViewRow);
                //oGridViewRow.Width = 100;

                conn.Close();
            }
        }
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        st_Docnolist = Request.QueryString.Get("st_Docnolist");
        //Response.Write("<br>st_Docnolist : " + st_Docnolist);
        // Response.End();
        string sql_st = "exec webx_Website_tracking '" + st_Docnolist + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();

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

    }
}
