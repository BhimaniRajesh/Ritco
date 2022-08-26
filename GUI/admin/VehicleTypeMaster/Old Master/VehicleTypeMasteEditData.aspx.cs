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
using System.Globalization; 
public partial class GUI_admin_VehicleTypeMaster_VehicleTypeMasteEditData : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string vhType;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if(IsPostBack == false)
        {
            cn.Open();
            vhType = Session["vhType"].ToString().Trim();
            lblVhTypCd.Text = vhType;
            getData();
            getvehicletypestring();
        }
    }
    protected void getvehicletypestring()
    {
        string sql = "select type_name from webx_vehicle_type where type_name<>'" + txtVehicleNm.Text + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["type_name"].ToString().ToUpper() + "'"));
        }
        dr_Location.Close();
        cn.Close();
    }
    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N"; 
        }
    }
    public void getData()
    {
       
        string sqlGet = "select Type_Name,Made_By,Model_No,Type_Desc,Capacity,Rate_Per_KM,Fuel_Type,ActiveFlag,UPDTBY,convert(varchar,UPDTON,103) as UPDTON,usedcapacity,payload,length,width,Height from webx_vehicle_type where Type_Code = '" + vhType + "'";  
        SqlCommand cmd = new SqlCommand(sqlGet,cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if(dr.Read());
        {
        txtVehicleNm.Text = dr["Type_Name"].ToString(); 
        txtVehicleManufacturerNm.Text = dr["Made_By"].ToString();
        txtModelNo.Text = dr["Model_No"].ToString();
        txtTypeDescription.Text = dr["Type_Desc"].ToString();
        txtGrosVehicleWeight.Text = dr["Capacity"].ToString();
        txtRateKm.Text = dr["Rate_Per_KM"].ToString();
        txtFuelType.Text = dr["Fuel_Type"].ToString();
        txtActFlag.Text = dr["ActiveFlag"].ToString();
        txtUpdtby.Text = dr["UPDTBY"].ToString();
        txtUpdton.Text = dr["UPDTON"].ToString();
        txtUnladenWeight.Text = dr["usedcapacity"].ToString();
        txtPayload.Text = dr["payload"].ToString();
        txtLength.Text = dr["length"].ToString();
        txtWidth.Text = dr["width"].ToString();
        txtHeight.Text = dr["Height"].ToString(); 
            if(txtActFlag.Text == "Y")
            {
                c1.Checked = true;
            }
        }
        dr.Close();
        //cn.Close();
    }
    string sdate;
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        //CultureInfo MyCultureInfo = new CultureInfo("en-US");
        //DateTimeFormatInfo dtf = new System.Globalization.DateTimeFormatInfo();
        //string s = dtf.ShortDatePattern;
        //dtf.ShortDatePattern = "d/M/yyyy";
        //MyCultureInfo.DateTimeFormat = dtf;
        //System.Threading.Thread.CurrentThread.CurrentCulture = MyCultureInfo;
        //Array str;
        //str = txtUpdton.Text.Split('/');
        //sdate = ((string[])(str))[1] + "/" + ((string[])(str))[0] + "/" + ((string[])(str))[2];
        sdate = fn.Mydate(txtUpdton.Text.Replace("'","''"));  
        string sqlUpdt = "update webx_vehicle_type set Type_Name='" + txtVehicleNm.Text.Replace("'", "''").Trim() + "',Made_By='" + txtVehicleManufacturerNm.Text.Replace("'", "''").Trim() + "',Model_No='" + txtModelNo.Text.Replace("'", "''").Trim() + "',Type_Desc='" + txtTypeDescription.Text.Replace("'", "''").Trim() + "'," +
                         "Capacity=" + txtGrosVehicleWeight.Text.Replace("'", "''").Trim() + ",Rate_Per_KM=" + txtRateKm.Text.Replace("'", "''").Trim() + ",Fuel_Type='" + txtFuelType.Text.Replace("'", "''").Trim() + "',ActiveFlag='" + txtActFlag.Text.Replace("'", "''").Trim() + "'," +
                         "UPDTBY='" + txtUpdtby.Text.Replace("'", "''").Trim() + "',UPDTON='" + sdate + "',usedcapacity=" + txtUnladenWeight.Text.Replace("'", "''").Trim() + ",payload=" + txtPayload.Text.Replace("'", "''").Trim() + "," +
                         "length=" + txtLength.Text.Replace("'", "''").Trim() + ",width=" + txtWidth.Text.Replace("'", "''").Trim() + ",Height=" + txtHeight.Text.Replace("'", "''").Trim() + " where Type_Code = '" + vhType + "'";
        SqlCommand cmd = new SqlCommand(sqlUpdt, cn);
        cmd.ExecuteNonQuery();
        cn.Close();
        Response.Redirect("~/GUI/admin/operations.aspx");
    }
    //protected void btnReset_Click(object sender, EventArgs e)
    //{
    //    txtVehicleNm.Text = "";
    //    txtVehicleManufacturerNm.Text = "";
    //    txtModelNo.Text = "";
    //    txtTypeDescription.Text = "";
    //    txtGrosVehicleWeight.Text = "";
    //    txtRateKm.Text = "";
    //    txtFuelType.Text = "";
    //    txtActFlag.Text = "";
    //    txtUpdtby.Text = "";
    //    txtUpdton.Text = "";
    //    txtUnladenWeight.Text = "";
    //    txtPayload.Text = "";
    //    txtLength.Text = "";
    //    txtWidth.Text = "";
    //    txtHeight.Text = "";
    //}
}


