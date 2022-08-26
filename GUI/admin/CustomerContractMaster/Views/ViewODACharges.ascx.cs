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
using System.Data.SqlClient;

public partial class GUI_admin_CustomerContractMaster_Views_ViewODACharges : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["SSC_ContractID"] != null) ? ViewState["SSC_ContractID"].ToString() : ""; } set { ViewState["SSC_ContractID"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sqlstr = "SELECT TOP 1 * FROM vw_oda_slabs WHERE contractid='" + ContractID + "'";
            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblfrom1.Text = dt.Rows[0]["odafrom1"].ToString();
                lblto1.Text = dt.Rows[0]["odato1"].ToString();
                lblfrom2.Text = dt.Rows[0]["odafrom2"].ToString();
                lblto2.Text = dt.Rows[0]["odato2"].ToString();
                lblfrom3.Text = dt.Rows[0]["odafrom3"].ToString();
                lblto3.Text = dt.Rows[0]["odato3"].ToString();
                lblfrom4.Text = dt.Rows[0]["odafrom4"].ToString();
                lblto4.Text = dt.Rows[0]["odato4"].ToString();
                lblfrom5.Text = dt.Rows[0]["odafrom5"].ToString();
                lblto5.Text = dt.Rows[0]["odato5"].ToString();
                lblfrom6.Text = dt.Rows[0]["odafrom6"].ToString();
                lblto6.Text = dt.Rows[0]["odato6"].ToString();
            }
            sqlstr = "SELECT TOP 1 * FROM vw_ODA_Distance WHERE contractid='" + ContractID + "'";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lbldistfrom1.Text = dt.Rows[0]["odadistfrom1"].ToString();
                lbldistto1.Text = dt.Rows[0]["odadistto1"].ToString();
                lbldistfrom2.Text = dt.Rows[0]["odadistfrom2"].ToString();
                lbldistto2.Text = dt.Rows[0]["odadistto2"].ToString();
                lbldistfrom3.Text = dt.Rows[0]["odadistfrom3"].ToString();
                lbldistto3.Text = dt.Rows[0]["odadistto3"].ToString();
                lbldistfrom4.Text = dt.Rows[0]["odadistfrom4"].ToString();
                lbldistto4.Text = dt.Rows[0]["odadistto4"].ToString();
                lbldistfrom5.Text = dt.Rows[0]["odadistfrom5"].ToString();
                lbldistto5.Text = dt.Rows[0]["odadistto5"].ToString();
                lbldistfrom6.Text = dt.Rows[0]["odadistfrom6"].ToString();
                lbldistto6.Text = dt.Rows[0]["odadistto6"].ToString();
            }

            sqlstr = "SELECT ess_code AS 'Distance From Delivery Location',trdays as 'Extra Transit Days',";
            sqlstr = sqlstr + "slab1 AS 'Slab 1',slab2 AS 'Slab 2',slab3 AS 'Slab 3',slab4 AS 'Slab 4',";
            sqlstr = sqlstr + "slab5 AS 'Slab 5' FROM WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE ";
            sqlstr = sqlstr + "WHERE contractid='" + ContractID + "' ORDER BY SRNO";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            grvcharges.DataSource = dt;
            grvcharges.DataBind();
        }
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
        }
    }
}
