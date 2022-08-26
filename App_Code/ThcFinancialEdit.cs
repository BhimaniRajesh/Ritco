using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for cls_Thc
/// </summary>
public class ThcFinancialEdit
{
    public ThcFinancialEdit()
    {

    }

    #region Variables

    public string ThcNo { get; set; }
    public string ThcBr { get; set; }
    public string ManualThcNo { get; set; }
    public string LoadOperType { get; set; }
    public decimal AdvanceAmount { get; set; }
    public string AdvancePaidBy { get; set; }
    public decimal ContractAmount { get; set; }
    public decimal TelephoneCharge { get; set; }
    public decimal MamulCharge { get; set; }
    public decimal LoadingCharge { get; set; }
    public string BalAmtBrcd { get; set; }
    public string AdvancePaid { get; set; }
    public string AdvanceAmount_LastPaid { get; set; }
    public decimal TdsRate { get; set; }
    public decimal TdsCharge { get; set; }
    public string PanNo { get; set; }
    public string TdsAccCode { get; set; }
    public string TdsAccDesc { get; set; }
    public string TdsGroupCode { get; set; }
    public string TdsGroupDesc { get; set; }
    public string TdsFor { get; set; }
    public decimal ServiceRate { get; set; }
    public decimal ServiceAmount { get; set; }
    public decimal CessAmount { get; set; }
    public decimal HEdu_Cess { get; set; }
    public decimal NetBalanceAmount { get; set; }
    public decimal AdvanceCash { get; set; }
    public decimal AdvanceCheque { get; set; }
    public decimal OtherAdvance { get; set; }
    public string ThcNew_Mode { get; set; }

    #endregion

    /// <summary>
    /// Used in THC Financial Edit Listing
    /// </summary>
    /// <param name="sFromDate"></param>
    /// <param name="sToDate"></param>
    /// <param name="sThcNos"></param>
    /// <param name="sManualThcNos"></param>
    /// <param name="sVehicleNos"></param>
    /// <param name="sFinyear"></param>
    /// <param name="sBranchCode"></param>
    /// <returns></returns>
    public DataSet GetThcForFinancialEdit(string sFromDate, string sToDate, string sThcNos, string sManualThcNos, string sVehicleNos, string sFinyear, string sBranchCode)
    {
        var dsResult = new DataSet();

        using (var dbTrans = new WebXHelper())
        {
            var param = new SqlParameter[7];
            param[0] = new SqlParameter("@FromDate", sFromDate);
            param[1] = new SqlParameter("@ToDate", sToDate);
            param[2] = new SqlParameter("@ThcNos", sThcNos);
            param[3] = new SqlParameter("@ManualThcNos", sManualThcNos);
            param[4] = new SqlParameter("@VehNos", sVehicleNos);
            param[5] = new SqlParameter("@FinYear", sFinyear);
            param[6] = new SqlParameter("@BranchCode", sBranchCode);

            dsResult = dbTrans.ExecuteDataSet(CommandType.StoredProcedure, "Usp_Get_Thc_Financial_MultipleAdvance", param);

        }
        return dsResult;
    }

    /// <summary>
    /// Used to Get THC Details for Financial Edit from THC No
    /// </summary>
    /// <param name="sThcNo">THC No</param>
    /// <returns></returns>
    public DataSet GetThcForFinancialEdit(string sThcNo)
    {
        var dsResult = new DataSet();
        using (var dbTrans = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@ThcNo", sThcNo);

            dsResult = dbTrans.ExecuteDataSet(CommandType.StoredProcedure,
                "Usp_Get_ThcWise_Financial_MultipleAdvanceDetail", param);


        }
        return dsResult;
    }

    /// <summary>
    /// Update THC Financial Details
    /// </summary>
    /// <param name="oThcFinEdit">THC Object</param>
    /// <returns>Voucher No</returns>
    public string UpdateThcFinDetails(ThcFinancialEdit oThcFinEdit)
    {
        var sVoucherNo = "";
        using (var oWh = new WebXHelper())
        {
            var xmlData = XmlUtility.XmlSerializeToString(oThcFinEdit);
            oWh.BeginTransaction();
            try
            {
                sVoucherNo = (string)oWh.ExecuteScalar(CommandType.StoredProcedure, "Usp_Thc_FinancialEdit_Update",
                    new[] { new SqlParameter("@XmlData", xmlData), 
                        new SqlParameter("@FinYear",SessionUtilities.FinYear), 
                        new SqlParameter("@EntryBy",SessionUtilities.CurrentEmployeeID) });
                oWh.CommitTransaction();
            }
            catch (Exception ex)
            {
                oWh.RollBackTransaction();
                ExceptionUtility.LogException(ex, "ThcFinancialEditMulti");
                throw ex;
            }
        }
        return sVoucherNo;
    }
}