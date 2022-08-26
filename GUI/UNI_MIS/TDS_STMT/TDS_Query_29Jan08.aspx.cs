using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_UNI_MIS_TDS_Query_TDS_Query : System.Web.UI.Page
{
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        
        
       
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        
        string scr = @"<script>
        function update(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtVendor').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update", scr);
        btnVendor.Attributes.Add("onclick", "window.open('TDSS_STMT_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtCust').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnCust.Attributes.Add("onclick", "window.open('TDS_Cust_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
       

        if (!(Page.IsPostBack))
        {
            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");



            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;

            Location();
        }
        btnShowTDS.Attributes.Add("onclick", "javascript:return ValidateData()");
    }

    private void Location()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        da = new SqlDataAdapter("select locname+' : '+LocCode as Location from webx_location Order By locname", conn);
        da.Fill(ds, "webx_location");
        cboBookLoc.DataSource = ds;
        cboBookLoc.DataTextField = "Location";
        cboBookLoc.DataBind();
        cboBookLoc.Items.Insert(0, "ALL");
    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
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

        //if (rbl.Items[3].Selected)
        //{
        //    //righnow = righnow.AddMonths(-12);
        //    strrightnow = "01/01/1950";
        //    txtDateFrom.Text = strrightnow;
        //}
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }

        else if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }


    protected void doOnDataBound(object sender, EventArgs e)
    {
        if (cboSelType.SelectedItem.Text == "--Select One--")
        {
            lblVendor.Visible = false;
            txtVendor.Visible = false;
            btnVendor.Visible = false;
            lblCust.Visible = false;
            txtCust.Visible = false;
            btnCust.Visible = false;
            Label1.Visible = false;
            txtCust1.Visible = false;
            Label2.Visible = false;
            txtCust2.Visible = false;
        }
        if (cboSelType.SelectedItem.Text == "Receivable")
        {
            lblVendor.Visible = false;
            txtVendor.Visible = false;
            btnVendor.Visible = false;
            lblCust.Visible = true;
            txtCust.Visible = true;
            btnCust.Visible = true;
            Label1.Visible = true;
            txtCust1.Visible = true;
            Label2.Visible = true;
            txtCust2.Visible = true;

        }
        if (cboSelType.SelectedItem.Text == "Payable")
        {
            lblVendor.Visible = true;
            txtVendor.Visible = true;
            btnVendor.Visible = true;
            lblCust.Visible = false;
            txtCust.Visible = false;
            btnCust.Visible = false;
            Label1.Visible = false;
            txtCust1.Visible = false;
            Label2.Visible = false;
            txtCust2.Visible = false;
        }
    }
    protected void btnShowTDS_OnClick(object sender, EventArgs e)
    {

        if (Page.IsValid == true)
        {
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);

            string BookLoc = cboBookLoc.SelectedItem.Text;
            string Vendor = txtVendor.Text;
            string Cust = txtCust.Text;


            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


            if (Vendor != null && Vendor != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                string Query = "select vendorname from  webx_vendor_hdr where vendorCode='" + Vendor + "'";
                conn.Open();
                SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
                string VName = Command.ExecuteScalar().ToString();
                conn.Close();



                Response.Redirect("TDS_Report.aspx?Code=" + Vendor + "&Name=" + VName + "&BookLoc=" + BookLoc + "&dateRange=" + strDate);
            }

            if (Cust != null && Cust != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                string Query = "select CUSTNM from  webx_CUSTHDR WITH(NOLOCK) where CUSTCD='" + Cust + "'";
                conn.Open();
                SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
                string CName = Command.ExecuteScalar().ToString();
                conn.Close();


                Response.Redirect("TDS_Report.aspx?Code1=" + Cust + "&Name=" + CName + "&BookLoc=" + BookLoc + "&dateRange=" + strDate);
            }

            if (Cust == "" && Vendor == "")
            {

                Response.Redirect("TDS_Report.aspx?&Name=" + "All" + "&BookLoc=" + BookLoc + "&dateRange=" + strDate + "&typ=" + cboSelType.SelectedValue);
            }
        }
    }   
}
