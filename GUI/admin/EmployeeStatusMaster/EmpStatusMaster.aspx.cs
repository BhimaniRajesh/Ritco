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

public partial class GUI_admin_EmployeeStatusMaster_EmpStatusMaster : System.Web.UI.Page
{

    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string i;
    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();

        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn.Open();
        //string sqlstr = "SELECT MAX(StatCD) from webx_Empstatus";
        //SqlCommand cmd = new SqlCommand(sqlstr, cn);
        //SqlDataReader dr = cmd.ExecuteReader();
        //if (dr.Read())
        //{
        //    i = dr[0].ToString();
        //}
        //dr.Close();
        //cn.Close();

    }



    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT statname FROM  webx_Empstatus";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["statname"] + "'"));
        }
        dr_Location.Close();
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

    public int getCode()
    {
        int maxVal = 0;
        cn.Open();
        string sql = "select right(max(statcd),2) from webx_Empstatus";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            maxVal = Convert.ToInt32(dr[0].ToString()); 
        }
        dr.Close();
        cn.Close();

        return maxVal = maxVal + 1;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int stCd;
        stCd = getCode();
        cn.Open();
        string sqlstr = "insert into webx_Empstatus(StatCD,statname,ACTIVEFLAG,UPDTBY,UPDTON)values('" + stCd + "','" + txtEmpStatus.Text + "' ,'" + txtActFlag.Text + "','" + Session["empcd"].ToString() + "','" + System.DateTime.Now.ToShortDateString() + "')";
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        cmd.ExecuteNonQuery();
        cn.Close();

        Response.Redirect("../company_structure.aspx");
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtEmpStatus.Text = "";
    }

    protected void txtEmpStatus_TextChanged(object sender, EventArgs e)
    {        
        txtEmpStatus.Text = txtEmpStatus.Text.ToUpper();

        if (txtEmpStatus.Text == "")
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
