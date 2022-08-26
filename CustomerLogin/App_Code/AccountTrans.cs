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
/// Summary description for AccountTrans
/// </summary>
public class AccountTrans 
{
    private string _finyear, _Voucherno, _Acccode, _Chqno, _Narration, _Payto, _ReceivedFrom, _Bookcode, _Transtype, _DocNo, _Docsf, _Brcd, _Oppaccount, _Voucher_Cancel, _Autoentry, _Opertitle, _PBOV_CODE, _PBOV_NAME, _PBOV_TYP, _Oppacccode, _Voucher_status, _Panno, _ServicetaxNo, _Billno, _Entryby, _UpdateBy, _Dockno, _Docksf, _YearSuffix, _Entryfor, _PrepareByLoc; 
    private DateTime _Transdate,_Chqdate,_Billdt, _Billduedt;
    private double _Debit, _Credit;
    private int _TransNo;
    private string connStr;
    string strdatabase;
    SqlDataReader dtr;
    public AccountTrans()
    {
        // TODO: Add constructor logic here
        //connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim(); //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
    }
    public string  Finyear 
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
    public string Voucherno
    {
        get
        {
            return _Voucherno;
        }
        set
        {
         
            _Voucherno = value;
        }
    }
    public string Acccode
    {
        get
        {
            return _Acccode;
        }
        set
        {
         
            _Acccode = value;
        }
    }
    public string Chqno
    {
        get
        {
            return _Chqno;
        }
        set
        {
            _Chqno = value;
        }
    }
    public DateTime Chqdate
    {
        get
        {
            return _Chqdate;
        }
        set
        {
            _Chqdate = value;
        }
    }
    public string Narration
    {
        get
        {
            return _Narration;
        }
        set
        {
            _Narration = value;
        }
    }
    public string Payto
    {
        get
        {
            return _Payto;
        }
        set
        {
            _Payto = value;
        }
    }
    public string ReceivedFrom
    {
        get
        {
            return _ReceivedFrom;
        }
        set
        {
            _ReceivedFrom = value;
        }
    }
    public string Transtype
    {
        get
        {
            return _Transtype;
        }
        set
        {
            _Transtype = value;
        }
    }
    public string DocNo
    {
        get
        {
            return _DocNo;
        }
        set
        {
            _DocNo = value;
        }
    }
    public string Docsf
    {
        get
        {
            return _Docsf;
        }
        set
        {
            _Docsf = value;
        }
    }
    
    public string Brcd
    {
        get
        {
            return _Brcd;
        }
        set
        {
            _Brcd = value;
        }
    }
    public string Oppaccount
    {
        get
        {
            return _Oppaccount;
        }
        set
        {
            _Oppaccount = value;
        }
    }
    public string Voucher_Cancel
    {
        get
        {
            return _Voucher_Cancel;
        }
        set
        {
            _Voucher_Cancel = value;
        }
    }
    public string Autoentry
    {
        get
        {
            return _Autoentry;
        }
        set
        {
            _Autoentry = value;
        }
    }
    public string Opertitle
    {
        get
        {
            return _Opertitle;
        }
        set
        {
            _Opertitle = value;
        }
    }
    public string PBOV_CODE
    {
        get
        {
            return _PBOV_CODE;
        }
        set
        {
            _PBOV_CODE = value;
        }
    }
     public string PBOV_NAME
    {
        get
        {
            return _PBOV_NAME;
        }
        set
        {
            _PBOV_NAME = value;
        }
    }
    public string PBOV_TYP
    {
        get
        {
            return _PBOV_TYP;
        }
        set
        {
            _PBOV_TYP = value;
        }
    }
    public string Oppacccode
    {
        get
        {
            return _Oppacccode;
        }
        set
        {
            _Oppacccode = value;
        }
    }
    public string Voucher_status
    {
        get
        {
            return _Voucher_status;
        }
        set
        {
            _Voucher_status = value;
        }
    }
    public string Panno
    {
        get
        {
            return _Panno;
        }
        set
        {
            _Panno = value;
        }
    }
    public string ServicetaxNo
    {
        get
        {
            return _ServicetaxNo;
        }
        set
        {
            _ServicetaxNo = value;
        }
    }
    public string Billno
    {
        get
        {
            return _Billno;
        }
        set
        {
            _Billno = value;
        }
    }
    public string Entryby
    {
        get
        {
            return _Entryby;
        }
        set
        {
            _Entryby = value;
        }
    }
    public string UpdateBy
    {
        get
        {
            return _UpdateBy;
        }
        set
        {
            _UpdateBy = value;
        }
    }
    public string Dockno
    {
        get
        {
            return _Dockno;
        }
        set
        {
            _Dockno = value;
        }
    }
    public string Docksf
    {
        get
        {
            return _Docksf;
        }
        set
        {
            _Docksf = value;
        }
    }
    public DateTime Transdate
    {
        get
        {
            return _Transdate;
        }
        set
        {
            _Transdate = value;
        }
    }
    
    
    public DateTime Billdt
    {
        get
        {
            return _Billdt;
        }
        set
        {
            _Billdt = value;
        }
    }
    public DateTime Billduedt
    {
        get
        {
            return _Billduedt;
        }
        set
        {
            _Billduedt = value;
        }
    }
    
