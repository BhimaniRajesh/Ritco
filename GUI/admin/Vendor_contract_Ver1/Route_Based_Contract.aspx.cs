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

public partial class GUI_admin_Vendor_contract_Ver1_Route_Based_Contract : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "";

    private string Mode_List
    {
        get { return (ViewState["Mode_List"] != null) ? ViewState["Mode_List"].ToString() : ""; }
        set { ViewState["Mode_List"] = value; }
    }
    private string Route_List
    {
        get { return (ViewState["Route_List"] != null) ? ViewState["Route_List"].ToString() : ""; }
        set { ViewState["Route_List"] = value; }
    }
    private string FTL_Type_list
    {
        get { return (ViewState["FTL_Type_list"] != null) ? ViewState["FTL_Type_list"].ToString() : ""; }
        set { ViewState["FTL_Type_list"] = value; }
    }

    private DataTable dtMode
    {
        get { return (ViewState["dtMode"] != null) ? ViewState["dtMode"] as DataTable : new DataTable(); }
        set { ViewState["dtMode"] = value; }
    }
    private DataTable dtRoute
    {
        get { return (ViewState["dtRoute"] != null) ? ViewState["dtRoute"] as DataTable : new DataTable(); }
        set { ViewState["dtRoute"] = value; }
    }
    private DataTable dtFTL_Type
    {
        get { return (ViewState["dtFTL_Type"] != null) ? ViewState["dtFTL_Type"] as DataTable : new DataTable(); }
        set { ViewState["dtFTL_Type"] = value; }
    }

    private List<VendorContract_RouteBased> ListVSR
    {
        get { return (ViewState["ListVSR"] != null) ? ViewState["ListVSR"] as List<VendorContract_RouteBased> : new List<VendorContract_RouteBased>(); }
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
            //Mode_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("TRN");
            //Route_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("RUT");
            //FTL_Type_list = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("FTLTYP");

            dtMode = Vendor_Contract.GetRouteMode();
            dtRoute = Vendor_Contract.GetRoute();
            dtFTL_Type = Vendor_Contract.GetFTLType();

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
            ListVSR.Add(new VendorContract_RouteBased());
        }
        GV_Route_Matrix.DataSource = ListVSR;
        GV_Route_Matrix.DataBind();
    }
    protected void GV_Route_Matrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                VendorContract_RouteBased objVCR = e.Row.DataItem as VendorContract_RouteBased;

                DropDownList Ddl_Mode = (DropDownList)e.Row.FindControl("Ddl_Mode");
                DropDownList Ddl_Route = (DropDownList)e.Row.FindControl("Ddl_Route");
                DropDownList Ddl_FTL_Type = (DropDownList)e.Row.FindControl("Ddl_FTL_Type");
                DropDownList Ddl_Rate_Type = (DropDownList)e.Row.FindControl("Ddl_Rate_Type");
                CheckBox ChkInd = (CheckBox)e.Row.FindControl("ChkInd");
                HiddenField hidID = (HiddenField)e.Row.FindControl("hidID");
                TextBox Txt_MinChg = (TextBox)e.Row.FindControl("Txt_MinChg");
                TextBox Txt_MaxChg = (TextBox)e.Row.FindControl("Txt_MaxChg");
                TextBox Txt_Rate = (TextBox)e.Row.FindControl("Txt_Rate");

                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(Mode_List, Ddl_Mode);
                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(Route_List, Ddl_Route);
                //Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(FTL_Type_list, Ddl_FTL_Type);

                hidID.Value = objVCR.ID.ToString();

                Ddl_Mode.DataSource = dtMode;
                Ddl_Mode.DataTextField = "Codedesc";
                Ddl_Mode.DataValueField = "CodeID";
                Ddl_Mode.DataBind();
                Ddl_Mode.Items.Insert(0, new ListItem("Select", ""));
                Ddl_Mode.SelectedValue = objVCR.TransMode;
                if (objVCR.TransMode == "")
                {
                    Ddl_Route.Items.Clear();
                    Ddl_Route.Items.Add(new ListItem("Select", ""));
                    //FillAll_DropDown(Ddl_FTL_Type);
                }
                else
                {
                    DataView dv = dtRoute.DefaultView;
                    dv.Sort = "RUTCD";
                    dv.RowFilter = "TransMode='" + objVCR.TransMode + "'";
                    Ddl_Route.DataSource = dv.Table;
                    Ddl_Route.DataTextField = "Route";
                    Ddl_Route.DataValueField = "RUTCD";
                    Ddl_Route.DataBind();
                    Ddl_Route.Items.Insert(0, new ListItem("Select", ""));

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
                Ddl_Route.SelectedValue = objVCR.RouteCode;

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
        ReverceBind(true);
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction tran = conn.BeginTransaction();
        try
        {
            foreach (VendorContract_RouteBased vsr in ListVSR)
            {
                bool isSuccess = false;
                if (vsr.ID > 0)
                    isSuccess = VendorContract_RouteBasedController.Update(vsr, tran);
                else
                {
                    long id = 0;
                    VendorContract_RouteBased objVCR = VendorContract_RouteBasedController.GetSingle(vsr.CONTRACTCD, vsr.RouteCode, vsr.FTL_Type, tran);
                    if (objVCR.CONTRACTCD != "")
                    {
                        objVCR.Chg_Rate = vsr.Chg_Rate;
                        objVCR.Max_Charge = vsr.Max_Charge;
                        objVCR.Min_Charge = vsr.Min_Charge;
                        objVCR.Rate_Type = vsr.Rate_Type;
                        objVCR.UpdateBy = vsr.EntryBy;
                        objVCR.UpdateDt = vsr.EntryDt;

                        isSuccess = VendorContract_RouteBasedController.Update(objVCR, tran);
                    }
                    else
                    {
                        id = VendorContract_RouteBasedController.Insert(vsr, tran);
                        if (id > 0)
                            isSuccess = true;
                    }
                }
                if (!isSuccess)
                    throw new Exception("Unknown Exception : Fail to save data.");
            }
            tran.Commit();
            DoRedirect();
        }
        catch (Exception ex)
        {
            if (conn.State == ConnectionState.Open)
                tran.Rollback();

            Response.Write(ex.Message);
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
    }
    protected void Ddl_Mode_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList Ddl_Mode = (DropDownList)sender;

        GridViewRow dr = Ddl_Mode.Parent.Parent as GridViewRow;
        DropDownList Ddl_Route = (DropDownList)dr.FindControl("Ddl_Route");
        DropDownList Ddl_FTL_Type = (DropDownList)dr.FindControl("Ddl_FTL_Type");
        Ddl_Route.Items.Clear();

        DataView dv = dtRoute.DefaultView;
        dv.Sort = "RUTCD";
        dv.RowFilter = "TransMode='" + Ddl_Mode.SelectedValue + "'";
        Ddl_Route.DataSource = dv.Table;
        Ddl_Route.DataTextField = "Route";
        Ddl_Route.DataValueField = "RUTCD";
        Ddl_Route.DataBind();
        Ddl_Route.Items.Insert(0, new ListItem("Select", ""));

        if (Ddl_Mode.SelectedValue == "S")
        {
            Ddl_FTL_Type.DataSource = dtFTL_Type;
            Ddl_FTL_Type.DataTextField = "Codedesc";
            Ddl_FTL_Type.DataValueField = "CodeID";
            Ddl_FTL_Type.DataBind();
            Ddl_FTL_Type.Items.Insert(0, new ListItem("Select", ""));
        }
        else
        {
            FillAll_DropDown(Ddl_FTL_Type);
        }
    }
    private void ReverceBind(bool isFinal)
    {
        List<VendorContract_RouteBased> _newList = new List<VendorContract_RouteBased>();
        foreach (GridViewRow gvr in GV_Route_Matrix.Rows)
        {
            DropDownList Ddl_Mode = (DropDownList)gvr.FindControl("Ddl_Mode");
            DropDownList Ddl_Route = (DropDownList)gvr.FindControl("Ddl_Route");
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
                    VendorContract_RouteBased objVCR;
                    if (_ID > 0)
                    {
                        objVCR = ListVSR.Find(delegate(VendorContract_RouteBased v) { return v.ID == _ID; });
                        objVCR.UpdateBy = SessionUtilities.CurrentEmployeeID;
                        objVCR.UpdateDt = DateTime.Now;
                    }
                    else
                    {
                        objVCR = new VendorContract_RouteBased();
                        objVCR.VendorCode = VendorID;
                        objVCR.CONTRACTCD = ContractCode;
                        objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                        objVCR.EntryDt = DateTime.Now;
                    }
                    objVCR.TransMode = Ddl_Mode.SelectedValue;
                    objVCR.RouteCode = Ddl_Route.SelectedValue;
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
                        VendorContract_RouteBased objVCR = ListVSR.Find(delegate(VendorContract_RouteBased v) { return v.ID == _ID; });
                        _newList.Add(objVCR);
                    }
                }
            }
            else
            {
                long _ID = Convert.ToInt64(hidID.Value);
                VendorContract_RouteBased objVCR;
                if (_ID > 0)
                {
                    objVCR = ListVSR.Find(delegate(VendorContract_RouteBased v) { return v.ID == _ID; });
                    objVCR.UpdateBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.UpdateDt = DateTime.Now;
                }
                else
                {
                    objVCR = new VendorContract_RouteBased();
                    objVCR.VendorCode = VendorID;
                    objVCR.CONTRACTCD = ContractCode;
                    objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.EntryDt = DateTime.Now;
                }
                objVCR.TransMode = Ddl_Mode.SelectedValue;
                objVCR.RouteCode = Ddl_Route.SelectedValue;
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
        ListVSR = VendorContract_RouteBasedController.GetByContractID(ContractCode);
        if (ListVSR.Count <= 0)
        {
            ListVSR.Add(new VendorContract_RouteBased());
        }
        GV_Route_Matrix.DataSource = ListVSR;
        GV_Route_Matrix.DataBind();
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
        Response.Redirect("./Distance_Based_Contract.aspx" + Qstring, false);
    }

    private void FillAll_DropDown(DropDownList DDL_Mst)
    {
        DDL_Mst.Items.Clear();
        DDL_Mst.Items.Add(new ListItem("ALL", "All"));
    }
}