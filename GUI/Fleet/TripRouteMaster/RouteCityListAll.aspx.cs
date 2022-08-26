using System;
using System.Data;
using System.IO; 
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_RouteCity_RouteCityListAll : System.Web.UI.Page
{
    #region Variable[s]
    int i = 0;
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindGrid(false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrive.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvRouteListAll.PageIndex = e.NewPageIndex;
            bindGrid(false);
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in Paging.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        try
        {
            bindGrid(true);
            DownloadXLS();
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in download excel file.&detail1=" + Exc.Message.Replace('\n', '_'), true);
        }
        finally
        {
            Response.End();
        }
    }
    #endregion

    #region Private Function[s]
    public void bindGrid(bool isExcel)
    {
        DataTable dtRouteList = new DataTable();
        RouteMasterCityController objRouteMaster = new RouteMasterCityController();

        try
        {
            dtRouteList = objRouteMaster.getAllCityRoute();

            if (dtRouteList != null && dtRouteList.Rows.Count > 0)
            {
                addColumnSerialNumber(dtRouteList);

                if (!isExcel)
                {
                    gvRouteListAll.DataSource = dtRouteList;
                    gvRouteListAll.DataBind();
                }
                else
                {
                    gvRouteListAllXLS.DataSource = dtRouteList;
                    gvRouteListAllXLS.DataBind();
                }
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void DownloadXLS()
    {
        try
        {
            //export to excel
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=CityBasedRouteList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(gvRouteListAllXLS);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void addColumnSerialNumber(DataTable dtRouteList)
    {
        try
        {
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SrNo";
            dtRouteList.Columns.Add(colSrNo);

            foreach (DataRow row in dtRouteList.Rows)
            {
                foreach (DataColumn col in dtRouteList.Columns)
                {
                    if (col.ToString() == "SrNo")
                    {
                        row.BeginEdit();
                        i += 1;
                        row["SrNo"] = i;
                        row.EndEdit();
                    }
                }
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion        
}



