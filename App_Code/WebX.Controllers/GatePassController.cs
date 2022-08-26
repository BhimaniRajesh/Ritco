using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

/// <summary>
/// Summary description for GatePassController
/// </summary>
public class GatePassController
{
    public GatePassController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static DataTable GetGatePass(string tp, DateTime stdt, DateTime eddt, string partycode, string gatepassnos, string docknos, string gpbr)
    {
        //string sqlstr = "SELECT gatepassno,CONVERT(VARCHAR,gatepassdate,106) AS date,";
        //sqlstr = sqlstr + " partyname=(ptcd + ' : ' + ptname),";
        //sqlstr = sqlstr + " godown=(SELECT godown_name FROM webx_godownmst WHERE godown_srno=(SELECT TOP 1 godown FROM webx_trans_docket_status WHERE dockno=g.dockno AND docksf='.'))";
        //sqlstr = sqlstr + " FROM webx_gatepass g";
        //sqlstr = sqlstr + " WHERE activeflag='Y' AND updated_yn='N' AND gpbrcd='" + gpbr + "'";

        string sqlstr = "SELECT g.gatepassno,CONVERT(VARCHAR,gatepassdate,106) AS date,";
        sqlstr = sqlstr + " partyname=(ptcd + ' : ' + ptname),";
        sqlstr = sqlstr + " godown=(SELECT godown_name FROM webx_godownmst WHERE godown_srno=(SELECT TOP 1 godown FROM webx_trans_docket_status WHERE dockno=g.dockno AND docksf='.'))";
        sqlstr = sqlstr + " FROM webx_gatepass g";
        sqlstr = sqlstr + " inner join webx_master_docket d on d.dockno=g.dockno ";
        sqlstr = sqlstr + " inner join webx_trans_docket_status s on s.dockno=d.dockno and s.gatepassno=g.gatepassno ";
        sqlstr = sqlstr + " cross apply(SELECT CNT=COUNT(*) FROM WebX_MR_HDR WHERE (MR_CANCEL='N' OR MR_CANCEL IS NULL) AND DOCKNO=g.dockno)X ";
        sqlstr = sqlstr + " WHERE activeflag='Y' AND updated_yn='N' AND gpbrcd='" + gpbr + "' and d.reassign_destcd=s.curr_loc and X.CNT>0 ";

        DataTable dtgatepass;
        if (tp.CompareTo("0") == 0)
        {
            if (gatepassnos.CompareTo("") != 0)
                sqlstr = sqlstr + " AND g.gatepassno IN ('" + gatepassnos.Replace(",", "','") + "')";
        }
        else if (tp.CompareTo("1") == 0)
        {
            if (docknos.CompareTo("") != 0)
                sqlstr = sqlstr + " AND d.dockno IN ('" + docknos.Replace(",", "','") + "')";
        }
        else if (tp.CompareTo("2") == 0)
        {
            sqlstr = sqlstr + " AND (gatepassdate BETWEEN '" + stdt.ToString("dd MMM yyyy") + "'";
            sqlstr = sqlstr + " AND '" + eddt.ToString("dd MMM yyyy") + "')";
            if (partycode.CompareTo("") != 0)
                sqlstr = sqlstr + " AND ptcd='" + partycode + "'";
        }



        try
        {
            dtgatepass = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dtgatepass;
    }

    public static void GatePassEntry(GatePass gp, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[15];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@gatepassno", gp.GatePassNo, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@gpbrcd", gp.GatePassLoc, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@dockno", gp.DockNo, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@docksf", gp.DockSF, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@mrno", gp.MRNo, SqlDbType.VarChar);
            if (gp.GatePassDate > DateTime.MinValue && gp.GatePassDate < DateTime.MaxValue)
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@gatepassdate", gp.GatePassDate, SqlDbType.DateTime);
            else
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@gatepassdate", DBNull.Value);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@ptcd", gp.PartyCode, SqlDbType.VarChar);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@ptname", gp.PartyName, SqlDbType.VarChar);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@receivercode", gp.ReceiverCode, SqlDbType.VarChar);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@receivername", gp.ReceiverName, SqlDbType.VarChar);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@delvehicle", gp.DeliveryVehicle, SqlDbType.VarChar);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@remarks", gp.Remarks, SqlDbType.VarChar);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@updated_yn", gp.FlagUpdate, SqlDbType.VarChar);
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@activeflag", "Y", SqlDbType.VarChar);
            paramsToStore[14] = ControllersHelper.GetSqlParameter("@entryby", gp.EntryBy, SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_GATEPASS_ENTRY", paramsToStore);
        }
        catch (Exception excp)
        {
            throw excp;
        }


    }

     public static void GatePassUpdate(GatePass gp, SqlTransaction trn)
    {
        string sqlstr = "UPDATE webx_gatepass SET updated_yn='Y',updatedate=GETDATE()";
        sqlstr = sqlstr + ",updateby='" + gp.UpdateBy + "' WHERE gatepassno='" + gp.GatePassNo + "'";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

        sqlstr = "UPDATE webx_trans_docket_status SET dely_date='" + gp.GatePassDate.ToString("dd MMM yyyy") + "'";
        sqlstr = sqlstr + " WHERE dockno='" + gp.DockNo + "' AND docksf='.'";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

	sqlstr = "UPDATE  IDET SET IDET.IndentDocketStatus = 'DELIVERED' FROM    dbo.Webx_Indent_Detail IDET ";
	sqlstr = sqlstr + "INNER JOIN dbo.Webx_Indent_Header IHDR ON IHDR.IndentNumber = IDET.IndentNumber ";
	sqlstr = sqlstr + "INNER JOIN WebX_Trans_Docket_Status WTDS WITH (NOLOCK) ON  WTDS.DOCKNO=IDET.DocketNumber ";
	sqlstr = sqlstr + "INNER JOIN WebX_Master_Docket D WITH (NOLOCK) ON WTDS.DOCKNO = D.DOCKNO ";
        sqlstr = sqlstr + "INNER JOIN dbo.webx_gatepass GP WITH (NOLOCK) ON GP.dockno=D.DOCKNO ";
	sqlstr = sqlstr + "WHERE GP.gatepassno='" + gp.GatePassNo + "' AND D.Reassign_destcd = WTDS.Curr_Loc AND ISNULL(IDET.IndentDocketStatus,'')=''";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
    }

    public static void SelDeliveryDetails(GatePass gp, SqlTransaction trn)
    {
        /*string sqlstr = "SELECT docksf FROM webx_mr_hdr m, webx_gatepass g ";
        sqlstr = sqlstr + " WHERE g.mrsno=m.mrsno AND gatepassno='" + gp.GatePassNo + "'";
        string docksf = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.Text, sqlstr));

        if (!(".ABCDEFGHIMXYZ".Contains(docksf)))
        {
            Exception ex = new Exception("Delivery MR suffix Error");
            trn.Rollback();
            throw ex;
        }*/

        string sqlstr = "UPDATE webx_trans_docket_status SET delivered='Y',dely_date=GETDATE(),Op_Status=' Delivered @'+Curr_Loc+' On '+CONVERT(VARCHAR,GETDATE(),106),";
        sqlstr = sqlstr + " delyreason='GATEPASS UPDATED',delyperson='" + gp.UpdateBy + "'";
        sqlstr = sqlstr + " WHERE dockno IN (SELECT dockno FROM webx_gatepass WHERE gatepassno='" + gp.GatePassNo + "') AND docksf='.'";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
    }

    public static DataTable GetChawlaPrintSet(string[] gatepassnos)
    {
        string sqlstr = "SELECT gatepassno,s.dockno,CONVERT(VARCHAR,dely_date,103) AS deldate,godown_name AS godown,CONVERT(VARCHAR(8),";
        sqlstr = sqlstr + " dely_date, 108) AS deltime,g.ptname, locaddr,loccitypin,loctelno,d.orgncd AS fromloc,csgenm,d.chrgwt AS WEIGHT,";
        sqlstr = sqlstr + " freight,c.mrsamt AS mramount,pkgsno,paymode,product,paymentbas, thcno,(svctax+cess+hedu_cess) AS servicetax,";
        sqlstr = sqlstr + " SCHG08,SCHG14,UCHG05,SCHG15,privatemark,name,col_oct=ISNULL(m.col_oct,0),col_octprchrg=ISNULL(m.col_octprchrg,0) FROM webx_trans_docket_status s ";
        sqlstr = sqlstr + " INNER JOIN webx_master_docket d ON d.dockno=s.[DOCKNO] ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_hdr m ON  m.dockno=d.[DOCKNO] ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_charges c ON c.mrsno= m.mrsno";
        sqlstr = sqlstr + " INNER join webx_gatepass g ON g.dockno=s.[DOCKNO] ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 name FROM webx_master_users WHERE userid=g.entryby)empnm ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 vehno AS thcno FROM webx_tchdr th,webx_tctrn tc WHERE tc.tcno=th.tcno AND tc.dockno=d.dockno ORDER BY tcdt_sys DESC)tcth ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 godown_name,godown_desc FROM webx_godownmst WHERE godown_srno=s.godown OR SPDBRCD=curr_loc)G1 ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 locaddr FROM webx_location WHERE loccode=g.gpbrcd)gaddr ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 (loccity+' - '+locpincode) AS loccitypin FROM webx_location WHERE loccode=g.gpbrcd)gcitypin ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 loctelno FROM webx_location WHERE loccode=g.gpbrcd)gteleno ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 codedesc AS product FROM webx_master_general  WHERE codetype='PROD' and codeid=prodcd)prod ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 codedesc AS paymentbas FROM webx_master_general WHERE codetype='PAYTYP' and codeid=d.paybas)paytyp ";
        sqlstr = sqlstr + " WHERE s.docksf='.' AND m.mrssf='.' AND m.mrstype='12' ";

        string strno = "";
        for (int i = 0; i < gatepassnos.Length; i++)
        {
            strno = strno + "'" + gatepassnos[i] + "',";
        }
        sqlstr = sqlstr + "AND g.gatepassno IN (" + strno.Substring(0, strno.Length - 1) + ")";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
        }
        catch (Exception ex)
        { }
        return dt;
    }
}
