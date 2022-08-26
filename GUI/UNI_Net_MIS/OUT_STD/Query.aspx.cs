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


public partial class GUI_UNI_MIS_OUT_STD_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //imgfrm.ImageUrl= "../../images/calendar.jpg";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            //LT_CUST_VEND.Items.Clear();
           // LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select custcd , custnm+ ' : ' +custcd  from webx_custhdr with(NOLOCK) where cust_active='Y'   order  by custnm";
           // SqlCommand cmd = new SqlCommand(sqlstr, conn);
           // SqlDataReader dread = cmd.ExecuteReader();
            //while (dread.Read())
            //{
            //    LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //}
            //LT_CUST_VEND.SelectedValue = "All";
            //dread.Close();

            RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

            RadioButtonList rb2 = new RadioButtonList();
            rb2 = (RadioButtonList)radDate;
            radDate.Items.Add(new ListItem("Till Date", "3"));
            radDate.SelectedValue = "3";


            Bill_Type.Items.Clear();
            Bill_Type.Items.Add(new ListItem("All", "All"));
            sqlstr = "select codeid,codedesc from  webx_master_general with(NOLOCK) where codetype= 'BILLTYP'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
             SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                Bill_Type.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            Bill_Type.SelectedValue = "All";
            dread.Close();

            txtasondt_to.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            string Year = Session["FinYear"].ToString().Substring(2, 2);
            txtasondt.Text = System.DateTime.Today.ToString("dd/MM/yyyy"); //"31/03/20" + Year;
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
        string report_mode = "";
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
        if ((rb2.Items[3].Selected || rb2.Items[4].Selected))
        {
            report_mode = "Tilldate";
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


        string st_ro = cboRO.SelectedValue.ToString();
        string  st_lo = cboLO.SelectedValue.ToString();

        string st_cust_vend = "", st_cust_vend_name = "";
        //for (int i = 0; i < LT_CUST_VEND.Items.Count; i++)
        //{
        //    if (LT_CUST_VEND.Items[i].Selected == true)
        //    {
        //        if (st_cust_vend == "")
        //        {
        st_cust_vend = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Value.ToString();
        st_cust_vend_name = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Text.ToString();
        //        }
        //        else
        //        {
        //            st_cust_vend = st_cust_vend + "," + LT_CUST_VEND.Items[i].Value.ToString();
        //            st_cust_vend_name = st_cust_vend_name + "," + LT_CUST_VEND.Items[i].Text.ToString();
        //        }
        //    }
        //}

       string  rpt_SUB = rpttyp_SUB.SelectedValue.ToString();
       string rpt = rpttyp.SelectedValue.ToString();
       string frm_as_dt = txtasondt.Text.ToString();
       string to_as_dt = txtasondt_to.Text.ToString();
       string rmd = rptmd.SelectedValue.ToString();

       string BM_TYP = Bill_Type.SelectedItem.ToString();
       string[] strArrDtFrom_as = frm_as_dt.Split('/');
       string[] strArrDtTo_as = to_as_dt.Split('/');

       string dtFrom_as= Convert.ToDateTime(strArrDtFrom_as[1] + "/" + strArrDtFrom_as[0] + "/" + strArrDtFrom_as[2]).ToString("dd MMM yy");
       string dtTo_as = Convert.ToDateTime(strArrDtTo_as[1] + "/" + strArrDtTo_as[0] + "/" + strArrDtTo_as[2]).ToString("dd MMM yy");
       string RTP_DT = RPT_DATE.SelectedValue.ToString();
       string RTP_DT_str = RPT_DATE.SelectedItem.ToString();
        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;
        final += "&CustRPT=1";
        final += "&st_cust_vend=" + st_cust_vend;
        final += "&st_cust_vend_name=" + st_cust_vend_name;
        final += "&rpt_SUB=" + rpt_SUB;
        final += "&frm_as_dt=" + dtFrom_as;
        final += "&to_as_dt=" + dtTo_as;
        final += "&RTP_DT=" + RTP_DT;
        final += "&RTP_DT_str=" + RTP_DT_str;
        final += "&BM_TYP=" + BM_TYP;
        final += "&RMD=" + rmd;
        
        Response.Redirect("Result.aspx" + final);

    }

}
