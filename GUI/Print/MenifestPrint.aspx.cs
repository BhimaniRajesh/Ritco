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
using System.IO;

public partial class GUI_Print_MenifestPrint : System.Web.UI.Page
{
    string mfno, strqry;
    SqlConnection cn;
    decimal d;
    public int totrecord;
    public static string  call_dkt,dockno;
    public static string  MF_detail="";
    protected void Page_Load(object sender, EventArgs e)
    {
        d = 0.0M;
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        call_dkt = Session["DocketCalledAs"].ToString();
        mfno = Request.QueryString["tcno"];
        strqry = "Select Distinct convert(varchar,TCDT,6) as MF_Date,TCBR,route_code as Route,THCBR,THCNO,VEHNO,convert(varchar,thcdt,6) as THC_Date,tobh_code as TOHUB_BR,TCBR,TCBR + '-' + ToBH_Code as  fromto,(select rutnm from webx_rutmas with(NOLOCK) where rutcd=t.route_code) as rutnm ,e.EntryBy,e.Name,tcdt as mf_dt,(select LocCode+' : '+LocName from webx_location where loccode=t.tcbr)as Location From VW_tchdr_new t with(NOLOCK)  left outer join webx_master_users e with(NOLOCK)  on t.Entryby=e.UserId Where TCNo='" + mfno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, cn);
        cmd.Connection.Open();
        dr = cmd.ExecuteReader();
        dr.Read();
        lblMFNo.Text = mfno;
        lblMFDate.Text = Convert.ToString(dr[0]);
        lblPageNo.Text = "1";
        lblPrintDate.Text = DateTime.Today.ToString("dd MMM yyyy");
        
        if ((dr[10] == System.DBNull.Value) || (Convert.ToString(dr[10]) == ""))
        {
            LblRoute.Text = Convert.ToString(dr[2]) + ":" + Convert.ToString(dr[9]);
        }
        else
        {
            LblRoute.Text = Convert.ToString(dr[2]) + ":" + Convert.ToString(dr[10]);
        }

        LblTHCNo.Text = Convert.ToString(dr[4]);
        LblFromTo.Text = Convert.ToString(dr[9]);
        LblVehicle.Text = Convert.ToString(dr[5]);
        dr.Close();
        cmd.Connection.Close();
        cn.Open();
        //strqry = "select  Manual_tcno from webx_tchdr where tcno='" + LblTHCNo.Text + "'";
        //cmd = new SqlCommand(strqry, cn);
       // strqry = "Select distinct (select codedesc from webx_master_general where codetype='Trn' and codeid=(select trn_mod from webx_master_docket where dockno=m.DockNo))+' - '+ (select codedesc from webx_master_general where codetype='SERVTY' and codeid=(select service_class from webx_master_docket where dockno=m.DockNo))as Mode,(select from_loc+' - '+to_loc from webx_master_docket where dockno=m.dockno)LocationTo,m.TCNO,m.dockno,m.Payment_Basis,m.BookingDate,m.ORGNCD+ ' - ' +m.DESTCD as Location,m.C_DelyDate,m.Cnor_Name,m.Pkgs_LB,convert(varchar,m.ActualWt_LB)+' - '+convert(varchar,(select freight from WebX_Master_Docket_Charges where dockno=m.dockno)) as Freight,m.cnee_name,(select freight from WebX_Master_Docket_Charges where dockno=m.dockno) as Freight1 From vw_MF_View_Print m,VW_tchdr_new t where m.TCNo=t.TCNo and m.tcno='" + mfno + "'";

        //SqlDataAdapter da = new SqlDataAdapter(strqry, cn);
        //DataSet ds = new DataSet();
        //da.Fill(ds, "manifest");
        
       // GrdPaidFollow.DataSource = ds.Tables["manifest"];
        //GrdPaidFollow.DataBind();
        //strqry = "Select * From vw_MF_View_Print_DOs_print with(NOLOCK) Where TCNo='" + mfno + "'  ";
        //cmd = new SqlCommand(strqry, cn);
        //dr = cmd.ExecuteReader();
        //dr.Read();
        //GrdPaidFollow.FooterRow.Cells[1].Text =Convert.ToString(ds.Tables["manifest"].Rows.Count);
        //GrdPaidFollow.FooterRow.CssClass = "blackfnt";
        //GrdPaidFollow.FooterRow.HorizontalAlign = HorizontalAlign.Center;
        //dr.Close(); 

        

