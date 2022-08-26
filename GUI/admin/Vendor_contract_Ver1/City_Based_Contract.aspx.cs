using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_Vendor_contract_Ver1_City_Based_Contract : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "";

    private DataTable dtMode
    {
        get { return (ViewState["dtMode"] != null) ? ViewState["dtMode"] as DataTable : new DataTable(); }
        set { ViewState["dtMode"] = value; }
    }

    private DataTable dtFTL_Type
    {
        get { return (ViewState["dtFTL_Type"] != null) ? ViewState["dtFTL_Type"] as DataTable : new DataTable(); }
        set { ViewState["dtFTL_Type"] = value; }
    }

    private List<VendorContract_CityBased> ListVSR
    {
        get { return (ViewState["ListVSR"] != null) ? ViewState["ListVSR"] as List<VendorContract_CityBased> : new List<VendorContract_CityBased>(); }
        set { ViewState["ListVSR"] = value; }
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
            Lbl_Vendor.Text = VendorID + ":" + VendorDesc;
            Lbl_VendorType.Text = VendorTypeDesc;

            dtFTL_Type = Vendor_Contract.GetFTLType();
            dtMode = Vendor_Contract.GetRouteMode();

            BindGrid();
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
            ListVSR.Add(new VendorContract_CityBased());
        }
        GV_City_Matrix.DataSource = ListVSR;
        GV_City_Matrix.DataBind();
    }
    protected void GV_City_Matrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                VendorContract_CityBased objVCR = e.Row.DataItem as VendorContract_CityBased;

                TextBox Txt_FromCity = (TextBox)e.Row.FindControl("Txt_FromCity");
                TextBox Txt_ToCity = (TextBox)e.Row.FindControl("Txt_ToCity");
                DropDownList Ddl_Mode = (DropDownList)e.Row.FindControl("Ddl_Mode");
                DropDownList Ddl_FTL_Type = (DropDownList)e.Row.FindControl("Ddl_FTL_Type");
                DropDownList Ddl_Rate_Type = (DropDownList)e.Row.FindControl("Ddl_Rate_Type");
                CheckBox ChkInd = (CheckBox)e.Row.FindControl("ChkInd");
                HiddenField hidID = (HiddenField)e.Row.FindControl("hidID");
                TextBox Txt_MinChg = (TextBox)e.Row.FindControl("Txt_MinChg");
                TextBox Txt_MaxChg = (TextBox)e.Row.FindControl("Txt_MaxChg");
                TextBox Txt_Rate = (TextBox)e.Row.FindControl("Txt_Rate");

                HtmlInputButton btnFromCity = (HtmlInputButton)e.Row.FindControl("btnFromCity");
                HtmlInputButton btnToCity = (HtmlInputButton)e.Row.FindControl("btnToCity");


                btnFromCity.Attributes.Add("onclick", "openPopupCity('" + Txt_FromCity.ClientID + "')");
                btnToCity.Attributes.Add("onclick", "openPopupCity('" + Txt_ToCity.ClientID + "')");

                Txt_FromCity.Attributes.Add("onchange", "javascript:return ValidateCity('" + Txt_FromCity.ClientID + "');");
                Txt_ToCity.Attributes.Add("onchange", "javascript:return ValidateCity('" + Txt_ToCity.ClientID + "');");

                hidID.Value = objVCR.ID.ToString();
                Txt_FromCity.Text = objVCR.FROM_CITY;
                Txt_ToCity.Text = objVCR.TO_CITY;

                Ddl_Mode.DataSource = dtMode;
                Ddl_Mode.DataTextField = "Codedesc";
                Ddl_Mode.DataValueField = "CodeID";
                Ddl_Mode.DataBind();
                Ddl_Mode.Items.Insert(0, new ListItem("Select", ""));
                Ddl_Mode.SelectedValue = objVCR.TransMode;

                if (objVCR.TransMode == "")
                {
                    FillAll_DropDown(Ddl_FTL_Type);
                }
                else
                {
                    if (objVCR.TransMode == "S")
                    {
                        Ddl_FTL_Type.DataSource = dtFTL_Type;
                        Ddl_FTL_Type.DataTextField = "Codedesc";
                        Ddl_FTL_Type.DataValueField = "CodeID";
                        Ddl_FTL_Type.DataBind();
                        Ddl_FTL_Type.Items.Insert(0, new ListItem("Select", ""));
                        Ddl_FTL_Type.SelectedValue = objVCR.FTL_Type;
                    }
                    else
                    {
                        FillAll_DropDown(Ddl_FTL_Type);
                    }
                }
                Ddl_Rate_Type.SelectedValue = objVCR.Rate_Type;
                if (objVCR.Min_Charge > 0)
                    Txt_MinChg.Text = objVCR.Min_Charge.ToString("0.00");
                if (objVCR.Max_Charge > 0)
                    Txt_MaxChg.Text = objVCR.Max_Charge.ToString("0.00");
                if (objVCR.Chg_Rate > 0)
                    Txt_Rate.Text = objVCR.Chg_Rate.ToString("0.00");
            }
        }
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
            foreach (VendorContract_CityBased vsr in ListVSR)
            {
                bool isSuccess = false;
                if (vsr.ID > 0)
                    isSuccess = VendorContract_CityBasedController.Update(vsr, tran);
                else
                {
                    long id = 0;
                    VendorContract_CityBased objVCR = VendorContract_CityBasedController.GetSingle(vsr.CONTRACTCD, vsr.FROM_CITY, vsr.TO_CITY, vsr.TransMode, vsr.FTL_Type, tran);
                    if (objVCR.CONTRACTCD != "")
                    {
                        objVCR.Chg_Rate = vsr.Chg_Rate;
                        objVCR.Max_Charge = vsr.Max_Charge;
                        objVCR.Min_Charge = vsr.Min_Charge;
                        objVCR.Rate_Type = vsr.Rate_Type;
                        objVCR.UpdateBy = vsr.EntryBy;
                        objVCR.UpdateDt = vsr.EntryDt;

                        isSuccess = VendorContract_CityBasedController.Update(objVCR, tran);
                    }
                    else
                    {
                        id = VendorContract_CityBasedController.Insert(vsr, tran);
                        if (id > 0)
                            isSuccess = true;
                    }
                }
                if (!isSuccess)
                    throw new Exception("Unknown Exception : Fail to save data.");
            }
            tran.Commit();
            doRedirect = true;
        }
        catch (Exception ex)
        {
            if (conn.State == ConnectionState.Open)
                tran.Rollback();
            doRedirect = false;
            Response.Redirect("../ErrorPage.aspx?heading=" + ex.Message + "&detail1=" + (ex.StackTrace).Replace('\n', '~'), false);
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        if (doRedirect)
            DoRedirect();
    }

    protected void Ddl_Mode_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList Ddl_Mode = (DropDownList)sender;

        GridViewRow dr = Ddl_Mode.Parent.Parent as GridViewRow;
        DropDownList Ddl_FTL_Type = (DropDownList)dr.FindControl("Ddl_FTL_Type");

        if (Ddl_Mode.SelectedValue == "S")
        {
            Ddl_FTL_Type.DataSource = dtFTL_Type;
            Ddl_FTL_Type.DataTextField = "Codedesc";
            Ddl_FTL_Type.DataValueField = "CodeID";
            Ddl_FTL_Type.DataBind();
            Ddl_FTL_Type.Items.Insert(0, new ListItem("Select", ""));
            Ddl_FTL_Type.Items.Insert(1, new ListItem("ALL", "All"));
            Ddl_FTL_Type.SelectedValue = "";
        }
        else
        {
            FillAll_DropDown(Ddl_FTL_Type);
        }
    }

    private void ReverceBind(bool isFinal)
    {
        List<VendorContract_CityBased> _newList = new List<VendorContract_CityBased>();
        foreach (GridViewRow gvr in GV_City_Matrix.Rows)
        {
            TextBox Txt_FromCity = (TextBox)gvr.FindControl("Txt_FromCity");
            TextBox Txt_ToCity = (TextBox)gvr.FindControl("Txt_ToCity");
            DropDownList Ddl_Mode = (DropDownList)gvr.FindControl("Ddl_Mode");
            DropDownList Ddl_FTL_Type = (DropDownList)gvr.FindControl("Ddl_FTL_Type");
            DropDownList Ddl_Rate_Type = (DropDownList)gvr.FindControl("Ddl_Rate_Type");
            CheckBox ChkInd = (CheckBox)gvr.FindControl("ChkInd");
            HiddenField hidID = (HiddenField)gvr.FindControl("hidID");
            TextBox Txt_MinChg = (TextBox)gvr.FindControl("Txt_MinChg");
            TextBox Txt_MaxChg = (TextBox)gvr.FindControl("Txt_MaxChg");
            TextBox Txt_Rate = (TextBox)gvr.FindControl("Txt_Rate");

            if (isFinal)
            {
                if (ChkInd.Checked)
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    VendorContract_CityBased objVCR;
                    if (_ID > 0)
                    {
                        objVCR = ListVSR.Find(delegate(VendorContract_CityBased v) { return v.ID == _ID; });
                        objVCR.UpdateBy = SessionUtilities.CurrentEmployeeID;
                        objVCR.UpdateDt = DateTime.Now;
                    }
                    else
                    {
                        objVCR = new VendorContract_CityBased();
                        objVCR.VendorCode = VendorID;
                        objVCR.CONTRACTCD = ContractCode;
                        objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                        objVCR.EntryDt = DateTime.Now;
                    }
                    objVCR.FROM_CITY = Txt_FromCity.Text.Trim();
                    objVCR.TO_CITY = Txt_ToCity.Text.Trim();
                    objVCR.TransMode = Ddl_Mode.SelectedValue;
                    objVCR.FTL_Type = Ddl_FTL_Type.SelectedValue;
                    objVCR.Rate_Type = Ddl_Rate_Type.SelectedValue;
                    if (Txt_MinChg.Text.Trim() != "")
                        objVCR.Min_Charge = Convert.ToDouble(Txt_MinChg.Text);
                    if (Txt_Rate.Text.Trim() != "")
                        objVCR.Chg_Rate = Convert.ToDouble(Txt_Rate.Text);
                    if (Txt_MaxChg.Text.Trim() != "")
                        objVCR.Max_Charge = Convert.ToDouble(Txt_MaxChg.Text);

                    _newList.Add(objVCR);
                }
                else
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    if (_ID > 0)
                    {
                        VendorContract_CityBased objVCR = ListVSR.Find(delegate(VendorContract_CityBased v) { return v.ID == _ID; });
                        _newList.Add(objVCR);
                    }
                }
            }
            else
            {
                long _ID = Convert.ToInt64(hidID.Value);
                VendorContract_CityBased objVCR;
                if (_ID > 0)
                {
                    objVCR = ListVSR.Find(delegate(VendorContract_CityBased v) { return v.ID == _ID; });
                    objVCR.UpdateBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.UpdateDt = DateTime.Now;
                }
                else
                {
                    objVCR = new VendorContract_CityBased();
                    objVCR.VendorCode = VendorID;
                    objVCR.CONTRACTCD = ContractCode;
                    objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.EntryDt = DateTime.Now;
                }
                objVCR.FROM_CITY = Txt_FromCity.Text.Trim();
                objVCR.TO_CITY = Txt_ToCity.Text.Trim();
                objVCR.TransMode = Ddl_Mode.SelectedValue;
                objVCR.FTL_Type = Ddl_FTL_Type.SelectedValue;
                objVCR.Rate_Type = Ddl_Rate_Type.SelectedValue;
                if (Txt_MinChg.Text.Trim() != "")
                    objVCR.Min_Charge = Convert.ToDouble(Txt_MinChg.Text);
                if (Txt_Rate.Text.Trim() != "")
                    objVCR.Chg_Rate = Convert.ToDouble(Txt_Rate.Text);
                if (Txt_MaxChg.Text.Trim() != "")
                    objVCR.Max_Charge = Convert.ToDouble(Txt_MaxChg.Text);

                _newList.Add(objVCR);
            }
        }
        ListVSR = _newList;
    }
    private void BindGrid()
    {
        ListVSR = VendorContract_CityBasedController.GetByContractID(ContractCode);
        if (ListVSR.Count <= 0)
        {
            ListVSR.Add(new VendorContract_CityBased());
        }
        GV_City_Matrix.DataSource = ListVSR;
        GV_City_Matrix.DataBind();
    }
    private void DoRedirect()
    {
        string Qstring = "?VendorTypeID=" + VendorTypeID;
        Qstring += "&VendorTypeDesc=" + VendorTypeDesc;
        Qstring += "&VendorID=" + VendorID;
        Qstring += "&VendorDesc=" + VendorDesc;
        Qstring += "&Add_Edit_Flag=" + Add_Edit_Flag;
        Qstring += "&ContractCode=" + ContractCode;
        Qstring += "&ContractType=" + ContractType;
        Qstring += "&NextStep=3";
        Response.Redirect("./Distance_Based_Contract.aspx" + Qstring);
    }
    private void FillAll_DropDown(DropDownList DDL_Mst)
    {
        DDL_Mst.Items.Clear();
        DDL_Mst.Items.Add(new ListItem("ALL", "All"));
    }
    protected void Submit_WithoutSaving(object sender, EventArgs e)
    {
        Response.Redirect("DoneVendorContract.aspx?ContractNo=" + ContractCode, false);
    }
}