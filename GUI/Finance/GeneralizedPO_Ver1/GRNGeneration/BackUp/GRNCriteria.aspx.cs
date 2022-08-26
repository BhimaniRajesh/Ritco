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
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRNCriteria : System.Web.UI.Page
{
    string Type = "";
    MyFunctions fn = new MyFunctions();
    string TP;
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Request.QueryString.Get("type");
        if (!IsPostBack)
        {
            try
            {
                fn.Fill_Vendor_Dataset();
                BindDropDown();
                //rdDateRange.Checked = true;
            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }
        }
    }
    public void BindDropDown()
    {
        string SQLStr = "";
        SQLStr = "SELECT 'All' AS CodeID, '--SELECT--' AS CodeDesc UNION SELECT CodeID,CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' order by CodeDesc";
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        ddlMatCat.DataSource = dt;
        ddlMatCat.DataTextField = "CodeDesc";
        ddlMatCat.DataValueField = "CodeID";
        ddlMatCat.DataBind();        
    }
    protected void ButSubmit_Click(object sender, EventArgs e)
    {
        string report_mode = "";
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
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

        string FromDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd/MM/yyyy");
        string Todate = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd/MM/yyyy");

        string PONO = PONo.Text.ToString();
        string POMANUALNO = POManualNo.Text.ToString();
        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();
        string POType = ddlMatCat.SelectedValue.ToString();
        string POTypeDesc = ddlMatCat.SelectedItem.ToString();

        DropDownList Company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");

		string Vendor = Txt_Custcd.Text.Replace("&", "AND").Trim();
        string Qstring = "";
        Qstring = "POType=" + POType;
        Qstring = Qstring + "&POTypeDesc=" + POTypeDesc;
        Qstring = Qstring + "&VendorCode=" + Vendor;
        Qstring = Qstring + "&PONo=" + PONO;
        Qstring = Qstring + "&ManualPONo=" + POMANUALNO;
        Qstring = Qstring + "&FromDate=" + FromDate;
        Qstring = Qstring + "&ToDate=" + Todate;
        Qstring = Qstring + "&RO=" + st_ro;
        Qstring = Qstring + "&LO=" + st_lo;
        Qstring = Qstring + "&CompanyCode=" + Company.SelectedValue.ToString(); ;
        string Rule = RuleValue();
        if (Rule == "N")
        {
            Response.Redirect("GRN_DataList.aspx?" + Qstring);
        }
        else
        {
            Response.Redirect("SinglePO_GRN_DataList.aspx?" + Qstring);
        }
    }

    public string RuleValue()
    {
        string Rule_Y_N = "";
        string SQL = "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE RULEID='SINGLE_OR_MULTI_PO_GRN'";
        Rule_Y_N = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, SQL).ToString(); 
        return Rule_Y_N;
    }
}
