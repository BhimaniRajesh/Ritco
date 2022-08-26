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

public partial class GUI_admin_CustomerContractMaster_EditCCMStep3FreightFTL : System.Web.UI.Page
{
    static DropDownList cmbftl;
    SqlConnection con;
    static DataTable dt = new DataTable("table1");

    static DataTable dtroadfreightbranch;
    static DataTable dtroadfreightzone;
    static DataTable dtroadfreightcity;

    static DataTable dtexpressfreightbranch;
    static DataTable dtexpressfreightzone;
    static DataTable dtexpressfreightcity;

    int zoneno = 0;

    string[] arrzonename;
    string[] arrzonecode;

    SqlTransaction sqltran;

    protected string strbranches = "", strzones = "", strcities = "", strtrnmodes = "";


    protected string custcode = "", custname = "", contractid = "";
    static string randno = "", oda = "", ftl = "", slabtype = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        randno = Request.QueryString["random"].ToUpper();
        oda = Request.QueryString["ODA"].ToString();

        string sqlstr = "SELECT custcode,custcodename,contractid FROM webx_ccm_step1 WHERE temp_sr_no = '" + randno + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            custcode = dr["CustCode"].ToString();
            custname = dr["CustCodeName"].ToString();
            contractid = dr["ContractID"].ToString();
        }
        dr.Close();


        ////////////////////////////////////////////////////////////////////////////////////////////////
        //                              VALIDATION OF FROM AND TO CODES
        ///////////////////////////////////////////////////////////////////////////////////////////////

        string sqlval = "SELECT UPPER(loccode) FROM webx_location";
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






        cmbftl = new DropDownList();
        cmbftl.Items.Clear();
        cmbftl.Items.Add(new ListItem("Select", "0"));

        cmbroadbranchftl1.Items.Add(new ListItem("Select", "0"));
        cmbroadbranchftl2.Items.Add(new ListItem("Select", "0"));
        cmbroadbranchftl3.Items.Add(new ListItem("Select", "0"));
        cmbroadbranchftl4.Items.Add(new ListItem("Select", "0"));
        cmbroadbranchftl5.Items.Add(new ListItem("Select", "0"));

        cmbroadzoneftl1.Items.Add(new ListItem("Select", "0"));
        cmbroadzoneftl2.Items.Add(new ListItem("Select", "0"));
        cmbroadzoneftl3.Items.Add(new ListItem("Select", "0"));
        cmbroadzoneftl4.Items.Add(new ListItem("Select", "0"));
        cmbroadzoneftl5.Items.Add(new ListItem("Select", "0"));

        cmbroadcityftl1.Items.Add(new ListItem("Select", "0"));
        cmbroadcityftl2.Items.Add(new ListItem("Select", "0"));
        cmbroadcityftl3.Items.Add(new ListItem("Select", "0"));
        cmbroadcityftl4.Items.Add(new ListItem("Select", "0"));
        cmbroadcityftl5.Items.Add(new ListItem("Select", "0"));



        cmbexpressbranchftl1.Items.Add(new ListItem("Select", "0"));
        cmbexpressbranchftl2.Items.Add(new ListItem("Select", "0"));
        cmbexpressbranchftl3.Items.Add(new ListItem("Select", "0"));
        cmbexpressbranchftl4.Items.Add(new ListItem("Select", "0"));
        cmbexpressbranchftl5.Items.Add(new ListItem("Select", "0"));

        cmbexpresszoneftl1.Items.Add(new ListItem("Select", "0"));
        cmbexpresszoneftl2.Items.Add(new ListItem("Select", "0"));
        cmbexpresszoneftl3.Items.Add(new ListItem("Select", "0"));
        cmbexpresszoneftl4.Items.Add(new ListItem("Select", "0"));
        cmbexpresszoneftl5.Items.Add(new ListItem("Select", "0"));

        cmbexpresscityftl1.Items.Add(new ListItem("Select", "0"));
        cmbexpresscityftl2.Items.Add(new ListItem("Select", "0"));
        cmbexpresscityftl3.Items.Add(new ListItem("Select", "0"));
        cmbexpresscityftl4.Items.Add(new ListItem("Select", "0"));
        cmbexpresscityftl5.Items.Add(new ListItem("Select", "0"));



        string strftls = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP'";
        cmd = new SqlCommand(strftls, con);
        dr = cmd.ExecuteReader();
        ///((TextBox)grvexpressfreightbranch.Rows[0].FindControl("txtrans1")).Style["left"] = cmbroadbranchftl1.Style["left"];
        while (dr.Read())
        {
            cmbftl.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));

            cmbroadbranchftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadbranchftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadbranchftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadbranchftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadbranchftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));

            cmbroadzoneftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadzoneftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadzoneftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadzoneftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadzoneftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));


            cmbroadcityftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadcityftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadcityftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadcityftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbroadcityftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));



            cmbexpressbranchftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpressbranchftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpressbranchftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpressbranchftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpressbranchftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));

            cmbexpresszoneftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresszoneftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresszoneftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresszoneftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresszoneftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));


            cmbexpresscityftl1.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresscityftl2.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresscityftl3.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresscityftl4.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));
            cmbexpresscityftl5.Items.Add(new ListItem(dr["codedesc"].ToString().ToUpper(), dr["codeid"].ToString()));


        }
        dr.Close();






        // DECIDES HOW ROAD OR EXPRESS OR BOTH
        strtrnmodes = "";
        sqlval = "SELECT  road_yn,express_yn,air_yn,rail_yn,sundry_yn,ftl_yn FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
        cmd = new SqlCommand(sqlval, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = "R,";
            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",E";
        }
        dr.Close();

        if (strtrnmodes.IndexOf('R') == -1)
        {
            tblroadbranch.Style["display"] = "none";
            grvroadfreightbranch.Style["display"] = "none";

            tblroadzone.Style["display"] = "none";
            grvroadfreightzone.Style["display"] = "none";

            tblroadcity.Style["display"] = "none";
            grvroadfreightcity.Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('E') == -1)
        {
            tblexpressbranch.Style["display"] = "none";
            grvexpressfreightbranch.Style["display"] = "none";

            tblexpresszone.Style["display"] = "none";
            grvexpressfreightzone.Style["display"] = "none";

            tblexpresscity.Style["display"] = "none";
            grvexpressfreightcity.Style["display"] = "none";

        }







        if (!IsPostBack)
        {


            dt = CreateDataTable();
            for (int i = 0; i < 1; i++)
            {
                dt.Rows.Add();

            }

            //// ROAD CODING STARTS HERE

            grvroadfreightbranch.DataSource = dt;
            grvroadfreightbranch.DataBind();

            grvroadfreightzone.DataSource = dt;
            grvroadfreightzone.DataBind();

            grvroadfreightcity.DataSource = dt;
            grvroadfreightcity.DataBind();

            // EXPRESS CODING STARTS HERE
            grvexpressfreightbranch.DataSource = dt;
            grvexpressfreightbranch.DataBind();

            grvexpressfreightzone.DataSource = dt;
            grvexpressfreightzone.DataBind();

            grvexpressfreightcity.DataSource = dt;
            grvexpressfreightcity.DataBind();

            dtroadfreightbranch = new DataTable();
            dtroadfreightzone = new DataTable();
            dtroadfreightcity = new DataTable();

            dtexpressfreightbranch = new DataTable();
            dtexpressfreightzone = new DataTable();
            dtexpressfreightcity = new DataTable();


            // ROAD -  BRANCH
            dtroadfreightbranch = CreateDataTable();
            sqlval = "SELECT  DISTINCT from_loccode,to_loccode,ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='L' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbroadbranchftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadbranchftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadbranchftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadbranchftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadbranchftl5.SelectedValue = dr["ftltype"].ToString();

            hdnroadbranch.Value = cmbroadbranchftl1.SelectedValue + "," + cmbroadbranchftl2.SelectedValue + "," + cmbroadbranchftl3.SelectedValue + "," + cmbroadbranchftl4.SelectedValue + "," + cmbroadbranchftl5.SelectedValue;

            dr.Close();


            string[] arrrow = new string[12];
            string s = "";
            sqlval = "SELECT from_loccode,to_loccode,FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='L' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            int cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtroadfreightbranch);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtroadfreightbranch.Rows.Count > 0)
            {
                grvroadfreightbranch.DataSource = dtroadfreightbranch;
                grvroadfreightbranch.DataBind();
            }





            /// ROAD - CITY
            arrrow = null;
            dtroadfreightcity = CreateDataTable();

            sqlval = "SELECT  DISTINCT from_loccode,to_loccode,ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='C' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbroadcityftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadcityftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadcityftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadcityftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadcityftl5.SelectedValue = dr["ftltype"].ToString();

            hdnroadcity.Value = cmbroadcityftl1.SelectedValue + "," + cmbroadcityftl2.SelectedValue + "," + cmbroadcityftl3.SelectedValue + "," + cmbroadcityftl4.SelectedValue + "," + cmbroadcityftl5.SelectedValue;

            dr.Close();

            arrrow = new string[12];
            s = "";
            sqlval = "SELECT from_loccode,to_loccode,FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='C' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtroadfreightcity);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtroadfreightcity.Rows.Count > 0)
            {
                grvroadfreightcity.DataSource = dtroadfreightcity;
                grvroadfreightcity.DataBind();
            }





            /// ROAD - ZONE
            arrrow = null;
            dtroadfreightzone = CreateDataTable();


            sqlval = "SELECT  DISTINCT from_loccode,to_loccode,ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='R' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbroadzoneftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadzoneftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadzoneftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadzoneftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbroadzoneftl5.SelectedValue = dr["ftltype"].ToString();

            hdnroadzone.Value = cmbroadzoneftl1.SelectedValue + "," + cmbroadzoneftl2.SelectedValue + "," + cmbroadzoneftl3.SelectedValue + "," + cmbroadzoneftl4.SelectedValue + "," + cmbroadzoneftl5.SelectedValue;

            dr.Close();
            arrrow = new string[12];
            s = "";
            sqlval = "SELECT from_loccode=(select codedesc from webx_master_general where codetype='ZONE' and codeid=from_loccode),to_loccode=(select codedesc from webx_master_general where codetype='ZONE' and codeid=to_loccode),FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='R' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtroadfreightzone);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtroadfreightzone.Rows.Count > 0)
            {
                grvroadfreightzone.DataSource = dtroadfreightzone;
                grvroadfreightzone.DataBind();
            }







            // EXPRESS - BRANCH
            dtexpressfreightbranch = CreateDataTable();


            sqlval = "SELECT  DISTINCT from_loccode,to_loccode,ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='L' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbexpressbranchftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpressbranchftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpressbranchftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpressbranchftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpressbranchftl5.SelectedValue = dr["ftltype"].ToString();

            hdnexpressbranch.Value = cmbexpressbranchftl1.SelectedValue + "," + cmbexpressbranchftl2.SelectedValue + "," + cmbexpressbranchftl3.SelectedValue + "," + cmbexpressbranchftl4.SelectedValue + "," + cmbexpressbranchftl5.SelectedValue;

            dr.Close();




            arrrow = new string[12];
            s = "";
            sqlval = "SELECT from_loccode,to_loccode,FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='L' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtexpressfreightbranch);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtexpressfreightbranch.Rows.Count > 0)
            {
                grvexpressfreightbranch.DataSource = dtexpressfreightbranch;
                grvexpressfreightbranch.DataBind();
            }





            /// express - CITY
            arrrow = null;
            dtexpressfreightcity = CreateDataTable();



            sqlval = "SELECT  DISTINCT from_loccode,to_loccode,ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='C' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbexpresscityftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresscityftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresscityftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresscityftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresscityftl5.SelectedValue = dr["ftltype"].ToString();

            hdnexpresscity.Value = cmbexpresscityftl1.SelectedValue + "," + cmbexpresscityftl2.SelectedValue + "," + cmbexpresscityftl3.SelectedValue + "," + cmbexpresscityftl4.SelectedValue + "," + cmbexpresscityftl5.SelectedValue;

            dr.Close();

            arrrow = new string[12];
            s = "";
            sqlval = "SELECT from_loccode,to_loccode,FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='C' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtexpressfreightcity);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtexpressfreightcity.Rows.Count > 0)
            {
                grvexpressfreightcity.DataSource = dtexpressfreightcity;
                grvexpressfreightcity.DataBind();
            }





            /// express - ZONE
            arrrow = null;
            dtexpressfreightzone = CreateDataTable();


            sqlval = "SELECT  DISTINCT ftltype,srno FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='R' ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
                cmbexpresszoneftl1.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresszoneftl2.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresszoneftl3.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresszoneftl4.SelectedValue = dr["ftltype"].ToString();
            if (dr.Read())
                cmbexpresszoneftl5.SelectedValue = dr["ftltype"].ToString();

            hdnexpresszone.Value = cmbexpresszoneftl1.SelectedValue + "," + cmbexpresszoneftl2.SelectedValue + "," + cmbexpresszoneftl3.SelectedValue + "," + cmbexpresszoneftl4.SelectedValue + "," + cmbexpresszoneftl5.SelectedValue;

            dr.Close();


            arrrow = new string[12];
            s = "";
            sqlval = "SELECT from_loccode=(select codedesc from webx_master_general where codetype='ZONE' and codeid=from_loccode),to_loccode=(select codedesc from webx_master_general where codetype='ZONE' and codeid=to_loccode),FTL1_TRIP_RATE,FTL1_TRDAYS FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='R'  ORDER BY srno";
            cmd = new SqlCommand(sqlval, con);
            dr = cmd.ExecuteReader();
            cnt = 0;
            while (dr.Read())
            {
                if (cnt == 0)
                {
                    s = dr["from_loccode"].ToString() + "~";
                    s = s + dr["to_loccode"].ToString() + "~";
                    cnt += 2;
                }

                s = s + dr["ftl1_trip_rate"].ToString() + "~";
                s = s + dr["ftl1_trdays"].ToString() + "~";
                cnt += 2;
                if (cnt == 12)
                {
                    s = s.Remove(s.Length - 1);
                    arrrow = s.Split('~');
                    cnt = 0;
                    AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], arrrow[9], arrrow[10], arrrow[11], dtexpressfreightzone);
                    arrrow = null;
                    s = "";
                }
            }
            dr.Close();


            if (dtexpressfreightzone.Rows.Count > 0)
            {
                grvexpressfreightzone.DataSource = dtexpressfreightzone;
                grvexpressfreightzone.DataBind();
            }







        }

    }

    protected void checkYes(GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)(e.Row.FindControl("chkyes"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            if (txtfrom.Text.CompareTo("") != 0)
            {
                chk.Checked = true;
            }
        }
    }

    protected void grvroadfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('branch','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('branch','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsroadfreightbranch_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsroadfreightbranch.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsroadfreightbranch.Text);
            }
            catch (Exception ex)
            {
                txtrowsroadfreightbranch.Text = "";
                txtrowsroadfreightbranch.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtroadfreightbranch.Rows.Add();
        }

        grvroadfreightbranch.DataSource = dtroadfreightbranch;
        grvroadfreightbranch.DataBind();


    }

    protected void grvroadfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('zone','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('zone','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsroadfreightzone_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsroadfreightzone.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsroadfreightzone.Text);
            }
            catch (Exception ex)
            {
                txtrowsroadfreightzone.Text = "";
                txtrowsroadfreightzone.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtroadfreightzone.Rows.Add();
        }

        grvroadfreightzone.DataSource = dtroadfreightzone;
        grvroadfreightzone.DataBind();


    }

    protected void grvroadfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsroadfreightcity_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsroadfreightcity.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsroadfreightcity.Text);
            }
            catch (Exception ex)
            {
                txtrowsroadfreightcity.Text = "";
                txtrowsroadfreightcity.Focus();
            }
        }


        for (int i = 0; i < maxrows; i++)
        {
            dtroadfreightcity.Rows.Add();
        }

        grvroadfreightcity.DataSource = dtroadfreightcity;
        grvroadfreightcity.DataBind();


    }



    protected void grvexpressfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('branch','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('branch','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsexpressfreightbranch_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsexpressfreightbranch.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsexpressfreightbranch.Text);
            }
            catch (Exception ex)
            {
                txtrowsexpressfreightbranch.Text = "";
                txtrowsexpressfreightbranch.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtexpressfreightbranch.Rows.Add();
        }

        grvexpressfreightbranch.DataSource = dtexpressfreightbranch;
        grvexpressfreightbranch.DataBind();


    }

    protected void grvexpressfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('zone','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('zone','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsexpressfreightzone_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsexpressfreightzone.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsexpressfreightzone.Text);
            }
            catch (Exception ex)
            {
                txtrowsexpressfreightzone.Text = "";
                txtrowsexpressfreightzone.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtexpressfreightzone.Rows.Add();
        }

        grvexpressfreightzone.DataSource = dtexpressfreightzone;
        grvexpressfreightzone.DataBind();


    }

    protected void grvexpressfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        checkYes(e);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputButton btnfrom = (HtmlInputButton)(e.Row.FindControl("btnfrom"));
            HtmlInputButton btnto = (HtmlInputButton)(e.Row.FindControl("btnto"));
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));

            btnfrom.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtfrom.ClientID + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtto.ClientID + "','none')");
        }
    }
    protected void btnrowsexpressfreightcity_OnClick(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsexpressfreightcity.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsexpressfreightcity.Text);
            }
            catch (Exception ex)
            {
                txtrowsexpressfreightcity.Text = "";
                txtrowsexpressfreightcity.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dtexpressfreightcity.Rows.Add();
        }

        grvexpressfreightcity.DataSource = dtexpressfreightcity;
        grvexpressfreightcity.DataBind();


    }




    protected void btnsubmit_Click(object sender, EventArgs e)
    {



        string str = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='zone' AND statuscode='Y'";
        SqlCommand cm = new SqlCommand(str, con);
        zoneno = Convert.ToInt16(cm.ExecuteScalar());
        arrzonename = new string[zoneno];
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


        sqltran = con.BeginTransaction();


        try
        {

            // CLEARING webx_custcontract_frtmatrix_ftlslabhdr TABLE
            string strdelete = "DELETE FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE contractid = '" + contractid + "'";
            SqlCommand cmd = new SqlCommand(strdelete, con, sqltran);
            cmd.ExecuteNonQuery();

            insertGrid(grvroadfreightbranch, "ROAD", "L", hdnroadbranch);
            insertGrid(grvroadfreightzone, "ROAD", "R", hdnroadzone);
            insertGrid(grvroadfreightcity, "ROAD", "C", hdnroadcity);

            insertGrid(grvexpressfreightbranch, "EXPRESS", "L", hdnexpressbranch);
            insertGrid(grvexpressfreightzone, "EXPRESS", "R", hdnexpresszone);
            insertGrid(grvexpressfreightcity, "EXPRESS", "C", hdnexpresscity);
        }
        catch (Exception ex)
        {
            sqltran.Rollback();
            Response.Write("SQL Exception" + "\n" + ex.Message);
            return;
        }

        sqltran.Commit();


        if (oda.ToUpper().CompareTo("Y") == 0)
        {
            Response.Redirect("EditCCMODA.aspx?Random=" + randno);
        }
        else
        {
            Response.Redirect("CCM_DisplayResult.aspx?ContractID=" + contractid + "&CustCodeName=" + custname + "&CCMMode=A");
        }



    }



    protected void insertGrid(GridView grid, string trntype, string locchar, HiddenField hdn)
    {






        string[] arrfrom = new string[grid.Rows.Count];
        string[] arrto = new string[grid.Rows.Count];

        string[] arrrate1 = new string[grid.Rows.Count];
        string[] arrtrans1 = new string[grid.Rows.Count];

        string[] arrrate2 = new string[grid.Rows.Count];
        string[] arrtrans2 = new string[grid.Rows.Count];

        string[] arrrate3 = new string[grid.Rows.Count];
        string[] arrtrans3 = new string[grid.Rows.Count];

        string[] arrrate4 = new string[grid.Rows.Count];
        string[] arrtrans4 = new string[grid.Rows.Count];

        string[] arrrate5 = new string[grid.Rows.Count];
        string[] arrtrans5 = new string[grid.Rows.Count];

        bool[] arryes = new bool[grid.Rows.Count];

        string[] cmbval = hdn.Value.Split(',');

        int tmpi = 0;

        foreach (GridViewRow grvrow in grid.Rows)
        {

            TextBox txtfrom = (TextBox)(grvrow.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(grvrow.FindControl("txtto"));

            TextBox txtrate1 = (TextBox)(grvrow.FindControl("txtrate1"));
            TextBox txttrans1 = (TextBox)(grvrow.FindControl("txttrans1"));

            TextBox txtrate2 = (TextBox)(grvrow.FindControl("txtrate2"));
            TextBox txttrans2 = (TextBox)(grvrow.FindControl("txttrans2"));

            TextBox txtrate3 = (TextBox)(grvrow.FindControl("txtrate3"));
            TextBox txttrans3 = (TextBox)(grvrow.FindControl("txttrans3"));

            TextBox txtrate4 = (TextBox)(grvrow.FindControl("txtrate4"));
            TextBox txttrans4 = (TextBox)(grvrow.FindControl("txttrans4"));

            TextBox txtrate5 = (TextBox)(grvrow.FindControl("txtrate5"));
            TextBox txttrans5 = (TextBox)(grvrow.FindControl("txttrans5"));

            CheckBox chk = (CheckBox)(grvrow.FindControl("chkyes"));



            if (txtrate1.Text.CompareTo("") == 0)
                txtrate1.Text = "0";

            if (txttrans1.Text.CompareTo("") == 0)
                txttrans1.Text = "0";


            if (txtrate2.Text.CompareTo("") == 0)
                txtrate2.Text = "0";

            if (txttrans2.Text.CompareTo("") == 0)
                txttrans2.Text = "0";


            if (txtrate3.Text.CompareTo("") == 0)
                txtrate3.Text = "0";

            if (txttrans3.Text.CompareTo("") == 0)
                txttrans3.Text = "0";


            if (txtrate4.Text.CompareTo("") == 0)
                txtrate4.Text = "0";

            if (txttrans4.Text.CompareTo("") == 0)
                txttrans4.Text = "0";


            if (txtrate5.Text.CompareTo("") == 0)
                txtrate5.Text = "0";

            if (txttrans5.Text.CompareTo("") == 0)
                txttrans5.Text = "0";


            arrfrom[tmpi] = txtfrom.Text;
            arrto[tmpi] = txtto.Text;

            arrrate1[tmpi] = txtrate1.Text;
            arrtrans1[tmpi] = txttrans1.Text;

            arrrate2[tmpi] = txtrate2.Text;
            arrtrans2[tmpi] = txttrans2.Text;

            arrrate3[tmpi] = txtrate3.Text;
            arrtrans3[tmpi] = txttrans3.Text;

            arrrate4[tmpi] = txtrate4.Text;
            arrtrans4[tmpi] = txttrans4.Text;

            arrrate5[tmpi] = txtrate5.Text;
            arrtrans5[tmpi] = txttrans5.Text;


            arryes[tmpi] = chk.Checked;

            tmpi++;

        } // grid brace



        string strinsert = "";
        for (int i = 0; i < grid.Rows.Count; i++)
        {

            if (arryes[i] == true)
            {
                strinsert = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr(";
                strinsert = strinsert + "contractid,custcode,from_loccode,to_loccode,ftl1_trip_rate,ftl1_trdays,";
                strinsert = strinsert + "trans_type,loc_reg,ftltype)";
                strinsert = strinsert + " VALUES('" + contractid + "',";
                strinsert = strinsert + "'" + custcode + "',";
                if (locchar.CompareTo("R") == 0)
                {
                    strinsert = strinsert + "'" + returnZoneCode(arrfrom[i]) + "',";
                    strinsert = strinsert + "'" + returnZoneCode(arrto[i]) + "',";
                }
                else
                {
                    strinsert = strinsert + "'" + arrfrom[i] + "',";
                    strinsert = strinsert + "'" + arrto[i] + "',";
                }
                strinsert = strinsert + arrrate1[i] + ",";
                strinsert = strinsert + arrtrans1[i] + ",'" + trntype + "','" + locchar + "','" + cmbval[0] + "')";
                SqlCommand cmd = new SqlCommand(strinsert, con, sqltran);
                cmd.ExecuteNonQuery();

                strinsert = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr(";
                strinsert = strinsert + "contractid,custcode,from_loccode,to_loccode,ftl1_trip_rate,ftl1_trdays,";
                strinsert = strinsert + "trans_type,loc_reg,ftltype)";
                strinsert = strinsert + " VALUES('" + contractid + "',";
                strinsert = strinsert + "'" + custcode + "',";
                if (locchar.CompareTo("R") == 0)
                {
                    strinsert = strinsert + "'" + returnZoneCode(arrfrom[i]) + "',";
                    strinsert = strinsert + "'" + returnZoneCode(arrto[i]) + "',";
                }
                else
                {
                    strinsert = strinsert + "'" + arrfrom[i] + "',";
                    strinsert = strinsert + "'" + arrto[i] + "',";
                }
                strinsert = strinsert + arrrate2[i] + ",";
                strinsert = strinsert + arrtrans2[i] + ",'" + trntype + "','" + locchar + "','" + cmbval[1] + "')";
                cmd = new SqlCommand(strinsert, con, sqltran);
                cmd.ExecuteNonQuery();

                strinsert = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr(";
                strinsert = strinsert + "contractid,custcode,from_loccode,to_loccode,ftl1_trip_rate,ftl1_trdays,";
                strinsert = strinsert + "trans_type,loc_reg,ftltype)";
                strinsert = strinsert + " VALUES('" + contractid + "',";
                strinsert = strinsert + "'" + custcode + "',";
                if (locchar.CompareTo("R") == 0)
                {
                    strinsert = strinsert + "'" + returnZoneCode(arrfrom[i]) + "',";
                    strinsert = strinsert + "'" + returnZoneCode(arrto[i]) + "',";
                }
                else
                {
                    strinsert = strinsert + "'" + arrfrom[i] + "',";
                    strinsert = strinsert + "'" + arrto[i] + "',";
                }
                strinsert = strinsert + arrrate3[i] + ",";
                strinsert = strinsert + arrtrans3[i] + ",'" + trntype + "','" + locchar + "','" + cmbval[2] + "')";
                cmd = new SqlCommand(strinsert, con, sqltran);
                cmd.ExecuteNonQuery();



                strinsert = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr(";
                strinsert = strinsert + "contractid,custcode,from_loccode,to_loccode,ftl1_trip_rate,ftl1_trdays,";
                strinsert = strinsert + "trans_type,loc_reg,ftltype)";
                strinsert = strinsert + " VALUES('" + contractid + "',";
                strinsert = strinsert + "'" + custcode + "',";
                if (locchar.CompareTo("R") == 0)
                {
                    strinsert = strinsert + "'" + returnZoneCode(arrfrom[i]) + "',";
                    strinsert = strinsert + "'" + returnZoneCode(arrto[i]) + "',";
                }
                else
                {
                    strinsert = strinsert + "'" + arrfrom[i] + "',";
                    strinsert = strinsert + "'" + arrto[i] + "',";
                }
                strinsert = strinsert + arrrate4[i] + ",";
                strinsert = strinsert + arrtrans4[i] + ",'" + trntype + "','" + locchar + "','" + cmbval[3] + "')";
                cmd = new SqlCommand(strinsert, con, sqltran);
                cmd.ExecuteNonQuery();


                strinsert = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr(";
                strinsert = strinsert + "contractid,custcode,from_loccode,to_loccode,ftl1_trip_rate,ftl1_trdays,";
                strinsert = strinsert + "trans_type,loc_reg,ftltype)";
                strinsert = strinsert + " VALUES('" + contractid + "',";
                strinsert = strinsert + "'" + custcode + "',";
                if (locchar.CompareTo("R") == 0)
                {
                    strinsert = strinsert + "'" + returnZoneCode(arrfrom[i]) + "',";
                    strinsert = strinsert + "'" + returnZoneCode(arrto[i]) + "',";
                }
                else
                {
                    strinsert = strinsert + "'" + arrfrom[i] + "',";
                    strinsert = strinsert + "'" + arrto[i] + "',";
                }
                strinsert = strinsert + arrrate5[i] + ",";
                strinsert = strinsert + arrtrans5[i] + ",'" + trntype + "','" + locchar + "','" + cmbval[4] + "')";
                cmd = new SqlCommand(strinsert, con, sqltran);
                cmd.ExecuteNonQuery();
            }

        }




    }



    private DataTable CreateDataTable()
    {
        DataTable myDataTable = new DataTable();

        DataColumn myDataColumn;

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "from_loccode";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "to_loccode";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rate1";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "trans1";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rate2";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "trans2";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rate3";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "trans3";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rate4";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "trans4";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rate5";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "trans5";
        myDataTable.Columns.Add(myDataColumn);

        return myDataTable;
    }


    private void AddDataToTable(string from_loccode, string to_loccode, string rate1, string trans1, string rate2, string trans2, string rate3, string trans3, string rate4, string trans4, string rate5, string trans5, DataTable myTable)
    {
        DataRow row;

        row = myTable.NewRow();
        row["from_loccode"] = from_loccode;
        row["to_loccode"] = to_loccode;
        row["rate1"] = rate1;
        row["trans1"] = trans1;
        row["rate2"] = rate2;
        row["trans2"] = trans2;
        row["rate3"] = rate3;
        row["trans3"] = trans3;
        row["rate4"] = rate4;
        row["trans4"] = trans4;
        row["rate5"] = rate5;
        row["trans5"] = trans5;

        myTable.Rows.Add(row);
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
