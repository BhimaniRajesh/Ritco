using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_VehicleMappingTollCard_Vehicle_Mapping_TollCard_Edit : System.Web.UI.Page
{
    public DataTable DtFuelWallet
    {
        get { return (DataTable)ViewState["DtFuelWallet"]; }
        set { ViewState["DtFuelWallet"] = value; }
    }

    public DataTable dt_BindGrid
    {
        get { return ViewState["VehicleBindGrid"] != null ? (DataTable)ViewState["VehicleBindGrid"] : new DataTable(); }
        set { ViewState["VehicleBindGrid"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnSubmit.Visible = false;
            var objVehicleTollController = new VehicleTollMappingController();
            DtFuelWallet = objVehicleTollController.GetTollWallet();
        }
        umsg.Hide();
    }

    private void Initialized()
    {
        dt_BindGrid = new DataTable();
        dt_BindGrid.Columns.Add("SrNo", typeof(string));
        dt_BindGrid.Columns.Add("VehicleNo", typeof(string));
        dt_BindGrid.Columns.Add("FuelWallet", typeof(string));
        dt_BindGrid.Columns.Add("Date", typeof(string));
        dt_BindGrid.Columns.Add("CardNo", typeof(string));
        dt_BindGrid.Columns.Add("IsActive", typeof(string));
        var objVehicleTollController = new VehicleTollMappingController();
        DataTable dtDetails = objVehicleTollController.GetVehicleTollDetails(txtVehicleNo.Text);

        foreach (DataRow drDt in dtDetails.Rows)
        {
            DataRow dr = dt_BindGrid.NewRow();
            dr["SrNo"] = Convert.ToString(drDt["SrNo"]);
            dr["VehicleNo"] = Convert.ToString(drDt["VehicleNo"]);
            dr["FuelWallet"] = Convert.ToString(drDt["FuelWallet"]);
            dr["Date"] = Convert.ToString(drDt["Date"]);
            dr["CardNo"] = Convert.ToString(drDt["CardNo"]);
            dr["IsActive"] = Convert.ToString(drDt["IsActive"]);
            dt_BindGrid.Rows.Add(dr);
            gvFuelCard.DataSource = dt_BindGrid;
            gvFuelCard.DataBind();
        }
    }

    protected void gvFuelCard_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).DataSource = DtFuelWallet;
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).DataValueField = "BankLeadgerCode";
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).DataTextField = "BankName";
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).DataBind();
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).Items.Insert(0, new ListItem("--Select--", ""));
            var IsActive = (HiddenField)e.Row.FindControl("hdnActive");
            var CheckBox = (CheckBox)e.Row.FindControl("chkActive");
            var hdnFuelWallet = (HiddenField)e.Row.FindControl("hdnFuelWallet");
            var ddlFuelWallet = (DropDownList)e.Row.FindControl("ddlFuelWallet");

            ddlFuelWallet.SelectedValue = hdnFuelWallet.Value;

            if (IsActive.Value == "True")
            {
                CheckBox.Checked = true;
            }
            else
            {
                CheckBox.Checked = false;
            }

        }
        btnSubmit.Visible = true;
        btnStep1.Visible = false;
    }

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        Initialized();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            int activeCnt = 0;
            int i = 1;
            var lstVehicleFuel = new List<VehicleToll>();
            foreach (GridViewRow grvDet in gvFuelCard.Rows)
            {
                var objVehicleToll = new VehicleToll();
                var SrNo = (HiddenField)grvDet.FindControl("hdnSrNo");
                var txtVehicleNo = (Label)grvDet.FindControl("lblVehicleNo");
                var FuelWallet = (DropDownList)grvDet.FindControl("ddlFuelWallet");
                var CardNo = (TextBox)grvDet.FindControl("txtCardNo");
                var IsActive = (CheckBox)grvDet.FindControl("chkActive");


                if (FuelWallet.SelectedIndex == 0)
                {
                    throw new Exception("Please Select Fuel/Toll Wallet at Row :-" + Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(CardNo.Text))
                {
                    throw new Exception("Please enter Card No at Row :-" + Convert.ToString(i));
                }

                var j = 1;
                foreach (GridViewRow grvDetj in gvFuelCard.Rows)
                {
                    var FuelWalletj = (DropDownList)grvDet.FindControl("ddlFuelWallet");
                    var CardNoj = (TextBox)grvDetj.FindControl("txtCardNo");
                    if (FuelWalletj.SelectedValue == FuelWallet.SelectedValue && CardNoj.Text == CardNo.Text && i != j)
                    {
                        throw new Exception("Row " + Convert.ToString(i) + " and Row " + Convert.ToString(j) + "are having duplicate Fuel Wallet and Card No");
                    }
                    j++;
                }
                objVehicleToll.VehicleNo = txtVehicleNo.Text;
                objVehicleToll.FuelWallet = FuelWallet.SelectedValue;
                objVehicleToll.CardNo = CardNo.Text;
                objVehicleToll.SrNo = SrNo.Value;
                objVehicleToll.ActiveFlag = IsActive.Checked == true ? true : false;
                lstVehicleFuel.Add(objVehicleToll);
                activeCnt = activeCnt + (IsActive.Checked == true ? 1 : 0);
                i++;
            }

            if (activeCnt > 1) {
                throw new Exception("Only One card should be active at a time !!");
            }

            var objVehicleTollController = new VehicleTollMappingController();
            objVehicleTollController.UpdateVehicleTollDetails(lstVehicleFuel);

            Response.Redirect("Vehicle_Mapping_TollCard_Done.aspx", false);
        }
        catch (Exception ex)
        {
            umsg.Show(ex.Message);
        }
    }

}