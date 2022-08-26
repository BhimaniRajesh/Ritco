using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using ApplicationManager;

public partial class GUI_Fleet_SecondaryContract_Step1 : System.Web.UI.Page
{
    string str_Connection_String = "";
    ds_Secondary_Contract.Webx_Fleet_Hourly_Based_SlotDataTable dt_Hourly = new ds_Secondary_Contract.Webx_Fleet_Hourly_Based_SlotDataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            str_Connection_String = Session["SqlProvider"].ToString();
            this.Title = System.Configuration.ConfigurationManager.AppSettings["PageTitle"].ToString().Trim();



            tb_Customer_Code.Attributes.Add("OnBlur", "javascript:CheckCustomerCode(this," + tb_Customer_Name.ClientID.Trim() + ");");
            tb_Customer_Name.Attributes.Add("OnBlur", "javascript:CheckCustomerName(this," + tb_Customer_Code.ClientID.Trim() + ");");
            tb_From_Date.Attributes.Add("OnBlur", "javascript:CheckContractExist_FromDt(" + tb_Customer_Code.ClientID.ToString() + " ," + tb_From_Date.ClientID.ToString() + "," + tb_To_Date.ClientID.ToString() + "," + lbl_Error.ClientID.Trim() + ");");
            tb_To_Date.Attributes.Add("OnBlur", "javascript:CheckContractExist_ToDt(" + tb_Customer_Code.ClientID.ToString() + " ," + tb_From_Date.ClientID.ToString() + "," + tb_To_Date.ClientID.ToString() + "," + lbl_Error.ClientID.Trim() + ");");
            //dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow(""); 
            BindACNonAC(chklst_AC);
            BindGrid();
            tb_Customer_Code.Focus();

