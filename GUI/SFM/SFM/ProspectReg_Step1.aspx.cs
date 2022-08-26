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

public partial class SFM_ProspectReg_Step1 : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    
    SqlCommand cmd = new SqlCommand();
    public static SqlConnection conn;
    string flag, scriptStr, ProspectCode;
    public string sql_Insert;
    public static string ClientName;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnDone.Attributes.Add("onclick", "javascript:return Validation(" + txtAddress.ClientID + "," + txtCity.ClientID + "," + txtComments.ClientID + "," + txtcompanyName.ClientID + "," + txtContactPerson.ClientID + "," + txtdate.ClientID + "," + txtDesignation.ClientID + "," + txtEmail.ClientID + "," + txtPhone.ClientID + "," + txtPin.ClientID + "," + txtWebsite.ClientID + "," + industryCode.ClientID + ")");
        txtEmail.Attributes.Add("onblur", "javascript:return EmailCheck(" + txtEmail.ClientID + ")");
        txtPin.Attributes.Add("onblur", "javascript:return PinCheck(" + txtPin.ClientID + ")");

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd MMM yyyy");
        txtdate.Text = strrightnow;
        txtdate.ReadOnly = true;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            //ClientName = Session["Client"].ToString();
            //if (ClientName == "1")
            //{
                loadpyament.Visible = true;
                routes.Visible = true;
            //}
            //else
            //{
             //   loadpyament.Visible = false;
             //   routes.Visible = false;
           // }
            conn.Open();
            SqlDataReader drIndustry;

            //cmd.CommandText = "select IndustryName,IndustryCode from  webx_IndustryMaster where ActiveFlag='Y' order by IndustryName";
            cmd.CommandText = "select CodeDesc,CodeId,* from Webx_Master_General where CodeType='IND'";
            cmd.Connection = conn;
            drIndustry = cmd.ExecuteReader();

            industryCode.Items.Clear();
            while (drIndustry.Read())
            {
                industryCode.Items.Add(new ListItem(drIndustry.GetValue(0).ToString(), drIndustry.GetValue(1).ToString()));

            }

            drIndustry.Close();

            conn.Close();
            getstring();

        }

    }
    private void getstring()
    {
        conn.Open();
        string Branch = Session["brcd"].ToString();
        string sql = "select Upper(companyName) as com from webx_ProspectCustomer where LocCode='" + Branch + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        SqlDataReader drCompany;
        drCompany = sqlCommand.ExecuteReader();
        while (drCompany.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(drCompany["com"] + "'"));
        }
        if (drCompany.HasRows == false)
        {
            Page.RegisterArrayDeclaration("str", "'TEST'");
        }
        drCompany.Close();

        conn.Close();
    }	

    protected void btnDone_Click(object sender, EventArgs e)
    {

        conn.Open();
        string mNewCode;
        string sql1 = "select max(prospectCode) from webx_ProspectCustomer";
        SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
        string i;
        i = Command.ExecuteScalar().ToString();
        conn.Close();
        if (i == "")
        {
            i = "PR00000";
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


        mNewCode = "PR" + m.ToString();
        ProspectCode = mNewCode;
        conn.Open();
        //if (ClientName == "1")
        //{
            //sql_Insert = "webx_sfm_ProspectCustomer_InsertData_Clients";
        //}
        //else
       // {
            sql_Insert = "webx_sfm_ProspectCustomer_InsertData";
        //}
        SqlCommand sqlcmd2 = new SqlCommand(sql_Insert, conn);
        sqlcmd2.CommandType = CommandType.StoredProcedure;

        string brcd = Convert.ToString(Session["brcd"]);
        string empcd = Convert.ToString(Session["Empcd"]);

        //string ProspectCode = getNewCode("webx_ProspectCustomer", "prospectCode", "PR", 5);
        //if (ClientName == "1")
        //{
            sqlcmd2.Parameters.Add("@prospectCode_1", SqlDbType.VarChar).Value = ProspectCode;
            sqlcmd2.Parameters.Add("@RegisterDt_2", SqlDbType.DateTime).Value = Convert.ToDateTime(txtdate.Text).ToString("dd MMM yyyy");
            sqlcmd2.Parameters.Add("@companyName_3", SqlDbType.VarChar).Value = txtcompanyName.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@industryCode_4", SqlDbType.VarChar).Value = industryCode.SelectedItem.Value.ToString();
            sqlcmd2.Parameters.Add("@compAddr_5", SqlDbType.VarChar).Value = txtAddress.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@compCity_6", SqlDbType.VarChar).Value = txtCity.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@compPin_7", SqlDbType.VarChar).Value = txtPin.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@compPhone_8", SqlDbType.VarChar).Value = txtPhone.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@CompEmail_9", SqlDbType.VarChar).Value = txtEmail.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@contPerson_10", SqlDbType.VarChar).Value = txtContactPerson.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@contDesign_11", SqlDbType.VarChar).Value = txtDesignation.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@contPhone_12", SqlDbType.VarChar).Value = "";
            sqlcmd2.Parameters.Add("@contEmail_13", SqlDbType.VarChar).Value = "";
            sqlcmd2.Parameters.Add("@compwebsite", SqlDbType.VarChar).Value = txtWebsite.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@comment", SqlDbType.VarChar).Value = txtComments.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@entryby_14", SqlDbType.VarChar).Value = empcd;
            sqlcmd2.Parameters.Add("@companyStatus_18", SqlDbType.VarChar).Value = "P";
            sqlcmd2.Parameters.Add("@loccode", SqlDbType.VarChar).Value = brcd;
            sqlcmd2.Parameters.Add("@statsub", SqlDbType.Char).Value = "U";
            sqlcmd2.Parameters.Add("@LoadType", SqlDbType.VarChar).Value = txtLoadType.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@PaymentSystem", SqlDbType.VarChar).Value = txtPaymentSystem.Text.ToString().Trim();
            sqlcmd2.Parameters.Add("@MainRoutes", SqlDbType.VarChar).Value = txtMainroutes.Text.ToString().Trim();

        //}
        //else
        //{

        //    sqlcmd2.Parameters.Add("@prospectCode_1", SqlDbType.VarChar).Value = ProspectCode;
        //    sqlcmd2.Parameters.Add("@RegisterDt_2", SqlDbType.DateTime).Value = Convert.ToDateTime(txtdate.Text).ToString("dd MMM yyyy");
        //    sqlcmd2.Parameters.Add("@companyName_3", SqlDbType.VarChar).Value = txtcompanyName.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@industryCode_4", SqlDbType.VarChar).Value = industryCode.SelectedItem.Value.ToString();
        //    sqlcmd2.Parameters.Add("@compAddr_5", SqlDbType.VarChar).Value = txtAddress.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@compCity_6", SqlDbType.VarChar).Value = txtCity.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@compPin_7", SqlDbType.VarChar).Value = txtPin.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@compPhone_8", SqlDbType.VarChar).Value = txtPhone.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@CompEmail_9", SqlDbType.VarChar).Value = txtEmail.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@contPerson_10", SqlDbType.VarChar).Value = txtContactPerson.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@contDesign_11", SqlDbType.VarChar).Value = txtDesignation.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@contPhone_12", SqlDbType.VarChar).Value = "";
        //    sqlcmd2.Parameters.Add("@contEmail_13", SqlDbType.VarChar).Value = "";
        //    sqlcmd2.Parameters.Add("@compwebsite", SqlDbType.VarChar).Value = txtWebsite.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@comment", SqlDbType.VarChar).Value = txtComments.Text.ToString().Trim();
        //    sqlcmd2.Parameters.Add("@entryby_14", SqlDbType.VarChar).Value = empcd;
        //    sqlcmd2.Parameters.Add("@companyStatus_18", SqlDbType.VarChar).Value = "P";
        //    sqlcmd2.Parameters.Add("@loccode", SqlDbType.VarChar).Value = brcd;
        //    sqlcmd2.Parameters.Add("@statsub", SqlDbType.Char).Value = "U";

        //}
        sqlcmd2.ExecuteNonQuery();
        Response.Redirect("ProspectReg_Done.aspx?ProspectCode=" + ProspectCode);
        conn.Close();
    }
}
