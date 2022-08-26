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

public partial class SFM_ProspectApproval2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string fromdt, todt, fromdt1, todt1, strFromDt, strToDt, strFromDt1, strToDt1, strCompanyName, strEmpId, strIndustry, strCity, strAccCategory, strApproval;
    public static string daterange, daterange1;
    Array str, str1, str11, Prospect;
    public int intTotalRecords=0;
    public string status1, CustomerCode,ProspectCode;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        fromdt = HttpUtility.UrlDecode(Request.QueryString["strFromDt"].ToString());
        todt = HttpUtility.UrlDecode(Request.QueryString["strToDt"].ToString());
        strCompanyName = Request.QueryString["strCompanyName"].ToString();
        strIndustry = Request.QueryString["strIndustry"].ToString();
        //strCity = Request.QueryString["strCity"].ToString();
        strAccCategory =Convert.ToString(Request.QueryString["strAccCategory"]);
        strEmpId = Request.QueryString["strEmpId"].ToString();

        Prospect = strCompanyName.Split(':');
        ProspectCode = Convert.ToString(((string[])(Prospect))[0]);
        if (strAccCategory == "")
        {
            strAccCategory = "";
        }
        if (strIndustry == "All")
        {
            strIndustry = "";
        }
        //DateTime f = Convert.ToDateTime(fromdt);
        //DateTime t = Convert.ToDateTime(todt);

        //string fd = f.ToString("dd/MM/yyyy");
        //string td = t.ToString("dd/MM/yyyy");

        str = fromdt.Split('/');
        str1 = todt.Split('/');

        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name

        daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        fromdt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        todt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        
        //btnSubmit.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        
        if (!IsPostBack)
        {
            BindGrid();
            btnSubmit.Attributes.Add("onclick", "javascript:return abc(" + btnSubmit.ClientID + ")");
        }
    }

    private void BindGrid()
    {
        conn.Open();
        string sql = "select ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,convert(varchar,LastVisitDt,106) as LastVisitDt,entryby,(select top 1 a.CodeDesc from Webx_Master_General a where a.Codetype='IND' and a.CodeId=industryCode) as industryCode,compCity,contPerson,acctCategory,companyStatus,comment,statesub from webx_ProspectCustomer where ProspectCode is not null and industryCode like '" + strIndustry + "%' and entryby = '" + strEmpId + "' and ProspectCode='" + ProspectCode + "' and  convert(varchar,RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and statesub='S' or statesub='R' order by CompanyName";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        ProspectStatus.DataSource = dv;
        ProspectStatus.DataBind();
        //ProspectStatus.FooterRow.Cells[0].Text="
        intTotalRecords = ds.Tables[0].Rows.Count;

        conn.Close();
    }
    protected void ProspectStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1;
            l1 = (Label)e.Row.FindControl("lblsubmission");
            CheckBox c1;
            if (l1.Text == "S")
            {
                l1.Text = "Submitted";
            }
            else if (l1.Text == "R")
            {
                l1.Text = "Rejected";
            }

        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        ProspectStatus.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn.Open();
        string prospect = "";
        foreach (GridViewRow gridrow in ProspectStatus.Rows)
        {
            Label lbl1 = (Label)gridrow.FindControl("lblsubmission");
            CheckBox check1 = (CheckBox)gridrow.FindControl("chkDock");
            Label lblProspect = (Label)gridrow.FindControl("lblProspect");
            
            
            if (check1.Checked == true)
            {
                if (prospect == "")
                {
                    prospect = lblProspect.Text;
                }
                else
                {
                    prospect = prospect + "','" + lblProspect.Text;
                }
                /********************************    Customer Code      *************************/

                if (RadioButtonList1.SelectedValue == "rd1")
                {
                    
                    string mNewCode;
                    string sql1 = "select max(CustCode) from webx_ProspectCustomer";
                    SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
                    string i;
                    i = Command.ExecuteScalar().ToString();

                    if (i == "" || i == null || i =="NULL")
                    {
                        i = "CC00000";
                    }
                        int j = Convert.ToInt16(i.Substring(2, 5));

                        int k = j + 1;
                        string m = k.ToString();

                        if (m.Length == 1)
                        {
                            m = "0000" + m;
                        }
                        else if (m.Length == 2)
                        {
                            m = "000" + m;
                        }
                        else if (m.Length == 3)
                        {
                            m = "00" + m;
                        }
                        else if (m.Length == 4)
                        {
                            m = "0" + m;
                        }
                        else if (m.Length == 5)
                        {
                            m = m;
                        }


                        mNewCode = "CC" + m.ToString();
                        CustomerCode = mNewCode;


                        string sql_custcode = "Update webx_ProspectCustomer set ApprovalDt=GetDate(),AcctCategory='Customer',statesub='A',CustCode='" + CustomerCode + "' where ProspectCode = '" + lblProspect.Text + "'";
                        SqlCommand sqlcmd2 = new SqlCommand(sql_custcode, conn);
                        sqlcmd2.ExecuteNonQuery();

                        //string sql_customer = "Update WEBX_SalesTarget set ProspectStatus='Customer' where ProspectID = '" + lblProspect.Text + "'";
                        //SqlCommand sqlcmd3 = new SqlCommand(sql_customer, conn);
                        //sqlcmd3.ExecuteNonQuery();
                    
                    
                    /******************************************************************************/
                }
                if (RadioButtonList1.SelectedValue == "rd2")
                {

                    string sql_custcode = "Update webx_ProspectCustomer set statesub='R',CustCode='NULL',ReasonforReject='" + txtReason.Text + "' where ProspectCode = '" + lblProspect.Text + "'";
                    SqlCommand sqlcmd2 = new SqlCommand(sql_custcode, conn);
                    sqlcmd2.ExecuteNonQuery();
                }
            }
            
        }
        if (RadioButtonList1.SelectedValue == "rd1")
        {
            Response.Redirect("ProspectApproval3_Approved.aspx?prospect="+prospect+"");
        }
        else if (RadioButtonList1.SelectedValue == "rd2")
        {
            Response.Redirect("ProspectApproval3_Rejected.aspx?prospect=" + prospect + "");
        }
        conn.Close();

    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 1)
        {
            reason.Visible = true;
        }
        if (RadioButtonList1.SelectedIndex == 0)
        {
            reason.Visible = false;
        }
    }
}
