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

public partial class GUI_UNI_Net_MIS_ReassignDocket_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP = "", RTP_DT_str = "";
    double RO_TOTDKT = 0, RO_PT = 0, RO_TT = 0, RO_PB = 0, RO_TB = 0, RO_PN = 0, RO_TN = 0;
    double TOTRO_TOTDKT = 0, TOTRO_PT = 0, TOTRO_TT = 0, TOTRO_PB = 0, TOTRO_TB = 0, TOTRO_PN = 0, TOTRO_TN = 0;

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

        string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + LO + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, conn);
        SqlDataReader drLoc;
        drLoc = cmdLoc.ExecuteReader();

        while (drLoc.Read())
        {
            lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        }
        drLoc.Close();

        string sqlRegion = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + RO + "'";
        SqlCommand cmdRegion = new SqlCommand(sqlRegion, conn);
        SqlDataReader drRegion;
        drRegion = cmdRegion.ExecuteReader();

        while (drRegion.Read())
        {
            lblro.Text = Convert.ToString(drRegion["Loccode"]) + ":" + Convert.ToString(drRegion["Locname"]);
        }
        drRegion.Close();

        string SQL_STR = "exec webx_Reassign_report '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "'";
        //Response.Write("..." + SQL_STR);
        //Response.End();
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
        TRTC1.Text = "PAID - TBB";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "TO PAY - TBB";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "TBB- PAID";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "TBB - TOPAY";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "PAID-TOPAY";
        TRTC1.CssClass = "blackboldfnt";
        TRTC1.Wrap = false;
        TR.Cells.Add(TRTC1);

        TRTC1 = new TableCell();
        TRTC1.Text = "TOPAY-PAID";
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
                TR2TC1.Text = RO_PT.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                
                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_TT.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_PB.ToString();
                // TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_TB.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_PN.ToString();
                //TR2TC1.ColumnSpan = 2;
                TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                TR2.Cells.Add(TR2TC1);

                TR2TC1 = new TableCell();
                TR2TC1.Text = RO_TN.ToString();
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
                RO_PT = 0;
                RO_TT = 0;
                RO_PB = 0;
                RO_TB = 0;
                RO_PN = 0;
                RO_TN = 0;

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


            if (Convert.ToDouble(DR["tot_dkts"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','1')\"> <u>" + DR["tot_dkts"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);



            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["TBB_paid"].ToString();
            if (Convert.ToDouble(DR["TBB_paid"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','2')\"> <u>" + DR["TBB_paid"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);



            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["TBB_Topay"].ToString();
            if (Convert.ToDouble(DR["TBB_Topay"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','3')\"> <u>" + DR["TBB_Topay"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);




            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["BOD_paid"].ToString();
            if (Convert.ToDouble(DR["BOD_paid"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','4')\"> <u>" + DR["BOD_paid"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["BOD_Topay"].ToString();
            if (Convert.ToDouble(DR["BOD_Topay"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','5')\"> <u>" + DR["BOD_Topay"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["National_paid"].ToString();
            if (Convert.ToDouble(DR["National_paid"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','6')\"> <u>" + DR["National_paid"].ToString() + "</u></a> ";
            }
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1); 

            TR1TC1 = new TableCell();
            TR1TC1.Text = DR["National_Topay"].ToString();
            if (Convert.ToDouble(DR["National_Topay"]) > 0)
            {
                TR1TC1.Text = "<a href=\"JavaScript:DrillDown('" + fromdt + "','" + todt + "','" + DR["loccode"].ToString() + "','6')\"> <u>" + DR["National_Topay"].ToString() + "</u></a> ";
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

            RO_TOTDKT += Convert.ToDouble(DR["tot_dkts"].ToString());
            RO_PT += Convert.ToDouble(DR["TBB_paid"].ToString());
            RO_TT += Convert.ToDouble(DR["TBB_Topay"].ToString());
            RO_PB += Convert.ToDouble(DR["BOD_paid"].ToString());
            RO_TB += Convert.ToDouble(DR["BOD_Topay"].ToString());
            RO_PN += Convert.ToDouble(DR["National_paid"].ToString());
            RO_TN += Convert.ToDouble(DR["National_Topay"].ToString());

            TOTRO_TOTDKT += Convert.ToDouble(DR["tot_dkts"].ToString());
            TOTRO_PT += Convert.ToDouble(DR["TBB_paid"].ToString());
            TOTRO_TT += Convert.ToDouble(DR["TBB_Topay"].ToString());
            TOTRO_PB += Convert.ToDouble(DR["BOD_paid"].ToString());
            TOTRO_TB += Convert.ToDouble(DR["BOD_Topay"].ToString());
            TOTRO_PN += Convert.ToDouble(DR["National_paid"].ToString());
            TOTRO_TN += Convert.ToDouble(DR["National_Topay"].ToString());

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
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_PT.ToString();
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_TT.ToString();
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        
        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_PB.ToString();
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_TB.ToString();
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_PN.ToString();
        TRbTC1.HorizontalAlign = HorizontalAlign.Center;
        TRb.Cells.Add(TRbTC1);

        TRbTC1 = new TableCell();
        TRbTC1.Text = RO_TN.ToString();
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
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_PT.ToString();
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_TT.ToString();
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_PB.ToString();
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_TB.ToString();
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_PN.ToString();
        TRaTC1.HorizontalAlign = HorizontalAlign.Center;
        TRa.Cells.Add(TRaTC1);

        TRaTC1 = new TableCell();
        TRaTC1.Text = TOTRO_TN.ToString();
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
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=ReassignDocket.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        Response.Write("Reassign Docket");
        frm.Controls.Add(TBL_CF);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }
}

