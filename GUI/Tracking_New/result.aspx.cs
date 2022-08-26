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

public partial class GUI_Tracking_New_result : System.Web.UI.Page
{
    string Doc_type;
    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strcust, dkt_call;

      public static string RO, LO,RO_TO,LO_TO,DateType,fromdt,todt,st_Docnolist,St_Manualnolist,st_Vehnolist,st_Freetext,st_doctyp;
       

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

        dkt_call = Session["DocketCalledAs"].ToString();

    }

    protected void dgTHC_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Build custom header.
            //string docknofrom, docknoto;
            //docknofrom = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from"));
            //docknoto = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to"));
            Table table = (Table)this.dgTHC.Controls[0];
            GridView oGridView = (GridView)sender;
            int realindex = table.Rows.GetRowIndex(e.Row);
            GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCel = new TableCell();
            // Label lblColname=(Label)e.Row

            //Add Department
            oTableCell.Text = "Status : ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
            //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Right;
            oTableCell.BackColor = System.Drawing.Color.White;
            oGridViewRow.Cells.Add(oTableCell);

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            Label lblTHCno = (Label)e.Row.FindControl("lblTHCno");
            string ST_THC = lblTHCno.Text.ToString();
            string SQL_status = "exec webx_THC_STATUS '" + ST_THC + "'";
            //Response.Write("<BB> : " +SQL_status);
            SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
//SqlDataReader dr21;
           // dr21 = sqlcmd21.ExecuteReader();


            string THC_STATUD = sqlcmd21.ExecuteScalar().ToString();

            oTableCel.Text = THC_STATUD; //+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
            //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
            oTableCel.ColumnSpan = 10;
             oTableCel.CssClass = "bluefnt";
             if (THC_STATUD.Substring(0, 3).ToUpper().ToString() == "CAN")
             {
                 oTableCel.CssClass = "redfnt";
             }
           // oTableCel.Font.Bold = true;
            oTableCel.HorizontalAlign = HorizontalAlign.Left;
            oTableCel.BackColor = System.Drawing.Color.White;
            oGridViewRow.Cells.Add(oTableCel);

            table.Controls.AddAt(realindex + 1, oGridViewRow);
            conn.Close();
        }
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
                oTableCell.ColumnSpan = 2;
                oTableCell.CssClass = "blackfnt";
                oTableCell.Font.Bold = true;
                oTableCell.HorizontalAlign = HorizontalAlign.Right;
                oGridViewRow.Cells.Add(oTableCell);

                e.Row.BackColor = System.Drawing.Color.White;
                Label lbldockno = (Label)e.Row.FindControl("lbldockno");

                Label lbldockno1 = (Label)e.Row.FindControl("lbldockno1");
                Label lbldocksf = (Label)e.Row.FindControl("lbldocksf");


                
                string MDockets = lbldockno.Text.ToString();

                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();


                String SQL_status = "exec webxNet_DKT_STATUS '" + MDockets + "'";
                //Response.Write("<br> dockno : " + SQL_status);
               // Response.End();
                SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
                SqlDataReader dr21;
                dr21 = sqlcmd21.ExecuteReader();

                String status_doc = "",st_docloc="", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
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

           
		string sql_rec = " select top 1  recd_person from webx_pdctrn with(NOLOCK) where dockno+docksf='"+MDockets+"'  order by dely_dt desc  ";
        SqlCommand cmd_rec = new SqlCommand(sql_rec, conn);
        SqlDataReader dr_rec = cmd_rec.ExecuteReader();

