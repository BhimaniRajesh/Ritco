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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Text;
using System.IO;

public partial class GUI_Fleet_Reports_OutStanding_Amount_Query : System.Web.UI.Page
{
    SqlConnection conn;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    string Financial_Year = "", fin_year = "", Defaultdate = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {


        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        BindDropDown("USP_billType", "Expense", "Code", ddlBillType);
   

        if (!IsPostBack)
        {
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            fn.Fill_Vendor_Dataset();





            Defaultdate = System.DateTime.Now.ToString("dd/MM/yyyy");

            txtDate.Text = Defaultdate;

            if (Defaultdate == "")
            {
                Defaultdate = "today";
            }

        }
    }

  

    private void BindDropDown(string strProc, string text, string value, DropDownList d)
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

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        string mtempdt = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_DateConvertFormat";

        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@CurrDt", SqlDbType.VarChar, 50).Value = txtDate.Text;
        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                mtempdt = dr1["Dt"].ToString();

            }
        }
        dr1.Close();

        conn.Close();


        string Year = SessionUtilities.FinYear.ToString();
        string Financial_Year = Year.Substring(2, 2);
        Cls_VendorBillAmount.strDate = txtDate.Text.ToString().Trim();
        Cls_VendorBillAmount.strVendor = txtVendor.Text.ToString().Trim();
        //Cls_VendorBillAmount.strType = ddlBillType.SelectedItem.Text.ToString().Trim();
        Cls_VendorBillAmount.strType = ddlBillType.SelectedItem.Value.ToString().Trim();
        Cls_VendorBillAmount.strTempDt = mtempdt;
        Response.Redirect("Result.aspx");
    }
}
