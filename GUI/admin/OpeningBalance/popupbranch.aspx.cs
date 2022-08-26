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

public partial class GUI_admin_OpeningBalance_popupbranch : System.Web.UI.Page
{
    //public static string strQSParam;
    //SqlConnection cn;
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }
        //if (IsPostBack == false)
        //{
        //    strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
        //    cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //    //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
        //    //SqlConnection cn = new SqlConnection(comon.common.cnstr);
        //    string sql = "Select loccode,locname from webx_Location where activeflag='Y' order by locname";
        //    SqlCommand cmd = new SqlCommand(sql, cn);
        //    SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    adp.Fill(dt);
        //    //dt.Columns.Add("Select", typeof(RadioButton));
        //    //dt.Columns["Select"].AutoIncrement = true;
        //    GridView1.DataSource = dt;
        //    GridView1.DataBind();

        //}
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        string sql = "select loccode,locname from webx_location where ActiveFlag='Y' and LocCode like'" + custcode + "%' and LocName Like '" + custname + "%'order by Locname";
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();
    }
}