   public double Debit
    {
        get
        {
            return _Debit;
        }
        set
        {
            _Debit = value;
        }
    }
    public double Credit
    {
        get
        {
            return _Credit;
        }
        set
        {
            _Credit = value;
        }
    }
    public int TransNo
    {
        get
        {
            return _TransNo;
        }
        set
        {
            _TransNo = value;
        }
    }

    public string  YearSuffix
    {
        get
        {
            return _YearSuffix;
        }
        set
        {
            _YearSuffix = value;
        }
    }
    

    public string Bookcode
    {
        get
        {
            return _Bookcode;
        }
        set
        {
            _Bookcode = value;
        }
    }
    public string Entryfor
    {
        get
        {
            return _Entryfor;
        }
        set
        {
            _Entryfor = value;
        }
    }
    public string PrepareByLoc
    {
        get
        {
            return _PrepareByLoc;
        }
        set
        {
            _PrepareByLoc = value;
        }
    }
      


    public void InsertData()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[36];

        arParms[0] = new SqlParameter("@finyear_1", SqlDbType.VarChar, 20);
        arParms[0].Value = Finyear;

        arParms[1] = new SqlParameter("@Transdate_2", SqlDbType.DateTime);
        arParms[1].Value = Transdate;

        arParms[2] = new SqlParameter("@Voucherno_3", SqlDbType.VarChar,20);
        arParms[2].Value = Voucherno;

        arParms[3] = new SqlParameter("@Acccode_4", SqlDbType.VarChar, 10);
        arParms[3].Value = Acccode;

        arParms[4] = new SqlParameter("@Chqno_5", SqlDbType.VarChar, 10);
        arParms[4].Value = Chqno;

        arParms[5] = new SqlParameter("@Chqdate_6", SqlDbType.DateTime);
        arParms[5].Value = Chqdate;

        arParms[6] = new SqlParameter("@Debit_7", SqlDbType.Float);
        arParms[6].Value = Debit;

        arParms[7] = new SqlParameter("@Credit_8", SqlDbType.Float);
        arParms[7].Value = Credit;

        arParms[8] = new SqlParameter("@Narration_9", SqlDbType.VarChar,1000);
        arParms[8].Value = Narration;

        arParms[9] = new SqlParameter("@Payto_10", SqlDbType.VarChar, 1000);
        arParms[9].Value = Payto;

        arParms[10] = new SqlParameter("@Bookcode_11", SqlDbType.VarChar, 50);
        arParms[10].Value = Bookcode;

        arParms[11] = new SqlParameter("@Transtype_12", SqlDbType.VarChar, 50);
        arParms[11].Value = Transtype;

        arParms[12] = new SqlParameter("@DocNo_13", SqlDbType.VarChar, 25);
        arParms[12].Value = DocNo;

        arParms[13] = new SqlParameter("@Docsf_14", SqlDbType.VarChar, 1);
        arParms[13].Value = Docsf;

        arParms[14] = new SqlParameter("@Brcd_15", SqlDbType.VarChar, 10);
        arParms[14].Value = Brcd;

        arParms[15] = new SqlParameter("@Oppaccount_16", SqlDbType.VarChar, 100);
        arParms[15].Value = Oppaccount;

        arParms[16] = new SqlParameter("@Entryby_17", SqlDbType.VarChar, 20);
        arParms[16].Value = Entryby;

        arParms[17] = new SqlParameter("@autoentry_18", SqlDbType.VarChar, 1);
        arParms[17].Value = Autoentry;

        arParms[18] = new SqlParameter("@opertitle_19", SqlDbType.VarChar, 50);
        arParms[18].Value = Opertitle;

        arParms[19] = new SqlParameter("@transNo_20", SqlDbType.Int, 50);
        arParms[19].Value = TransNo;

