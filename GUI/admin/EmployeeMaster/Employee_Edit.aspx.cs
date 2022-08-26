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
using System.Text.RegularExpressions;

public partial class GUI_admin_Employee_Employee_Add : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    SqlCommand cmd = new SqlCommand();
    SqlDataReader drEmpStatus, drEmpEdit;
    string strGender;
    string strEmployeeCode = "";
    public static string scriptStr, EmpCode, Emp, cd, pass2, p1, uid;
    public static string strToday = "", pre2 = "", percon = "", isp = "";
    public static int maxl = 0, minl = 0, pre = 0;
    DataTable dtDocuments = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        dtDocuments.Columns.AddRange(new DataColumn[4] { new DataColumn("SrNo"), new DataColumn("DocumentName"), new DataColumn("DocumentNo"), new DataColumn("DocumentUpload") });
        string para = Request.QueryString["para1"].ToString();
        if (para == "1")
        {
            //dHir = Session["dHir"].ToString();
            //dLoc = Session["dLoc"].ToString();
            Emp = Session["dEmp"].ToString();
            EmpCode = Session["tEmpCode"].ToString();
            uid = Session["uid"].ToString();

            if (!string.IsNullOrEmpty(Emp))
            {
                uclChangePassword.UserID = Emp;
            }
            else if (!string.IsNullOrEmpty(EmpCode))
            {
                uclChangePassword.UserID=GetUseridOnEmployeeId(EmpCode);
            }
            else
            {
                uclChangePassword.UserID = uid;
            }
        }

        SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn1.Open();

        SqlCommand c1 = new SqlCommand("SELECT GETDATE() AS servdt", cn1);

        DateTime d = (DateTime)c1.ExecuteScalar();
        strToday = d.ToString("dd/MM/yyyy");
        cn1.Close();

        // uclChangePassword.UserID = uid;
        uclChangePassword.RedirectURL = "~/GUI/Admin/EmployeeMaster/Employee_Edit.aspx?para1=1";
        uclChangePassword.AskForOldPass = false;

        if (!IsPostBack)
        {
            hdnContainerName.Value = ConfigurationManager.AppSettings["SOPContainerName"].ToString();
            SqlCommand cmdDept = new SqlCommand();
            cmdDept.CommandText = "select  * from webx_master_general  where codetype = 'DEPT'";
            cmdDept.Connection = cn1;
            cn1.Open();

            SqlDataAdapter daDept = new SqlDataAdapter(cmdDept);
            DataSet dsDept = new DataSet();
            daDept.Fill(dsDept);

            ddlDepartment.DataSource = dsDept;
            ddlDepartment.DataTextField = "codedesc";
            ddlDepartment.DataValueField = "codeid";
            ddlDepartment.DataBind();
            cn1.Close();

            SqlCommand cmdDesi = new SqlCommand();
            cmdDesi.CommandText = "select  * from webx_master_general  where codetype = 'DESIG'";
            cmdDesi.Connection = cn1;
            cn1.Open();

            SqlDataAdapter daDesi = new SqlDataAdapter(cmdDesi);
            DataSet dsDesi = new DataSet();
            daDesi.Fill(dsDesi);

            ddlDesignation.DataSource = dsDesi;
            ddlDesignation.DataTextField = "codedesc";
            ddlDesignation.DataValueField = "codeid";
            ddlDesignation.DataBind();
            cn1.Close();

            SqlCommand cmdQalification = new SqlCommand();
            cmdDesi.CommandText = "select  * from webx_master_general  where codetype = 'UHQ'";
            cmdDesi.Connection = cn1;
            cn1.Open();

            SqlDataAdapter daQalification = new SqlDataAdapter(cmdDesi);
            DataSet dsQalification = new DataSet();
            daQalification.Fill(dsQalification);

            ddlHighestQualification.DataSource = dsQalification;
            ddlHighestQualification.DataTextField = "codedesc";
            ddlHighestQualification.DataValueField = "codeid";
            ddlHighestQualification.DataBind();
            cn1.Close();

            txtcomp.Text = DateTime.Now.ToString("dd/MM/yyyy");

            txtDateJoinOrg.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateJoinOrg.ClientID + ")");
            txtDateOfBirth.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateOfBirth.ClientID + ")");

            ////  btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm1(" + txtDateJoinOrg.ClientID + "),ValidateForm2(" + txtDateLeaveOrg.ClientID + "),ValidateForm3(" + txtDateOfBirth.ClientID + "),ValidateForm4(" + txtDateStartCurrLoc.ClientID + "),ValidateForm5(" + txtDateLeavPreLoc.ClientID + "),ValidateData()");
            btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm51(" + txtDateJoinOrg.ClientID + "," + txtDateOfBirth.ClientID + ")");

            txtEmailId.Attributes.Add("onblur", "javascript:return EmailCheck(" + txtEmailId.ClientID + ")");
            chkActiveFlag.Attributes.Add("onclick", "javascript:return altCheck()");
            chkIsAuth.Attributes.Add("onclick", "javascript:return altCheckAuth()");

            maxlen();
            pass2 = "***************";
            //  Session["SqlProvider2"] = "Data Source=ECFY15;Initial Catalog=ASL_Live;User ID=sa;Password=sa";
            if (para == "1")
            {
                //dHir = Session["dHir"].ToString();
                //dLoc = Session["dLoc"].ToString();
                Emp = Session["dEmp"].ToString();
                EmpCode = Session["tEmpCode"].ToString();
                uid = Session["uid"].ToString();
            }
            else
            {
                Emp = Request.QueryString["enm"].ToString();
                EmpCode = Request.QueryString["eno"].ToString();
                uid = ""; ;
            }
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cmd.CommandText = "select  * from webx_master_general  where codetype like 'EMP%'";
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
            cn.Close()
                ;
            cboGender.Items.Add("--Select--");
            cboGender.Items.Add("Male");
            cboGender.Items.Add("Female");

            // strEmployeeCode = Request.QueryString.Get("EmployeeCode");
            filldata();
            getstring();
            getstring2();
            GetUserDocuments();
        }
    }
	private string GetUseridOnEmployeeId(string EmpCode)
    {
        var Userid = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT userid FROM  webx_master_users where empid = '" + EmpCode + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Userid;
        dr_Userid = sqlCommand.ExecuteReader();
        while (dr_Userid.Read())
        {
            Userid= dr_Userid["userid"].ToString();
        }
        dr_Userid.Close();
        return Userid;
    }
    public void GetUserDocuments()
    {

        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cmd.CommandText = "EXEC USP_UserMaster_GetUserDocuments '" + uid + "'";
        cmd.Connection = cn;
        cn.Open();
        SqlDataAdapter da1 = new SqlDataAdapter(cmd);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);
        gvDocument.DataSource = ds1;
        gvDocument.DataBind();
        cn.Close();
    }
    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT empid FROM  webx_master_users where empid <> '" + txteid.Text + "'";
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
        string sql = "SELECT userid FROM  webx_master_users where userid <> '" + txtuid.Text + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["userid"] + "'"));
        }
        dr_Location.Close();
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
        }
        d.Close();

    }
    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string q = "";

        if (uid == "")
        {
            q = "select top 1 VL.BranchCode as VirtulaLocation, * from webx_master_users U outer apply(SELECT  STUFF(( SELECT  ',' + D.BranchCode  FROM dbo.WebX_Master_UsersVirtualLocation D WHERE D.UserId = U.UserId FOR XML PATH('') ), 1, 1, '') AS BranchCode)VL where empid='" + EmpCode + "'";
        }
        else
        {
            //q = "select top 1 * from webx_master_users where userid='" + uid + "'";
            q = "select top 1 VL.BranchCode as VirtulaLocation, * from webx_master_users outer apply(SELECT  STUFF(( SELECT  ',' + D.BranchCode  FROM dbo.WebX_Master_UsersVirtualLocation D WHERE D.UserId = '" + uid + "' FOR XML PATH('') ), 1, 1, '') AS BranchCode)VL where userid='" + uid + "'";

        }

        SqlCommand c = new SqlCommand(q, cn);
        SqlDataReader d = c.ExecuteReader();

        while (d.Read())
        {
            txtName.Text = d["name"].ToString();
            txteid.Text = d["empid"].ToString();

            if (d["ManagerId"] != System.DBNull.Value)
            {
                txtmgrid.Text = d["ManagerId"].ToString();
            }


            if (d["mobileno"] != System.DBNull.Value)
            {

                txtMobileNo.Text = d["mobileno"].ToString();
            }
            if (d["RESI_ADDR"] != System.DBNull.Value)
            {
                txtResidentialAddress.Text = d["RESI_ADDR"].ToString();
            }

            string dt1 = "";
            if (d["dob"] != System.DBNull.Value)
            {
                dt1 = Convert.ToDateTime(d["dob"].ToString()).ToString("dd/MM/yyyy");
            }
            string dt2 = "";
            if (d["doj_org"] != System.DBNull.Value)
            {
                dt2 = Convert.ToDateTime(d["doj_org"].ToString()).ToString("dd/MM/yyyy");
            }

            txtDateOfBirth.Text = dt1;
            txtDateJoinOrg.Text = dt2;

            if (d["EmailId"] != System.DBNull.Value)
            {
                txtEmailId.Text = d["EmailId"].ToString();
            }


            if (d["branchcode"] != System.DBNull.Value)
            {
                txtCurrentLocationCode.Text = d["branchcode"].ToString();
            }
            //if (d["VirtulaLocation"] != System.DBNull.Value)
            //{
            //    txtCstLoc.Text = d["VirtulaLocation"].ToString();
            //}
            if (d["VirtulaLocation"].ToString() == "All")
            {
                txtCstLoc.Text = "";
            }
            else 
            {
                txtCstLoc.Text = d["VirtulaLocation"].ToString();
            }

            if (d["PasswordQues"] != System.DBNull.Value)
            {
                txtq.Text = d["PasswordQues"].ToString();
            }

            if (d["Passwordans"] != System.DBNull.Value)
            {
                txtans.Text = d["Passwordans"].ToString();
            }


            if (d["userid"] != System.DBNull.Value)
            {
                txtuid.Text = d["userid"].ToString();
            }

            if (d["user_type"] != System.DBNull.Value)
            {
                cd = d["user_type"].ToString();
            }


            if (d["status"].ToString() == "100")
            {
                txtActiveFlag.Text = "Yes";
                hid1.Value = "100";
                chkActiveFlag.Checked = true;
            }
            else
            {
                txtActiveFlag.Text = "No";
                hid1.Value = "200";
                chkActiveFlag.Checked = false;
            }
            
            if (d["IsMultifact_Auth"].ToString() == "Y" )
            {
                hidAuth.Value = "Y";
                chkIsAuth.Checked = true;
            }
            else
            {
                hidAuth.Value = "N";
                chkIsAuth.Checked = false;
            }

            cboEmployeeStatus.Text = d["user_type"].ToString();

            if (d["gender"] is DBNull)
            {
            }
            else
            {
                string gen = d["gender"].ToString();
                if (gen == "M")
                {
                    cboGender.Text = "Male";
                }
                else
                {
                    cboGender.Text = "Female";
                }
            }

            if (d["DepartmentID"] != System.DBNull.Value)
            {
                ddlDepartment.SelectedValue = d["DepartmentID"].ToString();
            }

            if (d["DesignationID"] != System.DBNull.Value)
            {
                ddlDesignation.SelectedValue = d["DesignationID"].ToString();
            }

            if (d["AdvanceLimit"] != System.DBNull.Value)
            {
                txtUserAdvanceLimit.Text = d["AdvanceLimit"].ToString();
            }
            if (d["Experience"] != System.DBNull.Value)
            {
                txtUserExperience.Text = d["Experience"].ToString();
            }
            if (d["HighestQualification"] != System.DBNull.Value)
            {
                ddlHighestQualification.SelectedValue = d["HighestQualification"].ToString();
            }
            if (d["DeactivateReason"] != System.DBNull.Value)
            {
                txtDeactivateReason.Text = d["DeactivateReason"].ToString();
            }
            
            if (d["AadhaarNo"] != System.DBNull.Value)
            {
                txtAadhaarNo.Text = d["AadhaarNo"].ToString();
            }
            if (d["PanNo"] != System.DBNull.Value)
            {
                txtPanNo.Text = d["PanNo"].ToString();
            }
            if (d["AadhaarUpload"] != System.DBNull.Value && Convert.ToString(d["AadhaarUpload"]) != "")
            {
                hdnAadhaarUpload.Value = d["AadhaarUpload"].ToString();
                lblAadhaarView.Visible = true;
            }
            if (d["PanUpload"] != System.DBNull.Value && Convert.ToString( d["PanUpload"]) != "")
            {
                hdnPanUpload.Value = d["PanUpload"].ToString();
                lblPanView.Visible = true;
            }

        }
        d.Close();

        SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd1 = new SqlCommand("select  codedesc from webx_master_general  where codetype like 'EMP%' and codeid='" + cd + "'", cn1);
        //cmd.CommandText = "select  codedesc from webx_master_general  where codetype='EMP%' and codeid=''" + cd + "''";
        // cmd.Connection = cn1;
        cn1.Open();
        string ctype = "";
        ctype = (string)cmd1.ExecuteScalar();
        cboEmployeeStatus.Text = ctype;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string VirtualLoc = "";
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
        if (VirtualLoc=="")
            {
            VirtualLoc = "All";
        }
        if (cboGender.SelectedItem.ToString() == "Male")
        {
            strGender = "M";
        }
        else if (cboGender.SelectedItem.ToString() == "Female")
        {
            strGender = "F";
        }

        string strEmpStatus = System.Convert.ToString(cboEmployeeStatus.SelectedValue);
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string strEmpcd;
        cmd.Connection = cn;
        string strSQL = "";

        string[] strDtFrom = txtDateJoinOrg.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

        string _UserAdvanceLimit = txtUserAdvanceLimit.Text == "" ? "0" : txtUserAdvanceLimit.Text;

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

        string DocumentXml = "<root>";
        int DocSrNo = 0;
        foreach (GridViewRow dr in gvDocument.Rows)
        {
            DocSrNo = DocSrNo + 1;
            TextBox txtDocumentName = ((TextBox)dr.FindControl("txtDocumentName"));
            TextBox txtDocumentNo = ((TextBox)dr.FindControl("txtDocumentNo"));
            FileUpload fldDocumentUpload = ((FileUpload)dr.FindControl("fldDocumentUpload"));
            HiddenField hdnDocumentUpload = ((HiddenField)dr.FindControl("hdnDocumentUpload"));
            HiddenField hdnSrNo = ((HiddenField)dr.FindControl("hdnSrNo"));



            if (fldDocumentUpload.HasFile)
            {
                //DocSrNo = DocSrNo + 1;
                string newFName = GetFileName(fldDocumentUpload.PostedFile.FileName, txtuid.Text.Trim(), DocSrNo.ToString());

                string DocumentUploadedFile = AzureStorageHelper.UploadBlob("EmployeeDocument", fldDocumentUpload, newFName);

                if (DocumentUploadedFile != "")
                {
                    DocumentXml = DocumentXml + "<Documents><SrNo>" + hdnSrNo.Value + "</SrNo><UserId>" + txtuid.Text.Trim() + "</UserId><DocumentName>" + txtDocumentName.Text + "</DocumentName><DocumentNo>" + txtDocumentNo.Text + "</DocumentNo><DocumentUpload>" + DocumentUploadedFile + "</DocumentUpload></Documents>";
                }
            }
            if (fldDocumentUpload.HasFile == false && hdnSrNo.Value != "0")
            {
                {
                    DocumentXml = DocumentXml + "<Documents><SrNo>" + hdnSrNo.Value + "</SrNo><UserId>" + txtuid.Text.Trim() + "</UserId><DocumentName>" + txtDocumentName.Text + "</DocumentName><DocumentNo>" + txtDocumentNo.Text + "</DocumentNo><DocumentUpload>" + hdnDocumentUpload.Value + "</DocumentUpload></Documents>";
                }

            }
        }
        DocumentXml = DocumentXml + "</root>";
        cmd.CommandText = "EXEC USP_UserMaster_UpdateUserDocuments '" + DocumentXml + "'";
        cmd.ExecuteNonQuery();




        if (uid == "")
        {
            if (txtDateOfBirth.Text == "")
            {
                strSQL = "update WEBX_MASTER_USERS set NAME='" + txtName.Text.Trim() + "'," +
                "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value  + "',IsMultifact_Auth='" + hidAuth.Value + "',LastUpdatedDate='" + d1 + "',DepartmentID='" + ddlDepartment.SelectedValue
                + "',DesignationID='" + ddlDesignation.SelectedValue + "',AdvanceLimit='" + _UserAdvanceLimit + "',Experience='" + txtUserExperience.Text
                + "',HighestQualification='" + ddlHighestQualification.SelectedValue + "',DeactivateReason='" + txtDeactivateReason.Text + "', AadhaarNo='" + txtAadhaarNo.Text + "',PanNo='" + txtPanNo.Text + "'";
                if (AadhaarUploadFileName != "" && fldAadhaarUpload.HasFile) {
                    strSQL = strSQL + " , AadhaarUpload='" + AadhaarUploadFileName + "'" ;
                }
                if (PanUploadFileName != "" && fldPanUpload.HasFile)
                {
                    strSQL = strSQL + " , PanUpload='" + PanUploadFileName + "'";
                }
                strSQL = strSQL + " where empid='" + EmpCode + "' ";

            }
            else
            {
                string[] strDtTo = txtDateOfBirth.Text.Split('/');
                DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

                strSQL = "update WEBX_MASTER_USERS set NAME='" + txtName.Text.Trim() + "'," +
                "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',DOB='" + d2 + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value  +"',IsMultifact_Auth='" + hidAuth.Value + "',LastUpdatedDate='" + d1 + "',DepartmentID='" + ddlDepartment.SelectedValue
                + "',DesignationID='" + ddlDesignation.SelectedValue + "',AdvanceLimit='" + _UserAdvanceLimit + "',Experience='" + txtUserExperience.Text
                + "',HighestQualification='" + ddlHighestQualification.SelectedValue + "',DeactivateReason='" + txtDeactivateReason.Text + "' , AadhaarNo='" + txtAadhaarNo.Text + "',PanNo='" + txtPanNo.Text + "'";
                if (AadhaarUploadFileName != "" && fldAadhaarUpload.HasFile)
                {
                    strSQL = strSQL + " , AadhaarUpload='" + AadhaarUploadFileName + "'";
                }
                if (PanUploadFileName != "" && fldPanUpload.HasFile)
                {
                    strSQL = strSQL + " , PanUpload='" + PanUploadFileName + "'";
                }
                strSQL = strSQL + " where empid='" + EmpCode + "' ";

            }
        }
        else
        {
            if (txtDateOfBirth.Text == "")
            {
                strSQL = "update WEBX_MASTER_USERS set emPID='" + txteid.Text.Trim() + "',USERID='" + txtuid.Text.Trim() + "',NAME='" + txtName.Text.Trim() + "'," +
                "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value + "',IsMultifact_Auth='" + hidAuth.Value + "',LastUpdatedDate='" + d1 + "',DepartmentID='" + ddlDepartment.SelectedValue
                + "',DesignationID='" + ddlDesignation.SelectedValue + "',AdvanceLimit='" + _UserAdvanceLimit + "',Experience='" + txtUserExperience.Text
                + "',HighestQualification='" + ddlHighestQualification.SelectedValue + "',DeactivateReason='" + txtDeactivateReason.Text + "' , AadhaarNo='" + txtAadhaarNo.Text + "',PanNo='" + txtPanNo.Text + "'";
                if (AadhaarUploadFileName != "" && fldAadhaarUpload.HasFile)
                {
                    strSQL = strSQL + " , AadhaarUpload='" + AadhaarUploadFileName + "'";
                }
                if (PanUploadFileName != "" && fldPanUpload.HasFile)
                {
                    strSQL = strSQL + " , PanUpload='" + PanUploadFileName + "'";
                }
                strSQL = strSQL + " where userid='" + uid + "' ";
            }
            else
            {
                string[] strDtTo = txtDateOfBirth.Text.Split('/');
                DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

                strSQL = "update WEBX_MASTER_USERS set emPID='" + txteid.Text.Trim() + "',USERID='" + txtuid.Text.Trim() + "',NAME='" + txtName.Text.Trim() + "'," +
                "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',DOB='" + d2 + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value + "',IsMultifact_Auth='" + hidAuth.Value + "',LastUpdatedDate='" + d1 + "',DepartmentID='" + ddlDepartment.SelectedValue
                + "',DesignationID='" + ddlDesignation.SelectedValue + "',AdvanceLimit='" + _UserAdvanceLimit + "',Experience='" + txtUserExperience.Text
                + "',HighestQualification='" + ddlHighestQualification.SelectedValue + "',DeactivateReason='" + txtDeactivateReason.Text + "' , AadhaarNo='" + txtAadhaarNo.Text + "',PanNo='" + txtPanNo.Text + "'";
                if (AadhaarUploadFileName != "" && fldAadhaarUpload.HasFile)
                {
                    strSQL = strSQL + " , AadhaarUpload='" + AadhaarUploadFileName + "'";
                }
                if (PanUploadFileName != "" && fldPanUpload.HasFile)
                {
                    strSQL = strSQL + " , PanUpload='" + PanUploadFileName + "'";
                }
                strSQL = strSQL + " where userid='" + uid + "'  ";
            }
        }

        if (txtuid.Text.Trim() != "") {
            cmd.CommandText = "EXEC Usp_Master_UsersVirtualLocation_Insert '" + txtuid.Text.Trim() + "','" + VirtualLoc + "'";
            cmd.ExecuteNonQuery();
        }
        
        //strSQL = "update WEBX_MASTER_USERS set emPID='" + txteid.Text.Trim() + "',USERID='" + txtuid.Text.Trim() + "',NAME='" + txtName.Text.Trim() + "'," +
        //"UserPwd='" + pw + "',GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',DOB='" + d2 + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value + "',LastUpdatedDate='" + d1 + "' where empid='" + EmpCode + "' ";

        try
        {
            cmd.CommandText = strSQL;
            cmd.ExecuteNonQuery();
            //Response.Write(strSQL);
            Response.Redirect("EmployeeEdSelect.aspx", false);
        }
        catch (Exception eee)
        {
            //btnSubmit.Text = eee.Message + ".......Please Veryfy Data";
            //Response.Write(eee.Message);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        //  cboPrefix.Text = "--Select--";
        txtName.Text = "";
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

    protected void ln1_Click(object sender, EventArgs e)
    {
        uclChangePassword.RedirectURL = "~/GUI/Admin/EmployeeMaster/Employee_Edit.aspx?para1=1";
        pnlMain.Visible = false;
        pnlPassword.Visible = true;
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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            HiddenField hdnDocumentUpload = (HiddenField)e.Row.FindControl("hdnDocumentUpload");
            Label lblDockView = (Label)e.Row.FindControl("lblDockView");

            if (hdnDocumentUpload.Value != "")
            {
                //lblPOD.Attributes.Add("style", "display:none");
                lblDockView.Visible = true;
            }
            else
            {
                lblDockView.Visible = false;
            }
        }
    }

    protected void CmdAddRows_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow dr in gvDocument.Rows)
            {
                TextBox txtDocumentName = ((TextBox)dr.FindControl("txtDocumentName"));
                TextBox txtDocumentNo = ((TextBox)dr.FindControl("txtDocumentNo"));
                FileUpload fldDocumentUpload = ((FileUpload)dr.FindControl("fldDocumentUpload"));
                HiddenField hdnDocumentUpload = ((HiddenField)dr.FindControl("hdnDocumentUpload"));
                HiddenField hdnSrNo = ((HiddenField)dr.FindControl("hdnSrNo"));

                dtDocuments.Rows.Add(hdnSrNo.Value, txtDocumentName.Text, txtDocumentNo.Text, hdnDocumentUpload.Value);

            }

            Int32 i;

            i = Convert.ToInt32(txtAddRows.Text == "" ? "0" : txtAddRows.Text);

            if (i > 0)
            {
                for (Int32 j = i; j > 0; j--)
                {
                    dtDocuments.Rows.Add("0", "", "", "");
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
