using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.CommonControls;


public partial class GUI_admin_Vendor_contract_Ver1_CPKM_Contract : BasePage
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "";
    public DataTable dt_VehicleCKPMBindGrid
    {
        get { return ViewState["VehicleCKPMBindGrid"] != null ? (DataTable)ViewState["VehicleCKPMBindGrid"] : new DataTable(); }
        set { ViewState["VehicleCKPMBindGrid"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CreateToken();
            VendorID = Request.QueryString.Get("VendorID");
            VendorDesc = Request.QueryString.Get("VendorDesc");
            VendorTypeID = Request.QueryString.Get("VendorTypeID");
            VendorTypeDesc = Request.QueryString.Get("VendorTypeDesc");
            Add_Edit_Flag = Request.QueryString.Get("Add_Edit_Flag");
            ContractCode = Request.QueryString.Get("ContractCode");
            ContractType = Request.QueryString.Get("ContractType");

            Lbl_Vendor.Text = VendorID + ":" + VendorDesc;
            Lbl_VendorType.Text = VendorTypeDesc;
            hdnVendorName.Value = VendorDesc;

            Inetialized();
        }
    }

    private void Inetialized()
    {
        //USP_CPKM_VendorContract_Detail
        var oVendorCPKMContractController = new VendorCPKMContractController();
        dt_VehicleCKPMBindGrid = oVendorCPKMContractController.GetVenodrContractDetail(VendorID, ContractCode);
        //dt_VehicleCKPMBindGrid = new DataTable();
        //dt_VehicleCKPMBindGrid.Columns.Add("VendorName", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("Station", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("StationID", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("StartDate", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("EndDate", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("BaseRate", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("GSTPer", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("GStAmount", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("NetRate", typeof(string));
        //dt_VehicleCKPMBindGrid.Columns.Add("GstCredit", typeof(string));
        if (dt_VehicleCKPMBindGrid.Rows.Count > 0)
        {
            FillGrid();
        }
        else
        {
            Addrows(1);
        }
        //Addrows(1);


    }
    private void Addrows(int rows)
    {
        DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
        dr["ContractID"] = "";
        dr["VendorName"] = hdnVendorName.Value;
        dr["Station"] = "";
        dr["StationID"] = "";
        dr["StartDate"] = "";
        dr["EndDate"] = "";
        dr["BaseRate"] = 0;
        dr["GSTPer"] = 0;
        dr["GStAmount"] = 0;
        dr["NetRate"] = 0;
        dr["GstCredit"] = "N";

        dt_VehicleCKPMBindGrid.Rows.Add(dr);
        FillGrid();
    }
    private void FillGrid()
    {
        gvVehicleCPKM.DataSource = dt_VehicleCKPMBindGrid;
        gvVehicleCPKM.DataBind();
    }

    protected void gvVehicleCPKM_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Add_Edit_Flag == "E")
            {
                e.Row.Cells[9].Visible = false;

            }
            else
            {
                e.Row.Cells[9].Visible = true;
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            if (Add_Edit_Flag == "E")
            {
                e.Row.Cells[9].Visible = false;
            }
            else
            {
                e.Row.Cells[9].Visible = true;
            }

            var lbAdd = (LinkButton)e.Row.FindControl("lbAdd");
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");


            var txtVendorName = (TextBox)e.Row.FindControl("txtVendorName");
            var txtStation = (TextBox)e.Row.FindControl("txtStation");
            var txtToDate = (DatePicker)e.Row.FindControl("txtToDate");
            var txtFromDate = (DatePicker)e.Row.FindControl("txtFromDate");
            var txtBaseRate = (TextBox)e.Row.FindControl("txtBaseRate");
            var txtGSTper = (TextBox)e.Row.FindControl("txtGSTper");
            var txtGSTAmount = (TextBox)e.Row.FindControl("txtGSTAmount");
            var txtNetAmount = (TextBox)e.Row.FindControl("txtNetAmount");
            var rbGSTCredit = (RadioButtonList)e.Row.FindControl("rbGSTCredit");


            var hdnStation = (HiddenField)e.Row.FindControl("hdnStation");
            var hdnFromDate = (HiddenField)e.Row.FindControl("hdnFromDate");
            var hdnToDate = (HiddenField)e.Row.FindControl("hdnToDate");
            var hdnGSTCredit = (HiddenField)e.Row.FindControl("hdnGSTCredit");
            var hdnGSTAmount = (HiddenField)e.Row.FindControl("hdnGSTAmount");
            var hdnNetAmount = (HiddenField)e.Row.FindControl("hdnNetAmount");
            var hdnContractID = (HiddenField)e.Row.FindControl("hdnContractID");

            txtFromDate.Text = hdnFromDate.Value;
            txtToDate.Text = hdnToDate.Value;
            //rbGSTCredit.SelectedItem.Value = hdnGSTCredit.Value;
            if (hdnGSTCredit.Value == "Y")
            {
                rbGSTCredit.Items.FindByText("Yes").Selected = true;
            }
            else
            {
                rbGSTCredit.Items.FindByText("No").Selected = true;

            }
            if (e.Row.RowIndex == dt_VehicleCKPMBindGrid.Rows.Count - 1)
            {
                lbAdd.Visible = true;

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
            dt_VehicleCKPMBindGrid.Columns.Add("ContractID", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("VendorName", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("Station", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("StationID", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("StartDate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("EndDate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("BaseRate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("GSTPer", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("GStAmount", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("NetRate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("GstCredit", typeof(string));
            try
            {
                foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
                {
                    DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
                    var txtVendorName = (TextBox)grvDet.FindControl("txtVendorName");
                    var txtStation = (TextBox)grvDet.FindControl("txtStation");
                    var txtToDate = (DatePicker)grvDet.FindControl("txtToDate");
                    var txtFromDate = (DatePicker)grvDet.FindControl("txtFromDate");
                    var txtBaseRate = (TextBox)grvDet.FindControl("txtBaseRate");
                    var txtGSTper = (TextBox)grvDet.FindControl("txtGSTper");
                    var txtGSTAmount = (TextBox)grvDet.FindControl("txtGSTAmount");
                    var txtNetAmount = (TextBox)grvDet.FindControl("txtNetAmount");
                    var rbGSTCredit = (RadioButtonList)grvDet.FindControl("rbGSTCredit");

                    var hdnStation = (HiddenField)grvDet.FindControl("hdnStation");
                    var hdnFromDate = (HiddenField)grvDet.FindControl("hdnFromDate");
                    var hdnToDate = (HiddenField)grvDet.FindControl("hdnToDate");
                    var hdnGSTCredit = (HiddenField)grvDet.FindControl("hdnGSTCredit");
                    var hdnGSTAmount = (HiddenField)grvDet.FindControl("hdnGSTAmount");
                    var hdnNetAmount = (HiddenField)grvDet.FindControl("hdnNetAmount");
                    var hdnContractID = (HiddenField)grvDet.FindControl("hdnContractID");


                    hdnFromDate.Value = txtFromDate.Text;
                    hdnToDate.Value = txtToDate.Text;
                    hdnGSTCredit.Value = rbGSTCredit.SelectedItem.Value == "0" ? "Y" : "N";


                    dr["VendorName"] = txtVendorName.Text;
                    dr["Station"] = txtStation.Text;
                    dr["StationID"] = hdnStation.Value;
                    dr["StartDate"] = txtFromDate.Text;
                    dr["EndDate"] = txtToDate.Text;
                    dr["BaseRate"] = txtBaseRate.Text;
                    dr["GSTPer"] = txtGSTper.Text;
                    dr["GStAmount"] = hdnGSTAmount.Value;
                    dr["NetRate"] = hdnNetAmount.Value;
                    dr["GstCredit"] = hdnGSTCredit.Value;
                    dr["ContractID"] = hdnContractID.Value;

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

    protected void gvVehicleCPKM_OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            lbRemove.CommandArgument = e.Row.RowIndex.ToString();
        }
    }

    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {

                var ocls_VehicleCPKM = new List<cls_VehicleCPKM>();
                var oVendorCPKMContractController = new VendorCPKMContractController();
                foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
                {
                    var obj = new cls_VehicleCPKM();
                    var txtVendorName = (TextBox)grvDet.FindControl("txtVendorName");
                    var txtStation = (TextBox)grvDet.FindControl("txtStation");
                    var txtToDate = (DatePicker)grvDet.FindControl("txtToDate");
                    var txtFromDate = (DatePicker)grvDet.FindControl("txtFromDate");
                    var txtBaseRate = (TextBox)grvDet.FindControl("txtBaseRate");
                    var txtGSTper = (TextBox)grvDet.FindControl("txtGSTper");
                    var txtGSTAmount = (TextBox)grvDet.FindControl("txtGSTAmount");
                    var txtNetAmount = (TextBox)grvDet.FindControl("txtNetAmount");
                    var rbGSTCredit = (RadioButtonList)grvDet.FindControl("rbGSTCredit");

                    var hdnStation = (HiddenField)grvDet.FindControl("hdnStation");
                    var hdnFromDate = (HiddenField)grvDet.FindControl("hdnFromDate");
                    var hdnToDate = (HiddenField)grvDet.FindControl("hdnToDate");
                    var hdnGSTCredit = (HiddenField)grvDet.FindControl("hdnGSTCredit");
                    var hdnGSTAmount = (HiddenField)grvDet.FindControl("hdnGSTAmount");
                    var hdnNetAmount = (HiddenField)grvDet.FindControl("hdnNetAmount");
                    var hdnContractID = (HiddenField)grvDet.FindControl("hdnContractID");


                    hdnFromDate.Value = txtFromDate.Text;
                    hdnToDate.Value = txtToDate.Text;
                    hdnGSTCredit.Value = rbGSTCredit.SelectedItem.Value == "0" ? "Y" : "N";

                    obj.VendorCode = Request.QueryString.Get("VendorID");
                    obj.VendorName = Request.QueryString.Get("VendorDesc");
                    obj.Station = txtStation.Text;
                    obj.StationID = hdnStation.Value;
                    obj.StartDate = hdnFromDate.Value;
                    obj.EndDate = hdnToDate.Value;
                    obj.BaseRate = WebXConvert.ToDouble(txtBaseRate.Text);
                    obj.GSTPer = WebXConvert.ToDouble(txtGSTper.Text);
                    obj.GStAmount = WebXConvert.ToDouble(hdnGSTAmount.Value);
                    obj.NetRate = WebXConvert.ToDouble(hdnNetAmount.Value);
                    obj.GstCredit = hdnGSTCredit.Value;
                    obj.ContractID = hdnContractID.Value;

                    ocls_VehicleCPKM.Add(obj);
                }

                var dt = oVendorCPKMContractController.AddEditVendorContract(ocls_VehicleCPKM);
                if (dt.Rows.Count > 0)
                {
                    trADDEDIT.Visible = false;
                    trSunmit.Visible = false;
                    trDownload.Visible = true;
                    //gridDownload.DataSource = dt;
                    //gridDownload.DataBind();
                }


                ConsumeToken();
            }
        }
        catch (Exception)
        {

            throw;
        }
    }
}