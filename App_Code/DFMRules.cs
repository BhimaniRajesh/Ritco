using System;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

/// <summary>
/// Summary description for DFMRules
/// </summary>
[Serializable]
public class DFMRules
{
    #region Private Members
    private string _CodeID = "";
    private string _Description = "";
    private string _DefaultValue = "";
    private string _EntryBy = "";
    private DateTime _EntryDate = DateTime.MinValue;
    private string _UpdateBy = "";
    private DateTime _UpdateDate = DateTime.MinValue;
    private List<DFMRules_Details> _Details = new List<DFMRules_Details>();
    #endregion

    #region Public Properties
    public string CodeID { get { return _CodeID; } set { _CodeID = value; } }
    public string Description { get { return _Description; } set { _Description = value; } }
    public string DefaultValue { get { return _DefaultValue; } set { _DefaultValue = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
    public string UpdateBy { get { return _UpdateBy; } set { _UpdateBy = value; } }
    public DateTime UpdateDate { get { return _UpdateDate; } set { _UpdateDate = value; } }
    public List<DFMRules_Details> Details { get { return _Details; } set { _Details = value; } }
    #endregion

    #region Constructer
    public DFMRules()
	{
		//
		// TODO: Add constructor logic here
		//
    }
    #endregion

    #region Public Methods
    public static DFMRules FillObject(DataRow dr)
    {
        DFMRules objDR = new DFMRules();

        if (dr[(int)DFMRules_Columns.CodeID] != DBNull.Value)
            objDR.CodeID = dr[(int)DFMRules_Columns.CodeID].ToString();
        if (dr[(int)DFMRules_Columns.Description] != DBNull.Value)
            objDR.Description = dr[(int)DFMRules_Columns.Description].ToString();
        if (dr[(int)DFMRules_Columns.DefaultValue] != DBNull.Value)
            objDR.DefaultValue = dr[(int)DFMRules_Columns.DefaultValue].ToString();
        if (dr[(int)DFMRules_Columns.EntryBy] != DBNull.Value)
            objDR.EntryBy = dr[(int)DFMRules_Columns.EntryBy].ToString();
        if (dr[(int)DFMRules_Columns.EntryDate] != DBNull.Value)
            objDR.EntryDate = Convert.ToDateTime(dr[(int)DFMRules_Columns.EntryDate]);
        if (dr[(int)DFMRules_Columns.UpdateBy] != DBNull.Value)
            objDR.UpdateBy = dr[(int)DFMRules_Columns.UpdateBy].ToString();
        if (dr[(int)DFMRules_Columns.UpdateDate] != DBNull.Value)
            objDR.UpdateDate = Convert.ToDateTime(dr[(int)DFMRules_Columns.UpdateDate]);

        return objDR;
    }
    public static DFMRules GetByCodeID(string codeId)
    {
        DFMRules objDR = new DFMRules();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@CodeID", SqlDbType.VarChar);
            paramsToStore[0].Value = codeId;
            paramsToStore[0].Size = 25;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_GetByCodeID", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    objDR = FillObject(ds.Tables[0].Rows[0]);
                    objDR.Details = DFMRules_Details.GetByRuleID(codeId);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return objDR;
    }
    public static List<DFMRules> GetList()
    {
        List<DFMRules> listDR = new List<DFMRules>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[0];

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Get_List", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DFMRules objDR = FillObject(dr);
                    if (objDR.CodeID != "")
                    {
                        objDR.Details = DFMRules_Details.GetByRuleID(objDR.CodeID);
                        listDR.Add(objDR);
                    }
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDR;
    }
    public static List<DFMRules> Find(DFMRules objDFR, bool usingOR)
    {
        List<DFMRules> listDR = new List<DFMRules>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[8];

            paramsToStore[0] = new SqlParameter("@SearchUsingOR", SqlDbType.Bit);
            paramsToStore[0].Value = usingOR;
            paramsToStore[1] = new SqlParameter("@CodeID", SqlDbType.VarChar);
            if (objDFR.CodeID.Trim() != "")
                paramsToStore[1].Value = objDFR.CodeID;
            else
                paramsToStore[1].Value = DBNull.Value;            
            paramsToStore[2] = new SqlParameter("@Description", SqlDbType.VarChar);
            if (objDFR.Description.Trim() != "")
                paramsToStore[2].Value = objDFR.Description;
            else
                paramsToStore[2].Value = DBNull.Value;
            
            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFR.DefaultValue.Trim() != "")
                paramsToStore[3].Value = objDFR.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;
            
            paramsToStore[4] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFR.EntryBy.Trim() != "")
                paramsToStore[4].Value = objDFR.EntryBy;
            else
                paramsToStore[4].Value = DBNull.Value;
            
            paramsToStore[5] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFR.EntryDate > DateTime.MinValue && objDFR.EntryDate < DateTime.MaxValue)
                paramsToStore[5].Value = objDFR.EntryDate;
            else
                paramsToStore[5].Value = DBNull.Value;

