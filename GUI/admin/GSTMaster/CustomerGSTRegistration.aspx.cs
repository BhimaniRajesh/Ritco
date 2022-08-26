using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_admin_GSTMaster_CustomerGSTRegistration : BasePage
{
    public string filename = "CustomerGST";
    public string procedure = "Usp_CustomerGST_Upload";
    public List<GSTMasterEntity> lst_GSTMasterEntity
    {
        get { return ViewState["lst_GSTMasterEntity"] != null ? (List<GSTMasterEntity>)ViewState["lst_GSTMasterEntity"] : new List<GSTMasterEntity>(); }
        set { ViewState["lst_GSTMasterEntity"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            using (var oDal = new WebXHelper())
            {
                var oHelper = new FileUploadHelper();
                { dtFormat = oHelper.GetColumnList("CustomerGST"); }

            }

            txtGSTCity.Attributes["onblur"] = "return onValidateCityExist(this,'" + ddlGSTState.ClientID + "');";
            
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (rbEntrytype.SelectedItem.Value == "1")
            {
                var oGSTCustomerMasterEntity = new GSTCustomerMasterEntity();

                oGSTCustomerMasterEntity.CustomerCode = hdnCust.Value;
                oGSTCustomerMasterEntity.Address = txtGSTBillingAddres.Text;

                oGSTCustomerMasterEntity.StateCode = hdnGSTState.Value;
                oGSTCustomerMasterEntity.CityCode = hdnGSTCity.Value;
                oGSTCustomerMasterEntity.CGSTNumber = txtCGSTNumber.Text;
                oGSTCustomerMasterEntity.IGSTNumber = txtIGSTNumber.Text;
                oGSTCustomerMasterEntity.PreferenceType = rbPreferenceType.SelectedItem.Value;
                oGSTCustomerMasterEntity.Preference = ddlBillingPreference.SelectedItem.Value;
                oGSTCustomerMasterEntity.EntryBy = SessionUtilities.CurrentEmployeeID;

                SqlParameter[] prm = {
                                         new SqlParameter("@CustHdrDetail", XmlUtility.XmlSerializeToString(oGSTCustomerMasterEntity))
                                     };

                var oHelper = new FileUploadHelper();
                oHelper.fileUploadControl = fUploader;
                oHelper.dtResultSuccess = dtResultSuccess;
                oHelper.dtResultFail = dtResultFail;
                oHelper.dtFormat = dtFormat;
                oHelper.strFileNamePrefix = filename + "_Upload";
                oHelper.strFilePath = "~/GUI/admin/XLSUploadUtility/TEMP";
                oHelper.strModuleName = "CustomerGST";
                oHelper.strProcedureName = procedure;
                oHelper.Upload(SessionUtilities.CurrentEmployeeID, prm);
                dtResultSuccess = oHelper.dtResultSuccess;
                dtResultFail = oHelper.dtResultFail;
                lblMessage.Text = oHelper.strResultMessage;
                tr_Success.Visible = (dtResultSuccess.Rows.Count > 0);
                tr_Fail.Visible = (dtResultFail.Rows.Count > 0);

                trMain1.Visible = false;
                trMain2.Visible = false;
                trMain3.Visible = true;
                trXLSResult.Visible = true;
            }
            else
            {

                if (IsTokenValid())
                {
                    checkRowData();
                    var oGSTCustomerMasterEntity = new GSTCustomerMasterEntity();

                    oGSTCustomerMasterEntity.CustomerCode = hdnCust.Value;
                    oGSTCustomerMasterEntity.Address = txtGSTBillingAddres.Text;

                    oGSTCustomerMasterEntity.StateCode = hdnGSTState.Value;
                    oGSTCustomerMasterEntity.CityCode = hdnGSTCity.Value;
                    oGSTCustomerMasterEntity.CGSTNumber = txtCGSTNumber.Text;
                    oGSTCustomerMasterEntity.IGSTNumber = txtIGSTNumber.Text;
                    oGSTCustomerMasterEntity.PreferenceType = rbPreferenceType.SelectedItem.Value;
                    oGSTCustomerMasterEntity.Preference = ddlBillingPreference.SelectedItem.Value;

                    lst_GSTMasterEntity = new List<GSTMasterEntity>();
                    lst_GSTMasterEntity.Clear();
                    foreach (RepeaterItem grvDet in rptOrderEntry.Items)
                    {
                        var CmdAddRows = (ImageButton)grvDet.FindControl("CmdAddRows");
                        var CmdDeleteRows = (ImageButton)grvDet.FindControl("CmdDeleteRows");
                        var txtGSTTiNumber = (TextBox)grvDet.FindControl("txtGSTTiNumber");
                        var lblGSTType = (Label)grvDet.FindControl("lblGSTType");
                        //var txtProvisionalNumber = (TextBox)grvDet.FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                        var txtCity = (TextBox)grvDet.FindControl("txtCity");
                        var txtAddress = (TextBox)grvDet.FindControl("txtAddress");
                        var ddlStatetype = (DropDownList)grvDet.FindControl("ddlStatetype");
                        var txtStateUTName = (TextBox)grvDet.FindControl("txtStateUTName");

                        var hdnStateTypeCode = (HiddenField)grvDet.FindControl("hdnStateTypeCode");
                        var hdnStateUTCode = (HiddenField)grvDet.FindControl("hdnStateUTCode");
                        var hdnCityCode = (HiddenField)grvDet.FindControl("hdnCityCode");
                        //var hdnProvisionalNumber = (HiddenField)grvDet.FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                        var hdnGSTTypeCode = (HiddenField)grvDet.FindControl("hdnGSTTypeCode");

                        var TRD = new GSTMasterEntity();

                        if (txtStateUTName.Text != "")
                        {
                            TRD.StateName = txtStateUTName.Text.Trim();
                            TRD.Address = txtAddress.Text.Trim();
                            TRD.City = txtCity.Text.Trim();
                            //TRD.ProvisionalNumber = txtProvisionalNumber.Text;
                            TRD.GSTType = lblGSTType.Text.Trim();
                            TRD.GSTTiNumber = txtGSTTiNumber.Text.Trim();
                            TRD.StateTypeCode = hdnStateTypeCode.Value.Trim();
                            TRD.StateCode = hdnStateUTCode.Value.Trim();
                            TRD.CityCode = hdnCityCode.Value.Trim();
                            TRD.GSTTypeCode = hdnGSTTypeCode.Value.Trim();
                            TRD.EntryDate = DateTime.Now;
                            TRD.EntryBy = SessionUtilities.CurrentEmployeeID;
                            lst_GSTMasterEntity.Add(TRD);
                        }
                    }
                    var ds = new DataSet();
                    //  btnSubmit.Visible = false;
                    oGSTCustomerMasterEntity.ListGSTMasterEntity = lst_GSTMasterEntity;
                    var oGSTMasterController = new GSTMasterController();
                    var dt = oGSTMasterController.InsertCustomerGSTDetail(oGSTCustomerMasterEntity);
                    if ((dt.Rows[0]["Status"]).ToString() == "1")
                    {
                        throw new Exception((dt.Rows[0]["MESSAGE"]).ToString());
                    }
                    ConsumeToken();
                    trMain1.Style["display"] = "none";
                    trMain2.Style["display"] = "none";
                    trMain3.Visible = true;
                }
            }
        }
        catch (Exception Ex)
        {
            hdnValid.Value = "1";
            msgBox.Show(Ex.Message);
        }
    }
    protected void fillData()
    {
        try
        {

            var oGSTMasterController = new GSTMasterController();
            var dt = oGSTMasterController.GetCustomerGSTDetail(hdnCust.Value);

            if (dt.Tables[2].Rows.Count > 0)
            {
                ddlGSTState.DataSource = dt.Tables[2];
                ddlGSTState.DataBind();
                ddlGSTState.Items.Insert(0, new ListItem() { Selected = true, Text = "Select State", Value = "" });
            }

            if (dt.Tables[0].Rows.Count > 0)
            {
                lblCutomerID.Text = Convert.ToString(dt.Tables[0].Rows[0]["CustomerNameID"]);
                hdnGSTState.Value = Convert.ToString(dt.Tables[0].Rows[0]["StateCode"]);
                hdnCust.Value = Convert.ToString(dt.Tables[0].Rows[0]["CUSTCD"]);
                ddlGSTState.SelectedValue = Convert.ToString(dt.Tables[0].Rows[0]["StateCode"]);
                //txtGSTState.Text= Convert.ToString(dt.Tables[0].Rows[0]["StateName"]);
                hdnGSTCity.Value = Convert.ToString(dt.Tables[0].Rows[0]["CityCode"]);
                txtGSTCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["CityName"]);
                txtGSTBillingAddres.Text = Convert.ToString(dt.Tables[0].Rows[0]["Address"]);
                txtCGSTNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["CGSTNumber"]);
                txtIGSTNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["IGSTNumber"]);
                rbPreferenceType.SelectedValue = Convert.ToString(dt.Tables[0].Rows[0]["PrimaryBillingType"]);
                ddlBillingPreference.SelectedValue = Convert.ToString(dt.Tables[0].Rows[0]["PrimaryBillingPreferenceType"]);
            }

            if (dt.Tables[1].Rows.Count > 0)
            {
                var dtDetail = dt.Tables[1];
                BindData(dtDetail);
                BindDataGrid();
            }
            else
            {
                var oGSTMasterEntity = new List<GSTMasterEntity>();
                lst_GSTMasterEntity = oGSTMasterEntity;
                Addrows(1);
                BindDataGrid();
            }

            txtCustomerName.Enabled = false;
            btnSubmitCriteria.Enabled = false;
            //tdCustomerCriteria.Attributes["disabled"] = "disabled";
        }
        catch (Exception Ex)
        {
            msgBox.Show(Ex.Message);
        }

    }
    protected void rptOrderEntry_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int lstCnt = lst_GSTMasterEntity.Count;
        int intRow = rptOrderEntry.Items.Count;
        int p_Srno = (e.Item.ItemIndex == 0 || e.Item.ItemIndex == -1 ? 0 : e.Item.ItemIndex);

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            ImageButton CmdAddRows = (ImageButton)e.Item.FindControl("CmdAddRows");
            ImageButton CmdDeleteRows = (ImageButton)e.Item.FindControl("CmdDeleteRows");
            TextBox txtGSTTiNumber = (TextBox)e.Item.FindControl("txtGSTTiNumber");
            Label lblGSTType = (Label)e.Item.FindControl("lblGSTType");
            //TextBox txtProvisionalNumber = (TextBox)e.Item.FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
            TextBox txtCity = (TextBox)e.Item.FindControl("txtCity");
            TextBox txtAddress = (TextBox)e.Item.FindControl("txtAddress");
            DropDownList ddlStatetype = (DropDownList)e.Item.FindControl("ddlStatetype");
            TextBox txtStateUTName = (TextBox)e.Item.FindControl("txtStateUTName");

            HiddenField hdnStateTypeCode = (HiddenField)e.Item.FindControl("hdnStateTypeCode");
            HiddenField hdnStateUTCode = (HiddenField)e.Item.FindControl("hdnStateUTCode");
            HiddenField hdnCityCode = (HiddenField)e.Item.FindControl("hdnCityCode");
            //HiddenField hdnProvisionalNumber = (HiddenField)e.Item.FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
            HiddenField hdnGSTTypeCode = (HiddenField)e.Item.FindControl("hdnGSTTypeCode");
            txtCity.Attributes["onblur"] = "return onValidateCityExist(this,'" + hdnStateUTCode.ClientID + "');";

            txtGSTTiNumber.Attributes["onblur"] = "return onValidateIGSTNumberExist(this,'CUSTOMER','" + hdnCust.Value + "');";
            //txtProvisionalNumber.Attributes["onblur"] = "return onValidateCGSTNumberExist(this,'CUSTOMER','" + hdnCust.Value + "');";//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.

            ddlStatetype.SelectedValue = hdnStateTypeCode.Value;

            if (lstCnt == e.Item.ItemIndex + 1)
            {
                if (lstCnt > 1)
                {
                    CmdAddRows.Attributes.Add("style", "display:block");
                    CmdDeleteRows.Attributes.Add("style", "display:block");
                }
                else
                {
                    CmdAddRows.Attributes.Add("style", "display:block");
                    CmdDeleteRows.Attributes.Add("style", "display:none");
                }

            }
            else
            {
                CmdAddRows.Attributes.Add("style", "display:none");
                CmdDeleteRows.Attributes.Add("style", "display:block");
            }

        }

    }
    protected void CmdAddRows_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {

    }
    protected void rptOrderEntry_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            int intRow = rptOrderEntry.Items.Count;
            if (e.CommandName == "Add")
            {
                lst_GSTMasterEntity.Clear();
                foreach (RepeaterItem grvDet in rptOrderEntry.Items)
                {
                    var TRD = new GSTMasterEntity();

                    var CmdAddRows = (ImageButton)grvDet.FindControl("CmdAddRows");
                    var CmdDeleteRows = (ImageButton)grvDet.FindControl("CmdDeleteRows");
                    var txtGSTTiNumber = (TextBox)grvDet.FindControl("txtGSTTiNumber");
                    var lblGSTType = (Label)grvDet.FindControl("lblGSTType");
                    //var txtProvisionalNumber = (TextBox)grvDet.FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                    var txtCity = (TextBox)grvDet.FindControl("txtCity");
                    var txtAddress = (TextBox)grvDet.FindControl("txtAddress");
                    var ddlStatetype = (DropDownList)grvDet.FindControl("ddlStatetype");
                    var txtStateUTName = (TextBox)grvDet.FindControl("txtStateUTName");

                    var hdnStateTypeCode = (HiddenField)grvDet.FindControl("hdnStateTypeCode");
                    var hdnStateUTCode = (HiddenField)grvDet.FindControl("hdnStateUTCode");
                    var hdnCityCode = (HiddenField)grvDet.FindControl("hdnCityCode");
                    //var hdnProvisionalNumber = (HiddenField)grvDet.FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                    var hdnGSTTypeCode = (HiddenField)grvDet.FindControl("hdnGSTTypeCode");

                    hdnStateTypeCode.Value = ddlStatetype.SelectedItem.Value;

                    if (intRow >= 1)
                    {
                        CmdAddRows.Attributes.Add("style", "display:none");
                        CmdDeleteRows.Attributes.Add("style", "display:block");
                    }
                    if (Convert.ToInt16(e.CommandArgument) + 1 == e.Item.ItemIndex + 1)
                    {
                        CmdAddRows.Attributes.Add("style", "display:block");
                        CmdDeleteRows.Attributes.Add("style", "display:block");
                    }

                    TRD.StateName = txtStateUTName.Text;
                    TRD.Address = txtAddress.Text;
                    TRD.City = txtCity.Text;
                    //TRD.ProvisionalNumber = txtProvisionalNumber.Text;
                    TRD.GSTType = lblGSTType.Text;
                    TRD.GSTTiNumber = txtGSTTiNumber.Text;

                    TRD.StateTypeCode = hdnStateTypeCode.Value;
                    TRD.StateCode = hdnStateUTCode.Value;
                    TRD.CityCode = hdnCityCode.Value;
                    TRD.GSTTypeCode = hdnGSTTypeCode.Value;

                    lst_GSTMasterEntity.Add(TRD);
                }
                Addrows(1);


            }
            else if (e.CommandName == "Delete")
            {
                int lstCount = lst_GSTMasterEntity.Count;
                if (lstCount > 0)
                {
                    lst_GSTMasterEntity.Clear();
                    foreach (RepeaterItem grvDet in rptOrderEntry.Items)
                    {
                        var TRD = new GSTMasterEntity();

                        var CmdAddRows = (ImageButton)grvDet.FindControl("CmdAddRows");
                        var CmdDeleteRows = (ImageButton)grvDet.FindControl("CmdDeleteRows");
                        var txtGSTTiNumber = (TextBox)grvDet.FindControl("txtGSTTiNumber");
                        var lblGSTType = (Label)grvDet.FindControl("lblGSTType");
                        //var txtProvisionalNumber = (TextBox)grvDet.FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                        var txtCity = (TextBox)grvDet.FindControl("txtCity");
                        var txtAddress = (TextBox)grvDet.FindControl("txtAddress");
                        var ddlStatetype = (DropDownList)grvDet.FindControl("ddlStatetype");
                        var txtStateUTName = (TextBox)grvDet.FindControl("txtStateUTName");

                        var hdnStateTypeCode = (HiddenField)grvDet.FindControl("hdnStateTypeCode");
                        var hdnStateUTCode = (HiddenField)grvDet.FindControl("hdnStateUTCode");
                        var hdnCityCode = (HiddenField)grvDet.FindControl("hdnCityCode");
                        //var hdnProvisionalNumber = (HiddenField)grvDet.FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                        var hdnGSTTypeCode = (HiddenField)grvDet.FindControl("hdnGSTTypeCode");

                        hdnStateTypeCode.Value = ddlStatetype.SelectedItem.Value;

                        if (intRow >= 1)
                        {
                            CmdAddRows.Attributes.Add("style", "display:none");
                            CmdDeleteRows.Attributes.Add("style", "display:block");
                        }
                        if (Convert.ToInt16(e.CommandArgument) + 1 == e.Item.ItemIndex + 1)
                        {
                            CmdAddRows.Attributes.Add("style", "display:block");
                            CmdDeleteRows.Attributes.Add("style", "display:block");
                        }


                        TRD.StateName = txtStateUTName.Text;
                        TRD.Address = txtAddress.Text;
                        TRD.City = txtCity.Text;
                        //TRD.ProvisionalNumber = txtProvisionalNumber.Text;
                        TRD.GSTType = lblGSTType.Text;
                        TRD.GSTTiNumber = txtGSTTiNumber.Text;

                        TRD.StateTypeCode = hdnStateTypeCode.Value;
                        TRD.StateCode = hdnStateUTCode.Value;
                        TRD.CityCode = hdnCityCode.Value;
                        TRD.GSTTypeCode = hdnGSTTypeCode.Value;

                        lst_GSTMasterEntity.Add(TRD);
                    }
                    lst_GSTMasterEntity.RemoveAt(Convert.ToInt32(e.CommandArgument) - 1);
                }
                else
                {
                    throw new Exception("At list one vehicle must be in contract");
                }
            }
            BindDataGrid();
        }
        catch (Exception Ex)
        {
            msgBox.Show(Ex.Message);
        }
    }
    protected void BindData(DataTable ds)
    {
        try
        {
            var oGSTMasterEntity = new List<GSTMasterEntity>();

            if (ds.Rows.Count > 0)
            {
                for (int i = 0; i < ds.Rows.Count; i++)
                {
                    GSTMasterEntity TRD = new GSTMasterEntity();
                    TRD.StateName = Convert.ToString(ds.Rows[i]["StateName"]);
                    TRD.Address = Convert.ToString(ds.Rows[i]["Address"]);
                    TRD.City = Convert.ToString(ds.Rows[i]["City"]);
                    //TRD.ProvisionalNumber = Convert.ToString(ds.Rows[i]["ProvisionalNumber"]);
                    TRD.GSTType = Convert.ToString(ds.Rows[i]["GSTType"]);
                    TRD.GSTTiNumber = Convert.ToString(ds.Rows[i]["GSTTiNumber"]);
                    TRD.StateTypeCode = Convert.ToString(ds.Rows[i]["StateTypeCode"]);
                    TRD.StateCode = Convert.ToString(ds.Rows[i]["StateCode"]);
                    TRD.CityCode = Convert.ToString(ds.Rows[i]["CityCode"]);
                    TRD.GSTTypeCode = Convert.ToString(ds.Rows[i]["GSTTypeCode"]);
                    oGSTMasterEntity.Add(TRD);

                }
            }

            lst_GSTMasterEntity = oGSTMasterEntity;

        }
        catch (Exception Ex)
        {
            msgBox.Show(Ex.Message);

        }
    }
    private void BindDataGrid()
    {
        rptOrderEntry.DataSource = lst_GSTMasterEntity;
        rptOrderEntry.DataBind();
    }
    private void Addrows(int rows)
    {
        int rowIndex = lst_GSTMasterEntity.Count - 1;

        for (var i = 0; i < rows; i++)
        {
            if (rptOrderEntry.Items.Count >= 1)
            {
                ImageButton CmdAddRows = (ImageButton)rptOrderEntry.Items[rowIndex].FindControl("CmdAddRows");
                ImageButton CmdDeleteRows = (ImageButton)rptOrderEntry.Items[rowIndex].FindControl("CmdDeleteRows");
                TextBox txtGSTTiNumber = (TextBox)rptOrderEntry.Items[rowIndex].FindControl("txtGSTTiNumber");
                Label lblGSTType = (Label)rptOrderEntry.Items[rowIndex].FindControl("lblGSTType");
                //TextBox txtProvisionalNumber = (TextBox)rptOrderEntry.Items[rowIndex].FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                TextBox txtCity = (TextBox)rptOrderEntry.Items[rowIndex].FindControl("txtCity");
                TextBox txtAddress = (TextBox)rptOrderEntry.Items[rowIndex].FindControl("txtAddress");
                DropDownList ddlStatetype = (DropDownList)rptOrderEntry.Items[rowIndex].FindControl("ddlStatetype");
                TextBox txtStateUTName = (TextBox)rptOrderEntry.Items[rowIndex].FindControl("txtStateUTName");

                HiddenField hdnStateTypeCode = (HiddenField)rptOrderEntry.Items[rowIndex].FindControl("hdnStateTypeCode");
                HiddenField hdnStateUTCode = (HiddenField)rptOrderEntry.Items[rowIndex].FindControl("hdnStateUTCode");
                HiddenField hdnCityCode = (HiddenField)rptOrderEntry.Items[rowIndex].FindControl("hdnCityCode");
                //HiddenField hdnProvisionalNumber = (HiddenField)rptOrderEntry.Items[rowIndex].FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                HiddenField hdnGSTTypeCode = (HiddenField)rptOrderEntry.Items[rowIndex].FindControl("hdnGSTTypeCode");


                GSTMasterEntity TRD = new GSTMasterEntity();

                TRD.StateName = string.Empty;
                TRD.Address = string.Empty;
                TRD.City = string.Empty;
                //TRD.ProvisionalNumber = string.Empty;
                TRD.GSTType = string.Empty;
                TRD.GSTTiNumber = string.Empty;
                TRD.StateTypeCode = string.Empty;
                TRD.StateCode = string.Empty;
                TRD.CityCode = string.Empty;
                TRD.GSTTypeCode = string.Empty;

                lst_GSTMasterEntity.Add(TRD);
            }
            else
            {
                GSTMasterEntity TRD = new GSTMasterEntity();
                TRD.StateName = string.Empty;
                TRD.Address = string.Empty;
                TRD.City = string.Empty;
                //TRD.ProvisionalNumber = string.Empty;
                TRD.GSTType = string.Empty;
                TRD.GSTTiNumber = string.Empty;
                TRD.StateTypeCode = string.Empty;
                TRD.StateCode = string.Empty;
                TRD.CityCode = string.Empty;
                TRD.GSTTypeCode = string.Empty;
                lst_GSTMasterEntity.Add(TRD);
            }

        }
    }
    /// <summary>
    /// Get List For Customer List
    /// </summary>
    /// <param name="customerCode"></param>
    /// <returns></returns>
    //[WebMethod]
    //public static string CheckCustomerCode(string customerCode)
    //{
    //    var oGSTMasterController = new GSTMasterController();
    //    var dtResult = oGSTMasterController.ValidateCustomer(customerCode);
    //    return jsonUtility.DataTableToJSON(dtResult);
    //}
    protected void btnSubmitCriteria_Click(object sender, EventArgs e)
    {
        fillData();
    }
    protected void checkRowData()
    {
        //List<CCMFixedCost> objCCMFixedCost = new List<CCMFixedCost>;

        //objCCMFixedCost.Clear();
        lst_GSTMasterEntity = new List<GSTMasterEntity>();

        lst_GSTMasterEntity.Clear();
        foreach (RepeaterItem grvDet in rptOrderEntry.Items)
        {
            var TRD = new GSTMasterEntity();

            var CmdAddRows = (ImageButton)grvDet.FindControl("CmdAddRows");
            var CmdDeleteRows = (ImageButton)grvDet.FindControl("CmdDeleteRows");
            var txtGSTTiNumber = (TextBox)grvDet.FindControl("txtGSTTiNumber");
            var lblGSTType = (Label)grvDet.FindControl("lblGSTType");
            //var txtProvisionalNumber = (TextBox)grvDet.FindControl("txtProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
            var txtCity = (TextBox)grvDet.FindControl("txtCity");
            var txtAddress = (TextBox)grvDet.FindControl("txtAddress");
            var ddlStatetype = (DropDownList)grvDet.FindControl("ddlStatetype");
            var txtStateUTName = (TextBox)grvDet.FindControl("txtStateUTName");

            var hdnStateTypeCode = (HiddenField)grvDet.FindControl("hdnStateTypeCode");
            var hdnStateUTCode = (HiddenField)grvDet.FindControl("hdnStateUTCode");
            var hdnCityCode = (HiddenField)grvDet.FindControl("hdnCityCode");
            //var hdnProvisionalNumber = (HiddenField)grvDet.FindControl("hdnProvisionalNumber");//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
            var hdnGSTTypeCode = (HiddenField)grvDet.FindControl("hdnGSTTypeCode");

            hdnStateTypeCode.Value = ddlStatetype.SelectedItem.Value;

            TRD.StateName = txtStateUTName.Text;
            TRD.Address = txtAddress.Text;
            TRD.City = txtCity.Text;
            //TRD.ProvisionalNumber = txtProvisionalNumber.Text;
            TRD.GSTType = lblGSTType.Text;
            TRD.GSTTiNumber = txtGSTTiNumber.Text;

            TRD.StateTypeCode = hdnStateTypeCode.Value;
            TRD.StateCode = hdnStateUTCode.Value;
            TRD.CityCode = hdnCityCode.Value;
            TRD.GSTTypeCode = hdnGSTTypeCode.Value;

            lst_GSTMasterEntity.Add(TRD);
        }


        for (int i = 0; i < lst_GSTMasterEntity.Count; i++)
        {
            GSTMasterEntity ts = lst_GSTMasterEntity[i];
            for (int j = 0; j < i; j++)
            {
                GSTMasterEntity preObj = lst_GSTMasterEntity[j];
                if (ts.StateCode == preObj.StateCode
                    // || ts.ProvisionalNumber == preObj.ProvisionalNumber  //commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
                    // || ts.GSTTiNumber == preObj.GSTTiNumber  //commented on 05-jul-2017, to allow duplicate Provisional / GSTIN Number.
                    )
                {
                    throw new Exception("Error at SrNo " + (i + 1).ToString() + ": Data already entered at SrNo " + (j + 1).ToString());
                }
            }
        }
    }


    public DataTable dtResultSuccess
    {
        get { return (ViewState["dtResultSuccess"] != null) ? ViewState["dtResultSuccess"] as DataTable : new DataTable(); }
        set { ViewState["dtResultSuccess"] = value; }
    }
    public DataTable dtResultFail
    {
        get { return (ViewState["dtResultFail"] != null) ? ViewState["dtResultFail"] as DataTable : new DataTable(); }
        set { ViewState["dtResultFail"] = value; }
    }

    public DataTable dtFormat
    {
        get { return (ViewState["dtFormat"] != null) ? ViewState["dtFormat"] as DataTable : new DataTable(); }
        set { ViewState["dtFormat"] = value; }
    }


    protected void lnkFormat_Click(object sender, EventArgs e)
    {

        Response.Redirect("CustomerGSTUploadFormat.xls", false);
    }

    protected void lnkResultSuccess_Click(object sender, EventArgs e)
    {
        ExcelUtils.ToExcel(dtResultSuccess, filename + "_Upload_Result_Success.xls", Response);
    }

    protected void lnkResultFail_Click(object sender, EventArgs e)
    {
        ExcelUtils.ToExcel(dtResultFail, filename + "_Upload_Result_Fail.xls", Response);
    }
}