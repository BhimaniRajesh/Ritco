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
//using CrystalDecisions.CrystalReports.Engine;
using System.IO;
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    string status;
    string dockno = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            //TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate); 
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            lblDateRange.Text = TxtDateRange.Text;
            LblAdviceNO.Text = Request.QueryString["docketno"];
            if (LblAdviceNO.Text == "")
            {
                LblAdviceNO.Text = "All"; 
            }
            if (LblAdviceNO.Text != "All")
            {
                string[] dktarray =  LblAdviceNO.Text.Split(',');
                for (int i = 0; i < dktarray.Length; i++)
                {
                    dockno += "'" + dktarray[i] + "',";
                }
                dockno = dockno.Substring(0, dockno.Length - 1);    
            }
            BindTheData();
        }
        
      
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        if (LblAdviceNO.Text != "All")
        {
            cmd.CommandText = "Select dockno,convert(varchar(9),dockdt,6) as dockdt,orgncd,destcd,reassign_destcd,csgncd,csgnnm,csgecd,csgenm,doc_curloc from vw_detain Where dkt_detain='N' and dkt_cancel='N' and tcno is null and draft_yn='N' and doc_curloc='" + Convert.ToString(Session["brcd"]) + "' and dockno in (" + dockno + ") order by dockdt,orgncd Desc";
        }
        else 
        {
            cmd.CommandText = "Select dockno,convert(varchar(9),dockdt,6) as dockdt,orgncd,destcd,reassign_destcd,csgncd,csgnnm,csgecd,csgenm,doc_curloc from vw_detain Where dkt_detain='N' and dkt_cancel='N' and tcno is null and draft_yn='N' and doc_curloc='" + Convert.ToString(Session["brcd"]) + "' and convert(varchar,dockdt,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106) order by dockdt,orgncd Desc";
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State==ConnectionState.Closed)
        //{  
            
        //}
        sqlDA.Fill(ds, "DetainedDockets");
        GrdPaidFollow.DataSource = ds.Tables["DetainedDockets"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["DetainedDockets"].Rows.Count > 0)
        {
            cmdexcel.Visible = true;  
        }
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["AdvReg"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["AdvReg"];
        GrdPaidFollow.DataBind();  

        //BindTheData();
    }
    //Boolean IsPageIndex;
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
    }
   
    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {       
        //update  webx_Docket_Detain_Cancel set dkt_detain='Y',dkt_detain_reason='"&Reason&"',dkt_detain_on=getdate(),dkt_detain_by='"&session("empcd")&"',detain_no_days="&Days&",detained_at='"&session("brcd")&"' where DOCKNO='"&dockno&"' 
        for (int i = 0; i < GrdPaidFollow.Rows.Count; i++)
        {
            if (((CheckBox)GrdPaidFollow.Rows[i].FindControl("chkselect")).Checked == true)
            {
                TextBox txtdetaindays;
                DropDownList d1;
                Label l1;
                txtdetaindays = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtdetaindays");
                d1 = (DropDownList)GrdPaidFollow.Rows[i].FindControl("cmbreason"); 
                l1 = (Label)GrdPaidFollow.Rows[i].FindControl("lbldocketno");
                String sqlAdd1 = "update WebX_Trans_Docket_Status set detained='Y',Detained_reason='" + d1.Text + "',DetainedOn=getdate(),DetainedBy='" + Session["empcd"] + "',detain_no_days=" + txtdetaindays.Text.Replace("'", "''").Trim() + ",detained_at='" + Session["brcd"] + "' where DOCKNO='" + l1.Text + "'";
                SqlCommand valCmd1 = new SqlCommand(sqlAdd1, cn);
                valCmd1.ExecuteNonQuery();
            }
        }
        Response.Redirect("FrmCriteria.aspx");
    }
    protected void linkexcel(object sender, EventArgs e)
    {
        
    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        BindTheData();
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList d1;
            d1 = (DropDownList)e.Row.FindControl("cmbreason");
            SqlDataAdapter da = new SqlDataAdapter("select codeid as UTY_ID,codedesc as UTY_NAME from webx_master_general where codetype='DTAIN' order by UTY_NAME", cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "reason");
            d1.DataSource = ds.Tables["reason"];
            d1.DataTextField = "UTY_NAME";
            d1.DataValueField = "UTY_ID";
            d1.DataBind();
            ((TextBox)e.Row.FindControl("txtdetaindays")).Attributes.Add("onblur", "return checknumber(" + ((TextBox)e.Row.FindControl("txtdetaindays")).ClientID + "," + ((CheckBox)e.Row.FindControl("chkselect")).ClientID + ")");
            ((CheckBox)e.Row.FindControl("chkselect")).Attributes.Add("onclick", "return checkvalid(" + ((TextBox)e.Row.FindControl("txtdetaindays")).ClientID + "," + ((CheckBox)e.Row.FindControl("chkselect")).ClientID + ")");  
        }
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "-- Docket Detention Detail --";
            oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 8;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
    }
}
