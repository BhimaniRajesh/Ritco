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
using System.IO; 

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
            gvStateListAll.PageIndex = e.NewPageIndex;
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
        DataTable dtStateList = new DataTable();
        StateMasterController objStateMaster = new StateMasterController();

        try
        {
            dtStateList = objStateMaster.getAllState();

            if (dtStateList != null && dtStateList.Rows.Count > 0)
            {
                addColumnSerialNumber(dtStateList);

                if (!isExcel)
                {
                    gvStateListAll.DataSource = dtStateList;
                    gvStateListAll.DataBind();
                }
                else
                {
                    gvStateListAllXLS.DataSource = dtStateList;
                    gvStateListAllXLS.DataBind();
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
            Response.AddHeader("content-disposition", "attachment;filename=State_List.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(gvStateListAllXLS);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());


        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void addColumnSerialNumber(DataTable dtVehicleTypeList)
    {
        try
        {
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SerialNo";
            dtVehicleTypeList.Columns.Add(colSrNo);

            foreach (DataRow row in dtVehicleTypeList.Rows)
            {
                foreach (DataColumn col in dtVehicleTypeList.Columns)
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
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}



