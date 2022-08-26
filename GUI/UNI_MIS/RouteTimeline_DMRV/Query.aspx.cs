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

public partial class GUI_UNI_MIS_RouteTimeline_DMRV_Query : System.Web.UI.Page
{
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


        string scr = @"<script>
        function update(elemValue)
        {        
            document.getElementById('ctl00_MyCPH1_txtStartLoc').value=elemValue;        
        }
        </script>";

            Page.RegisterClientScriptBlock("update", scr);
            btnStartLoc.Attributes.Add("onclick", "window.open('TDS_Cust_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        
            string scr1 = @"<script>
                function update1(elemValue)
                {        
                    document.getElementById('ctl00_MyCPH1_txtEndLoc').value=elemValue;        
                }
                </script>";

            Page.RegisterClientScriptBlock("update1", scr1);
            btnEndLoc.Attributes.Add("onclick", "window.open('TDS_Cust_Popup12.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

            string scr2 = @"<script>
                function update2(elemValue)
                {        
                    document.getElementById('ctl00_MyCPH1_txtEnLoc').value=elemValue;        
                }
                </script>";

            Page.RegisterClientScriptBlock("update2", scr2);
        btnLoc.Attributes.Add("onclick", "window.open('TDS_Cust_Popup22.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        if (!(Page.IsPostBack))
        {
            rbtTimeTrack.Checked = true;
            cboStatus.Enabled = false;
        }
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
    protected void btnShowTHCRoute_OnClick(object sender, EventArgs e)
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

            string Trans = cboMode.SelectedItem.Value;

            string StartLoc = txtStartLoc.Text;
            if (StartLoc.ToString() == "")
            {
                StartLoc = "All";
            }
            string EndLoc = txtEndLoc.Text;
            if (EndLoc.ToString() == "")
            {
                EndLoc = "All";
            }
            string Loc = txtEndLoc.Text;
            if(Loc.ToString() == "")
            {
                Loc = "All";
            }
            string THCNO = txtTHCNo.Text;
            if (THCNO != "")
            {
                THCNO = THCNO.Replace(",", "','");
            }
  
            if (rbtTimeTrack.Checked == true)
            {
                Response.Redirect("Route_Track_Rpt.aspx?THCNO=" + THCNO + "&Loc=" + Loc + "&EndLoc=" + EndLoc + "&StartLoc=" + StartLoc + "&Trans=" + Trans + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
            }
            if (rbtRMRV.Checked == true)
            {
                Response.Redirect("Route_RMRV_Rpt.aspx?THCNO=" + THCNO + "&Loc=" + Loc + "&EndLoc=" + EndLoc + "&StartLoc=" + StartLoc + "&Trans=" + Trans + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
            }
            if (rbtRoute.Checked == true)
            {
                string Status = cboStatus.SelectedItem.Value;
                if (Status.ToString() == "Both")
                {
                    Status = "";
                }
                Response.Redirect("Route_Move_Rpt.aspx?THCNO=" + THCNO + "&Status=" + Status + "&Loc=" + Loc + "&EndLoc=" + EndLoc + "&StartLoc=" + StartLoc + "&Trans=" + Trans + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
            }
        }
    }
    protected void rbtTimeTrack_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtTimeTrack.Checked == true)
        {
            rbtTimeTrack.Checked = true;
            rbtRMRV.Checked = false;
            rbtRoute.Checked = false;
            cboStatus.Enabled = false;
        }
    }
    protected void rbtRMRV_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtRMRV.Checked == true)
        {
            rbtTimeTrack.Checked = false;
            rbtRMRV.Checked = true;
            rbtRoute.Checked = false;
            cboStatus.Enabled = false;
        }
    }
    protected void rbtRoute_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtRoute.Checked == true)
        {
            rbtTimeTrack.Checked = false;
            rbtRMRV.Checked = false;
            rbtRoute.Checked = true;
            cboStatus.Enabled = true;
        }
    }
}
