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

public partial class GUI_admin_EmployeeStatusMaster_EmpSt_Update : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string i;
    public static string ssdEmpSt;
    public static string strActualLocationCode;
    public static string getStCd;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtActFlag.Attributes.Add("onblur", "javascript:return IsYN(this)");
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            if (!IsPostBack)
        {
            
            string para = "";
            para=Request.QueryString["para"].ToString();
            if(para == "1")
            {
            
                    ssdEmpSt = Session["dEmpSt"].ToString().Trim();
                    getData();
            }
            else
            {
                     ssdEmpSt = Request.QueryString["stnm"].ToString();
                     getData();
                
            }


            ////cn.Open();
            ////string sqlgetStCd = "select StatCD from webx_Empstatus where StatName = '" + ssdEmpSt + "'";
            ////SqlCommand cmd = new SqlCommand(sqlgetStCd, cn);
            ////SqlDataReader dr = cmd.ExecuteReader();
            ////if (dr.Read())
            ////{
            ////    getStCd = dr["StatCD"].ToString(); 
            ////}
            ////dr.Close();
            ////cn.Close(); 
        }
    }

    public void getData()
    {
        cn.Open();
        string sql = "select StatName, activeflag from webx_Empstatus where Statcd = '" + ssdEmpSt + "'";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        string s="Sa";
        while (dr.Read())
        {
            s  = dr["StatName"].ToString();
            strActualLocationCode = txtEmpStatus.Text;
            txtEmpStatus.Text = s;
            txtActFlag.Text = dr["activeflag"].ToString();
            if (txtActFlag.Text == "Y")
            {
                chk1.Checked = true;
            }
            else
            {
                chk1.Checked = false;
            }
        }
        dr.Close();
        cn.Close();

         txtEmpStatus.Text=  s;
    }
    protected void chk1_CheckedChanged(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        string sqlstr = "update webx_Empstatus set UPDTBY='" + Session["empcd"].ToString() + "', statname ='" + txtEmpStatus.Text + "',ACTIVEFLAG='" + txtActFlag.Text + "',UPDTON= '" + System.DateTime.Now.ToShortDateString() + "' where statcd='" + ssdEmpSt + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        cmd.ExecuteNonQuery();
        cn.Close();

        Response.Redirect("EmpStatus_Edit.aspx"); 
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtEmpStatus.Text = "";
    }

    protected void txtEmpStatus_TextChanged(object sender, EventArgs e)
    {
        txtEmpStatus.Text = txtEmpStatus.Text.ToUpper();

        if (txtEmpStatus.Text == "" || txtEmpStatus.Text.ToUpper() == strActualLocationCode.ToUpper())
        {
            lblErrorEmpStNm.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT StatName FROM webx_Empstatus WHERE StatName = '" + txtEmpStatus.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorEmpStNm.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            txtEmpStatus.Focus();
        }

        sqlConn.Close();
    }

}
