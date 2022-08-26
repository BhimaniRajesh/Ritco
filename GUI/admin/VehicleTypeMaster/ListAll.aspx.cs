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

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_VehicleMaster_ListAll : System.Web.UI.Page
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
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvVehicleTypeListAll.PageIndex = e.NewPageIndex;
            bindGrid(false);
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in Paging.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
    {

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
        DataTable dtVehicleTypeList = new DataTable();
        VehicleMasterController objVehicleMaster = new VehicleMasterController();

        try
        {
            dtVehicleTypeList = objVehicleMaster.getAllVehicleTypeList();

            if (dtVehicleTypeList != null && dtVehicleTypeList.Rows.Count > 0)
            {
                addColumnSerialNumber(dtVehicleTypeList);

                if (!isExcel)
                {
                    gvVehicleTypeListAll.DataSource = dtVehicleTypeList;
                    gvVehicleTypeListAll.DataBind();
                }
                else
                {
                    gvVehicleTypeListAllXLS.DataSource = dtVehicleTypeList;
                    gvVehicleTypeListAllXLS.DataBind();
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
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=VehicleType_Master_List.xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            gvVehicleTypeListAllXLS.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            // Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }

    private void addColumnSerialNumber(DataTable dtVehicleTypeList)//addcolumn(srno) function
    {
        try
        {
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SrNo";
            dtVehicleTypeList.Columns.Add(colSrNo);

            foreach (DataRow row in dtVehicleTypeList.Rows)
            {
                foreach (DataColumn col in dtVehicleTypeList.Columns)
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



