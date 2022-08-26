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
using System.Collections.Generic;

public partial class GUI_AllTest_NewFTL : System.Web.UI.Page
{
    SqlConnection con;
  
    private DataTable dtftltypes
    {
        get { return (ViewState["dtftltypes"] != null)? ViewState["dtftltypes"] as DataTable : new DataTable(); }
        set { ViewState["dtftltypes"] = value; }
    }
    private DataTable dtcharges
    {
        get { return (ViewState["dtcharges"] != null) ? ViewState["dtcharges"] as DataTable : new DataTable(); }
        set { ViewState["dtcharges"] = value; }
    }
    private string[] ftlvalues
    {
        get { return (ViewState["ftlvalues"] != null) ? ViewState["ftlvalues"] as string[] : new string[0]; }
        set { ViewState["ftlvalues"] = value; }
    }

    string[] arrzonename;
    string[] arrzonecode;
    int zoneno = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        SqlCommand cmd;
        string sqlstr = "";

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired Please Logon Again");
            return;
        }


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


            lbltransmode.Text = fn.Gettrnmod(hdntransmode.Value);
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
            lblfilterfrom.Text = hdnfrom.Value;
            lblfilterto.Text = hdnto.Value;

            ftlvalues = new string[10];
            dtftltypes = new DataTable();


            sqlstr = "SELECT contract_type FROM webx_custcontract_hdr WHERE contractid='" + hdncontractid.Value + "'";
            cmd = new SqlCommand(sqlstr, con);
            hdncontracttype.Value = Convert.ToString(cmd.ExecuteScalar());

            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP'";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dtftltypes);

            dtcharges = CreateDataTable();
            SqlDataReader dr;
            sqlstr = "SELECT *,RNO = ROW_NUMBER() OVER (ORDER BY  NULLIF(columnindex,0), ISNULL(NULLIF(ftltype,0),'999')) FROM ( ";
            sqlstr = sqlstr + " SELECT DISTINCT columnindex,ftltype,ftl1_trip_ratetype FROM webx_custcontract_frtmatrix_ftlslabhdr";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "'";
            sqlstr = sqlstr + " AND (trans_type='" + hdntransmode.Value + "' OR trans_type='" + hdntransname.Value + "') AND loc_reg='" + hdnmatrixtype.Value + "'";
            sqlstr = sqlstr + " AND from_loccode LIKE '" + hdnfrom.Value + "%'";
            sqlstr = sqlstr + " AND to_loccode LIKE '" + hdnto.Value + "%'";
            sqlstr = sqlstr + " ) V ORDER BY RNO ";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            for (int i = 0; i < 10; i++)
            {
                if (dr.Read())
                {
                    ftlvalues[i] = dr["ftltype"].ToString();
                    try
                    {
                        ddlratetype.SelectedValue = Convert.ToString(dr["ftl1_trip_ratetype"]);
                    }
                    catch (Exception ex)
                    { }
                }
            }

            //hdnftls.Value = ftlvalues[0] + "," + ftlvalues[1] + "," + ftlvalues[2] + "," + ftlvalues[3] + "," + ftlvalues[4];
            //hdnftls.Value = hdnftls.Value + "," + ftlvalues[5] + "," + ftlvalues[6] + "," + ftlvalues[7] + "," + ftlvalues[8] + "," + ftlvalues[9];
            hdnftls.Value = string.Join(",", ftlvalues);

            dr.Close();

            sqlstr = "EXEC usp_CustContract_FTLMatrix_FTLSlabHdt_GetForEdit_Test '" + hdncontractid.Value + "','"+ hdntransmode.Value + "','" + hdnmatrixtype.Value + "','" + hdntransname.Value + "','" + hdnfrom.Value + "','" + hdnto.Value + "' ";

            //sqlstr = "SELECT DISTINCT from_loccode AS fromloc,to_loccode AS toloc,ftl1_trip_rate,ftl1_trdays,srno";
            //sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_ftlslabhdr ";
            //sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "'";
            //sqlstr = sqlstr + " AND (trans_type='" + hdntransmode.Value + "' OR trans_type='" + hdntransname.Value + "') AND loc_reg='" + hdnmatrixtype.Value + "'";
            //sqlstr = sqlstr + " AND from_loccode LIKE '" + hdnfrom.Value + "%'";
            //sqlstr = sqlstr + " AND to_loccode LIKE '" + hdnto.Value + "%'";
            //sqlstr = sqlstr + " ORDER BY srno";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            int cnt = 0;
            DataTableFiller dtf;
            while (dr.Read())
            {
                dtf = new DataTableFiller();
                try
                {
                    dtf.From = dr["fromloc"].ToString();
                    dtf.To = dr["toloc"].ToString();

                    dtf.Rate1 = dr["ftl1_trip_rate"].ToString(); dtf.TrDays1 = dr["ftl1_trdays"].ToString();
                    dtf.Rate2 = dr["ftl2_trip_rate"].ToString(); dtf.TrDays2 = dr["ftl2_trdays"].ToString();
                    dtf.Rate3 = dr["ftl3_trip_rate"].ToString(); dtf.TrDays3 = dr["ftl3_trdays"].ToString();
                    dtf.Rate4 = dr["ftl4_trip_rate"].ToString(); dtf.TrDays4 = dr["ftl4_trdays"].ToString();
                    dtf.Rate5 = dr["ftl5_trip_rate"].ToString(); dtf.TrDays5 = dr["ftl5_trdays"].ToString();
                    dtf.Rate6 = dr["ftl6_trip_rate"].ToString(); dtf.TrDays6 = dr["ftl6_trdays"].ToString();
                    dtf.Rate7 = dr["ftl7_trip_rate"].ToString(); dtf.TrDays7 = dr["ftl7_trdays"].ToString();
                    dtf.Rate8 = dr["ftl8_trip_rate"].ToString(); dtf.TrDays8 = dr["ftl8_trdays"].ToString();
                    dtf.Rate9 = dr["ftl9_trip_rate"].ToString(); dtf.TrDays9 = dr["ftl9_trdays"].ToString();
                    dtf.Rate10 = dr["ftl10_trip_rate"].ToString(); dtf.TrDays10 = dr["ftl10_trdays"].ToString();

                    dtcharges.Rows.Add(AddDataToTable(dtf));
                }
                catch (Exception ex)
                {
                    dtcharges.Rows.Add(AddDataToTable(dtf));
                    break;
                }
            } //while (dr.Read());
            dr.Close();

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
            int j = 0;
            for (int i = 3; i < e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].ColumnSpan = 2;
                e.Row.Cells[++i].Style["display"] = "none";
            }

            for (int i = 1; i < 11; i++)
            {
                DropDownList cmbftltype = (DropDownList)e.Row.FindControl("cmbftltype" + i.ToString());
                if (cmbftltype != null)
                {
                    cmbftltype.DataSource = dtftltypes;
                    cmbftltype.DataBind();
                    cmbftltype.Items.Insert(0, new ListItem("Select", "0"));

                    try
                    {
                        cmbftltype.SelectedValue = Convert.ToString(ftlvalues[i - 1]);
                    }
                    catch (Exception ex) { }
                }
            }

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
        DropDownList[] cmbftltype = new DropDownList[10];
        for (int i = 1; i < 11; i++)
        {
            cmbftltype[i - 1] = (DropDownList)grvcharges.HeaderRow.FindControl("cmbftltype" + i.ToString());
        }

        SqlTransaction trn;
        trn = con.BeginTransaction();
        SqlCommand cmd;
        string strsql = "";

        TextBox[] txtrate = new TextBox[10];
        TextBox[] txttrdays = new TextBox[10];

        try
        {
            foreach (GridViewRow grv in grvcharges.Rows)
            {

                for (int i = 1; i < 11; i++)
                {
                    txtrate[i - 1] = (TextBox)grv.FindControl("txtrate" + i.ToString());
                    txttrdays[i - 1] = (TextBox)grv.FindControl("txttrdays" + i.ToString());

                    txtrate[i - 1].Text = txtrate[i - 1].Text.CompareTo("") == 0 ? "0.00" : txtrate[i - 1].Text;
                    txttrdays[i - 1].Text = txttrdays[i - 1].Text.CompareTo("") == 0 ? "0" : txttrdays[i - 1].Text;

                }

                TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
                TextBox txtto = (TextBox)grv.FindControl("txtto");

                CheckBox chk = (CheckBox)grv.FindControl("chkyes");



                strsql = "DELETE FROM webx_custcontract_frtmatrix_ftlslabhdr ";
                strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";
                strsql = strsql + " AND from_loccode='" + txtfrom.Text + "'";
                strsql = strsql + " AND to_loccode='" + txtto.Text + "'";
                strsql = strsql + " AND loc_reg='" + hdnmatrixtype.Value + "'";
                strsql = strsql + " AND (trans_type='" + hdntransmode.Value + "' OR trans_type='" + hdntransname.Value + "')";
                cmd = new SqlCommand(strsql, con, trn);
                cmd.ExecuteNonQuery();

                if (chk.Checked == true)
                {
                    if (txtfrom.Text.CompareTo("") == 0 || txtto.Text.CompareTo("") == 0)
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx?heading=FROM or TO location found empty");
                        return;
                    }

                    for (int i = 0; i < 10; i++)
                    {
                        strsql = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr";
                        strsql = strsql + "(custcode,contractid,from_loccode,to_loccode,ftltype,loc_reg,trans_type,";
                        strsql = strsql + "ftl1_trip_rate,ftl1_trip_ratetype,ftl1_trdays,columnindex) VALUES(";
                        strsql = strsql + "'" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
                        strsql = strsql + "'" + txtfrom.Text + "',";
                        strsql = strsql + "'" + txtto.Text + "',";
                        strsql = strsql + "'" + cmbftltype[i].SelectedValue + "',";
                        strsql = strsql + "'" + hdnmatrixtype.Value + "',";
                        strsql = strsql + "'" + hdntransmode.Value + "',";
                        strsql = strsql + txtrate[i].Text + ",";
                        strsql = strsql + "'" + ddlratetype.SelectedValue + "',";
                        strsql = strsql + txttrdays[i].Text + ","+ i.ToString()+ ")";
                        cmd = new SqlCommand(strsql, con, trn);
                        cmd.ExecuteNonQuery();
                    }
                }

            } // END OF FOREACH VALUES

            strsql = "UPDATE webx_custcontract_frtmatrix_ftlslabhdr SET ftl1_trip_ratetype='" + ddlratetype.SelectedValue + "'";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();
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


    private DataTable CreateDataTable()
    {
        DataTable myDataTable = new DataTable();
        myDataTable.Columns.Add("fromloc", typeof(string));
        myDataTable.Columns.Add("toloc", typeof(string));

        for (int i = 1; i < 11; i++)
        {
            myDataTable.Columns.Add("rate" + i.ToString(), typeof(string));
            myDataTable.Columns.Add("trdays" + i.ToString(), typeof(string));
        }

        return myDataTable;
    }

    private DataRow AddDataToTable(DataTableFiller dfl)
    {
        DataRow row;
        row = dtcharges.NewRow();

        row["fromloc"] = dfl.From;
        row["toloc"] = dfl.To;

        row["rate1"] = dfl.Rate1;
        row["trdays1"] = dfl.TrDays1;
        row["rate2"] = dfl.Rate2;
        row["trdays2"] = dfl.TrDays2;
        row["rate3"] = dfl.Rate3;
        row["trdays3"] = dfl.TrDays3;
        row["rate4"] = dfl.Rate4;
        row["trdays4"] = dfl.TrDays4;
        row["rate5"] = dfl.Rate5;
        row["trdays5"] = dfl.TrDays5;
        row["rate6"] = dfl.Rate6;
        row["trdays6"] = dfl.TrDays6;
        row["rate7"] = dfl.Rate7;
        row["trdays7"] = dfl.TrDays7;
        row["rate8"] = dfl.Rate8;
        row["trdays8"] = dfl.TrDays8;
        row["rate9"] = dfl.Rate9;
        row["trdays9"] = dfl.TrDays9;
        row["rate10"] = dfl.Rate10;
        row["trdays10"] = dfl.TrDays10;

        return row;
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

public class DataTableFiller
{
    private string from, to, rate1, trdays1;
    private string rate2, trdays2, rate3, trdays3, rate4, trdays4, rate5, trdays5, rate6, trdays6, rate7, trdays7;
    private string rate8, trdays8, rate9, trdays9, rate10, trdays10;

    public DataTableFiller()
    {
        from = "";
        rate1 = "0.00"; rate2 = "0.00"; rate3 = "0.00"; rate4 = "0.00"; rate5 = "0.00"; rate6 = "0.00";
        rate7 = "0.00"; rate8 = "0.00"; rate9 = "0.00"; rate10 = "0.00";
        trdays1 = "0"; trdays2 = "0"; trdays3 = "0"; trdays4 = "0"; trdays5 = "0"; trdays6 = "0"; trdays7 = "0";
        trdays8 = "0"; trdays9 = "0"; trdays10 = "0";
    }

    public string From { get { return from; } set { from = value; } }
    public string To { get { return to; } set { to = value; } }

    public string Rate1 { get { return rate1; } set { rate1 = value; } }
    public string TrDays1 { get { return trdays1; } set { trdays1 = value; } }

    public string Rate2 { get { return rate2; } set { rate2 = value; } }
    public string TrDays2 { get { return trdays2; } set { trdays2 = value; } }

    public string Rate3 { get { return rate3; } set { rate3 = value; } }
    public string TrDays3 { get { return trdays3; } set { trdays3 = value; } }

    public string Rate4 { get { return rate4; } set { rate4 = value; } }
    public string TrDays4 { get { return trdays4; } set { trdays4 = value; } }

    public string Rate5 { get { return rate5; } set { rate5 = value; } }
    public string TrDays5 { get { return trdays5; } set { trdays5 = value; } }

    public string Rate6 { get { return rate6; } set { rate6 = value; } }
    public string TrDays6 { get { return trdays6; } set { trdays6 = value; } }

    public string Rate7 { get { return rate7; } set { rate7 = value; } }
    public string TrDays7 { get { return trdays7; } set { trdays7 = value; } }

    public string Rate8 { get { return rate8; } set { rate8 = value; } }
    public string TrDays8 { get { return trdays8; } set { trdays8 = value; } }

    public string Rate9 { get { return rate9; } set { rate9 = value; } }
    public string TrDays9 { get { return trdays9; } set { trdays9 = value; } }

    public string Rate10 { get { return rate10; } set { rate10 = value; } }
    public string TrDays10 { get { return trdays10; } set { trdays10 = value; } }
}


