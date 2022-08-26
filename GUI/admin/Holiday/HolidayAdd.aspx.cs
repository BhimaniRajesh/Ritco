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

public partial class GUI_admin_Holiday_HolidayAdd : System.Web.UI.Page
{
    SqlConnection cn;
    MyFunctions fn = new MyFunctions();
    public static string strdRg;
    public static string strdLoc;
    public static string[] strdLocWhole;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            //ddRg.Items.Add("--Select--");  
            
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
        }
    }
    public bool findData()
    {
        SqlCommand cm = new SqlCommand("select HDAY_DATE from webx_holiday where HDAY_REGION = '" + ddRg.SelectedValue + "' and HDAY_DATE='" + Convert.ToDateTime(sdate) + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    string sdate;
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Array str;
        str = txtDate.Text.Split('/');
        sdate = ((string[])(str))[1] + "/" + ((string[])(str))[0] + "/" + ((string[])(str))[2];
        if (findData() == true)
        {
            lblMsg.Text = "Duplicate Entry";
            lblMsg.Focus();
        }
        else
        {
            cn.Open();     
            string sqlAdd = "insert into webx_holiday(HDAY_REGION,HDAY_DATE,HDAY_NOTE,ACTIVEFLAG,UPDTBY,UPDTON) values('" + ddRg.SelectedValue + "','" + Convert.ToDateTime(sdate) + "','" + txtDescription.Text.Replace("'", "''") + "','" + txtActFlag.Text + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() + "')";
            SqlCommand cmd = new SqlCommand(sqlAdd, cn);
            cmd.ExecuteNonQuery();
            cn.Close();
            lblMsg.Text = "Record Inserted";
            lblMsg.Focus();
            Response.Redirect("HolidayListingNew.aspx");  
        }
    }
    
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Server.Transfer("HolidayAdd.aspx");
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
}