            paramsToStore[6] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFR.UpdateBy.Trim() != "")
                paramsToStore[6].Value = objDFR.UpdateBy;
            else
                paramsToStore[6].Value = DBNull.Value;
            
            paramsToStore[7] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFR.UpdateDate > DateTime.MinValue && objDFR.UpdateDate < DateTime.MaxValue)
                paramsToStore[7].Value = objDFR.UpdateDate;
            else
                paramsToStore[7].Value = DBNull.Value;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 200;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 25;
            paramsToStore[6].Size = 25;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Find", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DFMRules objDR = FillObject(ds.Tables[0].Rows[0]);
                    if (objDR.CodeID != "")
                    {
                        objDR.Details = DFMRules_Details.GetByRuleID(objDR.CodeID);
                        listDR.Add(objDR);
                    }
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDR;
    }
    public static bool Insert(DFMRules objDFR)
    {
        bool bChk = false;
        SqlConnection conn = new SqlConnection(GetConnectionString());
        conn.Open();
        SqlTransaction tr = conn.BeginTransaction();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[7];

            paramsToStore[0] = new SqlParameter("@CodeID", SqlDbType.VarChar);
            if (objDFR.CodeID.Trim() != "")
                paramsToStore[0].Value = objDFR.CodeID;
            else
                paramsToStore[0].Value = DBNull.Value;
            paramsToStore[1] = new SqlParameter("@Description", SqlDbType.VarChar);
            if (objDFR.Description.Trim() != "")
                paramsToStore[1].Value = objDFR.Description;
            else
                paramsToStore[1].Value = DBNull.Value;

            paramsToStore[2] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFR.DefaultValue.Trim() != "")
                paramsToStore[2].Value = objDFR.DefaultValue;
            else
                paramsToStore[2].Value = DBNull.Value;

            paramsToStore[3] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFR.EntryBy.Trim() != "")
                paramsToStore[3].Value = objDFR.EntryBy;
            else
                paramsToStore[3].Value = DBNull.Value;

            paramsToStore[4] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFR.EntryDate > DateTime.MinValue && objDFR.EntryDate < DateTime.MaxValue)
                paramsToStore[4].Value = objDFR.EntryDate;
            else
                paramsToStore[4].Value = DBNull.Value;

            paramsToStore[5] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFR.UpdateBy.Trim() != "")
                paramsToStore[5].Value = objDFR.UpdateBy;
            else
                paramsToStore[5].Value = DBNull.Value;

            paramsToStore[6] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFR.UpdateDate > DateTime.MinValue && objDFR.UpdateDate < DateTime.MaxValue)
                paramsToStore[6].Value = objDFR.UpdateDate;
            else
                paramsToStore[6].Value = DBNull.Value;

            paramsToStore[0].Size = 25;
            paramsToStore[1].Size = 200;
            paramsToStore[2].Size = 50;
            paramsToStore[3].Size = 25;
            paramsToStore[6].Size = 25;

            SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Insert", paramsToStore);
            foreach (DFMRules_Details drd in objDFR.Details)
            {
                DFMRules_Details.Insert(drd, tr);
            }
            bChk = true;
            tr.Commit();
        }
        catch (Exception excp)
        {
            tr.Rollback();
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return bChk;
    }
    public static bool Update(DFMRules objDFR)
    {
        bool bChk = false;
        SqlConnection conn = new SqlConnection(GetConnectionString());
        conn.Open();
        SqlTransaction tr = conn.BeginTransaction();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[8];

            paramsToStore[0] = new SqlParameter("@CodeID", SqlDbType.VarChar);
            paramsToStore[0].Value = objDFR.CodeID;
            paramsToStore[1] = new SqlParameter("@OriginalCodeID", SqlDbType.VarChar);
            if (objDFR.CodeID.Trim() != "")
                paramsToStore[1].Value = objDFR.CodeID;
            else
                paramsToStore[1].Value = DBNull.Value;
            paramsToStore[2] = new SqlParameter("@Description", SqlDbType.VarChar);
            if (objDFR.Description.Trim() != "")
                paramsToStore[2].Value = objDFR.Description;
            else
                paramsToStore[2].Value = DBNull.Value;

            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFR.DefaultValue.Trim() != "")
                paramsToStore[3].Value = objDFR.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;

            paramsToStore[4] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFR.EntryBy.Trim() != "")
                paramsToStore[4].Value = objDFR.EntryBy;
            else
                paramsToStore[4].Value = DBNull.Value;

            paramsToStore[5] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFR.EntryDate > DateTime.MinValue && objDFR.EntryDate < DateTime.MaxValue)
                paramsToStore[5].Value = objDFR.EntryDate;
            else
                paramsToStore[5].Value = DBNull.Value;

            paramsToStore[6] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFR.UpdateBy.Trim() != "")
                paramsToStore[6].Value = objDFR.UpdateBy;
            else
                paramsToStore[6].Value = DBNull.Value;

            paramsToStore[7] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFR.UpdateDate > DateTime.MinValue && objDFR.UpdateDate < DateTime.MaxValue)
                paramsToStore[7].Value = objDFR.UpdateDate;
            else
                paramsToStore[7].Value = DBNull.Value;

            paramsToStore[0].Size = 25;
            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 200;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 25;
            paramsToStore[6].Size = 25;

            SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Update", paramsToStore);
            foreach (DFMRules_Details drd in objDFR.Details)
            {
                if (!drd.Deleted)
                {
                    DFMRules_Details objDrd = DFMRules_Details.GetByRuleIDDocType(drd.RuleID, drd.DocType, tr);
                    if (objDrd.ID > 0)
                    {
                        DFMRules_Details.Update(drd, tr);
                    }
                    else
                    {
                        DFMRules_Details.Insert(drd, tr);
                    }
                }
                else
                {
                    DFMRules_Details.Delete(drd.RuleID, drd.DocType, tr);
                }
            }
            bChk = true;
            tr.Commit();
        }
        catch (Exception excp)
        {
            tr.Rollback();
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return bChk;
    }
    public static bool Delete(string CodeId)
    {
        bool bChk = false;
        SqlConnection conn = new SqlConnection(GetConnectionString());
        conn.Open();
        SqlTransaction tr = conn.BeginTransaction();
        try
        {
            DFMRules objDFR = DFMRules.GetByCodeID(CodeId);
            if (objDFR.CodeID != "")
            {
                foreach (DFMRules_Details drd in objDFR.Details)
                {
                    DFMRules_Details.Delete(drd.RuleID, drd.DocType, tr);
                }
                SqlParameter[] paramsToStore = new SqlParameter[1];

                paramsToStore[0] = new SqlParameter("@CodeID", SqlDbType.VarChar);
                paramsToStore[0].Value = CodeId;
                paramsToStore[0].Size = 25;

                SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Delete", paramsToStore);
            }
            bChk = true;
            tr.Commit();
        }
        catch (Exception excp)
        {
            tr.Rollback();
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return bChk;
    }
    public static List<DFMRules> GetPaged(string whereClause, string orderBy, int pageIndex, int pageSize)
    {
        List<DFMRules> listDFR = new List<DFMRules>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;
            paramsToStore[2] = new SqlParameter("@PageIndex", SqlDbType.Int);
            paramsToStore[2].Value = pageIndex;
            paramsToStore[3] = new SqlParameter("@PageSize", SqlDbType.Int);
            paramsToStore[3].Value = pageSize;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_GetPaged", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DFMRules objDR = new DFMRules();
                    objDR = FillObject(dr);
                    objDR.Details = DFMRules_Details.GetByRuleID(objDR.CodeID);
                    listDFR.Add(objDR);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFR;
    }
    public static List<DFMRules> Get(string whereClause, string orderBy)
    {
        List<DFMRules> listDFR = new List<DFMRules>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;
            
            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_HDR_Get", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DFMRules objDR = new DFMRules();
                    objDR = FillObject(dr);
                    objDR.Details = DFMRules_Details.GetByRuleID(objDR.CodeID);
                    listDFR.Add(objDR);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFR;
    }
    #endregion

    #region Private Methods
    private static string GetConnectionString()
    {
        return SessionUtilities.ConnectionString;
    }
    #endregion
}

