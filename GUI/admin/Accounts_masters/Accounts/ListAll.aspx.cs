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
using Microsoft.ApplicationBlocks.Data;

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
            gvAccountListAll.PageIndex = e.NewPageIndex;
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
        DataTable dtAccountList = new DataTable();
        

        try
        {
            //string sqlstr = "SELECT Acccode,Accdesc,company_acccode,a.groupcode,b.groupdesc,acccategory,activeflag,bkacctno,bkloccode from webx_acctinfo a inner join webx_groups b on a.groupcode=b.groupcode order by accdesc";
			string sqlstr = "SELECT Acccode,Accdesc,a.Acccategory,a.Brcd,company_acccode,a.groupcode,b.groupdesc,acccategory,Case when IsExceptionLeger=1 THEN 'Yes' Else 'No' END  As ExceptionLedger,activeflag,bkacctno,bkloccode,E.UserId+ ' : '+ E.Name As Entryby,CONVERT(VARCHAR(20),a.Entrydt,106) AS Entrydt,U.UserId+ ' : '+ U.Name As Updateby,CONVERT(VARCHAR(20),a.Updatedt,106) AS Updatedt from webx_acctinfo a inner join webx_groups b on a.groupcode=b.groupcode LEFT JOIN WebX_Master_Users E WITH(NOLOCK) ON a.Entryby = E.UserId LEFT JOIN WebX_Master_Users U WITH(NOLOCK) ON a.Updateby = U.UserId WHERE b.main_category IN ('ASSET','EXPENSE','INCOME','LIABILITY','BANK') order by accdesc ";

            dtAccountList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            if (dtAccountList != null && dtAccountList.Rows.Count > 0)
            {
                addColumnSerialNumber(dtAccountList);

                if (!isExcel)
                {
                    gvAccountListAll.DataSource = dtAccountList;
                    gvAccountListAll.DataBind();
                }
                else
                {
                    gvAccountListAllXLS.DataSource = dtAccountList;
                    gvAccountListAllXLS.DataBind();
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
            Response.AddHeader("content-disposition", "attachment;filename=AccountList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(gvAccountListAllXLS);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void addColumnSerialNumber(DataTable dtAccountList)
    {
        try
        {
            DataColumn colSrNo = new DataColumn();
            colSrNo.ColumnName = "SrNo";
            dtAccountList.Columns.Add(colSrNo);

            foreach (DataRow row in dtAccountList.Rows)
            {
                foreach (DataColumn col in dtAccountList.Columns)
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



