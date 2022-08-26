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
using Microsoft.ApplicationBlocks.Data;

public partial class Views_LocWiseOtherCharges : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["LWOC_ContractID"] != null) ? ViewState["LWOC_ContractID"].ToString() : ""; } set { ViewState["LWOC_ContractID"] = value; } }
    public string CustCode { get { return (ViewState["LWOC_CustCode"] != null) ? ViewState["LWOC_CustCode"].ToString() : ""; } set { ViewState["LWOC_CustCode"] = value; } }
    public string BasedOn1 { get { return (ViewState["LWOC_BasedOn1"] != null) ? ViewState["LWOC_BasedOn1"].ToString() : ""; } set { ViewState["LWOC_BasedOn1"] = value; } }
    public string BaseCode1 { get {return (ViewState["LWOC_BaseCode1"] != null) ? ViewState["LWOC_BaseCode1"].ToString() : ""; } set { ViewState["LWOC_BaseCode1"] = value; } }
    public string BasedOn2 { get { return (ViewState["LWOC_BasedOn2"] != null) ? ViewState["LWOC_BasedOn2"].ToString() : ""; } set { ViewState["LWOC_BasedOn2"] = value; } }
    public string BaseCode2 { get { return (ViewState["LWOC_BaseCode2"] != null) ? ViewState["LWOC_BaseCode2"].ToString() : ""; } set { ViewState["LWOC_BaseCode2"] = value; } }
    public string ChargeCode { get { return (ViewState["LWOC_ChargeCode"] != null) ? ViewState["LWOC_ChargeCode"].ToString() : ""; } set { ViewState["LWOC_ChargeCode"] = value; } }
    public string ChargeType { get { return (ViewState["LWOC_ChargeType"] != null) ? ViewState["LWOC_ChargeType"].ToString() : ""; } set { ViewState["LWOC_ChargeType"] = value; } }
    public string ChargeName { get { return (ViewState["LWOC_ChargeName"] != null) ? ViewState["LWOC_ChargeName"].ToString() : ""; } set { ViewState["LWOC_ChargeName"] = value; } }
    public string LocReg { get { return (ViewState["LWOC_LocReg"] != null) ? ViewState["LWOC_LocReg"].ToString() : "CLR"; } set { ViewState["LWOC_LocReg"] = value; } }
    public string TransType { get { return (ViewState["LWOC_TransType"] != null) ? ViewState["LWOC_TransType"].ToString() : "1234"; } set { ViewState["LWOC_TransType"] = value; } }
    public string FromLoc { get { return (ViewState["LWOC_FromLoc"] != null) ? ViewState["LWOC_FromLoc"].ToString() : ""; } set { ViewState["LWOC_FromLoc"] = value; } }
    public string ToLoc { get { return (ViewState["LWOC_ToLoc"] != null) ? ViewState["LWOC_ToLoc"].ToString() : ""; } set { ViewState["LWOC_ToLoc"] = value; } }


    protected void Page_Load(object sender, EventArgs e)
    {
        ucFilter.FlagBasedOn1 = "N";
        ucFilter.FlagBasedOn2 = "N";
        //ucFilter.MatrixType = LocReg;        
        if (!IsPostBack & !Page.IsCallback)
        {
            lblchargename.Text = ChargeName;            
            ucFilter.BaseCode1 = BaseCode1;
            ucFilter.BaseCode2 = BaseCode2;
            ucFilter.MatrixType = "C";
            //ucFilter.TransMode = TransType;

            if (ChargeType == "BKG")
                lblChgTyp.Text = "Booking Time";
            else if (ChargeType == "DEL")
                lblChgTyp.Text = "Delivery Time";
            else
                lblChgTyp.Text = "";
        }
    }

    protected void grvcharges_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        LocReg = ucFilter.MatrixType;
        TransType = ucFilter.TransMode;
        FromLoc = ucFilter.From;
        ToLoc = ucFilter.To;

        lblchargename.Text = ChargeName;
        if (ChargeType == "BKG")
            lblChgTyp.Text = "Booking Time";
        else if (ChargeType == "DEL")
            lblChgTyp.Text = "Delivery Time";
        else
            lblChgTyp.Text = "";       

        GridView grvcharges = sender as GridView;
        DataSet ds = GetChageMatrixType();
        grvcharges.PageIndex = e.NewPageIndex;        
        grvcharges.DataSource = ds;
        grvcharges.DataBind();
    }
    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }
    private DataSet GetChageMatrixType()
    {
        string strQ = "SELECT custcode,contractid,chargename,ChargeTypeDesc,fromLocName,toLocName,loc_reg_desc,trans_type_desc," +
                      "RateTypeDesc,minrate,maxrate,rate,basedon1_desc,basedon2,basecode1_desc,basecode2 " +
                      "FROM vw_custcontract_othercharges WHERE (1=1) ";

        if (ContractID.Trim() != "")
            strQ += " AND ContractID='" + ContractID + "'";
        if (CustCode.Trim() != "")
            strQ += " AND CustCode='" + CustCode + "'";
        if (ChargeCode.Trim() != "")
            strQ += " AND ChargeCode='" + ChargeCode + "'";
        if (ChargeType.Trim() != "")
            strQ += " AND ChargeType='" + ChargeType + "'";
        if (BasedOn1.Trim() != "")
            strQ += " AND BasedOn1='" + BasedOn1 + "'";
        if (BaseCode1.Trim() != "")
            strQ += " AND BaseCode1='" + BaseCode1 + "'";
        if (BasedOn2.Trim() != "")
            strQ += " AND BasedOn2='" + BasedOn2 + "'";
        if (BaseCode2.Trim() != "")
            strQ += " AND BaseCode2='" + BaseCode2 + "'";
        if (LocReg.Trim() != "")
            strQ += " AND  PATINDEX ('%' + Loc_Reg + '%','" + LocReg + "')>0 ";
        if (FromLoc.Trim() != "")
            strQ += " AND FromLoc LIKE '" + FromLoc + "%'";
        if (ToLoc.Trim() != "")
            strQ += " AND ToLoc LIKE '" + ToLoc + "%'";
        if (TransType != "")
            strQ += " AND PATINDEX ('%' + trans_type + '%','" + TransType + "')>0";

        strQ += " ORDER BY ChargeTypeDesc,fromLocName,toLocName";

        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
    }

    public void DataViewBind()
    {
        lblchargename.Text = ChargeName;       
        if (ChargeType == "BKG")
            lblChgTyp.Text = "Booking Time";
        else if (ChargeType == "DEL")
            lblChgTyp.Text = "Delivery Time";
        else
            lblChgTyp.Text = "";
        DataSet ds = GetChageMatrixType();
        grvcharges.PageIndex = 0;
        grvcharges.DataSource = ds;
        grvcharges.DataBind();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        LocReg = ucFilter.MatrixType;
        TransType = ucFilter.TransMode;
        FromLoc = ucFilter.From;
        ToLoc = ucFilter.To;        
        DataViewBind();
    }    
}
