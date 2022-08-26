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

}
