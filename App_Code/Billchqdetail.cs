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
/// Summary description for billchqdetail
/// </summary>
public class Billchqdetail
{
    private string connStr;
    private string _chqno,_banknm,_bankbrn,_docno,_doctype,_docsf,_bankcd,_transfor,_chkacct;
    private DateTime _chqdt;
    private double _chqamt, _clamt;

	public Billchqdetail()
	{
		//
		// TODO: Add constructor logic here
		//
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
   	}
    public string Chqno
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
    public DateTime Chqdt
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
    public double Chqamt
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
    public double  Clamt
    {
        get
        {
            return _clamt;
        }
        set
        {
            _clamt = value;
        }
    }
    
    public string Banknm
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
    public string Bankbrn
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
    public string DocType
    {
        get
        {
            return _doctype;
        }
        set
        {
            _doctype = value;
        }
    }
   public string DocNo
    {
        get
        {
            return _docno;
        }
        set
        {
            _docno = value;
        }
    }
    public string DocSf
    {
        get
        {
            return _docsf;
        }
        set
        {
            _docsf = value;
        }
    }
    public string Bankcd
    {
        get
        {
            return _bankcd;
        }
        set
        {
            _bankcd = value;
        }
    }
    public string Transfor
    {
        get
        {
            return _transfor;
        }
        set
        {
            _transfor = value;
        }
    }
    public string ChkAcct
    {
        get
        {
            return _chkacct;
        }
        set
        {
            _chkacct = value;
        }
    }
    public void InsertData()
    {
        SqlParameter[] arParms = new SqlParameter[12];

        arParms[0] = new SqlParameter("@CHQNO_1", SqlDbType.VarChar, 10);
        arParms[0].Value = Chqno;

        arParms[1] = new SqlParameter("@CHQDT_2", SqlDbType.DateTime);
        arParms[1].Value = Chqdt;

        arParms[2] = new SqlParameter("@CHQAMT_3", SqlDbType.Float);
        arParms[2].Value = Chqamt;

        arParms[3] = new SqlParameter("@CLAMT_4", SqlDbType.Float);
        arParms[3].Value = Clamt ;

        arParms[4] = new SqlParameter("@BANKNM_5", SqlDbType.VarChar, 20);
        arParms[4].Value = Banknm ;

        arParms[5] = new SqlParameter("@BANKBRN_6", SqlDbType.VarChar, 30);
        arParms[5].Value = Bankbrn;

        arParms[6] = new SqlParameter("@DOCTYPE_7", SqlDbType.VarChar, 100);
        arParms[6].Value = DocType;

        arParms[7] = new SqlParameter("@DOCNO_8", SqlDbType.VarChar, 25);
        arParms[7].Value = DocNo ;

        arParms[8] = new SqlParameter("@DOCSF_9", SqlDbType.VarChar, 1);
        arParms[8].Value = DocSf ;
       
        arParms[9] = new SqlParameter("@bankcd_10", SqlDbType.VarChar, 25);
        arParms[9].Value = Bankcd ;
        
        arParms[10] = new SqlParameter("@transfor_11", SqlDbType.VarChar, 25);
        arParms[10].Value = Transfor;

        arParms[11] = new SqlParameter("@CHKACCT_12", SqlDbType.VarChar, 1);
        arParms[11].Value = "N";

        

        SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_billchqdetail_insertData", arParms);
    }
    public DataSet getBillChqDetail_docwise(string docno)
    {
        DataSet dt = SqlHelper.ExecuteDataset(connStr, CommandType.StoredProcedure, "usp_billchqdetail_selectdata_docwise");
        return(dt);
    }
}
