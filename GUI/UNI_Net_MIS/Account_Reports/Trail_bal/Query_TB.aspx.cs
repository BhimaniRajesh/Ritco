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

public partial class GUI_UNI_MIS_Monthly_Sales_Query_TB : System.Web.UI.Page
{
    public static string lv, RPT_flag, YearString, yearSuffix, finyearstart, strFinalQS = "", mHeadOfficeCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
            finyearstart = "01 APR " + YearString;
            yrstartdt = Convert.ToDateTime(finyearstart);
            mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateFrom.Text = yrstartdt.ToString("dd/MM/yyyy");

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string brcd = Session["brcd"].ToString();
            string sql_level = "select isnull(loc_level,1) from webx_location with(NOLOCK) where activeFlag='Y' and loccode='" + brcd + "' ";



            SqlCommand cmd_level = new SqlCommand(sql_level, conn);
            SqlDataReader dr_level = cmd_level.ExecuteReader();
            while (dr_level.Read())
            {
                lv = dr_level[0].ToString();
            }

            dr_level.Close();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";

            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader dr;
            dr = sqlcmd1.ExecuteReader();


            dr.Read();
            //int loclvl = Convert.ToInt16(dr["Loc_level"]);
            string loccd = dr["loccode"].ToString();
            dr.Close();

            String SQL_LOC, sqlall1;

