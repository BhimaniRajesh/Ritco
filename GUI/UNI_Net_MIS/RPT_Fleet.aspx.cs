using System;
using System.Data;
using System.Data.SqlClient;
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


public partial class GUI_UNI_Net_MIS_RPT_Fleet : System.Web.UI.Page
{
    SqlConnection conn;
    public static string brcd, empcd;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        String sqlstr = "select srno,report_name,Link as link_name,'' as link_title,Descp as discription,Subtitle from webx_reports_ver1 where  title='FT' and srno in (select reportid from Webx_Master_ReportsAccess_ver1 where HasAccess='Y' and Userid='" + empcd + "') and activeflag='Y' order by Subtitle, Report_Name";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        string st_subtitle = "", st_subtitlenm = "", PreVst_subtitle = "", st_reportname = "", st_discription = "", st_linkname = "", st_linktitle = "";
        int i = 0;

        while (dr.Read())
        {
            st_subtitle = dr["Subtitle"].ToString();

            st_reportname = dr["report_name"].ToString();

            if (dr["link_title"] != null)
            {
                st_linktitle = dr["link_title"].ToString();
            }

            if (st_linktitle != "")
            {
                st_linktitle = "(" + dr["link_title"].ToString() + ")";
            }
            st_linkname = dr["link_name"].ToString();
            st_linkname = st_linkname + "?RPTID=" + dr["srno"].ToString(); // changed by Manisha 20/5/2014

            st_discription = dr["discription"].ToString();


            if (st_subtitle.ToUpper() == "FT1")
            {
                st_subtitlenm = "Driver Reports";
            }
            if (st_subtitle.ToUpper() == "FT2")
            {
                st_subtitlenm = "Fuel Reports";
            }
            if (st_subtitle.ToUpper().Trim() == "FT3".Trim())
            {
                st_subtitlenm = "Maintenance Reports";
            }
            if (st_subtitle.ToUpper() == "FT4")
            {
                st_subtitlenm = "Tripsheet Reports";
            }
            if (st_subtitle.ToUpper() == "FT5")
            {
                st_subtitlenm = "Tyre  Reports";
            }
            if (st_subtitle.ToUpper() == "FT6")
            {
                st_subtitlenm = "Vehicle  Reports";
            }
            if (st_subtitle.ToUpper() == "FT7")
            {
                st_subtitlenm = "Vendor  Reports";
            }
			if (st_subtitle.ToUpper() == "FT8")
            {
                st_subtitlenm = "CPKM  Reports";
            }
            if (st_subtitle != PreVst_subtitle)
            {
                i = 1;

                TableRow tr2 = new TableRow();

                TableCell tr2tc1 = new TableCell();
                TableCell tr2tc2 = new TableCell();
                TableCell tr2tc3 = new TableCell();

                tr2tc1.Text = "Sr No.";
                tr2tc1.CssClass = "blackboldfnt";
                tr2tc1.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc1);

                tr2tc2.Text = st_subtitlenm;
                tr2tc2.CssClass = "blackboldfnt";
                tr2tc2.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc2);

                tr2tc3.Text = "Description";
                tr2tc3.CssClass = "blackboldfnt";
                tr2tc3.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc3);
                tblRptOpn.Rows.Add(tr2);


            }

            st_linktitle = "";
            TableRow tr3 = new TableRow();

            TableCell tr3tc1 = new TableCell();
            TableCell tr3tc2 = new TableCell();
            TableCell tr3tc3 = new TableCell();

            tr3tc1.Text = i.ToString();
            tr3tc1.CssClass = "blackfnt";
            tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc1);

            tr3tc2.Text = "<a href=\"" + st_linkname + "\" > " + st_reportname + "</a> <font color='#FF0000'>&nbsp;" + st_linktitle + "</font>";
            tr3tc2.CssClass = "blackfnt";
            tr3tc2.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc2);

            tr3tc3.Text = st_discription;
            tr3tc3.CssClass = "blackfnt";
            tr3tc3.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc3);

            tr3.BackColor = System.Drawing.Color.White;

            tblRptOpn.Rows.Add(tr3);

            PreVst_subtitle = dr["Subtitle"].ToString();

            i = i + 1;
        }

        dr.Close();

        if (i == 0)
        {
            tblnorec.Visible = true;
        }
        conn.Close();
    }
}
