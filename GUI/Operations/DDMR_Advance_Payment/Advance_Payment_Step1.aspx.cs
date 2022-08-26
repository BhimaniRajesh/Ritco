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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSelection : System.Web.UI.Page
{
    public string DOCNO_Str = "", Vendorcode = "", VendorName = "", ManualNo_Str = "", Fromdate = "", Todate = "", RouteMode = "", Trn_Typ = "", Trn_Typ_Desc = "", Trn_Doc = "", Trn_CalledAs = "", Trn_Doc_Typ = "";
    string ContractType = "", ContractTypeDesc = "", ContractID = "", ContractSubType = "", FTLTYPE = "", VEHNO = "", ContractSubType_Value="";
    SqlCommand cmd;
    SqlDataAdapter sqlDA;
    DataSet ds;
    MyFunctions fn = new MyFunctions();
    SqlConnection conn; 
    protected void Page_Load(object sender, EventArgs e)
    {
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            Fromdate = Request.QueryString["Fromdate"];
            Vendorcode = Request.QueryString["Vendorcode"];
            VendorName = Request.QueryString["VendorName"];
            Todate = Request.QueryString["Todate"];
            DOCNO_Str = Convert.ToString(Request.QueryString["DOCNO_Str"]);
            ManualNo_Str = Convert.ToString(Request.QueryString["ManualNo_Str"]);
            Trn_Typ = Convert.ToString(Request.QueryString["Trn_Typ"]);
            LBL_Select.Text = "Select DDMR for prepare Payment";

            if (Vendorcode == "")
            {
                Lbl_Vendor.Text = "-";
            }
            else
            {
                Lbl_Vendor.Text = Vendorcode + "~" + VendorName;
            }
            if (DOCNO_Str != "")
            {
                Lbl_Docno.Text = DOCNO_Str;
            }
            if (ManualNo_Str != "")
            {
                Lbl_Manual_Docno.Text = ManualNo_Str;
            }

        if (!IsPostBack)
        {
            lblDocDate.Text = Fromdate + " - " + Todate;

            lblDocType.Text = "DDMR";
            lblAdvanceBalance.Text = "DDMR Advance Vendor Payment";
            BindGrid();
            //ButSubmit.Attributes.Add("onclick", "return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        }
    }
    public void BindGrid()
    {
        DataTable dtDDMRList = new DataTable();

        string SQLStr = "EXEC WEBX_DDMR_Payment_Listing '" + Trn_Typ + "','" + Fromdate + "','" + Todate + "','" + Vendorcode + "','" + DOCNO_Str + "','" + ManualNo_Str + "','" + SessionUtilities.CurrentBranchCode + "'";

        dtDDMRList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GridDocList.DataSource = dtDDMRList;
        GridDocList.DataBind();
    }
    protected void ButSubmit_Click(object sender, EventArgs e)
    {
        string Docnos = "";
        foreach (GridViewRow gridrow in GridDocList.Rows)
        {
            CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
            HiddenField Hnd_docno = (HiddenField)gridrow.FindControl("Hnd_docno");
            if (Chk_Docno.Checked)
            {
                if (Docnos == "")
                {
                    Docnos = Hnd_docno.Value.ToString().Trim();
                }
                else
                {
                    Docnos = Docnos + "," + Hnd_docno.Value.ToString().Trim();
                }
            }
        }

        string QString = "";
        QString = "Fromdate=" + Fromdate;
        QString += "&Todate=" + Todate;
        QString += "&VendorName=" + VendorName;
        QString += "&Vendorcode=" + Vendorcode;
        QString += "&Docnos=" + Docnos;
        QString += "&ManualNo_Str=" + ManualNo_Str;
        QString += "&Trn_Typ=" + Trn_Typ;
        Response.Redirect("Advance_Advance_Step2.aspx?" + QString);
    }
}
