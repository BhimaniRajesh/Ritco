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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    static String dockno,RO,RO2,LO,LO2 = "";
    SqlConnection cn;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            Array str, str1;
            String fdate, tdate;
            fdate = ((TextBox)PreviousPage.FindControl("txtDateFrom")).Text;
            tdate = ((TextBox)PreviousPage.FindControl("txtDateTo")).Text;
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtRO.Text = ((DropDownList)PreviousPage.FindControl("cmbRO")).SelectedItem.Text + " To " + ((DropDownList)PreviousPage.FindControl("cmbRO2")).SelectedItem.Text.ToUpper();
            txtLocation.Text = ((DropDownList)PreviousPage.FindControl("CmbLoc")).Text + " To " + ((DropDownList)PreviousPage.FindControl("cmbLoc2")).SelectedItem.Text.ToUpper();
            lbldaterange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            dockno = ((TextBox)PreviousPage.FindControl("txtdockno")).Text;
            RO = ((DropDownList)PreviousPage.FindControl("cmbRO")).Text;
            RO2 = ((DropDownList)PreviousPage.FindControl("cmbRO2")).Text;
            LO = ((DropDownList)PreviousPage.FindControl("CmbLoc")).Text;
            LO2 = ((DropDownList)PreviousPage.FindControl("CmbLoc2")).Text;
        }
        
        BindTheData();
    }
    public void BindTheData()
    {
        String StrQry = "";
        GrdLoadUnload.DataSource = null;
        if (dockno != "")
        {
            StrQry = "Select a.dockno,a.docksf,convert(varchar(9),a.dockdt,6) as dockdt,a.orgncd,a.REASSIGN_DESTCD,dockdt_entry,convert(varchar(9),a.dely_dt,6) as dely_dt,a.CSGNNM,a.csgncd,trn_mod=(select codedesc from webx_master_general where codetype='TRN' and codeid=trn_mod),pkgsno,chrgwt,a.CSGENM,a.dkt_dly from vw_DOCKET_net a where  a.dockno='" + dockno + "'";
        }
        else
        {
            if (LO == "All" && LO2 == "All")
            {
                StrQry = "Select a.dockno,a.docksf,convert(varchar(9),a.dockdt,6) as dockdt,a.orgncd,a.REASSIGN_DESTCD,convert(varchar(9),a.dely_dt,6) as dely_dt,a.CSGNNM,a.CSGENM,a.dkt_dly from vw_DOCKET_net a with(NOLOCK)where a.dockno<>'' and convert(varchar,a.DOCKDT,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106) and (a.CSGNCD='" + Convert.ToString(Session["custcd"]) + "' or a.CSGeCD='" + Convert.ToString(Session["custcd"]) + "' or a.party_code='" + Convert.ToString(Session["custcd"]) + "')";
            }
            else if (LO == "All" && LO2 != "All")
            {
                StrQry = "Select a.dockno,a.docksf,convert(varchar(9),a.dockdt,6) as dockdt,a.orgncd,a.REASSIGN_DESTCD,convert(varchar(9),a.dely_dt,6) as dely_dt,a.CSGNNM,a.CSGENM,a.dkt_dly from vw_DOCKET_net a with(NOLOCK)where a.dockno<>'' and convert(varchar,a.DOCKDT,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106) and (a.CSGNCD='" + Convert.ToString(Session["custcd"]) + "' or a.CSGeCD='" + Convert.ToString(Session["custcd"]) + "' or a.party_code='" + Convert.ToString(Session["custcd"]) + "') and a.REASSIGN_DESTCD='" + LO2 + "'";
            }
            else if (LO != "All" && LO2 == "All")
            {
                StrQry = "Select a.dockno,a.docksf,convert(varchar(9),a.dockdt,6) as dockdt,a.orgncd,a.REASSIGN_DESTCD,convert(varchar(9),a.dely_dt,6) as dely_dt,a.CSGNNM,a.CSGENM,a.dkt_dly from vw_DOCKET_net a with(NOLOCK)where a.dockno<>'' and convert(varchar,a.DOCKDT,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106) and (a.CSGNCD='" + Convert.ToString(Session["custcd"]) + "' or a.CSGeCD='" + Convert.ToString(Session["custcd"]) + "' or a.party_code='" + Convert.ToString(Session["custcd"]) + "') and a.ORGNCD='" + LO + "'";
            }
            else if (LO != "All" && LO2 != "All")
            {
                StrQry = "Select a.dockno,a.docksf,convert(varchar(9),a.dockdt,6) as dockdt,a.orgncd,a.REASSIGN_DESTCD,convert(varchar(9),a.dely_dt,6) as dely_dt,a.CSGNNM,a.CSGENM,a.dkt_dly from vw_DOCKET_net a with(NOLOCK)where a.dockno<>'' and convert(varchar,a.DOCKDT,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106) and (a.CSGNCD='" + Convert.ToString(Session["custcd"]) + "' or a.CSGeCD='" + Convert.ToString(Session["custcd"]) + "' or a.party_code='" + Convert.ToString(Session["custcd"]) + "') and a.ORGNCD='" + LO + "' and a.REASSIGN_DESTCD='" + LO2 + "'";
            }
        }
        SqlDataAdapter da = new SqlDataAdapter(StrQry, cn);
        cn.Open();
        da.Fill(ds, "docket");
        GrdLoadUnload.DataSource = ds.Tables["docket"];
        GrdLoadUnload.DataBind();
        if (ds.Tables["docket"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;  
        }
        
    }    
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(GrdLoadUnload);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((Label)e.Row.FindControl("lblorgncd")).Text = ((Label)e.Row.FindControl("lblorgncd")).Text + " : " + fn.GetLocation(((Label)e.Row.FindControl("lblorgncd")).Text);
            ((Label)e.Row.FindControl("lbldlyloc")).Text = ((Label)e.Row.FindControl("lbldlyloc")).Text + " : " + fn.GetLocation(((Label)e.Row.FindControl("lbldlyloc")).Text);
            if (((Label)e.Row.FindControl("lbldelivered")).Text == "Y")
            {
                ((Label)e.Row.FindControl("lbldelivered")).Text = "Yes";
            }
            else if(((Label)e.Row.FindControl("lbldelivered")).Text == "N")
            {
                ((Label)e.Row.FindControl("lbldelivered")).Text = "No";
            }
        }
    }
}
