using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;
using WebX.CommonControls;

public partial class GUI_admin_FuelCardProcess_FuelCardProcess : System.Web.UI.Page, IPostBackEventHandler
{

    public DataTable dt_VehicleCKPMBindGrid
    {
        get { return ViewState["VehicleCKPMBindGrid"] != null ? (DataTable)ViewState["VehicleCKPMBindGrid"] : new DataTable(); }
        set { ViewState["VehicleCKPMBindGrid"] = value; }
    }

    static string str_Connection_String = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString();

        UserMessage.Hide();
        if (!IsPostBack)
        {
            Initialized();
            //BindDropDownWithPerameter("Usp_VehicleWise_TripsheetList", "Name", "Value", "", ddlWallet);
            //BindDropDownWithPerameter("Usp_VehicleWise_TripsheetList", "Name", "Value", ddlWallet.SelectedItem.Value, ddlBank);

        }
    }

    [WebMethod(Description = "The Webmethod is a AJAX Server Callback function called on Vehicle No index changed")]
    public static List<ListItem> GetTripsheetList(string VehicleNo)
    {
        string query = "SELECT TripsheetNo=VSlipNo FROM dbo.WEBX_FLEET_VEHICLE_ISSUE WHERE VehicleNo='" + VehicleNo + "' and Oper_Close_Dt IS NULL AND ISNULL(Cancel_Status,'N')='N'";
        string constr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                List<ListItem> Tripsheet = new List<ListItem>();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        Tripsheet.Add(new ListItem
                        {
                            Value = sdr["TripsheetNo"].ToString(),
                            Text = sdr["TripsheetNo"].ToString()
                        });
                    }
                }
                con.Close();
                return Tripsheet;
            }
        }
    }

    private void Initialized()
    {
        dt_VehicleCKPMBindGrid = new DataTable();
        dt_VehicleCKPMBindGrid.Columns.Add("VehicleNo", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("TripsheetNo", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("TripsheetDate", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("FuelCardNo", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("FuelAccCode", typeof(string));

        dt_VehicleCKPMBindGrid.Columns.Add("FuelType", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("City", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("CityID", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("SwappingDate", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("TransactionID", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("Qty", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("Rate", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("Amount", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("Reamrks", typeof(string));
        //var objVehicleCPKMController = new VehicleCPKMController();
        //DataTable dtDetails = objVehicleCPKMController.GetVehicleCPKMDetails();

        //foreach (DataRow drDt in dtDetails.Rows)
        //{
        //    DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
        //    dr["VehicleNo"] = Convert.ToString(drDt["VehicleNo"]);
        //    dr["CPKMDate"] = Convert.ToString(drDt["CPKMDate"]);
        //    dr["KMs"] = Convert.ToString(drDt["KMs"]);
        //    dr["VendorName"] = Convert.ToString(drDt["VendorName"]);
        //    dr["VendorCode"] = Convert.ToString(drDt["VendorCode"]);
        //    dr["IsExist"] = Convert.ToString(drDt["IsExist"]);
        //    dt_VehicleCKPMBindGrid.Rows.Add(dr);
        //}

        Addrows(1);

    }
    private void Addrows(int rows)
    {


        DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
        dr["VehicleNo"] = "";
        dr["TripsheetNo"] = "";
        dr["TripsheetDate"] = "";
        dr["FuelCardNo"] = "";
        dr["FuelAccCode"] = "";

        dr["FuelType"] = "";
        dr["City"] = "";
        dr["CityID"] = "";
        dr["SwappingDate"] = "";
        dr["TransactionID"] = "";
        dr["Qty"] = "";
        dr["Rate"] = "";
        dr["Amount"] = "";
        dr["Reamrks"] = "";
        dt_VehicleCKPMBindGrid.Rows.Add(dr);
        FillGrid();
    }
    private void FillGrid()
    {
        gvVehicleCPKM.DataSource = dt_VehicleCKPMBindGrid;
        gvVehicleCPKM.DataBind();
        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "InitializedAutocomplete", "InitializedAutocomplete()", true);
    }

    protected void gvVehicleCPKM_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {

            var lbAdd = (LinkButton)e.Row.FindControl("lbAdd");
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            var ddlTripsheetNo = (DropDownList)e.Row.FindControl("ddlTripsheet");
            var hdnFuelType = (HiddenField)e.Row.FindControl("hdnFuelType");
            var ddlFuelType = (DropDownList)e.Row.FindControl("ddlFuelType");
            var txtVehicleNo = (TextBox)e.Row.FindControl("txtVehicleNo");
            var hdnTripsheetNo = (HiddenField)e.Row.FindControl("hdnTripsheetNo");
            var hdnFuelWallet = (HiddenField)e.Row.FindControl("hdnFuelWallet");
            var ddlFuelWallet = (DropDownList)e.Row.FindControl("ddlFuelWallet");
            var lblTripsheetDate = (Label)e.Row.FindControl("lblTripsheetDate");
            var hdnTripsheetDate = (HiddenField)e.Row.FindControl("hdnTripsheetDate");

            if (e.Row.RowIndex == dt_VehicleCKPMBindGrid.Rows.Count - 1)
            {
                lbAdd.Visible = true;

            }
            if (txtVehicleNo.Text != "")
            {
                BindDropDownWithPerameter("Usp_VehicleWise_TripsheetList", "TripsheetNo", "TripsheetNo", txtVehicleNo.Text, ddlTripsheetNo);
                BindDropDownWithPerameter("Usp_VehicleWise_FuelWalletList", "FuelWalletName", "FuelWallet", txtVehicleNo.Text, ddlFuelWallet);
            }

            if (hdnTripsheetNo.Value != "")
            {
                ddlTripsheetNo.SelectedValue = hdnTripsheetNo.Value;
            }

            if (hdnTripsheetDate.Value != "")
            {
                lblTripsheetDate.Text = hdnTripsheetDate.Value;
            }

            if (hdnFuelType.Value != "")
            {   
                ddlFuelType.SelectedValue = hdnFuelType.Value;
            }

            if (hdnFuelWallet.Value != "")
            {
                ddlFuelWallet.SelectedValue = hdnFuelWallet.Value;
            }

            if (dt_VehicleCKPMBindGrid.Rows.Count == 1)
            {
                lbRemove.Visible = false;
            }

        }
    }

    protected void gvVehicleCPKM_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            dt_VehicleCKPMBindGrid.Rows.RemoveAt(Convert.ToInt32(e.CommandArgument));
            FillGrid();
        }
        else
        {
            dt_VehicleCKPMBindGrid = new DataTable();
            dt_VehicleCKPMBindGrid.Columns.Add("VehicleNo", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("TripsheetNo", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("TripsheetDate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("FuelCardNo", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("FuelAccCode", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("FuelType", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("City", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("CityID", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("SwappingDate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("TransactionID", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("Qty", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("Rate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("Amount", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("Reamrks", typeof(string));
            try
            {
                foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
                {
                    DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
                    var txtVehicleNo = (TextBox)grvDet.FindControl("txtVehicleNo");
                    var hdnVehicleNo = (HiddenField)grvDet.FindControl("hdnVehicleNo");
                    var ddlTripsheet = (DropDownList)grvDet.FindControl("ddlTripsheet");
                    var hdnTripsheetNo = (HiddenField)grvDet.FindControl("hdnTripsheetNo");
                    var lblTripsheetDate = (Label)grvDet.FindControl("lblTripsheetDate");
                    var hdnTripsheetDate = (HiddenField)grvDet.FindControl("hdnTripsheetDate");
                    var lblFuelCardNo = (Label)grvDet.FindControl("lblFuelCardNo");
                    var hdnFuelCardNo = (HiddenField)grvDet.FindControl("hdnFuelCardNo");
                    var ddlFuelType = (DropDownList)grvDet.FindControl("ddlFuelType");
                    var hdnFuelType = (HiddenField)grvDet.FindControl("hdnFuelType");
                    var txtCity = (TextBox)grvDet.FindControl("txtCity");
                    var hdnCity = (HiddenField)grvDet.FindControl("hdnCity");
                    var txtTransactionID = (TextBox)grvDet.FindControl("txtTransactionID");
                    var txtQty = (TextBox)grvDet.FindControl("txtQty");
                    var txtRate = (TextBox)grvDet.FindControl("txtRate");
                    var txtAmount = (TextBox)grvDet.FindControl("txtAmount");
                    var txtReamrks = (TextBox)grvDet.FindControl("txtReamrks");
                    var txtCPKMDate = (DatePicker)grvDet.FindControl("txtCPKMDate");
                    var hdnExist = (HiddenField)grvDet.FindControl("hdnExist");
                    var hdnAmount = (HiddenField)grvDet.FindControl("hdnAmount");
                    var hdnFuelWallet = (HiddenField)grvDet.FindControl("hdnFuelWallet");
                    var ddlFuelWallet = (DropDownList)grvDet.FindControl("ddlFuelWallet");



                    dr["VehicleNo"] = txtVehicleNo.Text;
                    dr["TripsheetNo"] = hdnTripsheetNo.Value;
                    dr["TripsheetDate"] = hdnTripsheetDate.Value;
                    dr["FuelCardNo"] = hdnFuelCardNo.Value;
                    dr["FuelAccCode"] = ddlFuelWallet.SelectedValue;
                    dr["FuelType"] = ddlFuelType.SelectedItem.Value;
                    dr["City"] = txtCity.Text;
                    dr["CityID"] = hdnCity.Value;
                    dr["SwappingDate"] = txtCPKMDate.Text;
                    dr["TransactionID"] = txtTransactionID.Text;
                    dr["Qty"] = txtQty.Text;
                    dr["Rate"] = txtRate.Text;
                    dr["Amount"] = hdnAmount.Value;
                    dr["Reamrks"] = txtReamrks.Text;
                    dr["VehicleNo"] = txtVehicleNo.Text;

                    dt_VehicleCKPMBindGrid.Rows.Add(dr);
                }

                Addrows(1);

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

    [WebMethod]
    public static string CheckVehicle(string VehicleNo)
    {
        var obj = new VehicleCPKMController { mVehicleNo = VehicleNo };
        var dtResult = obj.CheckValidVehicleNo();
        return jsonUtility.DataTableToJSON(dtResult);
    }

    [WebMethod]
    public static string CheckCity(string City)
    {
        WebXHelper objWebXHelper = new WebXHelper();
        var dtCity = objWebXHelper.ExecuteDataTable("Usp_FuelProcess_ValidateCity",
                     new SqlParameter[] {
                            new SqlParameter("@City",City)
                     });
        return jsonUtility.DataTableToJSON(dtCity);
    }

    protected void gvVehicleCPKM_OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            lbRemove.CommandArgument = e.Row.RowIndex.ToString();
        }
    }

    public void BindDropDownWithPerameter(string strProc, string text, string value, string parameter, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Mode", SqlDbType.VarChar).Value = parameter;
        SqlDataReader dr = cmd.ExecuteReader();

        d.Items.Clear();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    protected void txtVehicleNo_OnTextChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in gvVehicleCPKM.Rows)
        {
            var ddlTripsheetNo = (DropDownList)gridrow.FindControl("ddlTripsheet");
            var ddlFuelWallet = (DropDownList)gridrow.FindControl("ddlFuelWallet");
            var hdnFuelWallet = (HiddenField)gridrow.FindControl("hdnFuelWallet");
            var hdnTripsheetNo = (HiddenField)gridrow.FindControl("hdnTripsheetNo");
            var txtVehicleNo = (TextBox)gridrow.FindControl("txtVehicleNo");
            var lblTripsheetDate = (Label)gridrow.FindControl("lblTripsheetDate");
            var hdnTripsheetDate = (HiddenField)gridrow.FindControl("hdnTripsheetDate");

            BindDropDownWithPerameter("Usp_VehicleWise_TripsheetList", "TripsheetNo", "TripsheetNo", txtVehicleNo.Text, ddlTripsheetNo);
            BindDropDownWithPerameter("Usp_VehicleWise_FuelWalletList", "FuelWalletName", "FuelWallet", txtVehicleNo.Text, ddlFuelWallet);

            if (hdnTripsheetNo.Value != "")
            {
                ddlTripsheetNo.SelectedValue = hdnTripsheetNo.Value;
            }

            if (hdnFuelWallet.Value != "")
            {
                ddlFuelWallet.SelectedValue = hdnFuelWallet.Value;
            }

            if (hdnTripsheetDate.Value != "")
            {
                lblTripsheetDate.Text = hdnTripsheetDate.Value;
            }
        }
    }

    public void RaisePostBackEvent(string Arg)
    {
        foreach (GridViewRow gridrow in gvVehicleCPKM.Rows)
        {
            var ddlTripsheetNo = (DropDownList)gridrow.FindControl("ddlTripsheet");
            var hdnTripsheetNo = (HiddenField)gridrow.FindControl("hdnTripsheetNo");
            var txtVehicleNo = (TextBox)gridrow.FindControl("txtVehicleNo");
            var ddlFuelWallet = (DropDownList)gridrow.FindControl("ddlFuelWallet");
            var hdnFuelWallet = (HiddenField)gridrow.FindControl("hdnFuelWallet");

            if (txtVehicleNo.ID == Arg)
                txtVehicleNo_OnTextChanged(txtVehicleNo, null);
            if (ddlFuelWallet.ID == Arg)
                ddlFuelWallet_SelectedIndexChanged(ddlFuelWallet, null);
        }
    }

    protected void ddlWallet_OnSelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        try
        {
            int i = 1;
            var lstVehicleCKPM = new List<FuelCardProcessData>();
            foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
            {
                var objVehicleCKPM = new FuelCardProcessData();
                var txtVehicleNo = (TextBox)grvDet.FindControl("txtVehicleNo");
                var hdnVehicleNo = (HiddenField)grvDet.FindControl("hdnVehicleNo");
                var ddlTripsheet = (DropDownList)grvDet.FindControl("ddlTripsheet");
                var hdnTripsheetNo = (HiddenField)grvDet.FindControl("hdnTripsheetNo");
                var lblTripsheetDate = (Label)grvDet.FindControl("lblTripsheetDate");
                var hdnTripsheetDate = (HiddenField)grvDet.FindControl("hdnTripsheetDate");
                var lblFuelCardNo = (Label)grvDet.FindControl("lblFuelCardNo");
                var hdnFuelCardNo = (HiddenField)grvDet.FindControl("hdnFuelCardNo");
                var ddlFuelType = (DropDownList)grvDet.FindControl("ddlFuelType");
                var hdnFuelType = (HiddenField)grvDet.FindControl("hdnFuelType");
                var txtCity = (TextBox)grvDet.FindControl("txtCity");
                var hdnCity = (HiddenField)grvDet.FindControl("hdnCity");
                var txtTransactionID = (TextBox)grvDet.FindControl("txtTransactionID");
                var txtQty = (TextBox)grvDet.FindControl("txtQty");
                var txtRate = (TextBox)grvDet.FindControl("txtRate");
                var txtAmount = (TextBox)grvDet.FindControl("txtAmount");
                var txtReamrks = (TextBox)grvDet.FindControl("txtReamrks");
                var txtCPKMDate = (DatePicker)grvDet.FindControl("txtCPKMDate");
                var hdnExist = (HiddenField)grvDet.FindControl("hdnExist");
                var hdnAmount = (HiddenField)grvDet.FindControl("hdnAmount");
                var hdnFuelWallet = (HiddenField)grvDet.FindControl("hdnFuelWallet");
                var ddlFuelWallet = (DropDownList)grvDet.FindControl("ddlFuelWallet");

                objVehicleCKPM.VehicleNo = txtVehicleNo.Text;
                objVehicleCKPM.TripsheetNo = hdnTripsheetNo.Value;
                objVehicleCKPM.TripSheetDateTime = hdnTripsheetDate.Value;
                objVehicleCKPM.FuelCardNo = hdnFuelCardNo.Value;
                objVehicleCKPM.FuelAccCode = ddlFuelWallet.SelectedValue;
                objVehicleCKPM.FuelType = ddlFuelType.SelectedItem.Value;
                objVehicleCKPM.City = hdnCity.Value;
                objVehicleCKPM.SwappingDate = txtCPKMDate.SelectedDate.ToString("yyyy-MM-dd");
                objVehicleCKPM.TransactionId = txtTransactionID.Text;
                objVehicleCKPM.QTY = Convert.ToDecimal(txtQty.Text);
                objVehicleCKPM.Rate = Convert.ToDecimal(txtRate.Text);
                objVehicleCKPM.Amount = Convert.ToDecimal(hdnAmount.Value);
                objVehicleCKPM.Remarks = txtReamrks.Text;

                lstVehicleCKPM.Add(objVehicleCKPM);
            }
            var objFuelCardProcessController = new FuelCardProcessController();
             var dt =objFuelCardProcessController.InsertFuelCardProcessDetailV1(lstVehicleCKPM);

            Response.Redirect("FuelCardProcessDone.aspx?Flag=A&VoucherNo=" + Convert.ToString(dt.Rows[0]["Vouchers"]), false);
        }
        catch (Exception ex)
        {
            UserMessage.Show(ex.Message);
        }
    }

    protected void ddlFuelWallet_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in gvVehicleCPKM.Rows)
        {
            var lblFuelCardNo = (Label)gridrow.FindControl("lblFuelCardNo");
            var hdnFuelCardNo = (HiddenField)gridrow.FindControl("hdnFuelCardNo");
            var txtVehicleNo = (TextBox)gridrow.FindControl("txtVehicleNo");
            var hdnVehicleNo = (HiddenField)gridrow.FindControl("hdnVehicleNo");
            var ddlFuelWallet = (DropDownList)gridrow.FindControl("ddlFuelWallet");
            var hdnFuelWallet = (HiddenField)gridrow.FindControl("hdnFuelWallet");
            var lblTripsheetDate = (Label)gridrow.FindControl("lblTripsheetDate");
            var hdnTripsheetDate = (HiddenField)gridrow.FindControl("hdnTripsheetDate");

            DataTable dtFuelCard = new DataTable();
            WebXHelper objWebXHelper = new WebXHelper();
            try
            {
                dtFuelCard = objWebXHelper.ExecuteDataTable("Usp_FuelProcess_GetFuelCardNo",
                    new SqlParameter[] {
                            new SqlParameter("@FuelWallet",ddlFuelWallet.SelectedValue),
                            new SqlParameter("@VehicleNo",hdnVehicleNo.Value)
                    });

            }
            catch (Exception ex)
            {
                throw ex;
            }
            if (dtFuelCard != null && dtFuelCard.Rows.Count > 0)
            {
                lblFuelCardNo.Text = dtFuelCard.Rows[0]["CardNo"].ToString();
                hdnFuelCardNo.Value = dtFuelCard.Rows[0]["CardNo"].ToString();
            }

            if (hdnTripsheetDate.Value != "")
            {
                lblTripsheetDate.Text = hdnTripsheetDate.Value;
            }
        }       
    }
}