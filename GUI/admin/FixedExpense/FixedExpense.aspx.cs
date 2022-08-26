using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FixedExpense_FixedExpenseEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {
            tblMain.Visible = false;
            BindSelectOption();
        }
    }
    public void BindSelectOption()
    {
        var dt = new DataTable();
        dt = GeneralMasterUtilities.GetGeneralMaster("TyreOPT");

        ddlOption.DataSource = dt;
        ddlOption.DataTextField = "CodeDesc";
        ddlOption.DataValueField = "CodeId";
        ddlOption.DataBind();
        ddlOption.Items.Insert(0, new ListItem("--Select--", ""));
    }

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        btnStep1.Visible = false;
        tblMain.Visible = true;
        GetFixedExpenseData();
    }

    public void GetFixedExpenseData()
    {
        var option = ddlOption.SelectedItem.Value;
        lblOption.Text = ddlOption.SelectedItem.Text;
        var oFixedExpenseController = new FixedExpenseController();
        var ds = new DataSet();
        ds = oFixedExpenseController.GetOptionByFixedExpenseDetails(option);

        if (ds.Tables[0].Rows.Count > 0)
        {
            txtTyreExp.Text = ds.Tables[0].Rows[0]["TyreExp"].ToString();
            txtAMC.Text =ds.Tables[0].Rows[0]["AMC"].ToString();
            txtDocument.Text =ds.Tables[0].Rows[0]["Document"].ToString();
            txtOtherI.Text =ds.Tables[0].Rows[0]["OtherI"].ToString();
            txtOtherII.Text =ds.Tables[0].Rows[0]["OtherII"].ToString();
            txtVehicle.Text =ds.Tables[0].Rows[0]["VehicleNo"].ToString();
        }
        else
        {
            txtTyreExp.Text = "0.00";
            txtAMC.Text = "0.00";
            txtDocument.Text = "0.00";
            txtOtherI.Text = "0.00";
            txtOtherII.Text = "0.00";
            txtVehicle.Text = "";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        UserMessage.Hide();
        try
        {
            var lstFixedExpense = new List<FixedExpense>();
            var objFixedExpense = new FixedExpense();
            objFixedExpense.OptionType = ddlOption.SelectedItem.Value;
            objFixedExpense.TyreExp = txtTyreExp.Text;
            objFixedExpense.AMC = txtAMC.Text;
            objFixedExpense.Document = txtDocument.Text;
            objFixedExpense.OtherI = txtOtherI.Text;
            objFixedExpense.OtherII = txtOtherII.Text;
            objFixedExpense.VehicleNo = txtVehicle.Text;
            lstFixedExpense.Add(objFixedExpense);

            var objFixedExpenseController = new FixedExpenseController();
            objFixedExpenseController.InsertUpdateFixedExpenseDetails(lstFixedExpense);

            Response.Redirect("FixedExpenseDone.aspx", false);
        }
        catch (Exception ex)
        {
            UserMessage.Show(ex.Message);
        }
    }
}