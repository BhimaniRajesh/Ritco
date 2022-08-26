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
using WebX.Controllers;
public partial class GUI_Operation_DocketCancellation_DocketCancellation : System.Web.UI.Page
{
    protected string dkt_call = "";
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        dkt_call = Session["docketcalledas"].ToString();
        hdnfin_year.Value = Session["FinYear"].ToString(); // 2007
        hdnfin_year_2d.Value = Session["FinYear"].ToString().Substring(2, 2);
        hdnemployee.Value = Session["empcd"].ToString();
        hdnclient.Value = Session["client"].ToString().ToUpper();

        SqlCommand cmd;
        SqlDataReader dr;

        string sqlstr = "";
        sqlstr = "SELECT loc_level FROM webx_location WHERE loccode='" + Session["brcd"].ToString() + "'";
        cmd = new SqlCommand(sqlstr, con);
        string loclevel = Convert.ToString(cmd.ExecuteScalar());
        if (loclevel.CompareTo("1") != 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Not a Head Office Login. Can't Cancel " + Session["DOCKETCALLEDAS"].ToString() + "&detail1=Please login from Head Office to cancel " + Session["DocketCalledAs"].ToString());
            return;
        }

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlDataReader dr;
        string sqlstr = "";
        bool IsTBBDocket = false;

        DateTime dtstartfinyear = new DateTime(Convert.ToInt16(Session["finyear"]), 4, 1);
        DateTime dtendfinyear = new DateTime(Convert.ToInt16(Session["finyear"]) + 1, 3, 31);

        sqlstr = "SELECT paybas,convert(varchar,dockdt,103) AS dockdate,isnull(IsTBBDocket,0) AS IsTBBDocket FROM webx_master_docket WHERE dockno='" + txtdockno.Text.Trim() + "'";
        sqlstr = sqlstr + " AND dockdt BETWEEN  '" + dtstartfinyear.ToString("dd MMM yyyy") + "' AND '" + dtendfinyear.ToString("dd MMM yyyy") + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        int cnt = 0;
        while (dr.Read())
        {
            hdnpaybas.Value = Convert.ToString(dr["paybas"]);
            hdndockyear.Value = Convert.ToString(dr["dockdate"]).Substring(6, 4);
            IsTBBDocket = Convert.ToBoolean(dr["IsTBBDocket"]);
            cnt++;
        }
        dr.Close();

        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + txtdockno.Text + " doesn't Exists current Financial Year i.e. " + hdnfin_year.Value);
            return;
        }

        if (IsTBBDocket == true)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + txtdockno.Text + " Is Docket Is From MVC Module Can not Cancelled !! " );
            return;
        }


        sqlstr = "SELECT drs,ls,mf,thc,cancelled,billed FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            if (Convert.ToString(dr["cancelled"]).CompareTo("Y") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=" + dkt_call + " No " + txtdockno.Text + " is already Cancelled");
                return;
            }

            if (Convert.ToString(dr["thc"]).CompareTo("") != 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=THC " + dr["thc"].ToString() + " is Generated for " + dkt_call + " " + txtdockno.Text);
                return;
            }

            if (Convert.ToString(dr["mf"]).CompareTo("") != 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Manifest " + dr["mf"].ToString() + " is Generated for " + dkt_call + " " + txtdockno.Text);
                return;
            }

            if (Convert.ToString(dr["ls"]).CompareTo("") != 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Loading Sheet " + dr["ls"].ToString() + " is Generated for " + dkt_call + " " + txtdockno.Text);
                return;
            }

            if (Convert.ToString(dr["drs"]).CompareTo("") != 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=DRS " + dr["drs"].ToString() + " is Generated for " + dkt_call + " " + txtdockno.Text);
                return;
            }

            if (Convert.ToString(dr["billed"]).CompareTo("Y") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Bill is Generated for " + dkt_call + " " + txtdockno.Text);
                return;
            }

            cnt++;
        }
        dr.Close();

        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + txtdockno.Text + " doesn't Exists");
            return;
        }

        SqlTransaction trn = con.BeginTransaction();
        try
        {
            sqlstr = "UPDATE webx_trans_docket_status SET cancelled='Y',cancelledon=getdate(),cancelledby='" + Session["empcd"].ToString() + "' WHERE dockno='" + txtdockno.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            if (hdnpaybas.Value.CompareTo("P01") == 0)
            {
                // CANCELLING PAID MR - START
                DocketFinEditController.DocketAccountReversal(txtdockno.Text, hdnfin_year.Value, trn);
                // CANCELLING PAID MR - END

                // CANCELLING MR - START
                sqlstr = "UPDATE webx_mr_hdr SET mr_cancel='Y',";
                sqlstr = sqlstr + "cancomment='CNote Cancelled',";
                sqlstr = sqlstr + "bcandt=getdate(),";
                sqlstr = sqlstr + "bcanempcd='" + hdnemployee.Value + "'";
                sqlstr = sqlstr + " WHERE dockno='" + txtdockno.Text.Trim() + "'";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }
            else if (hdnpaybas.Value.CompareTo("P02") == 0)
            {
                if (hdnclient.Value.CompareTo("RLL") == 0 || hdnclient.Value.CompareTo("VARUNA") == 0 || hdnclient.Value.CompareTo("ASL") == 0 || hdnclient.Value.Trim().CompareTo("RITCO") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    // CANCELLING TBB TRANSACTION - START
                    DocketFinEditController.DocketAccountReversal(txtdockno.Text, hdnfin_year.Value, trn);
                }
            }
            else if (hdnpaybas.Value.CompareTo("P03") == 0)
            {
                sqlstr = "SELECT COUNT(*) FROM webx_mr_hdr WHERE dockno='" + txtdockno.Text.Trim() + "' AND mr_cancel='N'";
                cmd = new SqlCommand(sqlstr, con, trn);
                int mr_count = Convert.ToInt16(cmd.ExecuteScalar());


                // CANCELLING TO PAY MR - START
                if (mr_count > 0)
                {
                    sqlstr = "UPDATE webx_mr_hdr SET mr_cancel='Y',";
                    sqlstr = sqlstr + "cancomment='CNote Cancelled',";
                    sqlstr = sqlstr + "bcandt=getdate(),";
                    sqlstr = sqlstr + "bcanempcd='" + hdnemployee.Value + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + txtdockno.Text.Trim() + "'";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.ExecuteNonQuery();
                }
                // CANCELLING TO PAY MR - END

                // VARUNA HAS ACCOUNTING AT TOPAY MR GENERATION TIME SO CANCEL IN EVERY CASE
                if (hdnclient.Value.CompareTo("VARUNA") == 0 || hdnclient.Value.CompareTo("ASL") == 0 || hdnclient.Value.Trim().CompareTo("RITCO") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    DocketFinEditController.DocketAccountReversal(txtdockno.Text, hdnfin_year.Value, trn);
                }
                else if (hdnclient.Value.CompareTo("RLL") != 0) // REL DOESN'T WANT TO HAVE TOPAY TRANSACTIONS
                {
                    if (mr_count > 0)
                    {
                        DocketFinEditController.DocketAccountReversal(txtdockno.Text, hdnfin_year.Value, trn);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=Session Expired OR DataBase Updation Exception Occured&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();

        Response.Redirect("~/GUI/Default.aspx");
    }


}
