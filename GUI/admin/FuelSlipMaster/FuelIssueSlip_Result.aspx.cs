using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_FuelIssueSlip_Result : System.Web.UI.Page
{
    string QUserSlipNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        QUserSlipNo = Request.QueryString["QUserSlipNo"].ToString();
        if (!IsPostBack)
        {
            ShowDCRs();
        }
    }

    protected void ShowDCRs()
    {
        //tblDCR.Visible = true;
        //string strCMD = "Exec usp_Get_Fuel_Slip_Entry";
        //SqlDataSource1.SelectCommand = strCMD;
        //dgGeneral.DataBind();




        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //string str = "usp_Get_Fuel_Slip_Entry";
        //SqlCommand cmd = new SqlCommand(str, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@UserSlipNo", SqlDbType.VarChar).Value = QUserSlipNo;
        //cmd.ExecuteNonQuery();

        //SqlDataSource1.SelectCommand = str;
        //dgGeneral.DataBind();


        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd = new SqlCommand("SELECT VENDORNAME,VehicleNo,TripsheetNo, Convert(varchar, TripsheetOpenDate, 101)as TripsheetOpenDate, VendorCity,FuelType, UserSlipNo, Convert(varchar, UserSlipDate, 101)as UserSlipDate, Quantity,Rate,CASE WHEN FuelType='AddBlue' THEN Amount+ISNULL(IGST,0)+ISNULL(SGST,0)+ISNULL(CGST,0) ELSE Amount END As Amount,Remark FROM Webx_Fuel_Issue_Slip AS WIS INNER JOIN webx_VENDOR_HDR AS WVH ON WVH.VENDORCODE = WIS.VendorCode Where UserSlipNo IN (" + QUserSlipNo + ") ", con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        dgGeneral.DataSource = dt;
        con.Close();
        dgGeneral.DataBind();
    } 
}