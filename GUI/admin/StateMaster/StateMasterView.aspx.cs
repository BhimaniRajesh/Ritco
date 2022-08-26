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


public partial class GUI_admin_StateMaster_StateMasterView : System.Web.UI.Page
{
    #region Variable[s]
    public static string stateCode = string.Empty;
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
                    gvState.BorderColor = System.Drawing.Color.Black;
                    tblMain.BorderWidth = 1;
                    tblMain.BackColor = System.Drawing.Color.Black;
                    trStateMaster.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    if (Convert.ToString(Request.QueryString["print"]).CompareTo("N") == 0)
                    {
                        gvState.CssClass = "boxbg";
                        gvState.HeaderStyle.CssClass = "bgbluegrey";
                        lnkBtnDownloadXLS.Visible = true;
                        lnkBtnPrint.Visible = true;
                        boxbg = "boxbg";
                        tblMain.CssClass = "boxbg";
                        trStateMaster.CssClass = "bgbluegrey";
                        bgbluegrey = "bgbluegrey";
                    }
                }

                hdnCode.Value = Convert.ToString(Request.QueryString["state"]);
                stateCode = Convert.ToString(Request.QueryString["state"]);

                if (Request.QueryString["state"] != null)
                {
                    getData(Request.QueryString["state"].ToString());
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void gvState_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblActiveFlag = (Label)e.Row.FindControl("lblInOutbound");

                if (lblActiveFlag.Text == "I")
                {
                    lblActiveFlag.Text = "Inbound";
                }
                else if (lblActiveFlag.Text == "O")
                {
                    lblActiveFlag.Text = "Outbound";
                }
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
            if (lblState.Text.Trim().Contains(" "))
                Response.AddHeader("content-disposition", "attachment;filename=" + lblState.Text.Trim().Replace(" ", "_") + ".xls");
            else
                Response.AddHeader("content-disposition", "attachment;filename=" + lblState.Text.Trim() + ".xls");
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
        tdStateCode.BorderWidth = 1;
        lbltdStateCode.BorderWidth = 1;
        tdStateName.BorderWidth = 1;
        lbltdStateName.BorderWidth = 1;
        tdFreightRate.BorderWidth = 1;
        lbltdFreightRate.BorderWidth = 1;
        tdFreightRateType.BorderWidth = 1;
        lbltdFreightRateType.BorderWidth = 1;
        tdUpdateBy.BorderWidth = 1;
        lbltdUpdateBy.BorderWidth = 1;
        tdUpdateOnDate.BorderWidth = 1;
        lbltdUpdateOnDate.BorderWidth = 1;
        tdgvState.BorderWidth = 1;
        tdActiveFlag.BorderWidth = 1;
        lbltdActiveFlag.BorderWidth = 1;
        tdStaxFlag.BorderWidth = 1;
        lbltdStaxFlag.BorderWidth = 1;

        gvState.Columns[0].HeaderStyle.BorderWidth = 1;
        // gvState.Columns[0].HeaderStyle.BackColor = System.Drawing.Color.Black;  
        gvState.Columns[1].HeaderStyle.BorderWidth = 1;
        // gvState.Columns[1].HeaderStyle.BackColor = System.Drawing.Color.Black;  
        //  gvState.Columns[2].HeaderStyle.BorderWidth = 1;
        // gvState.Columns[2].HeaderStyle.BackColor = System.Drawing.Color.Black;  
        gvState.Columns[0].ItemStyle.BorderWidth = 1;
        // gvState.Columns[0].ItemStyle.BackColor = System.Drawing.Color.Black;  
        gvState.Columns[1].ItemStyle.BorderWidth = 1;
        // gvState.Columns[1].ItemStyle.BackColor = System.Drawing.Color.Black;  
        // gvState.Columns[2].ItemStyle.BorderWidth = 1;
        // gvState.Columns[2].ItemStyle.BackColor = System.Drawing.Color.Black;  
    }

    public void getData(string stateCode)
    {
        StateMasterController objStateMaster = new StateMasterController();
        DataTable dtStateMaster = new DataTable();

        try
        {
            if (!string.IsNullOrEmpty(stateCode))
            {
                dtStateMaster = objStateMaster.getStateInfo(stateCode);
            }

            if (dtStateMaster != null && dtStateMaster.Rows.Count > 0)
            {
                lblStateCode.Text = Convert.ToString(dtStateMaster.Rows[0]["STCD"]);
                lblState.Text = Convert.ToString(dtStateMaster.Rows[0]["STNM"]);
                lblFreightRate.Text = Convert.ToString(dtStateMaster.Rows[0]["frt_rate"]);
                lblUpdateby.Text = Convert.ToString(dtStateMaster.Rows[0]["lasteditby"]);

                if (dtStateMaster.Rows[0]["activeflag"].ToString().Trim() == "Y")
                {
                    lblActiveFlag.Text = "Yes";
                }
                else
                {
                    lblActiveFlag.Text = "No";
                }
                if (dtStateMaster.Rows[0]["stax_exmpt_yn"].ToString().Trim() == "Y")
                {
                    lblStax.Text = "Yes";
                }
                else
                {
                    lblStax.Text = "No";
                }

                if (!string.IsNullOrEmpty(Convert.ToString(dtStateMaster.Rows[0]["lasteditdate"])))
                {
                    if (DateTime.Compare(Convert.ToDateTime(dtStateMaster.Rows[0]["lasteditdate"]), DateTime.MinValue.AddYears(1754)) != 0)
                        lblUpdateDate.Text = dtStateMaster.Rows[0]["lasteditdate"] != null ? Convert.ToDateTime(dtStateMaster.Rows[0]["lasteditdate"].ToString()).ToString("dd/MM/yyyy") : "";
                }

                if (dtStateMaster.Rows[0]["rate_type"] != null)
                {
                    if (Convert.ToString(dtStateMaster.Rows[0]["rate_type"]) == "W")
                    {
                        lblFreightRateType.Text = "PerKG";
                    }
                    else if (Convert.ToString(dtStateMaster.Rows[0]["rate_type"]) == "P")
                    {
                        lblFreightRateType.Text = "PerPKG";
                    }
                    else if (Convert.ToString(dtStateMaster.Rows[0]["rate_type"]) == "T")
                    {
                        lblFreightRateType.Text = "PerTON";
                    }
                    else if (Convert.ToString(dtStateMaster.Rows[0]["rate_type"]) == "F")
                    {
                        lblFreightRateType.Text = "Flat(in RS)";
                    }
                }

                gvState.DataSource = dtStateMaster;
                gvState.DataBind();
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}
