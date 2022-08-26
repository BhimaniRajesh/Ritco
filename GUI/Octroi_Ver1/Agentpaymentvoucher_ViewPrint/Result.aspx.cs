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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms; 
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;
   

public partial class GUI_UNI_Net_MIS_WorkDone_Testing_Result : System.Web.UI.Page
{
    public string fromdt = "", todt = "", PartyCode = "", PartyNM = "", BillNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            fromdt = Request.QueryString["fromdt"].ToString();
            todt = Request.QueryString["todt"].ToString();
            PartyCode = Request.QueryString["PartyCode"].ToString();
            PartyNM = Request.QueryString["PartyNM"].ToString();            
            BillNo = Request.QueryString["BillNo"].ToString();

            if (BillNo == null)
                BillNo = "";

            lbldaterange.Text = fromdt.ToString() + " - "  +  todt.ToString();
            if (PartyCode == "")
            {
                lblCustCode.Text = "NA";
            }
            else
            {
                lblCustCode.Text = PartyCode.ToString() + " - " + PartyNM.ToString();
            }
            if (BillNo == "")
            {
                lblBillNo.Text = "NA";
            }
            else
            {
                lblBillNo.Text = BillNo.ToString();
            }

            BindTheData(); 
        }
    }

    protected void xls(object sender, EventArgs e)
    {
        tblxls1.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string billno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkbilldetail")).Text;
        string sql = "exec Usp_OctroiBill_AnnexureView '" + billno + "'";
        DataTable dtxls = new DataTable();
        dtxls = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];        
        //SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        //DataSet dsxls1 = new DataSet();
        //da.Fill(dsxls1, "xls1");
        //GrdXLS1.DataSource = dsxls1.Tables["xls1"];
        GrdXLS1.DataSource = dtxls; 
        GrdXLS1.DataBind();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Bill.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls1);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();
    }

    public void BindTheData()
    {
        DataTable dt = new DataTable();
        string str = "exec USP_AgentPaymentVoucher_ReViewPrint_Data '" + fromdt.ToString() + "','" + todt.ToString() + "','" + PartyCode.ToString() + "','" + BillNo.ToString() + "'";
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
        GrdLoadUnload.DataSource = dt;
        GrdLoadUnload.DataBind();       
    }
}
