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
            BindTheData();
        }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "WEBX_RetrieveData_DETAIN";
        if (LblAdviceNO.Text != "All")
        {
            cmd.Parameters.AddWithValue("@DKTRNDNO", LblAdviceNO.Text);
            cmd.Parameters.AddWithValue("@DTTYPE", "");
            cmd.Parameters.AddWithValue("@FROMDT", "");
            cmd.Parameters.AddWithValue("@TODT", "");
            cmd.Parameters.AddWithValue("@DKTMODE", "");
            cmd.Parameters.AddWithValue("@ORGNCD", Session["brcd"]);
        }
        else 
        {
            cmd.Parameters.AddWithValue("@DKTRNDNO","");
            cmd.Parameters.AddWithValue("@DTTYPE", "D");
            cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@DKTMODE", "");
            cmd.Parameters.AddWithValue("@ORGNCD", Session["brcd"]);
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        sqlDA.Fill(ds, "RDetainedDockets");
        GrdPaidFollow.DataSource = ds.Tables["RDetainedDockets"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["RDetainedDockets"].Rows.Count > 0)
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
                DropDownList d1;
                Label l1;
                //txtdetaindays = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtdetaindays");
                d1 = (DropDownList)GrdPaidFollow.Rows[i].FindControl("cmbreason"); 
                l1 = (Label)GrdPaidFollow.Rows[i].FindControl("lbldocketno");
                //old structure --> String sqlAdd1 = "Update webx_Docket_Detain_Cancel set dkt_detain='N',dkt_detain_remove_reason='" + d1.Text + "',detain_no_days=null,dkt_detain_remove_on=getdate(),dkt_detain_remove_by='" + Session["empcd"] + "' where DOCKNO='" + l1.Text + "'";
                String sqlAdd1 = "Update WebX_Trans_Docket_Status set detained='N',dkt_detain_remove_reason='" + d1.Text + "',detain_no_days=null,dkt_detain_remove_on=getdate(),dkt_detain_remove_by='" + Session["empcd"] + "' where DOCKNO='" + l1.Text + "'";
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
            SqlDataAdapter da = new SqlDataAdapter("select codeid as UTY_ID,codedesc as UTY_NAME from webx_master_general where codetype='remdet' order by UTY_NAME", cn);
            //select codeid as UTY_ID,codedesc as UTY_NAME from webx_master_general where codetype='DTAIN' order by UTY_NAME
            DataSet ds = new DataSet();
            da.Fill(ds, "reason");
            d1.DataSource = ds.Tables["reason"];
            d1.DataTextField = "UTY_NAME";
            d1.DataValueField = "UTY_ID";
            d1.DataBind();
            ((CheckBox)e.Row.FindControl("chkselect")).Attributes.Add("onclick","checkuncheckall(this)");  
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
            oTableCell.Text = "--Remove Dockets From Detention--";
            oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 4;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
    }
}
