using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;

public partial class GUI_Fleet_Reports_Driver_Wise_Fuel_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        //this.Title = pagetitle;
        if (!IsPostBack)
        {

            
            //BindDropDown("USP_Driver", "manual_Driver_Code","Driver_Name", ddlmanualname);
            BindDropDown("USP_Driver", "Manual_driver_Code", "driver_name", ddlmanualname);


        }

    }

    public void BindDropDown(string strProc, string value, string text, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));

            }
        }
        dr.Close();
        conn.Close();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
           Cls_Driver_Wise_Fuel_Register.strstart_dt =txtDateFrom.Text.ToString().Trim();

         Cls_Driver_Wise_Fuel_Register.strEnd_dt= txtDateTo.Text.ToString().Trim();
        Cls_Driver_Wise_Fuel_Register.strDriver1= ddlmanualname.SelectedItem.Text.ToString().Trim();
        Cls_Driver_Wise_Fuel_Register.strCompany = company.SelectedValue.ToString().Trim();
        Response.Redirect("Driver_wise_Fuel_Register_Report.aspx");
    }
}