            if (brcd == loccd)
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
                //trradflow.Visible = false;

            }

            // Response.Write("<br> lv : " + lv);

            if (Convert.ToDouble(lv) > 2)
            {
                trradflow.Style["display"] = "none";
            }
            //ACCRO.Style["display"] = "none";
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();

            while (dr1.Read())
            {

                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
                ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
            }
            dr1.Close();

            ddlro.SelectedValue = loccd;
            //string sqlstr = "";
            //if (Convert.ToDouble(lv) == 1)
            //{
            //    sqlstr = "   select custcd,custnm +' : '+custcd from webx_custhdr  where isnull(cust_active,'N')='Y' order by custnm";
            //}
            //else
            //{
            //    sqlstr = "  select custcd,custnm +' : '+custcd from webx_custhdr where custloc like '%" + brcd + "%' and  isnull(cust_active,'N')='Y' order by custnm";
            //}
            //DLLCust.Items.Clear();
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);
            //SqlDataReader dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        DLLCust.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //    }

            //}
            //dread.Close();

            //if (Convert.ToDouble(lv) == 1)
            //{
            //    sqlstr = "    select vendorcode,vendorname +' : ' +vendorcode from webx_vendor_hdr where active='Y' order by vendorname";
            //}
            //else
            //{
            //    sqlstr = "    select vendorcode,,vendorname +' : ' +vendorcode  from webx_vendor_hdr where active='Y' vendorcode in (select distinct vendorcode from webx_vendor_det where vendorbrcd like '%" + brcd + "%') order by vendorname ";
            //}
            //DLLVend.Items.Clear();
            //cmd = new SqlCommand(sqlstr, conn);
            //dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        DLLVend.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //    }

            //}
            //dread.Close();

            //if (Convert.ToDouble(lv) == 1)
            //{
            //    sqlstr = "    select userid,name +' : ' +userid from webx_master_users where status='100' order by name";
            //}
            //else
            //{
            //    sqlstr = " select userid,,name +' : ' +userid  from webx_master_users where status='100' and branchcode like '%" + brcd + "%'  order by name";
            //}
            //cmd = new SqlCommand(sqlstr, conn);
            //DLLEmp.Items.Clear();
            //DLLEmp.Items.Clear();

            //dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        DLLEmp.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //    }

            //}
            //dread.Close();


            //sqlstr = "select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,acccategory from webx_acctinfo with(NOLOCK) where acccategory in ('ASSET','LIABILITY','EXPENSES','INCOME','BANK','CASH') order by acccategory,Accdesc";
            //cmd = new SqlCommand(sqlstr, conn);
            //DLL_ACC.Items.Clear();
            //dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        DLL_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //    }

            //}
            //dread.Close();


            //cmd = new SqlCommand(sqlstr, conn);


            //DLLEmp.Items.Add(new ListItem("All", "All"));
            //DLLCust.Items.Add(new ListItem("All", "All"));
            //DLLVend.Items.Add(new ListItem("All", "All"));
            //DLL_ACC.Items.Add(new ListItem("All", "All"));
            //DLL_ACC.SelectedValue = "All";
            //DLLCust.SelectedValue = "All";
            //DLLVend.SelectedValue = "All";
            //DLLEmp.SelectedValue = "All";
            conn.Close();
        }
    }
    protected void rdiochanges(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr = "";
        string brcd = Session["brcd"].ToString();
        if (radFlow.SelectedValue.ToString() == "0")
        {
            //cboRO_Lo.Style["display"] = "block";

            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where activeflag='Y' order by locname";
            // cboRO_Lo.Style["display"] = "none";
        }
        else
        {
            sqlstr = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and (loc_level='2' or loc_level='1') order by locName";
            //   cboRO_Lo.Style["display"] = "none";
            // popRO();
        }

        if (Convert.ToDouble(lv) > 1)
        {
            sqlstr = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
        }
       

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        ddlro.Items.Clear();
        {

            while (dread.Read())
            {

                ddlro.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));

            }
            if (Convert.ToDouble(lv) == 1)
            {
                ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
            }
        }
        dread.Close();
        conn.Close();
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "1",Cumulative="", report_type_st = "", report_type = "";

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        for (int i = 0; i < 3; i++)
        {
            if (radDate.Items[i].Selected)
            {
                report_mode = radDate.Items[i].Value.ToString();
                int ab = Convert.ToInt16(report_mode) + 1;
                report_mode = ab.ToString();
            }
        }

        for (int i = 0; i < 4; i++)
        {
            if (rpttyp.Items[i].Selected)
            {
                report_type = rpttyp.Items[i].Value.ToString();
            }
        }

        if (radFlow.Items[0].Selected)
        {
            Cumulative = "N";
        }
        else
        {
            Cumulative = "Y";
        }
        string DWN_XLS = "";
        if (rptfrt.Items[0].Selected)
        {
            DWN_XLS = "N";
        }
        else
        {
            DWN_XLS = "Y";
        }

        

        
        string PF_LOC = ddlro.SelectedValue.ToString();
        string fromdt = "", todt = "";
       // fromdt = txtDateFrom.Text.ToString();
       // todt = txtDateTo.Text.ToString();
        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");



        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string custcd = "", empcd = "", vendcd = "", ACC_cd = "";
        //custcd = DLLCust.SelectedValue.ToString();
        //empcd = DLLEmp.SelectedValue.ToString();
        //vendcd = DLLVend.SelectedValue.ToString();
        custcd = txtCustomer.Text.ToString();// DLLCust.SelectedValue.ToString();
        empcd = txtEmployee.Text.ToString();
        vendcd = txtVendor.Text.ToString();
       string  drivercd = txtDriver.Text.ToString();
       ACC_cd = txtAccount.Text.ToString();
        string TYP_CD = "";

        if (report_type == "2")
        {
            TYP_CD = custcd;
            //report_type = "1";
        }
        else if (report_type == "3")
        {
            TYP_CD = vendcd;
            //report_type = "1";
        }
        else if (report_type == "4")
        {
            TYP_CD = empcd;
            //report_type = "1";
        }
        else if (report_type == "5")
        {
            TYP_CD = drivercd;
            //report_type = "1";
        }

        if (TYP_CD == "All")
        {
            TYP_CD = "";
        }
        if (ACC_cd == "All")
        {
            ACC_cd = "";
        }
        
        string final;
        final = "?RO=" + PF_LOC;
        final += "&Rtyp=" + report_type;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        //final += "&custcd=" + custcd;
        final += "&Cumulative=" + Cumulative;
        final += "&TYP_CD=" + TYP_CD;
        final += "&ACC_cd=" + ACC_cd;
        final += "&report_mode=" + report_mode;
        final += "&DWN_XLS=" + DWN_XLS;
        Response.Redirect("Result.aspx" + final);
    }
}
