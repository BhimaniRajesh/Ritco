using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

/// <summary>
/// Summary description for DemurrageChargesMatrixConroller
/// </summary>
public class DemurrageChargesMatrixConroller
{
	public DemurrageChargesMatrixConroller()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //function use for Get Demurrage Charge Contract Detail
    public DataTable GetDemurrageChargeDetail(string ContractId, string BusinessType, string FromLocation, string ToLocation, string TransMode, string MatrixType)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] prm = new SqlParameter[6];
            prm[0] = ControllersHelper.GetSqlParameter("@ContractId", ContractId, SqlDbType.VarChar, 50);
            prm[1] = ControllersHelper.GetSqlParameter("@BusinessType", BusinessType, SqlDbType.VarChar, 30);
            prm[2] = ControllersHelper.GetSqlParameter("@FromLocation", FromLocation, SqlDbType.VarChar, 50);
            prm[3] = ControllersHelper.GetSqlParameter("@ToLocation", ToLocation, SqlDbType.VarChar, 30);
            prm[4] = ControllersHelper.GetSqlParameter("@TransMode", TransMode, SqlDbType.VarChar, 50);
            prm[5] = ControllersHelper.GetSqlParameter("@MatrixType", MatrixType, SqlDbType.VarChar, 30);
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_Webx_Customer_Contract_Demurrage_Charge_Header_Get_Detail", prm).Tables[0];
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dt;
    }


    //function use for Get Demurrage Charge Contract Slab Detail
    public DataTable GetDemurrageChargeSlabDetail(int Srno , string SlabCode)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] prm = new SqlParameter[2];
            prm[0] = ControllersHelper.GetSqlParameter("@Srno", Srno, SqlDbType.Int);
            prm[1] = ControllersHelper.GetSqlParameter("@SlabCode", SlabCode, SqlDbType.VarChar, 10);

            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_Get_Demurrage_Charge_Slab_Detail", prm).Tables[0];
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dt;
    }
    //function use for insert in table
    public bool Insert(DemurrageChargesMatrix objhdr)
    {

        bool bChk = false;

        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            var prm = new SqlParameter[1];
            prm[0] = new SqlParameter("@DataXML", SqlDbType.Xml);

            // prm[0].Value = WebX.Helper.XmlUtility.XmlSerializeToString(ListFund);
            prm[0].Value = this.GetXmlString(objhdr);


            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_Webx_Customer_Contract_Demurrage_Charge_Header_Insert", prm);

            bChk = true;
        }
        catch (Exception ex)
        {

            trn.Rollback();
            bChk = false;
        }
        if (bChk)
        {
            trn.Commit();
        }
        conn.Close();
        conn.Dispose();


        return bChk;

    }
    //use for generated Xml File
    public string GetXmlString(DemurrageChargesMatrix tr)
    {
        string xmlString = "";

        XmlSerializer x = new XmlSerializer(tr.GetType());
        MemoryStream stream = new MemoryStream();
        x.Serialize(stream, tr);
        stream.Position = 0;
        XmlDocument xd = new XmlDocument();
        xd.Load(stream);
        xmlString = xd.InnerXml;

        xmlString = xmlString.Replace("&", "&amp;");
        return xmlString;
    }

}