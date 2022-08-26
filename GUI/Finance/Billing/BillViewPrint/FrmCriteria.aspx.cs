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
using Microsoft.VisualBasic;     
public partial class FrmCriteria : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection cn; //= new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    public string client;
    protected void Page_Load(object sender, EventArgs e)
    {
        client = Session["Client"].ToString();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            //txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            //txtDateTo.Text = txtDateFrom.Text;
            //txtDateFrom.ReadOnly = true;
            //txtDateTo.ReadOnly = true;  
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            txtmbillno.Text = txtmbillno.Text.Trim().Replace("'","''");
            txtbillno.Text = txtbillno.Text.Trim().Replace("'", "''");
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

            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd/MM/yyyy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd/MM/yyyy");


            if (client == "Varuna")
            {
                Response.Redirect("FrmBillDetail_Varuna.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else if (client == "Ritco")
            {
                Response.Redirect("FrmBillDetail_RITCO.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else if (client == "EXL")
            {
                Response.Redirect("FrmBillDetail_EXL.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else if (client == "RCPL")
            {
                Response.Redirect("FrmBillDetail_RCPL.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else if (client == "ASL")
            {
                Response.Redirect("FrmBillDetail_ASL.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else if (client == "TLL")
            {
                Response.Redirect("FrmBillDetail_TLL.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            else
            {
                Response.Redirect("FrmBillDetail.aspx?FrmDate=" + dtFrom + "&ToDate=" + dtTo + "&billno=" + txtbillno.Text + "&mbillno=" + txtmbillno.Text + "&partycode=" + txtpartycode.Text + "&billtype=" + cmbbilltype.Text + "&billstatus=" + cmbbillstatus.Text + "");
            }
            
        }
    }
    //public void abc(object source, ServerValidateEventArgs value)
    //{
    //    //value.IsValid = true; 
    //    txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
    //    txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
    //    txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
    //    txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
    //    string[] strDtFrom = txtDateFrom.Text.Split('/');
    //    DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
    //    string[] strDtTo = txtDateTo.Text.Split('/');
    //    DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
    //    if (DateTime.Compare(dt1, dt2) > 0)
    //    {
    //        value.IsValid = false;
    //    }
    //    else
    //    {
    //        value.IsValid = true;
    //    }
    //}
    //public void daterange(object source, ServerValidateEventArgs value)
    //{
    //    //value.IsValid = true; 
    //    txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
    //    txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
    //    txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
    //    txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
    //    string[] strDtFrom = txtDateFrom.Text.Split('/');
    //    DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
    //    string[] strDtTo = txtDateTo.Text.Split('/');
    //    DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
    //    System.TimeSpan diffResult = dt2.Subtract(dt1);
    //    if (diffResult.Days > 31)
    //    {
    //        value.IsValid = false;
    //    }
    //    else
    //    {
    //        value.IsValid = true;
    //    }
    //}
    //protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (radDate.SelectedItem.Text == " Last Week (Including Today)")
    //    {
    //        txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
    //        DateTime MyDate = DateTime.Today;
    //        MyDate = MyDate + TimeSpan.FromDays(-7);
    //        txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
    //        txtDateFrom.ReadOnly = true;
    //        txtDateTo.ReadOnly = true;  
            
    //    }
    //    else
    //    {
    //        if (radDate.SelectedItem.Text == " Date Range [dd/mm/yyyy]")
    //        {
    //            DateTime MyDate = DateTime.Today;
    //            MyDate = MyDate + TimeSpan.FromDays(-31);
    //            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
    //            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
    //            txtDateFrom.ReadOnly = false;
    //            txtDateTo.ReadOnly = false;
                
    //        }

    //        if (radDate.SelectedItem.Text == " Today:")
    //        {
    //            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
    //            txtDateTo.Text = txtDateFrom.Text;
    //            txtDateFrom.ReadOnly = true;
    //            txtDateTo.ReadOnly = true;
                
    //        }
    //    }
    //}
    
}
