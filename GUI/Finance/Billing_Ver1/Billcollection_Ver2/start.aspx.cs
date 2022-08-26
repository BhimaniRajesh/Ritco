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
using Microsoft.ApplicationBlocks.Data;

public partial class Finance_Billing_Billsubmission_start : System.Web.UI.Page
{
    string Type = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Request.QueryString.Get("type");
        if (!IsPostBack)
        {
            string Sql="SELECT CodeId,CodeDesc FROM WEBX_MASTER_GENERAL WHERE CODETYPE='BILLTYP' AND StatusCode='Y' ORDER BY CAST(CODEID AS NUMERIC(10))";
            DataTable Dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];
            if (Dtl.Rows.Count > 0)
            {
                Cbopaybas.DataSource = Dtl;
                Cbopaybas.DataBind();
            }
            Cbopaybas.Items.Add(new ListItem("Select", ""));
            Cbopaybas.SelectedValue = "";
            Cbopaybas.CssClass = "blackfnt";

            //if (Type == "F")
            //{
            //    Cbopaybas.Items.Add(new ListItem("Select", ""));
            //    Cbopaybas.Items.Add(new ListItem("ALL", "15"));
            //    Cbopaybas.Items.Add(new ListItem("PAID BILL", "1"));
            //    Cbopaybas.Items.Add(new ListItem("TBB/FREIGHT BILL", "2"));
            //    Cbopaybas.Items.Add(new ListItem("TO PAY BILL", "3"));
            //    Cbopaybas.Items.Add(new ListItem("MISC BILL", "7"));
            //    Cbopaybas.Items.Add(new ListItem("Tripsheet - Milk Run", "10"));
            //}
            //else if(Type == "O")
            //{
            //    Cbopaybas.Items.Add(new ListItem("Octroi BILL", "6"));
            //}
            fn.Fill_Customer_Dataset();
        }
        Button1.Attributes.Add("onclick", "javascript:return OnSubmit_Submission()");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {         
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
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

        string billno;
        billno = Billno.Text.ToString();
        string party_detail = Txt_Customer.Text.ToString(), custcd = "", custnm = "";
        string[] party_arr;
        if (Txt_Customer.Text != "")
        {
            party_arr = party_detail.Split('~');
            custcd = party_arr[1].ToString();
            custnm = party_arr[0].ToString();
        }
        string BillColType = ddlBillColType.SelectedValue.ToString();

        Response.Redirect("billmr_step1.aspx?billno=" + billno + "&party_code=" + custcd.ToString() + "&paybas=" + Cbopaybas.SelectedValue.ToString() + "&fromtdate=" + dtFrom + "&todate=" + dtTo + "&manualbillno=" + txtmanualbillno.Text.ToString() + "&BillColType=" + BillColType.ToString());
    } 
}
