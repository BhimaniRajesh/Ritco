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
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_admin_FuelSlipMaster_PendingFillingDate_View : System.Web.UI.Page
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
        SqlCommand cmd = new SqlCommand("SELECT VehicleNo,TripsheetNo, Convert(varchar, TripsheetOpenDate, 101)as TripsheetOpenDate, VendorCity,FuelType, UserSlipNo,Convert(varchar, FillingDate, 101)as FillingDate, Convert(varchar, UserSlipDate, 101)as UserSlipDate, Quantity,Rate,Amount,Remark FROM Webx_Fuel_Issue_Slip  Where UserSlipNo IN (" + QUserSlipNo + ") ", con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        dgGeneral.DataSource = dt;
        con.Close();
        dgGeneral.DataBind();
    } 
}