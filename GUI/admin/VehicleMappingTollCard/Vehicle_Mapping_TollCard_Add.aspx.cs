using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_VehicleMappingTollCard_Vehicle_Mapping_TollCard_Add : System.Web.UI.Page
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

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtVehicleNo.Text == "")
            {
                throw new Exception("Please Enter Vehicle No");
            }
            Initialized();
        }
        catch (Exception ex)
        {
            umsg.Show(ex.Message);
        }
    }

    private void Initialized()
    {
        dt_BindGrid = new DataTable();
        dt_BindGrid.Columns.Add("VehicleNo", typeof(string));
        dt_BindGrid.Columns.Add("FuelWallet", typeof(string));
        dt_BindGrid.Columns.Add("Date", typeof(string));
        dt_BindGrid.Columns.Add("CardNo", typeof(string));
        dt_BindGrid.Columns.Add("ConfirmCardNo", typeof(string));

        Addrows(1);
    }

    private void Addrows(int rows)
    {
        DataRow dr = dt_BindGrid.NewRow();
        dr["VehicleNo"] = txtVehicleNo.Text;
        dr["FuelWallet"] = "";
        dr["Date"] = DateTime.Now.ToString("dd/M/yyyy");
        dr["CardNo"] = "";
        dr["ConfirmCardNo"] = "";
        dt_BindGrid.Rows.Add(dr);
        FillGrid();
    }

    [WebMethod]
    public static string CheckVehicleWithTollCardDetails(string VehNo, string FuelWallet)
    {
        string dtDetails = "";
        try
        {
            var objVehicleTollController = new VehicleTollMappingController();
            dtDetails = objVehicleTollController.CheckVehicleWithTollCard(VehNo, FuelWallet);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dtDetails;
    }

    private void FillGrid()
    {
        gvFuelCard.DataSource = dt_BindGrid;
        gvFuelCard.DataBind();
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
            var lbAdd = (LinkButton)e.Row.FindControl("lbAdd");
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            var FuelWallet = (HiddenField)e.Row.FindControl("hdnFuelWallet");
            ((DropDownList)e.Row.FindControl("ddlFuelWallet")).SelectedValue = FuelWallet.Value;

            //if (e.Row.RowIndex == dt_BindGrid.Rows.Count - 1)
            //{
            //    lbAdd.Visible = true;
            //}

            //if (dt_BindGrid.Rows.Count == 1)
            //{
            //    lbRemove.Visible = false;
            //}
            lbRemove.Visible = false;
            lbAdd.Visible = false;
        }
         btnStep1.Visible=false;
        btnSubmit.Visible = true;
    }

    protected void gvFuelCard_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            dt_BindGrid.Rows.RemoveAt(Convert.ToInt32(e.CommandArgument));
            FillGrid();
        }
        else
        {
            dt_BindGrid = new DataTable();
            dt_BindGrid.Columns.Add("VehicleNo", typeof(string));
            dt_BindGrid.Columns.Add("FuelWallet", typeof(string));
            dt_BindGrid.Columns.Add("Date", typeof(string));
            dt_BindGrid.Columns.Add("CardNo", typeof(string));
            dt_BindGrid.Columns.Add("ConfirmCardNo", typeof(string));
            try
            {
                foreach (GridViewRow grvDet in gvFuelCard.Rows)
                {
                    DataRow dr = dt_BindGrid.NewRow();
                    var txtVehicleNo = (Label)grvDet.FindControl("lblVehicleNo");
                    var FuelWallet = (DropDownList)grvDet.FindControl("ddlFuelWallet");
                    var lblDate = (Label)grvDet.FindControl("lblDate");
                    var CardNo = (TextBox)grvDet.FindControl("txtCardNo");
                    var ConfirmCardNo = (TextBox)grvDet.FindControl("txtConfirmCardNo");

                    dr["VehicleNo"] = txtVehicleNo.Text;
                    dr["FuelWallet"] = FuelWallet.SelectedValue;
                    dr["Date"] = lblDate.Text;
                    dr["CardNo"] = CardNo.Text;
                    dr["ConfirmCardNo"] = ConfirmCardNo.Text;

                    dt_BindGrid.Rows.Add(dr);
                }

                Addrows(1);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void gvFuelCard_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            lbRemove.CommandArgument = e.Row.RowIndex.ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            int i = 1;
            var lstVehicleToll = new List<VehicleToll>();
            foreach (GridViewRow grvDet in gvFuelCard.Rows)
            {
                var objVehicleFuel = new VehicleToll();
                var txtVehicleNo = (Label)grvDet.FindControl("lblVehicleNo");
                var FuelWallet = (DropDownList)grvDet.FindControl("ddlFuelWallet");
                var FuelDate = (Label)grvDet.FindControl("lblDate");
                var CardNo = (TextBox)grvDet.FindControl("txtCardNo");
                var ConfirmCardNo = (TextBox)grvDet.FindControl("txtConfirmCardNo");

                if (FuelWallet.SelectedIndex == 0)
                {
                    throw new Exception("Please Select Fuel Wallet at Row :-" + Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(CardNo.Text))
                {
                    throw new Exception("Please enter Card No at Row :-" + Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(ConfirmCardNo.Text))
                {
                    throw new Exception("Please enter Confirm Card No at Row :-" + Convert.ToString(i));
                }

                var j = 1;
                foreach (GridViewRow grvDetj in gvFuelCard.Rows)
                {
                    var FuelWalletj = (DropDownList)grvDet.FindControl("ddlFuelWallet");
                    var CardNoj = (TextBox)grvDetj.FindControl("txtCardNo");
                    var ConfirmCardNoj = (TextBox)grvDet.FindControl("txtConfirmCardNo");

                    if (FuelWalletj.SelectedValue == FuelWallet.SelectedValue && CardNoj.Text == CardNo.Text && ConfirmCardNo.Text == ConfirmCardNoj.Text && i != j)
                    {
                        throw new Exception("Row " + Convert.ToString(i) + " and Row " + Convert.ToString(j) + "are having duplicate Fuel Wallet and Card No");
                    }
                    j++;
                }
                objVehicleFuel.VehicleNo = txtVehicleNo.Text;
                objVehicleFuel.FuelWallet = FuelWallet.SelectedValue;
                objVehicleFuel.FuelDate = FuelDate.Text;
                objVehicleFuel.CardNo = CardNo.Text;
                objVehicleFuel.ConfirmCardNo = ConfirmCardNo.Text;
                lstVehicleToll.Add(objVehicleFuel);
                i++;
            }
            var objVehicleTollController = new VehicleTollMappingController();
            objVehicleTollController.InsertVehicleTollDetails(lstVehicleToll);

            Response.Redirect("Vehicle_Mapping_TollCard_Done.aspx", false);
        }
        catch (Exception ex)
        {
            umsg.Show(ex.Message);
        }
    }
}