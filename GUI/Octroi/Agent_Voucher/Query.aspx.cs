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

public partial class Octroi_Agent_Voucher_Query : System.Web.UI.Page
{
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            Agent();
            btnShowBill.Attributes.Add("onclick", "javascript:return checkdata(" + rbtAgent.ClientID + "," + rbtAgeBill.ClientID + "," + rbtBillEntry.ClientID + "," + cboAgent.ClientID + "," + txtAgeBill.ClientID + "," + txtBillEntry.ClientID + "," + btnShowBill.ClientID + ")");           
        }
    }

    private void Agent()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        da = new SqlDataAdapter("select VENDORNAME+' - '+ VENDORCODE as Vendor,VENDORCODE as VendorCode from webx_vendor_hdr where Vendor_Type='01' Order By VENDORNAME", conn);
        da.Fill(ds, "webx_vendor_hdr");
        cboAgent.DataSource = ds;
        cboAgent.DataTextField = "Vendor";
        cboAgent.DataValueField = "VendorCode";
        cboAgent.DataBind();
        cboAgent.Items.Insert(0, "-Select One-");
    }

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
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
        if (rbl.Items[3].Selected)
        {
          //  righnow = righnow.AddYears(-);
            txtDateFrom.Text = "01/01/2006";
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateTo.Text = strrightnow;
        }
    }
    public void ToDate(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    protected void rbtAgent_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtAgent.Checked == true)
        {
            rbtAgeBill.Checked = false;
            rbtBillEntry.Checked = false;
            txtAgeBill.Enabled = false;
            txtBillEntry.Enabled = false;
            cboAgent.Enabled = true;
        }
    }
    protected void rbtAgeBill_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtAgeBill.Checked == true)
        {
            rbtAgent.Checked = false;
            rbtBillEntry.Checked = false;
            cboAgent.Enabled = false;
            txtAgeBill.Enabled = true;
            txtBillEntry.Enabled = false;
        }
    }
    protected void rbtBillEntry_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtBillEntry.Checked == true)
        {
            rbtAgent.Checked = false;
            rbtAgeBill.Checked = false;
            cboAgent.Enabled = false;
            txtAgeBill.Enabled = false;
            txtBillEntry.Enabled = true;
        }
    }
    protected void btnShowBill_OnClick(object sender, EventArgs e)
    {
        
    }
    protected void btnShowBill_Click(object sender, EventArgs e)
    {
        string Agent = cboAgent.SelectedItem.Text;
        if (Agent == "-Select One-")
        {
            Agent = "";
        }
        string AgentBill = txtAgeBill.Text;
        string BillEntry = txtBillEntry.Text;
        string AgentCode = cboAgent.SelectedItem.Value;

        if (Page.IsValid == true)
        {
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);

            //btnShowBill.Attributes.Add("onclick","javascript:return checkdata(" + rbtAgent.ClientID + "," + rbtAgeBill.ClientID + "," + rbtBillEntry.ClientID + "," + cboAgent.ClientID + "," + txtAgeBill.ClientID + "," + txtBillEntry.ClientID + "," + btnShowBill.ClientID + ")");

            Response.Redirect("Result_Page.aspx?AgentCode=" + AgentCode + "&Agent=" + Agent + "&AgentBill=" + AgentBill + "&BillEntry=" + BillEntry + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
        }
    }
}
