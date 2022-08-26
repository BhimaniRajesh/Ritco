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
public partial class GUI_Tracking_ver1_Docket_OpnLifeCycle : System.Web.UI.Page
{
    public static string call_dkt;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["DocketCalledAs"].ToString();
        string sqlstr = "select dockno,docksf,CurLoc,NextLoc,ARDT,dockdt,DKTCUM,LSSTATUS,LS,LSLoc,LSDT,LSCUM,MFSTATUS,MF,MFLoc,MFDT,MFCUM,MF_Can,THCSTATUS,THC,THCLoc,THCDT,THCCUM,THC_CAN,PRSSTATUS,PRS,PRSLoc,PRSDT,PRSCUM,PRS_CAN,DRSSTATUS,DRS,DRSLoc,DRSDT,DRSCUM,DRS_CAN,THCveh,DRSVeh,ArrvDt,DeptDt,SRNO from VwNet_DKT_Time_Track where dockno='" + str_dockno + "' and docksf='" + str_docksf + "' order by srno";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        TableRow tr1 = new TableRow();
        TableCell tr1tc = new TableCell();
        tr1tc.Text = "Activity";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;        
        tr1.Cells.Add(tr1tc);

       
        tr1tc = new TableCell();
        tr1tc.Text = "Status";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Document No.";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Date";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Cumulative Days";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "View Document";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1.CssClass = "bgbluegrey";
        tr1.BorderWidth = 1;
        tr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.BorderColor = System.Drawing.Color.Gray;

        tblOPNLIFECYCLE.Rows.Add(tr1);
        int i = 1;

        while (dr.Read())
        {
            TableRow tr2 = new TableRow();
            TableCell tr2tc = new TableCell();
            tr2tc.Text = "Activity At - " + dr["CurLoc"].ToString();
            tr2tc.CssClass = "blackboldfnt";
            tr2tc.Wrap = false;
            tr2tc.ColumnSpan = 6;
            tr2.Cells.Add(tr2tc);

            tr2.CssClass = "bgbluegrey";
            tr2.BorderWidth = 1;
            tr2.HorizontalAlign = HorizontalAlign.Center;
            tr2.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr2);


