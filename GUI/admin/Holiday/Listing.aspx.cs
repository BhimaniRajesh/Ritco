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

public partial class GUI_admin_Holiday_Listing : System.Web.UI.Page
{
    SqlConnection cn;

    public static string rg1;
    public static string rg2;
    public static string rg3;
    public static string rg4;
    public static string rg5;
    public static string rg6;
    public static string rg7;
    public static string rg8;
    public static string rg9;
    public static string rg10;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        getData();
    }
    public void getData()
    {
        cn.Open();
        string sqlGet = "select b.STNM, convert(varchar, a.HDAY_DATE,103) as HDAY_DATE, a.HDAY_NOTE, a.HDAY_REGION from webx_holiday a, webx_state b where a.HDAY_REGION = b.STCD";
            //"select HDAY_REGION, convert(varchar, HDAY_DATE,103) as HDAY_DATE, HDAY_NOTE from webx_holiday";
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        int totRow = ds.Tables[0].Rows.Count;
        if (totRow == 0)
        {
            lblMsg.Text = "Record not found";
            lblMsg.Focus();
        }
        else
        {
            lblMsg.Text = "";
            for (int i = 0; i <= totRow - 1; i++)
            {
                if (i == 0)
                {
                    lblState1.Text = ds.Tables[0].Rows[0][0].ToString();
                    lblDate1.Text = ds.Tables[0].Rows[0][1].ToString();
                    lblNote1.Text = ds.Tables[0].Rows[0][2].ToString();
                    rg1 = ds.Tables[0].Rows[0][3].ToString();

                    //chk1.Checked = true;
                }
                if (i == 1)
                {
                    lblState2.Text = ds.Tables[0].Rows[1][0].ToString();
                    lblDate2.Text = ds.Tables[0].Rows[1][1].ToString();
                    lblNote2.Text = ds.Tables[0].Rows[1][2].ToString();
                    rg2 = ds.Tables[0].Rows[1][3].ToString();

                    //chk2.Checked = true;
                }
                if (i == 2)
                {
                    lblState3.Text = ds.Tables[0].Rows[2][0].ToString();
                    lblDate3.Text = ds.Tables[0].Rows[2][1].ToString();
                    lblNote3.Text = ds.Tables[0].Rows[2][2].ToString();
                    rg3 = ds.Tables[0].Rows[2][3].ToString();
                    //chk3.Checked = true;
                }
                if (i == 3)
                {
                    lblState4.Text = ds.Tables[0].Rows[3][0].ToString();
                    lblDate4.Text = ds.Tables[0].Rows[3][1].ToString();
                    lblNote4.Text = ds.Tables[0].Rows[3][2].ToString();
                    rg4 = ds.Tables[0].Rows[3][3].ToString();
                    //chk4.Checked = true;
                }
                if (i == 4)
                {
                    lblState5.Text = ds.Tables[0].Rows[4][0].ToString();
                    lblDate5.Text = ds.Tables[0].Rows[4][1].ToString();
                    lblNote5.Text = ds.Tables[0].Rows[4][2].ToString();
                    rg5 = ds.Tables[0].Rows[4][3].ToString();
                    //chk5.Checked = true;
                }
                if (i == 5)
                {
                    lblState6.Text = ds.Tables[0].Rows[5][0].ToString();
                    lblDate6.Text = ds.Tables[0].Rows[5][1].ToString();
                    lblNote6.Text = ds.Tables[0].Rows[5][2].ToString();
                    rg6 = ds.Tables[0].Rows[5][3].ToString();
                    //chk6.Checked = true;
                }
                if (i == 6)
                {
                    lblState7.Text = ds.Tables[0].Rows[6][0].ToString();
                    lblDate7.Text = ds.Tables[0].Rows[6][1].ToString();
                    lblNote7.Text = ds.Tables[0].Rows[6][2].ToString();
                    rg7 = ds.Tables[0].Rows[6][3].ToString();
                    //chk7.Checked = true;
                }
                if (i == 7)
                {
                    lblState8.Text = ds.Tables[0].Rows[7][0].ToString();
                    lblDate8.Text = ds.Tables[0].Rows[7][1].ToString();
                    lblNote8.Text = ds.Tables[0].Rows[7][2].ToString();
                    rg8 = ds.Tables[0].Rows[7][3].ToString();
                    //chk8.Checked = true;
                }
                if (i == 8)
                {
                    lblState9.Text = ds.Tables[0].Rows[8][0].ToString();
                    lblDate9.Text = ds.Tables[0].Rows[8][1].ToString();
                    lblNote9.Text = ds.Tables[0].Rows[8][2].ToString();
                    rg9 = ds.Tables[0].Rows[8][3].ToString();
                    //chk9.Checked = true;
                }
                if (i == 9)
                {
                    lblState10.Text = ds.Tables[0].Rows[9][0].ToString();
                    lblDate10.Text = ds.Tables[0].Rows[9][1].ToString();
                    lblNote10.Text = ds.Tables[0].Rows[9][2].ToString();
                    rg10 = ds.Tables[0].Rows[9][3].ToString();
                    //chk10.Checked = true;
                }

                cn.Close();

            }
        }
    }

    protected void lnkEdit1_Click(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            Session["Edit"] = rg1;  //lblState1.Text;
            Session["dt"] = lblDate1.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit2_Click(object sender, EventArgs e)
    {
        if (chk2.Checked == true)
        {
            Session["Edit"] = rg2; // lblState2.Text;
            Session["dt"] = lblDate2.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit3_Click(object sender, EventArgs e)
    {
        if (chk3.Checked == true)
        {
            Session["Edit"] = rg3;  // lblState3.Text;
            Session["dt"] = lblDate3.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit4_Click(object sender, EventArgs e)
    {
        if (chk4.Checked == true)
        {
            Session["Edit"] = rg4;  //lblState4.Text;
            Session["dt"] = lblDate4.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit5_Click(object sender, EventArgs e)
    {
        if (chk5.Checked == true)
        {
            Session["Edit"] = rg5;  // lblState5.Text;
            Session["dt"] = lblDate5.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit6_Click(object sender, EventArgs e)
    {
        if (chk6.Checked == true)
        {
            Session["Edit"] = rg6;  // lblState6.Text;
            Session["dt"] = lblDate6.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit7_Click(object sender, EventArgs e)
    {
        if (chk7.Checked == true)
        {
            Session["Edit"] = rg7; // lblState7.Text;
            Session["dt"] = lblDate7.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit8_Click(object sender, EventArgs e)
    {
        if (chk8.Checked == true)
        {
            Session["Edit"] = rg8;  // lblState8.Text;
            Session["dt"] = lblDate8.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit9_Click(object sender, EventArgs e)
    {
        if (chk9.Checked == true)
        {
            Session["Edit"] = rg9;  //0lblState9.Text;
            Session["dt"] = lblDate9.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void lnkEdit10_Click(object sender, EventArgs e)
    {
        if (chk10.Checked == true)
        {
            Session["Edit"] = rg10; // lblState10.Text;
            Session["dt"] = lblDate10.Text;
            Session["status"] = "Yes";
            Server.Transfer("HolidayUpdate.aspx");
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            cn.Open();
            string del1 = "delete from webx_holiday where HDAY_REGION = '" + rg1 + "' and HDAY_DATE = '" + lblDate1.Text + "'";
            SqlCommand cmd = new SqlCommand(del1, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState1.Visible = false;
            lblDate1.Visible = false;
            lblNote1.Visible = false;
            chk1.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string del2 = "delete from webx_holiday where HDAY_REGION = '" + rg2 + "' and HDAY_DATE = '" + lblDate2.Text + "'";
            SqlCommand cmd = new SqlCommand(del2, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState2.Visible = false;
            lblDate2.Visible = false;
            lblNote2.Visible = false;
            chk2.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string del3 = "delete from webx_holiday where HDAY_REGION = '" + rg3 + "' and HDAY_DATE = '" + lblDate3.Text + "'";
            SqlCommand cmd = new SqlCommand(del3, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState3.Visible = false;
            lblDate3.Visible = false;
            lblNote3.Visible = false;
            chk3.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string del4 = "delete from webx_holiday where HDAY_REGION = '" + rg4 + "' and HDAY_DATE = '" + lblDate4.Text + "'";
            SqlCommand cmd = new SqlCommand(del4, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState4.Visible = false;
            lblDate4.Visible = false;
            lblNote4.Visible = false;
            chk4.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string del5 = "delete from webx_holiday where HDAY_REGION = '" + rg5 + "' and HDAY_DATE = '" + lblDate5.Text + "'";
            SqlCommand cmd = new SqlCommand(del5, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState5.Visible = false;
            lblDate5.Visible = false;
            lblNote5.Visible = false;
            chk5.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string del6 = "delete from webx_holiday where HDAY_REGION = '" + rg6 + "' and HDAY_DATE = '" + lblDate6.Text + "'";
            SqlCommand cmd = new SqlCommand(del6, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState6.Visible = false;
            lblDate6.Visible = false;
            lblNote6.Visible = false;
            chk6.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string del7 = "delete from webx_holiday where HDAY_REGION = '" + rg7 + "' and HDAY_DATE = '" + lblDate7.Text + "'";
            SqlCommand cmd = new SqlCommand(del7, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState7.Visible = false;
            lblDate7.Visible = false;
            lblNote7.Visible = false;
            chk7.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string del8 = "delete from webx_holiday where HDAY_REGION = '" + rg8 + "' and HDAY_DATE = '" + lblDate8.Text + "'";
            SqlCommand cmd = new SqlCommand(del8, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState8.Visible = false;
            lblDate8.Visible = false;
            lblNote8.Visible = false;
            chk8.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string del9 = "delete from webx_holiday where HDAY_REGION = '" + rg9 + "' and HDAY_DATE = '" + lblDate9.Text + "'";
            SqlCommand cmd = new SqlCommand(del9, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState9.Visible = false;
            lblDate9.Visible = false;
            lblNote9.Visible = false;
            chk9.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string del10 = "delete from webx_holiday where HDAY_REGION = '" + rg10 + "' and HDAY_DATE = '" + lblDate10.Text + "'";
            SqlCommand cmd = new SqlCommand(del10, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblState10.Visible = false;
            lblDate10.Visible = false;
            lblNote10.Visible = false;
            chk10.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Server.Transfer("HolidayAdd.aspx");
    }
}

