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

public partial class REPORT_AppointmentSchedule1 : System.Web.UI.Page
{
    string strCompanyName, strDateRange, Branch, sqlstr="";
    DateTime dFromDate, dTodate, dtToDate, dtFromDate;
    public static SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {
        Branch = Session["brcd"].ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!(Page.IsPostBack))
        {
            btnShowReport.Attributes.Add("onclick", "javascript:return datecheck(" + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ")");
            
            popRO();
        }
    }
    protected void cboSelectLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string sqlstr;// = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
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

        conn.Open();
        string strro1 = cboSelectRo.SelectedValue.ToString();
        string sqlstremp = "select top 1 '--All--' as Name, '--All--' as UserID from Vw_empmst_sfm union select Name,USerId from Vw_empmst_sfm where BranchCode in (select loccode from webx_location where report_loc='" + strro1 + "' or loccode='" + strro1 + "' )";
        SqlCommand cmdemp = new SqlCommand(sqlstremp, conn);
        SqlDataReader dreademp = cmdemp.ExecuteReader();
        DropDownList1.Items.Clear();
        while (dreademp.Read())
        {
            DropDownList1.Items.Add(new ListItem(dreademp.GetValue(0).ToString(), dreademp.GetValue(1).ToString()));

        }

        dreademp.Close();
        conn.Close();

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
            cboSelectLocation.Items.Clear();
            cboSelectLocation.Items.Add("Select");
            cboSelectLocation.Items.Add(brcd);

        }

    }
    public void popLOC()
    {
        //conn.Open();
        string strro = cboSelectRo.SelectedValue.ToString();
        string sql = "select top 1 '--All--' as c1,'--All--' as loccode from webx_location union select loccode+' : '+locname c1,loccode from webx_location where report_loc= '" + strro + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboSelectLocation.DataSource = ds;
        cboSelectLocation.DataTextField = "c1";
        cboSelectLocation.DataValueField = "loccode";
        cboSelectLocation.DataBind();
        conn.Close();

    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void btnShowReport_Click(object sender, EventArgs e)
    {
        string final = "?strFromDt=" + txtDateFrom.Text;
        final = final + "&strToDt=" + txtDateTo.Text;
        final = final + "&entryby=" + DropDownList1.SelectedValue.ToString();
        final = final + "&strRegion=" + cboSelectRo.SelectedValue.ToString();
        final = final + "&strLocation=" + cboSelectLocation.SelectedValue.ToString();
        Response.Redirect("AppointmentSchedule2.aspx" + final);
    }
}
