using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class EditCustomerContractStep1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidCustCode.Value = Request.QueryString["CustomerCode"];
            HidCustCodeName.Value = Request.QueryString["CustomerCodeName"].Replace("^|^", "&");

            displayData();
        }

        lblSelectedCustomer.InnerHtml = " " + HidCustCodeName.Value;

        if (!IsPostBack)
        {
            txtContractDate.Focus();   
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Insert user specified values in Table Webx_CCM_Step1

        bool blnStepResult = Update_CCM_Step1();

        if (blnStepResult == true)
        {
            //Redirect to step 2 screen
            Response.Redirect("EditCustomerContractStep2.aspx?RandomNo=" + HidRandomNo.Value);
        }
        else
        {
            txtContractDate.Focus();
        }
    }

    private bool Update_CCM_Step1()
    {
        bool blnStepResult = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "Webx_SP_Update_CCM_Step1_Data";

            sqlCommand.Parameters.AddWithValue("@contdate", getDateInddMMMyyyFormat(txtContractDate.Value));
            sqlCommand.Parameters.AddWithValue("@contvaliduntil", getDateInddMMMyyyFormat(txtValidUntil.Value));
            sqlCommand.Parameters.AddWithValue("@contefffromdate", getDateInddMMMyyyFormat(txtEffFromDate.Value));
            sqlCommand.Parameters.AddWithValue("@contsignloc", txtContractSigningLocation.Text);
            sqlCommand.Parameters.AddWithValue("@custrep", txtCustomerRepresentative.Value);
            sqlCommand.Parameters.AddWithValue("@coempname", txtCoEmpName.Value);
            sqlCommand.Parameters.AddWithValue("@custrepdesi", txtCustRepDesignation.Value);
            sqlCommand.Parameters.AddWithValue("@coempdesi", txtCoEmpDesignation.Value);
            sqlCommand.Parameters.AddWithValue("@custwitness", txtCustWitness.Value);
            sqlCommand.Parameters.AddWithValue("@cowitness", txtCoWitness.Value);
            sqlCommand.Parameters.AddWithValue("@billadd", txtBillingAddress.Value);
            sqlCommand.Parameters.AddWithValue("@city", txtCity.Value);
            sqlCommand.Parameters.AddWithValue("@pincode", txtPinCode.Value);
            sqlCommand.Parameters.AddWithValue("@partycat", ddlPartyCategory.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@contcat", ddlContractCategory.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@stapp", (chkSTApp.Checked == true ? "Y" : "N"));
            sqlCommand.Parameters.AddWithValue("@acctrep", txtAccountsRepresentative.Value);
            sqlCommand.Parameters.AddWithValue("@slab_yn", "N");
            sqlCommand.Parameters.AddWithValue("@ContractID", lblContractID.InnerHtml);

            sqlCommand.ExecuteNonQuery();

            blnStepResult = true;
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }

        return blnStepResult;
    }

    private bool checkContSignLocation()
    {
        txtContractSigningLocation.Text = txtContractSigningLocation.Text.Trim().ToUpper();
        
        if (txtContractSigningLocation.Text == "")
        {
            lblErrorContSignLocation.Visible = false;
            return true;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        sqlConn.Open();

        strSQL = "SELECT locname FROM webx_Location WHERE activeflag='Y' AND loccode = '" + txtContractSigningLocation.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            lblErrorContSignLocation.Visible = false;
            sqlConn.Close();
            return true;
        }
        else
        {
            lblErrorContSignLocation.Visible = true;
            sqlConn.Close();
            return false;
        }
    }

    protected void txtContractSigningLocation_TextChanged(object sender, EventArgs e)
    {
        lblErrorContSignLocation.Visible = (!(checkContSignLocation()));
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    private int GetRandomNo()
    {
        Random r = new Random();

        int intRandomValue = r.Next(int.MinValue, int.MaxValue);

        return intRandomValue;
    }

    private void displayData()
    {
        String strSQL = "select * from webx_ccm_step1 WHERE CustCode = '" + HidCustCode.Value + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();

        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            HidRandomNo.Value = dsCCM.Tables[0].Rows[0]["Temp_Sr_No"].ToString();
            lblContractID.InnerHtml = dsCCM.Tables[0].Rows[0]["ContractID"].ToString();
            txtContractDate.Value = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contdate"]).ToString("dd/MM/yyyy");
            txtValidUntil.Value = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contvaliduntil"]).ToString("dd/MM/yyyy");
            txtEffFromDate.Value = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contefffromdate"]).ToString("dd/MM/yyyy");
            txtContractSigningLocation.Text = dsCCM.Tables[0].Rows[0]["contsignloc"].ToString();
            txtCustomerRepresentative.Value = dsCCM.Tables[0].Rows[0]["custrep"].ToString();
            txtCoEmpName.Value = dsCCM.Tables[0].Rows[0]["coempname"].ToString();
            txtCustRepDesignation.Value = dsCCM.Tables[0].Rows[0]["custrepdesi"].ToString();
            txtCoEmpDesignation.Value = dsCCM.Tables[0].Rows[0]["coempdesi"].ToString();
            txtCustWitness.Value = dsCCM.Tables[0].Rows[0]["custwitness"].ToString();
            txtCoWitness.Value = dsCCM.Tables[0].Rows[0]["cowitness"].ToString();
            txtBillingAddress.Value = dsCCM.Tables[0].Rows[0]["billadd"].ToString();
            txtCity.Value = dsCCM.Tables[0].Rows[0]["city"].ToString();
            txtPinCode.Value = dsCCM.Tables[0].Rows[0]["pincode"].ToString();
            ddlPartyCategory.SelectedValue = dsCCM.Tables[0].Rows[0]["partycat"].ToString();
            ddlContractCategory.SelectedValue = dsCCM.Tables[0].Rows[0]["contcat"].ToString();
            chkSTApp.Checked = (dsCCM.Tables[0].Rows[0]["stapp"].ToString().ToUpper() == "Y" ? true : false);
            txtAccountsRepresentative.Value = dsCCM.Tables[0].Rows[0]["acctrep"].ToString();
        }
        else
        {
            
        }

        sqlConn.Close();
    }
}
