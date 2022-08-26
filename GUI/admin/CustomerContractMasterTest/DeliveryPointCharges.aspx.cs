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

public partial class GUI_admin_CustomerContractMaster_DeliveryPointCharges : System.Web.UI.Page
{

    SqlConnection con;
    static DataTable dtcharges;
    string[] arrzonename;
    string[] arrzonecode;
    int zoneno = 0;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {

        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();
        fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        hdntransmode.Value = Request.QueryString["transmode"].ToString();
        hdnchargetype.Value = Request.QueryString["chargetype"].ToString();
        hdnbasedon.Value = Request.QueryString["basedon"].ToString();
        hdnbasecode.Value = Request.QueryString["basecode"].ToString();
        hdnfrom.Value = Request.QueryString["from"].ToString();
        hdnto.Value = Request.QueryString["to"].ToString();
        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();

        hdnchargecode.Value = Request.QueryString["chargecode"].ToString();
        hdnmatrixtype.Value = Request.QueryString["matrixtype"].ToString();

        string strsql = "SELECT chargename FROM webx_master_charge WHERE chargecode='" + hdnchargecode.Value + "'";
        SqlCommand cmd = new SqlCommand(strsql, con);
        lblchargename.Text = Convert.ToString(cmd.ExecuteScalar());
        lblfilterto.Text = hdnto.Value;
        if (hdnmatrixtype.Value.CompareTo("C") == 0)
            lblmatrixtype.Text = "City - City";
        else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            lblmatrixtype.Text = "Locaton - Location";
        else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            lblmatrixtype.Text = "Region - Region";

        lbltransmode.Text = fn.Gettrnmod(hdntransmode.Value);

        if (!IsPostBack)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("fromloc", typeof(string));
            dt.Columns.Add("toloc", typeof(string));
            dt.Columns.Add("minrate", typeof(string));
            dt.Columns.Add("rate", typeof(string));
            dt.Columns.Add("ratetype", typeof(string));
            dt.Columns.Add("maxrate", typeof(string));
            dt.Rows.Add();



            strsql = "SELECT * FROM webx_custcontract_othercharges ";
            strsql = strsql + "WHERE custcode='" + hdncustcode.Value + "'";
            strsql = strsql + " AND contractid='" + hdncontractid.Value + "'";
            strsql = strsql + " AND trans_type='" + hdntransmode.Value + "'";
            strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "'";
            strsql = strsql + " AND chargetype='" + hdnchargetype.Value + "'";
            strsql = strsql + " AND fromloc like '" + hdnfrom.Value + "%'";
            strsql = strsql + " AND toloc like '" + hdnto.Value + "%'";
            cmd = new SqlCommand(strsql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            dtcharges = new DataTable();
            da.Fill(dtcharges);

            if (dtcharges.Rows.Count > 0)
                grvcharges.DataSource = dtcharges;
            else
                grvcharges.DataSource = dt;

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

            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");

            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtfrom','grvcharges','4row')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtto','grvcharges','4row')");
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkyes");
            chk.Checked = true;

            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");

            DropDownList ddlratetype = (DropDownList)e.Row.FindControl("ddlratetype");
            try
            {
                ddlratetype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ratetype"));
            }
            catch (Exception ex) { }

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
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtfrom.ClientID.ToString() + "','none')");

            txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
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
                TextBox txtminrate = (TextBox)grv.FindControl("txtminrate");
                TextBox txtrate = (TextBox)grv.FindControl("txtrate");
                TextBox txtmaxrate = (TextBox)grv.FindControl("txtmaxrate");
                DropDownList ddlratetype = (DropDownList)grv.FindControl("ddlratetype");
                CheckBox chk = (CheckBox)grv.FindControl("chkyes");


                strsql = "DELETE FROM webx_custcontract_othercharges";
                strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";
                strsql = strsql + " AND custcode='" + hdncustcode.Value + "' AND chargetype='" + hdnchargetype.Value + "'";
                strsql = strsql + " AND chargecode='" + hdnchargecode.Value + "'";
                strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "'";
                if (hdnmatrixtype.Value.CompareTo("C") == 0 || hdnmatrixtype.Value.CompareTo("L") == 0)
                    strsql = strsql + " AND fromloc='" + txtfrom.Text + "'";
                else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                    strsql = strsql + " AND fromloc='" + returnZoneCode(txtfrom.Text) + "'";

                if (hdnmatrixtype.Value.CompareTo("C") == 0 || hdnmatrixtype.Value.CompareTo("L") == 0)
                    strsql = strsql + " AND toloc='" + txtto.Text + "'";
                else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                    strsql = strsql + " AND toloc='" + returnZoneCode(txtto.Text) + "'";

                cmd = new SqlCommand(strsql, con, trn);
                cmd.ExecuteNonQuery();

                if (chk.Checked == true)
                {
                    if (txtfrom.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("ErrorPage.aspx?heading=Please Enter Location.");
                        return;
                    }

                    if (txtto.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("ErrorPage.aspx?heading=Please Enter Location.");
                        return;
                    }

                    txtminrate.Text = txtminrate.Text.CompareTo("") == 0 ? "0.00" : txtminrate.Text;
                    txtrate.Text = txtrate.Text.CompareTo("") == 0 ? "0.00" : txtrate.Text;
                    txtmaxrate.Text = txtmaxrate.Text.CompareTo("") == 0 ? "0.00" : txtmaxrate.Text;

                    strsql = "INSERT INTO webx_custcontract_othercharges";

                    strsql = strsql + "(custcode,contractid,chargecode,chargetype,basedon,basecode,fromloc,toloc,minrate,rate,maxrate,ratetype,trans_type,loc_reg";
                    strsql = strsql + ") VALUES (";
                    strsql = strsql + "'" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
                    strsql = strsql + "'" + hdnchargecode.Value + "','" + hdnchargetype.Value + "',";
                    strsql = strsql + "'" + hdnbasedon.Value + "','" + hdnbasecode.Value + "',";

                    if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "'" + returnZoneCode(txtfrom.Text) + "',";
                    else
                        strsql = strsql + "'" + txtfrom.Text + "',";

                    if (hdnmatrixtype.Value.CompareTo("R") == 0)
                        strsql = strsql + "'" + returnZoneCode(txtto.Text) + "',";
                    else
                        strsql = strsql + "'" + txtto.Text + "',";

                    strsql = strsql + txtminrate.Text + ",";
                    strsql = strsql + txtrate.Text + ",";
                    strsql = strsql + txtmaxrate.Text + ",";
                    strsql = strsql + "'" + ddlratetype.SelectedValue + "',";
                    strsql = strsql + "'" + hdntransmode.Value + "',";
                    strsql = strsql + "'" + hdnmatrixtype.Value + "')";
                    cmd = new SqlCommand(strsql, con, trn);
                    cmd.ExecuteNonQuery();
                } // chkyes

            } // END OF FOREACH VALUES


        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'));
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
