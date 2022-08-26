using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Issue_frmCloseJourneyQuery : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ClearData(object sender, EventArgs e)
    {
        txtID.Text = "";
        lblError.Text = "";
    }
    protected void CheckValid(object sender, EventArgs e)
    {
      
        string tmpcboID = cboID.SelectedValue;
        string tmpcboIDVal = txtID.Text;
        string tmp = tmpcboIDVal.Substring(0, 2);
        if (tmpcboID != tmp)
        {
            lblError.Text = "Invalid No.!!! Please check";
        }
        else
        {
            lblError.Text = "";
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {


        string strReqId = txtID.Text.ToString().Trim();
        conn.Open();
        string sql = "";
        string DataFoundFlag = "Not Found";

        Boolean tmp = strReqId.Contains("VS");
        if (tmp)
        {
            sql = "Select Request_Id from webx_fleet_vehicle_request where VSlipId='" + strReqId + "'";
            SqlCommand cmdREQ = new SqlCommand(sql, conn);
            cmdREQ.CommandType = CommandType.Text;
            SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
            while (dataReadREQ.Read())
            {
                strReqId = dataReadREQ["Request_Id"].ToString();
            }
            dataReadREQ.Close();
        }

        /*sql = "select V.VSlipNo,Convert(varchar,VSlipDt,106) VSlipDt,Vehno,R.Start_km "
                      + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
                      + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                      + " ,(Select valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt "
                      + " from WEBX_FLEET_VEHICLE_ISSUE v,webx_fleet_vehicle_request r "
                      + " where 1=1 "
                      + " and V.VSlipNo=r.VSlipId and r.Request_Id='" + strReqId + "'";
        */

        string VSlipId = "";
        string Start_km = "";
        string End_km = "";

        sql = "Select VSlipId,Start_km,End_km from webx_fleet_vehicle_request where Request_Id='" + strReqId + "'";
        SqlCommand cmdVI = new SqlCommand(sql, conn);
        cmdVI.CommandType = CommandType.Text;
        SqlDataReader dataReadVI = cmdVI.ExecuteReader();
        while (dataReadVI.Read())
        {
            DataFoundFlag = "Found";
            VSlipId = dataReadVI["VSlipId"].ToString();
            Start_km = dataReadVI["Start_km"].ToString();
            End_km = dataReadVI["End_km"].ToString();
            if (VSlipId == null || VSlipId=="")
            {
                lblError.Text = "Journey not yet started for this request!!!";
            }

            if (End_km != null && End_km!="")
            {
                lblError.Text = "Journey is already closed for this request!!!";
            }
            
           
        }
        dataReadVI.Close();

        if (DataFoundFlag == "Not Found")
        {
            lblError.Text = "Invalid No.";
        }



        if (lblError.Text == "")
        {
            Response.Redirect("frmCloseJourney.aspx?ReqId=" + txtID.Text.ToString().Trim());
        }
    }
}
