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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;


public partial class GUI_Fleet_Reports_Vehical_Expnse_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

        if (!IsPostBack)
        {


            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 21/5/2014
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            BindDropDown("usp_master_location", "locname", "loccode", ddlBranch);
            BindDropDown1("USP_Master_Vehicle_Model", "type_name", "Type_Code", ddlvehmodel);
        }
    }



    public void BindDropDown(string strProc, string text, string value, DropDownList d)
   {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string STR = strProc;
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (text == "locname")
        {
            cmd.Parameters.Add("@loccode", SqlDbType.VarChar, 15).Value = d.SelectedValue;
        }
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                //d.Items.Add(new ListItem(Convert.ToString(dr[dr.GetOrdinal(text)])));
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
                //d.Items.Add(new ListItem(Convert.ToString(dr[value])));
           
            }
        }
        dr.Close();
        conn.Close();
    }

    public void BindDropDown1(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string STR = strProc;
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (text == "type_name")
        {
            cmd.Parameters.Add("@Type_Code", SqlDbType.VarChar, 15).Value = d.SelectedValue;
        }
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                //d.Items.Add(new ListItem(Convert.ToString(dr[dr.GetOrdinal(text)])));
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
                //d.Items.Add(new ListItem(Convert.ToString(dr[value])));

            }
        }
        dr.Close();
        conn.Close();
    }


    //protected void btnShow_Click(object sender, System.EventArgs e)
    //{


    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    cls_Vehicle_Expense_Summary.strCompany = company.SelectedValue.ToString().Trim();
    //    cls_Vehicle_Expense_Summary.strStart_Dt = txtDateFrom.Text.ToString().Trim();
    //    cls_Vehicle_Expense_Summary.strEnd_Dt = txtDateTo.Text.ToString().Trim();
    //    cls_Vehicle_Expense_Summary.strLoccode = ddlBranch.SelectedItem.Text.ToString().Trim();
    //    cls_Vehicle_Expense_Summary.strVeh_Model = ddlvehmodel.SelectedItem.Text.ToString().Trim();
    //    cls_Vehicle_Expense_Summary.strVehicleNo = txtVehicleNo.Text.ToString().Trim();
        
        //Response.Redirect("Vehical_Expnse_Summary_Result.aspx");

        //ReportViewer1.Visible = true;
        //string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

        //if (userAgent.Contains("MSIE 7.0"))
        //{
        //    // ReportViewer1.Style.Add("margin-bottom", "26px");
        //    ReportViewer1.Attributes.Add("style", "overflow:auto;");
        //}


        //ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        //ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ////ReportViewer1.ServerReport.ReportServerUrl = "http://123.108.47.235/Reportserver";
        //ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "Vehicle_Expense_Summary";
        //ReportParameter[] parameters = new ReportParameter[4];
        //parameters[0] = new ReportParameter("Start_dt", txtDateFrom.Text.ToString().Trim());
        //parameters[1] = new ReportParameter("End_dt", txtDateTo.Text.ToString().Trim());
        //parameters[2] = new ReportParameter("loccode", ddlBranch.SelectedValue);
        //parameters[3] = new ReportParameter("VehicleNo", txtVehicleNo.Text.ToString().Trim());
        
        //ReportViewer1.ServerReport.SetParameters(parameters);
        //ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();



    //}
}