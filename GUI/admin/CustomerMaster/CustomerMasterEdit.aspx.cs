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
using WebX.Common;

public partial class GUI_admin_CustomerMaster_CustomerMasterAdd : System.Web.UI.Page
{
    public static string strGrpCd;
    public static string strCustCd;
    public static string strtCstCd;
    public static string strCustCd1;
    public static string cd, pass2, p1;

    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        getstring();

        if (!IsPostBack)
        {
            bindpaytype();
            string Para = Request.QueryString["para"].ToString();
            pass2 = "**********";
            //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            if (Para == "1")
            {
                strGrpCd = Session["g"].ToString();
                //Session["strGrpCdS"].ToString().Trim();
                strCustCd1 = Session["popCustCd"].ToString().Trim();
                strtCstCd = Session["tCstCd"].ToString();
                lblGrpCd.Text = strGrpCd;
                popcity();
                getData();
            }

            else
            {
                strGrpCd = Request.QueryString["grpcd"].ToString();
                strtCstCd = Request.QueryString["cno"].ToString();
                strCustCd1 = Request.QueryString["cno"].ToString();
                lblGrpCd.Text = strGrpCd;
                popcity();
                getData();
            }




            //strGrpCd = Request.QueryString["custgrp"].ToString();
            //Session["strGrpCdS"].ToString().Trim();

        }

        txtpin.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");
        txtMblNo.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");
        txtStNo.Attributes.Add("onblur", "javascript:return Falphanum(this)");
        txtpan.Attributes.Add("onblur", "javascript:return Falphanum2(this)");
        //txtOpnDbt.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        txtpin.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        txttel.Attributes.Add("onblur", "javascript:return IsNumericComma(this)");

        btnSubmit.Attributes.Add("onClick", "javascript:return x(" + txtCstLoc.ClientID + ")");
        txtCstLoc.ForeColor = System.Drawing.Color.Black;

        // btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtCstLoc.ClientID + ")");




    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        // string sql = "SELECT loc FROM  webx_zonemaster";
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }

    public void popcity()
    {
        cn.Open();
        SqlCommand c = new SqlCommand("select Location as c1 from webx_citymaster order by c1", cn);
        SqlDataAdapter d = new SqlDataAdapter(c);
        DataSet s = new DataSet();
        d.Fill(s);
        ddcity.DataSource = s;
        ddcity.DataTextField = "c1";
        ddcity.DataValueField = "c1";


        ddcity.DataBind();
        ddcity.Items.Insert(0, "-- Select --");


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



    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        string l = txtCstLoc.Text;

        int len = l.Length;

        string t1 = l.Substring(len - 1, 1);

        string loc123 = "";

        if (t1 == ",")
        {
            loc123 = l.Substring(0, l.Length - 1).Trim();
        }
        else
        {

            loc123 = l.Trim();
        }


        string pw = "";

        if (txtPwd.Text == pass2)
        {
            pw = p1;
        }
        else
        {
            pw = txtPwd.Text;
        }

		using (var oWebXHelper = new WebXHelper())
        {
            oWebXHelper.BeginTransaction();
            try
            {
                oWebXHelper.ExecuteNonQuery(CommandType.StoredProcedure, "Usp_CustomerMaster_UpdateDetail", new[]{
                 new SqlParameter("@GRPCD",lblGrpCd.Text.Trim()),
                 new SqlParameter("@CUSTCD",lblCst.Text.Trim()),
                 new SqlParameter("@CUSTNM",txtCstNm.Text.Trim() ),
                 new SqlParameter("@CUSTPASS",pw),
                 new SqlParameter("@CUSTCAT",ddCstCat.SelectedValue.Trim()),
                 new SqlParameter("@CUST_ACTIVE",txtActFlag.Text.Trim()),
                 new SqlParameter("@MOBSERV_ENABLED", txtMblSer.Text.Trim() ),
                 new SqlParameter("@MOBILENO",txtMblNo.Text.Trim() ),
                 new SqlParameter("@STNUM",txtStNo.Text.Trim()),
                 new SqlParameter("@UPDTBY",Convert.ToString(Session["empcd"])),
                 new SqlParameter("@UPDTON",getDateInddMMMyyyFormat(System.DateTime.Today.ToString("dd/MM/yyyy")) ),
                 new SqlParameter("@CUSTLOC",loc123),
                 new SqlParameter("@CUSTADDRESS",txtCstAddress.Text.Trim()),
                 new SqlParameter("@CITY",ddcity.SelectedValue.ToString()),
                 new SqlParameter("@TELNO",txttel.Text.Trim()),
                 new SqlParameter("@PINCODE",txtpin.Text.Trim()),
                 new SqlParameter("@PAN_NO",txtpan.Text.Trim()),
                 new SqlParameter("@EMAILIDS",txtemail.Text.Trim()),
                 new SqlParameter("@VENDORCODE",txtVendorCode.Text.Trim())});
                oWebXHelper.CommitTransaction();
            }
            catch (Exception ex)
            {
                ExceptionUtility.LogException(ex, "CustomerMasterEdit.aspx->btnSubmit_Click", Convert.ToString(Session["empcd"]));
                oWebXHelper.RollBackTransaction();
            }
        }

        // cn.Open();
        // string sqlUp = "update webx_CUSTHDR set telno='" + txttel.Text + "', city='" + ddcity.SelectedValue.ToString() + "',pinCODE='" + txtpin.Text + "',pan_no='" + txtpan.Text + "',EMAILIDS ='" + txtemail.Text + "', GRPCD='" + lblGrpCd.Text + "',CUSTCD='" + lblCst.Text + "',CUSTNM='" + txtCstNm.Text + "',CUSTPASS='" + pw + "',CUSTCAT='" + ddCstCat.SelectedValue + "',CUST_ACTIVE='" + txtActFlag.Text + "',MOBSERV_ENABLED='" + txtMblSer.Text + "',MOBILENO='" + txtMblNo.Text + "',STNUM='" + txtStNo.Text + "',UPDTBY='" + Session["EmpCd"].ToString() + "',UPDTON='" + System.DateTime.Now.ToString() + "',CUSTLOC='" + loc123 + "',CustAddress='" + txtCstAddress.Text + "' from webx_CUSTHDR where CUSTCD = '" + lblCst.Text + "'";
        // //string sqlAdd = "insert into webx_CUSTHDR(GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress) values('" + strGrpCd + "','" + strCustCd + "','" + txtCstNm.Text.Trim() + "','" + strCustCd + "','" + ddCstCat.SelectedValue + "','" + txtActFlag.Text + "','" + txtMblSer.Text.Trim() + "','" + txtMblNo.Text.Trim() + "','" + txtStNo.Text.Trim() + "','" + txtCstNo.Text.Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() + "','" + Convert.ToDouble(txtOpnDbt.Text) + "','" + Convert.ToDouble(txtOpnCrdt.Text) + "','" + txtCstLoc.Text.Trim() + "','" + txtCstAddress.Text.Trim() + "')";
        // SqlCommand sqlUpCmd = new SqlCommand(sqlUp, cn);
        // sqlUpCmd.ExecuteNonQuery();
        // cn.Close();
        Response.Redirect("CustomerMaster.aspx");


    }


    public void getData()
    {
        string sqlGet;

        if (strtCstCd != "")
        {
            sqlGet = "select * from webx_CUSTHDR where CUSTCD = '" + strtCstCd + "'";
        }
        else
        {
            sqlGet = "select * from webx_CUSTHDR where CUSTCD = '" + strCustCd1 + "'";
            //sqlGet = "select GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress from webx_CUSTHDR where GRPCD = '" + strGrpCd + "'";
        }
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);

        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {
            lblGrpCd.Text = getDr["GRPCD"].ToString();
            lblCst.Text = getDr["CUSTCD"].ToString();
            txtCstNm.Text = getDr["CUSTNM"].ToString();


            if (getDr["CUSTPASS"] is DBNull)
            {
                p1 = "";
                pass2 = "";
            }
            else
            {
                p1 = getDr["CUSTPASS"].ToString();
                pass2 = pass2.Substring(0, p1.Length);
            }

            txtPwd.Text = pass2;



            //getDr["CUSTPASS"].ToString();
            ddCstCat.Text = getDr["CUSTCAT"].ToString();
            txtActFlag.Text = getDr["CUST_ACTIVE"].ToString();

            if (txtActFlag.Text.Trim() == "Y")
            {
                c1.Checked = true;
            }
            else
            {
                c1.Checked = false;
            }


            txtMblSer.Text = getDr["MOBSERV_ENABLED"].ToString();
            
            
            if (getDr["MOBSERV_ENABLED"].ToString() == "Y")
            {
                c2.Checked = true;
            }
            else
            {
                c2.Checked = false;
            }


            txtMblNo.Text = getDr["MOBILENO"].ToString();
            txtStNo.Text = getDr["STNUM"].ToString();
            // txtCstNo.Text = getDr["CSTNO"].ToString();
            txttel.Text = getDr["telno"].ToString();
            txtpin.Text = getDr["pincode"].ToString();
            txtCstLoc.Text = getDr["CUSTLOC"].ToString();
            txtemail.Text = getDr["EMAILIDS"].ToString();
            string s = getDr["city"].ToString();
            ddcity.SelectedValue = s;
            txtpan.Text = getDr["pan_no"].ToString();
            //ddcity.Items.FindByText(s);

            txtCstAddress.Text = getDr["CustAddress"].ToString();
			txtVendorCode.Text = getDr["VendorCode"].ToString();
        }
        getDr.Close();
        cn.Close();
    }




    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("CustomerMaster.aspx");
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        //if (TextBox1.Text != "")
        //{
        //    Session["tLocCod"] = TextBox1.Text;
        //    //Session["tCstCd"] = "";
        //    //Session["popCustCd"] = "";
        //    Server.Transfer("AddCustLocwithDiffAddressEdit.aspx");
        //}
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["t1LocCod"] = "";
        Server.Transfer("AddCustLocwithDiffAddress.aspx");
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        lblGrpCd.Text = strGrpCd;
        txtCstNm.Text = "";
        ddCstCat.Text = "";
        txtActFlag.Text = "";
        txtMblSer.Text = "";
        txtMblNo.Text = "";
        txtStNo.Text = "";
        txtpan.Text = "";
        //txtOpnDbt.Text = "";
        txtpin.Text = "";
        txtCstLoc.Text = "";
        txtCstAddress.Text = "";
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
    protected void ln1_Click(object sender, EventArgs e)
    {
        txtPwd.Text = "";
        txtPwd.ReadOnly = false;
        txtPwd.TextMode = TextBoxMode.Password;

    }

    private void bindpaytype()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = DataProvider.GetActiveGeneralMaster("PAYTYP");

            ddCstCat.Items.Clear();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddCstCat.DataTextField = "CodeDesc";
                ddCstCat.DataValueField = "CodeDesc";
                ddCstCat.DataSource = dt;
                ddCstCat.DataBind();
            }
            ddCstCat.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
}
