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

public partial class SFM_SaleTargetView : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string strSaleTargetCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        strSaleTargetCode = Request.QueryString.Get("strSaleTargetCode");
        string[] Split = strSaleTargetCode.Split(new Char[] { ',' });
        strSaleTargetCode = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);

        string sql = ("select SaleTagetId,ProspectStatus,convert(varchar,SaleTargetDt,106) as Dt,TotalMonthValue,TotalQuaterValue,TotalYearValue,* from WEBX_SalesTarget where SaleTagetId='" + strSaleTargetCode + "'");

        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();
        try
        {
            if (dr.Read())
            {
                string SaleTargetCode = dr["SaleTagetId"].ToString().Trim();
                string ProspectStatus = dr["ProspectStatus"].ToString().Trim();
                string SaleTargetDt = dr["Dt"].ToString().Trim();
                
                if(!(dr["TotalMonthValue"] is DBNull))
                {
                 string TotalMonth = dr["TotalMonthValue"].ToString().Trim();
                    lblPeriod.Text = "Monthly";
                    lblTotal.Text = TotalMonth;
                }
                if (!(dr["TotalQuaterValue"] is DBNull))
                {
                    string TotalQuater = dr["TotalQuaterValue"].ToString().Trim();
                    lblPeriod.Text = "Quaterly";
                    lblTotal.Text = TotalQuater;
                }
                if (!(dr["TotalYearValue"] is DBNull))
                {
                    string TotalYear = dr["TotalYearValue"].ToString().Trim();
                    lblPeriod.Text = "Yearly";
                    lblTotal.Text = TotalYear;
                }

                lblDate.Text = SaleTargetDt;
                lblStatus.Text = ProspectStatus;
                
            }
            else
            {

            }
        }
        finally
        {
            conn.Close();
        }
    }
}
