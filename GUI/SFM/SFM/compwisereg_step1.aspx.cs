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

public partial class SFM_compwisereg_step1 : System.Web.UI.Page
{
    string strCompanyName;
    DateTime dFromDate, dTodate, dtToDate, dtFromDate;
    SqlDataReader drRo, drLocation, drCallSummary;
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    SqlCommand cmd = new SqlCommand();
    SqlDataAdapter da;

    protected void Page_Load(object sender, EventArgs e)
    {

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
    }
    //public void BindGrid()
    //{

    //    conn.Open();
    //    string sql = "webx_funnal_location";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;



    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";

    //    {
    //        dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
    //        dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
    //    }


    //    da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
    //    da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
    //    da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = cboSelectLocation.SelectedValue.ToString();

    //    DataSet ds = new DataSet();
    //    da.Fill(ds);

    //    DataView dv = ds.Tables[0].DefaultView;

    //    dgCallSummary.DataSource = dv;
    //    dgCallSummary.DataBind();

    //    conn.Close();

    //}
}