        tblMFDKT.Visible = true;

        TableRow tr1 = new TableRow();

        TableCell tctr1 = new TableCell();
        TableCell tctr2 = new TableCell();
        TableCell tctr3 = new TableCell();

        TableCell tctr4 = new TableCell();
        TableCell tctr5 = new TableCell();
        TableCell tctr6 = new TableCell();


        tctr1.Text = "SR No.";
        tctr1.CssClass = "blackfnt";
        tctr1.Wrap = false;
        tctr1.RowSpan = 2;
        tctr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr1);


        tctr2.Text = call_dkt + "<br>"+""+ " Number";
        tctr2.CssClass = "blackfnt";
        tctr2.Wrap = false;
        tctr2.RowSpan = 2;
        tctr2.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr2);

        tctr3.Text = "No.of Pkgs";
        tctr3.CssClass = "blackfnt";
        tctr3.Wrap = false;
        //tctr3.RowSpan = 2;
        tctr3.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr3);

         tctr4.Text = "From";
        tctr4.CssClass = "blackfnt";
        tctr4.Wrap = false;
        //tctr3.RowSpan = 2;
        tctr4.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr4);

            tctr5.Text = "To";
        tctr5.CssClass = "blackfnt";
        tctr5.Wrap = false;
        //tctr3.RowSpan = 2;
        tctr5.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr5);

        tctr6.Text = "Actual " + " <br> " + "Weight";
        tctr6.CssClass = "blackfnt";
        tctr6.Wrap = false;
        tctr6.RowSpan = 2;
        tctr6.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr6);

        tblMFDKT.Rows.Add(tr1);

        TableRow tr2 = new TableRow();

        TableCell tctr21 = new TableCell();
        TableCell tctr22 = new TableCell();
        TableCell tctr23 = new TableCell();

        TableCell tctr24 = new TableCell();
        TableCell tctr25 = new TableCell();
        TableCell tctr26 = new TableCell();

        tctr21.Text = "Pkg Type";
        tctr21.CssClass = "blackfnt";
        tctr21.Wrap = false;
       // tctr21.RowSpan = 2;
        tctr21.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr21);


        tctr22.Text = "Said to Contain";
        tctr22.CssClass = "blackfnt";
        tctr22.Wrap = false;
        tctr22.ColumnSpan = 2;
        tctr22.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr22);

       
        tblMFDKT.Rows.Add(tr2);


       string  sql_DKTlist = "Select * From vw_MF_View_Print_DOs_print with(NOLOCK) Where TCNo='" + mfno + "'  ";

       SqlCommand cmddktlist = new SqlCommand(sql_DKTlist, cn);
       SqlDataReader drdktlist = cmddktlist.ExecuteReader();

       int ik = 1;


       double tot_pkg=0, tot_actuwt=0;

       MF_detail = "\\n";
       MF_detail = MF_detail + string.Empty.PadLeft(27) + "RELOGISTICS INDIA PVT LTD" + "\\n";
       MF_detail = MF_detail + string.Empty.PadLeft(35) + "MANIFEST" + "\\n";
       MF_detail = MF_detail + "Dep.date and time :" + string.Empty.PadLeft(30-Convert.ToInt32(lblMFDate.Text.Length)) + "Page No. : 1" + "\\n";
       MF_detail = MF_detail + "VHC No:" + LblTHCNo.Text + string.Empty.PadLeft(33 - Convert.ToInt32(LblTHCNo.Text.Length)) + "Vehicle No.:" + LblVehicle.Text + "\\n";
       MF_detail = MF_detail + "Manifest No.:" + lblMFNo.Text + string.Empty.PadLeft(27 - Convert.ToInt32(lblMFNo.Text.Length)) + "From- TO :" + LblFromTo.Text + "\\n";
       MF_detail = MF_detail + "Route Path :" + LblRoute.Text + string.Empty.PadLeft(28 - Convert.ToInt32(LblRoute.Text.Length)) + "Print Date & Time :" + "\\n";
       MF_detail = MF_detail + "Seal No  :" + lblSealNo.Text + "\\n";
       MF_detail = MF_detail + "-------------------------------------------------------------------------------" + "\\n";
       MF_detail = MF_detail + "|" + string.Empty.PadLeft(8) + "|" + string.Empty.PadLeft(12) + "| No.of Pkgs  " + "|    From    " + "|     To     " + "|         " + "\\n";
       MF_detail = MF_detail + "| SR No. |" + " Cnote/HWB  |---------------------------------------" + "| Actual  " + "\\n";
       MF_detail = MF_detail + "|" + string.Empty.PadLeft(8) + "|" + string.Empty.PadLeft(3) + "Number" + string.Empty.PadLeft(3) + "|  Pkg Type   " + "|    Said to Contain   " + "   | Weight  " + "\\n";
       MF_detail = MF_detail + "--------------------------------------------------------------------------------" + "\\n";
       int cnt = 1;

       while (drdktlist.Read())
       {

           TableRow tr3 = new TableRow();

           TableCell tctr31 = new TableCell();
           TableCell tctr32 = new TableCell();
           TableCell tctr33 = new TableCell();

           TableCell tctr34 = new TableCell();
           TableCell tctr35 = new TableCell();
           TableCell tctr36 = new TableCell();


           tctr31.Text = ik.ToString();
           tctr31.CssClass = "blackfnt";
           tctr31.Wrap = false;
           tctr31.RowSpan = 2;
           tctr31.HorizontalAlign = HorizontalAlign.Center;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr31);


           tctr32.Text = drdktlist["dockno"].ToString() + "" + drdktlist["docksf"].ToString();
           tctr32.CssClass = "blackfnt";
           tctr32.Wrap = false;
           tctr32.RowSpan = 2;
           tctr32.HorizontalAlign = HorizontalAlign.Center;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr32);

           tctr33.Text = drdktlist["pkgsno"].ToString();
           tctr33.CssClass = "blackfnt";
           tctr33.Wrap = false;
           tctr33.HorizontalAlign = HorizontalAlign.Right;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr33);

           tctr34.Text = drdktlist["orgncd"].ToString();
           tctr34.CssClass = "blackfnt";
           tctr34.Wrap = false;
           tctr34.HorizontalAlign = HorizontalAlign.Center;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr34);

           tctr35.Text = drdktlist["reassign_destcd"].ToString();
           tctr35.CssClass = "blackfnt";
           tctr35.Wrap = false;
           tctr35.HorizontalAlign = HorizontalAlign.Center;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr35);

           tctr36.Text = drdktlist["actuwt"].ToString();
           tctr36.CssClass = "blackfnt";
           tctr36.Wrap = false;
           tctr36.RowSpan = 2;
           tctr36.HorizontalAlign = HorizontalAlign.Right;
           tr3.CssClass = "bgbluegrey";
           tr3.Cells.Add(tctr36);
           tr3.BackColor = System.Drawing.Color.White;
           tblMFDKT.Rows.Add(tr3);

           TableRow tr4 = new TableRow();

           TableCell tctr41 = new TableCell();
           TableCell tctr42 = new TableCell();
           TableCell tctr43 = new TableCell();

           TableCell tctr44 = new TableCell();
           TableCell tctr45 = new TableCell();
           TableCell tctr46 = new TableCell();

           tctr41.Text = drdktlist["pkgsty"].ToString();
           tctr41.CssClass = "blackfnt";
           tctr41.Wrap = false;
           tctr41.HorizontalAlign = HorizontalAlign.Left;
           tr4.CssClass = "bgbluegrey";
           tr4.Cells.Add(tctr41);


           tctr42.Text = drdktlist["Prodcd"].ToString();
           tctr42.CssClass = "blackfnt";
           tctr42.Wrap = false;
           tctr42.ColumnSpan = 2;
           tctr42.HorizontalAlign = HorizontalAlign.Center;
           tr4.CssClass = "bgbluegrey";
           tr4.Cells.Add(tctr42);

           tr4.BackColor = System.Drawing.Color.White;
           tblMFDKT.Rows.Add(tr4);

           tot_pkg = tot_pkg + Convert.ToDouble(drdktlist["pkgsno"]);
           tot_actuwt = tot_actuwt + Convert.ToDouble(drdktlist["actuwt"]);
           ik = ik + 1;

           string pkgsty = drdktlist["pkgsty"].ToString();
           if (Convert.ToInt32(pkgsty.Length) > 10)
           {
               pkgsty = pkgsty.Substring(0, 10);
           }
           string Prodcd = drdktlist["Prodcd"].ToString();
           if (Convert.ToInt32(Prodcd.Length) > 18)
           {
               Prodcd = Prodcd.Substring(0, 18);
           }
           dockno = drdktlist["dockno"].ToString();
           if (Convert.ToInt32(dockno.Length) > 10)
           {
               dockno = dockno.Substring(0, 10);
           }

           MF_detail = MF_detail + "|" + string.Empty.PadLeft(8) + "|" + string.Empty.PadLeft(12) + "|" + string.Empty.PadLeft(5) + drdktlist["pkgsno"].ToString() + string.Empty.PadLeft(8 - Convert.ToInt32(drdktlist["pkgsno"].ToString().Length)) + "|" + drdktlist["orgncd"].ToString() + string.Empty.PadLeft(12 - Convert.ToInt32(drdktlist["orgncd"].ToString().Length)) + "|" + drdktlist["reassign_destcd"].ToString() + string.Empty.PadLeft(12 - Convert.ToInt32(drdktlist["reassign_destcd"].ToString().Length)) + "| " + "\\n";
           MF_detail = MF_detail + "|" + string.Empty.PadLeft(4) + cnt + string.Empty.PadLeft(3) + "|" + string.Empty.PadLeft(2)  + drdktlist["dockno"].ToString() + string.Empty.PadLeft(10 - Convert.ToInt32(drdktlist["dockno"].ToString().Length)) + "|---------------------------------------" + "|" + drdktlist["actuwt"].ToString() + "\\n";
           MF_detail = MF_detail + "|" + string.Empty.PadLeft(8) + "|" + string.Empty.PadLeft(12) + "|" + string.Empty.PadLeft(1) + pkgsty + string.Empty.PadLeft(12 - Convert.ToInt32(pkgsty.Length)) + "|" + Prodcd + string.Empty.PadLeft(25 - Convert.ToInt32(Prodcd.Length)) + "|" + "\\n";
           MF_detail = MF_detail + "--------------------------------------------------------------------------------" + "\\n";
           cnt = cnt + 1;	
        
       }
       int count = Convert.ToInt32(cnt);
       MF_detail = MF_detail + "|" + string.Empty.PadLeft(2) + "Total" + string.Empty.PadLeft(1) + "|" + string.Empty.PadLeft(2) + (count - 1) + string.Empty.PadLeft(17 - Convert.ToInt32(dockno.Length)) + "|" + string.Empty.PadLeft(4) + tot_pkg + string.Empty.PadLeft(8-Convert.ToInt32(tot_pkg.ToString().Length)) + "|" + string.Empty.PadLeft(25) + "|" + tot_actuwt + string.Empty.PadLeft(10 - Convert.ToInt32(tot_actuwt.ToString().Length)) + "\\n";
       //MF_detail = MF_detail + "--------------------------------------------------------------------------------" + "\\n";
       MF_detail = MF_detail + "Staff Code:" + string.Empty.PadLeft(40) + "Signature:" + "\\n";
       MF_detail = MF_detail + "Staff Name:" + "\\n";
       MF_detail = MF_detail + "\\n";
       MF_detail = MF_detail + "Remarks :" + "\\n";
       //MF_detail = MF_detail + "--------------------------------------------------------------------------------" + "\\n";
       

       TableRow tr5 = new TableRow();

       TableCell tctr51 = new TableCell();
       TableCell tctr52 = new TableCell();
       TableCell tctr53 = new TableCell();

       TableCell tctr54 = new TableCell();
       TableCell tctr55 = new TableCell();
       TableCell tctr56 = new TableCell();


       tctr51.Text = "Total";
       tctr51.CssClass = "blackfnt";
       tctr51.Wrap = false;
       tctr51.RowSpan = 2;
       tctr51.HorizontalAlign = HorizontalAlign.Center;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr51);


       tctr52.Text = (ik-1).ToString();
       tctr52.CssClass = "blackfnt";
       tctr52.Wrap = false;
       tctr52.RowSpan = 2;
       tctr52.HorizontalAlign = HorizontalAlign.Right;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr52);

       tctr53.Text = tot_pkg.ToString();
       tctr53.CssClass = "blackfnt";
       tctr53.Wrap = false;
       //tctr5.RowSpan = 2;
       tctr53.HorizontalAlign = HorizontalAlign.Right;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr53);
       tr5.BackColor = System.Drawing.Color.White;
      

       tctr54.Text = "";
       tctr54.CssClass = "blackfnt";
       tctr54.Wrap = false;
       //tctr5.RowSpan = 2;
       tctr54.HorizontalAlign = HorizontalAlign.Center;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr54);

       tctr55.Text = "";
       tctr55.CssClass = "blackfnt";
       tctr55.Wrap = false;
       //tctr5.RowSpan = 2;
       tctr55.HorizontalAlign = HorizontalAlign.Center;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr55);

       tctr56.Text = tot_actuwt.ToString();
       tctr56.CssClass = "blackfnt";
       tctr56.Wrap = false;
       tctr56.RowSpan = 2;
       tctr56.HorizontalAlign = HorizontalAlign.Right;
       tr5.CssClass = "bgbluegrey";
       tr5.Cells.Add(tctr56);
       tr5.BackColor = System.Drawing.Color.White;
       tblMFDKT.Rows.Add(tr5);

	//string scr = @" <object id='objPrint'   classid='CLSID:91DF5E28-29FB-4D68-A027-60F581A55443'     codebase='http://www.prlwebxpress.com/prltest/print_utility/webx_dos_print.cab#version=1,0,0,0'></object> ";