string recd_person="";
		while (dr_rec.Read())
        {
			recd_person = dr_rec["recd_person"].ToString();
		}

 		dr_rec.Close();

                oTableCell = new TableCell();
                TableCell pTableCell = new TableCell();
                //oTableCell.Text = "Employee";
                oTableCell.ColumnSpan =5;
                pTableCell.ColumnSpan = 2;
                oTableCell.Text = status_doc; //+ " - " + attech_doc;
                oTableCell.CssClass = "blackboldfnt";

                pTableCell.Font.Bold = true;
                pTableCell.Text = "<a href=\"JavaScript:OpenPopupWindow('" + lbldockno1.Text.ToString() + "','" + lbldocksf.Text.ToString() + "')\">Track</a>/<a href=\"JavaScript:OpenPopupWindow1('" + lbldockno1.Text.ToString() + "','" + lbldocksf.Text.ToString() + "')\">View</a>/<a href=\"JavaScript:OpenPopupWindow1('" + lbldockno1.Text.ToString() + "','" + lbldocksf.Text.ToString() + "')\">Print</a>";
                pTableCell.CssClass = "blackfnt";

                oTableCell.Text = status_doc;// +" - " + attech_doc;
                oTableCell.CssClass = "bluefnt";
                //if (st_docname.ToUpper() == "DRS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenPopupWindowPDC('" + attech_doc + "','D')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>  Received By "+recd_person;
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
               // Response.Write("<br> status_doc : " + status_doc);
                //Response.End();
               // if (status_doc.Trim().ToUpper().Substring(0, 3) == "CAN" || status_doc.ToUpper().Substring(0, 3) == "DET")
               // {
                    // oTableCell.Text = "<b>" + status_doc + "</b>    by " + st_docmadby + "  on <b>" + st_docdate + "</b>";
                   // oTableCell.CssClass = "redfnt";
               // }
                ///oTableCell.Width = 50;
                oTableCell.Wrap = false;


                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell);
                oGridViewRow.BackColor = System.Drawing.Color.White;
                table.Controls.AddAt(realindex + 1, oGridViewRow);
                pTableCell.Wrap = false;
               
                
               // oTableCell.HorizontalAlign = HorizontalAlign.Left;
                pTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oGridViewRow.Cells.Add(oTableCell);
                oGridViewRow.Cells.Add(pTableCell);
               // oGridViewRow.BackColor = System.Drawing.Color.White;
              //  table.Controls.AddAt(realindex + 1, oGridViewRow);
                //oGridViewRow.Width = 100;

                String SQL_status1 = "exec usp_bapayment_validdkt '" + MDockets + "'";
                SqlCommand sqlcmd211 = new SqlCommand(SQL_status1, conn);
                SqlDataReader dr211;
                dr211 = sqlcmd211.ExecuteReader();

                String status_doc1 = "", attech_doc1 = "", ded1 = "";
                // double ded = 0;
                while (dr211.Read())
                {
                    status_doc1 = dr211.GetValue(1).ToString();// dr21["OP_status"].ToString();
                    attech_doc1 = dr211.GetValue(0).ToString();
                    ded1 = dr211.GetValue(3).ToString();

                    if (attech_doc1 == "Y" )
                    {
                        e.Row.Cells[12].Text = status_doc1;
                        e.Row.Cells[12].HorizontalAlign = HorizontalAlign.Center;
                    }
                }
                dr21.Close();


                conn.Close();
            }
        }
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        RO = Request.QueryString.Get("RO");
        LO = Request.QueryString.Get("LO");
        RO_TO = Request.QueryString.Get("RO_TO");
        LO_TO = Request.QueryString.Get("LO_TO");
        DateType = Request.QueryString.Get("DateType");
        fromdt = Request.QueryString.Get("fromdt");
        todt = Request.QueryString.Get("todt");
        st_Docnolist = Request.QueryString.Get("st_Docnolist");
        St_Manualnolist = Request.QueryString.Get("St_Manualnolist");
        st_Vehnolist = Request.QueryString.Get("st_Vehnolist");
        st_Freetext = Request.QueryString.Get("st_Freetext");
        st_doctyp = Request.QueryString.Get("st_doctyp");


        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

     
        string sql_st = "exec webx_OPN_DOC_TRacking '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','All','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.End();
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO + " - " + RO_TO;
        lblloc.Text = LO + " - " + LO_TO;
        //lblcust.Text = custcd;
                                                                                                                                             

        DataSet ds = new DataSet();

        da.Fill(ds);


        if (st_doctyp == "DKT")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            // lblflow.Text = dkt_call;
            dgDocket.Visible = true;

        }

        if (st_doctyp == "MF")
        {

            lblflow.Text = "Menifest";
            dgMenifest.DataSource = ds;
            dgMenifest.DataBind();

            dgMenifest.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (st_doctyp == "LS")
        {
            lblflow.Text = "Loading Sheet";

            dgLS.DataSource = ds;
            dgLS.DataBind();

            dgLS.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (st_doctyp == "THC")
        {

            lblflow.Text = "THC";
            dgTHC.DataSource = ds;
            dgTHC.DataBind();

            dgTHC.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (st_doctyp == "PRS" )
        {

            lblflow.Text = "PDC";
            dgPDC.DataSource = ds;
            dgPDC.DataBind();

            dgPDC.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (st_doctyp == "DRS")
        {

            lblflow.Text = "PDC";
            dgPDC1.DataSource = ds;
            dgPDC1.DataBind();

            dgPDC1.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (st_doctyp == "TS")
        {

            lblflow.Text = "TRIP SHEET";
            dgTS.DataSource = ds;
            dgTS.DataBind();
            dgTS.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }
        conn.Close();

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        if (st_doctyp == "DKT")
        {
            dgDocket.PageIndex = e.NewPageIndex;
        }
        if (st_doctyp == "MF")
        {
            dgMenifest.PageIndex = e.NewPageIndex;
        }
        if (st_doctyp == "PRS" )
        {
            dgPDC.PageIndex = e.NewPageIndex;
        }
        if ( Doc_type == "DRS")
        {
            dgPDC1.PageIndex = e.NewPageIndex;
        }
        if (st_doctyp == "THC")
        {
            dgTHC.PageIndex = e.NewPageIndex;
        }
        if (st_doctyp == "LS")
        {
            dgLS.PageIndex = e.NewPageIndex;
        }
        if (st_doctyp == "TS")
        {
            dgTS.PageIndex = e.NewPageIndex;
        }
        BindGrid();

    }

}
