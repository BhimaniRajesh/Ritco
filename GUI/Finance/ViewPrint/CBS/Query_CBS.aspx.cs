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
public partial class GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Query_trailBalne_party : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    public static string RPT_flag, strFinalQS="";
   protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
           String  mHeadOfficeCode = "UNHO";

           //Response.Write(" <br>aaa " + Session["FinYear"]);
          popRO();
        }
        //btnShow3.Attributes.Add("onclick", "javascript:return Submitdata(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + btnShow3.ClientID + ")");
        btnShow3.Attributes.Add("onclick", "javascript:return Submitdata(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + btnShow3.ClientID + ")");
        //btnShow2.Attributes.Add("onclick", "javascript:return Submitdata1(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + DDVendor.ClientID + "," + btnShow.ClientID + ")");
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

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
        //else if (rbl.Items[3].Selected)
        //{
        //    txtDateFrom.ReadOnly = true;
        //    txtDateTo.ReadOnly = true;
        //    txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
        //    txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        //}






    }
    //protected void radFlow_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    RadioButtonList rb2 = new RadioButtonList();
    //    rb2 = (RadioButtonList)sender;

    //    byteRadButtonSelection = Convert.ToByte(rb2.SelectedItem.Value);

    //    if (rb2.SelectedValue == "0")
    //    {
    //        txtPartyCode.Enabled = false;
    //        ddlro.Enabled = true;
    //        ddlloc.Enabled = true;
    //        DDLPaybas.Enabled = false;
    //        DDLPaybas2.Enabled = true;
    //        Report_type.Enabled = true;
    //        // btnBranchPopup.Enabled = false;


    //    }
    //    else
    //    {
    //        txtPartyCode.Enabled = true;
    //        ddlro.Enabled = false;
    //        ddlloc.Enabled = false;
    //        DDLPaybas.Enabled = true;
    //        DDLPaybas2.Enabled = false;
    //        Report_type.Enabled = false;
    //        // btnBranchPopup.Enabled = true;
    //    }

    //}

    public void abcd_txt()
    {

        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        string strro = ddlro.SelectedValue.ToString();
       string ACCOunts =DDAccounts.SelectedValue.ToString();
        //string Paybasloc = DDLPaybas2.SelectedValue.ToString();
        //string PaybasCust = DDLPaybas.SelectedValue.ToString();
        //string rpt_type = Report_type.SelectedValue.ToString();
       // string strcust = txtPartyCode.Text;
        string strflowtype = radFlow.SelectedValue.ToString();

         strFinalQS = "?DOCDate=" + strQSMRDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        //strFinalQS = strFinalQS + "&Location=" + strloc;
        strFinalQS = strFinalQS + "&Flowtype=" + strflowtype;
        strFinalQS = strFinalQS + "&ACCOunts=" + ACCOunts;
        //strFinalQS = strFinalQS + "&strflowtype=" + strflowtype;
    }

    protected void btnShow_Click1(object sender, EventArgs e)
    {
        
        
        

         RPT_flag = "C";
         abcd_txt();

         if (radFlow.SelectedValue.ToString() == "0")
         {
             Response.Redirect("Result_cbS.aspx" + strFinalQS);
         }
         else
         {
             Response.Redirect("Cumulative_Result_cbS.aspx" + strFinalQS);
         }

        
    }

    

    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select loccode,locname from webx_location where loc_level='1'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();


        dr.Read();
        //int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string loccd = dr["loccode"].ToString();
        dr.Close();

        String SQL_LOC,sqlall1;

        if (brcd == loccd)
        {
            ddlro.Items.Add(new ListItem("-- Select -- ", ""));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' order by locName";
            sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";
        }
        else
        {
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
            sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%"  +brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            trradflow.Style["display"] = "none";
        }


        SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd2.ExecuteReader();

        while (dr1.Read())
        {
            
            ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            
        }
        dr1.Close();

        ddlro.SelectedValue = loccd;

        //String SQL_Vendor;
        //SQL_Vendor = "select acccode,accdesc +' : '+acccode from webx_acctinfo where  acccode in (select distinct accthead from webx_vendor_type where accthead is not null) order by accdesc";
        SqlCommand sqlcmd3 = new SqlCommand(sqlall1, conn);
        SqlDataReader dr2;
        dr2 = sqlcmd3.ExecuteReader();

        while (dr2.Read())
        {
            DDAccounts.Items.Add(new ListItem(dr2.GetValue(1).ToString(), dr2.GetValue(0).ToString()));
        }
        dr2.Close();

        // String SQL_Employee;
        // SQL_Employee = " select acccode,accdesc +' : '+acccode from webx_acctinfo where acccode in ('ASS0001','CA00016','EXP0005') order by accdesc";
        //SqlCommand sqlcmd4 = new SqlCommand(SQL_Employee, conn);
        //SqlDataReader dr3;
        //dr3 = sqlcmd4.ExecuteReader();

        //while (dr3.Read())
        //{
        //    DDEmployeeAcc.Items.Add(new ListItem(dr3.GetValue(1).ToString(), dr3.GetValue(0).ToString()));
        //}
        //dr3.Close();

       
        
    }


    //protected void DDAccountsChanges(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    //String sqlstr = "";


    //    String sqlstr = "select acccode + '~' + accdesc,acccode + ' : ' + accdesc  from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + ddlro.SelectedValue.ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
    //    SqlCommand cmd = new SqlCommand(sqlstr, conn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    DDAccounts.Items.Clear();
    //    {

    //        while (dread.Read())
    //        {
    //            DDAccounts.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    conn.Close();
    //}

    
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //String sqlstr = "";


        String sqlstr = "select acccode ,acccode + ' : ' + accdesc  from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + ddlro.SelectedValue.ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        DDAccounts.Items.Clear();
        {

            DDAccounts.Items.Add(new ListItem("All", "0" ));
            DDAccounts.Items.Add(new ListItem("All Bank Accounts", "1"));
            DDAccounts.Items.Add(new ListItem("All Cash Accounts", "2"));

            while (dread.Read())
            {
                DDAccounts.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        conn.Close();
    }
}
