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

public partial class GUI_Finance_MoneyRecpt_MoneyRecieptMr_xls : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mrno = Request.QueryString["mrno"].ToString();
        string printyn=Request.QueryString["printyn"].ToString();

        string boxbg, bgbluegrey;

        if (printyn.CompareTo("1") == 1)
        {
            boxbg = "std";
            bgbluegrey = "bgwhite";
        }

        string sql = "SELECT convert(varchar,mrsdt,106) as mrsdt,convert(varchar,dockdt,106) as dockdt,* FROM webx_mr_hdr WHERE mrsno='" + mrno + "' UNION SELECT convert(varchar,mrsdt,106) as mrsdt,convert(varchar,dockdt,106) as dockdt,* FROM webx_mr_hdr_arch WHERE mrsno='" + mrno + "'";
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblmrno.Text = dr["mrsno"].ToString();
            lblmrdate.Text = dr["mrsdt"].ToString();
            lblmrtype.Text = dr["mrstype"].ToString();
            lblmrbranch.Text = dr["mrsbr"].ToString() + " : " + dr["mrbrnnm"].ToString();
            lbldocketno.Text = dr["dockno"].ToString();
            lbldocketdate.Text = dr["dockdt"].ToString();
            lblparty.Text = dr["ptcd"].ToString() + " : " + dr["ptname"].ToString();
            lblbookbranch.Text = dr["orgncd"].ToString() + " : " + dr["docbknm"].ToString();
            lbldelbranch.Text = dr["destcd"].ToString() + " : " + dr["docdlnm"].ToString();
            lblpackno.Text = dr["nopkgs"].ToString();
            lblchrgweight.Text = dr["chrgwt"].ToString();

            lblfreightamt.Text = dr["col_frt"].ToString();
            if (dr["col_frt"].ToString().CompareTo("") == 0)
                lblfreightamt.Text = "0";

            lbltdsrate.Text = dr["tds_rate"].ToString();
            
            lblsertax.Text = dr["col_stax"].ToString();
            if (dr["col_stax"].ToString().CompareTo("") == 0)
                lblsertax.Text = "0";


            lbltdsamt.Text = dr["ded_tds"].ToString();

            lblothded.Text = dr["ded_oth"].ToString();
            if (dr["ded_oth"].ToString().CompareTo("") == 0)
                lblothded.Text = "0";

            if (dr["ded_tds"].ToString().CompareTo("")==0)
                lblothded.Text = "0";

            double tot = Convert.ToDouble(dr["miscchrg"].ToString()) + Convert.ToDouble(dr["col_stax"].ToString()) + Convert.ToDouble(dr["col_frt"].ToString());
            lbltotal.Text = tot.ToString();

            double nettot = tot - Convert.ToDouble(dr["ded_tds"].ToString()) + Convert.ToDouble(dr["ded_oth"].ToString());
            lblnetamt.Text = nettot.ToString();

            if(dr["mrscash"].ToString().CompareTo("")==0)
                lblcolamt.Text = dr["mrscash"].ToString();
            else
                lblcolamt.Text = dr["mrschq"].ToString();

            lblremark.Text = dr["remark"].ToString();

        }
        dr.Close();



        //string sq = "select docno,docsf,chqno,chqdt,chqamt,clamt,banknm,bankbrn from webx_billchqdetail where docno='" & mrsno & "'";
        //cmd = new SqlCommand(sq, con);
        //dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
            



        //}
        //dr.Close();
    }
}
