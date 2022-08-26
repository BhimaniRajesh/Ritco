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

public partial class GUI_Finance_Vendor_BA_payment_BA_Payment_ver1_Query_BA_BillEntry : System.Web.UI.Page
{
    
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        string mHeadOfficeCode = "", brcd = "";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            brcd = Session["brcd"].ToString();
            String SQL_Vendor = "", vendorcls = "";

            if (brcd != mHeadOfficeCode)
            {
                vendorcls = " and (vendorbrcd='ALL' or vendorbrcd='" + brcd + "' or  patindex('%" + brcd + "%',vendorbrcd)>0 )";
            }


            SQL_Vendor = "select distinct m.vendorcode,vendorname=(m.vendorname+' : '+m.vendorcode) from webx_vendor_hdr m  with (NOLOCK),webx_vendor_det d with (NOLOCK) where m.vendorcode=d.vendorcode  and (vendor_type='8' or vendor_type='08') " + vendorcls + "   order by vendorname";

            SqlCommand sqlcmd = new SqlCommand(SQL_Vendor, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            cboVendor.Items.Add(new ListItem("-- Select --", ""));
            cboVendor.CssClass = "blackfnt";
            while (dr.Read())
            {

                cboVendor.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }
            dr.Close();
            //ddlRouteMode.Items.Clear();
            ddlRouteMode.CssClass = "blackfnt";

            
            conn.Close();
        }

    }
    protected void btnShow_Click(object sender, EventArgs e)
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
        string RPTTYP = cboDocType.SelectedValue.ToString();
        string str_mode = ddlRouteMode.SelectedValue.ToString();
        string VendoCode = cboVendor.SelectedValue.ToString();
        string VendoName  = cboVendor.SelectedItem.ToString();

        string final;
        final = "?DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPTTYP=" + RPTTYP;
        final += "&str_mode=" + str_mode;
        final += "&VendoCode=" + VendoCode;
        final += "&VendoName=" + VendoName;
        Response.Redirect("Result_BA_BillEntry.aspx" + final);
    }
}
