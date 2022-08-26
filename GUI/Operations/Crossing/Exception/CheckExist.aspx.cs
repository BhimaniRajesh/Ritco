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

public partial class GUI_Operations_Crossing_Exception_CheckExist : System.Web.UI.Page
{
    string ChallanNo;
    string qry = "";
    string CrossingChallanNo, ChallanDate, ChallanLocCode, VendorName, TotalToPay, TotalCrossing, TotalDoorDelyChrg, TotalBulkyChrg, NetPayable;
    protected void Page_Load(object sender, EventArgs e)
    {
        ChallanNo = Request.QueryString["ChallanNo"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (Session["BRCD"].ToString() == "HQTR")
        {
            qry = "select CrossingChallanNo,Convert(Varchar,ChallanDate,06) as ChallanDate,ChallanLocCode,(VendorCode + ':' + VendorName) as VendorName,TotalToPay,TotalCrossing,TotalCrossing,TotalDoorDelyChrg,TotalBulkyChrg,NetPayable,PaymentFlag,Cancel from Webx_Crossing_Docket_Master where isNULL(Cancel,'N')='N' and isNULL(PaymentFlag,'N')='N' and CrossingChallanNo='" + ChallanNo + "'";
        }
        else
        {
            qry = "select CrossingChallanNo,Convert(Varchar,ChallanDate,06) as ChallanDate,ChallanLocCode,(VendorCode + ':' + VendorName) as VendorName,TotalToPay,TotalCrossing,TotalCrossing,TotalDoorDelyChrg,TotalBulkyChrg,NetPayable,PaymentFlag,Cancel from Webx_Crossing_Docket_Master where isNULL(Cancel,'N')='N' and isNULL(PaymentFlag,'N')='N' and ChallanLocCode = '" + Session["BRCD"].ToString() + "' and CrossingChallanNo='" + ChallanNo + "'";
        }

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            CrossingChallanNo = Convert.ToString(dr["CrossingChallanNo"]);
            ChallanDate = Convert.ToString(dr["ChallanDate"]);
            ChallanLocCode = Convert.ToString(dr["ChallanLocCode"]);
            VendorName = Convert.ToString(dr["VendorName"]);
            TotalToPay = Convert.ToString(dr["TotalToPay"]);
            TotalCrossing = Convert.ToString(dr["TotalCrossing"]);
            TotalDoorDelyChrg = Convert.ToString(dr["TotalDoorDelyChrg"]);
            TotalBulkyChrg = Convert.ToString(dr["TotalBulkyChrg"]);
            NetPayable = Convert.ToString(dr["NetPayable"]);
            i = 1;
            break;
        }
        dr.Close();

        Response.Clear();
        if (i == 0)
        {
            string qry1 = "select CrossingChallanNo,ChallanDate,ChallanLocCode,VendorCode + ':' + VendorName,TotalToPay,TotalCrossing,TotalCrossing,TotalDoorDelyChrg,TotalBulkyChrg,NetPayable,PaymentFlag,Cancel from Webx_Crossing_Docket_Master where CrossingChallanNo='" + ChallanNo + "'";
            SqlCommand cmd1 = new SqlCommand(qry1, con);
            SqlDataReader dr1;
            dr1 = cmd1.ExecuteReader();
            string message = "";
            if (dr1.Read())
            {
                if (Convert.ToString(dr1["PaymentFlag"]) == "Y")
                {
                    message = "Challan Payment Already Done";
                }
                else if (Convert.ToString(dr1["ChallanLocCode"]) != Session["BRCD"].ToString() && Session["BRCD"].ToString() != "HQTR")
                {
                    message = "Challan Can Cancel only from Challan branch or Head Office";
                }
                else if (Convert.ToString(dr1["Cancel"]) == "Y")
                {
                    message = "Challan Already Cancelled";
                }
                else
                {
                    message = "Challan is Not Valid";
                }

            }
            else
            {
                message = "Challan is Not Valid";
            }
            dr1.Close();

            Response.Write("false|" + message);
        }
        else if (i == 1)
        {
            Response.Write("true|" + ChallanDate + "|" + ChallanLocCode + "|" + VendorName + "|" + TotalToPay + "|" + TotalCrossing + "|" + TotalDoorDelyChrg + "|" + TotalBulkyChrg + "|" + NetPayable + "|");
        }
        con.Close();
    }
}
