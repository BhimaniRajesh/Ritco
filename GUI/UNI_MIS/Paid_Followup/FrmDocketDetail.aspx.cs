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
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE");
    SqlConnection cn;
    string strqry;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strqry = Convert.ToString(Request.QueryString["str"]);
        //Name = Convert.ToString(Request.QueryString["Name"]);
        LblRptName.Text = "" + Convert.ToString(Request.QueryString["Name"]) + "  (" + Convert.ToString(Request.QueryString["RptName"].ToUpper()) + ")"; 
        if (!IsPostBack)
        {
            // strqry = Convert.ToString(Request.QueryString["str"]);
            BindTheData();
            ((Table)(GrdPaidFollow.Controls[0])).Rows[1].Cells[1].Text = Convert.ToString((Session["DocketCalledAs"]));
        }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        //SqlCommand cmd1 = new SqlCommand();
        cmd.Connection = cn;
        //cmd1.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = strqry;
        //cmd1.CommandText = "select count(*) as records from VW_UNI_PAID_Folleup";
        //cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        //cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        //cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "PaidFollow");
        // GrdPaidFollow.VirtualItemCount = 200;//Convert.ToInt32(cmd1.ExecuteScalar()); 
        GrdPaidFollow.DataSource = ds.Tables["PaidFollow"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);// 
        GrdPaidFollow.DataBind();
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdPaidFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
        BindTheData();
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
            E.Item.Cells[0].CssClass = "blackfnt";  
        }

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Paid_docket")
        {
            LinkButton l1;
            string a;
            l1 = (LinkButton)e.Item.FindControl("lblPaidDocket");
            a = l1.Text;
            Response.Redirect("FrmDocketDetail.aspx");
        }
    }

    protected void cmdprint_Click(object sender, EventArgs e)
    {
        SqlDataAdapter sqlDA = new SqlDataAdapter(strqry, cn);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "PaidFollow");
        Session["abc"] = ds;
        Response.Redirect("FrmRptDocketDTL.aspx?RPT=" + LblRptName.Text + "");
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DocketDtl.csv"), false);
        //SqlDataAdapter sqlDA = new SqlDataAdapter(strqry, cn);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "PaidFollow");

        //DataTable dt2 = ds.Tables["PaidFollow"];// (DataTable)Session["dt1"];

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
        //fs = System.IO.File.Open(Server.MapPath("DocketDtl.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DocketDtl.csv");
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
    //protected void GrdPaidFollow_ItemCreated(object sender, DataGridItemEventArgs e)
    //{
    //    //if (e.Item.ItemType == ListItemType.Header)//  DataControlRowType.Header)
    //    //{
    //    //    DataGrid oGridView = (DataGrid)sender;
    //    //    DataGridItem oGridViewRow = new DataGridItem(0, 0, ListItemType.Header); //  (0, 0, DataControlRowType.Header, DataControlRowState.Insert);
    //    //    TableCell oTableCell = new TableCell();
    //    //    oTableCell.HorizontalAlign = HorizontalAlign.Center;
    //    //    oTableCell.Font.Bold = true;
    //    //    oTableCell.Text = "LOCATION:-" + Convert.ToString(Request.QueryString["Name"]) + "  (" + Convert.ToString(Request.QueryString["RptName"].ToUpper()) + ")";
    //    //    oTableCell.ColumnSpan = 18;
    //    //    oTableCell.CssClass = "blackfnt";
    //    //    oGridViewRow.Cells.Add(oTableCell);
    //    //    oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
    //    //}
    //    //else if (e.Item.ItemType == ListItemType.Pager)
    //    //{
    //    //    GrdPaidFollow.PagerStyle.Position = PagerPosition.Bottom  ;
    //    //    GrdPaidFollow.PagerStyle.HorizontalAlign = HorizontalAlign.Center;     
    //    //}
    //}
}
