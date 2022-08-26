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
            Transit();
            TransitNext();
            rbtFixRpt.Checked = true;
            txtDateDiff1.Enabled = false;
            txtDateDiff2.Enabled = false;
            cboSelLoc.Items.Insert(0, "All");
            cboNextLoc.Items.Insert(0, "All");
        }
    }

    private void TransitNext()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //ds = new DataSet();
        //da = new SqlDataAdapter("select LocName+' : '+ LocCode as Location,LocCode as Code from webx_location where Loc_Level='2' Order By LocName", conn);
        //da.Fill(ds, "webx_location");
        //cboNextRo.DataSource = ds;
        //cboNextRo.DataTextField = "Location";
        //cboNextRo.DataValueField = "Code";
        //cboNextRo.DataBind();
        //cboNextRo.Items.Insert(0, "All");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        brcd = Session["brcd"].ToString();
        sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        dread.Close();

        if (loclevel == 1)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        cboNextRo.DataSource = ds;
        cboNextRo.DataTextField = "Location";
        cboNextRo.DataValueField = "loccode";
        cboNextRo.DataBind();
        cboNextRo.Items.Insert(0, "All");
    }

    private void Transit()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //ds = new DataSet();
        //da = new SqlDataAdapter("select LocName+' : '+ LocCode as Location,LocCode as Code from webx_location where Loc_Level='2' Order By LocName", conn);
        //da.Fill(ds, "webx_location");
        //cboSelRo.DataSource = ds;
        //cboSelRo.DataTextField = "Location";
        //cboSelRo.DataValueField = "Code";
        //cboSelRo.DataBind();
        //cboSelRo.Items.Insert(0, "All");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        brcd = Session["brcd"].ToString();
        sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        dread.Close();

        if (loclevel == 1)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        cboSelRo.DataSource = ds;
        cboSelRo.DataTextField = "Location";
        cboSelRo.DataValueField = "loccode";
        cboSelRo.DataBind();
        cboSelRo.Items.Insert(0, "All");
    }
    protected void cboSelRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string LocCode = cboSelRo.SelectedItem.Value;
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //ds = new DataSet();
        //string Sql = "select LocName+' : '+ LocCode as Location,LocCode from webx_location where Report_Loc='" + LocCode + "'";
        //da = new SqlDataAdapter(Sql, conn);
        //da.Fill(ds, "webx_location");
        //cboSelLoc.DataSource = ds;
        //cboSelLoc.DataTextField = "Location";
        //cboSelLoc.DataValueField = "LocCode";
        //cboSelLoc.DataBind();
        //cboSelLoc.Items.Insert(0, "All");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        brcd = Session["brcd"].ToString();
        conn.Open();
        if (loclevel <= 2)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where report_loc='" + cboSelRo.SelectedValue.ToString() + "' or loccode='" + cboSelRo.SelectedValue.ToString() + "'", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        cboSelLoc.DataSource = ds;
        cboSelLoc.DataTextField = "Location";
        cboSelLoc.DataBind();
        cboSelLoc.Items.Insert(0, "All");
        conn.Close();
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
        string RoCode = cboSelRo.SelectedItem.Value;
        string LocCode = cboSelLoc.SelectedItem.Value;
        string NextRo = cboNextRo.SelectedItem.Value;
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
        //string NextCode = cboNextRo.SelectedItem.Value;
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //ds = new DataSet();
        //string Sql = "select LocName+' : '+ LocCode as Location,LocCode from webx_location where Report_Loc='" + NextCode + "'";
        //da = new SqlDataAdapter(Sql, conn);
        //da.Fill(ds, "webx_location");
        //cboNextLoc.DataSource = ds;
        //cboNextLoc.DataTextField = "Location";
        //cboNextLoc.DataValueField = "LocCode";
        //cboNextLoc.DataBind();
        //cboNextLoc.Items.Insert(0, "All");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        brcd = Session["brcd"].ToString();
        conn.Open();
        if (loclevel <= 2)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where report_loc='" + cboNextRo.SelectedValue.ToString() + "' or loccode='" + cboNextRo.SelectedValue.ToString() + "'", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        cboNextLoc.DataSource = ds;
        cboNextLoc.DataTextField = "Location";
        cboNextLoc.DataBind();
        cboNextLoc.Items.Insert(0, "All");
        conn.Close();
    }
}
