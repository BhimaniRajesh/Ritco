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

public partial class GUI_admin_GeneralMaster_MasterList : System.Web.UI.Page
{
    SqlConnection con;
    string s;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }

    private void BindGrid()
    {
        string accesscode = "U";
        try
        {
            accesscode = Request.QueryString["accesscode"].ToString();
        }
        catch (Exception ex) { }

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        s = "SELECT headercode,headerdesc,Id_Desc,Name_Desc,whereused,Description FROM webx_master_codetypes WHERE activeflag_YN='Y' and ToSupport='tms' and HeaderAccess<>'S'";
        con.Open();
        cmd = new SqlCommand(s, con);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds, "tbl");
        gvmasterlist.DataSource = addColumnSerialNumber(ds.Tables["tbl"]);
        // gvmasterlist.DataSource = ds.Tables["tbl"];
        gvmasterlist.DataBind();

        s = "SELECT headercode,headerdesc,Id_Desc,Name_Desc,whereused,Description FROM webx_master_codetypes WHERE ToSupport='FLEET' AND activeflag_YN='Y' AND headeraccess<>'S'";
        cmd = new SqlCommand(s, con);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds, "FleetMaster");

        gvFleetMasterList.DataSource = addColumnSerialNumber(ds.Tables["FleetMaster"]);
        gvFleetMasterList.DataSource = ds.Tables["FleetMaster"];
        gvFleetMasterList.DataBind();     
        con.Close();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvmasterlist.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void pgChangeFleetMaster(object sender, GridViewPageEventArgs e)
    {
        gvFleetMasterList.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void gvmasterlist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gvmasterlist_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        LinkButton lnkBtnGeneralmasterView;
        LinkButton lnkBtnGeneralmasterXLS;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView dr = ((DataRowView)e.Row.DataItem);
            lnkBtnGeneralmasterView = (LinkButton)e.Row.FindControl("lnkBtnGeneralmasterView");
            lnkBtnGeneralmasterXLS = (LinkButton)e.Row.FindControl("lnkBtnGeneralmasterXLS");

            HiddenField hdnMasterCode = (HiddenField)e.Row.FindControl("hdnMasterCode");
            lnkBtnGeneralmasterView.Attributes.Add("onclick", "javascript:return popupView('" + hdnMasterCode.Value + "')");
            lnkBtnGeneralmasterXLS.Attributes.Add("onclick", "javascript:return downloadXLS('" + hdnMasterCode.Value + "')");
        }
    }

    private DataTable addColumnSerialNumber(DataTable dtTemp)
    {
        try
        {
            int i = 0;
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SerialNo";
            dtTemp.Columns.Add(colSrNo);

            foreach (DataRow row in dtTemp.Rows)
            {
                foreach (DataColumn col in dtTemp.Columns)
                {
                    if (col.ToString() == "SerialNo")
                    {
                        row.BeginEdit();
                        i += 1;
                        row["SerialNo"] = i;
                        row.EndEdit();
                    }
                }
            }

            return dtTemp;
        }
        catch (Exception Exc)
        {
            throw Exc;
            return dtTemp;
        }
    }

}
