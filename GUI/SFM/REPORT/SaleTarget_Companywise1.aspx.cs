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

public partial class REPORT_SaleTarget_Companywise1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string indCode1, Branch;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            Branch = Session["brcd"].ToString();
            popRO();
            //conn.Open();
            SqlDataReader drIndustry;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select CodeDesc,CodeId from Webx_Master_General where CodeType='IND'";
            cmd.Connection = conn;
            drIndustry = cmd.ExecuteReader();

            cboIndustry.Items.Clear();
            cboIndustry.Items.Add("All");
            while (drIndustry.Read())
            {
                cboIndustry.Items.Add(new ListItem(drIndustry.GetValue(0).ToString(), drIndustry.GetValue(1).ToString()));

            }
            
            drIndustry.Close();
            conn.Close();
            fillAccStatus();
            //Button3.Attributes.Add("onclick", "javascript:return check(" + cboIndustry.ClientID + ")");
        }
    }

    private void fillAccStatus()
    {
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        SqlDataReader drStatus;
        cmd.CommandText = "select * from webx_master_general where codetype='ast'";
        cmd.Connection = conn;
        drStatus = cmd.ExecuteReader();

        cboAccCategory.Items.Clear();
        cboAccCategory.Items.Add("All");
        while (drStatus.Read())
        {
            cboAccCategory.Items.Add(new ListItem(drStatus.GetValue(2).ToString(), drStatus.GetValue(1).ToString()));
        }
        drStatus.Close();
        conn.Close();
    }
    protected void cboIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        indCode1 = cboIndustry.SelectedItem.Value.ToString();
        if (indCode1 == "All")
        {
            indCode1 = "";
        }
        conn.Open();
        SqlDataReader drCompany;
        SqlCommand cmdComapny = new SqlCommand();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {
            cmdComapny.CommandText = "select companyName from webx_ProspectCustomer where industryCode like '" + indCode1 + "%' and LocCode='" + cboSelectLocation.SelectedItem.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            cmdComapny.CommandText = "select companyName from webx_ProspectCustomer where industryCode like '" + indCode1 + "%' and LocCode='" + cboSelectLocation.SelectedItem.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            cmdComapny.CommandText = "select companyName from webx_ProspectCustomer where industryCode like '" + indCode1 + "%' and LocCode='" + cboSelectLocation.SelectedItem.ToString() + "' and entryby='" + Session["empcd"].ToString() + "'";
        }
        cmdComapny.Connection = conn;
        drCompany = cmdComapny.ExecuteReader();
        cboCompany.Items.Clear();
        cboCompany.Items.Add("All");
        while (drCompany.Read())
        { 
            cboCompany.Items.Add(new ListItem(drCompany.GetValue(0).ToString()));
        }
        drCompany.Close();
        conn.Close();

    }
    protected void Button3_Click(object sender, EventArgs e)
    {

        string final = "?indCode1=" + cboIndustry.SelectedValue.ToString();
        final += "&Status=" + cboAccCategory.SelectedItem.ToString();
        final += "&Comapny=" + cboCompany.SelectedItem.ToString();
        final += "&Period=" + cboPeriod.SelectedItem.ToString();
        final += "&Location=" + cboSelectLocation.SelectedItem.ToString();
        final = final + "&year=" + cboyear.SelectedValue.ToString();
        
        Response.Redirect("./SaleTarget_Companywise2.aspx" + final);
    }
    protected void cboSelectRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
    }
    public void popRO()
    {
        
        conn.Open();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl <= 2)
        {

            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' ";
                //or loccode in (select loccode from webx_location where loc_level='1')";
                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
                cboSelectRo.DataSource = ds;
                cboSelectRo.DataTextField = "c1";
                cboSelectRo.DataValueField = "c2";
                cboSelectRo.DataBind();

                popLOC();


            }
            else
            {
                string concat = brcd + " : " + locnm;
                cboSelectRo.Items.Clear();
                cboSelectRo.Items.Add(concat);
                cboSelectRo.DataBind();
                cboSelectRo.SelectedItem.Value = brcd;

                popLOC();

            }
        }
        else
        {
            string sqlcode = "select Report_Loc from webx_Location where LocCode='" + brcd + "'";
            SqlCommand sqlcmd = new SqlCommand(sqlcode, conn);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

            da.Fill(ds, "tab");
            cboSelectRo.DataSource = ds;
            cboSelectRo.DataTextField = "Report_Loc";
            cboSelectRo.DataValueField = "Report_Loc";
            cboSelectRo.DataBind();

            string region = cboSelectRo.SelectedItem.ToString();

            string sqlcode1 = "select LocCode as c1,LocCode +':'+ LocName as c2 from webx_Location where LocCode='" + region + "'";
            SqlCommand command = new SqlCommand(sqlcode1, conn);
            DataSet ds1 = new DataSet();
            SqlDataAdapter da1 = new SqlDataAdapter(command);

            da1.Fill(ds1, "tab");
            cboSelectRo.DataSource = ds1;
            cboSelectRo.DataTextField = "c2";
            cboSelectRo.DataValueField = "c1";
            cboSelectRo.DataBind();
            //string concat = Report_Loc;
            //cboSelectRo.Items.Clear();
            //cboSelectRo.Items.Add(concat);
            //cboSelectRo.DataBind();


            //cboSelectRo.Enabled = false;
            cboSelectLocation.Items.Clear();
            cboSelectLocation.Items.Add("Select");
            cboSelectLocation.Items.Add(brcd);


        }


        /* 27 oct 2007 
        string Sql_loclevel = "select loc_level from webx_location where loccode='" + Session["currbrcd"].ToString() + "'";
        SqlCommand sqlcmd = new SqlCommand(Sql_loclevel, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd.ExecuteReader();
        string loc_level = "", sql = "";
        if (dr1.Read())
        {
            loc_level = dr1["loc_level"].ToString();
            if (loc_level == "1")
            {
                sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
            }
            else if (loc_level == "2")
            {
                sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 from webx_location where loccode='" + Session["currbrcd"].ToString() + "' union select loccode+' : '+locname c1,loccode c2 FROM webx_location where report_loc='" + Session["currbrcd"].ToString() + "'";
            }
            else if (loc_level == "3")
            {
                sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 from webx_location where loccode='" + Session["currbrcd"].ToString() + "' union select loccode+' : '+locname c1,loccode c2 FROM webx_location where report_loc='" + Session["currbrcd"].ToString() + "'";
            }
            else
            {
                sql = "select loccode+' : '+locname as  c1,loccode  as c2 FROM webx_location where  loccode='" + Session["currbrcd"].ToString() + "'";
            }
        }
        dr1.Close();
        DataSet ds = new DataSet();
        sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab");
        cboSelectRo.DataSource = ds;
        cboSelectRo.DataTextField = "c1";
        cboSelectRo.DataValueField = "c2";
        cboSelectRo.DataBind(); */
    }
    public void popLOC()
    {
       
        string strro = cboSelectRo.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        cboSelectLocation.DataSource = ds;
        cboSelectLocation.DataTextField = "c1";
        cboSelectLocation.DataValueField = "loccode";
        cboSelectLocation.DataBind();


    }
}
