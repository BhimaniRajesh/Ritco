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

public partial class GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Image imgfrm = (Image)DT.FindControl("imgfrm");
        //Image imgto = (Image)DT.FindControl("imgto");

        if (!IsPostBack)
        {
            //imgfrm.ImageUrl= "../../images/calendar.jpg";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sqlstr = " select acccode ,accdesc+ ' : ' +acccode from webx_acctinfo with(NOLOCK) where activeFlag='Y'   order  by accdesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_ACC.SelectedValue = "All";

            dread.Close();

            LT_CUST_VEND.Items.Clear();
            LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            sqlstr = " select custcd , custnm+ ' : ' +custcd  from webx_custhdr with(NOLOCK) where cust_active='Y'   order  by custnm";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CUST_VEND.SelectedValue = "All";
            dread.Close();

            LT_CAT.Items.Clear();
            LT_CAT.Items.Add(new ListItem("All", "All"));
            sqlstr = " select distinct  main_category from webx_groups with(NOLOCK) where isnull(main_category,'')<>''    order  by main_category";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CAT.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CAT.SelectedValue = "All";
            dread.Close();

            string YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
            SqlTransaction trans;

            TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

            txtDateFrom.Text = "01/04/" + Session["FinYear"].ToString();
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");


            RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

            radDate.SelectedValue = "0";
        

            conn.Close();
        }

        
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

        string report_mode = "", st_ro = "", st_lo = "", rpt = "", rmd = "";


        rpt = rpttyp.SelectedValue.ToString();
        rmd = rptmd.SelectedValue.ToString();

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

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

      
        st_ro = cboRO.SelectedValue.ToString();
        st_lo = cboLO.SelectedValue.ToString();

        string st_cust_vend = "",st_cust_vend_name = "", rpt_SUB = "", ST_CAT = "", ST_ACC = "", ACC = "";

        for (int i = 0; i < LT_CAT.Items.Count; i++)
        {
            if (LT_CAT.Items[i].Selected == true)
            {
                if (ST_CAT == "")
                    ST_CAT =  LT_CAT.Items[i].Value.ToString() ;
                else
                    ST_CAT = ST_CAT + "," + LT_CAT.Items[i].Value.ToString() ;
            }
        }

        for (int i = 0; i < LT_CUST_VEND.Items.Count; i++)
        {
            if (LT_CUST_VEND.Items[i].Selected == true)
            {
                if (ACC == "")
                {
                    ACC =  LT_CUST_VEND.Items[i].Value.ToString() ;
                    ST_ACC =  LT_CUST_VEND.Items[i].Text.ToString() ;
                }
                else
                {
                    ACC = ACC + "," + LT_CUST_VEND.Items[i].Value.ToString() ;
                    ST_ACC = ST_ACC + "," + LT_CUST_VEND.Items[i].Text.ToString() ;
                }
            }
        }

        for (int i = 0; i < LT_ACC.Items.Count; i++)
        {
            if (LT_ACC.Items[i].Selected == true)
            {
                if (st_cust_vend == "")
                {
                    st_cust_vend =  LT_ACC.Items[i].Value.ToString();
                    st_cust_vend_name =  LT_ACC.Items[i].Text.ToString() ;
                }
                else
                {
                    st_cust_vend = st_cust_vend + "," + LT_ACC.Items[i].Value.ToString() ;
                    st_cust_vend_name = st_cust_vend_name + "," + LT_ACC.Items[i].Text.ToString() ;
                }
            }
        }

        rpt_SUB = rpttyp_SUB.SelectedValue.ToString();

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;
        final += "&ST_CAT=" + ST_CAT;
        final += "&ST_ACC=" + ST_ACC;
        final += "&ACC=" + ACC;
        final += "&st_cust_vend=" + st_cust_vend;
        final += "&st_cust_vend_name=" + st_cust_vend_name;
        final += "&rpt_SUB=" + rpt_SUB;
        final += "&RMD=" + rmd;
        Response.Redirect("Result.aspx" + final);

    }
    protected void RD_CUST_VEND_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string whereCri = "";

        if (Session["HeadOfficeCode"].ToString().ToUpper() == Session["brcd"].ToString().ToUpper())
        {
            whereCri = "%%";
        }
        else
        {
            whereCri = "'%" + Session["brcd"].ToString() +"%'";
        }
        

        if (RD_CUST_VEND.SelectedValue == "1")
        {
            LT_CUST_VEND.Items.Clear();
            LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select custcd ,custnm + ' : ' +custcd  from webx_custhdr with(NOLOCK)    order  by custnm";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CUST_VEND.SelectedValue = "All";
        }
        else if (RD_CUST_VEND.SelectedValue == "2")
        {
            LT_CUST_VEND.Items.Clear();
            LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select vendorcode ,vendorname + ' : ' +vendorcode  from webx_vendor_hdr with(NOLOCK)   order  by vendorname";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CUST_VEND.SelectedValue = "All";
        }
        else if (RD_CUST_VEND.SelectedValue == "3")
        {
            LT_CUST_VEND.Items.Clear();
            LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select userid , name+ ' : ' +userid  from webx_master_users  with(NOLOCK)  order  by name";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CUST_VEND.SelectedValue = "All";
        }
        else if (RD_CUST_VEND.SelectedValue == "4")
        {
            LT_CUST_VEND.Items.Clear();
            LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select convert(varchar,driver_id) , driver_name+ ' : ' +convert(varchar,driver_id)  from WEBX_FLEET_DRIVERMST  with(NOLOCK) where activeflag='Y'   order  by driver_name";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_CUST_VEND.SelectedValue = "All";
        }
        conn.Close();
    }
    protected void LT_CAT_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string ST_CAT = "";

        for (int i = 0; i < LT_CAT.Items.Count; i++)
        {
            if (LT_CAT.Items[i].Selected == true)
            {
                if (ST_CAT == "")
                    ST_CAT = "'" + LT_CAT.Items[i].Value.ToString() + "'";
                else
                    ST_CAT = ST_CAT + ",'" + LT_CAT.Items[i].Value.ToString() + "'";
            }
        }

        int Npos1 = ST_CAT.IndexOf("All");

        if (Npos1 != 1)
        {
            LT_ACC.Items.Clear();
            LT_ACC.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select acccode , accdesc+ ' : ' +acccode  from webx_acctinfo a with(NOLOCK)  inner join webx_groups g on a.groupcode=g.groupcode where activeFlag='Y' and main_category in (" + ST_CAT + ")  order  by accdesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_ACC.SelectedValue = "All";
        }
        else
        {
            LT_ACC.Items.Clear();
            LT_ACC.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select acccode ,accdesc+ ' : ' +acccode from webx_acctinfo a with(NOLOCK)   where activeFlag='Y'   order  by accdesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            LT_ACC.SelectedValue = "All";
        }
        conn.Close();  
    }
}
