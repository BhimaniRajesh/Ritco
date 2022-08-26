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

public partial class GUI_UNI_NET_MIS_CrossingRegister_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {
            popVendor();
        }
        conn.Close();

    }

    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "";
        //if (Session["BRCD"] == "HQTR")
        //{
            sql = "select * from webx_vendor_hdr h, webx_vendor_det d where h.vendorcode=d.vendorcode and vendor_type='18'";
        //}
        //else
        //{
        //    sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='18' and (vendorbrcd='ALL' or vendorbrcd='" + Session["brcd"].ToString() + "' or  patindex('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) ";
        //}
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor.Items.Clear();
        cboVendor.CssClass = "blackfnt";
        cboVendor.Items.Add(new ListItem("All", "All"));
        while (dr.Read())
        {
            cboVendor.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["VendorCode"].ToString()));
        }
        dr.Close();
        conn.Close();
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";
        
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

        string strrightnow, strrightnow1;
        
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString();
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
        string st_lo = cboLO.SelectedValue.ToString();
        string rmd = rptmd.SelectedValue.ToString();
        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&Vendor=" + cboVendor.SelectedValue.ToString();
        final += "&CrossingChallanNo=" + txtCrossingChallanNo.Text.Trim();
        final += "&RMD=" + rmd;

        Response.Redirect("Result.aspx" + final);

    }
}
