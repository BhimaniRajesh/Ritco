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


public partial class GUI_UNI_MIS_TRF_report_result : System.Web.UI.Page
{
    public static string DateType, dkt_call, fromdt, todt, RO, LO, St_paylist, st_trnlist, st_delist, st_mode, st_status;



    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        //St_paylist = Request.QueryString["St_paylist"].ToString();
        //st_trnlist = Request.QueryString["st_trnlist"].ToString();
        //st_delist = Request.QueryString["st_delist"].ToString();


        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");



        string sql_st = "exec webx_TRF_REPORT '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);



        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;





        conn.Close();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
               // Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                //Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

               // dkt_colname.Text = dkt_call + " No.";
                //lblColDockdt.Text = dkt_call + " Date";
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string dockno = e.Row.Cells[3].Text.ToString();

                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

                string sql_inv = "select invno,invdt=convert(varchar,invdt,6),declval from WebX_Master_Docket_Invoice where dockno+'.'='" + dockno + "'";
                //Response.Write("<br>sql_inv : " + sql_inv);
                SqlCommand sqlcmd0 = new SqlCommand(sql_inv, conn);
                SqlDataReader dr0 = sqlcmd0.ExecuteReader();
                string invno="", invdt="";
                double invamt = 0;

                while (dr0.Read())
                {
                    if(invno=="")
                        invno = dr0["invno"].ToString();
                    else 
                        invno = invno +" / "+ dr0["invno"].ToString();

                    if (invdt == "")
                        invdt = dr0["invdt"].ToString();
                    else
                        invdt = invdt + " / " + dr0["invdt"].ToString();

                    invamt += Convert.ToDouble(dr0["declval"].ToString()); 

                }



                dr0.Close();
                conn.Close();

                e.Row.Cells[13].Text = invno;
                e.Row.Cells[14].Text = invdt;
                e.Row.Cells[15].Text = invamt.ToString();

                GridView oGridView = (GridView)sender;
                // Label billamt = (Label)oGridView.FindControl("billamt");

                GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                TableCell oTableCell1 = new TableCell();


                oTableCell = new TableCell();
                oTableCell.Text = " Srno";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VEHICLE REQUISITION NO ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "USER DEPARTMENT ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = dkt_call + " No. ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = dkt_call + " Date ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "MARKET VEHICLE / OWNED VEHICLE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "ONWARD / RETURN";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "TRANSPORTERS NAME";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "VEHICLE NO";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VEHICLE    CAPACITY IN KGS";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VEHICLE TYPE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "TRIP SHEET NO";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "TRUCK HIRE CHALLON NO/VEHICLE HIRE CHALLAN NO ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "INVOICE NO/JOB NO/HBL NO";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "DATE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "INVOICE VALUE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "ACTUAL CARGO WEIGHT ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "CONSIGNOR";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "CONSIGNEE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "ORIGIN  ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "DESTINATION ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "FROM  ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "TO";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "TRANSHIPMENT REQUIRED";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "PLACE OF TRANSHIPMENT";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VEH. OPENING KM.";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VEH. CLOSING KM.";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "TRIP KM. ACTUAL";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "TRIP KM. ESTIMATED";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "VARIANCE FOR ACTUAL AND ESTIMATED TRIP KMS";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "BILLING  TARIFF";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "BILLABLE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 6;
                oGridViewRow.Cells.Add(oTableCell);

              
                oTableCell = new TableCell();
                oTableCell.Text = "COST";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 9;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "POD REMARKS";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "REMARKS FOR DEDUCTIONS IF ANY";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "ANY OTHER REMARKS";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "OWN PURPOSE";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 7;
                oGridViewRow.Cells.Add(oTableCell);

                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                oGridView.Controls[0].Controls.RemoveAt(1);
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //Build custom header.


                GridView oGridView = (GridView)sender;
                // Label billamt = (Label)oGridView.FindControl("billamt");

                GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

                TableCell oTableCell1 = new TableCell();
                //***************************
                //*****for second row *************

                oTableCell1 = new TableCell();
                oTableCell1.Text = "FREIGHT REVENUE";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "LOADING CHARGES";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "UNLOADING CHARGES ";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "DETENTION CHARGES";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "OTHER CHARGES (IF ANY)";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "TOTAL BILLABLE";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "FREIGHT COST";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "TRANSHIPMENT COST";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "LOADING CHARGES";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "UNLOADING CHARGES ";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "DETENTION CHARGES";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ENROUTE EXPENSES";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "OTHER CHARGES (IF ANY)";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                
                oTableCell1 = new TableCell();
                oTableCell1.Text = "TOTAL COST";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                
                oTableCell1 = new TableCell();
                oTableCell1.Text = "GP";
                oTableCell1.CssClass = "blackfnt";
                //oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);



                oTableCell1 = new TableCell();
                oTableCell1.Text = "EXPENSE VOUCH NO";
                oTableCell1.CssClass = "blackfnt";
              //  oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ADVANCE AMOUNT";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "CASH / CHEQUE";
                oTableCell1.CssClass = "blackfnt";
              //  oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "BALANCE";
                oTableCell1.CssClass = "blackfnt";
              //  oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "SUBM TO ACCOUNT";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "PAYMENT DATE";
                oTableCell1.CssClass = "blackfnt";
               // oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "REMARK ON DEDUCTIONS";
                oTableCell1.CssClass = "blackfnt";
              //  oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

               
                

                oGridViewRow1.HorizontalAlign = HorizontalAlign.Center;
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
                oGridViewRow1.CssClass = "bgbluegrey";
            }
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;


        BindGrid();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {

        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;



        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TRF_report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);


        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
