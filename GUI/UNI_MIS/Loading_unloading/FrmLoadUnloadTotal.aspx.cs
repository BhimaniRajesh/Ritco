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
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn1 = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    DataTable dt = new DataTable(); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        DataColumn dc2 = new DataColumn("Location", typeof(String));
        DataColumn dc3 = new DataColumn("Total_CN", typeof(Int64));
        DataColumn dc4 = new DataColumn("CN_WT", typeof(decimal));
        DataColumn dc5 = new DataColumn("Total_In_MF", typeof(Int64));
        DataColumn dc6 = new DataColumn("MF_In_WT", typeof(decimal));
        DataColumn dc7 = new DataColumn("Total_Out_MF", typeof(Int64));
        DataColumn dc8 = new DataColumn("MF_Out_WT", typeof(Int64));
        DataColumn dc9 = new DataColumn("Total_DRS", typeof(Int64));
        DataColumn dc10 = new DataColumn("DRS_Wt", typeof(Int64));
        DataColumn dc11 = new DataColumn("Loading_Total_Wt", typeof(decimal));
        DataColumn dc12 = new DataColumn("Unloading_Total_Wt", typeof(Int64));
        DataColumn dc13 = new DataColumn("Grand_Total", typeof(Int64));
        DataColumn dc14 = new DataColumn("Rate", typeof(string));
        DataColumn dc15 = new DataColumn("NetDue", typeof(string));
        //dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);
        dt.Columns.Add(dc3);
        dt.Columns.Add(dc4);
        dt.Columns.Add(dc5);
        dt.Columns.Add(dc6);
        dt.Columns.Add(dc7);
        dt.Columns.Add(dc8);
        dt.Columns.Add(dc9);
        dt.Columns.Add(dc10);
        dt.Columns.Add(dc11);
        dt.Columns.Add(dc12);
        dt.Columns.Add(dc13);
        dt.Columns.Add(dc14);
        dt.Columns.Add(dc15);
        if (!IsPostBack)
        {
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            //((string[])(str))[0]
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            ////CultureInfo a = CultureInfo.CurrentCulture;  
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtDateRange.Text = Request.QueryString["FrmDate"] + "-" + Request.QueryString["ToDate"];
            TxtRO.Text = Request.QueryString["RO"];
            txtLocation.Text = Request.QueryString["LocCode"];
            //TxtCCode.Text = Request.QueryString["CCode"];
            lbldaterange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            //lblCCode.Text = TxtCCode.Text;    
            //DataColumn dc1 = new DataColumn("SR.No", typeof(Int64));
           
            //DataRow dr;
            //Int32 i = ds.Tables["PaidFollow"].Rows.Count;
            //ds.Tables["PaidFollow"].Columns.Add(dc);
            //for (int j = 1; j <= i; j++)
            //{
            //    dr = ds.Tables["PaidFollow"].NewRow();
            //    dr["SR.No"] = j;
            //    ds.Tables["PaidFollow"].Rows.Add(dr);
            //}

            BindTheData();
        }
    }
    public void BindTheData()
    {
        DataRow drow;
        SqlCommand cmd = new SqlCommand("select loccode,locName,report_loc from webx_location where report_loc<> 'Hoo' group by report_loc,loccode,locName",cn);  
        SqlDataReader dr;
        cn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            drow = dt.NewRow();
            drow["Location"] = dr.GetString(0) + " : " + dr.GetString(1);
            //ds.Tables["PaidFollow"].Rows.Add(dr);
            Decimal cn_wt, mf_in_wt, mf_out_wt, drs_wt, totalin , totalout;
            SqlDataReader drtemp;
            SqlCommand cmdtemp = new SqlCommand("select count(*) as Total_CN,sum(case when ACTUWT is  not null then ACTUWT end ) as CN_Wt from webx_docket with(NOLOCK) where orgncd='" + dr[0] + "' and  convert(varchar,dockdt,106) between convert(datetime, '" + TxtFDt.Text + "',106) and  convert(datetime, '" + TxtTDt.Text + "',106) ", cn1);
            if (cn1.State == ConnectionState.Closed) { cn1.Open(); };
            drtemp = cmdtemp.ExecuteReader();
            drtemp.Read();
            drow["Total_CN"] = drtemp["Total_CN"];  //Convert.ToInt32(drtemp.GetInt32(0));
            drow["CN_Wt"] = drtemp["CN_Wt"]; //Convert.ToInt32(drtemp.GetInt32(1));
            if (drtemp[1] != System.DBNull.Value)
            {
                cn_wt = Convert.ToDecimal(drtemp[1]);//drtemp[1];
            }
            else 
            {
                cn_wt = 0;
            }
            cmdtemp.Connection.Close();
            drtemp.Close();

            cmdtemp = new SqlCommand("select count(*) as Total_In_MF,sum(case when TOT_ACTUWT is  not null then TOT_ACTUWT end ) as MF_In_Wt from vw_MF_details t with(NOLOCK)  where  ToBH_CODE in (select sourcehb from webx_thchdr with(NOLOCK)  where thcno=t.thcno and sourcehb='" + dr[0] + "') and TCHDRFLAG='N'  and  convert(varchar,thcdt,106) between convert(datetime, '" + TxtFDt.Text + "',106) and  convert(datetime, '" + TxtTDt.Text + "',106)", cn1);
            cmdtemp.Connection.Open();  
            drtemp = cmdtemp.ExecuteReader();
            drtemp.Read();
            drow["Total_In_MF"] = drtemp[0];// Convert.ToInt32(drtemp.GetInt32(0));
            drow["MF_In_Wt"] = drtemp[1];//Convert.ToInt32(drtemp.GetInt32(1));
            if (drtemp[1] != System.DBNull.Value)
            {
               // cn_wt = Convert.ToInt32(drtemp[1]);//drtemp[1];
                mf_in_wt = Convert.ToDecimal(drtemp[1]);//drtemp[1];
            }
            else
            {
                mf_in_wt = 0;
            }
            
            
            cmdtemp.Connection.Close();
            drtemp.Close();
            totalin = ((cn_wt + mf_in_wt) / 1000);
            drow["Loading_Total_Wt"] = totalin.ToString("0.00");

            cmdtemp = new SqlCommand("select count(*) as Total_out_MF,sum(case when TOT_ACTUWT is  not null then TOT_ACTUWT end ) as MF_OUT_Wt from vw_MF_details t where tcbr='" + dr[0] + "'  and  tcdt between  convert(datetime, '" + TxtFDt.Text + "',106) and  convert(datetime, '" + TxtTDt.Text + "',106)", cn1);
            cmdtemp.Connection.Open();
            drtemp = cmdtemp.ExecuteReader();
            drtemp.Read();
            drow["Total_Out_MF"] = drtemp[0];// Convert.ToInt32(drtemp.GetInt32(0));
            drow["MF_Out_Wt"] = drtemp[1]; //Convert.ToInt32(drtemp.GetInt32(1));
            //mf_out_wt = Convert.ToInt32(drtemp[1]); //drtemp[1];
            if (drtemp[1] != System.DBNull.Value)
            {
                mf_out_wt = Convert.ToDecimal(drtemp[1]); //drtemp[1];
            }
            else
            {
                mf_out_wt = 0;
            }
            cmdtemp.Connection.Close();
            drtemp.Close();

            cmdtemp = new SqlCommand("select count(*)  as Total_DRS,sum(case when TOT_DKTWT is  not null then TOT_DKTWT end ) as DRS_Wt from vw_DRS_Details where pdcbr='" + dr[0] + "'  and pdcty='D'  and  pdcdt between convert(datetime, '" + TxtFDt.Text + "',106) and  convert(datetime, '" + TxtTDt.Text + "',106)", cn1);
            cmdtemp.Connection.Open();
            drtemp = cmdtemp.ExecuteReader();
            drtemp.Read();
            drow["Total_DRS"] = drtemp[0];//Convert.ToInt32(drtemp.GetInt32(0));
            drow["DRS_Wt"] = drtemp[1];//Convert.ToInt32(drtemp.GetInt32(1));
            if (drtemp[1] != System.DBNull.Value)
            {
                drs_wt = Convert.ToDecimal(drtemp[1]);//drtemp[1];
            }
            else
            {
                drs_wt = 0;
            }
            cmdtemp.Connection.Close();
            drtemp.Close();

            drow["Unloading_Total_Wt"] = ((cn_wt + mf_in_wt) / 1000);
            totalout = ((cn_wt + mf_in_wt) / 1000);
            drow["Grand_Total"] = totalin + totalout;
            drow["Rate"] = "";
            drow["NetDue"] = "";
            dt.Rows.Add(drow);        
        }
        dr.Close();
        cmd.Connection.Close();
        dt.Columns[0].Caption="Location";
        dt.Columns[1].Caption = "Cn No.";
        dt.Columns[2].Caption = "Wt.";
        dt.AcceptChanges(); 
        GrdPaidFollow.DataSource = dt;  
        GrdPaidFollow.DataBind();  
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdPaidFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["ToPay"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["ToPay"];
        GrdPaidFollow.DataBind();  
        //BindTheData();
    }
    //Boolean IsPageIndex;
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    //    IsPageIndex = true;
    //    if (GridViewSortExpression != string.Empty)
    //    {
    //        if (IsPageIndex)
    //        {

    //            ds.Tables[0].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
    //        }
    //        else
    //        {
    //            ds.Tables[0].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());

    //        }
    //    }
    //    BindGrid();
        //////////GrdPaidFollow.DataSource = ds.Tables[0];
        //////////GrdPaidFollow.PageIndex = e.NewPageIndex;
        //////////BindGrid(); 
        //////////GrdPaidFollow.DataBind();

    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {

        //GridViewSortExpression = e.SortExpression;
        //int pageIndex = GrdPaidFollow.PageIndex;
        //IsPageIndex = false;
        //if (GridViewSortExpression != string.Empty)
        //{
        //    if (IsPageIndex)
        //    {

        //        ds.Tables["PaidFollow"].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
        //    }
        //    else
        //    {
        //        ds.Tables["PaidFollow"].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());
        //    }
        //}
        //BindGrid();
        //GrdPaidFollow.DataSource = ds.Tables["PaidFollow"];
        //GrdPaidFollow.DataBind();  

    }
    //private string GridViewSortExpression
    //{

    //    get { return ViewState["SortExpression"] as string ?? string.Empty; }

    //    set { ViewState["SortExpression"] = value; }

    //}

    //private string GetSortDirection()
    //{
    //    switch (GridViewSortDirection)
    //    {
    //        case "ASC":
    //            GridViewSortDirection = "DESC";
    //            break;
    //        case "DESC":
    //            GridViewSortDirection = "ASC";
    //            break;
    //    }
    //    return GridViewSortDirection;

    //}
    //private string GridViewSortDirection
    //{

    //    get { return ViewState["SortDirection"] as string ?? "ASC"; }

    //    set { ViewState["SortDirection"] = value; }

    //}
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        // str = " ORDER BY " + e.SortExpression;
        // BindTheData();
        string strqry;
        strqry = "";
        Label l1, l2;
        string a, b;
        a = "";
        b = "";
        l1 = (Label)e.Item.FindControl("lblloccode");
        l2 = (Label)e.Item.FindControl("lbllocation");
        if (l1 != null)
        {
            a = l1.Text;
            b = l1.Text + ":" + l2.Text;
        }
        switch (e.CommandName)
        {
                //SELECT *, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small FROM VW_UNI_PAID_Folleup WHERE (ORGNCD = '" + a + "') AND (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "') AND (Closedt IS NULL)
            case "booked" :
                strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Booked MR Report");  
                break; 
            case "arrived":
                strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Arrived MR Report");  
                break;
            case "generated":
                strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Generated MR Report");  
                break;
            case "closed":
                strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and finclosedt is not null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Closed MR Report");
                break;
            case "out_docket":
                strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and finclosedt is  null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Outstanding MR Report");  
                break;
            default:
                break;
        }
    }

   protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_ToPay_arrv_out";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "ToPay");
        Session["ToPay"] = ds;
        Response.Redirect("FrmToPayFollowUpRPT.aspx");  
        //ReportDocument rd;
        //rd = new ReportDocument();
        //rd.Load(Server.MapPath("RptPaidFollow.rpt"));
        //rd.SetDataSource(ds.Tables[0]);
        //CrystalReportViewer1.ReportSource = rd;
        //CrystalReportViewer1.DataBind();  
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Excel1.csv"), false);

        //Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_ToPay_arrv_out";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "ToPay");
        DataTable dt2 = ds.Tables["ToPay"];// (DataTable)Session["dt1"];

        int iColCount = dt2.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(dt2.Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);
        // Now write all the rows.
        foreach (DataRow dr in dt2.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();
        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("LoadUnload.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "LoadUnload.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();

    }
}
