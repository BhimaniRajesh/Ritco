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
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;

public partial class GUI_View_Track_Operation_Result_RS : System.Web.UI.Page
{
    SqlConnection Conn;
    public int TOTPg = 0, MaxPgsize = 0;
    int ij = 1;
    public static string strcust, dkt_call,THC_call;
    public static int jk = 0, i = 0, j = 1;
  
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();
        if (!IsPostBack)
        {
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
            string MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();
            // string DateType = Request.QueryString.Get("DateType");
            string fromdt = Request.QueryString.Get("fromdt");
            string todt = Request.QueryString.Get("todt");
            string st_Docnolist = Request.QueryString.Get("st_Docnolist");
            string St_Manualnolist = Request.QueryString.Get("St_Manualnolist");
            string st_Vehnolist = Request.QueryString.Get("st_Vehnolist");
            string st_Freetext = Request.QueryString.Get("st_Freetext");
            string st_doctyp = Request.QueryString.Get("st_doctyp");

            string PGNO = Request.QueryString["PGNO"].ToString();
            string PGSIZE = Request.QueryString["Psize"].ToString();


            Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            Conn.Open();

         //   string sqlQuery1 = "exec WebxNet_OPSSTATUSREport '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + DTTYPE + "','1','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "','" + st_status + "','" + st_status_sub + "','" + strdays + "','0','100'";
            string sqlQuery1 = "exec webxNet_Tracking_Ver1 '" + fromdt + "','" + todt + "','" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "','0','" + PGSIZE + "'";
            //Response.Write("SQL_QA " + SQL_QA);
            //  Response.Write("sqlQuery1 " + sqlQuery1);
            SqlCommand sqlcmd121 = new SqlCommand(sqlQuery1, Conn);
		sqlcmd121.CommandTimeout = 1000;
            SqlDataReader dread = sqlcmd121.ExecuteReader();
            while (dread.Read())
            {
                TOTPg = Convert.ToInt32(dread.GetValue(2).ToString());
                MaxPgsize = Convert.ToInt32(dread.GetValue(0).ToString());
               
            }
            dread.Close();
            jk = Convert.ToInt32(PGSIZE);   
           
            //if (DWN_XLS == "1")
            //    PGSIZE = MaxPgsize.ToString();


            for (int i = 1; i < TOTPg + 1; i++)
            {
                PAging.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            if (TOTPg == 0)
            {
                PAging.Items.Clear();
                PAging.DataTextField = PGNO.ToString();
                PAging.DataValueField = PGNO.ToString();
            }
            PAging.SelectedValue = PGNO.ToString();
            PAging.AutoPostBack = true;

            if (PAging.Items.Count == 1 || TOTPg == 0)
            {
                TRPG.Style["display"] = "none";
            }

            if (PGNO == "1")
            {
                imgPrev.Style["display"] = "none";
            }
            if (Convert.ToInt16(PGNO) > 1 || Convert.ToInt16(PGNO) == TOTPg)
            {
                imgNext.Style["display"] = "none";
            }

            string sqlQuery = "exec webxNet_Tracking_Ver1 '" + fromdt + "','" + todt + "','" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "'," + PGNO + "," + PGSIZE + "";        


            SqlCommand sqlcmd12_PNL = new SqlCommand(sqlQuery, Conn);
		sqlcmd12_PNL.CommandTimeout = 1000;
            //Response.Write("<BR> sqlQuery : " + sqlQuery);
            //Response.End();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12_PNL);
            DataSet ds = new DataSet();
            da.Fill(ds);

            lblseldet.Text = fromdt + " - " + todt;
            lblloc.Text = MAxStr_VAL + " - " + MAxStr_VAL_to;
            //lblloc.Text = LO + " - " + LO_TO;

            if (st_doctyp == "DKT")
            {
                DGTrackDKT.DataSource = ds;
                DGTrackDKT.DataBind();
                DGTrackDKT.Visible = true;
                TR1.Style["display"] = "block";
            }
            else   if (st_doctyp == "THC")
            {

                dgTHC.DataSource = ds;
                dgTHC.DataBind();
                dgTHC.Visible = true;
                TR2.Style["display"] = "block";
            }
            else if (st_doctyp == "MF")
            {
                dgMenifest.DataSource = ds;
                dgMenifest.DataBind();
                dgMenifest.Visible = true;
                TR3.Style["display"] = "block";
            }
            else if (st_doctyp == "LS")
            {
                dgLS.DataSource = ds;
                dgLS.DataBind();
                dgLS.Visible = true;
                TR4.Style["display"] = "block";
            }
            else if (st_doctyp == "PRS" || st_doctyp == "DRS")
            {
                dgPDC.DataSource = ds;
                dgPDC.DataBind();
                dgPDC.Visible = true;
                TR5.Style["display"] = "block";
            }
            else if (st_doctyp == "PFM")
            {
                dgPFM.DataSource = ds;
                dgPFM.DataBind();
                dgPFM.Visible = true;
                TR6.Style["display"] = "block";
            }
            else if (st_doctyp == "TRS")
            {
                dgTRS.DataSource = ds;
                dgTRS.DataBind();
                dgTRS.Visible = true;
                TR7.Style["display"] = "block";
            }

            Conn.Close();
        }
    }
    protected void dgDOC_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int PGNO = Convert.ToInt32(Request.QueryString["PGNO"]);
            int Psize = Convert.ToInt32(Request.QueryString["Psize"]);
            //if (e.Row.Cells[0].Text != "")
            e.Row.Cells[0].Text = (((PGNO - 1) * Psize) + ij).ToString();
            ij += 1;
            i = (((PGNO - 1) * Psize) + ij);
            j=((Psize) + ij);
        }
    }
    protected void dgTHC_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label THC_colname = (Label)e.Row.FindControl("lblColname");
            THC_colname.Text = THC_call + " No.";
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int PGNO = Convert.ToInt32(Request.QueryString["PGNO"]);
            int Psize = Convert.ToInt32(Request.QueryString["Psize"]);
            //if (e.Row.Cells[0].Text != "")
            e.Row.Cells[0].Text = (((PGNO - 1) * Psize) + ij).ToString();
            ij += 1;
            i = (((PGNO - 1) * Psize) + ij);
            j += 1;
           


            Table table = (Table)this.dgTHC.Controls[0];
            GridView oGridView = (GridView)sender;
            int realindex = table.Rows.GetRowIndex(e.Row);
            GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            Label lbldocstaus = (Label)e.Row.FindControl("lbldocstaus");
            Label lbldockno = (Label)e.Row.FindControl("lbldockno");
            Label lbldocksf = (Label)e.Row.FindControl("lbldocksf");


            oTableCell.Text = "Status : ";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Right;
            oGridViewRow.Cells.Add(oTableCell);

            e.Row.BackColor = System.Drawing.Color.White;

            oTableCell = new TableCell();
            oTableCell.Text = lbldocstaus.Text.ToString();
            oTableCell.ColumnSpan = 4;
            oTableCell.CssClass = "bluefnt";
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Left;
            oGridViewRow.Cells.Add(oTableCell);



            oTableCell = new TableCell();
            string divid = "subcontent" + (j - 1).ToString();
            string Clickdivid = "contentlink" + (j - 1).ToString();

            oTableCell.Text = "  <a href=\"#\" id='" + Clickdivid + "' rel='" + divid + "'><u>Track</u></a> |   <A href=\"JavaScript:OpenWindowTHC('" + lbldockno.Text.ToString() + ",0')\"><u>View</u></a> ";



            string CS_JS = " <DIV id='" + divid + "' style='position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 140px;  padding: 2px;'>";
            CS_JS = CS_JS + "\n <div style='width: 49%; float: left'>";
            CS_JS = CS_JS + " <ul><li><a href=\"JavaScript:OpenPopupWindow_Summary_THC('" + lbldocksf.Text.ToString() + "',1)\" ><font size='+4' class='blackboldfnt'><u>Summary</u></font></a> &nbsp;&nbsp;</li>";
            CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_Summary_THC('" + lbldocksf.Text.ToString() + "',2)\" ><font size='+4' class='blackboldfnt'><u>Movement</u></font></a></li></ul></div>";

            CS_JS = CS_JS + "\n <div align='right'><a href=\"JavaScript:dropdowncontent.hidediv('" + divid + "')\"><b>Close X</b></a></div></DIV>";

            Response.Write(CS_JS);

            oTableCell.ColumnSpan = 3;
            oTableCell.CssClass = "bluefnt";
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Left;
            oGridViewRow.Cells.Add(oTableCell);

            oGridViewRow.BackColor = System.Drawing.Color.White;
            table.Controls.AddAt(realindex + 1, oGridViewRow);
            
        }

    }   
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            dkt_colname.Text = dkt_call + " No.";
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int PGNO = Convert.ToInt32(Request.QueryString["PGNO"]);
            int Psize = Convert.ToInt32(Request.QueryString["Psize"]);
            //if (e.Row.Cells[0].Text != "")
            e.Row.Cells[0].Text = (((PGNO - 1) * Psize) + ij).ToString();

            ij += 1;
            i = (((PGNO - 1) * Psize) + ij);
            j =  ij;
           
                   
            
                Table table = (Table)this.DGTrackDKT.Controls[0];
                GridView oGridView = (GridView)sender;
                int realindex = table.Rows.GetRowIndex(e.Row);
                GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                Label lbldocstaus = (Label)e.Row.FindControl("lbldocstaus");
                Label lbldockno = (Label)e.Row.FindControl("lbldockno");
                Label lbldocksf = (Label)e.Row.FindControl("lbldocksf");


                oTableCell.Text = "Status : ";
                oTableCell.ColumnSpan = 2;
                oTableCell.CssClass = "blackfnt";
                oTableCell.Font.Bold = true;
                oTableCell.HorizontalAlign = HorizontalAlign.Right;
                oGridViewRow.Cells.Add(oTableCell);

                e.Row.BackColor = System.Drawing.Color.White;

                 oTableCell = new TableCell();
                 oTableCell.Text = lbldocstaus.Text.ToString();
                oTableCell.ColumnSpan = 6;
                oTableCell.CssClass = "bluefnt";
                oTableCell.Font.Bold = true;
                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell);



                oTableCell = new TableCell();
                string divid = "subcontent" + (j-1).ToString();
                string Clickdivid = "contentlink" + (j - 1).ToString();

               

                  oTableCell.Text  = " <DIV id='" + divid + "' style='position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 340px; height: 80px; padding: 4px;'>";
                 oTableCell.Text  =  oTableCell.Text  + "\n <div style='width: 49%; float: left'>";
                 oTableCell.Text  =  oTableCell.Text  + " <ul><li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',1)\" ><font size='+4' class='blackboldfnt'><u>Summary</u></font></a> &nbsp;&nbsp;</li>";
                 oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',2)\" ><font size='+4' class='blackboldfnt'><u>Time Tracking</u></font></a></li>";
                 oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',6)\" ><font size='+4' class='blackboldfnt'><u>Movement</u></font></a></li>";
                 oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',5)\" ><font size='+4' class='blackboldfnt'><u>POD/PFM</u></font></a></li></ul></div>";
                 oTableCell.Text  =  oTableCell.Text  + "\n <div style='width: 49%; float: left'>";
                 oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',3)\" ><font size='+4' class='blackboldfnt'><u>Operation Life Cycle</u></font></a></li>";
                 oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',4)\" ><font size='+4' class='blackboldfnt'><u>Finance Life Cycle</u></font></a></li></div>";

                 //oTableCell.Text  =  oTableCell.Text  + " <li><a href=\"JavaScript:OpenPopupWindow_Summary('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "',7)\" ><font size='+4' class='blackboldfnt'><u>Profit/Loss</u></font></a>&nbsp;&nbsp;</li>
                 oTableCell.Text  =  oTableCell.Text  + "\n <div align='right'><a href=\"JavaScript:dropdowncontent.hidediv('" + divid + "')\"><b>Close X</b></a></div></DIV>";

              //  Response.Write(CS_JS);

                 oTableCell.Text = oTableCell.Text + "  <a href=\"#\" id='" + Clickdivid + "' rel='" + divid + "'><u>Track</u></a> |   <A href=\"JavaScript:OpenPopupWindow_view('" + lbldockno.Text.ToString() + "','" + lbldocksf.Text.ToString() + "')\"><u>View</u></a> ";

                
                oTableCell.ColumnSpan = 3;
                oTableCell.CssClass = "bluefnt";
                oTableCell.Font.Bold = true;
                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell);
              
                oGridViewRow.BackColor = System.Drawing.Color.White;
                table.Controls.AddAt(realindex + 1, oGridViewRow);
            

        }
    }
    protected void PAging_SelectedIndexChanged(object sender, EventArgs e)
    {
        string final;
        final = "?MAxStr_VAL=" + Request.QueryString["MAxStr_VAL"].ToString();
        final += "&MAxSTR_LV=" + Request.QueryString["MAxSTR_LV"].ToString();
        final += "&MAxStr_VAL_to=" + Request.QueryString["MAxStr_VAL_to"].ToString();
        final += "&MAxSTR_LV_to=" + Request.QueryString["MAxSTR_LV_to"].ToString();
        //final += "&DTTYPE=" + DTTYPE;
        final += "&DateType=" + Request.QueryString["DateType"].ToString();
        final += "&fromdt=" + Request.QueryString["fromdt"].ToString();
        final += "&todt=" + Request.QueryString["todt"].ToString();
        final += "&st_Docnolist=" + Request.QueryString["st_Docnolist"].ToString();
        final += "&St_Manualnolist=" + Request.QueryString["St_Manualnolist"].ToString();
        final += "&st_Vehnolist=" + Request.QueryString["St_Manualnolist"].ToString();
        final += "&st_Freetext=" + Request.QueryString["st_Freetext"].ToString();
        final += "&st_doctyp=" + Request.QueryString["st_doctyp"].ToString();
        final += "&str_doctyp=" + Request.QueryString["str_doctyp"].ToString();
        final += "&Psize=" + Request.QueryString["Psize"].ToString();
        final += "&PGNO=" + PAging.SelectedValue.ToString();

        Response.Redirect("Result_RS.aspx" + final);
    }
}
