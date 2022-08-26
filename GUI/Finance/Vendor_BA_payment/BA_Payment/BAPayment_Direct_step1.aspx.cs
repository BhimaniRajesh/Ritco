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

public partial class VendorPayment_new_BA_Payment_BAPayment_BillEntry_step1 : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    public static string mHeadOfficeCode = "", brcd = "";
    SqlConnection conn;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    { 
        
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
             mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
             brcd = Session["brcd"].ToString();
             String SQL_Vendor = "", vendorcls="";

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
            ddlRouteMode.Items.Clear();
            ddlRouteMode.CssClass = "blackfnt";
            //ddlRouteMode.Items.Add(new ListItem("Select", ""));

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1") + "," + fn.Gettrnmod("3") + "," + fn.Gettrnmod("4"), "All"));
            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "2"));
    
        }
        conn.Close();
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
    protected void btnShow_Click(object sender, EventArgs e)
    {
        String strFinalQS="";

         string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string Vendcd = cboVendor.SelectedValue.ToString();
        string DocType = cboDocType.SelectedValue.ToString();

        string str_DocType = "";

        if (DocType == "bkg")
        {
            str_DocType = "For Booking";

        }
        else if (DocType == "dly")
        {
            str_DocType = "For Delivery";
        }

        strFinalQS = "?DOCDate=" + strQSMRDate;
        strFinalQS = strFinalQS + "&Vendcd=" + Vendcd;
        strFinalQS = strFinalQS + "&DocType=" + DocType;
        strFinalQS = strFinalQS + "&str_DocType=" + str_DocType;
        strFinalQS = strFinalQS + "&RouteMode=" + ddlRouteMode.SelectedValue.ToString();
        Response.Redirect("BAPayment_Direct_step2.aspx" + strFinalQS);
       
        
    }
}
