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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;

public partial class GUI_Tracking_New_TAB_Tracking_Docket_Docket_Fin_Cycle : System.Web.UI.Page
{
    public static string dockno,lf_dockno, lf_Gen_oct ,call_dkt, dkt, lf_docksf, lf_orgncd, lf_orgnnm, lf_destcd, lf_destnm, lf_re_destcd, lf_re_destnm, lf_paybas, lf_paybasnm, lf_dockdt, lf_dockdt_f, lf_book_cum_days, lf_msg_b, lf_bgndt, lf_bgndt_f, lf_bill_cum_days, lf_billno, lf_billsubbrcd, lf_msg_sun, lf_bsbdt, lf_bsbdt_f, lf_billsub_cum_days, lf_billcolbrcd, lf_billmrcol_cum_days, lf_mrsdt, lf_mrsdt_f, lf_mrsno, lf_mrssf, lf_mr_cum_days, lf_mrcol_cum_days, lf_finclosedt, lf_finclosedt_f, lf_msg_mrcoll, lf_billcolbrnm, lf_billsubbrnm, IF_MRSNOYN;
    public static SqlDataReader dr2, dr3;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        dockno = Request.QueryString["dockno"].ToString();
        string sqlstr3 = "WEBX_LifeCycle_Fin";
        SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd3);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        dr3 = cmd3.ExecuteReader();
        while (dr3.Read())
        {
            //public static string lf_dockno, lf_docksf, lf_orgncd, lf_destcd, lf_re_destcd, 
            //lf_paybas, lf_dockdt, lf_book_cum_days, 
            //lf_msg_b, lf_bgndt, lf_bill_cum_days, lf_billno, lf_billsubbrcd, msg_sun,
            //lf_bsbdt, lf_billsub_cum_days, lf_billcolbrcd,
            //lf_mrsdt, lf_mrsno,lf_mrssf,
            //lf_mr_cum_days,lf_mrcol_cum_days,lf_finclosedt,lf_msg_coll;
            lf_dockno = Convert.ToString(dr3["dockno"]);
            lf_docksf = Convert.ToString(dr3["docksf"]);
            lf_orgncd = Convert.ToString(dr3["orgncd"]);
            lf_orgnnm = getname(Convert.ToString(dr3["orgncd"]));
            lf_destcd = Convert.ToString(dr3["destcd"]);
            lf_destnm = getname(Convert.ToString(dr3["destcd"]));
            lf_re_destcd = Convert.ToString(dr3["reassign_destcd"]);
            lf_re_destnm = getname(Convert.ToString(dr3["reassign_destcd"]));
            lf_paybas = Convert.ToString(dr3["paybas"]);
            lf_paybasnm = GetPayMode(Convert.ToString(dr3["paybas"]));
            if (dr3["dockdt"] != System.DBNull.Value)
            {
                lf_dockdt = Convert.ToString(dr3["dockdt"]);
                lf_dockdt_f = Convert.ToDateTime(dr3["dockdt"]).ToString("dd MMM yy");
            }
            if ((lf_dockdt != null) && (lf_dockdt != ""))
            {
                lf_book_cum_days = datedifferance(lf_dockdt, lf_dockdt);
            }
            lf_msg_b = Convert.ToString(dr3["tbb_bill"]) == "Y" ? "Yes" : "No";
            if (dr3["bgndt"] != System.DBNull.Value)
            {
                lf_bgndt = Convert.ToString(dr3["bgndt"]);
                lf_bgndt_f = Convert.ToDateTime(dr3["bgndt"]).ToString("dd MMM yy");
            }

            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_bgndt != "") && (lf_bgndt != ""))
            {
                lf_bill_cum_days = datedifferance(lf_dockdt, lf_bgndt);
            }
            lf_billno = Convert.ToString(dr3["billno"]);
            lf_billsubbrcd = Convert.ToString(dr3["billsubbrcd"]);
            lf_billsubbrnm = getname(Convert.ToString(dr3["billsubbrcd"]));
            if (dr3["bsbdt"] != System.DBNull.Value)
            {
                lf_bsbdt = Convert.ToString(dr3["bsbdt"]);
                lf_bsbdt_f = Convert.ToDateTime(dr3["bsbdt"]).ToString("dd MMM yy");
            }
            //lf_bsbdt = Convert.ToString(dr3["bsbdt"]);

            lf_msg_sun = Convert.ToString(dr3["bsbdt"] == System.DBNull.Value ? "No" : "Yes");
            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_bsbdt != null) && (lf_bsbdt != ""))
            {
                lf_billsub_cum_days = datedifferance(lf_dockdt, lf_bsbdt);
            }
            lf_billcolbrcd = Convert.ToString(dr3["billcolbrcd"]);

            if (Convert.ToString(dr3["billcolbrcd"]) != "Y")
                lf_Gen_oct = "No";
            else
                lf_Gen_oct = "Yes";


            lf_billcolbrnm = getname(Convert.ToString(dr3["billcolbrcd"]));
            //lf_mrsdt = Convert.ToString(dr3["thcbr"]);
            //lf_mrsno = Convert.ToString(dr3["thcbr"]);
            //lf_mrssf = Convert.ToString(dr3["thcbr"]);
            //lf_mr_cum_days = Convert.ToString(dr3["thcbr"]);
            //lf_mrcol_cum_days = Convert.ToString(dr3["thcbr"]);
            if (dr3["finclosedt"] != System.DBNull.Value)
            {
                lf_finclosedt = Convert.ToString(dr3["finclosedt"]);
                lf_finclosedt_f = Convert.ToDateTime(dr3["finclosedt"]).ToString("dd MMM yy");
            }
            //lf_finclosedt = Convert.ToString(dr3["finclosedt"]);
            lf_msg_mrcoll = Convert.ToString(dr3["finclosedt"] == System.DBNull.Value ? "No" : "Yes");
            //lf_msg_coll = Convert.ToString(dr3["finclosedt"] == System.DBNull.Value ? "No" : "Yes");

            //}
            //dr3.Close();
            //cmd3 = new SqlCommand("select mrsno,mrsdt,docno,mrstype,mrssf from VW_billMR where DOCNO='" + lf_billno + "'", conn);
            //cmd3.CommandType = CommandType.Text;
            //dr3 = cmd3.ExecuteReader();
            //IF_MRSNOYN = "No";
            //while (dr3.Read())
            //{
            if (dr3["mrsdt"] != System.DBNull.Value)
            {
                lf_mrsdt = Convert.ToString(dr3["mrsdt"]);
                lf_mrsdt_f = Convert.ToDateTime(dr3["mrsdt"]).ToString("dd MMM yy");
            }
            lf_mrsdt = Convert.ToString(dr3["mrsdt"]);
            lf_mrsno = Convert.ToString(dr3["mrsno"]);

            if (lf_mrsno == "")
                IF_MRSNOYN = "No";
            else
                IF_MRSNOYN = "Yes";


            lf_mrssf = ".";// Convert.ToString(dr3["mrssf"]);
            //lf_mr_cum_days = Convert.ToString(dr3["thcbr"]);
            //lf_billmrcol_cum_days = Convert.ToString(dr3["thcbr"]);

            if ((lf_mrsdt != null) && (lf_mrsdt != ""))
            {
                lf_billmrcol_cum_days = datedifferance(lf_mrsdt, lf_mrsdt);
            }

            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_mrsdt != "") && (lf_mrsdt != ""))
            {
                lf_mr_cum_days = datedifferance(lf_dockdt, lf_mrsdt);
            }
            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_finclosedt != "") && (lf_finclosedt != null))
            {
                lf_mrcol_cum_days = datedifferance(lf_dockdt, lf_finclosedt);
            }
            //lf_mrcol_cum_days = Convert.ToString(dr3["thcbr"]);
        }

    }
    protected void GrdLoadUnload_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 3;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 4;
            oTableCell.Text = "Arrivals [In]";
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 4;
            oTableCell.Text = "Departure [Out]";
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 1;
            oTableCell.Text = "";
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
    }
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1, l2, l3, l4, l5, l6, l7, l8;
            l1 = (Label)e.Row.FindControl("lblsta");
            l2 = (Label)e.Row.FindControl("lbleta");
            l3 = (Label)e.Row.FindControl("lblata");
            l4 = (Label)e.Row.FindControl("lblle1");
            l5 = (Label)e.Row.FindControl("lblstd");
            l6 = (Label)e.Row.FindControl("lbletd");
            l7 = (Label)e.Row.FindControl("lblatd");
            l8 = (Label)e.Row.FindControl("lblle2");

            if ((l1.Text == "N-A") && (l2.Text == "N-A") && (l3.Text == "N-A") && (l4.Text == "N-A"))
            {
                e.Row.Cells[3].Controls.Remove(l1);
                e.Row.Cells[3].Controls.Remove(l2);
                e.Row.Cells[3].Controls.Remove(l3);
                e.Row.Cells[3].Controls.Remove(l4);
                e.Row.Cells[3].Text = "N-A";
                e.Row.Cells[3].ColumnSpan = 4;
                //e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;//FromName("#dddddd");  
                //function.Font.Underline = true;
            }

            if ((l5.Text == "N-A") && (l6.Text == "N-A") && (l7.Text == "N-A") && (l8.Text == "N-A"))
            {
                e.Row.Cells[7].Text = "N-A";
                e.Row.Cells[7].ColumnSpan = 4;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.FromName("#dddddd");
                //function.Font.Underline = true;
            }
        }
    }

    protected string getname(string a)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select top 1 locname from webx_location where loccode='" + a + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        string result = Convert.ToString(cmd.ExecuteScalar());
        return result;
    }

    protected string GetPayMode(string a)
    {
        string paybasdesc = "";
        switch (a)
        {
            case "P01":
                return paybasdesc = "Paid";
            case "1":
                return paybasdesc = "Paid";
            case "P02":
                return paybasdesc = "TBB";
            case "2":
                return paybasdesc = "TBB";
            case "P03":
                return paybasdesc = "To Pay";
            case "3":
                return paybasdesc = "To Pay";
            case "P04":
                return paybasdesc = "FOC";
            case "P06":
                return paybasdesc = "Topay Billing";
            case "P07":
                return paybasdesc = "Trial TBB";
            case "P09":
                return paybasdesc = "National";
            case "P08":
                return paybasdesc = "BOD";
            case "4":
                return paybasdesc = "Octroi";
            case "6":
                return paybasdesc = "Misc. MR";
            default:
                return paybasdesc;
        }


    }

    protected string datedifferance(string fromdt, string todt)
    {
        if (fromdt != null && fromdt != "" && todt != null && todt != "")
        {
            Array strsplitfdt, strsplittdt;
            strsplitfdt = fromdt.Split(' ');
            strsplittdt = todt.Split(' ');
            //string[] strDtFrom = strsplitfdt[0].ToString().Split('/');
            string[] strDtFrom = ((string[])(strsplitfdt))[0].Split('/');
            DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[0]), Convert.ToInt16(strDtFrom[1]));
            string[] strDtTo = ((string[])(strsplittdt))[0].Split('/');
            DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[0]), Convert.ToInt16(strDtTo[1]));
            //DateTime dt1 = new DateTime(Convert.ToDateTime(fromdt));
            //DateTime dt2 = new DateTime(Convert.ToDateTime(todt));
            System.TimeSpan diffResult = dt2.Subtract(dt1);
            return Convert.ToString(diffResult.Days);
        }
        else
        {
            return "";
        }
    }


}
    

