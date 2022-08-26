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

/// <summary>
/// Summary description for Common_Database
/// </summary>
public class Common_Database
{
    static string conString = System.Configuration.ConfigurationManager.AppSettings["telecome"];
    public SqlConnection conn = new SqlConnection(conString);
    public SqlCommand cmd1;
    public SqlDataReader dtr1;
    public SqlDataAdapter sqlda1;

	public Common_Database()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void load_combo(DropDownList cmb, string sql)
    {
        conn.Open();
        cmd1 = new SqlCommand(sql, conn);
        dtr1 = cmd1.ExecuteReader();
        cmb.Items.Clear();
        cmb.Items.Add(new ListItem("<Select>", "Select"));

        while (dtr1.Read())
        {
            cmb.Items.Add(new ListItem(dtr1[1].ToString(), dtr1[0].ToString()));
        }
        dtr1.Close();
        conn.Close();
    }

    public string get_value(string sql)
    {
        string ret_str;
        conn.Open();
        cmd1 = new SqlCommand(sql, conn);
        dtr1 = cmd1.ExecuteReader();
        if (dtr1.Read())
        {
            ret_str = dtr1[0].ToString();
        }
        else
        {
            ret_str = "-";
        }
        dtr1.Close();
        conn.Close();
        return ret_str;
    }

    public void bind_grid(GridView gv, string sql)
    {
        conn.Open();
        cmd1 = new SqlCommand(sql, conn);
        DataSet ds1 = new DataSet();
        sqlda1 = new SqlDataAdapter(cmd1);
        sqlda1.Fill(ds1);

        gv.DataSource = ds1;
        gv.DataBind();

        dtr1.Close();
        conn.Close();

    }


    public enum MyMonths
    {
        January,
        February,
        March,
        April,
        May,
        June,
        July,
        August,
        September,
        October,
        November,
        December
    }
}
