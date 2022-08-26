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

public partial class Issue_frmVehicleIssueSlipNew : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.RequestDetRow datarow;

    string strOrgnCity, strOrgnLoc, strStartDt, strVehType;
    string strPassNo;
    string strReqDt, strDestnCity, strEndDt;
    string strReqId, strReqBy;

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

            InitializeData();
            BindGrid();

            LoadDriverData();






        }

    }



   





    private void LoadDriverData()
    {

       
    }

    private void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.RequestDet;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;
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

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);
           
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);

            if (e.Item.ItemIndex >= -1)
            {
                string strSelRadio = ((RadioButton)e.Item.FindControl("chksel")).ClientID;
                ((RadioButton)e.Item.FindControl("chksel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");
            }
            //((CheckBox)e.Item.FindControl("chksel")).Checked = datarow.Chksel;
            ((RadioButton)e.Item.FindControl("chksel")).Checked = datarow.Chksel;
            ((TextBox)e.Item.FindControl("txtReqId")).Text = datarow.RequestId;
            ((TextBox)e.Item.FindControl("txtReqBy")).Text = datarow.Request_By;
            ((TextBox)e.Item.FindControl("txtReqDt")).Text = datarow.Request_Dt;
            ((TextBox)e.Item.FindControl("txtOrgnCity")).Text = datarow.Orgn_City;
            ((TextBox)e.Item.FindControl("txtDestnCity")).Text = datarow.Destn_City;

            ((TextBox)e.Item.FindControl("txtStDt")).Text = datarow.Start_Dt;
            ((TextBox)e.Item.FindControl("txtEdDt")).Text = datarow.End_Dt;
            //((TextBox)e.Item.FindControl("txtPassNo")).Text = datarow.Pass_No;
            ((TextBox)e.Item.FindControl("txtVehType")).Text = datarow.Vehtype;
           //((DropDownList)e.Item.FindControl("cboVehno")).SelectedItem.Value = datarow.Vehno;





        }
    }


    public void InitializeData()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        lblDataError.Text = "";
        string DataFound = "N";
        strOrgnCity = ""; strOrgnLoc = ""; strStartDt = ""; strEndDt = ""; strVehType = "";
        strReqDt = "";
        strDestnCity = ""; strPassNo = "0";
        strReqId = ""; strReqBy = "";
        SqlCommand cmdREQ = new SqlCommand("usp_RequestListForIssue", conn);
        cmdREQ.CommandType = CommandType.StoredProcedure;


        //strReqId = Page.Request.Form[];
        //strReqFromDt = Page.Request.Form["txtDateFrom"];
        //strReqToDt = Page.Request.Form["txtDateTo"];
        //strReqFromDt=PreviousPage.txtDateFrom;
        //strReqToDt = PreviousPage.txtDateTo;


        
        //strStartDt = Request.QueryString["StartDt"].ToString().Trim();
        strStartDt = Request.QueryString["FromDt"].ToString().Trim();
        strEndDt = Request.QueryString["ToDt"].ToString().Trim();

        strOrgnCity = Request.QueryString["OrgnCity"].ToString().Trim();
        //strOrgnLoc = Request.QueryString["OrgnLoc"].ToString().Trim();
        if (strOrgnLoc == "" || strOrgnLoc == null)
        {
            strOrgnLoc = "";
        }
        strVehType = Request.QueryString["VehType"].ToString().Trim();
        //strPassNo = Request.QueryString["Pass_no"].ToString().Trim();


        //Response.Write("<br>strStartDt : " + strStartDt);
        //Response.Write("<br>strOrgnCity : " + strOrgnCity);
        //Response.Write("<br>strVehType : " + strVehType);

        cmdREQ.Parameters.AddWithValue("@StartDt", strStartDt);
        cmdREQ.Parameters.AddWithValue("@EndDt", strEndDt);
        
        cmdREQ.Parameters.AddWithValue("@OrgnCity", strOrgnCity);
        //cmdREQ.Parameters.AddWithValue("@OrgnLoc", strOrgnLoc);
        cmdREQ.Parameters.AddWithValue("@VehType", strVehType);
        //cmdREQ.Parameters.AddWithValue("@Pass_No", strPassNo);
        cmdREQ.Parameters.AddWithValue("@ReqId", strReqId);
        
        conn.Open();
        SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();


        while (dataReadREQ.Read())
        {
            DataFound = "Y";
            strReqId = dataReadREQ["Request_Id"].ToString();
            strReqBy = dataReadREQ["Request_By"].ToString();
            strReqDt = dataReadREQ["Request_dt"].ToString();
            strOrgnCity = dataReadREQ["Orgn_city"].ToString();
            strDestnCity = dataReadREQ["Destn_city"].ToString();
            strStartDt = dataReadREQ["Start_date_time"].ToString();
            strEndDt = dataReadREQ["End_dt_tm"].ToString();
            strPassNo = dataReadREQ["No_Passenger"].ToString();
            strVehType = dataReadREQ["Vehtype"].ToString();

            _dataSet.RequestDet.AddRequestDetRow(false, strReqId, strReqBy, strReqDt, strOrgnCity, strDestnCity, strStartDt, strEndDt, strPassNo, strVehType, "", "");


        }

        dataReadREQ.Close();
       

        if (DataFound == "N")
        {
            lblDataError.Text = "No Request Found !!!";
        }

    }


    public void Check_ManualTripSheetNo(object sender, EventArgs e)
    {
        lblMTS.Text = "";
        string DataFoundFlag = "N";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "Select Manual_TripSheetNo from WEBX_FLEET_VEHICLE_ISSUE where Manual_TripSheetNo='" + txtManualTripSheetNo.Text + "'";
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

        if (DataFoundFlag == "Y")
        {
            lblMTS.Text = "Duplicate Manual Trip Sheet No. !!!Please check.";
        }

    }

    protected void SubmitData(object sender, EventArgs e)
    {
        string ErrMsg = "";
        string strReqId = "";
        string mManualTripSheetNo = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";


        DateTime righnow = System.DateTime.Today;
        dtfi.DateSeparator = "/";
        righnow = Convert.ToDateTime(righnow, dtfi);

       

        DateTime dtIssueDt = new DateTime();
        dtIssueDt = Convert.ToDateTime(DtCal.CalenderText(), dtfi);
        if (dtIssueDt > righnow)
        {
            if (ErrMsg == "")
            {
                ErrMsg = "Error : Trip Sheet Date can not be greater than system date.Please check !!!";
            }
        }



        //string strcboVehno = "";
        string strSelFlag = "False";
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
           bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;
           
            
            if (strChkSel == true)
            {
                strSelFlag = "True";
                strReqId = ((TextBox)(gridrow.FindControl("txtReqId"))).Text;
                //strcboVehno = ((DropDownList)(gridrow.FindControl("cboVehno"))).SelectedItem.Value;
            }
        }

        if (ErrMsg == "")
        {
            if (strSelFlag == "False")
            {
                ErrMsg = "Error : Atleast on request has to be selected, please check !!!";
            }
        }

        mManualTripSheetNo = txtManualTripSheetNo.Text;
        lblError.Text = ErrMsg;
     
        string  mMark_Own="";

                if (lblError.Text == "" && lblMTS.Text == "")
                {


          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
          string mSTR = "select Market_Own  from WEBX_FLEET_VEHICLE_REQUEST where Request_Id='" + strReqId + "'";

          SqlCommand mCmd = new SqlCommand(mSTR, conn);
          SqlDataReader mDR = mCmd.ExecuteReader();

          if (mDR.HasRows)
          {
              while (mDR.Read())
              {

                  mMark_Own=Convert.ToString(mDR["Market_Own"]);
                  
              }


          }
          mDR.Close();


          conn.Close();


          if (mMark_Own == "Market")
          {


           

                 // lblError.Visible = true;
              lblError.Text = "Sorry,Trip sheet can not be created for selected Vehicle Request ,since it is for Market usage.";

          }
            else
           {

                  lblError.Text = "";

           }



          }



       
              if (lblError.Text == "" && lblMTS.Text == "")
              {


                  Response.Redirect("frmVehicleIssueSlipNewNext.aspx?ReqId=" + strReqId + "&IssueDt=" + DtCal.CalenderText() + "&ManualTripSheetNo=" + mManualTripSheetNo);
                  //conn.Open();
                  //conn.Close();
              }

         
    }
}

