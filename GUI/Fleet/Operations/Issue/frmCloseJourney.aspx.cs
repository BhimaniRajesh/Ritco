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

public partial class Issue_frmCloseJourney : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    //MyFleetDataSet.RequestDetRow datarow;
    string strReqId = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            strReqId = Request.QueryString["ReqId"];
            BindGrid();
        }

    }

    private void BindGrid()
    {
        conn.Open();
        string sql = "";
        
        Boolean tmp =strReqId.Contains("VS");
        if (tmp)
        {
            sql = "Select Request_Id from webx_fleet_vehicle_request where VSlipId='" + strReqId + "'";
            SqlCommand cmdREQ = new SqlCommand(sql, conn);
            cmdREQ.CommandType = CommandType.Text;
            SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
            while (dataReadREQ.Read())
            {
                strReqId=dataReadREQ["Request_Id"].ToString();
            }
            dataReadREQ.Close();
        }



        sql = "select V.VSlipNo,Convert(varchar,VSlipDt,106) VSlipDt,Vehno,R.Start_km "
                      + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
                      + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                      + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt "
                      + " from WEBX_FLEET_VEHICLE_ISSUE v,webx_fleet_vehicle_request r "
                      + " where 1=1 "
                      + " and V.VSlipNo=r.VSlipId and r.Request_Id='" + strReqId + "'";

        SqlCommand cmdVI = new SqlCommand(sql, conn);
         cmdVI.CommandType = CommandType.Text;
         SqlDataReader dataReadVI = cmdVI.ExecuteReader();
         while (dataReadVI.Read())
         {
             lblIssueNo.Text = dataReadVI["VSlipNo"].ToString();
             lblIssueDt.Text = dataReadVI["VSlipDt"].ToString();
             lblVehno.Text = dataReadVI["Vehno"].ToString();
             lblDriverName.Text = dataReadVI["driver_name"].ToString();
             lblLicno.Text = dataReadVI["License_no"].ToString();
             lblValidDt.Text = dataReadVI["valdity_dt"].ToString();
             lblStartKm.Text = dataReadVI["Start_km"].ToString();
         }
         dataReadVI.Close();




        SqlCommand cmd = new SqlCommand("usp_RequestViewPrintList", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@ReqId", strReqId);
        cmd.Parameters.AddWithValue("@ReqFromDt", "");
        cmd.Parameters.AddWithValue("@ReqToDt ", "");
        DataGrid1.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataGrid1.DataBind();
        conn.Close();
    }


    protected void SubmitData(object sender, EventArgs e)
    {

        lblError.Text = "";
        string StartKM, CloseKM;
        double mStartKM, mCloseKM;
        string mReqId = "";
        //txtCloseKM

        StartKM = lblStartKm.Text;
        CloseKM = txtCloseKM.Text;

        mStartKM = Convert.ToDouble(StartKM.ToString());
        mCloseKM = Convert.ToDouble(CloseKM.ToString());


        if (mCloseKM < mStartKM)
        {

            lblError.Text = "Closing KM should be greater than Starting KM.";
        }





        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";

        //DateTime righnow = System.DateTime.Today;
        //dtfi.DateSeparator = "/";
        //righnow = Convert.ToDateTime(righnow, dtfi);




        /*DateTime dtJourneyEdDt = new DateTime();
        dtReqDt = Convert.ToDateTime(DtCal.CalenderText(), dtfi);
        if (dtReqDt > righnow)
        {
            if (ErrMsg == "")
            {
                ErrMsg = "Error : Request Date can not be greater than system date.Please check !!!";
            }
        }*/







        if (lblError.Text == "")
        {
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {

                string End_time = cboEdDt_HH.SelectedItem.Value.ToString().Trim() + ":" + cboEdDt_MM.SelectedItem.Value.ToString().Trim() + " " + cboEdDt_AMPM.SelectedItem.Value.ToString().Trim();

                //foreach (DataGridItem gridrow in DataGrid1.Items)
                //{
                    SqlCommand Detail = new SqlCommand("usp_UpdateRequestVehicleIssue", conn, trans);
                    Detail.CommandType = CommandType.StoredProcedure;

                    //string mReqId = ((TextBox)gridrow.FindControl("txtReqId")).Text;

                    //datarow = _dataSet.RequestDet[gridrow.DataSetIndex];


                    Detail.Parameters.Add("@ReqId", SqlDbType.VarChar).Value = mReqId.Trim();
                    Detail.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
                    Detail.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.Text.ToString();
                    Detail.Parameters.Add("@Start_km", SqlDbType.VarChar).Value = lblStartKm.Text.ToString();
                    Detail.Parameters.Add("@End_km", SqlDbType.VarChar).Value = txtCloseKM.Text.ToString();
                    Detail.Parameters.Add("@IssueMode", SqlDbType.VarChar).Value = "CLOSE";
                    Detail.Parameters.Add("@End_dt", SqlDbType.DateTime).Value = Convert.ToDateTime(DtCalEdDt.CalenderText().ToString().Trim(), dtfi);
                    Detail.Parameters.Add("@End_tm", SqlDbType.VarChar).Value = End_time.Trim();




                   // _dataSet.RequestDet[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;

                    Detail.ExecuteNonQuery();
               // }
                trans.Commit();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
                Response.Redirect("frmCloseJourney_result.aspx?VSlipId=" + lblIssueNo.Text.ToString(), true);
        }

    }
    
   
    //txtCloseKM
}
