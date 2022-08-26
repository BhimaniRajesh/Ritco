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


public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{
    string Fromdt = "", Todate = "";
    public string Vendorcode = "", VendorName = "", AcctHead = "", PONo = "", ManualPONo = "", Matcat = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Fromdt = Request.QueryString["Fromdt"].ToString();
        Todate = Request.QueryString["Todate"].ToString();
        Vendorcode = Request.QueryString["Vendorcode"].ToString();
        VendorName = Request.QueryString["VendorName"].ToString();
        PONo = Request.QueryString["POno"].ToString();
        ManualPONo = Request.QueryString["ManualPOno"].ToString();
        Matcat = Request.QueryString["MatCat"].ToString();
        if (Matcat.ToString().Trim() == "01")
        {
            //AcctHead = "EXP0105";
            AcctHead = "POE0001";
        }
        else if (Matcat.ToString().Trim() == "02")
        {
            //AcctHead = "EXP0004";
            AcctHead = "TEXP003";
        }
        else if (Matcat.ToString().Trim() == "03")
        {
            //AcctHead = "EXP0003";
            AcctHead = "POE0003";
        }
        else if (Matcat.ToString().Trim() == "04")
        {
            //AcctHead = "EXP0088";
            AcctHead = "POE0004";
        }
        else if (Matcat.ToString().Trim() == "05" || Matcat.ToString().Trim() == "5")
        {
            //AcctHead = "EXP0065";
            AcctHead = "";
        }
        else if (Matcat.ToString().Trim() == "06" || Matcat.ToString().Trim() == "6")
        {
            AcctHead = "";
        }
        if (ManualPONo != "")
            Lbl_Manual_POno.Text = ManualPONo.ToString();
        if (PONo != "")
            Lbl_POno.Text = PONo.ToString();
        if (Vendorcode != "")
            Lbl_Vendor.Text = Vendorcode.ToString();
        if (Fromdt != "" && Todate != "")
            Lbl_Date.Text = Fromdt.ToString() + "-" + Todate.ToString();

        if (!IsPostBack)
        {
            DipsplayReport();
            string SQLStr = "";
            SQLStr = "SELECT CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' AND CODEID='" + Matcat.ToString().Trim() + "'";
            DataTable dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
            LblMatCat.Text = dt.Rows[0]["CodeDesc"].ToString();
        }
    }
    public void DipsplayReport()
    {
        string Sql = "EXEC usp_PO_Listing_Ver1 '" + PONo + "','" + ManualPONo + "','" + Vendorcode + "','" + Fromdt.ToString() + "','" + Todate.ToString() + "','" + Matcat + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + SessionUtilities.DefaultCompanyCode.ToString() + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);

        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_POList.DataSource = ds;
            GV_POList.DataBind();
            btn_submit.Enabled = true;
        }
        else
            btn_submit.Enabled = false;       
        
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string Docnos = "";
        foreach (GridViewRow gridrow in GV_POList.Rows)
        {
            CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
            Label LblBillno = (Label)gridrow.FindControl("LblPOno");
            if (Chk_Docno.Checked)
            {
                if (Docnos == "")
                    Docnos = LblBillno.Text.ToString().Trim();
                else
                    Docnos = Docnos + "," + LblBillno.Text.ToString().Trim();
            }
        }
        string strFinalQS = "?Fromdt=" + Fromdt;
        strFinalQS = strFinalQS + "&Todate=" + Todate;
        strFinalQS = strFinalQS + "&Vendorcode=" + Vendorcode;
        strFinalQS = strFinalQS + "&VendorName=" + VendorName;
        strFinalQS = strFinalQS + "&POno=" + Docnos;
        strFinalQS = strFinalQS + "&MatCat=" + Matcat;
        strFinalQS = strFinalQS + "&MatCatAcctHead=" + AcctHead.ToString();

        Response.Redirect("POBillEntry_Step3.aspx" + strFinalQS);

    }
}
