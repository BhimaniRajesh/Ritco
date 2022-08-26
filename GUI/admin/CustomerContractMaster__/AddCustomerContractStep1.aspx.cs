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

public partial class AddCustomerContractStep1 : System.Web.UI.Page
{
    int intRandomNo = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidCustCode.Value = Request.QueryString["CustomerCode"];
            HidCustCodeName.Value = Request.QueryString["CustomerCodeName"].Replace("^|^", "&");
        }

        lblSelectedCustomer.InnerHtml = " " + HidCustCodeName.Value;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Insert user specified values in Table Webx_CCM_Step1

        bool blnStepResult = Insert_CCM_Step1();

        if (blnStepResult == true)
        {
            //Redirect to step 2 screen
            Response.Redirect("AddCustomerContractStep2.aspx?RandomNo=" + intRandomNo.ToString());
        }
        else
        {
            txtContractDate.Focus();
        }
    }

    private bool Insert_CCM_Step1()
    {
        bool blnStepResult = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "Webx_SP_Insert_CCM_Step1_Data";

            intRandomNo = GetRandomNo();

            //Code for generating XML statement
            string strXML = "<root>" + 
                            "<ccm>" +
                            "<rndno>" + intRandomNo.ToString() + "</rndno>" +
                            "<custcode>" + HidCustCode.Value + "</custcode>" +
                            "<custcodename>" + HidCustCodeName.Value + "</custcodename>" +
                            "<contdate>" + getDateInddMMMyyyFormat(txtContractDate.Value) + "</contdate>" +
                            "<contvaliduntil>" + getDateInddMMMyyyFormat(txtValidUntil.Value) + "</contvaliduntil>" +
                            "<contefffromdate>" + getDateInddMMMyyyFormat(txtEffFromDate.Value) + "</contefffromdate>" +
                            "<contsignloc>" + txtContractSigningLocation.Text + "</contsignloc>" +
                            "<custrep>" + txtCustomerRepresentative.Value + "</custrep>" +
                            "<coempname>" + txtCoEmpName.Value + "</coempname>" +
                            "<custrepdesi>" + txtCustRepDesignation.Value + "</custrepdesi>" +
                            "<coempdesi>" + txtCoEmpDesignation.Value + "</coempdesi>" +
                            "<custwitness>" + txtCustWitness.Value + "</custwitness>" +
                            "<cowitness>" + txtCoWitness.Value + "</cowitness>" +
                            "<billadd>" + txtBillingAddress.Value + "</billadd>" +
                            "<city>" + txtCity.Value + "</city>" +
                            "<pincode>" + txtPinCode.Value + "</pincode>" +
                            "<partycat>" + ddlPartyCategory.SelectedValue + "</partycat>" +
                            "<contcat>" + ddlContractCategory.SelectedValue + "</contcat>" +
                            "<stapp>" + (chkSTApp.Checked == true ? "Y" : "N") + "</stapp>" +
                            "<acctrep>" + txtAccountsRepresentative.Value + "</acctrep>" +
                            "<slab_yn>" + "N" + "</slab_yn>" +
                            "</ccm>" +
                            "</root>";

            sqlCommand.Parameters.AddWithValue("@strXML", strXML);
            sqlCommand.Parameters.AddWithValue("@RandomNo", intRandomNo);
            
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
            return true;
        }
        else
        {
            lblErrorContSignLocation.Visible = true;
            return false;
        }

        sqlConn.Close();
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
}
