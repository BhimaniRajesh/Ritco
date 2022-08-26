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

public partial class GUI_admin_CustomerMaster_ListAll : System.Web.UI.Page
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
            gvVendorListAll.PageIndex = e.NewPageIndex;
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
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd MMM yyyy");
            string strSQL = "exec Usp_VendorMaster_GetVendorList";
            DownloadXLS(strSQL, "VendorMaster.xls");
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
        DataTable dtVendorList = new DataTable();
        VendorMasterController objVendorMaster = new VendorMasterController();

        try
        {
            dtVendorList = objVendorMaster.getAllVendorInfo();

            if (dtVendorList != null && dtVendorList.Rows.Count > 0)
            {
                addColumnSerialNumber(dtVendorList);

                if (!isExcel)
                {
                    gvVendorListAll.DataSource = dtVendorList;
                    gvVendorListAll.DataBind();
                }
                else
                {
                    gvVendorListAllXLS.DataSource = dtVendorList;
                    gvVendorListAllXLS.DataBind();
                }
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void DownloadXLS(string qry, string FileName)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataAdapter adp = new SqlDataAdapter(qry, conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        DataTable dataTable = ds.Tables[0];  //oClientInfo.GetClientData(Convert.ToInt16(Session["UserID"].ToString()));
        Response.ContentType = "Application/x-msexcel";
        Response.AddHeader("content-disposition", "attachment; filename=\"" + FileName + "\"");
        DataGrid csvGrid = new DataGrid();
        csvGrid.DataSource = dataTable;
        csvGrid.DataBind();
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
        csvGrid.RenderControl(htmlWriter);
        Response.Write(stringWriter.ToString());
    }
    private void addColumnSerialNumber(DataTable dtVendorList)
    {
        try
        {
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SrNo";
            dtVendorList.Columns.Add(colSrNo);

            foreach (DataRow row in dtVendorList.Rows)
            {
                foreach (DataColumn col in dtVendorList.Columns)
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



