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

public partial class GUI_admin_CustomerContractMaster_CCMStep3 : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();

        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();

        if (!IsPostBack)
        {
            string strsql = "";
            SqlCommand cmd;

            strsql = "SELECT defaultvalue FROM webx_rules_docket WHERE code='CHRG_RULE'";
            cmd = new SqlCommand(strsql, con);
            hdnbasedon1.Value = Convert.ToString(cmd.ExecuteScalar());


            if (hdnbasedon1.Value.CompareTo("NONE") == 0)
            {
                ddllist1.Items.Add(new ListItem("Default", "NONE"));
                trlist.Style["display"] = "none";
                ddllist1_SelectedIndexChanged(sender, e);
            }
            else
            {
                strsql = "SELECT headerdesc FROM webx_master_codetypes WHERE headercode='" + hdnbasedon1.Value + "'";
                cmd = new SqlCommand(strsql, con);
                lbllistname1.Text = "Select " + Convert.ToString(cmd.ExecuteScalar());

                strsql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='" + hdnbasedon1.Value + "' AND statuscode='Y'";
                cmd = new SqlCommand(strsql, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt1 = new DataTable();
                da.Fill(dt1);
                ddllist1.DataSource = dt1;
                ddllist1.DataBind();

                ddllist1.Items.Insert(0, new ListItem("Select", "0"));
            }
        }

    }

    protected void btnmatrix_Click(object sender, EventArgs e)
    {
        Button btnmatrix = (Button)sender;
        HiddenField hdnchargecode = (HiddenField)btnmatrix.Parent.FindControl("hdnchargecode");

        string url = "";
        url = url + "?custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
        url = url + "&servicecode=3.1&chargecode=" + hdnchargecode.Value;
        url = url + "&chargetype=" + ddlchargetime.SelectedValue;
        url = url + "&basedon1=" + hdnbasedon1.Value + "&basecode1=" + ddllist1.SelectedValue;
        url = url + "&basedon2=" + hdnbasedon2.Value + "&basecode2=" + ddllist2.SelectedValue; ;
        Response.Redirect("MatrixSelection.aspx" + url);
    }

    protected void ddllist2_SelectedIndexChanged(object sender, EventArgs e)
    {

        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        strsql = "SELECT chargerate=0.00,* FROM webx_master_charge ";
        strsql = strsql + "WHERE basedon='" + hdnbasedon1.Value + "'";
        strsql = strsql + " AND basecode='" + ddllist1.SelectedValue + "' AND activeflag='Y'";

        if (ddlchargetime.SelectedValue.CompareTo("BKG") == 0)
            strsql = strsql + " AND booktimeflag='Y'";
        else if (ddlchargetime.SelectedValue.CompareTo("DEL") == 0)
            strsql = strsql + " AND deltimeflag='Y'";

        strsql = strsql + " AND chargetype='DKT' ORDER BY chargename";
        cmd = new SqlCommand(strsql, con);

        da = new SqlDataAdapter(cmd);
        dt = new DataTable();
        da.Fill(dt);

        strsql = "SELECT * FROM webx_custcontract_charges WHERE custcode='" + hdncustcode.Value + "'";
        strsql = strsql + " AND contractid='" + hdncontractid.Value + "' AND chargetype='" + ddlchargetime.SelectedValue + "'";
        strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "' AND basecode1='" + ddllist1.SelectedValue + "'";
        strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "' AND basecode2='" + ddllist2.SelectedValue + "'";


        cmd = new SqlCommand(strsql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["chargerate"] = returnDouble(dr[Convert.ToString(dt.Rows[i]["chargecode"])].ToString()).ToString("F2");
            }
        }
        dr.Close();

        grvcharges.DataSource = dt;
        grvcharges.DataBind();

        if (dt.Rows.Count <= 0)
        {
            trgrid.Style["display"] = "none";
            trsubmit.Style["display"] = "none";
        }
        else
        {
            trgrid.Style["display"] = "marker";
            trsubmit.Style["display"] = "marker";
        }
    }
    protected void ddllist1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        hdnbasedon2.Value = "NONE";
        ddllist2.Items.Clear();
        ddllist2.Items.Add(new ListItem("Default", "NONE"));

        strsql = "SELECT chargerate=0.00,* FROM webx_master_charge ";
        strsql = strsql + "WHERE basedon='" + hdnbasedon1.Value + "'";
        strsql = strsql + " AND basecode='" + ddllist1.SelectedValue + "' AND activeflag='Y'";


        if (ddlchargetime.SelectedValue.CompareTo("BKG") == 0)
            strsql = strsql + " AND booktimeflag='Y'";
        else if (ddlchargetime.SelectedValue.CompareTo("DEL") == 0)
            strsql = strsql + " AND deltimeflag='Y'";

        strsql = strsql + " AND chargetype='DKT' ORDER BY chargename";
        cmd = new SqlCommand(strsql, con);

        da = new SqlDataAdapter(cmd);
        dt = new DataTable();
        da.Fill(dt);

        strsql = "SELECT * FROM webx_custcontract_charges WHERE custcode='" + hdncustcode.Value + "'";
        strsql = strsql + " AND contractid='" + hdncontractid.Value + "' AND chargetype='" + ddlchargetime.SelectedValue + "'";
        strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "' AND basecode1='" + ddllist1.SelectedValue + "'";
        strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "' AND basecode2='" + ddllist2.SelectedValue + "'";


        cmd = new SqlCommand(strsql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["chargerate"] = returnDouble(dr[Convert.ToString(dt.Rows[i]["chargecode"])].ToString()).ToString("F2");
            }
        }
        dr.Close();

        grvcharges.DataSource = dt;
        grvcharges.DataBind();

        if (dt.Rows.Count <= 0)
        {
            trgrid.Style["display"] = "none";
            trsubmit.Style["display"] = "none";
        }
        else
        {
            trgrid.Style["display"] = "marker";
            trsubmit.Style["display"] = "marker";
        }
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnvarybyloc = (HiddenField)e.Row.FindControl("hdnvarybyloc");
            HiddenField hdnchargecode = (HiddenField)e.Row.FindControl("hdnchargecode");
            TextBox txtcharge = (TextBox)e.Row.FindControl("txtcharge");
            Button btnmatrix = (Button)e.Row.FindControl("btnmatrix");

            if ("SCHG11,SCHG12,SCHG13,SCHG19,SCHG20,UCHG01,UCHG02,UCHG03,UCHG04".IndexOf(hdnchargecode.Value) >= 0)
                e.Row.Style["display"] = "none";

            if (hdnvarybyloc.Value.CompareTo("Y") == 0)
            {
                txtcharge.Style["display"] = "none";
                btnmatrix.Style["display"] = "block";
            }
            else
            {
                txtcharge.Style["display"] = "block";
                btnmatrix.Style["display"] = "none";
            }

        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        SqlTransaction trn = con.BeginTransaction();
        SqlCommand cmd;
        string strsql = "";
        try
        {
            strsql = "DELETE FROM webx_custcontract_charges WHERE contractid='" + hdncontractid.Value + "'";
            strsql = strsql + " AND basedon1='" + hdnbasedon1.Value + "'";
            strsql = strsql + " AND basedon2='" + hdnbasedon2.Value + "'";
            strsql = strsql + " AND basecode1='" + ddllist1.SelectedValue + "'";
            strsql = strsql + " AND basecode2='" + ddllist2.SelectedValue + "'";
            strsql = strsql + " AND chargetype='" + ddlchargetime.SelectedValue + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();
            string strfields, strvalues;
            strfields = "INSERT INTO webx_custcontract_charges ";
            strfields = strfields + " (custcode,contractid,chargetype,basedon1,basecode1,basedon2,basecode2";
            strvalues = " VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strvalues = strvalues + "'" + ddlchargetime.SelectedValue + "',";
            strvalues = strvalues + "'" + hdnbasedon1.Value + "','" + ddllist1.SelectedValue + "',";
            strvalues = strvalues + "'" + hdnbasedon2.Value + "','" + ddllist2.SelectedValue + "'";


            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtcharge = (TextBox)grv.FindControl("txtcharge");
                HiddenField hdnchargecode = (HiddenField)grv.FindControl("hdnchargecode");

                if (txtcharge.Text.CompareTo("") == 0)
                    txtcharge.Text = "0";

                strfields = strfields + "," + hdnchargecode.Value;
                strvalues = strvalues + "," + txtcharge.Text;
            }

            strfields = strfields + ",lasteditby,lasteditdate)";
            strvalues = strvalues + ",'" + Session["empcd"].ToString() + "',getdate())";

            strsql = strfields + strvalues;
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();
        Response.Redirect("CCM_DisplayResult.aspx?" + Request.QueryString.ToString());
    }

    protected DataTable createChargeTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("chargecode", typeof(string));
        dt.Columns.Add("chargename", typeof(string));
        dt.Columns.Add("chargerate", typeof(double));
        dt.Columns.Add("activeflag", typeof(string));
        dt.Columns.Add("operator", typeof(string));


        for (int i = 1; i < 24; i++)
        {
            string[] param = new string[5];
            param[0] = "SCHG" + i.ToString().PadLeft(2, '0');
            param[1] = "Charge Name " + i.ToString().PadLeft(2, '0');
            param[2] = "0";
            param[3] = "N";
            param[4] = "+";

            dt.Rows.Add(param);
        }

        for (int i = 1; i < 11; i++)
        {
            string[] param = new string[5];
            param[0] = "UCHG" + i.ToString().PadLeft(2, '0');
            param[1] = "User Charge Name " + i.ToString().PadLeft(2, '0');
            param[2] = "0";
            param[3] = "N";
            param[4] = "+";

            dt.Rows.Add(param);
        }

        return dt;
    }
    // Inner Function convert string to double,(incase string is NULL or blank it handles) and  keep Code clear
    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception ex)
        {
            return 0.00;
        }
    }

}
