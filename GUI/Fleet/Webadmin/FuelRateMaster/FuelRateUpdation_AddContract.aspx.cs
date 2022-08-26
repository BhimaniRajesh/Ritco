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

public partial class GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation_AddContract : System.Web.UI.Page
{
    string DataFound;
    static string str_Connection_String = "";
    public static string strToday;
    MyFunctions fn = new MyFunctions();
    bool success = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        strToday = System.DateTime.Today.ToString("dd/MM/yyyy");

        if (!IsPostBack)
        {
            fn.Fill_Vendor_Dataset_Fuel();
            txtConfirmRate.Attributes.Add("OnBlur", "javascript:return RateCheck(this)");

            btnAddContract.Attributes.Add("OnClick", "javascript:return CheckEmpty_AddContracts(this)");

            //txtToDate.Attributes.Add("OnBlur", "javascript:return CheckDate(this);");
        }
    }
    protected void btnAddContract_Click(object sender, EventArgs e)
    {
        string[] strDtFrom = txtFromDate.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtToDate.Text.Split('/');
        DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        string[] nameParts = txtVendor.Text.Split('~');
        string SplitVendorName = nameParts[0];
        string SplitVendorCode = nameParts[1];


        if (d1 > d2)
        {
            lblConfirm.Text = "From Date Can not be greater then To Date !!";
            return;
        }

        DateTime MaxFromDate = Convert.ToDateTime("01 JAN 2000"); DateTime MaxToDate = Convert.ToDateTime("01 JAN 2000");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string STR = "SELECT *  FROM Webx_Fuel_Vendor_Contract C1 CROSS APPLY(SELECT MinStartDate = MIN(C.DateFrom),MaxStartDate = MAX(C.DateTo) FROM Webx_Fuel_Vendor_Contract C WHERE IsApproved='Y' AND C.VendorCode=C1.VendorCode AND C.Product = C1.Product)C WHERE IsApproved='Y' AND VendorCode='" + SplitVendorCode + "' AND Product = '" + ddProduct.SelectedValue + "' AND '"+ d1 +"' BETWEEN C.MinStartDate AND C.MaxStartDate AND '"+ d2 +"' BETWEEN C.MinStartDate AND C.MaxStartDate";
        //string STR = "SELECT *  FROM Webx_Fuel_Vendor_Contract C1 CROSS APPLY(SELECT MinStartDate = MIN(C.DateFrom),MaxStartDate = MAX(C.DateTo) FROM Webx_Fuel_Vendor_Contract C WHERE  C.VendorCode=C1.VendorCode AND C.Product = C1.Product)C WHERE  VendorCode='" + SplitVendorCode + "' AND Product = '" + ddProduct.SelectedValue + "' AND '" + d1 + "' <= C1.DateFrom AND '" + d2 + "' BETWEEN C.MinStartDate AND C.MaxStartDate";
        string STR = "SELECT MaxFromDate = MAX(C.DateFrom),MaxToDate = MAX(C.DateTo),TotalCount =count(VendorCode)  FROM Webx_Fuel_Vendor_Contract C  WHERE  VendorCode='" + SplitVendorCode + "' AND Product = '" + ddProduct.SelectedValue + "' AND isactiveflag='Y' AND isnull(IsApproved,'N') = 'Y'";
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                if (Convert.ToInt32(dr["TotalCount"]) > 0)
                {
                    DataFound = "Y";
                    MaxFromDate = Convert.ToDateTime(dr["MaxFromDate"]);
                    MaxToDate = Convert.ToDateTime(dr["MaxToDate"]);
                }
            }
        }
        dr.Close();
        conn.Close();
        //if (DataFound == "Y")
        //{ 
        //    lblConfirm.Text = "Same Vendor cannot have duplicate contract"; 
        //}
        if (d1 <= MaxFromDate)
        {
            lblConfirm.Text = "Same Vendor cannot have duplicate contract";
        }
        else
        {

            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlTransaction trans1;
            conn1.Open();
            trans1 = conn1.BeginTransaction();
            try
            {

                SqlCommand cmd1 = new SqlCommand("usp_Insert_Fuel_Vendor_Contract", conn1, trans1);
                cmd1.CommandType = CommandType.StoredProcedure;

                cmd1.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = SplitVendorName.Trim();
                cmd1.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = SplitVendorCode.Trim();
                cmd1.Parameters.Add("@Product", SqlDbType.VarChar).Value = ddProduct.SelectedValue.Trim();
                cmd1.Parameters.Add("@DateFrom", SqlDbType.DateTime).Value = d1;
                cmd1.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = d2;
                cmd1.Parameters.Add("@Rate", SqlDbType.VarChar).Value = txtConfirmRate.Text.Trim();
                cmd1.ExecuteNonQuery();
                trans1.Commit();
                success = true;
                conn1.Close();
            }

            catch (Exception e1)
            {
                trans1.Rollback();
            }
            finally
            {

            }
            if (success == true)
            {
                Response.Redirect("FuelRateUpdation_AddContract_Result.aspx");
            }
        }

    }
}