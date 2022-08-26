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

public partial class REPORT_ProspectStatus1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string Branch, SqlStr = "";
    SqlCommand cmd = new SqlCommand();
     
    protected void Page_Load(object sender, EventArgs e)
    {
        Branch = Session["brcd"].ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr = @"<script>
                    function update1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtEmployeeCode').value=elemValue;
                  }
                  </script>";

        Page.RegisterClientScriptBlock("update1", scr);
        btnPopUp.Attributes.Add("onclick", "window.open('Popup_Employee_CallRegister.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        if (!(Page.IsPostBack))
        {

            popRO();

        }
    }

    protected void cboSelectLocation_SelectedIndexChanged(object sender, EventArgs e)
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
        if (loclvl == 1)
        {
            SqlStr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            SqlStr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            SqlStr = "select top 1 '--All--' as Name, '--All--' as UserId from WebX_Master_Users union select Name,UserId from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "' and UserId='" + Session["EMPCD"].ToString() + "'";
        }
        SqlCommand cmd = new SqlCommand(SqlStr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        DropDownList2.Items.Clear();
        while (dread.Read())
        {
            DropDownList2.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
            
        }

        dread.Close();
        conn.Close();

    }
    protected void cboSelectRo_SelectedIndexChanged(object sender, EventArgs e)
    {

        popLOC();

        conn.Open();
        string strro1 = cboSelectRo.SelectedValue.ToString();
        string sqlstremp = "select top 1 '--All--' as Name, '--All--' as empcd from Vw_empmst union select empnm,empcd from Vw_empmst where loccode in (select loccode from webx_location where report_loc='" + strro1 + "' or loccode='" + strro1 + "' )";
        SqlCommand cmdemp = new SqlCommand(sqlstremp, conn);
        SqlDataReader dreademp = cmdemp.ExecuteReader();
        DropDownList2.Items.Clear();
        while (dreademp.Read())
        {
            DropDownList2.Items.Add(new ListItem(dreademp.GetValue(0).ToString(), dreademp.GetValue(1).ToString()));

        }

        dreademp.Close();
        conn.Close();





    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
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


    }

    protected void btnShowReport_Click(object sender, EventArgs e)
    {

        string final = "?&DtFrom=" + txtDateFrom.Text;
        final += "&DtTo=" + txtDateTo.Text;
        final += "&emp=" + DropDownList2.SelectedValue.ToString();
        final += "&Region=" + cboSelectRo.SelectedValue.ToString();
        final += "&location=" + cboSelectLocation.SelectedValue.ToString();
        final += "&empcd=" + txtEmployeeCode.Text;
        Response.Redirect("ProspectStatus2.aspx" + final);
    }


    public void popRO()
    {
        ////string sConn;
        ////SqlConnection conn;
        ////sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        ////conn = new SqlConnection(sConn);
        //conn.Open();
        ////string sql = "select top 1 '--All--' as c1,'--All--' as c2 from webx_location union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        ////SqlCommand sqlcmd = new SqlCommand(sql, conn);
        ////DataSet ds = new DataSet();

        ////SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

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
        //conn.Close();

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
}
