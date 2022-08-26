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


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRN_DetailList : System.Web.UI.Page
{
    string POList = "", ReceiveDt = "" , PayLocation="";
    string VendorCode = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtChallandt.Text = DateTime.Now.ToString("dd/MM/yyyy");
        ReceiveDt = DateTime.Now.ToString("dd/MM/yyyy");
        if (!IsCallback && !IsPostBack)
        {
            progressBackgroundFilter.Visible = false;
            processMessage.Visible = false;
            POList = Request.QueryString["POList"].ToString();
            VendorCode = Request.QueryString["VendorCode"].ToString();
            lblGRNLoc.Text = SessionUtilities.CurrentBranchCode;
            PayLocation = SessionUtilities.CurrentBranchCode.ToString();
            HidSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");

            LblPONo.Text = Convert.ToString(Request.QueryString["POList"]);
            LblPODate.Text = Convert.ToString(Request.QueryString["PODate"]);
            LblVendor.Text = Convert.ToString(Request.QueryString["VendorCode"]);
            LblManualPONo.Text = Convert.ToString(Request.QueryString["ManualPO"]);
            LblPOType.Text = Convert.ToString(Request.QueryString["POType"]);
            LblPOAmount.Text = Convert.ToString(Request.QueryString["POAmount"]);
            BindData();
        }
        VendorCode = Request.QueryString["VendorCode"].ToString();
    }
    private void BindData()
    {
        DataTable dt = new DataTable();
        string Qry = "";
        Qry = "EXEC USP_GENERAL_PO_LIST_FOR_GRN_Ver1 '" + POList + "'";
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Qry).Tables[0];
        GV_Booking.DataSource = dt;
        GV_Booking.DataBind();
    }
    public string getnewcd()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "exec WebX_SP_GetNextDocumentCode_FA   '" + Session["BRCD"].ToString() + "','" + Session["finyear"].ToString() + "','GGRN'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        string cd1 = (string)sqlcmd.ExecuteScalar();
        return cd1;
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        SqlTransaction trans;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        trans = conn.BeginTransaction();

        string Xml_ReqMST = "<root><GRNMst>", Xml_ReqDET = "<root>", MSTID = "", VendCd = "", VendNm = "";
        string[] Vend_Arr = null;
        try
        {
            if (VendorCode.ToString() != "")
            {
                string Vendor = VendorCode.ToString().Replace("&", "AND").Trim();
                Vend_Arr = Vendor.Split('~');
                VendCd = Vend_Arr[1].ToString();
                VendNm = Vend_Arr[0].ToString();
            }
            else if (POList != "")
            {
                if (VendorName(POList) != "")
                {
                    string Vendor = VendorName(POList).ToString().Replace("&", "AND").Trim();
                    Vend_Arr = Vendor.Split('~');
                    VendCd = Vend_Arr[1].ToString();
                    VendNm = Vend_Arr[0].ToString();
                }
            }
            else
            {
                VendCd = "";
                VendNm = "";
            }
            Xml_ReqMST = Xml_ReqMST + "<BBRCD>" + Session["brcd"].ToString() + "</BBRCD>";
            Xml_ReqMST = Xml_ReqMST + "<CHALLANDT>" + fn.Mydate(txtChallandt.Text.ToString()) + "</CHALLANDT>";
            Xml_ReqMST = Xml_ReqMST + "<RECEIVEDT>" + fn.Mydate(txtChallandt.Text.ToString()) + "</RECEIVEDT>";
            Xml_ReqMST = Xml_ReqMST + "<REMARK>" + txtRemark.Text.ToString() + "</REMARK>";
            Xml_ReqMST = Xml_ReqMST + "<ManualGRNNO>" + txtMNGRNno.Text.ToString() + "</ManualGRNNO>";
            Xml_ReqMST = Xml_ReqMST + "<PREPAREDBY>" + Session["empcd"].ToString() + "</PREPAREDBY>";
            Xml_ReqMST = Xml_ReqMST + "<GRN_LOC>" + lblGRNLoc.Text.ToString() + "</GRN_LOC>";
            Xml_ReqMST = Xml_ReqMST + "<PAY_LOC>" + PayLocation.ToString() + "</PAY_LOC>";
            Xml_ReqMST = Xml_ReqMST + "<VENDORCD>" + VendCd + "</VENDORCD>";
            Xml_ReqMST = Xml_ReqMST + "<VENDORNM>" + VendNm + "</VENDORNM>";
            Xml_ReqMST = Xml_ReqMST + "<ENTRYBY>" + Session["empcd"].ToString() + "</ENTRYBY>";
			Xml_ReqMST = Xml_ReqMST + "<COMPANYCODE>" + SessionUtilities.DefaultCompanyCode.ToString() + "</COMPANYCODE>";
            Xml_ReqMST = Xml_ReqMST + "</GRNMst></root>";
            foreach (GridViewRow GR in GV_Booking.Rows)
            {
                CheckBox chk = (CheckBox)GR.FindControl("chksrno");
                TextBox Txt_Qty = (TextBox)GR.FindControl("txtQty");
                HiddenField Hnd_per = (HiddenField)GR.FindControl("HidQty");
                HiddenField narration = (HiddenField)GR.FindControl("HDNNarration");
				HiddenField HidPoSrno = (HiddenField)GR.FindControl("HidPoSrno");
                string[] ICode_Arr = GR.Cells[0].Text.ToString().Split('~');
                string Item1 = "", Item2 = "", Item3 = "", Item4 = "";
                if (ICode_Arr.Length == 1)
                {
                    Item1 = ICode_Arr[0].ToString();
                }
                else
                {
                    Item1 = ICode_Arr[0].ToString();
                    Item2 = ICode_Arr[1].ToString();
                    Item3 = ICode_Arr[2].ToString();
                    Item4 = ICode_Arr[3].ToString();
                }
                //if (chk.Checked == true)
                //{
                    Xml_ReqDET = Xml_ReqDET + "<GRNdet>";
                    Xml_ReqDET = Xml_ReqDET + "<POCODE>" + LblPONo.Text.ToString() + "</POCODE>";
                    Xml_ReqDET = Xml_ReqDET + "<ICODE>" + GR.Cells[0].Text.ToString() + "</ICODE>";
                    Xml_ReqDET = Xml_ReqDET + "<INAME>" + GR.Cells[1].Text.ToString() + "</INAME>";
                    Xml_ReqDET = Xml_ReqDET + "<TOTALQTY>" + GR.Cells[2].Text.ToString() + "</TOTALQTY>";
                    Xml_ReqDET = Xml_ReqDET + "<RECEQTY>" + Txt_Qty.Text.ToString() + "</RECEQTY>";
                    Xml_ReqDET = Xml_ReqDET + "<RATE>" + GR.Cells[3].Text.ToString() + "</RATE>";
                    Xml_ReqDET = Xml_ReqDET + "<TOTAL>" + LblPOAmount.Text.ToString() + "</TOTAL>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM1>" + Item1.Trim() + "</ITEM1>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM2>" + Item2.Trim() + "</ITEM2>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM3>" + Item3.Trim() + "</ITEM3>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM4>" + Item4.Trim() + "</ITEM4>";
                    Xml_ReqDET = Xml_ReqDET + "<narration>" + narration.Value + "</narration>";
					Xml_ReqDET = Xml_ReqDET + "<PoSrno>" + HidPoSrno.Value + "</PoSrno>";
                    Xml_ReqDET = Xml_ReqDET + "</GRNdet>";
                //}
            }
            Xml_ReqDET = Xml_ReqDET + "</root>";           

            string GRNNo = getnewcd();
            string Sql = "EXEC [Usp_Insert_GRN_Data_Ver1] '" + Xml_ReqMST.Replace("&", "&amp;").Replace("–", "-").Trim() + "','" + Xml_ReqDET.Replace("&", "&amp;").Replace("–", "-").Replace("'", " ").Trim() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + SessionUtilities.FinYear.ToString() + "','" + GRNNo + "'";
            SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (DR.Read())
                MSTID = DR[0].ToString();
            DR.Close();
            trans.Commit();
			//trans.Rollback();
            Response.Redirect("GRN_Done.aspx?GRNNO=" + MSTID, false);
        }
        catch (Exception ex)
        {
            trans.Rollback();
            string Err_Msg = ex.Message.ToString().Replace('\n', '_');
            Response.Redirect("../../../ErrorPage.aspx?heading=Master Generation Error&detail1=Session TimeOut Occured&detail2=" + Err_Msg + "&suggestion2=Item Group Master");
        }
    }    
    public string VendorName(string PO)
    {
        object Obj = null;
        string Qry = "SELECT Vendorname+'~'+Vendorcode FROM webx_GENERAL_POASSET_HDR WHERE POCode='" + PO + "'";
        Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Qry).ToString();
        return Obj.ToString();
    }
}


