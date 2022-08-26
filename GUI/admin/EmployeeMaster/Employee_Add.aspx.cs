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
using WebX.Entity;
using WebX.Controllers;
using System.Text.RegularExpressions;

public partial class GUI_admin_Employee_Employee_Add : System.Web.UI.Page
{

    //SqlConnection cn;  
    //SqlCommand cmd = new SqlCommand();
    //SqlDataReader drEmpStatus, drEmpEdit;
    //string strGender;
    //string strEmployeeCode = "";

    public static string strToday = "", pre2 = "", percon = "", isp = "";
    public static int maxl = 0, minl = 0, pre = 0, norow = 1;

    DataTable dtDocuments = new DataTable();


    string strErrorMessage = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        dtDocuments.Columns.AddRange(new DataColumn[2] { new DataColumn("DocumentName"), new DataColumn("DocumentNo") });
        try
        {
            maxlen();

            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();
            SqlCommand c1 = new SqlCommand("SELECT GETDATE() AS servdt", cn);


            DateTime d = (DateTime)c1.ExecuteScalar();
            strToday = d.ToString("dd/MM/yyyy");
            cn.Close();

            strErrorMessage = (strErrorMessage == "" ? "1" : strErrorMessage + ", " + "1");
            txtcomp.Text = DateTime.Now.ToString("dd/MM/yyyy");

            txtDateJoinOrg.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateJoinOrg.ClientID + ")");
            txtDateOfBirth.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateOfBirth.ClientID + ")");

            strErrorMessage = (strErrorMessage == "" ? "2" : strErrorMessage + ", " + "2");
            ////  btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm1(" + txtDateJoinOrg.ClientID + "),ValidateForm2(" + txtDateLeaveOrg.ClientID + "),ValidateForm3(" + txtDateOfBirth.ClientID + "),ValidateForm4(" + txtDateStartCurrLoc.ClientID + "),ValidateForm5(" + txtDateLeavPreLoc.ClientID + "),ValidateData()");
            btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm51(" + txtDateJoinOrg.ClientID + "," + txtDateOfBirth.ClientID + ")");

            txtEmailId.Attributes.Add("onblur", "javascript:return EmailCheck(" + txtEmailId.ClientID + ")");
            chkActiveFlag.Attributes.Add("onclick", "javascript:return altCheck()");
            chkIsAuth.Attributes.Add("onclick", "javascript:return altCheckAuth()");
            strErrorMessage = (strErrorMessage == "" ? "3" : strErrorMessage + ", " + "3");
            getstring();
            strErrorMessage = (strErrorMessage == "" ? "4" : strErrorMessage + ", " + "4");
            getstring2();
            strErrorMessage = (strErrorMessage == "" ? "5" : strErrorMessage + ", " + "5");
            if (!IsPostBack)
            {
                hid1.Value = "100";
                hidAuth.Value = "N";
                //  Session["SqlProvider2"] = "Data Source=ECFY15;Initial Catalog=ASL_Live;User ID=sa;Password=sa";


                SqlCommand cmdDept = new SqlCommand();
                cmdDept.CommandText = "select  * from webx_master_general  where codetype = 'DEPT'";
                cmdDept.Connection = cn;
                cn.Open();

                SqlDataAdapter daDept = new SqlDataAdapter(cmdDept);
                DataSet dsDept = new DataSet();
                daDept.Fill(dsDept);

                ddlDepartment.DataSource = dsDept;
                ddlDepartment.DataTextField = "codedesc";
                ddlDepartment.DataValueField = "codeid";
                ddlDepartment.DataBind();
                cn.Close();

                SqlCommand cmdDesi = new SqlCommand();
                cmdDesi.CommandText = "select  * from webx_master_general  where codetype = 'DESIG'";
                cmdDesi.Connection = cn;
                cn.Open();

                SqlDataAdapter daDesi = new SqlDataAdapter(cmdDesi);
                DataSet dsDesi = new DataSet();
                daDesi.Fill(dsDesi);

                ddlDesignation.DataSource = dsDesi;
                ddlDesignation.DataTextField = "codedesc";
                ddlDesignation.DataValueField = "codeid";
                ddlDesignation.DataBind();
                cn.Close();

                SqlCommand cmdQalification = new SqlCommand();
                cmdDesi.CommandText = "select  * from webx_master_general  where codetype = 'UHQ'";
                cmdDesi.Connection = cn;
                cn.Open();

                SqlDataAdapter daQalification = new SqlDataAdapter(cmdDesi);
                DataSet dsQalification = new DataSet();
                daQalification.Fill(dsQalification);

                ddlHighestQualification.DataSource = dsQalification;
                ddlHighestQualification.DataTextField = "codedesc";
                ddlHighestQualification.DataValueField = "codeid";
                ddlHighestQualification.DataBind();
                cn.Close();


                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "select  * from webx_master_general  where codetype LIKE 'EMP%'";
                cmd.Connection = cn;
                cn.Open();

                cboEmployeeStatus.Items.Clear();
                cboEmployeeStatus.Items.Add("--Select--");

                SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                DataSet ds1 = new DataSet();

                da1.Fill(ds1);

                cboEmployeeStatus.DataSource = ds1;
                cboEmployeeStatus.DataTextField = "codedesc";
                cboEmployeeStatus.DataValueField = "codeid";
                cboEmployeeStatus.DataBind();

                strErrorMessage = (strErrorMessage == "" ? "6" : strErrorMessage + ", " + "6");

                cn.Close();

                cboGender.Items.Add("--Select--");
                cboGender.Items.Add("Male");
                cboGender.Items.Add("Female");

                string strEmployeeCode = Request.QueryString.Get("EmployeeCode");
                strErrorMessage = (strErrorMessage == "" ? "7" : strErrorMessage + ", " + "7");

                PasswordPolicy pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.COMPLEXITY_EXPRESSION);
                if (pp.Active == "Y")
                    revPassword.ValidationExpression = (pp.SetValue != "") ? @pp.SetValue : @"(.+)";
                pp = PasswordPolicyController.GetByCodeID(PasswordPolicy.MAXIMUM_LENGTH);
                if (pp.Active == "Y")
                    txtPassword.MaxLength = Convert.ToInt32(pp.SetValue);



                dtDocuments.Rows.Add("", "");

                gvDocument.DataSource = dtDocuments;
                gvDocument.DataBind();

            }
            strErrorMessage = (strErrorMessage == "" ? "8" : strErrorMessage + ", " + "8");
        }
        catch (Exception Ex)
        {
            // throw new Exception(strErrorMessage);
            txtResidentialAddress.Text = Ex.Message;
        }
    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT empid FROM  webx_master_users";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["empid"] + "'"));
        }
        dr_Location.Close();
    }

    private void getstring2()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT userid FROM  webx_master_users";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["userid"] + "'"));
        }
        dr_Location.Close();
    }


    public string getNewCode(string mTableName, string mFieldName, string mPrefix, int mCodeLength)
    {
        string mNewCode, mPrefix1, mint, mTemp;
        int mlen1, i;

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlDataReader drprospect;
        mTemp = "";

        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select max(right(" + mFieldName + "," + (mCodeLength - mPrefix.Length) + "))+1 as maxCode from " + mTableName;
        cmd.Connection = cn;
        drprospect = cmd.ExecuteReader();
        mNewCode = "";
        mint = "";

        if (drprospect.Read())
        {
            mint = drprospect["maxCode"].ToString();
            mlen1 = mCodeLength - (mPrefix.Length - mint.Length);
            mNewCode = mPrefix + mTemp + mint;
            drprospect.Close();
        }
        else
        {
            mlen1 = mCodeLength - (mPrefix.Length - mint.Length);
            mNewCode = mPrefix + mTemp + "1";
        }

        cn.Close();

        return mNewCode;

    }

    public void maxlen()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string q = "";
        q = "select * from WebX_Setup_Fields where fieldcode='EMP'";


        SqlCommand c = new SqlCommand(q, cn);

        SqlDataReader d = c.ExecuteReader();

        while (d.Read())
        {
            maxl = Convert.ToInt16(d["fieldlengthmax"].ToString());
            minl = Convert.ToInt16(d["fieldlengthmin"].ToString());
            pre = Convert.ToInt16(d["prefixalphachars"].ToString());

            if (d["prefixconstant"] is DBNull)
            {
            }
            else
            {
                pre2 = d["prefixconstant"].ToString();
            }


            txteid.MaxLength = maxl;
            isp = d["isprefixconstant"].ToString();

            if (isp == "N" || isp == "n")
            {
                txteid.Text = "";
            }
            else
            {
                txteid.Text = pre2;

            }
        }
        d.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string mActiveFlag = "", strEmpStatus = "", strGender = "", VirtualLoc = "";

        if (txtCstLoc.Text.Trim() != "") 
        {
            string l = txtCstLoc.Text;

            int len = l.Length;

            string t1 = l.Substring(len - 1, 1);

            

            if (t1 == ",")
            {
                VirtualLoc = l.Substring(0, l.Length - 1).Trim();
            }
            else
            {

                VirtualLoc = l.Trim();
            }
        }
        if (VirtualLoc == "")
        {
            VirtualLoc = "All";
        }

        if (txtActiveFlag.Text.Trim() == "Y")
        { mActiveFlag = "Y"; }
        else
        { mActiveFlag = "N"; }

        if (cboGender.SelectedItem.ToString() == "Male")
        { strGender = "M"; }
        else if (cboGender.SelectedItem.ToString() == "Female")
        { strGender = "F"; }

        strEmpStatus = System.Convert.ToString(cboEmployeeStatus.SelectedValue);

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string strEmpcd;

        //strEmpcd = getNewCode("WEBX_MASTER_USERS", "EMPID", "E", 5);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        string strSQL = "";
        string DocumentXml = "<root>";
        int DocSrNo = 0;

        string AadhaarUploadFileName = "", PanUploadFileName = "";
        if (fldAadhaarUpload.HasFile)
        {
            string newFName1 = GetFileName(fldAadhaarUpload.PostedFile.FileName, txtuid.Text.Trim(), "AadharNo");
            AadhaarUploadFileName = AzureStorageHelper.UploadBlob("EmployeeDocument", fldAadhaarUpload, newFName1);
        }
        if (fldPanUpload.HasFile)
        {
            string newFName2 = GetFileName(fldPanUpload.PostedFile.FileName, txtuid.Text.Trim(), "PanNo");
            PanUploadFileName = AzureStorageHelper.UploadBlob("EmployeeDocument", fldPanUpload, newFName2);
        }
        
        foreach (GridViewRow dr in gvDocument.Rows)
        {
            TextBox txtDocumentName = ((TextBox)dr.FindControl("txtDocumentName"));
            TextBox txtDocumentNo = ((TextBox)dr.FindControl("txtDocumentNo"));
            FileUpload fldDocumentUpload = ((FileUpload)dr.FindControl("fldDocumentUpload"));


            if (fldDocumentUpload.HasFile)
            {
                DocSrNo = DocSrNo + 1;
                string newFName = GetFileName(fldDocumentUpload.PostedFile.FileName, txtuid.Text.Trim(), DocSrNo.ToString());

                string DocumentUploadedFile = AzureStorageHelper.UploadBlob("EmployeeDocument", fldDocumentUpload, newFName);

                if (DocumentUploadedFile != "")
                {
                    DocumentXml = DocumentXml + "<Documents><UserId>" + txtuid.Text.Trim() + "</UserId><DocumentName>" + txtDocumentName.Text + "</DocumentName><DocumentNo>" + txtDocumentNo.Text + "</DocumentNo><DocumentUpload>" + DocumentUploadedFile + "</DocumentUpload></Documents>";
                }
            }

        }
        DocumentXml = DocumentXml + "</root>";

        if (DocSrNo > 0)
        {
            cmd.CommandText = "EXEC USP_UserMaster_SaveDocuments '" + DocumentXml + "'";
            cmd.ExecuteNonQuery();
        }


        string[] strDtFrom = txtDateJoinOrg.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

        string _UserAdvanceLimit = txtUserAdvanceLimit.Text == "" ? "0" : txtUserAdvanceLimit.Text;

        if (txtDateOfBirth.Text == "")
        {
            strSQL = "insert into WEBX_MASTER_USERS(EMPID,USERID,NAME,UserPwd,GENDER,User_Type,RESI_ADDR,EMAILID,MOBILENO,ENTRYBY,ENTRYdate,PasswordQues,PasswordANS,DOJ_ORG,BranchCode,ManagerId,status,LastUpdatedDate,DepartmentID,DesignationID,AdvanceLimit,Experience,HighestQualification,DeactivateReason,AadhaarNo,AadhaarUpload,PanNo,PanUpload,IsMultifact_Auth) values(" +
                         "'" + h123.Value + "','" + txtuid.Text.Trim() + "','" + txtName.Text.Trim() + "','" + txtPassword.Text.Trim() + "','" + strGender + "','" + strEmpStatus + "','" + txtResidentialAddress.Text.Trim() + "','" + txtEmailId.Text.Trim() + "','" + txtMobileNo.Text.Trim() + "'," +
                         "'" + Session["empcd"] + "','" + System.DateTime.Now.ToString("MM/dd/yyyy") + "','" + txtq.Text.Trim() + "','" + txtans.Text.Trim() + "','" + d1 + "','" + txtCurrentLocationCode.Text.Trim() + "','" + txtmgrid.Text.Trim() + "','" + hid1.Value + "','" + d1 + "','" + ddlDepartment.SelectedValue + "','" + ddlDesignation.SelectedValue
                         + "','" + _UserAdvanceLimit + "','" + txtUserExperience.Text + "','" + ddlHighestQualification.SelectedValue + "','" + txtDeactivateReason.Text + "','" + txtAadhaarNo.Text + "','" + AadhaarUploadFileName + "','" + txtPanNo.Text + "','" + PanUploadFileName + "','" + hidAuth.Value + "')";
            //+ "')";
        }
        else
        {
            string[] strDtTo = txtDateOfBirth.Text.Split('/');
            DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));


            strSQL = "insert into WEBX_MASTER_USERS(EMPID,USERID,NAME,UserPwd,GENDER,User_Type,RESI_ADDR,EMAILID,MOBILENO,DOB,ENTRYBY,ENTRYdate,PasswordQues,PasswordANS,DOJ_ORG,BranchCode,ManagerId,status,LastUpdatedDate,DepartmentID,DesignationID,AdvanceLimit,Experience,HighestQualification,DeactivateReason,AadhaarNo,AadhaarUpload,PanNo,PanUpload,IsMultifact_Auth) values(" +
                       "'" + h123.Value + "','" + txtuid.Text.Trim() + "','" + txtName.Text.Trim() + "','" + txtPassword.Text.Trim() + "','" + strGender + "','" + strEmpStatus + "','" + txtResidentialAddress.Text.Trim() + "','" + txtEmailId.Text.Trim() + "','" + txtMobileNo.Text.Trim() + "'," +
                       "'" + d2 + "','" + Session["empcd"] + "','" + System.DateTime.Now.ToString("MM/dd/yyyy") + "','" + txtq.Text.Trim() + "','" + txtans.Text.Trim() + "','" + d1 + "','" + txtCurrentLocationCode.Text.Trim() + "','" + txtmgrid.Text.Trim() + "','" + hid1.Value + "','" + d1 + "','" + ddlDepartment.SelectedValue + "','" + ddlDesignation.SelectedValue
                       + "','" + _UserAdvanceLimit + "','" + txtUserExperience.Text + "','" + ddlHighestQualification.SelectedValue + "','" + txtDeactivateReason.Text + "','" + txtAadhaarNo.Text + "','" + AadhaarUploadFileName + "','" + txtPanNo.Text + "','" + PanUploadFileName + "','" + hidAuth.Value + "')";

        }

        if (txtuid.Text.Trim() != "")
        {
            cmd.CommandText = "EXEC Usp_Master_UsersVirtualLocation_Insert '" + txtuid.Text.Trim() + "','" + VirtualLoc + "'";
            cmd.ExecuteNonQuery();
        }        

        //strSQL = "insert into WEBX_MASTER_USERS(EMPID,USERID,NAME,UserPwd,GENDER,User_Type,RESI_ADDR,EMAILID,MOBILENO,DOB,ENTRYBY,ENTRYdate,PasswordQues,PasswordANS,DOJ_ORG,BranchCode,ManagerId,status,LastUpdatedDate) values(" +
        //                "'" + txteid.Text.Trim() + "','" + txtuid.Text.Trim() + "','" + txtName.Text.Trim() + "','" + txtPassword.Text.Trim() + "','" + strGender + "','" + strEmpStatus + "','" + txtResidentialAddress.Text.Trim() + "','" + txtEmailId.Text.Trim() + "','" + txtMobileNo.Text.Trim() + "'," +
        //                "'" + d2 + "','" + Session["empcd"] + "','" + System.DateTime.Now.ToString("MM/dd/yyyy") + "','" + txtq.Text.Trim() + "','" + txtans.Text.Trim() + "','" + d1 + "','" +  txtCurrentLocationCode.Text.Trim() + "','" + txtmgrid.Text.Trim() + "','" + hid1.Value + "','"+d1+"')";

        try
        {
            cmd.CommandText = strSQL;
            cmd.ExecuteNonQuery();
        }
        catch (Exception eee)
        {
            btnSubmit.Text = eee.Message + ".......Please Veryfy Data";
        }
        finally
        {
            cn.Close();
        }
        Response.Redirect("EmployeeEdSelect.aspx");
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        //  cboPrefix.Text = "--Select--";
        txtName.Text = "";
        txtPassword.Text = "";
        cboGender.Text = "--Select--";
        cboEmployeeStatus.Text = "--Select--";

        txtDateJoinOrg.Text = "";
        txtResidentialAddress.Text = "";
        txtEmailId.Text = "";
        txtMobileNo.Text = "";
        txtDateOfBirth.Text = "";
        //   txtActiveFlag.Text = "Y";
        //  txtDesignation.Text = "";
    }

    protected void txtCurrentLocationCode_TextChanged(object sender, EventArgs e)
    {
        txtCurrentLocationCode.Text = txtCurrentLocationCode.Text.ToUpper();

        if (txtCurrentLocationCode.Text == "")
        {
            lblErrorLocation1.Visible = false;
            return;
        }

        String strSQL = "";

        //SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //sqlConn.Open();

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        cn.Open();

        strSQL = "SELECT LocCode FROM webx_location WHERE LocCode = '" + txtCurrentLocationCode.Text + "' and activeflag='Y'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, cn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorLocation1.Visible = (dsLocation.Tables[0].Rows.Count <= 0 ? true : false);

        if (dsLocation.Tables[0].Rows.Count <= 0)
        {
            txtCurrentLocationCode.Focus();
        }

        cn.Close();

        //sqlConn.Close();
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

    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    protected void gvDocument_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void CmdAddRows_Click(object sender, EventArgs e)
    {
        try
        {
            Int32 i;

            i = Convert.ToInt32(txtAddRows.Text);

            if (i > 0)
            {
                for (Int32 j = i; j > 0; j--)
                {
                    dtDocuments.Rows.Add("", "");
                }
            }
            gvDocument.DataSource = dtDocuments;
            gvDocument.DataBind();

        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
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
