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

public partial class GUI_admin_Employee_Employee_Add : System.Web.UI.Page
{

    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    SqlCommand cmd = new SqlCommand();
    SqlDataReader drEmpStatus, drEmpEdit;
    string strGender;
    string strEmployeeCode = "";
    public string scriptStr, EmpCode, Emp, cd, pass2, p1, uid, latestpass;
    public static string strToday = "", pre2 = "", percon = "", isp = "";
    public static int maxl = 0, minl = 0, pre = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        uclChangePassword.UserID = Session["empcd"].ToString();
        uclChangePassword.RedirectURL = "~/GUI/MyProfile.aspx";
        uclChangePassword.AskForOldPass = false;

        SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn1.Open();
        SqlCommand c1 = new SqlCommand("SELECT GETDATE() AS servdt", cn1);


        DateTime d = (DateTime)c1.ExecuteScalar();
        strToday = d.ToString("dd/MM/yyyy");
        cn1.Close();

        txtcomp.Text = DateTime.Now.ToString("dd/MM/yyyy");

        txtDateJoinOrg.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateJoinOrg.ClientID + ")");
        txtDateOfBirth.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDateOfBirth.ClientID + ")");


        ////  btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm1(" + txtDateJoinOrg.ClientID + "),ValidateForm2(" + txtDateLeaveOrg.ClientID + "),ValidateForm3(" + txtDateOfBirth.ClientID + "),ValidateForm4(" + txtDateStartCurrLoc.ClientID + "),ValidateForm5(" + txtDateLeavPreLoc.ClientID + "),ValidateData()");
        btnSubmit.Attributes.Add("onclick", "javascript:return ValidateForm51(" + txtDateJoinOrg.ClientID + "," + txtDateOfBirth.ClientID + ")");

        txtEmailId.Attributes.Add("onblur", "javascript:return EmailCheck(" + txtEmailId.ClientID + ")");
        chkActiveFlag.Attributes.Add("onclick", "javascript:return altCheck()");

        // TEMP
        // btnpass.Attributes.Add("onclick", "javascript:return passfn()");
        
        if (!IsPostBack)
        {


            //  Session["SqlProvider2"] = "Data Source=ECFY15;Initial Catalog=ASL_Live;User ID=sa;Password=sa";



            //Emp = Session["empcd"].ToString();
            EmpCode = Session["empcd"].ToString();
            //    Request.QueryString["eno"].ToString();
            // uid = ""; ;


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

            cn.Close();

            cboGender.Items.Add("--Select--");
            cboGender.Items.Add("Male");
            cboGender.Items.Add("Female");

            // strEmployeeCode = Request.QueryString.Get("EmployeeCode");
            filldata();           
        }
    }


    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string q = "";


        q = "select top 1 * from webx_master_users where userid='" + EmpCode + "'";




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

            //txtPwd.Text
              
            latestpass  = d["userpwd"].ToString();




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

        if (txtDateOfBirth.Text == "")
        {
            strSQL = "update WEBX_MASTER_USERS set emPID='" + txteid.Text.Trim() + "',USERID='" + txtuid.Text.Trim() + "',NAME='" + txtName.Text.Trim() + "'," +
    "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value + "',LastUpdatedDate='" + d1 + "' where userid='" + Session["EMPCD"].ToString() + "' ";

        }
        else
        {
            string[] strDtTo = txtDateOfBirth.Text.Split('/');
            DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));


            strSQL = "update WEBX_MASTER_USERS set EMPID='" + txteid.Text.Trim() + "',USERID='" + txtuid.Text.Trim() + "',NAME='" + txtName.Text.Trim() + "'," +
             "GENDER='" + strGender + "',User_Type='" + strEmpStatus + "',RESI_ADDR='" + txtResidentialAddress.Text + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',DOB='" + d2 + "',ENTRYBY='" + Session["empcd"] + "',ENTRYdate='" + System.DateTime.Now.ToString("MM/dd/yyyy") + "',PasswordQues='" + txtq.Text.Trim() + "',PasswordANS='" + txtans.Text.Trim() + "',DOJ_ORG='" + d1 + "',BranchCode='" + txtCurrentLocationCode.Text.Trim() + "',ManagerId='" + txtmgrid.Text.Trim() + "',status='" + hid1.Value + "',LastUpdatedDate='" + d1 + "' where userid='" + Session["EMPCD"].ToString() + "'  ";

        }


        try
        {
            cmd.CommandText = strSQL;
            cmd.ExecuteNonQuery();
        }
        catch (Exception eee)
        {
            btnSubmit.Text = eee.Message + ".......Please Veryfy Data";
        }



        Response.Redirect("welcome.aspx");
    }







    protected void btnReset_Click(object sender, EventArgs e)
    {
        //  cboPrefix.Text = "--Select--";
        txtName.Text = "";
        txtPwd.Text = "";
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
        uclChangePassword.UserID = txtuid.Text.Trim();
        uclChangePassword.RedirectURL = "~/GUI/MyProfile.aspx";
        mainpnl.Visible = false;
        passpnl.Visible = true;       
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
    protected void pass_Click(object sender, EventArgs e)
    {

        if (Page.IsValid == true)
        {
            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            cn.Open();


            string strEmpcd;


            cmd.Connection = cn;
            string strSQL = "";





            string[] strDtFrom = txtDateJoinOrg.Text.Split('/');
            DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

            // TEMP
            // strSQL = "update WEBX_MASTER_USERS set UserPwd='" + txtnewpass.Text + "' where userid='" + Session["EMPCD"].ToString() + "' ";




            try
            {
                cmd.CommandText = strSQL;
                cmd.ExecuteNonQuery();
            }
            catch (Exception eee)
            {
               // TEMP
               // btnpass.Text = eee.Message + ".......Please Veryfy Data";
            }
            Response.Redirect("MyProfile.aspx");


        }
    }
}
