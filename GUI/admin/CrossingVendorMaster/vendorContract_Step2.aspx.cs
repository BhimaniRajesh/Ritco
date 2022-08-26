using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_CrossingVendorMaster_vendorContract_Step2 : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "";
    string _strID = "";
    string Contract_ID = "";

    protected DataTable VendorLoc
    {
        get { return (DataTable)ViewState["venloc"]; }
        set { ViewState["venloc"] = value; }
    }

    private bool IsUpdate
    {
        get { return (ViewState["IsUpdate"] != null) ? Convert.ToBoolean(ViewState["IsUpdate"]) : false; }
        set { ViewState["IsUpdate"] = value; }
    }
    private VendorCorssingContract VCC
    {
        get { return (ViewState["VCC"] != null) ? ViewState["VCC"] as VendorCorssingContract : new VendorCorssingContract(); }
        set { ViewState["VCC"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        VendorDesc = Request.QueryString.Get("VendorDesc");
        VendorTypeID = Request.QueryString.Get("VendorTypeID");
        VendorTypeDesc = Request.QueryString.Get("VendorTypeDesc");
        Add_Edit_Flag = Request.QueryString.Get("Add_Edit_Flag");
        //ContractCode = Request.QueryString.Get("ContractCode");
        //ContractType = Request.QueryString.Get("ContractType");

        if (!IsPostBack && !IsCallback)
        {
            hdnVendorCode.Value = Request.QueryString["VendorID"].ToString();
            //hdnVendorCode.Value = vcfone.VendorCode;

            if (Add_Edit_Flag == "A")
            {
                Lbl_ADD_Edit.Text = "ADD New Contract For Vendor";
            }
            else if (Add_Edit_Flag == "E")
            {
                Lbl_ADD_Edit.Text = "Edit Contract For Vendor";
            }

            string strCMD = "SELECT LocCode, (LocCode+':'+LocName) as LocName from Webx_Location where (SELECT dbo.SplitWithSearch((SELECT TOP 1 VENDORBRCD From webx_Vendor_DET where VendorCode='{0}'),',',LocCode))='1'";
            strCMD = string.Format(strCMD, hdnVendorCode.Value.Trim());
            DataTable dt = new DataTable();
            try
            {
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strCMD).Tables[0];
            }
            catch (Exception ex)
            {

            }

            VendorLoc = dt;
            GetContractData();
            BindContractData();
            //     BindGrid();
        }
    }
    private void BindContractData()
    {
        try
        {
            if (hdnVendorCode.Value != "")
            {
                grvcity.DataSource = VCC.Details;
                grvcity.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    private void GetContractData()
    {
        VCC = VendorCrossingContractController.GetByVendorCode(hdnVendorCode.Value);
        if (VCC.ContractID == "")
        {
            IsUpdate = false;
            VCC = new VendorCorssingContract();
            List<VendorCorssingContractDet> det = new List<VendorCorssingContractDet>();
            det.Add(new VendorCorssingContractDet());
            VCC.Details = det;
        }
        else
        {
            IsUpdate = true;
            //vcfone.ContractID = VCC.ContractID;
            if (VCC.Details.Count <= 0)
            {
                List<VendorCorssingContractDet> det = new List<VendorCorssingContractDet>();
                det.Add(new VendorCorssingContractDet());
                VCC.Details = det;
            }
        }
    }

    protected void btnrows_Click(object sender, EventArgs e)
    {
        int cnt = WebXConvert.ToInt16(txtnorows.Text);
        ReverceBind();
        for (int i = 0; i < cnt; i++)
        {
            VCC.Details.Add(new VendorCorssingContractDet());
        }
        BindContractData();
    }

    private void ReverceBind()
    {
        List<VendorCorssingContractDet> newList = new List<VendorCorssingContractDet>();
        foreach (GridViewRow gr in grvcity.Rows)
        {
            CheckBox chkyes = (CheckBox)gr.FindControl("chkyes");
            HiddenField hidID = (HiddenField)gr.FindControl("hidID");
            DropDownList ddlOrigin = (DropDownList)gr.FindControl("ddlOrigin");
            TextBox txtDestcity = (TextBox)gr.FindControl("txtDestcity");
            TextBox txtrate = (TextBox)gr.FindControl("txtrate");
            TextBox txtDoorDelyCharge = (TextBox)gr.FindControl("txtDoorDelyCharge");
            DropDownList cmbratetype = (DropDownList)gr.FindControl("cmbratetype");

            VendorCorssingContractDet dtNew;

            double id = Convert.ToDouble(hidID.Value);
            if (id > 0)
            {
                dtNew = VCC.Details.Find(delegate(VendorCorssingContractDet v) { return v.ID == id; });
                dtNew.UpdatedBy = SessionUtilities.CurrentEmployeeID;
                dtNew.UpdatedDate = DateTime.Now;
            }
            else
            {
                dtNew = new VendorCorssingContractDet();
                dtNew.ContractID = VCC.ContractID;
                dtNew.EntryBy = SessionUtilities.CurrentEmployeeID;
                dtNew.EntryDate = DateTime.Now;
            }
            if (chkyes.Checked)
            {
                dtNew.VendorCode = hdnVendorCode.Value;
                dtNew.Origin = ddlOrigin.SelectedValue;
                dtNew.DestCity = txtDestcity.Text;
                dtNew.Rate = Convert.ToDouble(txtrate.Text);
                dtNew.DoorDeliveryCharge = Convert.ToDouble(txtDoorDelyCharge.Text);
                dtNew.RateType = cmbratetype.SelectedValue;
            }
            newList.Add(dtNew);

        }
        VCC.Details = newList;
    }

    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chkyes = (CheckBox)e.Row.FindControl("chkyes");
            HiddenField hidID = (HiddenField)e.Row.FindControl("hidID");
            Button btnorigin = (Button)e.Row.FindControl("btnorigin");
            TextBox txtlocation = (TextBox)e.Row.FindControl("txtlocation");
            Button btnDestination = (Button)e.Row.FindControl("btnDestination");
            TextBox txtDestcity = (TextBox)e.Row.FindControl("txtDestcity");
            DropDownList ddlOrigin = (DropDownList)e.Row.FindControl("ddlOrigin");
            TextBox txtrate = (TextBox)e.Row.FindControl("txtrate");
            TextBox txtDoorDelyCharge = (TextBox)e.Row.FindControl("txtDoorDelyCharge");
            DropDownList cmbratetype = (DropDownList)e.Row.FindControl("cmbratetype");

            //chkyes.Checked = true;
            VendorCorssingContractDet vcd = e.Row.DataItem as VendorCorssingContractDet;
            hidID.Value = vcd.ID.ToString("0");
            ddlOrigin.DataTextField = "LocName";
            ddlOrigin.DataValueField = "LocCode";
            ddlOrigin.DataSource = VendorLoc;
            ddlOrigin.DataBind();
            ddlOrigin.Items.Insert(0, new ListItem("Select", ""));
            try
            {
                txtlocation.Enabled = true;
                ddlOrigin.SelectedValue = Convert.ToString(vcd.Origin);
                txtDestcity.Text = Convert.ToString(vcd.DestCity);
                txtrate.Text = vcd.Rate.ToString("0.00");
                cmbratetype.SelectedValue = Convert.ToString(vcd.RateType);
                txtDoorDelyCharge.Text = vcd.DoorDeliveryCharge.ToString("0.00");
                txtlocation.Enabled = false;
            }
            catch (Exception ex) { }

            btnorigin.Attributes.Add("onclick", "javascript:return popuplist('location','" + txtlocation.ClientID.ToString() + "','none')");
            btnDestination.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtDestcity.ClientID.ToString() + "','none')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
            SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            SqlTransaction trn;
            trn = conn.BeginTransaction();
            string ratetype = "", sqlstr = "";
            string VendorContractID = "";

            try
            {
                ReverceBind();
                if (VCC.ContractID == "")
                {
                    VCC.ContractID = VendorCrossingContractController.GenerateNewCode(trn);
                    VendorContractID = VCC.ContractID;
                    Contract_ID = VCC.ContractID;
                    VCC.VendorCode = hdnVendorCode.Value.Trim();
                    VCC.EntryBy = SessionUtilities.CurrentEmployeeID;
                    VCC.EntryDate = DateTime.Now;
                }
                else
                {
                    VCC.UpdatedBy = SessionUtilities.CurrentEmployeeID;
                    Contract_ID = VCC.ContractID;
                    VCC.UpdatedDate = DateTime.Now;
                }
                VCC.ActiveFlag = "Y";
                List<VendorCorssingContractDet> newList = new List<VendorCorssingContractDet>();
                foreach (VendorCorssingContractDet dt in VCC.Details)
                {                    
                    dt.ContractID = VCC.ContractID;
                    Contract_ID = VCC.ContractID;
                    dt.VendorCode = hdnVendorCode.Value.Trim();                    
                }
                if(IsUpdate)
                    VendorCrossingContractController.Update(VCC, trn);
                else
                    VendorCrossingContractController.Insert(VCC, trn);
                trn.Commit();
            }
            catch (Exception e1)
            {
                if(conn.State == ConnectionState.Open)
                    trn.Rollback();
                
                throw e1;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            conn.Close();
            string final = "";
            final = "ContractNo=" + Contract_ID;
            Response.Redirect("DoneCrossingVendorContract.aspx?" + final);
    }

}
