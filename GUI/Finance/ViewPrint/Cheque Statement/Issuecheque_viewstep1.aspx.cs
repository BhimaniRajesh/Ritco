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

public partial class GUI_UNI_MIS_chequemgt_Issuecheque_viewstep1 : System.Web.UI.Page
{
    DateFunction Daccess = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        string strredFromTo = redFromTo.ID.ToString();
        string strToDay = redToday.ID.ToString();
        string strSevenDay = redSevenDay.ID.ToString();
        string strChecyTypeChange = DropDownList1.ID.ToString();
        string strtxtAmountFrom = txtAmountFrom.ClientID;
        string strtxtAmountTo = txtAmountTo.ClientID; ;

        string scriptStr = "javascript:return CHK1(this," + strredFromTo + " )";
        string scriptStrToday = "javascript:return CHK1(this," + strToDay + ")";
        string scriptstrSevenDay = "javascript:return CHK1(this," + strSevenDay + ")";
        string scriptChecyTypeChange = "javascript:return chequeChange(this," + strChecyTypeChange + ")";
        string scriptAmoutFrom = "javascript:return amount(this," + strtxtAmountFrom + ")";
        string scriptAmoutTo = "javascript:return amount1(this," + strtxtAmountTo + ")";

        redFromTo.Attributes.Add("onClick", scriptStr);
        redToday.Attributes.Add("onClick", scriptStrToday);
        redSevenDay.Attributes.Add("onClick", scriptstrSevenDay);

        txtAmountFrom.Attributes.Add("onBlur", scriptAmoutFrom);
        txtAmountTo.Attributes.Add("onBlur", scriptAmoutTo);
        //DropDownList1.Attributes.Add("onchange", scriptChecyTypeChange);
        if (!IsPostBack)
        {
            dlstVendorCode.Items.Insert(0, "");
            dlstVendorCode.Items[0].Text = "All";
            dlstVendorCode.Items[0].Value = "All";
            panC.Visible = false;
            panV.Visible = false;

            string sql = "select CodeId,CodeDesc from Webx_Master_General where CodeType='VENDTY' and StatusCode='Y' and CodeAccess='S'";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.Fill(ds, "Load");
            dlstVenderType.DataSource = ds;
            dlstVenderType.DataValueField = "CodeId";
            dlstVenderType.DataTextField = "CodeDesc";
            dlstVenderType.DataBind();
            dlstVenderType.Items.Insert(0, "");
            dlstVenderType.Items[0].Text = "All";
            dlstVenderType.Items[0].Value = "All";
        }
    }
    public void change_panel(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedItem.Value == "1")
        {
            panV.Visible = true;
            panC.Visible = false;

        }
        else if (DropDownList1.SelectedItem.Value == "2")
        {
            panC.Visible = true;
            panV.Visible = false;
        }
        else
        {
            panC.Visible = false;
            panV.Visible = false;
        }
    }
    public void change_Pan1(object sender, EventArgs e)
    { 
    
    }
    public void type_Change(object sender, EventArgs e)
    {
        string sql="";
        if (cust_vend.SelectedItem.Value == "2")
        {
            sql = "select distinct a.VENDORCODE,a.VENDORNAME + ' : ' + a.VENDORCODE as VENDORNAME from webx_VENDOR_HDR a,Webx_Master_General b  where a.Vendor_Type=b.CodeId and a.active='Y' and a.Vendor_Type = '" + dlstVenderType.SelectedItem.Value + "'";
            if (sql != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.Fill(ds, "Load");
                dlstVendorCode.DataSource = ds;
                dlstVendorCode.DataValueField = "VENDORCODE";
                dlstVendorCode.DataTextField = "VENDORNAME";
                dlstVendorCode.DataBind();
                dlstVendorCode.Items.Insert(0, "");
                dlstVendorCode.Items[0].Text = "All";
                dlstVendorCode.Items[0].Value = "All";
            }
        }
        else if (cust_vend.SelectedItem.Value == "1")
        {
            dlstVenderType.SelectedValue = "All";
            //dlstVendorCode.SelectedItem.Value = "All";
        }
        else {
            dlstVendorCode.SelectedItem.Value = "All";
        }
    }
    public void btnSubmit_Click(object sender, EventArgs e)
    {
        string cheque_type, DateFrom, DateTo, chequeEILoc, vendType, vendCode, ChequeStatus, ChequeAmtStatus, CustVendCode, ChequeNumber, amountFrom, amountTo;
        DateFrom = "";
        DateTo = "";
        amountFrom = txtAmountFrom.Text;
        amountTo = txtAmountTo.Text;
        ChequeNumber = txtChequeNo.Text;
        if (redFromTo.Checked == true)
        {
            if(txtDateFrom.CalendarDate != "" || txtDateTo.CalendarDate != "")
            {
                DateFrom = Daccess.return_date(txtDateFrom.CalendarDate);
                DateTo = Daccess.return_date(txtDateTo.CalendarDate);
            }
        }
        else if (redToday.Checked == true)
        {
             DateTime dt = DateTime.Now;
             string date = dt.ToString("dd/MM/yyyy");
             DateFrom = Daccess.return_date(date);
             DateTo = Daccess.return_date(date);
        }
        else
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");

            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-6);
            string strrightnow = righnow.ToString("dd/MM/yyyy");

            DateFrom = Daccess.return_date(strrightnow);
            DateTo = Daccess.return_date(date);

        }
        if (txtLocation.Text == "")
        {
            chequeEILoc = "All";
        }
        else
        {
            chequeEILoc = txtLocation.Text;
        }

        if (cust_vend.SelectedItem.Value == "2")
        {
                string strVendorType = dlstVenderType.SelectedItem.Value;
                string strVendorCode = dlstVendorCode.SelectedItem.Value;
                Response.Redirect("result.aspx?CHQ_NO=" + "" + "&CV=V&DateFrom=" + DateFrom + "&DateTo=" + DateTo + "&LocationCode=" + chequeEILoc + "&VendorType=" + strVendorType + "&VendorCode=" + strVendorCode + "&amountFrom=" + amountFrom + "&amountTo=" + amountTo + "&ChequeNumber=" + ChequeNumber, true);
        }
        else if (cust_vend.SelectedItem.Value == "1")
        {
                string strChequeStatus = dlstCS.SelectedItem.Value;
                string strChqAmtStatus = dlstCAS.SelectedItem.Value;
                Response.Redirect("result.aspx?CHQ_NO=" + "" +"&CV=C&DateFrom=" + DateFrom + "&DateTo=" + DateTo + "&LocationCode=" + chequeEILoc + "&ChequeStatus=" + strChequeStatus + "&ChqAmtStatus=" + strChqAmtStatus + "&amountFrom=" + amountFrom + "&amountTo=" + amountTo + "&CustCode=" + txtVenderCode.Text + "&searchType=" + dlstSearchType.SelectedItem.Value + "&ChequeNumber=" + ChequeNumber, true);
        }
    }
    protected void btnCNSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("result.aspx?CHQ_NO=" + txtChequeNo.Text + "&CV=C&DateFrom=" + "" + "&DateTo=" + "" + "&LocationCode=" + "" + "&ChequeStatus=" + "" + "&ChqAmtStatus=" + "" + "&amountFrom=" + "" + "&amountTo=" + "" + "&CustCode=" + "" + "&searchType=" + "" + "&ChequeNumber=" + "", true);
    }
}
