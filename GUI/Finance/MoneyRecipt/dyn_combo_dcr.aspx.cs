using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Finance_MoneyRecipt_dyn_combo_dcr : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {

        string manualmrsno = Request.QueryString.Get("manualmrsno");
        string Lococde = Session["brcd"].ToString();
        
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader drchq;

        string sql = "exec usp_validate_Mrs_entry '" + manualmrsno + "','" + Session["brcd"].ToString() + "'";
        // Response.Write(sql);
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();
        string result = "",rst_string="OK";
        while (drchq.Read())
        {

            result = drchq.GetValue(0).ToString();
            if (result == "0")
            {
                rst_string = "Manual Mrs No is in Use or Not in Series or Invalid MRs No";

            }
            else 
            {
                rst_string = "OK";
            }
            
        }

        drchq.Close();
        Response.Write(rst_string);
        //Response.End();
    }
}
