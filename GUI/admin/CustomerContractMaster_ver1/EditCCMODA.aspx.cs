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

public partial class GUI_admin_CustomerContractMaster_EditCCMODA : System.Web.UI.Page
{
    public static string contractid = "", custcode = "";
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

      
        
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

        if (!IsPostBack)
        {
            displayData();
        }
        ddlRateType.Focus();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        manageSubmitClick();

        Response.Redirect("CCM_DisplayResult.aspx?contractid=" + contractid + "&CCMMode=E");
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

            //Delete Records from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table
            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR WHERE contractid = '" + contractid + "'";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB1', " +
                     (txtFromSlab1.Value == "" ? "NULL" : txtFromSlab1.Value) + ", " +
                     (txtToSlab1.Value == "" ? "NULL" : txtToSlab1.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB2', " +
                     (txtFromSlab2.Value == "" ? "NULL" : txtFromSlab2.Value) + ", " +
                     (txtToSlab2.Value == "" ? "NULL" : txtToSlab2.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB3', " +
                     (txtFromSlab3.Value == "" ? "NULL" : txtFromSlab3.Value) + ", " +
                     (txtToSlab3.Value == "" ? "NULL" : txtToSlab3.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB4', " +
                     (txtFromSlab4.Value == "" ? "NULL" : txtFromSlab4.Value) + ", " +
                     (txtToSlab4.Value == "" ? "NULL" : txtToSlab4.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB5', " +
                     (txtFromSlab5.Value == "" ? "NULL" : txtFromSlab5.Value) + ", " +
                     (txtToSlab5.Value == "" ? "NULL" : txtToSlab5.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR table for Slab 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR (contractid, Custcode, matrix_type, " +
                     "slab_code, slab_from, slab_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlRateType.SelectedValue + "', 'SLAB6', " +
                     (txtFromSlab6.Value == "" ? "NULL" : txtFromSlab6.Value) + ", " +
                     (txtToSlab6.Value == "" ? "NULL" : txtToSlab6.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Delete Records from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table
            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR WHERE contractid = '" + contractid + "'";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA1', " +
                     (txtFromODA1.Value == "" ? "NULL" : txtFromODA1.Value) + ", " +
                     (txtToODA1.Value == "" ? "NULL" : txtToODA1.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA2', " +
                     (txtFromODA2.Value == "" ? "NULL" : txtFromODA2.Value) + ", " +
                     (txtToODA2.Value == "" ? "NULL" : txtToODA2.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA3', " +
                     (txtFromODA3.Value == "" ? "NULL" : txtFromODA3.Value) + ", " +
                     (txtToODA3.Value == "" ? "NULL" : txtToODA3.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA4', " +
                     (txtFromODA4.Value == "" ? "NULL" : txtFromODA4.Value) + ", " +
                     (txtToODA4.Value == "" ? "NULL" : txtToODA4.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA5', " +
                     (txtFromODA5.Value == "" ? "NULL" : txtFromODA5.Value) + ", " +
                     (txtToODA5.Value == "" ? "NULL" : txtToODA5.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR table for Slab 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR (contractid, Custcode, matrix_type, " +
                     "MIN_ODACHRG, ess_code, ess_from, ess_to) VALUES ('" + contractid + "', '" +
                     custcode + "', '" + ddlODARateType.SelectedValue + "', " +
                     (txtMinODACharges.Value == "" ? "NULL" : txtMinODACharges.Value) + ", 'ODA6', " +
                     (txtFromODA6.Value == "" ? "NULL" : txtFromODA6.Value) + ", " +
                     (txtToODA6.Value == "" ? "NULL" : txtToODA6.Value) + ")";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Delete Records from WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table
            strSQL = "DELETE FROM WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE WHERE contractid = '" + contractid + "'";

            sqlCommand = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand.ExecuteNonQuery();

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 1
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 2
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 3
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 4
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 5
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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

            sqlCommand = null;

            //Insert Record in WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE table for Row 6
            strSQL = "Insert into WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE (contractid, Custcode, ESS_code, trdays, " +
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
            Response.Write("DataBase Erro..." + ex.Message);
            return;
        }
        trn.Commit();
    }

   

    private void displayData()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;
        SqlDataAdapter sqlDA;
        DataSet dsCCM;

        //Weight/Package Slab
        string strSQL = "select top 1 " +
                        "(select top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB1') AS Slab1From, " +
                        "(select top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB1') AS Slab1To, " +
                        "(select top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB2') AS Slab2From, " +
                        "(select  top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB2') AS Slab2To, " +
                        "(select top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB3') AS Slab3From, " +
                        "(select  top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB3') AS Slab3To, " +
                        "(select  top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB4') AS Slab4From, " +
                        "(select top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB4') AS Slab4To, " +
                        "(select  top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " +  
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB5') AS Slab5From, " +
                        "(select  top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB5') AS Slab5To, " +
                        "(select  top 1 slab_from from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " + 
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB6') AS Slab6From, " +
                        "(select  top 1 slab_to from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(slab_code) = 'SLAB6') AS Slab6To, matrix_type " + 
                        "FROM WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR OuterODAMatrix WHERE contractid = '" + contractid + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();

        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            ddlRateType.SelectedValue = (dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["matrix_type"].ToString());
            txtFromSlab1.Value = (dsCCM.Tables[0].Rows[0]["Slab1From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab1From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab1From"].ToString());
            txtToSlab1.Value = (dsCCM.Tables[0].Rows[0]["Slab1To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab1To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab1To"].ToString());
            txtFromSlab2.Value = (dsCCM.Tables[0].Rows[0]["Slab2From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab2From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab2From"].ToString());
            txtToSlab2.Value = (dsCCM.Tables[0].Rows[0]["Slab2To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab2To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab2To"].ToString());
            txtFromSlab3.Value = (dsCCM.Tables[0].Rows[0]["Slab3From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab3From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab3From"].ToString());
            txtToSlab3.Value = (dsCCM.Tables[0].Rows[0]["Slab3To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab3To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab3To"].ToString());
            txtFromSlab4.Value = (dsCCM.Tables[0].Rows[0]["Slab4From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab4From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab4From"].ToString());
            txtToSlab4.Value = (dsCCM.Tables[0].Rows[0]["Slab4To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab4To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab4To"].ToString());
            txtFromSlab5.Value = (dsCCM.Tables[0].Rows[0]["Slab5From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab5From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab5From"].ToString());
            txtToSlab5.Value = (dsCCM.Tables[0].Rows[0]["Slab5To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab5To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab5To"].ToString());
            txtFromSlab6.Value = (dsCCM.Tables[0].Rows[0]["Slab6From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab6From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab6From"].ToString());
            txtToSlab6.Value = (dsCCM.Tables[0].Rows[0]["Slab6To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["Slab6To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["Slab6To"].ToString());
        }

        //ODA Distance Slab
        strSQL = "select top 1 " +
                        "(select top 1  Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA1') AS ODA1From, " +
                        "(select top 1  ESS_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA1') AS ODA1To, " +
                        "(select top 1  Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA2') AS ODA2From, " +
                        "(select top 1  Ess_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA2') AS ODA2To, " +
                        "(select top 1  Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA3') AS ODA3From, " +
                        "(select top 1  Ess_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA3') AS ODA3To, " +
                        "(select top 1  Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA4') AS ODA4From, " +
                        "(select top 1  Ess_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA4') AS ODA4To, " +
                        "(select  top 1 Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA5') AS ODA5From, " +
                        "(select  top 1 Ess_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA5') AS ODA5To, " +
                        "(select top 1  Ess_from from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA6') AS ODA6From, " +
                        "(select top 1  Ess_to from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR Slab1FromInner " +
                        "where Slab1FromInner.contractid = OuterODAMatrix.contractid AND UPPER(ESS_code) = 'ODA6') AS ODA6To, matrix_type, MIN_ODACHRG " +
                        "FROM WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR OuterODAMatrix WHERE contractid = '" + contractid + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            ddlODARateType.SelectedValue = (dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["matrix_type"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["matrix_type"].ToString());
            txtMinODACharges.Value = (dsCCM.Tables[0].Rows[0]["MIN_ODACHRG"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["MIN_ODACHRG"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["MIN_ODACHRG"].ToString());
            txtFromODA1.Value = (dsCCM.Tables[0].Rows[0]["ODA1From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA1From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA1From"].ToString());
            txtToODA1.Value = (dsCCM.Tables[0].Rows[0]["ODA1To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA1To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA1To"].ToString());
            txtFromODA2.Value = (dsCCM.Tables[0].Rows[0]["ODA2From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA2From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA2From"].ToString());
            txtToODA2.Value = (dsCCM.Tables[0].Rows[0]["ODA2To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA2To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA2To"].ToString());
            txtFromODA3.Value = (dsCCM.Tables[0].Rows[0]["ODA3From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA3From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA3From"].ToString());
            txtToODA3.Value = (dsCCM.Tables[0].Rows[0]["ODA3To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA3To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA3To"].ToString());
            txtFromODA4.Value = (dsCCM.Tables[0].Rows[0]["ODA4From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA4From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA4From"].ToString());
            txtToODA4.Value = (dsCCM.Tables[0].Rows[0]["ODA4To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA4To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA4To"].ToString());
            txtFromODA5.Value = (dsCCM.Tables[0].Rows[0]["ODA5From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA5From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA5From"].ToString());
            txtToODA5.Value = (dsCCM.Tables[0].Rows[0]["ODA5To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA5To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA5To"].ToString());
            txtFromODA6.Value = (dsCCM.Tables[0].Rows[0]["ODA6From"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA6From"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA6From"].ToString());
            txtToODA6.Value = (dsCCM.Tables[0].Rows[0]["ODA6To"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["ODA6To"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["ODA6To"].ToString());
        }

        //ODA Charges
        strSQL = "select * from WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE WHERE contractid = '" + contractid + "' order by srno";

        sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (intLoopCounter)
                {
                    case 0:
                        txtTrODA1ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow1.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;

                    case 1:
                        txtTrODA1ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow2.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;

                    case 2:
                        txtTrODA1ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow3.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;

                    case 3:
                        txtTrODA1ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow4.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;

                    case 4:
                        txtTrODA1ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow5.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;

                    case 5:
                        txtTrODA1ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["trdays"].ToString());
                        txtSlabODA1ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab1"].ToString());
                        txtSlabODA2ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab2"].ToString());
                        txtSlabODA3ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab3"].ToString());
                        txtSlabODA4ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab4"].ToString());
                        txtSlabODA5ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab5"].ToString());
                        txtSlabODA6ForRow6.Value = (dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["slab6"].ToString());

                        break;
                }
            }
        }
    }
}
