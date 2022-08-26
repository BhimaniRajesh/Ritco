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

public partial class GUI_Operation_GenerateToPayMRUtility : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();
        fn = new MyFunctions();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string mrsno = "", drsdt = "", paybas = "", transmode = "", delloc = "", delivered = "", delydate = "", serviceclass = "";

        string sqlstr = "SELECT mrsno FROM webx_mr_hdr WHERE dockno='" + txtdockno.Text + "' AND mrstype='3' AND ISNULL(mr_cancel,'N')='N'";

        string client = Session["client"].ToString().ToUpper();

        SqlCommand cmd;
        cmd = new SqlCommand(sqlstr, con);
        mrsno = Convert.ToString(cmd.ExecuteScalar());

        if (mrsno.CompareTo("") != 0)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=To Pay MR No " + mrsno + " is already present for the " + Session["DocketCalledAs"].ToString() + " No " + txtdockno.Text);
            return;
        }


        sqlstr = "USP_MANUAL_TOPAYMR_CHECK";
        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@dockno", txtdockno.Text);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);


        if (dt.Rows.Count <= 0)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Proper Records not Found. Can't Generate ToPayMR");
        }

        if (dt.Rows[0]["flagallow"].ToString().CompareTo("N") == 0)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=" + Session["DocketCalledAs"].ToString() + " doesn't satiesfy ToPay MR criteria. Can't Generate ToPayMR");
        }
        //sqlstr = "SELECT CONVERT(VARCHAR, pdcdt,103) AS drsdt FROM webx_pdchdr WHERE pdcno=(";
        //sqlstr = sqlstr + "SELECT top 1 pdcno FROM webx_pdctrn WHERE dockno='" + txtdockno.Text + "')";
        //cmd = new SqlCommand(sqlstr, con);
        //drsdt = Convert.ToString(cmd.ExecuteScalar());


        //sqlstr = "SELECT delivered=ISNULL(delivered,'N'),dely_date=CONVERT(VARCHAR, dely_date,103) FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //SqlDataReader dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    delivered = Convert.ToString(dr["delivered"]);
        //    delydate = Convert.ToString(dr["dely_date"]);
        //}
        //dr.Close();


        //sqlstr = "SELECT paybas FROM webx_master_docket WHERE dockno='" + txtdockno.Text + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //paybas = Convert.ToString(cmd.ExecuteScalar());

        //sqlstr = "SELECT trn_mod FROM webx_master_docket WHERE dockno='" + txtdockno.Text + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //transmode = Convert.ToString(cmd.ExecuteScalar());

        //sqlstr = "SELECT service_class FROM webx_master_docket WHERE dockno='" + txtdockno.Text + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //serviceclass = Convert.ToString(cmd.ExecuteScalar());

        //if (paybas.CompareTo("P03") == 0 && serviceclass.CompareTo("2") == 0)
        //{
        //    if (delivered.CompareTo("N") == 0)
        //    {
        //        Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=" + Session["DocketCalledAs"].ToString() + " is not delivered. Can't Generate ToPayMR");
        //        return;
        //    }
        //}
        //else
        //{
        //    if (drsdt.CompareTo("") == 0)
        //    {
        //        Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=" + Session["DocketCalledAs"].ToString() + " is not delivered. Can't Generate ToPayMR");
        //        return;
        //    }
        //}



        //sqlstr = "SELECT reassign_destcd FROM webx_master_docket WHERE dockno='" + txtdockno.Text + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //delloc = Convert.ToString(cmd.ExecuteScalar());

        //if (paybas.CompareTo("P03") != 0)
        //{
        //    Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=" + Session["DocketCalledAs"].ToString() + " is not To Pay. Can't Generate ToPayMr");
        //    return;
        //}

        int finyear, month;
        DateTime dtmrs = DateTime.Parse(dt.Rows[0]["mrsdt"].ToString());

        if (dtmrs.Month < 4)
            finyear = dtmrs.Year - 1;
        else
            finyear = dtmrs.Year;

        if (finyear.ToString().CompareTo(Session["finyear"].ToString()) != 0)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Current Financial doesn't Match With DRS Date. Can't Generate ToPayMr");
            return;
        }

        SqlTransaction trn = con.BeginTransaction();
        try
        {
            sqlstr = "webx_Generate_topayMR";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@pdcdt", dtmrs.ToString("dd MMM yyyy"));
            cmd.Parameters.Add("@dockno", txtdockno.Text);
            cmd.Parameters.Add("@entryby", Session["empcd"].ToString());
            cmd.Parameters.Add("@loccode", delloc);
            cmd.Parameters.Add("@trn_mode", transmode);
            cmd.Parameters.Add("@finyear", finyear.ToString().Substring(2, 2));
            cmd.ExecuteNonQuery();

            if (client.CompareTo("AGILITY") != 0 && client.Trim().CompareTo("ASL") != 0 && client.CompareTo("RITCO") != 0 && client.CompareTo("VARUNA") == 0 && client.Trim().CompareTo("UFL") != 0)
            {
                sqlstr = "usp_TOPayMRTransaction";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@transno", "1");
                cmd.Parameters.Add("@docno", txtdockno.Text.Trim());
                cmd.Parameters.Add("@docsf", ".");
                cmd.Parameters.Add("@finyear", finyear.ToString().Substring(2, 2));
                cmd.Parameters.Add("@entryby1", Session["empcd"].ToString());
                cmd.Parameters.Add("@nextvoucherno", "");
                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }
        trn.Commit();

        sqlstr = "SELECT mrsno FROM webx_mr_hdr WHERE dockno='" + txtdockno.Text + "' AND mrstype='3' AND ISNULL(mr_cancel,'N')='N'";
        cmd = new SqlCommand(sqlstr, con);
        mrsno = Convert.ToString(cmd.ExecuteScalar());

        Response.Redirect("~/GUI/Operation/DocketEntry/docket_submit_done.aspx?dockno=" + txtdockno.Text.Trim() + "&mrsno=" + mrsno.Trim());
    }
}
