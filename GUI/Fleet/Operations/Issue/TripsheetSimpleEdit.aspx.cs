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
public partial class GUI_Fleet_Operations_Issue_TripsheetSimpleEdit : System.Web.UI.Page
{

    private double sum = 0;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    string stVSlipId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        //UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        //DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        //TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        //TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        //TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        //txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this)");
        txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtManualTripSheetNo.ClientID.ToString() + "').focus();");


        // string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
        //   cmdSubmit.Attributes.Add("onClick", aa);
      //  string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
      //  cmdSubmit.Attributes.Add("onClick", aa);
        //  checkRadio

        //   chksel.Attributes.Add("onClick", checkRadio());


        stVSlipId = Request.QueryString["id"];
        if (!IsPostBack)
        {
            conn.Open();
            //  stVSlipId = Request.QueryString["id"];


            Session["Tripsheet"] = null;

            Session["Tripsheet"] = stVSlipId;

           // Previous_advance();

            string sql = "select V.VSlipNo,V.Manual_tripsheetno,Convert(varchar,VSlipDt,103) VSlipDt,V.Vehicleno as vehno,f_issue_startkm as Start_km,f_issue_fill ,v.from_city,v.To_city  "
                     + " ,(Select Manual_driver_code from webx_fleet_drivermst where Driver_Id=v.driver1) Manual_driver_code "
                     + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                     + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt,v.driver1,v.CustCode,v.Category,v.Market_Own ,Tripsheet_StartLoc,Tripsheet_EndLoc ,(Select custnm  from webx_CUSTHDR  where custcd=v.CustCode) as Custname "
                     + " from WEBX_FLEET_VEHICLE_ISSUE v LEFT OUTER JOIN webx_fleet_vehicle_request r ON V.VSlipNo=r.VSlipId"
                     + " where 1=1"
                     + " and V.VSlipNo='" + stVSlipId + "'";

            SqlCommand cmdVI = new SqlCommand(sql, conn);
            cmdVI.CommandType = CommandType.Text;
            SqlDataReader dataReadVI = cmdVI.ExecuteReader();
            while (dataReadVI.Read())
            {
                lblIssueNo.Text = Session["Tripsheet"].ToString();
                txtTripDate.Text = dataReadVI["VSlipDt"].ToString();
                txtVehNo.Text = dataReadVI["Vehno"].ToString();
                txtDriver1.Text = dataReadVI["Manual_driver_code"].ToString();
                hdfldManualDriverCode.Value = dataReadVI["Manual_driver_code"].ToString();

                lblStartLoc.Text = dataReadVI["Tripsheet_StartLoc"].ToString();

                lblEndLoc.Text = dataReadVI["Tripsheet_EndLoc"].ToString();
                txtManualTripSheetNo.Text = dataReadVI["Manual_tripsheetno"].ToString();



                string mCategory = dataReadVI["Category"].ToString();

                for (int i = 0; i < ddlCategory.Items.Count; i++)
                {
                    if (mCategory == ddlCategory.Items[i].Value.ToString().Trim())
                    {
                        ddlCategory.SelectedIndex = i;
                    }

                }


                string m_custCode = "", m_Market = "";
                m_custCode = dataReadVI["CustCode"].ToString();

                m_Market = dataReadVI["mARKET_oWN"].ToString().Trim();


                txtFromCity.Text = dataReadVI["from_city"].ToString().Trim();

                txtToCity.Text = dataReadVI["To_city"].ToString().Trim();


                if (mCategory == "External Usage")
                {
                    Table1.Visible = true;

                    lblCutcode.Visible = true;
                    lblMarket_own.Visible = false;
                    txtCustCode.Visible = true;
                    txtCustCode.Text = m_custCode.Trim();

                    ddlMarket.Visible = false;
                    lblPopup.Visible = true;
                }
                if (mCategory == "Internal Usage")
                {



                    Table1.Visible = true;
                    lblCutcode.Visible = false;
                    lblMarket_own.Visible = true;
                    lblPopup.Visible = false;
                    txtCustCode.Visible = false;
                    ddlMarket.Visible = true;

                    m_Market = dataReadVI["mARKET_oWN"].ToString().Trim();

                    for (int i = 0; i < ddlMarket.Items.Count; i++)
                    {
                        if (m_Market == ddlMarket.Items[i].Value.ToString().Trim())
                        {
                            ddlMarket.SelectedIndex = i;
                        }

                    }


                }







            }
            dataReadVI.Close();

            //     BindGrid();


            string scr4 = @"<script>
                    function update_city1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtFromCity').value=elemValue;
                     //document.getElementById('ctl00_MyCPH1_txtFromCity').focus();

                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city1", scr4);


            string scr5 = @"<script>
                    function update_city2(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtToCity').value=elemValue;
                     //document.getElementById('ctl00_MyCPH1_txtToCity').focus();
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city2", scr5);


            //     Previous_advance();

        }

        //  Inetializ();



        lblIssueNo.Text = Session["Tripsheet"].ToString().Trim();


    }


    public void CheckCity(object sender, EventArgs e)
    {

        TextBox txt = (TextBox)sender;



        lblFromCity.Text = "";
        lblToCity.Text = "";
        string mCity = "";
        string DataFoundFlag = "N";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (txt.ID == "txtFromCity" || txt.ID == "txtToCity")
        {
            mCity = txt.Text;
        }


        string sql = "Select Location from webx_citymaster where Location='" + mCity + "' and ActiveFlag='Y'";
        SqlCommand cmdREQ = new SqlCommand(sql, conn);
        cmdREQ.CommandType = CommandType.Text;
        conn.Open();
        SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
        while (dataReadREQ.Read())
        {
            DataFoundFlag = "Y";
        }
        dataReadREQ.Close();
        conn.Close();

        if (DataFoundFlag == "N")
        {

            if (txt.ID == "txtFromCity")
            {
                lblFromCity.Text = "Invalid From City. !!!Please check.";
            }
            else
            {
                lblToCity.Text = "Invalid To City. !!!Please check.";
            }
        }

    }

    public void CheckManualDriverValid()
    {
        if (txtDriver1.Text.Trim() != "")
        {
            string DataFound = "N";
            string mcnt = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string mDriverId1 = "";
            string mManualDriverCode = "";
            lblD1Error.Visible = false;
            lblD1Error.Text = "";
            conn.Open();
            string sqlD1 = "Select Driver_Id,Driver_Status,Manual_Driver_Code ,(SELECT Count(*) FROM WEBX_TRIPSHEET_ADVEXP D WHERE D.Tripsheetno = '" + lblIssueNo.Text + "' FOR XML PATH('') ) as cnt from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='" + txtDriver1.Text.Trim() + "'";
            SqlCommand cmdD1 = new SqlCommand(sqlD1, conn);
            cmdD1.CommandType = CommandType.Text;

            SqlDataReader drD1 = cmdD1.ExecuteReader();
            while (drD1.Read())
            {
                DataFound = "Y";
                mDriverId1 = Convert.ToString(drD1["Driver_ID"]);
                mcnt = Convert.ToString(drD1["cnt"]);
                mManualDriverCode = Convert.ToString(drD1["Manual_Driver_Code"]);

                if (Convert.ToString(drD1["Driver_Status"]) == "In Transit")
                {
                    lblD1Error.Visible = true;
                    lblD1Error.Text = "Driver1 is already In-Transit!";
                }
                if (mcnt != "0")
                {
                    lblD1Error.Visible = true;
                    lblD1Error.Text = "Advance payment is already made for this driver !!! Hence driver can not be changed";
                }
                if (hdfldManualDriverCode.Value == txtDriver1.Text.Trim())
                {
                    lblD1Error.Visible = false;
                    lblD1Error.Text = "";
                }
            }
            drD1.Close();



            if (DataFound == "N")
            {
                lblD1Error.Visible = true;
                lblD1Error.Text = "Driver1 Code Is InValid!";


            }
            else
            {



            }


        }

        else
        {


        }
    
    }

    public void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {

        CheckManualDriverValid();
        


    }


    protected void txtVehNo_TextChanged(object sender, EventArgs e)
    {
        string Driver_WO_Vehicle = "N";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string DataF = "N";

        string mVehNo = "";
        string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + txtVehNo.Text.Trim() + "'";
        SqlCommand stCmd = new SqlCommand(mSTR, conn);
        SqlDataReader stDr = stCmd.ExecuteReader();
        if (stDr.HasRows)
        {
            while (stDr.Read())
            {

                mVehNo = Convert.ToString(stDr["vehno"]);

                DataF = "Y";
            }

        }

        stDr.Close();

        if (DataF.Trim() == "N")
        {
            lblVehCheck.Visible = true;

            lblVehCheck.Text = "Vehicle No. is not Valid!";

        }

        else
        {

            lblVehCheck.Visible = false;

            lblVehCheck.Text = "";

        }

        Session["VEHNO"] = null;
        Session["VEHNO"] = txtVehNo.Text.Trim();


    }


    public void Check_ManualTripSheetNo(object sender, EventArgs e)
    {
        lblMTS.Text = "";
        string DataFoundFlag = "N";


        if (txtManualTripSheetNo.Text.Trim() != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string sql = "Select * from WEBX_FLEET_VEHICLE_ISSUE where Manual_TripSheetNo='" + txtManualTripSheetNo.Text.Trim() + "'   and VSlipNo<>'" + Session["Tripsheet"].ToString().Trim() + "'";
            SqlCommand cmdREQ = new SqlCommand(sql, conn);
            //   cmdREQ.CommandType = CommandType.Text;
            conn.Open();
            SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();

            //if (dataReadREQ.HasRows)
            //{
            while (dataReadREQ.Read())
            {
                DataFoundFlag = "Y";
            }
            //}



            // string str = dataReadREQ[0].ToString();
            dataReadREQ.Close();
            conn.Close();


            if (DataFoundFlag == "Y")
            {
                lblMTS.Text = "Duplicate Manual Trip Sheet No. !!!Please check.";
            }
        }

    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
          string mTripSheetNo = "";
          string DataFoundFlag = "N";

          System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
          System.Globalization.DateTimeFormatInfo year = new System.Globalization.DateTimeFormatInfo();
          dtfi.ShortDatePattern = "dd/MM/yyyy";
          dtfi.DateSeparator = "/";
          dtfi.ShortTimePattern = "hh:mm tt";

          DateTime TripDate = new DateTime();
          TripDate = Convert.ToDateTime(txtTripDate.Text.Trim(), dtfi);
          DateTime mServerDt = DateTime.Now;

          if (TripDate > mServerDt)
          {

              lblError.Text = "Tripsheet Date cannot be future Date!";

          }





        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "Select * from WEBX_FLEET_VEHICLE_ISSUE where Manual_TripSheetNo='" + txtManualTripSheetNo.Text.Trim() + "'   and VSlipNo<>'" + Session["Tripsheet"].ToString().Trim() + "'";
        SqlCommand cmdREQ = new SqlCommand(sql, conn);
       
        conn.Open();
        SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();

        while (dataReadREQ.Read())
        {
            DataFoundFlag = "Y";
        }
      
        dataReadREQ.Close();
        conn.Close();


        if (DataFoundFlag == "Y")
        {
            lblMTS.Text = "Duplicate Manual Trip Sheet No. !!!Please check.";
        }



        CheckManualDriverValid();


       

        if (lblError.Text == "" && lblMTS.Text == "" && lblVehCheck.Text.Trim() == "" && lblD1Error.Text=="")
        {

            mTripSheetNo = lblIssueNo.Text.ToString();
         //   SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            string mBranchCode = "";
            try
            {



                string mDriverId1 = "";

                string stDriver1 = "Select Driver_Id from WEBX_FLEET_DRIVERMST  where Manual_Driver_Code ='" + txtDriver1.Text.Trim() + "'";
                SqlCommand stCmd1 = new SqlCommand(stDriver1, conn, trans);
                SqlDataReader stDr1 = stCmd1.ExecuteReader();

                if (stDr1.HasRows)
                {
                    while (stDr1.Read())
                    {
                        mDriverId1 = Convert.ToString(stDr1["Driver_ID"]);

                    }


                }

                stDr1.Close();


                string sqlUp = "usp_EditUpdateAdvExp_acctrans";
                SqlCommand sqlcmdUp = new SqlCommand(sqlUp, conn, trans);
                sqlcmdUp.CommandType = CommandType.StoredProcedure;
                sqlcmdUp.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = Session["Tripsheet"].ToString().Trim();// Session["brcd"].ToString();
                sqlcmdUp.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehNo.Text.Trim();
                sqlcmdUp.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = mDriverId1.Trim();
                sqlcmdUp.Parameters.Add("@ManualTripNo", SqlDbType.VarChar).Value = txtManualTripSheetNo.Text.Trim();
                sqlcmdUp.Parameters.Add("@category", SqlDbType.VarChar).Value = ddlCategory.SelectedItem.Text.Trim(); ;


                sqlcmdUp.Parameters.Add("@custCode", SqlDbType.VarChar).Value = txtCustCode.Text.Trim();// Session["brcd"].ToString();
                sqlcmdUp.Parameters.Add("@Market", SqlDbType.VarChar).Value = ddlMarket.SelectedItem.Text.Trim();
                sqlcmdUp.Parameters.Add("@Fromcity", SqlDbType.VarChar).Value = txtFromCity.Text.Trim();
                sqlcmdUp.Parameters.Add("@Tocity", SqlDbType.VarChar).Value = txtToCity.Text.Trim();
             
                // New Change
                sqlcmdUp.Parameters.Add("@TripDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtTripDate.Text.Trim(),dtfi);
                
                
                
                sqlcmdUp.ExecuteNonQuery();

                //string mstr2 = "update webx_tripsheet_advexp  set Voucher_cancel='Y'  where  tripsheetno='" + Session["Tripsheet"].ToString().Trim() + "'  ";
                //SqlCommand mcmd2 = new SqlCommand(mstr2, conn, trans);
                //mcmd2.ExecuteNonQuery();


                //string mstr3 = "update webx_acctrans_08_09  set Voucher_cancel='Y'  where  Docno='" + Session["Tripsheet"].ToString().Trim() + "'  ";
                //SqlCommand mcmd3 = new SqlCommand(mstr3, conn, trans);
                //mcmd3.ExecuteNonQuery();






              


             



                trans.Commit();
                //trans.Rollback();
                success = true;
                Session["strDriverCode"] = null;
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
            {
                string mFlag = "U";

                //    Response.Redirect("~/admin/lenseprice.aspx?code=" + Code + "&LenseId=" + LenseId);

                Response.Redirect("EditTripResult.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mFlag=" + mFlag, true);

            }


        }


    }


    protected void txtCustCode_TextChanged1(object sender, EventArgs e)
    {
        if (txtCustCode.Text.ToString().Trim() != "")
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string DataFound = "N";
            string str = "Select * from webx_CUSTHDR where CUST_ACTIVE='Y' and custcd='" + txtCustCode.Text.ToString().Trim() + "'";
            SqlCommand cmd = new SqlCommand(str, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    DataFound = "Y";

                }
            }
            dr.Close();
            conn.Close();
            if (DataFound == "N")
            {


                lblErrorLocation1.Visible = true;

                lblErrorLocation1.Text = "Invalid Customer Code";
            }
            else
            {
                lblErrorLocation1.Text = "";

                lblErrorLocation1.Visible = false;

            }

        }
    }


    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {



        lblCutcode.Visible = false;
        lblPopup.Visible = false;
        txtCustCode.Visible = false;
        Table1.Visible = false;
        lblMarket_own.Visible = false;
        ddlMarket.Visible = false;
        //   tblContract.Visible = true;



        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "External Usage")
        {

            lblCutcode.Visible = true;
            lblPopup.Visible = true;
            txtCustCode.Visible = true;
            Table1.Visible = true;
            lblMarket_own.Visible = false;
            ddlMarket.Visible = false;
            //  tblContract.Visible = true;

        }
        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "Internal Usage")
        {

          //  txtFromCity.Text = "";
          //  txtToCity.Text = "";
            //txtRoute.Text = "";
            lblCutcode.Visible = false;
            txtCustCode.Visible = false;
            Table1.Visible = true;
            lblMarket_own.Visible = true;
            ddlMarket.Visible = true;

            lblPopup.Visible = false;





        }
    }




}
