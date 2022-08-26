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
public class MyFunctions : System.Web.UI.Page
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

    public string GetVendor_name(string vendorcode)
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
            codenm = Convert.ToString(dr["vendorname"]);

        }

        if (codenm == null) codenm = "";
        return codenm;
    }
    public string Mydate1(string strDate_time) //format given dd/mm/yyyy
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
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TABLENAME", SqlDbType.VarChar).Value = tableName;
        cmd.Parameters.AddWithValue("@FIELDNAME", SqlDbType.VarChar).Value = fieldName;
        cmd.Parameters.AddWithValue("@PREFIX", SqlDbType.VarChar).Value = prefix;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        String sql1;
        sql1 = "";
        if (sdr.Read())
        {
            sql1 = sdr[0].ToString();
        }
        sdr.Close();
        cmd = new SqlCommand(sql1, conn);
        string NewCode = "1";
        SqlDataReader sdr1 = cmd.ExecuteReader();
        if (sdr1.Read())
        {
            if (sdr1[0].ToString() != "")
                NewCode = sdr1[0].ToString();

        }

        sdr1.Close();
        conn.Close();

        NewCode = prefix + NewCode.PadLeft(5, '0');
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
    //public string GetVendorName(string vendoername)
    //{
    //    string vendor = "";
    //    string code = "";
    //    string codenm = "";
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "sp_get_vendor";
    //    SqlCommand cmd = new SqlCommand(sql, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@vendor", SqlDbType.VarChar).Value = vendorname.Trim();

    //    SqlDataReader dr = null;
    //    dr = cmd.ExecuteReader();

    //    while (dr.Read())
    //    {
    //        //vendor = Convert.ToString(dr["vendorname"]);
    //        codenm = Convert.ToString(dr["vendorname"]);

    //    }

    //    if (codenm == null) codenm = "";
    //    return codenm;
    //}

    public string Getcustomer(string custcode)
    {


        string custnm = "";
        // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString());



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
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString());
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
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString());
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
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString());
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
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"].ToString().Trim());
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
        if (Session["Client"].ToString() == "RLL" || Session["Client"].ToString() == "FLSL")
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
        str = str + " dt =document.getElementById('" + t1.ClientID + "').value;" +
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
            " { alert('Date Should be Between " + datefrom + " and " + dateTo + "');document.getElementById('" + t1.ClientID + "').focus();return;};";
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
    public string getAccount_Company_code(string ATableName, string Code)
    {
        string Company_Acccode = "";
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select Company_Acccode from " + ATableName + "  with(NOLOCK) where acccode='" + Code + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        // dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Company_Acccode = Convert.ToString(dr[0]);
        }

        if (Company_Acccode == null) Company_Acccode = "";
        return Company_Acccode;
    }
    public void Fill_Vendor_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "select code as code , name as name from VW_Getting_Vendor_Details WITH(NOLOCK)  order by name";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsVendor.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsVendor);
        con.Close();
    }
    public void Fill_Asset_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Asset = "select assetcd AS Code,assetname As Name from webx_assetmaster WITH(NOLOCK)";
        SqlCommand Comd_Asset = new SqlCommand(Sql_Asset, con);
        SqlDataAdapter Da_Asset = new SqlDataAdapter(Comd_Asset);
        AtlasAutoComplete.DsAsset.Clear();
        Da_Asset.Fill(AtlasAutoComplete.DsAsset);
        con.Close();
    }
    public void Fill_Vehicle_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vehicle = "select Type_Name as Name,Type_Code  as Code  from webx_Vehicle_Type";
        SqlCommand Comd_Vehicle = new SqlCommand(Sql_Vehicle, con);
        SqlDataAdapter Da_Vehicle = new SqlDataAdapter(Comd_Vehicle);
        AtlasAutoComplete.DsVehicle.Clear();
        Da_Vehicle.Fill(AtlasAutoComplete.DsVehicle);
        con.Close();
    }
    public void Fill_Customer_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Customer = "select custnm as Name,custcd  as Code  from webx_custhdr WHERE CUST_ACTIVE='Y' and PATINDEX('%" + SessionUtilities.CurrentBranchCode + "%',custloc) > 0 order by custnm";
        SqlCommand Comd_Customer = new SqlCommand(Sql_Customer, con);
        SqlDataAdapter Da_Customer = new SqlDataAdapter(Comd_Customer);
        AtlasAutoComplete.DsCustomer.Clear();
        Da_Customer.Fill(AtlasAutoComplete.DsCustomer);
        con.Close();
    }
    public void Fill_Location_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Location = "select Locname as Name,loccode  as Code  from webx_location where ActiveFlag='Y' order by Locname";
        SqlCommand Comd_Location = new SqlCommand(Sql_Location, con);
        SqlDataAdapter Da_Location = new SqlDataAdapter(Comd_Location);
        AtlasAutoComplete.DsLocation.Clear();
        Da_Location.Fill(AtlasAutoComplete.DsLocation);
        con.Close();
    }

    public void Fill_Octroi_Vendor_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "exec usp_get_octroi_Vendor";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsOctVendor.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsOctVendor);
        con.Close();
    }
    public void Fill_Acccode_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Acccode = "select accdesc as Name,Company_acccode  as Code  from webx_acctinfo order by accdesc";
        SqlCommand Comd_Acccode = new SqlCommand(Sql_Acccode, con);
        SqlDataAdapter Da_Acccode = new SqlDataAdapter(Comd_Acccode);
        AtlasAutoComplete.DsAcccode.Clear();
        Da_Acccode.Fill(AtlasAutoComplete.DsAcccode);
        con.Close();
    }
    public void Fill_General_Asset_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_GAsset = "SELECT assetcd AS Code,assetname AS Name FROM webx_General_assetmaster WITH(NOLOCK)";
        SqlCommand Comd_GAsset = new SqlCommand(Sql_GAsset, con);
        SqlDataAdapter DsGeneralAsset = new SqlDataAdapter(Comd_GAsset);
        AtlasAutoComplete.DsGeneralAsset.Clear();
        DsGeneralAsset.Fill(AtlasAutoComplete.DsGeneralAsset);
        con.Close();
    }
    public string GetDriverName(string Driver_Id)
    {
        string Driver_Name = "";
        // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());



        conn.Open();
        string sql = "USP_Driver_Name";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Driver_Id", SqlDbType.VarChar).Value = Driver_Id.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Driver_Name = Convert.ToString(dr["Driver_Name"]);
        }

        if (Driver_Name == null) Driver_Name = "";
        return Driver_Name;
    }
    public void Fill_Driver_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Driver = "select Driver_Name as Name,Driver_Id  as Code  from WEBX_FLEET_DRIVERMST order by Driver_Name";
        SqlCommand Comd_Driver = new SqlCommand(Sql_Driver, con);
        SqlDataAdapter DsDrivName = new SqlDataAdapter(Comd_Driver);
        AtlasAutoComplete.DsDrivName.Clear();
        DsDrivName.Fill(AtlasAutoComplete.DsDrivName);
        con.Close();
    }
    public string GetVendorName(string vendoername)
    {

        string vendorname = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_vendor";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@vendor", SqlDbType.VarChar).Value = vendorname.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            vendorname = Convert.ToString(dr["vendorname"]);
        }

        if (vendorname == null) vendorname = "";
        return vendorname;
    }
    public string GetFinyear()
    {
        throw new NotImplementedException();
    }
    public void Fill_City_Dataset()
    {
        //string ConnectionString = "Data Source=JITEN;Initial Catalog=IMS_ECFY;UID=sa;pwd=sys";
        //SqlConnection con = new SqlConnection(ConnectionString);
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        //string Sql_Asset = "select city_code AS [Code],Location  AS [Name] from webx_citymaster";
        string Sql_Asset = "select Location  AS Name,city_code AS Code from webx_citymaster";
        SqlCommand Comd_Fill_CustomerCd = new SqlCommand(Sql_Asset, con);
        SqlDataAdapter Da_Fill_CustomerCd = new SqlDataAdapter(Comd_Fill_CustomerCd);
        AtlasAutoComplete.DsGetCityCd.Clear();
        Da_Fill_CustomerCd.Fill(AtlasAutoComplete.DsGetCityCd);
        con.Close();
    }
    public void Fill_General_Asset_Dataset(string MatCat)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_GAsset = "SELECT SKU_ID AS Code,SKU_Desc AS Name FROM webx_PO_SKU_Master WITH(NOLOCK) WHERE MatCat_Id='" + MatCat + "'";
        SqlCommand Comd_GAsset = new SqlCommand(Sql_GAsset, con);
        SqlDataAdapter DsGeneralAsset = new SqlDataAdapter(Comd_GAsset);
        AtlasAutoComplete.DsGeneralAsset.Clear();
        DsGeneralAsset.Fill(AtlasAutoComplete.DsGeneralAsset);
        con.Close();
    }
    public void Fill_VendorName_Dataset_Gatepass()
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "select  vendorname as Name,vendorcode as Code from webx_VENDOR_HDR WITH(NOLOCK)where vendorname in ( select vendorname from webx_VENDOR_det WITH(NOLOCK)where vendorname is not null  )order by vendorname";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsVendorName.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsVendorName);
        con.Close();
    }
    public void Fill_VendorName_Dataset()
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "select  vendorname as Name,vendorcode as Code from webx_VENDOR_HDR WITH(NOLOCK)where vendorname in ( select vendorname from webx_VENDOR_det WITH(NOLOCK)where vendorname is not null  )order by vendorname";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsVendorName.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsVendorName);
        con.Close();
    }
    public void Fill_Fix_Asset_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_FixAsset = "SELECT ASSETCD AS Code,assetname AS Name FROM webx_ASSETMASTER WITH(NOLOCK)";
        SqlCommand Comd_FixAsset = new SqlCommand(Sql_FixAsset, con);
        SqlDataAdapter DsFixAsset = new SqlDataAdapter(Comd_FixAsset);
        AtlasAutoComplete.DsFixAsset.Clear();
        DsFixAsset.Fill(AtlasAutoComplete.DsFixAsset);
        con.Close();
    }
    public void Fill_Stationary_Asset_Dataset(string MatCat)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_StationaryAsset = "SELECT SKU_ID AS Code,SKU_Desc AS Name FROM webx_PO_SKU_Master WITH(NOLOCK) WHERE MatCat_Id='" + MatCat + "'";
        SqlCommand Comd_StationaryAsset = new SqlCommand(Sql_StationaryAsset, con);
        SqlDataAdapter DsStationaryAsset = new SqlDataAdapter(Comd_StationaryAsset);
        AtlasAutoComplete.DsStationaryParts.Clear();
        DsStationaryAsset.Fill(AtlasAutoComplete.DsStationaryParts);
        con.Close();
    }
    public void Fill_SpareParts_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Spare = "SELECT Description AS Name,Part_ID AS Code FROM WEBX_FLEET_SPAREPARTHDR WITH(NOLOCK) ";
        SqlCommand Comd_GAsset = new SqlCommand(Sql_Spare, con);
        SqlDataAdapter DsSparePartsMain = new SqlDataAdapter(Comd_GAsset);
        AtlasAutoComplete.DsSpareParts.Clear();
        DsSparePartsMain.Fill(AtlasAutoComplete.DsSpareParts);
        con.Close();
    }
    public void Fill_VehicleMaster_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vehicle = "select VEHNO as Name,VEHNO as Code  from webx_VEHICLE_HDR";
        SqlCommand Comd_Vehicle = new SqlCommand(Sql_Vehicle, con);
        SqlDataAdapter Da_Vehicle = new SqlDataAdapter(Comd_Vehicle);
        AtlasAutoComplete.DsVehicleMaster.Clear();
        Da_Vehicle.Fill(AtlasAutoComplete.DsVehicleMaster);
        con.Close();
    }

    //**************** Added by Mayank *******************
    public void Fill_VehicleOpenTripsheet_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vehicle1 = "select DISTINCT VehicleNo as Name,VehicleNo as Code from WEBX_FLEET_VEHICLE_ISSUE Where Oper_Close_Dt IS NULL";
        SqlCommand Comd_Vehicle1 = new SqlCommand(Sql_Vehicle1, con);
        SqlDataAdapter Da_Vehicle1 = new SqlDataAdapter(Comd_Vehicle1);
        AtlasAutoComplete.DsVehicleOpenTripsheet.Clear();
        Da_Vehicle1.Fill(AtlasAutoComplete.DsVehicleOpenTripsheet);
        con.Close();
    }
    //***********************************

    public void Fill_MaterialDetails_Dataset(string MatCat)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Material = "SELECT G.ICODE AS Code,S.SKU_Desc AS Name FROM WEBX_SKU_GRN_ISSUE_STOCK G WITH(NOLOCK) INNER JOIN Webx_PO_SKU_Master S WITH(NOLOCK) ON S.SKU_ID=G.ICODE WHERE S.MatCat_Id='" + MatCat + "' and G.BBRCD='" + SessionUtilities.CurrentBranchCode.ToString() + "'";
        SqlCommand Comd_Material = new SqlCommand(Sql_Material, con);
        SqlDataAdapter Da_Material = new SqlDataAdapter(Comd_Material);
        AtlasAutoComplete.DsMaterialDetails.Clear();
        Da_Material.Fill(AtlasAutoComplete.DsMaterialDetails);
        con.Close();
    }
    public void Fill_Fix_Asset_Dataset(string MatCat)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_FixAsset = "SELECT G.ICODE AS Code,A.assetname AS Name FROM WEBX_SKU_GRN_ISSUE_STOCK G WITH(NOLOCK) INNER JOIN webx_ASSETMASTER A WITH(NOLOCK) ON A.ASSETCD=G.ICODE WHERE G.BBRCD='" + SessionUtilities.CurrentBranchCode.ToString() + "'";
        SqlCommand Comd_FixAsset = new SqlCommand(Sql_FixAsset, con);
        SqlDataAdapter DAFixAsset = new SqlDataAdapter(Comd_FixAsset);
        AtlasAutoComplete.DsFixAsset.Clear();
        DAFixAsset.Fill(AtlasAutoComplete.DsFixAsset);
        con.Close();
    }
    public void Fill_Vendor_Dataset_Fuel()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "select vendorCode as code , vendorname as name from webx_VENDOR_HDR WITH(NOLOCK) where ISNULL(Active,'N')='Y' and vendor_type='12' AND vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)where vendorCode is not null  )order by vendorname";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsVendorFuel.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsVendorFuel);
        con.Close();
    }
    public void Fill_Vendor_Dataset_Fuel(string strFltr)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Vendor = "select vendorCode as code , vendorname as name from webx_VENDOR_HDR WITH(NOLOCK) where ISNULL(Active,'N')='Y' and vendor_type='12' AND vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)where vendorCode is not null  ) and vendorCode like '%" + strFltr + "%' order by vendorname";
        SqlCommand Comd_Vendor = new SqlCommand(Sql_Vendor, con);
        SqlDataAdapter Da_Vendor = new SqlDataAdapter(Comd_Vendor);
        AtlasAutoComplete.DsVendorFuel.Clear();
        Da_Vendor.Fill(AtlasAutoComplete.DsVendorFuel);
        con.Close();
    }
	
    //****************** STANDARD EXP **********************
    public void Fill_StandardExp_FixedRoute()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_RouteNo = "Select RouteNo as code from StandardExpense_FixedRoute_HDR order by RouteNo";
        SqlCommand Comd_RouteNo = new SqlCommand(Sql_RouteNo, con);
        SqlDataAdapter Da_RouteNo = new SqlDataAdapter(Comd_RouteNo);
        AtlasAutoComplete.DsRouteNo.Clear();
        Da_RouteNo.Fill(AtlasAutoComplete.DsRouteNo);
        con.Close();
    }


    public void Fill_StandardExp_Fixed_VehicleNo()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Veh = "SELECT vehno AS code from webx_VEHICLE_HDR WITH(NOLOCK) where ActiveFlag='Y'";
        SqlCommand Comd_Veh = new SqlCommand(Sql_Veh, con);
        SqlDataAdapter Da_Veh = new SqlDataAdapter(Comd_Veh);
        AtlasAutoComplete.DsGetAllVehicle.Clear();
        Da_Veh.Fill(AtlasAutoComplete.DsGetAllVehicle);
        con.Close();
    }

    //**********************************************
    
    public void Fill_TyreModel_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Spare = "SELECT TYRE_MODEL_ID AS Code,MODEL_NO AS Name FROM WEBX_FLEET_TYREMODELMST WITH(NOLOCK) ";
        SqlCommand Comd_GATyre = new SqlCommand(Sql_Spare, con);
        SqlDataAdapter DsTyreModelMain = new SqlDataAdapter(Comd_GATyre);
        AtlasAutoComplete.DsTyreModel.Clear();
        DsTyreModelMain.Fill(AtlasAutoComplete.DsTyreModel);
        con.Close();
    }
    public void Fill_TyreMFG_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Spare = "SELECT MFG_ID AS Code,MFG_Name AS Name FROM WEBX_FLEET_TYREMFG WITH(NOLOCK) ";
        SqlCommand Comd_GATyreMFG = new SqlCommand(Sql_Spare, con);
        SqlDataAdapter DsTyreMFGMain = new SqlDataAdapter(Comd_GATyreMFG);
        AtlasAutoComplete.DsTyreMFG.Clear();
        DsTyreMFGMain.Fill(AtlasAutoComplete.DsTyreMFG);
        con.Close();
    }
    public void Fill_TyreSize_Dataset()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Spare = "SELECT Tyre_SizeID as Code,Tyre_SizeName As Name FROM WEBX_FLEET_TYRESIZEMST WITH(NOLOCK) ";
        SqlCommand Comd_GATyreSize = new SqlCommand(Sql_Spare, con);
        SqlDataAdapter DsTyreSizeMain = new SqlDataAdapter(Comd_GATyreSize);
        AtlasAutoComplete.DsTyreSize.Clear();
        DsTyreSizeMain.Fill(AtlasAutoComplete.DsTyreSize);
        con.Close();
    }
    public void Fill_ServiceWise_Customer_Dataset(string ServiceID)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Sql_Customer = "SELECT custnm AS Name,custcd  AS Code  FROM webx_custhdr Where custcd IN (SELECT CustCd FROM Webx_Cust_Service_Mapping WHERE Service_Code='" + ServiceID + "' AND ISNULL(Active,'N')='Y') ORDER BY CUSTNM";
        SqlCommand Comd_Customer = new SqlCommand(Sql_Customer, con);
        SqlDataAdapter Da_ServiceWiseCustomer = new SqlDataAdapter(Comd_Customer);
        AtlasAutoComplete.DsServiceWiseCustomer.Clear();
        Da_ServiceWiseCustomer.Fill(AtlasAutoComplete.DsServiceWiseCustomer);
        con.Close();
    }
	
    public void GetUser()
    {
        SqlConnection coon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        coon.Open();
        string Sql_Customer = "select UserId,Name from WebX_Master_Users where Status='100'";
        SqlCommand Comd_Customer = new SqlCommand(Sql_Customer, coon);
        SqlDataAdapter Da_ServiceWiseCustomer = new SqlDataAdapter(Comd_Customer);
        AtlasAutoComplete.DsUser.Clear();
        Da_ServiceWiseCustomer.Fill(AtlasAutoComplete.DsUser);
        coon.Close();
    }
}