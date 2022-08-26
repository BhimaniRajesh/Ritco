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
using WebX.Controllers;

public partial class GUI_UNI_Net_MIS_Voucher_register_Query : System.Web.UI.Page
{
    public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdbtnEntryDate.Checked = true;
            rdbtnActive.Checked = true;
            DT.EnableTillDate = true;
           
            DataTable dt = new DataTable();
            dt = DataProvider.GetActiveGeneralMaster("PAYTYP");
            ddlContractType.Items.Clear();
            ddlContractType.DataValueField = "CodeId";
            ddlContractType.DataTextField = "CodeDesc";
            ddlContractType.DataSource = dt;
            ddlContractType.DataBind();

            ddlContractType.Items.Insert(0, new ListItem("All", "0"));
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
        if ((rb2.Items[3].Selected))
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

        //string[] strArrDtFrom = strrightnow.Split('/');
        //string[] strArrDtTo = strrightnow1.Split('/');

        //string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        //string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        txtDateFrom.Text = strrightnow;
        txtDateTo.Text = strrightnow1;

        Session["ContractRegisterCustCodeList"] = txtCustCode.Text.ToString();
        Session["Contractid"] = txtCustContract.Text.ToString();

        Page.RegisterStartupScript("ContractRegisterCustCodeList", @"<script language='JavaScript' type='text/javascript'>
           var fromdt = document.getElementById('ctl00$MyCPH1$DT$txtDateFrom');
           var todt = document.getElementById('ctl00$MyCPH1$DT$txtDateTo');
           var rdbtnEntryDate = document.getElementById('ctl00_MyCPH1_rdbtnEntryDate');
           var rdbtnContractDate = document.getElementById('ctl00_MyCPH1_rdbtnContractDate');
           var rdbtnExpirydate = document.getElementById('ctl00_MyCPH1_rdbtnExpirydate'); 
           var rdbtnWithoutContract = document.getElementById('ctl00_MyCPH1_rdbtnWithoutContract');
           var rdbtnBoth = document.getElementById('ctl00_MyCPH1_rdbtnBoth');
           var ddlContractType = document.getElementById('ctl00_MyCPH1_ddlContractType');
           var txtLocation = document.getElementById('ctl00_MyCPH1_txtLocation');
           if (rdbtnEntryDate.checked) { var contype = 'EN';}
           if (rdbtnContractDate.checked) { var contype = 'CO';}
           if (rdbtnExpirydate.checked) { var contype = 'EX';}
          
           if (rdbtnWithoutContract.checked) { var cont = 'W';
                 var trStatus = document.getElementById('ctl00_MyCPH1_trStatus');
                 trStatus.style['display'] = 'none';
            }
           else if(rdbtnBoth.checked) { var cont = 'B'; 
                 var trStatus = document.getElementById('ctl00_MyCPH1_trStatus');
                 trStatus.style['display'] = 'none';
            }
           else
           {    var rdbtnActive = document.getElementById('ctl00_MyCPH1_rdbtnActive');
                var rdbtnInactive = document.getElementById('ctl00_MyCPH1_rdbtnInactive');
                var rdbtnExpired = document.getElementById('ctl00_MyCPH1_rdbtnExpired');
                if (rdbtnActive.checked) { var cont = 'A' }
                if (rdbtnInactive.checked) { var cont = 'I'; }
                if (rdbtnExpired.checked) { var cont = 'E'; }
           }
           
           //var strPopupURL = 'Result.aspx?fromdt=' + fromdt.value + '&todt=' + todt.value + '&con_type=' + contype + '&Con_status=' + cont;
           var strPopupURL = 'Result.aspx?id='+Math.random()+'&fromdt=' + fromdt.value + '&todt=' + todt.value + '&con_type=' + contype + '&Con_status=' + cont + '&servicetype=' + ddlContractType.value +'&LocCode='+ txtLocation.value;
            window.open(strPopupURL, '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=970 ,height=650,status=no,left=10,top=10');
               return false;
           </script>");

    }

}
