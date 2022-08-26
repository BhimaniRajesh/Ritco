using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.IO; 
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

using WebX.Entity;
using WebX.Controllers;


public partial class GUI_admin_GodownMaster_GodownMasterView : System.Web.UI.Page
{
    #region Variable[s]   
    public static string locCode = string.Empty;
    protected static string boxbg, bgbluegrey;
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            { 
                hdnflagprint.Value = Convert.ToString(Request.QueryString["print"]);

                if (hdnflagprint.Value.CompareTo("Y") == 0)
                {
                    setBorderWidth();                      
                    lnkBtnDownloadXLS.Visible = false;
                    lnkBtnPrint.Visible = false;           
                    gvGodown.BorderColor = System.Drawing.Color.Black;  
                    tblMain.BorderWidth = 1;
                    tblMain.BackColor = System.Drawing.Color.Black;
                    trStateMaster.BackColor = System.Drawing.Color.White;                                
                }
                else
                {
                    if (Convert.ToString(Request.QueryString["print"]).CompareTo("N") == 0)
                    {
                        gvGodown.CssClass = "boxbg";
                        gvGodown.HeaderStyle.CssClass = "bgbluegrey";                  
                        boxbg = "boxbg";
                        tblMain.CssClass = "boxbg";
                        trStateMaster.CssClass = "bgbluegrey";                   
                        bgbluegrey = "bgbluegrey";                      
                    }
                }

                hdnCode.Value = Convert.ToString(Request.QueryString["locCode"]);
                locCode = Convert.ToString(Request.QueryString["locCode"]);

                if (Request.QueryString["locCode"] != null)                
                    getData(locCode.Trim());               
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    } 
    protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        try
        {
            setBorderWidth();
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
    private void DownloadXLS()
    {
        try
        {
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + locCode.Trim() + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            // Response.Write("Docket Not Yet Delivered");
            frm.Controls.Add(tblMain);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            // Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void setBorderWidth()
    {        
       tdStateMaster.BorderWidth = 1; 
    
       gvGodown.Columns[0].HeaderStyle.BorderWidth = 1;        
       gvGodown.Columns[1].HeaderStyle.BorderWidth = 1;     
       gvGodown.Columns[2].HeaderStyle.BorderWidth = 1;
       gvGodown.Columns[3].HeaderStyle.BorderWidth = 1;
       gvGodown.Columns[4].HeaderStyle.BorderWidth = 1;
       gvGodown.Columns[5].HeaderStyle.BorderWidth = 1;
       gvGodown.Columns[0].ItemStyle.BorderWidth = 1;    
       gvGodown.Columns[1].ItemStyle.BorderWidth = 1;      
       gvGodown.Columns[2].ItemStyle.BorderWidth = 1;
       gvGodown.Columns[3].ItemStyle.BorderWidth = 1;
       gvGodown.Columns[4].ItemStyle.BorderWidth = 1;
       gvGodown.Columns[5].ItemStyle.BorderWidth = 1;        
    }
    public void getData(string strlocCode)
    {
        try
        {
            GodownMasterController objGodownMasterController = new GodownMasterController();
            DataTable dtGodown = new DataTable();

            if ((!string.IsNullOrEmpty(strlocCode)))
                dtGodown = objGodownMasterController.getGodownByLocation(strlocCode);

            gvGodown.DataSource = dtGodown;
            gvGodown.DataBind();  
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }   
    #endregion
}
