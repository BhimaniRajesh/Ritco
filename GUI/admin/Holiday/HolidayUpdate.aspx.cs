using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient; 

public partial class GUI_admin_Holiday_HolidayUpdate : System.Web.UI.Page
{
    SqlConnection cn;

    public static string strdRg;
    public static string strdLoc;
    public static string[] strdLocWhole;
    public static string strdLocDt;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            //strdRg = Session["dRg"].ToString().Trim();
            //strdLoc = Session["dLoc"].ToString().Trim();
            //strdLocWhole = strdLoc.Split(':'); 
           
            cn.Open();
            string sqlGetState = "select distinct STCD,STNM from webx_state order by stnm";
            SqlCommand cmd = new SqlCommand(sqlGetState, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddRg.DataTextField = "STNM";
                ddRg.DataValueField = "STCD";
                ddRg.DataSource = ds;
                ddRg.DataBind(); 
            }
            ddRg.Items.Insert(0, new ListItem("--Select--", "-1"));
            cn.Close();
            if (Session["status"].ToString() != "Yes")
            {
                strdRg = Session["dRg"].ToString().Trim();
                strdLoc = Session["dLoc"].ToString().Trim();
                strdLocWhole = strdLoc.Split(':'); 
                getData();
            }
            else
            {
                strdRg = Session["Edit"].ToString().Trim();
                strdLocDt = Session["dt"].ToString().Trim(); 
                getListEditData();
            }
        }
    }
    public void getData()
    {
        cn.Open();
        string sqlGetData = "select HDAY_REGION, convert(varchar, HDAY_DATE,103) as HDAY_DATE, HDAY_NOTE, ACTIVEFLAG from webx_holiday where HDAY_REGION = '" + strdRg + "' and HDAY_DATE = '" + getDateInddMMMyyyFormat(strdLocWhole[1]) + "'"; 
        SqlCommand cmd = new SqlCommand(sqlGetData, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if(dr.Read())
        {
            //DateTime dt = Convert.ToDateTime(dr["HDAY_DATE"].ToString()); 
            ddRg.Text = dr["HDAY_REGION"].ToString();
            // txtDate.Text = dt;
            txtDate.Text = dr["HDAY_DATE"].ToString();
            txtDescription.Text = dr["HDAY_NOTE"].ToString();
            txtActFlag.Text = dr["ACTIVEFLAG"].ToString();
        }
        dr.Close();
        ddRg.Text = strdRg;
        ddRg.Enabled = false;  
        cn.Close();
    }
    public void getListEditData()
    {
        cn.Open();
        string sqlGetData = "select HDAY_REGION, convert(varchar, HDAY_DATE,103) as HDAY_DATE, HDAY_NOTE, ACTIVEFLAG from webx_holiday where HDAY_REGION = '" + Session["Edit"].ToString().Trim() + "' and HDAY_DATE = '" + Session["dt"].ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(sqlGetData, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            ddRg.Text = dr["HDAY_REGION"].ToString();
            txtDate.Text = dr["HDAY_DATE"].ToString();
            txtDescription.Text = dr["HDAY_NOTE"].ToString();
            txtActFlag.Text = dr["ACTIVEFLAG"].ToString();
        }
        dr.Close();
        cn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sqlUpdt = "";
        cn.Open();
        
        if (Session["status"].ToString() != "Yes")
        {
            sqlUpdt = "update webx_holiday set UPDTBY='" + Session["empcd"].ToString().Trim() + "',HDAY_REGION='" + ddRg.SelectedValue + "',HDAY_DATE='" + Convert.ToDateTime(txtDate.Text) + "',HDAY_NOTE='" + txtDescription.Text + "',ACTIVEFLAG='" + txtActFlag.Text + "',UPDTON = '" + System.DateTime.Now.ToShortDateString() + "' where HDAY_REGION='" + strdRg + "' and HDAY_DATE='" + strdLocWhole[1].ToString() + "'";
        }
        else
        {
            sqlUpdt = "update webx_holiday set UPDTBY='" + Session["empcd"].ToString().Trim() + "',HDAY_REGION='" + ddRg.SelectedValue + "',HDAY_DATE='" + Convert.ToDateTime(txtDate.Text) + "',HDAY_NOTE='" + txtDescription.Text + "',ACTIVEFLAG='" + txtActFlag.Text + "',UPDTON = '" + System.DateTime.Now.ToShortDateString() + "' where HDAY_REGION='" + strdRg + "' and HDAY_DATE='" + strdLocDt + "'";
        }

        SqlCommand cmd = new SqlCommand(sqlUpdt, cn);
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        //ddRg.SelectedItem = "--Select--";
        txtDate.Text = "";
        txtDescription.Text = "";
        txtActFlag.Text = "Y";

        if (Session["status"].ToString() != "Yes")
        {
            getData();
        }
        else
        {
            getListEditData();
        }
    }
    protected void chk_CheckedChanged(object sender, EventArgs e)
    {
        if (chk.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}