/// <summary>
/// Summary description for DFMRules_Details
/// </summary>
[Serializable]
public class DFMRules_Details
{
    #region Private Members
    private bool _Deleted = false;
    private int _ID = 0;
    private string _RuleID = "";
    private string _DocType = "";
    private string _DefaultValue = "";
    private string _SetValue = "";
    private string _ActiveFlag = "N";
    private string _Enable = "N";
    private string _EntryBy = "";
    private DateTime _EntryDate = DateTime.MinValue;
    private string _UpdateBy = "";
    private DateTime _UpdateDate = DateTime.MinValue;
    #endregion

    #region Public Properties
    public bool Deleted { get { return _Deleted; } set { _Deleted = value; } }
    public int ID { get { return _ID; } set { _ID = value; } }
    public string RuleID { get { return _RuleID; } set { _RuleID = value; } }
    public string DocType { get { return _DocType; } set { _DocType = value; } }
    public string DefaultValue { get { return _DefaultValue; } set { _DefaultValue = value; } }
    public string SetValue { get { return _SetValue; } set { _SetValue = value; } }
    public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
    public string Enable { get { return _Enable; } set { _Enable = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
    public string UpdateBy { get { return _UpdateBy; } set { _UpdateBy = value; } }
    public DateTime UpdateDate { get { return _UpdateDate; } set { _UpdateDate = value; } }
    #endregion

    #region Contructer
    public DFMRules_Details()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #endregion

    #region Public Methods
    public static DFMRules_Details FillObject(DataRow dr)
    {
        DFMRules_Details objDRD = new DFMRules_Details();

        if (dr[(int)DFMRules_Details_Columns.ID] != DBNull.Value)
            objDRD.ID = Convert.ToInt32(dr[(int)DFMRules_Details_Columns.ID]);
        if (dr[(int)DFMRules_Details_Columns.RuleID] != DBNull.Value)
            objDRD.RuleID = dr[(int)DFMRules_Details_Columns.RuleID].ToString();
        if (dr[(int)DFMRules_Details_Columns.DocType] != DBNull.Value)
            objDRD.DocType = dr[(int)DFMRules_Details_Columns.DocType].ToString();        
        if (dr[(int)DFMRules_Details_Columns.DefaultValue] != DBNull.Value)
            objDRD.DefaultValue = dr[(int)DFMRules_Details_Columns.DefaultValue].ToString();
        if (dr[(int)DFMRules_Details_Columns.SetValue] != DBNull.Value)
            objDRD.SetValue = dr[(int)DFMRules_Details_Columns.SetValue].ToString();
        if (dr[(int)DFMRules_Details_Columns.ActiveFlag] != DBNull.Value)
            objDRD.ActiveFlag = dr[(int)DFMRules_Details_Columns.ActiveFlag].ToString();
        if (dr[(int)DFMRules_Details_Columns.Enable] != DBNull.Value)
            objDRD.Enable = dr[(int)DFMRules_Details_Columns.Enable].ToString();
        if (dr[(int)DFMRules_Details_Columns.EntryBy] != DBNull.Value)
            objDRD.EntryBy = dr[(int)DFMRules_Details_Columns.EntryBy].ToString();
        if (dr[(int)DFMRules_Details_Columns.EntryDate] != DBNull.Value)
            objDRD.EntryDate = Convert.ToDateTime(dr[(int)DFMRules_Details_Columns.EntryDate]);
        if (dr[(int)DFMRules_Details_Columns.UpdateBy] != DBNull.Value)
            objDRD.UpdateBy = dr[(int)DFMRules_Details_Columns.UpdateBy].ToString();
        if (dr[(int)DFMRules_Details_Columns.UpdateDate] != DBNull.Value)
            objDRD.UpdateDate = Convert.ToDateTime(dr[(int)DFMRules_Details_Columns.UpdateDate]);

        return objDRD;
    }        
    public void MarkDeleted()
    {
        _Deleted = true;
    }

    #region Without Trans
    public static int Insert(DFMRules_Details objDFD)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[11];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Direction = ParameterDirection.Output;
            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[1].Value = objDFD.RuleID;
            else
                paramsToStore[1].Value = DBNull.Value;

            paramsToStore[2] = new SqlParameter("@DocType", SqlDbType.VarChar);
            if (objDFD.DocType.Trim() != "")
                paramsToStore[2].Value = objDFD.DocType;
            else
                paramsToStore[2].Value = DBNull.Value;
            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[3].Value = objDFD.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;
            paramsToStore[4] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            if (objDFD.SetValue.Trim() != "")
                paramsToStore[4].Value = objDFD.SetValue;
            else
                paramsToStore[4].Value = DBNull.Value;

            paramsToStore[5] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            if (objDFD.ActiveFlag.Trim() != "")
                paramsToStore[5].Value = objDFD.ActiveFlag;
            else
                paramsToStore[5].Value = DBNull.Value;
            paramsToStore[6] = new SqlParameter("@Enable", SqlDbType.VarChar);
            if (objDFD.Enable.Trim() != "")
                paramsToStore[6].Value = objDFD.Enable;
            else
                paramsToStore[6].Value = DBNull.Value;
            paramsToStore[7] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFD.EntryBy.Trim() != "")
                paramsToStore[7].Value = objDFD.EntryBy;
            else
                paramsToStore[7].Value = DBNull.Value;
            paramsToStore[8] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFD.EntryDate > DateTime.MinValue && objDFD.EntryDate < DateTime.MaxValue)
                paramsToStore[8].Value = objDFD.EntryDate;
            else
                paramsToStore[8].Value = DBNull.Value;
            paramsToStore[9] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFD.UpdateBy.Trim() != "")
                paramsToStore[9].Value = objDFD.UpdateBy;
            else
                paramsToStore[9].Value = DBNull.Value;
            paramsToStore[10] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFD.UpdateDate > DateTime.MinValue && objDFD.UpdateDate < DateTime.MaxValue)
                paramsToStore[10].Value = objDFD.UpdateDate;
            else
                paramsToStore[10].Value = DBNull.Value;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 6;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 50;
            paramsToStore[5].Size = 1;
            paramsToStore[6].Size = 1;
            paramsToStore[7].Size = 25;
            paramsToStore[9].Size = 25;

            SqlHelper.ExecuteNonQuery(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Insert", paramsToStore);
            objDFD.ID = (int)paramsToStore[0].Value;
        }
        catch (Exception excp)
        {
        }
        return objDFD.ID;
    }
    public static bool Delete(string RuleId, string DocType)
    {
        bool bChk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];
 
            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = RuleId;
            paramsToStore[0].Size=25;
            paramsToStore[1] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[1].Value = DocType;
            paramsToStore[1].Size=6;

            SqlHelper.ExecuteNonQuery(GetConnectionString(), CommandType.StoredProcedure,"sp_WebX_DFM_RULES_DET_Delete", paramsToStore);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }
    public static bool Delete(string Id)
    {
        bool bChk = false;
        try
        {
            if (!Id.Contains(","))
                Id += ", ";
            string cmd = "Delete from WebX_DFM_RULES_DET where ID in (Select Items from dbo.Split('" + Id + "',','))";
            SqlHelper.ExecuteNonQuery(GetConnectionString(), CommandType.Text, cmd);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }
    public static bool Update(DFMRules_Details objDFD)
    {
        bool bChk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[13];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Value = objDFD.ID;

            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[1].Value = objDFD.RuleID;
            
            paramsToStore[2] = new SqlParameter("@OriginalRuleID", SqlDbType.VarChar);
            paramsToStore[2].Value = objDFD.RuleID;
            
            paramsToStore[3] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[3].Value = objDFD.DocType;
            
            paramsToStore[4] = new SqlParameter("@OriginalDocType", SqlDbType.VarChar);
            paramsToStore[4].Value = objDFD.DocType;
            
            paramsToStore[5] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            paramsToStore[5].Value = objDFD.DefaultValue;
            
            paramsToStore[6] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            paramsToStore[6].Value = objDFD.SetValue;
            
            paramsToStore[7] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            paramsToStore[7].Value = objDFD.ActiveFlag;
            
            paramsToStore[8] = new SqlParameter("@Enable", SqlDbType.VarChar);
            paramsToStore[8].Value = objDFD.Enable;
            
            paramsToStore[9] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            paramsToStore[9].Value = objDFD.EntryBy;
            
            paramsToStore[10] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            paramsToStore[10].Value = objDFD.EntryDate;
            paramsToStore[11] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            paramsToStore[11].Value = objDFD.UpdateBy;
            
            paramsToStore[12] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            paramsToStore[12].Value = objDFD.UpdateDate;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 25;
            paramsToStore[3].Size = 6;
            paramsToStore[4].Size = 6;
            paramsToStore[5].Size = 50;
            paramsToStore[6].Size = 50;
            paramsToStore[7].Size = 1;
            paramsToStore[8].Size = 1;
            paramsToStore[9].Size = 25;
            paramsToStore[11].Size = 25;

            SqlHelper.ExecuteNonQuery(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Update", paramsToStore);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }    
    public static DFMRules_Details GetByRuleIDDocType(string RuleId, string DocType)
    {
        DFMRules_Details objDFD = new DFMRules_Details();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];

            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = RuleId;
            paramsToStore[0].Size = 25;
            paramsToStore[1] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[1].Value = DocType;
            paramsToStore[1].Size = 6;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByRuleIDDocType", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    objDFD = FillObject(ds.Tables[0].Rows[0]);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return objDFD;
    }
    public static DFMRules_Details GetByID(int Id)
    {
        DFMRules_Details objDFD = new DFMRules_Details();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Value = Id;
            
            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByID", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    objDFD = FillObject(ds.Tables[0].Rows[0]);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return objDFD;
    }
    public static List<DFMRules_Details> GetByRuleID(string ruleId)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = ruleId;
            paramsToStore[0].Size = 25;
            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByRuleID", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> GetByDocType(string docType)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[0].Value = docType;
            paramsToStore[0].Size = 6;
            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByDocType", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> Find(DFMRules_Details objDFD)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[11];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            if(objDFD.ID > 0)
                paramsToStore[0].Value = objDFD.ID;
            else
                paramsToStore[0].Value = DBNull.Value;

            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[1].Value = objDFD.RuleID;
            else
                paramsToStore[1].Value = DBNull.Value;

            paramsToStore[2] = new SqlParameter("@DocType", SqlDbType.VarChar);
            if (objDFD.DocType.Trim() != "")
                paramsToStore[2].Value = objDFD.DocType;
            else
                paramsToStore[2].Value = DBNull.Value;
            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[3].Value = objDFD.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;
            paramsToStore[4] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            if (objDFD.SetValue.Trim() != "")
                paramsToStore[4].Value = objDFD.SetValue;
            else
                paramsToStore[4].Value = DBNull.Value;
            
            paramsToStore[5] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            if (objDFD.ActiveFlag.Trim() != "")
                paramsToStore[5].Value = objDFD.ActiveFlag;
            else
                paramsToStore[5].Value = DBNull.Value;
            paramsToStore[6] = new SqlParameter("@Enable", SqlDbType.VarChar);
            if (objDFD.Enable.Trim() != "")
                paramsToStore[6].Value = objDFD.Enable;
            else
                paramsToStore[6].Value = DBNull.Value;
            paramsToStore[7] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFD.EntryBy.Trim() != "")
                paramsToStore[7].Value = objDFD.EntryBy;
            else
                paramsToStore[7].Value = DBNull.Value;
            paramsToStore[8] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFD.EntryDate > DateTime.MinValue && objDFD.EntryDate < DateTime.MaxValue)
                paramsToStore[8].Value = objDFD.EntryDate;
            else
                paramsToStore[8].Value = DBNull.Value;
            paramsToStore[9] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFD.UpdateBy.Trim() != "")
                paramsToStore[9].Value = objDFD.UpdateBy;
            else
                paramsToStore[9].Value = DBNull.Value;
            paramsToStore[10] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFD.UpdateDate > DateTime.MinValue && objDFD.UpdateDate < DateTime.MaxValue)
                paramsToStore[10].Value = objDFD.UpdateDate;
            else
                paramsToStore[10].Value = DBNull.Value;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 6;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 50;
            paramsToStore[5].Size = 1;
            paramsToStore[6].Size = 1;
            paramsToStore[7].Size = 25;
            paramsToStore[9].Size = 25;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Find", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }        
        return listDFD;
    }
    public static List<DFMRules_Details> GetPaged(string whereClause, string orderBy, int pageIndex, int pageSize)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;
            paramsToStore[2] = new SqlParameter("@PageIndex", SqlDbType.Int);
            paramsToStore[2].Value = pageIndex;
            paramsToStore[3] = new SqlParameter("@PageSize", SqlDbType.Int);
            paramsToStore[3].Value = pageSize;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetPaged", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> Get(string whereClause, string orderBy)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;

            DataSet ds = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Get", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    #endregion 

    #region With Trans
    public static int Insert(DFMRules_Details objDFD, SqlTransaction tr)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[11];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Direction = ParameterDirection.Output;
            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[1].Value = objDFD.RuleID;
            else
                paramsToStore[1].Value = DBNull.Value;

            paramsToStore[2] = new SqlParameter("@DocType", SqlDbType.VarChar);
            if (objDFD.DocType.Trim() != "")
                paramsToStore[2].Value = objDFD.DocType;
            else
                paramsToStore[2].Value = DBNull.Value;
            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[3].Value = objDFD.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;
            paramsToStore[4] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            if (objDFD.SetValue.Trim() != "")
                paramsToStore[4].Value = objDFD.SetValue;
            else
                paramsToStore[4].Value = DBNull.Value;

            paramsToStore[5] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            if (objDFD.ActiveFlag.Trim() != "")
                paramsToStore[5].Value = objDFD.ActiveFlag;
            else
                paramsToStore[5].Value = DBNull.Value;
            paramsToStore[6] = new SqlParameter("@Enable", SqlDbType.VarChar);
            if (objDFD.Enable.Trim() != "")
                paramsToStore[6].Value = objDFD.Enable;
            else
                paramsToStore[6].Value = DBNull.Value;
            paramsToStore[7] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFD.EntryBy.Trim() != "")
                paramsToStore[7].Value = objDFD.EntryBy;
            else
                paramsToStore[7].Value = DBNull.Value;
            paramsToStore[8] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFD.EntryDate > DateTime.MinValue && objDFD.EntryDate < DateTime.MaxValue)
                paramsToStore[8].Value = objDFD.EntryDate;
            else
                paramsToStore[8].Value = DBNull.Value;
            paramsToStore[9] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFD.UpdateBy.Trim() != "")
                paramsToStore[9].Value = objDFD.UpdateBy;
            else
                paramsToStore[9].Value = DBNull.Value;
            paramsToStore[10] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFD.UpdateDate > DateTime.MinValue && objDFD.UpdateDate < DateTime.MaxValue)
                paramsToStore[10].Value = objDFD.UpdateDate;
            else
                paramsToStore[10].Value = DBNull.Value;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 6;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 50;
            paramsToStore[5].Size = 1;
            paramsToStore[6].Size = 1;
            paramsToStore[7].Size = 25;
            paramsToStore[9].Size = 25;

            SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Insert", paramsToStore);
            objDFD.ID = (int)paramsToStore[0].Value;
        }
        catch (Exception excp)
        {
        }
        return objDFD.ID;
    }
    public static bool Delete(string RuleId, string DocType, SqlTransaction tr)
    {
        bool bChk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];

            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = RuleId;
            paramsToStore[0].Size = 25;
            paramsToStore[1] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[1].Value = DocType;
            paramsToStore[1].Size = 6;

            SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Delete", paramsToStore);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }
    public static bool Delete(string Id, SqlTransaction tr)
    {
        bool bChk = false;
        try
        {
            if (!Id.Contains(","))
                Id += ", ";
            string cmd = "Delete from WebX_DFM_RULES_DET where ID in (Select Items from dbo.Split('" + Id + "',','))";
            SqlHelper.ExecuteNonQuery(tr, CommandType.Text ,cmd);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }
    public static bool Update(DFMRules_Details objDFD, SqlTransaction tr)
    {
        bool bChk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[13];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Value = objDFD.ID;

            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[1].Value = objDFD.RuleID;

            paramsToStore[2] = new SqlParameter("@OriginalRuleID", SqlDbType.VarChar);
            paramsToStore[2].Value = objDFD.RuleID;

            paramsToStore[3] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[3].Value = objDFD.DocType;

            paramsToStore[4] = new SqlParameter("@OriginalDocType", SqlDbType.VarChar);
            paramsToStore[4].Value = objDFD.DocType;

            paramsToStore[5] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            paramsToStore[5].Value = objDFD.DefaultValue;

            paramsToStore[6] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            paramsToStore[6].Value = objDFD.SetValue;

            paramsToStore[7] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            paramsToStore[7].Value = objDFD.ActiveFlag;

            paramsToStore[8] = new SqlParameter("@Enable", SqlDbType.VarChar);
            paramsToStore[8].Value = objDFD.Enable;

            paramsToStore[9] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            paramsToStore[9].Value = objDFD.EntryBy;

            paramsToStore[10] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            paramsToStore[10].Value = objDFD.EntryDate;
            paramsToStore[11] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            paramsToStore[11].Value = objDFD.UpdateBy;

            paramsToStore[12] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            paramsToStore[12].Value = objDFD.UpdateDate;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 25;
            paramsToStore[3].Size = 6;
            paramsToStore[4].Size = 6;
            paramsToStore[5].Size = 50;
            paramsToStore[6].Size = 50;
            paramsToStore[7].Size = 1;
            paramsToStore[8].Size = 1;
            paramsToStore[9].Size = 25;
            paramsToStore[11].Size = 25;

            SqlHelper.ExecuteNonQuery(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Update", paramsToStore);
            bChk = true;
        }
        catch (Exception excp)
        {
        }
        return bChk;
    }
    public static DFMRules_Details GetByRuleIDDocType(string RuleId, string DocType, SqlTransaction tr)
    {
        DFMRules_Details objDFD = new DFMRules_Details();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];

            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = RuleId;
            paramsToStore[0].Size = 25;
            paramsToStore[1] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[1].Value = DocType;
            paramsToStore[1].Size = 6;

            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByRuleIDDocType", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    objDFD = FillObject(ds.Tables[0].Rows[0]);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return objDFD;
    }
    public static DFMRules_Details GetByID(int Id, SqlTransaction tr)
    {
        DFMRules_Details objDFD = new DFMRules_Details();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            paramsToStore[0].Value = Id;

            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByID", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    objDFD = FillObject(ds.Tables[0].Rows[0]);
                }
            }
        }
        catch (Exception excp)
        {
        }
        return objDFD;
    }
    public static List<DFMRules_Details> GetByRuleID(string ruleId, SqlTransaction tr)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            paramsToStore[0].Value = ruleId;
            paramsToStore[0].Size = 25;
            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByRuleID", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> GetByDocType(string docType, SqlTransaction tr)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];

            paramsToStore[0] = new SqlParameter("@DocType", SqlDbType.VarChar);
            paramsToStore[0].Value = docType;
            paramsToStore[0].Size = 6;
            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetByDocType", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> Find(DFMRules_Details objDFD, SqlTransaction tr)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[11];

            paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Int);
            if (objDFD.ID > 0)
                paramsToStore[0].Value = objDFD.ID;
            else
                paramsToStore[0].Value = DBNull.Value;

            paramsToStore[1] = new SqlParameter("@RuleID", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[1].Value = objDFD.RuleID;
            else
                paramsToStore[1].Value = DBNull.Value;

            paramsToStore[2] = new SqlParameter("@DocType", SqlDbType.VarChar);
            if (objDFD.DocType.Trim() != "")
                paramsToStore[2].Value = objDFD.DocType;
            else
                paramsToStore[2].Value = DBNull.Value;
            paramsToStore[3] = new SqlParameter("@DefaultValue", SqlDbType.VarChar);
            if (objDFD.RuleID.Trim() != "")
                paramsToStore[3].Value = objDFD.DefaultValue;
            else
                paramsToStore[3].Value = DBNull.Value;
            paramsToStore[4] = new SqlParameter("@SetValue", SqlDbType.VarChar);
            if (objDFD.SetValue.Trim() != "")
                paramsToStore[4].Value = objDFD.SetValue;
            else
                paramsToStore[4].Value = DBNull.Value;

            paramsToStore[5] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            if (objDFD.ActiveFlag.Trim() != "")
                paramsToStore[5].Value = objDFD.ActiveFlag;
            else
                paramsToStore[5].Value = DBNull.Value;
            paramsToStore[6] = new SqlParameter("@Enable", SqlDbType.VarChar);
            if (objDFD.Enable.Trim() != "")
                paramsToStore[6].Value = objDFD.Enable;
            else
                paramsToStore[6].Value = DBNull.Value;
            paramsToStore[7] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            if (objDFD.EntryBy.Trim() != "")
                paramsToStore[7].Value = objDFD.EntryBy;
            else
                paramsToStore[7].Value = DBNull.Value;
            paramsToStore[8] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (objDFD.EntryDate > DateTime.MinValue && objDFD.EntryDate < DateTime.MaxValue)
                paramsToStore[8].Value = objDFD.EntryDate;
            else
                paramsToStore[8].Value = DBNull.Value;
            paramsToStore[9] = new SqlParameter("@UpdateBy", SqlDbType.VarChar);
            if (objDFD.UpdateBy.Trim() != "")
                paramsToStore[9].Value = objDFD.UpdateBy;
            else
                paramsToStore[9].Value = DBNull.Value;
            paramsToStore[10] = new SqlParameter("@UpdateDate", SqlDbType.DateTime);
            if (objDFD.UpdateDate > DateTime.MinValue && objDFD.UpdateDate < DateTime.MaxValue)
                paramsToStore[10].Value = objDFD.UpdateDate;
            else
                paramsToStore[10].Value = DBNull.Value;

            paramsToStore[1].Size = 25;
            paramsToStore[2].Size = 6;
            paramsToStore[3].Size = 50;
            paramsToStore[4].Size = 50;
            paramsToStore[5].Size = 1;
            paramsToStore[6].Size = 1;
            paramsToStore[7].Size = 25;
            paramsToStore[9].Size = 25;

            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Find", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> GetPaged(string whereClause, string orderBy, int pageIndex, int pageSize, SqlTransaction tr)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;
            paramsToStore[2] = new SqlParameter("@PageIndex", SqlDbType.Int);
            paramsToStore[2].Value = pageIndex;
            paramsToStore[3] = new SqlParameter("@PageSize", SqlDbType.Int);
            paramsToStore[3].Value = pageSize;

            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_GetPaged", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    public static List<DFMRules_Details> Get(string whereClause, string orderBy, SqlTransaction tr)
    {
        List<DFMRules_Details> listDFD = new List<DFMRules_Details>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = new SqlParameter("@WhereClause", SqlDbType.VarChar);
            paramsToStore[0].Value = whereClause;
            paramsToStore[0].Size = 2000;
            paramsToStore[1] = new SqlParameter("@OrderBy", SqlDbType.VarChar);
            paramsToStore[1].Value = orderBy;
            paramsToStore[1].Size = 2000;

            DataSet ds = SqlHelper.ExecuteDataset(tr, CommandType.StoredProcedure, "sp_WebX_DFM_RULES_DET_Get", paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    listDFD.Add(FillObject(dr));
                }
            }
        }
        catch (Exception excp)
        {
        }
        return listDFD;
    }
    #endregion

    #endregion

    #region Private Method
    private static string GetConnectionString()
    {
        return SessionUtilities.ConnectionString;
    }
    #endregion
}

