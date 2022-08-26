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


/// <summary>
/// Summary description for Advice
/// </summary>
/// 
public class Advice
{
    private string connStr;
    private string _adviceNo, _adviceType, _raisedOn, _raisedBy, _reason, _credit_account, _enclosed, _advice_Cancel, _finyear, _againstAdviceNo, _advGenByCd, _advAccByCd, _recvLocCd, _sendLocCd,_entryby, _advApprByCd, _adviceStatus, _advApprBrCd, _advAccBrCd, _advRecvByCd, _fromAcccode, _toAcccode, _raiseAcccode, _cancel_Reason, _cancelBy;
    private  DateTime _adviceDt, _advApprDt, _advRecvDt, _cancel_date, _advAccDt;
    private double _advice_amount, _adjusted_amount; 

   public Advice()
	{
		//
		// TODO: Add constructor logic here
        //
       //connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); 
       //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
    }

    public string AdviceNo
    {
        get
        {
            return _adviceNo;
        }
        set
        {
            _adviceNo = value;
        }
    }
    public string AdviceType
    {
        get
        {
            return _adviceType;
        }
        set
        {
            _adviceType = value;
        }
    }
    public string RaisedOn
    {
        get
        {
            return _raisedOn;
        }
        set
        {
            _raisedOn = value;
        }
    }
    public string RaisedBy
    {
        get
        {
            return _raisedBy;
        }
        set
        {
            _raisedBy = value;
        }
    }
    public string Reason
    {
        get
        {
            return _reason;
        }
        set
        {
            _reason = value;
        }
    }
    public string Credit_account
    {
        get
        {
            return _credit_account;
        }
        set
        {
            _credit_account = value;
        }
    }
    public string Enclosed
    {
        get
        {
            return _enclosed;
        }
        set
        {
            _enclosed = value;
        }
    }
    public string Advice_Cancel
    {
        get
        {
            return _advice_Cancel;
        }
        set
        {
            _advice_Cancel = value;
        }
    }
    public string Finyear
    {
        get
        {
            return _finyear;
        }
        set
        {
            _finyear = value;
        }
    }
    public string AgainstAdviceNo
    {
        get
        {
            return _againstAdviceNo;
        }
        set
        {
            _againstAdviceNo = value;
        }
    }
    public string AdvGenByCd
    {
        get
        {
            return _advGenByCd;
        }
        set
        {
            _advGenByCd = value;
        }
    }
    public string AdvAccByCd
    {
        get
        {
            return _advAccByCd;
        }
        set
        {
            _advAccByCd = value;
        }
    }
    public string RecvLocCd
    {
        get
        {
            return _recvLocCd;
        }
        set
        {
            _recvLocCd = value;
        }
    }
    public string SendLocCd
    {
        get
        {
            return _sendLocCd;
        }
        set
        {
            _sendLocCd = value;
        }
    }
    public string Entryby
    {
        get
        {
            return _entryby;
        }
        set
        {
            _entryby = value;
        }
    }
    
    public string AdvApprByCd
    {
        get
        {
            return _advApprByCd;
        }
        set
        {
            _advApprByCd = value;
        }
    }
    public string AdviceStatus
    {
        get
        {
            return _adviceStatus;
        }
        set
        {
            _adviceStatus = value;
        }
    }
     public string AdvApprBrCd
    {
        get
        {
            return _advApprBrCd;
        }
        set
        {
            _advApprBrCd = value;
        }
    }
     public string AdvAccBrCd
    {
        get
        {
            return _advAccBrCd;
        }
        set
        {
            _advAccBrCd = value;
        }
    }
     public string AdvRecvByCd
    {
        get
        {
            return _advRecvByCd;
        }
        set
        {
            _advRecvByCd = value;
        }
    }
    public string FromAcccode
    {
        get
        {
            return _fromAcccode;
        }
        set
        {
            _fromAcccode = value;
        }
    }
    public string ToAcccode
    {
        get
        {
            return _toAcccode;
        }
        set
        {
            _toAcccode = value;
        }
    }
    public string RaiseAcccode
    {
        get
        {
            return _raiseAcccode;
        }
        set
        {
            _raiseAcccode = value;
        }
    }
    public string Cancel_Reason
    {
        get
        {
            return _cancel_Reason;
        }
        set
        {
            _cancel_Reason = value;
        }
    }
    public string CancelBy
    {
        get
        {
            return _cancelBy;
        }
        set
        {
            _cancelBy = value;
        }
    }
    public DateTime AdviceDt
    {
        get
        {
            return _adviceDt;
        }
        set
        {
            _adviceDt = value;
        }
    }
     public DateTime  AdvApprDt
    {
        get
        {
            return _advApprDt;
        }
        set
        {
            _advApprDt = value;
        }
    }
    public DateTime  Cancel_date
    {
        get
        {
            return _cancel_date;
        }
        set
        {
            _cancel_date = value;
        }
    }
    public DateTime  AdvAccDt
    {
        get
        {
            return AdvAccDt;
        }
        set
        {
            AdvAccDt = value;
        }
    }
    public double Advice_amount
    {
        get
        {
            return _advice_amount;
        }
        set
        {
            _advice_amount = value;
        }
    }
    public double Adjusted_amount
    {
        get
        {
            return _adjusted_amount;
        }
        set
        {
            _adjusted_amount = value;
        }
    }
    
