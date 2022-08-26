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
using RKLib.ExportData;
public partial class GUI_UNI_MIS_BILL_MR_Register_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    DataSet ds = new DataSet();
    double BillAmt = 0, pendAmt = 0;
    int i=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();


        if (RMD == "0")
        {
            BindGrid();
        }
        else if (RMD == "1")
        {
            DWN_XLS();
        }
        else if (RMD == "2")
        {
            CSV_BindGrid();

        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string RO = "", LO = "", RTP_DT_str = "", fromdt = "", todt = "", RPT = "", RTP_DT = "";
        string st_cust_vend = "", st_cust_vend_name = "", rpt_SUB = "", BM_TYP = "", BM_STATUS = "", BM_STATUS_str = "";
        string CS_CHQ = "", AMT_G_THAN = "", OV_DYS = "", BILLNO_list = "", MANBNOLIST = "", DKTSNOLIST = "", DKTST = "";
        string M_L_TYP = "", Select_list = "", Select_Text = "", ASONDT = "", ASONDT_To="";

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT = Request.QueryString["RPT"].ToString();
        st_cust_vend = Request.QueryString["st_cust_vend"].ToString();
        st_cust_vend_name = Request.QueryString["st_cust_vend_name"].ToString();
        BM_TYP = Request.QueryString["BM_TYP"].ToString();
        BM_STATUS_str = Request.QueryString["BM_STATUS_str"].ToString();
        BM_STATUS = Request.QueryString["BM_STATUS"].ToString();
        CS_CHQ = Request.QueryString["CS_CHQ"].ToString();
        AMT_G_THAN = Request.QueryString["AMT_G_THAN"].ToString();
        OV_DYS = Request.QueryString["OV_DYS"].ToString();
        BILLNO_list = Request.QueryString["BILLNO_list"].ToString();
        MANBNOLIST = Request.QueryString["MANBNOLIST"].ToString();
        DKTSNOLIST = Request.QueryString["DKTSNOLIST"].ToString();
        DKTST = Request.QueryString["DKTST"].ToString();
        M_L_TYP = Request.QueryString["M_L_TYP"].ToString();
        Select_list = Request.QueryString["Select_list"].ToString();
        Select_Text = Request.QueryString["Select_Text"].ToString();
        st_cust_vend_name = Request.QueryString["st_cust_vend_name"].ToString();
        RTP_DT_str = Request.QueryString["RTP_DT_str"].ToString();
        RTP_DT = Request.QueryString["RTP_DT"].ToString();
        ASONDT = Request.QueryString["ASONDT"].ToString();
        ASONDT_To = Request.QueryString["ASONDT_To"].ToString();
        string TYPDET = Request.QueryString["TYPDET"].ToString();

        if (st_cust_vend == "")
        {
            st_cust_vend = "All";
            st_cust_vend_name = "All";
        }

        LBLDATE.Text=fromdt+" - "+todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lblcust.Text = st_cust_vend_name;
        lblBM_STAuTS_str.Text = BM_STATUS_str;
        lblBM_TYp.Text = BM_TYP;
        lblCASH_CHQ.Text = CS_CHQ;
        lblamt.Text = AMT_G_THAN;


        string SQL_STR = "";


        if (RO == LO)
            RO = "All";

        if (RPT == "B")
        {
            SQL_STR = "EXEC WebxNet_BILL_Register '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + st_cust_vend + "','" + BM_TYP + "','" + BM_STATUS + "','" + CS_CHQ + "','" + M_L_TYP + "','" + RTP_DT + "','" + OV_DYS + "','" + AMT_G_THAN + "','" + Select_list.Replace(",billno", ",bno=billno") + "','" + BILLNO_list + "','" + MANBNOLIST + "','" + DKTSNOLIST + "','" + ASONDT + "','" + ASONDT_To + "','" + TYPDET + "'";
        }
        else if (RPT == "M")
        {
            SQL_STR = "EXEC WebxNet_MR_Register '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + st_cust_vend + "','" + BM_TYP + "','" + DKTST + "','" + BM_STATUS + "','" + M_L_TYP + "','" + CS_CHQ + "','" + RTP_DT + "','" + AMT_G_THAN + "','" + Select_list + "','" + BILLNO_list + "','" + DKTSNOLIST + "'";
        }
      //Response.Write("SQL_STR : " + SQL_STR);
       // Response.Write("SQL_STR : " + Select_list);
      //  Response.Write("SQL_STR : " + Select_Text);
        //Response.End();
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
       // SqlDataReader dr = CMD.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(CMD);
        if (ASONDT != "")
        {
            dgDocket.AllowPaging = false;

        }
        da.Fill(ds);
        da.Fill(ds, "RDATA");
        Session["DATA"] = ds;
        dgDocket.DataSource = ds.Tables["RDATA"];
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;

        Conn.Close();
    }

    public void CSV_BindGrid()
    {
        BindGrid();
        DataTable dtEmployee = ((DataSet)Session["DATA"]).Tables["RDATA"].Copy();
        string Select_Text = Request.QueryString["Select_Text"].ToString();
        // Export all the details to CSV
        int[] iColumns = new int[Select_Text.Split(',').Length];
        string[] sHeaders = new string[Select_Text.Split(',').Length];
        string[] STRHeaders = Select_Text.Split(',');
        for (int i = 1; i < Select_Text.Split(',').Length; i++)
        {
            iColumns[i] = i;
            sHeaders[i] = STRHeaders[i].ToString();
        }
        //int[] iColumns =  //{ 1, 2, 3, 5, 6 };
        //string[] sHeaders = select_Text.Split(','); //{ "LastName", "FirstName", "DOB", "Address", "ZipCode" };

        // Export the details of specified columns with specified headers to CSV
        RKLib.ExportData.Export objExport = new RKLib.ExportData.Export();
        objExport.ExportDetails(dtEmployee, iColumns, sHeaders, Export.ExportFormat.CSV, "Register.csv");
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView oGridView = (GridView)sender;
                // Label billamt = (Label)oGridView.FindControl("billamt");

                GridViewRow tr1 = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
                //TableCell oTableCell = new TableCell();
                //TableCell oTableCell1 = new TableCell();
                TableCell tr1tc1 = new TableCell();
                tr1tc1.Text = "Sr No.";
                tr1tc1.CssClass = "blackfnt";
                tr1tc1.Wrap = false;
                tr1.CssClass = "bgbluegrey";
                tr1.Cells.Add(tr1tc1);
                string Select_Text = Request.QueryString["Select_Text"].ToString();
                string[] select_Text_Arr = Select_Text.Split(',');

                for (int ic = 0; ic < select_Text_Arr.Length; ic++)
                {
                    TableCell tr1tc2 = new TableCell();
                    tr1tc2.Text = select_Text_Arr[ic].ToString();
                    tr1tc2.CssClass = "blackfnt";
                    tr1tc2.Wrap = false;
                    tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(tr1tc2);

                    if (select_Text_Arr[ic].ToString() == "Amount")
                    {
                        if (e.Row.Cells[ic+1].Text != "" && e.Row.Cells[ic+1].Text != "&nbsp;")
                            BillAmt += Convert.ToDouble(e.Row.Cells[ic + 1].Text);
                    }
                    else if (select_Text_Arr[ic].ToString().Trim() == "Pending Amount")
                    {
                        if (e.Row.Cells[ic + 1].Text != "" && e.Row.Cells[ic + 1].Text != "&nbsp;")
                            pendAmt += Convert.ToDouble(e.Row.Cells[ic + 1].Text);

                    }
                    if (select_Text_Arr[ic].ToString().Trim() == "View")
                    {
                        e.Row.Cells[ic + 1].Text = "<a href=\"Javascript:OpenPopupWindow('" + e.Row.Cells[ic + 1].Text.ToString() + "')\"><u>" + e.Row.Cells[ic + 1].Text + "</u></a>";
                    }
                   
                }



                oGridView.Controls[0].Controls.AddAt(0, tr1);
                oGridView.Controls[0].Controls.RemoveAt(1);

                //Table table = (Table)this.dgDocket.Controls[0];
                ////GridView oGridView = (GridView)sender;
                //int realindex = table.Rows.GetRowIndex(e.Row);
                //GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                //TableCell oTableCell = new TableCell();
                //for (int ic = 0; ic < select_Text_Arr.Length; ic++)
                //{
                //    if (select_Text_Arr[ic].ToString().Trim() == "View")
                //    {
                //        oTableCell.Text = "Sr No.";
                //        oTableCell.CssClass = "blackfnt";
                //        oTableCell.Wrap = false;
                //        oGridViewRow.CssClass = "bgbluegrey";
                //        oGridViewRow.Cells.Add(oTableCell);
                //        oGridViewRow.BackColor = System.Drawing.Color.White;
                //        table.Controls.AddAt(realindex + 1, oGridViewRow);
                //    }
                //}
                //GridViewRow TRF = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
                //TableCell TCTRF = new TableCell();
                //TCTRF.Text = "";
                //TCTRF.CssClass = "blackfnt";
                //TCTRF.Wrap = false;
                //TRF.CssClass = "bgbluegrey";
                //TRF.Cells.Add(TCTRF);
                //for (int ic = 0; ic < select_Text_Arr.Length; ic++)
                //{
                     

                //    if (select_Text_Arr[ic].ToString() == "Amount")
                //    {                        
                //        TCTRF = new TableCell();
                //        TCTRF.Text = BillAmt.ToString();
                //        TCTRF.CssClass = "blackfnt";
                //        TCTRF.Wrap = false;
                //        TRF.CssClass = "bgbluegrey";
                //        TRF.Cells.Add(TCTRF);
                //    }
                //}

                //oGridView.Controls[0].Controls.AddAt(0, TRF);
                //oGridView.Controls[0].Controls.RemoveAt(1);


                i += 1;
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                 string ASONDT = Request.QueryString["ASONDT"].ToString();
                 if (ASONDT != "")
                 {
                     GridView oGridView = (GridView)sender;
                     GridViewRow TRF = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
                     TableCell TCTRF = new TableCell();
                     TCTRF.Text = "";
                     TCTRF.CssClass = "blackfnt";
                     TCTRF.Wrap = false;
                     TRF.CssClass = "bgbluegrey";
                     TRF.Cells.Add(TCTRF);
                     string Select_Text = Request.QueryString["Select_Text"].ToString();
                     string[] select_Text_Arr = Select_Text.Split(',');


                     for (int ic = 0; ic < select_Text_Arr.Length; ic++)
                     {
                         TCTRF = new TableCell();
                         TCTRF.Text = "";

                         if (select_Text_Arr[ic].ToString().Trim() == "Amount")
                         {
                             TCTRF.Text = BillAmt.ToString("F2");
                         }
                         else if (select_Text_Arr[ic].ToString().ToUpper().Trim() == "PENDING AMOUNT")
                         {
                             TCTRF.Text =pendAmt.ToString("F2");
                         }

                         TCTRF.CssClass = "blackfnt";
                         TCTRF.Wrap = false;
                         TCTRF.Font.Bold = true;
                         TCTRF.HorizontalAlign = HorizontalAlign.Right;
                         TRF.CssClass = "bgbluegrey";
                         TRF.Cells.Add(TCTRF);
                     }

                     oGridView.Controls[0].Controls.AddAt(i+1, TRF);
                    // oGridView.Controls[0].Controls.RemoveAt(1);
                 }
            }
        }
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;

        //BindGrid();

    }
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}

    public void DWN_XLS()
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        TBL_CRI.Border = 1;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Register_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(TBL_CRI);
       frm.Controls.Add(dgDocket);

        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        //BindGrid();
       // DWN_XLS();
        

        string final;
        final = "?RO=" + Request.QueryString["RO"].ToString();
        final += "&LO=" + Request.QueryString["LO"].ToString();
        final += "&fromdt=" + Request.QueryString["fromdt"].ToString();
        final += "&todt=" + Request.QueryString["todt"].ToString();
        final += "&RPT=" + Request.QueryString["RPT"].ToString();
        final += "&RMD=1";
        final += "&st_cust_vend=" + Request.QueryString["st_cust_vend"].ToString();
        final += "&st_cust_vend_name=" + Request.QueryString["st_cust_vend_name"].ToString();
        final += "&BM_TYP=" + Request.QueryString["BM_TYP"].ToString();
        final += "&BM_STATUS=" + Request.QueryString["BM_STATUS"].ToString();
        final += "&BM_STATUS_str=" + Request.QueryString["BM_STATUS_str"].ToString();
        final += "&CS_CHQ=" + Request.QueryString["CS_CHQ"].ToString();
        final += "&AMT_G_THAN=" + Request.QueryString["AMT_G_THAN"].ToString();
        final += "&OV_DYS=" + Request.QueryString["OV_DYS"].ToString();
        final += "&BILLNO_list=" + Request.QueryString["BILLNO_list"].ToString();
        final += "&MANBNOLIST=" + Request.QueryString["MANBNOLIST"].ToString();
        final += "&DKTSNOLIST=" + Request.QueryString["DKTSNOLIST"].ToString();
        final += "&DKTST=" + Request.QueryString["DKTST"].ToString();
        final += "&M_L_TYP=" + Request.QueryString["M_L_TYP"].ToString();
        final += "&Select_list=" + Request.QueryString["Select_list"].ToString();
        final += "&Select_Text=" + Request.QueryString["Select_Text"].ToString();
        final += "&RTP_DT=" + Request.QueryString["RTP_DT"].ToString();
        final += "&RTP_DT_str=" + Request.QueryString["RTP_DT_str"].ToString();
        final += "&ASONDT=" + Request.QueryString["ASONDT"].ToString();
        final += "&ASONDT_To=" + Request.QueryString["ASONDT_To"].ToString();
        final += "&TYPDET=" + Request.QueryString["TYPDET"].ToString();
        Response.Redirect("Result.aspx" + final);
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {


        string final;
        final = "?RO=" + Request.QueryString["RO"].ToString();
        final += "&LO=" + Request.QueryString["LO"].ToString();
        final += "&fromdt=" + Request.QueryString["fromdt"].ToString();
        final += "&todt=" + Request.QueryString["todt"].ToString();
        final += "&RPT=" + Request.QueryString["RPT"].ToString();
        final += "&RMD=2";
        final += "&st_cust_vend=" + Request.QueryString["st_cust_vend"].ToString();
        final += "&st_cust_vend_name=" + Request.QueryString["st_cust_vend_name"].ToString();
        final += "&BM_TYP=" + Request.QueryString["BM_TYP"].ToString();
        final += "&BM_STATUS=" + Request.QueryString["BM_STATUS"].ToString();
        final += "&BM_STATUS_str=" + Request.QueryString["BM_STATUS_str"].ToString();
        final += "&CS_CHQ=" + Request.QueryString["CS_CHQ"].ToString();
        final += "&AMT_G_THAN=" + Request.QueryString["AMT_G_THAN"].ToString();
        final += "&OV_DYS=" + Request.QueryString["OV_DYS"].ToString();
        final += "&BILLNO_list=" + Request.QueryString["BILLNO_list"].ToString();
        final += "&MANBNOLIST=" + Request.QueryString["MANBNOLIST"].ToString();
        final += "&DKTSNOLIST=" + Request.QueryString["DKTSNOLIST"].ToString();
        final += "&DKTST=" + Request.QueryString["DKTST"].ToString();
        final += "&M_L_TYP=" + Request.QueryString["M_L_TYP"].ToString();
        final += "&Select_list=" + Request.QueryString["Select_list"].ToString();
        final += "&Select_Text=" + Request.QueryString["Select_Text"].ToString();
        final += "&RTP_DT=" + Request.QueryString["RTP_DT"].ToString();
        final += "&RTP_DT_str=" + Request.QueryString["RTP_DT_str"].ToString();
        final += "&ASONDT=" + Request.QueryString["ASONDT"].ToString();
        final += "&ASONDT_To=" + Request.QueryString["ASONDT_To"].ToString();
        final += "&TYPDET=" + Request.QueryString["TYPDET"].ToString();
       // string TYPDET = Request.QueryString["TYPDET"].ToString();

        Response.Redirect("Result.aspx" + final);

    }
    
}
