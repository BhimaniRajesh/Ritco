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

public partial class GUI_Fleet_Operations_Issue_Popup_Driver : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;


    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //string sql;
    string Driver_WO_Vehicle = "N";
    cn.Open();

    string str = "";
     string sql = "Select * from WebX_Setup_Process";
       SqlCommand sqlcmd1 = new SqlCommand(sql, cn);
            SqlDataReader r1 = sqlcmd1.ExecuteReader();
            if (r1.Read())
            {
                if (r1["Driver_WO_Vehicle"] != null)
                {
                    Driver_WO_Vehicle = r1["Driver_WO_Vehicle"].ToString().Trim();
                }
            }
            r1.Close();



            if (Driver_WO_Vehicle == "N")
            {

                if (Session["VEHNO"] == null)
                {
                    Session["VEHNO"]="A";
                }

                else
                {


                    str = "select  IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'    and    VEHNO='" + Session["VEHNO"].ToString().Trim() + "' ";
                    string mBwdDriver = "";

                    //if (Session["brcd"].ToString().Trim() == "BWD")
                    //{

                    //    mBwdDriver = "";

                    //}
                    //else
                    //{
                    //    mBwdDriver = "and (Driver_Status='Available' OR Driver_Status is null)";

                    //}


                    str = str + mBwdDriver;  // +   "  Order by Driver_Name";

                }

            }


            if (Driver_WO_Vehicle == "Y")
            {

                //str = "select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name,ISNULL(Driver_Status,'Available') as Driver_Status  from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  and (Driver_Status='Available' OR Driver_Status is null)";//   Order by Driver_Name";
                str = "select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name,ISNULL(Driver_Status,'Available') as Driver_Status  from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  ";//   Order by Driver_Name";


            }

            



        if (txtDCode.Text != "" && txtDName.Text == "")
        {
           // sql = "Select Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST  where   ActiveFlag='Y'  and    Manual_Driver_Code like '" + txtDCode.Text.Trim() + "%' order by Driver_Name";

            sql = str + "   and    Manual_Driver_Code like '" + txtDCode.Text.Trim() + "%'" + " order by Driver_Name";
            
            
            cmd = new SqlCommand(sql, cn);
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            Label1.Text = "";
        }
       // else
            if (txtDName.Text != "" && txtDCode.Text == "")
            {
                sql = "Select Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST  where ActiveFlag  and    Driver_Name like '" + txtDName.Text.Trim() + "%' order by Driver_Name";
                sql = str + "     and    Driver_Name like '" + txtDName.Text.Trim() + "%'" + " order by Driver_Name ";
                
                
                cmd = new SqlCommand(sql, cn);
                adp = new SqlDataAdapter(cmd);
                ds = new DataSet();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                GridView1.Visible = true;
                Label1.Text = "";
            }
            //else
            //{ 
                
            //    Label1.Text = "Please select anyone"; 
            //    GridView1.Visible = false;
            //}

            if (txtDName.Text == "" && txtDCode.Text == "")
            {
                //sql = "Select Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST  where ActiveFlag='Y' order by Driver_Name";
                sql = "Select Manual_Driver_Code,Driver_Name,Driver_Status from WEBX_FLEET_DRIVERMST  where ActiveFlag='Y' and (Manual_Driver_Code is not null and Manual_Driver_Code != '' and Manual_Driver_Code != ' ')  order by Driver_Name";
                //sql = str + "order by Driver_Name ";
                cmd = new SqlCommand(sql, cn);
                adp = new SqlDataAdapter(cmd);
                ds = new DataSet();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                GridView1.Visible = true;
                Label1.Text = "";
            }





        cn.Close();

    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow )
        {
            //((TextBox)e.Row.FindControl("txtDocType")).Attributes.Add("OnBlur", "javascript:checkDocType(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("txtDocType")).ClientID.ToString() + ");");
            //DropDownList ddlRenewqlAutu = (DropDownList)e.Row.FindControl("ddlRenewqlAutu");
            //BindDropDown("USP_RENEWAUCODE", "CodeDesc", "CodeId", ddlRenewqlAutu);
            if (e.Row.Cells[3].Text != "Available")
            {
                e.Row.Cells[0].Enabled = false;
            }

        }
    }

        

}
