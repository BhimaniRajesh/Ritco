using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_UNI_MIS_Account_Reports_Trail_balance_Popup_trailBalance : System.Web.UI.Page
{
    SqlConnection conn;
    public static string dockno, st_frmdt, st_todt, st_loccode,rpt_typ, st_acccode, st_tcnm;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            dockno = Request.QueryString["dockno"].ToString();
            string[] dockno_arr = dockno.Split('~');
            st_frmdt = dockno_arr[0].ToString();
            st_tcnm = dockno_arr[2].ToString();
            st_todt = dockno_arr[1].ToString();
            st_loccode = dockno_arr[3].ToString();
            st_acccode = dockno_arr[4].ToString();
            rpt_typ = dockno_arr[5].ToString();

        }

        string sql_poptb = "exec Webx_profir_Loss_det_Net '" + st_tcnm + "','" + st_frmdt + "','" + st_todt + "','" + st_loccode + "','" + st_acccode + "'";
        //Response.Write("<br> sql_poptb : " + sql_poptb);
        SqlCommand cmd = new SqlCommand(sql_poptb, conn);
        SqlDataReader dr = cmd.ExecuteReader();


        TableRow tr1 = new TableRow();

        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();
        TableCell tr1tc3 = new TableCell();

        tr1tc1.Text = "Acc. Code";
        tr1tc1.CssClass = "blackboldfnt";
        tr1tc1.HorizontalAlign = HorizontalAlign.Center;
        tr1tc1.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc1);

        tr1tc2.Text = "Acc. Name";
        tr1tc2.CssClass = "blackboldfnt";
        tr1tc2.HorizontalAlign = HorizontalAlign.Center;
        tr1tc2.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc2);

        tr1tc3.Text = "Amt.";
        tr1tc3.CssClass = "blackboldfnt";
        tr1tc3.HorizontalAlign = HorizontalAlign.Center;
        tr1tc3.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc3);

        tblTBalance.Rows.Add(tr1);
        string s_scode, s_acodesc;
        double s_amt = 0, TOTAMT = 0;
        while (dr.Read()) 
        {
            TableRow tr2 = new TableRow();

            TableCell tr2tc1 = new TableCell();
            TableCell tr2tc2 = new TableCell();
            TableCell tr2tc3 = new TableCell();

            s_scode = dr["acccode"].ToString();
            s_acodesc = dr["accdesc"].ToString();
            s_amt = Convert.ToDouble(dr["Acc_total_fin"]);
            TOTAMT += s_amt;
            tr2tc1.Text = s_scode;
            tr2tc1.CssClass = "blackfnt";
            tr2tc1.HorizontalAlign = HorizontalAlign.Center;
            tr2tc1.Wrap = false;
            
            tr2.Cells.Add(tr2tc1);

            tr2tc2.Text = s_acodesc;
            tr2tc2.CssClass = "blackfnt";
            tr2tc2.HorizontalAlign = HorizontalAlign.Center;
            tr2tc2.Wrap = false;
            tr2.CssClass = "bgbluegrey";
            tr2.Cells.Add(tr2tc2);


            string popstr1 = "branch=" + st_loccode + "&strdlstSalesAmount=" + s_scode + "&dateFrom=" + st_frmdt + "&dateTo=" + st_todt + "&strdlstTranType=" + rpt_typ;
           
                      

            tr2tc3.Text = s_amt.ToString("F2");
            tr2tc3.Text = "<a href=\"JavaScript:OpenPopupWindow2('" + popstr1 + "')\"><u><font class='bluefnt'>" + s_amt.ToString("F2") + "</font> </u></a>";
            tr2tc3.CssClass = "blackfnt";
            tr2tc3.HorizontalAlign = HorizontalAlign.Right;
            tr2tc3.Wrap = false;
            tr2.CssClass = "bgbluegrey";
            tr2.Cells.Add(tr2tc3);

            tr2.BackColor = System.Drawing.Color.White;
            tblTBalance.Rows.Add(tr2);
        }


        TableRow tr3 = new TableRow();

        TableCell tr3tc1 = new TableCell();
        TableCell tr3tc3 = new TableCell();

        tr3tc1.Text = "Total";
        tr3tc1.CssClass = "blackboldfnt";
        tr3tc1.HorizontalAlign = HorizontalAlign.Right;
        tr3tc1.Wrap = false;
        tr3tc1.ColumnSpan = 2;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3tc1);

        tr3tc3.Text = TOTAMT.ToString("F2");
        tr3tc3.CssClass = "blackfnt";
        tr3tc3.HorizontalAlign = HorizontalAlign.Right;
        tr3tc3.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3tc3);

        tr3.BackColor = System.Drawing.Color.White;
        tblTBalance.Rows.Add(tr3);

        conn.Close();
    }
}
