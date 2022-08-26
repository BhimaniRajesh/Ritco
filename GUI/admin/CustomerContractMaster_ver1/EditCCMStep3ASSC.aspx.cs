using System;
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
using System.Data.SqlClient;

public partial class EditCCMStep3ASSC : System.Web.UI.Page
{
    SqlConnection con;
    SqlTransaction sqltrn;

    static DataTable dtbranch;
    static DataTable dtzone;
    static DataTable dtcity;

    MyFunctions fn = new MyFunctions();

    int zoneno = 0;

    string[] arrzonename;
    string[] arrzonecode;

    protected string contractid = "", slabtype = "", ftl = "", oda = "", custcode = "";
    protected string strcities = "", strbranches = "", strzones = "", strtrnmodes = "", servicetype = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnsubmit.Attributes.Add("onclick", "javascript:return submitValidation()");

        slabtype = Request.QueryString["Slab"].ToString();

        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }

       
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + "  :  " + fn.Getcustomer(custcode);

        strtrnmodes = "";
        string sqlval = "SELECT  road_yn,express_yn,air_yn,rail_yn,sundry_yn,ftl_yn FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
        SqlCommand cmd = new SqlCommand(sqlval, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = "R";
            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",E";
            if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",A";
            if (dr["rail_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",T";
        }
        dr.Close();





        ////////////////////////////////////////////////////////////////////////////////////////////////
        //                              VALIDATION OF FROM AND TO CODES
        ///////////////////////////////////////////////////////////////////////////////////////////////

        sqlval = "SELECT UPPER(loccode) FROM webx_location";
        cmd = new SqlCommand(sqlval, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            strbranches = strbranches + dr[0].ToString() + ",";
        }
        dr.Close();

        sqlval = "SELECT UPPER(codedesc) FROM webx_master_general WHERE UPPER(codetype)='ZONE'";
        cmd = new SqlCommand(sqlval, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            strzones = strzones + dr[0].ToString() + ",";
        }
        dr.Close();

        sqlval = "SELECT UPPER(location) FROM webx_citymaster";
        cmd = new SqlCommand(sqlval, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            strcities = strcities + dr[0].ToString() + ",";
        }
        dr.Close();

        /////////////////////////////////////////////////////////////////////////////////////////////////////
        //                             VALIDATION OF FROM AND TO ENDS HERE
        /////////////////////////////////////////////////////////////////////////////////////////////////////




        if (!IsPostBack)
        {

            dtbranch = new DataTable();
            dtzone = new DataTable();
            dtcity = new DataTable();


            //grvbranch.DataSource = dt;
            //grvbranch.DataBind();

            //grvzone.DataSource = dt;
            //grvzone.DataBind();

            //grvcity.DataSource = dt;
            //grvcity.DataBind();



            /////////////////////////////////////////////////////////////////////////
            //              RETRIEVING DATA
            ////////////////////////////////////////////////////////////////////////
            string strsqlcmb = "SELECT TOP 1 rate_type FROM webx_custcontract_locdet WHERE contractid='" + contractid + "' AND custcode='" + custcode + "'";
            cmd = new SqlCommand(strsqlcmb, con);
            string cmbselval = "";
            cmbselval = Convert.ToString(cmd.ExecuteScalar());

            if (cmbselval.CompareTo("") == 0)
            {
                strsqlcmb = "SELECT TOP 1 rate_type FROM webx_custcontract_regdet WHERE contractid='" + contractid + "' AND custcode='" + custcode + "'";
                cmd = new SqlCommand(strsqlcmb, con);
                cmbselval = Convert.ToString(cmd.ExecuteScalar());
            }

            if (cmbselval.CompareTo("") == 0)
            {
                strsqlcmb = "SELECT TOP 1 rate_type FROM webx_custcontract_citydet WHERE contractid='" + contractid + "' AND custcode='" + custcode + "'";
                cmd = new SqlCommand(strsqlcmb, con);
                cmbselval = Convert.ToString(cmd.ExecuteScalar());
            }

            cmbratetype.SelectedValue = cmbselval;



            //RETRIEVING DATA OF BRANCH
            string strretrieve = "SELECT rate_type,fromlocode,tolocode,air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_locdet WHERE contractid='" + contractid + "' AND custcode='" + custcode + "'";
            cmd = new SqlCommand(strretrieve, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(dtbranch);
            if (dtbranch.Rows.Count <= 0)
            {
                dtbranch.Rows.Add();
            }

            grvbranch.DataSource = dtbranch;
            grvbranch.DataBind();





            // RETRIEVING DATA OF ZONES
            strretrieve = "SELECT fromregion=(select codedesc from webx_master_general where codetype='zone' and ( codeid=fromregion or codedesc=fromregion )),toregion=(select codedesc from webx_master_general where codetype='zone' and ( codeid=toregion or codedesc=toregion )),air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_regdet WHERE contractid='" + contractid +"' AND custcode='" + custcode + "'";
            cmd = new SqlCommand(strretrieve, con);
            da = new SqlDataAdapter(cmd);

            da.Fill(dtzone);
            if (dtzone.Rows.Count <= 0)
            {
                dtzone.Rows.Add();
            }

            grvzone.DataSource = dtzone;
            grvzone.DataBind();


            // RETRIEVING DATA OF CITY
            strretrieve = "SELECT fromcity,tocity,air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_citydet WHERE contractid='" + contractid + "' AND custcode='" + custcode + "'";
            cmd = new SqlCommand(strretrieve, con);
            da = new SqlDataAdapter(cmd);

            da.Fill(dtcity);
            if (dtcity.Rows.Count <= 0)
            {
                dtcity.Rows.Add();
            }
            grvcity.DataSource = dtcity;
            grvcity.DataBind();
        }// IsPostBack ENDS HERE
    }

    protected void gridBound(GridView sender, GridViewRowEventArgs e,string gridtype)
    {

       if (strtrnmodes.IndexOf('A') == -1)
        {
            e.Row.Cells[3].Style["display"] = "none";
            e.Row.Cells[4].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('R') == -1)
        {
            e.Row.Cells[5].Style["display"] = "none";
            e.Row.Cells[6].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('T') == -1)
        {
            e.Row.Cells[7].Style["display"] = "none";
            e.Row.Cells[8].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('E') == -1)
        {
            e.Row.Cells[9].Style["display"] = "none";
            e.Row.Cells[10].Style["display"] = "none";
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((HtmlInputButton)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('" + gridtype + "','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((HtmlInputButton)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('" + gridtype + "','" + txtto.ClientID.ToString() + "','none')");
            
            CheckBox chk = (CheckBox)(e.Row.FindControl("chkyes"));
           if (txtfrom.Text.CompareTo("") != 0)
            {
                chk.Checked = true;
            }

        }

    }


    protected void grvbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBound((GridView)sender, e, "branch");
    }
    protected void btnrowsbranch_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsbranch.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsbranch.Text);
            }
            catch (Exception ex)
            {
                txtrowsbranch.Text = "";
                txtrowsbranch.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtbranch.Rows.Add();
        }

        grvbranch.DataSource = dtbranch;
        grvbranch.DataBind();
    }
    protected void grvzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBound((GridView)sender, e, "zone");
    }

    protected void btnrowszone_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowszone.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowszone.Text);
            }
            catch (Exception ex)
            {
                txtrowszone.Text = "";
                txtrowszone.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtzone.Rows.Add();
        }

        grvzone.DataSource = dtzone;
        grvzone.DataBind();
    }
    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBound((GridView)sender, e, "city");
    }

    protected void btnrowscity_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowscity.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowscity.Text);
            }
            catch (Exception ex)
            {
                txtrowscity.Text = "";
                txtrowscity.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtcity.Rows.Add();
        }

        grvcity.DataSource = dtcity;
        grvcity.DataBind();
    }


    protected void btnsubmit_Click(object sender,EventArgs e)
    {

        string str = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='zone' AND statuscode='Y'";
        SqlCommand cm = new SqlCommand(str,con);
        zoneno = Convert.ToInt16(cm.ExecuteScalar());
        arrzonename =new  string[zoneno];
        arrzonecode = new string[zoneno];
        
        str = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='zone' AND statuscode='Y' ORDER BY codeid";
        cm = new SqlCommand(str, con);
        SqlDataReader dr = cm.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            arrzonecode[i] = dr["codeid"].ToString();
            arrzonename[i] = dr["codedesc"].ToString();
            i++;
        }
        dr.Close();


        sqltrn = con.BeginTransaction();

        // FIRST STEP IS TO UPDATE INFORMATION OF CUSTOMER THAT HE/SHE IS USING SINGLE SLAB...
        try
        {
            string strupdate = "UPDATE webx_custcontract_hdr SET single_slab_yn=";
            if (slabtype.CompareTo("S") == 0)
                strupdate = strupdate + "'Y',multiple_slab_yn='N'"; 
            else
                strupdate = strupdate + "'N',multiple_slab_yn='Y'";
            strupdate = strupdate + " WHERE custcode = '" + custcode + "'";
            SqlCommand cmd = new SqlCommand(strupdate,con,sqltrn);
            cmd.ExecuteNonQuery();

            string strdel = "DELETE FROM webx_custcontract_locdet WHERE custcode='" + custcode + "'";
            cmd = new SqlCommand(strdel, con,sqltrn);
            cmd.ExecuteNonQuery();

            strdel = "DELETE FROM webx_custcontract_regdet WHERE custcode='" + custcode + "'";
            cmd = new SqlCommand(strdel, con,sqltrn);
            cmd.ExecuteNonQuery();

            strdel = "DELETE FROM webx_custcontract_citydet WHERE custcode='" + custcode + "'";
            cmd = new SqlCommand(strdel, con,sqltrn);
            cmd.ExecuteNonQuery();


            gridInsert(grvbranch, "branch");
            gridInsert(grvzone, "zone");
            gridInsert(grvcity, "city");

        }
        catch(Exception ex)
        {
            sqltrn.Rollback();
            Response.Write("Single Slab Not Updated.....DataBase Updation/Insertion ERROR.." + ex.Message);
            return;
        }

        sqltrn.Commit();


      Response.Redirect("CCM_DisplayResult.aspx?CCMMode=E" + "&contractid=" + contractid + "&custcode=" + custcode);

    }


    private void gridInsert(GridView objgrid,string gridtype)
    {
        string strinsert = "";
        SqlCommand cmd;
        foreach (GridViewRow grv in objgrid.Rows)
        {
            TextBox txtfrom = (TextBox)(grv.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(grv.FindControl("txtto"));

            TextBox txtroadrate = (TextBox)(grv.FindControl("txtroadrate"));
            TextBox txtroadtrans = (TextBox)(grv.FindControl("txtroadtransit"));

            TextBox txtairrate = (TextBox)(grv.FindControl("txtairrate"));
            TextBox txtairtrans = (TextBox)(grv.FindControl("txtairtransit"));

            TextBox txttrainrate = (TextBox)(grv.FindControl("txttrainrate"));
            TextBox txttraintrans = (TextBox)(grv.FindControl("txttraintransit"));

            TextBox txtexpressrate = (TextBox)(grv.FindControl("txtexpressrate"));
            TextBox txtexpresstrans = (TextBox)(grv.FindControl("txtexpresstransit"));

            CheckBox chk = (CheckBox)(grv.FindControl("chkyes"));

            if (txtroadrate.Text.CompareTo("") == 0)
                txtroadrate.Text = "0";

            if (txtairrate.Text.CompareTo("") == 0)
                txtairrate.Text = "0";

            if (txttrainrate.Text.CompareTo("") == 0)
                txttrainrate.Text = "0";

            if (txtexpressrate.Text.CompareTo("") == 0)
                txtexpressrate.Text = "0";


            if (txtroadtrans.Text.CompareTo("") == 0)
                txtroadtrans.Text = "0";

            if (txtairtrans.Text.CompareTo("") == 0)
                txtairtrans.Text = "0";

            if (txttraintrans.Text.CompareTo("") == 0)
                txttraintrans.Text = "0";

            if (txtexpresstrans.Text.CompareTo("") == 0)
                txtexpresstrans.Text = "0";

            if (chk.Checked == true)
            {
                if (gridtype.CompareTo("branch") == 0)
                    strinsert = "INSERT INTO webx_custcontract_locdet(contractid, custcode, fromlocode, tolocode, ";
                if (gridtype.CompareTo("zone") == 0)
                    strinsert = "INSERT INTO webx_custcontract_regdet(contractid, custcode, fromregion, toregion, ";
                if (gridtype.CompareTo("city") == 0)
                    strinsert = "INSERT INTO webx_custcontract_citydet(contractid, custcode, fromcity, tocity, ";
                strinsert = strinsert + "air_rate, air_days,";
                strinsert = strinsert + "road_rate,road_days,";
                strinsert = strinsert + "train_rate, train_days,";
                strinsert = strinsert + "express_rate, express_days,";
                strinsert = strinsert + "rate_type, contract_type)";
                strinsert = strinsert + " VALUES ('" + contractid + "','" + custcode + "',";

                string sfrom=returnZoneCode(txtfrom.Text);
                string sto = returnZoneCode(txtto.Text);
                if (gridtype.CompareTo("zone") == 0)
                    strinsert = strinsert + "'" + sfrom + "','" + sto + "',";
                else
                    strinsert = strinsert + "'" + txtfrom.Text + "','" + txtto.Text + "',";

                strinsert = strinsert + txtairrate.Text + "," + txtairtrans.Text + ",";
                strinsert = strinsert + txtroadrate.Text + "," + txtroadtrans.Text + ",";
                strinsert = strinsert + txttrainrate.Text + "," + txttraintrans.Text + ",";
                strinsert = strinsert + txtexpressrate.Text + "," + txtexpresstrans.Text + ",'" + cmbratetype.SelectedValue + "','')";
                cmd = new SqlCommand(strinsert, con, sqltrn);
                cmd.ExecuteNonQuery();
            }
        }
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


    private string returnZoneName(string zonecode)
    {
        for (int i = 0; i < zoneno; i++)
        {
            if (zonecode.ToUpper().CompareTo(arrzonecode[i].ToString().ToUpper()) == 0)
            {
                return arrzonename[i].ToString();
            }
        }
        return "";
    }
}   
                 
