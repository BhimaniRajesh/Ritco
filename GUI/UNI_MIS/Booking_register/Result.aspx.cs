using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class GUI_UNI_MIS_Booking_register_Result : System.Web.UI.Page
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
                ////Build custom header.
                ////string docknofrom, docknoto;
                ////docknofrom = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from"));
                ////docknoto = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to"));
                //Table table = (Table)this.dgDocket.Controls[0];
                //GridView oGridView = (GridView)sender;
                //int realindex = table.Rows.GetRowIndex(e.Row);
                //GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                //TableCell oTableCell = new TableCell();

                //// Label lblColname=(Label)e.Row

                ////Add Department
                //oTableCell.Text = "Status : ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                ////DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                //oTableCell.ColumnSpan = 3;
                //oTableCell.CssClass = "blackfnt";
                //oTableCell.Font.Bold = true;
                //oTableCell.HorizontalAlign = HorizontalAlign.Right;
                //oGridViewRow.Cells.Add(oTableCell);

                //e.Row.BackColor = System.Drawing.Color.White;
                //Label lbldockno = (Label)e.Row.FindControl("lbldockno");

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
                //string MDockets = lbldockno.Text.ToString();

                //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                //conn.Open();


                //String SQL_status = "exec webx_Docket_status '" + MDockets + "'";
                //SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
                //SqlDataReader dr21;
                //dr21 = sqlcmd21.ExecuteReader();

                //String status_doc = "", st_docloc = "", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
                //while (dr21.Read())
                //{
                //    status_doc = dr21["OP_status"].ToString();
                //    attech_doc = dr21["doc_no"].ToString();
                //    st_docdate = dr21["doc_dt"].ToString();

                //    st_docname = dr21["docname"].ToString();
                //    st_docloc = dr21["curr_loc"].ToString();
                //    st_docmadby = dr21["doc_PreBy"].ToString();
                //}
                //dr21.Close();

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


                //oTableCell = new TableCell();
                ////oTableCell.Text = "Employee";
                //oTableCell.ColumnSpan = 8;
                //oTableCell.Text = status_doc + " - " + attech_doc;
                //oTableCell.CssClass = "blackboldfnt";
                //if (st_docname.ToUpper() == "DRS")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenPopupWindowPDC('" + attech_doc + "','D')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                //    oTableCell.CssClass = "blackfnt";
                //}
                //if (st_docname.ToUpper() == "THC")
                //{
                //    oTableCell.Text = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindowTHC('" + attech_doc + ".')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
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
                /////oTableCell.Width = 50;
                //oTableCell.Wrap = false;
                ////TextBox txt = new TextBox();
                ////txt.CssClass = "blackfnt";
                ////txt.Text = "chirag";
                ////oTableCell.Controls.Add(txt);

                //oTableCell.HorizontalAlign = HorizontalAlign.Left;
                //oGridViewRow.Cells.Add(oTableCell);
                //oGridViewRow.BackColor = System.Drawing.Color.White;
                //table.Controls.AddAt(realindex + 1, oGridViewRow);
                ////oGridViewRow.Width = 100;

                //conn.Close();
            }
        }
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string strrightnow = "", strrightnow1 = "", dtFrom = "", dtTo="";
        System.DateTime righnow = System.DateTime.Today;
         strrightnow = righnow.ToString("dd/MM/yyyy");
         strrightnow1 = righnow.ToString("dd/MM/yyyy");

      
      
      
        string RO = Request.QueryString.Get("RO");
        if (RO == "")
        {
            RO = "All";
        }
        string LO = Request.QueryString.Get("LO");
        if (LO == "")
        {
            LO = "All";
        }
        string DateType = Request.QueryString.Get("DateType");

       // string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

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
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        Doc_type = Request.QueryString.Get("Rtyp");
        string custcd = Request.QueryString.Get("St_custcd");
        string st_vendcd = Request.QueryString.Get("st_vendcd");
        string st_orderlist = Request.QueryString.Get("st_orderlist");

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO ;
        lblloc.Text = LO ;
        lblcust.Text = custcd;
        st_orderlist = "";
        if (Doc_type.ToUpper() == "THC")
        {
            custcd = st_vendcd;
            st_orderlist = Request.QueryString.Get("st_orderlist");
        }

        //string custcd = "";

        if (custcd.ToString() == "")
        {
            custcd = "";

        }



        String SQL_grid = "exec webx_Booking_Bill_register '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + custcd + "','" + Doc_type + "','" + st_orderlist + "'";

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);


        if (Doc_type == "doc_flow")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Visible = true;

        }

        if (Doc_type.ToUpper() == "BILL")
        {

            dgBill.DataSource = ds;
            dgBill.DataBind();
            dgBill.Visible = true;

        }
        if (Doc_type.ToUpper() == "THC")
        {

            dgthc.DataSource = ds;
            dgthc.DataBind();
            dgthc.Visible = true;

        }

        
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        if (Doc_type == "doc_flow")
        {
            dgDocket.PageIndex = e.NewPageIndex;
        }

        if (Doc_type.ToUpper() == "BILL")
        {
            dgBill.PageIndex = e.NewPageIndex;
        }
        if (Doc_type.ToUpper() == "THC")
        {
            dgthc.PageIndex = e.NewPageIndex;
        }
        
     //   BindGrid();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            ///GV_Booking.AllowPaging = false;
            //GV_Booking.BorderWidth = 1;
            if (Doc_type == "doc_flow")
            {
                dgDocket.AllowPaging = false;
                dgDocket.BorderWidth = 1;
            }

            if (Doc_type.ToUpper() == "BILL")
            {
               // dgBill.PageIndex = e.NewPageIndex;
                dgBill.AllowPaging = false;
                dgBill.BorderWidth = 1;
            }
            if (Doc_type.ToUpper() == "THC")
            {
                //dgthc.PageIndex = e.NewPageIndex;
                dgthc.AllowPaging = false;
                dgthc.BorderWidth = 1;
            }
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Booking_Register.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            BindGrid();
            
            
            if (Doc_type == "doc_flow")
            {
                //dgDocket.PageIndex = e.NewPageIndex;
                dgDocket.RenderControl(hw);
            }

            if (Doc_type.ToUpper() == "BILL")
            {
                //dgBill.PageIndex = e.NewPageIndex;
                dgBill.RenderControl(hw);
            }
            if (Doc_type.ToUpper() == "THC")
            {
                //dgthc.PageIndex = e.NewPageIndex;
                dgthc.RenderControl(hw);
            }


            Response.Write(tw.ToString());
            Response.End();

        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
}
