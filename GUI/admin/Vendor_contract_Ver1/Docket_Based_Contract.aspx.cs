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

public partial class GUI_admin_Vendor_contract_Ver1_Docket_Based_Contract : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "";

    private List<VendorContract_DocketBased> ListVSD
    {
        get { return (ViewState["ListVSD"] != null) ? ViewState["ListVSD"] as List<VendorContract_DocketBased> : new List<VendorContract_DocketBased>(); }
        set { ViewState["ListVSD"] = value; }
    }

    private string Mode_List
    {
        get { return (ViewState["Mode_List"] != null) ? ViewState["Mode_List"].ToString() : ""; }
        set { ViewState["Mode_List"] = value; }
    }
    private string PayBas_List
    {
        get { return (ViewState["PayBas_List"] != null) ? ViewState["PayBas_List"].ToString() : ""; }
        set { ViewState["PayBas_List"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        VendorID = Request.QueryString.Get("VendorID");
        VendorDesc = Request.QueryString.Get("VendorDesc");
        VendorTypeID = Request.QueryString.Get("VendorTypeID");
        VendorTypeDesc = Request.QueryString.Get("VendorTypeDesc");
        Add_Edit_Flag = Request.QueryString.Get("Add_Edit_Flag");
        ContractCode = Request.QueryString.Get("ContractCode");
        if (!IsPostBack)
        {
			Lbl_Contract_title.Text = "Vendor Contract Step 2: " + SessionUtilities.DocketCalledAs + " Based Contract";
            Lbl_Contract_title2.Text = SessionUtilities.DocketCalledAs + " Based Contract Matrix : Booking Charges";

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
            Mode_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("TRN");
            PayBas_List = Vendor_Contract.Get_VendorContract_Mst_Selection_Array("PAYTYP");
            BindGrid();
        }
    }

    protected void AddGridRow(object sender, EventArgs e)
    {
        ReverceBind(false);
        int addRows = 0;
        if(Txt_TotRows.Text.Trim() != "")
            addRows = Convert.ToInt32(Txt_TotRows.Text.Trim());
        for (int i = 0; i < addRows; i++)
        {
            ListVSD.Add(new VendorContract_DocketBased());
        }
        GV_Docket_Matrix.DataSource = ListVSD;
        GV_Docket_Matrix.DataBind();
    }

    public void BindGrid()
    {        
        //Vendor_Contract.Add_DynamicGridRow(GV_Docket_Matrix, Convert.ToInt16(Txt_TotRows.Text));
        ListVSD = VendorContract_DocketBasedController.GetByChgType(ContractCode,"B");
        if (ListVSD.Count <= 0)
        {
            ListVSD.Add(new VendorContract_DocketBased());
            Btn_SubmitWithoutSave.Visible = false;
        }
        else
            Btn_SubmitWithoutSave.Visible = true;
        GV_Docket_Matrix.DataSource = ListVSD;
        GV_Docket_Matrix.DataBind();
    }

    protected void GV_Route_Matrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            VendorContract_DocketBased vsd = e.Row.DataItem as VendorContract_DocketBased;

            DropDownList Ddl_Mode = (DropDownList)e.Row.FindControl("Ddl_Mode");
            DropDownList Ddl_Paybas = (DropDownList)e.Row.FindControl("Ddl_Paybas");
            DropDownList Ddl_Bkg_Del = (DropDownList)e.Row.FindControl("Ddl_Bkg_Del");
            DropDownList Ddl_Rate_Type = (DropDownList)e.Row.FindControl("Ddl_Rate_Type");
            TextBox Txt_Location = (TextBox)e.Row.FindControl("Txt_Location");
            TextBox Txt_City = (TextBox)e.Row.FindControl("Txt_City");
            TextBox Txt_MinChg = (TextBox)e.Row.FindControl("Txt_MinChg");
            TextBox Txt_Rate = (TextBox)e.Row.FindControl("Txt_Rate");
            TextBox Txt_MaxChg = (TextBox)e.Row.FindControl("Txt_MaxChg");
            HiddenField hidID = (HiddenField)e.Row.FindControl("hidID");            
            HtmlInputButton btnLoc = (HtmlInputButton)e.Row.FindControl("btnLoc");
            HtmlInputButton btnCity = (HtmlInputButton)e.Row.FindControl("btnCity");

            Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(Mode_List, Ddl_Mode);
            Vendor_Contract.Fill_DDL_Mst_Selection_From_Array(PayBas_List, Ddl_Paybas);

            btnLoc.Attributes.Add("onclick", "openPopupLoc('"+Txt_Location.ClientID +"')");
            btnCity.Attributes.Add("onclick", "openPopupCity('" + Txt_City.ClientID + "')");

            Txt_Location.Attributes.Add("onchange", "javascript:return ValidateLocation('" + Txt_Location.ClientID + "');");
            Txt_City.Attributes.Add("onchange", "javascript:return ValidateCity('" + Txt_City.ClientID + "');");
            
            hidID.Value = vsd.ID.ToString();
            Ddl_Mode.SelectedValue = vsd.TransMode;
            Ddl_Paybas.SelectedValue = vsd.PayBas;
            Ddl_Bkg_Del.SelectedValue = "B";
            Ddl_Rate_Type.SelectedValue = vsd.Rate_Type;
            Txt_Location.Text = vsd.Location;
            Txt_City.Text = vsd.City;
            if(vsd.Min_Charge > 0)
                Txt_MinChg.Text = vsd.Min_Charge.ToString("0.00");
            if (vsd.Chg_Rate > 0)
                Txt_Rate.Text = vsd.Chg_Rate.ToString("0.00");
            if (vsd.Max_Charge > 0)
                Txt_MaxChg.Text = vsd.Max_Charge.ToString("0.00");
        }
    }

    private void ReverceBind(bool isFinal)
    {
        List<VendorContract_DocketBased> _newList = new List<VendorContract_DocketBased>();
        foreach (GridViewRow gvr in GV_Docket_Matrix.Rows)
        {
            DropDownList Ddl_Mode = (DropDownList)gvr.FindControl("Ddl_Mode");
            DropDownList Ddl_Paybas = (DropDownList)gvr.FindControl("Ddl_Paybas");
            DropDownList Ddl_Bkg_Del = (DropDownList)gvr.FindControl("Ddl_Bkg_Del");
            DropDownList Ddl_Rate_Type = (DropDownList)gvr.FindControl("Ddl_Rate_Type");
            TextBox Txt_Location = (TextBox)gvr.FindControl("Txt_Location");
            TextBox Txt_City = (TextBox)gvr.FindControl("Txt_City");
            TextBox Txt_MinChg = (TextBox)gvr.FindControl("Txt_MinChg");
            TextBox Txt_Rate = (TextBox)gvr.FindControl("Txt_Rate");
            TextBox Txt_MaxChg = (TextBox)gvr.FindControl("Txt_MaxChg");
            HiddenField hidID = (HiddenField)gvr.FindControl("hidID");
            CheckBox ChkInd = (CheckBox)gvr.FindControl("ChkInd");

            if (isFinal)
            {
                if (ChkInd.Checked)
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    VendorContract_DocketBased objVSD;
                    if (_ID > 0)
                    {
                        objVSD = ListVSD.Find(delegate(VendorContract_DocketBased v) { return v.ID == _ID; });
                        objVSD.UpdateBy = SessionUtilities.CurrentEmployeeID;
                        objVSD.UpdateDt = DateTime.Now;
                    }
                    else
                    {
                        objVSD = new VendorContract_DocketBased();
                        objVSD.VendorCode = VendorID;
                        objVSD.CONTRACTCD = ContractCode;
                        objVSD.EntryBy = SessionUtilities.CurrentEmployeeID;
                        objVSD.EntryDt = DateTime.Now;
                    }
                    objVSD.TransMode = Ddl_Mode.SelectedValue;
                    objVSD.PayBas = Ddl_Paybas.SelectedValue;
                    objVSD.ChargeType = Ddl_Bkg_Del.SelectedValue;
                    objVSD.Rate_Type = Ddl_Rate_Type.SelectedValue;
                    objVSD.Location = Txt_Location.Text.Trim();
                    objVSD.City = Txt_City.Text.Trim();
                    if (Txt_MinChg.Text.Trim() != "")
                        objVSD.Min_Charge = Convert.ToDouble(Txt_MinChg.Text);
                    if (Txt_Rate.Text.Trim() != "")
                        objVSD.Chg_Rate = Convert.ToDouble(Txt_Rate.Text);
                    if (Txt_MaxChg.Text.Trim() != "")
                        objVSD.Max_Charge = Convert.ToDouble(Txt_MaxChg.Text);

                    _newList.Add(objVSD);
                }
                else
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    if (_ID > 0)
                    {
                        VendorContract_DocketBased objVSD = ListVSD.Find(delegate(VendorContract_DocketBased v) { return v.ID == _ID; });
                        _newList.Add(objVSD);
                    }
                }
            }
            else
            {
                long _ID = Convert.ToInt64(hidID.Value);
                VendorContract_DocketBased objVSD;
                if (_ID > 0)
                {
                    objVSD = ListVSD.Find(delegate(VendorContract_DocketBased v) { return v.ID == _ID; });
                    objVSD.UpdateBy = SessionUtilities.CurrentEmployeeID;
                    objVSD.UpdateDt = DateTime.Now;
                }
                else
                {
                    objVSD = new VendorContract_DocketBased();
                    objVSD.VendorCode = VendorID;
                    objVSD.CONTRACTCD = ContractCode;
                    objVSD.EntryBy = SessionUtilities.CurrentEmployeeID;
                    objVSD.EntryDt = DateTime.Now;
                }
                objVSD.TransMode = Ddl_Mode.SelectedValue;
                objVSD.PayBas = Ddl_Paybas.SelectedValue;
                objVSD.ChargeType = Ddl_Bkg_Del.SelectedValue;
                objVSD.Rate_Type = Ddl_Rate_Type.SelectedValue;
                objVSD.Location = Txt_Location.Text.Trim();
                objVSD.City = Txt_City.Text.Trim();
                if (Txt_MaxChg.Text.Trim() != "")
                    objVSD.Min_Charge = Convert.ToDouble(Txt_MaxChg.Text);
                if (Txt_Rate.Text.Trim() != "")
                    objVSD.Chg_Rate = Convert.ToDouble(Txt_Rate.Text);
                if (Txt_MaxChg.Text.Trim() != "")
                    objVSD.Max_Charge = Convert.ToDouble(Txt_MaxChg.Text);

                _newList.Add(objVSD);
            }
        }
        ListVSD = _newList;
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
            foreach (VendorContract_DocketBased vsd in ListVSD)
            {
                bool isSuccess = false;
                if (vsd.ID > 0)
                    isSuccess = VendorContract_DocketBasedController.Update(vsd, tran);
                else
                {
                    long id = 0;
                    VendorContract_DocketBased objVCR = VendorContract_DocketBasedController.GetSingle(vsd.CONTRACTCD, vsd.Location, vsd.City, vsd.PayBas, vsd.TransMode, vsd.ChargeType, tran);
                    if (objVCR.CONTRACTCD != "")
                    {
                        objVCR.Location = vsd.Location;
                        objVCR.City = vsd.City;
                        objVCR.Chg_Rate = vsd.Chg_Rate;
                        objVCR.Max_Charge = vsd.Max_Charge;
                        objVCR.Min_Charge = vsd.Min_Charge;
                        objVCR.Rate_Type = vsd.Rate_Type;
                        objVCR.UpdateBy = vsd.EntryBy;
                        objVCR.UpdateDt = vsd.EntryDt;                        

                        isSuccess = VendorContract_DocketBasedController.Update(objVCR, tran);
                    }
                    else
                    {
                        id = VendorContract_DocketBasedController.Insert(vsd, tran);
                        if (id > 0)
                            isSuccess = true;
                    }                    
                }
                if (!isSuccess)
                    throw new Exception("Unknown Exception : Fail to save data.");
            }
            tran.Commit();
            //BindGrid();
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
        //if (doRedirect)
        //    Response.Redirect("DoneVendorContract.aspx?ContractNo=" + ContractCode, false);
        if (doRedirect)
            RedirectToNextStep();
    }

    protected void Submit_WithoutSaving(object sender, EventArgs e) 
    { 
        //Redirect to Delivery Matrix
        RedirectToNextStep();
    }

    private void RedirectToNextStep()
    {
        string final = "?VendorID=" + VendorID;
        final += "&VendorDesc=" + VendorDesc;
        final += "&VendorTypeID=" + VendorTypeID;
        final += "&VendorTypeDesc=" + VendorTypeDesc;
        final += "&Add_Edit_Flag=" + Add_Edit_Flag;
        final += "&ContractCode=" + ContractCode;

        Response.Redirect("Docket_Based_Contract_Del.aspx" + final, false);
    }
}
