using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Docket : System.Web.UI.Page
{
    protected string dkt_call;
    public static string PLPartner;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack && !IsCallback)
        {
            optselect.Items[0].Text = SessionUtilities.DocketCalledAs + " Number";
            applySettings();
            trDetails.Style["display"] = "none";
            processMessage.Visible = false;
            progressBackgroundFilter.Visible = false;
        }
    }
    protected void btnstep1_Click(object sender, EventArgs e)
    {
        try
        {
            WebxError werr = new WebxError();
            werr = validateStep1();
            ErrorControl(hdnerrorkeys.Value, false);
            progressBackgroundFilter.Visible = false;
            processMessage.Visible = false;

            if (werr.Key.CompareTo("") != 0)
            {
                applySettings();
                ErrorControl(werr.Key, true);
                progressBackgroundFilter.Visible = true;
                processMessage.Visible = true;
                lblalert.Text = werr.Message;
                return;
            }
            
            trHeader.Style["display"] = "none";
            trDetails.Style["display"] = "block";
            txtDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            
            if (optselect.SelectedIndex == 0)
            {
                trDock.Style["display"] = "block";
                trPLPartner.Style["display"] = "none";
                lblDockNO.Text = txtdockno.Text.Trim();   
            }
            else if (optselect.SelectedIndex == 1)
            {
                trDock.Style["display"] = "none";
                trPLPartner.Style["display"] = "block";
                lblmdockno.Text = txtmdockno.Text.Trim();
                PLPartner = txtPLPartner.Text.Trim();
                lblPLPartner.Text = txtPLPartner.Text.Trim() + " : " + txtPLPartnernm.Text.Trim();     
            }

            string strQ = "exec usp_Get_EnrouteStatusDocketDetails '" + optselect.SelectedIndex + "','" + txtdockno.Text.Trim() + "','" + txtmdockno.Text.Trim() + "','" + txtPLPartner.Text.Trim() + "'";
            DataTable dtstrQ = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ).Tables[0];
            if (dtstrQ.Rows.Count > 0)
            {
                lblConsignor.Text = dtstrQ.Rows[0]["Consignor"].ToString();
                lblConsignee.Text = dtstrQ.Rows[0]["Consignee"].ToString();
                lblOrigin.Text = dtstrQ.Rows[0]["Origin"].ToString();
                lblDestination.Text = dtstrQ.Rows[0]["Dest"].ToString();
            }
            txtTimeHH.Focus();  
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            WebxError werr = new WebxError();
            werr = validateSubmit();
            ErrorControl(hdnerrorkeys.Value, false);
            progressBackgroundFilter.Visible = false;
            processMessage.Visible = false;

            if (werr.Key.CompareTo("") != 0)
            {
                ErrorControl(werr.Key, true);
                progressBackgroundFilter.Visible = true;
                processMessage.Visible = true;
                lblalert.Text = werr.Message;
                return;
            }

            string strHHMM = txtTimeHH.Text.Trim() + ':' + txtTimeMM.Text.Trim();

            string strInsert = "usp_Webx_Enroute_Status_Docket_InsertData";
            SqlParameter[] parm = new SqlParameter[8];

            if (optselect.SelectedIndex == 0)
            {
                // parm[0] = ControllersHelper.GetSqlParameter("@VendorCode", SessionUtilities.DefaultCompanyCode, SqlDbType.VarChar);
                parm[0] = ControllersHelper.GetSqlParameter("@VendorCode", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
                parm[1] = ControllersHelper.GetSqlParameter("@DockNo", lblDockNO.Text.ToString(), SqlDbType.VarChar);
            }
            else if (optselect.SelectedIndex == 1)
            {
                parm[0] = ControllersHelper.GetSqlParameter("@VendorCode",PLPartner,SqlDbType.VarChar);
                parm[1] = ControllersHelper.GetSqlParameter("@DockNo", lblmdockno.Text.ToString(), SqlDbType.VarChar);
            }
            parm[2] = ControllersHelper.GetSqlParameter("@Date", DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy"), SqlDbType.DateTime);
            parm[3] = ControllersHelper.GetSqlParameter("@Time", strHHMM.ToString(), SqlDbType.VarChar);
            parm[4] = ControllersHelper.GetSqlParameter("@Location", txtLocation.Text.Trim(), SqlDbType.VarChar);
            parm[5] = ControllersHelper.GetSqlParameter("@Remarks", txtRemarks.Text.Trim(), SqlDbType.VarChar);
            parm[6] = ControllersHelper.GetSqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
			parm[7] = ControllersHelper.GetSqlParameter("@EntryType", "User Update", SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, strInsert, parm);

            if (optselect.SelectedIndex == 0)
            {
                Response.Redirect("Enroute_Status_Update_Docket_Done.aspx?DockNo=" + txtdockno.Text.Trim(), false);
            }
            else if (optselect.SelectedIndex == 1)
            {
                Response.Redirect("Enroute_Status_Update_Docket_Done.aspx?DockNo=" + txtmdockno.Text.Trim(), false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("ErrorPage.aspx?heading=Enroute Status Update Error&detail1=Enroute Status Update Error&detail2=" + Exc.Message.Replace('\n', '_'), false);            
        }
    }

    protected void applySettings()
    {
        if (optselect.SelectedValue == "CN")
        {
            txtdockno.Enabled = true;
            txtdockno.CssClass = "ltxtm";

            txtmdockno.Enabled = false;
            txtmdockno.CssClass = "ltxtd";
            txtmdockno.Text = "";
            txtPLPartner.Enabled = false;
            txtPLPartner.CssClass = "ltxtd";
            txtPLPartner.Text = "";
            txtPLPartnernm.Enabled = false;
            txtPLPartnernm.CssClass = "ltxtd";
            txtPLPartnernm.Text = "";
        }
        else if (optselect.SelectedValue == "MN")
        {
            txtmdockno.Enabled = true;
            txtmdockno.CssClass = "ltxtm";
            txtPLPartner.Enabled = true;
            txtPLPartner.CssClass = "ltxtm";
            txtPLPartnernm.CssClass = "ltxtm";

            txtdockno.Enabled = false;
            txtdockno.CssClass = "ltxtd";
            txtdockno.Text = "";
        }
    }
    protected WebxError validateStep1()
    {
        WebxError werr = new WebxError();
        werr.Key = "";
        werr.Message = "";

        if (optselect.SelectedIndex == 0)
        {
            if (txtdockno.Text.Trim().CompareTo("") == 0)
            {
                werr.Key = "SDOCKNO";
                werr.Message = "Enter " + SessionUtilities.DocketCalledAs + " no";
                return werr;
            }

            if (txtdockno.Text.Trim().CompareTo("") != 0)
            {
                DataTable dt = new DataTable();
                string strsql = "exec usp_check_validIntransit_docketno @DOCKNO='" + txtdockno.Text.Trim() + "',@OPTION='01'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
                if (dt.Rows.Count <= 0)
                {
                    werr.Key = "DKTSYS";
                    werr.Message = " Invalid " + SessionUtilities.DocketCalledAs + " No " + txtdockno.Text.Trim() + "";
                    return werr;
                }
                else
                {
                    DataTable dt1 = new DataTable();
                    string strsql1 = "exec usp_check_validIntransit_docketno @DOCKNO='" + txtdockno.Text.Trim() + "',@OPTION='02'";
                    dt1 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql1).Tables[0];
                    if (dt1.Rows.Count <= 0)
                    {
                        werr.Key = "DKTSYSDLV";
                        werr.Message = "" + SessionUtilities.DocketCalledAs + " No " + txtdockno.Text.Trim() + " is already Delivered";
                        return werr;
                    }
                }
            }
        }

        if (optselect.SelectedIndex == 1)
        {
            if (txtmdockno.Text.Trim().CompareTo("") == 0)
            {
                werr.Key = "SMDOCKNO";
                werr.Message = "Enter 3PL no";
                return werr;
            }

            if (txtPLPartner.Text.Trim().CompareTo("") == 0)
            {
                werr.Key = "SPLPART";
                werr.Message = "Enter 3PL Partner";
                return werr;
            }

            if ((txtmdockno.Text.Trim().CompareTo("") != 0) && (txtPLPartner.Text.Trim().CompareTo("") != 0))
            {
                DataTable dt = new DataTable();
                string strsql = "exec usp_check_validIntransit_docketno @MANUAL_DOCKNO='" + txtmdockno.Text.Trim() + "',@PL_PARTNER='" + txtPLPartner.Text.Trim() + "',@OPTION='03'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
                if (dt.Rows.Count <= 0)
                {
                    werr.Key = "SPLCOND";
                    werr.Message = "3PL No " + txtmdockno.Text.Trim() + " doesn't Exists for vendor " + txtPLPartner.Text.Trim() + ":" + txtPLPartnernm.Text.Trim() + "";
                    return werr;
                }
                else
                {
                    DataTable dt1 = new DataTable();
                    string strsql1 = "exec usp_check_validIntransit_docketno @MANUAL_DOCKNO='" + txtmdockno.Text.Trim() + "',@PL_PARTNER='" + txtPLPartner.Text.Trim() + "',@OPTION='04'";
                    dt1 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql1).Tables[0];
                    if (dt1.Rows.Count <= 0)
                    {
                        werr.Key = "SPLCONDDLV";
                        werr.Message = "3PL No " + txtmdockno.Text.Trim() + " for vendor " + txtPLPartner.Text.Trim() + ":" + txtPLPartnernm.Text.Trim() + " is already Delivered";
                        return werr;
                    }
                }
            }
        }
        return werr;
    }
    protected WebxError validateSubmit()
    {
        WebxError werr = new WebxError();
        werr.Key = "";
        werr.Message = "";

        if (txtDate.Text.Trim().CompareTo("") == 0)
        {
            werr.Key = "DATE";
            werr.Message = "Please enter Date";
            return werr;
        }

        if (txtTimeHH.Text.Trim().CompareTo("") == 0)
        {
            werr.Key = "HH";
            werr.Message = "Please enter Hour";
            return werr;
        }

        if (txtTimeMM.Text.Trim().CompareTo("") == 0)
        {
            werr.Key = "MM";
            werr.Message = "Please enter Minute";
            return werr;
        }

        if (txtDate.Text.Trim().CompareTo("") != 0 && txtTimeHH.Text.Trim().CompareTo("") != 0 && txtTimeMM.Text.Trim().CompareTo("") != 0)
        {
            string strsql = "";
            DataTable dt = new DataTable();
            if (optselect.SelectedIndex == 0)
                strsql = "SELECT top 1 LastUpdateDate = convert(varchar,Date,103) + ' ' + Time FROM Webx_Enroute_Status_Docket where DockNo='" + txtdockno.Text.Trim() + "' order by ID desc";
            else
                strsql = "SELECT top 1 LastUpdateDate = convert(varchar,Date,103) + ' ' + Time FROM Webx_Enroute_Status_Docket where VendorCode='" + txtPLPartner.Text.Trim() + "' and DockNo='" + txtmdockno.Text.Trim() + "' order by ID desc";

            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string LastUpdatedDate = dt.Rows[0]["LastUpdateDate"].ToString();
                string GenerationDate = txtDate.Text.Trim() + ' ' + txtTimeHH.Text.Trim() + ':' + txtTimeMM.Text.Trim();

                DataTable dtDateCompare = new DataTable();
                string strDateCompare = "select datediff(minute,convert(datetime,'" + LastUpdatedDate + "',103),convert(datetime,'" + GenerationDate + "',103)) as DateResult";
                dtDateCompare = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strDateCompare).Tables[0];
                if (dtDateCompare.Rows.Count > 0)
                {
                    if (Convert.ToInt32(dtDateCompare.Rows[0]["DateResult"].ToString()) < 0)
                    {
                        werr.Key = "DATECOMP";
                        werr.Message = "Date of Update " + GenerationDate + " Should be greater then Last Updated Date " + LastUpdatedDate + "";
                        return werr;
                    }
                }
            }
        }

        if (txtLocation.Text.Trim().CompareTo("") == 0)
        {
            werr.Key = "LOCATION";
            werr.Message = "Please enter Location";
            return werr;
        }

        return werr;
    }

    #region Error Handlers
    private TextBox ErrorAlert(TextBox txt)
    {
        txt.BackColor = System.Drawing.Color.FromName("#ff0000");
        txt.ForeColor = System.Drawing.Color.White;
        txt.Focus();
        return txt;
    }
    private DropDownList ErrorAlert(DropDownList ddl)
    {
        ddl.BackColor = System.Drawing.Color.FromName("#ff0000");
        ddl.ForeColor = System.Drawing.Color.White;
        return ddl;
    }
    private TextBox ClearError(TextBox txt)
    {
        txt.CssClass = "ltxtm";
        txt.ForeColor = System.Drawing.Color.Black;
        return txt;
    }
    private DropDownList ClearError(DropDownList ddl)
    {
        ddl.BackColor = System.Drawing.Color.White;
        ddl.ForeColor = System.Drawing.Color.Black;
        return ddl;
    }
    private void ErrorControl(string key, bool flag)
    {
        if (flag)
        {
            hdnerrorkeys.Value = key;
            switch (key)
            {
                case "SDOCKNO":
                    ErrorAlert(txtdockno);
                    break;
                case "SMDOCKNO":
                    ErrorAlert(txtmdockno);
                    break;
                case "SPLPART":
                    ErrorAlert(txtPLPartner);
                    break;
                case "SPLCOND":
                    ErrorAlert(txtmdockno);
                    break;
                case "DKTSYS":
                    ErrorAlert(txtdockno);
                    break;
                case "DKTSYSDLV":
                    ErrorAlert(txtdockno);
                    break;
                case "SPLCONDDLV":
                    ErrorAlert(txtmdockno);
                    break;
                case "DATE":
                    ErrorAlert(txtDate);
                    break;
                case "HH":
                    ErrorAlert(txtTimeHH);
                    break;
                case "MM":
                    ErrorAlert(txtTimeMM);
                    break;
                case "DATECOMP":
                    ErrorAlert(txtDate);
                    break;
                case "LOCATION":
                    ErrorAlert(txtLocation);
                    break;


            }
            return;
        }
        else
        {
            switch (hdnerrorkeys.Value)
            {
                case "SDOCKNO":
                    ClearError(txtdockno);
                    break;
                case "SMDOCKNO":
                    ClearError(txtmdockno);
                    break;
                case "SPLPART":
                    ClearError(txtPLPartner);
                    break;
                case "SPLCOND":
                    ClearError(txtmdockno);
                    break;
                case "DKTSYS":
                    ClearError(txtdockno);
                    break;
                case "DKTSYSDLV":
                    ClearError(txtdockno);
                    break;
                case "SPLCONDDLV":
                    ClearError(txtmdockno);
                    break;
                case "DATE":
                    ClearError(txtDate);
                    break;
                case "HH":
                    ClearError(txtTimeHH);
                    break;
                case "MM":
                    ClearError(txtTimeMM);
                    break;
                case "DATECOMP":
                    ClearError(txtDate);
                    break;
                case "LOCATION":
                    ClearError(txtLocation);
                    break;
            }
            hdnerrorkeys.Value = "";
        }
    }
    #endregion
}
