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

public partial class GUI_Octroi_Octroi_Bill_ManualOctroiMr_viewPrint : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public static double octtot;
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        string mrno = Request.QueryString["mrno"].ToString();
        
        lblmrno.Text= mrno;
        Ptrinyn = Request.QueryString["printyn"].ToString();
      
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";
        if (Ptrinyn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }
        gvagentpayvoucher.HeaderStyle.CssClass = bgbluegrey;
        gvagentpayvoucher.CssClass = boxbg;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sqlqry = "SELECT convert(varchar,mrsdt,106) as mrsdt,* FROM Vw_MR_details WHERE mrsno='" + mrno + "'";
        SqlCommand cmd = new SqlCommand(sqlqry);
        cmd.Connection = con;
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblmrno.Text=dr["mrsno"].ToString();
            lblmrdate.Text=dr["mrsdt"].ToString();
            lblmrtype.Text = dr["mrstype"].ToString();
            lblmrbranch.Text = dr["mrsbr"].ToString() + " ~ " + fn.GetLocation(dr["mrsbr"].ToString());
            lblparty.Text = dr["ptcd"].ToString() + " ~ " + dr["ptname"].ToString();
            lblbookbranch.Text = dr["orgncd"].ToString() + " ~ " + fn.GetLocation(dr["orgncd"].ToString());
            lbldelbranch.Text = dr["destcd"].ToString() + " ~ " + fn.GetLocation(dr["destcd"].ToString());
        }

        dr.Close();

        string q2 = "select a.dockno,a.mrsamt,convert(varchar,recptdt,106) as recptdt,b.recptno,b.octamt,b.process_chrg,b.oct_percentage,b.clearance_chrg,b.processing_per,b.col_oth from webx_mr_hdr a,webx_mr_det b where a.mrsno=b.mrsno and b.mrsno='" + mrno + "'";
        q2 = q2 + "union select a.dockno,a.mrsamt,convert(varchar,recptdt,106) as recptdt,b.recptno,b.octamt,b.process_chrg,b.oct_percentage,b.clearance_chrg,b.processing_per,b.col_oth from webx_mr_hdr_arch a,webx_mr_det_arch b where a.mrsno=b.mrsno and b.mrsno='" + mrno + "'";
        SqlCommand cmd1 = new SqlCommand(q2, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvagentpayvoucher.DataSource = ds;
        gvagentpayvoucher.DataBind();



        string q3 = "select top 11 mrsamt,tds_rate,isnull(col_stax,0) as col_stax,isnull(ded_tds,0) as ded_tds,remark,tdsaccdesc,miscchrg,isnull(mrschq,0) as mrschq,isnull(mrscash,0) as mrscash,ded_oth,paymode,netamt from webx_mr_hdr_arch where mrsno='" + mrno + "'";
        SqlCommand cmd2 = new SqlCommand(q3, con);
        SqlDataReader dr1;
        dr1 = cmd2.ExecuteReader();

        while (dr1.Read())
        { 
            lblmramt.Text=dr1["mrsamt"].ToString();
            lbltdsrate.Text = dr1["tds_rate"].ToString();
            lblsertax.Text = dr1["col_stax"].ToString();
            lbltdsamt.Text = dr1["ded_tds"].ToString();
            lbltdstype.Text = dr1["tdsaccdesc"].ToString();

            lbltotal.Text = Convert.ToString(Convert.ToDouble(dr1["col_stax"].ToString()) + Convert.ToDouble(dr1["mrsamt"].ToString()));
            lblothded.Text = dr1["ded_oth"].ToString();
            lblpaymode.Text = dr1["paymode"].ToString();
            lblothamt.Text = dr1["miscchrg"].ToString();
            lblnetamt.Text = dr1["netamt"].ToString();
            if(Convert.ToDouble(dr1["mrscash"].ToString())!=0)
            {
                lblcolamt.Text = dr1["mrscash"].ToString();
            }
            else if (Convert.ToDouble(dr1["mrschq"].ToString())!=0)
            {
                lblcolamt.Text = dr1["mrschq"].ToString();
            }

            lblremark.Text = dr1["remark"].ToString();
           
        
        }

        dr1.Close();

        con.Close();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvagentpayvoucher_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    

}
