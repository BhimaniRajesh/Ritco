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


public partial class GUI_UNI_Net_MIS_FollowUp_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_Call = Session["DocketCalledAs"].ToString();
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
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string RO = "", LO = "", RTP_DT_str = "", fromdt = "", todt = "", RPT = "", st_cust_vend = "";

        double RO_TOTDKTS = 0, RO_ARR = 0, RO_MRGEN = 0, RO_MRAMT = 0, RO_MRCL = 0, RO_CLAMT = 0, RO_MROS = 0, RO_OSAMT = 0;
        double TOT_TOTDKTS = 0, TOT_ARR = 0, TOT_MRGEN = 0, TOT_MRAMT = 0, TOT_MRCL = 0, TOT_CLAMT = 0, TOT_MROS = 0, TOT_OSAMT = 0;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT = Request.QueryString["RPT"].ToString();
        RTP_DT_str = Request.QueryString["RPT_STR"].ToString();
        st_cust_vend = Request.QueryString["cust"].ToString();

        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        if (st_cust_vend == "")
            st_cust_vend = "All";
        lblGrp.Text = st_cust_vend;
    
        lbltypBill.Text ="Collection Follow-Up "+ RTP_DT_str;


        string SQL_STR = "exec WebxNet_FOllowUP_Paid_ToPay '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + st_cust_vend + "','" + RPT + "'";
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
        SqlDataReader DR = CMD.ExecuteReader();
        TBL_CF.Visible = true;
        TableRow TR = new TableRow();
        TableCell TRTC1 = new TableCell();

        TRTC1.Text = "SRNO";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);


        TRTC1 = new TableCell();
        TRTC1.Text = "Location";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        if (RPT == "1")
        {
            TRTC1.Text = "Total " + dkt_Call + "s Booked At Location";
        }
        else
        {
            TRTC1.Text = "Total " + dkt_Call + "s Booked For Location";
        }
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        if (RPT != "1")
        {
            TRTC1 = new TableCell();
            TRTC1.Text = "Total " + dkt_Call + "s Arrived At Dest.";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);
        }

        TRTC1 = new TableCell();
        TRTC1.Text = "MR Generated";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "MR Amt.";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "MR Closed";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "MR Closed Amt.";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "MR OutStanding";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "MR OutStanding Amt.";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

        TR.BorderWidth = 1;
        TR.HorizontalAlign = HorizontalAlign.Center;
        TR.BorderColor = System.Drawing.Color.Gray;
        TR.CssClass = "bgbluegrey";
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
                TR2TC1.Text = RO_TOTDKTS.ToString();
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                if (RPT != "1")
                {
                    TR2TC1 = new TableCell();
                    TR2TC1.Text = RO_ARR.ToString();
                    TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                    TR2.Cells.Add(TR2TC1);
                }

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_MRGEN.ToString();
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text =RO_MRAMT.ToString("F2");
                TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_MRCL.ToString();
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_CLAMT.ToString("F2");
                TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_MROS.ToString();
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_OSAMT.ToString("F2");
                TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                TR2.Cells.Add(TR2TC1);


                TR2.BorderWidth = 1;
                TR2.HorizontalAlign = HorizontalAlign.Center;
                TR2.BorderColor = System.Drawing.Color.Gray;
                TR2.BackColor = System.Drawing.Color.White;
                TR2.CssClass = "bluefnt";
                TR2.Font.Bold = true;
               
                TBL_CF.Rows.Add(TR2);

                RO_TOTDKTS = 0;
                RO_ARR = 0; 
                RO_MRGEN = 0; 
                RO_MRAMT = 0;
                RO_MRCL = 0; 
                RO_CLAMT = 0;
                RO_MROS = 0; 
                RO_OSAMT = 0;

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


            TR1TC1 = new TableCell();//
           
            
            if (Convert.ToDouble(DR["TOT_docket"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','" + st_cust_vend + "','" + RPT + "','1')\"> <u>" + DR["TOT_docket"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            if (RPT != "1")
            {
                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["Arrived"].ToString();
                TR1TC1.HorizontalAlign = HorizontalAlign.Center;
                TR1.Cells.Add(TR1TC1);
            }

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_gen"].ToString();
            if (Convert.ToDouble(DR["MR_gen"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','" + st_cust_vend + "','" + RPT + "','2')\"> <u>" + DR["MR_gen"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_gen_amt"].ToString();
            TR1TC1.HorizontalAlign = HorizontalAlign.Right;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_CloseD"].ToString();
            if (Convert.ToDouble(DR["MR_CloseD"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','" + st_cust_vend + "','" + RPT + "','3')\"> <u>" + DR["MR_CloseD"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);


            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_Closed_amt"].ToString();
            TR1TC1.HorizontalAlign = HorizontalAlign.Right;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_not_Closed"].ToString();
            if (Convert.ToDouble(DR["MR_not_Closed"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','" + st_cust_vend + "','" + RPT + "','4')\"> <u>" + DR["MR_not_Closed"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);


            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["MR_not_Closed_amt"].ToString();
            TR1TC1.HorizontalAlign = HorizontalAlign.Right;
            TR1.Cells.Add(TR1TC1);

            TR1.BorderWidth = 1;
            TR1.HorizontalAlign = HorizontalAlign.Center;
            TR1.BorderColor = System.Drawing.Color.Gray;
            TR1.BackColor = System.Drawing.Color.White;
            TR1.CssClass = "blackfnt";
            TBL_CF.Rows.Add(TR1);

            P_RO = DR["report_loc_name"].ToString();
            i += 1;

            
            if (RPT != "1")
            {
                RO_ARR += Convert.ToDouble(DR["Arrived"]);
                TOT_ARR += Convert.ToDouble(DR["Arrived"]);
            }
            RO_TOTDKTS += Convert.ToDouble(DR["TOT_docket"]);
            RO_MRGEN += Convert.ToDouble(DR["MR_gen"]);
            RO_MRAMT += Convert.ToDouble(DR["MR_gen_amt"]);
            RO_MRCL += Convert.ToDouble(DR["MR_CloseD"]);
            RO_CLAMT += Convert.ToDouble(DR["MR_Closed_amt"]);
            RO_MROS += Convert.ToDouble(DR["MR_not_Closed"]);
            RO_OSAMT += Convert.ToDouble(DR["MR_not_Closed_amt"]);

            TOT_TOTDKTS += Convert.ToDouble(DR["TOT_docket"]);
            TOT_MRGEN += Convert.ToDouble(DR["MR_gen"]);
            TOT_MRAMT += Convert.ToDouble(DR["MR_gen_amt"]);
            TOT_MRCL += Convert.ToDouble(DR["MR_CloseD"]);
            TOT_CLAMT += Convert.ToDouble(DR["MR_Closed_amt"]);
            TOT_MROS += Convert.ToDouble(DR["MR_not_Closed"]);
            TOT_OSAMT += Convert.ToDouble(DR["MR_not_Closed_amt"]);
        }

        DR.Close();

        TableRow TR4 = new TableRow();
        TableCell TR4TC1 = new TableCell();

        TR4TC1.Text = P_RO.ToString();
        TR4TC1.ColumnSpan = 2;
        TR4TC1.HorizontalAlign = HorizontalAlign.Center;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_TOTDKTS.ToString();
        TR4TC1.HorizontalAlign = HorizontalAlign.Center;
        TR4.Cells.Add(TR4TC1);

        if (RPT != "1")
        {
            TR4TC1 = new TableCell();
            TR4TC1.Text = RO_ARR.ToString();
            TR4TC1.HorizontalAlign = HorizontalAlign.Center;
            TR4.Cells.Add(TR4TC1);
        }

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_MRGEN.ToString();
        TR4TC1.HorizontalAlign = HorizontalAlign.Center;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_MRAMT.ToString("F2");
        TR4TC1.HorizontalAlign = HorizontalAlign.Right;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_MRCL.ToString();
        TR4TC1.HorizontalAlign = HorizontalAlign.Center;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_CLAMT.ToString("F2");
        TR4TC1.HorizontalAlign = HorizontalAlign.Right;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_MROS.ToString();
        TR4TC1.HorizontalAlign = HorizontalAlign.Center;
        TR4.Cells.Add(TR4TC1);

        TR4TC1 = new TableCell();
        TR4TC1.Text = RO_OSAMT.ToString("F2");
        TR4TC1.HorizontalAlign = HorizontalAlign.Right;
        TR4.Cells.Add(TR4TC1);


        TR4.BorderWidth = 1;
        TR4.HorizontalAlign = HorizontalAlign.Center;
        TR4.BorderColor = System.Drawing.Color.Gray;
        TR4.BackColor = System.Drawing.Color.White;
        TR4.CssClass = "bluefnt";
        TR4.Font.Bold = true;

        TBL_CF.Rows.Add(TR4);

        TableRow TR5 = new TableRow();
        TableCell TR5TC1 = new TableCell();

        TR5TC1.Text = "Total";
        TR5TC1.ColumnSpan = 2;
        TR5TC1.HorizontalAlign = HorizontalAlign.Center;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_TOTDKTS.ToString();
        TR5TC1.HorizontalAlign = HorizontalAlign.Center;
        TR5.Cells.Add(TR5TC1);

        if (RPT != "1")
        {
            TR5TC1 = new TableCell();
            TR5TC1.Text = TOT_ARR.ToString();
            TR5TC1.HorizontalAlign = HorizontalAlign.Center;
            TR5.Cells.Add(TR5TC1);
        }

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_MRGEN.ToString();
        TR5TC1.HorizontalAlign = HorizontalAlign.Center;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_MRAMT.ToString("F2");
        TR5TC1.HorizontalAlign = HorizontalAlign.Right;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_MRCL.ToString();
        TR5TC1.HorizontalAlign = HorizontalAlign.Center;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_CLAMT.ToString("F2");
        TR5TC1.HorizontalAlign = HorizontalAlign.Right;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_MROS.ToString();
        TR5TC1.HorizontalAlign = HorizontalAlign.Center;
        TR5.Cells.Add(TR5TC1);

        TR5TC1 = new TableCell();
        TR5TC1.Text = TOT_OSAMT.ToString("F2");
        TR5TC1.HorizontalAlign = HorizontalAlign.Right;
        TR5.Cells.Add(TR5TC1);


        TR5.BorderWidth = 1;
        TR5.HorizontalAlign = HorizontalAlign.Center;
        TR5.BorderColor = System.Drawing.Color.Gray;
        TR5.BackColor = System.Drawing.Color.White;
        TR5.CssClass = "bluefnt";
        TR5.Font.Bold = true;

        TBL_CF.Rows.Add(TR5);


       
        Conn.Close();
    }
    public void DWN_XLS()
    {

        TBL_CRI.Border = 1;

        TBL_CF.BorderWidth = 1;
        TBL_CF.BorderColor = System.Drawing.Color.Gray;
        TBL_CF.Font.Name = "verdana";
        TBL_CF.Font.Size = 8;


        //BindGrid();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Cash_Income_Management.xls");
        Response.Charset = "";

        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(TBL_CF);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }


}