        arParms[20] = new SqlParameter("@PBOV_CODE_21", SqlDbType.VarChar, 20);
        arParms[20].Value = PBOV_CODE;

        arParms[21] = new SqlParameter("@PBOV_NAME_22", SqlDbType.VarChar, 100);
        arParms[21].Value = PBOV_NAME;

        arParms[22] = new SqlParameter("@PBOV_TYP_23", SqlDbType.VarChar, 1);
        arParms[22].Value = PBOV_TYP;

        arParms[23] = new SqlParameter("@oppacccode_24", SqlDbType.VarChar, 20);
        arParms[23].Value = Oppacccode;

        arParms[24] = new SqlParameter("@entryfor_25", SqlDbType.VarChar, 10);
        arParms[24].Value = Entryfor;

        arParms[25] = new SqlParameter("@prepareByLoc_26", SqlDbType.VarChar, 10);
        arParms[25].Value = PrepareByLoc;

        arParms[26] = new SqlParameter("@panno_27", SqlDbType.VarChar, 10);
        arParms[26].Value = Panno;

        arParms[27] = new SqlParameter("@servicetaxNo_28", SqlDbType.VarChar, 25);
        arParms[27].Value = ServicetaxNo;

        arParms[28] = new SqlParameter("@billno_29", SqlDbType.VarChar, 25);
        arParms[28].Value = Billno;

        arParms[29] = new SqlParameter("@billdt_30", SqlDbType.DateTime);
        arParms[29].Value = Billdt;

        arParms[30] = new SqlParameter("@billduedt_31", SqlDbType.DateTime);
        arParms[30].Value = Billduedt;

        arParms[31] = new SqlParameter("@UpdateBy_32", SqlDbType.VarChar,10);
        arParms[31].Value = UpdateBy;

        arParms[32] = new SqlParameter("@dockno_34", SqlDbType.VarChar, 15);
        arParms[32].Value = Dockno;

        arParms[33] = new SqlParameter("@docksf_35", SqlDbType.VarChar, 1);
        arParms[33].Value = Docksf;

        arParms[34] = new SqlParameter("@YearSuffix_36", SqlDbType.VarChar, 8);
        arParms[34].Value = YearSuffix ;

