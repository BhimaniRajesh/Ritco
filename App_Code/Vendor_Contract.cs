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
using WebX.Controllers;
using WebX.Entity;

/// <summary>
/// Summary description for Vendor_Contract
/// </summary>
public class Vendor_Contract
{
	public Vendor_Contract()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void Fill_VendorContract_Selection(DropDownList DDL, string SelectionType)
    {
        string Sql = "Exec [sp_Get_VendorContract_Selection] '" + SelectionType + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        DDL.Items.Clear();
        DDL.Items.Add(new ListItem("Select", ""));
        while (DR.Read())
        {
            DDL.Items.Add(new ListItem(DR[1].ToString(), DR[0].ToString()));
        }
        DR.Close();
    }
    public static string Get_VendorContract_Selection_Array(string SelectionType)
    {
        string Sql = "Exec [sp_Get_VendorContract_Selection] '" + SelectionType + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        string VendorContract_Selection = "";
        while (DR.Read())
        {
            if (VendorContract_Selection == "")
            {
                VendorContract_Selection = DR[0].ToString() + "@/" + DR[1].ToString() + "@/" + DR[2].ToString() + "@/" + DR[3].ToString() + "@/" + DR[4].ToString();
            }
            else
            {
                VendorContract_Selection = VendorContract_Selection + "~/" + DR[0].ToString() + "@/" + DR[1].ToString() + "@/" + DR[2].ToString() + "@/" + DR[3].ToString() + "@/" + DR[4].ToString();
            }
        }
        DR.Close();
        return VendorContract_Selection;
    }
    public static string Get_VendorContract_Mst_Selection_Array(string SelectionType)
    {
        string Sql = "Exec [sp_Get_VendorContract_Selection] '" + SelectionType + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        string VendorContract_Selection = "";
        while (DR.Read())
        {
            if (VendorContract_Selection == "")
            {
                VendorContract_Selection = DR[0].ToString() + "@/" + DR[1].ToString();
            }
            else
            {
                VendorContract_Selection = VendorContract_Selection + "~/" + DR[0].ToString() + "@/" + DR[1].ToString();
            }
        }
        DR.Close();
        return VendorContract_Selection;
    }
    public static void Fill_DDL_Mst_Selection_From_Array(string Selection_Str, DropDownList DLL_Mst)
    {
        string[] Mst_Array = Selection_Str.Split(new string[] { "~/" }, StringSplitOptions.None);
        string[] DLL_Txt_Val_Array = null;
        DLL_Mst.Items.Clear();
        DLL_Mst.Items.Add(new ListItem("Select", ""));
        for (int i = 0; i < Mst_Array.Length; i++)
        {
            DLL_Txt_Val_Array = Mst_Array[i].Split(new string[] { "@/" }, StringSplitOptions.None);
            DLL_Mst.Items.Add(new ListItem(DLL_Txt_Val_Array[1].ToString(), DLL_Txt_Val_Array[0].ToString()));
        }
    }
    public static DataTable GetVendors()
    {
        return GetFromDB("VENDOR");
    }
    public static DataTable GetTransMode()
    {
        return GetFromDB("TRN");
    }
    public static DataTable GetFTLType()
    {
        return GetFromDB("FTLTYP");
    }
    public static DataTable GetRoute()
    {
        return GetFromDB("RUT");
    }
    public static DataTable GetRouteMode()
    {
        return GetFromDB("RUTMODE");
    }
    public static DataTable GetVehicleNumbers()
    {
        return GetFromDB("VEH");
    }
    public static DataTable GetVehicleType()
    {
        return GetFromDB("VEHTYP");
    }
    private static DataTable GetFromDB(string type)
    {
        DataTable dt = new DataTable();
        string Sql = "Exec [sp_Get_VendorContract_Selection] '" + type + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }
        return dt;
    }


    public static void Add_DynamicGridRow(GridView GV_Matrix,int Tot_Rows)
    {
        DataTable dt = new DataTable("table1");
        for (int i = 0; i < Tot_Rows; i++)
        {
            dt.Rows.Add();
        }
        GV_Matrix.DataSource = dt;
        GV_Matrix.DataBind();
    }

    public static string GetActiveContractType(string VendorCode)
    {
        //VendorContractSummary VCS = VendorContractSummaryController.GetByVendorCode(VendorCode);
        //if (VCS.CONTRACTCD != "")
        //    return VCS.MetrixType;
        //else
        //    return "0";

        return GetActiveContractDetail(VendorCode, "CONTRACTCD");
    }
    public static string GetActiveContractTypeDesc(string VendorCode)
    {
        return GetActiveContractDetail(VendorCode, "CONTRACTTYPEDESC");
    }
    public static string GetActiveContractID(string VendorCode)
    {
        return GetActiveContractDetail(VendorCode, "CONTRACTTYPEID");
    }

    private static string GetActiveContractDetail(string VendorCode, string param)
    {
        string strRet = "";

        DataTable DT = GetActiveContractDetail(VendorCode);
        if (DT.Rows.Count > 0)
        {
            DataRow dr = DT.Rows[0];
            //ContractTypeID, ContractId, ContractTypeDesc
            if (param.ToUpper() == "CONTRACTCD")
                strRet = dr["ContractId"].ToString();
            else if (param.ToUpper() == "CONTRACTTYPEID")
                strRet = dr["ContractTypeID"].ToString();
            else if (param.ToUpper() == "CONTRACTTYPEDESC")
                strRet = dr["ContractTypeDesc"].ToString();
        }

        if (param.ToUpper() == "CONTRACTCD" && (strRet == "" || strRet == "NA"))
            strRet = "";
        else if (param.ToUpper() == "CONTRACTTYPEID" && (strRet == "" || strRet == "NA"))
            strRet = "0";
        else if (param.ToUpper() == "CONTRACTTYPEDESC" && (strRet == "" || strRet == "NA"))
            strRet = "None";

        return strRet;
    }

    public static DataTable GetActiveContractDetail(string VendorCode)
    {
        DataTable dtRet = new DataTable();
        string strQ = "exec Usp_GetVendorContractDetail '" + VendorCode + "','',''";
        DataSet DS = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        if (DS.Tables.Count > 0)
        {
            dtRet = DS.Tables[0];
        }
        return dtRet;
    }
}
