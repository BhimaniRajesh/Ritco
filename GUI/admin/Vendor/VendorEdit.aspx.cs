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
using System.Text.RegularExpressions;

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{

    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);


    public static string vencode;
    public static string ext, ext2;

    public string dockno;
    public string bno = "";

    public string s1, s2, s3;
    string res = "ok";

    protected void Page_Load(object sender, EventArgs e)
    {

        umsg.Hide();
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

        //btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtCstLoc.ClientID + ")");
        btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + vendorbstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtAddress.ClientID + "," + txtCstLoc.ClientID + "," + txttel.ClientID + "," + txtemail.ClientID + "," + txtContactPerson.ClientID + "," + txtPhoneNumber.ClientID + ")");

        chact.Attributes.Add("onclick", "javascript:return checkChange()");
        chblk.Attributes.Add("onclick", "javascript:return checkChange2()");
        chkOA.Attributes.Add("onclick", "javascript:return checkChangechkOA()");


        if (!IsPostBack)
        {
            hdnContainerName.Value = ConfigurationManager.AppSettings["SOPContainerName"].ToString();
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
        SqlCommand c = new SqlCommand("select top 1 '-- Select --' as c1 from webx_citymaster  union  select Location as c1 from webx_citymaster WHERE activeflag='Y'", cn);
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

        string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_master_general  union select codeid as a,codedesc as b from webx_master_general where codetype='VENDTY'  AND StatusCode='Y' ";
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
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (txtvenname.Text != "")
        {
            try
            {
                string sqlst = "";
                // bool Flag = false;
                sqlst = "SELECT count(*) from webx_VENDOR_HDR WHERE Vendorname='" + txtvenname.Text + "' AND VENDORCODE != '" + vencode + "' AND vendor_type = '" + ddVendorType.SelectedValue.ToString() + "' AND Active = 'Y' ";
                SqlCommand cmdd = new SqlCommand(sqlst, conn);
                double Cnt = Convert.ToDouble(cmdd.ExecuteScalar());
                if (Cnt > 0)
                {
                    umsg.Show("Duplicate Vendor Name Can't Allow");
                    return;
                }


            }
            catch (Exception ex)
            {
                umsg.Show(ex.ToString());
            }
        }



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


        string c1 = "", c2 = "", c3 = "";
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
        if (chkOA.Checked == true)
        {
            c3 = "Y";
        }
        else
        {
            c3 = "N";
        }
        string sql = "";
        string sql5 = "";
        try
        {
            if (ext2 == "no")
            {
                sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED,ContactPerson,PhoneNumber,PhoneNumber2) " +
                  "values('" + vencode + "','" + loc123 + "','" + txtAddress.Text + "','" + ddcity.SelectedValue.ToString() + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtemail.Text + "','" + c1 + "','" + c2 + "','" + txtContactPerson.Text + "','" + txtPhoneNumber.Text + "','" + txtPhoneNumber2.Text + "')";

            }
            else
            {
                //sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) " +
                //       "values('" + vencode + "','" + loc123 + "','" + txtAddress.Text + "','" + ddcity.SelectedValue.ToString() + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtemail.Text + "','" + c1 + "','" + c2+ "')";

                sql = "UPDATE webx_VENDOR_DET SET VENDORCODE='" + vencode + "',VENDORBRCD='" + loc123 + "',VENDORADDRESS='" + txtAddress.Text + "',VENDORCITY='" + ddcity.SelectedValue.ToString() + "',VENDORPIN='" + txtpin.Text + "',VENDORPHONE='" + txttel.Text + "',VENDOREMAIL='" + txtemail.Text + "',ACTIVEFLAG='" + c1 + "',BLACKLISTED='" + c2 + "',ContactPerson='" + txtContactPerson.Text + "',PhoneNumber='" + txtPhoneNumber.Text + "',PhoneNumber2='" + txtPhoneNumber2.Text + "' WHERE VENDORCODE='" + vencode + "'";
            }

            SqlCommand cmdd = new SqlCommand(sql, conn);

            cmdd.ExecuteNonQuery();


            //  sql = "Update webx_VENDOR_hdr set  VENDORBRCD='" + loc123 + "', VENDORADDRESS='" + txtAddress.Text + "', VENDORCITY='" + ddcity.SelectedValue.ToString() + "', VENDORPIN='" + txtpin.Text + "', VENDORPHONE='" + txttel.Text + "', VENDOREMAIL='" + txtemail.Text + "', ACTIVEFLAG='" + c1 + "', BLACKLISTED='" + c2 + "' where vendorcode='" + vencode + "'";

            string AadhaarUploadFileName = "", PanUploadFileName = "";
            if (fldAadhaarUpload.HasFile)
            {
                string newFName1 = GetFileName(fldAadhaarUpload.PostedFile.FileName, vencode, "AadharNo");
                AadhaarUploadFileName = AzureStorageHelper.UploadBlob("VendorDocument", fldAadhaarUpload, newFName1);
            }
            if (fldPanUpload.HasFile)
            {
                string newFName2 = GetFileName(fldPanUpload.PostedFile.FileName, vencode, "PanNo");
                PanUploadFileName = AzureStorageHelper.UploadBlob("VendorDocument", fldPanUpload, newFName2);
            }




            if (ext == "no")
            {
                sql5 = "insert into webx_VENDOR_HDR (vendor_type,VENDORNAME,VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,SystemDate,PanUpload,pan_no,AadhaarNo,AadhaarUpload,vendorbstno,vendorcstno,dEFAULT_aDDR,VENDORCODE,OtherAdvFlag,DiscountRate)" +
                    " '" + ddVendorType.SelectedValue.ToString() + "','" + txtvenname.Text + "','" + txtRemarks.Text + "','" + Session["empcd"].ToString().Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() + "','" + ddVendorType.SelectedValue.ToString() + "','" + txtSystemDate.Text + "','" + PanUploadFileName + "','" + PanNo.Text + "','" + txtAadhaarNo.Text + "','" + AadhaarUploadFileName + "','" + vendorbstno.Text + "','" + txtAddress.Text + "','" + vencode + "','" + c3 + "','" + txtDiscount.Text + "'";

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
            "SystemDate= CONVERT(DATETIME,'" + txtSystemDate.Text + "',105)" + "," +
            "pan_no='" + PanNo.Text + "',";
                if (PanUploadFileName == "")
                {
                    if (hdnPanUpload.Value !="")
                    {
                        sql5 = sql5 + "PanUpload='" +  hdnPanUpload.Value+"',";
                    }
                    else
                    { sql5 = sql5 + "PanUpload='" + PanUploadFileName + "',"; }
                }
                
                if (AadhaarUploadFileName == "")
                {
                    if (hdnAadhaarUpload.Value != "")
                    {
                        sql5 = sql5 + "AadhaarUpload='" + hdnAadhaarUpload.Value + "',";
                    }
                    else { sql5 = sql5 + "AadhaarUpload='" + AadhaarUploadFileName + "',"; }
                }
                

             sql5 = sql5 + "vendorbstno='" + vendorbstno.Text + "'," +
             "Active='" + c1 + "'," +
            "dEFAULT_aDDR='" + txtAddress.Text + "'," +
            "DiscountRate='" + txtDiscount.Text + "'," +
            "OtherAdvFlag='" + c3 + "' where VENDORCODE='" + vencode + "'";
            }

            SqlCommand cmd5 = new SqlCommand(sql5, conn);

            cmd5.ExecuteNonQuery();

        }
        catch (Exception ee1)
        {
            res = sql + " : " + sql5 + ee1.Message;


        }

        if (res == "ok")
        {
            Response.Redirect("../business_partners.aspx");
        }
        else
        {
            lblerr.Text += " " + res;
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
        string sqlGet = "select convert(varchar(20),SystemDate,103) AS SystemDate,* from webx_VENDOR_HDR where VENDORCODE = '" + vencode + "'";
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {

            // ddVendorType.Text = getDr["vendor_type"].ToString();
            if (getDr["SystemDate"].ToString() == "" || getDr["SystemDate"].ToString() == "NULL")
            {
                txtSystemDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            }
            else
            {
                txtSystemDate.Text = getDr["SystemDate"].ToString();
            }
            txtvenname.Text = getDr["VENDORNAME"].ToString();
            txtRemarks.Text = getDr["VENDORREMARKS"].ToString();
            //servtaxno.Text = getDr["servtaxno"].ToString();
            PanNo.Text = getDr["pan_no"].ToString();
            vendorbstno.Text = getDr["vendorbstno"].ToString();
            //vendorcstno.Text = getDr["vendorcstno"].ToString();
            txtAddress.Text = getDr["dEFAULT_aDDR"].ToString();
            //  ddVendorType.Text = getDr["vendor_type"].ToString();
            ddVendorType.SelectedValue = getDr["vendor_type"].ToString();
            txtDiscount.Text = getDr["DiscountRate"].ToString();

            if (getDr["OtherAdvFlag"].ToString() == "Y")
            {
                txtOA.Text = "Y";
                chkOA.Checked = true;
            }
            else
            {
                txtOA.Text = "N";
                chkOA.Checked = false;
            }
            if (getDr["AadhaarNo"] != System.DBNull.Value)
            {
                txtAadhaarNo.Text = getDr["AadhaarNo"].ToString();
            }
            if (getDr["active"].ToString() == "Y")
            {
                txtact.Text = "Y";
                chact.Checked = true;
            }
            else
            {
                txtact.Text = "N";
                chact.Checked = false;
            }
            //if (getDr["PanNo"] != System.DBNull.Value)
            //{
            //    PanNo.Text = getDr["PanNo"].ToString();
            //}
            if (getDr["AadhaarUpload"] != System.DBNull.Value && Convert.ToString(getDr["AadhaarUpload"]) != "")
            {
                hdnAadhaarUpload.Value = getDr["AadhaarUpload"].ToString();
                lblAadhaarView.Visible = true;
            }
            if (getDr["PanUpload"] != System.DBNull.Value && Convert.ToString(getDr["PanUpload"]) != "")
            {
                hdnPanUpload.Value = getDr["PanUpload"].ToString();
                lblPanView.Visible = true;
            }
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

            txtPhoneNumber2.Text = getDr2["PhoneNumber2"] == null ? "" : getDr2["PhoneNumber2"].ToString();
            txtPhoneNumber.Text = getDr2["PhoneNumber"] == null ? "" : getDr2["PhoneNumber"].ToString();
            txtContactPerson.Text = getDr2["ContactPerson"] == null ? "" : getDr2["ContactPerson"].ToString();



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

    private string GetFileName(string fileName, string docno, string pref)
    {
        string strRet = fileName;

        string pat = @"(?:.+)(.+)\.(.+)";
        Regex r = new Regex(pat);
        //run
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        docno = docno.Replace("/", "$");

        strRet = pref + "_" + docno + "." + file_ext;

        return strRet;
    }
}
