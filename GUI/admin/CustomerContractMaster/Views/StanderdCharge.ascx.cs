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

public partial class StanderdCharge : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["SC_ContractID"] != null) ? ViewState["SC_ContractID"].ToString() : ""; } set { ViewState["SC_ContractID"] = value; } }
    public string CustCode { get { return (ViewState["SC_CustCode"] != null) ? ViewState["SC_CustCode"].ToString() : ""; } set { ViewState["SC_CustCode"] = value; } }
    public string BaseCode { get { return (ViewState["SC_BaseCode"] != null) ? ViewState["SC_BaseCode"].ToString() : ""; } set { ViewState["SC_BaseCode"] = value; } }
    public string BasedOn { get { return (ViewState["SC_BasedOn"] != null) ? ViewState["SC_BasedOn"].ToString() : ""; } set { ViewState["SC_BasedOn"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack & !Page.IsCallback)
        {
            //BasedOn = DocketRules.GetDefaultValue("CHRG_RULE");
            //if (BasedOn.CompareTo("NONE") == 0)
            //    BaseCode = BasedOn;

            BindBookingTimeData();
            BindDelivaryTimeData();
            ucChgMatrix.Visible = false;
        }
    }

    private void BindBookingTimeData()
    {
        DataTable dt = getData(true).Tables[0];
        if (dt.Rows.Count <= 0)
        {
            dt = new DataTable();
            dt.Columns.Add("ChargeCode");
            dt.Columns.Add("ChargeName");
            dt.Columns.Add("VaryByLoc");
            dt.Rows.Add("", "", "");
        }
        gvBkgResult.DataSource = dt;
        gvBkgResult.DataBind();
    }
    private void BindDelivaryTimeData()
    {
        DataTable dt = getData(false).Tables[0];
        if (dt.Rows.Count <= 0)
        {
            dt = new DataTable();
            dt.Columns.Add("ChargeCode");
            dt.Columns.Add("ChargeName");
            dt.Columns.Add("VaryByLoc");
            dt.Rows.Add("", "&nbsp;", "");
        }
        gvDelResult.DataSource = dt;
        gvDelResult.DataBind();
    }
    private DataSet getData(bool IsBookingTime)
    {        
        string strQ = "SELECT ChargeCode,ChargeName=(ChargeName +' ('+operator+')'),VaryByLoc  FROM webx_master_charge ";
        strQ += "WHERE chargetype='DKT' AND basedon='" + BasedOn + "' AND basecode='" + BaseCode + "' AND activeflag='Y'";
        if (IsBookingTime)
            strQ += " AND booktimeflag='Y' ";
        else
            strQ += " AND DELTIMEFLAG='Y' ";

        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
    }
    private string GetChargeAmt(string chrgCode)
    {
        string strRet = "0.00";
        string strQ = "select top 1 " + chrgCode + " From webx_custcontract_charges where contractid='" + ContractID + "' and basedon1='" + BasedOn + "'  and basecode1='" + BaseCode + "' and  basedon2='NONE' and  basecode2='NONE'";
        if (chrgCode != "")
        {
            object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strQ);
            if (obj != null)
            {
                strRet = Convert.ToString(obj);
            }
        }
        else
            strRet = "";
        return strRet;
    }
    protected void gvBkgResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {            
            DataRow dr = ((DataRowView) e.Row.DataItem).Row as DataRow;
            Label lblChgName = e.Row.FindControl("lblChgName") as Label;
            Label lblChgAMT = e.Row.FindControl("lblChgAMT") as Label;
            HiddenField lblChgCode = e.Row.FindControl("lblChgCode") as HiddenField;
            LinkButton btnChgMatrix = e.Row.FindControl("btnChgMatrix") as LinkButton;

            lblChgName.Text = dr["ChargeName"].ToString();
            lblChgCode.Value = dr["ChargeCode"].ToString();
            lblChgAMT.Text = GetChargeAmt(dr["ChargeCode"].ToString());
            if (dr["VaryByLoc"].ToString().ToUpper() == "Y")
            {
                lblChgAMT.Visible = false;
                btnChgMatrix.Visible = true;
            }
            else
            {
                lblChgAMT.Visible = true;
                btnChgMatrix.Visible = false;
            }

        }
    }
    protected void gvDelResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow dr = ((DataRowView)e.Row.DataItem).Row as DataRow;
            Label lblChgName = e.Row.FindControl("lblChgName") as Label;
            Label lblChgAMT = e.Row.FindControl("lblChgAMT") as Label;
            HiddenField lblChgCode = e.Row.FindControl("lblChgCode") as HiddenField;
            LinkButton btnChgMatrix = e.Row.FindControl("btnChgMatrix") as LinkButton;

            lblChgName.Text = dr["ChargeName"].ToString();
            lblChgCode.Value = dr["ChargeCode"].ToString();
            lblChgAMT.Text = GetChargeAmt(dr["ChargeCode"].ToString()); 
            if (dr["VaryByLoc"].ToString().ToUpper() == "Y")
            {
                lblChgAMT.Visible = false;
                btnChgMatrix.Visible = true;
            }
            else
            {
                lblChgAMT.Visible = true;
                btnChgMatrix.Visible = false;
            }
        }
    }
    protected void btnBkgMaxtrix_Click(object sender, EventArgs e)
    {
        GridViewRow gvr = ((LinkButton)sender).Parent.Parent as GridViewRow;
        HiddenField lblChgCode = gvr.FindControl("lblChgCode") as HiddenField;
        Label lblChgName = gvr.FindControl("lblChgName") as Label;

        ucChgMatrix.Visible = true;
        ucChgMatrix.ContractID = ContractID;
        ucChgMatrix.CustCode = CustCode;
        ucChgMatrix.BasedOn1 = BasedOn;
        ucChgMatrix.BaseCode1 = BaseCode;
        ucChgMatrix.ChargeCode = lblChgCode.Value;
        ucChgMatrix.ChargeName = lblChgName.Text;
        ucChgMatrix.ChargeType = "BKG";
        ucChgMatrix.BasedOn2 = "NONE";
        ucChgMatrix.BaseCode2 = "NONE";
        ucChgMatrix.TransType = "1234";
        ucChgMatrix.LocReg = "CLR";
        ucChgMatrix.FromLoc = "";
        ucChgMatrix.ToLoc = "";
        ucChgMatrix.DataViewBind();
    }
    protected void btnDelMaxtrix_Click(object sender, EventArgs e)
    {
        GridViewRow gvr = ((LinkButton)sender).Parent.Parent as GridViewRow;
        HiddenField lblChgCode = gvr.FindControl("lblChgCode") as HiddenField;
        Label lblChgName = gvr.FindControl("lblChgName") as Label;

        ucChgMatrix.Visible = true;
        ucChgMatrix.ContractID = ContractID;
        ucChgMatrix.CustCode = CustCode;
        ucChgMatrix.BasedOn1 = BasedOn;
        ucChgMatrix.BaseCode1 = BaseCode;
        ucChgMatrix.ChargeCode = lblChgCode.Value;
        ucChgMatrix.ChargeName = lblChgName.Text;
        ucChgMatrix.ChargeType = "DEL";
        ucChgMatrix.BasedOn2 = "NONE";
        ucChgMatrix.BaseCode2 = "NONE";
        ucChgMatrix.TransType = "1234";
        ucChgMatrix.LocReg = "CLR";
        ucChgMatrix.FromLoc = "";
        ucChgMatrix.ToLoc = "";
        ucChgMatrix.DataViewBind();       
    }
    
    public void ReBind()
    {
        BindBookingTimeData();
        BindDelivaryTimeData();
    }
}
