using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_MIS_CPKM_Report_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDropDown("USP_Get_All_CPKMVendorList", "VENDORNAME", "VENDORCODE", ddlVendor);
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

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            string final;
            final = "Result.aspx?VendorCode=" + ddlVendor.SelectedValue;
            final += "&VoucherNo=" + txtVoucherNo.Text.Trim();
            final += "&BillNo=" + txtBillNo.Text.Trim();
            final += "&BillStatus=" + ddlBillStatus.SelectedValue;
            final += "&FromDate=" + DT.DateFrom.ToString("dd MMM yyyy");
            final += "&ToDate=" + DT.DateTo.ToString("dd MMM yyyy");
            Page.RegisterStartupScript("MIS for CPKM Report", @"<script language='JavaScript' type='text/javascript'>window.open('" + final + "', '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=950 ,height=600,status=no,left=60,top=50');</script>");
        }
        catch (Exception ex)
        {

        }
    }
}           