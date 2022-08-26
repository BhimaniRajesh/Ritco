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

public partial class GUI_Tracking_Tracking_Result : System.Web.UI.Page
{
    string Doc_type;
    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strcust, dkt_call;

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

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

                //exec sp_Missing_Dockets_In_Range '648751','648800'

                //SqlCommand cmd = new SqlCommand();
                //cmd.Connection = cn;
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.CommandText = "sp_Missing_Dockets_In_Range";
                //cmd.Parameters.AddWithValue("@FromRange", docknofrom);
                //cmd.Parameters.AddWithValue("@ToRange", docknoto);
                //if (cn.State == ConnectionState.Closed) 
                //{
                //    cmd.Connection.Open();
                //}
                //SqlDataReader dr;
                //dr = cmd.ExecuteReader();
                //string MissDkt;
                //MissDkt = "";
                //while (dr.Read())
                //{
                //    MissDkt = MissDkt + "," + Convert.ToString(dr[0]) ;
                //}
                //dr.Close();
                //if (cn.State == ConnectionState.Open)
                //{
                //    cmd.Connection.Close();
                //}
                string MDockets = lbldockno.Text.ToString();

                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();


                String SQL_status = "exec webx_Docket_status '" + MDockets + "'";
                SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
                SqlDataReader dr21;
                dr21 = sqlcmd21.ExecuteReader();

                String status_doc = "",st_docloc="", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
                while (dr21.Read())
                {
                    status_doc = dr21["OP_status"].ToString();
                    attech_doc = dr21["doc_no"].ToString();
                    st_docdate = dr21["doc_dt"].ToString();
                    
                    st_docname = dr21["docname"].ToString();
                    st_docloc = dr21["curr_loc"].ToString();
                    st_docmadby = dr21["doc_PreBy"].ToString();
                }
                dr21.Close();

                //MDockets = "";
                //if (MissDkt.Length > 0)
                //{
                //    MDockets = "[" + MissDkt.Substring(1, MissDkt.Length - 1) + "]";
                //}
                //else 
                //{
                //    MDockets = "None";
                //}
                ////MissDkt += "[" + MissDkt + "]";


