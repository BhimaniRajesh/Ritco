using System;
using System.Xml;
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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_StateMaster_StateMaster : System.Web.UI.Page
{
    #region Variable[s]
    private bool _isRedirect = false;
    private string _errorMessage = string.Empty;
    private static string stateCode = string.Empty;
    StateMasterController objStateMaster = new StateMasterController();
    DataTable dtStateMaster = new DataTable();
    #endregion

    #region Event[e]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                bindRateTypeDDL();


                if (Request.QueryString["state"] != null)
                {
                    if (Request.QueryString["Flag"] == "Edit")
                    {

                        stateCode = Request.QueryString["state"].ToString();

                        dtStateMaster = objStateMaster.getStateHdr(stateCode);
                        lblStateCode.Text = dtStateMaster.Rows[0]["stcd"].ToString();
                        txtstatename.Text = dtStateMaster.Rows[0]["stnm"].ToString();
                        txtfreightrate.Text = dtStateMaster.Rows[0]["frt_rate"].ToString();
                        ddlratetype.SelectedValue = dtStateMaster.Rows[0]["rate_type"].ToString();

                        hdnstatnm.Value = txtstatename.Text.Trim();


                        if (dtStateMaster.Rows[0]["activeflag"].ToString() == "Y")
                        {
                            chkStateactiveflag.Checked = true;
                        }
                        else
                        {
                            chkStateactiveflag.Checked = false;
                        }

                        if (dtStateMaster.Rows[0]["stax_exmpt_yn"].ToString() == "Y")
                        {
                            chkSTaxFlag.Checked = true;
                        }
                        else
                        {
                            chkSTaxFlag.Checked = false;
                        }

                        ddlStatetype.SelectedValue = dtStateMaster.Rows[0]["StateType"].ToString();
                        txtStateCode.Text = Convert.ToString(dtStateMaster.Rows[0]["StateCode"]);
                        addRows(0, true);

                    }
                }
                else
                {
                    stateCode = string.Empty;
                    addRows(1, true);
                }

            }
            txtstatename.Focus();
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnaddrows_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtnorows.Text.Trim()))
            {
                if (string.IsNullOrEmpty(stateCode))
                    addRows(Convert.ToInt32(txtnorows.Text), false);
                else
                    addRows(Convert.ToInt32(txtnorows.Text), true);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in adding rows.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string nextStateCode = string.Empty;
        bool isFirstRecord = true;

        State state = new State();

        try
        {
            Validation();

            if (string.IsNullOrEmpty(_errorMessage))
            {
                if (Request.QueryString["Flag"] == "Add")
                {
                    if (isFirstRecord)
                    {
                        nextStateCode = objStateMaster.getNextStateCode().ToString();

                        if (nextStateCode.Length <= 1)
                            nextStateCode = "0" + nextStateCode.Trim();
                    }

                    stateCode = nextStateCode;
                }
                else
                {
                    state.Code = lblStateCode.Text.ToString();
                }
                state.Code = stateCode;
                state.Name = txtstatename.Text.Trim();
                state.FreightRate = txtfreightrate.Text != "" ? Convert.ToDecimal(txtfreightrate.Text) : Convert.ToDecimal("0");
                state.FreightRateType = ddlratetype.SelectedValue.ToString();
                state.ActiveFlag = chkStateactiveflag.Checked == true ? "Y" : "N";
                state.ServiceTaxFlag = chkSTaxFlag.Checked == true ? "Y" : "N";
                state.StateType = ddlStatetype.SelectedValue;
                state.StateCode = txtStateCode.Text;

                if (Request.QueryString["Flag"] != null)
                {
                    if (Request.QueryString["Flag"] == "Edit")
                    {
                        state.UpdateBy = Session["empcd"].ToString();
                        state.UpdateDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));
                    }
                    else
                    {
                        state.EntryBy = Session["empcd"].ToString();
                        state.UpdateBy = Session["empcd"].ToString();
                        state.EntryDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));

                    }
                }
                StateDocument[] stateDocument = new StateDocument[grvstate.Rows.Count];

                int i = 0;

                foreach (GridViewRow gridrow in grvstate.Rows)
                {
                    stateDocument[i] = new StateDocument();

                    CheckBox chkyes = (CheckBox)gridrow.FindControl("chkyes");
                    TextBox txtDocument = (TextBox)gridrow.FindControl("txtdocument");
                    DropDownList ddlbound = (DropDownList)gridrow.FindControl("ddlbound");


                    if (chkyes.Checked == true)
                    {
                        stateDocument[i].FlagInsert = "Y";
                    }
                    else
                        stateDocument[i].FlagInsert = "N";

                    _isRedirect = true;

                    stateDocument[i].Code = stateCode;
                    stateDocument[i].Form = txtDocument.Text.Trim();
                    stateDocument[i].Require = "";
                    stateDocument[i].InOutBound = ddlbound.SelectedValue;
                    stateDocument[i].Permit = "";
                    stateDocument[i].Strem = "";

                    i++;


                }
                StateMasterController.InsertState(state, stateDocument);

                if (Request.QueryString["Flag"] != null)
                {
                    if (Request.QueryString["Flag"] == "Edit")
                    {
                        Response.Redirect("StateMasterDone.aspx?Flag=Edit&state=" + lblStateCode.Text.Trim().ToString(), false);
                    }
                    else
                    {
                        Response.Redirect("StateMasterDone.aspx?Flag=Add&state=" + nextStateCode, false);
                    }
                }
                else
                {
                    Response.Redirect("StateMasterDone.aspx?Flag=Add&state=" + nextStateCode, false);
                }
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + _errorMessage, false);
            }


        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void grvstate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(stateCode))
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                    CheckBox chkyes = (CheckBox)e.Row.FindControl("chkyes");
                    DropDownList ddlBound = (DropDownList)e.Row.FindControl("ddlbound");
                    HiddenField hdnbound = (HiddenField)e.Row.FindControl("hdnbound");
                    TextBox txtDocument = (TextBox)e.Row.FindControl("txtDocument");
                    chkyes.Checked = true;
                    if (dtStateMaster != null && dtStateMaster.Rows.Count > 0)
                    {

                        ddlBound.SelectedValue = Convert.ToString(dtStateMaster.Rows[e.Row.RowIndex]["inoutbound"]);
                        txtDocument.Text = Convert.ToString(dtStateMaster.Rows[e.Row.RowIndex]["STFORM"]);


                    }
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        bool isOne = false;
        _errorMessage = string.Empty;

        try
        {
            if (string.IsNullOrEmpty(txtstatename.Text))
            {
                _errorMessage = "Please enter state Name.";
                return;
            }
            else if (string.IsNullOrEmpty(txtStateCode.Text))
            {
                _errorMessage = "Please enter state Code.";
                return;
            }
            else if (!string.IsNullOrEmpty(txtStateCode.Text))
            {
                if (DataValidations.IsValidManualStateCode(txtStateCode.Text.Trim(),lblStateCode.Text))
                {
                    _errorMessage = "State Code Already Exists.";
                    return;
                }
            }
            else
            {
                if (Request.QueryString["Flag"] != null)
                {
                    if (Request.QueryString["Flag"] != "Edit")
                    {
                        if (DataValidations.IsValidState(txtstatename.Text.Trim()))
                        {
                            _errorMessage = "State Name Already Exists.";
                            return;
                        }
                    }
                }
            }

            foreach (GridViewRow gridrow in grvstate.Rows)
            {
                CheckBox chkyes = (CheckBox)gridrow.FindControl("chkyes");
                TextBox txtDocument = (TextBox)gridrow.FindControl("txtdocument");
                DropDownList ddlbound = (DropDownList)gridrow.FindControl("ddlbound");

                if (chkyes.Checked == true)
                {
                    isOne = true;
                    if (string.IsNullOrEmpty(txtDocument.Text))
                    {
                        _errorMessage = "Please Enter Document Name.";
                        return;
                    }

                    if (ddlbound.SelectedValue == "0")
                    {
                        _errorMessage = "Please Select I/O Bound.";
                        return;
                    }
                }
            }

            //if (!isOne)
            //{
            //    _errorMessage = "Please enter atleast one document.";
            //    return;
            //}


        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void bindRateTypeDDL()
    {
        try
        {
            StateMasterController objStateMaster = new StateMasterController();
            DataTable dtRateType = new DataTable();

            ddlratetype.Items.Clear();

            dtRateType = objStateMaster.getRateType();

            if (dtRateType != null && dtRateType.Rows.Count > 0)
            {
                ddlratetype.DataTextField = "RateType";
                ddlratetype.DataValueField = "RateCode";
                ddlratetype.DataSource = dtRateType;
                ddlratetype.DataBind();
                ddlratetype.Items.Insert(0, new ListItem("Select", "0"));
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void addRows(int numRows, bool isEdit)
    {
        try
        {
            if (isEdit)
                getData(stateCode);

            for (int i = 0; i < numRows; i++)
            {
                dtStateMaster.Rows.Add();
            }

            grvstate.DataSource = dtStateMaster;
            grvstate.DataBind();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    public void getData(string stateCode)
    {
        try
        {
            if (!string.IsNullOrEmpty(stateCode))
            {
                dtStateMaster = objStateMaster.getStateDocument(stateCode);
            }

        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}
