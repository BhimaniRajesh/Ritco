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
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_Vendor_contract_Ver1_Distance_Based_Contract : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "", Step = "";

    private string Veh_List
    {
        get { return (ViewState["Veh_List"] != null) ? ViewState["Veh_List"].ToString() : ""; }
        set { ViewState["Veh_List"] = value; }
    }
    private string VehType_List
    {
        get { return (ViewState["VehType_List"] != null) ? ViewState["VehType_List"].ToString() : ""; }
        set { ViewState["VehType_List"] = value; }
    }
    private string FTL_Type_list
    {
        get { return (ViewState["FTL_Type_list"] != null) ? ViewState["FTL_Type_list"].ToString() : ""; }
        set { ViewState["FTL_Type_list"] = value; }
    }

    private DataTable dtVehicle
    {
        get { return (ViewState["dtVehicle"] != null) ? ViewState["dtVehicle"] as DataTable : new DataTable(); }
        set { ViewState["dtVehicle"] = value; }
    }
    private DataTable dtVehType
    {
        get { return (ViewState["dtVehType"] != null) ? ViewState["dtVehType"] as DataTable : new DataTable(); }
        set { ViewState["dtVehType"] = value; }
    }
    private DataTable dtFTL_Type
    {
        get { return (ViewState["dtFTL_Type"] != null) ? ViewState["dtFTL_Type"] as DataTable : new DataTable(); }
        set { ViewState["dtFTL_Type"] = value; }
    }

    private List<VendorContract_DistanceBased> ListVSD
    {
        get { return (ViewState["ListVSD"] != null) ? ViewState["ListVSD"] as List<VendorContract_DistanceBased> : new List<VendorContract_DistanceBased>(); }
        set { ViewState["ListVSD"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        VendorID = Request.QueryString.Get("VendorID");
        VendorDesc = Request.QueryString.Get("VendorDesc");
        VendorTypeID = Request.QueryString.Get("VendorTypeID");
        VendorTypeDesc = Request.QueryString.Get("VendorTypeDesc");
        Add_Edit_Flag = Request.QueryString.Get("Add_Edit_Flag");
        ContractCode = Request.QueryString.Get("ContractCode");
        ContractType = Request.QueryString.Get("ContractType");
        Step = Request.QueryString.Get("NextStep");
        if (!IsPostBack && !IsCallback)
        {
            if (Add_Edit_Flag == "A")
            {
                Lbl_ADD_Edit.Text = "ADD New Contract For Vendor";
            }
            else if (Add_Edit_Flag == "E")
            {
                Lbl_ADD_Edit.Text = "Edit Contract For Vendor";
            }

            SetTitle();
            SetContractForTitle();

            //VehType_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("VEHTYP");
            //Veh_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("VEH");
            //FTL_Type_list = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("FTLTYP");
            dtVehType = Vendor_Contract.GetVehicleType();
            dtVehicle = Vendor_Contract.GetVehicleNumbers();
            dtFTL_Type = Vendor_Contract.GetFTLType();

            Lbl_Vendor.Text = VendorID + ":" + VendorDesc;
            Lbl_VendorType.Text = VendorTypeDesc;
            BindGrid();
        }
    }

    private void SetContractForTitle()
    {
        switch (ContractType)
        {
            case "01":
            case "04":
                Lbl_Contract_For.Text = "Contract Matrix For :- Vendor";
                break;
            case "02":
            case "05":
                Lbl_Contract_For.Text = "Contract Matrix For :- Type of Movement";
                break;
            case "03":
            case "06":
                Lbl_Contract_For.Text = "Contract Matrix For :- Vehicle Number";
                break;
        }
    }
    private void SetTitle()
    {
        switch (ContractType)
        {
            case "01":
            case "04":
                //Lbl_Contract_title.Text = "Vendor Contract Step " + Step + " : Distance Based Contract";
                Lbl_Contract_title.Text = "Vendor Contract Step 2 : Distance Based Contract";
                break;
            case "02":
            case "05":
                //Lbl_Contract_title.Text = "Vendor Contract Step " + Step + " : Distance Based Contract";
                Lbl_Contract_title.Text = "Vendor Contract Step 2 : Distance Based Contract";
                break;
            case "03":
            case "06":
                //Lbl_Contract_title.Text = "Vendor Contract Step " + Step + " : Distance Based Contract";
                Lbl_Contract_title.Text = "Vendor Contract Step 2 : Distance Based Contract";
                break;
        }
    }

    protected void AddGridRow(object sender, EventArgs e)
    {
        ReverceBind(false);
        int addRows = 0;
        if (Txt_TotRows.Text.Trim() != "")
            addRows = Convert.ToInt32(Txt_TotRows.Text.Trim());
        for (int i = 0; i < addRows; i++)
        {
            ListVSD.Add(new VendorContract_DistanceBased());
        }
        GV_Distance_Matrix.DataSource = ListVSD;
        GV_Distance_Matrix.DataBind();
    }
    protected void GV_Distance_Matrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            VendorContract_DistanceBased objVSD = e.Row.DataItem as VendorContract_DistanceBased;

            DropDownList Ddl_VehNo = (DropDownList)e.Row.FindControl("Ddl_VehNo");
            DropDownList Ddl_Veh_Type = (DropDownList)e.Row.FindControl("Ddl_Veh_Type");
            DropDownList Ddl_FTL_Type = (DropDownList)e.Row.FindControl("Ddl_FTL_Type");

            CheckBox ChkInd = (CheckBox)e.Row.FindControl("ChkInd");
            HiddenField hidID = (HiddenField)e.Row.FindControl("hidID");

            TextBox Txt_MinChg = (TextBox)e.Row.FindControl("Txt_MinChg");
            TextBox Txt_Km = (TextBox)e.Row.FindControl("Txt_Km");
            TextBox Txt_Ext_Km = (TextBox)e.Row.FindControl("Txt_Ext_Km");
            TextBox Txt_MaxPayment = (TextBox)e.Row.FindControl("Txt_MaxPayment");
            TextBox Txt_Trip = (TextBox)e.Row.FindControl("Txt_Trip");

            if (ContractType == "01" || ContractType == "02" || ContractType == "04" || ContractType == "05")
            {
                FillAll_DropDown(Ddl_VehNo);
                FillAll_DropDown(Ddl_Veh_Type);
                if (ContractType == "01" || ContractType == "04")
                {
                    FillAll_DropDown(Ddl_FTL_Type);
                }
                else
                {
                    //Ddl_FTL_Type.
                    Ddl_FTL_Type.DataSource = dtFTL_Type;
                    Ddl_FTL_Type.DataTextField = "Codedesc";
                    Ddl_FTL_Type.DataValueField = "CodeID";
                    Ddl_FTL_Type.DataBind();
                    Ddl_FTL_Type.Items.Add(new ListItem("Select", ""));
                    Ddl_FTL_Type.SelectedValue = objVSD.FTL_Type;
                }
            }
            else
            {
                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(Veh_List, Ddl_VehNo);
                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(VehType_List, Ddl_Veh_Type);
                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(FTL_Type_list, Ddl_FTL_Type);
                Ddl_Veh_Type.DataSource = dtVehType;
                Ddl_Veh_Type.DataTextField = "TYPE_NAME";
                Ddl_Veh_Type.DataValueField = "TYPE_CODE";
                Ddl_Veh_Type.DataBind();
                Ddl_Veh_Type.Items.Insert(0,new ListItem("Select", ""));
                Ddl_Veh_Type.SelectedValue = objVSD.Vehicle_Type;
                if (objVSD.Vehicle_Type == "")
                {
                    Ddl_VehNo.Items.Clear();
                    Ddl_VehNo.Items.Add(new ListItem("Select", ""));
                }
                else
                {
                    DataView dv = dtVehicle.DefaultView;
                    dv.Sort = "VEHDESC";
                    dv.RowFilter = "Vehicle_Type='" + objVSD.Vehicle_Type + "'";
                    Ddl_VehNo.DataSource = dv.Table;
                    Ddl_VehNo.DataTextField = "VEHDESC";
                    Ddl_VehNo.DataValueField = "VEHNO";
                    Ddl_VehNo.DataBind();
                    Ddl_VehNo.Items.Insert(0, new ListItem("Select", ""));  
                    Ddl_VehNo.SelectedValue = objVSD.Vehicle_Number;
                }
                Ddl_FTL_Type.DataSource = dtFTL_Type;
                Ddl_FTL_Type.DataTextField = "Codedesc";
                Ddl_FTL_Type.DataValueField = "CodeID";
                Ddl_FTL_Type.DataBind();
                Ddl_FTL_Type.Items.Insert(0,new ListItem("Select", ""));
                Ddl_FTL_Type.SelectedValue = objVSD.FTL_Type;
            }

            hidID.Value = objVSD.ID.ToString();           
            
            if (objVSD.Min_Amt_Committed > 0)
                Txt_MinChg.Text = objVSD.Min_Amt_Committed.ToString("0.00");
            if (objVSD.Max_Amt_Committed > 0)
                Txt_MaxPayment.Text = objVSD.Max_Amt_Committed.ToString("0.00");
            if (objVSD.Chg_Per_Add_Km > 0)
                Txt_Ext_Km.Text = objVSD.Chg_Per_Add_Km.ToString("0.00");
            if (objVSD.Committed_Km > 0)
                Txt_Km.Text = objVSD.Committed_Km.ToString("0");
            if (objVSD.Trips_PM > 0)
                Txt_Trip.Text = objVSD.Trips_PM.ToString();
        }
    }
    private void BindGrid()
    {
        ListVSD = VendorContract_DistanceBasedController.GetByContractID(ContractCode);
        if (ListVSD.Count <= 0)
        {
            ListVSD.Add(new VendorContract_DistanceBased());
        }
        GV_Distance_Matrix.DataSource = ListVSD;
        GV_Distance_Matrix.DataBind();
    }
    private void ReverceBind(bool isFinal)
    {
        List<VendorContract_DistanceBased> _newList = new List<VendorContract_DistanceBased>();
        foreach (GridViewRow gvr in GV_Distance_Matrix.Rows)
        {
            DropDownList Ddl_VehNo = (DropDownList)gvr.FindControl("Ddl_VehNo");
            DropDownList Ddl_Veh_Type = (DropDownList)gvr.FindControl("Ddl_Veh_Type");
            DropDownList Ddl_FTL_Type = (DropDownList)gvr.FindControl("Ddl_FTL_Type");

            CheckBox ChkInd = (CheckBox)gvr.FindControl("ChkInd");
            HiddenField hidID = (HiddenField)gvr.FindControl("hidID");

            TextBox Txt_MinChg = (TextBox)gvr.FindControl("Txt_MinChg");
            TextBox Txt_Km = (TextBox)gvr.FindControl("Txt_Km");
            TextBox Txt_Ext_Km = (TextBox)gvr.FindControl("Txt_Ext_Km");
            TextBox Txt_MaxPayment = (TextBox)gvr.FindControl("Txt_MaxPayment");
            TextBox Txt_Trip = (TextBox)gvr.FindControl("Txt_Trip");

            if (isFinal)
            {
                if (ChkInd.Checked)
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    VendorContract_DistanceBased objVCD;
                    if (_ID > 0)
                    {
                        objVCD = ListVSD.Find(delegate(VendorContract_DistanceBased v) { return v.ID == _ID; });
                        objVCD.UpdateBy = SessionUtilities.CurrentEmployeeID;
                        objVCD.UpdateDt = DateTime.Now;
                    }
                    else
                    {
                        objVCD = new VendorContract_DistanceBased();
                        objVCD.VendorCode = VendorID;
                        objVCD.CONTRACTCD = ContractCode;
                        objVCD.EntryBy = SessionUtilities.CurrentEmployeeID;
                        objVCD.EntryDt = DateTime.Now;
                    }
                    objVCD.FTL_Type = Ddl_FTL_Type.SelectedValue;
                    objVCD.Vehicle_Number = Ddl_VehNo.SelectedValue;
                    objVCD.Vehicle_Type = Ddl_Veh_Type.SelectedValue;

                    if (Txt_MinChg.Text.Trim() != "")
                        objVCD.Min_Amt_Committed = Convert.ToDouble(Txt_MinChg.Text);
                    if (Txt_Ext_Km.Text.Trim() != "")
                        objVCD.Chg_Per_Add_Km = Convert.ToDouble(Txt_Ext_Km.Text);
                    if (Txt_Km.Text.Trim() != "")
                        objVCD.Committed_Km = Convert.ToDouble(Txt_Km.Text);
                    if (Txt_MaxPayment.Text.Trim() != "")
                        objVCD.Max_Amt_Committed = Convert.ToDouble(Txt_MaxPayment.Text);
                    if (Txt_Trip.Text.Trim() != "")
                        objVCD.Trips_PM = Convert.ToInt32(Txt_Trip.Text);

                    _newList.Add(objVCD);
                }
                else
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    if (_ID > 0)
                    {
                        VendorContract_DistanceBased objVCD = ListVSD.Find(delegate(VendorContract_DistanceBased v) { return v.ID == _ID; });
                        _newList.Add(objVCD);
                    }
                }
            }
            else
            {
                long _ID = Convert.ToInt64(hidID.Value);
                VendorContract_DistanceBased objVCD;
                if (_ID > 0)
                {
                    objVCD = ListVSD.Find(delegate(VendorContract_DistanceBased v) { return v.ID == _ID; });
                    objVCD.UpdateBy = SessionUtilities.CurrentEmployeeID;
                    objVCD.UpdateDt = DateTime.Now;
                }
                else
                {
                    objVCD = new VendorContract_DistanceBased();
                    objVCD.VendorCode = VendorID;
                    objVCD.CONTRACTCD = ContractCode;
                    objVCD.EntryBy = SessionUtilities.CurrentEmployeeID;
                    objVCD.EntryDt = DateTime.Now;
                }
                objVCD.FTL_Type = Ddl_FTL_Type.SelectedValue;
                objVCD.Vehicle_Number = Ddl_VehNo.SelectedValue;
                objVCD.Vehicle_Type = Ddl_Veh_Type.SelectedValue;

                if (Txt_MinChg.Text.Trim() != "")
                    objVCD.Min_Amt_Committed = Convert.ToDouble(Txt_MinChg.Text);
                if (Txt_Ext_Km.Text.Trim() != "")
                    objVCD.Chg_Per_Add_Km = Convert.ToDouble(Txt_Ext_Km.Text);
                if (Txt_Km.Text.Trim() != "")
                    objVCD.Committed_Km = Convert.ToDouble(Txt_Km.Text);
                if (Txt_MaxPayment.Text.Trim() != "")
                    objVCD.Max_Amt_Committed = Convert.ToDouble(Txt_MaxPayment.Text);
                if (Txt_Trip.Text.Trim() != "")
                    objVCD.Max_Amt_Committed = Convert.ToInt32(Txt_Trip.Text);

                _newList.Add(objVCD);
            }
        }
        ListVSD = _newList;
    }

    private void FillAll_DropDown(DropDownList DDL_Mst)
    {
        DDL_Mst.Items.Clear();
        DDL_Mst.Items.Add(new ListItem("All", "All"));
    }

    protected void Ddl_Veh_Type_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList Ddl_Veh_Type = (DropDownList)sender;

        GridViewRow dr = Ddl_Veh_Type.Parent.Parent as GridViewRow;
        DropDownList Ddl_VehNo = (DropDownList)dr.FindControl("Ddl_VehNo");
        Ddl_VehNo.Items.Clear();

        DataView dv = dtVehicle.DefaultView;
        dv.Sort = "VEHDESC";
        dv.RowFilter = "Vehicle_Type='" + Ddl_Veh_Type.SelectedValue + "'";
        Ddl_VehNo.DataSource = dv.Table;
        Ddl_VehNo.DataTextField = "VEHDESC";
        Ddl_VehNo.DataValueField = "VEHNO";
        Ddl_VehNo.DataBind();
        Ddl_VehNo.Items.Insert(0, new ListItem("Select", ""));   
    }

    protected void Submit_Data(object sender, EventArgs e)
    {
        bool doRedirect = false;
        ReverceBind(true);
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction tran = conn.BeginTransaction();
        try
        {
            foreach (VendorContract_DistanceBased vsd in ListVSD)
            {
                bool isSuccess = false;
                if (vsd.ID > 0)
                    isSuccess = VendorContract_DistanceBasedController.Update(vsd, tran);
                else
                {
                    long id = 0;
                    VendorContract_DistanceBased objVCR = VendorContract_DistanceBasedController.GetSingle(vsd.CONTRACTCD, vsd.FTL_Type, vsd.Vehicle_Number, tran);
                    if (objVCR.CONTRACTCD != "")
                    {
                        objVCR.Chg_Per_Add_Km = vsd.Chg_Per_Add_Km;
                        objVCR.Committed_Km = vsd.Committed_Km;
                        objVCR.Max_Amt_Committed = vsd.Max_Amt_Committed;
                        objVCR.Min_Amt_Committed = vsd.Min_Amt_Committed;                        
                        objVCR.UpdateBy = vsd.EntryBy;
                        objVCR.UpdateDt = vsd.EntryDt;

                        isSuccess = VendorContract_DistanceBasedController.Update(objVCR, tran);
                    }
                    else
                    {
                        id = VendorContract_DistanceBasedController.Insert(vsd, tran);
                        if (id > 0)
                            isSuccess = true;
                    }
                }
                if (!isSuccess)
                    throw new Exception("Unknown Exception : Fail to save data.");
            }
            tran.Commit();
            doRedirect =  true;            
        }
        catch (Exception ex)
        {
            if (conn.State == ConnectionState.Open)
                tran.Rollback();
            doRedirect =  false; //

            Response.Redirect("../ErrorPage.aspx?heading=" + ex.Message + "&detail1="+(ex.StackTrace).Replace('\n','~'), false);
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        if(doRedirect)
            Response.Redirect("DoneVendorContract.aspx?ContractNo="+ContractCode,false);
    }
    protected void Submit_WithoutSaving(object sender, EventArgs e)
    {
        Response.Redirect("DoneVendorContract.aspx?ContractNo=" + ContractCode, false);
    }
}