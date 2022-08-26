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

public partial class CityMaster_Update : System.Web.UI.Page
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

            lblMsg.Text = "";

            //string city2 = txtCityLoc2.Text;

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
            while (drRg.Read())
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
    public bool find1()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc1.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find2()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc2.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find3()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc3.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find4()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc4.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find5()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc5.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find6()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc6.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find7()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc7.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find8()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc8.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find9()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc9.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }
    public bool find10()
    {
        SqlCommand cm = new SqlCommand("select Location from webx_citymaster where Location='" + txtCityLoc10.Text + "'", cn);
        object v = null;
        cn.Open();
        v = cm.ExecuteScalar();
        cn.Close();
        if (v == null)
            return false;
        else
            return true;
    }


    public void instCityVal()
    {
        if (chk1.Checked == true)
        {
            if (find1() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc1.Text + "', Region='" + Convert.ToInt32(ddRg1.SelectedValue) + "', book_loc='" + txtRdBkLoc1.Text + "', Del_loc='" + txtRdDelLoc1.Text + "', state='" + Convert.ToInt32(ddst1.SelectedValue) + "', oda_yn='" + txtOda1.Text + "', ODAkm='" + txtOdaKm1.Text + "', Book_loc_air='" + txtAirBkLoc1.Text + "', Del_loc_air='" + txtAirDlLoc1.Text + "', Book_loc_Rail='" + txtRlBkLoc1.Text + "', Del_loc_Rail='" + txtRlDelLoc1.Text + "' where Location = '" + txtCityLoc1.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk2.Checked == true)
        {
            if (find2() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc2.Text + "', Region='" + Convert.ToInt32(ddRg2.SelectedValue) + "', book_loc='" + txtRdBkLoc2.Text + "', Del_loc='" + txtRdDelLoc2.Text + "', state='" + Convert.ToInt32(ddst2.SelectedValue) + "', oda_yn='" + txtOda2.Text + "', ODAkm='" + txtOdaKm2.Text + "', Book_loc_air='" + txtAirBkLoc2.Text + "', Del_loc_air='" + txtAirDlLoc2.Text + "', Book_loc_Rail='" + txtRlBkLoc2.Text + "', Del_loc_Rail='" + txtRlDelLoc2.Text + "' where Location = '" + txtCityLoc2.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk3.Checked == true)
        {
            if (find3() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc3.Text + "', Region='" + Convert.ToInt32(ddRg3.SelectedValue) + "', book_loc='" + txtRdBkLoc3.Text + "', Del_loc='" + txtRdDelLoc3.Text + "', state='" + Convert.ToInt32(ddst3.SelectedValue) + "', oda_yn='" + txtOda3.Text + "', ODAkm='" + txtOdaKm3.Text + "', Book_loc_air='" + txtAirBkLoc3.Text + "', Del_loc_air='" + txtAirDlLoc3.Text + "', Book_loc_Rail='" + txtRlBkLoc3.Text + "', Del_loc_Rail='" + txtRlDelLoc3.Text + "' where Location = '" + txtCityLoc3.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk4.Checked == true)
        {
            if (find4() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc4.Text + "', Region='" + Convert.ToInt32(ddRg4.SelectedValue) + "', book_loc='" + txtRdBkLoc4.Text + "', Del_loc='" + txtRdDelLoc4.Text + "', state='" + Convert.ToInt32(ddst4.SelectedValue) + "', oda_yn='" + txtOda4.Text + "', ODAkm='" + txtOdaKm4.Text + "', Book_loc_air='" + txtAirBkLoc4.Text + "', Del_loc_air='" + txtAirDlLoc4.Text + "', Book_loc_Rail='" + txtRlBkLoc4.Text + "', Del_loc_Rail='" + txtRlDelLoc4.Text + "' where Location = '" + txtCityLoc4.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk5.Checked == true)
        {
            if (find5() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc5.Text + "', Region='" + Convert.ToInt32(ddRg5.SelectedValue) + "', book_loc='" + txtRdBkLoc5.Text + "', Del_loc='" + txtRdDelLoc5.Text + "', state='" + Convert.ToInt32(ddst5.SelectedValue) + "', oda_yn='" + txtOda5.Text + "', ODAkm='" + txtOdaKm5.Text + "', Book_loc_air='" + txtAirBkLoc5.Text + "', Del_loc_air='" + txtAirDlLoc5.Text + "', Book_loc_Rail='" + txtRlBkLoc5.Text + "', Del_loc_Rail='" + txtRlDelLoc5.Text + "' where Location = '" + txtCityLoc5.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk6.Checked == true)
        {
            if (find6() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc6.Text + "', Region='" + Convert.ToInt32(ddRg6.SelectedValue) + "', book_loc='" + txtRdBkLoc6.Text + "', Del_loc='" + txtRdDelLoc6.Text + "', state='" + Convert.ToInt32(ddst6.SelectedValue) + "', oda_yn='" + txtOda6.Text + "', ODAkm='" + txtOdaKm6.Text + "', Book_loc_air='" + txtAirBkLoc6.Text + "', Del_loc_air='" + txtAirDlLoc6.Text + "', Book_loc_Rail='" + txtRlBkLoc6.Text + "', Del_loc_Rail='" + txtRlDelLoc6.Text + "' where Location = '" + txtCityLoc6.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk7.Checked == true)
        {
            if (find7() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc7.Text + "', Region='" + Convert.ToInt32(ddRg7.SelectedValue) + "', book_loc='" + txtRdBkLoc7.Text + "', Del_loc='" + txtRdDelLoc7.Text + "', state='" + Convert.ToInt32(ddst7.SelectedValue) + "', oda_yn='" + txtOda7.Text + "', ODAkm='" + txtOdaKm7.Text + "', Book_loc_air='" + txtAirBkLoc7.Text + "', Del_loc_air='" + txtAirDlLoc7.Text + "', Book_loc_Rail='" + txtRlBkLoc7.Text + "', Del_loc_Rail='" + txtRlDelLoc7.Text + "' where Location = '" + txtCityLoc7.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk8.Checked == true)
        {
            if (find8() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc8.Text + "', Region='" + Convert.ToInt32(ddRg8.SelectedValue) + "', book_loc='" + txtRdBkLoc8.Text + "', Del_loc='" + txtRdDelLoc8.Text + "', state='" + Convert.ToInt32(ddst8.SelectedValue) + "', oda_yn='" + txtOda8.Text + "', ODAkm='" + txtOdaKm8.Text + "', Book_loc_air='" + txtAirBkLoc8.Text + "', Del_loc_air='" + txtAirDlLoc8.Text + "', Book_loc_Rail='" + txtRlBkLoc8.Text + "', Del_loc_Rail='" + txtRlDelLoc8.Text + "' where Location = '" + txtCityLoc8.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk9.Checked == true)
        {
            if (find9() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc9.Text + "', Region='" + Convert.ToInt32(ddRg9.SelectedValue) + "', book_loc='" + txtRdBkLoc9.Text + "', Del_loc='" + txtRdDelLoc9.Text + "', state='" + Convert.ToInt32(ddst9.SelectedValue) + "', oda_yn='" + txtOda9.Text + "', ODAkm='" + txtOdaKm9.Text + "', Book_loc_air='" + txtAirBkLoc9.Text + "', Del_loc_air='" + txtAirDlLoc9.Text + "', Book_loc_Rail='" + txtRlBkLoc9.Text + "', Del_loc_Rail='" + txtRlDelLoc9.Text + "' where Location = '" + txtCityLoc9.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
        }
        if (chk10.Checked == true)
        {
            if (find10() == false)
            {
                lblMsg.Text = "Record Not Found";
            }
            else
            {
                cn.Open();
                string spsql = "update webx_citymaster set Location='" + txtCityLoc10.Text + "', Region='" + Convert.ToInt32(ddRg10.SelectedValue) + "', book_loc='" + txtRdBkLoc10.Text + "', Del_loc='" + txtRdDelLoc10.Text + "', state='" + Convert.ToInt32(ddst10.SelectedValue) + "', oda_yn='" + txtOda10.Text + "', ODAkm='" + txtOdaKm10.Text + "', Book_loc_air='" + txtAirBkLoc10.Text + "', Del_loc_air='" + txtAirDlLoc10.Text + "', Book_loc_Rail='" + txtRlBkLoc10.Text + "', Del_loc_Rail='" + txtRlDelLoc10.Text + "' where Location = '" + txtCityLoc10.Text + "'";
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();
                cn.Close();
                lblMsg.Text = "Record Updated";
            }
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
        instCityVal();
    }
}
      
