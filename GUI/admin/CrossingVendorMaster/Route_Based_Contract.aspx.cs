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

public partial class GUI_admin_CrossingVendorMaster_Route_Based_Contract : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractCode = "", ContractType = "";

    private string Route_List
    {
        get { return (ViewState["Route_List"] != null) ? ViewState["Route_List"].ToString() : ""; }
        set { ViewState["Route_List"] = value; }
    }

    private DataTable dtRoute
    {
        get { return (ViewState["dtRoute"] != null) ? ViewState["dtRoute"] as DataTable : new DataTable(); }
        set { ViewState["dtRoute"] = value; }
    }

    private MyDataSet.CrossingContractDetDataTable ListVSR
    {
        get { return (ViewState["ListVSR"] != null) ? ViewState["ListVSR"] as MyDataSet.CrossingContractDetDataTable : null; }
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
            ListVSR.Rows.Add(ListVSR.NewRow());
        }
        GV_Route_Matrix.DataSource = ListVSR;
        GV_Route_Matrix.DataBind();
    }
    protected void GV_Route_Matrix_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
    private void ReverceBind(bool isFinal)
    {
        MyDataSet.CrossingContractDetDataTable _newList = new MyDataSet.CrossingContractDetDataTable();
        foreach (GridViewRow gvr in GV_Route_Matrix.Rows)
        {
            DropDownList cmbratetype = (DropDownList)gvr.FindControl("cmbratetype");            
            CheckBox ChkInd = (CheckBox)gvr.FindControl("chkyes");
            HiddenField hidID = (HiddenField)gvr.FindControl("hidID");
            TextBox txtlocation = (TextBox)gvr.FindControl("txtlocation");
            TextBox txtDestcity = (TextBox)gvr.FindControl("txtDestcity");
            TextBox txtrate = (TextBox)gvr.FindControl("txtrate");
            TextBox txtDoorDelyCharge = (TextBox)gvr.FindControl("txtDoorDelyCharge");

            if (isFinal)
            {
                if (ChkInd.Checked)
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    DataRow objVCR;
                    if (_ID > 0)
                    {
                        DataRow[] arrVCR = ListVSR.Select("ID='" + _ID.ToString() + "'");
                        if (arrVCR.Length > 0)
                        {
                            objVCR = arrVCR[0];
                            //objVCR. = SessionUtilities.CurrentEmployeeID;
                            //objVCR.UpdatedDate = DateTime.Now.ToString();
                        }
                    }
                    else
                    {
                        objVCR = new DataRow();
                        objVCR.VendorCode = VendorID;
                        objVCR.CONTRACTCD = ContractCode;
                        objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                        objVCR.EntryDate = DateTime.Now.ToString();
                    }
                    // Get Other all required controls and add its value to respective column
                    objVCR.ActiveFlag = "Y";
                    objVCR.Origin = txtlocation.Text;
                    objVCR.DestCity = txtDestcity.Text;
                    if (txtDoorDelyCharge.Text.Trim() != "")
                        objVCR.doordeliveryCharge = txtDoorDelyCharge.Text;
                    else
                        objVCR.doordeliveryCharge = "0.00";
                    if (txtrate.Text.Trim() != "")
                        objVCR.rate = txtrate.Text;
                    else
                        objVCR.rate = "0.00";                    
                    objVCR.ratetype = cmbratetype.SelectedValue;

                    _newList.Rows.Add(objVCR);
                }
                else
                {
                    long _ID = Convert.ToInt64(hidID.Value);
                    if (_ID > 0)
                    {
                        DataRow[] arrVCR = ListVSR.Select("ID='" + _ID.ToString() + "'");
                        if (arrVCR.Length > 0)
                        {
                            _newList.Rows.Add(arrVCR[0]);
                        }
                    }
                }
            }
            else
            {
                long _ID = Convert.ToInt64(hidID.Value);
                MyDataSet.CrossingContractDetRow objVCR;
                if (_ID > 0)
                {
                    objVCR = ListVSR.Find(delegate(MyDataSet.CrossingContractDetRow v) { return v.ID == _ID; });
                    objVCR.UpdatedBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.UpdatedDate = DateTime.Now.ToString();
                }
                else
                {
                    objVCR = new MyDataSet.CrossingContractDetRow();
                    objVCR.VendorCode = VendorID;
                    objVCR.CONTRACTCD = ContractCode;
                    objVCR.EntryBy = SessionUtilities.CurrentEmployeeID;
                    objVCR.EntryDate = DateTime.Now.ToString();
                }
                // Get Other all required controls and add its value to respective column
                objVCR.ActiveFlag = "Y";
                objVCR.Origin = txtlocation.Text;
                objVCR.DestCity = txtDestcity.Text;
                if (txtDoorDelyCharge.Text.Trim() != "")
                    objVCR.doordeliveryCharge = txtDoorDelyCharge.Text;
                else
                    objVCR.doordeliveryCharge = "0.00";
                if (txtrate.Text.Trim() != "")
                    objVCR.rate = txtrate.Text;
                else
                    objVCR.rate = "0.00";       
                objVCR.ratetype = cmbratetype.SelectedValue;

                _newList.Add(objVCR);
            }
        }
        ListVSR = _newList;
    }

    private void BindGrid()
    {
        
        ListVSR = VendorContractCrossingController.GetByContractID(ContractCode);
        if (ListVSR.Rows.Count <= 0)
        {
            ListVSR.Add(new MyDataSet.CrossingContractDetRow());
        }
        GV_Route_Matrix.DataSource = ListVSR;
        GV_Route_Matrix.DataBind();
    }
    protected void Submit_Data(object sender, EventArgs e)
    {

    }
}
