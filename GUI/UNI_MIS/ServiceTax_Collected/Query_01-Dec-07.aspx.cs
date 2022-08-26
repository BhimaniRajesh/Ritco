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

public partial class GUI_UNI_MIS_ServiceTax_Collected_Query : System.Web.UI.Page
{
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            ServiceSummary();
            cboSelLoc.Items.Insert(0, "ALL");
            rbtOutbound.Checked = true;
        }
    }
    private void ServiceSummary()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        da = new SqlDataAdapter("select LocName+' : '+ LocCode as Location,LocCode as Code from webx_location where Loc_Level='2' Order By LocName", conn);
        da.Fill(ds, "webx_location");
        cboSelRo.DataSource = ds;
        cboSelRo.DataTextField = "Location";
        cboSelRo.DataValueField = "Code";
        cboSelRo.DataBind();
        cboSelRo.Items.Insert(0, "ALL");
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
        cboSelLoc.Items.Insert(0, "ALL");
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
    protected void btnShowServiceTax_OnClick(object sender, EventArgs e)
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
            string outbo="";

            if (rbtOutbound.Checked == true)
            {
                outbo = "outbo";
            }
            if (rbtInbound.Checked == true)
            {
                outbo = "inbo";
            }

            Response.Redirect("STax_Coll_Rpt.aspx?outbo=" + outbo + "&RoCode=" + RoCode + "&LocCode=" + LocCode + "&Ro=" + Ro + "&Loc=" + Loc + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
        }
    }
    protected void rbtOutbound_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtOutbound.Checked == true)
        {
            rbtInbound.Checked = false;
        }
    }
    protected void rbtInbound_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtInbound.Checked == true)
        {
            rbtOutbound.Checked = false;
        }
    }
}
