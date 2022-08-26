using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Fleet_PMContract : System.Web.UI.Page
{
    public static DataTable dtContractRule = new DataTable();
    public static DataTable dtHourlyBasedData = new DataTable();
    public static string str_Category;
    ds_Tripsheet.webx_Fleet_Contract_PeopleDataTable dt_PM_Contract = new ds_Tripsheet.webx_Fleet_Contract_PeopleDataTable();

    public void BindGrid()
    {
        gv_People_Contract.DataSource = dt_PM_Contract;
        gv_People_Contract.DataBind();
    }
    private void FillDataWhenEdit(string str_Customer_Code, string str_Contract_Code)
    {
        DataTable dt = new DataTable();
        Secondary_Contract objSecondaryContract = new Secondary_Contract(Session["SqlProvider"].ToString());

        dt = objSecondaryContract.GetDataTable("Select cp.* "
            + ",(Select Type_Name from webx_Vehicle_Type Where Type_Code=cp.Vehicle_Type) as Type_Name "
            + ",(Select CodeDesc from webx_master_General where CodeType='TSCAT' And StatusCode='Y' And CodeId = cp.Category_Id) As TsCategory"
            + ",(Select CodeDesc from webx_master_General where CodeType='TSDUR' And StatusCode='Y' And CodeId = cp.Duration_Id) As Duration"
            + ",(Select CodeDesc from webx_master_General where CodeType='PKDRP' And StatusCode='Y' And CodeId = cp.PickDrop_Id) As PickDropDesc"
            + ",(Select CodeDesc from webx_master_General where CodeType='FLTCAT' And StatusCode='Y' And CodeId = cp.Veh_Category_Id) As VehCategory"
            + " From Webx_Fleet_Contract_People as cp Where Contract_Code= '" + str_Contract_Code + "'");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow(
                dt.Rows[i]["Type_Name"].ToString(),
                dt.Rows[i]["Category_Id"].ToString(),
                dt.Rows[i]["From_Area"].ToString(),
                dt.Rows[i]["To_Area"].ToString(),
                dt.Rows[i]["PickDrop_Id"].ToString(),
                dt.Rows[i]["Duration_Id"].ToString(),
                dt.Rows[i]["Minimum_Head"].ToString(),
                dt.Rows[i]["Outstanding_Charge"].ToString(),
                dt.Rows[i]["Non_Working_Charge"].ToString(),
                dt.Rows[i]["Veh_Category_Id"].ToString(),
                dt.Rows[i]["Fixed_KM"].ToString(),
                dt.Rows[i]["Variable_KM"].ToString(),
                dt.Rows[i]["Fixed_Hour"].ToString(),
                dt.Rows[i]["Variable_Hour"].ToString(),
                dt.Rows[i]["Rate"].ToString(),
                dt.Rows[i]["No_of_Vehicle"].ToString(),
                dt.Rows[i]["No_of_Days"].ToString(),
                dt.Rows[i]["ID"].ToString(),
                dt.Rows[i]["RUTCD"].ToString(),
                dt.Rows[i]["RUTKM"].ToString(),
                dt.Rows[i]["Deployment_St_Time"].ToString(),
                dt.Rows[i]["Deployment_End_Time"].ToString()
            );
        }
        BindGrid();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            VisibleColumns();

            //People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());
            //dtContractRule = objPeopleContract.GetDataTable("Select *From [Webx_Fleet_People_Contract_Hdr] Where [Contract_Code] ='" + Request.QueryString["Contract_Code"].ToString() + "'");
            //dtHourlyBasedData = objPeopleContract.GetDataTable("Select *From [Webx_Fleet_Hourly_Based_Slot] Where [Contract_Code]= '" + Request.QueryString["Contract_Code"].ToString() + "'");
            //FillHeaderDetails();
            if (Request.QueryString["Customer_Code"] != null && Request.QueryString["Contract_Code"] != null)
            {
                FillDataWhenEdit(Request.QueryString["Customer_Code"].ToString(), Request.QueryString["Contract_Code"].ToString());
            }
            //tb_Vehicle_No.Attributes.Add("OnBlur", "javascript:CheckVehicleNumber(" + e.Row.RowIndex + ",this," + lbl_Vehicle_No_Err.ClientID.ToString().Trim() + ");");
            dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
            Web.Controls.CScriptVariables oScript = new Web.Controls.CScriptVariables(this, "ScriptVar");
            oScript.AddClientIds(this, true);
        }
    }
    protected void gv_People_Contract_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddl_Category = (DropDownList)e.Row.FindControl("ddl_Category");
            DropDownList ddl_Duration = (DropDownList)e.Row.FindControl("ddl_Duration");
            DropDownList ddl_PickupDrop = (DropDownList)e.Row.FindControl("ddl_PickupDrop");
            DropDownList ddl_Vehicle_Category = (DropDownList)e.Row.FindControl("ddl_Vehicle_Category");
            DropDownList ddl_Route = (DropDownList)e.Row.FindControl("ddl_Route");

            TextBox tb_Vehicle_Type = (TextBox)e.Row.FindControl("tb_Vehicle_Type");
            TextBox tb_From_City = (TextBox)e.Row.FindControl("tb_From_City");
            TextBox tb_To_City = (TextBox)e.Row.FindControl("tb_To_City");
            TextBox tb_Minimum_Head = (TextBox)e.Row.FindControl("tb_Minimum_Head");
            TextBox tb_Outstanding_Charge = (TextBox)e.Row.FindControl("tb_Outstanding_Charge");
            TextBox tb_Non_Working_Charge = (TextBox)e.Row.FindControl("tb_Non_Working_Charge");
            TextBox tb_Fixed_Km = (TextBox)e.Row.FindControl("tb_Fixed_Km");
            TextBox tb_Variable_Km = (TextBox)e.Row.FindControl("tb_Variable_Km");
            TextBox tb_Fixed_Hour = (TextBox)e.Row.FindControl("tb_Fixed_Hour");
            TextBox tb_Variable_Hour = (TextBox)e.Row.FindControl("tb_Variable_Hour");
            TextBox tb_Cost = (TextBox)e.Row.FindControl("tb_Cost");
            TextBox tb_No_Veh = (TextBox)e.Row.FindControl("tb_No_Veh");
            TextBox tb_No_Days = (TextBox)e.Row.FindControl("tb_No_Days");
            TextBox tb_RUTKM = (TextBox)e.Row.FindControl("tb_RUTKM");
            TextBox tb_Deployment_StTime = (TextBox)e.Row.FindControl("tb_Deployment_StTime");
            TextBox tb_Deployment_EndTime = (TextBox)e.Row.FindControl("tb_Deployment_EndTime");

            Label lbl_Err_FromCity = (Label)e.Row.FindControl("lbl_Err_FromCity");
            Label lbl_Err_ToCity = (Label)e.Row.FindControl("lbl_Err_ToCity");
            Label lbl_Err_Vehicle_Type = (Label)e.Row.FindControl("lbl_Err_Vehicle_Type");


            People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());
            objPeopleContract.BindDropDown(ddl_Category, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='TSCAT' And StatusCode='Y'");
            objPeopleContract.BindDropDown(ddl_Duration, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='TSDUR' And StatusCode='Y'");
            objPeopleContract.BindDropDown(ddl_PickupDrop, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='PKDRP' And StatusCode='Y'");
            objPeopleContract.BindDropDown(ddl_Vehicle_Category, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='FLTCAT' And StatusCode='Y'");
            objPeopleContract.BindDropDown(ddl_Route, "Select RUTCD,RUTDESC From [webx_trip_rutmas] Where ActiveFlag='Y'");

            if (dt_PM_Contract.Count > 0)
            {
                ddl_Category.SelectedValue = dt_PM_Contract[e.Row.RowIndex]["Category_Id"].ToString().Trim();
                ddl_Duration.SelectedValue = dt_PM_Contract[e.Row.RowIndex]["Duration_Id"].ToString().Trim();
                ddl_PickupDrop.SelectedValue = dt_PM_Contract[e.Row.RowIndex]["PickDrop_Id"].ToString().Trim();
                ddl_Vehicle_Category.SelectedValue = dt_PM_Contract[e.Row.RowIndex]["Veh_Category_Id"].ToString().Trim();
                ddl_Route.SelectedValue = dt_PM_Contract[e.Row.RowIndex]["RUTCD"].ToString().Trim();
            }

            tb_Vehicle_Type.Attributes.Add("OnBlur", "javascript:CheckVehicleType(" + e.Row.RowIndex + ",this," + lbl_Err_Vehicle_Type.ClientID.ToString().Trim() + ");");

            //tb_From_City.Attributes.Add("onblur", "javascript:checkCity(this," + lbl_Err_FromCity.ClientID + ");");
            //tb_To_City.Attributes.Add("onblur", "javascript:checkCity(this," + lbl_Err_ToCity.ClientID + ");");

            ddl_Route.Attributes.Add("OnChange", "javascript:OnChangeRoute(" + e.Row.RowIndex + ",this);");

            //ddl_Hourly_Based_Slot.Attributes.Add("OnChange", "javascript:CheckHourlyBasedFTL(" + e.Row.RowIndex + ");");
            //ddl_Category.Attributes.Add("OnChange", "javascript:CheckCategory(" + e.Row.RowIndex + ");");

            //tb_From_Km.Attributes.Add("OnBlur", "javascript:CheckFromKM(" + e.Row.RowIndex + ");");
            //tb_To_Km.Attributes.Add("OnBlur", "javascript:CheckToKM(" + e.Row.RowIndex + ");");
        }
    }
    public void VisibleColumns()
    {
        if (Request.QueryString["Contract_Type"] != null)
        {
            if (Request.QueryString["Contract_Type"].ToString() == "01")
            {
                gv_People_Contract.Columns[2].Visible = true;
            }
            else if (Request.QueryString["Contract_Type"].ToString() == "02")
            {
                gv_People_Contract.Columns[3].Visible = true;
                gv_People_Contract.Columns[4].Visible = true;
                gv_People_Contract.Columns[6].Visible = true;
            }
            else if (Request.QueryString["Contract_Type"].ToString() == "03")
            {
                gv_People_Contract.Columns[3].Visible = true;
                gv_People_Contract.Columns[4].Visible = true;
                gv_People_Contract.Columns[6].Visible = true;
                gv_People_Contract.Columns[7].Visible = true;
            }
        }
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_PM_Contract.Clear();

        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        foreach (GridViewRow gvr in gv_People_Contract.Rows)
        {
            dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow(
                ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text,
                ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue,
                "",//((TextBox)gvr.FindControl("tb_From_City")).Text,
                "",//((TextBox)gvr.FindControl("tb_To_City")).Text,
                ((DropDownList)gvr.FindControl("ddl_PickupDrop")).SelectedValue,
                ((DropDownList)gvr.FindControl("ddl_Duration")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_Minimum_Head")).Text,
                ((TextBox)gvr.FindControl("tb_Outstanding_Charge")).Text,
                ((TextBox)gvr.FindControl("tb_Non_Working_Charge")).Text,
                ((DropDownList)gvr.FindControl("ddl_Vehicle_Category")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_Fixed_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Fixed_Hour")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Hour")).Text,
                ((TextBox)gvr.FindControl("tb_Cost")).Text,
                ((TextBox)gvr.FindControl("tb_No_Veh")).Text,
                ((TextBox)gvr.FindControl("tb_No_Days")).Text,
                ((HiddenField)gvr.FindControl("hf_Contract_Code")).Value,
                ((DropDownList)gvr.FindControl("ddl_Route")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_RUTKM")).Text,
                ((TextBox)gvr.FindControl("tb_Deployment_StTime")).Text,
                ((TextBox)gvr.FindControl("tb_Deployment_EndTime")).Text
            );
        }


        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void gv_People_Contract_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        dt_PM_Contract.Clear();

        foreach (GridViewRow gvr in gv_People_Contract.Rows)
        {
            dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow(
                ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text,
                ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue,
                "",//((TextBox)gvr.FindControl("tb_From_City")).Text,
                "",//((TextBox)gvr.FindControl("tb_To_City")).Text,
                ((DropDownList)gvr.FindControl("ddl_PickupDrop")).SelectedValue,
                ((DropDownList)gvr.FindControl("ddl_Duration")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_Minimum_Head")).Text,
                ((TextBox)gvr.FindControl("tb_Outstanding_Charge")).Text,
                ((TextBox)gvr.FindControl("tb_Non_Working_Charge")).Text,
                ((DropDownList)gvr.FindControl("ddl_Vehicle_Category")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_Fixed_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Fixed_Hour")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Hour")).Text,
                ((TextBox)gvr.FindControl("tb_Cost")).Text,
                ((TextBox)gvr.FindControl("tb_No_Veh")).Text,
                ((TextBox)gvr.FindControl("tb_No_Days")).Text,
                ((HiddenField)gvr.FindControl("hf_Contract_Code")).Value,
                ((DropDownList)gvr.FindControl("ddl_Route")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_RUTKM")).Text,
                ((TextBox)gvr.FindControl("tb_Deployment_StTime")).Text,
                ((TextBox)gvr.FindControl("tb_Deployment_EndTime")).Text
            );
        }

            //if (gvr.RowIndex == e.RowIndex)
            //{
            //    if (((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value != "")
            //    {
            //        People_Contract objPeopleContract = new People_Contract(Convert.ToString(Session["SqlProvider"]));
            //        objPeopleContract.ExecureQry("Delete From [Webx_Fleet_People_Contract_Det] Where Contract_Det_Code = '" + ((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value + "'");
            //    }
            //}

        dt_PM_Contract.Rows[e.RowIndex].Delete();
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_PM_Contract.Addwebx_Fleet_Contract_PeopleRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());
        bool IsCommitted = false;

        objPeopleContract.BeginTransaction();

        try
        {
            foreach (GridViewRow gvr in gv_People_Contract.Rows)
            {
                //objPeopleContract.Contract_Code = Request.QueryString["Contract_Code"].ToString();
                objPeopleContract.Customer_Code = Request.QueryString["Customer_Code"].ToString();
                objPeopleContract.Contract_Type_Id = Request.QueryString["Contract_Type"].ToString();
                objPeopleContract.Vehicle_Type = ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text;
                objPeopleContract.Category_Id = ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue;
                //objPeopleContract.From_Area = ((TextBox)gvr.FindControl("tb_From_City")).Text;
                //objPeopleContract.To_Area = ((TextBox)gvr.FindControl("tb_To_City")).Text;
                objPeopleContract.PickDrop_Id = ((DropDownList)gvr.FindControl("ddl_PickupDrop")).SelectedValue;
                objPeopleContract.Duration_Id = ((DropDownList)gvr.FindControl("ddl_Duration")).SelectedValue;
                objPeopleContract.Outstanding_Charge = Convert.ToDouble(((TextBox)gvr.FindControl("tb_Outstanding_Charge")).Text);
                objPeopleContract.Non_Working_Charge =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Non_Working_Charge")).Text);
                objPeopleContract.Veh_Category_Id = ((DropDownList)gvr.FindControl("ddl_Vehicle_Category")).SelectedValue;
                objPeopleContract.Fixed_KM =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Fixed_Km")).Text);
                objPeopleContract.Variable_KM =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Variable_Km")).Text);
                objPeopleContract.Fixed_Hour =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Fixed_Hour")).Text);
                objPeopleContract.Variable_Hour =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Variable_Hour")).Text);

                objPeopleContract.Rate =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_Cost")).Text);
                objPeopleContract.No_of_Vehicle =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_No_Veh")).Text);
                objPeopleContract.No_of_Days =  Convert.ToDouble(((TextBox)gvr.FindControl("tb_No_Days")).Text);

                objPeopleContract.RUTCD = ((DropDownList)gvr.FindControl("ddl_Route")).Text;
                objPeopleContract.RUTKM = ((TextBox)gvr.FindControl("tb_RUTKM")).Text;
                objPeopleContract.Deployment_St_Time = ((TextBox)gvr.FindControl("tb_Deployment_StTime")).Text;
                objPeopleContract.Deployment_End_Time = ((TextBox)gvr.FindControl("tb_Deployment_EndTime")).Text;

                HiddenField hf_Contract_Code = (HiddenField)gvr.FindControl("hf_Contract_Code");
                if (Request.QueryString["Customer_Code"] != null && Request.QueryString["Contract_Code"] != "New")
                {
                    objPeopleContract.Contract_Code = Request.QueryString["Contract_Code"].ToString();
                    objPeopleContract.Customer_Code = Request.QueryString["Customer_Code"].ToString();
                    if (hf_Contract_Code.Value != "")
                    {
                        objPeopleContract.Contract_Code = hf_Contract_Code.Value; 
                        objPeopleContract.UpdatePMContract();
                    }
                    else
                    {
                        objPeopleContract.Contract_Code = Request.QueryString["Contract_Code"].ToString();
                        objPeopleContract.InsertPMContractWithID();
                    }
                }
                else
                {
                    objPeopleContract.InsertPMContract();
                }
            }
            IsCommitted = objPeopleContract.CommitTransaction();
        }
        catch (Exception e1)
        {
            objPeopleContract.RollBackTransaction();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
        }

        if (IsCommitted)
        {
            if (Request.QueryString["Customer_Code"] != null && Request.QueryString["Contract_Code"] != "New")
            {
                Response.Redirect("People_Contract_Result.aspx?Contract_Code=" + Request.QueryString["Contract_Code"].ToString() + "&Customer_Code=" + Request.QueryString["Customer_Code"].ToString() + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString());
            }
            else
            {
                Response.Redirect("People_Contract_Result.aspx?Contract_Code=" + objPeopleContract.Contract_Code + "&Customer_Code=" + Request.QueryString["Customer_Code"].ToString() + "&Contract_Type=" + Request.QueryString["Contract_Type"].ToString());
            }
        }
    }
}
