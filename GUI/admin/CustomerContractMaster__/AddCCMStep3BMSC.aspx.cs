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

public partial class GUI_admin_CustomerContractMaster_AddCCMStep3BMSC : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    SqlConnection con;

    MyFunctions fn = new MyFunctions();

    SqlTransaction sqltran;

    int zoneno = 0;

    string[] arrzonename;
    string[] arrzonecode;

    protected string slabtype = "", ftl = "", oda = "", randno = "",custcode="",custname="",contractid="";
    protected string strcities = "", strbranches = "", strzones = "",strtrnmodes="",servicetype="";
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick", "javascript:return submitValidation()");

        randno = Request.QueryString["Random"].ToString();
        slabtype = Request.QueryString["Slab"].ToString();
        ftl = Request.QueryString["FTL"].ToString();
        oda = Request.QueryString["ODA"].ToString();
        
       

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        string sqlstr = "SELECT custcode,custcodename,contractid FROM webx_ccm_step1 WHERE temp_sr_no = " + randno;


        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            custcode = dr["CustCode"].ToString();
            custname = dr["CustCodeName"].ToString();
            contractid = dr["ContractID"].ToString();
        }
        dr.Close();


        strtrnmodes = "";
        string sqlval = "SELECT  road_yn,express_yn,air_yn,rail_yn,sundry_yn,ftl_yn FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
        cmd = new SqlCommand(sqlval, con);
        dr = cmd.ExecuteReader();
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


     

        if (strtrnmodes.IndexOf('A') ==-1)
        {
            tblairbranch.Style["display"] = "none";
            grvairfreightbranch.Style["display"] = "none";

            tblairzone.Style["display"] = "none";
            grvairfreightzone.Style["display"] = "none";

            tblaircity.Style["display"] = "none";
            grvairfreightcity.Style["display"] = "none";
        }

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
        if (strtrnmodes.IndexOf('T') == -1)
        {
            tbltrainbranch.Style["display"] = "none";
            grvtrainfreightbranch.Style["display"] = "none";

            tbltrainzone.Style["display"] = "none";
            grvtrainfreightzone.Style["display"] = "none";

            tbltraincity.Style["display"] = "none";
            grvtrainfreightcity.Style["display"] = "none";

        }




        ////////////////////////////////////////////////////////////////////////////////////////////////
        //                              VALIDATION OF FROM AND TO CODES
        ///////////////////////////////////////////////////////////////////////////////////////////////

        sqlval = "SELECT UPPER(loccode) FROM webx_location";
        cmd = new SqlCommand(sqlval,con);
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

            for (int i = 0; i < 1; i++)
            {
                dt.Rows.Add();
            }


                    // BRANCH CODING STARTS HERE

            grvroadfreightbranch.DataSource = dt;
            grvroadfreightbranch.DataBind();

            grvairfreightbranch.DataSource = dt;
            grvairfreightbranch.DataBind();

            grvexpressfreightbranch.DataSource = dt;
            grvexpressfreightbranch.DataBind();

            grvtrainfreightbranch.DataSource = dt;
            grvtrainfreightbranch.DataBind();




                                    //ZONE CODING STARTS HERE




            grvroadfreightzone.DataSource = dt;
            grvroadfreightzone.DataBind();

            grvairfreightzone.DataSource = dt;
            grvairfreightzone.DataBind();

            grvexpressfreightzone.DataSource = dt;
            grvexpressfreightzone.DataBind();

            grvtrainfreightzone.DataSource = dt;
            grvtrainfreightzone.DataBind();


                            // CITY CODING STARTS HERE


            grvroadfreightcity.DataSource = dt;
            grvroadfreightcity.DataBind();

            grvairfreightcity.DataSource = dt;
            grvairfreightcity.DataBind();

            grvexpressfreightcity.DataSource = dt;
            grvexpressfreightcity.DataBind();

            grvtrainfreightcity.DataSource = dt;
            grvtrainfreightcity.DataBind();


        }
    }





    protected void cmbratetype_TextChanged(object sender, EventArgs e)
    {
        // THIS FUNCTIONALITY IS USED AT MANY PLACES SO INNER FUNCTIONED
        comboFiller();
    }





