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

public partial class GUI_admin_VehicleTypeMaster_VehicleTypeMasterAdd : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        getstring();
        if (!IsPostBack)
        {

            txtGrosVehicleWeight.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtUnladenWeight.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtPayload.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtRateKm.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtUpdtby.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            //txtUpdton.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtLength.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtWidth.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            txtHeight.Attributes.Add("onblur", "javascript:return Validate(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + ")");
            btnSubmit.Attributes.Add("onclick", "javascript:return checkblank(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + "," + txtUpdton.ClientID + "),enablepayload()");
            string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00$MyCPH1$txtPayload\").disabled = true;</script>";
            Page.RegisterStartupScript("aaa", js);            
        }

        //btnSubmit.Attributes.Add("onclick", "javascript:return SubmitData1(" + txtGrosVehicleWeight.ClientID + "," + txtUnladenWeight.ClientID + "," + txtPayload.ClientID + "," + txtRateKm.ClientID + "," + txtFuelType.ClientID + "," + txtUpdtby.ClientID + "," + txtUpdton.ClientID + "," + txtLength.ClientID + "," + txtWidth.ClientID + "," + txtHeight.ClientID + "," + txtVehicleManufacturerNm.ClientID + "," + txtVehicleNm.ClientID + "," + txtTypeDescription.ClientID + "," + txtModelNo.ClientID + ")");
    }
    private void getstring()
    {
        //airportstr = "";
        string sql = "SELECT Type_name FROM webx_vehicle_type";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["Type_name"] + "'"));
        }
        dr_Location.Close();
    }
    public string getNewCd()
    {
        int intCustCode = 1;

        //cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(Type_Code),2) as numeric(18, 0)) + 1 from webx_vehicle_type", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0].ToString());
        }

        drGet.Close();

        return  intCustCode.ToString().PadLeft(2, '0');
        
        //cn.Close();
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string nwCd = getNewCd();
        //cn.Open();
        txtUpdton.Text = fn.Mydate(txtUpdton.Text.Replace("'","''")); 
        string sqlAdd = "insert into webx_vehicle_type(Type_Code,Type_Name,Made_By,Model_No,Type_Desc,Capacity,Rate_Per_KM,Fuel_Type,ActiveFlag,UPDTBY,UPDTON,usedcapacity,payload,length,width,Height)values('" + nwCd + "','" + txtVehicleNm.Text.Replace("'", "''").Trim() + "','" + txtVehicleManufacturerNm.Text.Replace("'", "''").Trim() + "','" + txtModelNo.Text.Replace("'", "''").Trim() + "','" + txtTypeDescription.Text.Replace("'", "''").Trim() + "'," + txtGrosVehicleWeight.Text.Replace("'", "''").Trim() + "," + txtRateKm.Text.Replace("'", "''").Trim() + ",'" + txtFuelType.Text.Replace("'", "''").Trim() + "','" + txtActFlag.Text.Replace("'", "''").Trim() + "','" + txtUpdtby.Text.Replace("'", "''").Trim() + "','" + txtUpdton.Text.Replace("'", "''").Trim() + "'," + txtUnladenWeight.Text.Replace("'", "''").Trim() + "," + txtPayload.Text.Replace("'", "''").Trim() + "," + txtLength.Text.Replace("'", "''").Trim() + "," + txtWidth.Text.Replace("'", "''").Trim() + "," + txtHeight.Text.Replace("'", "''").Trim() + ")";
        SqlCommand cmd = new SqlCommand(sqlAdd, cn);
        cmd.ExecuteNonQuery();
        Response.Redirect("~/GUI/admin/operations.aspx");
        //cn.Close();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtVehicleNm.Text = "";
        txtVehicleManufacturerNm.Text = "";
        txtModelNo.Text = "";
        txtTypeDescription.Text = "";
        txtGrosVehicleWeight.Text = "";
        txtRateKm.Text = "";
        txtFuelType.Text = "";
        txtActFlag.Text = "";
        txtUpdtby.Text = "";
        txtUpdton.Text = "";
        txtUnladenWeight.Text = "";
        txtPayload.Text = "";
        txtLength.Text = "";
        txtWidth.Text = "";
        txtHeight.Text = "";
    }
}
