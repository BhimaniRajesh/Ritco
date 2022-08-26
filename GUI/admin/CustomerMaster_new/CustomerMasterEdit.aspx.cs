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

public partial class GUI_admin_CustomerMaster_CustomerMasterEdit : System.Web.UI.Page
{
    public static string strGrpCd;
    public static string strCustCd;
    public static string strtCstCd;
    public static string strCustCd1;
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

           string Para = Request.QueryString["para"].ToString();

            if (Para == "1")
            {
                strGrpCd = Session["strGrpCdS"].ToString().Trim();
                strCustCd1 = Session["popCustCd"].ToString().Trim();
                strtCstCd = Session["tCstCd"].ToString();
                lblGrpCd.Text = strGrpCd;
                getData();
            }

            else
            {
                strGrpCd = Request.QueryString["grpcd"].ToString();
                strtCstCd = Request.QueryString["cno"].ToString();
                strCustCd1 = Request.QueryString["cno"].ToString();
                lblGrpCd.Text = strGrpCd;
                getData();
            }



        }

    }
    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void c2_CheckedChanged(object sender, EventArgs e)
    {
        if (c2.Checked == true)
        {
            txtMblSer.Text = "Y";
        }
        else
        {
            txtMblSer.Text = "N";
        }
    }
    public string getNewCd(string strGrpCd)
    {
        int intCustCode = 1;

        cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(custcd), 4) as numeric(18, 0)) + 1 from webx_CUSTHDR where grpcd='" + strGrpCd + "'", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0].ToString());
        }

        drGet.Close();

        cn.Close();

        return strGrpCd + intCustCode.ToString().PadLeft(4, '0');
    }

    public void getData()
    {
        string sqlGet;
        cn.Open();
        if (strtCstCd != "")
        {
            sqlGet = "select GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress from webx_CUSTHDR where CUSTCD = '" + strtCstCd + "'";
        }
        else
        {
            sqlGet = "select GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress from webx_CUSTHDR where CUSTCD = '" + strCustCd1 + "'";
            //sqlGet = "select GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress from webx_CUSTHDR where GRPCD = '" + strGrpCd + "'";
        }
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {
            lblGrpCd.Text = getDr["GRPCD"].ToString() ;
            lblCst.Text = getDr["CUSTCD"].ToString();
            txtCstNm.Text = getDr["CUSTNM"].ToString();
            txtCstPwd.Text = "";
                //getDr["CUSTPASS"].ToString();
            ddCstCat.Text = getDr["CUSTCAT"].ToString();
            txtActFlag.Text = getDr["CUST_ACTIVE"].ToString();
            txtMblSer.Text = getDr["MOBSERV_ENABLED"].ToString();
            txtMblNo.Text = getDr["MOBILENO"].ToString();
            txtStNo.Text = getDr["STNUM"].ToString();
            txtCstNo.Text = getDr["CSTNO"].ToString();
            txtOpnDbt.Text = getDr["opendebit"].ToString();
            txtOpnCrdt.Text = getDr["opencredit"].ToString();
            txtCstLoc.Text = getDr["CUSTLOC"].ToString();
            txtCstAddress.Text = getDr["CustAddress"].ToString();
        }
        getDr.Close();
        cn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //strCustCd = getNewCd(strGrpCd);



        string locstr = txtCstLoc.Text;
        string locvalid = loc_validcheck(locstr);

        if (locvalid == "1")
        {
            cn.Open();
            string sqlUp = "update webx_CUSTHDR set GRPCD='" + lblGrpCd.Text + "',CUSTCD='" + lblCst.Text + "',CUSTNM='" + txtCstNm.Text + "',CUSTPASS='" + txtCstPwd.Text + "',CUSTCAT='" + ddCstCat.SelectedValue + "',CUST_ACTIVE='" + txtActFlag.Text + "',MOBSERV_ENABLED='" + txtMblSer.Text + "',MOBILENO='" + txtMblNo.Text + "',STNUM='" + txtStNo.Text + "',CSTNO='" + txtCstNo.Text + "',UPDTBY='" + Session["EmpCd"].ToString() + "',UPDTON='" + System.DateTime.Now.ToString() + "',opendebit='" + txtOpnDbt.Text + "',opencredit='" + txtOpnCrdt.Text + "',CUSTLOC='" + txtCstLoc.Text + "',CustAddress='" + txtCstAddress.Text + "' from webx_CUSTHDR where CUSTCD = '" + lblCst.Text + "'";
            //string sqlAdd = "insert into webx_CUSTHDR(GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress) values('" + strGrpCd + "','" + strCustCd + "','" + txtCstNm.Text.Trim() + "','" + strCustCd + "','" + ddCstCat.SelectedValue + "','" + txtActFlag.Text + "','" + txtMblSer.Text.Trim() + "','" + txtMblNo.Text.Trim() + "','" + txtStNo.Text.Trim() + "','" + txtCstNo.Text.Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() + "','" + Convert.ToDouble(txtOpnDbt.Text) + "','" + Convert.ToDouble(txtOpnCrdt.Text) + "','" + txtCstLoc.Text.Trim() + "','" + txtCstAddress.Text.Trim() + "')";
            SqlCommand sqlUpCmd = new SqlCommand(sqlUp, cn);
            sqlUpCmd.ExecuteNonQuery();
            cn.Close();
            Response.Redirect("CustomerMaster.aspx");

        }
        else
        {
            txtCstLoc.ForeColor = System.Drawing.Color.Red;
            txtCstLoc.Text = "Enter Valid Location";

        }
 
    }

    public string loc_validcheck(string loc)
    {
        string loc2 = loc;
        string[] loc3 = loc2.Split(',');
        string result = "";
        int len = loc3.Length;
        for (int i = 0; i < len; i++)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string l = loc3[i];

            string sql = "select* from webx_location where Loccode='" + l + "'";


            SqlCommand cmd = new SqlCommand(sql, conn);

            string dno2;
            conn.Open();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                result = "0";
                return result;
                break;
            }
            else
            {
                result = "1";
            }
        }


        return result;

    }

    //protected void btnGo_Click(object sender, EventArgs e)
    //{
    //    if (TextBox1.Text != "")
    //    {
    //        Session["tLocCod"] = TextBox1.Text;
    //        //Session["tCstCd"] = "";
    //        //Session["popCustCd"] = "";//txtLocCod.Text;
    //        Server.Transfer("AddCustLocwithDiffAddressEdit.aspx");
    //    }
    //}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("CustomerMaster.aspx");
    }
    //protected void LinkButton1_Click(object sender, EventArgs e)
    //{
    //    Session["t1LocCod"] = "";
    //    Server.Transfer("AddCustLocwithDiffAddressEdit.aspx");
    //}
    protected void btnReset_Click(object sender, EventArgs e)
    {
        lblGrpCd.Text = strGrpCd;
        txtCstNm.Text = "";
        ddCstCat.Text = "--Select--";
        txtActFlag.Text = "";
        txtMblSer.Text = "";
        txtMblNo.Text = "";
        txtStNo.Text = "";
        txtCstNo.Text = "";
        txtOpnDbt.Text = "";
        txtOpnCrdt.Text = "";
        txtCstLoc.Text = "";
        txtCstAddress.Text = "";

        getData(); 
    }
}
