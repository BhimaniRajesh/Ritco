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
using Microsoft.ApplicationBlocks.Data;

/// <summary>
/// Summary description for VendorPayment_Utility
/// </summary>
public class VendorPayment_Utility
{
	public VendorPayment_Utility()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void BindGrid(GridView GridDocList, string Trn_CalledAs, string Trn_Typ, string Fromdate, string Todate, string Vendorcode, string DOCNO_Str, string ManualNo_Str, string brcd, string Trn_Doc_Typ, string ContractSubType, string ContractSubType_Value)
    {
        string Sql = "EXEC WEBX_Vendor_Payment_Listing '" + Trn_CalledAs + "','" + Trn_Typ + "','" + Fromdate + "','" + Todate + "','" + Vendorcode + "','" + DOCNO_Str + "','" + ManualNo_Str + "','','" + brcd + "','" + Trn_Doc_Typ + "','" + ContractSubType + "','" + ContractSubType_Value + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
    public static void BillEntryBindGrid(GridView GridDocList,string Fromdate, string Todate, string Vendorcode, string Billno, string VendorBillno)
    {
        string Sql = "EXEC usp_Bill_Listing '" + Billno + "','" + Vendorcode + "','" + Fromdate + "','" + Todate + "','" + SessionUtilities.CurrentBranchCode + "','" + VendorBillno + "','THC-PDC'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
    public static void BillEntryBindGrid_DDMR(GridView GridDocList, string Fromdate, string Todate, string Vendorcode, string Billno, string VendorBillno, string BillType)
    {
        string Sql = "EXEC usp_Bill_Listing_DDMR '" + Billno + "','" + Vendorcode + "','" + Fromdate + "','" + Todate + "','" + SessionUtilities.CurrentBranchCode + "','" + VendorBillno + "','" + BillType + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
    public static string  Duplicate_ChqNO(string Chqno, string ChqDate)    
    {
        string Cnt = "";
        string Sql = "EXEC WEBX_Chq_Duplicate_Check '" + Chqno + "','" + ChqDate + "'";
        //DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj !=null)
            Cnt = Obj.ToString();
        return Cnt;
    }
    public static string GetThcPartyCode(string ThcNo)
    {
        string PartyCode = "";
        string Sql = "EXEC WEBX_Thc_GetThcPartyCode '" + ThcNo + "'";
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj != null)
            PartyCode = Obj.ToString();
        return PartyCode;
    }
    public static string DR_VR_Trn_Halt(double Netamt, string Trn_date)
    {
        string Flag = "";
        string FIN_Start = "", Financial_Year = "", fin_year = "", Curr_Year = "", Finyear = "";
        Financial_Year = SessionUtilities.FinYear.ToString().Substring(2, 2);
        fin_year = SessionUtilities.FinYear.ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Curr_Year = DateTime.Now.ToString("yyyy");
        Finyear = SessionUtilities.FinYear.ToString();
        if (Finyear == Curr_Year)
            FIN_Start = "01 Apr " + Curr_Year.Substring(2, 2);
        else
            FIN_Start = "01 Apr " + Financial_Year;
        string Sql = "exec WEBX_DR_VR_Trn_Halt '" + SessionUtilities.CurrentBranchCode + "','" + Trn_date + "','" + FIN_Start + "','" + fin_year + "','" + Netamt + "'";
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj != null)
            Flag = Obj.ToString();
        return Flag;
    }
    public static string DR_VR_Trn_Halt(double Netamt, string Trn_date, string BankAcccode)
    {
        string Flag = "";
        string FIN_Start = "", Financial_Year = "", fin_year = "", Curr_Year = "", Finyear = "";
        Financial_Year = SessionUtilities.FinYear.ToString().Substring(2, 2);
        fin_year = SessionUtilities.FinYear.ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Curr_Year = DateTime.Now.ToString("yyyy");
        Finyear = SessionUtilities.FinYear.ToString();
        if (Finyear == Curr_Year)
            FIN_Start = "01 Apr " + Curr_Year.Substring(2, 2);
        else
            FIN_Start = "01 Apr " + Financial_Year;
        string Sql = "exec WEBX_DR_VR_BANK_Trn_Halt '" + SessionUtilities.CurrentBranchCode + "','" + Trn_date + "','" + FIN_Start + "','" + fin_year + "','" + Netamt + "','" + BankAcccode + "'";
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj != null)
            Flag = Obj.ToString();
        return Flag;
    }
    public static string Get_From_To_Date(string DateType,string FROM_Date, string TO_Date,RadioButtonList RD)
    {
        string DateSelection = "", ReturnVal = "";
        if ((RD.Items[0].Selected))
            DateSelection = "Date";
        if ((RD.Items[1].Selected))
            DateSelection = "Week";
        if ((RD.Items[2].Selected))
            DateSelection = "Today";

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateSelection == "Date")
        {
            strrightnow = FROM_Date.ToString();
            strrightnow1 = TO_Date.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (DateSelection == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateSelection == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateSelection == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
            strrightnow = righnow.ToString("dd/MM/yyyy");

        if (strrightnow1 == "")
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');


        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        if (DateType == "F")
            ReturnVal = dtFrom;
        else
            ReturnVal = dtTo;
        return ReturnVal;
    }
    public static string Get_DocTypeList(CheckBoxList Chk_DocType)
    {
        string Trn_Doc_Typ="";
        if (Chk_DocType.Items[0].Selected)
            Trn_Doc_Typ = "T";
        if (Chk_DocType.Items[1].Selected)
        {
            if (Trn_Doc_Typ == "")
                Trn_Doc_Typ = "P";    
            else
                Trn_Doc_Typ = Trn_Doc_Typ + "," + "P";
        }
        if (Chk_DocType.Items[2].Selected)
        {
            if (Trn_Doc_Typ == "")
                Trn_Doc_Typ = "D";
            else
                Trn_Doc_Typ = Trn_Doc_Typ + "," + "D";
        }
        return Trn_Doc_Typ;
    }
    public static string Insert_Advance_Balance_BillEntry_Data(string Xml_PAY_Det, string EntryType)
    {
        string Voucherno = "";
        string Sql = "";
        if (EntryType == "ADV")
            Sql="EXEC [Usp_Doc_Advance_Payment] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        else if (EntryType == "BAL")
            Sql="EXEC [Usp_Doc_Balance_Payment] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        else if (EntryType == "BE")
            Sql = "EXEC [Usp_Doc_BillEntry] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        else if (EntryType == "BAL_KM")
            Sql = "EXEC [Usp_Doc_Balance_Payment_KM_Based] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        else if (EntryType == "BE_KM")
            Sql = "EXEC  [Usp_Doc_BillEntry_KM_Based]  '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";

        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (DR.Read())
        {
            Voucherno = DR[0].ToString() + "~" + DR[1].ToString();
        }
        DR.Close();
        return Voucherno;
    }
    public static string Insert_BillEntry_Payment_Data(string Xml_PAY_MST, string Xml_PAY_Det, string EntryType)
    {
            string Voucherno = "";
            string Sql = "";
            Sql = "EXEC [Usp_BillEntry_Payment] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + Xml_PAY_MST + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (DR.Read())
            {
                Voucherno = DR[0].ToString() + "~" + DR[1].ToString();
            }
            DR.Close();
            return Voucherno;
    }
    public static void Fill_TdsPayable(DropDownList DDL_TdsPayable)
    {
        string Sql = "select Acccode,Accdesc+':'+company_acccode from vw_tds_payable WIth(NOLOCK) ";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        DDL_TdsPayable.Items.Clear();
        DDL_TdsPayable.Items.Add(new ListItem("Select", ""));
        while (DR.Read())
        {
            DDL_TdsPayable.Items.Add(new ListItem(DR.GetValue(1).ToString(), DR.GetValue(0).ToString()));
        }
        DR.Close();
    }
    public static void VoucherView(GridView GridDocList, string Voucherno, string VoucherType)
    {
        string Sql = "EXEC [Usp_View_PaymentVoucher] '" + VoucherType + "','" + Voucherno + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
    public static string  VoucherView_PaymentDetails(string Voucherno, string VoucherType)
    {
        string Paymentdetails = "";
        string Sql = "EXEC [Usp_View_PaymentVoucher_PaymentDetails] '" + VoucherType + "','" + Voucherno + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        
        while (DR.Read())
        {
                for (int i = 0; i < 22; i++)
                {
                    if (Paymentdetails == "")
                        Paymentdetails = DR.GetValue(i).ToString();
                    else
                        Paymentdetails = Paymentdetails + "~" + DR.GetValue(i).ToString();
                }
        }
        DR.Close();
        return Paymentdetails;
    }

    public static string View_BillDetails(string Voucherno, string VoucherType)
    {
        string Billdetails = "";
        string Sql = "EXEC [Usp_View_VendorBill] '" + VoucherType + "','" + Voucherno + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);

        if (VoucherType == "BE" || VoucherType == "BE_KM")
        {
            while (DR.Read())
            {
                for (int i = 0; i < 12; i++)
                {
                    if (Billdetails == "")
                        Billdetails = DR.GetValue(i).ToString();
                    else
                        Billdetails = Billdetails + "~" + DR.GetValue(i).ToString();
                }
            }
        }
        else if (VoucherType == "BAL_KM")
        {
            while (DR.Read())
            {
                for (int i = 0; i < 4; i++)
                {
                    if (Billdetails == "")
                        Billdetails = DR.GetValue(i).ToString();
                    else
                        Billdetails = Billdetails + "~" + DR.GetValue(i).ToString();
                }
            }
        }

        return Billdetails;
    }
    public static string GetCotractType(string VendorCode)
    {
        string ContractType = "";
        string Sql = "EXEC [Usp_GetVendorContractDetail] '" + VendorCode + "','','' ";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);

        if(DR.Read())
            ContractType = DR.GetValue(0).ToString() + "~" + DR.GetValue(1).ToString() + "~" + DR.GetValue(2).ToString();
        return ContractType;
    }
    public static string Get_VendorContract_Mst_Selection_Array(string VendorCode,string ContractID,string ContractType)
    {
        string Sql = "Exec [Usp_GetVendorContractDetail] '" + VendorCode + "','" + ContractID + "','" + ContractType + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        string VendorContract_Selection = "";
        while (DR.Read())
        {
            if (VendorContract_Selection == "")
                VendorContract_Selection = DR[0].ToString() + "@/" + DR[1].ToString();
            else
                VendorContract_Selection = VendorContract_Selection + "~/" + DR[0].ToString() + "@/" + DR[1].ToString();
        }
        DR.Close();
        return VendorContract_Selection;
    }
    public static void Fill_DDL_Mst_Selection_From_Array(string Selection_Str, DropDownList DLL_Mst)
    {
        if (Selection_Str != "")
        {
            string[] Mst_Array = Selection_Str.Split(new string[] { "~/" }, StringSplitOptions.None);
            string[] DLL_Txt_Val_Array = null;
            DLL_Mst.Items.Clear();
            if (Mst_Array.Length != 1)
                DLL_Mst.Items.Add(new ListItem("Select", ""));
            if (Mst_Array.Length > 0)
            {
                for (int i = 0; i < Mst_Array.Length; i++)
                {
                    DLL_Txt_Val_Array = Mst_Array[i].Split(new string[] { "@/" }, StringSplitOptions.None);
                    DLL_Mst.Items.Add(new ListItem(DLL_Txt_Val_Array[1].ToString(), DLL_Txt_Val_Array[0].ToString()));
                }
            }
        }
    }
    public static string  Get_KM_Based_ContractAmt(string VendorCode,string ContractID,string ContractType,string ContractType_Value,double Total_Travel_KM)
    {
        string Sql = "Exec [Usp_GetVendorContract_Amount_Detail] '" + VendorCode + "','" + ContractID + "','" + ContractType + "','" + ContractType_Value + "','" + Total_Travel_KM + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        string ContractAmount = "";
        if(DR.Read())
                ContractAmount = DR[0].ToString();
        DR.Close();
        return ContractAmount;
    }

    //public static void BindGrid(GridView GridDocList, string SqlQuery)
    //{
    //    //Sql = "EXEC WEBX_Vendor_Payment_Listing '" + Trn_CalledAs + "','" + Trn_Typ + "','" + Fromdate + "','" + Todate + "','" + Vendorcode + "','" + DOCNO_Str + "','" + ManualNo_Str + "','','" + brcd + "','" + Trn_Doc_Typ + "'";
    //    DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SqlQuery);
    //    GridDocList.DataSource = ds;
    //    GridDocList.DataBind();
    //}
}
