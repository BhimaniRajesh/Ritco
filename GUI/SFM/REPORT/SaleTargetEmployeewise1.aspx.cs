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

public partial class REPORT_SaleTargetEmployeewise1 : System.Web.UI.Page 
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string indCode1, locationname, ind, sqlstr = "", Branch;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!(Page.IsPostBack))
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
        }
        //btnShowReport.Attributes.Add("onclick", "javascript:return check(" + DropDownList1.ClientID + "," + cboIndustry.ClientID + ")");
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

    protected void cboSelectLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

        conn.Open();
        //string sqlstr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
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
            sqlstr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            sqlstr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            sqlstr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "' and UserId='" + Session["EMPCD"].ToString() + "'";
        }
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        DropDownList1.Items.Clear();
        while (dread.Read())
        {
            DropDownList1.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));

        }

        dread.Close();
        conn.Close();

    }
    protected void cboSelectRo_SelectedIndexChanged(object sender, EventArgs e)
    {

        popLOC();

        //conn.Open();
        //string strro1 = cboSelectRo.SelectedValue.ToString();
        //string sqlstremp = "select top 1 '--All--' as EMPNM, '--All--' as EMPCD from Vw_empmst union select EMPNM,EMPCD from Vw_empmst where currbrcd in (select loccode from webx_location where report_loc='" + strro1 + "' or loccode='" + strro1 + "' )";
        //SqlCommand cmdemp = new SqlCommand(sqlstremp, conn);
        //SqlDataReader dreademp = cmdemp.ExecuteReader();
        //DropDownList1.Items.Clear();
        //while (dreademp.Read())
        //{
        //    DropDownList1.Items.Add(new ListItem(dreademp.GetValue(0).ToString(), dreademp.GetValue(1).ToString()));

        //}

        //dreademp.Close();
        //conn.Close();

    }
    public void popRO()
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        //conn = new SqlConnection(sConn);
        //conn.Open();
        //string sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //da.Fill(ds, "tab");
        //cboSelectRo.DataSource = ds;
        //cboSelectRo.DataTextField = "c1";
        //cboSelectRo.DataValueField = "c2";
        //cboSelectRo.DataBind();
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        //conn = new SqlConnection(sConn);
        //conn.Open();
        //string brcd = Session["currbrcd"].ToString();
        //string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        //SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        //SqlDataReader dr;
        //dr = sqlcmd1.ExecuteReader();

        //dr.Read();
        //int loclvl = Convert.ToInt16(dr["Loc_level"]);
        //string locnm = dr["locname"].ToString();
        //dr.Close();
        //if (loclvl <= 2)
        //{

        //    if (loclvl == 1)
        //    {
        //        string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        //        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //        DataSet ds = new DataSet();
        //        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //        da.Fill(ds, "tab");
        //        cboSelectRo.DataSource = ds;
        //        cboSelectRo.DataTextField = "c1";
        //        cboSelectRo.DataValueField = "c2";
        //        cboSelectRo.DataBind();

        //        popLOC();


        //    }
        //    else
        //    {
        //        string concat = brcd + " : " + locnm;
        //        cboSelectRo.Items.Clear();
        //        cboSelectRo.Items.Add(concat);
        //        cboSelectRo.DataBind();
        //        cboSelectRo.SelectedItem.Value = brcd;

        //        popLOC();

        //    }
        //}
        //else
        //{
        //    cboSelectRo.Enabled = false;
        //    cboSelectLocation.Items.Clear();
        //    cboSelectLocation.Items.Add("Select");
        //    cboSelectLocation.Items.Add(brcd);


        //}
        ////conn.Close();

        //string Sql_loclevel = "select loc_level from webx_location where loccode='" + Session["currbrcd"].ToString() + "'";
        //SqlCommand sqlcmd = new SqlCommand(Sql_loclevel, conn);
        //SqlDataReader dr1;
        //dr1 = sqlcmd.ExecuteReader();
        //string loc_level = "", sql = "";
        //if (dr1.Read())
        //{
        //    loc_level = dr1["loc_level"].ToString();
        //    if (loc_level == "1")
        //    {
        //        sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        //    }
        //    else if (loc_level == "2")
        //    {
        //        sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 from webx_location where loccode='" + Session["currbrcd"].ToString() + "' union select loccode+' : '+locname c1,loccode c2 FROM webx_location where report_loc='" + Session["currbrcd"].ToString() + "'";
        //    }
        //    else if (loc_level == "3")
        //    {
        //        sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 from webx_location where loccode='" + Session["currbrcd"].ToString() + "' union select loccode+' : '+locname c1,loccode c2 FROM webx_location where report_loc='" + Session["currbrcd"].ToString() + "'";
        //    }
        //    else
        //    {
        //        sql = "select loccode+' : '+locname as  c1,loccode  as c2 FROM webx_location where  loccode='" + Session["currbrcd"].ToString() + "'";
        //    }
        //}
        //dr1.Close();
        //DataSet ds = new DataSet();
        //sqlcmd = new SqlCommand(sql, conn);
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //da.Fill(ds, "tab");
        //cboSelectRo.DataSource = ds;
        //cboSelectRo.DataTextField = "c1";
        //cboSelectRo.DataValueField = "c2";
        //cboSelectRo.DataBind();


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
    }
    public void popLOC()
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        //conn = new SqlConnection(sConn);
        //conn.Open();


        //string strro = cboSelectRo.SelectedValue.ToString();
        //string sql = "select top 1 '--All--' as c1,'--All--' as loccode from webx_location union select loccode+' : '+locname c1,loccode from webx_location where report_loc= '" + strro + "'";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);

        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //da.Fill(ds, "tab1");
        //cboSelectLocation.DataSource = ds;
        //cboSelectLocation.DataTextField = "c1";
        //cboSelectLocation.DataValueField = "loccode";
        //cboSelectLocation.DataBind();
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        //conn = new SqlConnection(sConn);
        //conn.Open();
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

        //conn.Close();

    }
    protected void cboIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string employee = DropDownList1.SelectedValue.ToString();
        if (employee == "--All--")
        {
            employee = "";
        }
        else
        {
            employee = employee;
        }
        indCode1 = cboIndustry.SelectedValue.ToString();
        ind = indCode1;
        if (indCode1 == "All")
        {
            indCode1 = "";
        }
        conn.Open();
        SqlDataReader drCompany;
        SqlCommand cmdComapny = new SqlCommand();
        cmdComapny.CommandText = "select companyName from webx_ProspectCustomer where industryCode like '" + indCode1 + "%' and EntryBy like '" + employee + "%'";
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
    protected void btnShowReport_Click(object sender, EventArgs e)
    {
        string final = "?indCode1=" + cboIndustry.SelectedValue.ToString();
        final += "&locationname=" + cboSelectLocation.SelectedItem.ToString();
        final += "&Empcd=" + DropDownList1.SelectedValue.ToString();
        final += "&Status=" + cboAccCategory.SelectedItem.ToString();
        final += "&Comapny=" + cboCompany.SelectedItem.ToString();
        final += "&Period=" + cboPeriod.SelectedItem.ToString();
        Response.Redirect("SaleTargetEmployeewise2.aspx" + final);
    }
}