        arParms[35] = new SqlParameter("@ReceivedFrom_37", SqlDbType.VarChar, 100);
        arParms[35].Value = "";

        Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_acctrans_insert_Voucher" , arParms);  
    }

    public string  genVoucherNo(string brcd)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[3];
        
        arParms[0] = new SqlParameter("@brcd", SqlDbType.VarChar, 10);
        arParms[0].Value = brcd;

        arParms[1] = new SqlParameter("@finyear", SqlDbType.VarChar , 4);
        arParms[1].Value = HttpContext.Current.Session["FinYear"].ToString().Substring(2,2);

        
        arParms[2] = new SqlParameter("@NextVoucherNo", SqlDbType.VarChar , 25);
        arParms[2].Value = HttpContext.Current.Session["FinYearStart1"];
        arParms[2].Direction=ParameterDirection.Output;


        Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connStr, CommandType.StoredProcedure, "usp_next_VoucherNo", arParms);

        return(arParms[2].Value.ToString());
   
    }
    public string getAccountDesc(string acccode)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();
        string accdesc="";    
        string sql = "select accdesc from webx_acctinfo where acccode='" + acccode + "'";
        SqlDataReader rdr=Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr,CommandType.Text,sql);
        if (rdr.Read())
        {
            accdesc=rdr[0].ToString();
        }
        rdr.Close();
        return (accdesc);  
    }
    public string getVendorDesc(string vendorCode)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        string vendorName = "";
        string sql = "select vendorName from webx_vendor_hdr where vendorcode='" + vendorCode + "'";
        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
        if (rdr.Read())
        {
            vendorName = rdr[0].ToString();
        }
        rdr.Close();
        return (vendorName);
    }
    public string getCustomerDesc(string custCode)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        string custName = "";
        string sql = "select custnm from webx_custhdr where cust_active='Y' and custcd='" + custCode + "'";
        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
        if (rdr.Read())
        {
            custName = rdr[0].ToString();
        }
        rdr.Close();
        return (custName);
    }
    public string getOpeningBalance(string acccode, string fromDate, string toDate, string loccode, string openTable, string transTable,string individual)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[7];

        arParms[0] = new SqlParameter("@mTableName_open", SqlDbType.VarChar, 100);
        arParms[0].Value = openTable;

        arParms[1] = new SqlParameter("@mTableName_trans", SqlDbType.VarChar, 100);
        arParms[1].Value = transTable;


        arParms[2] = new SqlParameter("@acccode", SqlDbType.VarChar, 7);
        arParms[2].Value = acccode;

        arParms[3] = new SqlParameter("@mdatefrom", SqlDbType.VarChar, 12);
        arParms[3].Value = fromDate;

        arParms[4] = new SqlParameter("@mdateto", SqlDbType.VarChar, 12);
        arParms[4].Value = toDate;


        arParms[5] = new SqlParameter("@mcbs_brcd", SqlDbType.VarChar, 10);
        arParms[5].Value = loccode;

        arParms[6] = new SqlParameter("@individual", SqlDbType.VarChar, 1);
        arParms[6].Value = individual;

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_openingBalance", arParms);
        string openBalance="";
        if (rdr.Read())
        {
            openBalance = rdr[0].ToString();
        }
        rdr.Close();
        return (openBalance);
    }
    public string getOpeningBalance_DRCR(string acccode, string fromDate, string toDate, string loccode, string openTable, string transTable, string individual)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[7];

        arParms[0] = new SqlParameter("@mTableName_open", SqlDbType.VarChar, 100);
        arParms[0].Value = openTable;

        arParms[1] = new SqlParameter("@mTableName_trans", SqlDbType.VarChar, 100);
        arParms[1].Value = transTable;


        arParms[2] = new SqlParameter("@acccode", SqlDbType.VarChar, 7);
        arParms[2].Value = acccode;

        arParms[3] = new SqlParameter("@mdatefrom", SqlDbType.VarChar, 12);
        arParms[3].Value = fromDate;

        arParms[4] = new SqlParameter("@mdateto", SqlDbType.VarChar, 12);
        arParms[4].Value = toDate;


        arParms[5] = new SqlParameter("@mcbs_brcd", SqlDbType.VarChar, 10);
        arParms[5].Value = loccode;

        arParms[6] = new SqlParameter("@individual", SqlDbType.VarChar, 1);
        arParms[6].Value = individual;

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_openingDRCR", arParms);
        string openBalance = "";
        if (rdr.Read())
        {
            openBalance = rdr[0].ToString();
        }
        rdr.Close();
        return (openBalance);
    }
    public string getOpeningBalance_onlyValue(string acccode, string fromDate, string toDate, string loccode, string openTable, string transTable, string individual)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[7];

        arParms[0] = new SqlParameter("@mTableName_open", SqlDbType.VarChar, 100);
        arParms[0].Value = openTable;

        arParms[1] = new SqlParameter("@mTableName_trans", SqlDbType.VarChar, 100);
        arParms[1].Value = transTable;


        arParms[2] = new SqlParameter("@acccode", SqlDbType.VarChar, 7);
        arParms[2].Value = acccode;

        arParms[3] = new SqlParameter("@mdatefrom", SqlDbType.VarChar, 12);
        arParms[3].Value = fromDate;

        arParms[4] = new SqlParameter("@mdateto", SqlDbType.VarChar, 12);
        arParms[4].Value = toDate;


        arParms[5] = new SqlParameter("@mcbs_brcd", SqlDbType.VarChar, 10);
        arParms[5].Value = loccode;

        arParms[6] = new SqlParameter("@individual", SqlDbType.VarChar, 1);
        arParms[6].Value = individual;

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_openingBalance_onlyValue", arParms);
        string openBalance = "";
        if (rdr.Read())
        {
            openBalance = rdr[0].ToString();
        }
        rdr.Close();
        return (openBalance);
    }
    public string getValidEmployee()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_Acct_Employees");
        string empcodes = "";
        while (rdr.Read())
        {
            if (empcodes == "")
                empcodes = rdr[0].ToString();
            else
                empcodes = empcodes + "," + rdr[0].ToString();

        }
        rdr.Close();
        return (empcodes);
    }
    public string getValidCustomer()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_Acct_customers");
        string empcodes = "";
        while (rdr.Read())
        {
            if (empcodes == "")
                empcodes = rdr[0].ToString().ToUpper();
            else
                empcodes = empcodes + "," + rdr[0].ToString().ToUpper();

        }
        rdr.Close();
        return (empcodes);
    }
    public string getValidBranch()
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_Acct_Branch");
        string branchcode = "";
        while (rdr.Read())
        {
            if (branchcode == "")
                branchcode = rdr[0].ToString().ToUpper();
            else
                branchcode = branchcode + "," + rdr[0].ToString().ToUpper();
        }
        rdr.Close();
        return (branchcode);
    }
    public string getControlAcccode(string acctype)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();
       
        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = new SqlParameter("@acctype", SqlDbType.VarChar);
        arParms[0].Value = acctype;

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_getControlAccount", arParms);
        string acccode = "";
        while (rdr.Read())
        {
            acccode = rdr["acccode"].ToString();
        }
        rdr.Close();
        return (acccode);  
    }
    public string getIBTControlAcccode(string acctype)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = new SqlParameter("@acctype", SqlDbType.VarChar);
        arParms[0].Value = acctype;

        SqlDataReader rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_getIBTControlAcccode", arParms);
        string acccode = "";
        while (rdr.Read())
        {
            acccode = rdr["acccode"].ToString();
        }
        rdr.Close();
        return (acccode);
    }


    public string GetAccountCode(string Groupcode)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        DataAccess DAccess = new DataAccess();
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        string parentGroup = "", NewAccountCode = "", acct_prefix = "", Maxcode = "";
       
        SqlConnection conn = new SqlConnection(strdatabase);
        conn.Open();
        string sql = "select acct_prefix from webx_groups where groupcode='" + Groupcode + "'";
        dtr = DAccess.getreader(sql);

        while (dtr.Read())
        {
            acct_prefix = dtr["acct_prefix"].ToString();
        }
        if (acct_prefix == null || acct_prefix == "")
        {
            acct_prefix = Groupcode.Substring(0, 3);
        }
        dtr.Close();
        string whrcls = "substring(acccode,1," + acct_prefix.Length + ")='" + acct_prefix + "'";
        string selcls = "isNull(Max(Right(acccode, Len(acccode) - " + acct_prefix.Length + ") + 1),0)";
        sql = "select " + selcls + " as Maxcode from webx_acctInfo where " + whrcls;
        
        dtr = DAccess.getreader(sql);

        while (dtr.Read())
        {
            Maxcode = dtr["Maxcode"].ToString();
        }
        if (Maxcode == null || Maxcode == "")
        {
            Maxcode = "1";
        }
        int totallenght = 4 + acct_prefix.Length - Maxcode.Length;
        if (Maxcode == null || Maxcode == "")
        {
            NewAccountCode = acct_prefix.PadRight(totallenght, '0') + "1";
        }
        else
        {
            NewAccountCode = acct_prefix.PadRight(totallenght, '0') + Maxcode;
        }
        NewAccountCode = NewAccountCode.ToUpper();
        dtr.Close();
        return NewAccountCode;
    }
    public string GetGroupCode(string Groupcode)
    {
        connStr = HttpContext.Current.Session["SqlProvider"].ToString().Trim();

        DataAccess DAccess = new DataAccess();
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        string parentGroup = "", NewAccountCode = "", acct_prefix = "", Maxcode = "";

        SqlConnection conn = new SqlConnection(strdatabase);
        conn.Open();
        string sql = "select acct_prefix from webx_groups where groupcode='" + Groupcode + "'";
        dtr = DAccess.getreader(sql);

        while (dtr.Read())
        {
            acct_prefix = dtr["acct_prefix"].ToString();
            
        }
        if (acct_prefix == null || acct_prefix == "")
        {
            //if (acct_prefix == "")
            //{
            acct_prefix = Groupcode.Substring(0, 3);
            //}
            //acct_prefix = "A";
        }
        dtr.Close();
        string whrcls = "substring(Groupcode,1," + acct_prefix.Length + ")='" + acct_prefix + "'";
        string selcls = "isNull(Max(Right(Groupcode, Len(Groupcode) - " + acct_prefix.Length + ") + 1),0)";
        sql = "select " + selcls + " as Maxcode from Webx_groups where " + whrcls;

        dtr = DAccess.getreader(sql);

        while (dtr.Read())
        {
            Maxcode = dtr["Maxcode"].ToString();
        }
        if (Maxcode == null || Maxcode == "")
        {
            Maxcode = "1";
        }
        int totallenght = 3 + acct_prefix.Length - Maxcode.Length;
        if (Maxcode == null || Maxcode == "")
        {
            NewAccountCode = acct_prefix.PadRight(totallenght, '0') + "1";
        }
        else
        {
            NewAccountCode = acct_prefix.PadRight(totallenght, '0') + Maxcode;
        }
        NewAccountCode = NewAccountCode.ToUpper();
        dtr.Close();
        return NewAccountCode;
    }
}
