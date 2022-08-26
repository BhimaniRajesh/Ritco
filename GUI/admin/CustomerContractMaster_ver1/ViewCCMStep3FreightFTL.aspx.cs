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

public partial class GUI_admin_CustomerContractMaster_EditCCMStep3FreightFTL : System.Web.UI.Page
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
            HidTL.Value = Request.QueryString["TL"].ToString();
            HidODA.Value = Request.QueryString["ODA"].ToString();

            PopulateHiddenVars();

            //Get Mode of Transport Details
            getMOTDetails();
        }

        lblNote.InnerHtml = "<b>STEP 4: Freight Matrix - " + HidTL.Value + "</b>";

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

        if (!IsPostBack)
        {
            //Populate Zone Details
            populateZoneDetails(new DataSet("dsZoneHeader"));

            //Populate FTL Details
            populateFTLList();

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
    protected void txtFRFromRoadForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch1.Visible = false;
        txtFRFromRoadForBranch1.Text = txtFRFromRoadForBranch1.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch1.Text != "")
        {
            lblErrorFRFromRoadForBranch1.Visible = (!CheckValidBranch(txtFRFromRoadForBranch1.Text));
            if (lblErrorFRFromRoadForBranch1.Visible == true)
            {
                txtFRFromRoadForBranch1.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch1.Visible = false;
        txtFRToRoadForBranch1.Text = txtFRToRoadForBranch1.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch1.Text != "")
        {
            lblErrorFRToRoadForBranch1.Visible = (!CheckValidBranch(txtFRToRoadForBranch1.Text));
            if (lblErrorFRToRoadForBranch1.Visible == true)
            {
                txtFRToRoadForBranch1.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch2.Visible = false;
        txtFRFromRoadForBranch2.Text = txtFRFromRoadForBranch2.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch2.Text != "")
        {
            lblErrorFRFromRoadForBranch2.Visible = (!CheckValidBranch(txtFRFromRoadForBranch2.Text));
            if (lblErrorFRFromRoadForBranch2.Visible == true)
            {
                txtFRFromRoadForBranch2.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch2.Visible = false;
        txtFRToRoadForBranch2.Text = txtFRToRoadForBranch2.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch2.Text != "")
        {
            lblErrorFRToRoadForBranch2.Visible = (!CheckValidBranch(txtFRToRoadForBranch2.Text));
            if (lblErrorFRToRoadForBranch2.Visible == true)
            {
                txtFRToRoadForBranch2.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch3.Visible = false;
        txtFRFromRoadForBranch3.Text = txtFRFromRoadForBranch3.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch3.Text != "")
        {
            lblErrorFRFromRoadForBranch3.Visible = (!CheckValidBranch(txtFRFromRoadForBranch3.Text));
            if (lblErrorFRFromRoadForBranch3.Visible == true)
            {
                txtFRFromRoadForBranch3.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch3.Visible = false;
        txtFRToRoadForBranch3.Text = txtFRToRoadForBranch3.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch3.Text != "")
        {
            lblErrorFRToRoadForBranch3.Visible = (!CheckValidBranch(txtFRToRoadForBranch3.Text));
            if (lblErrorFRToRoadForBranch3.Visible == true)
            {
                txtFRToRoadForBranch3.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch4.Visible = false;
        txtFRFromRoadForBranch4.Text = txtFRFromRoadForBranch4.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch4.Text != "")
        {
            lblErrorFRFromRoadForBranch4.Visible = (!CheckValidBranch(txtFRFromRoadForBranch4.Text));
            if (lblErrorFRFromRoadForBranch4.Visible == true)
            {
                txtFRFromRoadForBranch4.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch4.Visible = false;
        txtFRToRoadForBranch4.Text = txtFRToRoadForBranch4.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch4.Text != "")
        {
            lblErrorFRToRoadForBranch4.Visible = (!CheckValidBranch(txtFRToRoadForBranch4.Text));
            if (lblErrorFRToRoadForBranch4.Visible == true)
            {
                txtFRToRoadForBranch4.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch5.Visible = false;
        txtFRFromRoadForBranch5.Text = txtFRFromRoadForBranch5.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch5.Text != "")
        {
            lblErrorFRFromRoadForBranch5.Visible = (!CheckValidBranch(txtFRFromRoadForBranch5.Text));
            if (lblErrorFRFromRoadForBranch5.Visible == true)
            {
                txtFRFromRoadForBranch5.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch5.Visible = false;
        txtFRToRoadForBranch5.Text = txtFRToRoadForBranch5.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch5.Text != "")
        {
            lblErrorFRToRoadForBranch5.Visible = (!CheckValidBranch(txtFRToRoadForBranch5.Text));
            if (lblErrorFRToRoadForBranch5.Visible == true)
            {
                txtFRToRoadForBranch5.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch6.Visible = false;
        txtFRFromRoadForBranch6.Text = txtFRFromRoadForBranch6.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch6.Text != "")
        {
            lblErrorFRFromRoadForBranch6.Visible = (!CheckValidBranch(txtFRFromRoadForBranch6.Text));
            if (lblErrorFRFromRoadForBranch6.Visible == true)
            {
                txtFRFromRoadForBranch6.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoad6.Visible = false;
        txtFRToRoadForBranch6.Text = txtFRToRoadForBranch6.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch6.Text != "")
        {
            lblErrorFRToRoad6.Visible = (!CheckValidBranch(txtFRToRoadForBranch6.Text));
            if (lblErrorFRToRoad6.Visible == true)
            {
                txtFRToRoadForBranch6.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch7.Visible = false;
        txtFRFromRoadForBranch7.Text = txtFRFromRoadForBranch7.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch7.Text != "")
        {
            lblErrorFRFromRoadForBranch7.Visible = (!CheckValidBranch(txtFRFromRoadForBranch7.Text));
            if (lblErrorFRFromRoadForBranch7.Visible == true)
            {
                txtFRFromRoadForBranch7.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch7.Visible = false;
        txtFRToRoadForBranch7.Text = txtFRToRoadForBranch7.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch7.Text != "")
        {
            lblErrorFRToRoadForBranch7.Visible = (!CheckValidBranch(txtFRToRoadForBranch7.Text));
            if (lblErrorFRToRoadForBranch7.Visible == true)
            {
                txtFRToRoadForBranch7.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch8.Visible = false;
        txtFRFromRoadForBranch8.Text = txtFRFromRoadForBranch8.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch8.Text != "")
        {
            lblErrorFRFromRoadForBranch8.Visible = (!CheckValidBranch(txtFRFromRoadForBranch8.Text));
            if (lblErrorFRFromRoadForBranch8.Visible == true)
            {
                txtFRFromRoadForBranch8.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch8.Visible = false;
        txtFRToRoadForBranch8.Text = txtFRToRoadForBranch8.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch8.Text != "")
        {
            lblErrorFRToRoadForBranch8.Visible = (!CheckValidBranch(txtFRToRoadForBranch8.Text));
            if (lblErrorFRToRoadForBranch8.Visible == true)
            {
                txtFRToRoadForBranch8.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch9.Visible = false;
        txtFRFromRoadForBranch9.Text = txtFRFromRoadForBranch9.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch9.Text != "")
        {
            lblErrorFRFromRoadForBranch9.Visible = (!CheckValidBranch(txtFRFromRoadForBranch9.Text));
            if (lblErrorFRFromRoadForBranch9.Visible == true)
            {
                txtFRFromRoadForBranch9.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch9.Visible = false;
        txtFRToRoadForBranch9.Text = txtFRToRoadForBranch9.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch9.Text != "")
        {
            lblErrorFRToRoadForBranch9.Visible = (!CheckValidBranch(txtFRToRoadForBranch9.Text));
            if (lblErrorFRToRoadForBranch9.Visible == true)
            {
                txtFRToRoadForBranch9.Focus();
            }
        }
    }
    protected void txtFRFromRoadForBranch10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForBranch10.Visible = false;
        txtFRFromRoadForBranch10.Text = txtFRFromRoadForBranch10.Text.Trim().ToUpper();
        if (txtFRFromRoadForBranch10.Text != "")
        {
            lblErrorFRFromRoadForBranch10.Visible = (!CheckValidBranch(txtFRFromRoadForBranch10.Text));
            if (lblErrorFRFromRoadForBranch10.Visible == true)
            {
                txtFRFromRoadForBranch10.Focus();
            }
        }
    }
    protected void txtFRToRoadForBranch10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForBranch10.Visible = false;
        txtFRToRoadForBranch10.Text = txtFRToRoadForBranch10.Text.Trim().ToUpper();
        if (txtFRToRoadForBranch10.Text != "")
        {
            lblErrorFRToRoadForBranch10.Visible = (!CheckValidBranch(txtFRToRoadForBranch10.Text));
            if (lblErrorFRToRoadForBranch10.Visible == true)
            {
                txtFRToRoadForBranch10.Focus();
            }
        }
    }

    protected void txtFRFromExpressForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch1.Visible = false;
        txtFRFromExpressForBranch1.Text = txtFRFromExpressForBranch1.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch1.Text != "")
        {
            lblErrorFRFromExpressForBranch1.Visible = (!CheckValidBranch(txtFRFromExpressForBranch1.Text));
            if (lblErrorFRFromExpressForBranch1.Visible == true)
            {
                txtFRFromExpressForBranch1.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch1.Visible = false;
        txtFRToExpressForBranch1.Text = txtFRToExpressForBranch1.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch1.Text != "")
        {
            lblErrorFRToExpressForBranch1.Visible = (!CheckValidBranch(txtFRToExpressForBranch1.Text));
            if (lblErrorFRToExpressForBranch1.Visible == true)
            {
                txtFRToExpressForBranch1.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch2.Visible = false;
        txtFRFromExpressForBranch2.Text = txtFRFromExpressForBranch2.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch2.Text != "")
        {
            lblErrorFRFromExpressForBranch2.Visible = (!CheckValidBranch(txtFRFromExpressForBranch2.Text));
            if (lblErrorFRFromExpressForBranch2.Visible == true)
            {
                txtFRFromExpressForBranch2.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch2.Visible = false;
        txtFRToExpressForBranch2.Text = txtFRToExpressForBranch2.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch2.Text != "")
        {
            lblErrorFRToExpressForBranch2.Visible = (!CheckValidBranch(txtFRToExpressForBranch2.Text));
            if (lblErrorFRToExpressForBranch2.Visible == true)
            {
                txtFRToExpressForBranch2.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch3.Visible = false;
        txtFRFromExpressForBranch3.Text = txtFRFromExpressForBranch3.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch3.Text != "")
        {
            lblErrorFRFromExpressForBranch3.Visible = (!CheckValidBranch(txtFRFromExpressForBranch3.Text));
            if (lblErrorFRFromExpressForBranch3.Visible == true)
            {
                txtFRFromExpressForBranch3.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch3.Visible = false;
        txtFRToExpressForBranch3.Text = txtFRToExpressForBranch3.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch3.Text != "")
        {
            lblErrorFRToExpressForBranch3.Visible = (!CheckValidBranch(txtFRToExpressForBranch3.Text));
            if (lblErrorFRToExpressForBranch3.Visible == true)
            {
                txtFRToExpressForBranch3.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch4.Visible = false;
        txtFRFromExpressForBranch4.Text = txtFRFromExpressForBranch4.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch4.Text != "")
        {
            lblErrorFRFromExpressForBranch4.Visible = (!CheckValidBranch(txtFRFromExpressForBranch4.Text));
            if (lblErrorFRFromExpressForBranch4.Visible == true)
            {
                txtFRFromExpressForBranch4.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch4.Visible = false;
        txtFRToExpressForBranch4.Text = txtFRToExpressForBranch4.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch4.Text != "")
        {
            lblErrorFRToExpressForBranch4.Visible = (!CheckValidBranch(txtFRToExpressForBranch4.Text));
            if (lblErrorFRToExpressForBranch4.Visible == true)
            {
                txtFRToExpressForBranch4.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch5.Visible = false;
        txtFRFromExpressForBranch5.Text = txtFRFromExpressForBranch5.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch5.Text != "")
        {
            lblErrorFRFromExpressForBranch5.Visible = (!CheckValidBranch(txtFRFromExpressForBranch5.Text));
            if (lblErrorFRFromExpressForBranch5.Visible == true)
            {
                txtFRFromExpressForBranch5.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch5.Visible = false;
        txtFRToExpressForBranch5.Text = txtFRToExpressForBranch5.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch5.Text != "")
        {
            lblErrorFRToExpressForBranch5.Visible = (!CheckValidBranch(txtFRToExpressForBranch5.Text));
            if (lblErrorFRToExpressForBranch5.Visible == true)
            {
                txtFRToExpressForBranch5.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch6.Visible = false;
        txtFRFromExpressForBranch6.Text = txtFRFromExpressForBranch6.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch6.Text != "")
        {
            lblErrorFRFromExpressForBranch6.Visible = (!CheckValidBranch(txtFRFromExpressForBranch6.Text));
            if (lblErrorFRFromExpressForBranch6.Visible == true)
            {
                txtFRFromExpressForBranch6.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch6.Visible = false;
        txtFRToExpressForBranch6.Text = txtFRToExpressForBranch6.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch6.Text != "")
        {
            lblErrorFRToExpressForBranch6.Visible = (!CheckValidBranch(txtFRToExpressForBranch6.Text));
            if (lblErrorFRToExpressForBranch6.Visible == true)
            {
                txtFRToExpressForBranch6.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch7.Visible = false;
        txtFRFromExpressForBranch7.Text = txtFRFromExpressForBranch7.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch7.Text != "")
        {
            lblErrorFRFromExpressForBranch7.Visible = (!CheckValidBranch(txtFRFromExpressForBranch7.Text));
            if (lblErrorFRFromExpressForBranch7.Visible == true)
            {
                txtFRFromExpressForBranch7.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch7.Visible = false;
        txtFRToExpressForBranch7.Text = txtFRToExpressForBranch7.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch7.Text != "")
        {
            lblErrorFRToExpressForBranch7.Visible = (!CheckValidBranch(txtFRToExpressForBranch7.Text));
            if (lblErrorFRToExpressForBranch7.Visible == true)
            {
                txtFRToExpressForBranch7.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch8.Visible = false;
        txtFRFromExpressForBranch8.Text = txtFRFromExpressForBranch8.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch8.Text != "")
        {
            lblErrorFRFromExpressForBranch8.Visible = (!CheckValidBranch(txtFRFromExpressForBranch8.Text));
            if (lblErrorFRFromExpressForBranch8.Visible == true)
            {
                txtFRFromExpressForBranch8.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch8.Visible = false;
        txtFRToExpressForBranch8.Text = txtFRToExpressForBranch8.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch8.Text != "")
        {
            lblErrorFRToExpressForBranch8.Visible = (!CheckValidBranch(txtFRToExpressForBranch8.Text));
            if (lblErrorFRToExpressForBranch8.Visible == true)
            {
                txtFRToExpressForBranch8.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch9.Visible = false;
        txtFRFromExpressForBranch9.Text = txtFRFromExpressForBranch9.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch9.Text != "")
        {
            lblErrorFRFromExpressForBranch9.Visible = (!CheckValidBranch(txtFRFromExpressForBranch9.Text));
            if (lblErrorFRFromExpressForBranch9.Visible == true)
            {
                txtFRFromExpressForBranch9.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch9.Visible = false;
        txtFRToExpressForBranch9.Text = txtFRToExpressForBranch9.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch9.Text != "")
        {
            lblErrorFRToExpressForBranch9.Visible = (!CheckValidBranch(txtFRToExpressForBranch9.Text));
            if (lblErrorFRToExpressForBranch9.Visible == true)
            {
                txtFRToExpressForBranch9.Focus();
            }
        }
    }
    protected void txtFRFromExpressForBranch10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForBranch10.Visible = false;
        txtFRFromExpressForBranch10.Text = txtFRFromExpressForBranch10.Text.Trim().ToUpper();
        if (txtFRFromExpressForBranch10.Text != "")
        {
            lblErrorFRFromExpressForBranch10.Visible = (!CheckValidBranch(txtFRFromExpressForBranch10.Text));
            if (lblErrorFRFromExpressForBranch10.Visible == true)
            {
                txtFRFromExpressForBranch10.Focus();
            }
        }
    }
    protected void txtFRToExpressForBranch10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForBranch10.Visible = false;
        txtFRToExpressForBranch10.Text = txtFRToExpressForBranch10.Text.Trim().ToUpper();
        if (txtFRToExpressForBranch10.Text != "")
        {
            lblErrorFRToExpressForBranch10.Visible = (!CheckValidBranch(txtFRToExpressForBranch10.Text));
            if (lblErrorFRToExpressForBranch10.Visible == true)
            {
                txtFRToExpressForBranch10.Focus();
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

            ddlZoneRoadFromForRow2.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow2.DataValueField = "CodeId";

            ddlZoneRoadFromForRow2.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow2.DataBind();

            ddlZoneRoadFromForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow2.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow2.DataValueField = "CodeId";

            ddlZoneRoadToForRow2.DataSource = dvZone.Table;
            ddlZoneRoadToForRow2.DataBind();

            ddlZoneRoadToForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow3.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow3.DataValueField = "CodeId";

            ddlZoneRoadFromForRow3.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow3.DataBind();

            ddlZoneRoadFromForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow3.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow3.DataValueField = "CodeId";

            ddlZoneRoadToForRow3.DataSource = dvZone.Table;
            ddlZoneRoadToForRow3.DataBind();

            ddlZoneRoadToForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow4.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow4.DataValueField = "CodeId";

            ddlZoneRoadFromForRow4.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow4.DataBind();

            ddlZoneRoadFromForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow4.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow4.DataValueField = "CodeId";

            ddlZoneRoadToForRow4.DataSource = dvZone.Table;
            ddlZoneRoadToForRow4.DataBind();

            ddlZoneRoadToForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow5.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow5.DataValueField = "CodeId";

            ddlZoneRoadFromForRow5.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow5.DataBind();

            ddlZoneRoadFromForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow5.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow5.DataValueField = "CodeId";

            ddlZoneRoadToForRow5.DataSource = dvZone.Table;
            ddlZoneRoadToForRow5.DataBind();

            ddlZoneRoadToForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow6.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow6.DataValueField = "CodeId";

            ddlZoneRoadFromForRow6.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow6.DataBind();

            ddlZoneRoadFromForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow6.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow6.DataValueField = "CodeId";

            ddlZoneRoadToForRow6.DataSource = dvZone.Table;
            ddlZoneRoadToForRow6.DataBind();

            ddlZoneRoadToForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow7.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow7.DataValueField = "CodeId";

            ddlZoneRoadFromForRow7.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow7.DataBind();

            ddlZoneRoadFromForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow7.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow7.DataValueField = "CodeId";

            ddlZoneRoadToForRow7.DataSource = dvZone.Table;
            ddlZoneRoadToForRow7.DataBind();

            ddlZoneRoadToForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow8.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow8.DataValueField = "CodeId";

            ddlZoneRoadFromForRow8.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow8.DataBind();

            ddlZoneRoadFromForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow8.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow8.DataValueField = "CodeId";

            ddlZoneRoadToForRow8.DataSource = dvZone.Table;
            ddlZoneRoadToForRow8.DataBind();

            ddlZoneRoadToForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow9.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow9.DataValueField = "CodeId";

            ddlZoneRoadFromForRow9.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow9.DataBind();

            ddlZoneRoadFromForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow9.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow9.DataValueField = "CodeId";

            ddlZoneRoadToForRow9.DataSource = dvZone.Table;
            ddlZoneRoadToForRow9.DataBind();

            ddlZoneRoadToForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadFromForRow10.DataTextField = "CodeDesc";
            ddlZoneRoadFromForRow10.DataValueField = "CodeId";

            ddlZoneRoadFromForRow10.DataSource = dvZone.Table;
            ddlZoneRoadFromForRow10.DataBind();

            ddlZoneRoadFromForRow10.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneRoadToForRow10.DataTextField = "CodeDesc";
            ddlZoneRoadToForRow10.DataValueField = "CodeId";

            ddlZoneRoadToForRow10.DataSource = dvZone.Table;
            ddlZoneRoadToForRow10.DataBind();

            ddlZoneRoadToForRow10.Items.Insert(0, new ListItem("Select", "-1"));
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

            ddlZoneExpressFromForRow2.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow2.DataValueField = "CodeId";

            ddlZoneExpressFromForRow2.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow2.DataBind();

            ddlZoneExpressFromForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow2.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow2.DataValueField = "CodeId";

            ddlZoneExpressToForRow2.DataSource = dvZone.Table;
            ddlZoneExpressToForRow2.DataBind();

            ddlZoneExpressToForRow2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow3.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow3.DataValueField = "CodeId";

            ddlZoneExpressFromForRow3.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow3.DataBind();

            ddlZoneExpressFromForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow3.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow3.DataValueField = "CodeId";

            ddlZoneExpressToForRow3.DataSource = dvZone.Table;
            ddlZoneExpressToForRow3.DataBind();

            ddlZoneExpressToForRow3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow4.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow4.DataValueField = "CodeId";

            ddlZoneExpressFromForRow4.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow4.DataBind();

            ddlZoneExpressFromForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow4.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow4.DataValueField = "CodeId";

            ddlZoneExpressToForRow4.DataSource = dvZone.Table;
            ddlZoneExpressToForRow4.DataBind();

            ddlZoneExpressToForRow4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow5.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow5.DataValueField = "CodeId";

            ddlZoneExpressFromForRow5.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow5.DataBind();

            ddlZoneExpressFromForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow5.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow5.DataValueField = "CodeId";

            ddlZoneExpressToForRow5.DataSource = dvZone.Table;
            ddlZoneExpressToForRow5.DataBind();

            ddlZoneExpressToForRow5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow6.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow6.DataValueField = "CodeId";

            ddlZoneExpressFromForRow6.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow6.DataBind();

            ddlZoneExpressFromForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow6.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow6.DataValueField = "CodeId";

            ddlZoneExpressToForRow6.DataSource = dvZone.Table;
            ddlZoneExpressToForRow6.DataBind();

            ddlZoneExpressToForRow6.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow7.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow7.DataValueField = "CodeId";

            ddlZoneExpressFromForRow7.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow7.DataBind();

            ddlZoneExpressFromForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow7.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow7.DataValueField = "CodeId";

            ddlZoneExpressToForRow7.DataSource = dvZone.Table;
            ddlZoneExpressToForRow7.DataBind();

            ddlZoneExpressToForRow7.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow8.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow8.DataValueField = "CodeId";

            ddlZoneExpressFromForRow8.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow8.DataBind();

            ddlZoneExpressFromForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow8.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow8.DataValueField = "CodeId";

            ddlZoneExpressToForRow8.DataSource = dvZone.Table;
            ddlZoneExpressToForRow8.DataBind();

            ddlZoneExpressToForRow8.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow9.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow9.DataValueField = "CodeId";

            ddlZoneExpressFromForRow9.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow9.DataBind();

            ddlZoneExpressFromForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow9.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow9.DataValueField = "CodeId";

            ddlZoneExpressToForRow9.DataSource = dvZone.Table;
            ddlZoneExpressToForRow9.DataBind();

            ddlZoneExpressToForRow9.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressFromForRow10.DataTextField = "CodeDesc";
            ddlZoneExpressFromForRow10.DataValueField = "CodeId";

            ddlZoneExpressFromForRow10.DataSource = dvZone.Table;
            ddlZoneExpressFromForRow10.DataBind();

            ddlZoneExpressFromForRow10.Items.Insert(0, new ListItem("Select", "-1"));

            ddlZoneExpressToForRow10.DataTextField = "CodeDesc";
            ddlZoneExpressToForRow10.DataValueField = "CodeId";

            ddlZoneExpressToForRow10.DataSource = dvZone.Table;
            ddlZoneExpressToForRow10.DataBind();

            ddlZoneExpressToForRow10.Items.Insert(0, new ListItem("Select", "-1"));
        }

        sqlConn.Close();
    }

    private void populateFTLList()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetFTLTypes";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsFTL = new DataSet();

        sqlDA.Fill(dsFTL);

        DataView dvFTL = new DataView();

        dvFTL = dsFTL.Tables[0].DefaultView;

        if (blnRoadYN == true)
        {
            ddlFTLTypeRoadForBranch1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForBranch1.DataTextField = "codedesc";
                ddlFTLTypeRoadForBranch1.DataValueField = "codedesc";

                ddlFTLTypeRoadForBranch1.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForBranch1.DataBind();
            }

            ddlFTLTypeRoadForBranch1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForBranch2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForBranch2.DataTextField = "codedesc";
                ddlFTLTypeRoadForBranch2.DataValueField = "codedesc";

                ddlFTLTypeRoadForBranch2.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForBranch2.DataBind();
            }

            ddlFTLTypeRoadForBranch2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForBranch3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForBranch3.DataTextField = "codedesc";
                ddlFTLTypeRoadForBranch3.DataValueField = "codedesc";

                ddlFTLTypeRoadForBranch3.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForBranch3.DataBind();
            }

            ddlFTLTypeRoadForBranch3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForBranch4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForBranch4.DataTextField = "codedesc";
                ddlFTLTypeRoadForBranch4.DataValueField = "codedesc";

                ddlFTLTypeRoadForBranch4.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForBranch4.DataBind();
            }

            ddlFTLTypeRoadForBranch4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForBranch5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForBranch5.DataTextField = "codedesc";
                ddlFTLTypeRoadForBranch5.DataValueField = "codedesc";

                ddlFTLTypeRoadForBranch5.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForBranch5.DataBind();
            }

            ddlFTLTypeRoadForBranch5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForZone1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForZone1.DataTextField = "codedesc";
                ddlFTLTypeRoadForZone1.DataValueField = "codedesc";

                ddlFTLTypeRoadForZone1.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForZone1.DataBind();
            }

            ddlFTLTypeRoadForZone1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForZone2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForZone2.DataTextField = "codedesc";
                ddlFTLTypeRoadForZone2.DataValueField = "codedesc";

                ddlFTLTypeRoadForZone2.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForZone2.DataBind();
            }

            ddlFTLTypeRoadForZone2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForZone3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForZone3.DataTextField = "codedesc";
                ddlFTLTypeRoadForZone3.DataValueField = "codedesc";

                ddlFTLTypeRoadForZone3.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForZone3.DataBind();
            }

            ddlFTLTypeRoadForZone3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForZone4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForZone4.DataTextField = "codedesc";
                ddlFTLTypeRoadForZone4.DataValueField = "codedesc";

                ddlFTLTypeRoadForZone4.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForZone4.DataBind();
            }

            ddlFTLTypeRoadForZone4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForZone5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForZone5.DataTextField = "codedesc";
                ddlFTLTypeRoadForZone5.DataValueField = "codedesc";

                ddlFTLTypeRoadForZone5.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForZone5.DataBind();
            }

            ddlFTLTypeRoadForZone5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForCity1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForCity1.DataTextField = "codedesc";
                ddlFTLTypeRoadForCity1.DataValueField = "codedesc";

                ddlFTLTypeRoadForCity1.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForCity1.DataBind();
            }

            ddlFTLTypeRoadForCity1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForCity2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForCity2.DataTextField = "codedesc";
                ddlFTLTypeRoadForCity2.DataValueField = "codedesc";

                ddlFTLTypeRoadForCity2.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForCity2.DataBind();
            }

            ddlFTLTypeRoadForCity2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForCity3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForCity3.DataTextField = "codedesc";
                ddlFTLTypeRoadForCity3.DataValueField = "codedesc";

                ddlFTLTypeRoadForCity3.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForCity3.DataBind();
            }

            ddlFTLTypeRoadForCity3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForCity4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForCity4.DataTextField = "codedesc";
                ddlFTLTypeRoadForCity4.DataValueField = "codedesc";

                ddlFTLTypeRoadForCity4.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForCity4.DataBind();
            }

            ddlFTLTypeRoadForCity4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeRoadForCity5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeRoadForCity5.DataTextField = "codedesc";
                ddlFTLTypeRoadForCity5.DataValueField = "codedesc";

                ddlFTLTypeRoadForCity5.DataSource = dvFTL.Table;
                ddlFTLTypeRoadForCity5.DataBind();
            }

            ddlFTLTypeRoadForCity5.Items.Insert(0, new ListItem("Select", "-1"));
        }

        if (blnExpressYN == true)
        {
            ddlFTLTypeExpressForBranch1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForBranch1.DataTextField = "codedesc";
                ddlFTLTypeExpressForBranch1.DataValueField = "codedesc";

                ddlFTLTypeExpressForBranch1.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForBranch1.DataBind();
            }

            ddlFTLTypeExpressForBranch1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForBranch2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForBranch2.DataTextField = "codedesc";
                ddlFTLTypeExpressForBranch2.DataValueField = "codedesc";

                ddlFTLTypeExpressForBranch2.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForBranch2.DataBind();
            }

            ddlFTLTypeExpressForBranch2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForBranch3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForBranch3.DataTextField = "codedesc";
                ddlFTLTypeExpressForBranch3.DataValueField = "codedesc";

                ddlFTLTypeExpressForBranch3.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForBranch3.DataBind();
            }

            ddlFTLTypeExpressForBranch3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForBranch4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForBranch4.DataTextField = "codedesc";
                ddlFTLTypeExpressForBranch4.DataValueField = "codedesc";

                ddlFTLTypeExpressForBranch4.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForBranch4.DataBind();
            }

            ddlFTLTypeExpressForBranch4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForBranch5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForBranch5.DataTextField = "codedesc";
                ddlFTLTypeExpressForBranch5.DataValueField = "codedesc";

                ddlFTLTypeExpressForBranch5.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForBranch5.DataBind();
            }

            ddlFTLTypeExpressForBranch5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForZone1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForZone1.DataTextField = "codedesc";
                ddlFTLTypeExpressForZone1.DataValueField = "codedesc";

                ddlFTLTypeExpressForZone1.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForZone1.DataBind();
            }

            ddlFTLTypeExpressForZone1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForZone2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForZone2.DataTextField = "codedesc";
                ddlFTLTypeExpressForZone2.DataValueField = "codedesc";

                ddlFTLTypeExpressForZone2.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForZone2.DataBind();
            }

            ddlFTLTypeExpressForZone2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForZone3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForZone3.DataTextField = "codedesc";
                ddlFTLTypeExpressForZone3.DataValueField = "codedesc";

                ddlFTLTypeExpressForZone3.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForZone3.DataBind();
            }

            ddlFTLTypeExpressForZone3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForZone4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForZone4.DataTextField = "codedesc";
                ddlFTLTypeExpressForZone4.DataValueField = "codedesc";

                ddlFTLTypeExpressForZone4.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForZone4.DataBind();
            }

            ddlFTLTypeExpressForZone4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForZone5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForZone5.DataTextField = "codedesc";
                ddlFTLTypeExpressForZone5.DataValueField = "codedesc";

                ddlFTLTypeExpressForZone5.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForZone5.DataBind();
            }

            ddlFTLTypeExpressForZone5.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForCity1.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForCity1.DataTextField = "codedesc";
                ddlFTLTypeExpressForCity1.DataValueField = "codedesc";

                ddlFTLTypeExpressForCity1.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForCity1.DataBind();
            }

            ddlFTLTypeExpressForCity1.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForCity2.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForCity2.DataTextField = "codedesc";
                ddlFTLTypeExpressForCity2.DataValueField = "codedesc";

                ddlFTLTypeExpressForCity2.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForCity2.DataBind();
            }

            ddlFTLTypeExpressForCity2.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForCity3.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForCity3.DataTextField = "codedesc";
                ddlFTLTypeExpressForCity3.DataValueField = "codedesc";

                ddlFTLTypeExpressForCity3.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForCity3.DataBind();
            }

            ddlFTLTypeExpressForCity3.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForCity4.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForCity4.DataTextField = "codedesc";
                ddlFTLTypeExpressForCity4.DataValueField = "codedesc";

                ddlFTLTypeExpressForCity4.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForCity4.DataBind();
            }

            ddlFTLTypeExpressForCity4.Items.Insert(0, new ListItem("Select", "-1"));

            ddlFTLTypeExpressForCity5.Items.Clear();

            if (dsFTL.Tables[0].Rows.Count > 0)
            {
                ddlFTLTypeExpressForCity5.DataTextField = "codedesc";
                ddlFTLTypeExpressForCity5.DataValueField = "codedesc";

                ddlFTLTypeExpressForCity5.DataSource = dvFTL.Table;
                ddlFTLTypeExpressForCity5.DataBind();
            }

            ddlFTLTypeExpressForCity5.Items.Insert(0, new ListItem("Select", "-1"));
        }

        sqlConn.Close();
    }

    //protected void ddlZoneHeader_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlZoneHeader.SelectedValue == "-1")
    //    {
    //        ddlZoneToForRow1.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow2.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow3.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow4.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow5.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow6.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow7.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow8.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow9.SelectedValue = ddlZoneHeader.SelectedValue;
    //        ddlZoneToForRow10.SelectedValue = ddlZoneHeader.SelectedValue;
    //    }

    //    ddlZoneFromForRow1.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow2.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow3.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow4.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow5.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow6.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow7.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow8.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow9.SelectedValue = ddlZoneHeader.SelectedValue;
    //    ddlZoneFromForRow10.SelectedValue = ddlZoneHeader.SelectedValue;
    //}

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

        if (HidODA.Value == "Y")
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

        strSQL = "DELETE FROM WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        //Manage Branch Matrix For Road
        if (trForRoadForBranch.Visible == true)
        {
            string[] strArrBM = HidBMRoad.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeRoadForBranch1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strRoad + "', 'L', '" + ddlFTLTypeRoadForBranch1.SelectedValue + "')";

                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeRoadForBranch2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strRoad + "', 'L', '" + ddlFTLTypeRoadForBranch2.SelectedValue + "')";

                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeRoadForBranch3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strRoad + "', 'L', '" + ddlFTLTypeRoadForBranch3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeRoadForBranch4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strRoad + "', 'L', '" + ddlFTLTypeRoadForBranch4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeRoadForBranch5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strRoad + "', 'L', '" + ddlFTLTypeRoadForBranch5.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        if (trForExpressForBranch.Visible == true)
        {
            //Manage Branch Matrix For Express
            string[] strArrBM = HidBMExpress.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeExpressForBranch1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strExpress + "', 'L', '" + ddlFTLTypeExpressForBranch1.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeExpressForBranch2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strExpress + "', 'L', '" + ddlFTLTypeExpressForBranch2.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeExpressForBranch3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strExpress + "', 'L', '" + ddlFTLTypeExpressForBranch3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeExpressForBranch4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strExpress + "', 'L', '" + ddlFTLTypeExpressForBranch4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeExpressForBranch5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strExpress + "', 'L', '" + ddlFTLTypeExpressForBranch5.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Road
        if (trForRoadForZone.Visible == true)
        {
            string[] strArrBM = HidZMRoad.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeRoadForZone1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strRoad + "', 'R', '" + ddlFTLTypeRoadForZone1.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeRoadForZone2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strRoad + "', 'R', '" + ddlFTLTypeRoadForZone2.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeRoadForZone3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strRoad + "', 'R', '" + ddlFTLTypeRoadForZone3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeRoadForZone4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strRoad + "', 'R', '" + ddlFTLTypeRoadForZone4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeRoadForZone5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strRoad + "', 'R', '" + ddlFTLTypeRoadForZone5.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage Zone Matrix For Express
        if (trForExpressForZone.Visible == true)
        {
            string[] strArrBM = HidZMExpress.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeExpressForZone1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strExpress + "', 'R', '" + ddlFTLTypeExpressForZone1.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeExpressForZone2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strExpress + "', 'R', '" + ddlFTLTypeExpressForZone2.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeExpressForZone3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strExpress + "', 'R', '" + ddlFTLTypeExpressForZone3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeExpressForZone4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strExpress + "', 'R', '" + ddlFTLTypeExpressForZone4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeExpressForZone5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strExpress + "', 'R', '" + ddlFTLTypeExpressForZone5.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Road
        if (trForRoadForCity.Visible == true)
        {
            string[] strArrBM = HidCMRoad.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeRoadForCity1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strRoad + "', 'C', '" + ddlFTLTypeRoadForCity1.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeRoadForCity2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strRoad + "', 'C', '" + ddlFTLTypeRoadForCity2.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeRoadForCity3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strRoad + "', 'C', '" + ddlFTLTypeRoadForCity3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeRoadForCity4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strRoad + "', 'C', '" + ddlFTLTypeRoadForCity4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeRoadForCity5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strRoad + "', 'C', '" + ddlFTLTypeRoadForCity5.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        //Manage City Matrix For Express
        if (trForExpressForCity.Visible == true)
        {
            string[] strArrBM = HidCMExpress.Value.Split('~');

            for (int intLoopCounter = 0; intLoopCounter < strArrBM.Length; intLoopCounter++)
            {
                string[] strInnerArrBM = strArrBM[intLoopCounter].Split(',');

                //For FTL Type 1
                if (ddlFTLTypeExpressForCity1.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                    "LOC_REG, ftltype) values ('" +
                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[2] + ", " +
                                    strInnerArrBM[3] + ", '', '" + strExpress + "', 'C', '" + ddlFTLTypeExpressForCity1.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 2
                if (ddlFTLTypeExpressForCity2.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[4] + ", " +
                                                    strInnerArrBM[5] + ", '', '" + strExpress + "', 'C', '" + ddlFTLTypeExpressForCity2.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 3
                if (ddlFTLTypeExpressForCity3.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[6] + ", " +
                                                    strInnerArrBM[7] + ", '', '" + strExpress + "', 'C', '" + ddlFTLTypeExpressForCity3.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 4
                if (ddlFTLTypeExpressForCity4.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[8] + ", " +
                                                    strInnerArrBM[9] + ", '', '" + strExpress + "', 'C', '" + ddlFTLTypeExpressForCity4.SelectedValue + "')";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }

                //For FTL Type 5
                if (ddlFTLTypeExpressForCity5.SelectedValue != "-1")
                {
                    strSQL = "Insert into WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR (ContractId, Custcode, destcode, " +
                                                    "From_Loccode, To_Loccode, FTL1_TRIP_RATE, FTL1_trdays, PayType, trans_type, " +
                                                    "LOC_REG, ftltype) values ('" +
                                                    HidContractID.Value + "', '" + HidCustCode.Value + "', '" + strInnerArrBM[0] + "', '" +
                                                    strInnerArrBM[0] + "', '" + strInnerArrBM[1] + "', " + strInnerArrBM[10] + ", " +
                                                    strInnerArrBM[11] + ", '', '" + strExpress + "', 'C', '" + ddlFTLTypeExpressForCity5.SelectedValue + "')";
                    sqlCommand = null;

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
    protected void txtFRToExpressForCity10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity10.Visible = false;
        txtFRToExpressForCity10.Text = txtFRToExpressForCity10.Text.Trim().ToUpper();
        if (txtFRToExpressForCity10.Text != "")
        {
            lblErrorFRToExpressForCity10.Visible = (!CheckValidCity(txtFRToExpressForCity10.Text));
            if (lblErrorFRToExpressForCity10.Visible == true)
            {
                txtFRToExpressForCity10.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity9.Visible = false;
        txtFRToExpressForCity9.Text = txtFRToExpressForCity9.Text.Trim().ToUpper();
        if (txtFRToExpressForCity9.Text != "")
        {
            lblErrorFRToExpressForCity9.Visible = (!CheckValidCity(txtFRToExpressForCity9.Text));
            if (lblErrorFRToExpressForCity9.Visible == true)
            {
                txtFRToExpressForCity9.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity8.Visible = false;
        txtFRToExpressForCity8.Text = txtFRToExpressForCity8.Text.Trim().ToUpper();
        if (txtFRToExpressForCity8.Text != "")
        {
            lblErrorFRToExpressForCity8.Visible = (!CheckValidCity(txtFRToExpressForCity8.Text));
            if (lblErrorFRToExpressForCity8.Visible == true)
            {
                txtFRToExpressForCity8.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity7.Visible = false;
        txtFRToExpressForCity7.Text = txtFRToExpressForCity7.Text.Trim().ToUpper();
        if (txtFRToExpressForCity7.Text != "")
        {
            lblErrorFRToExpressForCity7.Visible = (!CheckValidCity(txtFRToExpressForCity7.Text));
            if (lblErrorFRToExpressForCity7.Visible == true)
            {
                txtFRToExpressForCity7.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity6.Visible = false;
        txtFRToExpressForCity6.Text = txtFRToExpressForCity6.Text.Trim().ToUpper();
        if (txtFRToExpressForCity6.Text != "")
        {
            lblErrorFRToExpressForCity6.Visible = (!CheckValidCity(txtFRToExpressForCity6.Text));
            if (lblErrorFRToExpressForCity6.Visible == true)
            {
                txtFRToExpressForCity6.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity5.Visible = false;
        txtFRToExpressForCity5.Text = txtFRToExpressForCity5.Text.Trim().ToUpper();
        if (txtFRToExpressForCity5.Text != "")
        {
            lblErrorFRToExpressForCity5.Visible = (!CheckValidCity(txtFRToExpressForCity5.Text));
            if (lblErrorFRToExpressForCity5.Visible == true)
            {
                txtFRToExpressForCity5.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity4.Visible = false;
        txtFRToExpressForCity4.Text = txtFRToExpressForCity4.Text.Trim().ToUpper();
        if (txtFRToExpressForCity4.Text != "")
        {
            lblErrorFRToExpressForCity4.Visible = (!CheckValidCity(txtFRToExpressForCity4.Text));
            if (lblErrorFRToExpressForCity4.Visible == true)
            {
                txtFRToExpressForCity4.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity3.Visible = false;
        txtFRToExpressForCity3.Text = txtFRToExpressForCity3.Text.Trim().ToUpper();
        if (txtFRToExpressForCity3.Text != "")
        {
            lblErrorFRToExpressForCity3.Visible = (!CheckValidCity(txtFRToExpressForCity3.Text));
            if (lblErrorFRToExpressForCity3.Visible == true)
            {
                txtFRToExpressForCity3.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity2.Visible = false;
        txtFRToExpressForCity2.Text = txtFRToExpressForCity2.Text.Trim().ToUpper();
        if (txtFRToExpressForCity2.Text != "")
        {
            lblErrorFRToExpressForCity2.Visible = (!CheckValidCity(txtFRToExpressForCity2.Text));
            if (lblErrorFRToExpressForCity2.Visible == true)
            {
                txtFRToExpressForCity2.Focus();
            }
        }
    }
    protected void txtFRToExpressForCity1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToExpressForCity1.Visible = false;
        txtFRToExpressForCity1.Text = txtFRToExpressForCity1.Text.Trim().ToUpper();
        if (txtFRToExpressForCity1.Text != "")
        {
            lblErrorFRToExpressForCity1.Visible = (!CheckValidCity(txtFRToExpressForCity1.Text));
            if (lblErrorFRToExpressForCity1.Visible == true)
            {
                txtFRToExpressForCity1.Focus();
            }
        }
    }

    protected void txtFRFromExpressForCity10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity10.Visible = false;
        txtFRFromExpressForCity10.Text = txtFRFromExpressForCity10.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity10.Text != "")
        {
            lblErrorFRFromExpressForCity10.Visible = (!CheckValidCity(txtFRFromExpressForCity10.Text));
            if (lblErrorFRFromExpressForCity10.Visible == true)
            {
                txtFRFromExpressForCity10.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity9.Visible = false;
        txtFRFromExpressForCity9.Text = txtFRFromExpressForCity9.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity9.Text != "")
        {
            lblErrorFRFromExpressForCity9.Visible = (!CheckValidCity(txtFRFromExpressForCity9.Text));
            if (lblErrorFRFromExpressForCity9.Visible == true)
            {
                txtFRFromExpressForCity9.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity8.Visible = false;
        txtFRFromExpressForCity8.Text = txtFRFromExpressForCity8.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity8.Text != "")
        {
            lblErrorFRFromExpressForCity8.Visible = (!CheckValidCity(txtFRFromExpressForCity8.Text));
            if (lblErrorFRFromExpressForCity8.Visible == true)
            {
                txtFRFromExpressForCity8.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity7.Visible = false;
        txtFRFromExpressForCity7.Text = txtFRFromExpressForCity7.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity7.Text != "")
        {
            lblErrorFRFromExpressForCity7.Visible = (!CheckValidCity(txtFRFromExpressForCity7.Text));
            if (lblErrorFRFromExpressForCity7.Visible == true)
            {
                txtFRFromExpressForCity7.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity6.Visible = false;
        txtFRFromExpressForCity6.Text = txtFRFromExpressForCity6.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity6.Text != "")
        {
            lblErrorFRFromExpressForCity6.Visible = (!CheckValidCity(txtFRFromExpressForCity6.Text));
            if (lblErrorFRFromExpressForCity6.Visible == true)
            {
                txtFRFromExpressForCity6.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity5.Visible = false;
        txtFRFromExpressForCity5.Text = txtFRFromExpressForCity5.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity5.Text != "")
        {
            lblErrorFRFromExpressForCity5.Visible = (!CheckValidCity(txtFRFromExpressForCity5.Text));
            if (lblErrorFRFromExpressForCity5.Visible == true)
            {
                txtFRFromExpressForCity5.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity4.Visible = false;
        txtFRFromExpressForCity4.Text = txtFRFromExpressForCity4.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity4.Text != "")
        {
            lblErrorFRFromExpressForCity4.Visible = (!CheckValidCity(txtFRFromExpressForCity4.Text));
            if (lblErrorFRFromExpressForCity4.Visible == true)
            {
                txtFRFromExpressForCity4.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity3.Visible = false;
        txtFRFromExpressForCity3.Text = txtFRFromExpressForCity3.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity3.Text != "")
        {
            lblErrorFRFromExpressForCity3.Visible = (!CheckValidCity(txtFRFromExpressForCity3.Text));
            if (lblErrorFRFromExpressForCity3.Visible == true)
            {
                txtFRFromExpressForCity3.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity2.Visible = false;
        txtFRFromExpressForCity2.Text = txtFRFromExpressForCity2.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity2.Text != "")
        {
            lblErrorFRFromExpressForCity2.Visible = (!CheckValidCity(txtFRFromExpressForCity2.Text));
            if (lblErrorFRFromExpressForCity2.Visible == true)
            {
                txtFRFromExpressForCity2.Focus();
            }
        }
    }
    protected void txtFRFromExpressForCity1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromExpressForCity1.Visible = false;
        txtFRFromExpressForCity1.Text = txtFRFromExpressForCity1.Text.Trim().ToUpper();
        if (txtFRFromExpressForCity1.Text != "")
        {
            lblErrorFRFromExpressForCity1.Visible = (!CheckValidCity(txtFRFromExpressForCity1.Text));
            if (lblErrorFRFromExpressForCity1.Visible == true)
            {
                txtFRFromExpressForCity1.Focus();
            }
        }
    }

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
    protected void txtFRToRoadForCity10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity10.Visible = false;
        txtFRToRoadForCity10.Text = txtFRToRoadForCity10.Text.Trim().ToUpper();
        if (txtFRToRoadForCity10.Text != "")
        {
            lblErrorFRToRoadForCity10.Visible = (!CheckValidCity(txtFRToRoadForCity10.Text));
            if (lblErrorFRToRoadForCity10.Visible == true)
            {
                txtFRToRoadForCity10.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity9.Visible = false;
        txtFRToRoadForCity9.Text = txtFRToRoadForCity9.Text.Trim().ToUpper();
        if (txtFRToRoadForCity9.Text != "")
        {
            lblErrorFRToRoadForCity9.Visible = (!CheckValidCity(txtFRToRoadForCity9.Text));
            if (lblErrorFRToRoadForCity9.Visible == true)
            {
                txtFRToRoadForCity9.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity8.Visible = false;
        txtFRToRoadForCity8.Text = txtFRToRoadForCity8.Text.Trim().ToUpper();
        if (txtFRToRoadForCity8.Text != "")
        {
            lblErrorFRToRoadForCity8.Visible = (!CheckValidCity(txtFRToRoadForCity8.Text));
            if (lblErrorFRToRoadForCity8.Visible == true)
            {
                txtFRToRoadForCity8.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity7.Visible = false;
        txtFRToRoadForCity7.Text = txtFRToRoadForCity7.Text.Trim().ToUpper();
        if (txtFRToRoadForCity7.Text != "")
        {
            lblErrorFRToRoadForCity7.Visible = (!CheckValidCity(txtFRToRoadForCity7.Text));
            if (lblErrorFRToRoadForCity7.Visible == true)
            {
                txtFRToRoadForCity7.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity6.Visible = false;
        txtFRToRoadForCity6.Text = txtFRToRoadForCity6.Text.Trim().ToUpper();
        if (txtFRToRoadForCity6.Text != "")
        {
            lblErrorFRToRoadForCity6.Visible = (!CheckValidCity(txtFRToRoadForCity6.Text));
            if (lblErrorFRToRoadForCity6.Visible == true)
            {
                txtFRToRoadForCity6.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity5.Visible = false;
        txtFRToRoadForCity5.Text = txtFRToRoadForCity5.Text.Trim().ToUpper();
        if (txtFRToRoadForCity5.Text != "")
        {
            lblErrorFRToRoadForCity5.Visible = (!CheckValidCity(txtFRToRoadForCity5.Text));
            if (lblErrorFRToRoadForCity5.Visible == true)
            {
                txtFRToRoadForCity5.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity4.Visible = false;
        txtFRToRoadForCity4.Text = txtFRToRoadForCity4.Text.Trim().ToUpper();
        if (txtFRToRoadForCity4.Text != "")
        {
            lblErrorFRToRoadForCity4.Visible = (!CheckValidCity(txtFRToRoadForCity4.Text));
            if (lblErrorFRToRoadForCity4.Visible == true)
            {
                txtFRToRoadForCity4.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity3.Visible = false;
        txtFRToRoadForCity3.Text = txtFRToRoadForCity3.Text.Trim().ToUpper();
        if (txtFRToRoadForCity3.Text != "")
        {
            lblErrorFRToRoadForCity3.Visible = (!CheckValidCity(txtFRToRoadForCity3.Text));
            if (lblErrorFRToRoadForCity3.Visible == true)
            {
                txtFRToRoadForCity3.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity2.Visible = false;
        txtFRToRoadForCity2.Text = txtFRToRoadForCity2.Text.Trim().ToUpper();
        if (txtFRToRoadForCity2.Text != "")
        {
            lblErrorFRToRoadForCity2.Visible = (!CheckValidCity(txtFRToRoadForCity2.Text));
            if (lblErrorFRToRoadForCity2.Visible == true)
            {
                txtFRToRoadForCity2.Focus();
            }
        }
    }
    protected void txtFRToRoadForCity1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRToRoadForCity1.Visible = false;
        txtFRToRoadForCity1.Text = txtFRToRoadForCity1.Text.Trim().ToUpper();
        if (txtFRToRoadForCity1.Text != "")
        {
            lblErrorFRToRoadForCity1.Visible = (!CheckValidCity(txtFRToRoadForCity1.Text));
            if (lblErrorFRToRoadForCity1.Visible == true)
            {
                txtFRToRoadForCity1.Focus();
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
    protected void txtFRFromRoadForCity1_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity1.Visible = false;
        txtFRFromRoadForCity1.Text = txtFRFromRoadForCity1.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity1.Text != "")
        {
            lblErrorFRFromRoadForCity1.Visible = (!CheckValidCity(txtFRFromRoadForCity1.Text));
            if (lblErrorFRFromRoadForCity1.Visible == true)
            {
                txtFRFromRoadForCity1.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity2_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity2.Visible = false;
        txtFRFromRoadForCity2.Text = txtFRFromRoadForCity2.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity2.Text != "")
        {
            lblErrorFRFromRoadForCity2.Visible = (!CheckValidCity(txtFRFromRoadForCity2.Text));
            if (lblErrorFRFromRoadForCity2.Visible == true)
            {
                txtFRFromRoadForCity2.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity3_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity3.Visible = false;
        txtFRFromRoadForCity3.Text = txtFRFromRoadForCity3.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity3.Text != "")
        {
            lblErrorFRFromRoadForCity3.Visible = (!CheckValidCity(txtFRFromRoadForCity3.Text));
            if (lblErrorFRFromRoadForCity3.Visible == true)
            {
                txtFRFromRoadForCity3.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity4_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity4.Visible = false;
        txtFRFromRoadForCity4.Text = txtFRFromRoadForCity4.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity4.Text != "")
        {
            lblErrorFRFromRoadForCity4.Visible = (!CheckValidCity(txtFRFromRoadForCity4.Text));
            if (lblErrorFRFromRoadForCity4.Visible == true)
            {
                txtFRFromRoadForCity4.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity5_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity5.Visible = false;
        txtFRFromRoadForCity5.Text = txtFRFromRoadForCity5.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity5.Text != "")
        {
            lblErrorFRFromRoadForCity5.Visible = (!CheckValidCity(txtFRFromRoadForCity5.Text));
            if (lblErrorFRFromRoadForCity5.Visible == true)
            {
                txtFRFromRoadForCity5.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity6_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity6.Visible = false;
        txtFRFromRoadForCity6.Text = txtFRFromRoadForCity6.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity6.Text != "")
        {
            lblErrorFRFromRoadForCity6.Visible = (!CheckValidCity(txtFRFromRoadForCity6.Text));
            if (lblErrorFRFromRoadForCity6.Visible == true)
            {
                txtFRFromRoadForCity6.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity7_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity7.Visible = false;
        txtFRFromRoadForCity7.Text = txtFRFromRoadForCity7.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity7.Text != "")
        {
            lblErrorFRFromRoadForCity7.Visible = (!CheckValidCity(txtFRFromRoadForCity7.Text));
            if (lblErrorFRFromRoadForCity7.Visible == true)
            {
                txtFRFromRoadForCity7.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity8_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity8.Visible = false;
        txtFRFromRoadForCity8.Text = txtFRFromRoadForCity8.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity8.Text != "")
        {
            lblErrorFRFromRoadForCity8.Visible = (!CheckValidCity(txtFRFromRoadForCity8.Text));
            if (lblErrorFRFromRoadForCity8.Visible == true)
            {
                txtFRFromRoadForCity8.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity9_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity9.Visible = false;
        txtFRFromRoadForCity9.Text = txtFRFromRoadForCity9.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity9.Text != "")
        {
            lblErrorFRFromRoadForCity9.Visible = (!CheckValidCity(txtFRFromRoadForCity9.Text));
            if (lblErrorFRFromRoadForCity9.Visible == true)
            {
                txtFRFromRoadForCity9.Focus();
            }
        }
    }
    protected void txtFRFromRoadForCity10_TextChanged(object sender, EventArgs e)
    {
        lblErrorFRFromRoadForCity10.Visible = false;
        txtFRFromRoadForCity10.Text = txtFRFromRoadForCity10.Text.Trim().ToUpper();
        if (txtFRFromRoadForCity10.Text != "")
        {
            lblErrorFRFromRoadForCity10.Visible = (!CheckValidCity(txtFRFromRoadForCity10.Text));
            if (lblErrorFRFromRoadForCity10.Visible == true)
            {
                txtFRFromRoadForCity10.Focus();
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

        string strPreviousFrom = "";
        string strPreviousTo = "";
        string strCurrentFrom = "";
        string strCurrentTo = "";

        int intColumnCounter = 0;
        int intRowCounter = 0;

        //Branch Matrix for Road
        if (blnRoadYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strRoad.ToUpper() + "' AND LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                txtFRFromRoadForBranch1.Text = strCurrentFrom;
                                txtFRToRoadForBranch1.Text = strCurrentTo;

                                break;

                            case 1:
                                txtFRFromRoadForBranch2.Text = strCurrentFrom;
                                txtFRToRoadForBranch2.Text = strCurrentTo;

                                break;

                            case 2:
                                txtFRFromRoadForBranch3.Text = strCurrentFrom;
                                txtFRToRoadForBranch3.Text = strCurrentTo;

                                break;

                            case 3:
                                txtFRFromRoadForBranch4.Text = strCurrentFrom;
                                txtFRToRoadForBranch4.Text = strCurrentTo;
                                
                                break;

                            case 4:
                                txtFRFromRoadForBranch5.Text = strCurrentFrom;
                                txtFRToRoadForBranch5.Text = strCurrentTo;

                                break;

                            case 5:
                                txtFRFromRoadForBranch6.Text = strCurrentFrom;
                                txtFRToRoadForBranch6.Text = strCurrentTo;
    
                                break;

                            case 6:
                                txtFRFromRoadForBranch7.Text = strCurrentFrom;
                                txtFRToRoadForBranch7.Text = strCurrentTo;

                                break;

                            case 7:
                                txtFRFromRoadForBranch8.Text = strCurrentFrom;
                                txtFRToRoadForBranch8.Text = strCurrentTo;

                                break;

                            case 8:
                                txtFRFromRoadForBranch9.Text = strCurrentFrom;
                                txtFRToRoadForBranch9.Text = strCurrentTo;

                                break;

                            case 9:
                                txtFRFromRoadForBranch10.Text = strCurrentFrom;
                                txtFRToRoadForBranch10.Text = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeRoadForBranch1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType1RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeRoadForBranch2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType2RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeRoadForBranch3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType3RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeRoadForBranch4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType4RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeRoadForBranch5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType5RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }

        //Branch Matrix for Express
        if (blnExpressYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strExpress.ToUpper() + "' AND LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                txtFRFromExpressForBranch1.Text = strCurrentFrom;
                                txtFRToExpressForBranch1.Text = strCurrentTo;

                                break;

                            case 1:
                                txtFRFromExpressForBranch2.Text = strCurrentFrom;
                                txtFRToExpressForBranch2.Text = strCurrentTo;

                                break;

                            case 2:
                                txtFRFromExpressForBranch3.Text = strCurrentFrom;
                                txtFRToExpressForBranch3.Text = strCurrentTo;

                                break;

                            case 3:
                                txtFRFromExpressForBranch4.Text = strCurrentFrom;
                                txtFRToExpressForBranch4.Text = strCurrentTo;

                                break;

                            case 4:
                                txtFRFromExpressForBranch5.Text = strCurrentFrom;
                                txtFRToExpressForBranch5.Text = strCurrentTo;

                                break;

                            case 5:
                                txtFRFromExpressForBranch6.Text = strCurrentFrom;
                                txtFRToExpressForBranch6.Text = strCurrentTo;

                                break;

                            case 6:
                                txtFRFromExpressForBranch7.Text = strCurrentFrom;
                                txtFRToExpressForBranch7.Text = strCurrentTo;

                                break;

                            case 7:
                                txtFRFromExpressForBranch8.Text = strCurrentFrom;
                                txtFRToExpressForBranch8.Text = strCurrentTo;

                                break;

                            case 8:
                                txtFRFromExpressForBranch9.Text = strCurrentFrom;
                                txtFRToExpressForBranch9.Text = strCurrentTo;

                                break;

                            case 9:
                                txtFRFromExpressForBranch10.Text = strCurrentFrom;
                                txtFRToExpressForBranch10.Text = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeExpressForBranch1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType1RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeExpressForBranch2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType2RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeExpressForBranch3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType3RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeExpressForBranch4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType4RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeExpressForBranch5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType5RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForBranch10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }

        //Zone Matrix for Road
        if (blnRoadYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strRoad.ToUpper() + "' AND LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                ddlZoneRoadFromForRow1.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow1.SelectedValue = strCurrentTo;

                                break;

                            case 1:
                                ddlZoneRoadFromForRow2.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow2.SelectedValue = strCurrentTo;

                                break;

                            case 2:
                                ddlZoneRoadFromForRow3.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow3.SelectedValue = strCurrentTo;

                                break;

                            case 3:
                                ddlZoneRoadFromForRow4.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow4.SelectedValue = strCurrentTo;

                                break;

                            case 4:
                                ddlZoneRoadFromForRow5.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow5.SelectedValue = strCurrentTo;

                                break;

                            case 5:
                                ddlZoneRoadFromForRow6.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow6.SelectedValue = strCurrentTo;

                                break;

                            case 6:
                                ddlZoneRoadFromForRow7.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow7.SelectedValue = strCurrentTo;

                                break;

                            case 7:
                                ddlZoneRoadFromForRow8.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow8.SelectedValue = strCurrentTo;

                                break;

                            case 8:
                                ddlZoneRoadFromForRow9.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow9.SelectedValue = strCurrentTo;

                                break;

                            case 9:
                                ddlZoneRoadFromForRow10.SelectedValue = strCurrentFrom;
                                ddlZoneRoadToForRow10.SelectedValue = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeRoadForZone1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType1RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeRoadForZone2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType2RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeRoadForZone3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType3RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeRoadForZone4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType4RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeRoadForZone5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType5RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }

        //Zone Matrix for Express
        if (blnExpressYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strExpress.ToUpper() + "' AND LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                ddlZoneExpressFromForRow1.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow1.SelectedValue = strCurrentTo;

                                break;

                            case 1:
                                ddlZoneExpressFromForRow2.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow2.SelectedValue = strCurrentTo;

                                break;

                            case 2:
                                ddlZoneExpressFromForRow3.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow3.SelectedValue = strCurrentTo;

                                break;

                            case 3:
                                ddlZoneExpressFromForRow4.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow4.SelectedValue = strCurrentTo;

                                break;

                            case 4:
                                ddlZoneExpressFromForRow5.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow5.SelectedValue = strCurrentTo;

                                break;

                            case 5:
                                ddlZoneExpressFromForRow6.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow6.SelectedValue = strCurrentTo;

                                break;

                            case 6:
                                ddlZoneExpressFromForRow7.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow7.SelectedValue = strCurrentTo;

                                break;

                            case 7:
                                ddlZoneExpressFromForRow8.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow8.SelectedValue = strCurrentTo;

                                break;

                            case 8:
                                ddlZoneExpressFromForRow9.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow9.SelectedValue = strCurrentTo;

                                break;

                            case 9:
                                ddlZoneExpressFromForRow10.SelectedValue = strCurrentFrom;
                                ddlZoneExpressToForRow10.SelectedValue = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeExpressForZone1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType1RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeExpressForZone2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType2RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeExpressForZone3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType3RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeExpressForZone4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType4RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeExpressForZone5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType5RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForZone10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }

        //City Matrix for Road
        if (blnRoadYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strRoad.ToUpper() + "' AND LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                txtFRFromRoadForCity1.Text = strCurrentFrom;
                                txtFRToRoadForCity1.Text = strCurrentTo;

                                break;

                            case 1:
                                txtFRFromRoadForCity2.Text = strCurrentFrom;
                                txtFRToRoadForCity2.Text = strCurrentTo;

                                break;

                            case 2:
                                txtFRFromRoadForCity3.Text = strCurrentFrom;
                                txtFRToRoadForCity3.Text = strCurrentTo;

                                break;

                            case 3:
                                txtFRFromRoadForCity4.Text = strCurrentFrom;
                                txtFRToRoadForCity4.Text = strCurrentTo;

                                break;

                            case 4:
                                txtFRFromRoadForCity5.Text = strCurrentFrom;
                                txtFRToRoadForCity5.Text = strCurrentTo;

                                break;

                            case 5:
                                txtFRFromRoadForCity6.Text = strCurrentFrom;
                                txtFRToRoadForCity6.Text = strCurrentTo;

                                break;

                            case 6:
                                txtFRFromRoadForCity7.Text = strCurrentFrom;
                                txtFRToRoadForCity7.Text = strCurrentTo;

                                break;

                            case 7:
                                txtFRFromRoadForCity8.Text = strCurrentFrom;
                                txtFRToRoadForCity8.Text = strCurrentTo;

                                break;

                            case 8:
                                txtFRFromRoadForCity9.Text = strCurrentFrom;
                                txtFRToRoadForCity9.Text = strCurrentTo;

                                break;

                            case 9:
                                txtFRFromRoadForCity10.Text = strCurrentFrom;
                                txtFRToRoadForCity10.Text = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeRoadForCity1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType1RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeRoadForCity2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType2RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeRoadForCity3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType3RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeRoadForCity4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType4RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeRoadForCity5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRRoadFTLType5RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRRoadFTLType1RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType1RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRRoadFTLType2RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType2RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRRoadFTLType3RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType3RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRRoadFTLType4RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType4RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRRoadFTLType5RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysRoadFTLType5RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }

        //City Matrix for Express
        if (blnExpressYN == true)
        {
            string strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + HidContractID.Value + "' AND UPPER(Trans_Type) = '" + strExpress.ToUpper() + "' AND LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                txtFRFromExpressForCity1.Text = strCurrentFrom;
                                txtFRToExpressForCity1.Text = strCurrentTo;

                                break;

                            case 1:
                                txtFRFromExpressForCity2.Text = strCurrentFrom;
                                txtFRToExpressForCity2.Text = strCurrentTo;

                                break;

                            case 2:
                                txtFRFromExpressForCity3.Text = strCurrentFrom;
                                txtFRToExpressForCity3.Text = strCurrentTo;

                                break;

                            case 3:
                                txtFRFromExpressForCity4.Text = strCurrentFrom;
                                txtFRToExpressForCity4.Text = strCurrentTo;

                                break;

                            case 4:
                                txtFRFromExpressForCity5.Text = strCurrentFrom;
                                txtFRToExpressForCity5.Text = strCurrentTo;

                                break;

                            case 5:
                                txtFRFromExpressForCity6.Text = strCurrentFrom;
                                txtFRToExpressForCity6.Text = strCurrentTo;

                                break;

                            case 6:
                                txtFRFromExpressForCity7.Text = strCurrentFrom;
                                txtFRToExpressForCity7.Text = strCurrentTo;

                                break;

                            case 7:
                                txtFRFromExpressForCity8.Text = strCurrentFrom;
                                txtFRToExpressForCity8.Text = strCurrentTo;

                                break;

                            case 8:
                                txtFRFromExpressForCity9.Text = strCurrentFrom;
                                txtFRToExpressForCity9.Text = strCurrentTo;

                                break;

                            case 9:
                                txtFRFromExpressForCity10.Text = strCurrentFrom;
                                txtFRToExpressForCity10.Text = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    ddlFTLTypeExpressForCity1.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType1RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    ddlFTLTypeExpressForCity2.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType2RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    ddlFTLTypeExpressForCity3.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType3RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    ddlFTLTypeExpressForCity4.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType4RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    ddlFTLTypeExpressForCity5.SelectedValue = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                    txtFRExpressFTLType5RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity1.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 1:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity2.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 2:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity3.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 3:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity4.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 4:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity5.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 5:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity6.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 6:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity7.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 7:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity8.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 8:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity9.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;

                        case 9:
                            switch (intColumnCounter)
                            {
                                case 0:
                                    txtFRExpressFTLType1RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType1RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 1:
                                    txtFRExpressFTLType2RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType2RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 2:
                                    txtFRExpressFTLType3RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType3RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 3:
                                    txtFRExpressFTLType4RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType4RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;

                                case 4:
                                    txtFRExpressFTLType5RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                    txtTrDaysExpressFTLType5RowForCity10.Value = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                    break;
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }
        }
    }
}
