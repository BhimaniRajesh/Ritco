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
using System.Data.SqlTypes;

public partial class GUI_admin_HierarchyMaster_HierarchyMaster : System.Web.UI.Page
{
    SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string maxlevel, level;
    public int lvlcode,newCode;
    public string LevelNo;
    public int LevelNumber;
    public string editLevelNo, level_info = "", empcd="";
   
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        editLevelNo =Convert.ToString(Request.QueryString["editLevelNo"]);
        if (!Page.IsPostBack)
        {
            if (editLevelNo == null || editLevelNo == "")
            {
                //SqlDataReader drLevelInfo;
                //conn.Open();
                //cmd.CommandText = "select max(Level_no) as Level from WEBX_Hierarchy";
                //cmd.Connection = conn;
                //drLevelInfo = cmd.ExecuteReader();
                //while (drLevelInfo.Read())
                //{
                //    maxlevel = drLevelInfo["Level"].ToString();
                //}
                //drLevelInfo.Close();
                //conn.Close();
                //newCode = Convert.ToInt32(maxlevel);
                //newCode = newCode + 1;
               
            }
            else
            {

                conn.Open();
                SqlDataReader dr1;
                cmd.CommandText = "select * from WEBX_Hierarchy where Level_No='" + editLevelNo + "'";
                cmd.Connection = conn;
                dr1 = cmd.ExecuteReader();
                while (dr1.Read())
                {
                    lblLevel.Text = dr1["Level_No"].ToString();
                    TextBox2.Text = dr1["Level_Type"].ToString();

                    
                }
                dr1.Close();
                conn.Close();



                
            }
            
        } 
   
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        empcd = Session["empcd"].ToString().Trim();

        if (editLevelNo == "" || editLevelNo == null)
        {
            SqlDataReader drLevelInfo;
            conn.Open();

            cmd.CommandText = "select max(Level_no) as Level from WEBX_Hierarchy";
            cmd.Connection = conn;
            drLevelInfo = cmd.ExecuteReader();
            while (drLevelInfo.Read())
            {
                maxlevel = drLevelInfo["Level"].ToString();
            }
            drLevelInfo.Close();
           
            newCode = Convert.ToInt32(maxlevel);
            newCode = newCode + 1;

            
            string sql = "Insert into WEBX_Hierarchy (Level_No,Level_Type,EntryBy,UpdtDt) values (" + newCode + ",'" + TextBox2.Text + "','" + empcd + "',getdate())";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.ExecuteNonQuery();
            
            Response.Redirect("HierarchyList.aspx");
            conn.Close();

        }
        else
        {
            conn.Open();
            string updtstring = "Update WEBX_Hierarchy set Level_Type='" + TextBox2.Text + "',EntryBy='" + empcd + "',UpdtDt=getdate() where Level_No='" + editLevelNo + "'";
            SqlCommand sqlcmd2 = new SqlCommand(updtstring, conn);
            sqlcmd2.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("HierarchyList.aspx");
            conn.Close();
        }
        
        

    }
    
    
    
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox2.Text = "";
    }
}
