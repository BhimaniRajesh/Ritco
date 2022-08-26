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
using Microsoft.ApplicationBlocks.Data;  

public partial class GUI_Operation_Singlescreen_docketentry_AjaxResponse : System.Web.UI.Page
{
    string mode = "", dkt_call = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        mode = Request.QueryString["mode"].ToString();
        try
        {
               dkt_call = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Write("false|Session Expired. LogOn again....");
            return;
        }
        if (mode.CompareTo("check") == 0)
        {
        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
            string code1 = Request.QueryString["code1"].ToString();
            if (code1 == "octdet")
            {
                string code2 = Request.QueryString["code2"].ToString();

                string strValidDocket = "exec USP_Oct_Docket_Validation '" + code2 + "','Cust','" + Session["PartyCode"].ToString() + "','" + Session["PartyType"].ToString() + "'";
                DataTable dtValidDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strValidDocket).Tables[0];
                if (dtValidDocket.Rows.Count > 0)
                {
                    if (dtValidDocket.Rows[0][0].ToString() == "F")
                    {
                        Response.Write("InValidDocket|" + dtValidDocket.Rows[0][1].ToString() + "|");
                    }
                    else
                    {
                        string strRule = "select * from webx_modules_rules where Module_Name ='Prepare Octroi Bill' and Rule_Desc = 'For Octroi Bill - Booking Location Octroi Bill Generated'";
                        DataTable dtRule = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strRule).Tables[0];
                        if (dtRule.Rows.Count > 0)
                        {
                            if (dtRule.Rows[0]["RULE_Y_N"].ToString() == "Y")
                            {
                                string strLocation = " SELECT * FROM WEBX_MASTER_DOCKET WHERE DOCKNO ='" + code2 + "' AND ORGNCD = '" + SessionUtilities.CurrentBranchCode + "'";
                                DataTable dtLocation = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strLocation).Tables[0];
                                if (dtLocation.Rows.Count > 0)
                                {
                                    GridDetails(code2);
                                }
                                else
                                {
                                    Response.Write("InValidLocation|");
                                }
                            }
                            else  // if (dtRule.Rows[0][""].ToString() == "N")
                            {
                                GridDetails(code2);
                            }
                        }
                        else
                        {
                            Response.Write("InValidRule|");
                        }                       
                    }
                }
            }
        }        
        // data ENDS HERE
    }

    public void GridDetails(string code2)
    {
        string code3 = Request.QueryString["code3"].ToString();

        string str = "exec usp_get_PrepareOctroiBill_GridDetails '" + code2 + "','" + code3 + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
        if (dt.Rows.Count > 0)
        {
            Response.Write("true|" + dt.Rows[0]["DECLVAL"].ToString() + "|" + dt.Rows[0]["OCTAMT"].ToString() + "|" + dt.Rows[0]["RECPTNO"].ToString() + "|" + dt.Rows[0]["RECPTDT"].ToString() + "|" + dt.Rows[0]["DOCKDT"].ToString() + "|" + dt.Rows[0]["STATUS"].ToString() + "|" + dt.Rows[0]["CSGNNM"].ToString() + "|");
        }
        else
        {
            string StrDate = "exec usp_get_PrepareOctroiBill_GridDetails_1 '" + code2 + "','" + code3 + "'";
            DataTable dtDate = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, StrDate).Tables[0];
            if (dtDate.Rows.Count > 0)
            {
                Response.Write("false|" + dtDate.Rows[0]["DOCKDT"].ToString() + "|" + "N|" + dtDate.Rows[0]["CSGNNM"].ToString() + "|");
            }
            else
            {
                Response.Write("InValid|");
            }
        }
    }
}


