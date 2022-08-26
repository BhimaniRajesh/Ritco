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

public partial class GUI_admin_CustomerContractMaster_Views_SundryChargesView : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["SSC_ContractID"] != null) ? ViewState["SSC_ContractID"].ToString() : ""; } set { ViewState["SSC_ContractID"] = value; } }
    public string SundryType { get { return (ViewState["SSC_SundryType"] != null) ? ViewState["SSC_SundryType"].ToString() : ""; } set { ViewState["SSC_SundryType"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        trslabrange.Visible = false;
        trheader.Visible = false;
        
        if (!IsPostBack)
        {
            string sqlstr = "SELECT (CASE single_slab_yn WHEN 'Y' THEN 'S' ELSE 'M' END) AS sundrytype";
            sqlstr = sqlstr + " FROM webx_custcontract_hdr WHERE contractid='" + ContractID + "'";
            SundryType = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }
    }

    protected void grvcharges_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvcharges.PageIndex = e.NewPageIndex;
        DataBinder();
    }

    private void DataBinder()
    {
        string sqlstr = "";
        trheader.Visible = true;
        if (SundryType.CompareTo("M") == 0)
        {
            trslabrange.Visible = true;
            lblheader.Text = "Freight Sundry Multiple Slab Rate Matrix";
        }
        else
        {
            trslabrange.Visible = false;
            lblheader.Text = "Freight Sundry Single Slab Rate Matrix";
        }

        if (SundryType.CompareTo("S") == 0)
        {
            sqlstr = "SELECT fromloc AS 'From',toloc AS 'To',air_rate AS 'Air Rate',air_days AS 'Air Days',road_rate AS 'Road Rate',";
            sqlstr = sqlstr + "road_days AS 'Road Days',train_rate  AS 'Train Rate',train_days AS 'Train Days',express_rate AS 'Express Rate',";
            sqlstr = sqlstr + "express_days AS 'Express Days',rate_type AS 'Rate Type',matrixtype AS 'Matrix Type' ";
            sqlstr = sqlstr + " FROM vw_ccm_sss WHERE contractid='" + ContractID + "'";
            sqlstr = sqlstr + " AND  PATINDEX ('%' + locreg + '%','" + ucfilter.MatrixType + "')>0";
            if (ucfilter.BasedOn1.CompareTo("NONE") == 0)
                sqlstr = sqlstr + " AND basedon1='NONE' AND basecode1='NONE'";
            else
                sqlstr = sqlstr + " AND basedon1='" + ucfilter.BasedOn1 + "' AND basecode1='" + ucfilter.BaseCode1 + "'";

            if (ucfilter.BasedOn2.CompareTo("NONE") == 0)
                sqlstr = sqlstr + " AND basedon2='NONE' AND basecode2='NONE'";
            else
                sqlstr = sqlstr + " AND basedon2='" + ucfilter.BasedOn2 + "' AND basecode2='" + ucfilter.BaseCode2 + "'";

            sqlstr = sqlstr + " AND fromloc LIKE '" + ucfilter.From + "%' AND toloc LIKE '" + ucfilter.To + "%'";
        }
        else
        {

            sqlstr = "SELECT (CASE matrix_type WHEN 'W' THEN 'Per KG' WHEN 'P' THEN 'Per Pkg' WHEN 'T' THEN 'Per Ton' WHEN 'F' THEN 'Flat(In Rs)' END) AS ratetype,";
            sqlstr = sqlstr + "slab_from,slab_to FROM webx_custcontract_frtmatrix_slabhdr WHERE contractid='" + ContractID + "'";
            DataTable dtrange = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            if (dtrange.Rows.Count > 0)
            {
                lblfrom1.Text = dtrange.Rows[0]["slab_from"].ToString();
                lblto1.Text = dtrange.Rows[0]["slab_to"].ToString();
                lblratetype1.Text = dtrange.Rows[0]["ratetype"].ToString();
                lblfrom2.Text = dtrange.Rows[1]["slab_from"].ToString();
                lblto2.Text = dtrange.Rows[1]["slab_to"].ToString();
                lblratetype2.Text = dtrange.Rows[1]["ratetype"].ToString();
                lblfrom3.Text = dtrange.Rows[2]["slab_from"].ToString();
                lblto3.Text = dtrange.Rows[2]["slab_to"].ToString();
                lblratetype3.Text = dtrange.Rows[2]["ratetype"].ToString();
                lblfrom4.Text = dtrange.Rows[3]["slab_from"].ToString();
                lblto4.Text = dtrange.Rows[3]["slab_to"].ToString();
                lblratetype4.Text = dtrange.Rows[3]["ratetype"].ToString();
                lblfrom5.Text = dtrange.Rows[4]["slab_from"].ToString();
                lblto5.Text = dtrange.Rows[4]["slab_to"].ToString();
                lblratetype5.Text = dtrange.Rows[4]["ratetype"].ToString();
                lblfrom6.Text = dtrange.Rows[4]["slab_from"].ToString();
                lblto6.Text = dtrange.Rows[4]["slab_to"].ToString();
                lblratetype6.Text = dtrange.Rows[4]["ratetype"].ToString();
            }

            sqlstr = "SELECT (CASE loc_reg WHEN 'R' THEN (SELECT TOP 1 codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=from_loccode) ELSE from_loccode END) AS 'From',";
            sqlstr = sqlstr + "(CASE loc_reg WHEN 'R' THEN (SELECT TOP 1 codedesc FROM webx_master_general WHERE codetype='ZONE' AND codeid=to_loccode ) ELSE to_loccode  END) AS 'To',";
            sqlstr = sqlstr + "ISNULL(trdays,0) AS 'Transit Days',slab1 AS 'Slab 1',slab2 AS 'Slab 2',";
            sqlstr = sqlstr + "slab3 AS 'Slab 3',slab4 AS 'Slab 4',slab5 AS 'Slab 5',slab6 AS 'Slab 6',";
            sqlstr = sqlstr + "(CASE loc_reg WHEN 'C' THEN 'City' WHEN 'L' THEN 'Branch' WHEN 'R' THEN 'Region' END) AS 'Matrix Type' ";
            sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_slabdet WHERE contractid='" + ContractID + "'";
            sqlstr = sqlstr + " AND  PATINDEX ('%' + loc_reg + '%','" + ucfilter.MatrixType + "')>0";
            if (ucfilter.BasedOn1.CompareTo("NONE") == 0)
                sqlstr = sqlstr + " AND basedon1='NONE' AND basecode1='NONE'";
            else
                sqlstr = sqlstr + " AND basedon1='" + ucfilter.BasedOn1 + "' AND basecode1='" + ucfilter.BaseCode1 + "'";

            if (ucfilter.BasedOn2.CompareTo("NONE") == 0)
                sqlstr = sqlstr + " AND basedon2='NONE' AND basecode2='NONE'";
            else
                sqlstr = sqlstr + " AND basedon2='" + ucfilter.BasedOn2 + "' AND basecode2='" + ucfilter.BaseCode2 + "'";

            sqlstr = sqlstr + " AND from_loccode LIKE '" + ucfilter.From + "%' AND to_loccode LIKE '" + ucfilter.To + "%'";
        }
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
        grvcharges.DataSource = dt;
        grvcharges.DataBind();
    }
    protected void lnksearch_Click(object sender, EventArgs e)
    {
        DataBinder();
    }

}
