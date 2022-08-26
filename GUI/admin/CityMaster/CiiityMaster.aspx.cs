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
using System.Text; 

public partial class CiiityMaster : System.Web.UI.Page
{

    SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(myCommon.Common.cnstr);
  
    protected void Page_Load(object sender, EventArgs e)
    {
       if (IsPostBack == false)
        {
            ddst1.Items.Add("--Select--");
            ddst2.Items.Add("--Select--");
            ddst3.Items.Add("--Select--");
            ddst4.Items.Add("--Select--");
            ddst5.Items.Add("--Select--");
            ddst6.Items.Add("--Select--");
            ddst7.Items.Add("--Select--");
            ddst8.Items.Add("--Select--");
            ddst9.Items.Add("--Select--");
            ddst10.Items.Add("--Select--");

            ddRg1.Items.Add("--Select--");
            ddRg2.Items.Add("--Select--");
            ddRg3.Items.Add("--Select--");
            ddRg4.Items.Add("--Select--");
            ddRg5.Items.Add("--Select--");
            ddRg6.Items.Add("--Select--");
            ddRg7.Items.Add("--Select--");
            ddRg8.Items.Add("--Select--");
            ddRg9.Items.Add("--Select--");
            ddRg10.Items.Add("--Select--");

            cn.Open();
            string sqlstr = "Select stnm,stcd from WEBX_STATE  order by stnm";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            
            while (dr.Read())
                {
                 ddst1.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst2.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst3.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst4.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst5.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst6.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst7.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst8.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst9.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                 ddst10.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                }
                dr.Close();
                
                string sqlstrRg = "Select ZoneName, ZoneCode from webx_zonemaster order by zonename";
                SqlCommand cmdRg = new SqlCommand(sqlstrRg, cn);
                SqlDataReader drRg = cmdRg.ExecuteReader();
                while(drRg.Read())
                {
                    ddRg1.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg2.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg3.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg4.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg5.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg6.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg7.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg8.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg9.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                    ddRg10.Items.Add(new ListItem(drRg.GetValue(0).ToString(), drRg.GetValue(1).ToString()));
                }
                drRg.Close();
                cn.Close();


            }

        }




    protected void chk11_CheckedChanged(object sender, EventArgs e)
    {
        if (chk11.Checked == true)
        {
            txtOda1.Text = "Y";
            txtOdaKm1.ReadOnly = false;
        }
        else
            if (chk11.Checked == false)
        {
            txtOda1.Text = "N";
            txtOdaKm1.Text = "0";
            txtOdaKm1.ReadOnly = true;
        }
    }
    protected void chk12_CheckedChanged(object sender, EventArgs e)
    {
        if (chk12.Checked == true)
        {
            txtOda2.Text = "Y";
            txtOdaKm2.ReadOnly = false;
        }
        else
            if (chk12.Checked == false)
            {
                txtOda2.Text = "N";
                txtOdaKm2.Text = "0";
                txtOdaKm2.ReadOnly = true;
            }

    }
    protected void chk13_CheckedChanged(object sender, EventArgs e)
    {
        if (chk13.Checked == true)
        {
            txtOda3.Text = "Y";
            txtOdaKm3.ReadOnly = false;
        }
        else
            if (chk13.Checked == false)
            {
                txtOda3.Text = "N";
                txtOdaKm3.Text = "0";
                txtOdaKm3.ReadOnly = true;
            }
    }
    protected void chk14_CheckedChanged(object sender, EventArgs e)
    {
        if (chk14.Checked == true)
        {
            txtOda4.Text = "Y";
            txtOdaKm4.ReadOnly = false;
        }
        else
            if (chk11.Checked == false)
            {
                txtOda4.Text = "N";
                txtOdaKm4.Text = "0";
                txtOdaKm4.ReadOnly = true;
            }
    }
    protected void chk15_CheckedChanged(object sender, EventArgs e)
    {
        if (chk15.Checked == true)
        {
            txtOda5.Text = "Y";
            txtOdaKm5.ReadOnly = false;
        }
        else
            if (chk15.Checked == false)
            {
                txtOda5.Text = "N";
                txtOdaKm5.Text = "0";
                txtOdaKm5.ReadOnly = true;
            }
    }
    protected void chk16_CheckedChanged(object sender, EventArgs e)
    {
        if (chk16.Checked == true)
        {
            txtOda6.Text = "Y";
            txtOdaKm6.ReadOnly = false;
        }
        else
            if (chk16.Checked == false)
            {
                txtOda6.Text = "N";
                txtOdaKm6.Text = "0";
                txtOdaKm6.ReadOnly = true;
            }
    }
    protected void chk17_CheckedChanged(object sender, EventArgs e)
    {
        if (chk17.Checked == true)
        {
            txtOda7.Text = "Y";
            txtOdaKm7.ReadOnly = false;
        }
        else
            if (chk17.Checked == false)
            {
                txtOda7.Text = "N";
                txtOdaKm7.Text = "0";
                txtOdaKm7.ReadOnly = true;
            }
    }
    protected void chk18_CheckedChanged(object sender, EventArgs e)
    {
        if (chk18.Checked == true)
        {
            txtOda8.Text = "Y";
            txtOdaKm8.ReadOnly = false;
        }
        else
            if (chk18.Checked == false)
            {
                txtOda8.Text = "N";
                txtOdaKm8.Text = "0";
                txtOdaKm8.ReadOnly = true;
            }
    }
    protected void chk19_CheckedChanged(object sender, EventArgs e)
    {
        if (chk19.Checked == true)
        {
            txtOda9.Text = "Y";
            txtOdaKm9.ReadOnly = false;
        }
        else
            if (chk19.Checked == false)
            {
                txtOda9.Text = "N";
                txtOdaKm9.Text = "0";
                txtOdaKm9.ReadOnly = true;
            }
    }
    protected void chk20_CheckedChanged(object sender, EventArgs e)
    {
        if (chk20.Checked == true)
        {
            txtOda10.Text = "Y";
            txtOdaKm10.ReadOnly = false;
        }
        else
            if (chk20.Checked == false)
            {
                txtOda10.Text = "N";
                txtOdaKm10.Text = "0";
                txtOdaKm10.ReadOnly = true;
            }
    }

