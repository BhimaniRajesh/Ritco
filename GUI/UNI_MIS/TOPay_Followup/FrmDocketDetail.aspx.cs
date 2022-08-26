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
    SqlConnection cn; // = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    string strqry;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strqry = Convert.ToString(Request.QueryString["str"]);
        strqry = strqry.Replace(":", "+");
        LblRptName.Text = "";
        LblRptName.Text = "" + Convert.ToString(Request.QueryString["Name"]) + "  (" + Convert.ToString(Request.QueryString["RptName"].ToUpper()) + ")"; 
        if (!IsPostBack)
        {
            
           // strqry = Convert.ToString(Request.QueryString["str"]);
            BindTheData();
            ((Table)(GrdToPayFollow.Controls[0])).Rows[1].Cells[1].Text = Convert.ToString((Session["DocketCalledAs"]));
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
        sqlDA.Fill(ds, "ToPay");
       // GrdPaidFollow.VirtualItemCount = 200;//Convert.ToInt32(cmd1.ExecuteScalar()); 
        GrdToPayFollow.DataSource = ds.Tables["ToPay"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);// 
        GrdToPayFollow.DataBind();
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdToPayFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
        BindTheData();
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
        //if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        //{
        //    E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        //    E.Item.Cells[0].CssClass = "blackfnt";  
        //}

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "ViewMR")
        {
            //LinkButton l1;
            //string a;
            //l1 = (LinkButton)e.Item.FindControl("lblPaidDocket");
            //a = l1.Text;
            //Response.Redirect("FrmDocketDetail.aspx");
        }
    }

    protected void cmdprint_Click(object sender, EventArgs e)
    {
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(strqry,cn);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "ToPay");
        Session["abc"] = ds;
        Response.Redirect("FrmToPayRptDocketDTL.aspx?RPT=" + LblRptName.Text + "");
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("ToPayFollowUp.csv"), false);

        ////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        //// First we will write the headers.
        //SqlDataAdapter sqlDA = new SqlDataAdapter(strqry, cn);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "ToPay");

        //DataTable dt2 = ds.Tables["ToPay"];// (DataTable)Session["dt1"];

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
        //fs = System.IO.File.Open(Server.MapPath("ToPayFollowUp.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "ToPayFollowUp.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        GrdToPayFollow.AllowPaging = false;
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
        frm.Controls.Add(GrdToPayFollow);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
