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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    public static string Financial_Year = "", fin_year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("date") == 0)
        {
            string POno = Request.QueryString["code"].ToString();
            string yearsuffix = "";

            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

            DataTable vdtl = new DataTable();
            vdtl.Rows.Clear();

            string qry = "SELECT distinct top 1 H.pocode,convert(varchar,podate,103) as podate,cancelled=ISNULL(cancelled,'N'),POSTATUS,GRNNO=ISNULL(G.GRNNO,'') FROM webx_GENERAL_POASSET_HDR H WITH(NOLOCK) LEFT OUTER JOIN WEBX_GRN_DET G WITH(NOLOCK) ON G.POCode=H.pocode WHERE (H.pocode='" + POno + "' OR Manual_PO_No='" + POno + "') AND isnull(cancelled,'N')='N' and Company_Code = '" + SessionUtilities.DefaultCompanyCode.ToString() + "'";
            vdtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry).Tables[0];
            if (vdtl.Rows.Count > 0)
            {
                string CaseFlag = "N";
                if (vdtl.Rows[0]["cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|PO No Is Already Cancelled...|");
                    CaseFlag = "Y";
                }
                if (vdtl.Rows[0]["POSTATUS"].ToString().CompareTo("GRN GENERATED") == 0 || vdtl.Rows[0]["GRNNO"].ToString().CompareTo("") != 0)
                {
                    Response.Write("false|GRN No Is Already Generated...|");
                    CaseFlag = "Y";
                }
                if (CaseFlag == "N")
                {
                    Response.Write("true|" + vdtl.Rows[0]["podate"].ToString() + "|");
                }
            }
            else
            {
                Response.Write("false|InValid PO No....\n\n Or \n\nPlease Enter Valid PO Code|");   
            }
        }
        con.Close();
    }
}