            if (Request.QueryString["Customer_Code"] != null && Request.QueryString["Contract_Code"] != null)
            {
                tb_Customer_Code.Text = Request.QueryString["Customer_Code"].ToString();
                FillDataWhenEdit(Request.QueryString["Customer_Code"].ToString(), Request.QueryString["Contract_Code"].ToString());
            }
            else
            {
                string st1 = @"<script>
                    function HideRow() {
                    var tr_HourlyBased = document.getElementById('ctl00_MyCPH1_tr_HourlyBased');
                    var tr_HourlyBased_det = document.getElementById('ctl00_MyCPH1_tr_HourlyBased_det');

                    tr_HourlyBased.style['display'] = 'none';
                    tr_HourlyBased_det.style['display'] = 'none';

                    return false;
                }
                </script>";
                Page.RegisterClientScriptBlock("HideRow", st1);
            }
        }
    }

    public void FillDataWhenEdit(string str_Customer_Code, string str_Contract_Code)
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);

        DataTable dtContractRule = new DataTable();
        dtContractRule = objSecContract.GetDataTable("Select CONVERT(VarChar,Contract_From_Dt,103) as Contract_From_Dt,CONVERT(VarChar,Contract_To_Dt,103) as Contract_To_Dt,*From [Webx_Fleet_Secondary_Contract_Hdr] Where [Customer_Code] ='" + str_Customer_Code + "' And [Contract_Code]='" + str_Contract_Code + "'");

        tb_From_Date.Text = dtContractRule.Rows[0]["Contract_From_Dt"].ToString();
        tb_To_Date.Text = dtContractRule.Rows[0]["Contract_To_Dt"].ToString();

        if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "FTL")
        {
            rblst_Contract_Based.Items[0].Selected = true;
        }
        else
        {
            rblst_Contract_Based.Items[1].Selected = true;
        }

        if (dtContractRule.Rows[0]["Contract_Based_On"].ToString() == "Vehicle")
        {
            rblst_Contract_Based.Items[1].Selected = true;
        }
        else
        {
            rblst_Contract_Based.Items[0].Selected = true;
        }

        if (dtContractRule.Rows[0]["AC"].ToString() == "Yes") { chklst_AC.Items[0].Selected = true; }
        if (dtContractRule.Rows[0]["Non_AC"].ToString() == "Yes") { chklst_AC.Items[1].Selected = true; }
        if (dtContractRule.Rows[0]["Empty"].ToString() == "Yes") { chklst_AC.Items[2].Selected = true; }

        if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Hourly")
        {
            rblst_Rate_Based.Items[0].Selected = true;
            tr_HourlyBased_det.Style["display"] = "block";
            DataTable dtHourly = new DataTable();
            dtHourly = objSecContract.GetDataTable("select HourlyBasedSlot,Extra_Charge_Per_Hour,Id from Webx_Fleet_Hourly_Based_Slot where Contract_Code = '" + str_Contract_Code + "'");
            for (int i = 0; i < dtHourly.Rows.Count; i++)
            {
                dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow(dtHourly.Rows[i]["HourlyBasedSlot"].ToString(), dtHourly.Rows[i]["Extra_Charge_Per_Hour"].ToString(), dtHourly.Rows[i]["Id"].ToString());
            }
            BindGrid();
        }
        if (dtContractRule.Rows[0]["Rate_Based_On"].ToString() == "Fixed")
        {
            rblst_Rate_Based.Items[1].Selected = true;
        }

        if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "KM") { rblst_RateType.Items[0].Selected = true; }
        if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "KG") { rblst_RateType.Items[1].Selected = true; }
        if (dtContractRule.Rows[0]["Rate_Type"].ToString() == "PKG") { rblst_RateType.Items[2].Selected = true; }

        if (dtContractRule.Rows[0]["Fixed_Cost_Rate"].ToString() == "Yes")
        {
            chk_Variable_Cost.Checked = true;
        }
        else
        {
            chk_Variable_Cost.Checked = false;
        }

        if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "NonMatrix") { rb_Variable_Matrix.Items[0].Selected = true; }
        else if (dtContractRule.Rows[0]["Fixed_Cost_Rate_Based_On"].ToString() == "Matrix") { rb_Variable_Matrix.Items[1].Selected = true; }

        if (dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "NonMatrix") { rb_Variable_Matrix.Items[0].Selected = true; }
        else if (dtContractRule.Rows[0]["Variable_Cost_Rate_Based_On"].ToString() == "Matrix") { rb_Variable_Matrix.Items[1].Selected = true; }

        if (dtContractRule.Rows[0]["Standard_Charge_Applicable"].ToString() == "Yes") { chk_Standard_Charge.Checked = true; } else { chk_Standard_Charge.Checked = false; }

    }

    public void BindACNonAC(CheckBoxList cb)
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);
        DataSet ds = new DataSet();
        ds = objSecContract.GetDataSet("Select CodeId,CodeDesc  from Webx_Master_General Where CodeType='FLTCAT' And StatusCode='Y'");
        cb.DataSource = ds;
        cb.DataTextField = "CodeDesc";
        cb.DataValueField = "CodeId";
        cb.DataBind();
    }
    public void BindGrid()
    {
        gv_Hourly_Based.DataSource = dt_Hourly;
        gv_Hourly_Based.DataBind();
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_Hourly.Clear();

        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        foreach (GridViewRow gvr in gv_Hourly_Based.Rows)
        {
            dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow(((TextBox)gvr.FindControl("tb_Hours")).Text, ((TextBox)gvr.FindControl("tb_Extra_Charge")).Text, ((HiddenField)gvr.FindControl("hf_Id")).Value);
        }

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow("", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void gv_Hourly_Based_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        dt_Hourly.Clear();

        foreach (GridViewRow gvr in gv_Hourly_Based.Rows)
        {
            dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow(((TextBox)gvr.FindControl("tb_Hours")).Text, ((TextBox)  gvr.FindControl("tb_Extra_Charge")).Text, ((HiddenField)gvr.FindControl("hf_Id")).Value);
            if (gvr.RowIndex == e.RowIndex)
            {
                if (((HiddenField)gvr.FindControl("hf_Id")).Value != "")
                {
                    Secondary_Contract objSecContract = new Secondary_Contract(Convert.ToString(Session["SqlProvider"]));
                    objSecContract.ExecureQry("Delete From [Webx_Fleet_Hourly_Based_Slot] Where Id = " + ((HiddenField)gvr.FindControl("hf_Id")).Value);
                }
            }
        }

        dt_Hourly.Rows[e.RowIndex].Delete();
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Hourly.AddWebx_Fleet_Hourly_Based_SlotRow("", "","");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void gv_Hourly_Based_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox tb_Hours = (TextBox)e.Row.FindControl("tb_Hours");
            //((TextBox)gvr.FindControl("tb_Extra_Charge")).Text
        }
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        Secondary_Contract objSecContract = new Secondary_Contract(Session["SqlProvider"].ToString());
        bool IsCommitted = false;

        objSecContract.BeginTransaction();

        objSecContract.Customer_Code = tb_Customer_Code.Text.Trim();
        objSecContract.Contract_From_Dt = DTM.ConvertToDate(tb_From_Date.Text.Trim());
        objSecContract.Contract_To_Dt = DTM.ConvertToDate(tb_To_Date.Text.Trim());
        objSecContract.Contract_Based_On = rblst_Contract_Based.SelectedValue;

        objSecContract.AC = chklst_AC.Items[0].Selected == true ? "Yes" : "No";
        objSecContract.Non_AC = chklst_AC.Items[1].Selected == true ? "Yes" : "No";
        objSecContract.Empty = chklst_AC.Items[2].Selected == true ? "Yes" : "No";

        objSecContract.Rate_Based_On = rblst_Rate_Based.SelectedValue;
        objSecContract.Hourly_Based_Slot_Id = 0;
        objSecContract.Rate_Type = rblst_RateType.SelectedValue;

        objSecContract.Fixed_Cost_Rate = chk_Variable_Cost.Checked == true ? "Yes" : "No";
        objSecContract.Fixed_Cost_Rate_Based_On = rb_Variable_Matrix.SelectedValue;
        //objSecContract.Fixed_Cost = chk_FixedCostRate.Checked == true ? "Yes" : "No";
        //objSecContract.Fixes_Cost_KM = tb_Fiexed_Cost.Text == "" ? 0 : Convert.ToDouble(tb_Fiexed_Cost.Text.Trim());
        //objSecContract.Fixed_Cost_KM_Type = ddl_Fixed_Cost_Type.SelectedValue;
        objSecContract.Variable_Cost_Rate = chk_Variable_Cost.Checked == true ? "Yes" : "No";
        objSecContract.Variable_Cost_Rate_Based_On = rb_Variable_Matrix.SelectedValue;
        objSecContract.Standard_Charge_Applicable = chk_Standard_Charge.Checked == true ? "Yes" : "No";
        objSecContract.Entry_By = SessionUtilities.CurrentEmployeeID.ToUpper().Trim();

        try
        {
            if (Request.QueryString["Contract_Code"] == null)
            {
                objSecContract.InsertSecondaryContractHdr();
            }
            else
            {
                objSecContract.Contract_Code = Convert.ToString(Request.QueryString["Contract_Code"]);
                objSecContract.UpdateSecondaryContractHdr(); 
            }
            foreach (GridViewRow gvr in gv_Hourly_Based.Rows)
            {
                TextBox tb_Hours = (TextBox)gvr.FindControl("tb_Hours");
                TextBox tb_Extra_Charge = (TextBox)gvr.FindControl("tb_Extra_Charge");
                HiddenField hf_Id = (HiddenField)gvr.FindControl("hf_Id");

                objSecContract.Customer_Code = tb_Customer_Code.Text.Trim();
                objSecContract.HourlyBasedSlot = tb_Hours.Text == "" ? 0 : Convert.ToDouble(tb_Hours.Text);
                objSecContract.Extra_Charge_Per_Hour = tb_Extra_Charge.Text == "" ? 0 : Convert.ToDouble(tb_Extra_Charge.Text);
                objSecContract.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().ToUpper().Trim();

                if (hf_Id.Value == "")
                {
                    objSecContract.InsertHourlyBased();
                }
                else
                {
                    objSecContract.Hourly_Based_Slot_Id = Convert.ToInt32(hf_Id.Value); 
                    objSecContract.Contract_Code = Convert.ToString(Request.QueryString["Contract_Code"]);
                    objSecContract.UpdateHourlyBased();
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
            Response.Redirect("SecondaryContract_Step2.aspx?Contract_Code=" + objSecContract.Contract_Code.Trim().ToUpper() + "&Customer_Code=" + tb_Customer_Code.Text.ToUpper() + "");
        }
    }
}
