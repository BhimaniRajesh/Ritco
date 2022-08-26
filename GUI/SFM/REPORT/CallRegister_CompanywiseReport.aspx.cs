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

public partial class REPORT_CallRegister_CompanywiseReport : System.Web.UI.Page
{
    public string callvisit;
    string strCompanyName, strDateRange;
    DateTime dFromDate, dTodate, dtToDate, dtFromDate;
    SqlDataReader drRo, drLocation, drCallSummary;
    SqlDataReader drComp;
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    

    protected void Page_Load(object sender, EventArgs e)
    {
        string client = Session["Client"].ToString();
        if (client == "Varuna" || client == "VARUNA")
        {
            callvisit = "Visit";
        }
        else
        {
            callvisit = "Call";
        }
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtEmp').value=elemValue;        
        }
        </script>";

            Page.RegisterClientScriptBlock("update1", scr1);
            btnCust.Attributes.Add("onclick", "window.open('./Company_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        }
        btnShowReport.Attributes.Add("onclick", "javascript:return datecheck(" + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ")");
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
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }
    protected void btnShowReport_Click(object sender, EventArgs e)
    {
        //BindGrid();

        string final = "?strFromDt=" + txtDateFrom.Text;
        final = final + "&strToDt=" + txtDateTo.Text;
        final = final + "&strCompany=" + txtEmp.Text;
       
        Response.Redirect("CallRegister_CompanywiseReport2.aspx" + final);


        
    }

    public void BindGrid()
    {
        //string strCallReport;
        //string strDateRange, strCompanyName;
        //// strDateRange = " and calldt between " + Convert.ToDateTime(txtDateFrom.Text.ToString()) + "' and '" + Convert.ToDateTime(txtDateTo.Text.ToString()) + "'";
        //strCompanyName = txtLocationCode.Text.Trim();
        //if (txtLocationCode.Text != "")
        //{
         //   strCompanyName = " and companyName like '" + strCompanyName + "%' ";
        //}
        //conn.Open();

        ////if (Session["Level_Type"].ToString() == "Head Office")
        ////{

        //strCallReport = "select m.*,d.contPerson,d.companyName from webx_callEntry m ,webx_prospectcustomer d where m.ProspectCode=d.ProspectCode " + strCompanyName + " order by calldt ";


        ////}
        ////else
        ////{

        //// strCallReport = "select m.*,d.contPerson,d.companyName from webx_callEntry m ,webx_prospectcustomer d where m.ProspectCode=d.ProspectCode " + strCompanyName + " and   m.entryby='" + Session["EmpCd"] + "' order by calldt ";

        ////}

        //conn.Close();

        //Response.Redirect("CallRegister_CompanywiseReport2.aspx?CallReport=" + strCallReport + "&Company=" + txtLocationCode.Text.Trim());

        conn.Open();
        string sql = "webx_callreg_Company";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        {
            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        }
        
      
        da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@company", SqlDbType.VarChar).Value = txtEmp.Text.ToString();

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallCompany.DataSource = dv;
        dgCallCompany.DataBind();

        conn.Close();

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallCompany.PageIndex = e.NewPageIndex;
        BindGrid();
    }


}

