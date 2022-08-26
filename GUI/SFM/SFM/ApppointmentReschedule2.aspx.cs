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

public partial class SFM_ApppointmentReschedule2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string ProspectCode, flag, appointmentCode;
    public static string prcd;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            ProspectCode = Request.QueryString["ProspectCode"].ToString();
            txtEntrydate.Text = System.DateTime.Today.ToString("dd MMM yyyy");
            txtEntrydate.ReadOnly = true;
            txtEntryDt2.Text = System.DateTime.Today.ToString("dd MMM yyyy");
            txtEntryDt2.ReadOnly = true;

            BindGrid();

            //string conName = txtReshceduleDt.ClientID;
            //scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
            //txtReshceduleDt.Attributes.Add("onclick", scriptStr);


            btnsubmit1.Attributes.Add("onclick", "javascript:return check(" + txtReshceduleDt.ClientID + "," + txtTime.ClientID + ")");
        
        }
        
    }

    private void BindGrid()
    {
        conn.Open();
        string sql = "select a.AppointmentCode as AppointmentCode,p.ProspectCode,(select companyname from webx_ProspectCustomer where ProspectCode=a.ProspectCode) as Company,(select CodeDesc from Webx_Master_General where CodeType='IND' and CodeId = p.industrycode) as Industry,(select compCity from  webx_ProspectCustomer where ProspectCode=a.ProspectCode) as City,(select Name from WebX_Master_Users where UserID=p.entryby) as SalesManager,Convert(varchar,a.AppointmentDt,106) as AppointmentDt,a.Purpose,a.Remarks,a.AppTime from webx_ProspectCustomer p,Webx_Appointment a where p.ProspectCode = '" + ProspectCode + "' and p.ProspectCode=a.ProspectCode and (a.flag is NULL or a.flag = 'R')";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataAdapter da2 = new SqlDataAdapter(sqlcmd);
        DataSet ds2 = new DataSet();
       
        da2.Fill(ds2);
         foreach (DataRow dr in ds2.Tables[0].Rows)
                {
                   prcd = dr["ProspectCode"].ToString();
                }
        DataView dv2 = ds2.Tables[0].DefaultView;

        GridAppointment.DataSource = dv2;
        GridAppointment.DataBind();

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridAppointment.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in GridAppointment.Rows)
        {
            //HtmlInputRadioButton rd1 = (HtmlInputRadioButton)gridrow.FindControl("Radio1");
            RadioButton rd1 = (RadioButton)gridrow.FindControl("Radio1");
            if (rd1.Checked == true)
            {
                Label lblAppCode = (Label)gridrow.FindControl("lblAppointmentCode");
                Label lblProspect = (Label)gridrow.FindControl("lblProspectId");
                txtAppointment.Text = lblAppCode.Text;
                txtCustCode.Text = lblProspect.Text;
                appointmentCode = txtAppointment.Text;
            }
            
           
        }
        RadioButton2.Checked = false;
        RadioButton1.Checked = true;

        //txtCustCode.Text = prcd;
       
        p1.Visible = true;
        p2.Visible = false;
    }

    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in GridAppointment.Rows)
        {
            RadioButton rd1 = (RadioButton)gridrow.FindControl("Radio1");
            if (rd1.Checked == true)
            {
                Label lblAppCode = (Label)gridrow.FindControl("lblAppointmentCode");
                Label lblProspect = (Label)gridrow.FindControl("lblProspectId");
                txtAppointmentCode2.Text = lblAppCode.Text;
                TextBox1.Text = lblProspect.Text;
                appointmentCode = txtAppointmentCode2.Text;
            }


        }
        RadioButton1.Checked = false;
        RadioButton2.Checked = true;

        //TextBox1.Text = prcd;
        p1.Visible = false;
        p2.Visible = true;

    }
    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        flag = "R";
        appointmentCode = txtAppointment.Text;
        
        //DateTime rescheduledate = Convert.ToDateTime();
        
        MyFunctions fn = new MyFunctions();
        string rescheduledate = fn.Mydate(txtReshceduleDt.Text);


        conn.Open();
        string sql = "Update Webx_Appointment set AppointmentDt = '" + rescheduledate + "',AppTime = '" + txtTime.Text + "',flag = '" + flag + "' where AppointmentCode = '" + appointmentCode + "' and ProspectCode='" + txtCustCode.Text + "'";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.ExecuteNonQuery();

        string sqlUpdate = "Update webx_ProspectCustomer set flag='Y' where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd3 = new SqlCommand(sqlUpdate, conn);
        sqlcmd3.ExecuteNonQuery();


        
        string final = "?Prospect1=" + txtCustCode.Text;
        //final += "&flag=" + flag;
        Response.Redirect("ApppointmentRescheduleDone.aspx" + final);

        conn.Close();
    }
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        flag = "C";
        appointmentCode = txtAppointmentCode2.Text;

        conn.Open();
        string reason = txtReason.Text;
        string sql1 = "Update Webx_Appointment set flag = '" + flag + "',Reason = '" + reason + "' where AppointmentCode = '" + appointmentCode + "' and ProspectCode='" + TextBox1.Text + "'";
        SqlCommand sqlcmd2 = new SqlCommand(sql1, conn);
        sqlcmd2.ExecuteNonQuery();



        string sqlUpdate = "Update webx_ProspectCustomer set Cflag='Y' where ProspectCode='" + TextBox1.Text + "'";
        SqlCommand sqlcmd3 = new SqlCommand(sqlUpdate, conn);
        sqlcmd3.ExecuteNonQuery();

        string final1 = "?Prospect2=" + TextBox1.Text;
        
        Response.Redirect("ApppointmentRescheduleDone.aspx" + final1);

        conn.Close();
    }
    
}