// Page.RegisterClientScriptBlock("update", scr);


	  

	  MF_detail= "objPrint.Print_Line('" + MF_detail  + "');" ;
	
drdktlist.Close();

	

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        String strDestinationFile;
        strDestinationFile = "C:\\" + mfno + ".txt";
        TextWriter tw = new StreamWriter(strDestinationFile);

        ////writing the header
        //for (int x = 0; x < tblMFDKT.Columns.Count; x++)
        //{
        //    tw.Write(tblMFDKT.Columns[x].HeaderText);
        //    if (x != tblMFDKT.Columns.Count - 1)
        //    {
        //        tw.Write(", ");
        //    }

        //}
        //tw.WriteLine();




        for (int i = 0; i < tblMFDKT.Rows.Count; i++)
        {
            for (int j = 0; j < tblMFDKT.Rows[i].Cells.Count; j++)
            {

                tw.Write(tblMFDKT.Rows[i].Cells[j].Text);
                tw.Write("\t");
            }

            tw.Write("\n");
        }



        ////    //writing the data
        ////    for (int x = 0; x < tblMFDKT.Rows.Count - 1; x++)
        ////    {
        ////        for (int y = 0; y < tblMFDKT.Columns.Count; y++)
        ////        {
        ////            tw.Write(tblMFDKT.Rows[x].Cells.Value);
        ////            if (y != tblMFDKT.Columns.Count - 1)
        ////            {
        ////                tw.Write(", ");
        ////            }
        ////        }
        ////        tw.WriteLine();
        ////    }
        tw.Close();


        ///////////////////////////////// CSV

        //int ind = 0;
        //int a = 0;
        //try
        //{
        //    // GV_Booking.AllowPaging = false;

        //    Response.Clear();
        //    Response.AddHeader("Content-Disposition", "attachment;Filename=" + strDestinationFile + "");
        //    Response.Charset = "";
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    Response.ContentType = "application/vnd.text";
        //    System.IO.StringWriter tw = new System.IO.StringWriter();
        //    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);



            /////////////////////////////////////////////////////////

            //TextWriter tw = new StreamWriter(strDestinationFile);
            //for (int i = 0; i < tblMFDKT.Rows.Count; i++)
            //{
            //    for (int j = 0; j < tblMFDKT.Rows[i].Cells.Count; j++)
            //    {

            //        tw.Write(tblMFDKT.Rows[i].Cells[j].Text);
            //        tw.Write("\t");
            //    }

            //    tw.Write("\n");
            //}
            //tw.Close();

            
            /////////////////////////////////////////////////////////////



            //tblMFDKT.RenderControl(hw);


            //Response.Write(tw.ToString());
            //Response.End();
        //}
        //catch (Exception ex1)
        //{
        //    throw ex1;
        //    // lblloc.Text = ex1.Message;
        //}



        //////////////////////////////////
    }
}