    public void InsertData()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); 
        try
        {
        SqlParameter[] arParms = new SqlParameter[21];

        arParms[0] = new SqlParameter("@Adviceno_1", SqlDbType.VarChar, 20);
        arParms[0].Value = AdviceNo;

        arParms[1] = new SqlParameter("@AdviceDt_2", SqlDbType.DateTime);
        arParms[1].Value = AdviceDt;

        arParms[2] = new SqlParameter("@Advicetype_3", SqlDbType.VarChar,1);
        arParms[2].Value = AdviceType;

        arParms[3] = new SqlParameter("@RaisedOn_4", SqlDbType.VarChar,10);
        arParms[3].Value = RaisedOn ;

        arParms[4] = new SqlParameter("@RaisedBy_5", SqlDbType.VarChar,10);
        arParms[4].Value = RaisedBy;

        arParms[5] = new SqlParameter("@advice_amount_6", SqlDbType.Float);
        arParms[5].Value = Advice_amount ;

        arParms[6] = new SqlParameter("@adjusted_amount_7", SqlDbType.Float);
        arParms[6].Value = Adjusted_amount;

        arParms[7] = new SqlParameter("@reason_8", SqlDbType.VarChar,255 );
        arParms[7].Value = Reason;

        arParms[8] = new SqlParameter("@credit_account_9", SqlDbType.VarChar,10);
        arParms[8].Value = Credit_account;

        arParms[9] = new SqlParameter("@enclosed_10", SqlDbType.VarChar,255 );
        arParms[9].Value = Enclosed;

        arParms[10] = new SqlParameter("@finyear_11", SqlDbType.VarChar,10 );
        arParms[10].Value = Finyear;

        arParms[11] = new SqlParameter("@againstadviceno_12", SqlDbType.VarChar,25);
        arParms[11].Value = AgainstAdviceNo;

        arParms[12] = new SqlParameter("@AdvGenByCd_13", SqlDbType.VarChar,10 );
        arParms[12].Value = AdvGenByCd;

        arParms[13] = new SqlParameter("@AdvApprDt_14", SqlDbType.DateTime);
        arParms[13].Value = AdvApprDt;

        arParms[14] = new SqlParameter("@SendLocCd_15", SqlDbType.VarChar,10 );
        arParms[14].Value = SendLocCd;

        arParms[15] = new SqlParameter("@entryby_16", SqlDbType.VarChar,10 );
        arParms[15].Value = Entryby ;

        arParms[16] = new SqlParameter("@AdvApprByCd_17", SqlDbType.VarChar ,10);
        arParms[16].Value = AdvApprByCd;

        arParms[17] = new SqlParameter("@adviceStatus_18", SqlDbType.VarChar,15);
        arParms[17].Value = AdviceStatus;

        arParms[18] = new SqlParameter("@AdvApprBrCd_19", SqlDbType.VarChar,10);
        arParms[18].Value = AdvApprBrCd;

        arParms[19] = new SqlParameter("@fromAcccode_20", SqlDbType.VarChar,10);
        arParms[19].Value = FromAcccode;

        arParms[20] = new SqlParameter("@raiseacccode_22", SqlDbType.VarChar, 10);
        arParms[20].Value = RaiseAcccode;

        SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_Advice_insertData", arParms);

        SqlParameter[] arParms1 = new SqlParameter[3];

        arParms1[0] = new SqlParameter("@transNo", SqlDbType.Int);
        arParms1[0].Value = 1;

        arParms1[1] = new SqlParameter("@docNo", SqlDbType.VarChar,25);
        arParms1[1].Value = AdviceNo;

        arParms1[2] = new SqlParameter("@finYear", SqlDbType.VarChar,4);
        arParms1[2].Value = Finyear.Substring(2,2);

        SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_AdviceTransaction", arParms1);
  
        }
        catch (Exception e1)
        {
            string errorMsg = "Error" + e1.Message;
        }
    }
    public string genAdviceNo(string brcd,string Finyear)
    {
        
        string NewCode = "";
      
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_next_advice_code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = brcd.Trim();
        cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = Finyear.Trim();
        cmd.Parameters.Add("@NextAdviceNo", SqlDbType.VarChar).Value = Finyear.Trim();
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            NewCode = Convert.ToString(dr["NewCode"]);
        }

        if (NewCode == null) NewCode = "";
        return NewCode;


    }
    public DataSet getAdvAckList(string adviceno, string datefrom, string dateto)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); 
        SqlParameter[] arParms = new SqlParameter[4];

        arParms[0] = new SqlParameter("@datefrom", SqlDbType.VarChar, 12);
        arParms[0].Value = datefrom;

        arParms[1] = new SqlParameter("@dateto", SqlDbType.VarChar, 12);
        arParms[1].Value = dateto;

        arParms[2] = new SqlParameter("@adviceNo", SqlDbType.VarChar, 25);
        arParms[2].Value = adviceno;

        arParms[3] = new SqlParameter("@raisedOn", SqlDbType.VarChar, 10);
        arParms[3].Value = HttpContext.Current.Session["brcd"].ToString();

        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.StoredProcedure, "usp_Advice_Acknowledge", arParms);

        return (ds);
    }

    public void AcceptAdvice(string AdviceNo1,string ToAcccode,DateTime AccDate)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); 
        SqlParameter[] arParms = new SqlParameter[8];

        arParms[0] = new SqlParameter("@Adviceno_1", SqlDbType.VarChar, 15);
        arParms[0].Value = AdviceNo1;

        arParms[1] = new SqlParameter("@AdvAccByCd_2", SqlDbType.VarChar, 5);
        arParms[1].Value = HttpContext.Current.Session["empcd"].ToString();

        arParms[2] = new SqlParameter("@AdvRecvDt_3", SqlDbType.DateTime);
        arParms[2].Value = AccDate;

        arParms[3] = new SqlParameter("@RecvLocCd_4", SqlDbType.VarChar, 10);
        arParms[3].Value = HttpContext.Current.Session["brcd"].ToString(); 

        arParms[4] = new SqlParameter("@AdvAccBrCd_6", SqlDbType.VarChar, 10);
        arParms[4].Value = HttpContext.Current.Session["brcd"].ToString();

        arParms[5] = new SqlParameter("@AdvRecvByCd_7", SqlDbType.VarChar, 5);
        arParms[5].Value = HttpContext.Current.Session["empcd"].ToString();

        arParms[6] = new SqlParameter("@Toacccode_8", SqlDbType.VarChar, 7);
        arParms[6].Value = ToAcccode;

        arParms[7] = new SqlParameter("@AdvAccDt_10", SqlDbType.DateTime);
        arParms[7].Value = AccDate;

        SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_Advice_updateData", arParms);

        SqlParameter[] arParms1 = new SqlParameter[3];

        arParms1[0] = new SqlParameter("@transNo", SqlDbType.Int);
        arParms1[0].Value = 2;

        arParms1[1] = new SqlParameter("@docNo", SqlDbType.VarChar, 25);
        arParms1[1].Value = AdviceNo1;

        string Finyear = HttpContext.Current.Session["FinYear"].ToString(); ;
                

        arParms1[2] = new SqlParameter("@finYear", SqlDbType.VarChar, 4);
        arParms1[2].Value = Finyear.Substring(2, 2);

        SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_AdviceTransaction", arParms1);
  

    }
    public string getValidLocation()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); 
       SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_advice_locations");
       string loccodes = "";
        while(rdr.Read())
       {
           if (loccodes=="")
              loccodes= rdr[0].ToString();
           else
               loccodes=loccodes + ","+ rdr[0].ToString();

       }
       rdr.Close();
       return (loccodes);
    }
  }
