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

public partial class GUI_UNI_Net_MIS_DocketYetNotDelivered_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP="",RTP_DT_str="";
    double RO_TOTDKT = 0, RO_NOTARRIVED = 0, RO_DELIVERED = 0, RO_WAITINGFORDRS = 0, RO_GONEFORDELIVERED = 0, RO_UNDELIVERED = 0;
    double TOTRO_TOTDKT = 0, TOTRO_NOTARRIVED = 0, TOTRO_DELIVERED = 0, TOTRO_WAITINGFORDRS = 0, TOTRO_GONEFORDELIVERED = 0, TOTRO_UNDELIVERED = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();

        }
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string RO, LO, DateType, fromdt, todt;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        
        string dtFrom = fromdt;
        string dtTo = todt;

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;



        string SQL_STR = "exec WbxNet_Yet_Not_delivered '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "'";
        //Response.Write("..." + SQL_STR);
        SqlCommand CMD = new SqlCommand(SQL_STR, conn);
        SqlDataReader DR = CMD.ExecuteReader();
        TBL_CF.Visible = true;
        TableRow TR = new TableRow();
        TableCell TRTC1 = new TableCell();

        TRTC1.Text = "Sr. No";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);


        TRTC1 = new TableCell();
        TRTC1.Text = "Location";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Total" + dkt_call;
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Not Arrived <br/> At <br/>Destination";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Delivered";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Waiting<br/>For<br/>DRS";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Gone<br/>For<br/>Delivery";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "Undelivered";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TR.BorderWidth = 1;
        TR.HorizontalAlign = HorizontalAlign.Center;
        TR.BorderColor = System.Drawing.Color.Gray;
        TR.CssClass = "bgbluegrey";
        //TR.BackColor = System.Drawing.Color.White;
       // TR.CssClass = "blackfnt";
        TBL_CF.Rows.Add(TR);

        string C_LOC = "", P_LOC = "", C_RO = "", P_RO = "";
        int i = 1;
        while (DR.Read())
        {

            C_RO = DR["report_loc_name"].ToString();

            if (C_RO != P_RO && P_RO != "")
            {
                TableRow TR2 = new TableRow();
                TableCell TR2TC1 = new TableCell();

                TR2TC1.Text = P_RO.ToString();
                TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_TOTDKT.ToString();
               // TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_NOTARRIVED.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_DELIVERED.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_WAITINGFORDRS.ToString();
               // TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_GONEFORDELIVERED.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_UNDELIVERED.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                

                TR2.BorderWidth = 1;
                TR2.HorizontalAlign = HorizontalAlign.Center;
                TR2.BorderColor = System.Drawing.Color.Gray;
                TR2.BackColor = System.Drawing.Color.White;
                TR2.CssClass = "bluefnt";
                TR2.Font.Bold = true;

                RO_TOTDKT = 0;
                RO_NOTARRIVED = 0;
                RO_DELIVERED = 0;
                RO_WAITINGFORDRS = 0;
                RO_GONEFORDELIVERED = 0;
                RO_UNDELIVERED = 0;

                TBL_CF.Rows.Add(TR2);
            }



            TableRow TR1 = new TableRow();
            TableCell TR1TC1 = new TableCell();

            TR1TC1.Text = i.ToString();
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["locname"].ToString();
            TR1TC1.HorizontalAlign = HorizontalAlign.Left;
            TR1TC1.Wrap = false;
            TR1.Cells.Add(TR1TC1);


            TR1TC1 = new TableCell();


            if (Convert.ToDouble(DR["Total_Dockets"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','1')\"> <u>" + DR["Total_Dockets"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);



            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["NotArrived_At_dest"].ToString();
            if (Convert.ToDouble(DR["NotArrived_At_dest"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','2')\"> <u>" + DR["NotArrived_At_dest"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);



            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["Delivered"].ToString();
            if (Convert.ToDouble(DR["Delivered"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','3')\"> <u>" + DR["Delivered"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);




            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["Waiting_FOR_DRS"].ToString();
            if (Convert.ToDouble(DR["Waiting_FOR_DRS"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','4')\"> <u>" + DR["Waiting_FOR_DRS"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["Gone_for_Delivery"].ToString();
            if (Convert.ToDouble(DR["Gone_for_Delivery"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','5')\"> <u>" + DR["Gone_for_Delivery"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["UnDelivered"].ToString();
            if (Convert.ToDouble(DR["UnDelivered"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','6')\"> <u>" + DR["UnDelivered"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1.BorderWidth = 1;
            TR1.HorizontalAlign = HorizontalAlign.Center;
            TR1.BorderColor = System.Drawing.Color.Gray;
            TR1.BackColor = System.Drawing.Color.White;
            TR1.CssClass = "blackfnt";
            TBL_CF.Rows.Add(TR1);

            P_RO = DR["report_loc_name"].ToString();
            i += 1;

            RO_TOTDKT += Convert.ToDouble(DR["Total_Dockets"].ToString());
            RO_NOTARRIVED += Convert.ToDouble(DR["NotArrived_At_dest"].ToString());
            RO_DELIVERED += Convert.ToDouble(DR["Delivered"].ToString());
            RO_WAITINGFORDRS += Convert.ToDouble(DR["Waiting_FOR_DRS"].ToString());
            RO_GONEFORDELIVERED += Convert.ToDouble(DR["Gone_for_Delivery"].ToString());
            RO_UNDELIVERED += Convert.ToDouble(DR["UnDelivered"].ToString());

            TOTRO_TOTDKT += Convert.ToDouble(DR["Total_Dockets"].ToString());
            TOTRO_NOTARRIVED += Convert.ToDouble(DR["NotArrived_At_dest"].ToString());
            TOTRO_DELIVERED += Convert.ToDouble(DR["Delivered"].ToString());
            TOTRO_WAITINGFORDRS += Convert.ToDouble(DR["Waiting_FOR_DRS"].ToString());
            TOTRO_GONEFORDELIVERED += Convert.ToDouble(DR["Gone_for_Delivery"].ToString());
            TOTRO_UNDELIVERED += Convert.ToDouble(DR["UnDelivered"].ToString());
            P_RO = DR["report_loc_name"].ToString();
        }
        DR.Close();

        TableRow TRb = new TableRow();
        TableCell TRbTC1 = new TableCell();

        TRbTC1.Text = P_RO.ToString();
        TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_TOTDKT.ToString();
        // TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_NOTARRIVED.ToString();
        //TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_DELIVERED.ToString();
        //TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_WAITINGFORDRS.ToString();
        // TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_GONEFORDELIVERED.ToString();
        //TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_UNDELIVERED.ToString();
        //TRbTC1.ColumnSpan = 2;
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);



        TRb.BorderWidth = 1;
        TRb.HorizontalAlign = HorizontalAlign.Center;
        TRb.BorderColor = System.Drawing.Color.Gray;
        TRb.BackColor = System.Drawing.Color.White;
        TRb.CssClass = "bluefnt";
        TRb.Font.Bold = true;

        TBL_CF.Rows.Add(TRb);

        TableRow TRa = new TableRow();
        TableCell TRaTC1 = new TableCell();

        TRaTC1.Text = "Total";
        TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_TOTDKT.ToString();
        // TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_NOTARRIVED.ToString();
        //TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_DELIVERED.ToString();
        //TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_WAITINGFORDRS.ToString();
        // TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_GONEFORDELIVERED.ToString();
        //TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_UNDELIVERED.ToString();
        //TRaTC1.ColumnSpan = 2;
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);



        TRa.BorderWidth = 1;
        TRa.HorizontalAlign = HorizontalAlign.Center;
        TRa.BorderColor = System.Drawing.Color.Gray;
        TRa.BackColor = System.Drawing.Color.White;
        TRa.CssClass = "bluefnt";
        TRa.Font.Bold = true;

        TBL_CF.Rows.Add(TRa);


     

        conn.Close();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=DocketNotYetDelivered.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        Response.Write("Docket Not Yet Delivered");
        frm.Controls.Add(TBL_CF);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    //protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
           
    //    }
    //}
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        //dgDocket.PageIndex = e.NewPageIndex;
        //BindGrid();
    }
}
