using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

/// <summary>
/// Summary description for MyFunctions
/// </summary>
public class MyFunctions  : System.Web.UI.Page
{

    
    
	public MyFunctions()
	{
		//
        
		// TODO: Add constructor logic here
		//
	}
    public string MonthName(int month)
    {
        switch (month)
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
    public string MonthInNum(string month)
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
    public string Mydate1(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "" )
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);
            
            string tempDate="";
            int tempMonth,tempYear;
            tempMonth = 0;
            tempYear=0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }

            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + System.Convert.ToString(tempYear);
            return fdt;
        }

    }

    public string GetVehicle(string thcno)
    {


        string vehno = "";
        // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());



        conn.Open();
        string sql = "select vehno from webx_thc_summary with(NOLOCK) where thcno='" + thcno + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = custcode.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            vehno = Convert.ToString(dr["vehno"]);
        }

        if (vehno == null) vehno = "";
        return vehno;
    }
    public string NewCodeGene(string tableName, string fieldName, string prefix)
    {
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "WMS_CODEGEN";
        SqlCommand cmd = new SqlCommand(sql,conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TABLENAME", SqlDbType.VarChar).Value = tableName;
        cmd.Parameters.AddWithValue("@FIELDNAME", SqlDbType.VarChar).Value = fieldName;
        cmd.Parameters.AddWithValue("@PREFIX", SqlDbType.VarChar).Value = prefix;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        String sql1;
        sql1 = "";
        if( sdr.Read())
        {   
            sql1=sdr[0].ToString();
        }
        sdr.Close();
        cmd = new SqlCommand(sql1, conn);
        string NewCode="1";
        SqlDataReader sdr1 = cmd.ExecuteReader();
        if (sdr1.Read())
        {
            if(sdr1[0].ToString() !="")
                NewCode = sdr1[0].ToString();

        }
        
        sdr1.Close();
        conn.Close();

        NewCode = prefix + NewCode.PadLeft(5,'0');
        return NewCode;
    }
	public string getAllCityStr()
    {
        string Citystr = "";
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();
        string sql = "select location from webx_citymaster";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            if (Citystr == "")
            {
                Citystr = dr_Location.GetValue(0).ToString();
            }
            else
            {
                Citystr = Citystr + "," + dr_Location.GetValue(0).ToString();
            }

        }
        dr_Location.Close();
        sqlConn.Close();
        return Citystr;
    }
    public string Datadate(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);

            string tempDate = "";
            int tempMonth, tempYear;
            tempMonth = 0;
            tempYear = 0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }

            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + System.Convert.ToString(tempYear);
            return fdt;
        }

    }
    

    public string Getcustomer(string custcode)
    {


        string custnm="";
        // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


       SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        

        conn.Open();
        string sql = "sp_get_custnm";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = custcode.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            custnm = Convert.ToString(dr["custnm"]);
        }

        if (custnm == null) custnm = "";
        return custnm;
    }
    public string GetLocation(string lococde)
    {


        string locname = "";
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_locnm";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            locname = Convert.ToString(dr["locname"]);
        }

        if (locname == null) locname = "";
        return locname;
    }
    public string Getpaybas(string lococde)
    {


        string paybasdesc = "";
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_paybas";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@paybas", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            paybasdesc = Convert.ToString(dr["paybasdesc"]);
        }

        if (paybasdesc == null) paybasdesc = "";
        return paybasdesc;
    }
    public string Gettrnmod(string lococde)
    {


        string moddesc = "";
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_trnmod";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@trnmod", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            moddesc = Convert.ToString(dr["moddesc"]);
        }

        if (moddesc == null) moddesc = "";
        return moddesc;
    }
    public string Mydate(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);

            string tempDate = "";
            int tempMonth, tempYear;
            tempMonth = 0;
            tempYear = 0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }

            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + System.Convert.ToString(tempYear);
            return fdt;
        }

    }
    public string Mydatedisplay(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);

            string tempDate = "";
            int tempMonth, tempYear;
            tempMonth = 0;
            tempYear = 0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }
            string shortyear = tempYear.ToString();
            shortyear = shortyear.Substring(shortyear.Length - 2); 
            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + shortyear;
            return fdt;
        }
    }
    public string GetLocregion(string lococde)
    {


        string Region = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "Select LocRegion From Webx_location where loccode='" + lococde + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Region = Convert.ToString(dr["LocRegion"]);
        }

        if (Region == null) Region = "";
        return Region;
    }
    public string GetRegion_name(string Zonecode)
    {


        string Region = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select codedesc from webx_master_general where codetype='zone' and codeid='" + Zonecode + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Region = Convert.ToString(dr["codedesc"]);
        }

        if (Region == null) Region = "";
        return Region;
    }
    public string GetEmpName(string empcd)
    {


        string empnm = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string sql = "Select empnm From Webx_empmst where empcd='" + empcd + "'";
        string sql = "select name as empnm from webx_master_users where userid='" + empcd + "'";
        
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            empnm = Convert.ToString(dr["empnm"]);
        }

        if (empnm == null) empnm = "";
        return empnm;
    }
    public string GetZeroval(string fieldname)
    {

        if (fieldname == "" || fieldname is DBNull)
        {
            fieldname = "0";
        }

        return fieldname;
    }
    public string getLocationStr()
    {


        string Locationstr = "";
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();



        string sql = "SELECT loccode FROM  webx_location where ActiveFlag='Y'";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();



        while (dr_Location.Read())
        {
            if (Locationstr == "")
            {
                Locationstr = dr_Location.GetValue(0).ToString();
            }
            else
            {
                Locationstr = Locationstr + "," + dr_Location.GetValue(0).ToString();
            }


        }
        dr_Location.Close();
        sqlConn.Close();
        return Locationstr;
    }
    public string getCustomerStr()
    {


        string Custcdstr = "";
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();



        string sql = "SELECT custcd FROM  webx_custhdr ";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_Customer = null;
        dr_Customer = sqlCommand.ExecuteReader();



        while (dr_Customer.Read())
        {
            if (Custcdstr == "")
            {
                Custcdstr = dr_Customer.GetValue(0).ToString();
            }
            else
            {
                Custcdstr = Custcdstr + "," + dr_Customer.GetValue(0).ToString();
            }


        }
        dr_Customer.Close();
        sqlConn.Close();
        return Custcdstr;
    }
    public string getCityStr()
    {


        string CityStr = "";
        string ODACityStr = "", oda_yn = "";
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();



        string sql = "select Location,oda_yn from webx_citymaster ";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_City = null;
        dr_City = sqlCommand.ExecuteReader();



        while (dr_City.Read())
        {
            if (CityStr == "")
            {
                CityStr = dr_City.GetValue(0).ToString();
            }
            else
            {
                CityStr = CityStr + "," + dr_City.GetValue(0).ToString();
            }
            oda_yn = dr_City.GetValue(1).ToString().ToUpper();
            if (oda_yn == "Y")
            {
                if (ODACityStr == "")
                {
                    ODACityStr = dr_City.GetValue(0).ToString();
                }
                else
                {
                    ODACityStr = ODACityStr + "," + dr_City.GetValue(0).ToString();
                }
            }


        }
        dr_City.Close();
        sqlConn.Close();
        return CityStr + "/" + ODACityStr;
    }
    public string MRNogen(string loccode)
    {


        string NewCode = "";
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_next_MR_code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = loccode.Trim();
        if (Session["Client"].ToString() == "RLL")
        {
            cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = HttpContext.Current.Session["FinYear"].ToString().Trim().Substring(2, 2);
        }
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            NewCode = Convert.ToString(dr["NewCode"]);
        }

        if (NewCode == null) NewCode = "";
        return NewCode;
    }
    public string GetVendor(string vendorcode)
    {
        string vendor = "";
        string code = "";
        string codenm = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_vendornm";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@vendorcode", SqlDbType.VarChar).Value = vendorcode.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            //vendor = Convert.ToString(dr["vendorname"]);
            codenm = Convert.ToString(dr["vendorcode"]) + " : " + Convert.ToString(dr["vendorname"]);

        }

        if (codenm == null) codenm = "";
        return codenm;
    }

    public string GetVendorType(string vendortype)
    {
        string vendor = "";
        string code = "";
        string codenm = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_getvendor_type";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@typecode", SqlDbType.VarChar).Value = vendortype.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            //vendor = Convert.ToString(dr["vendorname"]);
            codenm = Convert.ToString(dr["type_code"]) + " : " + Convert.ToString(dr["Type_Name"]);

        }

        if (codenm == null) codenm = "";
        return codenm;
    }

 public char retchkboxYN(CheckBox obj)
    {
        if (obj.Checked)
            return ('Y');
        else
            return ('N');
    }
    public bool setchkboxYN(string val1)
    {
        if (val1.ToString() == "Y")
            return (true);
        else
            return (false);
    }
    public string getDateValidateString(TextBox t1, string datefrom, string dateTo)
    {
        string str = "";
        str = " var months = new Array('', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');";
        str = str + " dt =document.getElementById('" + t1.ClientID  + "').value;" +
            " dt_dd=dt.substring(0,2); " +
            " dt_mm=dt.substring(3,5); " +
            " dt_yy=dt.substring(6,10); " +
            " transdate=new Date(months[parseFloat(dt_mm)] + ' ' + parseFloat(dt_dd) + ', ' + parseFloat(dt_yy));" +
            " dt ='" + datefrom + "';" +
            " dt_dd=dt.substring(0,2); " +
            " dt_mm=dt.substring(3,5); " +
            " dt_yy=dt.substring(6,10); " +
            " datefrom=new Date(months[parseFloat(dt_mm)] + ' ' + parseFloat(dt_dd) + ', ' + parseFloat(dt_yy));" +
            " dt ='" + dateTo + "';" +
            " dt_dd=dt.substring(0,2); " +
            " dt_mm=dt.substring(3,5); " +
            " dt_yy=dt.substring(6,10); " +
            " dateto=new Date(months[parseFloat(dt_mm)] + ' ' + parseFloat(dt_dd) + ', ' + parseFloat(dt_yy));" +
            " if((transdate<datefrom)||(transdate>dateto)) " +
            " { alert('Date Should be Between " + datefrom + " and " + dateTo + "');document.getElementById('" + t1.ClientID  + "').focus();return;};";
        return (str);
    }
    public string DatadateDDMMYYYY(string strDate_time)
    {
        DateTime dt = Convert.ToDateTime(strDate_time);
        string ddx, mmx, yyx;

        if (dt.Day.ToString().Length == 1)
            ddx = "0" + dt.Day.ToString();
        else
            ddx = dt.Day.ToString();
        if (dt.Month.ToString().Length == 1)
            mmx = "0" + dt.Month.ToString();
        else
            mmx = dt.Month.ToString();
        yyx = dt.Year.ToString();
        return (ddx + "/" + mmx + "/" + yyx);

    }
    public string GetGroupCode(string Parentcode, string Grpdesc)
    {
        string parentGroup = "", GroupCode = "", NewGroupCode = "";
        //parentGroup = Grpdesc.ToString().Substring(1,3);
        parentGroup = Parentcode.Substring(0, 3);
        switch (Grpdesc)
        {
            case "INCOME":
                parentGroup = "INC";
                break;
            case "EXPENSES":
                parentGroup = "EXP";
                break;
            case "EXPENSE":
                parentGroup = "EXP";
                break;
            case "ASSET":
                parentGroup = "ASS";
                break;
            case "ASSETS":
                parentGroup = "ASS";
                break;
            case "LIABILITIES":
                parentGroup = "LIA";
                break;
        }

        string empnm = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select max(right(groupcode,len(groupcode)-3))+1 as maxcode from webx_groups where groupcode like '" + parentGroup + "%'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            GroupCode = Convert.ToString(dr["maxcode"]);
        }
        if (GroupCode == null || GroupCode == "")
        {
            NewGroupCode = parentGroup + "001";
        }
        else
        {
            if (GroupCode.Length == 1)
            {
                NewGroupCode = parentGroup + "00" + GroupCode;
            }
            else if (GroupCode.Length == 2)
            {
                NewGroupCode = parentGroup + "0" + GroupCode;
            }
            else if (GroupCode.Length == 3)
            {
                NewGroupCode = parentGroup + GroupCode;
            }
        }
        //if (GroupCode == null) GroupCode = "";
        return NewGroupCode;
    }
    public string GetAccountCode(string Groupcode)
    {
        string parentGroup = "", NewAccountCode = "", acct_prefix = "", Maxcode = "";
        //parentGroup = Grpdesc.ToString().Substring(1,3);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select acct_prefix from webx_groups where groupcode='" + Groupcode + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            acct_prefix = Convert.ToString(dr["acct_prefix"]);
        }
        if (acct_prefix == null || acct_prefix == "")
        {
            acct_prefix = "A";
        }
        dr.Close();
        string whrcls = "substring(acccode,1," + acct_prefix.Length + ")='" + acct_prefix + "'";
        string selcls = "Max(Right(acccode, Len(acccode) - " + acct_prefix.Length + ") + 1)";
        sql = "select " + selcls + " as Maxcode from webx_acctInfo where " + whrcls;
        cmd = new SqlCommand(sql, conn);

        SqlDataReader dr1 = null;
        dr1 = cmd.ExecuteReader();

        while (dr1.Read())
        {
            Maxcode = Convert.ToString(dr1["Maxcode"]);
        }
        if (Maxcode == null || Maxcode == "")
        {
            Maxcode = "1";
        }
        //if (GroupCode == null) GroupCode = "";
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
        dr1.Close();
        return NewAccountCode;
    }
    public string NextVoucherno(string loccode, string finyear)
    {

        string NewCode = "";
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_next_VoucherNo_Wo_Output";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = loccode.Trim();
        cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = finyear.Trim();
        cmd.Parameters.Add("@NextVoucherNo", SqlDbType.VarChar).Value = "";
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            NewCode = Convert.ToString(dr[0]);
        }

        if (NewCode == null) NewCode = "";
        return NewCode;
    }
    public string getOpenBal_Trans(string acccode, string enddate, string AcctOpenTable, string AcctTransTable, string AccBrcd)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string cbs_brcd = AccBrcd;
        double currcredit = 0, currdebit = 0, opendebit = 0, opencredit = 0, closedebit = 0, closecredit = 0;

        string sql = "select isnull(opendebit_i,0) as opendebit,isnull(opencredit_i,0) as opencredit from " + AcctOpenTable + " where acccode='" + acccode + "' and brcd='" + AccBrcd + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            opendebit = Convert.ToDouble(dr["opendebit"]);
            opencredit = Convert.ToDouble(dr["opencredit"]);
        }
        dr.Close();

        string mdatefrom = Mydate("01/04/07");
        string mdateto = Mydate(enddate);

        string sql_cbs = "";

        if (Convert.ToDateTime(mdatefrom) <= Convert.ToDateTime(mdateto))
        {
            sql_cbs = "exec webx_cbs " + AcctTransTable + ",'" + acccode + "','" + mdatefrom + "','" + mdateto + "', '" + cbs_brcd + "'";
            SqlCommand cmd1 = new SqlCommand(sql_cbs, conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();

            while (dr1.Read())
            {
                if (dr1["credit"].ToString() != null)
                {
                    currcredit = Convert.ToDouble(dr1["credit"].ToString());
                }
                if (dr1["debit"].ToString() != null)
                {
                    currdebit = Convert.ToDouble(dr1["debit"].ToString());
                }
            }

            dr1.Close();

            closedebit = opendebit + currdebit;
            closecredit = opencredit + currcredit;
        }
        else
        {
            closedebit = opendebit;
            closecredit = opencredit;
        }
        string ReturnCurrBalBC = "";

        if (closedebit >= closecredit)
        {
            closedebit = closedebit - closecredit;
            closecredit = 0;

            if (closedebit != 0)
            {
                ReturnCurrBalBC = closedebit.ToString("F2") + " DR";
            }
            else
            {
                ReturnCurrBalBC = "0.00";
            }
        }
        else
        {
            closecredit = closecredit - closedebit;
            closedebit = 0;

            if (closecredit != 0)
            {
                ReturnCurrBalBC = closecredit.ToString("F2") + " CR";
            }
            else
            {
                ReturnCurrBalBC = "0.00";
            }
        }

        return (ReturnCurrBalBC);
        conn.Close();
    }
    public string getAccountDesc(string ATableName, string Code)
    {
        string AccDesc = "";
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select accdesc from " + ATableName + "  with(NOLOCK) where acccode='" + Code + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        // dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            AccDesc = Convert.ToString(dr[0]);
        }

        if (AccDesc == null) AccDesc = "";
        return AccDesc;
    }
}
