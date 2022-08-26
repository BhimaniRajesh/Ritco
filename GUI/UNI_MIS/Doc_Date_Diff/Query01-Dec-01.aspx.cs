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

public partial class GUI_Doc_Date_Diff_Query : System.Web.UI.Page
{
    int loclevel;
    public string brcd = "";
    string sqlstr = "";
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!(Page.IsPostBack))
        {
            DateDiff();
            rbtFixRpt.Checked = true;
            txtDateDiff1.Enabled = false;
            txtDateDiff2.Enabled = false;
            cboSelLoc.Items.Insert(0, "All");
        }
    }

    private void DateDiff()
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
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
        if (rbl.Items[3].Selected)
        {
            //strrightnow = "01/01/1950";
            //txtDateFrom.Text = strrightnow;
            righnow = righnow.AddDays(-30);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
    }

    public void ToDate(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    protected void btnShowDateDiff_OnClick(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);

            string Ro = cboSelRo.SelectedItem.Text;
            string RoCode = cboSelRo.SelectedItem.Value;
            string Loc = cboSelLoc.SelectedItem.Text;
            string LocCode = cboSelLoc.SelectedItem.Value;
            string DateDiff = cboDateDiff.SelectedItem.Value;

            if (rbtFixRpt.Checked == true)
            {
                Response.Redirect("Date_Diff_FixRpt.aspx?LocCode=" + LocCode + "&RoCode=" + RoCode + "&Ro=" + Ro + "&Loc=" + Loc + "&DateType=" + DateDiff + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
            }
            else
            {               
                Response.Redirect("Date_Diff_DayRpt.aspx?FromDt=" + txtDateDiff1.Text + "&ToDt=" + txtDateDiff2.Text + "&LocCode=" + LocCode + "&RoCode=" + RoCode + "&Ro=" + Ro + "&Loc=" + Loc + "&DateType=" + DateDiff + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
            }
        }
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
}
