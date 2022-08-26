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

public partial class GUI_admin_CustomerMaster_AddCustLocwithDiffAddress : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(myCommon.Common.cnstr);
    public static string strGrpCd;
    public static string strCstCd;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
            strGrpCd = Session["strGrpCdS"].ToString().Trim();
            lblGrpCd.Text = strGrpCd;
            strCstCd = Session["popCustCd"].ToString().Trim(); 
            cn.Open();
            string sqlcustcd = "select custcd, custnm from webx_CUSTHDR where custcd='" + strCstCd + "'";
            //string sqlcustcd = "select custcd, custnm from webx_CUSTHDR where grpcd='"+ strGrpCd +"'";
            SqlCommand CmdCustCd = new SqlCommand(sqlcustcd, cn);
            SqlDataReader drCustCd = CmdCustCd.ExecuteReader();
            if (drCustCd.Read())
            {
                lblCstCd.Text = drCustCd["custcd"].ToString();
                lblCstNm.Text = drCustCd["custnm"].ToString();
            }
            drCustCd.Close();
            cn.Close();
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
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod1.Text + "','" + txtAdd1.Text + "','" + txtCity1.Text + "','" + txtPinCod1.Text + "','" + txtContPer1.Text + "','" + txtTel1.Text + "','" + txtFax1.Text + "','" + txtEmail1.Text + "','" + txtActFlag1.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod2.Text + "','" + txtAdd2.Text + "','" + txtCity2.Text + "','" + txtPinCod2.Text + "','" + txtContPer2.Text + "','" + txtTel2.Text + "','" + txtFax2.Text + "','" + txtEmail2.Text + "','" + txtActFlag2.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod3.Text + "','" + txtAdd3.Text + "','" + txtCity3.Text + "','" + txtPinCod3.Text + "','" + txtContPer3.Text + "','" + txtTel3.Text + "','" + txtFax3.Text + "','" + txtEmail3.Text + "','" + txtActFlag3.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod4.Text + "','" + txtAdd4.Text + "','" + txtCity4.Text + "','" + txtPinCod4.Text + "','" + txtContPer4.Text + "','" + txtTel4.Text + "','" + txtFax4.Text + "','" + txtEmail4.Text + "','" + txtActFlag4.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod5.Text + "','" + txtAdd5.Text + "','" + txtCity5.Text + "','" + txtPinCod5.Text + "','" + txtContPer5.Text + "','" + txtTel5.Text + "','" + txtFax5.Text + "','" + txtEmail5.Text + "','" + txtActFlag5.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod6.Text + "','" + txtAdd6.Text + "','" + txtCity6.Text + "','" + txtPinCod6.Text + "','" + txtContPer6.Text + "','" + txtTel6.Text + "','" + txtFax6.Text + "','" + txtEmail6.Text + "','" + txtActFlag6.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod7.Text + "','" + txtAdd7.Text + "','" + txtCity7.Text + "','" + txtPinCod7.Text + "','" + txtContPer7.Text + "','" + txtTel7.Text + "','" + txtFax7.Text + "','" + txtEmail7.Text + "','" + txtActFlag7.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod8.Text + "','" + txtAdd8.Text + "','" + txtCity8.Text + "','" + txtPinCod8.Text + "','" + txtContPer8.Text + "','" + txtTel8.Text + "','" + txtFax8.Text + "','" + txtEmail8.Text + "','" + txtActFlag8.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod9.Text + "','" + txtAdd9.Text + "','" + txtCity9.Text + "','" + txtPinCod9.Text + "','" + txtContPer9.Text + "','" + txtTel9.Text + "','" + txtFax9.Text + "','" + txtEmail9.Text + "','" + txtActFlag9.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string spsql = "insert into webx_CUSTDET(CUSTCD,LOCCD,CUSTADDRESS,CUSTCITY,CUSTPIN,CUSTCONTPERSON,CUSTTEL,CUSTFAX,CUSTEMAIL,ACTIVE_FLAG)values('" + lblCstCd.Text + "','" + txtLocCod10.Text + "','" + txtAdd10.Text + "','" + txtCity10.Text + "','" + txtPinCod10.Text + "','" + txtContPer10.Text + "','" + txtTel10.Text + "','" + txtFax10.Text + "','" + txtEmail10.Text + "','" + txtActFlag10.Text + "')"; 
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
    }

    protected void btnAddCity_Click(object sender, EventArgs e)
    {
        instCityVal();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("CustomerMasterAdd.aspx");
    }
}
