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

public partial class GUI_admin_CustomerContractMaster_DeliveryPointCharges : System.Web.UI.Page
{
    private string _ContractID = "";
    private string _CustCode = "";
    private string _BasedOn1 = "", _BaseCode1 = "";
    private string _BasedOn2 = "", _BaseCode2 = "";
    private string _ChargeCode = "", _ChargeType = "", _ChargeName = "";
    private string _LocReg = "", _TransType = "";

    private DataTable dtViews
    {
        get { return (ViewState["dtViews"] != null) ? ViewState["dtViews"] as DataTable : new DataTable(); }
        set { ViewState["dtViews"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        _ContractID = Request.QueryString["ContractID"].ToString();
        _CustCode = Request.QueryString["CustCode"].ToString();
        if (Request.QueryString["BasedOn1"] != null)
            _BasedOn1 = Request.QueryString["BasedOn1"].ToString();
        if (Request.QueryString["BaseCode1"] != null)
            _BaseCode1 = Request.QueryString["BaseCode1"].ToString();
        if (Request.QueryString["BasedOn2"] != null)
            _BasedOn2 = Request.QueryString["BasedOn2"].ToString();
        if (Request.QueryString["BaseCode2"] != null)
            _BaseCode2 = Request.QueryString["BaseCode2"].ToString();
        if (Request.QueryString["ChargeCode"] != null)
            _ChargeCode = Request.QueryString["ChargeCode"].ToString();
        if (Request.QueryString["ChargeName"] != null)
            _ChargeName = Request.QueryString["ChargeName"].ToString();
        if (Request.QueryString["ChargeType"] != null)
            _ChargeType = Request.QueryString["ChargeType"].ToString();
        if (Request.QueryString["LocReg"] != null)
            _LocReg = Request.QueryString["LocReg"].ToString();
        if (Request.QueryString["TransType"] != null)
            _TransType = Request.QueryString["TransType"].ToString();

        if (!IsPostBack && !IsCallback)
        {
            cstheader.ContractID = _ContractID;
            cstheader.CustCode = _CustCode;

            lblchargename.Text = _ChargeName;
            GenerateViewTable();
            GenerateTabs(dtViews);
            menuTabs.Items[0].Selected = true;
            AddView(menuTabs.SelectedItem);
        }
    }
    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        AddView(e.Item);
    }
    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }
    protected void reptMatrix_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;
            //Label lblMatrixType = e.Item.FindControl("lblMatrixType") as Label;
            //GridView grvcharges = e.Item.FindControl("grvcharges") as GridView;

            //lblMatrixType.Text = dr["CodeDesc"].ToString();

            //grvcharges.DataSource = GetChageMatrix(dr["CodeID"].ToString());
            //grvcharges.DataBind();
        }
    }
    protected void grvcharges_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView grvcharges = sender as GridView;
        grvcharges.PageIndex = e.NewPageIndex;
        grvcharges.DataSource = GetChageMatrix(menuTabs.SelectedValue);
        grvcharges.DataBind();
    }

    private DataSet GetChageMatrix(string matrixType)
    {
        string strQ = "SELECT custcode,contractid,chargename,ChargeTypeDesc,fromLocName,toLocName,loc_reg_desc,trans_type_desc," +
                      "RateTypeDesc,minrate,maxrate,rate,basedon1_desc,basedon2,basecode1_desc,basecode2 " +
                      "FROM vw_custcontract_othercharges WHERE (1=1) ";

        if (_ContractID.Trim() != "")
            strQ += "AND ContractID='" + _ContractID + "'";
        if (_CustCode.Trim() != "")
            strQ += "AND CustCode='" + _CustCode + "'";
        if (_ChargeCode.Trim() != "")
            strQ += "AND ChargeCode='" + _ChargeCode + "'";
        if (_ChargeType.Trim() != "")
            strQ += "AND ChargeType='" + _ChargeType + "'";
        if (_BasedOn1.Trim() != "")
            strQ += "AND BasedOn1='" + _BasedOn1 + "'";
        if (_BaseCode1.Trim() != "")
            strQ += "AND BaseCode1='" + _BaseCode1 + "'";
        if (_BasedOn2.Trim() != "")
            strQ += "AND BasedOn2='" + _BasedOn2 + "'";
        if (_ContractID.Trim() != "")
            strQ += "AND BaseCode2='" + _BaseCode2 + "'";
        if (_ContractID.Trim() != "")
            strQ += "AND Loc_Reg='" + matrixType + "'";

        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
    }

    private void GenerateViewTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("CodeID");
        dt.Columns.Add("CodeDesc");
        switch (_LocReg)
        {
            case "C":
                dt.Rows.Add("C", "City - City");
                break;
            case "L":
                dt.Rows.Add("L", "Location - Location");
                break;
            case "R":
                dt.Rows.Add("R", "Region - Region");
                break;
            default:
                dt.Rows.Add("C", "City - City");
                dt.Rows.Add("L", "Location - Location");
                dt.Rows.Add("R", "Region - Region");
                break;
        }
        dtViews = dt;
    }
    private void GenerateTabs(DataTable dt)
    {
        menuTabs.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            MenuItem mi = new MenuItem(dr["CodeDesc"].ToString(), dr["CodeID"].ToString());
            menuTabs.Items.Add(mi);
        }
    }
    private void AddView(MenuItem mi)
    {
        View v = multiTabs.Views[0];
        GridView grvcharges = v.FindControl("grvcharges") as GridView;
        grvcharges.DataSource = GetChageMatrix(mi.Value);
        grvcharges.DataBind();
    }
}
