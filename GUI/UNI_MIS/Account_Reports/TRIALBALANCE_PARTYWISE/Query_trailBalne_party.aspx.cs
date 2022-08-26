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
    public static string RPT_flag,mHeadOfficeCode, strFinalQS="";
   protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
             mHeadOfficeCode = Session["HeadOfficeCode"].ToString(); ;

          // Response.Write(" <br>aaa " + Session["FinYear"]);
          popRO();
        }

        btnShow.Attributes.Add("onclick", "javascript:return Submitdata(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + btnShow.ClientID + ")");
        btnShow2.Attributes.Add("onclick", "javascript:return Submitdata1(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + DDVendor.ClientID + "," + btnShow.ClientID + ")");

        btnShow3.Attributes.Add("onclick", "javascript:return Submitdata2(" + ddlro.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + DDEmployeeAcc.ClientID + "," + btnShow.ClientID + ")");
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
        //string strloc = ddlloc.SelectedValue.ToString();
        //string Paybasloc = DDLPaybas2.SelectedValue.ToString();
        //string PaybasCust = DDLPaybas.SelectedValue.ToString();
        //string rpt_type = Report_type.SelectedValue.ToString();
       // string strcust = txtPartyCode.Text;
        string strflowtype = radFlow.SelectedValue.ToString();

         strFinalQS = "?DOCDate=" + strQSMRDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        //strFinalQS = strFinalQS + "&Location=" + strloc;
       // strFinalQS = strFinalQS + "&Cust=" + strcust;
        strFinalQS = strFinalQS + "&RPT_flag=" + RPT_flag;
        strFinalQS = strFinalQS + "&strflowtype=" + strflowtype;
    }

    protected void btnShow_Click1(object sender, EventArgs e)
    {
        //string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        //string[] strArrDtTo = txtDateTo.Text.Split('/');

        //DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        //DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        //string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        //string strro = ddlro.SelectedValue.ToString();
        //string strloc = ddlloc.SelectedValue.ToString();
        //string Paybasloc = DDLPaybas2.SelectedValue.ToString();
        //string PaybasCust = DDLPaybas.SelectedValue.ToString();
        //string rpt_type = Report_type.SelectedValue.ToString();
        string strcust = txtPartyCode.Text;
        //string strflowtype = radFlow.SelectedValue.ToString();
        //string strdttype = ddlbookdt.SelectedValue.ToString();
        
        

         RPT_flag = "C";
         abcd_txt();
        //string strFinalQS = "?DOCDate=" + strQSMRDate;
        //strFinalQS = strFinalQS + "&RO=" + strro;
        ////strFinalQS = strFinalQS + "&Location=" + strloc;
       strFinalQS = strFinalQS + "&Cust=" + strcust;
       
        //strFinalQS = strFinalQS + "&RPT_flag=" + RPT_flag;
        //strFinalQS = strFinalQS + "&strflowtype=" + strflowtype;
        //strFinalQS = strFinalQS + "&PaybasCust=" + PaybasCust;
        //strFinalQS = strFinalQS + "&rpt_type=" + rpt_type;
        //strFinalQS = strFinalQS + "&DateType=" + strdttype;


        Response.Redirect("Result_Trailbalance.aspx" + strFinalQS);
    }

    protected void btnShow_Click2(object sender, EventArgs e)
    {

        string strcust = txtVendor.Text;
        
        

        RPT_flag = "V";
        abcd_txt();
        string stAcctCd_v = DDVendor.SelectedValue.ToString();
        strFinalQS = strFinalQS + "&Cust=" + strcust;
        strFinalQS = strFinalQS + "&AcctCd_v=" + stAcctCd_v;


        Response.Redirect("Result_Trailbalance.aspx" + strFinalQS);
    }

    protected void btnShow_Click3(object sender, EventArgs e)
    {

        string strcust = txtEmployee.Text;

        

        RPT_flag = "E";
        abcd_txt();
        string stAcctCd_v1 = DDEmployeeAcc.SelectedValue.ToString();
        strFinalQS = strFinalQS + "&Cust=" + strcust;
        strFinalQS = strFinalQS + "&AcctCd_v=" + stAcctCd_v1;


        Response.Redirect("Result_Trailbalance.aspx" + strFinalQS);
    }

    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='Y'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();


        dr.Read();
        //int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string loccd = dr["loccode"].ToString();
        dr.Close();

        String SQL_LOC;

        if (brcd == loccd)
        {
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' order by locName";
        }
        else
        {
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
        }


        SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd2.ExecuteReader();

        while (dr1.Read())
        {
            
            ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            
        }
        dr1.Close();

        ddlro.SelectedValue = brcd;

        //String SQL_Vendor;
        //SQL_Vendor = "select acccode,accdesc +' : '+acccode from webx_acctinfo where  acccode in (select distinct accthead from webx_vendor_type where accthead is not null) order by accdesc";
        //SqlCommand sqlcmd3 = new SqlCommand(SQL_Vendor, conn);
        //SqlDataReader dr2;
        //dr2 = sqlcmd3.ExecuteReader();

        //while (dr2.Read())
        //{
        //    DDVendor.Items.Add(new ListItem(dr2.GetValue(1).ToString(), dr2.GetValue(0).ToString()));
        //}
        //dr2.Close();

        DDVendor.Items.Add(new ListItem("S.CREDITOR - TRANSPORTER :LCL0002", "LCL0002"));
        DDVendor.Items.Add(new ListItem("SUNDRY CREDITORS - OTHERS ", "UNS0004"));
        
         String SQL_Employee;
         SQL_Employee = " select acccode,accdesc +' : '+acccode from webx_acctinfo where acccode in ('ASS0001','CA00016','EXP0005') order by accdesc";
        SqlCommand sqlcmd4 = new SqlCommand(SQL_Employee, conn);
        SqlDataReader dr3;
        dr3 = sqlcmd4.ExecuteReader();

        while (dr3.Read())
        {
            DDEmployeeAcc.Items.Add(new ListItem(dr3.GetValue(1).ToString(), dr3.GetValue(0).ToString()));
        }
        dr3.Close();

       
        
    }


    //public void popRO()
    //{
    //    //string sConn;
    //    //SqlConnection conn;

    //    // sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
    //    //  sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    // conn = new SqlConnection(sConn);
    //    conn.Open();


    //    String sqlstr = "select abbr_type,Codetype_new from webx_typemst  where Activeflag='Y'";
    //    SqlCommand cmd = new SqlCommand(sqlstr, conn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            DDLPaybas.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
    //            DDLPaybas2.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
    //        }

    //    }
    //    dread.Close();


    //    string brcd = Session["brcd"].ToString();

    //    string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";

    //    SqlCommand sqlcmd1 = new SqlCommand(q1, conn);






    //    SqlDataReader dr;
    //    dr = sqlcmd1.ExecuteReader();


    //    dr.Read();
    //    int loclvl = Convert.ToInt16(dr["Loc_level"]);
    //    string locnm = dr["locname"].ToString();
    //    dr.Close();
    //    if (loclvl <= 2)
    //    {

    //        if (loclvl == 1)
    //        {
    //            string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

    //            SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //            DataSet ds = new DataSet();

    //            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


    //            da.Fill(ds, "tab");
    //            ddlro.DataSource = ds;
    //            ddlro.DataTextField = "c1";
    //            ddlro.DataValueField = "c2";
    //            ddlro.DataBind();


    //        }
    //        else
    //        {
    //            string concat = brcd + " : " + locnm;


    //            ddlro.Items.Clear();

    //            ddlro.Items.Add(concat);
    //            ddlro.DataBind();
    //            ddlro.SelectedItem.Value = brcd;

    //            popLOC();

    //        }





    //    }
    //    else
    //    {
    //        ddlro.Enabled = false;
    //        ddlloc.Items.Clear();
    //        ddlloc.Items.Add(brcd);
    //    }





    //}

    //public void popLOC()
    //{
    //    string sConn;
    //    // SqlConnection conn;
    //    //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
    //    //  sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";

    //    //conn = new SqlConnection(sConn);
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string strro = ddlro.SelectedValue.ToString();
    //    string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
    //    //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    //sqlcmd.CommandType = CommandType.Text;
    //    //select loccode+':'+locname c1 from webx_location
    //    //ddlro.DataTextField = "-ALL-";
    //    DataSet ds = new DataSet();

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


    //    da.Fill(ds, "tab1");
    //    ddlloc.DataSource = ds;
    //    ddlloc.DataTextField = "c1";
    //    ddlloc.DataValueField = "loccode";
    //    ddlloc.DataBind();
    //}
    //protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //    popLOC();
    //}
    //protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
    //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
}
