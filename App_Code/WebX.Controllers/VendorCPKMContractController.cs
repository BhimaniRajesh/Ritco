using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for VendorCPKMContractController
/// </summary>
public class VendorCPKMContractController : Base
{
    public VendorCPKMContractController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable AddEditVendorContract(List<cls_VehicleCPKM> oList)
    {
        return ExecuteDataSet("Usp_VendorContractGeneration", new SqlParameter[] { new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oList)) }, true).Tables[0];
    }

    public DataTable GetVenodrContractDetail(string VendorCode, string ContractID)
    {
        return (DataTable)ExecuteDataTable("USP_CPKM_VendorContract_Detail", new SqlParameter[] { new SqlParameter("@VendorCode", VendorCode), 
                                                                                              new SqlParameter("@ContractID", ContractID)});
    }
}