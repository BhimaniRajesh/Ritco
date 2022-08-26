using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Xml;
using WebX.Entity;

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for StateMasterController
    /// </summary>
    public class StateMasterController
    {
        #region Constructor
        public StateMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into webx_STATE table
        public static void InsertState(State state, StateDocument[] stateDocument)
        {
            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();

            SqlTransaction trn = con.BeginTransaction();

            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[3];

                string strXMLStateHdr, strXMLStateDocument, strXMLOutPut = "<root></root>";
                System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(state.GetType());
                System.IO.MemoryStream stream = new System.IO.MemoryStream();
                x.Serialize(stream, state);
                stream.Position = 0;
                XmlDocument xd = new XmlDocument();
                xd.Load(stream);
                strXMLStateHdr = xd.InnerXml;



                System.Xml.Serialization.XmlSerializer x1 = new System.Xml.Serialization.XmlSerializer(stateDocument.GetType());
                System.IO.MemoryStream streamStateDoc = new System.IO.MemoryStream();
                x1.Serialize(streamStateDoc, stateDocument);
                streamStateDoc.Position = 0;
                XmlDocument xdStateDoc = new XmlDocument();
                xdStateDoc.Load(streamStateDoc);
                strXMLStateDocument = xdStateDoc.InnerXml;

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLStateHdr", strXMLStateHdr, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@strXMLStateDocument", strXMLStateDocument, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@strXMLOutPut", strXMLOutPut, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_webx_STATE_Insert", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                throw ex;
            }
            trn.Commit();

        }

        // update new record into webx_STATE table
        //public int updateSTATEMaster(StateMaster objectStateMaster)
        //{
        //int result;
        //result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_STATE_Update", saveSTATEMasterParam(objectStateMaster));
        //return result;
        //}

        // delete record from webx_STATE table
        //public int deleteSTATEMaster(int id)
        //{
        //    int result;
        //    result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, "DELETE FROM webx_state_hdr WHERE SRNO='" + id + "'");
        //    return result;
        //}

        // Get State information from webx_STATE by stateCode       
        public DataTable getStateDocument(string stateCode)
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select * from webx_state_document where stcd='" + stateCode + "'");
            return dsStateList.Tables[0];
        }

        public DataTable getStateHdr(string stateCode)
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select * from Webx_State where stcd='" + stateCode + "'");
            return dsStateList.Tables[0];
        }
        // Get next state code     
        public int getNextStateCode()
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "Select cast(max(stcd) as integer) + 1 as NextStateCode From Webx_State");

                if (obj is DBNull)
                    return 1;
                else
                    return (int)obj;
            }
            catch (Exception Exc)
            {
                return 1;
            }
        }

        // Get All State information from webx_STATE     
        public DataTable getAllState()
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select hd.stcd,stnm,frt_rate,rate_type,entryby,entrydt,lasteditby,lasteditdate,activeflag,stax_exmpt_yn,STCSTREQ,STFORM,STPERMIT,STREM,inoutbound,frttype.codedesc from Webx_State hd inner join Webx_State_Document dc on hd.stcd=dc.STCD CROSS APPLY (SELECT codedesc FROM  webx_master_general where codetype='RATETYPE' AND codeid=hd.rate_type) frttype ORDER BY hd.stnm");
            return dsStateList.Tables[0];
        }

        //Get State Information
        public DataTable getStateInfo(string stateCode)
        {
            DataSet dsStateInfo = new DataSet();
            dsStateInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select hd.stcd,stnm,frt_rate,rate_type,entryby,entrydt,lasteditby,lasteditdate,activeflag,stax_exmpt_yn,STCSTREQ,STFORM,STPERMIT,STREM,inoutbound from Webx_State hd inner join Webx_State_Document dc on hd.stcd=dc.STCD where hd.stcd='" + stateCode + "'");
            return dsStateInfo.Tables[0];
        }


        // Get All Distinct State information from webx_STATE     
        public DataTable getAllStateDistinct()
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT distinct STNM,(STCD + ' : ' + STNM) as STdetail, STCD FROM Webx_State order by STNM");
            //dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT *, distinct STNM,(STCD + ' : ' + STNM) as STdetail, STCD FROM webx_state order by STNM");
            return dsStateList.Tables[0];
        }

        // Get State information from webx_STATE by stateCode       
        public DataTable getStateByStateCode(string stateCode)
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy,* FROM webx_state LEFT OUTER JOIN WebX_Master_Users ON webx_state.UPDTBY = WebX_Master_Users.UserID WHERE stcd='" + stateCode + "'");
            return dsStateList.Tables[0];
        }

        // Get All Rate Type from webx_master_general     
        public DataTable getRateType()
        {
            DataSet dsRateTypeList = new DataSet();
            dsRateTypeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codeid as RateCode, codedesc as RateType FROM webx_master_general WHERE codetype='RATETYPE'");
            return dsRateTypeList.Tables[0];
        }
        #endregion


    }
}