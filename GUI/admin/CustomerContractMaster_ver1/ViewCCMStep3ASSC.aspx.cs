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

public partial class EditCCMStep3ASSC : System.Web.UI.Page
{
    bool blnAirYN;
    bool blnRoadYN;
    bool blnTrainYN;
    bool blnExpressYN;

    public string strAir;
    public string strRoad;
    public string strTrain;
    public string strExpress;

    protected void Page_Load(object sender, EventArgs e)
    {
        blnAirYN = false;
        blnRoadYN = false;
        blnTrainYN = false;
        blnExpressYN = false;

        strAir = "";
        strRoad = "";
        strTrain = "";
        strExpress = "";

        if (!IsPostBack)
        {
            HidRandomNo.Value = Request.QueryString["Random"].ToString();
            HidSlab.Value = Request.QueryString["Slab"].ToString();
            HidODA.Value = Request.QueryString["ODA"].ToString();
            HidFTL.Value = Request.QueryString["FTL"].ToString();
           
            PopulateHiddenVars();

            //Get Mode of Transport Details
            getMOTDetails();

            //Populate Zone Details
            populateZoneDetails(ddlZoneHeader, new DataSet("dsZoneHeader"));

            ddlRateType.Focus();
        }

        if(HidMOTAir.Value != "")
        {
            string[] strArrForAir = HidMOTAir.Value.Split(',');

            strAir = strArrForAir[0];
            blnAirYN = (strArrForAir[1] == "Y" ? true : false);
        }

        if (HidMOTRoad.Value != "")
        {
            string[] strArrForRoad = HidMOTRoad.Value.Split(',');

            strRoad = strArrForRoad[0];
            blnRoadYN = (strArrForRoad[1] == "Y" ? true : false);
        }

        if (HidMOTTrain.Value != "")
        {
            string[] strArrForTrain = HidMOTTrain.Value.Split(',');

            strTrain = strArrForTrain[0];
            blnTrainYN = (strArrForTrain[1] == "Y" ? true : false);
        }

        if (HidMOTExpress.Value != "")
        {
            string[] strArrForExpress = HidMOTExpress.Value.Split(',');

            strExpress = strArrForExpress[0];
            blnExpressYN = (strArrForExpress[1] == "Y" ? true : false);
        }

        //Manage Visibility of TD's for Header for Branch
        tdAirHeader.Visible = blnAirYN;
        tdAirHeaderForTrDays.Visible = blnAirYN;

        if (blnAirYN == true)
        {
            lblAirHeader.InnerHtml = strAir;
        }
        
        tdRoadHeader.Visible = blnRoadYN;
        tdRoadHeaderForTrDays.Visible = blnRoadYN;
        if (blnRoadYN == true)
        {
            lblRoadHeader.InnerHtml = strRoad;
        }

        tdTrainHeader.Visible = blnTrainYN;
        tdTrainHeaderForTrDays.Visible = blnTrainYN;
        if (blnTrainYN == true)
        {
            lblTrainHeader.InnerHtml = strTrain;
        }

        tdExpressHeader.Visible = blnExpressYN;
        tdExpressHeaderForTrDays.Visible = blnExpressYN;
        if (blnExpressYN == true)
        {
            lblExpressHeader.InnerHtml = strExpress;
        }

        //Manage Visibility of TD's for Air for Branch
        tdAirForRow1.Visible = blnAirYN;
        tdAirForRowTrDays1.Visible = blnAirYN;
        tdAirForRow2.Visible = blnAirYN;
        tdAirForRowTrDays2.Visible = blnAirYN;
        tdAirForRow3.Visible = blnAirYN;
        tdAirForRowTrDays3.Visible = blnAirYN;
        tdAirForRow4.Visible = blnAirYN;
        tdAirForRowTrDays4.Visible = blnAirYN;
        tdAirForRow5.Visible = blnAirYN;
        tdAirForRowTrDays5.Visible = blnAirYN;
        tdAirForRow6.Visible = blnAirYN;
        tdAirForRowTrDays6.Visible = blnAirYN;
        tdAirForRow7.Visible = blnAirYN;
        tdAirForRowTrDays7.Visible = blnAirYN;
        tdAirForRow8.Visible = blnAirYN;
        tdAirForRowTrDays8.Visible = blnAirYN;
        tdAirForRow9.Visible = blnAirYN;
        tdAirForRowTrDays9.Visible = blnAirYN;
        tdAirForRow10.Visible = blnAirYN;
        tdAirForRowTrDays10.Visible = blnAirYN;

        //Manage Visibility of TD's for Road for Branch
        tdRoadForRow1.Visible = blnRoadYN;
        tdRoadForRowTrDays1.Visible = blnRoadYN;
        tdRoadForRow2.Visible = blnRoadYN;
        tdRoadForRowTrDays2.Visible = blnRoadYN;
        tdRoadForRow3.Visible = blnRoadYN;
        tdRoadForRowTrDays3.Visible = blnRoadYN;
        tdRoadForRow4.Visible = blnRoadYN;
        tdRoadForRowTrDays4.Visible = blnRoadYN;
        tdRoadForRow5.Visible = blnRoadYN;
        tdRoadForRowTrDays5.Visible = blnRoadYN;
        tdRoadForRow6.Visible = blnRoadYN;
        tdRoadForRowTrDays6.Visible = blnRoadYN;
        tdRoadForRow7.Visible = blnRoadYN;
        tdRoadForRowTrDays7.Visible = blnRoadYN;
        tdRoadForRow8.Visible = blnRoadYN;
        tdRoadForRowTrDays8.Visible = blnRoadYN;
        tdRoadForRow9.Visible = blnRoadYN;
        tdRoadForRowTrDays9.Visible = blnRoadYN;
        tdRoadForRow10.Visible = blnRoadYN;
        tdRoadForRowTrDays10.Visible = blnRoadYN;

        //Manage Visibility of TD's for Train for Branch
        tdTrainForRow1.Visible = blnTrainYN;
        tdTrainForRowTrDays1.Visible = blnTrainYN;
        tdTrainForRow2.Visible = blnTrainYN;
        tdTrainForRowTrDays2.Visible = blnTrainYN;
        tdTrainForRow3.Visible = blnTrainYN;
        tdTrainForRowTrDays3.Visible = blnTrainYN;
        tdTrainForRow4.Visible = blnTrainYN;
        tdTrainForRowTrDays4.Visible = blnTrainYN;
        tdTrainForRow5.Visible = blnTrainYN;
        tdTrainForRowTrDays5.Visible = blnTrainYN;
        tdTrainForRow6.Visible = blnTrainYN;
        tdTrainForRowTrDays6.Visible = blnTrainYN;
        tdTrainForRow7.Visible = blnTrainYN;
        tdTrainForRowTrDays7.Visible = blnTrainYN;
        tdTrainForRow8.Visible = blnTrainYN;
        tdTrainForRowTrDays8.Visible = blnTrainYN;
        tdTrainForRow9.Visible = blnTrainYN;
        tdTrainForRowTrDays9.Visible = blnTrainYN;
        tdTrainForRow10.Visible = blnTrainYN;
        tdTrainForRowTrDays10.Visible = blnTrainYN;

        //Manage Visibility of TD's for Express for Branch
        tdExpressForRow1.Visible = blnExpressYN;
        tdExpressForRowTrDays1.Visible = blnExpressYN;
        tdExpressForRow2.Visible = blnExpressYN;
        tdExpressForRowTrDays2.Visible = blnExpressYN;
        tdExpressForRow3.Visible = blnExpressYN;
        tdExpressForRowTrDays3.Visible = blnExpressYN;
        tdExpressForRow4.Visible = blnExpressYN;
        tdExpressForRowTrDays4.Visible = blnExpressYN;
        tdExpressForRow5.Visible = blnExpressYN;
        tdExpressForRowTrDays5.Visible = blnExpressYN;
        tdExpressForRow6.Visible = blnExpressYN;
        tdExpressForRowTrDays6.Visible = blnExpressYN;
        tdExpressForRow7.Visible = blnExpressYN;
        tdExpressForRowTrDays7.Visible = blnExpressYN;
        tdExpressForRow8.Visible = blnExpressYN;
        tdExpressForRowTrDays8.Visible = blnExpressYN;
        tdExpressForRow9.Visible = blnExpressYN;
        tdExpressForRowTrDays9.Visible = blnExpressYN;
        tdExpressForRow10.Visible = blnExpressYN;
        tdExpressForRowTrDays10.Visible = blnExpressYN;

        //Manage Visibility of TD's for Header for Zone
        tdAirHeaderForZone.Visible = blnAirYN;
        tdAirHeaderForTrDaysForZone.Visible = blnAirYN;
        if (blnAirYN == true)
        {
            lblAirHeaderForZone.InnerHtml = strAir;
        }

        tdRoadHeaderForZone.Visible = blnRoadYN;
        tdRoadHeaderForTrDaysForZone.Visible = blnRoadYN;
        if (blnRoadYN == true)
        {
            lblRoadHeaderForZone.InnerHtml = strRoad;
        }

        tdTrainHeaderForZone.Visible = blnTrainYN;
        tdTrainHeaderForTrDaysForZone.Visible = blnTrainYN;
        if (blnTrainYN == true)
        {
            lblTrainHeaderForZone.InnerHtml = strTrain;
        }

        tdExpressHeaderForZone.Visible = blnExpressYN;
        tdExpressHeaderForTrDaysForZone.Visible = blnExpressYN;
        if (blnExpressYN == true)
        {
            lblExpressHeaderForZone.InnerHtml = strExpress;
        }
        
        //Manage Visibility of TD's for Air for Zone
        tdAirZoneForRow1.Visible = blnAirYN;
        tdAirForRowTrDaysForZone1.Visible = blnAirYN;
        tdAirZoneForRow2.Visible = blnAirYN;
        tdAirForRowTrDaysForZone2.Visible = blnAirYN;
        tdAirZoneForRow3.Visible = blnAirYN;
        tdAirForRowTrDaysForZone3.Visible = blnAirYN;
        tdAirZoneForRow4.Visible = blnAirYN;
        tdAirForRowTrDaysForZone4.Visible = blnAirYN;
        tdAirZoneForRow5.Visible = blnAirYN;
        tdAirForRowTrDaysForZone5.Visible = blnAirYN;
        tdAirZoneForRow6.Visible = blnAirYN;
        tdAirForRowTrDaysForZone6.Visible = blnAirYN;
        tdAirZoneForRow7.Visible = blnAirYN;
        tdAirForRowTrDaysForZone7.Visible = blnAirYN;
        tdAirZoneForRow8.Visible = blnAirYN;
        tdAirForRowTrDaysForZone8.Visible = blnAirYN;
        tdAirZoneForRow9.Visible = blnAirYN;
        tdAirForRowTrDaysForZone9.Visible = blnAirYN;
        tdAirZoneForRow10.Visible = blnAirYN;
        tdAirForRowTrDaysForZone10.Visible = blnAirYN;

        //Manage Visibility of TD's for Road for Zone
        tdRoadZoneForRow1.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone1.Visible = blnRoadYN;
        tdRoadZoneForRow2.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone2.Visible = blnRoadYN;
        tdRoadZoneForRow3.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone3.Visible = blnRoadYN;
        tdRoadZoneForRow4.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone4.Visible = blnRoadYN;
        tdRoadZoneForRow5.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone5.Visible = blnRoadYN;
        tdRoadZoneForRow6.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone6.Visible = blnRoadYN;
        tdRoadZoneForRow7.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone7.Visible = blnRoadYN;
        tdRoadZoneForRow8.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone8.Visible = blnRoadYN;
        tdRoadZoneForRow9.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone9.Visible = blnRoadYN;
        tdRoadZoneForRow10.Visible = blnRoadYN;
        tdRoadForRowTrDaysForZone10.Visible = blnRoadYN;

        //Manage Visibility of TD's for Train for Zone
        tdTrainZoneForRow1.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone1.Visible = blnTrainYN;
        tdTrainZoneForRow2.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone2.Visible = blnTrainYN;
        tdTrainZoneForRow3.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone3.Visible = blnTrainYN;
        tdTrainZoneForRow4.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone4.Visible = blnTrainYN;
        tdTrainZoneForRow5.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone5.Visible = blnTrainYN;
        tdTrainZoneForRow6.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone6.Visible = blnTrainYN;
        tdTrainZoneForRow7.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone7.Visible = blnTrainYN;
        tdTrainZoneForRow8.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone8.Visible = blnTrainYN;
        tdTrainZoneForRow9.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone9.Visible = blnTrainYN;
        tdTrainZoneForRow10.Visible = blnTrainYN;
        tdTrainForRowTrDaysForZone10.Visible = blnTrainYN;

        //Manage Visibility of TD's for Express for Zone
        tdExpressZoneForRow1.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone1.Visible = blnExpressYN;
        tdExpressZoneForRow2.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone2.Visible = blnExpressYN;
        tdExpressZoneForRow3.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone3.Visible = blnExpressYN;
        tdExpressZoneForRow4.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone4.Visible = blnExpressYN;
        tdExpressZoneForRow5.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone5.Visible = blnExpressYN;
        tdExpressZoneForRow6.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone6.Visible = blnExpressYN;
        tdExpressZoneForRow7.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone7.Visible = blnExpressYN;
        tdExpressZoneForRow8.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone8.Visible = blnExpressYN;
        tdExpressZoneForRow9.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone9.Visible = blnExpressYN;
        tdExpressZoneForRow10.Visible = blnExpressYN;
        tdExpressForRowTrDaysForZone10.Visible = blnExpressYN;

        //Manage Visibility of TD's for Header for City
        tdAirHeaderForCity.Visible = blnAirYN;
        tdAirHeaderForTrDaysForCity.Visible = blnAirYN;
        if (blnAirYN == true)
        {
            lblAirHeaderForCity.InnerHtml = strAir;
        }

        tdRoadHeaderForCity.Visible = blnRoadYN;
        tdRoadHeaderForTrDaysForCity.Visible = blnRoadYN;
        if (blnRoadYN == true)
        {
            lblRoadHeaderForCity.InnerHtml = strRoad;
        }

        tdTrainHeaderForCity.Visible = blnTrainYN;
        tdTrainHeaderForTrDaysForCity.Visible = blnTrainYN;
        if (blnTrainYN == true)
        {
            lblTrainHeaderForCity.InnerHtml = strTrain;
        }

        tdExpressHeaderForCity.Visible = blnExpressYN;
        tdExpressHeaderForTrDaysForCity.Visible = blnExpressYN;
        if (blnExpressYN == true)
        {
            lblExpressHeaderForCity.InnerHtml = strExpress;
        }

        //Manage Visibility of TD's for Air for City
        tdAirCityForRow1.Visible = blnAirYN;
        tdAirForRowTrDaysForCity1.Visible = blnAirYN;
        tdAirCityForRow2.Visible = blnAirYN;
        tdAirForRowTrDaysForCity2.Visible = blnAirYN;
        tdAirCityForRow3.Visible = blnAirYN;
        tdAirForRowTrDaysForCity3.Visible = blnAirYN;
        tdAirCityForRow4.Visible = blnAirYN;
        tdAirForRowTrDaysForCity4.Visible = blnAirYN;
        tdAirCityForRow5.Visible = blnAirYN;
        tdAirForRowTrDaysForCity5.Visible = blnAirYN;
        tdAirCityForRow6.Visible = blnAirYN;
        tdAirForRowTrDaysForCity6.Visible = blnAirYN;
        tdAirCityForRow7.Visible = blnAirYN;
        tdAirForRowTrDaysForCity7.Visible = blnAirYN;
        tdAirCityForRow8.Visible = blnAirYN;
        tdAirForRowTrDaysForCity8.Visible = blnAirYN;
        tdAirCityForRow9.Visible = blnAirYN;
        tdAirForRowTrDaysForCity9.Visible = blnAirYN;
        tdAirCityForRow10.Visible = blnAirYN;
        tdAirForRowTrDaysForCity10.Visible = blnAirYN;

        //Manage Visibility of TD's for Road for City
        tdRoadCityForRow1.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity1.Visible = blnRoadYN;
        tdRoadCityForRow2.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity2.Visible = blnRoadYN;
        tdRoadCityForRow3.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity3.Visible = blnRoadYN;
        tdRoadCityForRow4.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity4.Visible = blnRoadYN;
        tdRoadCityForRow5.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity5.Visible = blnRoadYN;
        tdRoadCityForRow6.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity6.Visible = blnRoadYN;
        tdRoadCityForRow7.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity7.Visible = blnRoadYN;
        tdRoadCityForRow8.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity8.Visible = blnRoadYN;
        tdRoadCityForRow9.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity9.Visible = blnRoadYN;
        tdRoadCityForRow10.Visible = blnRoadYN;
        tdRoadForRowTrDaysForCity10.Visible = blnRoadYN;

        //Manage Visibility of TD's for Train for City
        tdTrainCityForRow1.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity1.Visible = blnTrainYN;
        tdTrainCityForRow2.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity2.Visible = blnTrainYN;
        tdTrainCityForRow3.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity3.Visible = blnTrainYN;
        tdTrainCityForRow4.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity4.Visible = blnTrainYN;
        tdTrainCityForRow5.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity5.Visible = blnTrainYN;
        tdTrainCityForRow6.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity6.Visible = blnTrainYN;
        tdTrainCityForRow7.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity7.Visible = blnTrainYN;
        tdTrainCityForRow8.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity8.Visible = blnTrainYN;
        tdTrainCityForRow9.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity9.Visible = blnTrainYN;
        tdTrainCityForRow10.Visible = blnTrainYN;
        tdTrainForRowTrDaysForCity10.Visible = blnTrainYN;

        //Manage Visibility of TD's for Express for City
        tdExpressCityForRow1.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity1.Visible = blnExpressYN;
        tdExpressCityForRow2.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity2.Visible = blnExpressYN;
        tdExpressCityForRow3.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity3.Visible = blnExpressYN;
        tdExpressCityForRow4.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity4.Visible = blnExpressYN;
        tdExpressCityForRow5.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity5.Visible = blnExpressYN;
        tdExpressCityForRow6.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity6.Visible = blnExpressYN;
        tdExpressCityForRow7.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity7.Visible = blnExpressYN;
        tdExpressCityForRow8.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity8.Visible = blnExpressYN;
        tdExpressCityForRow9.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity9.Visible = blnExpressYN;
        tdExpressCityForRow10.Visible = blnExpressYN;
        tdExpressForRowTrDaysForCity10.Visible = blnExpressYN;

        if (!IsPostBack)
        {
            displayData();
        }
    }

