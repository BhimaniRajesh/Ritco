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

public partial class GUI_admin_CustomerContractMaster_EditCCMStep3BMSC : System.Web.UI.Page
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
            HidFTL.Value = Request.QueryString["FTL"].ToString();
            HidODA.Value = Request.QueryString["ODA"].ToString();

            PopulateHiddenVars();

            //Get Mode of Transport Details
            getMOTDetails();
        }

        if (HidMOTAir.Value != "")
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
        trForRoadForBranch.Visible = blnRoadYN;
        trForRoadForZone.Visible = blnRoadYN;
        trForRoadForCity.Visible = blnRoadYN;

        trForExpressForBranch.Visible = blnExpressYN;
        trForExpressForZone.Visible = blnExpressYN;
        trForExpressForCity.Visible = blnExpressYN;

        trForAirForBranch.Visible = blnAirYN;
        trForAirForZone.Visible = blnAirYN;
        trForAirForCity.Visible = blnAirYN;

        trForTrainForBranch.Visible = blnTrainYN;
        trForTrainForZone.Visible = blnTrainYN;
        trForTrainForCity.Visible = blnTrainYN;

        if (!IsPostBack)
        {
            //Populate Zone Details
            populateZoneDetails(new DataSet("dsZoneHeader"));

            displayData();
        }
    }

    protected void txtBranchCodeRoad_TextChanged(object sender, EventArgs e)
    {
        lblErrorBranchCodeRoad.Visible = false;
        txtBranchCodeRoad.Text = txtBranchCodeRoad.Text.Trim().ToUpper();
        if (txtBranchCodeRoad.Text != "")
        {
            lblErrorBranchCodeRoad.Visible = (!CheckValidBranch(txtBranchCodeRoad.Text));
            if (lblErrorBranchCodeRoad.Visible == true)
            {
                txtBranchCodeRoad.Focus();
            }
        }
    }

    protected void txtFromForExpressForCity1_TextChanged(object sender, EventArgs e)
    {
        lblFromForExpressForCity1.Visible = false;
        txtFromForExpressForCity1.Text = txtFromForExpressForCity1.Text.Trim().ToUpper();
        if (txtFromForExpressForCity1.Text != "")
        {
            lblFromForExpressForCity1.Visible = (!CheckValidCity(txtFromForExpressForCity1.Text));
            if (lblFromForExpressForCity1.Visible == true)
            {
                txtFromForExpressForCity1.Focus();
            }
        }
    }

    protected void txtFromForExpressForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblFromForExpressForBranch1.Visible = false;
        txtFromForExpressForBranch1.Text = txtFromForExpressForBranch1.Text.Trim().ToUpper();
        if (txtFromForExpressForBranch1.Text != "")
        {
            lblFromForExpressForBranch1.Visible = (!CheckValidBranch(txtFromForExpressForBranch1.Text));
            if (lblFromForExpressForBranch1.Visible == true)
            {
                txtFromForExpressForBranch1.Focus();
            }
        }
    }
    
    protected void txtFromForRoadForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblFromForRoadForBranch1.Visible = false;
        txtFromForRoadForBranch1.Text = txtFromForRoadForBranch1.Text.Trim().ToUpper();
        if (txtFromForRoadForBranch1.Text != "")
        {
            lblFromForRoadForBranch1.Visible = (!CheckValidBranch(txtFromForRoadForBranch1.Text));
            if (lblFromForRoadForBranch1.Visible == true)
            {
                txtFromForRoadForBranch1.Focus();
            }
        }
    }
    
    private void populateZoneDetails(DataSet dsZone)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetZone";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        sqlDA.Fill(dsZone);

        if (blnRoadYN == true)
        {
            ddlZoneHeaderRoad.Items.Clear();

            if (dsZone.Tables[0].Rows.Count > 0)
            {
                ddlZoneHeaderRoad.DataTextField = "CodeDesc";
                ddlZoneHeaderRoad.DataValueField = "CodeId";

                ddlZoneHeaderRoad.DataSource = dsZone;
                ddlZoneHeaderRoad.DataBind();
            }

            ddlZoneHeaderRoad.Items.Insert(0, new ListItem("Select", "-1"));
        }

        DataView dvZone = new DataView();

        dvZone = dsZone.Tables[0].DefaultView;

        if (blnExpressYN == true)
        {
            ddlZoneHeaderExpress.DataTextField = "CodeDesc";
            ddlZoneHeaderExpress.DataValueField = "CodeId";

            ddlZoneHeaderExpress.DataSource = dvZone.Table;
            ddlZoneHeaderExpress.DataBind();

            ddlZoneHeaderExpress.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnAirYN == true)
        {
            ddlZoneHeaderAir.DataTextField = "CodeDesc";
            ddlZoneHeaderAir.DataValueField = "CodeId";

            ddlZoneHeaderAir.DataSource = dvZone.Table;
            ddlZoneHeaderAir.DataBind();

            ddlZoneHeaderAir.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnTrainYN == true)
        {
            ddlZoneHeaderTrain.DataTextField = "CodeDesc";
            ddlZoneHeaderTrain.DataValueField = "CodeId";

            ddlZoneHeaderTrain.DataSource = dvZone.Table;
            ddlZoneHeaderTrain.DataBind();

            ddlZoneHeaderTrain.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnRoadYN == true)
        {
            ddlZoneRoadFromForRow1.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow1.DataValueField = "CodeId";

            ddlZoneRoadFromForRow1.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow1.DataBind();

            ddlZoneRoadFromForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow1.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow1.DataValueField = "CodeId";

            ddlZoneRoadToForRow1.DataSource = dvZone.Table;
            ddlZoneRoadToForRow1.DataBind();

            ddlZoneRoadToForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow2.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow2.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow2.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow2.DataBind();

            //ddlZoneRoadFromForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow2.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow2.DataValueField = "CodeId";

            //ddlZoneRoadToForRow2.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow2.DataBind();

            //ddlZoneRoadToForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow3.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow3.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow3.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow3.DataBind();

            //ddlZoneRoadFromForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow3.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow3.DataValueField = "CodeId";

            //ddlZoneRoadToForRow3.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow3.DataBind();

            //ddlZoneRoadToForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow4.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow4.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow4.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow4.DataBind();

            //ddlZoneRoadFromForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow4.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow4.DataValueField = "CodeId";

            //ddlZoneRoadToForRow4.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow4.DataBind();

            //ddlZoneRoadToForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow5.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow5.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow5.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow5.DataBind();

            //ddlZoneRoadFromForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow5.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow5.DataValueField = "CodeId";

            //ddlZoneRoadToForRow5.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow5.DataBind();

            //ddlZoneRoadToForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow6.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow6.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow6.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow6.DataBind();

            //ddlZoneRoadFromForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow6.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow6.DataValueField = "CodeId";

            //ddlZoneRoadToForRow6.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow6.DataBind();

            //ddlZoneRoadToForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow7.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow7.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow7.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow7.DataBind();

            //ddlZoneRoadFromForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow7.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow7.DataValueField = "CodeId";

            //ddlZoneRoadToForRow7.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow7.DataBind();

            //ddlZoneRoadToForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow8.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow8.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow8.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow8.DataBind();

            //ddlZoneRoadFromForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow8.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow8.DataValueField = "CodeId";

            //ddlZoneRoadToForRow8.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow8.DataBind();

            //ddlZoneRoadToForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow9.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow9.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow9.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow9.DataBind();

            //ddlZoneRoadFromForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow9.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow9.DataValueField = "CodeId";

            //ddlZoneRoadToForRow9.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow9.DataBind();

            //ddlZoneRoadToForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadFromForRow10.DataTextField = "CodeDesc";
            //ddlZoneRoadFromForRow10.DataValueField = "CodeId";

            //ddlZoneRoadFromForRow10.DataSource = dvZone.Table;
            //ddlZoneRoadFromForRow10.DataBind();

            //ddlZoneRoadFromForRow10.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneRoadToForRow10.DataTextField = "CodeDesc";
            //ddlZoneRoadToForRow10.DataValueField = "CodeId";

            //ddlZoneRoadToForRow10.DataSource = dvZone.Table;
            //ddlZoneRoadToForRow10.DataBind();

            //ddlZoneRoadToForRow10.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnExpressYN == true)
        {
            ddlZoneExpressFromForRow1.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow1.DataValueField = "CodeId";

            ddlZoneExpressFromForRow1.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow1.DataBind();

            ddlZoneExpressFromForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow1.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow1.DataValueField = "CodeId";

            ddlZoneExpressToForRow1.DataSource = dvZone.Table;
            ddlZoneExpressToForRow1.DataBind();

            ddlZoneExpressToForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow2.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow2.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow2.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow2.DataBind();

            //ddlZoneExpressFromForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow2.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow2.DataValueField = "CodeId";

            //ddlZoneExpressToForRow2.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow2.DataBind();

            //ddlZoneExpressToForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow3.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow3.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow3.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow3.DataBind();

            //ddlZoneExpressFromForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow3.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow3.DataValueField = "CodeId";

            //ddlZoneExpressToForRow3.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow3.DataBind();

            //ddlZoneExpressToForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow4.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow4.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow4.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow4.DataBind();

            //ddlZoneExpressFromForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow4.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow4.DataValueField = "CodeId";

            //ddlZoneExpressToForRow4.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow4.DataBind();

            //ddlZoneExpressToForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow5.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow5.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow5.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow5.DataBind();

            //ddlZoneExpressFromForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow5.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow5.DataValueField = "CodeId";

            //ddlZoneExpressToForRow5.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow5.DataBind();

            //ddlZoneExpressToForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow6.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow6.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow6.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow6.DataBind();

            //ddlZoneExpressFromForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow6.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow6.DataValueField = "CodeId";

            //ddlZoneExpressToForRow6.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow6.DataBind();

            //ddlZoneExpressToForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow7.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow7.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow7.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow7.DataBind();

            //ddlZoneExpressFromForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow7.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow7.DataValueField = "CodeId";

            //ddlZoneExpressToForRow7.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow7.DataBind();

            //ddlZoneExpressToForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow8.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow8.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow8.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow8.DataBind();

            //ddlZoneExpressFromForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow8.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow8.DataValueField = "CodeId";

            //ddlZoneExpressToForRow8.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow8.DataBind();

            //ddlZoneExpressToForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow9.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow9.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow9.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow9.DataBind();

            //ddlZoneExpressFromForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow9.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow9.DataValueField = "CodeId";

            //ddlZoneExpressToForRow9.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow9.DataBind();

            //ddlZoneExpressToForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressFromForRow10.DataTextField = "CodeDesc";
            //ddlZoneExpressFromForRow10.DataValueField = "CodeId";

            //ddlZoneExpressFromForRow10.DataSource = dvZone.Table;
            //ddlZoneExpressFromForRow10.DataBind();

            //ddlZoneExpressFromForRow10.Items.Insert(0, new ListItem("Select", "-1"));

            //ddlZoneExpressToForRow10.DataTextField = "CodeDesc";
            //ddlZoneExpressToForRow10.DataValueField = "CodeId";

            //ddlZoneExpressToForRow10.DataSource = dvZone.Table;
            //ddlZoneExpressToForRow10.DataBind();

            //ddlZoneExpressToForRow10.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnAirYN == true)
        {
            ddlZoneAirFromForRow1.DataTextField = "CodeDesc";
            ddlZoneAirFromForRow1.DataValueField = "CodeId";

            ddlZoneAirFromForRow1.DataSource = dvZone.Table;
            ddlZoneAirFromForRow1.DataBind();

            ddlZoneAirFromForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneAirToForRow1.DataTextField = "CodeDesc";
            ddlZoneAirToForRow1.DataValueField = "CodeId";

            ddlZoneAirToForRow1.DataSource = dvZone.Table;
            ddlZoneAirToForRow1.DataBind();

            ddlZoneAirToForRow1.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnTrainYN == true)
        {
            ddlZoneTrainFromForRow1.DataTextField = "CodeDesc";
            ddlZoneTrainFromForRow1.DataValueField = "CodeId";

            ddlZoneTrainFromForRow1.DataSource = dvZone.Table;
            ddlZoneTrainFromForRow1.DataBind();

            ddlZoneTrainFromForRow1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneTrainToForRow1.DataTextField = "CodeDesc";
            ddlZoneTrainToForRow1.DataValueField = "CodeId";

            ddlZoneTrainToForRow1.DataSource = dvZone.Table;
            ddlZoneTrainToForRow1.DataBind();

            ddlZoneTrainToForRow1.Items.Insert(0, new ListItem("Select", "-1"));
        }

        sqlConn.Close();
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
    }

    private void manageSubmitClick()
    {
        SqlCommand sqlCommand;
        string strSQL;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        //Update WEBX_CUSTCONTRACT_HDR table
        strSQL = "Update WEBX_CUSTCONTRACT_HDR set single_slab_yn='" + (HidSlab.Value == "S" ? "Y" : "N") +
                        "', multiple_slab_yn='" + (HidSlab.Value == "S" ? "N" : "Y") +
                        "' where custcode = '" + HidCustCode.Value + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        strSQL = "DELETE FROM WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR where ContractId = '" + HidContractID.Value + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 1
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB1', " + (txtFromSlab1.Value == "" ? "NULL" : txtFromSlab1.Value) + ", " +
                 (txtToSlab1.Value == "" ? "NULL" : txtToSlab1.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        sqlCommand = null;

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 2
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB2', " + (txtFromSlab2.Value == "" ? "NULL" : txtFromSlab2.Value) + ", " +
                 (txtToSlab2.Value == "" ? "NULL" : txtToSlab2.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        sqlCommand = null;

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 3
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB3', " + (txtFromSlab3.Value == "" ? "NULL" : txtFromSlab3.Value) + ", " +
                 (txtToSlab3.Value == "" ? "NULL" : txtToSlab3.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        sqlCommand = null;

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 4
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB4', " + (txtFromSlab4.Value == "" ? "NULL" : txtFromSlab4.Value) + ", " +
                 (txtToSlab4.Value == "" ? "NULL" : txtToSlab4.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        sqlCommand = null;

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 5
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB5', " + (txtFromSlab5.Value == "" ? "NULL" : txtFromSlab5.Value) + ", " +
                 (txtToSlab5.Value == "" ? "NULL" : txtToSlab5.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        sqlCommand = null;

        //Insert Record in WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR table for Slab 6
        strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                 "slab_code, slab_from, slab_to) VALUES ('" + HidContractID.Value + "', '" + HidCustCode.Value + "', '" +
                 ddlRateType.SelectedValue + "', 'SLAB6', " + (txtFromSlab6.Value == "" ? "NULL" : txtFromSlab6.Value) + ", " +
                 (txtToSlab6.Value == "" ? "NULL" : txtToSlab6.Value) + ")";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        strSQL = "DELETE FROM WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where ContractId = '" + HidContractID.Value + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        //Manage Branch Matrix For Road
        if (trForRoadForBranch.Visible == true)
        {
            if (HidBMRoad.Value != "")
            {
                string[] strArrBM = HidBMRoad.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strRoad + "', 'L', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Branch Matrix For Express
        if (trForExpressForBranch.Visible == true)
        {
            if (HidBMExpress.Value != "")
            {
                string[] strArrBM = HidBMExpress.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strExpress + "', 'L', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Branch Matrix For Air
        if (trForAirForBranch.Visible == true)
        {
            if (HidBMAir.Value != "")
            {
                string[] strArrBM = HidBMAir.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strAir + "', 'L', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Branch Matrix For Train
        if (trForTrainForBranch.Visible == true)
        {
            if (HidBMTrain.Value != "")
            {
                string[] strArrBM = HidBMTrain.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strTrain + "', 'L', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Road
        if (trForRoadForZone.Visible == true)
        {
            if (HidZMRoad.Value != "")
            {
                string[] strArrBM = HidZMRoad.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strRoad + "', 'R', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Express
        if (trForExpressForZone.Visible == true)
        {
            if (HidZMExpress.Value != "")
            {
                string[] strArrBM = HidZMExpress.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strExpress + "', 'R', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Air
        if (trForAirForZone.Visible == true)
        {
            if (HidZMAir.Value != "")
            {
                string[] strArrBM = HidZMAir.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strAir + "', 'R', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Train
        if (trForTrainForZone.Visible == true)
        {
            if (HidZMTrain.Value != "")
            {
                string[] strArrBM = HidZMTrain.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strTrain + "', 'R', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Road
        if (trForRoadForCity.Visible == true)
        {
            if (HidCMRoad.Value != "")
            {
                string[] strArrBM = HidCMRoad.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strRoad + "', 'C', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Express
        if (trForExpressForCity.Visible == true)
        {
            if (HidCMExpress.Value != "")
            {
                string[] strArrBM = HidCMExpress.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strExpress + "', 'C', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Air
        if (trForAirForCity.Visible == true)
        {
            if (HidCMAir.Value != "")
            {
                string[] strArrBM = HidCMAir.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strAir + "', 'C', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Train
        if (trForTrainForCity.Visible == true)
        {
            if (HidCMTrain.Value != "")
            {
                string[] strArrBM = HidCMTrain.Value.Split('~');

                for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
                {
                    sqlCommand = null;

                    string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                    sqlCommand = null;
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET (ContractId, Custcode, destcode, " +
                             "From_Loccode, To_Loccode, trdays, RateType, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, " +
                             "PayType, trans_type, LOC_REG, reverse_rate) values ('" +
                             HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[1] + "', '" +
                             strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", '" +
                             strInnerArrBM[3] + "', " + (strInnerArrBM[4] == "" ? "NULL" : strInnerArrBM[4]) + ", " +
                             (strInnerArrBM[5] == "" ? "NULL" : strInnerArrBM[5]) + ", " +
                             (strInnerArrBM[6] == "" ? "NULL" : strInnerArrBM[6]) + ", " +
                             (strInnerArrBM[7] == "" ? "NULL" : strInnerArrBM[7]) + ", " +
                             (strInnerArrBM[8] == "" ? "NULL" : strInnerArrBM[8]) + ", " +
                             (strInnerArrBM[9] == "" ? "NULL" : strInnerArrBM[9]) + ", " + "'', '" + strTrain + "', 'C', NULL)";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
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
            HidContractID.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContractID"].ToString();
        }
        else
        {

        }
    }
    //protected void txtFRToExpressForCity10_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity10.Text = txtFRToExpressForCity10.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity10.Text != "")
    //    {
    //        lblErrorFRToExpressForCity10.Visible = (!CheckValidCity(txtFRToExpressForCity10.Text));
    //        if (lblErrorFRToExpressForCity10.Visible == true)
    //        {
    //            txtFRToExpressForCity10.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity9_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity9.Text = txtFRToExpressForCity9.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity9.Text != "")
    //    {
    //        lblErrorFRToExpressForCity9.Visible = (!CheckValidCity(txtFRToExpressForCity9.Text));
    //        if (lblErrorFRToExpressForCity9.Visible == true)
    //        {
    //            txtFRToExpressForCity9.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity8_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity8.Text = txtFRToExpressForCity8.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity8.Text != "")
    //    {
    //        lblErrorFRToExpressForCity8.Visible = (!CheckValidCity(txtFRToExpressForCity8.Text));
    //        if (lblErrorFRToExpressForCity8.Visible == true)
    //        {
    //            txtFRToExpressForCity8.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity7_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity7.Text = txtFRToExpressForCity7.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity7.Text != "")
    //    {
    //        lblErrorFRToExpressForCity7.Visible = (!CheckValidCity(txtFRToExpressForCity7.Text));
    //        if (lblErrorFRToExpressForCity7.Visible == true)
    //        {
    //            txtFRToExpressForCity7.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity6_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity6.Text = txtFRToExpressForCity6.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity6.Text != "")
    //    {
    //        lblErrorFRToExpressForCity6.Visible = (!CheckValidCity(txtFRToExpressForCity6.Text));
    //        if (lblErrorFRToExpressForCity6.Visible == true)
    //        {
    //            txtFRToExpressForCity6.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity5_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity5.Text = txtFRToExpressForCity5.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity5.Text != "")
    //    {
    //        lblErrorFRToExpressForCity5.Visible = (!CheckValidCity(txtFRToExpressForCity5.Text));
    //        if (lblErrorFRToExpressForCity5.Visible == true)
    //        {
    //            txtFRToExpressForCity5.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity4_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity4.Text = txtFRToExpressForCity4.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity4.Text != "")
    //    {
    //        lblErrorFRToExpressForCity4.Visible = (!CheckValidCity(txtFRToExpressForCity4.Text));
    //        if (lblErrorFRToExpressForCity4.Visible == true)
    //        {
    //            txtFRToExpressForCity4.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity3_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity3.Text = txtFRToExpressForCity3.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity3.Text != "")
    //    {
    //        lblErrorFRToExpressForCity3.Visible = (!CheckValidCity(txtFRToExpressForCity3.Text));
    //        if (lblErrorFRToExpressForCity3.Visible == true)
    //        {
    //            txtFRToExpressForCity3.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity2_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity2.Text = txtFRToExpressForCity2.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity2.Text != "")
    //    {
    //        lblErrorFRToExpressForCity2.Visible = (!CheckValidCity(txtFRToExpressForCity2.Text));
    //        if (lblErrorFRToExpressForCity2.Visible == true)
    //        {
    //            txtFRToExpressForCity2.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToExpressForCity1_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToExpressForCity1.Text = txtFRToExpressForCity1.Text.Trim().ToUpper();
    //    if (txtFRToExpressForCity1.Text != "")
    //    {
    //        lblErrorFRToExpressForCity1.Visible = (!CheckValidCity(txtFRToExpressForCity1.Text));
    //        if (lblErrorFRToExpressForCity1.Visible == true)
    //        {
    //            txtFRToExpressForCity1.Focus();
    //        }
    //    }
    //}

    //protected void txtFRFromExpressForCity10_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity10.Text = txtFRFromExpressForCity10.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity10.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity10.Visible = (!CheckValidCity(txtFRFromExpressForCity10.Text));
    //        if (lblErrorFRFromExpressForCity10.Visible == true)
    //        {
    //            txtFRFromExpressForCity10.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity9_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity9.Text = txtFRFromExpressForCity9.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity9.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity9.Visible = (!CheckValidCity(txtFRFromExpressForCity9.Text));
    //        if (lblErrorFRFromExpressForCity9.Visible == true)
    //        {
    //            txtFRFromExpressForCity9.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity8_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity8.Text = txtFRFromExpressForCity8.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity8.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity8.Visible = (!CheckValidCity(txtFRFromExpressForCity8.Text));
    //        if (lblErrorFRFromExpressForCity8.Visible == true)
    //        {
    //            txtFRFromExpressForCity8.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity7_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity7.Text = txtFRFromExpressForCity7.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity7.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity7.Visible = (!CheckValidCity(txtFRFromExpressForCity7.Text));
    //        if (lblErrorFRFromExpressForCity7.Visible == true)
    //        {
    //            txtFRFromExpressForCity7.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity6_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity6.Text = txtFRFromExpressForCity6.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity6.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity6.Visible = (!CheckValidCity(txtFRFromExpressForCity6.Text));
    //        if (lblErrorFRFromExpressForCity6.Visible == true)
    //        {
    //            txtFRFromExpressForCity6.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity5_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity5.Text = txtFRFromExpressForCity5.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity5.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity5.Visible = (!CheckValidCity(txtFRFromExpressForCity5.Text));
    //        if (lblErrorFRFromExpressForCity5.Visible == true)
    //        {
    //            txtFRFromExpressForCity5.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity4_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity4.Text = txtFRFromExpressForCity4.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity4.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity4.Visible = (!CheckValidCity(txtFRFromExpressForCity4.Text));
    //        if (lblErrorFRFromExpressForCity4.Visible == true)
    //        {
    //            txtFRFromExpressForCity4.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity3_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity3.Text = txtFRFromExpressForCity3.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity3.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity3.Visible = (!CheckValidCity(txtFRFromExpressForCity3.Text));
    //        if (lblErrorFRFromExpressForCity3.Visible == true)
    //        {
    //            txtFRFromExpressForCity3.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity2_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity2.Text = txtFRFromExpressForCity2.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity2.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity2.Visible = (!CheckValidCity(txtFRFromExpressForCity2.Text));
    //        if (lblErrorFRFromExpressForCity2.Visible == true)
    //        {
    //            txtFRFromExpressForCity2.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromExpressForCity1_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromExpressForCity1.Text = txtFRFromExpressForCity1.Text.Trim().ToUpper();
    //    if (txtFRFromExpressForCity1.Text != "")
    //    {
    //        lblErrorFRFromExpressForCity1.Visible = (!CheckValidCity(txtFRFromExpressForCity1.Text));
    //        if (lblErrorFRFromExpressForCity1.Visible == true)
    //        {
    //            txtFRFromExpressForCity1.Focus();
    //        }
    //    }
    //}

    protected void txtCityCodeExpress_TextChanged(object sender, EventArgs e)
    {
        lblErrorCityCodeExpress.Visible = false;
        txtCityCodeExpress.Text = txtCityCodeExpress.Text.Trim().ToUpper();
        if (txtCityCodeExpress.Text != "")
        {
            lblErrorCityCodeExpress.Visible = (!CheckValidCity(txtCityCodeExpress.Text));
            if (lblErrorCityCodeExpress.Visible == true)
            {
                txtCityCodeExpress.Focus();
            }
        }
    }
    //protected void txtFRToRoadForCity10_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity10.Text = txtFRToRoadForCity10.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity10.Text != "")
    //    {
    //        lblErrorFRToRoadForCity10.Visible = (!CheckValidCity(txtFRToRoadForCity10.Text));
    //        if (lblErrorFRToRoadForCity10.Visible == true)
    //        {
    //            txtFRToRoadForCity10.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity9_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity9.Text = txtFRToRoadForCity9.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity9.Text != "")
    //    {
    //        lblErrorFRToRoadForCity9.Visible = (!CheckValidCity(txtFRToRoadForCity9.Text));
    //        if (lblErrorFRToRoadForCity9.Visible == true)
    //        {
    //            txtFRToRoadForCity9.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity8_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity8.Text = txtFRToRoadForCity8.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity8.Text != "")
    //    {
    //        lblErrorFRToRoadForCity8.Visible = (!CheckValidCity(txtFRToRoadForCity8.Text));
    //        if (lblErrorFRToRoadForCity8.Visible == true)
    //        {
    //            txtFRToRoadForCity8.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity7_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity7.Text = txtFRToRoadForCity7.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity7.Text != "")
    //    {
    //        lblErrorFRToRoadForCity7.Visible = (!CheckValidCity(txtFRToRoadForCity7.Text));
    //        if (lblErrorFRToRoadForCity7.Visible == true)
    //        {
    //            txtFRToRoadForCity7.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity6_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity6.Text = txtFRToRoadForCity6.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity6.Text != "")
    //    {
    //        lblErrorFRToRoadForCity6.Visible = (!CheckValidCity(txtFRToRoadForCity6.Text));
    //        if (lblErrorFRToRoadForCity6.Visible == true)
    //        {
    //            txtFRToRoadForCity6.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity5_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity5.Text = txtFRToRoadForCity5.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity5.Text != "")
    //    {
    //        lblErrorFRToRoadForCity5.Visible = (!CheckValidCity(txtFRToRoadForCity5.Text));
    //        if (lblErrorFRToRoadForCity5.Visible == true)
    //        {
    //            txtFRToRoadForCity5.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity4_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity4.Text = txtFRToRoadForCity4.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity4.Text != "")
    //    {
    //        lblErrorFRToRoadForCity4.Visible = (!CheckValidCity(txtFRToRoadForCity4.Text));
    //        if (lblErrorFRToRoadForCity4.Visible == true)
    //        {
    //            txtFRToRoadForCity4.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity3_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity3.Text = txtFRToRoadForCity3.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity3.Text != "")
    //    {
    //        lblErrorFRToRoadForCity3.Visible = (!CheckValidCity(txtFRToRoadForCity3.Text));
    //        if (lblErrorFRToRoadForCity3.Visible == true)
    //        {
    //            txtFRToRoadForCity3.Focus();
    //        }
    //    }
    //}
    //protected void txtFRToRoadForCity2_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRToRoadForCity2.Text = txtFRToRoadForCity2.Text.Trim().ToUpper();
    //    if (txtFRToRoadForCity2.Text != "")
    //    {
    //        lblErrorFRToRoadForCity2.Visible = (!CheckValidCity(txtFRToRoadForCity2.Text));
    //        if (lblErrorFRToRoadForCity2.Visible == true)
    //        {
    //            txtFRToRoadForCity2.Focus();
    //        }
    //    }
    //}
    protected void txtFromForRoadForCity1_TextChanged(object sender, EventArgs e)
    {
        lblFromForRoadForCity1.Visible = false;
        txtFromForRoadForCity1.Text = txtFromForRoadForCity1.Text.Trim().ToUpper();
        if (txtFromForRoadForCity1.Text != "")
        {
            lblFromForRoadForCity1.Visible = (!CheckValidCity(txtFromForRoadForCity1.Text));
            if (lblFromForRoadForCity1.Visible == true)
            {
                txtFromForRoadForCity1.Focus();
            }
        }
    }
    protected void txtCityCodeRoad_TextChanged(object sender, EventArgs e)
    {
        lblErrorCityCodeRoad.Visible = false;
        txtCityCodeRoad.Text = txtCityCodeRoad.Text.Trim().ToUpper();
        if (txtCityCodeRoad.Text != "")
        {
            lblErrorCityCodeRoad.Visible = (!CheckValidCity(txtCityCodeRoad.Text));
            if (lblErrorCityCodeRoad.Visible == true)
            {
                txtCityCodeRoad.Focus();
            }
        }
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
                        break;
                    case "R":
                        HidMOTRoad.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        break;
                    case "T":
                        HidMOTTrain.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        break;
                    case "E":
                        HidMOTExpress.Value = strArrMOT[intLoopCounter] + "," + "Y";
                        break;
                }
            }
        }
    }
    protected void txtBranchCodeExpress_TextChanged(object sender, EventArgs e)
    {
        lblErrorBranchCodeExpress.Visible = false;
        txtBranchCodeExpress.Text = txtBranchCodeExpress.Text.Trim().ToUpper();
        if (txtBranchCodeExpress.Text != "")
        {
            lblErrorBranchCodeExpress.Visible = (!CheckValidBranch(txtBranchCodeExpress.Text));
            if (lblErrorBranchCodeExpress.Visible == true)
            {
                txtBranchCodeExpress.Focus();
            }
        }
    }
    //protected void txtFRFromRoadForCity1_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity1.Text = txtFRFromRoadForCity1.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity1.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity1.Visible = (!CheckValidCity(txtFRFromRoadForCity1.Text));
    //        if (lblErrorFRFromRoadForCity1.Visible == true)
    //        {
    //            txtFRFromRoadForCity1.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity2_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity2.Text = txtFRFromRoadForCity2.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity2.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity2.Visible = (!CheckValidCity(txtFRFromRoadForCity2.Text));
    //        if (lblErrorFRFromRoadForCity2.Visible == true)
    //        {
    //            txtFRFromRoadForCity2.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity3_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity3.Text = txtFRFromRoadForCity3.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity3.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity3.Visible = (!CheckValidCity(txtFRFromRoadForCity3.Text));
    //        if (lblErrorFRFromRoadForCity3.Visible == true)
    //        {
    //            txtFRFromRoadForCity3.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity4_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity4.Text = txtFRFromRoadForCity4.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity4.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity4.Visible = (!CheckValidCity(txtFRFromRoadForCity4.Text));
    //        if (lblErrorFRFromRoadForCity4.Visible == true)
    //        {
    //            txtFRFromRoadForCity4.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity5_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity5.Text = txtFRFromRoadForCity5.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity5.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity5.Visible = (!CheckValidCity(txtFRFromRoadForCity5.Text));
    //        if (lblErrorFRFromRoadForCity5.Visible == true)
    //        {
    //            txtFRFromRoadForCity5.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity6_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity6.Text = txtFRFromRoadForCity6.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity6.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity6.Visible = (!CheckValidCity(txtFRFromRoadForCity6.Text));
    //        if (lblErrorFRFromRoadForCity6.Visible == true)
    //        {
    //            txtFRFromRoadForCity6.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity7_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity7.Text = txtFRFromRoadForCity7.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity7.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity7.Visible = (!CheckValidCity(txtFRFromRoadForCity7.Text));
    //        if (lblErrorFRFromRoadForCity7.Visible == true)
    //        {
    //            txtFRFromRoadForCity7.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity8_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity8.Text = txtFRFromRoadForCity8.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity8.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity8.Visible = (!CheckValidCity(txtFRFromRoadForCity8.Text));
    //        if (lblErrorFRFromRoadForCity8.Visible == true)
    //        {
    //            txtFRFromRoadForCity8.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity9_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity9.Text = txtFRFromRoadForCity9.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity9.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity9.Visible = (!CheckValidCity(txtFRFromRoadForCity9.Text));
    //        if (lblErrorFRFromRoadForCity9.Visible == true)
    //        {
    //            txtFRFromRoadForCity9.Focus();
    //        }
    //    }
    //}
    //protected void txtFRFromRoadForCity10_TextChanged(object sender, EventArgs e)
    //{
    //    txtFRFromRoadForCity10.Text = txtFRFromRoadForCity10.Text.Trim().ToUpper();
    //    if (txtFRFromRoadForCity10.Text != "")
    //    {
    //        lblErrorFRFromRoadForCity10.Visible = (!CheckValidCity(txtFRFromRoadForCity10.Text));
    //        if (lblErrorFRFromRoadForCity10.Visible == true)
    //        {
    //            txtFRFromRoadForCity10.Focus();
    //        }
    //    }
    //}
    protected void txtToForRoadForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblToForRoadForBranch1.Visible = false;
        txtToForRoadForBranch1.Text = txtToForRoadForBranch1.Text.Trim().ToUpper();
        if (txtToForRoadForBranch1.Text != "")
        {
            lblToForRoadForBranch1.Visible = (!CheckValidBranch(txtToForRoadForBranch1.Text));
            if (lblToForRoadForBranch1.Visible == true)
            {
                txtToForRoadForBranch1.Focus();
            }
        }
    }
    protected void txtToForExpressForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblToForExpressForBranch1.Visible = false;
        txtToForExpressForBranch1.Text = txtToForExpressForBranch1.Text.Trim().ToUpper();
        if (txtToForExpressForBranch1.Text != "")
        {
            lblToForExpressForBranch1.Visible = (!CheckValidBranch(txtToForExpressForBranch1.Text));
            if (lblToForExpressForBranch1.Visible == true)
            {
                txtToForExpressForBranch1.Focus();
            }
        }
    }
    protected void txtBranchCodeAir_TextChanged(object sender, EventArgs e)
    {
        lblErrorBranchCodeAir.Visible = false;
        txtBranchCodeAir.Text = txtBranchCodeAir.Text.Trim().ToUpper();
        if (txtBranchCodeAir.Text != "")
        {
            lblErrorBranchCodeAir.Visible = (!CheckValidBranch(txtBranchCodeAir.Text));
            if (lblErrorBranchCodeAir.Visible == true)
            {
                txtBranchCodeAir.Focus();
            }
        }
    }
    protected void txtFromForAirForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblFromForAirForBranch1.Visible = false;
        txtFromForAirForBranch1.Text = txtFromForAirForBranch1.Text.Trim().ToUpper();
        if (txtFromForAirForBranch1.Text != "")
        {
            lblFromForAirForBranch1.Visible = (!CheckValidBranch(txtFromForAirForBranch1.Text));
            if (lblFromForAirForBranch1.Visible == true)
            {
                txtFromForAirForBranch1.Focus();
            }
        }
    }
    protected void txtToForAirForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblToForAirForBranch1.Visible = false;
        txtToForAirForBranch1.Text = txtToForAirForBranch1.Text.Trim().ToUpper();
        if (txtToForAirForBranch1.Text != "")
        {
            lblToForAirForBranch1.Visible = (!CheckValidBranch(txtToForAirForBranch1.Text));
            if (lblToForAirForBranch1.Visible == true)
            {
                txtToForAirForBranch1.Focus();
            }
        }
    }
    protected void txtBranchCodeTrain_TextChanged(object sender, EventArgs e)
    {
        lblErrorBranchCodeTrain.Visible = false;
        txtBranchCodeTrain.Text = txtBranchCodeTrain.Text.Trim().ToUpper();
        if (txtBranchCodeTrain.Text != "")
        {
            lblErrorBranchCodeTrain.Visible = (!CheckValidBranch(txtBranchCodeTrain.Text));
            if (lblErrorBranchCodeTrain.Visible == true)
            {
                txtBranchCodeTrain.Focus();
            }
        }
    }
    protected void txtFromForTrainForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblFromForTrainForBranch1.Visible = false;
        txtFromForTrainForBranch1.Text = txtFromForTrainForBranch1.Text.Trim().ToUpper();
        if (txtFromForTrainForBranch1.Text != "")
        {
            lblFromForTrainForBranch1.Visible = (!CheckValidBranch(txtFromForTrainForBranch1.Text));
            if (lblFromForTrainForBranch1.Visible == true)
            {
                txtFromForTrainForBranch1.Focus();
            }
        }
    }
    protected void txtToForTrainForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblToForTrainForBranch1.Visible = false;
        txtToForTrainForBranch1.Text = txtToForTrainForBranch1.Text.Trim().ToUpper();
        if (txtToForTrainForBranch1.Text != "")
        {
            lblToForTrainForBranch1.Visible = (!CheckValidBranch(txtToForTrainForBranch1.Text));
            if (lblToForTrainForBranch1.Visible == true)
            {
                txtToForTrainForBranch1.Focus();
            }
        }
    }
    protected void txtToForRoadForCity1_TextChanged(object sender, EventArgs e)
    {
        lblToForRoadForCity1.Visible = false;
        txtToForRoadForCity1.Text = txtToForRoadForCity1.Text.Trim().ToUpper();
        if (txtToForRoadForCity1.Text != "")
        {
            lblToForRoadForCity1.Visible = (!CheckValidCity(txtToForRoadForCity1.Text));
            if (lblToForRoadForCity1.Visible == true)
            {
                txtToForRoadForCity1.Focus();
            }
        }
    }
    protected void txtToForExpressForCity1_TextChanged(object sender, EventArgs e)
    {
        lblToForExpressForCity1.Visible = false;
        txtToForExpressForCity1.Text = txtToForExpressForCity1.Text.Trim().ToUpper();
        if (txtToForExpressForCity1.Text != "")
        {
            lblToForExpressForCity1.Visible = (!CheckValidCity(txtToForExpressForCity1.Text));
            if (lblToForExpressForCity1.Visible == true)
            {
                txtToForExpressForCity1.Focus();
            }
        }
    }
    protected void txtCityCodeAir_TextChanged(object sender, EventArgs e)
    {
        lblErrorCityCodeAir.Visible = false;
        txtCityCodeAir.Text = txtCityCodeAir.Text.Trim().ToUpper();
        if (txtCityCodeAir.Text != "")
        {
            lblErrorCityCodeAir.Visible = (!CheckValidCity(txtCityCodeAir.Text));
            if (lblErrorCityCodeAir.Visible == true)
            {
                txtCityCodeAir.Focus();
            }
        }
    }
    protected void txtFromForAirForCity1_TextChanged(object sender, EventArgs e)
    {
        lblFromForAirForCity1.Visible = false;
        txtFromForAirForCity1.Text = txtFromForAirForCity1.Text.Trim().ToUpper();
        if (txtFromForAirForCity1.Text != "")
        {
            lblFromForAirForCity1.Visible = (!CheckValidCity(txtFromForAirForCity1.Text));
            if (lblFromForAirForCity1.Visible == true)
            {
                txtFromForAirForCity1.Focus();
            }
        }
    }
    protected void txtToForAirForCity1_TextChanged(object sender, EventArgs e)
    {
        lblToForAirForCity1.Visible = false;
        txtToForAirForCity1.Text = txtToForAirForCity1.Text.Trim().ToUpper();
        if (txtToForAirForCity1.Text != "")
        {
            lblToForAirForCity1.Visible = (!CheckValidCity(txtToForAirForCity1.Text));
            if (lblToForAirForCity1.Visible == true)
            {
                txtToForAirForCity1.Focus();
            }
        }
    }
    protected void txtCityCodeTrain_TextChanged(object sender, EventArgs e)
    {
        lblErrorCityCodeTrain.Visible = false;
        txtCityCodeTrain.Text = txtCityCodeTrain.Text.Trim().ToUpper();
        if (txtCityCodeTrain.Text != "")
        {
            lblErrorCityCodeTrain.Visible = (!CheckValidCity(txtCityCodeTrain.Text));
            if (lblErrorCityCodeTrain.Visible == true)
            {
                txtCityCodeTrain.Focus();
            }
        }
    }
    protected void txtFromForTrainForCity1_TextChanged(object sender, EventArgs e)
    {
        lblFromForTrainForCity1.Visible = false;
        txtFromForTrainForCity1.Text = txtFromForTrainForCity1.Text.Trim().ToUpper();
        if (txtFromForTrainForCity1.Text != "")
        {
            lblFromForTrainForCity1.Visible = (!CheckValidCity(txtFromForTrainForCity1.Text));
            if (lblFromForTrainForCity1.Visible == true)
            {
                txtFromForTrainForCity1.Focus();
            }
        }
    }
    protected void txtToForTrainForCity1_TextChanged(object sender, EventArgs e)
    {
        lblToForTrainForCity1.Visible = false;
        txtToForTrainForCity1.Text = txtToForTrainForCity1.Text.Trim().ToUpper();
        if (txtToForTrainForCity1.Text != "")
        {
            lblToForTrainForCity1.Visible = (!CheckValidCity(txtToForTrainForCity1.Text));
            if (lblToForTrainForCity1.Visible == true)
            {
                txtToForTrainForCity1.Focus();
            }
        }
    }

    private void displayData()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;
        SqlDataAdapter sqlDA;
        DataSet dsCCM;

        //Slab Definition
        string strSQL = "select top 1 " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB1') AS Slab1From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB1') AS Slab1To, " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB2') AS Slab2From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB2') AS Slab2To, " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB3') AS Slab3From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB3') AS Slab3To, " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB4') AS Slab4From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB4') AS Slab4To, " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB5') AS Slab5From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB5') AS Slab5To, " +
                        "(select slab_from from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB6') AS Slab6From, " +
                        "(select slab_to from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.ContractID = OuterODAMatrix.ContractID AND UPPER(slab_code) = 'SLAB6') AS Slab6To, matrix_type " +
                        "FROM WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR OuterODAMatrix WHERE ContractId = '" + HidContractID.Value + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();

        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            ddlRateType.SelectedValue = (dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["matrix_type"].ToString());
            txtFromSlab1.Value = (dsCCM.Tables[0].Rows[0]["Slab1From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab1From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab1From"].ToString());
            txtToSlab1.Value = (dsCCM.Tables[0].Rows[0]["Slab1To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab1To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab1To"].ToString());
            txtFromSlab2.Value = (dsCCM.Tables[0].Rows[0]["Slab2From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab2From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab2From"].ToString());
            txtToSlab2.Value = (dsCCM.Tables[0].Rows[0]["Slab2To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab2To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab2To"].ToString());
            txtFromSlab3.Value = (dsCCM.Tables[0].Rows[0]["Slab3From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab3From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab3From"].ToString());
            txtToSlab3.Value = (dsCCM.Tables[0].Rows[0]["Slab3To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab3To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab3To"].ToString());
            txtFromSlab4.Value = (dsCCM.Tables[0].Rows[0]["Slab4From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab4From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab4From"].ToString());
            txtToSlab4.Value = (dsCCM.Tables[0].Rows[0]["Slab4To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab4To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab4To"].ToString());
            txtFromSlab5.Value = (dsCCM.Tables[0].Rows[0]["Slab5From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab5From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab5From"].ToString());
            txtToSlab5.Value = (dsCCM.Tables[0].Rows[0]["Slab5To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab5To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab5To"].ToString());
            txtFromSlab6.Value = (dsCCM.Tables[0].Rows[0]["Slab6From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab6From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab6From"].ToString());
            txtToSlab6.Value = (dsCCM.Tables[0].Rows[0]["Slab6To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab6To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab6To"].ToString());
        }

        //Branch Matrix for Road
        if (blnRoadYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strRoad.ToUpper() + "' and LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForRoadForBranch1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForRoadForBranch1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForRoadForBranch1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForRoadBranch1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForRoadBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Branch Matrix for Express
        if (blnExpressYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strExpress.ToUpper() + "' and LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForExpressForBranch1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForExpressForBranch1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForExpressForBranch1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForExpressBranch1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForExpressBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Branch Matrix for Air
        if (blnAirYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strAir.ToUpper() + "' and LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForAirForBranch1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForAirForBranch1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForAirForBranch1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForAirBranch1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForAirBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Branch Matrix for Train
        if (blnTrainYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strTrain.ToUpper() + "' and LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForTrainForBranch1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForTrainForBranch1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForTrainForBranch1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForTrainBranch1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForTrainBranch1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Zone Matrix for Road
        if (blnRoadYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strRoad.ToUpper() + "' and LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                ddlZoneRoadFromForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                ddlZoneRoadToForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForRoadForZone1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForRoadZone1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForRoadZone1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Zone Matrix for Express
        if (blnExpressYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strExpress.ToUpper() + "' and LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                ddlZoneExpressFromForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                ddlZoneExpressToForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForExpressForZone1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForExpressZone1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForExpressZone1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Zone Matrix for Air
        if (blnAirYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strAir.ToUpper() + "' and LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                ddlZoneAirFromForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                ddlZoneAirToForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForAirForZone1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForAirZone1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForAirZone1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //Zone Matrix for Train
        if (blnTrainYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strTrain.ToUpper() + "' and LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                ddlZoneTrainFromForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                ddlZoneTrainToForRow1.SelectedValue = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForTrainForZone1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForTrainZone1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForTrainZone1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //City Matrix for Road
        if (blnRoadYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strRoad.ToUpper() + "' and LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForRoadForCity1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForRoadForCity1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForRoadForCity1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForRoadCity1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForRoadCity1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //City Matrix for Express
        if (blnExpressYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strExpress.ToUpper() + "' and LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForExpressForCity1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForExpressForCity1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForExpressForCity1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForExpressCity1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForExpressCity1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //City Matrix for Air
        if (blnAirYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strAir.ToUpper() + "' and LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForAirForCity1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForAirForCity1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForAirForCity1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForAirCity1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForAirCity1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }

        //City Matrix for Train
        if (blnTrainYN == true)
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where contractid = '" + HidContractID.Value + "' and UPPER(trans_type) = '" + strTrain.ToUpper() + "' and LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();

            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                txtFromForTrainForCity1.Text = (dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["from_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["from_loccode"].ToString());
                txtToForTrainForCity1.Text = (dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["to_loccode"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["to_loccode"].ToString());

                txtTrDaysForTrainForCity1.Value = (dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["trdays"].ToString());
                ddlRateTypeForTrainCity1.SelectedValue = (dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["RateType"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["RateType"].ToString());
                txtSlab1ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab1"].ToString());
                txtSlab2ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab2"].ToString());
                txtSlab3ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab3"].ToString());
                txtSlab4ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab4"].ToString());
                txtSlab5ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab5"].ToString());
                txtSlab6ForTrainCity1.Value = (dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["slab6"].ToString());
            }
        }
    }
}
