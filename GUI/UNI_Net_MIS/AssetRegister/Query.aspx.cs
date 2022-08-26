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

public partial class GUI_UNI_Net_MIS_AssetRegister_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;
    public string finyearend1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {
            string sqlstr = "select (accdesc + ':' + acccode) as c1,acccode as c2 from webx_acctinfo where acccategory like 'Fixe%' order by accdesc asc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(ds, "tab");
            cmbAsset.DataSource = ds;
            cmbAsset.DataTextField = "c1";
            cmbAsset.DataValueField = "c2";
            cmbAsset.DataBind();


            string YearString = Session["FinYear"].ToString().Substring(0, 4);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            finyearend1 = "31 Mar " + CloseYear;

            cboDepreciation.Items.Add(new ListItem("Upto Todate" ,"A"));
            cboDepreciation.Items.Add(new ListItem(finyearend1, "B"));

        }
        conn.Close();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";

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

        
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        string asset = cmbAsset.SelectedValue.ToString();
        string method = cboMethod.SelectedValue.ToString();
        string rmd = rptmd.SelectedValue.ToString();
        string depfrom = cboDepreciation.SelectedValue.ToString();
        string final;
        
        final = "?DateType=" + report_mode;
        final += "Location=" + txtLocation.Text;
        final += "GrossValue=" + txtGrossValue.Text;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&asset=" + asset;
        final += "&method=" + method;
        final += "&depfrom=" + depfrom;
        final += "&RMD=" + rmd;

        Response.Redirect("Result.aspx" + final);

    }
}
