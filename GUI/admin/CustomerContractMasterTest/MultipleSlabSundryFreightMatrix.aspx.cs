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

public partial class GUI_AllTest_MultipleSlabSundryFreightMatrix : System.Web.UI.Page
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

        cstheader.CustCode = hdncustcode.Value;
        cstheader.ContractID = hdncontractid.Value;

        if (!IsPostBack)
        {

            if (hdnmatrixtype.Value.CompareTo("C") == 0)
                lblmatrixtype.Text = "City - City";
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
                lblmatrixtype.Text = "Locaton - Location";
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
                lblmatrixtype.Text = "Region - Region";

            switch (hdntransmode.Value)
            {
                case "1":
                    hdntransname.Value = "AIR";
                    break;
                case "2":
                    hdntransname.Value = "ROAD";
                    break;
                case "3":
                    hdntransname.Value = "TRAIN";
                    break;
                case "4":
                    hdntransname.Value = "EXPRESS";
                    break;
            }

            lbltransmode.Text = fn.Gettrnmod(hdntransmode.Value);
            lblfilterfrom.Text = hdnfrom.Value;
            lblfilterto.Text = hdnto.Value;

            dtcharges = new DataTable();
            SqlCommand cmd;
            string strsql = "";

            strsql = "SELECT contract_type FROM webx_custcontract_hdr WHERE contractid='" + hdncontractid.Value + "'";
            cmd = new SqlCommand(strsql, con);
            hdncontracttype.Value = Convert.ToString(cmd.ExecuteScalar());

            if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = "SELECT";
                strsql = strsql + " (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=from_loccode) AS fromloc,";
                strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=to_loccode) AS toloc,";
            }
            else
            {
                strsql = "SELECT from_loccode AS fromloc,to_loccode AS toloc,";
            }

            strsql = strsql + " ISNULL(trdays,0) AS trdays,ISNULL(slab1,0) AS slab1, ISNULL(slab2,0) AS slab2,";
            strsql = strsql + " ISNULL(slab3,0) AS slab3,ISNULL(slab4,0) AS slab4,ISNULL(slab5,0) AS slab5,";
            strsql = strsql + " ISNULL(slab6,0) AS slab6";
            strsql = strsql + " FROM webx_custcontract_frtmatrix_slabdet ";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value.ToString() + "'";
            if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=from_loccode) LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND (SELECT codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=TO_loccode) LIKE '" + hdnto.Value + "%'";
            }
            else
            {
                strsql = strsql + " AND from_loccode LIKE '" + hdnfrom.Value + "%'";
                strsql = strsql + " AND to_loccode LIKE '" + hdnto.Value + "%'";
            }
            strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "'";
            strsql = strsql + " AND (trans_type='" + hdntransmode.Value + "' OR trans_type='" + hdntransname.Value + "')";
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

                TextBox txttrdays = (TextBox)grv.FindControl("txttrdays");
                TextBox txtslab1 = (TextBox)grv.FindControl("txtslab1");
                TextBox txtslab2 = (TextBox)grv.FindControl("txtslab2");
                TextBox txtslab3 = (TextBox)grv.FindControl("txtslab3");
                TextBox txtslab4 = (TextBox)grv.FindControl("txtslab4");
                TextBox txtslab5 = (TextBox)grv.FindControl("txtslab5");
                TextBox txtslab6 = (TextBox)grv.FindControl("txtslab6");

                CheckBox chk = (CheckBox)grv.FindControl("chkyes");

                if (txttrdays.Text.CompareTo("") == 0)
                    txttrdays.Text = "0";

                if (txtslab1.Text.CompareTo("") == 0)
                    txtslab1.Text = "0";
                if (txtslab2.Text.CompareTo("") == 0)
                    txtslab2.Text = "0";
                if (txtslab3.Text.CompareTo("") == 0)
                    txtslab3.Text = "0";
                if (txtslab4.Text.CompareTo("") == 0)
                    txtslab4.Text = "0";
                if (txtslab5.Text.CompareTo("") == 0)
                    txtslab5.Text = "0";
                if (txtslab6.Text.CompareTo("") == 0)
                    txtslab6.Text = "0";


                strsql = "DELETE FROM webx_custcontract_frtmatrix_slabdet";
                strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "' AND from_loccode='" + txtfrom.Text + "'";
                strsql = strsql + " AND to_loccode='" + txtto.Text.Trim() + "'";
                strsql = strsql + " AND (trans_type='" + hdntransmode.Value + "' OR trans_type='" + hdntransname.Value + "')";
                strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "'";
                cmd = new SqlCommand(strsql, con, trn);
                cmd.ExecuteNonQuery();

                if (chk.Checked == true)
                {
                    if (txtfrom.Text.CompareTo("") == 0 || txtto.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx?heading=FROM or TO location found empty");
                        return;
                    }

                    strsql = "INSERT INTO webx_custcontract_frtmatrix_slabdet";
                    strsql = strsql + "(custcode,contractid,from_loccode,to_loccode,";
                    strsql = strsql + "trdays,slab1,slab2,slab3,slab4,slab5,slab6,";
                    strsql = strsql + "loc_reg,trans_type,contract_type)";
                    strsql = strsql + "  VALUES(";
                    strsql = strsql + "'" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
                    if (hdnmatrixtype.Value.CompareTo("R") == 0)
                    {
                        strsql = strsql + "'" + returnZoneCode(txtfrom.Text) + "',";
                        strsql = strsql + "'" + returnZoneCode(txtto.Text) + "',";
                    }
                    else
                    {
                        strsql = strsql + "'" + txtfrom.Text + "',";
                        strsql = strsql + "'" + txtto.Text + "',";
                    }
                    strsql = strsql + txttrdays.Text + ",";
                    strsql = strsql + txtslab1.Text + ",";
                    strsql = strsql + txtslab2.Text + ",";
                    strsql = strsql + txtslab3.Text + ",";
                    strsql = strsql + txtslab4.Text + ",";
                    strsql = strsql + txtslab5.Text + ",";
                    strsql = strsql + txtslab6.Text + ",";
                    strsql = strsql + "'" + hdnmatrixtype.Value + "',";
                    strsql = strsql + "'" + hdntransmode.Value + "',";
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