[Serializable]
public class DFM_Rules_NameValues
{
    string _RuleID = "";
    string _Name = "";
    string _Value = "";

    public string RuleID
    {
        get { return _RuleID; }
        set { _RuleID = value; }
    }
    public string Name
    {
        get { return _Name; }
        set { _Name = value; }
    }
    public string Value
    {
        get { return _Value; }
        set { _Value = value; }
    }

    public DFM_Rules_NameValues()
    { }
    public DFM_Rules_NameValues(string ruleId, string name, string value)
    {
        RuleID = ruleId;
        Name = name;
        Value = value;
    }

    public static List<DFM_Rules_NameValues> GetRuleValues(string ruleID, string docTyp)
    {
        List<DFM_Rules_NameValues> listRet = new List<DFM_Rules_NameValues>();
        switch (ruleID.Trim().ToUpper())
        {
            case "COD_DOD_COLLECT":
                switch (docTyp.Trim().ToUpper())
                { 
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                }
                break;
            case "DOC_COD_DOD":
                switch (docTyp.Trim().ToUpper())
                {
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                }
                break;
            case "DOC_DEL":
                switch (docTyp.Trim().ToUpper())
                {
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                }
                break;
            case "COD_DOD_NO":
                switch (docTyp.Trim().ToUpper())
                {
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NOT BLANK", "NOT_BLANK"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NOT BLANK", "NOT_BLANK"));
                        break;
                }
                break;
            case "OCT_RECPT_NO":
                switch (docTyp.Trim().ToUpper())
                {
                    case "3":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NOT BLANK", "NOT_BLANK"));
                        break;
                }
                break;
            case "FIRST_FM_LOC":
                switch (docTyp.Trim().ToUpper())
                {
                    case "1":                    
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Docket Delevery Location", "DOC_DEL_LOC"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Docket Origin Location", "DOC_ORG_LOC"));
                        break;
                    case "2":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Bill Generation Location", "BILL_GEN_LOC"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Bill Submossion Location", "BILL_SUB_LOC"));
                        break;
                    case "3":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Octroi Recpt. Fist Entry Location", "OCT_FIRST_ENTRY_LOC"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        break;
                }
                break;
            case "FWD_CUST_REST":
                switch (docTyp.Trim().ToUpper())
                {                   
                    case "2":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "BILL PARTY", "BILL_PARTY"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        break;
                }
                break;
            case "FWD_LOC_REST":
                switch (docTyp.Trim().ToUpper())
                {                    
                    case "2":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "Bill Submission Location", "BILL_SUB_LOC"));
                        break;
                    case "1":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "CPC", "CPC"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        break;
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NONE", "NONE"));
                        break;
                }
                break;
            case "UP_FILE_SIZE":
                listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "300 KB", "300"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "400 KB", "400"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "500 KB", "500"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "600 KB", "600"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "700 KB", "700"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "800 KB", "800"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "900 KB", "900"));
                listRet.Add(new DFM_Rules_NameValues(ruleID, "1000 KB", "1000"));
                break;
            case "SCAN_DOC_AT_HQ":
                switch (docTyp.Trim().ToUpper())
                {
                    case "1":
                    case "2":                    
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                }
                break;
            case "OVER_DOC_AT_HQ":
                switch (docTyp.Trim().ToUpper())
                {
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                    default:
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NA", "NA"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "YES", "YES"));
                        listRet.Add(new DFM_Rules_NameValues(ruleID, "NO", "NO"));
                        break;
                }
                break;
        }
        return listRet;
    }
}

public enum DFMRules_Columns
{ 
    CodeID = 0,
    Description,
    DefaultValue,
    EntryBy,
    EntryDate,
    UpdateBy,
    UpdateDate
}
public enum DFMRules_Details_Columns
{ 
    ID = 0,
    RuleID,
    DocType,
    DefaultValue,
    SetValue,
    ActiveFlag,
    Enable,
    EntryBy,
    EntryDate,
    UpdateBy,
    UpdateDate
}
