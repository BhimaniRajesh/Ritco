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

public partial class GUI_AllTest_SingleSlabSundryFreightMatrix : System.Web.UI.Page
{

    SqlConnection con;
    string[] arrzonename;
    string[] arrzonecode;
    int zoneno = 0;

    private DataTable dtcharges
    {
        get { return (ViewState["dtcharges"] != null) ? ViewState["dtcharges"] as DataTable : new DataTable(); }
        set { ViewState["dtcharges"] = value; }
    }

    private DataTable discountType
    {
        get { return (ViewState["discountType"] != null) ? ViewState["discountType"] as DataTable : new DataTable(); }
        set { ViewState["discountType"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        MyFunctions fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();

        cstheader.CustCode = hdncustcode.Value;
        cstheader.ContractID = hdncontractid.Value;

        hdntransmode.Value = Request.QueryString["transmode"].ToString();
        hdnmatrixtype.Value = Request.QueryString["matrixtype"].ToString();

        hdnfrom.Value = Request.QueryString["from"].ToString();
        hdnto.Value = Request.QueryString["to"].ToString();

        if (!IsPostBack)
        {
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

            discountType = DataProvider.GetActiveGeneralMaster("DISCTYPE");

            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                lblmatrixtype.Text = "City - City";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                lblmatrixtype.Text = "Locaton - Location";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                lblmatrixtype.Text = "Region - Region";

            lbltransmode.Text = "All";
            lblfilterfrom.Text = hdnfrom.Value;
            lblfilterto.Text = hdnto.Value;

            dtcharges = new DataTable();
            SqlCommand cmd;
            string strsql = "";

            strsql = "SELECT contract_type FROM webx_custcontract_hdr WHERE contractid='" + hdncontractid.Value + "'";
            cmd = new SqlCommand(strsql, con);
            hdncontracttype.Value = Convert.ToString(cmd.ExecuteScalar());

            strsql = "SELECT TOP 1 rate_type FROM  ";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                strsql = strsql + "webx_custcontract_citydet";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                strsql = strsql + "webx_custcontract_locdet";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                strsql = strsql + "webx_custcontract_regdet";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value.ToString() + "'";
            strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "' AND basecode1='" + hdnbasecode1.Value + "'";
            strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "' AND basecode2='" + hdnbasecode2.Value + "'";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                strsql = strsql + " AND fromcity LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND tocity LIKE '" + hdnto.Value + "%'";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                strsql = strsql + " AND fromlocode LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND tolocode LIKE '" + hdnto.Value + "%'";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=fromregion) LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=toregion) LIKE '" + hdnto.Value + "%'";
            }

            cmd = new SqlCommand(strsql, con);
            try
            {
                cmbratetype.SelectedValue = Convert.ToString(cmd.ExecuteScalar());
            }
            catch (Exception ex) { }

            strsql = "SELECT ";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                strsql = strsql + "fromcity AS fromloc,tocity AS toloc,";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                strsql = strsql + "fromlocode AS fromloc,tolocode AS toloc,";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=fromregion) AS fromloc,";
                strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=toregion) AS toloc,";
            }
            strsql = strsql + "air_rate,road_rate,train_rate,express_rate,";
            strsql = strsql + "air_days,road_days,train_days,express_days,";
            strsql = strsql + "Discount,DiscountType,DiscountFromDate=CONVERT(VARCHAR,DiscountFromDate,103),DiscountToDate=CONVERT(VARCHAR,DiscountToDate,103)";
            strsql = strsql + " FROM ";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                strsql = strsql + "webx_custcontract_citydet";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                strsql = strsql + "webx_custcontract_locdet";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                strsql = strsql + "webx_custcontract_regdet";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value.ToString() + "'";

            strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "' AND basecode1='" + hdnbasecode1.Value + "'";
            strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "' AND basecode2='" + hdnbasecode2.Value + "'";

            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                strsql = strsql + " AND fromcity LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND tocity LIKE '" + hdnto.Value + "%'";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                strsql = strsql + " AND fromlocode LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND tolocode LIKE '" + hdnto.Value + "%'";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=fromregion) LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=toregion) LIKE '" + hdnto.Value + "%'";
            }
            cmd = new SqlCommand(strsql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dtcharges);

            if (dtcharges.Rows.Count <= 0)
                dtcharges.Rows.Add();

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

        for (int i = 0; i < rows; i++)
        {
            dtcharges.Rows.Add();
        }

        grvcharges.DataSource = dtcharges;
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

            //OnClientClick="javascript:return popuplisthead('branch','txtto','grvroadfreightbranch','4row')"
            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");
            btnfrom.Attributes.Add("onclick", "javascript:return windowHeadPopUp('" + loctype + "','txtfrom','grvcharges','4row')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtto','grvcharges','4row')");
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkyes");
            chk.Checked = true;

            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");
            DropDownList ddlDiscountType = (DropDownList)e.Row.FindControl("ddlDiscountType");
            HiddenField hdnDiscountType = (HiddenField)e.Row.FindControl("hdnDiscountType");

            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");
            string testtype = "", loctype = "";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                testtype = "citytest"; loctype = "city";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                testtype = "loctest"; loctype = "branch";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                testtype = "zonetest"; loctype = "zone";
            }

            ddlDiscountType.DataSource = discountType;
            ddlDiscountType.DataBind();
            ddlDiscountType.Items.Insert(0, new ListItem("Select", ""));

            string s = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtDiscountFromDate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkDiscountFromDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkDiscountFromDate")).Attributes.Add("onclick", s);

            string s1 = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtDiscountToDate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkDiscountToDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkDiscountToDate")).Attributes.Add("onclick", s1);
            ddlDiscountType.SelectedValue = hdnDiscountType.Value;

            txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtfrom.ClientID.ToString() + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtto.ClientID.ToString() + "','none')");
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        string strsql = "";
        SqlCommand cmd;
        strsql = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='zone' AND statuscode='Y'";
        cmd = new SqlCommand(strsql, con);
        zoneno = Convert.ToInt16(cmd.ExecuteScalar());
        arrzonename = new string[zoneno];
        arrzonecode = new string[zoneno];

        strsql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='zone' AND statuscode='Y' ORDER BY codeid";
        cmd = new SqlCommand(strsql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            arrzonecode[i] = dr["codeid"].ToString();
            arrzonename[i] = dr["codedesc"].ToString();
            i++;
        }
        dr.Close();
        SqlTransaction trn = con.BeginTransaction();

        try
        {
            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
                TextBox txtto = (TextBox)grv.FindControl("txtto");

                TextBox txtairrate = (TextBox)grv.FindControl("txtairrate");
                TextBox txtairdays = (TextBox)grv.FindControl("txtairdays");
                TextBox txtroadrate = (TextBox)grv.FindControl("txtroadrate");
                TextBox txtroaddays = (TextBox)grv.FindControl("txtroaddays");
                TextBox txttrainrate = (TextBox)grv.FindControl("txttrainrate");
                TextBox txttraindays = (TextBox)grv.FindControl("txttraindays");
                TextBox txtexpressrate = (TextBox)grv.FindControl("txtexpressrate");
                TextBox txtexpressdays = (TextBox)grv.FindControl("txtexpressdays");

                TextBox txtDiscount = (TextBox)grv.FindControl("txtDiscount");
                DropDownList ddlDiscountType = (DropDownList)grv.FindControl("ddlDiscountType");
                TextBox txtDiscountFromDate = (TextBox)grv.FindControl("txtDiscountFromDate");
                TextBox txtDiscountToDate = (TextBox)grv.FindControl("txtDiscountToDate");

                CheckBox chk = (CheckBox)grv.FindControl("chkyes");


                strsql = "DELETE FROM  ";
                if (hdnmatrixtype.Value.CompareTo("C") == 0)
                    strsql = strsql + "webx_custcontract_citydet";
                else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                    strsql = strsql + "webx_custcontract_locdet";
                else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                    strsql = strsql + "webx_custcontract_regdet";
                strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";

                strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "' AND basecode1='" + hdnbasecode1.Value + "'";
                strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "' AND basecode2='" + hdnbasecode2.Value + "'";

                if (hdnmatrixtype.Value.CompareTo("C") == 0)
                {
                    strsql = strsql + " AND fromcity='" + txtfrom.Text + "'";
                    strsql = strsql + " AND tocity='" + txtto.Text + "'";
                }
                else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                {
                    strsql = strsql + " AND fromlocode='" + txtfrom.Text + "'";
                    strsql = strsql + " AND tolocode='" + txtto.Text + "'";
                }
                else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                {
                    strsql = strsql + " AND fromregion='" + returnZoneCode(txtfrom.Text) + "'";
                    strsql = strsql + " AND toregion='" + returnZoneCode(txtto.Text) + "'";
                }
                cmd = new SqlCommand(strsql, con, trn);
                cmd.ExecuteNonQuery();

                if (chk.Checked == true)
                {

                    if (txtfrom.Text.CompareTo("") == 0 || txtto.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx", false);
                        return;
                    }

                    txtairdays.Text = txtairdays.Text.CompareTo("") == 0 ? "0" : txtairdays.Text;
                    txtroaddays.Text = txtroaddays.Text.CompareTo("") == 0 ? "0" : txtroaddays.Text;
                    txttraindays.Text = txttraindays.Text.CompareTo("") == 0 ? "0" : txttraindays.Text;
                    txtexpressdays.Text = txtexpressdays.Text.CompareTo("") == 0 ? "0" : txtexpressdays.Text;

                    txtairrate.Text = txtairrate.Text.CompareTo("") == 0 ? "0.00" : txtairrate.Text;
                    txtroadrate.Text = txtroadrate.Text.CompareTo("") == 0 ? "0.00" : txtroadrate.Text;
                    txttrainrate.Text = txttrainrate.Text.CompareTo("") == 0 ? "0.00" : txttrainrate.Text;
                    txtexpressrate.Text = txtexpressrate.Text.CompareTo("") == 0 ? "0.00" : txtexpressrate.Text;

                    strsql = "INSERT INTO ";
                    if (hdnmatrixtype.Value.CompareTo("C") == 0)
                        strsql = strsql + "webx_custcontract_citydet";
                    else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                        strsql = strsql + "webx_custcontract_locdet";
                    else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "webx_custcontract_regdet";

                    strsql = strsql + "(custcode,contractid,basedon1,basecode1,basedon2,basecode2,";
                    if (hdnmatrixtype.Value.CompareTo("C") == 0)
                        strsql = strsql + "fromcity,tocity,";
                    else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                        strsql = strsql + "fromlocode,tolocode,";
                    else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "fromregion,toregion,";

                    strsql = strsql + "air_rate,road_rate,train_rate,express_rate,";
                    strsql = strsql + "air_days,road_days,train_days,express_days,rate_type,Discount,DiscountType,DiscountFromDate,DiscountToDate)";
                    strsql = strsql + " VALUES(";
                    strsql = strsql + "'" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
                    strsql = strsql + "'" + hdnbasedon1.Value + "','" + hdnbasecode1.Value + "',";
                    strsql = strsql + "'" + hdnbasedon2.Value + "','" + hdnbasecode2.Value + "',";

                    if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "'" + returnZoneCode(txtfrom.Text) + "',";
                    else
                        strsql = strsql + "'" + txtfrom.Text + "',";

                    if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "'" + returnZoneCode(txtto.Text) + "',";
                    else
                        strsql = strsql + "'" + txtto.Text + "',";

                    strsql = strsql + txtairrate.Text + ",";
                    strsql = strsql + txtroadrate.Text + ",";
                    strsql = strsql + txttrainrate.Text + ",";
                    strsql = strsql + txtexpressrate.Text + ",";
                    strsql = strsql + txtairdays.Text + ",";
                    strsql = strsql + txtroaddays.Text + ",";
                    strsql = strsql + txttraindays.Text + ",";
                    strsql = strsql + txtexpressdays.Text + ",";
                    strsql = strsql + "'" + cmbratetype.SelectedValue + "',";
                    strsql = strsql + "'" + WebXConvert.ToDouble(txtDiscount.Text) + "',";
                    strsql = strsql + "'" + ddlDiscountType.SelectedValue + "',";
                    if (!string.IsNullOrEmpty(txtDiscountFromDate.Text))
                        strsql = strsql + "'" + WebXConvert.ToDateTime(txtDiscountFromDate.Text, "en-GB") + "',";
                    else
                        strsql = strsql + "NULL,";
                    if (!string.IsNullOrEmpty(txtDiscountToDate.Text))
                        strsql = strsql + "'" + WebXConvert.ToDateTime(txtDiscountToDate.Text, "en-GB") + "'";
                    else
                        strsql = strsql + "NULL";
                    strsql = strsql + ")";
                    cmd = new SqlCommand(strsql, con, trn);
                    cmd.ExecuteNonQuery();
                }

            } // END OF FOREACH VALUES
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'), false);
            return;
        }

        trn.Commit();
        Response.Redirect("CCM_DisplayResult.aspx?contractid=" + hdncontractid.Value + "&custcode=" + hdncustcode.Value);
    }

    private string returnZoneCode(string zonename)
    {
        for (int i = 0; i < zoneno; i++)
        {
            if (zonename.ToUpper().CompareTo(arrzonename[i].ToString().ToUpper()) == 0)
            {
                return arrzonecode[i].ToString();
            }
        }
        return "";
    }
}
