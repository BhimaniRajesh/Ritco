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


public partial class GUI_Octroi_New_CheckExist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string result = "";
        string DelVal = "";
        string OctAmt = "0";
        string ReceiptNo = "";
        string ReceiptDt = "";

        string PartyCode = Request.QueryString["PartyCode"].ToString();
        string DocketNo = Request.QueryString["DocketNo"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader dr;

        string sql = "exec usp_Docket_Details '" + DocketNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        Int16 cnt = 0;

        string docket_mode = "", Mrsno = "", Billno = "";
        string paybas = "", Party_code = "", DocketDate="";
        string octroibill = "";
        string octroimr = "";
        string octroi = "";
        Boolean flag = false;

        if(dr.Read())
        {
            flag = true;
           
                docket_mode = dr["docket_mode"].ToString();
                paybas = dr["paybas"].ToString();
                octroibill = dr["octroibill"].ToString();
                octroimr = dr["octroimr"].ToString();
                Mrsno = dr["Mrsno"].ToString();
                Billno = dr["Billno"].ToString();
                Party_code= dr["Party_code"].ToString();
                DocketDate = dr["DocketDate"].ToString();
       }

        dr.Close();

        if (!flag)
        {
            result = "false";
        }
        else if (docket_mode == "" || docket_mode != "F")
        {
            result = "Entered docket not fincialy completed !!";
        }
        else if (Party_code != PartyCode)
        {
            result = "Invalid Docket No For This Customer !!";
        }
        else if (docket_mode == "" || docket_mode != "F")
        {
            result = "Entered docket not fincialy completed !!";
        }
        else if (octroibill == "Y")
        {
            result = "Octroi Bill Already Generated - BillNo : -" + Billno;
        }
        else if (octroimr == "Y")
        {

            result = "Octroi MR Already Generated - MRsNo : -" + Mrsno;
        }

        else if (paybas != "P02" && paybas != "P08")
        {
            if (paybas != "P09")
                result = "Please Enter TBB/Nationa/BOD dockets";
        }
        else
        {
            result = "true";
            string sql2 = "select sum(A.declval)as Declval,isnull(octamt,0) as octamt,isnull(recptno,'') as recptno,";
            sql2 += "isnull(convert(varchar,recptdt,103),'') as recptdt ";
            sql2 += "from WebX_Master_Docket_Invoice A With(NOLOCK) left outer join webx_OCT_DET B With(NOLOCK) on A.Dockno=B.dockno";
            sql2 += " where A.dockno='" + DocketNo + "' group by octamt,recptno,recptdt";

            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            SqlDataReader dr2;
            dr2 = cmd2.ExecuteReader();
            dr2.Read();

            if (dr2.HasRows == false)
            {
                DelVal = "";
                OctAmt = "0.00";
                ReceiptNo = "";
                ReceiptDt = "";
            }
            else
            {
                DelVal = dr2["Declval"].ToString();
                OctAmt = dr2["octamt"].ToString();
                ReceiptNo = dr2["recptno"].ToString();
                ReceiptDt = dr2["recptdt"].ToString();
                if (OctAmt == "0")
                    OctAmt = "0.00";
            }
        }
        Response.Write(result + "|" + DelVal + "|" + OctAmt + "|" + ReceiptNo + "|" + ReceiptDt + "|" + DocketDate);
    }
}
