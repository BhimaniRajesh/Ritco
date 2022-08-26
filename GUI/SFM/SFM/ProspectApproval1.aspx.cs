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

public partial class SFM_ProspectApproval1 : System.Web.UI.Page
{
    SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public static string strIndustry;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr = @"<script>
                    function update1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtEmpId').value=elemValue; 
                  }
                  </script>";

        Page.RegisterClientScriptBlock("update1", scr);
        //btnPopUp.Attributes.Add("onclick", "window.open('PopupEmployee.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        btnCust.Attributes.Add("onclick", "window.open('EmployeePopup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        Button3.Attributes.Add("onclick", "javascript:return datecheck(" + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ")");
        if (!IsPostBack)
        {
            conn.Open();
            SqlDataReader drIndustry;

            cmd.CommandText = "select CodeDesc,CodeId from Webx_Master_General where CodeType='IND'";
            cmd.Connection = conn;
            drIndustry = cmd.ExecuteReader();

            cboIndustry.Items.Clear();
            cboIndustry.Items.Add("--Select--");
            cboIndustry.Items.Add("All");
            while (drIndustry.Read())
            {
                cboIndustry.Items.Add(new ListItem(drIndustry.GetValue(0).ToString(), drIndustry.GetValue(1).ToString()));

            }

            drIndustry.Close();
        }
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
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }
    protected void cboIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        //conn = new SqlConnection(sConn);
        conn.Open();


        strIndustry = cboIndustry.SelectedValue.ToString();
        strIndustry = strIndustry.Trim();
        string sql;
        if (strIndustry == "All")
        {
            strIndustry = "";
            sql = "select top 1 ' Select' as c1,' Select' as c2 from webx_ProspectCustomer union select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where  statesub <> 'A' and entryby='" + txtEmpId.Text + "'";
        }
        else
        {
            sql = "select top 1 ' Select' as c1,' Select' as c2 from webx_ProspectCustomer union select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode='" + strIndustry + "' and statesub <> 'A' and entryby='" + txtEmpId.Text + "'";
        }

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboCustomerId.DataSource = ds;

        cboCustomerId.DataTextField = "c1";
        cboCustomerId.DataValueField = "c2";
        cboCustomerId.DataBind();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string final = "?strFromDt=" + txtDateFrom.Text;
        final = final + "&strToDt=" + txtDateTo.Text;
        final = final + "&strCompanyName=" + cboCustomerId.SelectedItem;
        final = final + "&strEmpId=" + txtEmpId.Text;
        final = final + "&strIndustry=" + cboIndustry.SelectedValue.ToString();
        //final = final + "&strCity=" + txtCity.Text;
        final = final + "&strAccCategory=" + cboAccCategory.SelectedValue.ToString();


        Response.Redirect("ProspectApproval2.aspx" + final);
    }
    protected void cboCustomerId_SelectedIndexChanged(object sender, EventArgs e)
    {
        conn.Open();
        string CompanyCode = cboCustomerId.SelectedValue.ToString();
        string sqlQuery = "Select AcctCategory,statesub from Webx_ProspectCustomer where ProspectCode='" + CompanyCode + "'";
        SqlCommand SqlCmd1 = new SqlCommand(sqlQuery, conn);
        SqlDataReader dr;
        dr = SqlCmd1.ExecuteReader();

        while (dr.Read())
        {
            string status = Convert.ToString(dr["statesub"]);
            if (status == "S")
            {
                status = "Submitted";
            }
            else if (status == "U")
            {
                status = "Un-Submitted";
            }
            else if (status == "R")
            {
                status = "Rejected";
            }
            else if (status == "A")
            {
                status = "Approved";
            }

            cboAccCategory.Items.Add(new ListItem(dr.GetValue(0).ToString()));
            cboApproval.Items.Add(new ListItem(status).ToString());
        }

    }
}
