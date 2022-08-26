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
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;    

public partial class GUI_Octroi_Ver1_Octroi_Bill_Direct_Agent_Voucher : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "SELECT accdesc,acccode FROM webx_acctinfo WHERE accdesc like '%TDS%'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql);
        ddlTDSType.DataSource = ds;
        ddlTDSType.DataTextField = "accdesc";
        ddlTDSType.DataValueField = "acccode";
        ddlTDSType.DataBind();

        if (!IsPostBack)
        {
            string Voucherdate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbgndt.Text = Voucherdate.ToString();                 
            fn.Fill_Octroi_Vendor_Dataset();
        }
    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Branch_Code = SessionUtilities.CurrentBranchCode;
        string Branch_Name = fn.GetLocation(Branch_Code);
        string[] Vendor = txtOctAgent.Text.Split('~');

        try
        {
            string Xml_BillHeader = "<root><BillMst>";
            Xml_BillHeader = Xml_BillHeader + "<Chqno>" + +"</Chqno>";
            Xml_BillHeader = Xml_BillHeader + "<Chqdate>" + +"</Chqdate>";
            Xml_BillHeader = Xml_BillHeader + "<othChrg>" + txtOtherCharges.Text +"</othChrg>";
            Xml_BillHeader = Xml_BillHeader + "<>" + +"</>";
            Xml_BillHeader = Xml_BillHeader + "<>" + +"</>";
            
            Xml_BillHeader = Xml_BillHeader + "</BillMst></root>";

            string Xml_OctBillDetail = "<root>";
            foreach (GridViewRow drow in OctroiBillEntry1.OctroiBillEntry.Rows)
            {
                TextBox txtdockno = (TextBox)drow.FindControl("txtdockno");
                HiddenField hidStatus = (HiddenField)drow.FindControl("hidStatus");
                TextBox txtoctamt = (TextBox)drow.FindControl("txtoctamt");
                HiddenField hidgoctamt = (HiddenField)drow.FindControl("hidoctamt");
                TextBox txtrcpno = (TextBox)drow.FindControl("txtrcpno");
                HiddenField hidrcpno = (HiddenField)drow.FindControl("hidrcpno");
                TextBox txtrcpdt = (TextBox)drow.FindControl("txtrcpdt");
                HiddenField hidrcpdt = (HiddenField)drow.FindControl("hidrcpdt");
                HiddenField hidtot = (HiddenField)drow.FindControl("hidtot");

                if (txtdockno.Text != "")
                {
                    Xml_OctBillDetail = Xml_OctBillDetail + "<BillOctDet>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCBILLSF>" + "." + "</OCBILLSF>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<DOCKNO>" + txtdockno.Text.Trim() + "</DOCKNO>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCTAMT>" + hidgoctamt.Value + "</OCTAMT>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<RECPTNO>" + hidrcpno.Value + "</RECPTNO>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<RECPTDT>" + DateFunction.ConvertStringToDate(hidrcpdt.Value).ToString("MM/dd/yyyy") + "</RECPTDT>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<vendor_paidby>" + SessionUtilities.CurrentEmployeeID + "</vendor_paidby>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<vendor_paidat>" + Branch_Code.ToString() + "</vendor_paidat>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCT_DET_YN>" + hidStatus.Value + "</OCT_DET_YN>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "</BillOctDet>";
                }
            }
            Xml_OctBillDetail = Xml_OctBillDetail + "</root>";
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Direct Agent Voucher Generation Error&detail1=Direct Agent Voucher Generation Error&detail2=" + strex);
            return;
        }
    }
}