    protected void txtBranchCode_TextChanged(object sender, EventArgs e)
    {
        txtBranchCode.Text = txtBranchCode.Text.Trim().ToUpper();
        if (txtBranchCode.Text != "")
        {
            lblErrorBranchCode.Visible = (!CheckValidBranch(txtBranchCode.Text));
            if (lblErrorBranchCode.Visible == true)
            {
                txtBranchCode.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow1From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow1From.Text = txtFreightMatrixRow1From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow1From.Text != "")
        {
            lblErrorFreightMatrixRow1From.Visible = (!CheckValidBranch(txtFreightMatrixRow1From.Text));
            if (lblErrorFreightMatrixRow1From.Visible == true)
            {
                txtFreightMatrixRow1From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow1To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow1To.Text = txtFreightMatrixRow1To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow1To.Text != "")
        {
            lblErrorFreightMatrixRow1To.Visible = (!CheckValidBranch(txtFreightMatrixRow1To.Text));
            if (lblErrorFreightMatrixRow1To.Visible == true)
            {
                txtFreightMatrixRow1To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow2From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow2From.Text = txtFreightMatrixRow2From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow2From.Text != "")
        {
            lblErrorFreightMatrixRow2From.Visible = (!CheckValidBranch(txtFreightMatrixRow2From.Text));
            if (lblErrorFreightMatrixRow2From.Visible == true)
            {
                txtFreightMatrixRow2From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow2To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow2To.Text = txtFreightMatrixRow2To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow2To.Text != "")
        {
            lblErrorFreightMatrixRow2To.Visible = (!CheckValidBranch(txtFreightMatrixRow2To.Text));
            if (lblErrorFreightMatrixRow2To.Visible == true)
            {
                txtFreightMatrixRow2To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow3From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow3From.Text = txtFreightMatrixRow3From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow3From.Text != "")
        {
            lblErrorFreightMatrixRow3From.Visible = (!CheckValidBranch(txtFreightMatrixRow3From.Text));
            if (lblErrorFreightMatrixRow3From.Visible == true)
            {
                txtFreightMatrixRow3From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow3To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow3To.Text = txtFreightMatrixRow3To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow3To.Text != "")
        {
            lblErrorFreightMatrixRow3To.Visible = (!CheckValidBranch(txtFreightMatrixRow3To.Text));
            if (lblErrorFreightMatrixRow3To.Visible == true)
            {
                txtFreightMatrixRow3To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow4From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow4From.Text = txtFreightMatrixRow4From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow4From.Text != "")
        {
            lblErrorFreightMatrixRow4From.Visible = (!CheckValidBranch(txtFreightMatrixRow4From.Text));
            if (lblErrorFreightMatrixRow4From.Visible == true)
            {
                txtFreightMatrixRow4From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow4To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow4To.Text = txtFreightMatrixRow4To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow4To.Text != "")
        {
            lblErrorFreightMatrixRow4To.Visible = (!CheckValidBranch(txtFreightMatrixRow4To.Text));
            if (lblErrorFreightMatrixRow4To.Visible == true)
            {
                txtFreightMatrixRow4To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow5From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow5From.Text = txtFreightMatrixRow5From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow5From.Text != "")
        {
            lblErrorFreightMatrixRow5From.Visible = (!CheckValidBranch(txtFreightMatrixRow5From.Text));
            if (lblErrorFreightMatrixRow5From.Visible == true)
            {
                txtFreightMatrixRow5From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow5To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow5To.Text = txtFreightMatrixRow5To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow5To.Text != "")
        {
            lblErrorFreightMatrixRow5To.Visible = (!CheckValidBranch(txtFreightMatrixRow5To.Text));
            if (lblErrorFreightMatrixRow5To.Visible == true)
            {
                txtFreightMatrixRow5To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow6From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow6From.Text = txtFreightMatrixRow6From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow6From.Text != "")
        {
            lblErrorFreightMatrixRow6From.Visible = (!CheckValidBranch(txtFreightMatrixRow6From.Text));
            if (lblErrorFreightMatrixRow6From.Visible == true)
            {
                txtFreightMatrixRow6From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow6To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow6To.Text = txtFreightMatrixRow6To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow6To.Text != "")
        {
            lblErrorFreightMatrixRow6To.Visible = (!CheckValidBranch(txtFreightMatrixRow6To.Text));
            if (lblErrorFreightMatrixRow6To.Visible == true)
            {
                txtFreightMatrixRow6To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow7From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow7From.Text = txtFreightMatrixRow7From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow7From.Text != "")
        {
            lblErrorFreightMatrixRow7From.Visible = (!CheckValidBranch(txtFreightMatrixRow7From.Text));
            if (lblErrorFreightMatrixRow7From.Visible == true)
            {
                txtFreightMatrixRow7From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow7To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow7To.Text = txtFreightMatrixRow7To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow7To.Text != "")
        {
            lblErrorFreightMatrixRow7To.Visible = (!CheckValidBranch(txtFreightMatrixRow7To.Text));
            if (lblErrorFreightMatrixRow7To.Visible == true)
            {
                txtFreightMatrixRow7To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow8From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow8From.Text = txtFreightMatrixRow8From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow8From.Text != "")
        {
            lblErrorFreightMatrixRow8From.Visible = (!CheckValidBranch(txtFreightMatrixRow8From.Text));
            if (lblErrorFreightMatrixRow8From.Visible == true)
            {
                txtFreightMatrixRow8From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow8To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow8To.Text = txtFreightMatrixRow8To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow8To.Text != "")
        {
            lblErrorFreightMatrixRow8To.Visible = (!CheckValidBranch(txtFreightMatrixRow8To.Text));
            if (lblErrorFreightMatrixRow8To.Visible == true)
            {
                txtFreightMatrixRow8To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow9From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow9From.Text = txtFreightMatrixRow9From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow9From.Text != "")
        {
            lblErrorFreightMatrixRow9From.Visible = (!CheckValidBranch(txtFreightMatrixRow9From.Text));
            if (lblErrorFreightMatrixRow9From.Visible == true)
            {
                txtFreightMatrixRow9From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow9To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow9To.Text = txtFreightMatrixRow9To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow9To.Text != "")
        {
            lblErrorFreightMatrixRow9To.Visible = (!CheckValidBranch(txtFreightMatrixRow9To.Text));
            if (lblErrorFreightMatrixRow9To.Visible == true)
            {
                txtFreightMatrixRow9To.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow10From_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow10From.Text = txtFreightMatrixRow10From.Text.Trim().ToUpper();
        if (txtFreightMatrixRow10From.Text != "")
        {
            lblErrorFreightMatrixRow10From.Visible = (!CheckValidBranch(txtFreightMatrixRow10From.Text));
            if (lblErrorFreightMatrixRow10From.Visible == true)
            {
                txtFreightMatrixRow10From.Focus();
            }
        }
    }
    protected void txtFreightMatrixRow10To_TextChanged(object sender, EventArgs e)
    {
        txtFreightMatrixRow10To.Text = txtFreightMatrixRow10To.Text.Trim().ToUpper();
        if (txtFreightMatrixRow10To.Text != "")
        {
            lblErrorFreightMatrixRow10To.Visible = (!CheckValidBranch(txtFreightMatrixRow10To.Text));
            if (lblErrorFreightMatrixRow10To.Visible == true)
            {
                txtFreightMatrixRow10To.Focus();
            }
        }
    }

    private void populateZoneDetails(DropDownList ddlList, DataSet dsZone)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetZone";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        sqlDA.Fill(dsZone);

        ddlList.Items.Clear();

        if (dsZone.Tables[0].Rows.Count > 0)
        {
            ddlList.DataTextField = "CodeDesc";
            ddlList.DataValueField = "CodeId";

            ddlList.DataSource = dsZone;
            ddlList.DataBind();
        }

        ddlList.Items.Insert(0, new ListItem("Select", "-1"));

        DataView dvZone = new DataView();

        dvZone = dsZone.Tables[0].DefaultView;

        ddlZoneFromForRow1.DataTextField = "CodeDesc";
        ddlZoneFromForRow1.DataValueField = "CodeId";

        ddlZoneFromForRow1.DataSource = dvZone.Table;
        ddlZoneFromForRow1.DataBind();

        ddlZoneFromForRow1.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow1.DataTextField = "CodeDesc";
        ddlZoneToForRow1.DataValueField = "CodeId";

        ddlZoneToForRow1.DataSource = dvZone.Table;
        ddlZoneToForRow1.DataBind();

        ddlZoneToForRow1.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow2.DataTextField = "CodeDesc";
        ddlZoneFromForRow2.DataValueField = "CodeId";

        ddlZoneFromForRow2.DataSource = dvZone.Table;
        ddlZoneFromForRow2.DataBind();

        ddlZoneFromForRow2.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow2.DataTextField = "CodeDesc";
        ddlZoneToForRow2.DataValueField = "CodeId";

        ddlZoneToForRow2.DataSource = dvZone.Table;
        ddlZoneToForRow2.DataBind();

        ddlZoneToForRow2.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow3.DataTextField = "CodeDesc";
        ddlZoneFromForRow3.DataValueField = "CodeId";

        ddlZoneFromForRow3.DataSource = dvZone.Table;
        ddlZoneFromForRow3.DataBind();

        ddlZoneFromForRow3.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow3.DataTextField = "CodeDesc";
        ddlZoneToForRow3.DataValueField = "CodeId";

        ddlZoneToForRow3.DataSource = dvZone.Table;
        ddlZoneToForRow3.DataBind();

        ddlZoneToForRow3.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow4.DataTextField = "CodeDesc";
        ddlZoneFromForRow4.DataValueField = "CodeId";

        ddlZoneFromForRow4.DataSource = dvZone.Table;
        ddlZoneFromForRow4.DataBind();

        ddlZoneFromForRow4.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow4.DataTextField = "CodeDesc";
        ddlZoneToForRow4.DataValueField = "CodeId";

        ddlZoneToForRow4.DataSource = dvZone.Table;
        ddlZoneToForRow4.DataBind();

        ddlZoneToForRow4.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow5.DataTextField = "CodeDesc";
        ddlZoneFromForRow5.DataValueField = "CodeId";

        ddlZoneFromForRow5.DataSource = dvZone.Table;
        ddlZoneFromForRow5.DataBind();

        ddlZoneFromForRow5.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow5.DataTextField = "CodeDesc";
        ddlZoneToForRow5.DataValueField = "CodeId";

        ddlZoneToForRow5.DataSource = dvZone.Table;
        ddlZoneToForRow5.DataBind();

        ddlZoneToForRow5.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow6.DataTextField = "CodeDesc";
        ddlZoneFromForRow6.DataValueField = "CodeId";

        ddlZoneFromForRow6.DataSource = dvZone.Table;
        ddlZoneFromForRow6.DataBind();

        ddlZoneFromForRow6.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow6.DataTextField = "CodeDesc";
        ddlZoneToForRow6.DataValueField = "CodeId";

        ddlZoneToForRow6.DataSource = dvZone.Table;
        ddlZoneToForRow6.DataBind();

        ddlZoneToForRow6.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow7.DataTextField = "CodeDesc";
        ddlZoneFromForRow7.DataValueField = "CodeId";

        ddlZoneFromForRow7.DataSource = dvZone.Table;
        ddlZoneFromForRow7.DataBind();

        ddlZoneFromForRow7.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow7.DataTextField = "CodeDesc";
        ddlZoneToForRow7.DataValueField = "CodeId";

        ddlZoneToForRow7.DataSource = dvZone.Table;
        ddlZoneToForRow7.DataBind();

        ddlZoneToForRow7.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow8.DataTextField = "CodeDesc";
        ddlZoneFromForRow8.DataValueField = "CodeId";

        ddlZoneFromForRow8.DataSource = dvZone.Table;
        ddlZoneFromForRow8.DataBind();

        ddlZoneFromForRow8.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow8.DataTextField = "CodeDesc";
        ddlZoneToForRow8.DataValueField = "CodeId";

        ddlZoneToForRow8.DataSource = dvZone.Table;
        ddlZoneToForRow8.DataBind();

        ddlZoneToForRow8.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow9.DataTextField = "CodeDesc";
        ddlZoneFromForRow9.DataValueField = "CodeId";

        ddlZoneFromForRow9.DataSource = dvZone.Table;
        ddlZoneFromForRow9.DataBind();

        ddlZoneFromForRow9.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow9.DataTextField = "CodeDesc";
        ddlZoneToForRow9.DataValueField = "CodeId";

        ddlZoneToForRow9.DataSource = dvZone.Table;
        ddlZoneToForRow9.DataBind();

        ddlZoneToForRow9.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneFromForRow10.DataTextField = "CodeDesc";
        ddlZoneFromForRow10.DataValueField = "CodeId";

        ddlZoneFromForRow10.DataSource = dvZone.Table;
        ddlZoneFromForRow10.DataBind();

        ddlZoneFromForRow10.Items.Insert(0, new ListItem("Select", "-1"));

        ddlZoneToForRow10.DataTextField = "CodeDesc";
        ddlZoneToForRow10.DataValueField = "CodeId";

        ddlZoneToForRow10.DataSource = dvZone.Table;
        ddlZoneToForRow10.DataBind();

        ddlZoneToForRow10.Items.Insert(0, new ListItem("Select", "-1"));

        sqlConn.Close();
    }

    protected void ddlZoneHeader_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlZoneHeader.SelectedValue == "-1")
        {
            ddlZoneToForRow1.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow2.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow3.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow4.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow5.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow6.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow7.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow8.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow9.SelectedValue = ddlZoneHeader.SelectedValue;
            ddlZoneToForRow10.SelectedValue = ddlZoneHeader.SelectedValue;
        }

        ddlZoneFromForRow1.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow2.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow3.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow4.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow5.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow6.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow7.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow8.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow9.SelectedValue = ddlZoneHeader.SelectedValue;
        ddlZoneFromForRow10.SelectedValue = ddlZoneHeader.SelectedValue;
    }
    protected void txtFromCityRow1_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow1.Text = txtFromCityRow1.Text.Trim().ToUpper();
        lblErrorFromCityRow1.Visible = (!CheckValidCity(txtFromCityRow1.Text));
        if (lblErrorFromCityRow1.Visible == true)
        {
            txtFromCityRow1.Focus();
        }
    }
    protected void txtToCityRow1_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow1.Text = txtToCityRow1.Text.Trim().ToUpper();
        if (txtToCityRow1.Text != "")
        {
            lblErrorToCityRow1.Visible = (!CheckValidCity(txtToCityRow1.Text));
            if (lblErrorToCityRow1.Visible == true)
            {
                txtToCityRow1.Focus();
            }
        }
    }
    protected void txtFromCityRow2_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow2.Text = txtFromCityRow2.Text.Trim().ToUpper();
        if (txtFromCityRow2.Text != "")
        {
            lblErrorFromCityRow2.Visible = (!CheckValidCity(txtFromCityRow2.Text));
            if (lblErrorFromCityRow2.Visible == true)
            {
                txtFromCityRow2.Focus();
            }
        }
    }
    protected void txtToCityRow2_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow2.Text = txtToCityRow2.Text.Trim().ToUpper();
        if (txtToCityRow2.Text != "")
        {
            lblErrorToCityRow2.Visible = (!CheckValidCity(txtToCityRow2.Text));
            if (lblErrorToCityRow2.Visible == true)
            {
                txtToCityRow2.Focus();
            }
        }
    }
    protected void txtFromCityRow3_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow3.Text = txtFromCityRow3.Text.Trim().ToUpper();
        if (txtFromCityRow3.Text != "")
        {
            lblErrorFromCityRow3.Visible = (!CheckValidCity(txtFromCityRow3.Text));
            if (lblErrorFromCityRow3.Visible == true)
            {
                txtFromCityRow3.Focus();
            }
        }
    }
    protected void txtToCityRow3_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow3.Text = txtToCityRow3.Text.Trim().ToUpper();
        if (txtToCityRow3.Text != "")
        {
            lblErrorToCityRow3.Visible = (!CheckValidCity(txtToCityRow3.Text));
            if (lblErrorToCityRow3.Visible == true)
            {
                txtToCityRow3.Focus();
            }
        }
    }
    protected void txtFromCityRow4_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow4.Text = txtFromCityRow4.Text.Trim().ToUpper();
        if (txtFromCityRow4.Text != "")
        {
            lblErrorFromCityRow4.Visible = (!CheckValidCity(txtFromCityRow4.Text));
            if (lblErrorFromCityRow4.Visible == true)
            {
                txtFromCityRow4.Focus();
            }
        }
    }
    protected void txtToCityRow4_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow4.Text = txtToCityRow4.Text.Trim().ToUpper();
        if (txtToCityRow4.Text != "")
        {
            lblErrorToCityRow4.Visible = (!CheckValidCity(txtToCityRow4.Text));
            if (lblErrorToCityRow4.Visible == true)
            {
                txtToCityRow4.Focus();
            }
        }
    }
    protected void txtFromCityRow5_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow5.Text = txtFromCityRow5.Text.Trim().ToUpper();
        if (txtFromCityRow5.Text != "")
        {
            lblErrorFromCityRow5.Visible = (!CheckValidCity(txtFromCityRow5.Text));
            if (lblErrorFromCityRow5.Visible == true)
            {
                txtFromCityRow5.Focus();
            }
        }
    }
    protected void txtToCityRow5_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow5.Text = txtToCityRow5.Text.Trim().ToUpper();
        if (txtToCityRow5.Text != "")
        {
            lblErrorToCityRow5.Visible = (!CheckValidCity(txtToCityRow5.Text));
            if (lblErrorToCityRow5.Visible == true)
            {
                txtToCityRow5.Focus();
            }
        }
    }
    protected void txtFromCityRow6_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow6.Text = txtFromCityRow6.Text.Trim().ToUpper();
        if (txtFromCityRow6.Text != "")
        {
            lblErrorFromCityRow6.Visible = (!CheckValidCity(txtFromCityRow6.Text));
            if (lblErrorFromCityRow6.Visible == true)
            {
                txtFromCityRow6.Focus();
            }
        }
    }
    protected void txtToCityRow6_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow6.Text = txtToCityRow6.Text.Trim().ToUpper();
        if (txtToCityRow6.Text != "")
        {
            lblErrorToCityRow6.Visible = (!CheckValidCity(txtToCityRow6.Text));
            if (lblErrorToCityRow6.Visible == true)
            {
                txtToCityRow6.Focus();
            }
        }
    }
    protected void txtFromCityRow7_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow7.Text = txtFromCityRow7.Text.Trim().ToUpper();
        if (txtFromCityRow7.Text != "")
        {
            lblErrorFromCityRow7.Visible = (!CheckValidCity(txtFromCityRow7.Text));
            if (lblErrorFromCityRow7.Visible == true)
            {
                txtFromCityRow7.Focus();
            }
        }
    }
    protected void txtToCityRow7_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow7.Text = txtToCityRow7.Text.Trim().ToUpper();
        if (txtToCityRow7.Text != "")
        {
            lblErrorToCityRow7.Visible = (!CheckValidCity(txtToCityRow7.Text));
            if (lblErrorToCityRow7.Visible == true)
            {
                txtToCityRow7.Focus();
            }
        }
    }
    protected void txtFromCityRow8_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow8.Text = txtFromCityRow8.Text.Trim().ToUpper();
        if (txtFromCityRow8.Text != "")
        {
            lblErrorFromCityRow8.Visible = (!CheckValidCity(txtFromCityRow8.Text));
            if (lblErrorFromCityRow8.Visible == true)
            {
                txtFromCityRow8.Focus();
            }
        }
    }
    protected void txtToCityRow8_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow8.Text = txtToCityRow8.Text.Trim().ToUpper();
        if (txtToCityRow8.Text != "")
        {
            lblErrorToCityRow8.Visible = (!CheckValidCity(txtToCityRow8.Text));
            if (lblErrorToCityRow8.Visible == true)
            {
                txtToCityRow8.Focus();
            }
        }
    }
    protected void txtFromCityRow9_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow9.Text = txtFromCityRow9.Text.Trim().ToUpper();
        if (txtFromCityRow9.Text != "")
        {
            lblErrorFromCityRow9.Visible = (!CheckValidCity(txtFromCityRow9.Text));
            if (lblErrorFromCityRow9.Visible == true)
            {
                txtFromCityRow9.Focus();
            }
        }
    }
    protected void txtToCityRow9_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow9.Text = txtToCityRow9.Text.Trim().ToUpper();
        if (txtToCityRow9.Text != "")
        {
            lblErrorToCityRow9.Visible = (!CheckValidCity(txtToCityRow9.Text));
            if (lblErrorToCityRow9.Visible == true)
            {
                txtToCityRow9.Focus();
            }
        }
    }
    protected void txtFromCityRow10_TextChanged(object sender, EventArgs e)
    {
        txtFromCityRow10.Text = txtFromCityRow10.Text.Trim().ToUpper();
        if (txtFromCityRow10.Text != "")
        {
            lblErrorFromCityRow10.Visible = (!CheckValidCity(txtFromCityRow10.Text));
            if (lblErrorFromCityRow10.Visible == true)
            {
                txtFromCityRow10.Focus();
            }
        }
    }
    protected void txtToCityRow10_TextChanged(object sender, EventArgs e)
    {
        txtToCityRow10.Text = txtToCityRow10.Text.Trim().ToUpper();
        if (txtToCityRow10.Text != "")
        {
            lblErrorToCityRow10.Visible = (!CheckValidCity(txtToCityRow10.Text));
            if (lblErrorToCityRow10.Visible == true)
            {
                txtToCityRow10.Focus();
            }
        }
    }
    protected void txtCity_TextChanged(object sender, EventArgs e)
    {
        txtCity.Text = txtCity.Text.Trim().ToUpper();
        if (txtCity.Text != "")
        {
            lblErrorCity.Visible = (!CheckValidCity(txtCity.Text));
            if (lblErrorCity.Visible == true)
            {
                txtCity.Focus();
            }
        }
    }

    private bool CheckValidCity(string CityName)
    {
        bool IsValidCity = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "select location from webx_citymaster where location = '" + CityName + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCity = new DataSet();

        sqlDA.Fill(dsCity);

        if (dsCity.Tables[0].Rows.Count > 0)
        {
            IsValidCity = true;
        }

        return IsValidCity;
    }

    private bool CheckValidBranch(string BranchCode)
    {
        bool IsValidBranch = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "select loccode from webx_location where loccode = '" + BranchCode + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            IsValidBranch = true;
        }

        return IsValidBranch;
    }

    private void getMOTDetails()
    {
        HidMOTAir.Value = "";
        HidMOTRoad.Value = "";
        HidMOTTrain.Value = "";
        HidMOTExpress.Value = "";

        string strMOT;
        string strMOTAbbr;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "SELECT MOT, MOTAbbr FROM Webx_CCM_Step2 WHERE Temp_Sr_No = " + HidRandomNo.Value;

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsMOT = new DataSet();

        sqlDA.Fill(dsMOT);

        if (dsMOT.Tables[0].Rows.Count > 0)
        {
            strMOT = dsMOT.Tables[0].Rows[0]["MOT"].ToString();
            strMOTAbbr = dsMOT.Tables[0].Rows[0]["MOTAbbr"].ToString();
            string[] strArrMOT = strMOT.Split(',');
            string[] strArrMOTAbbr = strMOTAbbr.Split(',');

            for (int intLoopCounter = 0; intLoopCounter < strArrMOT.Length; intLoopCounter++)
            {
                switch (strArrMOTAbbr[intLoopCounter])
                {
                    case "A":
                        HidMOTAir.Value = strArrMOT[intLoopCounter] + "," + "Y";    
                        //blnAirYN = true;
                        break;
                    case "R":
                        HidMOTRoad.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        //blnRoadYN = true;
                        break;
                    case "T":
                        HidMOTTrain.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        //blnTrainYN = true;
                        break;
                    case "E":
                        HidMOTExpress.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        //blnExpressYN = true;
                        break;
                }
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        manageSubmitClick();

        if ((blnRoadYN == true || blnExpressYN == true) && HidFTL.Value != "")
        {
            Response.Redirect("EditCCMStep3FreightFTL.aspx?TL=" + HidFTL.Value + "&Random=" + HidRandomNo.Value + "&ODA=" + HidODA.Value);
        }
        else if (HidODA.Value == "Y")
        {
            Response.Redirect("EditCCMODA.aspx?Random=" + HidRandomNo.Value);
        }
        else
        {
            Response.Redirect("CCM_DisplayResult.aspx?ContractID=" + HidContractID.Value + "&CustCodeName=" + HidCustCodeName.Value + "&CCMMode=E");
        }

        /*string[] strArrBM = HidBM.Value.Split('~');
        string[] strArrZM = HidZM.Value.Split('~');
        string[] strArrCM = HidCM.Value.Split('~');

        string strXMLForBM = "<root>";

        //Generate XML for Branch Matrix Freight Rate
        for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
        {
            string[] strArrInnerBM = strArrBM[intLoopCounter].Split(',');

            strXMLForBM += "<bm>" +
                           "<rndm>" + HidRandomNo.Value + "</rndm>" + 
                           "<branchname>" + txtBranchCode.Text + "</branchname>" +
                           "<branchfrom>" + strArrInnerBM[0] + "</branchfrom>" +
                           "<branchto>" + strArrInnerBM[1] + "</branchto>" +
                           "<brfrair>" + strArrInnerBM[2] + "</brfrair>" +
                           "<brfrroad>" + strArrInnerBM[3] + "</brfrroad>" +
                           "<brfrtrain>" + strArrInnerBM[4] + "</brfrtrain>" +
                           "<brfrexpress>" + strArrInnerBM[5] + "</brfrexpress>" +
                           "</bm>";
        }

        strXMLForBM += "</root>";

        //Generate XML for Zone Matrix Freight Rate
        string strXMLForZM = "<root>";

        //Generate XML for Branch Matrix Freight Rate
        for (int intLoopCounter = 0; intLoopCounter < strArrZM.Length; intLoopCounter++)
        {
            string[] strArrInnerZM = strArrZM[intLoopCounter].Split(',');

            strXMLForZM += "<zone>" +
                           "<rndm>" + HidRandomNo.Value + "</rndm>" +  
                           "<zonename>" + ddlZoneHeader.SelectedValue + "</zonename>" +
                           "<zonefrom>" + strArrInnerZM[0] + "</zonefrom>" +
                           "<zoneto>" + strArrInnerZM[1] + "</zoneto>" +
                           "<zonefrair>" + strArrInnerZM[2] + "</zonefrair>" +
                           "<zonefrroad>" + strArrInnerZM[3] + "</zonefrroad>" +
                           "<zonefrtrain>" + strArrInnerZM[4] + "</zonefrtrain>" +
                           "<zonefrexpress>" + strArrInnerZM[5] + "</zonefrexpress>" +
                           "</zone>";
        }

        strXMLForZM += "</root>";

        //Generate XML for City Matrix Freight Rate
        string strXMLForCM = "<root>";

        //Generate XML for Branch Matrix Freight Rate
        for (int intLoopCounter = 0; intLoopCounter < strArrCM.Length; intLoopCounter++)
        {
            string[] strArrInnerCM = strArrCM[intLoopCounter].Split(',');

            strXMLForCM += "<city>" +
                           "<rndm>" + HidRandomNo.Value + "</rndm>" +  
                           "<cityname>" + txtCity.Text + "</cityname>" +
                           "<cityfrom>" + strArrInnerCM[0] + "</cityfrom>" +
                           "<cityto>" + strArrInnerCM[1] + "</cityto>" +
                           "<cityfrair>" + strArrInnerCM[2] + "</cityfrair>" +
                           "<cityfrroad>" + strArrInnerCM[3] + "</cityfrroad>" +
                           "<cityfrtrain>" + strArrInnerCM[4] + "</cityfrtrain>" +
                           "<cityfrexpress>" + strArrInnerCM[5] + "</cityfrexpress>" +
                           "</city>";
        }

        strXMLForCM += "</root>";

        //Call database SP to insert data
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_CCM_Step3_Insert_Data";

        sqlCommand.Parameters.AddWithValue("@RandomNo", HidRandomNo.Value);
        sqlCommand.Parameters.AddWithValue("@RateType", ddlRateType.SelectedValue);
        sqlCommand.Parameters.AddWithValue("@Branch", txtBranchCode.Text);
        sqlCommand.Parameters.AddWithValue("@strXMLForBM", strXMLForBM);
        sqlCommand.Parameters.AddWithValue("@Zone", ddlZoneHeader.SelectedValue);
        sqlCommand.Parameters.AddWithValue("@strXMLForZM", strXMLForZM);
        sqlCommand.Parameters.AddWithValue("@City", txtCity.Text);
        sqlCommand.Parameters.AddWithValue("@strXMLForCM", strXMLForCM);

        sqlCommand.ExecuteNonQuery();
        */
    }

    private void manageSubmitClick()
    {
        //Update WEBX_CUSTCONTRACT_HDR table
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "Update WEBX_CUSTCONTRACT_HDR set single_slab_yn='" + (HidSlab.Value == "S" ? "Y" : "N") + 
                        "', multiple_slab_yn='" + (HidSlab.Value == "S" ? "N" : "Y") +
                        "' where custcode = '" + HidCustCode.Value + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        //Manage Branch Matrix

        strSQL = "DELETE FROM WEBX_CUSTCONTRACT_LOCDET where contractid = '" + HidContractID.Value + "'";

        sqlCommand = null;

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        if (HidBM.Value != "")
        {
            string[] strArrBM = HidBM.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                sqlCommand = null;

                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                strSQL = "Insert into WEBX_CUSTCONTRACT_LOCDET (ContractId, Custcode, FromLocode, " +
                                "ToLocode, Air_rate, Train_rate, Express_rate, Road_rate, rate_type, " +
                                "contract_type, Air_days, Train_days, Express_days, Road_days) values ('" +
                                HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " + strInnerArrBM[6] + ", " +
                                strInnerArrBM[8] + ", " + strInnerArrBM[4] + ", '" + ddlRateType.SelectedValue + "', " +
                                "'', " + strInnerArrBM[3] + ", " + strInnerArrBM[7] + ", " + strInnerArrBM[9] + ", " +
                                strInnerArrBM[5] + ")";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlCommand.ExecuteNonQuery();
            }
        }

        //Manage Zone Matrix

        strSQL = "DELETE FROM WEBX_CUSTCONTRACT_REGDET where contractid = '" + HidContractID.Value + "'";

        sqlCommand = null;

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        if (HidZM.Value != "")
        {
            string[] strArrZM = HidZM.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrZM.Length; intLoopCounter++)
            {
                sqlCommand = null;

                string[] strInnerArrZM = strArrZM[intLoopCounter].Split(',');

                strSQL = "Insert into WEBX_CUSTCONTRACT_REGDET (ContractId, Custcode, FromRegion, " +
                                "ToRegion, Air_rate, Train_rate, Express_rate, Road_rate, rate_type, " +
                                "contract_type, Air_days, Train_days, Express_days, Road_days) values ('" +
                                HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrZM[0] + "', '" +
                                strInnerArrZM[1] + "', " + strInnerArrZM[2] + ", " + strInnerArrZM[6] + ", " +
                                strInnerArrZM[8] + ", " + strInnerArrZM[4] + ", '" + ddlRateType.SelectedValue + "', " +
                                "'', " + strInnerArrZM[3] + ", " + strInnerArrZM[7] + ", " + strInnerArrZM[9] + ", " +
                                strInnerArrZM[5] + ")";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlCommand.ExecuteNonQuery();
            }
        }

        //Manage City Matrix

        //Delete Records From WEBX_CUSTCONTRACT_cityDET Table for the Contract
        strSQL = "delete from WEBX_CUSTCONTRACT_cityDET where contractId = '" + HidContractID.Value + "'";

        sqlCommand = null;

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        if (HidCM.Value != "")
        {
            string[] strArrCM = HidCM.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrCM.Length; intLoopCounter++)
            {
                sqlCommand = null;

                string[] strInnerArrCM = strArrCM[intLoopCounter].Split(',');

                strSQL = "Insert into WEBX_CUSTCONTRACT_cityDET (ContractId, Custcode, Fromcity, Tocity, " +
                         "Air_rate, Train_rate, Express_rate, Road_rate, rate_type, contract_type, Air_days, " +
                         "Train_days, Express_days, Road_days) Values ('" + HidContractID.Value + "', '" +
                         HidCustCode.Value + "', '" + strInnerArrCM[0] + "', '" + strInnerArrCM[1] + "', " +
                         strInnerArrCM[2] + ", " + strInnerArrCM[6] + ", " + strInnerArrCM[8] + ", " +
                         strInnerArrCM[4] + ", '" + ddlRateType.SelectedValue + "', " + "'', " +
                         strInnerArrCM[3] + ", " + strInnerArrCM[7] + ", " + strInnerArrCM[9] + ", " +
                         strInnerArrCM[5] + ")";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlCommand.ExecuteNonQuery();
            }
        }
    }

    private void PopulateHiddenVars()
    {
        string strSQL = "select * from Webx_CCM_Step1 where Temp_Sr_No = " + HidRandomNo.Value;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCMStep1Data = new DataSet();

        sqlDA.Fill(dsCCMStep1Data);

        if (dsCCMStep1Data.Tables[0].Rows.Count > 0)
        {
            HidCustCode.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustCode"].ToString();
            HidCustCodeName.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustCodeName"].ToString();
            HidContDate.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContDate"]).ToString("dd-MMM-yy");
            HidContValidUntil.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContValidUntil"]).ToString("dd-MMM-yy");
            HidContEffFromDate.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContEffFromDate"]).ToString("dd-MMM-yy");
            HidContSignLoc.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContSignLoc"].ToString();
            HidCustRep.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustRep"].ToString();
            HidCoEmpName.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoEmpName"].ToString();
            HidCustRepDesi.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustRepDesi"].ToString();
            HidCoEmpDesi.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoEmpDesi"].ToString();
            HidCustWitness.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustWitness"].ToString();
            HidCoWitness.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoWitness"].ToString();
            HidBillAdd.Value = dsCCMStep1Data.Tables[0].Rows[0]["BillAdd"].ToString();
            HidCity.Value = dsCCMStep1Data.Tables[0].Rows[0]["City"].ToString();
            HidPinCode.Value = dsCCMStep1Data.Tables[0].Rows[0]["PinCode"].ToString();
            HidPartyCat.Value = dsCCMStep1Data.Tables[0].Rows[0]["PartyCat"].ToString();
            HidContCat.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContCat"].ToString();
            HidSTApp.Value = dsCCMStep1Data.Tables[0].Rows[0]["STApp"].ToString();
            HidAcctRep.Value = dsCCMStep1Data.Tables[0].Rows[0]["AcctRep"].ToString();
            HidContractID.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContractID"].ToString();
        }
        else
        {

        }
    }

    private void displayData()
    {
        //Branch Matrix
        string strSQL = "select * from WEBX_CUSTCONTRACT_LOCDET WHERE ContractId = '" + HidContractID.Value + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (intLoopCounter)
                {
                    case 0:
                        txtFreightMatrixRow1From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow1To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }
                        
                        ddlRateType.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["rate_type"].ToString();
                        break;

                    case 1:
                        txtFreightMatrixRow2From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow2To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }
                        
                        break;

                    case 2:
                        txtFreightMatrixRow3From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow3To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 3:
                        txtFreightMatrixRow4From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow4To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 4:
                        txtFreightMatrixRow5From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow5To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 5:
                        txtFreightMatrixRow6From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow6To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 6:
                        txtFreightMatrixRow7From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow7To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 7:
                        txtFreightMatrixRow8From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow8To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 8:
                        txtFreightMatrixRow9From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow9To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 9:
                        txtFreightMatrixRow10From.Text = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                        txtFreightMatrixRow10To.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;
                }
            }
        }

        //Zone Matrix
        strSQL = "select * from WEBX_CUSTCONTRACT_REGDET WHERE ContractId = '" + HidContractID.Value + "'";
        
        sqlCommand = null;
        sqlDA = null;
        dsCCM = null;

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();
        
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (intLoopCounter)
                {
                    case 0:
                        ddlZoneFromForRow1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow1.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 1:
                        ddlZoneFromForRow2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow2.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 2:
                        ddlZoneFromForRow3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow3.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 3:
                        ddlZoneFromForRow4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow4.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 4:
                        ddlZoneFromForRow5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow5.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 5:
                        ddlZoneFromForRow6.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow6.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 6:
                        ddlZoneFromForRow7.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow7.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 7:
                        ddlZoneFromForRow8.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow8.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 8:
                        ddlZoneFromForRow9.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow9.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 9:
                        ddlZoneFromForRow10.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["FromRegion"].ToString().ToUpper().Trim();
                        ddlZoneToForRow10.Text = dsCCM.Tables[0].Rows[intLoopCounter]["ToRegion"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtFreightForAirZoneForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForZone10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtFreightForRoadZoneForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForZone10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtFreightForTrainZoneForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForZone10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtFreightForExpressZoneForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForZone10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;
                }
            }
        }

        //City Matrix
        strSQL = "select * from WEBX_CUSTCONTRACT_CITYDET WHERE ContractId = '" + HidContractID.Value + "'";

        sqlCommand = null;
        sqlDA = null;
        dsCCM = null;

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();
        
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (intLoopCounter)
                {
                    case 0:
                        txtFromCityRow1.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow1.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }
                        
                        break;

                    case 1:
                        txtFromCityRow2.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow2.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 2:
                        txtFromCityRow3.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow3.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 3:
                        txtFromCityRow4.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow4.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 4:
                        txtFromCityRow5.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow5.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 5:
                        txtFromCityRow6.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow6.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 6:
                        txtFromCityRow7.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow7.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 7:
                        txtFromCityRow8.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow8.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity7.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity8.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 8:
                        txtFromCityRow9.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow9.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity9.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;

                    case 9:
                        txtFromCityRow10.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Fromcity"].ToString().ToUpper().Trim();
                        txtToCityRow10.Text = dsCCM.Tables[0].Rows[intLoopCounter]["Tocity"].ToString().ToUpper().Trim();

                        if (blnAirYN == true)
                        {
                            txtAirCityForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                            txtAirTrDaysRowForCity10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                        }

                        if (blnRoadYN == true)
                        {
                            txtRoadCityForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                            txtRoadTrDaysRowForCity10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                        }

                        if (blnTrainYN == true)
                        {
                            txtTrainCityForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                            txtTrainTrDaysRowForCity10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                        }

                        if (blnExpressYN == true)
                        {
                            txtExpressCityForRow10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                            txtExpressTrDaysRowForCity10.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                        }

                        break;
                }
            }
        }
    }
}
