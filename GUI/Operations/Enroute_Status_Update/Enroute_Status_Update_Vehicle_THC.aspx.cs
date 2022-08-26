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

public partial class GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Vehicle_THC : System.Web.UI.Page
{
    protected string dkt_call;
    public static string Type;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = SessionUtilities.DocketCalledAs;
        Type = Request.QueryString["Type"].ToString();
        if (!IsPostBack && !IsCallback)
        {
            if (Type == "2")
            {
                trVehicle.Style["display"] = "none";
                trTHCNo.Style["display"] = "block";
                txtTHCNo.Focus();  
            }
            else if (Type == "3")
            {
                trVehicle.Style["display"] = "block";
                trTHCNo.Style["display"] = "none";
                txtVehicleNo.Focus();  
            }

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
                ErrorControl(werr.Key, true);
                progressBackgroundFilter.Visible = true;
                processMessage.Visible = true;
                lblalert.Text = werr.Message;
                return;
            }

            trHeader.Style["display"] = "none";
            trDetails.Style["display"] = "block";
            txtDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");

            ddlMovementStatus.DataSource = DataProvider.GetActiveGeneralMaster("MOVST");
            ddlMovementStatus.DataTextField = "codedesc";
            ddlMovementStatus.DataValueField = "codeid";
            ddlMovementStatus.DataBind();

            ddlAwaitingAction.DataSource = DataProvider.GetActiveGeneralMaster("AWTAC");
            ddlAwaitingAction.DataTextField = "codedesc";
            ddlAwaitingAction.DataValueField = "codeid";
            ddlAwaitingAction.DataBind();

