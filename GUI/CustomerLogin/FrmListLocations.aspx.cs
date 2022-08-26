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
public partial class GUI_admin_VehicleMaster_ListAll : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public string Client;
    protected void Page_Load(object sender, EventArgs e)
    {
        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/GUI/images/" + logo;

        if (Session["Client"] == "ASL")
        {
            Client = "ASL";
        }
        
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        lblcustname.Text = Convert.ToString(Session["custcd"]);
        if (IsPostBack == false)
        {
           bindGrid();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    public void bindGrid()
    {
        cn.Open();
        string sql,custloc,custlocstr;
        custlocstr = "";
        sql = "select custloc from webx_custhdr where custcd='" + Convert.ToString(Session["custcd"]) + "'";
        SqlCommand cmd = new SqlCommand(sql, cn);
        custloc = Convert.ToString(cmd.ExecuteScalar());
        string[] strarr=custloc.Split(',');
        for (int i = 0; i <= strarr.Length-1; i++)
        {
            custlocstr = custlocstr + "'" + Convert.ToString(strarr[i]) + "',";
        }
        if (strarr.Length > 0)
        {
            custlocstr = custlocstr.Substring(0,custlocstr.Length -1);
        }
        sql = "select loccode,locname,locaddr,'(T)'+locstdcode+'-'+loctelno +' (F)'+locfaxno as contactinfo,locemail from webx_location where loccode in (" + custlocstr + ")";
        cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dt.Columns.Add("Sr. No", typeof(int));
        dt.Columns["Sr. No"].AutoIncrement = true;
        dt.Columns["Sr. No"].AutoIncrementSeed = 1;
        dt.Columns["Sr. No"].AutoIncrementStep = 1;
        adp.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        cn.Close();
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
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
        frm.Controls.Add(GridView1);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}



