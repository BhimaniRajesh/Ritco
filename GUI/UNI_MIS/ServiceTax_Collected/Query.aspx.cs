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
            popRO();
            rbtOutbound.Checked = true;
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
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab1");
        cboSelLoc.DataSource = ds;
        cboSelLoc.DataTextField = "c1";
        cboSelLoc.DataValueField = "loccode";
        cboSelLoc.DataBind();
    }
    protected void cboSelRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
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

            string Ro = "ALL";
            if (cboSelRo.Enabled == false)
            {
            }
            else
            {
                Ro = cboSelRo.SelectedItem.Text;
            }
            string RoCode = "ALL";
            if (cboSelRo.Enabled == false)
            {
            }
            else
            {
                RoCode = cboSelRo.SelectedItem.Value;
            }
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
