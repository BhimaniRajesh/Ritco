using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{

    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);


    public static string vencode;
    public static string ext,ext2;

    public string dockno;
    public string bno = "";

    public string s1, s2, s3;
    string res = "ok";

    protected void Page_Load(object sender, EventArgs e)
    {


        string billdate;

        getstring();

        string para = Request.QueryString["para"].ToString();

        if (para == "1")
        {
            vencode = Session["vencd"].ToString();
        }
        else
        {
            vencode = Request.QueryString["vno"].ToString();
        }

        lblcstcode.Text = vencode;

        btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtCstLoc.ClientID + ")");


        chact.Attributes.Add("onclick", "javascript:return checkChange()");
        chblk.Attributes.Add("onclick", "javascript:return checkChange2()");



        if (!IsPostBack)
        {

            popVentype();
            popcity();
            filltxt();

        }


    }


    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
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
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand c = new SqlCommand("select top 1 '-- Select --' as c1 from webx_citymaster  union  select Location as c1 from webx_citymaster", cn);
        SqlDataAdapter d = new SqlDataAdapter(c);
        DataSet s = new DataSet();
        d.Fill(s);
        ddcity.DataSource = s;
        ddcity.DataTextField = "c1";
        ddcity.DataValueField = "c1";

        ddcity.DataBind();


    }

    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //  string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_VENDOR_type  union select type_name + ' : ' + type_code as a, type_code as b from webx_VENDOR_type";

        string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_master_general  union select codeid as a,codedesc as b from webx_master_general where codetype='VENDTY'";
        SqlCommand cmd = new SqlCommand(sqldd, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddVendorType.DataSource = ds;
        ddVendorType.DataTextField = "b";
        ddVendorType.DataValueField = "a";
        ddVendorType.DataBind();

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


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

 

        string c1 = "", c2 = "";
        if (chact.Checked == true)
        {
            c1 = "Y";
        }
        else
        {
            c1 = "N";
        }


        if (chblk.Checked == true)
        {
            c2 = "Y";
        }
        else
        {
            c2 = "N";
        }
        string sql = "";
         string sql5 = "";
        try
        {
            if (ext2 == "no")
            {
                sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) " +
                  "values('" + vencode + "','" + loc123 + "','" + txtAddress.Text + "','" + ddcity.SelectedValue.ToString() + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtemail.Text + "','" + c1 + "','" + c2 + "')";

            }
            else
            {
                //sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) " +
                //       "values('" + vencode + "','" + loc123 + "','" + txtAddress.Text + "','" + ddcity.SelectedValue.ToString() + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtemail.Text + "','" + c1 + "','" + c2+ "')";

                sql = "UPDATE webx_VENDOR_DET SET VENDORCODE='" + vencode + "',VENDORBRCD='" + loc123 + "',VENDORADDRESS='" + txtAddress.Text + "',VENDORCITY='" + ddcity.SelectedValue.ToString() + "',VENDORPIN='" + txtpin.Text + "',VENDORPHONE='" + txttel.Text + "',VENDOREMAIL='" + txtemail.Text + "',ACTIVEFLAG='" + c1 + "',BLACKLISTED='" + c2 + "' WHERE VENDORCODE='" + vencode + "'";
            }

            SqlCommand cmdd = new SqlCommand(sql, conn);

            cmdd.ExecuteNonQuery();


            //  sql = "Update webx_VENDOR_hdr set  VENDORBRCD='" + loc123 + "', VENDORADDRESS='" + txtAddress.Text + "', VENDORCITY='" + ddcity.SelectedValue.ToString() + "', VENDORPIN='" + txtpin.Text + "', VENDORPHONE='" + txttel.Text + "', VENDOREMAIL='" + txtemail.Text + "', ACTIVEFLAG='" + c1 + "', BLACKLISTED='" + c2 + "' where vendorcode='" + vencode + "'";

           
          
            
            if (ext == "no")
            {
                sql5 = "insert into webx_VENDOR_HDR (vendor_type,VENDORNAME,VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,servtaxno,pan_no,vendorbstno,vendorcstno,dEFAULT_aDDR,VENDORCODE)" +
                    " '" + ddVendorType.SelectedValue.ToString() + "','" + txtvenname.Text + "','" + txtRemarks.Text + "','" + Session["empcd"].ToString().Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() + "','" + ddVendorType.SelectedValue.ToString() + "','" + servtaxno.Text + "','" + PanNo.Text + "','" + vendorbstno.Text + "','" + vendorcstno.Text + "','" + txtAddress.Text + "','" + vencode + "'";

            }
            else
            {

                 sql5 = "update webx_VENDOR_HDR set vendor_type='" +
             ddVendorType.SelectedValue.ToString() + "'," +
             "VENDORNAME='" + txtvenname.Text + "'," +
               "VENDORREMARKS='" + txtRemarks.Text + "'," +
             "UPDTBY='" + Session["empcd"].ToString().Trim() + "'," +
             "UPDTON='" + System.DateTime.Now.ToShortDateString() + "'," +
             "VENDCAT='" + ddVendorType.SelectedValue.ToString() + "'," +
             "servtaxno='" + servtaxno.Text + "'," +
             "pan_no='" + PanNo.Text + "'," +
             "vendorbstno='" + vendorbstno.Text + "'," +
             "vendorcstno='" + vendorcstno.Text + "'," +
             "dEFAULT_aDDR='" + txtAddress.Text + "' where VENDORCODE='" + vencode + "'";
            }

            SqlCommand cmd5 = new SqlCommand(sql5, conn);

            cmd5.ExecuteNonQuery();

        }
        catch (Exception ee1)
        {
             res = sql+" : "+sql5+ ee1.Message;

         
        }

        if (res == "ok")
        {
            Response.Redirect("../business_partners.aspx");
        }
        else 
        {
            lblerr.Text += " " +res;
            pnl1.Visible = false;
            plnerr.Visible = true;
        }
        




    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("VendorMasterEdit.aspx");
      
    }


    public void filltxt()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sqlGet = "select * from webx_VENDOR_HDR where VENDORCODE = '" + vencode + "'";
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {

            // ddVendorType.Text = getDr["vendor_type"].ToString();
            txtvenname.Text = getDr["VENDORNAME"].ToString();
            txtRemarks.Text = getDr["VENDORREMARKS"].ToString();
            servtaxno.Text = getDr["servtaxno"].ToString();
            PanNo.Text = getDr["pan_no"].ToString();
            vendorbstno.Text = getDr["vendorbstno"].ToString();
            vendorcstno.Text = getDr["vendorcstno"].ToString();
            txtAddress.Text = getDr["dEFAULT_aDDR"].ToString();
            //  ddVendorType.Text = getDr["vendor_type"].ToString();
            ddVendorType.SelectedValue = getDr["vendor_type"].ToString();

        }
        getDr.Close();

        string sqlGet2 = "select * from webx_VENDOR_det where VENDORCODE = '" + vencode + "'";
        SqlCommand cmdGet2 = new SqlCommand(sqlGet2, cn);
        SqlDataReader getDr2 = cmdGet2.ExecuteReader();
        if (getDr2.Read())
        {

            // ddVendorType.Text = getDr["vendor_type"].ToString();
            txtCstLoc.Text = getDr2["VENDORbrcd"].ToString();
            txtAddress.Text = getDr2["VENDORaddress"].ToString();
            ddcity.SelectedValue = getDr2["VENDORcity"].ToString();
            txtpin.Text = getDr2["VENDORpin"].ToString();
            txttel.Text = getDr2["vendorphone"].ToString();
            txtemail.Text = getDr2["vendoremail"].ToString();

            if (getDr2["activeflag"].ToString() == "Y")
            {
                txtact.Text = "Y";
                chact.Checked = true;
            }
            else
            {
                txtact.Text = "N";
                chact.Checked = false;
            }

            if (getDr2["blacklisted"].ToString() == "Y")
            {
                txtblk.Text = "Y";
                chblk.Checked = true;
            }
            else
            {
                txtblk.Text = "N";
                chblk.Checked = false;
            }


        }

        if (getDr2.HasRows == false)
        {
            ext2 = "no";
        }
        getDr2.Close();


        cn.Close();

    }






}
