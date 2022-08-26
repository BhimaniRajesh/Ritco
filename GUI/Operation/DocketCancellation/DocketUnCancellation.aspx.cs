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

public partial class GUI_Operation_DocketCancellation_DocketCancellation : System.Web.UI.Page
{
    protected string dkt_call = "";
    SqlConnection con;
    SqlTransaction trn;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();

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

        DateTime dtstartfinyear = new DateTime(Convert.ToInt16(Session["finyear"]), 4, 1);
        DateTime dtendfinyear = new DateTime(Convert.ToInt16(Session["finyear"]) + 1, 3, 31);

        sqlstr = "SELECT orgncd,reassign_destcd,trn_mod,paybas,convert(varchar,dockdt,103) AS dockdate FROM webx_master_docket WHERE dockno='" + txtdockno.Text.Trim() + "'";
        sqlstr = sqlstr + " AND dockdt BETWEEN  '" + dtstartfinyear.ToString("dd MMM yyyy") + "' AND '" + dtendfinyear.ToString("dd MMM yyyy") + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        int cnt = 0;
        while (dr.Read())
        {
            hdnpaybas.Value = Convert.ToString(dr["paybas"]);
            hdndockyear.Value = Convert.ToString(dr["dockdate"]).Substring(6, 4);
            hdnorgnloc.Value = Convert.ToString(dr["orgncd"]);
            hdndelloc.Value = Convert.ToString(dr["reassign_destcd"]);
            hdntransmode.Value = Convert.ToString(dr["trn_mod"]);
            cnt++;
        }
        dr.Close();

        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + txtdockno.Text + " doesn't Exists current Financial Year i.e. " + hdnfin_year.Value);
            return;
        }

        sqlstr = "SELECT cancelled FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        string flag = Convert.ToString(cmd.ExecuteScalar());

        if (flag.CompareTo("Y") != 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + txtdockno.Text + " is not Cancelled.");
            return;
        }

        hdnnextmrno.Value = fn.MRNogen(hdnorgnloc.Value);

        trn = con.BeginTransaction();
        try
        {
            sqlstr = "UPDATE webx_trans_docket_status SET cancelled='N' WHERE dockno='" + txtdockno.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "SELECT CONVERT(VARCHAR, pdcdt,103) AS drsdt FROM webx_pdchdr WHERE pdcno=(";
            sqlstr = sqlstr + "SELECT top 1 pdcno FROM webx_pdctrn WHERE dockno='" + txtdockno.Text + "')";
            cmd = new SqlCommand(sqlstr, con, trn);
            string drsdt = Convert.ToString(cmd.ExecuteScalar());

            if (hdnpaybas.Value.CompareTo("P01") == 0)
            {
                
            }
            else if (hdnpaybas.Value.CompareTo("P02") == 0)
            {
                if (hdnclient.Value.CompareTo("RLL") == 0 || hdnclient.Value.CompareTo("VARUNA") == 0 || hdnclient.Value.CompareTo("ASL") == 0 || hdnclient.Value.Trim().CompareTo("RITCO") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    sqlstr = "usp_TBB_Transaction";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@transNo", "1");
                    cmd.Parameters.AddWithValue("@docNo", txtdockno.Text.Trim());
                    cmd.Parameters.AddWithValue("@finYear", hdnfin_year_2d.Value.Trim());
                    cmd.Parameters.AddWithValue("@entryBy1", hdnemployee.Value.Trim());
                    cmd.Parameters.AddWithValue("@NextVoucherno", "");
                    cmd.ExecuteNonQuery();
                }
            }
            else if (hdnpaybas.Value.CompareTo("P03") == 0)
            {
                // VARUNA HAS ACCOUNTING AT TOPAY MR GENERATION TIME SO CANCEL IN EVERY CASE
                if (hdnclient.Value.CompareTo("VARUNA") == 0 || hdnclient.Value.CompareTo("ASL") == 0 || hdnclient.Value.Trim().CompareTo("RITCO") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    sqlstr = "usp_TOPayMRTransaction";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@transno", "1");
                    cmd.Parameters.Add("@docno", txtdockno.Text.Trim());
                    cmd.Parameters.Add("@docsf", ".");
                    cmd.Parameters.Add("@finyear", hdnfin_year_2d.Value);
                    cmd.Parameters.Add("@entryby1", Session["empcd"].ToString());
                    cmd.Parameters.Add("@nextvoucherno", "");
                    cmd.ExecuteNonQuery();
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

    protected void generateMR()
    {
        SqlCommand cmd;
        string strcsgncd, strcsgnname, strcsgnnm, strcsgnaddr, strcsgnpin, strcsgnphone, strdockdate, strmrno;
        string strorgnloc, strdelloc, stredd, strpkgsno, strchargedweight, strpaybas;
        string strdkttot, strsubtotal, strsvctax, strcess, strheducess;
        string sqlstr = "SELECT CONVERT(VARCHAR,dockdt,103) AS dockdate,orgncd AS orgnloc,cdeldt,";
        sqlstr = sqlstr + "destcd AS delloc,pkgsno,paybas,chrgwt,";
        sqlstr = sqlstr + "subtotal,svctax,cess,hedu_cess,dkttot,";
        sqlstr = sqlstr + "csgncd,csgnnm,csgnaddr,csgnpincode,csgnteleno FROM webx_master_docket d, webx_master_docket_charges c WHERE d.dockno=c.dockno AND d.dockno='" + txtdockno.Text.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con, trn);
        DataTable dt_docket = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt_docket);

        strdockdate = Convert.ToString(dt_docket.Rows[0]["dockdate"].ToString());
        strcsgncd = Convert.ToString(dt_docket.Rows[0]["csgncd"].ToString());

        strsubtotal = Convert.ToString(dt_docket.Rows[0]["subtotal"].ToString());
        strsvctax = Convert.ToString(dt_docket.Rows[0]["svctax"].ToString());
        strcess = Convert.ToString(dt_docket.Rows[0]["cess"].ToString());
        strheducess = Convert.ToString(dt_docket.Rows[0]["hedu_cess"].ToString());
        strdkttot = Convert.ToString(dt_docket.Rows[0]["dkttot"].ToString());

        strpaybas = Convert.ToString(dt_docket.Rows[0]["paybas"].ToString());
        strcsgnnm = fn.Getcustomer(dt_docket.Rows[0]["csgncd"].ToString());
        strcsgnname = Convert.ToString(dt_docket.Rows[0]["csgnnm"].ToString());
        strcsgnaddr = Convert.ToString(dt_docket.Rows[0]["csgnaddr"].ToString());
        strcsgnpin = Convert.ToString(dt_docket.Rows[0]["csgnpincode"].ToString());
        strcsgnphone = Convert.ToString(dt_docket.Rows[0]["csgnteleno"].ToString());
        strorgnloc = Convert.ToString(dt_docket.Rows[0]["orgnloc"].ToString());
        strdelloc = Convert.ToString(dt_docket.Rows[0]["delloc"].ToString());
        stredd = Convert.ToString(dt_docket.Rows[0]["cdeldt"].ToString());
        strpkgsno = Convert.ToString(dt_docket.Rows[0]["pkgsno"].ToString());
        strchargedweight = Convert.ToString(dt_docket.Rows[0]["chrgwt"].ToString());
        strcsgnnm = strcsgnnm.Replace("'", " ");
        strcsgnname = strcsgnname.Replace("'", " ");
        strcsgnaddr = strcsgnaddr.Replace("'", " ");

        // THESE VARIABLE ARE BULK MAY BE USED IF DOCKET FINANCE ENTRY CHANGE
        double deductionamt = 0, othercharge = 0, diplomatcharge = 0; //diplomatcharge=odacharge
        double deliverycharge = 0, tdscharge = 0, deducationonaccount = 0, otherdeduction = 0;
        string sqlmr = "INSERT INTO webx_mr_hdr ";
        sqlmr = sqlmr + "(entryby,entrydt,mrsno,mrssf, mrsdt, mrstype, mrsbr, mrbrnnm, dockno, docksf,";
        sqlmr = sqlmr + " dockdt, dockdlydt, ptcd, ptname, ptpin, pttel, ptadd, orgncd, docbknm, destcd,";
        sqlmr = sqlmr + " docdlnm, nopkgs, chrgwt, paybas, delbasd, mrsamt, netamt, deduction,mrs_closed,";
        sqlmr = sqlmr + "ba_emp_cd,ba_emp_nm,rebook_flag,mrcollbrcd)"; ;
        sqlmr = sqlmr + " VALUES ('" + hdnemployee.Value.Trim() + "','" + fn.Mydate1(strdockdate) + "', '" + hdnnextmrno.Value + "','.','" + fn.Mydate1(strdockdate) + "', '1' ,";
        sqlmr = sqlmr + "'" + strorgnloc + "', '" + fn.GetLocation(strorgnloc) + "',";
        sqlmr = sqlmr + "'" + txtdockno.Text.Trim() + "','.','" + fn.Mydate1(strdockdate) + "',";
        sqlmr = sqlmr + "'" + stredd + "',";
        if (strcsgncd.CompareTo("") == 0 || strcsgncd.CompareTo("8888") == 0)
        {
            sqlmr = sqlmr + "'8888','" + strcsgnname + "',";
        }
        else
        {
            sqlmr = sqlmr + "'" + strcsgncd + "','" + strcsgnnm + "',";
        }

        sqlmr = sqlmr + "'" + strcsgnpin + "',";
        sqlmr = sqlmr + "'" + strcsgnphone + "','" + strcsgnaddr + "',";
        sqlmr = sqlmr + "'" + strorgnloc + "','" + fn.GetLocation(strorgnloc) + "',";
        sqlmr = sqlmr + "'" + strdelloc + "','" + fn.GetLocation(strdelloc) + "',";
        sqlmr = sqlmr + "'" + strpkgsno + "','" + strchargedweight + "',";
        sqlmr = sqlmr + "'" + strpaybas + "',";
        sqlmr = sqlmr + "'" + fn.Getpaybas(strpaybas) + "', '" + strdkttot + "',";
        sqlmr = sqlmr + "'" + strdkttot + "','" + deductionamt + "','N','0','" + fn.GetEmpName(hdnemployee.Value.Trim()) + "',";
        sqlmr = sqlmr + "'N', '" + strorgnloc + "')";
        cmd = new SqlCommand(sqlmr, con, trn);
        cmd.ExecuteNonQuery();

        //
        sqlmr = "UPDATE webx_mr_hdr SET col_frt=" + strsubtotal + ",col_oth=" + othercharge + ",";
        sqlmr = sqlmr + "col_stax=" + strsvctax + ",col_dlychg=" + deliverycharge + ",ded_tds=" + tdscharge + ",";
        sqlmr = sqlmr + "ded_onac=" + deducationonaccount + ",ded_oth=" + otherdeduction + ",diplomatchg=" + diplomatcharge + ",delserchrg_ded=0,";
        sqlmr = sqlmr + "diplomatchg_ded=0,col_cess=" + strcess + ",col_h_cess=" + strheducess + ",";
        sqlmr = sqlmr + "svctax_rate=12,cess_rate=2,";
        sqlmr = sqlmr + "h_cess_rate=1";
        sqlmr = sqlmr + " WHERE mrsno='" + hdnnextmrno.Value + "'";
        cmd = new SqlCommand(sqlmr, con, trn);
        cmd.ExecuteNonQuery();

        sqlmr = "UPDATE webx_trans_docket_status SET MR='Y' WHERE dockno='" + txtdockno.Text.Trim() + "'";
        cmd = new SqlCommand(sqlmr, con, trn);
        cmd.ExecuteNonQuery();

        sqlmr = "EXEC usp_paidmrtransaction 1,'" + txtdockno.Text.Trim() + "','" + hdnfin_year_2d.Value + "','" + hdnemployee.Value.Trim() + "',''";
        cmd = new SqlCommand(sqlmr, con, trn);
        cmd.ExecuteNonQuery();
    }


}
