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
using Microsoft.ApplicationBlocks.Data;
using System.IO;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operation_Singlescreen_docketentry_AjaxResponse : System.Web.UI.Page
{
    string mode = "", dkt_call = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        mode = Request.QueryString["mode"].ToString();
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            dkt_call = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Write("false|Session Expired. LogOn again....");
            return;
        }

        SqlCommand cmd;
        if (mode.CompareTo("check") == 0)
        {
            Response.Clear();
            // CHECK MODE RETURNS true OR false USED ONLY TO CHECKING PURPOSE
            string code1 = Request.QueryString["code1"].ToString();
            if (code1.CompareTo("delmrdockno") == 0)
            {
                string dockno = Request.QueryString["code2"].ToString();
                string suffix = Request.QueryString["code3"].ToString();
                try
                {
                    MRController.IsDocketEligibleForDelMR(dockno, suffix, SessionUtilities.CurrentBranchCode, SessionUtilities.FinYear);
                }
                catch (Exception ex)
                {
                    Response.Write("false|" + ex.Message.Replace('\n', ' '));
                    return;
                }

                Response.Write("true|");
            }
            else if (code1.CompareTo("partytest") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                string type = Request.QueryString["code3"].ToString().ToUpper();
                string custloc = Request.QueryString["code4"].ToUpper();
                try
                {
                    if (DataValidations.IsActiveCustomer(partycode, custloc))
                    {
                        Response.Write("true|"  + DataProvider.GetCustomerName(partycode));
                    }
                    else
                    {
                        Response.Write("false|Party Not Found|");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("false|Session Expired or Problem in Cheque Validation|");
                    Response.End();
                    return;
                }
            }
            else if (code1.CompareTo("receiver") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                string sql = "";

                sql = "SELECT receivercode as custcd,receivername as custnm FROM webx_master_receiver WHERE receivercode='" + partycode + "' AND activeflag='Y'";

                cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["custcd"].ToString().ToUpper().CompareTo(partycode.ToUpper()) == 0)
                    {
                        Response.Write("true|" + dr["custnm"].ToString() + "|");
                        return;
                    }
                }
                dr.Close();
                Response.Write("false|Receiver Not Found|");
            }
            else if (code1.CompareTo("dupchequeno") == 0)
            {
                string chequeno = Request.QueryString["code2"].ToString();
                string chequedate = Request.QueryString["code3"].ToString();
                System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
                DateTime dtcheque = Convert.ToDateTime(chequedate);
                try
                {
                    if (DataValidations.IsValidCheque(chequeno, dtcheque))
                    {
                        Response.Write("true|");
                    }
                    else
                    {
                        Response.Write("false|Cheque already exists with same date in System.|");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("false|Session Expired or Problem in Cheque Validation|");
                    Response.End();
                    return;
                }
            }

            Response.End();
        }
        else if (mode.CompareTo("data") == 0)
        {
        }// data ENDS HERE

    }
}
