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
public partial class GUI_UNI_MIS_UnUsed_missing_Result : System.Web.UI.Page
{
    string Doc_type;
    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strcust, dkt_call, Rtyp;

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

        dkt_call = Session["DocketCalledAs"].ToString();

    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    if (Rtyp == "M")
            //    {
            //        e.Row.Cells[9].Style["display"] = "none";
            //        e.Row.Cells[9].Visible = false;
            //    }
            //    else
            //    {
            //        e.Row.Cells[8].Style["display"] = "none";
            //    }
            //}

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ////Build custom header.
                string docknofrom, docknoto,suUsed;
                docknofrom = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Series_From"));
                docknoto = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Series_To"));
                suUsed = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "used"));
                //Label lblMissingUnsused = (Label)e.Row.FindControl("lblMissingUnsused");
               // Label lblMissingUnsusedResult = (Label)e.Row.FindControl("lblMissingUnsusedResult");

                //exec sp_Missing_Dockets_In_Range '648751','648800'
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();


                string sql_used = "select dockno from webx_master_docket with(NOLOCK) where dockno between '" + docknofrom + "' and '" + docknoto + "'";
                SqlCommand cmd12 = new SqlCommand(sql_used,conn);
                SqlDataReader dr12 = cmd12.ExecuteReader();
                string st_used = "";
                int iu = 0, intResultU = 0;
                iu = 1;
                while (dr12.Read())
                {
                    if (st_used == "")
                        st_used = dr12["dockno"].ToString();
                    else
                        st_used = st_used + "," + dr12["dockno"].ToString();


                    iu = iu + 1;
                    System.Math.DivRem(iu, 10, out intResultU);
                    if (intResultU == 1)
                    {
                        st_used = st_used + "<br>";
                    }
                }
                dr12.Close();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandType = CommandType.StoredProcedure;

                //if (Rtyp == "M")
                //{
                    cmd.CommandText = "usp_Missing_Dockets_In_Range";
                   // lblMissingUnsused.Text = "Missing List";
                //}
                //else
                //{
                //    cmd.CommandText = "sp_Missing_Dockets_In_Range";
                //   // lblMissingUnsused.Text = "UnUsed List";
                //}
                
                cmd.Parameters.AddWithValue("@FromRange", docknofrom);
                cmd.Parameters.AddWithValue("@ToRange", docknoto);
                if (conn.State == ConnectionState.Closed)
                {
                    cmd.Connection.Open();
                }
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                string MissDkt;
                MissDkt = "";
                int i = 0, intResult;
                i = 1;
                while (dr.Read())
                {
                    if (MissDkt == "")
                    {
                        MissDkt = Convert.ToString(dr[0]);
                    }
                    else
                    {
                        MissDkt = MissDkt + "," + Convert.ToString(dr[0]);
                    }
                    i = i + 1;
                    System.Math.DivRem(i, 10, out intResult);
                    if (intResult == 1)
                    {
                        MissDkt = MissDkt + "<br>";
                    }
                }
                dr.Close();



                SqlCommand cmd1 = new SqlCommand();
                cmd1.CommandText = "usp_UNUsed_Dockets_In_Range";
                cmd1.Connection = conn;
                cmd1.CommandType = CommandType.StoredProcedure;

                //if (Rtyp == "M")
                //{
               // cmd1.CommandText = "usp_Missing_Dockets_In_Range";
                // lblMissingUnsused.Text = "Missing List";
                //}
                //else
                //{
                //    cmd.CommandText = "sp_Missing_Dockets_In_Range";
                //   // lblMissingUnsused.Text = "UnUsed List";
                //}

                cmd1.Parameters.AddWithValue("@FromRange", docknofrom);
                cmd1.Parameters.AddWithValue("@ToRange", docknoto);
                if (conn.State == ConnectionState.Closed)
                {
                    cmd1.Connection.Open();
                }
                SqlDataReader dr1;
                dr1 = cmd1.ExecuteReader();
                string MissDkt1;
                MissDkt1 = "";
                int i1 = 0, intResult1;
                i1 = 1;
                while (dr1.Read())
                {
                    if (MissDkt1 == "")
                    {
                        MissDkt1 = Convert.ToString(dr1[0]);
                    }
                    else
                    {
                        MissDkt1 = MissDkt1 + "," + Convert.ToString(dr1[0]);
                    }
                    i1 = i1 + 1;
                    System.Math.DivRem(i1, 10, out intResult1);
                    if (intResult1 == 1)
                    {
                        MissDkt1 = MissDkt1 + "<br>";
                    }
                }
                dr1.Close();

                conn.Close();

                if (Rtyp == "M")
                {
                    if (i > 1)
                    {
                        e.Row.Style["display"] = "block";
                    }
                    else
                    {
                        e.Row.Style["display"] = "none";
                    }
                }
                else
                {
                    if (i1 > 1)
                    {
                        e.Row.Style["display"] = "block";
                    }
                    else
                    {
                        e.Row.Style["display"] = "none";
                    }
                }

                e.Row.Cells[8].Text = (i - 1) + "";
                if (MissDkt != "")
                {
                    e.Row.Cells[9].Text = "[" + MissDkt + "]";
                    //e.Row.Cells[9].Text = "[" + MissDkt + "]";
                }
                else
                {
                    e.Row.Cells[9].Text = "";
                    //e.Row.Cells[9].Text = "";
                }
                e.Row.Cells[10].Text = suUsed;
                if (st_used != "")
                {
                    e.Row.Cells[11].Text =" [" + st_used + "]";
                    //e.Row.Cells[9].Text = "[" + MissDkt + "]";
                }
                else
                {
                    e.Row.Cells[11].Text ="";
                    //e.Row.Cells[9].Text = "";
                }
                e.Row.Cells[12].Text = (i1 - 1) + "";
                if (MissDkt1 != "")
                {
                   // e.Row.Cells[8].Text = "[" + MissDkt + "]";
                    e.Row.Cells[13].Text = "[" + MissDkt1 + "]";
                }
                else
                {
                   // e.Row.Cells[8].Text = "";
                    e.Row.Cells[13].Text =  "";
                }
                 
              

                //lblMissingUnsusedResult.Text = MissDkt;

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

        string strrightnow = "", strrightnow1 = "", dtFrom = "", dtTo = "";
        System.DateTime righnow = System.DateTime.Today;
      



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
       
        Doc_type = Request.QueryString.Get("Rtyp");
        Rtyp = Request.QueryString.Get("Rtyp");
        string custcd = Request.QueryString.Get("St_custcd");
        string st_vendcd = Request.QueryString.Get("st_vendcd");
        string st_orderlist = Request.QueryString.Get("st_orderlist");
        dtFrom = Request.QueryString.Get("fromdt");
        dtTo = Request.QueryString.Get("todt");
        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO;
        lblloc.Text = LO;
        //lblcust.Text = custcd;
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


        if (RO == LO)
            RO = "All";

        String SQL_grid = "exec Webx_Missing_unUsed '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + custcd + "'";//,'" + Doc_type + "','" + st_orderlist + "'";

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);


       
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Visible = true;

       


        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
      
            dgDocket.PageIndex = e.NewPageIndex;
       
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
            
                dgDocket.AllowPaging = false;
                dgDocket.BorderWidth = 1;
                dgDocket.CssClass = "blackfnt";
                dgDocket.Font.Size = 10;
            
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=UnUsed_missing.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            BindGrid();

            dgDocket.RenderControl(hw);
            

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
