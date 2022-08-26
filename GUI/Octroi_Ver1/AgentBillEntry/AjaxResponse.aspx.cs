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

                string strValidDocket = "exec USP_Oct_Docket_Validation '" + code2 + "','Vend','',''";
                DataTable dtValidDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strValidDocket).Tables[0];
                if (dtValidDocket.Rows.Count > 0)
                {
                    if (dtValidDocket.Rows[0][0].ToString() == "F")
                    {
                        Response.Write("InValidDocket|" + dtValidDocket.Rows[0][1].ToString() + "|");
                    }
                    else
                    {
                        string str = "exec usp_get_AgentBill_GridDetails '" + code2 + "'";
                        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            Response.Write("true|" + dt.Rows[0]["OCTAMT"].ToString() + "|" + dt.Rows[0]["RECPTNO"].ToString() + "|" + dt.Rows[0]["RECPTDT"].ToString() + "|" + dt.Rows[0]["DOCKDT"].ToString() + "|" + dt.Rows[0]["STATUS"].ToString() + "|");
                        }
                        else
                        {
                            string StrDate = "select DOCKDT = convert(varchar(50),DOCKDT,103) from WebX_Master_Docket where DOCKNO = '" + code2 + "'";
                            DataTable dtDate = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, StrDate).Tables[0];
                            if (dtDate.Rows.Count > 0)
                            {
                                Response.Write("false|" + dtDate.Rows[0]["DOCKDT"].ToString() + "|N|");
                            }
                            else
                            {
                                Response.Write("InValid|");
                            }
                        }
                    }
                }
            }
        }        
        // data ENDS HERE
    }
}
