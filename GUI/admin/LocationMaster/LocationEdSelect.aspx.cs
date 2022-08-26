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

public partial class LocationEdSelect : System.Web.UI.Page
{

    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(comon.common.cnstr);

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        getstring();
        if (IsPostBack == false)
        {
            ddHir.Items.Add("--Select--");
            ddLoc.Items.Add("--Select--");

            cn.Open();
            //string sqlstr = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
            string sqlstr = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
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
    private void getstring()
    {
        string sql = "Select loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        cn.Open();
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
        cn.Close();
    }
    protected void ddHir_SelectedIndexChanged(object sender, EventArgs e)
    {

        //cn.Open();
        //string sqlstr = "Select distinct LocName + ' : ' + LocCode from webx_Location";
        //SqlCommand cmd = new SqlCommand(sqlstr, cn);
        //SqlDataReader dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    ddHir.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
        //}
        //dr.Close();
        //cn.Close();
        if (ddHir.SelectedItem.Text != "--Select--")
        {
            if (ddHir.SelectedValue == "Head Office")
            {
                ddLoc.Items.Clear();
                ddLoc.Items.Add("--Select--");
                cn.Open();
                //string mynwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";
                string mynwsqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' and codeid='1'  and activeflag='Y'";
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
                cn.Open();
                string sqlstr2 = "Select distinct LocName + ' : ' + LocCode from webx_Location where Loc_Level='" + ddHir.SelectedValue.ToString() + "'  and activeflag='Y'";
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
        else
        {
            ddLoc.Items.Clear();
            ddLoc.Items.Add("--Select--");
        }
        
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddLoc.aspx");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //string myVal;

        if (txtAcLoc.Text != "")
        {
            Session["tAcLoc"] = txtAcLoc.Text;
            Session["dHir"] = ""; // .SelectedIndex;
            Session["dLoc"] = "";
            Response.Redirect("LocationEdit.aspx");
            //string myVal1 = "?tAcLoc" + txtAcLoc.Text;
            //Server.Transfer("LocationEdit.aspx" + myVal1);
        }
        else
        if (ddHir.SelectedIndex > 0 && ddLoc.SelectedIndex >= 0)
        {
            Session["dHir"] = ddHir.SelectedValue; // .SelectedIndex;
            Session["dLoc"] = ddLoc.SelectedValue;
            Session["tAcLoc"] = "";
            Response.Redirect("LocationEdit.aspx");
            
            //string myVal = "?dHir" + ddHir.SelectedIndex;
            //myVal = myVal + "&dLoc" + ddLoc.SelectedValue.ToString();

            //Server.Transfer("LocationEdit.aspx" + myVal);
        }
        
    }
    protected void btnInactivate_Click(object sender, EventArgs e)
    {
       //StringBuilder str = new StringBuilder();
       string sqlstrVal;
        if (txtAcLoc.Text != "")
        {
           cn.Open(); 
           sqlstrVal = "update webx_location set ActiveFlag='N' where LocCode='" + txtAcLoc.Text.Trim() + "'";
           SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
           cmdVal.ExecuteNonQuery();
           cn.Close();  
        }
        else
            if (ddHir.SelectedIndex > 0 && ddLoc.SelectedIndex >= 0)
            {
                cn.Open();
                string[] strLocCode = ddLoc.SelectedValue.Split(':');
                string strSplt = strLocCode[1].Trim();
                sqlstrVal = "update webx_location set ActiveFlag='N' where LocCode='" + strLocCode[1].Trim() + "'";
                SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
                cmdVal.ExecuteNonQuery();
                cn.Close();
            }
    }
}
        
        
        
        
        //int strVal=0;
        //str.Append("<script language='javascript'>");
        //str.Append("alert('Now It is InActivate Flag')");
        //str.Append("</script>");
        //RegisterStartupScript("asdf", str.ToString());
        
        //if(strVal==1)
        //{
            //cn.Open();
            //string[] strLocCode = ddLoc.SelectedValue.Split(':');
            ////string[] strLocCode = ddLoc.ToString().Split(':');
            //string strSplt = strLocCode[1].Trim();//ddRptLoc.SelectedValue.Split(':');
            //string sqlstrVal = "update webx_location set ActiveFlag='N' where LocCode='" + strLocCode[1].Trim() + "'";
            //SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
            //cmdVal.ExecuteNonQuery();
            //cn.Close();
        //}
        //else
        //    if(strVal==0)
        //{
        //}
    
