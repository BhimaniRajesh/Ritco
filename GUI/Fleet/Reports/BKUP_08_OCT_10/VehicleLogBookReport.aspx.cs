using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_VehicleLogBookReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            //lblPopup.Attributes.Add("onclick", "window.open('../../../Reports/popup-CUST.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");
            BindDropDown("USP_VehicleLog_Category", "CODEDESC", "CodeId", ddlcategory);
            BindDropDown("USP_VehicleLog_ProdType", "CODEDESC", "CodeId", ddlprodtype);
            BindDropDown("USP_VehicleLog_Company", "Company_Name", "Company_Code", ddlCompany);
        }
    }

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    protected void btnShow1_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

        cls_VehicleLogEntry.strTRIPSHEETNO = txtTripsheetNo.Text;
        cls_VehicleLogEntry.strCUSTOMER = "";
        cls_VehicleLogEntry.strVEHNO = "";
        cls_VehicleLogEntry.strCATEGORY = "All";
        cls_VehicleLogEntry.strPRODUCT = "All";
        cls_VehicleLogEntry.strStartDt_From = "";
        cls_VehicleLogEntry.strEndDt_To = "";
        cls_VehicleLogEntry.strCompany = "All";

        //Response.Redirect("VehicleLogBookReportResult.aspx");
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

        cls_VehicleLogEntry.strTRIPSHEETNO = "";
        cls_VehicleLogEntry.strCUSTOMER = txtCustCode.Text;
        cls_VehicleLogEntry.strVEHNO = txtVehNo.Text;
        cls_VehicleLogEntry.strCATEGORY = ddlcategory.SelectedItem.Text;
        cls_VehicleLogEntry.strPRODUCT = ddlprodtype.SelectedItem.Text;
        cls_VehicleLogEntry.strStartDt_From = txtDateFrom.Text;
        cls_VehicleLogEntry.strEndDt_To = txtDateTo.Text;
        cls_VehicleLogEntry.strCompany = ddlCompany.SelectedItem.Text;

        //Response.Redirect("VehicleLogRegisterReportResult.aspx?TripsheetNo=" + txtTripsheetNo.Text + "&Customer=" + txtCustNm.Text + "&VEHNO=" + txtVehNo.Text + "&Category=" + ddlcategory.SelectedItem.Text.ToString() + "&Product=" + ddlprodtype.SelectedItem.Text.ToString() + "&StartDt_From=" + txtDateFrom.Text + "&EndDt_To=" + txtDateTo.Text + "");

        //Response.Redirect("VehicleLogBookReportResult.aspx");
    }
}
