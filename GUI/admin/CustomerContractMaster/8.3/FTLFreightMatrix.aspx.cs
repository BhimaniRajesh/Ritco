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
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;
using System.Xml;
public partial class GUI_Admin_CustomerContractMaster_FTLFreightMatrix : System.Web.UI.Page
{
    string[] arrzonename;
    string[] arrzonecode;
    int zoneno = 0;
    WebxError werror = new WebxError();
    private DataTable dtcharges
    {
        get { return (ViewState["dtcharges"] != null) ? ViewState["dtcharges"] as DataTable : new DataTable(); }
        set { ViewState["dtcharges"] = value; }
    }

    private DataTable TransMode
    {
        get { return (ViewState["dttranmodes"] != null) ? ViewState["dttranmodes"] as DataTable : new DataTable(); }
        set { ViewState["dttranmodes"] = value; }
    }

    private DataTable FTLType
    {
        get { return (ViewState["dtftltype"] != null) ? ViewState["dtftltype"] as DataTable : new DataTable(); }
        set { ViewState["dtftltype"] = value; }
    }

    private DataTable RateType
    {
        get { return (ViewState["dtratetype"] != null) ? ViewState["dtratetype"] as DataTable : new DataTable(); }
        set { ViewState["dtratetype"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();

        cstheader.CustCode = hdncustcode.Value;
        cstheader.ContractID = hdncontractid.Value;

        hdntransmode.Value = Request.QueryString["transmode"].ToString();
        hdnmatrixtype.Value = Request.QueryString["matrixtype"].ToString();

        hdnfrom.Value = Request.QueryString["from"].ToString();
        hdnto.Value = Request.QueryString["to"].ToString();

        nvpMain.CustCode = hdncustcode.Value;
        nvpMain.ContractID = hdncontractid.Value;

        if (!IsPostBack)
        {
            umsg.Hide();

            hdnbasedon1.Value = Request.QueryString["basedon1"].ToString();
            hdnbasecode1.Value = Request.QueryString["basecode1"].ToString();
            hdnbasedon2.Value = Request.QueryString["basedon2"].ToString();
            hdnbasecode2.Value = Request.QueryString["basecode2"].ToString();


            if (hdnbasedon1.Value.CompareTo("NONE") == 0)
            {
                trbasedon1.Style["display"] = "none";
                trbasedon2.Style["display"] = "none";
                trbasedon1.Style["display"] = "none";
                trbasedon2.Style["display"] = "none";
            }
            else
            {
                lblbasedon1.Text = DataProvider.GetCodeTypeName(hdnbasedon1.Value);
                lblbasecode1.Text = DataProvider.GetGeneralMasterName(hdnbasedon1.Value, hdnbasecode1.Value);
            }

            if (hdnbasedon2.Value.CompareTo("NONE") == 0)
            {
                trbasedon2.Style["display"] = "none";
            }
            else
            {
                lblbasedon2.Text = DataProvider.GetCodeTypeName(hdnbasedon2.Value);
                lblbasecode2.Text = DataProvider.GetGeneralMasterName(hdnbasedon2.Value, hdnbasecode2.Value);
            }

            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                lblmatrixtype.Text = "City - City";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                lblmatrixtype.Text = "Locaton - Location";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                lblmatrixtype.Text = "Zone - Zone";

            lbltransmode.Text = DataProvider.GetGeneralMasterName("TRN", hdntransmode.Value);
            lblfilterfrom.Text = hdnfrom.Value;
            lblfilterto.Text = hdnto.Value;
            if (Request.QueryString["ftltype"].ToString() == "A")
                lblftltype.Text = "ALL";
            else
                lblftltype.Text = DataProvider.GetGeneralMasterName("FTLTYP", Request.QueryString["ftltype"].ToString());

            TransMode = CCMController.GetContractTransMode(hdncontractid.Value);
            FTLType = DataProvider.GetActiveGeneralMaster("FTLTYP");
            RateType = CCMController.GetContractRateType(hdncontractid.Value);


            dtcharges = new DataTable();
            string strsql = "";
            strsql = "SELECT ";
            if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=from_loccode) AS from_loccode,";
                strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=to_loccode) AS to_loccode,";
            }
            else
            {
                strsql = strsql + "from_loccode,to_loccode,";
            }
            strsql = strsql + "BillLoc,ftl1_trip_rate,ftl1_trip_ratetype,ftl1_trdays,trans_type,ftltype,ftltype AS oldftltype";
            strsql = strsql + " FROM dbo.webx_custcontract_frtmatrix_ftlslabhdr";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value.ToString() + "'";
            strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "' AND trans_type='" + hdntransmode.Value + "'";
            if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=from_loccode) LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=to_loccode) LIKE '" + hdnto.Value + "%'";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0 || hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                strsql = strsql + " AND from_loccode LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND to_loccode LIKE '" + hdnto.Value + "%'";
            }
            if (Convert.ToString(Request.QueryString["ftltype"]) != "A")
                strsql = strsql + " AND ftltype='" + Convert.ToString(Request.QueryString["ftltype"]) + "'";

            dtcharges = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            if (dtcharges.Rows.Count <= 0)
                dtcharges.Rows.Add();

            hdnBillLocRule.Value = CCMServicesController.GetCCMBillLocRule(hdncontractid.Value);
            if (CCMServicesController.GetCCMBillLocRule(hdncontractid.Value) == "3")
                grvcharges.Columns[8].Visible = true;
            else
                grvcharges.Columns[8].Visible = false;

            grvcharges.DataSource = dtcharges;
            grvcharges.DataBind();

        }
    }


    protected void btnaddrows_Click(object sender, EventArgs e)
    {
        int rows = 0;
        try
        {
            rows = Convert.ToInt16(txtrows.Text);
        }
        catch (Exception ex)
        {

        }


        DataTable dt = new DataTable();
        dt.Columns.Add("from_loccode", typeof(string));
        dt.Columns.Add("to_loccode", typeof(string));
        dt.Columns.Add("oldftltype", typeof(string));
        dt.Columns.Add("ftltype", typeof(string));
        dt.Columns.Add("ftl1_trip_rate", typeof(string));
        dt.Columns.Add("ftl1_trip_ratetype", typeof(string));
        dt.Columns.Add("ftl1_trdays", typeof(string));
        dt.Columns.Add("trans_type", typeof(string));


        dt.Columns.Add("BillLoc", typeof(string));



        foreach (GridViewRow gr in grvcharges.Rows)
        {
            TextBox txtfrom = (TextBox)gr.FindControl("txtfrom");
            TextBox txtto = (TextBox)gr.FindControl("txtto");
            TextBox txtrate = (TextBox)gr.FindControl("txtrate");
            TextBox txttrdays = (TextBox)gr.FindControl("txttrdays");
            DropDownList ddlratetype = (DropDownList)gr.FindControl("ddlratetype");
            DropDownList ddltransmode = (DropDownList)gr.FindControl("ddltransmode");
            DropDownList ddlftltype = (DropDownList)gr.FindControl("ddlftltype");
            HiddenField hdnoldftltype = (HiddenField)gr.FindControl("hdnoldftltype");
            TextBox txtBillingLoc = (TextBox)gr.FindControl("txtBillingLoc");

            DataRow dr = dt.NewRow();
            dr["from_loccode"] = txtfrom.Text;
            dr["to_loccode"] = txtto.Text;
            dr["ftltype"] = ddlftltype.SelectedValue;
            dr["oldftltype"] = hdnoldftltype.Value;
            dr["ftl1_trip_rate"] = txtrate.Text;
            dr["ftl1_trdays"] = txttrdays.Text;
            dr["ftl1_trip_ratetype"] = ddlratetype.SelectedValue;
            dr["trans_type"] = ddltransmode.SelectedValue;
            dr["BillLoc"] = txtBillingLoc.Text;

            dt.Rows.Add(dr);
        }

        for (int i = 0; i < rows; i++)
        {
            dt.Rows.Add();
        }
        if (dt.Rows.Count == 0)
            dt.Rows.Add();

        grvcharges.DataSource = dt;
        grvcharges.DataBind();
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {

            string loctype = "";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                loctype = "city";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                loctype = "branch";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                loctype = "zone";
            }

            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");
            HtmlInputButton btnBillLoc = (HtmlInputButton)e.Row.FindControl("btnBillLoc");
            btnfrom.Attributes.Add("onclick", "javascript:return windowHeadPopUp('" + loctype + "','txtfrom','grvcharges','4row')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtto','grvcharges','4row')");
            //btnBillLoc.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtBillingLoc','grvcharges','4row')");
            DropDownList ddlftltype = (DropDownList)e.Row.FindControl("ddlftltype");
            DropDownList ddltransmode = (DropDownList)e.Row.FindControl("ddltransmode");
            DropDownList ddlratetype = (DropDownList)e.Row.FindControl("ddlratetype");


            ddlftltype.DataSource = FTLType;
            ddlftltype.DataBind();

            ddltransmode.DataSource = TransMode;
            ddltransmode.DataBind();

            ddlratetype.DataSource = RateType;
            ddlratetype.DataBind();

        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkyes");
            chk.Checked = true;

            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");
            TextBox txtBillingLoc = (TextBox)e.Row.FindControl("txtBillingLoc");
            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");
            HtmlInputButton btnBillLoc = (HtmlInputButton)e.Row.FindControl("btnBillLoc");
            ContractComplete cacFrom = (ContractComplete)e.Row.FindControl("cactxtfrom");
            ContractComplete cacTo = (ContractComplete)e.Row.FindControl("cactxtto");

            ContractComplete cacBillLoc = (ContractComplete)e.Row.FindControl("cacBillLoc");

            string testtype = "", loctype = "";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                testtype = "citytest"; loctype = "city";
                cacFrom.ContractEntity = ContractEntities.City;
                cacTo.ContractEntity = ContractEntities.City;
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                testtype = "loctest"; loctype = "branch";
                cacFrom.ContractEntity = ContractEntities.Branch;
                cacFrom.FilterString = "3456789";
                cacTo.ContractEntity = ContractEntities.Branch;
                cacTo.FilterString = "3456789";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                testtype = "zonetest"; loctype = "zone";
                cacFrom.ContractEntity = ContractEntities.Region;
                cacTo.ContractEntity = ContractEntities.Region;
            }

            DropDownList ddltransmode = (DropDownList)e.Row.FindControl("ddltransmode");
            DropDownList ddlratetype = (DropDownList)e.Row.FindControl("ddlratetype");
            DropDownList ddlftltype = (DropDownList)e.Row.FindControl("ddlftltype");

            ddlftltype.DataSource = FTLType;
            ddlftltype.DataBind();

            ddltransmode.DataSource = TransMode;
            ddltransmode.DataBind();

            ddlratetype.DataSource = RateType;
            ddlratetype.DataBind();

            ddltransmode.SelectedValue = DataBinder.Eval(e.Row.DataItem, "trans_type").ToString();
            ddlratetype.SelectedValue = DataBinder.Eval(e.Row.DataItem, "ftl1_trip_ratetype").ToString();
            ddlftltype.SelectedValue = DataBinder.Eval(e.Row.DataItem, "ftltype").ToString();


            // txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            // txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            // btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtfrom.ClientID.ToString() + "','none')");
            // btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtto.ClientID.ToString() + "','none')");
        }
    }

    protected void ddlftltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlHeaderftltype = (DropDownList)sender;
        foreach (GridViewRow grv in grvcharges.Rows)
        {

            DropDownList ddlftltype = (DropDownList)grv.FindControl("ddlftltype");
            ddlftltype.SelectedValue = ddlHeaderftltype.SelectedValue;
        }
    }

    protected void ddltransmode_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlHeadertransmode = (DropDownList)sender;
        foreach (GridViewRow grv in grvcharges.Rows)
        {

            DropDownList ddltransmode = (DropDownList)grv.FindControl("ddltransmode");
            ddltransmode.SelectedValue = ddlHeadertransmode.SelectedValue;
        }
    }

    protected void ddlratetype_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlHeaderratetype = (DropDownList)sender;
        foreach (GridViewRow grv in grvcharges.Rows)
        {

            DropDownList ddlratetype = (DropDownList)grv.FindControl("ddlratetype");
            ddlratetype.SelectedValue = ddlHeaderratetype.SelectedValue;
        }
    }


    protected void SaveContractInformation()
    { SubmitData(); }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SubmitData();
        if (werror.Key == "")
        {
            Response.Redirect("CCM_DisplayResult.aspx?contractid=" + hdncontractid.Value + "&custcode=" + hdncustcode.Value);

        }
        else
        {

            string[] ErrorMessage = werror.Message.ToString().Trim().Split('|');

            umsg.Show("Message", ErrorMessage[0].Trim());

            if (ErrorMessage[1] == "From")
            {
                TextBox txtfrom = (TextBox)grvcharges.Rows[Convert.ToInt32(werror.Key)].FindControl("txtfrom");
                txtfrom.CssClass = "ltxte";
                txtfrom.Focus();
            }
            if (ErrorMessage[1] == "To")
            {
                TextBox txtto = (TextBox)grvcharges.Rows[Convert.ToInt32(werror.Key)].FindControl("txtto");
                txtto.CssClass = "ltxte";
                txtto.Focus();
            }

            if (hdnBillLocRule.Value == "3")
            {
                if (ErrorMessage[1] == "BillLoc")
                {
                    TextBox txtBillingLoc = (TextBox)grvcharges.Rows[Convert.ToInt32(werror.Key)].FindControl("txtBillingLoc");
                    txtBillingLoc.CssClass = "ltxte";
                    txtBillingLoc.Focus();
                }
            }
            return;
        }


    }

    protected void btnsubmitclear_Click(object sender, EventArgs e)
    {
        SubmitData();

        dtcharges.Rows.Clear();
        dtcharges.Rows.Add();

        grvcharges.DataSource = dtcharges;
        grvcharges.DataBind();
    }

    private void SubmitData()
    {


        DataTable dtZone = DataProvider.GetActiveGeneralMaster("ZONE");

        arrzonename = new string[dtZone.Rows.Count];
        arrzonecode = new string[dtZone.Rows.Count];

        if (dtZone.Rows.Count > 0)
            for (int i = 0; i < dtZone.Rows.Count; i++)
            {
                arrzonecode[i] = dtZone.Rows[i]["codeid"].ToString();
                arrzonename[i] = dtZone.Rows[i]["codedesc"].ToString();
            }

        DataTable dt = new DataTable();
        try
        {
            CCMFTLMatix[] cfm = new CCMFTLMatix[grvcharges.Rows.Count];
            CCMMatrixCombination[] MatrixCombination = new CCMMatrixCombination[grvcharges.Rows.Count];

            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
                TextBox txtto = (TextBox)grv.FindControl("txtto");
                TextBox txtBillingLoc = (TextBox)grv.FindControl("txtBillingLoc");
                HiddenField hdnfrom = (HiddenField)grv.FindControl("hdnfrom");
                HiddenField hdnto = (HiddenField)grv.FindControl("hdnto");
                HiddenField hdnBillLoc = (HiddenField)grv.FindControl("hdnBillLoc");

                TextBox txtrate = (TextBox)grv.FindControl("txtrate");
                TextBox txttrdays = (TextBox)grv.FindControl("txttrdays");

                DropDownList ddltransmode = (DropDownList)grv.FindControl("ddltransmode");
                DropDownList ddlratetype = (DropDownList)grv.FindControl("ddlratetype");
                DropDownList ddlftltype = (DropDownList)grv.FindControl("ddlftltype");
                HiddenField hdnoldftltype = (HiddenField)grv.FindControl("hdnoldftltype");


                CheckBox chk = (CheckBox)grv.FindControl("chkyes");
                if (chk.Checked == true)
                {
                    if (txtfrom.Text.CompareTo("") == 0 || txtto.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx", false);
                        return;
                    }
                    txtrate.Text = txtrate.Text.CompareTo("") == 0 ? "0" : txtrate.Text;
                    txttrdays.Text = txttrdays.Text.CompareTo("") == 0 ? "0" : txttrdays.Text;
                }

                cfm[grv.RowIndex] = new CCMFTLMatix();
                MatrixCombination[grv.RowIndex] = new CCMMatrixCombination();

                cfm[grv.RowIndex].ContractID = hdncontractid.Value;


                if (hdnmatrixtype.Value == "R")
                {
                    cfm[grv.RowIndex].FromLoc = returnZoneCode(txtfrom.Text);
                    cfm[grv.RowIndex].ToLoc = returnZoneCode(txtto.Text);

                    MatrixCombination[grv.RowIndex].FromLoc = returnZoneCode(txtfrom.Text);
                    MatrixCombination[grv.RowIndex].ToLoc = returnZoneCode(txtto.Text);

                }
                else
                {
                    cfm[grv.RowIndex].FromLoc = txtfrom.Text;
                    cfm[grv.RowIndex].ToLoc = txtto.Text;
                    MatrixCombination[grv.RowIndex].FromLoc = txtfrom.Text;
                    MatrixCombination[grv.RowIndex].ToLoc = txtto.Text;

                }
                cfm[grv.RowIndex].FTLType = ddlftltype.SelectedValue;
                cfm[grv.RowIndex].OldFTLType = hdnoldftltype.Value;
                cfm[grv.RowIndex].TRDays = WebXConvert.ToInt32(txttrdays.Text);
                cfm[grv.RowIndex].Rate = WebXConvert.ToDouble(txtrate.Text);
                cfm[grv.RowIndex].RateType = ddlratetype.SelectedValue;
                cfm[grv.RowIndex].MatrixType = hdnmatrixtype.Value;
                cfm[grv.RowIndex].TransMode = hdntransmode.Value;
                cfm[grv.RowIndex].FlagInsert = WebXConvert.ToY_N(chk.Checked);
                cfm[grv.RowIndex].BillLoc = txtBillingLoc.Text;

                MatrixCombination[grv.RowIndex].MatrixType = hdnmatrixtype.Value;
                MatrixCombination[grv.RowIndex].BillLoc = txtBillingLoc.Text;
                MatrixCombination[grv.RowIndex].FlagInsert = WebXConvert.ToY_N(chk.Checked);

                if (hdnmatrixtype.Value == "R")
                {
                    cfm[grv.RowIndex].OldFromLoc = returnZoneCode(hdnfrom.Value);
                    cfm[grv.RowIndex].OldToLoc = returnZoneCode(hdnto.Value);
                }
                else
                {
                    cfm[grv.RowIndex].OldFromLoc = hdnfrom.Value;
                    cfm[grv.RowIndex].OldToLoc = hdnto.Value;
                }
            } // END OF FOREACH VALUES



            werror = CCMMatrixCombination.CCMMatrixCombinationValidation(MatrixCombination);

            if (werror.Key.Trim() == "")
            {
                CCMController.CCMFreightFTLMatrixEntry(cfm, SessionUtilities.CurrentEmployeeID.ToString());
            }




        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'), false);
            return;
        }
    }

    private string returnZoneCode(string zonename)
    {
        for (int i = 0; i < arrzonename.Length; i++)
        {
            if (zonename.ToUpper().CompareTo(arrzonename[i].ToString().ToUpper()) == 0)
            {
                return arrzonecode[i].ToString();
            }
        }
        return "";
    }


    //private static bool ValidateLocation(string location, string loctype)
    //{

    //    string strquery = "";
    //    string loc = "";
    //    if (loctype == "city")
    //    {
    //        strquery = "SELECT location FROM webx_citymaster WHERE activeflag='Y' where location='" + location.Trim() + "'";
    //        loc = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strquery).ToString();
    //        if (loc.Trim() == "")
    //        {
    //            return false;
    //        }
    //        else
    //        {
    //            return true;
    //        }
    //    }

    //    return true;

    //}





}
