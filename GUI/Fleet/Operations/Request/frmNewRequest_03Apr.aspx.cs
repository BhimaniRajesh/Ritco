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
using System.Web.Mail;
using System.Net;
using System.IO;
using System.Text;


public partial class Request_frmNewRequest : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection();//System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    


    protected void Page_Load(object sender, EventArgs e)
    {
     
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;


        if (!IsPostBack)
        {

            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            DtCal.SetCalenderText(strrightnow);

       //     FillCategory();
            FillCity();
            FillVehType();
           
        }
        else

        {
        
        }
        


    }



    
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }


    
    
    //protected void FillCategory()
    //{

    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    conn.Open();
    //    DataSet myds = new DataSet();
    //    SqlDataAdapter myda = new SqlDataAdapter("select CategoryCode ,CategoryName from WEBX_FLEET_CATEGORY where ActiveFlag='Y' order By CategoryName", conn);
    //    myda.Fill(myds, "WEBX_FLEET_CATEGORY");
    //    cboCategory.DataTextField = "CategoryName";
    //    cboCategory.DataValueField = "CategoryCode";
    //    cboCategory.DataSource = myds.Tables["WEBX_FLEET_CATEGORY"];
    //    cboCategory.DataBind();
    //    cboCategory.Items.Insert(0, "");
    //    conn.Close();
    
    //}


    protected void FillCity()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        DataSet myds = new DataSet();
        SqlDataAdapter myda = new SqlDataAdapter("select city_code ,Location from vwCityList order By Location", conn);
        myda.Fill(myds, "vwCityList");
        
        cboOrgnCity.DataTextField = "Location";
        cboOrgnCity.DataValueField = "city_code";
        cboOrgnCity.DataSource = myds.Tables["vwCityList"];
        cboOrgnCity.DataBind();
        cboOrgnCity.Items.Insert(0, "");
        


        cboDestnCity.DataTextField = "Location";
        cboDestnCity.DataValueField = "city_code";
        cboDestnCity.DataSource = myds.Tables["vwCityList"];
        cboDestnCity.DataBind();
        cboDestnCity.Items.Insert(0, "");

        conn.Close();

    }



    protected void FillVehType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        DataSet myds = new DataSet();
        SqlDataAdapter myda = new SqlDataAdapter("select Distinct Type_Code,Type_Name from webx_Vehicle_Type where ActiveFlag='Y' and Fleet_Type='0' order by Type_Name", conn);
        myda.Fill(myds, "webx_Vehicle_Type");

        cboVehType.DataTextField = "Type_Name";
        cboVehType.DataValueField = "Type_Code";
        cboVehType.DataSource = myds.Tables["webx_Vehicle_Type"];
        cboVehType.DataBind();
        cboVehType.Items.Insert(0, "");

        conn.Close();

    }



    //protected void FillRequestBy(object sender, EventArgs e)
    //{

    //    txtOrgnAddr.Text = "";
    //    txtOrgnPincode.Text = "";
    //    txtOrgnTelno.Text = "";
    //    txtOrgnEmail.Text = "";

    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    conn.Open();
    //    DataSet myds = new DataSet();
    //    string mCustEmpVal = "";
    //    string sql = "";

    //    if (cboCategory.SelectedItem.Text == "CUSTOMER")
    //    {
    //        mCustEmpVal = "C";
    //    }
    //    else
    //    {
    //        mCustEmpVal = "E";
    //    }


    //    sql="select distinct custcd ,custnm from vwCustEmpList where CUST_EMP='" + mCustEmpVal + "' order By custnm";
    //    SqlDataAdapter myda = new SqlDataAdapter(sql, conn);
    //    myda.Fill(myds, "vwCustEmpList");

    //    cboRequestBy.DataTextField = "custnm";
    //    cboRequestBy.DataValueField = "custcd";
    //    cboRequestBy.DataSource = myds.Tables["vwCustEmpList"];
    //    cboRequestBy.DataBind();
    //    cboRequestBy.Items.Insert(0, "");
    //    conn.Close();

    // }


    //protected void FillOrgnAddr(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    string sql = "";
    //    sql = "select * from vwCustEmpList where custcd='" + cboRequestBy.SeleSSctedValue + "' order By custnm";
    //    SqlCommand cmdREQ = new SqlCommand(sql, conn);
    //    cmdREQ.CommandType = CommandType.Text;

    //    conn.Open();
    //    SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
    //    while (dataReadREQ.Read())
    //    {
    //        txtOrgnAddr.Text = dataReadREQ["custaddress"].ToString();
    //        txtOrgnPincode.Text = dataReadREQ["custpin"].ToString();
    //        txtOrgnTelno.Text = dataReadREQ["custtel"].ToString();
    //        txtOrgnEmail.Text = dataReadREQ["custemail"].ToString();

    //    }
    //    dataReadREQ.Close();
    //    conn.Close();

    //}


    protected void FillPickupLoc(object sender, EventArgs e)
    {
        DropDownList cboCity = (DropDownList)sender;

        DropDownList cboPickup = new DropDownList();

        if (cboCity.ID == "cboOrgnCity")
        {
            cboPickup = (DropDownList)cboOrgnLoc;
        }
        else
        {
            cboPickup = (DropDownList)cboDestnLoc;
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string mcity = "";
        mcity = cboCity.SelectedItem.Value;
        if (mcity == "")
        {
            mcity = "0";
        }


        DataSet myds = new DataSet();
        SqlDataAdapter myda = new SqlDataAdapter("select p.pickup_loccode,upper(p.pickup_locname) pickup_locname from vwPickupList p where city_code=" + mcity + " order By pickup_locname", conn);
        myda.Fill(myds, "vwPickupList");

        
        cboPickup.DataTextField = "pickup_locname";
        cboPickup.DataValueField = "pickup_loccode";
        cboPickup.DataSource = myds.Tables["vwPickupList"];
        cboPickup.DataBind();
        cboPickup.Items.Insert(0, "");
        conn.Close();
    }


    


    protected void SubmitDataTest(object sender, EventArgs e)
    {

       
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";

        DateTime righnow = System.DateTime.Today;
        dtfi.DateSeparator = "/";
        righnow = Convert.ToDateTime(righnow, dtfi);
        DateTime dtReqDt = new DateTime();
        dtReqDt = Convert.ToDateTime(DtCal.CalenderText(), dtfi);
        if (dtReqDt > righnow)
        {

            lblError.Text = "Error : Request Date can not be greater than system date.Please check !!!";
        }
        else
        {
            lblError.Text = "";
        }

      
    }
    protected void SubmitData(object sender, EventArgs e)
    {


        string ErrMsg = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        dtfi.ShortTimePattern = "hh:mm tt";


        DateTime righnow = System.DateTime.Today;
        dtfi.DateSeparator = "/";
        righnow = Convert.ToDateTime(righnow, dtfi);
        
        
        DateTime dtReqDt = new DateTime();
        dtReqDt = Convert.ToDateTime(DtCal.CalenderText(), dtfi);
        if (dtReqDt > righnow)
        {
            if (ErrMsg == "")
            {
                ErrMsg = "Error : Request Date can not be greater than system date.Please check !!!";
            }
        }
       


        DateTime dtStDt = new DateTime();
        DateTime dtEdDt = new DateTime();

        if (DtCalStDt.CalenderText() != "" && DtCalEdDt.CalenderText() != "")
        {

            dtStDt = Convert.ToDateTime(DtCalStDt.CalenderText(), dtfi);
            dtEdDt = Convert.ToDateTime(DtCalEdDt.CalenderText(), dtfi);





            if (dtStDt > dtEdDt)
            {
                if (ErrMsg == "")
                {
                    ErrMsg = "Error : Start Date can not be greater than End date.Please check !!!";
                }
            }



            if (dtStDt == dtEdDt)
            {

                DateTime dtStDt_tm = new DateTime();
                DateTime dtEdDt_tm = new DateTime();
                dtStDt_tm = Convert.ToDateTime(cboStDt_HH.SelectedItem.Value + ":" + cboStDt_MM.SelectedItem.Value + " " + cboStDt_AMPM.SelectedItem.Value, dtfi);
                dtEdDt_tm = Convert.ToDateTime(cboEdDt_HH.SelectedItem.Value + ":" + cboEdDt_MM.SelectedItem.Value + " " + cboEdDt_AMPM.SelectedItem.Value, dtfi);

                if (dtStDt_tm > dtEdDt_tm)
                {
                    if (ErrMsg == "")
                    {
                        ErrMsg = "Error : Start time can not be greater than End time.Please check !!!";
                    }
                }
            }


        }

        else
        {
            ErrMsg = "Start Date And End Date Both are Compulsory!";

        }



        lblError.Text = ErrMsg;
        //lblError.Text = "***";


        string mCheck = "";
        string mDocuementNo = "";
        if (lblError.Text == "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            conn.Open();

            string msql = "usp_CheckTS";
            SqlCommand msqlcmd1 = new SqlCommand(msql, conn);
            msqlcmd1.CommandType = CommandType.StoredProcedure;
            // sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "ISSUE";
            msqlcmd1.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "VRN";

            SqlDataReader mr1 = msqlcmd1.ExecuteReader();
            if (mr1.Read())
            {
                mCheck = mr1[0].ToString().Trim();
            }
            mr1.Close();






            if (mCheck == "VRN")
            {

                string mSTR = "WebX_SP_GetNextDocumentCode";
                SqlCommand mcmd1 = new SqlCommand(mSTR, conn);
                mcmd1.CommandType = CommandType.StoredProcedure;
            //    mcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "VRN";
                //   mcmd1.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = "AAAA";
                mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = "VRN";
                SqlDataReader rTS = mcmd1.ExecuteReader();
                if (rTS.Read())
                {
                    mDocuementNo = rTS[0].ToString().Trim();
                }
                rTS.Close();

            }

            else
            {

            
                string sql = "usp_GetDocumentNo";
                SqlCommand sqlcmd1 = new SqlCommand(sql, conn);
                sqlcmd1.CommandType = CommandType.StoredProcedure;
                sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "REQUEST";
                SqlDataReader r1 = sqlcmd1.ExecuteReader();
                if (r1.Read())
                {
                    mDocuementNo = r1[0].ToString();
                }
                r1.Close();


            }




            string Start_time = cboStDt_HH.SelectedItem.Value.ToString().Trim() + ":" + cboStDt_MM.SelectedItem.Value.ToString().Trim() + " " + cboStDt_AMPM.SelectedItem.Value.ToString().Trim();
            string End_time = cboEdDt_HH.SelectedItem.Value.ToString().Trim() + ":" + cboEdDt_MM.SelectedItem.Value.ToString().Trim() + " " + cboEdDt_AMPM.SelectedItem.Value.ToString().Trim();

           

            SqlCommand cmd = new SqlCommand("usp_AddRequestHdr", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Manual_Request_Id", SqlDbType.VarChar).Value = txtManualRequestId.Text.Trim();
            cmd.Parameters.Add("@Request_Id", SqlDbType.VarChar).Value = mDocuementNo;
            cmd.Parameters.Add("@Request_Dt", SqlDbType.DateTime).Value = Convert.ToDateTime(DtCal.CalenderText().ToString().Trim(), dtfi);
            cmd.Parameters.Add("@Request_Type", SqlDbType.VarChar).Value = "T";
           // cmd.Parameters.Add("@Request_By", SqlDbType.VarChar).Value = cboRequestBy.SelectedItem.Text.Trim(); //txtRequestBy.Text.Trim();
           // cmd.Parameters.Add("@Request_By_Id", SqlDbType.VarChar).Value = cboRequestBy.Text.Trim(); //txtRequestBy.Text.Trim();


            cmd.Parameters.Add("@Request_By", SqlDbType.VarChar).Value = txtRequestBy.Text.Trim(); //txtRequestBy.Text.Trim();
            cmd.Parameters.Add("@Request_By_Id", SqlDbType.VarChar).Value = txtRequestBy.Text.Trim(); //txtRequestBy.Text.Trim();
            
         //   cmd.Parameters.Add("@Category_Id", SqlDbType.VarChar).Value = cboCategory.Text.Trim();

            cmd.Parameters.Add("@Orgn_address", SqlDbType.VarChar).Value = txtOrgnAddr.Text.Trim();
            cmd.Parameters.Add("@Orgn_City", SqlDbType.VarChar).Value = cboOrgnCity.Text.Trim();
            cmd.Parameters.Add("@Orgn_pin", SqlDbType.VarChar).Value = txtOrgnPincode.Text.Trim();
            cmd.Parameters.Add("@Orgn_LocCode", SqlDbType.VarChar).Value = cboOrgnLoc.Text.Trim();
            cmd.Parameters.Add("@Orgn_Phone", SqlDbType.VarChar).Value = txtOrgnTelno.Text.Trim();
            cmd.Parameters.Add("@Orgn_Email", SqlDbType.VarChar).Value = txtOrgnEmail.Text.Trim();


            cmd.Parameters.Add("@Destn_address", SqlDbType.VarChar).Value = txtDestnAddr.Text.Trim();
            cmd.Parameters.Add("@Destn_City", SqlDbType.VarChar).Value = cboDestnCity.Text.Trim();
            cmd.Parameters.Add("@Destn_pin", SqlDbType.VarChar).Value = txtDestnPincode.Text.Trim();
            cmd.Parameters.Add("@Destn_LocCode", SqlDbType.VarChar).Value = cboDestnLoc.Text.Trim();
            cmd.Parameters.Add("@Destn_Phone", SqlDbType.VarChar).Value = txtDestnTelno.Text.Trim();
            cmd.Parameters.Add("@Destn_Email", SqlDbType.VarChar).Value = txtDestnEmail.Text.Trim();


            cmd.Parameters.Add("@Vehtype", SqlDbType.VarChar).Value = cboVehType.Text.Trim();
           


            cmd.Parameters.Add("@Start_date_time", SqlDbType.DateTime).Value = Convert.ToDateTime(DtCalStDt.CalenderText().ToString().Trim(), dtfi);
            cmd.Parameters.Add("@End_dt_tm", SqlDbType.DateTime).Value = Convert.ToDateTime(DtCalEdDt.CalenderText().ToString().Trim(), dtfi);
            cmd.Parameters.Add("@Start_tm", SqlDbType.VarChar).Value = Start_time.Trim();
            cmd.Parameters.Add("@End_tm", SqlDbType.VarChar).Value = End_time.Trim();



            cmd.Parameters.Add("@Req_Loc", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();

            cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = ddlCategory.SelectedItem.Value.ToString().Trim();
            cmd.Parameters.Add("@CustCode", SqlDbType.VarChar).Value = txtCustCode.Text.ToString().Trim();
            cmd.Parameters.Add("@M_Own", SqlDbType.VarChar).Value = ddlMarket.SelectedItem.Value.ToString().Trim();









            cmd.ExecuteNonQuery();

            
            conn.Close();
            

            


            Response.Redirect("~/GUI/FLeet/Operations/Request/frmNewRequest_result.aspx?ReqId=" + mDocuementNo);
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



        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "External Usage")
        {

            lblCutcode.Visible = true;
            lblPopup.Visible = true;
            txtCustCode.Visible = true;
            Table1.Visible = true;
            lblMarket_own.Visible = false;
            ddlMarket.Visible = false;

        }
        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "Internal Usage")
        {

            lblCutcode.Visible = false;
            txtCustCode.Visible = false;
            Table1.Visible = true;
            lblMarket_own.Visible = true;
            ddlMarket.Visible = true;

            lblPopup.Visible = false;



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






    
}
