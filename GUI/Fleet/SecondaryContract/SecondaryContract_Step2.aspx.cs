using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Fleet_SecondaryContract_SecondaryContract_Step2 : System.Web.UI.Page
{
    public static DataTable dtContractRule = new DataTable();
    public static DataTable dtHourlyBasedData = new DataTable();
    public static string str_Category;
    ds_Secondary_Contract.Webx_Fleet_Secondary_Contract_DetDataTable dt_Secondary_Contract = new ds_Secondary_Contract.Webx_Fleet_Secondary_Contract_DetDataTable();

    public void BindGrid()
    {
        gv_Secondary_Contract.DataSource = dt_Secondary_Contract;
        gv_Secondary_Contract.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            //ViewState.Add("mode", "0");

            Secondary_Contract objSecondaryContract = new Secondary_Contract(Session["SqlProvider"].ToString());
            dtContractRule = objSecondaryContract.GetDataTable("Select *From [Webx_Fleet_Secondary_Contract_Hdr] Where [Contract_Code] ='" + Request.QueryString["Contract_Code"].ToString() + "'");
            dtHourlyBasedData = objSecondaryContract.GetDataTable("Select *From [Webx_Fleet_Hourly_Based_Slot] Where [Contract_Code]= '" + Request.QueryString["Contract_Code"].ToString() + "'");
            FillHeaderDetails();
            if (Request.QueryString["Customer_Code"] != null && Request.QueryString["Contract_Code"] != null)
            {
                FillDataWhenEdit(Request.QueryString["Customer_Code"].ToString(), Request.QueryString["Contract_Code"].ToString());
                VisibleColumns();
            }
            //tb_Vehicle_No.Attributes.Add("OnBlur", "javascript:CheckVehicleNumber(" + e.Row.RowIndex + ",this," + lbl_Vehicle_No_Err.ClientID.ToString().Trim() + ");");

        }
    }
    private void FillDataWhenEdit(string str_Customer_Code, string str_Contract_Code)
    {
        DataTable dt = new DataTable();
        Secondary_Contract objSecondaryContract = new Secondary_Contract(Session["SqlProvider"].ToString());

        dt = objSecondaryContract.GetDataTable("select (select LocName from webx_location where loccode=Webx_Fleet_Secondary_Contract_Det.LocCode) as LocName,Contract_Det_Code,Vehicle_No,(Select CodeDesc from webx_master_general where codetype='FTLTYP' And StatusCode='Y' And CodeId=Vehicle_Type_Code)  as Vehicle_Type_Code,Category,HourlyBasedSlot_Id,From_KM,To_KM,Fixed_Cost,Variable_Cost,Fixed_Cost_KM from Webx_Fleet_Secondary_Contract_Det  Where Contract_Code= '" + str_Contract_Code + "'");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dt_Secondary_Contract.AddWebx_Fleet_Secondary_Contract_DetRow(
                dt.Rows[i]["Vehicle_No"].ToString(),
                dt.Rows[i]["Vehicle_Type_Code"].ToString(),
                dt.Rows[i]["Category"].ToString(),
                dt.Rows[i]["HourlyBasedSlot_Id"].ToString(),
                dt.Rows[i]["From_KM"].ToString(),
                dt.Rows[i]["To_KM"].ToString(),
                dt.Rows[i]["Fixed_Cost"].ToString(),
                dt.Rows[i]["Variable_Cost"].ToString(),
                dt.Rows[i]["Fixed_Cost_KM"].ToString(),
                dt.Rows[i]["Contract_Det_Code"].ToString(),
                dt.Rows[i]["LocName"].ToString()
            );
        }
        BindGrid();
    }
    protected void gv_Secondary_Contract_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddl_Category = (DropDownList)e.Row.FindControl("ddl_Category");
            DropDownList ddl_Hourly_Based_Slot = (DropDownList)e.Row.FindControl("ddl_Hourly_Based_Slot");
            DropDownList ddl_Fixed_Cost_Km = (DropDownList)e.Row.FindControl("ddl_Fixed_Cost_Km");

            TextBox tb_Location = (TextBox)e.Row.FindControl("tb_Location");
            TextBox tb_Vehicle_No = (TextBox)e.Row.FindControl("tb_Vehicle_No");
            TextBox tb_Vehicle_Type = (TextBox)e.Row.FindControl("tb_Vehicle_Type");

            TextBox tb_To_Km = (TextBox)e.Row.FindControl("tb_To_Km");
            TextBox tb_From_Km = (TextBox)e.Row.FindControl("tb_From_Km");

            Label lbl_Location_Err = (Label)e.Row.FindControl("lbl_Location_Err");
            Label lbl_Vehicle_No_Err = (Label)e.Row.FindControl("lbl_Vehicle_No_Err");
            Label lbl_Vehicle_Type_Err = (Label)e.Row.FindControl("lbl_Vehicle_Type_Err");

            Secondary_Contract objSecondaryContract = new Secondary_Contract(Session["SqlProvider"].ToString());
            objSecondaryContract.BindDropDown(ddl_Category, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='FLTCAT' And StatusCode='Y' And CodeId In (Select Items From dbo.Split('" + str_Category + "',','))");
            objSecondaryContract.BindDropDown(ddl_Hourly_Based_Slot, "Select Id,HourlyBasedSlot From [Webx_Fleet_Hourly_Based_Slot] Where Contract_Code='" + Request.QueryString["Contract_Code"].ToString() + "'");
            objSecondaryContract.BindDropDown(ddl_Fixed_Cost_Km, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='COSTBASED' And StatusCode='Y'");

            if (dt_Secondary_Contract.Count > 0)
            {
                ddl_Category.SelectedValue = dt_Secondary_Contract[e.Row.RowIndex]["Category"].ToString().Trim();
                ddl_Hourly_Based_Slot.SelectedValue = dt_Secondary_Contract[e.Row.RowIndex]["HourlyBasedSlot_Id"].ToString().Trim();
                ddl_Fixed_Cost_Km.SelectedValue = dt_Secondary_Contract[e.Row.RowIndex]["Fixed_Cost_KM"].ToString().Trim();
            }
            tb_Location.Attributes.Add("OnBlur", "javascript:CheckLocation(" + e.Row.RowIndex + ",this," + lbl_Location_Err.ClientID.ToString().Trim() + ");");

            tb_Vehicle_No.Attributes.Add("OnBlur", "javascript:CheckVehicleNumber(" + e.Row.RowIndex + ",this," + lbl_Vehicle_No_Err.ClientID.ToString().Trim() + ");");
            tb_Vehicle_Type.Attributes.Add("OnBlur", "javascript:CheckVehicleType(" + e.Row.RowIndex + ",this," + lbl_Vehicle_Type_Err.ClientID.ToString().Trim() + ");");

            ddl_Hourly_Based_Slot.Attributes.Add("OnChange", "javascript:CheckHourlyBasedFTL(" + e.Row.RowIndex + ");");
            ddl_Category.Attributes.Add("OnChange", "javascript:CheckCategory(" + e.Row.RowIndex + ");");

            tb_From_Km.Attributes.Add("OnBlur", "javascript:CheckFromKM(" + e.Row.RowIndex + ");");
            tb_To_Km.Attributes.Add("OnBlur", "javascript:CheckToKM(" + e.Row.RowIndex + ");");
        }
    }

    public void FillHeaderDetails()
    {
        if (dtContractRule.Rows.Count > 0)
        {
            if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "FTL") { lbl_Contract_Based_On.Text = "FTL Type"; }
            if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "Vehicle") { lbl_Contract_Based_On.Text = "Vehicle Type"; }

            if (dtContractRule.Rows[0]["AC"].ToString() == "Yes") { lbl_AC_status.Text = "AC"; str_Category="1";}
            if (dtContractRule.Rows[0]["Non_AC"].ToString() == "Yes") { lbl_AC_status.Text = lbl_AC_status.Text + " & Non-AC"; str_Category += ",2"; }
            if (dtContractRule.Rows[0]["Empty"].ToString() == "Yes") { lbl_AC_status.Text = lbl_AC_status.Text + " & Empty"; str_Category += ",3"; }

            if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Hourly") { lbl_Rate_Based_On.Text = "Hourly Based"; }
            if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Fixed") { lbl_Rate_Based_On.Text = "Fixed"; }

            if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "KM") { lbl_Fiexed_Cost_Based_On.Text = "Per KM"; }
            if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "KG") { lbl_Fiexed_Cost_Based_On.Text = "Per KG"; }
            if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "PKG") { lbl_Fiexed_Cost_Based_On.Text = "Per Package"; }

            if (dtContractRule.Rows[0]["Fixed_Cost_Rate"].ToString() == "Yes")
            {

            }

            if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "NonMatrix") { lbl_Fiexed_Cost_Based_On.Text = "Non-Matrix"; }
            else if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "Matrix") { lbl_Fiexed_Cost_Based_On.Text = "Matrix"; }

            if (dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "NonMatrix") { lbl_Variable_Cost_Based_On.Text = "Non-Matrix"; }
            else if (dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "Matrix") { lbl_Variable_Cost_Based_On.Text = "Matrix"; }

            if (dtContractRule.Rows[0]["Standard_Charge_Applicable"].ToString() == "Yes") { lbl_Standard_Charge_Applcable.Text = "Yes"; }

        }
    }

    public void VisibleColumns()
    {
        if (dtContractRule.Rows.Count > 0)
        {
            if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "FTL") { gv_Secondary_Contract.Columns[3].Visible = true; gv_Secondary_Contract.Columns[2].Visible = false; }
            if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "Vehicle") { gv_Secondary_Contract.Columns[3].Visible = false; gv_Secondary_Contract.Columns[2].Visible = true; }

            if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Hourly")
            {
                gv_Secondary_Contract.Columns[5].Visible = true;
            }
            else if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Fixed")
            {
                gv_Secondary_Contract.Columns[5].Visible = false;
            }

            if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "NonMatrix" && dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "NonMatrix")
            {
                gv_Secondary_Contract.Columns[6].Visible = false;
                gv_Secondary_Contract.Columns[7].Visible = false;
                gv_Secondary_Contract.Columns[10].Visible = false;


            }

            //if (dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "NonMatrix")
            //{
            //    if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Hourly")
            //    {
            //        gv_Secondary_Contract.Columns[4].Visible = true;

            //    }
            //    else if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Fixed")
            //    {
            //        gv_Secondary_Contract.Columns[4].Visible = false;
            //    }
            //}


            //if (dtContractRule.Rows[0]["Fixed_Cost_Rate"].ToString() == "Yes")
            //{

            //}

            if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "Matrix" && dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "Matrix")
            {
                gv_Secondary_Contract.Columns[6].Visible = true;
                gv_Secondary_Contract.Columns[7].Visible = true;
                gv_Secondary_Contract.Columns[10].Visible = true;
            }

        }
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_Secondary_Contract.Clear();

        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        foreach (GridViewRow gvr in gv_Secondary_Contract.Rows)
        {
            dt_Secondary_Contract.AddWebx_Fleet_Secondary_Contract_DetRow(
                ((TextBox)gvr.FindControl("tb_Vehicle_No")).Text,
                ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text,
                ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue,
                ((DropDownList)gvr.FindControl("ddl_Hourly_Based_Slot")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_From_Km")).Text,
                ((TextBox)gvr.FindControl("tb_To_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Fixed_Cost")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Cost")).Text,
                ((DropDownList)gvr.FindControl("ddl_Fixed_Cost_Km")).SelectedValue,
                ((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value,
                ((TextBox)gvr.FindControl("tb_Location")).Text
            );
        }

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Secondary_Contract.AddWebx_Fleet_Secondary_Contract_DetRow("", "", "", "", "", "", "", "", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
        VisibleColumns();
    }
    protected void gv_Secondary_Contract_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        dt_Secondary_Contract.Clear();

        foreach (GridViewRow gvr in gv_Secondary_Contract.Rows)
        {
            dt_Secondary_Contract.AddWebx_Fleet_Secondary_Contract_DetRow(
                ((TextBox)gvr.FindControl("tb_Vehicle_No")).Text,
                ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text,
                ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue,
                ((DropDownList)gvr.FindControl("ddl_Hourly_Based_Slot")).SelectedValue,
                ((TextBox)gvr.FindControl("tb_From_Km")).Text,
                ((TextBox)gvr.FindControl("tb_To_Km")).Text,
                ((TextBox)gvr.FindControl("tb_Fixed_Cost")).Text,
                ((TextBox)gvr.FindControl("tb_Variable_Cost")).Text,
                ((DropDownList)gvr.FindControl("ddl_Fixed_Cost_Km")).SelectedValue,
                ((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value,
                ((TextBox)gvr.FindControl("tb_Location")).Text  
            );

            if (gvr.RowIndex == e.RowIndex)
            {
                if (((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value != "")
                {
                    Secondary_Contract objSecContract = new Secondary_Contract(Convert.ToString(Session["SqlProvider"]));
                    objSecContract.ExecureQry("Delete From [Webx_Fleet_Secondary_Contract_Det] Where Contract_Det_Code = '" + ((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value + "'");
                }
            }
        }

        dt_Secondary_Contract.Rows[e.RowIndex].Delete();
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Secondary_Contract.AddWebx_Fleet_Secondary_Contract_DetRow("", "", "", "", "", "", "", "", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        Secondary_Contract objSecContract = new Secondary_Contract(Session["SqlProvider"].ToString());
        bool IsCommitted = false;

        objSecContract.BeginTransaction();

        try
        {
            foreach (GridViewRow gvr in gv_Secondary_Contract.Rows)
            {
                objSecContract.Contract_Det_Code = "";
                objSecContract.Contract_Code = Request.QueryString["Contract_Code"].ToString();
                objSecContract.Vehicle_No = ((TextBox)gvr.FindControl("tb_Vehicle_No")).Text;
                objSecContract.Vehicle_Type = ((TextBox)gvr.FindControl("tb_Vehicle_Type")).Text;
                objSecContract.Category = ((DropDownList)gvr.FindControl("ddl_Category")).SelectedValue;
                objSecContract.Hourly_Based_Slot_Id = ((DropDownList)gvr.FindControl("ddl_Hourly_Based_Slot")).SelectedValue == "" ? 0 : Convert.ToInt32(((DropDownList)gvr.FindControl("ddl_Hourly_Based_Slot")).SelectedValue);
                objSecContract.From_KM = ((TextBox)gvr.FindControl("tb_From_Km")).Text == "" ? 0 : Convert.ToDouble(((TextBox)gvr.FindControl("tb_From_Km")).Text);
                objSecContract.To_KM = ((TextBox)gvr.FindControl("tb_To_Km")).Text == "" ? 0 : Convert.ToDouble(((TextBox)gvr.FindControl("tb_To_Km")).Text);
                objSecContract.Fixed_Cost = ((TextBox)gvr.FindControl("tb_Fixed_Cost")).Text == "" ? 0 : Convert.ToDouble(((TextBox)gvr.FindControl("tb_Fixed_Cost")).Text);
                objSecContract.Variable_Cost = ((TextBox)gvr.FindControl("tb_Variable_Cost")).Text == "" ? 0 : Convert.ToDouble(((TextBox)gvr.FindControl("tb_Variable_Cost")).Text);
                objSecContract.Fixed_Cost_Based = ((DropDownList)gvr.FindControl("ddl_Fixed_Cost_Km")).SelectedValue;
                objSecContract.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().ToUpper().Trim();
                objSecContract.Contract_Det_Code = ((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value;
                objSecContract.Loc_Code = ((TextBox)gvr.FindControl("tb_Location")).Text;   
 
                if (((HiddenField)gvr.FindControl("hf_Contract_Det_Code")).Value == "")
                {
                    objSecContract.InsertSecondaryContractDet();
                }
                else
                {
                    objSecContract.UpdateSecondaryContractDet(); 
                }
            }
            IsCommitted = objSecContract.CommitTransaction();
        }
        catch (Exception e1)
        {
            objSecContract.RollBackTransaction();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
        }

        if (IsCommitted)
        {
            Response.Redirect("Secondary_Contract_Result.aspx?Contract_Code=" + Request.QueryString["Contract_Code"].ToString() + "&Customer_Code=" + Request.QueryString["Customer_Code"].ToString() + "");
        }
    }
}