                oTableCell = new TableCell();
                //oTableCell.Text = "Employee";
                oTableCell.ColumnSpan =8;
                oTableCell.Text = status_doc + " - " + attech_doc;
                oTableCell.CssClass = "blackboldfnt";
                if (st_docname.ToUpper() == "DRS")
                {
                    oTableCell.Text = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenPopupWindowPDC('" + attech_doc + "','D')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                    oTableCell.CssClass = "blackfnt";
                }
                if (st_docname.ToUpper() == "THC")
                {
                    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowTHC('" + attech_doc + ".')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                    oTableCell.CssClass = "blackfnt";
                }
                if (st_docname.ToUpper() == "MF")
                {
                    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowManifest('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                    oTableCell.CssClass = "blackfnt";
                }
                if (st_docname.ToUpper() == "LS")
                {
                    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowLSNO('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                    oTableCell.CssClass = "blackfnt";
                }
                ///oTableCell.Width = 50;
                oTableCell.Wrap = false;
                //TextBox txt = new TextBox();
                //txt.CssClass = "blackfnt";
                //txt.Text = "chirag";
                //oTableCell.Controls.Add(txt);
                
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
        string sql = "webx_UNI_CUST_TRacking";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");
        string strrightnow1 = righnow.ToString("dd/MM/yyyy");

        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //// dtfi.ShortDatePattern="
        //dtfi.DateSeparator = "/";

        MyFunctions fn = new MyFunctions();


        //string fromdt = Request.QueryString.Get("txtDateFrom");
        // string Todt = Request.QueryString.Get("txtDateTo");

        //string fromdt = fn.Datadate(txtDateFrom.Text.ToString());
        //string Todt = fn.Datadate(txtDateTo.Text.ToString());
        //// Todt = fn.Datadate(Todt);

        //{
        //    dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
        //    dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);

        //}

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        //{

        //    dtFrom = Convert.ToDateTime(dtFrom1, dtfi);
        //    dtTo = Convert.ToDateTime(dtTo1, dtfi);
        //}

        string fdate = Request.QueryString.Get("dtFrom");
        string tdate = Request.QueryString.Get("dtTo");

        Array str, str1;
        if (fdate == "")
        {
            fdate = "01/01/2007";
        }
        if (tdate == "")
        {
            tdate = "01/01/2007";
        }
        //fdate = Request.QueryString["FrmDate"];
        //tdate = Request.QueryString["ToDate"];
        str = fdate.Split('/');
        str1 = tdate.Split('/');
        //((string[])(str))[0]
        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
        //CultureInfo a = CultureInfo.CurrentCulture;
        //TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);

        string dtFrom, dtTo;
        dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        

        string RO = Request.QueryString.Get("RO");
        if (RO == "")
        {
            RO = "All";
        }
        string LO = Request.QueryString.Get("LO");
        string RO_TO = Request.QueryString.Get("RO_TO");
        string LO_TO= Request.QueryString.Get("LO_TO");

        if (LO_TO == "All")
        {
            RO_TO = "All";
        }
        //string Paybas = Request.QueryString.Get("Paybas");
        //string trnmod = Request.QueryString.Get("trnmod");
         Doc_type = Request.QueryString.Get("Doc_type");
        string docket_list = Request.QueryString.Get("docket_list");
        string manual_list = Request.QueryString.Get("manual_list");
        string custcd = Request.QueryString.Get("custcd");

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO + " - " + RO_TO;
        lblloc.Text = LO + " - " + LO_TO;
        lblcust.Text = custcd;
      

        //string custcd = "";

        if (custcd.ToString() == "")
        {
            custcd = "All";

        }

        da.SelectCommand.Parameters.Add("@fromdt", SqlDbType.DateTime).Value = dtFrom.Trim();
        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo.Trim();
        da.SelectCommand.Parameters.Add("@fromRo", SqlDbType.VarChar).Value = RO;
        da.SelectCommand.Parameters.Add("@fromloc", SqlDbType.VarChar).Value = LO;
        da.SelectCommand.Parameters.Add("@toRo", SqlDbType.VarChar).Value = RO_TO;
        da.SelectCommand.Parameters.Add("@toloc", SqlDbType.VarChar).Value = LO_TO;
        da.SelectCommand.Parameters.Add("@custcode", SqlDbType.VarChar).Value = custcd;
        da.SelectCommand.Parameters.Add("@docklist", SqlDbType.VarChar).Value = docket_list;
        da.SelectCommand.Parameters.Add("@manuallist", SqlDbType.VarChar).Value = manual_list;
        da.SelectCommand.Parameters.Add("@documenttype", SqlDbType.VarChar).Value = Doc_type;

        DataSet ds = new DataSet();

        da.Fill(ds);

        if (Doc_type == "D")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            lblflow.Text = dkt_call;
            dgDocket.Visible = true;

            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }
        if (Doc_type == "M")
        {

            lblflow.Text = "Menifest";
            dgMenifest.DataSource = ds;
            dgMenifest.DataBind();
            
            dgMenifest.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (Doc_type == "L")
        {
            lblflow.Text = "Loading Sheet";

            dgLS.DataSource = ds;
            dgLS.DataBind();

            dgLS.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (Doc_type == "T")
        {

            lblflow.Text = "THC";
            dgTHC.DataSource = ds;
            dgTHC.DataBind();

            dgTHC.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }

        if (Doc_type == "P")
        {

            lblflow.Text = "PDC";
            dgPDC.DataSource = ds;
            dgPDC.DataBind();

            dgPDC.Visible = true;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }


        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        if (Doc_type == "D")
        {
            dgDocket.PageIndex = e.NewPageIndex;
        }
        if (Doc_type == "M")
        {
            dgMenifest.PageIndex = e.NewPageIndex;
        }
        if (Doc_type == "P")
        {
            dgPDC.PageIndex = e.NewPageIndex;
        }
        if (Doc_type == "T")
        {
            dgTHC.PageIndex = e.NewPageIndex;
        }
        if (Doc_type == "L")
        {
            dgLS.PageIndex = e.NewPageIndex;
        }
        BindGrid();

    }

}
