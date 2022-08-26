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

public partial class GUI_admin_DocketCustomization_DocketCustomization_Step2 : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        if (!IsPostBack)
        {

            /*****************************************************************************************************
            *  RETRIEVING BASED ON CHARGE RULE
            ******************************************************************************************************/
            strsql = "SELECT defaultvalue FROM webx_rules_docket WHERE code='CHRG_RULE'";
            cmd = new SqlCommand(strsql, con);
            hdnchargerule.Value = Convert.ToString(cmd.ExecuteScalar());
            /******************************************************************************************************/

            if (hdnchargerule.Value.CompareTo("NONE") == 0)
            {
                ddlbasedon.Items.Add(new ListItem("NONE", "NONE"));
            }
            else
            {
                strsql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='" + hdnchargerule.Value + "'";
                strsql = strsql + " AND statuscode='Y'";
                cmd = new SqlCommand(strsql, con);
                da = new SqlDataAdapter(cmd);
                DataTable dtbasedon = new DataTable();
                da.Fill(dtbasedon);

                ddlbasedon.DataSource = dtbasedon;
                ddlbasedon.DataBind();
            }
        } // End of IsPostBack
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnenabled1 = (HiddenField)e.Row.FindControl("hdnenabled1");
            HiddenField hdnenabled2 = (HiddenField)e.Row.FindControl("hdnenabled2");

            HiddenField hdnchargecode2 = (HiddenField)e.Row.FindControl("hdnchargecode2");

            CheckBox chkenabled1 = (CheckBox)e.Row.FindControl("chkenabled1");
            CheckBox chkenabled2 = (CheckBox)e.Row.FindControl("chkenabled2");

            if (hdnenabled1.Value.CompareTo("Y") == 0)
                chkenabled1.Checked = true;
            if (hdnenabled2.Value.CompareTo("Y") == 0)
                chkenabled2.Checked = true;

            if (hdnchargecode2.Value.CompareTo("") == 0)
                chkenabled2.Style["display"] = "none";
        }
    }

    protected void chargeBind()
    {
        SqlCommand cmd;
        SqlDataAdapter da;
        string strsql = "";
        /********************************************************************************************************
       *  CHARGE FEEDING FROM CUSTOMER WISE OR DEFUALT PAYMENT BASIS WISE
       ********************************************************************************************************/

        if (hdnchargerule.Value.CompareTo("NONE") == 0)
        {
            strsql = "SELECT chargecode,enabled,chargename FROM webx_master_charge c LEFT OUTER JOIN ";
            strsql = strsql + " webx_rules_docket r ON SUBSTRING(r.code,LEN(r.code)-5,LEN(r.code))=chargecode";
            strsql = strsql + " AND r.code LIKE 'NONE,NONE,%'";
            strsql = strsql + " AND paybas='" + ddlpaybas.SelectedValue + "'";
            strsql = strsql + " WHERE booktimeflag='Y' AND c.activeflag='Y'";
            strsql = strsql + " AND basedon='NONE'";
            strsql = strsql + " AND basecode='NONE' AND chargetype='DKT'";
        }
        else
        {
            strsql = "SELECT chargecode,enabled,chargename FROM webx_master_charge c LEFT OUTER JOIN ";
            strsql = strsql + " webx_rules_docket r ON SUBSTRING(r.code,LEN(r.code)-5,LEN(r.code))=chargecode";
            strsql = strsql + " AND r.code LIKE '" + hdnchargerule.Value + "," + ddlbasedon.SelectedValue + ",%'";
            strsql = strsql + " AND paybas='" + ddlpaybas.SelectedValue + "'";
            strsql = strsql + " WHERE booktimeflag='Y' AND c.activeflag='Y'";
            strsql = strsql + " AND basedon='" + hdnchargerule.Value + "'";
            strsql = strsql + " AND basecode='" + ddlbasedon.SelectedValue + "' AND chargetype='DKT'";
        }

        cmd = new SqlCommand(strsql, con);
        da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);


        DataTable dtcharges = new DataTable();
        dtcharges.Columns.Add("chargecode1", typeof(string));
        dtcharges.Columns.Add("chargename1", typeof(string));
        dtcharges.Columns.Add("enabled1", typeof(string));
        dtcharges.Columns.Add("chargecode2", typeof(string));
        dtcharges.Columns.Add("chargename2", typeof(string));
        dtcharges.Columns.Add("enabled2", typeof(string));

        if (dt.Rows.Count % 2 != 0)
            dt.Rows.Add();

        int rwscnt = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dtcharges.Rows.Add();
            dtcharges.Rows[rwscnt]["chargecode1"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename1"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["enabled1"] = dt.Rows[i]["enabled"].ToString();
            i++;
            dtcharges.Rows[rwscnt]["chargecode2"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename2"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["enabled2"] = dt.Rows[i]["enabled"].ToString();
            rwscnt++;
        }


        grvcharges.DataSource = dtcharges;
        grvcharges.DataBind();
    }

    protected void ddlpaybas_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strsql = "";
        SqlCommand cmd;

        strsql = "SELECT defaultvalue FROM webx_rules_docket WHERE code='STAX_PAIDBY' AND paybas='" + ddlpaybas.SelectedValue + "'";
        cmd = new SqlCommand(strsql, con);
        string strstaxpaidby = Convert.ToString(cmd.ExecuteScalar());


        try
        {
            string[] arrstaxpaidby = new string[3];
            arrstaxpaidby = strstaxpaidby.Split('|');

            string[] arrdefaults = new string[4];
            arrdefaults = arrstaxpaidby[1].Split(',');

            string[] arrenabled = new string[4];
            arrenabled = arrstaxpaidby[2].Split(',');


            if (arrstaxpaidby[0].IndexOf("1CO") >= 0)
                chkairco.Checked = true;
            if (arrstaxpaidby[0].IndexOf("1CE") >= 0)
                chkairce.Checked = true;
            if (arrstaxpaidby[0].IndexOf("1P") >= 0)
                chkairp.Checked = true;
            if (arrstaxpaidby[0].IndexOf("1T") >= 0)
                chkairt.Checked = true;

            if (arrstaxpaidby[0].IndexOf("2CO") >= 0)
                chkroadco.Checked = true;
            if (arrstaxpaidby[0].IndexOf("2CE") >= 0)
                chkroadce.Checked = true;
            if (arrstaxpaidby[0].IndexOf("2P") >= 0)
                chkroadp.Checked = true;
            if (arrstaxpaidby[0].IndexOf("2T") >= 0)
                chkroadt.Checked = true;

            if (arrstaxpaidby[0].IndexOf("3CO") >= 0)
                chktrainco.Checked = true;
            if (arrstaxpaidby[0].IndexOf("3CE") >= 0)
                chktraince.Checked = true;
            if (arrstaxpaidby[0].IndexOf("3P") >= 0)
                chktrainp.Checked = true;
            if (arrstaxpaidby[0].IndexOf("3T") >= 0)
                chktraint.Checked = true;

            if (arrstaxpaidby[0].IndexOf("4CO") >= 0)
                chkexpressco.Checked = true;
            if (arrstaxpaidby[0].IndexOf("4CE") >= 0)
                chkexpressce.Checked = true;
            if (arrstaxpaidby[0].IndexOf("4P") >= 0)
                chkexpressp.Checked = true;
            if (arrstaxpaidby[0].IndexOf("4T") >= 0)
                chkexpresst.Checked = true;

            try
            {
                ddlair.SelectedValue = arrdefaults[0];
            }
            catch (Exception ex) { }

            try
            {
                ddlroad.SelectedValue = arrdefaults[1];
            }
            catch (Exception ex) { }

            try
            {
                ddltrain.SelectedValue = arrdefaults[2];
            }
            catch (Exception ex) { }

            try
            {
                ddlexpress.SelectedValue = arrdefaults[3];
            }
            catch (Exception ex) { }

            if (arrenabled[0].CompareTo("Y") == 0)
                chkairenabled.Checked = true;

            if (arrenabled[1].CompareTo("Y") == 0)
                chkroadenabled.Checked = true;

            if (arrenabled[2].CompareTo("Y") == 0)
                chktrainenabled.Checked = true;

            if (arrenabled[3].CompareTo("Y") == 0)
                chkexpressenabled.Checked = true;
        }
        catch (Exception ex) { }




        chargeBind();


        strsql = "SELECT * FROM webx_rules_docket WHERE paybas='" + ddlpaybas.SelectedValue + "'";
        strsql = strsql + " AND code IN ('F_CHRG','F_RATE','F_RATETYPE','EDD')";
        cmd = new SqlCommand(strsql, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["code"].ToString().CompareTo("F_CHRG") == 0)
            {
                if (dt.Rows[i]["enabled"].ToString().CompareTo("E") == 0)
                {
                    optfchrge.Checked = true; optfchrgne.Checked = false; optfchrgd.Checked = false;
                }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("NE") == 0)
                {
                    optfchrgne.Checked = true; optfchrge.Checked = false; optfchrgd.Checked = false;
                }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("D") == 0)
                { optfchrgd.Checked = true; optfchrge.Checked = false; optfchrgne.Checked = false; }
            }

            if (dt.Rows[i]["code"].ToString().CompareTo("F_RATE") == 0)
            {
                if (dt.Rows[i]["enabled"].ToString().CompareTo("E") == 0)
                { optfratee.Checked = true; optfratene.Checked = false; optfrated.Checked = false; }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("NE") == 0)
                { optfratene.Checked = true; optfratee.Checked = false; optfrated.Checked = false; }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("D") == 0)
                { optfrated.Checked = true; optfratee.Checked = false; optfratene.Checked = false; }
            }

            if (dt.Rows[i]["code"].ToString().CompareTo("F_RATETYPE") == 0)
            {
                if (dt.Rows[i]["enabled"].ToString().CompareTo("E") == 0)
                { optftypee.Checked = true; optftypene.Checked = false; optftyped.Checked = false; }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("NE") == 0)
                { optftypene.Checked = true; optftypee.Checked = false; optftyped.Checked = false; }
                else if (dt.Rows[i]["enabled"].ToString().CompareTo("D") == 0)
                { optftyped.Checked = true; optftypee.Checked = false; optftypene.Checked = false; }
            }
        }
    }

    protected void ddlbasedon_SelectedIndexChanged(object sender, EventArgs e)
    {
        chargeBind();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string strsql = "", strpaidby = "";
        SqlCommand cmd;


        if (ddlpaybas.SelectedValue.CompareTo("0") == 0)
        {
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Please Select Payment Basis");
            return;
        }


        if (chkairco.Checked == true)
            strpaidby = strpaidby + "1CO,";
        if (chkairce.Checked == true)
            strpaidby = strpaidby + "1CE,";
        if (chkairp.Checked == true)
            strpaidby = strpaidby + "1P,";
        if (chkairt.Checked == true)
            strpaidby = strpaidby + "1T,";

        if (chkroadco.Checked == true)
            strpaidby = strpaidby + "2CO,";
        if (chkroadce.Checked == true)
            strpaidby = strpaidby + "2CE,";
        if (chkroadp.Checked == true)
            strpaidby = strpaidby + "2P,";
        if (chkroadt.Checked == true)
            strpaidby = strpaidby + "2T,";

        if (chktrainco.Checked == true)
            strpaidby = strpaidby + "3CO,";
        if (chktraince.Checked == true)
            strpaidby = strpaidby + "3CE,";
        if (chktrainp.Checked == true)
            strpaidby = strpaidby + "3P,";
        if (chktraint.Checked == true)
            strpaidby = strpaidby + "3T,";

        if (chkexpressco.Checked == true)
            strpaidby = strpaidby + "4CO,";
        if (chkexpressce.Checked == true)
            strpaidby = strpaidby + "4CE,";
        if (chkexpressp.Checked == true)
            strpaidby = strpaidby + "4P,";
        if (chkexpresst.Checked == true)
            strpaidby = strpaidby + "4T,";

        strpaidby = strpaidby + "|";

        strpaidby = strpaidby + ddlair.SelectedValue + ",";
        strpaidby = strpaidby + ddlroad.SelectedValue + ",";
        strpaidby = strpaidby + ddltrain.SelectedValue + ",";
        strpaidby = strpaidby + ddlexpress.SelectedValue + ",";

        strpaidby = strpaidby + "|";

        strpaidby = strpaidby + (chkairenabled.Checked == true ? "Y" : "N") + ",";
        strpaidby = strpaidby + (chkroadenabled.Checked == true ? "Y" : "N") + ",";
        strpaidby = strpaidby + (chktrainenabled.Checked == true ? "Y" : "N") + ",";
        strpaidby = strpaidby + (chkexpressenabled.Checked == true ? "Y" : "N") + ",";


        SqlTransaction trn;
        trn = con.BeginTransaction();
        try
        {
            strsql = "DELETE FROM webx_rules_docket WHERE code='STAX_PAIDBY' AND paybas='" + ddlpaybas.SelectedValue + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_rules_docket VALUES('STAX_PAIDBY','RULES FOR STAX PAID BY','" + strpaidby + "',0,0,'" + ddlpaybas.SelectedValue + "','Y','Y')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "DELETE FROM webx_rules_docket WHERE code IN ('F_CHRG','F_RATE','F_RATETYPE') ";
            strsql = strsql + " AND paybas='" + ddlpaybas.SelectedValue + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            string f_chrg = "", f_rate = "", f_ratetype = "";
            if (optfchrgd.Checked == true)
                f_chrg = "D";
            else if (optfchrgne.Checked == true)
                f_chrg = "NE";
            else if (optfchrge.Checked == true)
                f_chrg = "E";

            if (optfrated.Checked == true)
                f_rate = "D";
            else if (optfratene.Checked == true)
                f_rate = "NE";
            else if (optfratee.Checked == true)
                f_rate = "E";

            if (optftyped.Checked == true)
                f_ratetype = "D";
            else if (optftypene.Checked == true)
                f_ratetype = "NE";
            else if (optftypee.Checked == true)
                f_ratetype = "E";


            strsql = "INSERT INTO webx_rules_docket VALUES('F_CHRG','Freight charge manual entry for ";
            strsql = strsql + ddlpaybas.SelectedValue + "','0',0,0,'" + ddlpaybas.SelectedValue + "',";
            strsql = strsql + "'Y','" + f_chrg + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_rules_docket VALUES('F_RATE','Freight charge manual entry for ";
            strsql = strsql + ddlpaybas.SelectedValue + "','0',0,0,'" + ddlpaybas.SelectedValue + "',";
            strsql = strsql + "'Y','" + f_rate + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_rules_docket VALUES('F_RATETYPE','Freight charge manual entry for ";
            strsql = strsql + ddlpaybas.SelectedValue + "','0',0,0,'" + ddlpaybas.SelectedValue + "',";
            strsql = strsql + "'Y','" + f_ratetype + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "DELETE FROM webx_rules_docket WHERE code LIKE '" + hdnchargerule.Value + ",";
            strsql = strsql + ddlbasedon.SelectedValue + "%' AND paybas='" + ddlpaybas.SelectedValue + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            saveChargeRule(trn);

        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Error.&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();
        Response.Redirect("~/GUI/admin/sa.aspx");
    }

    protected void saveChargeRule(SqlTransaction trn)
    {
        string strsql = "";
        SqlCommand cmd;

        foreach (GridViewRow grv in grvcharges.Rows)
        {
            HiddenField hdnchargecode1 = (HiddenField)grv.FindControl("hdnchargecode1");
            HiddenField hdnchargecode2 = (HiddenField)grv.FindControl("hdnchargecode2");

            CheckBox chkenabled1 = (CheckBox)grv.FindControl("chkenabled1");
            CheckBox chkenabled2 = (CheckBox)grv.FindControl("chkenabled2");

            strsql = "INSERT INTO webx_rules_docket VALUES('";
            strsql = strsql + hdnchargerule.Value + "," + ddlbasedon.SelectedValue + "," + hdnchargecode1.Value;
            strsql = strsql + "','Enable/Disable Setting for ChargeCode " + hdnchargecode1.Value + "','0',";
            strsql = strsql + "0,0,'" + ddlpaybas.SelectedValue + "','Y','" + (chkenabled1.Checked == true ? "Y" : "N") + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            if (hdnchargecode2.Value.CompareTo("") != 0)
            {
                strsql = "INSERT INTO webx_rules_docket VALUES('";
                strsql = strsql + hdnchargerule.Value + "," + ddlbasedon.SelectedValue + "," + hdnchargecode2.Value;
                strsql = strsql + "','Enable/Disable Setting for ChargeCode " + hdnchargecode2.Value + "','0',";
                strsql = strsql + "0,0,'" + ddlpaybas.SelectedValue + "','Y','" + (chkenabled2.Checked == true ? "Y" : "N") + "')";
                cmd = new SqlCommand(strsql, con, trn);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
