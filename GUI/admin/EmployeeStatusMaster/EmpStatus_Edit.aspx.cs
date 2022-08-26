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
using System.Text; 

public partial class GUI_admin_EmployeeStatusMaster_EmpStatus_Edit : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            ddEmpSt.Items.Add("--Select--"); 
            cn.Open();
            string sqlstr = "select StatName,statcd from webx_Empstatus";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            ddEmpSt.DataSource = ds;

            ddEmpSt.DataTextField = "StatName";
            ddEmpSt.DataValueField = "statcd";
            ddEmpSt.DataBind();







            //SqlDataReader dr = cmd.ExecuteReader();
            //while(dr.Read())
            //{
            //  ddEmpSt.Items.Add(new ListItem(dr.GetValue(0).ToString()));
            //}
            //dr.Close();
            //cn.Close();
        }
    }
    //protected void chk1_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chk1.Checked == true)
    //    {
    //        txtActFlag.Text = "Y";
    //    }
    //    else
    //    {
    //        txtActFlag.Text = "N";
    //    }

    //}
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("EmpStatusMaster.aspx");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Session["dEmpSt"] = ddEmpSt.SelectedValue;
        Response.Redirect("EmpSt_Update.aspx?para=" + "1");
        
        //object[] stcd = null;
        //cn.Open();
        //string sqlstcd= "select StatCD from webx_Empstatus";
        //SqlCommand cmdstcd = new SqlCommand(sqlstcd, cn);
        //SqlDataReader drstcd = cmdstcd.ExecuteReader();
        //if (drstcd.Read())
        //{
        //    stcd = new object[drstcd.FieldCount];
        //    drstcd.GetValues(stcd);
        //}
        //drstcd.Close();
        //cn.Close();

        //cn.Open();
        //string sqlstr = "update webx_Empstatus set UPDTBY='" + Session["empcd"].ToString() + "', statname ='" + ddEmpSt.SelectedValue.ToString() + "',ACTIVEFLAG='" + txtActFlag.Text + "',UPDTON= '" + System.DateTime.Now.ToShortDateString() + "'  where statcd='" + ddEmpSt.SelectedIndex + "'";
        //SqlCommand cmd = new SqlCommand(sqlstr, cn);
        //cmd.ExecuteNonQuery();
        //cn.Close();
    }
    protected void btnInactivate_Click(object sender, EventArgs e)
    {
        StringBuilder str = new StringBuilder();
        str.Append("<script language='javascript'>");
        str.Append("alert('Now It is InActivate Flag')");
        str.Append("</script>");
        RegisterStartupScript("asdf", str.ToString());

        //if (chk1.Checked == true && txtActFlag.Text == "Y")
        //{
        //    chk1.Checked = false;
        //    txtActFlag.Text = "N";
        //}

        cn.Open();
        string sqlstrVal = "update webx_Empstatus set ActiveFlag='N' where statcd='" + ddEmpSt.SelectedValue.ToString() + "'";
        SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
        cmdVal.ExecuteNonQuery();
        cn.Close();
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("Listall.aspx");
    }
}
