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

public partial class SFM_AppointmentEntry1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    string scriptStr, conName;
    public string AppontmentId;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtCustCode').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnCust.Attributes.Add("onclick", "window.open('Appointment_popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        if (!IsPostBack)
        {
            string conName = txtAppDate.ClientID;
            scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
            txtAppDate.Attributes.Add("onclick", scriptStr);

            btnSubmit.Attributes.Add("onclick", "javascript:return Validation(" + txtCustCode.ClientID + "," + txtAppDate.ClientID + "," + txtTime.ClientID + "," + txtPersonMet.ClientID + "," + txtContactNo.ClientID + "," + txtDepartment.ClientID + "," + txtDesignation.ClientID + "," + txtPurposeofVisit.ClientID + ")");
            txtTime.Attributes.Add("onblur", "javascript:return validateTime(" + txtTime.ClientID + ")");
            
        }
        DateTime entrydt = new DateTime();
        entrydt = System.DateTime.Today;
        txtEntrydate.Text = entrydt.ToString("dd MMM yyyy");
        txtEntrydate.ReadOnly = true;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
            conn.Open();
        
            string mNewCode;
            string sql1 = "select max(AppointmentCode) from Webx_Appointment";
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
            string i;
            i = Command.ExecuteScalar().ToString();
            
            if (i == "")
            {
                i = "AP00000";
            }
            int j = Convert.ToInt16(i.Substring(2,5));
            int k = j + 1;
            string m =k.ToString();

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
                m =  m;
            }
                

            mNewCode = "AP" + m.ToString();
            AppontmentId = mNewCode;

            string prospectCode = txtCustCode.Text;
            string brcd = Convert.ToString(Session["currbrcd"]);
            string empcd = Convert.ToString(Session["Empcd"]);

            string sql = "Insert Into Webx_Appointment (AppointmentCode,ProspectCode,EntryDt,AppointmentDt,AppTime,PersonToMet,ContactNo,Department,Designation,Purpose,Remarks,EntryBy) Values ('" + AppontmentId + " ','" + prospectCode  + "','" + txtEntrydate.Text + "','" + txtAppDate.Text + "','" + txtTime.Text + "','" + txtPersonMet.Text + "','" + txtContactNo.Text + "','" + txtDepartment.Text + "','" + txtDesignation.Text + "','" + txtPurposeofVisit.Text + "','" + txtRemarks.Text + "','" + empcd + "')";
            SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
            sqlcmd2.ExecuteNonQuery();
            
            conn.Close();
            Response.Redirect("AppointmentEntry_Done.aspx?AppontmentId=" + AppontmentId);
        }
    }

