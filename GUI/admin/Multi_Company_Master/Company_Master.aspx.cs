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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_Multi_Company_Master_Company_Master : System.Web.UI.Page
{
    Company_Master Company_Details = new Company_Master();
    SqlConnection con;
    string Company_Code, InsertUpFlag, ErrorMsg;
    DataTable Dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Company_Code = Request.QueryString["Company_Code"].ToString();
            if (Company_Code != "new")
            {
                loadData();
                InsertUpFlag = "2";
            }
            else
            {
                InsertUpFlag = "1";
            }

            txtCmpCode.Attributes.Add("onblur", "CompanyCode('" + txtCmpCode.ClientID.ToString() + "')");
            txtBrcd.Attributes.Add("onblur", "LocBlur('" + txtBrcd.ClientID.ToString() + "')");
            btnLocCode.Attributes.Add("onclick", "popuplist('LocCode','" + txtBrcd.ClientID.ToString() + "','none')");
        }
    }
    public void UpdateCompanyLogo(string strCompCode, SqlTransaction trans)
    {

        try
        {
            FileUpload img = (FileUpload)imgUpload;
            Byte[] imgByte = null;
            if (img.HasFile && img.PostedFile != null)
            {
                //To create a PostedFile
                HttpPostedFile File = imgUpload.PostedFile;
                //Create byte Array with file len
                imgByte = new Byte[File.ContentLength];
                //force the control to load data in array
                File.InputStream.Read(imgByte, 0, File.ContentLength);
            }
            // Insert the employee name and image into db

            string sql = "Update WEBX_COMPANY_MASTER Set COMPANY_LOGO='" + imgByte + "' Where COMPANY_CODE='" + strCompCode + "' ";
            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql);

            //    cmd.Parameters.AddWithValue("@eimg", imgByte);
            //    cmd.Parameters.AddWithValue("@COMPANY_CODE", strCompCode);
            //SqlCommand cmd = new SqlCommand(sql, trans);


            // cmd.ExecuteScalar();

        }
        catch (Exception e1)
        {
            ErrorMsg = e1.Message.ToString();
            ErrorMsg = ErrorMsg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("../../ErrorPage.aspx?PageHead=" + "Transaction Error" + "&ErrorMsg=" + e1.ToString(), false);
            Response.End();
        }
    }
    public void loadData()
    {
        Company_Code = Request.QueryString["Company_Code"].ToString();

        Dt = Company_Details.CompanyMasterLoadData(Company_Code);

        txtCmpCode.Text = Dt.Rows[0]["COMPANY_CODE"].ToString();
        txtCmpName.Text = Dt.Rows[0]["COMPANY_NAME"].ToString();
        txtBrcd.Text = Dt.Rows[0]["BRCD"].ToString();
        txtAddress.Text = Dt.Rows[0]["ADDRESS"].ToString();
        txtContactPerson.Text = Dt.Rows[0]["CONTACT_PERSON"].ToString();
        txtContactNo.Text = Dt.Rows[0]["CONTACTNO"].ToString();

        txtSTaxno.Text = Dt.Rows[0]["ServicetaxNo"].ToString();
        txtTANNo.Text = Dt.Rows[0]["TANNo"].ToString();
        txtPANNo.Text = Dt.Rows[0]["PANNo"].ToString();
        txtPunchLine.Text = Dt.Rows[0]["PunchLine"].ToString();
        txtRegNo.Text = Dt.Rows[0]["RegistrationNo"].ToString();
        txtTelNo.Text = Dt.Rows[0]["TelephoneNo"].ToString();
        txtFAXNo.Text = Dt.Rows[0]["FAXNo"].ToString();
        txtHelpLineNo.Text = Dt.Rows[0]["HelpLineNo"].ToString();


        if (Dt.Rows[0]["ACTIVEFLAG"].ToString().CompareTo("Y") == 0)
            chkActive.Checked = true;
        else
            chkActive.Checked = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Company_Code = Request.QueryString["Company_Code"].ToString();
        string ActiveFlag = "";

        if (Company_Code != "new")
            InsertUpFlag = "2";
        else
            InsertUpFlag = "1";

        if (chkActive.Checked == true)
            ActiveFlag = "Y";
        else
            ActiveFlag = "N";


        string Xml_Company_Details = "<root><CompanyMaster>";
        Xml_Company_Details += "<COMPANY_CODE>" + txtCmpCode.Text.Trim() + "</COMPANY_CODE>";
        Xml_Company_Details += "<COMPANY_NAME>" + txtCmpName.Text.Trim() + "</COMPANY_NAME>";
        Xml_Company_Details += "<BRCD>" + txtBrcd.Text.Trim() + "</BRCD>";
        Xml_Company_Details += "<ADDRESS>" + txtAddress.Text.Trim() + "</ADDRESS>";
        Xml_Company_Details += "<CONTACT_PERSON>" + txtContactPerson.Text.Trim() + "</CONTACT_PERSON>";
        Xml_Company_Details += "<CONTACTNO>" + txtContactNo.Text.Trim() + "</CONTACTNO>";
        Xml_Company_Details += "<ACTIVEFLAG>" + ActiveFlag.Trim() + "</ACTIVEFLAG>";
        Xml_Company_Details += "<ENTRYBY>" + SessionUtilities.CurrentBranchCode.Trim() + "</ENTRYBY>";
        Xml_Company_Details += "<INSUPFLAG>" + InsertUpFlag.Trim() + "</INSUPFLAG>";

        Xml_Company_Details += "<ServicetaxNo>" + txtSTaxno.Text.Trim() + "</ServicetaxNo>";
        Xml_Company_Details += "<TANNo>" + txtTANNo.Text.Trim() + "</TANNo>";
        Xml_Company_Details += "<PANNo>" + txtPANNo.Text.Trim() + "</PANNo>";
        Xml_Company_Details += "<PunchLine>" + txtPunchLine.Text.Trim() + "</PunchLine>";
        Xml_Company_Details += "<RegistrationNo>" + txtRegNo.Text.Trim() + "</RegistrationNo>";
        Xml_Company_Details += "<TelephoneNo>" + txtTelNo.Text.Trim() + "</TelephoneNo>";
        Xml_Company_Details += "<FAXNo>" + txtFAXNo.Text.Trim() + "</FAXNo>";
        Xml_Company_Details += "<HelpLineNo>" + txtHelpLineNo.Text.Trim() + "</HelpLineNo>";

        Xml_Company_Details += "</CompanyMaster></root>";

        con = new SqlConnection(SessionUtilities.ConnectionString.ToString().Trim());
        con.Open();

        SqlTransaction trans;
        trans = con.BeginTransaction();

        try
        {
            Company_Code = Company_Details.InsertUpdateCompanyMaster(Xml_Company_Details, trans);


            UpdateCompanyLogo(Company_Code, trans);


        }
        catch (Exception e1)
        {
            ErrorMsg = e1.Message.ToString();
            ErrorMsg = ErrorMsg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("../../ErrorPage.aspx?PageHead=" + "Transaction Error" + "&ErrorMsg=" + ErrorMsg, false);
            Response.End();
        }
        trans.Commit();
        con.Close();

        Response.Redirect("Company_Master_Done.aspx?Type=Company&Flag=" + InsertUpFlag.ToString() + "&Code=" + Company_Code, false);
    }
}
