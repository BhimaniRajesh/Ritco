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

public partial class GUI_admin_CustomerContractMaster_AddCCMODA : System.Web.UI.Page
{
    string custcode = "", contractid = "";
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        contractid = Request.QueryString["contractid"].ToString();
        custcode = Request.QueryString["custcode"].ToString();

      
        
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

        if (!IsPostBack)
        {
            ddlRateType.Focus();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        manageSubmitClick();

        Response.Redirect("CCM_DisplayResult.aspx?ContractID=" + contractid + "&CustCodeName=" + custcode + "&CCMMode=A");
    }

    private void manageSubmitClick()
    {
        SqlCommand sqlCommand;
        string strSQL;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

        SqlTransaction trn = sqlConn.BeginTransaction();

        try
        {

            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR WHERE custcode='" + custcode + "'";
            sqlCommand = new SqlCommand(strSQL,sqlConn,trn);
            sqlCommand.ExecuteNonQuery();

            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR WHERE custcode='" + custcode + "'";
            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
            sqlCommand.ExecuteNonQuery();

            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE WHERE custcode='" + custcode + "'";
            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB1', " +
                     (txtFromSlab1.Value == "" ? "NULL" : txtFromSlab1.Value) + ", " +
                     (txtToSlab1.Value == "" ? "NULL" : txtToSlab1.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB2', " +
                     (txtFromSlab2.Value == "" ? "NULL" : txtFromSlab2.Value) + ", " +
                     (txtToSlab2.Value == "" ? "NULL" : txtToSlab2.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB3', " +
                     (txtFromSlab3.Value == "" ? "NULL" : txtFromSlab3.Value) + ", " +
                     (txtToSlab3.Value == "" ? "NULL" : txtToSlab3.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB4', " +
                     (txtFromSlab4.Value == "" ? "NULL" : txtFromSlab4.Value) + ", " +
                     (txtToSlab4.Value == "" ? "NULL" : txtToSlab4.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB5', " +
                     (txtFromSlab5.Value == "" ? "NULL" : txtFromSlab5.Value) + ", " +
                     (txtToSlab5.Value == "" ? "NULL" : txtToSlab5.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (ContractId, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB6', " +
                     (txtFromSlab6.Value == "" ? "NULL" : txtFromSlab6.Value) + ", " +
                     (txtToSlab6.Value == "" ? "NULL" : txtToSlab6.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA1', " +
                     (txtFromODA1.Value == "" ? "NULL" : txtFromODA1.Value) + ", " +
                     (txtToODA1.Value == "" ? "NULL" : txtToODA1.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA2', " +
                     (txtFromODA2.Value == "" ? "NULL" : txtFromODA2.Value) + ", " +
                     (txtToODA2.Value == "" ? "NULL" : txtToODA2.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA3', " +
                     (txtFromODA3.Value == "" ? "NULL" : txtFromODA3.Value) + ", " +
                     (txtToODA3.Value == "" ? "NULL" : txtToODA3.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA4', " +
                     (txtFromODA4.Value == "" ? "NULL" : txtFromODA4.Value) + ", " +
                     (txtToODA4.Value == "" ? "NULL" : txtToODA4.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA5', " +
                     (txtFromODA5.Value == "" ? "NULL" : txtFromODA5.Value) + ", " +
                     (txtToODA5.Value == "" ? "NULL" : txtToODA5.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (ContractId, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA6', " +
                     (txtFromODA6.Value == "" ? "NULL" : txtFromODA6.Value) + ", " +
                     (txtToODA6.Value == "" ? "NULL" : txtToODA6.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA1', " + (txtTrODA1ForRow1.Value == "" ? "NULL" : txtTrODA1ForRow1.Value) + ", " +
                     (txtSlabODA1ForRow1.Value == "" ? "NULL" : txtSlabODA1ForRow1.Value) + ", " +
                     (txtSlabODA2ForRow1.Value == "" ? "NULL" : txtSlabODA2ForRow1.Value) + ", " +
                     (txtSlabODA3ForRow1.Value == "" ? "NULL" : txtSlabODA3ForRow1.Value) + ", " +
                     (txtSlabODA4ForRow1.Value == "" ? "NULL" : txtSlabODA4ForRow1.Value) + ", " +
                     (txtSlabODA5ForRow1.Value == "" ? "NULL" : txtSlabODA5ForRow1.Value) + ", " +
                     (txtSlabODA6ForRow1.Value == "" ? "NULL" : txtSlabODA6ForRow1.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA2', " + (txtTrODA1ForRow2.Value == "" ? "NULL" : txtTrODA1ForRow2.Value) + ", " +
                     (txtSlabODA1ForRow2.Value == "" ? "NULL" : txtSlabODA1ForRow2.Value) + ", " +
                     (txtSlabODA2ForRow2.Value == "" ? "NULL" : txtSlabODA2ForRow2.Value) + ", " +
                     (txtSlabODA3ForRow2.Value == "" ? "NULL" : txtSlabODA3ForRow2.Value) + ", " +
                     (txtSlabODA4ForRow2.Value == "" ? "NULL" : txtSlabODA4ForRow2.Value) + ", " +
                     (txtSlabODA5ForRow2.Value == "" ? "NULL" : txtSlabODA5ForRow2.Value) + ", " +
                     (txtSlabODA6ForRow2.Value == "" ? "NULL" : txtSlabODA6ForRow2.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA3', " + (txtTrODA1ForRow3.Value == "" ? "NULL" : txtTrODA1ForRow3.Value) + ", " +
                     (txtSlabODA1ForRow3.Value == "" ? "NULL" : txtSlabODA1ForRow3.Value) + ", " +
                     (txtSlabODA2ForRow3.Value == "" ? "NULL" : txtSlabODA2ForRow3.Value) + ", " +
                     (txtSlabODA3ForRow3.Value == "" ? "NULL" : txtSlabODA3ForRow3.Value) + ", " +
                     (txtSlabODA4ForRow3.Value == "" ? "NULL" : txtSlabODA4ForRow3.Value) + ", " +
                     (txtSlabODA5ForRow3.Value == "" ? "NULL" : txtSlabODA5ForRow3.Value) + ", " +
                     (txtSlabODA6ForRow3.Value == "" ? "NULL" : txtSlabODA6ForRow3.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA4', " + (txtTrODA1ForRow4.Value == "" ? "NULL" : txtTrODA1ForRow4.Value) + ", " +
                     (txtSlabODA1ForRow4.Value == "" ? "NULL" : txtSlabODA1ForRow4.Value) + ", " +
                     (txtSlabODA2ForRow4.Value == "" ? "NULL" : txtSlabODA2ForRow4.Value) + ", " +
                     (txtSlabODA3ForRow4.Value == "" ? "NULL" : txtSlabODA3ForRow4.Value) + ", " +
                     (txtSlabODA4ForRow4.Value == "" ? "NULL" : txtSlabODA4ForRow4.Value) + ", " +
                     (txtSlabODA5ForRow4.Value == "" ? "NULL" : txtSlabODA5ForRow4.Value) + ", " +
                     (txtSlabODA6ForRow4.Value == "" ? "NULL" : txtSlabODA6ForRow4.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();



            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA5', " + (txtTrODA1ForRow5.Value == "" ? "NULL" : txtTrODA1ForRow5.Value) + ", " +
                     (txtSlabODA1ForRow5.Value == "" ? "NULL" : txtSlabODA1ForRow5.Value) + ", " +
                     (txtSlabODA2ForRow5.Value == "" ? "NULL" : txtSlabODA2ForRow5.Value) + ", " +
                     (txtSlabODA3ForRow5.Value == "" ? "NULL" : txtSlabODA3ForRow5.Value) + ", " +
                     (txtSlabODA4ForRow5.Value == "" ? "NULL" : txtSlabODA4ForRow5.Value) + ", " +
                     (txtSlabODA5ForRow5.Value == "" ? "NULL" : txtSlabODA5ForRow5.Value) + ", " +
                     (txtSlabODA6ForRow5.Value == "" ? "NULL" : txtSlabODA6ForRow5.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (ContractId, Custcode, ESS_code, trdays, " +
                     "Slab1, Slab2, Slab3, Slab4, Slab5, Slab6) VALUES ('" + contractid + "', '" +
                     custcode + "', 'ODA6', " + (txtTrODA1ForRow6.Value == "" ? "NULL" : txtTrODA1ForRow6.Value) + ", " +
                     (txtSlabODA1ForRow6.Value == "" ? "NULL" : txtSlabODA1ForRow6.Value) + ", " +
                     (txtSlabODA2ForRow6.Value == "" ? "NULL" : txtSlabODA2ForRow6.Value) + ", " +
                     (txtSlabODA3ForRow6.Value == "" ? "NULL" : txtSlabODA3ForRow6.Value) + ", " +
                     (txtSlabODA4ForRow6.Value == "" ? "NULL" : txtSlabODA4ForRow6.Value) + ", " +
                     (txtSlabODA5ForRow6.Value == "" ? "NULL" : txtSlabODA5ForRow6.Value) + ", " +
                     (txtSlabODA6ForRow6.Value == "" ? "NULL" : txtSlabODA6ForRow6.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
            sqlCommand.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            trn.Rollback(); 
            Response.Write("DataBase Error..." + ex.Message);
            return;
        }
        trn.Commit();
    }

   
}
