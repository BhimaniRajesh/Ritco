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

public partial class GUI_UNI_MIS_Route_summary_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sqlstr = "select  rutcd,rutnm + ' : ' + rutcd  from webx_rutmas with(NOLOCK)  where activeflag='Y' order by rutnm";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            DLL_ACC.Items.Clear();
            DLL_ACC.Items.Add(new ListItem("------------Select One------------", "All"));
            SqlDataReader dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DLL_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();

            string sqlstr1 = "select  vehno  from webx_Vehicle_hdr with(NOLOCK) where isnull(activeflag,'N')='Y'  order by Vehno ";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
            DLLVehicle.Items.Clear();
            DLLVehicle.Items.Add(new ListItem("---------All---------", "All"));
            SqlDataReader dread1 = cmd1.ExecuteReader();
            {

                while (dread1.Read())
                {
                    DLLVehicle.Items.Add(new ListItem(dread1.GetValue(0).ToString(), dread1.GetValue(0).ToString()));
                }

            }
            dread1.Close();

            string sqlstr2 = "select distinct vendorCode,vendorCode+':'+VendorName as Vendor from webx_VENDOR_HDR order by vendorCode";
            SqlCommand cmd2 = new SqlCommand(sqlstr2, conn);
            DDLVendor.Items.Clear();
            DDLVendor.Items.Add(new ListItem("---------All---------", "All"));
            SqlDataReader dread2 = cmd2.ExecuteReader();
            {

                while (dread2.Read())
                {
                    DDLVendor.Items.Add(new ListItem(dread2.GetValue(1).ToString(), dread2.GetValue(0).ToString()));
                }

            }
            dread2.Close();

            conn.Close();
        }

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "1", Cumulative = "",VEHNO="", report_type_st = "", report_type = "";


        for (int i = 0; i < 3; i++)
        {
            if (radDate.Items[i].Selected)
            {
                report_mode = radDate.Items[i].Value.ToString();
                int ab = Convert.ToInt16(report_mode) + 1;
                report_mode = ab.ToString();
            }
        }
        for (int i = 0; i < 3; i++)
        {
            if (rpttyp.Items[i].Selected)
            {
                report_type = rpttyp.Items[i].Value.ToString();
            }
        }

       
        
        string DWN_XLS = "";
        if (rptfrt.Items[0].Selected)
        {
            DWN_XLS = "0";
        }
        else if (rptfrt.Items[1].Selected)
        {
            DWN_XLS = "1";
        }
        //else if (rptfrt.Items[2].Selected)
        //{
        //    DWN_XLS = "2";
        //}


        string fromdt = "", todt = "", PF_LOC="", Vendor = "";
        fromdt = txtDateFrom.Text.ToString();
        todt = txtDateTo.Text.ToString();

        PF_LOC = DLL_ACC.SelectedItem.ToString();

        string DateType = report_mode;
        string strrightnow, strrightnow1;

        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date" || DateType == "1")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString();
        }
        else if (DateType == "Week" || DateType == "2")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today" || DateType == "3")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
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

        Vendor = DDLVendor.SelectedValue;

        string final;
        final = "?Route=" + PF_LOC;
        final += "&Rtyp=" + report_type;
        final += "&dateFrom=" + dtFrom;
        final += "&dateTo=" + dtTo;
        //final += "&custcd=" + custcd;
        //final += "&Cumlative=" + Cumulative;
        //final += "&TYP_CD=" + TYP_CD;
        final += "&Vehno=" + VEHNO;
        //final += "&report_mode=" + report_mode;
        final += "&DWN_XLS=" + DWN_XLS;
        final += "&Vendor=" + Vendor;
        Response.Redirect("Result.aspx" + final);
    }
}
