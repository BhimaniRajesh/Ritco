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

public partial class GUI_UNI_MIS_Loc_Performance_Query : System.Web.UI.Page
{
    DataSet ds;
    SqlDataAdapter da;
    string Report_Type;
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
            Location();
            cboSelLoc.Items.Insert(0, "All");
            rbtLoc.Checked = true;
        }
    }

    private void Location()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        da = new SqlDataAdapter("select LocName+' : '+ LocCode as Location,LocCode as Code from webx_location where Loc_Level='2' Order By LocName", conn);
        da.Fill(ds, "webx_location");
        cboSelRo.DataSource = ds;
        cboSelRo.DataTextField = "Location";
        cboSelRo.DataValueField = "Code";
        cboSelRo.DataBind();
        cboSelRo.Items.Insert(0,"All");
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
            righnow = righnow.AddDays(-30);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
    }

    public void ToDate(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
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
    protected void btnShowLoc_OnClick(object sender, EventArgs e)
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

            string Ro_Code = cboSelRo.SelectedItem.Value;
            string Loc_Code = cboSelLoc.SelectedItem.Value;
            string RO = cboSelRo.SelectedItem.Text;
            string Location = cboSelLoc.SelectedItem.Text;
            

            if (rbtLoc.Checked == true)
            {
                Report_Type = "1";
            }
            if (rbtNotBook.Checked == true)
            {
                Report_Type = "2";
            }
            if (rbtBoth.Checked == true)
            {
                Report_Type = "3";
            }

            Response.Redirect("Loc_Performance_Rpt.aspx?Report_Type=" + Report_Type + "&RO=" + RO + "&Location=" + Location + "&Ro_Code=" + Ro_Code + "&Loc_Code=" + Loc_Code + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
        }
    }

    protected void cboSelRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        string LocCode = cboSelRo.SelectedItem.Value;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        string Sql = "select LocName+' : '+ LocCode as Location,LocCode from webx_location where Report_Loc='" + LocCode + "'";
        da = new SqlDataAdapter(Sql, conn);
        da.Fill(ds, "webx_location");
        cboSelLoc.DataSource = ds;
        cboSelLoc.DataTextField = "Location";
        cboSelLoc.DataValueField = "LocCode";
        cboSelLoc.DataBind();
        cboSelLoc.Items.Insert(0, "All");
    }
    protected void rbtLoc_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtLoc.Checked == true)
        {
            rbtLoc.Checked = true;
            rbtNotBook.Checked = false;
            rbtBoth.Checked = false;
        }
    }
    protected void rbtNotBook_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtNotBook.Checked == true)
        {
            rbtLoc.Checked = false;
            rbtNotBook.Checked = true;
            rbtBoth.Checked = false;
        }
    }
    protected void rbtBoth_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtBoth.Checked == true)
        {
            rbtLoc.Checked = false;
            rbtNotBook.Checked = false;
            rbtBoth.Checked = true;
        }
    }
}
