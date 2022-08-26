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

public partial class GUI_admin_Employee_EmployeeEdSelect : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(comon.common.cnstr);

    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();
        getstring2();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (IsPostBack == false)
        {
            ddHir.Items.Add("--Select--");
            ddLoc.Items.Add("--Select--");
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();
            //string sqlstr = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
            string sqlstr = "select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='HRCHY' order by codeid asc";
            
            
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddHir.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();
            cn.Close();
        }

    }
    protected void ddHir_SelectedIndexChanged(object sender, EventArgs e)
    {

        //cn.Open();
        //string sqlstr = "select distinct LocName + ' : ' + LocCode from webx_Location";
        //SqlCommand cmd = new SqlCommand(sqlstr, cn);
        //SqlDataReader dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    ddHir.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
        //}
        //dr.Close();
        //cn.Close();



        if (ddHir.SelectedValue == "Head Office")
        {
            ddLoc.Items.Clear();
            ddLoc.Items.Add("--Select--");
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();
            //string mynwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";


            string mynwsqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and level_no='1' and statuscode='Y' order by level_no asc";
            
            SqlCommand mycmd1 = new SqlCommand(mynwsqlstr1, cn);
            SqlDataReader mynwdr1 = mycmd1.ExecuteReader();
            //ddRptTo.Items.Clear();
            while (mynwdr1.Read())
            {

                ddLoc.Items.Add(new ListItem(mynwdr1.GetValue(0).ToString(), mynwdr1.GetValue(1).ToString()));
            }
            mynwdr1.Close();
            cn.Close();
        }
        else
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
            cn.Open();
            string sqlstr2 = "select top 1 '--Select--' as a from webx_location  union select distinct LocName + ' : ' + LocCode as a from webx_Location where Loc_Level='" + ddHir.SelectedValue.ToString() + "'";
            //string sqlstr2 = "select distinct LocName + ' : ' + LocCode from webx_Location where Loc_Level='" + ddHir.SelectedValue.ToString() + "'";
            SqlCommand cmd2 = new SqlCommand(sqlstr2, cn);
            SqlDataReader dr2 = cmd2.ExecuteReader();
            ddLoc.Items.Clear();
            while (dr2.Read())
            {
                ddLoc.Items.Add(new ListItem(dr2.GetValue(0).ToString()));
            }
            dr2.Close();
            cn.Close();
        }
        
    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT empid FROM  webx_master_users";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["empid"] + "'"));
        }
        dr_Location.Close();
    }



    private void getstring2()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT userid FROM  webx_master_users";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["userid"] + "'"));
        }
        dr_Location.Close();
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("Employee_Add.aspx");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //string myVal;

        if (txtmgrid.Text != "")
        {
            Session["tEmpCode"] = txtmgrid.Text;
            Session["dHir"] = ""; // .SelectedIndex;
            Session["dLoc"] = "";
            Session["dEmp"] = "";
            Session["uid"] = "";
            Response.Redirect("Employee_Edit.aspx?para1="+"1");
            
        }
        if (txtuid.Text != "")
        {
            Session["tEmpCode"] = "";
            Session["dHir"] = ""; // .SelectedIndex;
            Session["dLoc"] = "";
            Session["dEmp"] = "";
            Session["uid"] = txtuid.Text;

            Response.Redirect("Employee_Edit.aspx?para1=" + "1");

        }
        else  if (ddHir.SelectedIndex > 0 && ddLoc.SelectedIndex >= 0)
            {
                //Session["dHir"] = ddHir.SelectedValue; // .SelectedIndex;
                //Session["dLoc"] = ddLoc.SelectedValue;
              Session["dEmp"] = ddEmployee.SelectedValue.ToString();
                Session["tEmpCode"] = ddEmployee.SelectedValue.ToString();
                Session["uid"] = "";
                Response.Redirect("Employee_Edit.aspx?para1="+"1");

                 
            }

    }
    protected void btnInactivate_Click(object sender, EventArgs e)
    {
        StringBuilder str = new StringBuilder();
        //int strVal=0;
        str.Append("<script language='javascript'>");
        str.Append("alert('Now It is InActivate Flag')");
        str.Append("</script>");
        RegisterStartupScript("asdf", str.ToString());

        //if(strVal==1)
        //{
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string[] strLocCode = ddLoc.SelectedValue.Split(':');
        //string[] strLocCode = ddLoc.ToString().Split(':');
        string strSplt = strLocCode[1].Trim();//ddRptLoc.SelectedValue.Split(':');
        string sqlstrVal = "update webx_location set ActiveFlag='N' where LocCode='" + strLocCode[1].Trim() + "'";
        SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
        cmdVal.ExecuteNonQuery();
        cn.Close();
        
    }
    protected void ddLoc_SelectedIndexChanged(object sender, EventArgs e)
    {
        string[] strLocCode = ddLoc.SelectedValue.Split(':');
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sqlstr2 = "select  name + ' : ' +  empid + ' : ' + userid  as a,EMPiD from webx_master_users  where BranchCode='" + strLocCode[1].Trim() + "' order by name"; // order by EMPNM,EMPCD";

        SqlCommand cmd2 = new SqlCommand(sqlstr2, cn);

        SqlDataAdapter da = new SqlDataAdapter(cmd2);
        DataSet dds = new DataSet();
        da.Fill(dds);

        ddEmployee.DataSource=dds;
        ddEmployee.DataTextField = "a";
        ddEmployee.DataValueField = "EMPiD";

        ddEmployee.DataBind();


    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("Listall.aspx");
    }
}
