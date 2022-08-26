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

public partial class GUI_UNI_MIS_InTransit_report_Query : System.Web.UI.Page
{
    int loclevel;
    public string brcd = "";
    string sqlstr = "";
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            popRO();
            popRO_Next();
            rbtFixRpt.Checked = true;
            txtDateDiff1.Enabled = false;
            txtDateDiff2.Enabled = false;            
        }
    }
    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl <= 2)
        {
            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
                cboSelRo.DataSource = ds;
                cboSelRo.DataTextField = "c1";
                cboSelRo.DataValueField = "c2";
                cboSelRo.DataBind();
                cboSelLoc.Items.Add("All");
            }
            else
            {
                string concat = brcd + " : " + locnm;
                cboSelRo.Items.Clear();
                cboSelRo.Items.Add(concat);
                cboSelRo.DataBind();
                cboSelRo.SelectedItem.Value = brcd;

                popLOC();
            }
        }
        else
        {
            cboSelRo.Enabled = false;
            cboSelLoc.Items.Clear();
            cboSelLoc.Items.Add(brcd);
        }
    }
    public void popLOC()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string strro = cboSelRo.SelectedValue.ToString();
        string sql = "select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab1");
        cboSelLoc.DataSource = ds;
        cboSelLoc.DataTextField = "c1";
        cboSelLoc.DataValueField = "loccode";
        cboSelLoc.DataBind();
        cboSelLoc.Items.Insert(0,"All");
        
    }

    public void popRO_Next()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        conn.Open();

       
                string sql = "select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
                cboNextRo.DataSource = ds;
                cboNextRo.DataTextField = "c1";
                cboNextRo.DataValueField = "c2";
                cboNextRo.DataBind();
                cboNextRo.Items.Insert(0, "All");
               
                popLOC_Next();
               
           
    }
    public void popLOC_Next()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string strro = cboNextRo.SelectedValue.ToString();
        string sql = "select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab1");
        cboNextLoc.DataSource = ds;
        cboNextLoc.DataTextField = "c1";
        cboNextLoc.DataValueField = "loccode";
        cboNextLoc.DataBind();
        cboNextLoc.Items.Insert(0, "All");
    }    
    
    protected void cboSelRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
    }    

    protected void rbtFixRpt_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtFixRpt.Checked == true)
        {
            rbtFixRpt.Checked = true;
            rbtDiff.Checked = false;
            txtDateDiff1.Enabled = false;
            txtDateDiff2.Enabled = false;
        }

    }
    protected void rbtDiff_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtDiff.Checked == true)
        {
            rbtFixRpt.Checked = false;
            rbtDiff.Checked = true;
            txtDateDiff1.Enabled = true;
            txtDateDiff2.Enabled = true;
        }
    }
    protected void btnShowTransit_OnClick(object sender, EventArgs e)
    {
        string RoCode = "ALL";
        if (cboSelRo.Enabled == false)
        {
        }
        else
        {
            RoCode = cboSelRo.SelectedItem.Value;
        }


        string LocCode = cboSelLoc.SelectedItem.Value;       
        string NextRo = "ALL";
        if (cboNextRo.Enabled == false)
        {
        }
        else
        {
            NextRo = cboNextRo.SelectedItem.Value;
        }
        string NextLoc = cboNextLoc.SelectedItem.Value;
        string No_Day = txtDateDiff1.Text;
        string Number_Day = txtDateDiff2.Text;

        if (rbtFixRpt.Checked == true)
        {
            Response.Redirect("Transit_Rpt.aspx?RoCode=" + RoCode + "&LocCode=" + LocCode + "&NextRo=" + NextRo + "&NextLoc=" + NextLoc + "&No_Day=" + "" + "&Number_Day=" + "");
        }
        else
        {
            Response.Redirect("Transit_Rpt.aspx?RoCode=" + RoCode + "&LocCode=" + LocCode + "&NextRo=" + NextRo + "&NextLoc=" + NextLoc + "&No_Day=" + No_Day + "&Number_Day=" + Number_Day);
        }
    }
    protected void cboNextRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC_Next();
    }
}
