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

public partial class SFM_ProspectReassign1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string ProspectCode, scriptStr, empcode, newempcode;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ProspectCode = Request.QueryString["ProspectCode"].ToString();
        lblProspectCode.Text = ProspectCode;


        string scr1 = @"<script>
        function update1(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtReassignProspect').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnCust.Attributes.Add("onclick", "window.open('EmployeePopup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        string conName1 = txtReassignDate.ClientID;
        scriptStr = "javascript:return popUpCalendar(this," + conName1 + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName1 + "\\')')";
        txtReassignDate.Attributes.Add("onclick", scriptStr);


        conn.Open();
        string sql = "select (select Name from WebX_Master_Users where UserId=p.entryby)as empnm,* from webx_ProspectCustomer p where p.ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        while (dr.Read())
        {
            lblSalesPerson.Text = dr["empnm"].ToString();
        }
        dr.Close();

        string sql111 = "select (select UserId from WebX_Master_Users where UserId=p.entryby)as empcd,* from webx_ProspectCustomer p where p.ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd111 = new SqlCommand(sql111, conn);
        SqlDataReader dr111;
        dr111 = sqlcmd111.ExecuteReader();
        while (dr111.Read())
        {
            empcode = dr111["empcd"].ToString();
        }
        dr111.Close();
        conn.Close();

        if (IsPostBack)
        {
            btnSubmit.Attributes.Add("onclick", "javascript:return check(" + txtReassignProspect.ClientID + "," + txtReassignDate.ClientID + ")");
        }
        
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn.Open();
        string sql11 = "Select UserId from WebX_Master_Users where UserId='" + txtReassignProspect.Text + "'";
        SqlCommand sql_cmd = new SqlCommand(sql11, conn);
        SqlDataReader dr1;
        dr1 = sql_cmd.ExecuteReader();
        while (dr1.Read())
        {
            newempcode = dr1["UserId"].ToString();
        }
        dr1.Close();

        string assignby = Session["empcd"].ToString();
        string sql = "Insert Into webx_pros_reassign (ProspectCode1,Old_Id,New_Id,Assign_By,Assign_Date) values ('" + ProspectCode + "' ,'" + empcode + "','" + txtReassignProspect.Text + "','" + assignby + "','" + txtReassignDate.Text + "')";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.ExecuteNonQuery();

        string sql1 = "Update webx_ProspectCustomer set EntryBy='" + txtReassignProspect.Text + "' where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd3 = new SqlCommand(sql1, conn);
        sqlcmd3.ExecuteNonQuery();

        string sql2 = "Update webx_CallEntry set EntryBy='" + txtReassignProspect.Text + "' where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd4 = new SqlCommand(sql2, conn);
        sqlcmd4.ExecuteNonQuery();

        string sql3 = "Update Webx_Appointment set EntryBy='" + txtReassignProspect.Text + "' where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd5 = new SqlCommand(sql3, conn);
        sqlcmd5.ExecuteNonQuery();

        string sql4 = "Update WEBX_SalesTarget set EntryBy='" + txtReassignProspect.Text + "' where ProspectId='" + ProspectCode + "'";
        SqlCommand sqlcmd6 = new SqlCommand(sql4, conn);
        sqlcmd6.ExecuteNonQuery();



        conn.Close();
        
        Response.Redirect("ProspectReassignDone.aspx");
    }
}
