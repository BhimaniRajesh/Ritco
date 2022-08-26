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
    static DataTable dtcharges;
    SqlConnection con;
    string[] arrzonename;
    string[] arrzonecode;
    int zoneno = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        MyFunctions fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        hdntransmode.Value = Request.QueryString["transmode"].ToString();
        hdnmatrixtype.Value = Request.QueryString["matrixtype"].ToString();

        hdnfrom.Value = Request.QueryString["from"].ToString();
        hdnto.Value = Request.QueryString["to"].ToString();



        if (!IsPostBack)
        {
            lblcontractid.Text = hdncontractid.Value;
            lblcustcodename.Text = hdncustcode.Value + " : " + fn.Getcustomer(hdncustcode.Value);

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
            strsql = strsql + "air_days,road_days,train_days,express_days ";
            strsql = strsql + " FROM ";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                strsql = strsql + "webx_custcontract_citydet";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                strsql = strsql + "webx_custcontract_locdet";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                strsql = strsql + "webx_custcontract_regdet";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value.ToString() + "'";
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

                CheckBox chk = (CheckBox)grv.FindControl("chkyes");


                if (txtfrom.Text.CompareTo("") == 0 || txtto.Text.CompareTo("") == 0)
                {
                    Response.Redirect("~/GUI/ErrorPage.aspx");
                    return;
                }

                strsql = "DELETE FROM  ";
                if (hdnmatrixtype.Value.CompareTo("C") == 0)
                    strsql = strsql + "webx_custcontract_citydet";
                else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                    strsql = strsql + "webx_custcontract_locdet";
                else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                    strsql = strsql + "webx_custcontract_regdet";
                strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";
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

                    strsql = "INSERT INTO ";
                    if (hdnmatrixtype.Value.CompareTo("C") == 0)
                        strsql = strsql + "webx_custcontract_citydet";
                    else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                        strsql = strsql + "webx_custcontract_locdet";
                    else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "webx_custcontract_regdet";

                    strsql = strsql + "(custcode,contractid,";
                    if (hdnmatrixtype.Value.CompareTo("C") == 0)
                        strsql = strsql + "fromcity,tocity,";
                    else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                        strsql = strsql + "fromlocode,tolocode,";
                    else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "fromregion,toregion,";

                    strsql = strsql + "air_rate,road_rate,train_rate,express_rate,";
                    strsql = strsql + "air_days,road_days,train_days,express_days,rate_type,contract_type)";
                    strsql = strsql + " VALUES(";
                    strsql = strsql + "'" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
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
                    strsql = strsql + "'" + hdncontracttype.Value + "'";
                    strsql = strsql + ")";
                    cmd = new SqlCommand(strsql, con, trn);
                    cmd.ExecuteNonQuery();
                }

            } // END OF FOREACH VALUES


        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();
        Response.Redirect("CCM_DisplayResult.aspx?contractid=" + hdncontractid.Value);
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
