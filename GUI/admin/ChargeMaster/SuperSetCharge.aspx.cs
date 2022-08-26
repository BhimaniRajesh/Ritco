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

public partial class GUI_Octroi_ViewnPrint_DText : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Session Expired&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        if (!IsPostBack)
        {
            string strsql = "";
            SqlCommand cmd;
            SqlDataAdapter da;
            DataTable dt;

            strsql = "SELECT ISNULL(defaultvalue,'NONE') FROM webx_rules_docket WHERE code='CHRG_RULE'";
            cmd = new SqlCommand(strsql, con);
            hdnbasedon.Value = Convert.ToString(cmd.ExecuteScalar());

            strsql = "SELECT * FROM webx_master_general WHERE codetype='" + hdnbasedon.Value + "' AND statuscode='Y' ORDER BY codedesc";
            cmd = new SqlCommand(strsql, con);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            ddllist.DataSource = dt;
            ddllist.DataBind();

            if (dt.Rows.Count <= 0)
                ddllist.Items.Add(new ListItem("Default", "NONE"));

            ddllist.Items.Insert(0, new ListItem("Select", "0"));

            if (hdnbasedon.Value.CompareTo("NONE") == 0)
            {
                trlist.Style["display"] = "none";
                ddllist.SelectedValue = "NONE";
                ddllist_SelectedIndexChanged(sender, e);
            }
            else if (hdnbasedon.Value.CompareTo("SVCTYP") == 0)
            {
                lbllistname.Text = "Service Type";
            }
            else if (hdnbasedon.Value.CompareTo("BUT") == 0)
            {
                lbllistname.Text = "Business Type";
            }

        }
    }

    protected void ddllist_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        strsql = "SELECT * FROM webx_master_charge WHERE basedon='" + hdnbasedon.Value + "'";
        strsql = strsql + " AND basecode='" + ddllist.SelectedValue + "'";
        strsql = strsql + " AND chargetype='DKT' ORDER BY chargename";
        cmd = new SqlCommand(strsql, con);

        da = new SqlDataAdapter(cmd);
        dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count < 33)
            dt = createChargeTable();

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
            DropDownList ddloperator = (DropDownList)e.Row.FindControl("ddloperator");
            HiddenField hdnactiveflag = (HiddenField)e.Row.FindControl("hdnactiveflag");
            TextBox txtchargename = (TextBox)e.Row.FindControl("txtchargename");
            Label lblchargename = (Label)e.Row.FindControl("lblchargename");
            Label lblfixed = (Label)e.Row.FindControl("lblfixed");
            HiddenField hdnchargecode = (HiddenField)e.Row.FindControl("hdnchargecode");
            CheckBox chkactiveflag = (CheckBox)e.Row.FindControl("chkactiveflag");

            HiddenField hdnvarybyloc = (HiddenField)e.Row.FindControl("hdnvarybyloc");
            CheckBox chkvarybyloc = (CheckBox)e.Row.FindControl("chkvarybyloc");

            HiddenField hdnbooktimeflag = (HiddenField)e.Row.FindControl("hdnbooktimeflag");
            CheckBox chkbooktimeflag = (CheckBox)e.Row.FindControl("chkbooktimeflag");

            HiddenField hdndeltimeflag = (HiddenField)e.Row.FindControl("hdndeltimeflag");
            CheckBox chkdeltimeflag = (CheckBox)e.Row.FindControl("chkdeltimeflag");


            if (hdnactiveflag.Value.ToUpper().CompareTo("Y") == 0)
                chkactiveflag.Checked = true;
            else
                chkactiveflag.Checked = false;

            if (hdnvarybyloc.Value.ToUpper().CompareTo("Y") == 0)
                chkvarybyloc.Checked = true;
            else
                chkvarybyloc.Checked = false;

            if (hdnbooktimeflag.Value.ToUpper().CompareTo("Y") == 0)
                chkbooktimeflag.Checked = true;
            else
                chkbooktimeflag.Checked = false;

            if (hdndeltimeflag.Value.ToUpper().CompareTo("Y") == 0)
                chkdeltimeflag.Checked = true;
            else
                chkdeltimeflag.Checked = false;

            try
            {
                ddloperator.SelectedValue = (string)DataBinder.Eval(e.Row.DataItem, "operator");
            }
            catch (Exception ex) { }

            lblchargename.Attributes.Add("onclick", "javascript:return alterDisplay('" + txtchargename.ClientID.ToString() + "','" + lblchargename.ClientID.ToString() + "')");
            txtchargename.Attributes.Add("onblur", "javascript:return alterDisplay('" + txtchargename.ClientID.ToString() + "','" + lblchargename.ClientID.ToString() + "')");

            // Some charges are with fixed name
            switch (hdnchargecode.Value)
            {
                case "SCHG11":  // FOV CHARGES
                case "SCHG12":  // COD/DOD CHARGES
                case "SCHG13":  // DACC CHARGES
                case "SCHG19":  // ODA CHARGES
                case "SCHG20":  // FUEL SURCHARGE
                case "UCHG01":  // MULTIPOINT PICKUP
                case "UCHG02":  // UNLOADING CHARGES
                case "UCHG03":  // MULTIPOINT DELIVERY
                case "UCHG04":  // LOADING CHARGES
                    lblfixed.Text = "(Fixed)";
                    ddloperator.SelectedValue = "+";
                    ddloperator.Enabled = false;
                    lblchargename.Attributes.Add("onclick", "javascript:return false;");
                    break;
            }

            lblchargename.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
        }
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd;
        SqlTransaction trn;
        string sqlstr = "";

        trn = con.BeginTransaction();
        try
        {
            sqlstr = "INSERT INTO webx_master_charge_edit SELECT chargetype,chargecode,chargename,basedon,basecode,operator,";
            sqlstr = sqlstr + "activeflag,entryby,getdate(),null,null,varybyloc,booktimeflag,deltimeflag FROM webx_master_charge WHERE basedon='" + hdnbasedon.Value + "' AND basecode='" + ddllist.SelectedValue + "' AND chargetype='DKT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "DELETE FROM webx_master_charge WHERE basedon='" + hdnbasedon.Value + "' AND basecode='" + ddllist.SelectedValue + "' AND chargetype='DKT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtchargename = (TextBox)grv.FindControl("txtchargename");
                HiddenField hdnchargecode = (HiddenField)grv.FindControl("hdnchargecode");
                CheckBox chkactiveflag = (CheckBox)grv.FindControl("chkactiveflag");
                CheckBox chkvarybyloc = (CheckBox)grv.FindControl("chkvarybyloc");
                CheckBox chkbooktimeflag = (CheckBox)grv.FindControl("chkbooktimeflag");
                CheckBox chkdeltimeflag = (CheckBox)grv.FindControl("chkdeltimeflag");
                DropDownList ddloperator = (DropDownList)grv.FindControl("ddloperator");

                sqlstr = "INSERT INTO webx_master_charge(chargetype,basedon,basecode,chargecode,chargename,operator,";
                sqlstr = sqlstr + "varybyloc,booktimeflag,deltimeflag,activeflag,entryby,entrydate)";
                sqlstr = sqlstr + " VALUES ('DKT','" + hdnbasedon.Value + "','" + ddllist.SelectedValue + "',";
                sqlstr = sqlstr + "'" + hdnchargecode.Value + "','" + txtchargename.Text + "',";
                sqlstr = sqlstr + "'" + ddloperator.SelectedValue + "','" + (chkvarybyloc.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkbooktimeflag.Checked == true ? "Y" : "N") + "','" + (chkdeltimeflag.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkactiveflag.Checked == true ? "Y" : "N") + "','" + Session["empcd"].ToString() + "'";
                sqlstr = sqlstr + ",getdate())";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Entry Failed&detail1=" + ex.Message.Replace('\n', '_'));
        }

        trn.Commit();
        Response.Redirect("~/GUI/Default.aspx");
    }

    protected DataTable createChargeTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("chargecode", typeof(string));
        dt.Columns.Add("chargename", typeof(string));
        dt.Columns.Add("varybyloc", typeof(string));
        dt.Columns.Add("booktimeflag", typeof(string));
        dt.Columns.Add("deltimeflag", typeof(string));
        dt.Columns.Add("activeflag", typeof(string));
        dt.Columns.Add("operator", typeof(string));


        for (int i = 1; i < 24; i++)
        {
            string[] param = new string[4];
            param[0] = "SCHG" + i.ToString().PadLeft(2, '0');
            param[1] = "Charge Name " + i.ToString().PadLeft(2, '0');
            param[2] = "N";
            param[3] = "+";

            dt.Rows.Add(param);
        }

        for (int i = 1; i < 11; i++)
        {
            string[] param = new string[4];
            param[0] = "UCHG" + i.ToString().PadLeft(2, '0');
            param[1] = "User Charge Name " + i.ToString().PadLeft(2, '0');
            param[2] = "N";
            param[3] = "+";

            dt.Rows.Add(param);
        }

        return dt;
    }


}
