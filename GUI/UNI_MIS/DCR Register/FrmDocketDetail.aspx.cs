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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
//using CrystalDecisions.CrystalReports.Engine; 
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    string docfrom, docto,mode;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        docfrom = Request.QueryString["docfrom"];
        docto = Request.QueryString["docto"];
        lbldaterange.Text = docfrom + " - " + docto;   
        mode = Request.QueryString["mode"];  
        if (!IsPostBack)
        {
            BindTheData();
        }
    }
    public void BindTheData()
    {
        if (mode == "unused")
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "usp_Missing_Dockets_In_Range";
            cmd.Parameters.AddWithValue("@FromRange", docfrom);
            cmd.Parameters.AddWithValue("@ToRange", docto);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            sqlDA.Fill(ds, "LoadUnload");
            GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        }
        else if (mode == "used")
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "webx_drill_dcr_register";
            cmd.Parameters.AddWithValue("@FromRange", docfrom);
            cmd.Parameters.AddWithValue("@ToRange", docto);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            sqlDA.Fill(ds, "LoadUnload");
            GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        }
        bindgrid();
        GrdPaidFollow.DataBind();  
    }
    int _counter = 0;
    protected void GrdToPayFollow_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            _counter += 1;
            Label l = (Label)e.Row.FindControl("LblSrNo");
            l.Text = _counter.ToString();
            l.DataBind();
        }
    }
    protected void bindgrid()
    {
        GrdPaidFollow.AutoGenerateColumns = false;
        GrdPaidFollow.AllowSorting = false;
        //GrdPaidFollow.Columns.Clear();
        if (GrdPaidFollow.Columns.Count == 1)
        {
            if (mode == "unused")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
                bf_HelpDesk.HeaderText = "Docket ";
                bf_HelpDesk.DataField = "missing";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);
                //<asp:BoundField HeaderStyle-CssClass="blackfnt" HeaderText="Issued to HO" DataField="HO" ControlStyle-Height="500" 
                //ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
            }
            else if (mode == "used")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Docket No.";
                bf_HelpDesk.DataField = "docket";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Delivery Location";
                bf_HelpDesk.DataField = "reassign_destcd";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Consignor";
                bf_HelpDesk.DataField = "con_nor";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);


                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Consignee";
                bf_HelpDesk.DataField = "Con_nee";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Bkg. Date";
                bf_HelpDesk.DataField = "dockdt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Comm. Dely. Date";
                bf_HelpDesk.DataField = "cdeldt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Last Location";
                bf_HelpDesk.DataField = "last_loc";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Dep Date";
                bf_HelpDesk.DataField = "dep_dt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Current Location";
                bf_HelpDesk.DataField = "curr_loc";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Delivery Location";
                bf_HelpDesk.DataField = "dly_loc";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Pkgs No.";
                bf_HelpDesk.DataField = "pkgsno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Charge Wt";
                bf_HelpDesk.DataField = "chrgwt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Arrival Date";
                bf_HelpDesk.DataField = "arrv_dt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Delivery Date";
                bf_HelpDesk.DataField = "dely_dt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
                GrdPaidFollow.Columns.Add(bf_HelpDesk);
            }
        }

    }
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        _counter = e.NewPageIndex * GrdPaidFollow.PageSize;
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["LoadUnload"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        GrdPaidFollow.DataBind();  
       
    }
    
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {

    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DocketDetail.csv"), false);
        //if (mode == "unused")
        //{
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = cn;
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.CommandText = "usp_Missing_Dockets_In_Range";
        //    cmd.Parameters.AddWithValue("@FromRange", docfrom);
        //    cmd.Parameters.AddWithValue("@ToRange", docto);
        //    SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //    if (cn.State == ConnectionState.Closed)
        //    {
        //        cn.Open();
        //    }
        //    sqlDA.Fill(ds, "LoadUnload");
        //}
        //else if (mode == "used")
        //{
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = cn;
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.CommandText = "webx_drill_dcr_register";
        //    cmd.Parameters.AddWithValue("@FromRange", docfrom);
        //    cmd.Parameters.AddWithValue("@ToRange", docto);
        //    SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //    if (cn.State == ConnectionState.Closed)
        //    {
        //        cn.Open();
        //    }
        //    sqlDA.Fill(ds, "LoadUnload");
        //}
        //DataTable dt2 = ds.Tables["LoadUnload"];// (DataTable)Session["dt1"];

        //int iColCount = dt2.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(dt2.Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);
        //// Now write all the rows.
        //foreach (DataRow dr in dt2.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();
        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("DocketDetail.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DocketDetail.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        GrdPaidFollow.AllowPaging = false;
        BindTheData();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(GrdPaidFollow);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
