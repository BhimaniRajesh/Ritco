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
        if (mode.CompareTo("01") == 0)
        {
            string MRNo = Request.QueryString["code"].ToString();
            DataTable vdtl = new DataTable();
            vdtl.Rows.Clear();

            string qry = "SELECT distinct top 1 MRSNO,convert(varchar,MRSDT,103) as MRSDT,cancelled=ISNULL(MR_CANCEL,'N') FROM WEBX_MR_HDR WITH(NOLOCK) WHERE (MRSNO='" + MRNo + "' OR MANUAL_DOCNO='" + MRNo + "') AND MRSTYPE='14' AND Company_Code = '" + SessionUtilities.DefaultCompanyCode.ToString() + "'";
            vdtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry).Tables[0];
            if (vdtl.Rows.Count > 0)
            {
                string CaseFlag = "N";
                if (vdtl.Rows[0]["cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|MR No Is Already Cancelled...|");
                    CaseFlag = "Y";
                }
                //if (vdtl.Rows[0]["POSTATUS"].ToString().CompareTo("GRN GENERATED") == 0 || vdtl.Rows[0]["GRNNO"].ToString().CompareTo("") != 0)
                //{
                //    Response.Write("false|GRN No Is Already Generated...|");
                //    CaseFlag = "Y";
                //}
                if (CaseFlag == "N")
                {
                    Response.Write("true|" + vdtl.Rows[0]["MRSDT"].ToString() + "|");
                }
            }
            else
            {
                Response.Write("false|InValid MR No....\n\n Or \n\nPlease Enter Valid MR Code|");   
            }
        }
        else if (mode.CompareTo("03") == 0)
        {
            string MRNo = Request.QueryString["code"].ToString();
            DataTable vdtl = new DataTable();
            vdtl.Rows.Clear();

            string qry = "SELECT distinct top 1 JOB_ORDER_NO,convert(varchar,JOB_ORDER_DT,103) as JobSheetDT,cancelled=ISNULL(Cancel_Status,'N') FROM WEBX_FLEET_PM_JOBORDER_HDR WITH(NOLOCK) WHERE JOB_ORDER_NO='" + MRNo + "' AND Company_Code = '" + SessionUtilities.DefaultCompanyCode.ToString() + "'";
            vdtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry).Tables[0];
            if (vdtl.Rows.Count > 0)
            {
                string CaseFlag = "N";
                if (vdtl.Rows[0]["cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|Job Sheet No Is Already Cancelled...|");
                    CaseFlag = "Y";
                }
                if (CaseFlag == "N")
                {
                    Response.Write("true|" + vdtl.Rows[0]["JobSheetDT"].ToString() + "|");
                }
            }
            else
            {
                Response.Write("false|InValid Job Sheet No....\n\n Or \n\nPlease Enter Valid Job Sheet Code|");
            }
        }
        else
        {
            Response.Write("true|");
        }
        con.Close();
    }
}
