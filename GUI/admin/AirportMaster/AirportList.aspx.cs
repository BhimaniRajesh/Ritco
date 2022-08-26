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

public partial class GUI_admin_AirportMaster_AirportList : System.Web.UI.Page
{
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        getData();
    }
    public void getData()
    {
        cn.Open();
        string sqlGet = "Select airportcode, airportcity from webx_airport_master";
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
                    lblCode1.Text = ds.Tables[0].Rows[0][0].ToString();
                    lblCity1.Text = ds.Tables[0].Rows[0][1].ToString();

                    //chk1.Checked = true;
                }
                if (i == 1)
                {
                    lblCode2.Text = ds.Tables[0].Rows[1][0].ToString();
                    lblCity2.Text = ds.Tables[0].Rows[1][1].ToString();

                    //chk2.Checked = true;
                }
                if (i == 2)
                {
                    lblCode3.Text = ds.Tables[0].Rows[2][0].ToString();
                    lblCity3.Text = ds.Tables[0].Rows[2][1].ToString();

                    //chk3.Checked = true;
                }
                if (i == 3)
                {
                    lblCode4.Text = ds.Tables[0].Rows[3][0].ToString();
                    lblCity4.Text = ds.Tables[0].Rows[3][1].ToString();

                    //chk4.Checked = true;
                }
                if (i == 4)
                {
                    lblCode5.Text = ds.Tables[0].Rows[4][0].ToString();
                    lblCity5.Text = ds.Tables[0].Rows[4][1].ToString();

                    //chk5.Checked = true;
                }
                if (i == 5)
                {
                    lblCode6.Text = ds.Tables[0].Rows[5][0].ToString();
                    lblCity6.Text = ds.Tables[0].Rows[5][1].ToString();

                    //chk6.Checked = true;
                }
                if (i == 6)
                {
                    lblCode7.Text = ds.Tables[0].Rows[6][0].ToString();
                    lblCity7.Text = ds.Tables[0].Rows[6][1].ToString();

                    //chk7.Checked = true;
                }
                if (i == 7)
                {
                    lblCode8.Text = ds.Tables[0].Rows[7][0].ToString();
                    lblCity8.Text = ds.Tables[0].Rows[7][1].ToString();

                    //chk8.Checked = true;
                }
                if (i == 8)
                {
                    lblCode9.Text = ds.Tables[0].Rows[8][0].ToString();
                    lblCity9.Text = ds.Tables[0].Rows[8][1].ToString();

                    //chk9.Checked = true;
                }
                if (i == 9)
                {
                    lblCode10.Text = ds.Tables[0].Rows[9][0].ToString();
                    lblCity10.Text = ds.Tables[0].Rows[9][1].ToString();

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
            Session["Edit"] = lblCode1.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit2_Click(object sender, EventArgs e)
    {
        if (chk2.Checked == true)
        {
            Session["Edit"] = lblCode2.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit3_Click(object sender, EventArgs e)
    {
        if (chk3.Checked == true)
        {
            Session["Edit"] = lblCode3.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit4_Click(object sender, EventArgs e)
    {
        if (chk4.Checked == true)
        {
            Session["Edit"] = lblCode4.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit5_Click(object sender, EventArgs e)
    {
        if (chk5.Checked == true)
        {
            Session["Edit"] = lblCode5.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit6_Click(object sender, EventArgs e)
    {
        if (chk6.Checked == true)
        {
            Session["Edit"] = lblCode6.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit7_Click(object sender, EventArgs e)
    {
        if (chk7.Checked == true)
        {
            Session["Edit"] = lblCode7.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit8_Click(object sender, EventArgs e)
    {
        if (chk8.Checked == true)
        {
            Session["Edit"] = lblCode8.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit9_Click(object sender, EventArgs e)
    {
        if (chk9.Checked == true)
        {
            Session["Edit"] = lblCode9.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void lnkEdit10_Click(object sender, EventArgs e)
    {
        if (chk10.Checked == true)
        {
            Session["Edit"] = lblCode10.Text;
            Server.Transfer("AirportMasterEdit.aspx"); 
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            cn.Open();
            string del1 = "delete from webx_airport_master where airportcode = '" + lblCode1.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del1, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode1.Visible = false;
            lblCity1.Visible = false;
            chk1.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus(); 
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string del2 = "delete from webx_airport_master where airportcode = '" + lblCode2.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del2, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode2.Visible = false;
            lblCity2.Visible = false;
            chk2.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus(); 
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string del3 = "delete from webx_airport_master where airportcode = '" + lblCode3.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del3, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode3.Visible = false;
            lblCity3.Visible = false;
            chk3.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus(); 
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string del4 = "delete from webx_airport_master where airportcode = '" + lblCode4.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del4, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode4.Visible = false;
            lblCity4.Visible = false;
            chk4.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus(); 
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string del5 = "delete from webx_airport_master where airportcode = '" + lblCode5.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del5, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode5.Visible = false;
            lblCity5.Visible = false;
            chk5.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string del6 = "delete from webx_airport_master where airportcode = '" + lblCode6.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del6, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode6.Visible = false;
            lblCity6.Visible = false;
            chk6.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string del7 = "delete from webx_airport_master where airportcode = '" + lblCode7.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del7, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode7.Visible = false;
            lblCity7.Visible = false;
            chk7.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string del8 = "delete from webx_airport_master where airportcode = '" + lblCode8.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del8, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode8.Visible = false;
            lblCity8.Visible = false;
            chk8.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string del9 = "delete from webx_airport_master where airportcode = '" + lblCode9.Text + "'"; 
            SqlCommand cmd = new SqlCommand(del9, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode9.Visible = false;
            lblCity9.Visible = false;
            chk9.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string del10 = "delete from webx_airport_master where airportcode = '" + lblCode10.Text + "'";
            SqlCommand cmd = new SqlCommand(del10, cn);
            cmd.ExecuteNonQuery();
            cn.Close();

            lblCode10.Visible = false;
            lblCity10.Visible = false;
            chk10.Checked = false;
            lblMsg.Text = "Record successfully deleted";
            lblMsg.Focus();
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Server.Transfer("AirportMasterAdd.aspx"); 
    }
}
