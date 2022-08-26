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

public partial class GUI_admin_CustomerMaster_AddCustLocwithDiffAddressEdit : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(myCommon.Common.cnstr);
    public static string strGrpCd;
    public static string strPpCstCd;
    public static string sqlGet;
    //public static string strtLocCd; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
            strGrpCd = Session["strGrpCdS"].ToString().Trim();
            lblGrpCd.Text = strGrpCd;
            strPpCstCd = Session["popCustCd"].ToString().Trim();
            //strtLocCd = Session["tLocCod"].ToString().Trim();
            cn.Open();
            string sqlcustcd = "select custcd, custnm from webx_CUSTHDR where custcd='" + strPpCstCd + "'";
            //string sqlcustcd = "select custcd, custnm from webx_CUSTHDR where grpcd='" + strGrpCd + "'";
            SqlCommand CmdCustCd = new SqlCommand(sqlcustcd, cn);
            SqlDataReader drCustCd = CmdCustCd.ExecuteReader();
            if (drCustCd.Read())
            {
                lblCstCd.Text = drCustCd["custcd"].ToString();
                lblCstNm.Text = drCustCd["custnm"].ToString();
                //Session["popCustCd"] = drCustCd["custcd"].ToString();
            }
            drCustCd.Close();
            cn.Close();
            getData();

            //Label1.Text = "";
            lblmsg.Text = "";
        }
    }

    public void getData()
    {
        //string sqlGet;
        cn.Open();
        if (Session["t1LocCod"].ToString() != "")
        {
            sqlGet = "select LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG from webx_CUSTDET where LOCCD='" + Session["tLocCod"].ToString().Trim() + "' order by LOCCD";
            //sqlGet = "select LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG from webx_CUSTDET where CUSTCD='" + strPpCstCd + "' and LOCCD='" + Session["tLocCod"].ToString().Trim() + "' order by LOCCD";
        }
        else
            if (strPpCstCd != "")
            {
                sqlGet = "select LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG from webx_CUSTDET where CUSTCD='" + strPpCstCd + "' order by LOCCD";
            }
        else
           if(Session["tCstCd"].ToString() != "")
        {
            sqlGet = "select LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG from webx_CUSTDET where CUSTCD='" + Session["tCstCd"].ToString().Trim() + "' order by LOCCD";
        }
        
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmdGet);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        int totRow = ds.Tables[0].Rows.Count;
        if (totRow == 0)
        {
            Label1.Text = "Record not found";
        }
        else
        {
            Label1.Text = "";
            for (int i = 0; i <= totRow -1; i++)
            {
                if (i == 0)
                {
                    txtLocCod1.Text = ds.Tables[0].Rows[0][0].ToString();
                    txtAdd1.Text = ds.Tables[0].Rows[0][1].ToString();
                    txtCity1.Text = ds.Tables[0].Rows[0][2].ToString();
                    txtPinCod1.Text = ds.Tables[0].Rows[0][3].ToString();
                    txtContPer1.Text = ds.Tables[0].Rows[0][4].ToString();
                    txtTel1.Text = ds.Tables[0].Rows[0][5].ToString();
                    txtFax1.Text = ds.Tables[0].Rows[0][6].ToString();
                    txtEmail1.Text = ds.Tables[0].Rows[0][7].ToString();
                    txtActFlag1.Text = ds.Tables[0].Rows[0][8].ToString();
                    chk1.Checked = true; 
                    if (txtActFlag1.Text == "Y")
                    {
                        chk11.Checked = true;
                    }
                }
                if (i == 1)
                {
                    txtLocCod2.Text = ds.Tables[0].Rows[1][0].ToString();
                    txtAdd2.Text = ds.Tables[0].Rows[1][1].ToString();
                    txtCity2.Text = ds.Tables[0].Rows[1][2].ToString();
                    txtPinCod2.Text = ds.Tables[0].Rows[1][3].ToString();
                    txtContPer2.Text = ds.Tables[0].Rows[1][4].ToString();
                    txtTel2.Text = ds.Tables[0].Rows[1][5].ToString();
                    txtFax2.Text = ds.Tables[0].Rows[1][6].ToString();
                    txtEmail2.Text = ds.Tables[0].Rows[1][7].ToString();
                    txtActFlag2.Text = ds.Tables[0].Rows[1][8].ToString();
                    chk2.Checked = true;
                    if (txtActFlag2.Text == "Y")
                    {
                        chk12.Checked = true;
                    }
                }
                if (i == 2)
                {
                    txtLocCod3.Text = ds.Tables[0].Rows[2][0].ToString();
                    txtAdd3.Text = ds.Tables[0].Rows[2][1].ToString();
                    txtCity3.Text = ds.Tables[0].Rows[2][2].ToString();
                    txtPinCod3.Text = ds.Tables[0].Rows[2][3].ToString();
                    txtContPer3.Text = ds.Tables[0].Rows[2][4].ToString();
                    txtTel3.Text = ds.Tables[0].Rows[2][5].ToString();
                    txtFax3.Text = ds.Tables[0].Rows[2][6].ToString();
                    txtEmail3.Text = ds.Tables[0].Rows[2][7].ToString();
                    txtActFlag3.Text = ds.Tables[0].Rows[2][8].ToString();
                    chk3.Checked = true;
                    if (txtActFlag3.Text == "Y")
                    {
                        chk13.Checked = true;
                    }
                }
                if (i == 3)
                {
                    txtLocCod4.Text = ds.Tables[0].Rows[3][0].ToString();
                    txtAdd4.Text = ds.Tables[0].Rows[3][1].ToString();
                    txtCity4.Text = ds.Tables[0].Rows[3][2].ToString();
                    txtPinCod4.Text = ds.Tables[0].Rows[3][3].ToString();
                    txtContPer4.Text = ds.Tables[0].Rows[3][4].ToString();
                    txtTel4.Text = ds.Tables[0].Rows[3][5].ToString();
                    txtFax4.Text = ds.Tables[0].Rows[3][6].ToString();
                    txtEmail4.Text = ds.Tables[0].Rows[3][7].ToString();
                    txtActFlag4.Text = ds.Tables[0].Rows[3][8].ToString();
                    chk4.Checked = true;
                    if (txtActFlag4.Text == "Y")
                    {
                        chk14.Checked = true;
                    }
                }
                if (i == 4)
                {
                    txtLocCod5.Text = ds.Tables[0].Rows[4][0].ToString();
                    txtAdd5.Text = ds.Tables[0].Rows[4][1].ToString();
                    txtCity5.Text = ds.Tables[0].Rows[4][2].ToString();
                    txtPinCod5.Text = ds.Tables[0].Rows[4][3].ToString();
                    txtContPer5.Text = ds.Tables[0].Rows[4][4].ToString();
                    txtTel5.Text = ds.Tables[0].Rows[4][5].ToString();
                    txtFax5.Text = ds.Tables[0].Rows[4][6].ToString();
                    txtEmail5.Text = ds.Tables[0].Rows[4][7].ToString();
                    txtActFlag5.Text = ds.Tables[0].Rows[4][8].ToString();
                    chk5.Checked = true;
                    if (txtActFlag5.Text == "Y")
                    {
                        chk15.Checked = true;
                    }
                }
                if (i == 5)
                {
                    txtLocCod6.Text = ds.Tables[0].Rows[5][0].ToString();
                    txtAdd6.Text = ds.Tables[0].Rows[5][1].ToString();
                    txtCity6.Text = ds.Tables[0].Rows[5][2].ToString();
                    txtPinCod6.Text = ds.Tables[0].Rows[5][3].ToString();
                    txtContPer6.Text = ds.Tables[0].Rows[5][4].ToString();
                    txtTel6.Text = ds.Tables[0].Rows[5][5].ToString();
                    txtFax6.Text = ds.Tables[0].Rows[5][6].ToString();
                    txtEmail6.Text = ds.Tables[0].Rows[5][7].ToString();
                    txtActFlag6.Text = ds.Tables[0].Rows[5][8].ToString();
                    chk6.Checked = true;
                    if (txtActFlag6.Text == "Y")
                    {
                        chk16.Checked = true;
                    }
                }
                if (i == 6)
                {
                    txtLocCod7.Text = ds.Tables[0].Rows[6][0].ToString();
                    txtAdd7.Text = ds.Tables[0].Rows[6][1].ToString();
                    txtCity7.Text = ds.Tables[0].Rows[6][2].ToString();
                    txtPinCod7.Text = ds.Tables[0].Rows[6][3].ToString();
                    txtContPer7.Text = ds.Tables[0].Rows[6][4].ToString();
                    txtTel7.Text = ds.Tables[0].Rows[6][5].ToString();
                    txtFax7.Text = ds.Tables[0].Rows[6][6].ToString();
                    txtEmail7.Text = ds.Tables[0].Rows[6][7].ToString();
                    txtActFlag7.Text = ds.Tables[0].Rows[6][8].ToString();
                    chk7.Checked = true;
                    if (txtActFlag7.Text == "Y")
                    {
                        chk17.Checked = true;
                    }
                }
                if (i == 7)
                {
                    txtLocCod8.Text = ds.Tables[0].Rows[7][0].ToString();
                    txtAdd8.Text = ds.Tables[0].Rows[7][1].ToString();
                    txtCity8.Text = ds.Tables[0].Rows[7][2].ToString();
                    txtPinCod8.Text = ds.Tables[0].Rows[7][3].ToString();
                    txtContPer8.Text = ds.Tables[0].Rows[7][4].ToString();
                    txtTel8.Text = ds.Tables[0].Rows[7][5].ToString();
                    txtFax8.Text = ds.Tables[0].Rows[7][6].ToString();
                    txtEmail8.Text = ds.Tables[0].Rows[7][7].ToString();
                    txtActFlag8.Text = ds.Tables[0].Rows[7][8].ToString();
                    chk8.Checked = true;
                    if (txtActFlag8.Text == "Y")
                    {
                        chk18.Checked = true;
                    }
                }
                if (i == 8)
                {
                    txtLocCod9.Text = ds.Tables[0].Rows[8][0].ToString();
                    txtAdd9.Text = ds.Tables[0].Rows[8][1].ToString();
                    txtCity9.Text = ds.Tables[0].Rows[8][2].ToString();
                    txtPinCod9.Text = ds.Tables[0].Rows[8][3].ToString();
                    txtContPer9.Text = ds.Tables[0].Rows[8][4].ToString();
                    txtTel9.Text = ds.Tables[0].Rows[8][5].ToString();
                    txtFax9.Text = ds.Tables[0].Rows[8][6].ToString();
                    txtEmail9.Text = ds.Tables[0].Rows[8][7].ToString();
                    txtActFlag9.Text = ds.Tables[0].Rows[8][8].ToString();
                    chk9.Checked = true;
                    if (txtActFlag9.Text == "Y")
                    {
                        chk19.Checked = true;
                    }
                }
                if (i == 9)
                {
                    txtLocCod10.Text = ds.Tables[0].Rows[9][0].ToString();
                    txtAdd10.Text = ds.Tables[0].Rows[9][1].ToString();
                    txtCity10.Text = ds.Tables[0].Rows[9][2].ToString();
                    txtPinCod10.Text = ds.Tables[0].Rows[9][3].ToString();
                    txtContPer10.Text = ds.Tables[0].Rows[9][4].ToString();
                    txtTel10.Text = ds.Tables[0].Rows[9][5].ToString();
                    txtFax10.Text = ds.Tables[0].Rows[9][6].ToString();
                    txtEmail10.Text = ds.Tables[0].Rows[9][7].ToString();
                    txtActFlag10.Text = ds.Tables[0].Rows[9][8].ToString();
                    chk10.Checked = true;
                    if (txtActFlag10.Text == "Y")
                    {
                        chk20.Checked = true;
                    }
                }
            }
        }
    }

    protected void chk11_CheckedChanged(object sender, EventArgs e)
    {
        if (chk11.Checked == true)
        {
            txtActFlag1.Text = "Y";
        }
        else
        {
            txtActFlag1.Text = "N";
        }

    }
    protected void chk12_CheckedChanged(object sender, EventArgs e)
    {
        if (chk12.Checked == true)
        {
            txtActFlag2.Text = "Y";
        }
        else
        {
            txtActFlag2.Text = "N";
        }

    }
    protected void chk13_CheckedChanged(object sender, EventArgs e)
    {
        if (chk13.Checked == true)
        {
            txtActFlag3.Text = "Y";
        }
        else
        {
            txtActFlag3.Text = "N";
        }
    }
    protected void chk14_CheckedChanged(object sender, EventArgs e)
    {
        if (chk14.Checked == true)
        {
            txtActFlag4.Text = "Y";
        }
        else
        {
            txtActFlag4.Text = "N";
        }
    }
    protected void chk15_CheckedChanged(object sender, EventArgs e)
    {
        if (chk15.Checked == true)
        {
            txtActFlag5.Text = "Y";
        }
        else
        {
            txtActFlag5.Text = "N";
        }
    }
    protected void chk16_CheckedChanged(object sender, EventArgs e)
    {
        if (chk16.Checked == true)
        {
            txtActFlag6.Text = "Y";
        }
        else
        {
            txtActFlag6.Text = "N";
        }
    }
    protected void chk17_CheckedChanged(object sender, EventArgs e)
    {
        if (chk17.Checked == true)
        {
            txtActFlag7.Text = "Y";
        }
        else
        {
            txtActFlag7.Text = "N";
        }
    }
    protected void chk18_CheckedChanged(object sender, EventArgs e)
    {
        if (chk18.Checked == true)
        {
            txtActFlag8.Text = "Y";
        }
        else
        {
            txtActFlag8.Text = "N";
        }
    }
    protected void chk19_CheckedChanged(object sender, EventArgs e)
    {
        if (chk19.Checked == true)
        {
            txtActFlag9.Text = "Y";
        }
        else
        {
            txtActFlag9.Text = "N";
        }
    }
    protected void chk20_CheckedChanged(object sender, EventArgs e)
    {
        if (chk20.Checked == true)
        {
            txtActFlag10.Text = "Y";
        }
        else
        {
            txtActFlag10.Text = "N";
        }
    }

    public void instCityVal()
    {
        if (chk1.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod1.Text + "',CUSTADDRESS = '" + txtAdd1.Text + "',CUSTCITY = '" + txtCity1.Text + "',CUSTPIN = '" + txtPinCod1.Text + "',CUSTCONTPERSON='" + txtContPer1.Text + "',CUSTTEL= '" + txtTel1.Text + "',CUSTFAX = '" + txtFax1.Text + "',CUSTEMAIL= '" + txtEmail1.Text + "',ACTIVE_FLAG='" + txtActFlag1.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod2.Text + "',CUSTADDRESS = '" + txtAdd2.Text + "',CUSTCITY = '" + txtCity2.Text + "',CUSTPIN = '" + txtPinCod2.Text + "',CUSTCONTPERSON='" + txtContPer2.Text + "',CUSTTEL= '" + txtTel2.Text + "',CUSTFAX = '" + txtFax2.Text + "',CUSTEMAIL= '" + txtEmail2.Text + "',ACTIVE_FLAG='" + txtActFlag2.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod3.Text + "',CUSTADDRESS = '" + txtAdd3.Text + "',CUSTCITY = '" + txtCity3.Text + "',CUSTPIN = '" + txtPinCod3.Text + "',CUSTCONTPERSON='" + txtContPer3.Text + "',CUSTTEL= '" + txtTel3.Text + "',CUSTFAX = '" + txtFax3.Text + "',CUSTEMAIL= '" + txtEmail3.Text + "',ACTIVE_FLAG='" + txtActFlag3.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod4.Text + "',CUSTADDRESS = '" + txtAdd4.Text + "',CUSTCITY = '" + txtCity4.Text + "',CUSTPIN = '" + txtPinCod4.Text + "',CUSTCONTPERSON='" + txtContPer4.Text + "',CUSTTEL= '" + txtTel4.Text + "',CUSTFAX = '" + txtFax4.Text + "',CUSTEMAIL= '" + txtEmail4.Text + "',ACTIVE_FLAG='" + txtActFlag4.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod5.Text + "',CUSTADDRESS = '" + txtAdd5.Text + "',CUSTCITY = '" + txtCity5.Text + "',CUSTPIN = '" + txtPinCod5.Text + "',CUSTCONTPERSON='" + txtContPer5.Text + "',CUSTTEL= '" + txtTel5.Text + "',CUSTFAX = '" + txtFax5.Text + "',CUSTEMAIL= '" + txtEmail5.Text + "',ACTIVE_FLAG='" + txtActFlag5.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod6.Text + "',CUSTADDRESS = '" + txtAdd6.Text + "',CUSTCITY = '" + txtCity6.Text + "',CUSTPIN = '" + txtPinCod6.Text + "',CUSTCONTPERSON='" + txtContPer6.Text + "',CUSTTEL= '" + txtTel6.Text + "',CUSTFAX = '" + txtFax6.Text + "',CUSTEMAIL= '" + txtEmail6.Text + "',ACTIVE_FLAG='" + txtActFlag6.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod7.Text + "',CUSTADDRESS = '" + txtAdd7.Text + "',CUSTCITY = '" + txtCity7.Text + "',CUSTPIN = '" + txtPinCod7.Text + "',CUSTCONTPERSON='" + txtContPer7.Text + "',CUSTTEL= '" + txtTel7.Text + "',CUSTFAX = '" + txtFax7.Text + "',CUSTEMAIL= '" + txtEmail7.Text + "',ACTIVE_FLAG='" + txtActFlag7.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod8.Text + "',CUSTADDRESS = '" + txtAdd8.Text + "',CUSTCITY = '" + txtCity8.Text + "',CUSTPIN = '" + txtPinCod8.Text + "',CUSTCONTPERSON='" + txtContPer8.Text + "',CUSTTEL= '" + txtTel8.Text + "',CUSTFAX = '" + txtFax8.Text + "',CUSTEMAIL= '" + txtEmail8.Text + "',ACTIVE_FLAG='" + txtActFlag8.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod9.Text + "',CUSTADDRESS = '" + txtAdd9.Text + "',CUSTCITY = '" + txtCity9.Text + "',CUSTPIN = '" + txtPinCod9.Text + "',CUSTCONTPERSON='" + txtContPer9.Text + "',CUSTTEL= '" + txtTel9.Text + "',CUSTFAX = '" + txtFax9.Text + "',CUSTEMAIL= '" + txtEmail9.Text + "',ACTIVE_FLAG='" + txtActFlag9.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string sqlupdt = "update webx_CUSTDET set loccd='" + txtLocCod10.Text + "',CUSTADDRESS = '" + txtAdd10.Text + "',CUSTCITY = '" + txtCity10.Text + "',CUSTPIN = '" + txtPinCod10.Text + "',CUSTCONTPERSON='" + txtContPer10.Text + "',CUSTTEL= '" + txtTel10.Text + "',CUSTFAX = '" + txtFax10.Text + "',CUSTEMAIL= '" + txtEmail10.Text + "',ACTIVE_FLAG='" + txtActFlag10.Text + "' where CUSTCD='" + lblCstCd.Text + "'";
            SqlCommand valCmd = new SqlCommand(sqlupdt, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
    }

    protected void btnAddCity_Click(object sender, EventArgs e)
    {
        if (Label1.Text != "")
        {
            lblmsg.Text = "Record Not Found";
        }
        else
        {
            instCityVal();
            lblmsg.Text = "Record Updated";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("CustomerMasterAdd.aspx");
    }
}
