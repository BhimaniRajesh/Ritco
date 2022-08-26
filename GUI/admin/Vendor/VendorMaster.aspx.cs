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




    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string dockno;
    public string bno = "";

    public string s1, s2, s3;

    protected void Page_Load(object sender, EventArgs e)
    {

        umsg.Hide();
        string billdate;

        getstring();

        //btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtCstLoc.ClientID + ")");
        btnSubmit.Attributes.Add("onclick", "javascript:return x(" + PanNo.ClientID + "," + vendorbstno.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + "," + txtAddress.ClientID + "," + txtCstLoc.ClientID + "," + txttel.ClientID + "," + txtemail.ClientID + "," + txtContactPerson.ClientID + "," + txtPhoneNumber.ClientID + ")");


        chact.Attributes.Add("onclick", "javascript:return checkChange()");
        chblk.Attributes.Add("onclick", "javascript:return checkChange2()");
        chkOA.Attributes.Add("onclick", "javascript:return checkChangechkOA()");
        if (!IsPostBack)
        {
            txtSystemDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtSystemDate.Enabled = false;
            popVentype();
            popcity();

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


    public string getNewCd()
    {
        int intCustCode = 1;
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(vendorcode), 5) as numeric(18, 0)) + 1 from webx_VENDOR_hdr Where Len(vendorcode)=6", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            try
            {
                intCustCode = Convert.ToInt32(drGet[0].ToString());
            }
            catch (Exception ex)
            {
                intCustCode = 0;
            }
        }

        drGet.Close();

        return "V" + intCustCode.ToString().PadLeft(5, '0');
        cn.Close();
    }




    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string venno = getNewCd();


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

        if (txtvenname.Text != "")
        {
            try
            {
                string sql = "";
                // bool Flag = false;
                sql = "SELECT count(*) from webx_VENDOR_HDR WHERE Vendorname='" + txtvenname.Text + "' AND vendor_type = '" + ddVendorType.SelectedValue.ToString() + "'";
                SqlCommand cmdd = new SqlCommand(sql, conn);
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
        if (PanNo.Text != "")
        {
            try
            {
                string sql = "";
                // bool Flag = false;
                sql = "SELECT count(*) from webx_VENDOR_HDR WHERE PAN_NO='" + PanNo.Text + "'";
                SqlCommand cmdd = new SqlCommand(sql, conn);
                double Cnt = Convert.ToDouble(cmdd.ExecuteScalar());
                if (Cnt > 0)
                {
                    umsg.Show("Duplicate Pan No Can't Allow");
                    return;
                }


            }
            catch (Exception ex)
            {
                umsg.Show(ex.ToString());
            }
        }

        try
        {

            string sql = "";


            sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED,ContactPerson,PhoneNumber,PhoneNumber2) values('" + venno + "','" + loc123 + "','" + txtAddress.Text + "','" + ddcity.SelectedValue.ToString() + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtemail.Text + "','" + c1 + "','" + c2 + "','" + txtContactPerson.Text + "','" + txtPhoneNumber.Text + "','" + txtPhoneNumber2.Text + "')";

            SqlCommand cmdd = new SqlCommand(sql, conn);

            cmdd.ExecuteNonQuery();


        }
        catch (Exception ee1)
        {
            lblQry.Text = ee1.Message;


        }

        //string sql3 = "insert into webx_VENDOR_HDR(vendor_type,VENDORCODE,VENDORNAME," +
        //"VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,servtaxno,pan_no,vendorbstno," +
        //"vendorcstno,Active,OtherAdvFlag,DiscountRate) values('" +
        // ddVendorType.SelectedValue.ToString() + "','" + venno + "','" + txtvenname.Text +
        //"','" + txtRemarks.Text +
        //"','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() +
        //"','" + ddVendorType.SelectedValue.ToString() + "','" + servtaxno.Text + "','" +
        //PanNo.Text + "','" + vendorbstno.Text + "','" + vendorcstno.Text + "','" + c1 + "','" + c3 + "','" + txtDiscount.Text + "')";

        string AadhaarUploadFileName = "", PanUploadFileName = "";
        if (fldAadhaarUpload.HasFile)
        {
            string newFName1 = GetFileName(fldAadhaarUpload.PostedFile.FileName, venno, "AadharNo");
            AadhaarUploadFileName = AzureStorageHelper.UploadBlob("VendorDocument", fldAadhaarUpload, newFName1);
        }
        if (fldPanUpload.HasFile)
        {
            string newFName2 = GetFileName(fldPanUpload.PostedFile.FileName, venno, "PanNo");
            PanUploadFileName = AzureStorageHelper.UploadBlob("VendorDocument", fldPanUpload, newFName2);
        }

        //string sql3 = "insert into webx_VENDOR_HDR(vendor_type,VENDORCODE,VENDORNAME," +
        //"VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,servtaxno,pan_no,vendorbstno," +
        //"vendorcstno,Active,OtherAdvFlag,DiscountRate) values('" +
        // ddVendorType.SelectedValue.ToString() + "','" + venno + "','" + txtvenname.Text +
        //"','" + txtRemarks.Text +
        //"','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() +
        //"','" + ddVendorType.SelectedValue.ToString() + "','" + servtaxno.Text + "','" +
        //PanNo.Text + "','" + vendorbstno.Text + "','" + vendorcstno.Text + "','" + c1 + "','" + c3 + "','" + txtDiscount.Text + "')";

        string sql3 = "insert into webx_VENDOR_HDR(vendor_type,VENDORCODE,VENDORNAME," +
        "VENDORREMARKS,SystemDate,PanUpload,AadhaarNo,AadhaarUpload,UPDTBY,UPDTON,VENDCAT,pan_no,vendorbstno," +
        "Active,OtherAdvFlag,DiscountRate) values('" +
         ddVendorType.SelectedValue.ToString() + "','" + venno + "','" + txtvenname.Text +
        "','" + txtRemarks.Text +
        "',CONVERT(DATETIME,'" + txtSystemDate.Text + "',105),'" + PanUploadFileName + "','" + txtAadhaarNo.Text + "','" + AadhaarUploadFileName +
        "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() +
        "','" + ddVendorType.SelectedValue.ToString() +
        "','" + PanNo.Text + "','" + vendorbstno.Text + "','" + c1 + "','" + c3 + "','" + txtDiscount.Text + "')";


        SqlCommand cmdd3 = new SqlCommand(sql3, conn);
        //Response.Write(sql3);
        //Response.End();
        cmdd3.ExecuteNonQuery();
        Response.Redirect("../business_partners.aspx");
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