/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                
 *                                       BRANCH CODING STARTS HERE
 * 
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/



    protected void grvroadfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('branch','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('branch','" + txtto.ClientID.ToString() + "','none')");

        }
    }

    protected void txtrowsroadfreightbranch_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvroadfreightbranch.DataSource = dt;
        grvroadfreightbranch.DataBind();

     
    }


    protected void grvairfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
                ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('branch','" + txtfrom.ClientID.ToString() + "','none')");

                TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
                ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('branch','" + txtto.ClientID.ToString() + "','none')");

            }
    }



    protected void txtrowsairfreightbranch_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsairfreightbranch.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsairfreightbranch.Text);
            }
            catch (Exception ex)
            {
                txtrowsairfreightbranch.Text = "";
                txtrowsairfreightbranch.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvairfreightbranch.DataSource = dt;
        grvairfreightbranch.DataBind();
    }






    protected void grvexpressfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('branch','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('branch','" + txtto.ClientID.ToString() + "','none')");

        }
    }




    // EXPRESS freightbranch




    protected void txtrowsexpressfreightbranch_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvexpressfreightbranch.DataSource = dt;
        grvexpressfreightbranch.DataBind();
    }




    // TRAIN freightbranch

    protected void grvtrainfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('branch','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('branch','" + txtto.ClientID.ToString() + "','none')");

        }
    }



    protected void txtrowstrainfreightbranch_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowstrainfreightbranch.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowstrainfreightbranch.Text);
            }
            catch (Exception ex)
            {
                txtrowstrainfreightbranch.Text = "";
                txtrowstrainfreightbranch.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvtrainfreightbranch.DataSource = dt;
        grvtrainfreightbranch.DataBind();
    }







