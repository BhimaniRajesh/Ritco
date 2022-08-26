using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.IO;
public partial class GUI_Tracking_ver1_Result : System.Web.UI.Page
{
    public static string THC_call, dkt_call, D_XLS = "N", DWN_XLS, CS_JS1="";
    public static int jk = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

        dkt_call = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();
    }
    public void BindGrid()
    {
        string RO = "", LO = "", RO_TO = "", LO_TO = "", DateType = "", fromdt = "", todt = "";
        string st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_doctyp = "";// DWN_XLS = "";
        int pagecnt = 0;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        RO = Request.QueryString.Get("RO");
        LO = Request.QueryString.Get("LO");
        RO_TO = Request.QueryString.Get("RO_TO");
        LO_TO = Request.QueryString.Get("LO_TO");
        DateType = Request.QueryString.Get("DateType");
        fromdt = Request.QueryString.Get("fromdt");
        todt = Request.QueryString.Get("todt");
        st_Docnolist = Request.QueryString.Get("st_Docnolist");
        St_Manualnolist = Request.QueryString.Get("St_Manualnolist");
        st_Vehnolist = Request.QueryString.Get("st_Vehnolist");
        st_Freetext = Request.QueryString.Get("st_Freetext");
        st_doctyp = Request.QueryString.Get("st_doctyp");
        DWN_XLS = Request.QueryString.Get("DWN_XLS");
        pagecnt =Convert.ToInt32( Request.QueryString.Get("pagecnt"));
        string str_doctyp = Request.QueryString.Get("str_doctyp");
        

        
       // Response.Write("<br>pagecnt : " + pagecnt);
        lblseldet.Text = fromdt + " - " + todt;
        lblro.Text = RO + " - " + RO_TO;
        lblloc.Text = LO + " - " + LO_TO;

        int pagesize = 20;

        
        int startno = ((pagecnt - 1) * pagesize) + 1;

        if (st_Docnolist == "" && St_Manualnolist == "" && st_Vehnolist == "" && st_Freetext == "")
        {
            pagesize = pagesize;
            startno = startno;
        }
        else
        {
            pagesize = 500;
            startno = 1;
        }
        if (DWN_XLS == "Y")
        {
            pagesize = 500;
            startno = 1;
            //Response.ContentType = "application/vnd.ms-excel";
            //Response.AddHeader("content-disposition", "attachment; filename=Tracking.xls");
        }
        if (D_XLS == "Y")
        {
            pagesize = 500;
            startno = 1;
            //Response.ContentType = "application/vnd.ms-excel";
            //Response.AddHeader("content-disposition", "attachment; filename=Tracking.xls");
        }

        if (RO == "" || RO == "All")
        {
            RO = "%%";
        }
        if (LO == "" || LO == "All")
        {
            LO = "%%";
        }
        if (RO_TO == "" || RO_TO == "All")
        {
            RO_TO = "%%";
        }
        if (LO_TO == "" || LO_TO == "All")
        {
            LO_TO = "%%";
        }


        lblflow.Text = str_doctyp;
        

        string sql_st = "exec webxNet_Tracking '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "','" + startno + "','" + pagesize + "'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataReader dr = sqlcmd12.ExecuteReader();
        //Response.Write("<br>sql_st : " + sql_st);
        TBL_TRACKING.Visible = true;
        TableRow TR = new TableRow();
        TableCell TRTC1 = new TableCell();
        TableCell TRTC2 = new TableCell();
        string DrillDown;

        if ((D_XLS != "Y" ) && (st_Docnolist == "" && St_Manualnolist == "" && st_Vehnolist == "" && st_Freetext == ""))
        {
            string pgelist = "";
            for (int pg = 1; pg < 6; pg++)
            {
                DrillDown = "RO=" + Request.QueryString.Get("RO") + "&RO_TO=" + Request.QueryString.Get("RO_TO") + "&LO=" + Request.QueryString.Get("LO") + "&LO_TO=" + Request.QueryString.Get("LO_TO") + "&DateType=" + DateType + "&fromdt=" + fromdt + "&todt=" + todt + "&st_Docnolist=" + st_Docnolist + "&St_Manualnolist=" + St_Manualnolist + "&st_Vehnolist=" + st_Vehnolist + "&st_Freetext=" + st_Freetext + "&st_doctyp=" + st_doctyp + "&pagecnt=" + pg + "&DWN_XLS=N";
                if (pgelist == "")
                    pgelist = "<a href='./result.aspx?" + DrillDown + "'><u>" + pg + "</u></a>";
                else
                    pgelist = pgelist + "      <a href='./result.aspx?" + DrillDown + "'><u>" + pg + "</u></a>";
            }


            TRTC1.Text = "Pages : - " + pgelist;
            TRTC1.ColumnSpan = 3;
            TRTC1.CssClass = "blackboldfnt";
            TRTC1.Wrap = false;
            TR.Cells.Add(TRTC1);


            DrillDown = "RO=" + Request.QueryString.Get("RO") + "&RO_TO=" + Request.QueryString.Get("RO_TO") + "&LO=" + Request.QueryString.Get("LO") + "&LO_TO=" + Request.QueryString.Get("LO_TO") + "&DateType=" + DateType + "&fromdt=" + fromdt + "&todt=" + todt + "&st_Docnolist=" + st_Docnolist + "&St_Manualnolist=" + St_Manualnolist + "&st_Vehnolist=" + st_Vehnolist + "&st_Freetext=" + st_Freetext + "&st_doctyp=" + st_doctyp + "&pagecnt=100&DWN_XLS=Y";

            TRTC2.Text = "";// "<a href='./result.aspx?" + DrillDown + "'><u>Download XLS</a>";
            TRTC2.ColumnSpan = 7;
            TRTC2.CssClass = "blackboldfnt";
            TRTC2.Wrap = false;
            TR.Cells.Add(TRTC2);

            TR.HorizontalAlign = HorizontalAlign.Left;
            TR.CssClass = "bgbluegrey";
            TBL_TRACKING.Rows.Add(TR);
        }

        TableRow TR1 = new TableRow();
        TableCell TR1TC1 = new TableCell();
        TableCell TR1TC2 = new TableCell();
        TableCell TR1TC3 = new TableCell();
        TableCell TR1TC4 = new TableCell();
        TableCell TR1TC5 = new TableCell();
        TableCell TR1TC6 = new TableCell();
        TableCell TR1TC7 = new TableCell();
        TableCell TR1TC8 = new TableCell();
        TableCell TR1TC9 = new TableCell();
        TableCell TR1TC10 = new TableCell();
        TableCell TR1TC11 = new TableCell();

        

        if (st_doctyp == "DKT")
        {

            TR1TC1.Text = "SR No.";
            TR1TC1.CssClass = "blackboldfnt";
            TR1TC1.Wrap = false;
            TR1.Cells.Add(TR1TC1);

            TR1TC2.Text = str_doctyp + "<br/> No.";
            TR1TC2.CssClass = "blackboldfnt";
            TR1TC2.Wrap = false;
            TR1.Cells.Add(TR1TC2);

            TR1TC3.Text = str_doctyp + "<br/> Date";
            TR1TC3.CssClass = "blackboldfnt";
            TR1TC3.Wrap = false;
            TR1.Cells.Add(TR1TC3);

            TR1TC4.Text = "EDD - ADD";
            TR1TC4.CssClass = "blackboldfnt";
            TR1TC4.Wrap = false;
            TR1.Cells.Add(TR1TC4);

            TR1TC5.Text = "Origin - Destination";
            TR1TC5.CssClass = "blackboldfnt";
            TR1TC5.Wrap = false;
            TR1.Cells.Add(TR1TC5);

            TR1TC10.Text = "Curr. Loc. - Next Loc.";
            TR1TC10.CssClass = "blackboldfnt";
            TR1TC10.Wrap = false;
            TR1.Cells.Add(TR1TC10);

            TR1TC6.Text = "From - To";
            TR1TC6.CssClass = "blackboldfnt";
            TR1TC6.Wrap = false;
            TR1.Cells.Add(TR1TC6);

            TR1TC7.Text = "Paybas | Mode | Type";
            TR1TC7.CssClass = "blackboldfnt";
            TR1TC7.Wrap = false;
            TR1.Cells.Add(TR1TC7);

            TR1TC8.Text = "Consignor";
            TR1TC8.CssClass = "blackboldfnt";
            TR1TC8.Wrap = false;
            TR1.Cells.Add(TR1TC8);

            TR1TC9.Text = "Consignee";
            TR1TC9.CssClass = "blackboldfnt";
            TR1TC9.Wrap = false;
            TR1.Cells.Add(TR1TC9);
        }

        if (st_doctyp == "THC")
        {

            TR1TC1.Text = "SR No.";
            TR1TC1.CssClass = "blackboldfnt";
            TR1TC1.Wrap = false;
            TR1.Cells.Add(TR1TC1);

            TR1TC2.Text = str_doctyp + " No.";
            TR1TC2.CssClass = "blackboldfnt";
           // TR1TC2.Wrap = false;
            TR1.Cells.Add(TR1TC2);

            TR1TC3.Text = str_doctyp + "<br/> Date";
            TR1TC3.CssClass = "blackboldfnt";
            TR1TC3.Wrap = false;
            TR1.Cells.Add(TR1TC3);



            TR1TC4.Text = "Manual  No.";
            TR1TC4.CssClass = "blackboldfnt";
           // TR1TC4.Wrap = false;
            TR1.Cells.Add(TR1TC4);

            TR1TC5.Text = "Location";
            TR1TC5.CssClass = "blackboldfnt";
            TR1TC5.Wrap = false;
            TR1.Cells.Add(TR1TC5);

            TR1TC10.Text = "Vehicle No.";
            TR1TC10.CssClass = "blackboldfnt";
            TR1TC10.Wrap = false;
            TR1.Cells.Add(TR1TC10);

            TR1TC6.Text = "Driver";
            TR1TC6.CssClass = "blackboldfnt";
            TR1TC6.Wrap = false;
            TR1.Cells.Add(TR1TC6);

            TR1TC7.Text = "Last Location";
            TR1TC7.CssClass = "blackboldfnt";
            TR1TC7.Wrap = false;
            TR1.Cells.Add(TR1TC7);

            TR1TC8.Text = "Departure Date & Time";
            TR1TC8.CssClass = "blackboldfnt";
            TR1TC8.Wrap = false;
            TR1.Cells.Add(TR1TC8);

            //TR1TC9.Text = "Consignee";
            //TR1TC9.CssClass = "blackboldfnt";
            //TR1TC9.Wrap = false;
            //TR1.Cells.Add(TR1TC9);
        }


        TR1.HorizontalAlign = HorizontalAlign.Center;
        TR1.CssClass = "bgbluegrey";
        TBL_TRACKING.Rows.Add(TR1);

        int i = startno;
        int j = 1;
        while (dr.Read())
        {
            TableRow TR2 = new TableRow();
            TableCell TR2TC1 = new TableCell();
            TableCell TR2TC2 = new TableCell();
            TableCell TR2TC3 = new TableCell();
            TableCell TR2TC4 = new TableCell();
            TableCell TR2TC5 = new TableCell();
            TableCell TR2TC6 = new TableCell();
            TableCell TR2TC7 = new TableCell();
            TableCell TR2TC8 = new TableCell();
            TableCell TR2TC9 = new TableCell();
            TableCell TR2TC10 = new TableCell();
            TableCell TR2TC11 = new TableCell();

            TR2TC1.Text = i.ToString();
            TR2TC1.CssClass = "blackfnt";
            TR2TC1.Wrap = false;
            TR2.Cells.Add(TR2TC1);


            if (st_doctyp == "DKT")
            {
                TR2TC2.Text = dr["doc_no"].ToString();
                TR2TC2.CssClass = "blackfnt";
                TR2TC2.Wrap = false;
                TR2.Cells.Add(TR2TC2);

                TR2TC3.Text = dr["doc_dt"].ToString();
                TR2TC3.CssClass = "blackfnt";
                TR2TC3.Wrap = false;
                TR2.Cells.Add(TR2TC3);

                TR2TC4.Text = dr["Deldt"].ToString();
                TR2TC4.CssClass = "blackfnt";
                TR2TC4.Wrap = false;
                TR2.Cells.Add(TR2TC4);

                TR2TC5.Text = dr["Origin_dest"].ToString();
                TR2TC5.CssClass = "blackfnt";
                TR2TC5.Wrap = false;
                TR2.Cells.Add(TR2TC5);

                TR2TC10.Text = dr["Curr_Next"].ToString();
                TR2TC10.CssClass = "blackfnt";
                TR2TC10.Wrap = false;
                TR2.Cells.Add(TR2TC10);

                TR2TC6.Text = dr["From_to"].ToString();
                TR2TC6.CssClass = "blackfnt";
                TR2TC6.Wrap = false;
                TR2.Cells.Add(TR2TC6);

                TR2TC7.Text = dr["Type"].ToString();
                TR2TC7.CssClass = "blackfnt";
                TR2TC7.Wrap = false;
                TR2.Cells.Add(TR2TC7);

                TR2TC8.Text = dr["cnor"].ToString();
                TR2TC8.CssClass = "blackfnt";
                TR2TC8.Wrap = false;
                TR2.Cells.Add(TR2TC8);

                TR2TC9.Text = dr["cnee"].ToString();
                TR2TC9.CssClass = "blackfnt";
                TR2TC9.Wrap = false;
                TR2.Cells.Add(TR2TC9);
            }
            else if (st_doctyp == "THC")
            {

                TR2TC2.Text = dr["doc_no"].ToString();
                TR2TC2.CssClass = "blackfnt";
                TR2TC2.Wrap = false;
                TR2.Cells.Add(TR2TC2);

                TR2TC3.Text = dr["doc_dt"].ToString();
                TR2TC3.CssClass = "blackfnt";
                TR2TC3.Wrap = false;
                TR2.Cells.Add(TR2TC3);

                TR2TC4.Text = dr["ManualDocNo"].ToString();
                TR2TC4.CssClass = "blackfnt";
                TR2TC4.Wrap = false;
                TR2.Cells.Add(TR2TC4);

                TR2TC5.Text = dr["Origin_dest"].ToString();
                TR2TC5.CssClass = "blackfnt";
                TR2TC5.Wrap = false;
                TR2.Cells.Add(TR2TC5);

                TR2TC10.Text = dr["doc_veh"].ToString();
                TR2TC10.CssClass = "blackfnt";
                TR2TC10.Wrap = false;
                TR2.Cells.Add(TR2TC10);

                TR2TC6.Text = dr["Cnor"].ToString();
                TR2TC6.CssClass = "blackfnt";
                TR2TC6.Wrap = false;
                TR2.Cells.Add(TR2TC6);

                TR2TC7.Text = dr["Curr_Next"].ToString();
                TR2TC7.CssClass = "blackfnt";
                TR2TC7.Wrap = false;
                TR2.Cells.Add(TR2TC7);

                TR2TC8.Text = dr["Deldt"].ToString();
                TR2TC8.CssClass = "blackfnt";
                TR2TC8.Wrap = false;
                TR2.Cells.Add(TR2TC8);
            }

            

            TR2.HorizontalAlign = HorizontalAlign.Center;
            TR2.BackColor = System.Drawing.Color.White;
            TBL_TRACKING.Rows.Add(TR2);

            TableRow TR3 = new TableRow();
            TableCell TR3TC1 = new TableCell();
            TableCell TR3TC2 = new TableCell();
            TableCell TR3TC3 = new TableCell();

            TR3TC1.Text = "Status : - " ;
            TR3TC1.ColumnSpan = 2;
            TR3TC1.CssClass = "blackboldfnt";
            TR3TC1.Wrap = false;
            TR3TC1.HorizontalAlign = HorizontalAlign.Right;
            TR3.Cells.Add(TR3TC1);

            TR3TC2.Text = dr["status"].ToString();
            TR3TC2.ColumnSpan =4;
            TR3TC2.CssClass = "bluefnt";
            TR3TC2.Wrap = false;
            TR3TC2.HorizontalAlign = HorizontalAlign.Left;
            TR3.Cells.Add(TR3TC2);

            if (st_doctyp == "DKT")
            {
                //OpenPopupWindow  "<a href='./result.aspx?" + DrillDown + "'><u>Download XLS</a>";
                //<A href=\"JavaScript:OpenPopupWindow('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\"><u>Track</u></a> |
                string divid = "subcontent" + j.ToString();
                string Clickdivid = "contentlink" + j.ToString();
                TR3TC3.Text = "<a href=\"JavaScript:OpenPopupWindow('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" id='" + Clickdivid + "' rel='" + divid + "'><u>Track</u></a> |   <A href=\"JavaScript:OpenPopupWindow_view('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\"><u>View</u></a> ";


                string CS_JS = " <DIV id='" + divid + "' style='position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 340px; height: 20px; padding: 4px;'>";
                CS_JS = CS_JS + "\n <div style='width: 49%; float: left'>";
                CS_JS = CS_JS + " <ul><li><a href=\"JavaScript:OpenPopupWindow_Summary('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Summary</u></font></a> &nbsp;&nbsp;</li>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_PODTrack('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>POD/PFM Track</u></font></a></li>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_movement('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Movement</u></font></a></li></ul></div>";
                CS_JS = CS_JS + "\n <div style='width: 49%; float: left'>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_FINLIFECYCLE('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Finance Life Cycle</u></font></a></li>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_OPNLIFECYCLE('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Operation Life Cycle</u></font></a>&nbsp;&nbsp;</li></div>";
                CS_JS = CS_JS + "\n <div align='right'><a href=\"JavaScript:dropdowncontent.hidediv('" + divid + "')\"><b>Close X</b></a></div></DIV>";

                TR3TC3.Text = TR3TC3.Text.ToString() + " " + CS_JS;
                // Response.Write(CS_JS);

            }
          ////  string CS_JS1 = "<script type='text/javascript'>";
          //  CS_JS1 = CS_JS1 + "\n dropdowncontent.init('" + Clickdivid + "', 'left-top', 300, 'click')";
          //  // CS_JS1 = CS_JS1 + "\n   </script>";
            //  Response.Write(CS_JS1);| <A href=\"JavaScript:OpenPopupWindow_THC_TRACK('" + dr["docno"].ToString() + "')\"><u>Track</u></a>
            if (st_doctyp == "THC")
            {
                string divid = "subcontent" + j.ToString();
                string Clickdivid = "contentlink" + j.ToString();
               
                TR3TC3.Text = "<a href=\"#\" id='" + Clickdivid + "' rel='" + divid + "'><u>Track</u></a>  | <A href=\"JavaScript:OpenWindowTHC('" + dr["docno"].ToString() + ".,0')\"><u>View</u></a> ";

                string CS_JS = " <DIV id='" + divid + "' style='position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 220px; height: 20px; padding: 4px;'>";
                CS_JS = CS_JS + "\n <div style='width: 85%; float: left'>";
                CS_JS = CS_JS + "<u><li><a href=\"JavaScript:OpenPopupWindow_Summary_THC('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Summary</u></font></a></li>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_movement_THC('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Movement</u></font></a></li>";
               // CS_JS = CS_JS + "\n <div style='width: 49%; float: left'>";
                CS_JS = CS_JS + " <li><a href=\"JavaScript:OpenPopupWindow_movement_THC('" + dr["docno"].ToString() + "','" + dr["docsf"].ToString() + "')\" ><font size='+4' class='blackboldfnt'><u>Operation Life Cycle</u></font></a></li></u></div>";
                CS_JS = CS_JS + "\n <div align='right'><a href=\"JavaScript:dropdowncontent.hidediv('" + divid + "')\"><b>Close X</b></a></div></DIV>";



                TR3TC3.Text = TR3TC3.Text.ToString() + " " + CS_JS;
                // Response.Write(CS_JS);
            }
            
            
            TR3TC3.ColumnSpan = 4;
            TR3TC3.CssClass = "blackboldfnt";
            TR3TC3.Wrap = false;
            TR3TC3.HorizontalAlign = HorizontalAlign.Left;
            TR3.Cells.Add(TR3TC3);

            
            TR3.BackColor = System.Drawing.Color.White;
            TBL_TRACKING.Rows.Add(TR3);
            i += 1;

            jk = j;
            j += 1;
        }

        dr.Close();

        conn.Close();
    }
    public void DWN_XLS11()
    {
        DWN_XLS = "Y";
        D_XLS = "Y";
        
        TBL_TRACKING.BorderWidth = 1;
        TBL_TRACKING.BorderColor = System.Drawing.Color.Gray;
        TBL_TRACKING.Font.Name = "verdana";
        TBL_TRACKING.Font.Size = 8;

        tbl_cri.Border = 1;
       

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Tracking.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tbl_cri);
       // frm.Controls.Add(TBL_TRACKING);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS11();
    }

}