    public void instCityVal()
    {
        if (chk1.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc1.Text + "','" + Convert.ToInt32(ddRg1.SelectedValue) + "','" + txtRdBkLoc1.Text + "','" + txtRdDelLoc1.Text + "','" + Convert.ToInt32(ddst1.SelectedValue) + "','" + txtOda1.Text + "','" + Convert.ToInt32(txtOdaKm1.Text) + "','" + txtAirBkLoc1.Text + "','" + txtAirDlLoc1.Text + "','" + txtRlBkLoc1.Text + "','" + txtRlDelLoc1.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc2.Text + "','" + Convert.ToInt32(ddRg2.SelectedValue) + "','" + txtRdBkLoc2.Text + "','" + txtRdDelLoc2.Text + "','" + Convert.ToInt32(ddst2.SelectedValue) + "','" + txtOda2.Text + "','" + Convert.ToInt32(txtOdaKm2.Text) + "','" + txtAirBkLoc2.Text + "','" + txtAirDlLoc2.Text + "','" + txtRlBkLoc2.Text + "','" + txtRlDelLoc2.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc3.Text + "','" + Convert.ToInt32(ddRg3.SelectedValue) + "','" + txtRdBkLoc3.Text + "','" + txtRdDelLoc3.Text + "','" + Convert.ToInt32(ddst3.SelectedValue) + "','" + txtOda3.Text + "','" + Convert.ToInt32(txtOdaKm3.Text) + "','" + txtAirBkLoc3.Text + "','" + txtAirDlLoc3.Text + "','" + txtRlBkLoc3.Text + "','" + txtRlDelLoc3.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc4.Text + "','" + Convert.ToInt32(ddRg4.SelectedValue) + "','" + txtRdBkLoc4.Text + "','" + txtRdDelLoc4.Text + "','" + Convert.ToInt32(ddst4.SelectedValue) + "','" + txtOda4.Text + "','" + Convert.ToInt32(txtOdaKm4.Text) + "','" + txtAirBkLoc4.Text + "','" + txtAirDlLoc4.Text + "','" + txtRlBkLoc4.Text + "','" + txtRlDelLoc4.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc5.Text + "','" + Convert.ToInt32(ddRg5.SelectedValue) + "','" + txtRdBkLoc5.Text + "','" + txtRdDelLoc5.Text + "','" + Convert.ToInt32(ddst5.SelectedValue) + "','" + txtOda5.Text + "','" + Convert.ToInt32(txtOdaKm5.Text) + "','" + txtAirBkLoc5.Text + "','" + txtAirDlLoc5.Text + "','" + txtRlBkLoc5.Text + "','" + txtRlDelLoc5.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc6.Text + "','" + Convert.ToInt32(ddRg6.SelectedValue) + "','" + txtRdBkLoc6.Text + "','" + txtRdDelLoc6.Text + "','" + Convert.ToInt32(ddst6.SelectedValue) + "','" + txtOda6.Text + "','" + Convert.ToInt32(txtOdaKm6.Text) + "','" + txtAirBkLoc6.Text + "','" + txtAirDlLoc6.Text + "','" + txtRlBkLoc6.Text + "','" + txtRlDelLoc6.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc7.Text + "','" + Convert.ToInt32(ddRg7.SelectedValue) + "','" + txtRdBkLoc7.Text + "','" + txtRdDelLoc7.Text + "','" + Convert.ToInt32(ddst7.SelectedValue) + "','" + txtOda7.Text + "','" + Convert.ToInt32(txtOdaKm7.Text) + "','" + txtAirBkLoc7.Text + "','" + txtAirDlLoc7.Text + "','" + txtRlBkLoc7.Text + "','" + txtRlDelLoc7.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc8.Text + "','" + Convert.ToInt32(ddRg8.SelectedValue) + "','" + txtRdBkLoc8.Text + "','" + txtRdDelLoc8.Text + "','" + Convert.ToInt32(ddst8.SelectedValue) + "','" + txtOda8.Text + "','" + Convert.ToInt32(txtOdaKm8.Text) + "','" + txtAirBkLoc8.Text + "','" + txtAirDlLoc8.Text + "','" + txtRlBkLoc8.Text + "','" + txtRlDelLoc8.Text + "')";  
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc9.Text + "','" + Convert.ToInt32(ddRg9.SelectedValue) + "','" + txtRdBkLoc9.Text + "','" + txtRdDelLoc9.Text + "','" + Convert.ToInt32(ddst9.SelectedValue) + "','" + txtOda9.Text + "','" + Convert.ToInt32(txtOdaKm9.Text) + "','" + txtAirBkLoc9.Text + "','" + txtAirDlLoc9.Text + "','" + txtRlBkLoc9.Text + "','" + txtRlDelLoc9.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_citymaster(Location, Region, book_loc, Del_loc, state, oda_yn, ODAkm, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail) values('" + txtCityLoc10.Text + "','" + Convert.ToInt32(ddRg10.SelectedValue) + "','" + txtRdBkLoc10.Text + "','" + txtRdDelLoc10.Text + "','" + Convert.ToInt32(ddst10.SelectedValue) + "','" + txtOda10.Text + "','" + Convert.ToInt32(txtOdaKm10.Text) + "','" + txtAirBkLoc10.Text + "','" + txtAirDlLoc10.Text + "','" + txtRlBkLoc10.Text + "','" + txtRlDelLoc10.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
    }
    //public bool funValidate()
    //{
    //    if (txtCityLoc1.Text == "" || ddRg1.SelectedIndex == 0 || ddst1.SelectedIndex == 0 || txtRdBkLoc1.Text == "" || txtRdDelLoc1.Text == "" || txtAirBkLoc1.Text == "" || txtAirDlLoc1.Text == "" || txtRlBkLoc1.Text == "" || txtRlDelLoc1.Text == "" || txtOda1.Text == "")
    //    {
    //        StringBuilder str = new StringBuilder();
    //        str.Append("<script language='javascript'>");
    //        str.Append("alert('Please do not keep blank')");
    //        str.Append("</script>");
    //        RegisterStartupScript("asdf", str.ToString());
    //    }
    //    return true;
    //}

    protected void btnAddCity_Click(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {            
            instCityVal();
        }
        if (chk2.Checked == true)
        {
            instCityVal();
        }
        if (chk3.Checked == true)
        {
            instCityVal();
        }
        if (chk4.Checked == true)
        {
            instCityVal();
        }
        if (chk5.Checked == true)
        {
            instCityVal();
        }
        if (chk6.Checked == true)
        {
            instCityVal();
        }
        if (chk7.Checked == true)
        {
            instCityVal();
        }
        if (chk8.Checked == true)
        {
            instCityVal();
        }
        if (chk9.Checked == true)
        {
            instCityVal();
        }
        if (chk10.Checked == true)
        {
            instCityVal();
        }
    }

}







