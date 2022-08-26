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

public partial class GUI_Octroi_ViewnPrint_VedorPayment_Step1 : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnsubmit.Attributes.Add("onclick", "javascript:return requireValidate()");


            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            string sql = "SELECT distinct Type_name,Type_code FROM webx_vendor_type";


            SqlCommand sqlcmd = new SqlCommand(sql, con);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();

            da.Fill(ds);

            cmbvendortype.DataSource = ds;
            cmbvendortype.DataTextField = "type_name";
            cmbvendortype.DataValueField = "type_code";
            cmbvendortype.DataBind();
            con.Close();
        }

    }

    protected void cmbvendortype_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        int strvendor = Convert.ToInt16(cmbvendortype.SelectedValue);
        string sql = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendor + "' order by vendorname";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();

        da.Fill(ds);
      
        cmbvendorname.DataSource = ds;
        cmbvendorname.DataTextField = "vendorname";
        cmbvendorname.DataValueField = "vendorcode";
        cmbvendorname.DataBind();
        cmbvendorname.Items.Add("All");
        conn.Close();
     
    }



    int dates = 0;
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
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
            dates = 0;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
            dates = 1;
        }

        if (rbl.Items[2].Selected)
        {
            txtDateFrom.Text = righnow.ToString("dd/MM/yyyy");
            txtDateTo.Text = righnow.ToString("dd/MM/yyyy");
            dates = 2;
        }
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string FINAL = "";
        if (optdatetype.Checked == true)
        {
            FINAL = FINAL + "type=1";
            if (radDate.SelectedIndex == 0)
            {
                FINAL = FINAL + "&dates=0";
            }
            else if (radDate.SelectedIndex == 0)
            {
                FINAL = FINAL + "&dates=1";
            }
            else if (radDate.SelectedIndex == 0)
            {
                FINAL = FINAL + "&dates=2";
            }
            FINAL = FINAL + "&billno=" + txtbillno.Text;
            FINAL = FINAL + "&date1=" + txtDateFrom.Text;
            FINAL = FINAL + "&date2=" + txtDateTo.Text;
            FINAL = FINAL + "&doctype=" + cmbdoctype.Text;
            FINAL = FINAL + "&vendortype=" + cmbvendortype.Text;
            FINAL = FINAL + "&vendorname=" + cmbvendorname.Text;
            Response.Redirect("VendorPaymentBill.aspx?" + FINAL);
        }
        else if (optnumtype.Checked == true)
        {
            FINAL = FINAL + "type=0";
            FINAL = FINAL + "&dates=5";
            FINAL = FINAL + "&billno=" + txtbillno.Text;
            FINAL = FINAL + "&date1=" + txtDateFrom.Text;
            FINAL = FINAL + "&date2=" + txtDateTo.Text;
            FINAL = FINAL + "&doctype=" + cmbdoctype.Text;
            FINAL = FINAL + "&vendortype=" + cmbvendortype.Text;
            FINAL = FINAL + "&vendorname=" + cmbvendorname.Text;
            Response.Redirect("VendorPaymentBill.aspx?" + FINAL);
        }
    }
}
