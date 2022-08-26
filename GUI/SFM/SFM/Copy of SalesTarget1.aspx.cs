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

public partial class SFM_SalesTarget1 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = @"<script>
                    function update(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtEmployeeCode').value=elemValue;
                  }
                  </script>";

        Page.RegisterClientScriptBlock("update", scr);
        btnPopUp.Attributes.Add("onclick", "window.open('PopupEmployee.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        

        if (!IsPostBack)
        {
            conn.Open();
            SqlDataReader drIndustry;

            cmd.CommandText = "select IndustryName,IndustryCode from  webx_IndustryMaster order by IndustryName";
            cmd.Connection = conn;
            drIndustry = cmd.ExecuteReader();

            cboIndustry.Items.Clear();
            cboIndustry.Items.Add("Select");
            while (drIndustry.Read())
            {
                cboIndustry.Items.Add(new ListItem(drIndustry.GetValue(0).ToString(), drIndustry.GetValue(1).ToString()));

            }

            drIndustry.Close();
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        
        string final = "?ProspectId=" + cboCustomerId.SelectedValue.ToString();
        final = final + "&Industry=" + cboIndustry.SelectedValue.ToString();
        final = final + "&year=" + cboYear.SelectedValue.ToString();
        final = final + "&acccategory=" + cboAccCategory.SelectedValue.ToString();
        final = final + "&employee=" + txtEmployeeCode.Text;
        final = final + "&period=" + cboPeriod.SelectedValue.ToString();

        Response.Redirect("SalesTarget2.aspx" + final);
        
    }
    protected void cboIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sConn;
        SqlConnection conn;
        sConn = "data source=202.87.45.72;UID=sa;PWD=@ptn$ecfy;Database=RIL2;";

        conn = new SqlConnection(sConn);
        conn.Open();
        cboCustomerId.

        string strIndustry = cboIndustry.SelectedValue.ToString();
        //string sql = "select top 1 'All' as c1,'All' as ProspectCode from webx_ProspectCustomer union select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode='" + strIndustry + "' and flag is null";
        string sql = "select top 1 'All' as c1,'All' as ProspectCode from webx_ProspectCustomer union select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode='" + strIndustry + "' and flag is null and entryby='" + txtEmployeeCode.Text + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboCustomerId.DataSource = ds;
        cboCustomerId.DataTextField = "c1";
        cboCustomerId.DataValueField = "ProspectCode";
        cboCustomerId.DataBind();
    }
}
