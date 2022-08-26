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

public partial class REPORT_sfm_funnel_report_loc_wise : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr = @"<script>
                    function update(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtLocationCode').value=elemValue;
                  }
                  </script>";

        Page.RegisterClientScriptBlock("update", scr);
        //btnPopUp.Attributes.Add("onclick", "window.open('PopupLocation.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= no, toolbar= no,location= no, menubar= no');");
        btnPopUp.Attributes.Add("onclick", "window.open('Popup_Employee_CallRegister.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        if (!(Page.IsPostBack))
        {
            popRO();
        }
    }
    protected void cboSelectRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
    }
    protected void cboSelectLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

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
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void btnShowReport_Click(object sender, EventArgs e)
    {
        string final = "?strFromDt=" + txtDateFrom.Text;
        final = final + "&strToDt=" + txtDateTo.Text;
        final = final + "&strlocation=" + cboSelectLocation.SelectedValue.ToString();
        final = final + "&strRegion=" + cboSelectRo.SelectedValue.ToString();
        final = final + "&strtxtloccode=" + txtLocationCode.Text;
        Response.Redirect("sfm_funnel_report_loc_wise2.aspx" + final);

    }

    public void BindGrid()
    {
        
        conn.Open();
        string sql = "webx_funnal_location";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        {
            if (txtDateFrom.Text != "")
            {
                dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            }
            else
            {
                System.DateTime nowdate = System.DateTime.Today;
                string todate = nowdate.ToString("dd/MM/yyyy");
                dtFrom = Convert.ToDateTime("01/01/1950");
                dtTo = Convert.ToDateTime(todate);
            }

        }
        Session["dtfrm"] = dtFrom;
        Session["dtt"] = dtTo;

        string location;

        location = cboSelectLocation.SelectedItem.ToString();

        if (location == "--All--")
        {
            location = "";
        }
        else
        {
            location = cboSelectLocation.SelectedValue.ToString();
        }

        if (txtLocationCode.Text == "")
        {

            da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
            da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
            da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
        }
        else
        {
            location = txtLocationCode.Text;
            da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
            da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
            da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
        
        }

        string loc = cboSelectLocation.SelectedItem.ToString();
        Session["loc"] = loc;

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallSummary.DataSource = dv;
        dgCallSummary.DataBind();

        conn.Close();

    }
    public void popRO()
    {
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
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' ";
                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
                cboSelectRo.DataSource = ds;
                cboSelectRo.DataTextField = "c1";
                cboSelectRo.DataValueField = "c2";
                cboSelectRo.DataBind();

                popLOC();


            }
            else
            {
                string concat = brcd + " : " + locnm;
                cboSelectRo.Items.Clear();
                cboSelectRo.Items.Add(concat);
                cboSelectRo.DataBind();
                cboSelectRo.SelectedItem.Value = brcd;

                popLOC();

            }
        }
        else
        {
            string sqlcode = "select Report_Loc from webx_Location where LocCode='" + brcd + "'";
            SqlCommand sqlcmd = new SqlCommand(sqlcode, conn);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

            da.Fill(ds, "tab");
            cboSelectRo.DataSource = ds;
            cboSelectRo.DataTextField = "Report_Loc";
            cboSelectRo.DataValueField = "Report_Loc";
            cboSelectRo.DataBind();

            string region = cboSelectRo.SelectedItem.ToString();

            string sqlcode1 = "select LocCode as c1,LocCode +':'+ LocName as c2 from webx_Location where LocCode='" + region + "'";
            SqlCommand command = new SqlCommand(sqlcode1, conn);
            DataSet ds1 = new DataSet();
            SqlDataAdapter da1 = new SqlDataAdapter(command);

            da1.Fill(ds1, "tab");
            cboSelectRo.DataSource = ds1;
            cboSelectRo.DataTextField = "c2";
            cboSelectRo.DataValueField = "c1";
            cboSelectRo.DataBind();
            
            cboSelectLocation.Items.Clear();
            cboSelectLocation.Items.Add("Select");
            cboSelectLocation.Items.Add(brcd);


        }
    }
    public void popLOC()
    {
       // conn.Open();

        string strro = cboSelectRo.SelectedValue.ToString();
        string sql = "select top 1 '--All--' as c1,'--All--' as loccode from webx_location union select loccode+' : '+locname c1,loccode from webx_location where report_loc= '" + strro + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboSelectLocation.DataSource = ds;
        cboSelectLocation.DataTextField = "c1";
        cboSelectLocation.DataValueField = "loccode";
        cboSelectLocation.DataBind();

        conn.Close();
    }
    public void pgChange(object source, DataGridPageChangedEventArgs e)
    {
        
        dgCallSummary.CurrentPageIndex = e.NewPageIndex;
        BindGrid();

    }
}