/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                    
 *                                       ZONE CODING STARTS HERE
 * 
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/




    protected void grvroadfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('zone','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('zone','" + txtto.ClientID.ToString() + "','none')");

        }
    }

    protected void txtrowsroadfreightzone_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvroadfreightzone.DataSource = dt;
        grvroadfreightzone.DataBind();
    }


    protected void grvairfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('zone','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('zone','" + txtto.ClientID.ToString() + "','none')");

        }
    }






    protected void txtrowsairfreightzone_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsairfreightzone.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsairfreightzone.Text);
            }
            catch (Exception ex)
            {
                txtrowsairfreightzone.Text = "";
                txtrowsairfreightzone.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvairfreightzone.DataSource = dt;
        grvairfreightzone.DataBind();
    }






    protected void grvexpressfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('zone','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('zone','" + txtto.ClientID.ToString() + "','none')");

        }
    }




    // EXPRESS freightzone




    protected void txtrowsexpressfreightzone_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvexpressfreightzone.DataSource = dt;
        grvexpressfreightzone.DataBind();
    }




    // TRAIN freightzone

    protected void grvtrainfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('zone','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('zone','" + txtto.ClientID.ToString() + "','none')");

        }
    }



    protected void txtrowstrainfreightzone_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowstrainfreightzone.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowstrainfreightzone.Text);
            }
            catch (Exception ex)
            {
                txtrowstrainfreightzone.Text = "";
                txtrowstrainfreightzone.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvtrainfreightzone.DataSource = dt;
        grvtrainfreightzone.DataBind();
    }









    /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                
     *                                       CITY CODING STARTS HERE
     * 
    *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/











    protected void grvroadfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('city','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('city','" + txtto.ClientID.ToString() + "','none')");

        }
    }

    protected void txtrowsroadfreightcity_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvroadfreightcity.DataSource = dt;
        grvroadfreightcity.DataBind();
    }


    protected void grvairfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('city','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('city','" + txtto.ClientID.ToString() + "','none')");

        }
    }






    protected void txtrowsairfreightcity_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowsairfreightcity.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowsairfreightcity.Text);
            }
            catch (Exception ex)
            {
                txtrowsairfreightcity.Text = "";
                txtrowsairfreightcity.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvairfreightcity.DataSource = dt;
        grvairfreightcity.DataBind();
    }






    protected void grvexpressfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('city','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('city','" + txtto.ClientID.ToString() + "','none')");

        }
    }




    // EXPRESS freightcity




    protected void txtrowsexpressfreightcity_TextChanged(object sender, EventArgs e)
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

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvexpressfreightcity.DataSource = dt;
        grvexpressfreightcity.DataBind();
    }




    // TRAIN freightcity

    protected void grvtrainfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((Button)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('city','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((Button)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('city','" + txtto.ClientID.ToString() + "','none')");

        }
    }



    protected void txtrowstrainfreightcity_TextChanged(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtrowstrainfreightcity.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtrowstrainfreightcity.Text);
            }
            catch (Exception ex)
            {
                txtrowstrainfreightcity.Text = "";
                txtrowstrainfreightcity.Focus();
            }
        }

        dt.Rows.Clear();
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvtrainfreightcity.DataSource = dt;
        grvtrainfreightcity.DataBind();
    }














    ////////////////////////////////////////////    INNER FUNCTINS     //////////////////////////////////

    protected void comboFiller()
    {
        // BRANCH CODING
        foreach (GridViewRow grvrow in grvroadfreightbranch.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvairfreightbranch.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvexpressfreightbranch.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvtrainfreightbranch.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }


        // ZONE CODING
        foreach (GridViewRow grvrow in grvroadfreightzone.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvairfreightzone.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvexpressfreightzone.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvtrainfreightzone.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }


        //  CITY CODING
        foreach (GridViewRow grvrow in grvroadfreightcity.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvairfreightcity.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvexpressfreightcity.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

        foreach (GridViewRow grvrow in grvtrainfreightcity.Rows)
        {
            DropDownList cmb = (DropDownList)(grvrow.FindControl("cmbratetype"));
            cmb.Text = cmbratetype.Text;
        }

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

            // FILLING webx_custcontract_hdr TABLE
            string strupdate = "UPDATE webx_custcontract_hdr SET single_slab_yn='" + (slabtype.CompareTo("S") == 0 ? "Y" : "N") +
                            "', multiple_slab_yn='" + (slabtype.CompareTo("S") == 0 ? "N" : "Y") +
                            "' WHERE custcode = '" + custcode + "'";

            SqlCommand cmd = new SqlCommand(strupdate, con, sqltran);
            cmd.ExecuteNonQuery();



            // CLEARING DETAILS OF METRICES
            strupdate = "DELETE FROM WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR where ContractId = '" + contractid + "'";
            cmd = new SqlCommand(strupdate, con, sqltran);
            cmd.ExecuteNonQuery();

            if (txtFromSlab1.Text.CompareTo("") == 0)
                txtFromSlab1.Text = "0";
            if (txtToSlab1.Text.CompareTo("") == 0)
                txtToSlab1.Text = "0";

            if (txtFromSlab2.Text.CompareTo("") == 0)
                txtFromSlab2.Text = "0";
            if (txtToSlab2.Text.CompareTo("") == 0)
                txtToSlab2.Text = "0";

            if (txtFromSlab3.Text.CompareTo("") == 0)
                txtFromSlab3.Text = "0";
            if (txtToSlab3.Text.CompareTo("") == 0)
                txtToSlab3.Text = "0";

            if (txtFromSlab4.Text.CompareTo("") == 0)
                txtFromSlab4.Text = "0";
            if (txtToSlab4.Text.CompareTo("") == 0)
                txtToSlab4.Text = "0";

            if (txtFromSlab5.Text.CompareTo("") == 0)
                txtFromSlab5.Text = "0";
            if (txtToSlab5.Text.CompareTo("") == 0)
                txtToSlab5.Text = "0";



            //
            string sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB1',";
            sqlinsert = sqlinsert + "" + txtFromSlab1.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab1.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();





            // SLAB NO 2
            sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB2',";
            sqlinsert = sqlinsert + "" + txtFromSlab2.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab2.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();




            // SLAB NO 3
            sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB3',";
            sqlinsert = sqlinsert + "" + txtFromSlab3.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab3.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();



            // SLAB NO 4
            sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB4',";
            sqlinsert = sqlinsert + "" + txtFromSlab4.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab4.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();



            // SLAB NO 5
            sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB5',";
            sqlinsert = sqlinsert + "" + txtFromSlab5.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab5.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();


            // SLAB NO 6
            sqlinsert = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlinsert = sqlinsert + "(CONTRACTID, CUSTCODE, MATRIX_TYPE, SLAB_CODE, SLAB_FROM, SLAB_TO) ";
            sqlinsert = sqlinsert + " VALUES (";
            sqlinsert = sqlinsert + "'" + contractid + "',";
            sqlinsert = sqlinsert + "'" + custcode + "',";
            sqlinsert = sqlinsert + "'" + cmbratetype.SelectedValue + "',";
            sqlinsert = sqlinsert + "'SLAB6',";
            sqlinsert = sqlinsert + "" + txtFromSlab6.Text + ",";
            sqlinsert = sqlinsert + "" + txtToSlab6.Text + ");";
            cmd = new SqlCommand(sqlinsert, con, sqltran);
            cmd.ExecuteNonQuery();








            // DELETING PREVIOUS RECORDS FROM webx_custcontract_frtmatrix_slabdet IF ANY........
            string sqldelete = "DELETE FROM WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET where ContractId = '" + contractid + "'";
            cmd = new SqlCommand(sqldelete, con, sqltran);
            cmd.ExecuteNonQuery();

           
            //ROAD CODING
            if (strtrnmodes.IndexOf('R') != -1)
            {
                insertGrid(grvroadfreightbranch, "ROAD", "L");
                insertGrid(grvroadfreightzone, "ROAD", "R");
                insertGrid(grvroadfreightcity, "ROAD", "C");
            }





            // AIR CODING
            if (strtrnmodes.IndexOf('A') != -1)
            {
                insertGrid(grvairfreightbranch, "AIR", "L");
                insertGrid(grvairfreightzone, "AIR", "R");
                insertGrid(grvairfreightcity, "AIR", "C");
            } 


            // EXPRESS CODING
            if (strtrnmodes.IndexOf('E') != -1)
            {
                insertGrid(grvexpressfreightbranch, "EXPRESS", "L");
                insertGrid(grvexpressfreightzone, "EXPRESS", "R");
                insertGrid(grvexpressfreightcity, "EXPRESS", "C");
            } 



            // TRAIN CODING
            if (strtrnmodes.IndexOf('T') != -1)
            {
                insertGrid(grvtrainfreightbranch, "TRAIN", "L");
                insertGrid(grvtrainfreightzone, "TRAIN", "R");
                insertGrid(grvtrainfreightcity, "TRAIN", "C");
            }

        }
        catch (Exception ex)
        {
            sqltran.Rollback();
            Response.Write("SQL Exception" + "\n" + ex.Message);
            return;
        }

        sqltran.Commit();



        if (ftl.CompareTo("FTL") == 0)
            Response.Redirect("EditCCMStep3FreightFTL.aspx?TL=" + ftl + "&Random=" + randno + "&ODA=" + oda);
        else if (ftl.CompareTo("") == 0 && oda.CompareTo("Y") == 0)
            Response.Redirect("EditCCMODA.aspx?Random=" + randno);
        else
            Response.Redirect("CCM_DisplayResult.aspx?ContractID=" + contractid + "&CustCodeName=" + custname + "&CCMMode=E");


    }




    private void insertGrid(GridView grv, string trnmod, string matmode)
    {
        string strgridinsert = "";
        SqlCommand cmd;
        foreach (GridViewRow grvrow in grv.Rows)
        {
            TextBox txtfrom = (TextBox)(grvrow.FindControl("txtfrom"));
            TextBox txtto = (TextBox)(grvrow.FindControl("txtto"));
            TextBox txttransit = (TextBox)(grvrow.FindControl("txttransit"));
            DropDownList cmbratetype_det_grid = (DropDownList)(grvrow.FindControl("cmbratetype"));
            TextBox txtslab1 = (TextBox)(grvrow.FindControl("txtslab1"));
            TextBox txtslab2 = (TextBox)(grvrow.FindControl("txtslab2"));
            TextBox txtslab3 = (TextBox)(grvrow.FindControl("txtslab3"));
            TextBox txtslab4 = (TextBox)(grvrow.FindControl("txtslab4"));
            TextBox txtslab5 = (TextBox)(grvrow.FindControl("txtslab5"));
            TextBox txtslab6 = (TextBox)(grvrow.FindControl("txtslab6"));
            CheckBox chk = (CheckBox)(grvrow.FindControl("chkyes"));


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

            if (chk.Checked == true)
            {
                strgridinsert = "INSERT INTO webx_custcontract_frtmatrix_slabdet ";
                strgridinsert = strgridinsert + "(ContractId, Custcode, from_loccode, to_loccode, trdays, ratetype, Slab1, Slab2, Slab3, Slab4, Slab5, Slab6, ";
                strgridinsert = strgridinsert + "trans_type, loc_reg) VALUES (";
                strgridinsert = strgridinsert + "'" + contractid + "',";
                strgridinsert = strgridinsert + "'" + custcode + "',";
                if (matmode.CompareTo("R") == 0)
                {
                    strgridinsert = strgridinsert + "'" + returnZoneCode(txtfrom.Text) + "',";
                    strgridinsert = strgridinsert + "'" + returnZoneCode(txtto.Text) + "',";
                }
                else
                {
                    strgridinsert = strgridinsert + "'" + txtfrom.Text + "',";
                    strgridinsert = strgridinsert + "'" + txtto.Text + "',";
                }
                
                strgridinsert = strgridinsert + "'" + txttransit.Text + "',";
                strgridinsert = strgridinsert + "'" + cmbratetype_det_grid.SelectedValue + "',";
                strgridinsert = strgridinsert + txtslab1.Text + ",";
                strgridinsert = strgridinsert + txtslab2.Text + ",";
                strgridinsert = strgridinsert + txtslab3.Text + ",";
                strgridinsert = strgridinsert + txtslab4.Text + ",";
                strgridinsert = strgridinsert + txtslab5.Text + ",";
                strgridinsert = strgridinsert + txtslab6.Text + ",";
                strgridinsert = strgridinsert + "'" + trnmod + "',";
                strgridinsert = strgridinsert + "'" + matmode + "')";

                cmd = new SqlCommand(strgridinsert, con, sqltran);
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
