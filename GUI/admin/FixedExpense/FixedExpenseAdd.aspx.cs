using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FixedExpense_FixedExpenseAdd : System.Web.UI.Page
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
        if (ddlOption.SelectedIndex==0)
        {
            UserMessage.Show("Please Select Option.");
        }
        else
        {
            lblOption.Text = ddlOption.SelectedItem.Text;
            btnStep1.Visible = false;
            tblMain.Visible = true;
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
            objFixedExpense.TyreExp= txtTyreExp.Text;
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
        catch(Exception ex)
        {
            UserMessage.Show(ex.Message);
        }
    }

    [WebMethod]
    public static string CheckOptionDetails(string Option)
    {
        string dtDetails = "";
        try
        {
            var objFixedExpenseController = new FixedExpenseController();
            dtDetails = objFixedExpenseController.CheckOptionIsMapped(Option);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dtDetails;
    }
}