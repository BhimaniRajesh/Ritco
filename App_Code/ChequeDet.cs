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

/// <summary>
/// Summary description for ChequeDet
/// </summary>
public class ChequeDet
{
	    public ChequeDet()
	    {
		    //
		    // TODO: Add constructor logic here
		    //
            connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];

  
        }
        private string connStr;
        private string _chqno, _ptmsptcd, _ptmsptnm, _banknm, _bankbrn, _comments, _owncust, _recdbrcd, _chq_flag, _brcd, _empcd, _voucherno, _depoflag, _acccode, _depoloccode, _chq_status, _chq_trf, _chq_clear;
        private DateTime _chqdt, _chq_bounce_dt, _chq_reoffer_dt, _transdate;
        private float _adjustamt, _chqamt, _chq_bounceamt;
        private int _chq_depattempt;

        public string  Chqno 
        {
            get
            {
                return _chqno;
            }
            set
            {
               _chqno = value;
            }
        }
        public DateTime  Chqdt 
        {
            get
            {
                return _chqdt;
            }
            set
            {
               _chqdt = value;
            }
        }
        public float Chqamt 
            {
                get
                {
                    return _chqamt;
                }
                set
                {
                   _chqamt = value;
                }
            }
        public float Adjustamt 
        {
            get
            {
                return _adjustamt;
            }
            set
            {
               _adjustamt = value;
            }
        }
        public string  Ptmsptcd 
        {
            get
            {
                return _ptmsptcd;
            }
            set
            {
               _ptmsptcd = value;
            }
        }
        public string  Ptmsptnm 
        {
            get
            {
                return _ptmsptnm;
            }
            set
            {
               _ptmsptnm = value;
            }
        }
        public string  Banknm 
        {
            get
            {
                return _banknm;
            }
            set
            {
               _banknm = value;
            }
        }
        public string  Bankbrn 
        {
            get
            {
                return _bankbrn;
            }
            set
            {
               _bankbrn = value;
            }
        }
        public string  Comments 
        {
            get
            {
                return _comments;
            }
            set
            {
               _comments = value;
            }
        }
        public string  OwnCust 
        {
            get
            {
                return _owncust;
            }
            set
            {
               _owncust = value;
            }
        }
        public string  Brcd 
        {
            get
            {
                return _brcd;
            }
            set
            {
               _brcd = value;
            }
        }
    
        public string  Empcd 
        {
            get
            {
                return _empcd;
            }
            set
            {
               _empcd = value;
            }
        }
        
        public string  Voucherno 
        {
            get
            {
                return _voucherno;
            }
            set
            {
               _voucherno = value;
            }
        }
        public string  Depoflag 
        {
            get
            {
                return _depoflag;
            }
            set
            {
               _depoflag = value;
            }
        }
        public string  Acccode 
        {
            get
            {
                return _acccode;
            }
            set
            {
               _acccode = value;
            }
        }

        public DateTime Transdate 
        {
            get
            {
                return _transdate;
            }
            set
            {
               _transdate = value;
            }
        }
        public string  Depoloccode 
        {
            get
            {
                return _depoloccode;
            }
            set
            {
               _depoloccode = value;
            }
        }
        public DateTime Chq_bounce_dt
        {
            get
            {
                return _chq_bounce_dt;
            }
            set
            {
               _chq_bounce_dt = value;
            }
        }
        public DateTime Chq_reoffer_dt
        {
            get
            {
                return _chq_reoffer_dt;
            }
            set
            {
               _chq_reoffer_dt = value;
            }
        }
        public float Chq_bounceamt
        {
            get
            {
                return _chq_bounceamt;
            }
            set
            {
               _chq_bounceamt = value;
            }
        }
       
        public string Chq_status
        {
            get
            {
                return _chq_status;
            }
            set
            {
               _chq_status = value;
            }
        }
        public int Chq_depattempt
        {
            get
            {
                return _chq_depattempt;
            }
            set
            {
               _chq_depattempt = value;
            }
        }
        public string Chq_clear
        {
            get
            {
                return _chq_clear;
            }
            set
            {
               _chq_clear = value;
            }
        }
    
        public string Recdbrcd
        {
            get
            {
                return _recdbrcd;
            }
            set
            {
               _recdbrcd = value;
            }
        }
        public string Chq_flag
        {
            get
            {
                return _chq_flag;
            }
            set
            {
               _chq_flag = value;
            }
        }

    public string Chq_trf
    {
        get
        {
            return _chq_trf;
        }
        set
        {
            _chq_trf = value;
        }    
    }


    public void InsertData()
    {
        try
        {

            SqlParameter[] arParms = new SqlParameter[21];

            arParms[0] = new SqlParameter("@chqno_1", SqlDbType.VarChar, 10);
            arParms[0].Value = Chqno;

            arParms[1] = new SqlParameter("@chqdt_2", SqlDbType.DateTime);
            arParms[1].Value = Chqdt;

            arParms[2] = new SqlParameter("@chqamt_3", SqlDbType.Float);
            arParms[2].Value = Chqamt;

            arParms[3] = new SqlParameter("@banknm_4", SqlDbType.VarChar, 100);
            arParms[3].Value = Banknm;

            arParms[4] = new SqlParameter("@ptmsptcd_5", SqlDbType.VarChar, 20);
            arParms[4].Value = Ptmsptcd;

            arParms[5] = new SqlParameter("@ptmsptnm_6", SqlDbType.VarChar, 100);
            arParms[5].Value = Ptmsptnm;

            arParms[6] = new SqlParameter("@comments_7", SqlDbType.VarChar, 255);
            arParms[6].Value = Comments;

            arParms[7] = new SqlParameter("@brcd_8", SqlDbType.VarChar, 8);
            arParms[7].Value = Brcd;

            arParms[8] = new SqlParameter("@empcd_9", SqlDbType.VarChar, 10);
            arParms[8].Value = Empcd;

            arParms[9] = new SqlParameter("@adjustamt_10", SqlDbType.Float);
            arParms[9].Value = Adjustamt;

            arParms[10] = new SqlParameter("@BANKBRN_11", SqlDbType.VarChar, 100);
            arParms[10].Value = Bankbrn;

            arParms[11] = new SqlParameter("@chq_trf_12", SqlDbType.VarChar, 8);
            arParms[11].Value = Chq_trf;

            arParms[12] = new SqlParameter("@chq_flag_13", SqlDbType.VarChar, 1);
            arParms[12].Value = Chq_flag;

            arParms[13] = new SqlParameter("@recdbrcd_14", SqlDbType.VarChar, 8);
            arParms[13].Value = Recdbrcd;

            arParms[14] = new SqlParameter("@OwnCust_15", SqlDbType.VarChar, 1);
            arParms[14].Value = OwnCust;

            arParms[15] = new SqlParameter("@DepoFlag_16", SqlDbType.VarChar, 1);
            arParms[15].Value = Depoflag;

            arParms[16] = new SqlParameter("@voucherNo_17", SqlDbType.VarChar, 20);
            arParms[16].Value = Voucherno;

            arParms[17] = new SqlParameter("@acccode_18", SqlDbType.VarChar, 7);
            arParms[17].Value = Acccode;

            arParms[18] = new SqlParameter("@transdate_19", SqlDbType.DateTime);
            arParms[18].Value = Transdate;

            arParms[19] = new SqlParameter("@depoloccode_20", SqlDbType.VarChar, 8);
            arParms[19].Value = Depoloccode;

            arParms[20] = new SqlParameter("@chq_status_21", SqlDbType.VarChar, 100);
            arParms[20].Value = Chq_status;

            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_WEBX_chq_det_insertData", arParms);

            //calling accounting entry for on account entry 

           
        }
        catch (Exception e1)
        {
            string errorMsg = "Error" + e1.Message;
        }
    }
    public void OnAccountEntry()
    {
            SqlParameter[] arParms = new SqlParameter[4];

            arParms[0] = new SqlParameter("@transNo", SqlDbType.Int);
            arParms[0].Value = 1;

            arParms[1] = new SqlParameter("@chqno", SqlDbType.VarChar,6);
            arParms[1].Value = Chqno;

            arParms[2] = new SqlParameter("@chqdate", SqlDbType.DateTime);
            arParms[2].Value = Chqdt;

            arParms[3] = new SqlParameter("@finYear", SqlDbType.VarChar, 4);
            arParms[3].Value = HttpContext.Current.Session["FinYear"].ToString();

            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure,"usp_ChequeTransaction" ,arParms);
    }

    public DataSet getChkDepList(string chqNo, string datefrom, string dateto)
    {
        SqlParameter[] arParms = new SqlParameter[4];

        arParms[0] = new SqlParameter("@datefrom", SqlDbType.VarChar, 12);
        arParms[0].Value = datefrom;

        arParms[1] = new SqlParameter("@dateto", SqlDbType.VarChar, 12);
        arParms[1].Value = dateto;

        arParms[2] = new SqlParameter("@CHQNO", SqlDbType.VarChar, 25);
        arParms[2].Value = chqNo;

        arParms[3] = new SqlParameter("@COLBRCD", SqlDbType.VarChar, 10);
        arParms[3].Value = HttpContext.Current.Session["brcd"].ToString();

        DataSet ds = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(connStr, CommandType.StoredProcedure, "usp_depovoucher_chqlist", arParms);

        return (ds);
    }

    public void updChequeDeposit(string lstchqno, string lstchqdt, string lstchqamt, DateTime voucherDate, string Narration, string bankAcccode)
    {
        SqlParameter[] arParms = new SqlParameter[10];

        arParms[0] = new SqlParameter("@LSTCHQNO", SqlDbType.VarChar, 8000);
        arParms[0].Value = lstchqno;

        arParms[1] = new SqlParameter("@LSTCHQDT", SqlDbType.VarChar, 8000);
        arParms[1].Value = lstchqdt;

        arParms[2] = new SqlParameter("@LSTCHQAMT", SqlDbType.VarChar, 8000);
        arParms[2].Value = lstchqamt.Trim(); ;

        arParms[3] = new SqlParameter("@narration", SqlDbType.VarChar, 1000);
        arParms[3].Value = Narration.Trim();

        arParms[4] = new SqlParameter("@transdate", SqlDbType.DateTime);
        arParms[4].Value = voucherDate;

        arParms[5] = new SqlParameter("@bankacccode", SqlDbType.VarChar, 7);
        arParms[5].Value = bankAcccode.Trim();

        arParms[6] = new SqlParameter("@brcd", SqlDbType.VarChar, 8);
        arParms[6].Value = HttpContext.Current.Session["brcd"].ToString().Trim();

        arParms[7] = new SqlParameter("@finYear", SqlDbType.VarChar,4);
        string date = HttpContext.Current.Session["FinYearStart1"].ToString().Trim();
        arParms[7].Value = date; 

        arParms[8] = new SqlParameter("@entryBy", SqlDbType.VarChar, 10);
        arParms[8].Value = HttpContext.Current.Session["empcd"].ToString().Trim();

        arParms[9] = new SqlParameter("@NewVoucherNumber", SqlDbType.VarChar, 25);
        arParms[9].Direction = ParameterDirection.Output;

        Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_update_chqDepositVoucher", arParms);

        _voucherno = arParms[9].Value.ToString();
    }
}
