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
using System.Globalization;

public partial class SFM_ProspectRegStateSub2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string fromdt, todt, fromdt1, todt1, strFromDt, strToDt, strFromDt1, strToDt1, strCompanyName, strEmpId, strIndustry, strCity, strAccCategory, strApproval;
    public static string daterange, daterange1;
    Array str, str1, str11;
    public int intTotalRecords;
    public string status1, Prospect;
    public string[] Prospect1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //fromdt = HttpUtility.UrlDecode(Request.QueryString["strFromDt"].ToString());
        //todt = HttpUtility.UrlDecode(Request.QueryString["strToDt"].ToString());
        //fromdt1 = HttpUtility.UrlDecode(Request.QueryString["strFromDt1"].ToString());
        //todt1 = HttpUtility.UrlDecode(Request.QueryString["strToDt1"].ToString());

        strCompanyName = Convert.ToString(Request.QueryString["strCompanyName"]);
        strIndustry = Convert.ToString(Request.QueryString["strIndustry"]);
        strAccCategory = Convert.ToString(Request.QueryString["strAccCategory"]);
        strApproval = Convert.ToString(Request.QueryString["strApproval"]);
        strEmpId = Convert.ToString(Request.QueryString["strEmpId"]);

        Prospect1 = strCompanyName.Split(':');
        Prospect = Prospect1[0].ToString();

        if (!IsPostBack)
        {
            //if (fromdt != "" || todt != "")
            //{
            //    str = fromdt.Split('/');
            //    str1 = todt.Split('/');

            //    string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            //    string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name

            //    daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            //    fromdt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            //    todt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];


            // BindGrid1();
            /***********************************************************************************************************/
            //}
            //if (fromdt1 != "" || todt1 != "")
            //{
            //    str1 = fromdt1.Split('/');
            //    str11 = todt1.Split('/');

            //    string FmonthName1 = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            //    string TmonthName1 = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str11))[1]));//return month name


            //    daterange1 = (FmonthName1 + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2] + " -- " + TmonthName1 + " " + ((string[])(str11))[0] + " " + ((string[])(str11))[2]);
            //    fromdt1 = FmonthName1 + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            //    todt1 = TmonthName1 + " " + ((string[])(str11))[0] + " " + ((string[])(str11))[2];

            BindGrid();
            //}


            btnSubmit.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        }


    }

    //private void BindGrid1()
    //{
    //    conn.Open();
    //    string sql = "select ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,convert(varchar,LastVisitDt,106) as LastVisitDt,entryby,(select top 1 a.CodeDesc from Webx_Master_General a where a.Codetype='IND' and a.CodeId=industryCode) as industryCode,compCity,contPerson,acctCategory,companyStatus,comment,statesub,ReasonforReject from webx_ProspectCustomer where ProspectCode is not null and convert(varchar,RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and ProspectCode='" + Prospect + "' order by CompanyName";
    //    SqlCommand cmd = new SqlCommand(sql, conn);
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    DataSet ds = new DataSet();
    //    da.Fill(ds);

    //    DataView dv = ds.Tables[0].DefaultView;

    //    ProspectStatus.DataSource = dv;
    //    ProspectStatus.DataBind();

    //    intTotalRecords = ds.Tables[0].Rows.Count;

    //    conn.Close();
    //}

    private void BindGrid()
    {
        conn.Open();
        string sql = "select ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,convert(varchar,LastVisitDt,106) as LastVisitDt,entryby,industryCode,compCity,contPerson,acctCategory,companyStatus,comment,statesub,ReasonforReject from webx_ProspectCustomer where ProspectCode is not null and industryCode like '" + strIndustry + "%' and compCity like '" + strCity + "%' and acctCategory like '" + strAccCategory + "%' and entryby like '" + strEmpId + "%' and ProspectCode='" + Prospect + "' order by CompanyName";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        ProspectStatus.DataSource = dv;
        ProspectStatus.DataBind();

        intTotalRecords = ds.Tables[0].Rows.Count;

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        ProspectStatus.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        conn.Open();

        foreach (GridViewRow gridrow in ProspectStatus.Rows)
        {
            Label lbl1 = (Label)gridrow.FindControl("lblsubmission");
            CheckBox check1 = (CheckBox)gridrow.FindControl("chkDock");
            Label lblProspect = (Label)gridrow.FindControl("lblProspect");

            if (check1.Checked == true)
            {
                string statusofsubmission = lbl1.Text;

                if (statusofsubmission == "UnSubmitted" || statusofsubmission == "Rejected")
                {
                    status1 = "S";
                }

                string sql1 = "update webx_ProspectCustomer set submissionDt=getDate(),statesub='" + status1 + "' where ProspectCode='" + lblProspect.Text + "'";
                SqlCommand cmd1 = new SqlCommand(sql1, conn);
                cmd1.ExecuteNonQuery();
            }

        }
        Response.Redirect("ProspectRegStateDone.aspx");
        conn.Close();
    }
    protected void ProspectStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1;
            l1 = (Label)e.Row.FindControl("lblsubmission");
            CheckBox c1;
            if (l1.Text == "U")
            {
                l1.Text = "UnSubmitted";
            }
            else if (l1.Text == "S")
            {
                l1.Text = "Submitted";
                c1 = (CheckBox)e.Row.FindControl("chkDock");
                c1.Enabled = false;
            }
            else if (l1.Text == "R")
            {
                l1.Text = "Rejected";
            }
            else if (l1.Text == "A")
            {
                l1.Text = "Approved";
                c1 = (CheckBox)e.Row.FindControl("chkDock");
                c1.Enabled = false;
            }

        }
    }
}
