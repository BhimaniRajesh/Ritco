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

public partial class GUI_UNI_Net_MIS_ReportCounterSummary_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {



        }
        conn.Close();

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";
        string EMP = "",REPORT="";

        //DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        //DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
        string report_mode = "";
        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        SqlConnection conn;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string brcd = Session["brcd"].ToString();
        string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        // Response.Write("<br> sqlstr : " + sqlstr);
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        int loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        string loc_level = Convert.ToString(dread.GetValue(0).ToString());
        //Response.Write("<br> sqlstr : " + loclevel);
        dread.Close();

        string minLV = "", maxLV = "";

        sqlstr = "select max(codeid),min(codeid) from webx_master_general where codetype='HRCHY' and codeid<>'1'  and  codeid>=" + loclevel + " ";
        cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            minLV = dr[1].ToString();
            maxLV = dr[0].ToString();
        }
        dr.Close();

        string Str_VAL = "", STR_LV = "";
        string MAxStr_VAL = "", MAxSTR_LV = "";

        EMP = txtEmployee.Text;
        if (EMP == "")
            EMP = "All";

        REPORT = txtreportid.Text;
        if (REPORT == "")
            REPORT = "All";


        string RptType = ddlDtType.SelectedValue.ToString();   
        string final;

        final = "?RPTType=" + RptType;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&EmpCode=" + EMP;
        final += "&ReportCode=" + REPORT;
        final += "&ReportType=" + rptmd.Text.ToString();    
        

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }

        //Response.Redirect("Result.aspx" + final);

    }
    protected void rptmd_SelectedIndexChanged(object sender, EventArgs e)
    {   
        
            

    }
}
