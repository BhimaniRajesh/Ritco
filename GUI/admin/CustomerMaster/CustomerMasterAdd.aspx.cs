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
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bindpaytype();
            popcity();
            strGrpCd = Request.QueryString["custgrp"].ToString();
                //Session["strGrpCdS"].ToString().Trim();
            lblGrpCd.Text = strGrpCd;
        }

        txtpin.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");
        txtMblNo.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");
        txtStNo.Attributes.Add("onblur", "javascript:return Falphanum(this)");
        txtpan.Attributes.Add("onblur", "javascript:return Falphanum2(this)");
        //txtOpnDbt.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        txtpin.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        txttel.Attributes.Add("onblur", "javascript:return IsNumericComma(this)");

//        btnSubmit.Attributes.Add("onClick", "javascript:return checklocation(" + txtCstLoc.ClientID + ");ValidateData()");

        btnSubmit.Attributes.Add("onClick", "javascript:return x(" + txtCstLoc.ClientID + ")");
        

        txtCstLoc.ForeColor = System.Drawing.Color.Black;



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
    public string getNewCd(string strGrpCd)
    {
        int intCustCode = 1;

        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

       // SqlCommand cmdGet = new SqlCommand("select cast(right(max(custcd), 4) as numeric(18, 0)) + 1 from webx_CUSTHDR where grpcd='" + strGrpCd + "'", cn);
        SqlCommand cmdGet = new SqlCommand("SELECT MAX(CONVERT(INT,SUBSTRING(CUSTCD, 6,4)))+1 FROM webx_custhdr where GRPCD = SUBSTRING(CUSTCD, 1,5) AND grpcd='" + strGrpCd + "'", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();
        
        if (drGet.Read())
        {
            if (drGet[0] is DBNull)
            {
                intCustCode = 1;
            }
            else
            {
                intCustCode = Convert.ToInt32(drGet[0].ToString());
            }
        }
        
        drGet.Close();
         
        cn.Close();

        return strGrpCd + intCustCode.ToString().PadLeft(4, '0');
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {


            strCustCd = getNewCd(strGrpCd);
            cn.Open();

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
			
			using (var oWebXHelper = new WebXHelper())
			{
				oWebXHelper.BeginTransaction();
				try
				{
					oWebXHelper.ExecuteNonQuery(CommandType.StoredProcedure, "Usp_CustomerMaster_SaveDetail", new[]{
					new SqlParameter("@GRPCD",strGrpCd.Trim()),
					new SqlParameter("@CUSTCD",strCustCd.Trim()),
					new SqlParameter("@CUSTNM",txtCstNm.Text.Trim() ),
					new SqlParameter("@CUSTPASS",strCustCd.Trim()),
					new SqlParameter("@CUSTCAT",ddCstCat.SelectedValue.Trim()),
					new SqlParameter("@CUST_ACTIVE",txtActFlag.Text.Trim()),
					new SqlParameter("@MOBSERV_ENABLED", txtMblSer.Text.Trim() ),
					new SqlParameter("@MOBILENO",txtMblNo.Text.Trim() ),
					new SqlParameter("@STNUM",txtStNo.Text.Trim()),
					new SqlParameter("@CSTNO",txtpan.Text.Trim()),
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
					ExceptionUtility.LogException(ex, "CustomerMasterAdd.aspx->btnSubmit_Click", Convert.ToString(Session["empcd"]));
					oWebXHelper.RollBackTransaction();
				}
			}

      
            // //string sqlAdd = "insert into webx_CUSTHDR(GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress) values('" + strGrpCd + "','" + strCustCd + "','" + txtCstNm.Text.Trim() + "','" + strCustCd + "','" + ddCstCat.SelectedValue + "','" + txtActFlag.Text + "','" + txtMblSer.Text.Trim() + "','" + txtMblNo.Text.Trim() + "','" + txtStNo.Text.Trim() + "','" + txtpan.Text.Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + getDateInddMMMyyyFormat(System.DateTime.Today.ToString("dd/MM/yyyy")) + "'," + (txtOpnDbt.Text.Trim() == "" ? "0" : txtOpnDbt.Text.Trim()) + "," + (txtpin.Text.Trim() == "" ? "0" : txtpin.Text.Trim()) + ",'" + txtCstLoc.Text.Trim() + "','" + txtCstAddress.Text.Trim() + "')";
            // string sqlAdd = "insert into webx_CUSTHDR(GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,CUSTLOC,CustAddress,city,telno,pincode,pan_no,EMAILIDS) values('" + strGrpCd + "','" + strCustCd + "','" + txtCstNm.Text.Trim() + "','" + strCustCd + "','" + ddCstCat.SelectedValue + "','" + txtActFlag.Text + "','" + txtMblSer.Text.Trim() + "','" + txtMblNo.Text.Trim() + "','" + txtStNo.Text.Trim() + "','" + txtpan.Text.Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + getDateInddMMMyyyFormat(System.DateTime.Today.ToString("dd/MM/yyyy")) + "','" + loc123 + "','" + txtCstAddress.Text.Trim() + "','" + ddcity.SelectedValue.ToString() + "','" + txttel.Text + "','" + txtpin.Text + "','" + txtpan.Text + "','" + txtemail.Text + "')";
            // SqlCommand cmdAdd = new SqlCommand(sqlAdd, cn);
            // cmdAdd.ExecuteNonQuery();
            // cn.Close();
            Response.Redirect("CustomerMaster.aspx");
                            //}
                            //else
                            //{
                            //    txtCstLoc.ForeColor = System.Drawing.Color.Red;
                            //    txtCstLoc.Text = "Enter Valid Location : " + locvalid;

                            //}
    }


    //public string loc_validcheck(string loc)
    //{
    //    string loc2=loc;
    //    string[] loc3=loc2.Split(',');
    //    string result="";
    //    int len = loc3.Length;

       
    //        for (int i = 0; i < len; i++)
    //        {
    //            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //            string l = loc3[i];

    //            if (l.Length > 1)
    //            {
    //                string sql = "select* from webx_location where Loccode='" + l + "'";


    //                SqlCommand cmd = new SqlCommand(sql, conn);

    //                string dno2;
    //                conn.Open();

    //                SqlDataAdapter da = new SqlDataAdapter(cmd);

    //                DataSet ds = new DataSet();

    //                da.Fill(ds);

    //                if (ds.Tables[0].Rows.Count == 0)
    //                {
    //                    result = l;
    //                    return result;
    //                    break;
    //                }
    //                else
    //                {
    //                    result = "1";
    //                }
    //            }
    //            else
    //            {
    //                result = "1";
    //            }
    //        }
       



    //    return result;
        
    //    }




  

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