            if (Type == "2")
            {
                string StrTHCNo = "select thcno,vehno,driver1,DRIVER1LICNOMOB from WebX_THC_Summary where thcno = '" + txtTHCNo.Text.Trim() + "'";
                DataTable dtTHCNo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, StrTHCNo).Tables[0];
                if (dtTHCNo.Rows.Count > 0)
                {
                    lblVehicleNo.Text = dtTHCNo.Rows[0]["vehno"].ToString();
                    lblTHCNo.Text = dtTHCNo.Rows[0]["thcno"].ToString();
                    lblDriver.Text = dtTHCNo.Rows[0]["driver1"].ToString();
                    lblMobile.Text = dtTHCNo.Rows[0]["DRIVER1LICNOMOB"].ToString();
                }
            }
            else if (Type == "3")
            {
                string StrTHCNo = "select top 1 * from usp_Enroute_getTHCDetails where CNT='0' and vehno='" + txtVehicleNo.Text.Trim() + "' order by thcnew_entrydt desc";
                DataTable dtTHCNo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, StrTHCNo).Tables[0];
                if (dtTHCNo.Rows.Count > 0)
                {
                    lblTHCNo.Text = dtTHCNo.Rows[0]["thcno"].ToString();                    
                    lblVehicleNo.Text = dtTHCNo.Rows[0]["vehno"].ToString();
                    lblDriver.Text = dtTHCNo.Rows[0]["driver1"].ToString();
                    lblMobile.Text = dtTHCNo.Rows[0]["DRIVER1LICNOMOB"].ToString();
                }
                else
                {
                    lblVehicleNo.Text = txtVehicleNo.Text.Trim();
                    lblTHCNo.Text = SessionUtilities.THCCalledAs + " not found";
                    lblDriver.Text = "NA";
                    lblMobile.Text = "NA";
                }
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

            string strInsert = "usp_Webx_Enroute_Status_THC_Vehicle_InsertData";
            SqlParameter[] parm = new SqlParameter[14];
            // parm[0] = ControllersHelper.GetSqlParameter("@VendorCode", SessionUtilities.DefaultCompanyCode, SqlDbType.VarChar);
            parm[0] = ControllersHelper.GetSqlParameter("@VendorCode", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
            parm[1] = ControllersHelper.GetSqlParameter("@THCNO", lblTHCNo.Text.ToString(), SqlDbType.VarChar);
            parm[2] = ControllersHelper.GetSqlParameter("@VehicleNo", lblVehicleNo.Text.ToString(), SqlDbType.VarChar);
            parm[3] = ControllersHelper.GetSqlParameter("@Driver", lblDriver.Text.ToString(), SqlDbType.VarChar);
            parm[4] = ControllersHelper.GetSqlParameter("@MobileNo", lblMobile.Text.ToString(), SqlDbType.VarChar);            
            parm[5] = ControllersHelper.GetSqlParameter("@Date", DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy"), SqlDbType.DateTime);
            parm[6] = ControllersHelper.GetSqlParameter("@Time", strHHMM.ToString(), SqlDbType.VarChar);
            parm[7] = ControllersHelper.GetSqlParameter("@Location", txtLocation.Text.Trim(), SqlDbType.VarChar);
            parm[8] = ControllersHelper.GetSqlParameter("@Remarks", txtRemarks.Text.Trim(), SqlDbType.VarChar);
            parm[9] = ControllersHelper.GetSqlParameter("@MovementStatus",ddlMovementStatus.SelectedValue,SqlDbType.VarChar);
            parm[10] = ControllersHelper.GetSqlParameter("@Awaitingaction", ddlAwaitingAction.SelectedValue, SqlDbType.VarChar);
            parm[11] = ControllersHelper.GetSqlParameter("@Days", txtDays.Text.Trim(), SqlDbType.VarChar);            
            parm[12] = ControllersHelper.GetSqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
			parm[13] = ControllersHelper.GetSqlParameter("@EntryType", "User Update", SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, strInsert, parm);
            if(Type=="2") 
                Response.Redirect("Enroute_Status_Update_Vehicle_THC_Done.aspx?No=" + lblTHCNo.Text.Trim() +"&Type=2", false);
            else if (Type == "3")
                Response.Redirect("Enroute_Status_Update_Vehicle_THC_Done.aspx?No=" + lblVehicleNo.Text.Trim() + "&Type=3", false);
        }
        catch (Exception Exc)
        {
            Response.Redirect("ErrorPage.aspx?heading=Enroute Status Update Error&detail1=Enroute Status Update Error&detail2=" + Exc.Message.Replace('\n', '_'), false);
        }
    }
    protected WebxError validateStep1()
    {
        WebxError werr = new WebxError();
        werr.Key = "";
        werr.Message = "";

        if (Type == "2")
        {
            if (txtTHCNo.Text.Trim().CompareTo("") == 0)
            {
                werr.Key = "THCNO";
                werr.Message = "Please enter " + SessionUtilities.THCCalledAs + " no";
                return werr;
            }
            if (txtTHCNo.Text.Trim().CompareTo("") != 0)
            {
                string strQ = "select * from usp_Enroute_getTHCDetails where thcno = '" + txtTHCNo.Text.Trim() + "'";
                DataTable dtstrQ = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ).Tables[0];
                if (dtstrQ.Rows.Count > 0)
                {
                    if (dtstrQ.Rows[0]["cnt"].ToString() != "0")
                    {
                        werr.Key = "THC";
                        werr.Message = "Please enter In trasit " + SessionUtilities.THCCalledAs + " only ";
                        return werr;
                    }
                }
                else
                {
                    werr.Key = "THC";
                    werr.Message = "Invalid " + SessionUtilities.THCCalledAs + " no : " + txtTHCNo.Text.Trim() + "";
                    return werr;
                }
            }
        }

        else if (Type == "3")
        {
            if (txtVehicleNo.Text.Trim().CompareTo("") == 0)
            {
                werr.Key = "VEHNO";
                werr.Message = "Please enter Vehicle no";
                return werr;
            }
            if (txtVehicleNo.Text.Trim().CompareTo("") != 0)
            {
                string strQ = "select CNT=COUNT(*) from webx_VEHICLE_HDR where VEHNO = '" + txtVehicleNo.Text.Trim() + "'";
                DataTable dtstrQ = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ).Tables[0];
                if (dtstrQ.Rows.Count > 0)
                {
                    if (dtstrQ.Rows[0]["CNT"].ToString() == "0")
                    {
                        werr.Key = "VEH";
                        werr.Message = "Invalid vehicle no : " + txtVehicleNo.Text.Trim();
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
            if(Type == "2")
                strsql = "SELECT top 1 LastUpdateDate = convert(varchar,Date,103) + ' ' + Time FROM Webx_Enroute_Status_THC_Vehicle where THCNO='" + lblTHCNo.Text.Trim() + "' and VehicleNo='" + lblVehicleNo.Text.Trim() + "' order by ID desc";
            else if (Type == "3")
                strsql = "SELECT top 1 LastUpdateDate = convert(varchar,Date,103) + ' ' + Time FROM Webx_Enroute_Status_THC_Vehicle where VehicleNo='" + lblVehicleNo.Text.Trim() + "' order by ID desc";

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

        //if (txtRemarks.Text.Trim().CompareTo("") == 0)
        //{
        //    werr.Key = "REMARK";
        //    werr.Message = "Please enter Remarks";
        //    return werr;
        //}

        if (txtDays.Text.Trim().CompareTo("") == 0)
        {
            werr.Key = "DAYS";
            werr.Message = "Please enter Days since last action";
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
                case "THCNO":
                    ErrorAlert(txtTHCNo);
                    break;
                case "THC":
                    ErrorAlert(txtTHCNo);
                    break;
                case "VEHNO":
                    ErrorAlert(txtVehicleNo);
                    break;
                case "VEH":
                    ErrorAlert(txtVehicleNo);
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
                case "REMARK":
                    ErrorAlert(txtRemarks);
                    break;
                case "DAYS":
                    ErrorAlert(txtDays);
                    break;
            }
            return;
        }
        else
        {
            switch (hdnerrorkeys.Value)
            {
                case "THCNO":
                    ClearError(txtTHCNo);
                    break;
                case "THC":
                    ClearError(txtTHCNo);
                    break;
                case "VEHNO":
                    ClearError(txtVehicleNo);
                    break;
                case "VEH":
                    ClearError(txtVehicleNo);
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
                case "REMARK":
                    ClearError(txtRemarks);
                    break;
                case "DAYS":
                    ClearError(txtDays);
                    break;
            }
            hdnerrorkeys.Value = "";
        }
    }
    #endregion
}