            TableRow tr3 = new TableRow();
            TableCell tr3tc = new TableCell();

            
            tr3tc.Text = "Booked/Arrived";
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            if (i == 1)
            {
                tr3tc.Text = "Booked At - " + dr["CurLoc"].ToString();
            }
            else
            {
                tr3tc.Text = "Arrived At - " + dr["CurLoc"].ToString();
            }
            tr3tc.CssClass = "bluefnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["dockno"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            if (i == 1)
            {
                tr3tc.Text = dr["dockdt"].ToString();
            }
            else
            {
                tr3tc.Text = dr["ARDT"].ToString();
            }
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);


            tr3tc = new TableCell();
            tr3tc.Text = dr["DKTCUM"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["dockno"].ToString();
            if (tr3tc.Text != "")
            {
                tr3tc.Text = "<a href=\"JavaScript:OpenPopupWindowDocket('" + dr["dockno"].ToString() + "')\"> View </a>";
            }
            
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            //tr3.CssClass = "bgbluegrey";
            tr3.BorderWidth = 1;
            tr3.BackColor = System.Drawing.Color.White;
            tr3.HorizontalAlign = HorizontalAlign.Center;
            tr3.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr3);

            TableRow tr41 = new TableRow();
            TableCell tr41tc = new TableCell();


            tr41tc.Text = "PRS ";
            tr41tc.CssClass = "blackfnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);

            tr41tc = new TableCell();
            tr41tc.Text = dr["PRSSTATUS"].ToString();
            tr41tc.CssClass = "bluefnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);

            tr41tc = new TableCell();
            tr41tc.Text = dr["PRS"].ToString();
            tr41tc.CssClass = "blackfnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);

            tr41tc = new TableCell();
            tr41tc.Text = dr["PRSDT"].ToString();
            tr41tc.CssClass = "blackfnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);


            tr41tc = new TableCell();
            tr41tc.Text = dr["PRSCUM"].ToString();
            tr41tc.CssClass = "blackfnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);

            tr41tc = new TableCell();
            tr41tc.Text = dr["PRS"].ToString();
            if (tr41tc.Text != "")
            {
                tr41tc.Text = "<a href=\"JavaScript:OpenPopupWindowPRS('" + dr["PRS"].ToString() + "')\"> View </a>";
            }
            tr41tc.CssClass = "blackfnt";
            tr41tc.Wrap = false;
            tr41.Cells.Add(tr41tc);

            //tr41.CssClass = "bgbluegrey";
            tr41.BorderWidth = 1;
            tr41.BackColor = System.Drawing.Color.White;
            tr41.HorizontalAlign = HorizontalAlign.Center;
            tr41.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr41);


            TableRow tr4 = new TableRow();
            TableCell tr4tc = new TableCell();


            tr4tc.Text = "LS ";
            tr4tc.CssClass = "blackfnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);

            tr4tc = new TableCell();
            tr4tc.Text = dr["LSSTATUS"].ToString();
            tr4tc.CssClass = "bluefnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);

            tr4tc = new TableCell();
            tr4tc.Text = dr["LS"].ToString();
            tr4tc.CssClass = "blackfnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);

            tr4tc = new TableCell();
            tr4tc.Text = dr["LSDT"].ToString();
            tr4tc.CssClass = "blackfnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);


            tr4tc = new TableCell();
            tr4tc.Text = dr["LSCUM"].ToString();
            tr4tc.CssClass = "blackfnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);

            tr4tc = new TableCell();
            tr4tc.Text = dr["LS"].ToString();
            if (tr4tc.Text != "")
            {
                tr4tc.Text = "<a href=\"JavaScript:OpenPopupWindowLS('" + dr["LS"].ToString() + "')\"> View </a>";
            }
            
            tr4tc.CssClass = "blackfnt";
            tr4tc.Wrap = false;
            tr4.Cells.Add(tr4tc);

            //tr4.CssClass = "bgbluegrey";
            tr4.BorderWidth = 1;
            tr4.BackColor = System.Drawing.Color.White;
            tr4.HorizontalAlign = HorizontalAlign.Center;
            tr4.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr4);


            TableRow tr5 = new TableRow();
            TableCell tr5tc = new TableCell();


            tr5tc.Text = "MF ";
            tr5tc.CssClass = "blackfnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);

            tr5tc = new TableCell();
            tr5tc.Text = dr["MFSTATUS"].ToString();
            tr5tc.CssClass = "bluefnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);

            tr5tc = new TableCell();
            tr5tc.Text = dr["MF"].ToString();
            tr5tc.CssClass = "blackfnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);

            tr5tc = new TableCell();
            tr5tc.Text = dr["MFDT"].ToString();
            tr5tc.CssClass = "blackfnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);


            tr5tc = new TableCell();
            tr5tc.Text = dr["MFCUM"].ToString();
            tr5tc.CssClass = "blackfnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);

            tr5tc = new TableCell();
            tr5tc.Text = dr["MF"].ToString();
            if (tr5tc.Text != "")
            {
                tr5tc.Text = "<a href=\"JavaScript:OpenPopupWindowMF('" + dr["MF"].ToString() + "')\"> View </a>";
            }
            tr5tc.CssClass = "blackfnt";
            tr5tc.Wrap = false;
            tr5.Cells.Add(tr5tc);

            //tr5.CssClass = "bgbluegrey";
            tr5.BorderWidth = 1;
            tr5.BackColor = System.Drawing.Color.White;
            tr5.HorizontalAlign = HorizontalAlign.Center;
            tr5.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr5);


            TableRow tr6 = new TableRow();
            TableCell tr6tc = new TableCell();


            tr6tc.Text = "THC ";
            tr6tc.CssClass = "blackfnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);

            tr6tc = new TableCell();
            tr6tc.Text = dr["THCSTATUS"].ToString();
            tr6tc.CssClass = "bluefnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);

            tr6tc = new TableCell();
            tr6tc.Text = dr["THC"].ToString();
            tr6tc.CssClass = "blackfnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);

            tr6tc = new TableCell();
            tr6tc.Text = dr["THCDT"].ToString();
            tr6tc.CssClass = "blackfnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);


            tr6tc = new TableCell();
            tr6tc.Text = dr["THCCUM"].ToString();
            tr6tc.CssClass = "blackfnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);

            tr6tc = new TableCell();
            tr6tc.Text = dr["THC"].ToString();
            if (tr6tc.Text != "")
            {
                tr6tc.Text = "<a href=\"JavaScript:OpenPopupWindowTHC('" + dr["THC"].ToString() + "')\"> View </a>";
            }
            tr6tc.CssClass = "blackfnt";
            tr6tc.Wrap = false;
            tr6.Cells.Add(tr6tc);

            //tr6.CssClass = "bgbluegrey";
            tr6.BorderWidth = 1;
            tr6.BackColor = System.Drawing.Color.White;
            tr6.HorizontalAlign = HorizontalAlign.Center;
            tr6.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr6);



            TableRow tr7 = new TableRow();
            TableCell tr7tc = new TableCell();


            tr7tc.Text = "DRS ";
            tr7tc.CssClass = "blackfnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);

            tr7tc = new TableCell();
            tr7tc.Text = dr["DRSSTATUS"].ToString();
            tr7tc.CssClass = "bluefnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);

            tr7tc = new TableCell();
            tr7tc.Text = dr["DRS"].ToString();
            tr7tc.CssClass = "blackfnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);

            tr7tc = new TableCell();
            tr7tc.Text = dr["DRSDT"].ToString();
            tr7tc.CssClass = "blackfnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);


            tr7tc = new TableCell();
            tr7tc.Text = dr["DRSCUM"].ToString();
            tr7tc.CssClass = "blackfnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);

            tr7tc = new TableCell();
            tr7tc.Text = dr["DRS"].ToString();
            if (tr7tc.Text != "")
            {
                tr7tc.Text = "<a href=\"JavaScript:OpenPopupWindowDRS('" + dr["DRS"].ToString() + "')\"> View </a>";
            }
            tr7tc.CssClass = "blackfnt";
            tr7tc.Wrap = false;
            tr7.Cells.Add(tr7tc);

            //tr7.CssClass = "bgbluegrey";
            tr7.BorderWidth = 1;
            tr7.BackColor = System.Drawing.Color.White;
            tr7.HorizontalAlign = HorizontalAlign.Center;
            tr7.BorderColor = System.Drawing.Color.Gray;

            tblOPNLIFECYCLE.Rows.Add(tr7);



            i += 1;

        }
        dr.Close();

        conn.Close();
    }
}
