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



public partial class GUI_Fleet_Operations_Issue_Popup_Vehicle : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            hf_Opener_tb_SKU_Code.Value = Request.QueryString["Opener_tb_SKU_Code"].ToString();
        }


    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       
        string DataFound = "N";
        cn.Open();
        string msql = "select  TSWithVehicle_Valid ,TS_VehicleFilter_Loc from   WebX_Setup_Process";
        string TSWithVehicle_Valid = "", TS_VehicleFilter_Loc = "";

        string strValid = "", strLocFilter = "";
        SqlCommand sql1 = new SqlCommand(msql, cn);
        sql1.CommandType = CommandType.Text;
 
        SqlDataReader mr1 = sql1.ExecuteReader();
  
        if (mr1.HasRows)
        {
            while (mr1.Read())
            {


                TSWithVehicle_Valid = mr1["TSWithVehicle_Valid"].ToString().Trim();

                TS_VehicleFilter_Loc = mr1["TS_VehicleFilter_Loc"].ToString().Trim();

            }


        }
        mr1.Close();



        string STR1 = "select V.vehno from webx_vehicle_hdr V where 1=1  and  vendortype='05'";

        if (TSWithVehicle_Valid == "Y")
        {
                strValid = "   and   (V.Vehicle_Status='Available' or V.Vehicle_Status is null)";
       
        }


        strLocFilter = "   and conrtl_branch='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";

   
        if (txtVehNo.Text != "" )
        {

            sql=STR1 +  strLocFilter + "   and vehno like '" + txtVehNo.Text + "%' " + " order by VEHNO";
     
            cmd = new SqlCommand(sql, cn);
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            Label1.Text = "";
        }
      
         
            else
            { 
        
                sql = STR1 +  strLocFilter +   " order by VEHNO";
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


}
