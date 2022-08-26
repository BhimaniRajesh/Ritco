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

public partial class GUI_admin_WebXPressRules_Step3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDocumentDetails();

            displayProcessDetails();
        }

        lblDocketGeneration.InnerHtml = "&nbsp;" + HidDocket.Value + " Generation";
        lblLSGeneration.InnerHtml = "&nbsp;" + HidLS.Value + " Generation";
        lblMFGeneration.InnerHtml = "&nbsp;" + HidMF.Value + " Generation";
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
    protected void ddlDocketGeneration_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageDocketGenerationChange();
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
            sqlCommand.CommandText = "WebX_SP_Manage_Rules_Step3";

            sqlCommand.Parameters.AddWithValue("@Docket_Generation_Steps", ddlDocketGeneration.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@LS_Required", ddlLSGeneration.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@MF_Of_Quick_Docket", (ddlMFGeneration.Visible == true ? ddlMFGeneration.SelectedValue : "0"));

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

    private void displayProcessDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand("select Docket_Generation_Steps, LS_Required, MF_Of_Quick_Docket from webx_setup_process", sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsProcess = new DataSet();

            sqlDA.Fill(dsProcess);

            if (dsProcess.Tables[0].Rows.Count > 0)
            {
                ddlDocketGeneration.SelectedValue = dsProcess.Tables[0].Rows[0]["Docket_Generation_Steps"].ToString();
                ddlLSGeneration.SelectedValue = dsProcess.Tables[0].Rows[0]["LS_Required"].ToString();
                
                manageDocketGenerationChange();
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

    private void manageDocketGenerationChange()
    {
        if (ddlDocketGeneration.SelectedIndex == -1)
        {
            ddlMFGeneration.Visible = false;
            lblMFGenNA.Visible = false;
        }
        else
        {
            lblMFGenNA.Visible = true;
            if (ddlDocketGeneration.SelectedIndex == 1)
            {
                ddlMFGeneration.Visible = false;
                lblMFGenNA.InnerHtml = "NA";
            }
            else
            {
                ddlMFGeneration.Visible = true;
                lblMFGenNA.InnerHtml = "Allow Operationally Incomplete " + HidDocket.Value + "s?";
            }

        }
    }
}
