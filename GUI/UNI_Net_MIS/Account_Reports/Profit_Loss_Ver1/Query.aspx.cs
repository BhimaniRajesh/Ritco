using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_UNI_MIS_Account_Reports_Profit_Loss_Ver1_Query : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    public static string lv, RPT_flag, strFinalQS = "", YearString, yearSuffix, finyearstart, brcd;
    public static int loclevel;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
            TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;

            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            DateTime yrstartdt;

            String Year = Session["FinYear"].ToString();
            brcd = Session["brcd"].ToString();
            string abc = Year.Substring(2, 2);
            //Response.Write("<br>Year " + Year);
            //Response.Write("<br>Year " + abc);
            // Response.End();
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            finyearstart = "01 APR " + abc;
            yrstartdt = Convert.ToDateTime(finyearstart);
            Session["FinYearStart"] = yrstartdt.ToString("dd/MM/yyyy");
            txtDateFrom.Text = Convert.ToString(Session["FinYearStart"]);
            //String mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            String mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            //cboRO_Lo.Style["display"] = "none";
            // Response.Write(" <br>aaa " + Session["FinYear"]);
            popRO();
        }

        // btnShow.Attributes.Add("onclick", "javascript:return Submitdata(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + btnShow.ClientID + ")");
        // btnShow2.Attributes.Add("onclick", "javascript:return Submitdata1(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + DDVendor.ClientID + "," + btnShow.ClientID + ")");
    }



    protected void rdiochanges(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        double loccount = 0;
        if (radFlow.SelectedValue.ToString() == "1")
        {

            string SQL_ACC_LOC = "select distinct brcd from webx_acctrans_" + YearString + " with(NOLOCK)";
            SqlCommand cmd121 = new SqlCommand(SQL_ACC_LOC, conn);
            SqlDataReader DR121 = cmd121.ExecuteReader();
            string str_ACC_loc = "";
            while (DR121.Read())
            {
                if (str_ACC_loc == "")
                    str_ACC_loc = DR121[0].ToString();
                else
                    str_ACC_loc = str_ACC_loc + "," + DR121[0].ToString();
            }
            DR121.Close();


            string str_LOC_VIEWchg = "alter View VW_Location ";//replace(loccode,'AND','[AND]')
            str_LOC_VIEWchg += " as ";
            str_LOC_VIEWchg += " select distinct loccode,lcd='['+loccode+']',locname,Report_loc=(case when report_level='1' then loccode else Report_loc end),loc_level from webx_location with(NOLOCK) where isnull(activeflag,'N')='Y' and (loccode in ('" + str_ACC_loc.Replace(" ", "").Replace(",", "','") + "') or loc_level in ('1','2') )  ";
            SqlCommand cmd122 = new SqlCommand(str_LOC_VIEWchg, conn);
            cmd122.ExecuteNonQuery();
        }
        


        string sqlstr1 = "select count(*) from VW_Location with(NOLOCK)";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        loccount = Convert.ToDouble(cmd1.ExecuteScalar());
        

        string sqlstr = "";
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
            if (radFlow.SelectedValue.ToString() == "1")
            {
                if (loccount < 150)
                {
                    if (Convert.ToDouble(lv) == 1)
                    {
                        ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
                    }
                }
                //else
                //{
                //    ddlro.Items.Remove(Session["HeadOfficeCode"].ToString());
                //}
            }
            else
            {
                if (Convert.ToDouble(lv) == 1)
                {
                    ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
                }
            }
        }
        dread.Close();
        conn.Close();
    }
   
  

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);
        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
       
    }
   

    public void abcd_txt()
    {

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
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

        string strQSMRDate = dtFrom + " - " + dtTo;
        string strro = ddlro.SelectedValue.ToString();
        //string strLO = cboRO_Lo.SelectedValue.ToString();
        //string Paybasloc = DDLPaybas2.SelectedValue.ToString();
        //string PaybasCust = DDLPaybas.SelectedValue.ToString();
        //string rpt_type = Report_type.SelectedValue.ToString();
        // string strcust = txtPartyCode.Text;
        string strflowtype = radFlow.SelectedValue.ToString();

        //if (strflowtype == "1")
        //{
        //    if (Session["HeadOfficeCode"].ToString() == strro)
        //    {
        //        strro = "";
        //    }
        //}

        string chkstate = grpchk.Checked.ToString();

        strFinalQS = "?DOCDate=" + strQSMRDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        // strFinalQS = strFinalQS + "&LO=" + strLO;
        strFinalQS = strFinalQS + "&chkstate=" + chkstate;
        strFinalQS = strFinalQS + "&Flowtype=" + strflowtype;
        //strFinalQS = strFinalQS + "&ACCOunts=" + ACCOunts;
        //strFinalQS = strFinalQS + "&strflowtype=" + strflowtype;
    }

    protected void btnShow_Click1(object sender, EventArgs e)
    {
        RPT_flag = "C";
        abcd_txt();

        
            Response.Redirect("Result.aspx" + strFinalQS);
        


    }



    public void popRO()
    {
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

        String SQL_LOC, sqlall1, sqlstr;

        if (brcd == loccd)
        {
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' ";//and (loc_level='2' or loc_level='1') order by locName";
            sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            ddlro.Items.Add(new ListItem("All", "All"));
            // cboRO_Lo.SelectedValue = "All";

        }
        else
        {
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
            sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
            //ddlro.Style["display"] = "none";
            // RoWtr.Style["display"] = "none";
        }
        if (Convert.ToDouble(lv) > 2)
        {
            RoWtr.Style["display"] = "none";
        }

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
    
    }


   
   
}
