using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_LS_ver2_popup_locations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";
        string loccode = txtLocCode.Text;
        string locname = txtLocName.Text;
        string HO = Session["HeadOfficeCode"].ToString().Trim();
        string brcd = Session["brcd"].ToString().Trim();
        sql = "select LocCode, LocName from webx_location where ActiveFlag='Y' and LocCode like'" + loccode + "%' and LocName Like '" + locname + "%'order by Locname";
        //if (HO == brcd)
        //{
        //    sql = "select LocCode, LocName from webx_location where ActiveFlag='Y' and LocCode like'" + loccode + "%' and LocName Like '" + locname + "%' order by Locname";
        //}
        //else
        //{
        //    sql = "select LocCode, LocName from webx_location where ActiveFlag='Y' and LocCode like'" + loccode + "%' and LocName Like '" + locname + "%' and LocCode = '" + brcd + "' order by Locname";
        //}

        DataSet ds = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString(), CommandType.Text, sql);
        DataList1.DataSource = ds;
        DataList1.DataBind();        
    }
}
