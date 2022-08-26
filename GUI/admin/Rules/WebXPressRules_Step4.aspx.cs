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

public partial class GUI_admin_WebXPressRules_Step4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDocumentDetails();

            populateDocuments();
        }
    }

    private void getDocumentDetails()
    {
        HidDocket.Value = "";
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLForDocument = "select CodeID, CodeDesc from webx_master_general where codetype = 'DOCS'";

        SqlCommand sqlCommand = new SqlCommand(strSQLForDocument, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocument = new DataSet();

        sqlDA.Fill(dsDocument);

        if (dsDocument.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsDocument.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (dsDocument.Tables[0].Rows[intLoopCounter]["CodeID"].ToString())
                {
                    case "DKT":
                        HidDocket.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "LS":
                        HidLS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "MF":
                        HidMF.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "WebX_SP_Manage_Rules_Step4";

            sqlCommand.Parameters.AddWithValue("@Document", ddlDocument.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@Prefix", txtDocPrefix.Text);
            sqlCommand.Parameters.AddWithValue("@YearCodeReq", ddlYearCode.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@RunningNoLength", ddlRunNoLen.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@Seperator", ddlSeparator.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@NomenclatureType", ddlNomenclature.SelectedIndex.ToString());
            
            sqlCommand.ExecuteNonQuery();
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void populateDocuments()
    {
        ddlDocument.Items.Clear();

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand("select CodeID from webx_master_general where codetype = 'DOCS' ORDER BY CodeID", sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsProcess = new DataSet();

            sqlDA.Fill(dsProcess);

            if (dsProcess.Tables[0].Rows.Count > 0)
            {
                ddlDocument.DataTextField = "CodeID";
                ddlDocument.DataValueField = "CodeID";

                ddlDocument.DataSource = dsProcess;
                ddlDocument.DataBind();
            }

            ddlDocument.Items.Insert(0, new ListItem("Select", "-1"));
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }
    protected void ddlDocument_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDocument.SelectedValue == "-1")
        {
            ddlDocPrefixSize.SelectedValue = "-1";
            txtDocPrefix.Text = "";
            ddlYearCode.SelectedValue = "-1";
            ddlRunNoLen.SelectedValue = "-1";
            ddlSeparator.SelectedValue = "-1";
            ddlNomenclature.Items.Clear();
            ddlNomenclature.Items.Insert(0, new ListItem("Select", "-1"));

        }
        else
        {
            manageDocumentChange();
        }
        //manageNomenclature();
    }
    protected void ddlDocPrefixSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageNomenclature();
    }
    protected void ddlYearCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageNomenclature();
    }
    protected void ddlSeparator_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageNomenclature();
    }
    protected void ddlRunNoLen_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageNomenclature();
    }
    protected void txtDocPrefix_TextChanged(object sender, EventArgs e)
    {
        txtDocPrefix.Text = txtDocPrefix.Text.Trim().ToUpper();

        if (txtDocPrefix.Text.Length > Convert.ToInt32(ddlDocPrefixSize.SelectedValue))
        {
            txtDocPrefix.Text = "";
        }

        manageNomenclature();

        if (txtDocPrefix.Text == "")
        {
            txtDocPrefix.Focus();
        }
    }

    private void manageNomenclature()
    {
        ddlNomenclature.Items.Clear();

        if (ddlDocument.SelectedValue != "-1" && (ddlDocPrefixSize.SelectedValue != "-1" || txtDocPrefix.Text != "") && ddlYearCode.SelectedValue != "-1" && ddlRunNoLen.SelectedValue != "-1" && ddlSeparator.SelectedValue != "-1")
        {
            populateNomenclature();
        }
        
        ddlNomenclature.Items.Insert(0, new ListItem("Select", "-1"));
    }

    private void populateNomenclature()
    {
        string strRunningNo = "1".PadLeft(Convert.ToInt16(ddlRunNoLen.SelectedValue), '0');
        string strListItemForDocument = txtDocPrefix.Text + ddlSeparator.SelectedValue + Session["brcd"].ToString() + ddlSeparator.SelectedValue + (ddlYearCode.SelectedValue == "Y" ? Session["FinYear"].ToString() : "") + ddlSeparator.SelectedValue + strRunningNo;
        string strListItemForBranch = Session["brcd"].ToString() + ddlSeparator.SelectedValue + txtDocPrefix.Text + ddlSeparator.SelectedValue + (ddlYearCode.SelectedValue == "Y" ? Session["FinYear"].ToString() : "") + ddlSeparator.SelectedValue + strRunningNo;
        string strListItemForYear = Session["brcd"].ToString() + ddlSeparator.SelectedValue + txtDocPrefix.Text + ddlSeparator.SelectedValue + (ddlYearCode.SelectedValue == "Y" ? Session["FinYear"].ToString().Substring(2, 2) : "") + strRunningNo;

        ddlNomenclature.Items.Add(new ListItem(strListItemForDocument, strListItemForDocument));
        ddlNomenclature.Items.Add(new ListItem(strListItemForBranch, strListItemForBranch));
        ddlNomenclature.Items.Add(new ListItem(strListItemForYear, strListItemForYear));
    }

    private void manageDocumentChange()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand("select Prefix, YearCodeReq, RunningNoLength, Seperator, NomenclatureType, ManualNoAllowed, DCRIntegrated, BackDatedAllow, BackDatedDays from WebX_Setup_Document_Nomenclature where document = '" + ddlDocument.SelectedValue + "'", sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsProcess = new DataSet();

            sqlDA.Fill(dsProcess);

            if (dsProcess.Tables[0].Rows.Count > 0)
            {
                txtDocPrefix.Text = dsProcess.Tables[0].Rows[0]["Prefix"].ToString();
                ddlDocPrefixSize.SelectedValue = txtDocPrefix.Text.Length.ToString();
                ddlYearCode.SelectedValue = dsProcess.Tables[0].Rows[0]["YearCodeReq"].ToString();
                ddlRunNoLen.SelectedValue = dsProcess.Tables[0].Rows[0]["RunningNoLength"].ToString();
                
                ddlSeparator.SelectedValue = dsProcess.Tables[0].Rows[0]["Seperator"].ToString().Trim();

                manageNomenclature();

                ddlNomenclature.SelectedIndex = Convert.ToInt32(dsProcess.Tables[0].Rows[0]["NomenclatureType"].ToString());
            }
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }
}
