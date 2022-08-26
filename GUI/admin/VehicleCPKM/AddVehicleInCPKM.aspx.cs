using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.CommonControls;

public partial class GUI_admin_VehicleCPKM_AddVehicleInCPKM : System.Web.UI.Page
{
    public DataTable dt_VehicleCKPMBindGrid
    {
        get { return ViewState["VehicleCKPMBindGrid"] != null ? (DataTable)ViewState["VehicleCKPMBindGrid"] : new DataTable(); }
        set { ViewState["VehicleCKPMBindGrid"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Initialized();
        }
        umsg.Hide();
    }
    private void Initialized()
    {
        dt_VehicleCKPMBindGrid = new DataTable();
        dt_VehicleCKPMBindGrid.Columns.Add("VehicleNo", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("CPKMDate", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("KMs", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("VendorName", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("VendorCode", typeof(string));
        dt_VehicleCKPMBindGrid.Columns.Add("IsExist", typeof(string));
        var objVehicleCPKMController = new VehicleCPKMController();
        DataTable dtDetails = objVehicleCPKMController.GetVehicleCPKMDetails();

        foreach (DataRow drDt in dtDetails.Rows)
        {
             DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
             dr["VehicleNo"] = Convert.ToString(drDt["VehicleNo"]);
             dr["CPKMDate"] = Convert.ToString(drDt["CPKMDate"]);
             dr["KMs"] = Convert.ToString(drDt["KMs"]);
             dr["VendorName"] = Convert.ToString(drDt["VendorName"]);
             dr["VendorCode"] = Convert.ToString(drDt["VendorCode"]);
             dr["IsExist"] = Convert.ToString(drDt["IsExist"]);
            dt_VehicleCKPMBindGrid.Rows.Add(dr);
        }

        Addrows(1);
        
    }
    private void Addrows(int rows)
    {
            DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
            dr["VehicleNo"] = "";
            dr["CPKMDate"] = "";
            dr["KMs"] = "";
            dr["VendorName"] = "";
            dr["VendorCode"] = "";
            dr["IsExist"] = "";
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
            var txtVendor = (TextBox)e.Row.FindControl("txtVendor");
            var hdnVendor = (HiddenField)e.Row.FindControl("hdnVendor");
            var hdnExist = (HiddenField)e.Row.FindControl("hdnExist");
            if (e.Row.RowIndex == dt_VehicleCKPMBindGrid.Rows.Count - 1)
            {
                lbAdd.Visible = true;

            }
            if (hdnExist.Value == "1")
            {
                lbAdd.Visible = false;
                lbRemove.Visible = false;
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
            dt_VehicleCKPMBindGrid.Columns.Add("CPKMDate", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("KMs", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("VendorName", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("VendorCode", typeof(string));
            dt_VehicleCKPMBindGrid.Columns.Add("IsExist", typeof(string));
            try
            {
                foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
                {
                    DataRow dr = dt_VehicleCKPMBindGrid.NewRow();
                    var txtVehicleNo = (TextBox)grvDet.FindControl("txtVehicleNo");
                    var txtCPKMDate = (DatePicker)grvDet.FindControl("txtCPKMDate");
                    var txtKMs = (TextBox)grvDet.FindControl("txtKMs");
                    var txtVendor = (TextBox)grvDet.FindControl("txtVendor");
                    var hdnVendor = (HiddenField)grvDet.FindControl("hdnVendor");
                    var hdnExist = (HiddenField)grvDet.FindControl("hdnExist");

                    dr["VehicleNo"] = txtVehicleNo.Text;
                    dr["CPKMDate"] = txtCPKMDate.Text;
                    dr["KMs"] = txtKMs.Text;
                    dr["VendorName"] = txtVendor.Text;
                    dr["VendorCode"] = hdnVendor.Value;
                    dr["IsExist"] = hdnExist.Value;
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
		
    protected void gvVehicleCPKM_OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var lbRemove = (LinkButton)e.Row.FindControl("lbRemove");
            lbRemove.CommandArgument = e.Row.RowIndex.ToString();
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        umsg.Hide();
        
        try
        {
            int i = 1;
            var lstVehicleCKPM = new List<VehicleCKPM>();
            foreach (GridViewRow grvDet in gvVehicleCPKM.Rows)
            {
                var objVehicleCKPM = new VehicleCKPM();
                var txtVehicleNo = (TextBox) grvDet.FindControl("txtVehicleNo");
                var txtCPKMDate = (DatePicker) grvDet.FindControl("txtCPKMDate");
                var txtKMs = (TextBox) grvDet.FindControl("txtKMs");
                var txtVendor = (TextBox) grvDet.FindControl("txtVendor");
                var hdnVendor = (HiddenField) grvDet.FindControl("hdnVendor");
                if (string.IsNullOrEmpty(txtVehicleNo.Text))
                {
                    throw  new Exception("Please enter VehicleNo at Row :-"+Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(txtCPKMDate.Text))
                {
                    throw new Exception("Please enter CPKM Date at Row :-" + Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(txtKMs.Text))
                {
                    throw new Exception("Please enter KMs at Row :-" + Convert.ToString(i));
                }
                if (string.IsNullOrEmpty(txtVendor.Text))
                {
                    throw new Exception("Please enter Vendor at Row :-" + Convert.ToString(i));
                }
                var j = 1;
                foreach (GridViewRow grvDetj in gvVehicleCPKM.Rows)
                {
                    var txtVehicleNoj = (TextBox)grvDetj.FindControl("txtVehicleNo");
                    var hdnVendorj = (HiddenField)grvDetj.FindControl("hdnVendor");
                    if (txtVehicleNoj.Text == txtVehicleNo.Text && hdnVendorj.Value == hdnVendor.Value && i!=j)
                    {
                        throw new Exception("Row "+Convert.ToString(i)+" and Row "+Convert.ToString(j)+"are having duplicate Vehicle No and Vendor Code");
                    }
                    j++;
                }
                objVehicleCKPM.VehicleNo = txtVehicleNo.Text;
                objVehicleCKPM.CPKMDate = txtCPKMDate.SelectedDate.ToString("yyyy-MM-dd");
                objVehicleCKPM.VendorCode = hdnVendor.Value;
                objVehicleCKPM.KMs = txtKMs.Text;
                objVehicleCKPM.VendorName = txtVendor.Text;
                lstVehicleCKPM.Add(objVehicleCKPM);
                i++;
            }
            var objVehicleCPKMController = new VehicleCPKMController();
            objVehicleCPKMController.InsertVehicleCPKMDetails(lstVehicleCKPM);

             Response.Redirect("VehicleCPKMDone.aspx?Flag=A",false);
        }
        catch (Exception ex)
        {
           umsg.Show(ex.Message);
        }
    }
}
