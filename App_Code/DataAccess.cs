using System;
using System.Data;
using System.Text;
using System.Collections;
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
/// Summary description for DataAccess
/// </summary>
public class DataAccess
{
    SqlDataReader dtr;
    string strdatabase = "";
	public DataAccess()
	{
		
	}
    public static void insertQuary(string ProcName, Hashtable field)
    {
        string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(strdatabase);
        string fieldname, fieldvalue;
        int i = 0;
        try
        {
            //trans = conn.BeginTransaction();
            SqlParameter[] arParms = new SqlParameter[Convert.ToInt16(field.Count)];
            foreach (DictionaryEntry de in field)
            {
                fieldname = "";
                fieldvalue = "";
                fieldname = "@" + de.Key.ToString();
                fieldvalue = de.Value.ToString();
                if (i == 0)
                {
                    arParms[0] = new SqlParameter(fieldname, fieldvalue);
                }
                else
                {
                    arParms[i] = new SqlParameter(fieldname, fieldvalue);
                }
                i = i + 1;
            }
            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, ProcName, arParms);
            //trans.Commit();
        }
        catch (Exception e1)
        {
            string errorMsg = "Error" + e1.Message;
            //trans.Rollback();
        }
        finally
        {
            conn.Close();
        }
    }
    public string all_AccLevel2(string group_code)
    {
        DateFunction Daccess = new DateFunction();
        string all_code = "";
        string all_ = "";
        string info = group_code;
        string strValueOP = "";
        string[] arInfo = new string[1];
        char[] splitter = { ';' };
        arInfo = info.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            strValueOP = arInfo[x];
            string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
            SqlConnection conn = new SqlConnection(strdatabase);

            string sql = "select * from WebX_Groups where Grouplevel=2 and Parentcode='" + strValueOP + "'";
            conn.Open();
            dtr = Daccess.getreader(sql);

            while (dtr.Read())
            {
                all_code = all_code + dtr["Groupcode"].ToString() + ";";
            }
            dtr.Close();
            all_ = all_AccLevel3(all_code);
            conn.Close();
            conn.Close();
            conn.Dispose();
        }
        return all_;
    }
    public string all_AccLevel3(string all_code)
    {
        DateFunction Daccess = new DateFunction();
        string all_code_lvl3 = "";
        string info = all_code;
        string strValueOP = "";
        string[] arInfo = new string[1];
        char[] splitter = { ';' };
        arInfo = info.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            strValueOP = arInfo[x];
            string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
            SqlConnection conn = new SqlConnection(strdatabase);

            string sql = "select * from WebX_Groups where Grouplevel=2 and Parentcode='" + strValueOP + "'";
            conn.Open();
            dtr = Daccess.getreader(sql);

            while (dtr.Read())
            {
                all_code_lvl3 = all_code + dtr["Groupcode"].ToString() + ";";
            }
            dtr.Close();
           
            conn.Close();
            conn.Close();
            conn.Dispose();
        }
        return all_code_lvl3;
        //double all_total=group_total_accTrans(group_total_accTrans
    }
    public double group_total_accTrans(string acct_code, string AsOnDate, string convDate, string strTranType, string branch)
    {
        DateFunction Daccess = new DateFunction();
        double groupTotal = 0;
        string info = acct_code;
        string strValueOP = "";
        string[] arInfo = new string[1];
        char[] splitter = { ';' };
        arInfo = info.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            strValueOP = arInfo[x];
            string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
            string startYear = (string)(System.Web.HttpContext.Current.Session["FinYearStart"].ToString().Trim());
            SqlConnection conn = new SqlConnection(strdatabase);

            string brcd = " and brcd = '" + branch + "'";
            //string startFinYear = startYear;
            string DateRange = " and convert(datetime, Transdate,160) between convert(varchar,'" + startYear + "',106) and convert(varchar,'" + convDate + "',106)";
            string sql = "";
            if (strTranType == "N")
            {
                sql = "select abs(isNull(sum(Debit-Credit),0.00)) as bal from webx_acctrans_07_08 where Acccode='" + strValueOP + "'" + DateRange + "";
            }
            else
            {
                sql = "select abs(isNull(sum(Debit-Credit),0.00)) as bal from webx_acctrans_07_08 where Acccode='" + strValueOP + "'" + DateRange + brcd + "";
            }
            conn.Open();
            string groupTotalDebit = "";
            dtr = Daccess.getreader(sql);
            while (dtr.Read())
            {
                groupTotalDebit = dtr["bal"].ToString() + "0";
                groupTotal = groupTotal + Convert.ToDouble(groupTotalDebit);
                if (groupTotalDebit == null && groupTotalDebit == "")
                {
                    groupTotalDebit = "0";
                }
            }
            dtr.Close();
            conn.Close();
            conn.Dispose();
        }
        return groupTotal;
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
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);

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
    public void ExecuteNonQry(CommandType cmdType, string ProcedureName, SqlParameter[] prm)
    {
        strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection con = new SqlConnection(strdatabase);

        SqlCommand cmd = new SqlCommand(ProcedureName, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        foreach (SqlParameter sp in prm)
            cmd.Parameters.Add(sp);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.ExecuteNonQuery();
        con.Close();
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
    public string insertQuary_New(string ProcName, Hashtable field)
    {
        string return_val = "0";
        string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(strdatabase);
        conn.Open();
        string fieldname, fieldvalue;
        int i = 0;
        try
        {

            SqlParameter[] arParms = new SqlParameter[Convert.ToInt16(field.Count)];
            foreach (DictionaryEntry de in field)
            {
                fieldname = "";
                fieldvalue = "";
                fieldname = "@" + de.Key.ToString();
                fieldvalue = de.Value.ToString();
                if (i == 0)
                {
                    arParms[0] = new SqlParameter(fieldname, fieldvalue);
                }
                else
                {
                    arParms[i] = new SqlParameter(fieldname, fieldvalue);
                }
                i = i + 1;
            }
            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, ProcName, arParms);
        }
        catch (Exception e1)
        {
            string errorMsg = "Error" + e1.Message;
            return_val = errorMsg;
        }
        finally
        {
            conn.Close();

            //return return_val;
        }
        return return_val;
    }
}
