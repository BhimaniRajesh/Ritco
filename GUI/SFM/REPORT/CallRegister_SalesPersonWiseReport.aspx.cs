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

public partial class REPORT_CallRegister_SalesPersonWiseReport : System.Web.UI.Page
{
    public string callvisit;
    string strCompanyName, strDateRange;
    DateTime dFromDate, dTodate, dtToDate, dtFromDate;
    //SqlDataReader drRo, drLocation, drCallSummary;
    //SqlDataReader drComp;
    public static SqlConnection conn;
    //SqlCommand cmd = new SqlCommand();

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
        document.getElementById('ctl00_MyCPH1_txtEmpCode').value=elemValue;        
        }
        </script>";

            Page.RegisterClientScriptBlock("update1", scr1);
            btnCust.Attributes.Add("onclick", "window.open('./Popup_Employee_CallRegister.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
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
        //string strCallReport;
        //string strDateRange, strEmpName;
        

        //strEmpName = txtEmpCode.Text.Trim();
        //if (txtEmpCode.Text != "")
        //{
        //    strEmpName = " and d.entryby like '" + strEmpName + "%' ";
        //}
        //conn.Open();
        //strCallReport = "select m.*,d.contPerson,d.companyName from webx_callEntry m ,webx_prospectcustomer d where m.ProspectCode=d.ProspectCode " + strEmpName + " order by calldt";
        
        //conn.Close();
        
        //Response.Redirect("CallRegister_SalesPersonWiseReport2.aspx?CallReport=" + strCallReport + "&Employee=" + txtEmpCode.Text.Trim());

        //BindGrid();
        

        string final = "?strFromDt=" + txtDateFrom.Text;
        final = final + "&strToDt=" + txtDateTo.Text;
        final = final + "&strEmployee=" + txtEmpCode.Text;

        Response.Redirect("CallRegister_SalesPersonWiseReport2.aspx" + final);


    }

    public void BindGrid()
    {

        conn.Open();
        string sql = "webx_callregsalespersonlist";
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
        da.SelectCommand.Parameters.Add("@employee", SqlDbType.VarChar).Value = txtEmpCode.Text.ToString();

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallReg.DataSource = dv;
        dgCallReg.DataBind();

        conn.Close();




        //conn.Open();
        //string sql = "webx_new";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //System.DateTime righnow = System.DateTime.Today;
        //string strrightnow = righnow.ToString("dd/MM/yyyy");

        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";

        //{
        //    dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
        //    dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        //}


        //da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
        //da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
        //da.SelectCommand.Parameters.Add("@employee", SqlDbType.VarChar).Value = txtEmpCode.Text.ToString();

        //DataSet ds1 = new DataSet();
        //da.Fill(ds1);
        //DataView dv = ds1.Tables[0].DefaultView;

        //dgCallReg.DataSource = dv;
        //dgCallReg.DataBind();

        //conn.Close();

    }
    
    //protected void pgChange(object sender, DataGridPageChangedEventArgs e)
    //{
    //    //dgCallReg.PageIndexChanged = e.NewPageIndex;
    //    //BindGrid();
               
    //    dgCallReg.CurrentPageIndex = e.NewPageIndex;
    //    dgCallReg.EditItemIndex = -1;
    //    ResetPageIndex(dgCallReg, View);
    //    dgCallReg.DataBind();

    //}

    //protected void ResetPageIndex(DataGrid grid, DataView view)
    //{
    //    // check for invalid page index
    //    if ((grid.CurrentPageIndex != 0) && (((grid.CurrentPageIndex) * grid.PageSize) >= view.Count))
    //    {
    //        // invalid so leave at last page
    //        if ((view.Count % grid.PageSize) == 0)
    //        { // ends on page border
    //            grid.CurrentPageIndex = (view.Count / grid.PageSize) - 1;
    //        }
    //        else // partial page
    //        {
    //            grid.CurrentPageIndex = (view.Count / grid.PageSize);
    //        }
    //    }
    //}
}
