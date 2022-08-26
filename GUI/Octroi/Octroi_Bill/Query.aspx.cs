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

public partial class Octroi_Octroi_Bill_Default : System.Web.UI.Page
{
    string custcd, octroipaid_by;
    string custcls = "";
    int _lastEditedPage;
    MyFunctions fn = new MyFunctions();
    public DataSet1 _dataSet = new DataSet1();
    public DataSet1.WorkExperianceDataRow datarow;
    protected void Page_Load(object sender, EventArgs e)
    {
        string custcdstr = Request.QueryString.Get("Party_detail");
        string custis = Request.QueryString.Get("custis");

        string[] custcd_arr;

        custcd_arr = custcdstr.Split('-');
        custcd = custcd_arr[0].ToString();
        if (custis == "CSGN")
        {
            custcls = "and csgncd='" + custcd + "'";
            octroipaid_by = "Consignor";
        }
        if (custis == "CSGE")
        {
            custcls = "and csgecd='" + custcd + "'";
            octroipaid_by = "consignee";
        }
        if (custis == "BILL")
        {
            custcls = "and party_code='" + custcd + "'";
            octroipaid_by = "Billing Party";
        }
        Label1.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);
        LblPTMSCD.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);
        txtbillsubloc.Text = Session["brcd"].ToString();
        txtbillcolloc.Text = Session["brcd"].ToString();

        if (!IsPostBack)
        {
            BindGrid();
        }
        else
        {
            ReverseBind();
        }
    }

    private void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.WorkExperianceData;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet1)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }
   
    private void ReverseBind()
    {
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            datarow = _dataSet.WorkExperianceData[gridrow.DataSetIndex];

            data
