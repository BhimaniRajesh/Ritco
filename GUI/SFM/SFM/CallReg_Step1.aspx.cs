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

public partial class SFM_CallReg_Step1 : System.Web.UI.Page
{
    public static SqlConnection conn;

    public static SqlCommand cmd = new SqlCommand();
    public DateTime calldate = new DateTime();
    public DateTime orderdate = new DateTime();
    string x, z, y, scriptStr, conName;
    public string strCallDate, prospectCode, CallCode, PersonCalled, CallTime, discPoint;
    public string strOrderDate, CallType;
    public static string strProspectCode, AcctCategory, tempProspect;
    float valpmonth, callDuration;
    DateTime OrderDate, CallDate, CallDt, lastorderdt;
    Boolean blnValidate;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {

            fillAccStatus();
            tempProspect = Request.QueryString.Get("ProspectCode");

            btnSubmit.Attributes.Add("onclick", "javascript:return Validation(" + cboCallType.ClientID + "," + txtPersonCalled.ClientID + "," + txtTime.ClientID + "," + txtDiscuss.ClientID + "," + txtMin.ClientID + "," + cboAccountCategory.ClientID + "," + txtOrderDate.ClientID + "," + txtOrderValue.ClientID + "," + txtdate.ClientID + ")");
            string conName = txtdate.ClientID;
            scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
            txtdate.Attributes.Add("onclick", scriptStr);

            string conName1 = txtOrderDate.ClientID;
            scriptStr = "javascript:return popUpCalendar(this," + conName1 + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName1 + "\\')')";
            txtOrderDate.Attributes.Add("onclick", scriptStr);

            //txtTime.Attributes.Add("onblur", "javascript:return validateTime(" + txtTime.ClientID + ")");


            SqlDataReader drCall;
            conn.Open();
            strProspectCode = Request.QueryString.Get("ProspectCode");
            cmd.CommandText = "select top 1 * from webx_callentry where prospectCode='" + strProspectCode + "' order  by calldt desc";
            cmd.Connection = conn;
            drCall = cmd.ExecuteReader();

            while (drCall.Read())
            {
                txtPersonCalled.Text = drCall["PersonCalled"].ToString();
                txtdate.Text = Convert.ToDateTime(drCall["callDt"]).ToString("dd MMM yyyy");
                txtTime.Text = drCall["CallTime"].ToString();
                txtMin.Text = drCall["callDuration"].ToString();
                txtDiscuss.Text = drCall["discPoint"].ToString();
                cboCallType.SelectedItem.Text = drCall["CallType"].ToString();
                //cboAccountCategory.SelectedItem.Text = drCall["AcctCategory"].ToString();
                txtOrderValue.Text = drCall["valpmonth"].ToString();
                txtOrderDate.Text = Convert.ToDateTime(drCall["lastOrderdt"]).ToString("dd MMM yyyy");
            }
            drCall.Close();

            string sql = "Select CompanyName from webx_ProspectCustomer where prospectCode='" + strProspectCode + "'";
            SqlCommand cmd1 = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            while (dr.Read())
            {
                string company = dr["CompanyName"].ToString();
                custid.Text = tempProspect + " : " + company;
            }
            dr.Close();
            conn.Close();
            blnValidate = true;

            lblEntryDt.Text = System.DateTime.Today.ToString("dd MMM yyyy");
        }
    }

    private void fillAccStatus()
    {
        conn.Open();
        SqlDataReader drStatus;
        cmd.CommandText = "select * from webx_master_general where codetype='ast'";
        cmd.Connection = conn;
        drStatus = cmd.ExecuteReader();

        cboAccountCategory.Items.Clear();
        while (drStatus.Read())
        {
            cboAccountCategory.Items.Add(new ListItem(drStatus.GetValue(2).ToString(), drStatus.GetValue(1).ToString()));

        }

        drStatus.Close();

        conn.Close();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn.Open();
        string mNewCode;
        string sql1 = "select max(callCode) from webx_CallEntry";
        SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
        string i;
        i = Command.ExecuteScalar().ToString();

        if (i == "")
        {
            i = "CL00000";
        }
        int j = Convert.ToInt16(i.Substring(2, 5));
        int k = j + 1;
        string m = k.ToString();

        if (m.Length == 1)
        {
            m = "0000" + m;
        }
        else if (m.Length == 2)
        {
            m = "000" + m;
        }
        else if (m.Length == 3)
        {
            m = "00" + m;
        }
        else if (m.Length == 4)
        {
            m = "0" + m;
        }
        else if (m.Length == 5)
        {
            m = m;
        }


        mNewCode = "CL" + m.ToString();
        CallCode = mNewCode;

        PersonCalled = txtPersonCalled.Text.Trim();
        CallTime = txtTime.Text.Trim();
        discPoint = txtDiscuss.Text.Trim();
        if (txtMin.Text.Trim() != "")
        {
            callDuration = System.Convert.ToSingle(txtMin.Text.Trim());
        }
        AcctCategory = cboAccountCategory.SelectedValue;

        CallType = cboCallType.SelectedValue;

        string sql = "webx_sfm_CallEntry_InsertData";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.CommandType = CommandType.StoredProcedure;

        prospectCode = strProspectCode;

        string brcd = Convert.ToString(Session["brcd"]);
        string empcd = Convert.ToString(Session["Empcd"]);


        sqlcmd2.Parameters.Add("@callCode_1", SqlDbType.VarChar).Value = CallCode;
        sqlcmd2.Parameters.Add("@callDt_2", SqlDbType.DateTime).Value = Convert.ToDateTime(txtdate.Text.ToString().Trim());
        sqlcmd2.Parameters.Add("@prospectCode_3", SqlDbType.VarChar).Value = strProspectCode;
        sqlcmd2.Parameters.Add("@PersonCalled_4", SqlDbType.VarChar).Value = txtPersonCalled.Text.ToString().Trim();


        sqlcmd2.Parameters.Add("@CallTime_5", SqlDbType.VarChar).Value = txtTime.Text.ToString().Trim();
        sqlcmd2.Parameters.Add("@discPoint_6", SqlDbType.VarChar).Value = txtDiscuss.Text.ToString().Trim();
        if (txtMin.Text.ToString() == "")
        {
            txtMin.Text = "0";
        }
        if (txtOrderValue.Text.ToString() == "")
        {
            txtOrderValue.Text = "0";
        }
        sqlcmd2.Parameters.Add("@callDuration_7", SqlDbType.Int).Value = Convert.ToInt16(txtMin.Text.Trim());
        sqlcmd2.Parameters.Add("@AcctCategory_8", SqlDbType.VarChar).Value = cboAccountCategory.SelectedItem.Text;
        sqlcmd2.Parameters.Add("@CallType_10", SqlDbType.VarChar).Value = cboCallType.SelectedItem.Text;
        sqlcmd2.Parameters.Add("@entryby_11", SqlDbType.VarChar).Value = empcd;
        sqlcmd2.Parameters.Add("@loccode", SqlDbType.VarChar).Value = brcd;
        sqlcmd2.Parameters.Add("@entrydt", SqlDbType.VarChar).Value = "";
        sqlcmd2.Parameters.Add("@valpmonth", SqlDbType.Float).Value = Convert.ToDouble(txtOrderValue.Text.ToString().Trim());
        if (txtOrderDate.Text.ToString() == "")
        {
            sqlcmd2.Parameters.Add("@lastorderdt", SqlDbType.DateTime).Value = System.DateTime.Today;
        }
        else
        {
            sqlcmd2.Parameters.Add("@lastorderdt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtOrderDate.Text.ToString().Trim());
        }
        
        sqlcmd2.ExecuteNonQuery();

        cmd.CommandText = "update webx_ProspectCustomer set LastVisitDt='" + txtdate.Text + "',AcctCategory='" + cboAccountCategory.SelectedItem.ToString() + "', valpmonth=" + txtOrderValue.Text + " where prospectCode ='" + prospectCode + "'";
        cmd.Connection = conn;
        cmd.ExecuteNonQuery();

        conn.Close();
        Response.Redirect("CallReg_Done.aspx?CallCode=" + CallCode);

    }

}
