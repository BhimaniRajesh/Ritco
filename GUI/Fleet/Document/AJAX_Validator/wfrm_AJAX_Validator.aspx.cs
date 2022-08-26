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

public partial class Outbound_Delivery_Challan_AJAX_Validator_wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidDocType") Response.Write(CheckValidDocType());
        if (Request.QueryString["Function"] == "CheckValidVehNo") { Response.Write(CheckValidVehNo()); }
        if (Request.QueryString["Function"] == "CheckStartDate") { Response.Write(CheckStartDate()); }
        if (Request.QueryString["Function"] == "CheckDocNo") { Response.Write(CheckDocNo()); }
    }
    private string CheckValidDocType()
    {
        cls_DocumentType doc_type = new cls_DocumentType(str_Connection_String);
        doc_type.DOCU_TYPE = Request.QueryString["DocType"].ToString();
        doc_type.DOCU_TYPE_ID = Request.QueryString["DodId"].ToString();  
        doc_type.CheckValidDocumentType();
        if (doc_type.IsRecordFound)
            return "Y~";
        else
            return "N" + doc_type.DOCU_TYPE + "~"; 
    }
    private string CheckValidVehNo()
    {
        cls_DocumentEntry docEntry = new cls_DocumentEntry(str_Connection_String);
        docEntry.CheckValidVehNoRotate(Request.QueryString["VehNo"].ToString());
        if (docEntry.IsRecordFound == true)
        {
            return "Y~" + docEntry.VehNo + "~" + docEntry.VEH_INTERNAL_NO + "~" + docEntry.CURRENT_KM_READ + "~" + docEntry.VehType + "~"; 
        }
        else
        {
            return "N~";
        }
    }
    private string CheckStartDate()
    {
        cls_DocumentEntry doc_entry = new cls_DocumentEntry(str_Connection_String);
        doc_entry.DOCU_ID = Request.QueryString["DocId"].ToString().Trim();
        doc_entry.DOCU_DET_ID = Request.QueryString["DocDetId"].ToString().Trim();
        doc_entry.CheckStartDate();
        if (doc_entry.IsRecordFound)
            return "Y~" + doc_entry.EXPRITY_DT + "~";
        else
            return "N~";
    }
    private string CheckDocNo()
    {
        cls_DocumentEntry doc_entry = new cls_DocumentEntry(str_Connection_String);
        doc_entry.DOCU_NO = Request.QueryString["DocNo"].ToString().Trim();
        doc_entry.VEH_INTERNAL_NO = Request.QueryString["VehNo"].ToString().Trim();
        doc_entry.DOCU_ID = Request.QueryString["DocId"].ToString().Trim();
        doc_entry.DOCU_TYPE = Request.QueryString["DocumentType"].ToString().Trim();
        doc_entry.DOCU_DET_ID = Request.QueryString["DocDetId"].ToString().Trim();
        doc_entry.CheckDocNo();
        if (doc_entry.IsRecordFound)
            return "Y~";
        else
            return "N~";
    }
    
}
