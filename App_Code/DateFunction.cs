using System;
using System.Data;
using System.Text;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;

/// <summary>
/// Summary description for DateFunction
/// </summary>
public class DateFunction
{
    public string rev_strDate_time, tempYear, tempDate;
    string tempMonth, ducument_date;
    string str_tempDate, str_tempYear;
    int str_tempMonth;
    string str, strConnString, strdatabase;
    DataAccess data = new DataAccess();
	public DateFunction()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Converts string to date.
    /// </summary>
    /// <param name="strDate">Date string : it should be in dd/MM/yyyy formate</param>
    /// <returns>returns DateTime object, if entered date format is invalid, empty or null it will return DateTime.MinValue</returns>
    public static DateTime ConvertStringToDate(string strDate)
    {
        DateTime dtReturn = DateTime.MinValue;
        try
        {
            if (!String.IsNullOrEmpty(strDate.Trim()))
            {
                string[] strTemp = strDate.Trim().Split('/');
                dtReturn = Convert.ToDateTime(strTemp[1] + "/" + strTemp[0] + "/" + strTemp[2]);
            }
        }
        catch (Exception ex)
        { }
        return dtReturn;
    }
    
    public string monthName(string number)
    {
        string fullName="";
        if (number != "")
        {
            Int16 mum = 0;
            mum =Convert.ToInt16(number);
            fullName = MonthNameFull(mum);
        }
        return fullName; 
    }
    static string MonthNameFull(int str_tempMonth)
    {
        switch (str_tempMonth)
        {
            case 1: return ("January");
            case 2: return ("February");
            case 3: return ("March");
            case 4: return ("April");
            case 5: return ("May");
            case 6: return ("June");
            case 7: return ("July");
            case 8: return ("August");
            case 9: return ("September");
            case 10: return ("October");
            case 11: return ("November");
            case 12: return ("December");
            default: return ("Illegal month");
        }
    }
    public string returnmmddyyyy_format(string ddmmyyyy)
    {
        if (ddmmyyyy == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = ddmmyyyy;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { ' ' };
            arDate_time = date_time.Split(split_arDate_time);
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = (arDate_time[1]).ToString();
                tempYear = arDate_time[2];
            }

            string fdt = Rev_MonthName(tempMonth) + "/" + System.Convert.ToString(tempDate) + "/" + System.Convert.ToString(tempYear);

            return fdt;
        }
    }
    public string return_date_fun(string rev_strDate_time)
    {
        if (rev_strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = rev_strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { ' ' };
            arDate_time = date_time.Split(split_arDate_time);
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = (arDate_time[1]).ToString();
                tempYear = arDate_time[2];
            }

            string fdt = System.Convert.ToString(tempDate) + "/" + Rev_MonthName(tempMonth) + "/" + System.Convert.ToString(tempYear);
            return fdt;
        }

    }
    static string Rev_MonthName(string month)
    {
        switch (month)
        {
            case "Jan": return ("01");
            case "Feb": return ("02");
            case "Mar": return ("03");
            case "Apr": return ("04");
            case "May": return ("05");
            case "Jun": return ("06");
            case "Jul": return ("07");
            case "Aug": return ("08");
            case "Sep": return ("09");
            case "Oct": return ("10");
            case "Nov": return ("11");
            case "Dec": return ("12");
            default: return ("Illegal month");
        }
    }
    public string return_date(string strDate_time)
    {

        if (strDate_time == "")
        {
            string fdt_date = "";
            return fdt_date;
        }
        else
        {
            string strDateTime = strDate_time;
            string[] str_arDate_time = new string[3];
            char[] str_split_arDate_time = { '/' };
            str_arDate_time = strDateTime.Split(str_split_arDate_time);
            for (int x = 0; x < str_arDate_time.Length; x++)
            {
                str_tempDate = str_arDate_time[0].ToString().Trim();
                str_tempMonth = Convert.ToInt16(str_arDate_time[1]);
                str_tempYear = str_arDate_time[2];
            }
        }
        string fdt = System.Convert.ToString(str_tempDate) + " " + MonthName1(str_tempMonth) + " " + System.Convert.ToString(str_tempYear);
        return fdt;
    }
    public static string MonthName1(int str_tempMonth)
    {
        switch (str_tempMonth)
        {
            case 1: return ("Jan");
            case 2: return ("Feb");
            case 3: return ("Mar");
            case 4: return ("Apr");
            case 5: return ("May");
            case 6: return ("Jun");
            case 7: return ("Jul");
            case 8: return ("Aug");
            case 9: return ("Sep");
            case 10: return ("Oct");
            case 11: return ("Nov");
            case 12: return ("Dec");
            default: return ("Illegal month");
        }
    }

    public DataSet getdataset(string qry)
    {

        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        DataSet ds = new DataSet();
        DataTable dt = ds.Tables.Add("temp");
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        ad.Fill(ds.Tables[0]);
        con.Close();
        return (ds);
    }
    public DataTable gettable(string qry)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase]; ;
        SqlConnection con = new SqlConnection(strdatabase);

        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        DataTable dt = new DataTable();
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        ad.Fill(dt);
        con.Close();
        return (dt);

    }
    public SqlDataReader getreader(string qry)
    {
	SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        //strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //SqlConnection con = new SqlConnection(strdatabase);

        SqlCommand cmd = new SqlCommand();
        if (con.State == ConnectionState.Closed)
        con.Open();
        cmd.CommandText = qry;
        cmd.Connection = con;
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        SqlDataReader dr;
        dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        
        return (dr);

    }
    public void executeqery(string qry)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        cmd.ExecuteNonQuery();
        con.Close();

    }
    public string executescalar(string qry)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);

        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        string str = cmd.ExecuteScalar().ToString();
        cmd.Dispose();
        con.Close();

        return (str);


    }
    public object intscalar(string qry)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);

        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        object o = cmd.ExecuteScalar();

        con.Close();
        return (o);

    }
    public string exescalar(string qry)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);

        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = qry;
        cmd.Connection = con;
        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        string str = (string)cmd.ExecuteScalar();
        con.Close();
        return (str);
    }
    public void bindgrid(System.Web.UI.WebControls.DataGrid dg, string qry)
    {
        DataSet ds = new DataSet();
        ds = getdataset(qry);
        dg.DataSource = ds.Tables[0];
        dg.DataBind();
    }
    public string EncryptDecrypt(string textToEncrypt)
    {

        int key = 129;
        StringBuilder inSb = new StringBuilder(textToEncrypt);
        StringBuilder outSb = new StringBuilder(textToEncrypt.Length);
        char c;
        for (int i = 0; i < textToEncrypt.Length; i++)
        {
            c = inSb[i];
            c = (char)(c ^ key);
            outSb.Append(c);
        }
        return outSb.ToString();
    }
    public string getCustomer(string custcd)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);

        string custName;
        string sql = "select CustNm from webx_Custhdr where Custcd='" + custcd + "'";
        con.Open();
        SqlDataReader dtr = getreader(sql);
        custName = "";
        while (dtr.Read())
        {
            custName = dtr["CustNm"].ToString().Trim();
        }
        dtr.Close();
        return custName;
    }
    public string getAccountDesc(string acccode)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);
        string accdesc;
        string ATableName = "webx_acctinfo";
        
        string sql = "select accdesc from " + ATableName + " where acccode='" + acccode + "'";
        
        con.Open();
        SqlDataReader dtr = getreader(sql);
        accdesc = "";
        while (dtr.Read())
        {
            accdesc = dtr["accdesc"].ToString().Trim();
        }
        dtr.Close();
        return accdesc;
    }
    public string getLocationDesc(string loccode)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        //strConnString = System.Configuration.ConfigurationSettings.AppSettings[strdatabase];
        SqlConnection con = new SqlConnection(strdatabase);

        string locName;
        string ATableName = "WebX_Location";
        string sql = "select LocName from " + ATableName + " where LocCode='" + loccode + "'";
        con.Open();
        SqlDataReader dtr = getreader(sql);
        locName = "";
        while (dtr.Read())
        {
            locName = dtr["LocName"].ToString().Trim();
        }
        dtr.Close();
        return locName;
    }
    public string getvendor(string vendcd)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);

        string VendName;
        string sql = "select accthead from webx_VENDOR_HDR m,webx_VENDOR_TYPE d  where m.vendor_type=d.type_code and m.VENDORCODE='" + vendcd + "'";
        con.Open();
        SqlDataReader dtr = getreader(sql);
        VendName = "";
        while (dtr.Read())
        {
            VendName = dtr["accthead"].ToString().Trim();
        }
        dtr.Close();
        return VendName;
    }
    public string getEmpname(string empcd)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);

        string Empname;
        string sql = "Select empnm from  webx_EMPMST where empcd = '" + empcd + "'";
        con.Open();
        SqlDataReader dtr = getreader(sql);
        Empname = "";
        while (dtr.Read())
        {
            Empname = dtr["empnm"].ToString().Trim();
        }
        dtr.Close();
        return Empname;
    }
    public string getOpenBal_MIS(string acccode, string enddate, string AcctOpenTable, string AcctTransTable, string AccBrcd, string mindividual)
    {
        double opendebit1=0;
        double opencredit1=0;
        double currcredit1=0;
        double currdebit1=0;
        string ReturnCurrBalBC = "";
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);

        //string openBal = "";
        string stropendebit = "";
        string stropencredit="";
        string strcurrcredit="";
        string strcurrdebit="";
        string sql="" ;
        string sql1= "";
        string cbs_brcd = AccBrcd;
        SqlDataReader dtr;
        
        //double  opendebit, opencredit;
        double closedebit, closecredit;
      
        closedebit = 0;
        closecredit = 0;
        if (mindividual == "N")
        {
            sql = "select opendebit + opendebit_i as opendebit,opencredit + opencredit_i as opencredit from " + AcctOpenTable + " where acccode='" + acccode + "' and brcd='" + AccBrcd + "'";
        }
        else
        {
            sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " + AcctOpenTable + " where acccode='" + acccode + "' and brcd='" + AccBrcd + "'";
        }
        con.Open();
        stropendebit = "";
        stropencredit = "";
        dtr = getreader(sql);
        while (dtr.Read())
        {
            stropendebit = dtr["opendebit"].ToString() + "0";
             opendebit1 = opendebit1 + Convert.ToDouble(stropendebit) ;
            stropencredit = dtr["opencredit"].ToString() + "0";
             opencredit1 = opencredit1 + Convert.ToDouble(stropencredit);
        }
        dtr.Close();
        con.Close();
        string datefrom = "01 Jan 2000";
        DateTime mdatefrom = Convert.ToDateTime("01/01/2000");
        string DateValuemdateto = returnmmddyyyy_format(enddate);
        DateTime Datefun = Convert.ToDateTime(DateValuemdateto);
        if (mdatefrom <= Datefun)
        {
            sql1 = "exec webx_cbs_mis " + AcctTransTable + ",'" + acccode + "','" + datefrom + "','" + enddate + "', '" + cbs_brcd + "','" + mindividual + "'";
            dtr = getreader(sql1);
            while (dtr.Read())
            {
                 strcurrcredit = dtr["credit"].ToString() ;
                 currcredit1 = currcredit1 + Convert.ToDouble(strcurrcredit);
                 strcurrdebit = dtr["debit"].ToString() ;
                 currdebit1 = currdebit1 + Convert.ToDouble(strcurrdebit);
            }
            dtr.Close();
            con.Close();
        }
        closedebit = opendebit1 + currdebit1;
        closecredit = opencredit1 + currcredit1;

        if (closedebit >= closecredit)
        {
            closedebit = closedebit - closecredit;
            ReturnCurrBalBC = string.Format("{0:0.00}", closedebit).ToString() + " " + "Dr";
        }
        else
        {
            closecredit = closecredit - closedebit;
            ReturnCurrBalBC = string.Format("{0:0.00}", closecredit).ToString() + " " + "Cr";
        }
        return ReturnCurrBalBC;
    }
}
