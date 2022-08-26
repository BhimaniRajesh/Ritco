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

public partial class GUI_Operations_TCS_PrintTCS_View_Print_UnloadingSheet : System.Web.UI.Page
{
    public static string strLoadingSheetNo;
    public static string strLoadingSheetDate;
    public static string strLoadingSheetDateAsItIs;
    public static string strLoadingRouteCode;
    public static string strLoadingBranch;
    public static string strLoadingBranchCode;
    public static string strLoadingVehicle;
    public static string strLoadingSheetTCDate;
    public static string strLoadingSheetPrepBy;
    public static string strLoadingSheetTCDateInTimeFormat;
 
    public string route, unloadingloc, preat, VehicalNo, THCDt, Desti, TCNO, stDest, endDest, Total_Pack;
    public string strSQL, ETA;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strLoadingSheetNo = HttpUtility.UrlDecode(Request.QueryString["THC_No"].ToString());
            //strLoadingSheetNo = "BLR_/THC/0000007";
        }
        THCGenerate();        

        btnPrint.Attributes.Add("onclick", "Javascript:OpenInWindow('PrintLoadingSheet.aspx','400','700','0','0')");
    }
    
    private void THCGenerate()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
        
        sqlConn.Open();
        strSQL = "select convert(varchar,thcdt,6) as THCDT,convert(varchar,actdept_dt,6) as ETA, * from webx_thc_summary where thcno = '" + strLoadingSheetNo + "'";
        SqlCommand cmd = new SqlCommand(strSQL, sqlConn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            route = Convert.ToString(dr["routecd"]) + " : " + Convert.ToString(dr["routename"]);
            VehicalNo = Convert.ToString(dr["vehno"]);
            THCDt = Convert.ToString(dr["THCDT"]);
            Desti = Convert.ToString(dr["tobh_code"]);
            ETA = Convert.ToString(dr["ETA"]);
        }
        dr.Close();

        strSQL = "Select E.branchcode as bcode , B.LocName as bname from WEBX_master_users E, WEBX_Location B where E.userid = '" +Session["empcd"].ToString() + "' and E.branchcode = B.LocCode";
        strSQL = "Select thcbr as bcode,bname=(select top 1 locname from webx_location where loccode=thcbr)  from  webx_thc_summary with(NOLOCK) where thcno = '" + strLoadingSheetNo + "'"; 
        cmd = new SqlCommand(strSQL, sqlConn);
        SqlDataReader drd = cmd.ExecuteReader();
        while (drd.Read())
        {
            unloadingloc = Convert.ToString(drd["bcode"]) + " : " + Convert.ToString(drd["bname"]);
            //preat = Convert.ToString(drd["bcode"]) + " : " + Convert.ToString(drd["bname"]);
            preat = Convert.ToString(drd["bcode"]);
        }
        drd.Close();

        strSQL = "Select distinct h.tcno,h.tcbr, h.ToBH_CODE,b.LocName as brnm from WEBX_Location b,WEBX_tchdr h where   h.ToBH_CODE ='" + Desti + "' and (h.ToBH_CODE is not null or h.ToBH_CODE<>'') and h.thcno ='" + strLoadingSheetNo + "' and h.ToBH_CODE=b.LocCode order by  h.ToBH_CODE";
        //Response.Write("<br> strSQL : " + strSQL);
        
        cmd = new SqlCommand(strSQL, sqlConn);
        SqlDataReader drdr = cmd.ExecuteReader();

        string st_mfno = "";
        while (drdr.Read())
        {
            TCNO = Convert.ToString(drdr["tcno"]);
            stDest = Convert.ToString(drdr["tcbr"]);
            endDest = Convert.ToString(drdr["ToBH_CODE"]);


            if (st_mfno == "")
            {
                st_mfno = Convert.ToString(drdr["tcno"]);
            }
            else
            {
                st_mfno = st_mfno + "~" + Convert.ToString(drdr["tcno"]);
            }
        }
        drdr.Close();

        int it = 0;
       
        string[] st_mfno_arr = st_mfno.Split('~');
        string st_TCNO = "";
        for (int ik = 0; ik < st_mfno_arr.Length; ik++)
        {
            st_TCNO = st_mfno_arr[ik];

            string SQL_tcno = "Select (select codedesc from webx_master_general where codetype='Trn' and codeid=(select trn_mod from webx_master_docket where dockno=d.DockNo))+' - '+ (select codedesc from webx_master_general where codetype='SVCTYP' and codeid=(select service_class from webx_master_docket where dockno=d.DockNo)) as Mode,d.from_loc+' - '+d.to_loc as Location,d.csgncd+'-'+d.csgnnm as csgnnm,convert(varchar,d.DOCKDT,6) as DOCKDT,convert(varchar,d.CDELDT,6) as CDELDT,d.ORGNCD,d.reassign_destcd as destcd,CSGENM=c.CSGEcd+' : '+((case when  c.CSGECD='8888' then c.CSGENM else (select custnm from webx_custhdr with(NOLOCK) where custcd=c.CSGECD ) end )),d.paybas,d.pkgsno as nopkgs,d.ACTUWT,t.* from WEBX_TCTRN t with(NOLOCK) ,WEBX_TCHDR h with(NOLOCK),webx_Master_docket d with(NOLOCK),vw_master_docket_charges_cnor_cnee c with(NOLOCK) where d.dockno=c.dockno and t.dockno=d.dockno and  h.TCNO=t.TCNO and (h.ToBH_CODE is not null or h.ToBH_CODE<>'') and h.thcno ='" + strLoadingSheetNo + "' and h.ToBH_CODE='" + Desti + "' and t.TCNO ='" + st_TCNO + "' order by  h.ToBH_CODE,Substring(t.DOCKNO,3,7)";
            //strSQL = "Select rtrim(left(convert(varchar,d.DOCKDT,106),6))+' '+right(convert(varchar,d.DOCKDT,106),2) as DOCKDT,rtrim(left(convert(varchar,d.CDELDT,106),6))+ ' '+left(convert(varchar,d.CDELDT,106),2) as CDELDT,d.ORGNCD,d.reassign_destcd as destcd,CSGENM=c.CSGNcd+' : '+((case when  CSGNCD='8888' then CSGNNM else (select custnm from webx_custhdr with(NOLOCK) where custcd=csgncd ) end )),d.paybas,d.pkgsno as nopkgs,d.ACTUWT,t.* from WEBX_TCTRN t with(NOLOCK) ,WEBX_TCHDR h with(NOLOCK),webx_docket d with(NOLOCK),webx_docket_cnor_cnee c with(NOLOCK) where d.dockno=c.dockno and t.dockno=d.dockno and  h.TCNO=t.TCNO and (h.ToBH_CODE is not null or h.ToBH_CODE<>'') and h.thcno ='" + strLoadingSheetNo + "' and h.ToBH_CODE='" + Desti + "' and t.TCNO ='" + TCNO + "' order by  h.ToBH_CODE,Substring(t.DOCKNO,3,7)";
           SqlCommand cmdtcno = new SqlCommand(SQL_tcno, sqlConn);
           SqlDataReader drtcno = cmdtcno.ExecuteReader();
         //  Response.Write("<br> SQL_tcno : " + SQL_tcno);

           TableRow tr1 = new TableRow();

           TableCell tc1tr1 = new TableCell();
           tc1tr1.Text = "MF No " + st_TCNO;
           tc1tr1.CssClass = "blackboldfnt";
           tc1tr1.Wrap = false;
           tc1tr1.ColumnSpan = 10;
           tc1tr1.HorizontalAlign = HorizontalAlign.Center;
           tr1.CssClass = "bgbluegrey";
           tr1.Cells.Add(tc1tr1);

           tblunloadsheet.Rows.Add(tr1);


           TableRow tr2 = new TableRow();
           TableCell tctr1 = new TableCell();
           TableCell tctr2 = new TableCell();
           TableCell tctr3 = new TableCell();
           TableCell tctr4 = new TableCell();
           TableCell tctr5 = new TableCell();
           TableCell tctr6 = new TableCell();
           TableCell tctr7 = new TableCell();
           TableCell tctr8 = new TableCell();
           TableCell tctr9 = new TableCell();
           TableCell tctr10 = new TableCell();

           tctr1.Text = "Sr.no.";
           tctr1.CssClass = "blackboldfnt";
           tctr1.Wrap = false;          
           tctr1.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr1);


           tctr2.Text = "Docket No./Pay basis  ";
           tctr2.CssClass = "blackfnt";
          // tctr2.Wrap = false;
           tctr2.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr2);

           tctr3.Text = "Mode/Service Type";
           tctr3.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr3.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr3);

           tctr4.Text = "Booking - Delivery Date ";
           tctr4.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr2.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr4);

           tctr5.Text = "Booking - Delivery Location ";
           tctr5.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr5.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr5);

           tctr6.Text = "From - To ";
           tctr6.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr6.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr6);

           tctr7.Text = "Consignor ";
           tctr7.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr2.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr7);

           tctr8.Text = "Consignee  ";
           tctr8.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr9.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr8);

           tctr9.Text = "Packages Weight L/B ";
           tctr9.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr9.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr9);

           tctr10.Text = "Weight L/B Kg  ";
           tctr10.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr10.HorizontalAlign = HorizontalAlign.Center;
           tr2.CssClass = "bgbluegrey";
           tr2.Cells.Add(tctr10);

           tr2.BackColor = System.Drawing.Color.White;
           tblunloadsheet.Rows.Add(tr2);

           
           it = 1;
           double PakgL = 0, PakgB = 0, WeightL = 0, WeightB = 0;
           while (drtcno.Read())
           {

               TableRow tr3 = new TableRow();
               TableCell tctr31 = new TableCell();
               TableCell tctr32 = new TableCell();
               TableCell tctr33 = new TableCell();
               TableCell tctr34 = new TableCell();
               TableCell tctr35 = new TableCell();
               TableCell tctr36 = new TableCell();
               TableCell tctr37 = new TableCell();
               TableCell tctr38 = new TableCell();
               TableCell tctr39 = new TableCell();
               TableCell tctr310 = new TableCell();


               string st_docko = drtcno["dockno"].ToString();
               string st_Mode = drtcno["Mode"].ToString();
               string st_DOCKDT = drtcno["DOCKDT"].ToString() + " - " + drtcno["CDELDT"].ToString();
               string st_orgncd = drtcno["orgncd"].ToString() + " - " + drtcno["destcd"].ToString();
               string st_Location = drtcno["Location"].ToString();
               string st_csgnnm = drtcno["csgnnm"].ToString();
               string st_CSGeNM = drtcno["CSGeNM"].ToString();
               //dr["NextStop"] = drRows["NextStop"].ToString() + " : " + getBranchName(drRows["NextStop"].ToString());
               string st_destcd = drtcno["destcd"].ToString();
               string st_CDELDT = drtcno["CDELDT"].ToString();
               string st_Loadpkgsno = drtcno["Loadpkgsno"].ToString() + "/" + drtcno["nopkgs"].ToString();
               string st_Loadactuwt = drtcno["Loadactuwt"].ToString() + "/" + drtcno["loadcftwt"].ToString();

               PakgL += Convert.ToDouble(drtcno["Loadpkgsno"].ToString());
               PakgB += Convert.ToDouble(drtcno["nopkgs"].ToString());
               WeightL += Convert.ToDouble(drtcno["Loadactuwt"].ToString());
               WeightB += Convert.ToDouble(drtcno["loadcftwt"].ToString());



               tctr31.Text =Convert.ToString( it);
               tctr31.CssClass = "blackboldfnt";
               tctr31.Wrap = false;
               tctr31.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr31);


               tctr32.Text =st_docko;
               tctr32.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr32.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr32);

               tctr33.Text = st_Mode;
               tctr33.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr33.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr33);

               tctr34.Text = st_DOCKDT;
               tctr34.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr34.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr34);

               tctr35.Text = st_orgncd;
               tctr35.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr35.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr35);

               tctr36.Text = st_Location;
               tctr36.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr36.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr36);

               tctr37.Text = st_csgnnm;
               tctr37.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr37.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr37);

               tctr38.Text = st_CSGeNM;
               tctr38.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr38.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr38);

               tctr39.Text = st_Loadpkgsno;
               tctr39.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr39.HorizontalAlign = HorizontalAlign.Center;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr39);

               tctr310.Text = st_Loadactuwt;
               tctr310.CssClass = "blackfnt";
               // tctr2.Wrap = false;
               tctr310.HorizontalAlign = HorizontalAlign.Right;
               tr3.CssClass = "bgbluegrey";
               tr3.Cells.Add(tctr310);

               tr3.BackColor = System.Drawing.Color.White;
               tblunloadsheet.Rows.Add(tr3);

               it = it + 1;
           }
                 


           drtcno.Close();


           TableRow tr4 = new TableRow();
           TableCell tctr41 = new TableCell();
           TableCell tctr42 = new TableCell();
           TableCell tctr43 = new TableCell();

           tctr41.Text = "Total :" ;
           tctr41.CssClass = "blackboldfnt";
           tctr41.Wrap = false;
           tctr41.ColumnSpan = 8;
           tctr41.HorizontalAlign = HorizontalAlign.Right;
           tr4.CssClass = "bgbluegrey";
           tr4.Cells.Add(tctr41);


           tctr42.Text = PakgL.ToString() + "/" + PakgB.ToString();
           tctr42.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr42.HorizontalAlign = HorizontalAlign.Right;
           tr4.CssClass = "bgbluegrey";
           tr4.Cells.Add(tctr42);

           tctr43.Text = WeightL.ToString() + "/" + WeightB.ToString();
           tctr43.CssClass = "blackfnt";
           // tctr2.Wrap = false;
           tctr43.HorizontalAlign = HorizontalAlign.Right;
           tr4.CssClass = "bgbluegrey";
           tr4.Cells.Add(tctr43);

           tr4.BackColor = System.Drawing.Color.White;
           tblunloadsheet.Rows.Add(tr4);

        }


        //strSQL = "Select (select codedesc from webx_master_general where codetype='Trn' and codeid=(select trn_mod from webx_master_docket where dockno=d.DockNo))+' - '+ (select codedesc from webx_master_general where codetype='SERVTY' and codeid=(select service_class from webx_master_docket where dockno=d.DockNo)) as Mode,d.from_loc+' - '+d.to_loc as Location,d.csgncd+'-'+d.csgnnm as csgnnm,convert(varchar,d.DOCKDT,6) as DOCKDT,convert(varchar,d.CDELDT,6) as CDELDT,d.ORGNCD,d.reassign_destcd as destcd,CSGENM=c.CSGNcd+' : '+((case when  c.CSGNCD='8888' then c.CSGNNM else (select custnm from webx_custhdr with(NOLOCK) where custcd=c.csgncd ) end )),d.paybas,d.pkgsno as nopkgs,d.ACTUWT,t.* from WEBX_TCTRN t with(NOLOCK) ,WEBX_TCHDR h with(NOLOCK),webx_Master_docket d with(NOLOCK),vw_master_docket_charges_cnor_cnee c with(NOLOCK) where d.dockno=c.dockno and t.dockno=d.dockno and  h.TCNO=t.TCNO and (h.ToBH_CODE is not null or h.ToBH_CODE<>'') and h.thcno ='" + strLoadingSheetNo + "' and h.ToBH_CODE='" + Desti + "' and t.TCNO ='" + TCNO + "' order by  h.ToBH_CODE,Substring(t.DOCKNO,3,7)";
        ////strSQL = "Select rtrim(left(convert(varchar,d.DOCKDT,106),6))+' '+right(convert(varchar,d.DOCKDT,106),2) as DOCKDT,rtrim(left(convert(varchar,d.CDELDT,106),6))+ ' '+left(convert(varchar,d.CDELDT,106),2) as CDELDT,d.ORGNCD,d.reassign_destcd as destcd,CSGENM=c.CSGNcd+' : '+((case when  CSGNCD='8888' then CSGNNM else (select custnm from webx_custhdr with(NOLOCK) where custcd=csgncd ) end )),d.paybas,d.pkgsno as nopkgs,d.ACTUWT,t.* from WEBX_TCTRN t with(NOLOCK) ,WEBX_TCHDR h with(NOLOCK),webx_docket d with(NOLOCK),webx_docket_cnor_cnee c with(NOLOCK) where d.dockno=c.dockno and t.dockno=d.dockno and  h.TCNO=t.TCNO and (h.ToBH_CODE is not null or h.ToBH_CODE<>'') and h.thcno ='" + strLoadingSheetNo + "' and h.ToBH_CODE='" + Desti + "' and t.TCNO ='" + TCNO + "' order by  h.ToBH_CODE,Substring(t.DOCKNO,3,7)";
        ////Response.Write("<br> <br><br>strSQL : " + strSQL);
        //cmd = new SqlCommand(strSQL, sqlConn);
        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

        //DataSet dsDocketList = new DataSet();

        //DataTable dt = new DataTable();

        //dt.Columns.Add("SrNo", typeof(string));
        //dt.Columns.Add("DocketNo", typeof(string));
        //dt.Columns.Add("Mode", typeof(string));
        //dt.Columns.Add("DocketDate", typeof(string));
        //dt.Columns.Add("BookingLocation", typeof(string));
        //dt.Columns.Add("Location", typeof(string));
        //dt.Columns.Add("ConsName", typeof(string));
        //dt.Columns.Add("CoseName", typeof(string));
        ////dt.Columns.Add("NextStop", typeof(string));
        //dt.Columns.Add("DelyLoc", typeof(string));
        //dt.Columns.Add("DelyDate", typeof(string));
        //dt.Columns.Add("PackagesLB", typeof(string));
        //dt.Columns.Add("WeightLB", typeof(string));

        //DataRow drdata;

        //sqlDA.Fill(dsDocketList);
        //int i = 1;
        ////double PakgL = 0;
        ////double PakgB = 0;
        ////double WeightL = 0;
        ////double WeightB = 0;

        //if (dsDocketList.Tables[0].Rows.Count > 0)
        //{
        //    foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
        //    {
        //        drdata = dt.NewRow();

        //        drdata["SrNo"] = i.ToString();
        //        i++;
        //        drdata["DocketNo"] = drRows["dockno"].ToString();
        //        drdata["Mode"] = drRows["Mode"].ToString();
        //        drdata["DocketDate"] = drRows["DOCKDT"].ToString() + " - " + drRows["CDELDT"].ToString();
        //        drdata["BookingLocation"] = drRows["orgncd"].ToString() + " - " + drRows["destcd"].ToString();
        //        drdata["Location"] = drRows["Location"].ToString();
        //        drdata["ConsName"] = drRows["csgnnm"].ToString();
        //        drdata["CoseName"] = drRows["CSGeNM"].ToString();
        //        //dr["NextStop"] = drRows["NextStop"].ToString() + " : " + getBranchName(drRows["NextStop"].ToString());
        //        drdata["DelyLoc"] = drRows["destcd"].ToString();
        //        drdata["DelyDate"] = drRows["CDELDT"].ToString();
        //        drdata["PackagesLB"] = drRows["Loadpkgsno"].ToString() + "/" + drRows["nopkgs"].ToString();
        //        drdata["WeightLB"] = drRows["Loadactuwt"].ToString() + "/" + drRows["loadcftwt"].ToString();

        //        //PakgL += Convert.ToDouble(drRows["Loadpkgsno"].ToString());
        //        //PakgB += Convert.ToDouble(drRows["nopkgs"].ToString());
        //        //WeightL += Convert.ToDouble(drRows["Loadactuwt"].ToString());
        //        //WeightB += Convert.ToDouble(drRows["loadcftwt"].ToString());

        //        dt.Rows.Add(drdata);
        //    }

        //    //rptDocketList.DataSource = dt;
        //    //rptDocketList.DataBind();

        //    //Total_Pack = "of "+PakgB.ToString();
        //    //lblPackLB.Text = PakgL.ToString() + "/" + PakgB.ToString();
        //    //lblWeightLB.Text = WeightL.ToString() + "/" + WeightB.ToString();
        //}
    }


    private void getLoadingSheetDetails()
    {
        try
        {
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            string strSQL = "Select * From vw_LS_Header Where replace(LSNo,'.','')='" + strLoadingSheetNo + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsLS = new DataSet();

            sqlDA.Fill(dsLS);

            if (dsLS.Tables[0].Rows.Count > 0)
            {
                strLoadingSheetDate = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["LSDate"].ToString()).ToString("dd/MM/yyyy");
                strLoadingSheetDateAsItIs = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["LSDate"].ToString()).ToString("dd MMM yy");
                strLoadingRouteCode = dsLS.Tables[0].Rows[0]["Route_Code"].ToString();
                strLoadingBranch = dsLS.Tables[0].Rows[0]["LS_Branch"].ToString() + " : " + getBranchName(dsLS.Tables[0].Rows[0]["LS_Branch"].ToString());
                strLoadingBranchCode = dsLS.Tables[0].Rows[0]["LS_Branch"].ToString();
                strLoadingVehicle = dsLS.Tables[0].Rows[0]["LS_VehicleNo"].ToString();
                strLoadingSheetTCDate = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["tcdt"].ToString()).ToString("dd/MM/yyyy");
                strLoadingSheetPrepBy = dsLS.Tables[0].Rows[0]["entryby"].ToString() + " : " + getEmployeeName(dsLS.Tables[0].Rows[0]["entryby"].ToString());
                strLoadingSheetTCDateInTimeFormat = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["tcdt"].ToString()).ToString("HH : mm");
            }
        }
        catch (Exception Ex)
        {

        }
    }

    private string getEmployeeName(string strEmployeeCode)
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            sqlConn.Open();

            string strSQL = "Select empnm from webx_EMPMST where empcd = '" + strEmployeeCode + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsEmployee = new DataSet();

            sqlDA.Fill(dsEmployee);

            return (dsEmployee.Tables[0].Rows.Count > 0 ? dsEmployee.Tables[0].Rows[0][0].ToString() : "-");
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getBranchName(string strBranchCode)
    {
        try
        {
            if (strBranchCode == "")
            {
                return "";
            }
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "webx_Check_Location";

            sqlCommand.Parameters.AddWithValue("@BRCD", strBranchCode);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsBranch = new DataSet();

            sqlDA.Fill(dsBranch);

            return (dsBranch.Tables[0].Rows.Count > 0 ? dsBranch.Tables[0].Rows[0]["LocName"].ToString() : "");
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private void paintDocketListing()
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            sqlConn.Open();

            string strSQL = "Select * From vw_LS_Detail_HR Where replace(LSNo,'.','')='" + strLoadingSheetNo.Replace(".", "") + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDocketList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("DocketNo", typeof(string));
            dt.Columns.Add("DocketDate", typeof(string));
            dt.Columns.Add("BookingLocation", typeof(string));
            dt.Columns.Add("ConsName", typeof(string));
            dt.Columns.Add("NextStop", typeof(string));
            dt.Columns.Add("DelyLoc", typeof(string));
            dt.Columns.Add("DelyDate", typeof(string));
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsDocketList);
            int i = 1;

            if (dsDocketList.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["DocketNo"] = drRows["Docket_No"].ToString();
                    dr["DocketDate"] = Convert.ToDateTime(drRows["BookingDt"].ToString()).ToString("dd MMM yy");
                    dr["BookingLocation"] = drRows["BookingLocation"].ToString() + " : " + getBranchName(drRows["BookingLocation"].ToString());
                    dr["ConsName"] = getConsName(drRows["csgncd"].ToString(), drRows["ConsignorName"].ToString()) + " / " + getConsName(drRows["csgecd"].ToString(), drRows["csgenm"].ToString());
                    dr["NextStop"] = drRows["NextStop"].ToString() + " : " + getBranchName(drRows["NextStop"].ToString());
                    dr["DelyLoc"] = drRows["DeliveryLocation"].ToString() + " : " + getBranchName(drRows["DeliveryLocation"].ToString());
                    dr["DelyDate"] = (drRows["DelyDate"] == System.DBNull.Value ? "" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
                    dr["PackagesLB"] = drRows["Packages_L_B"].ToString();
                    dr["WeightLB"] = drRows["Weight_L_B"].ToString();

                    dt.Rows.Add(dr);
                }

                //rptDocketList.DataSource = dt;
                //rptDocketList.DataBind();
            }
        }
        catch (Exception Ex)
        {

        }
    }

    private string getConsName(string strConsCode, string strConsName)
    {
        if (strConsCode == "8888")
        {
            return strConsName;
        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");

            try
            {
                sqlConn.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConn;
                sqlCommand.CommandText = "select CustNm from webx_Custhdr where Custcd='" + strConsCode + "'";

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
                DataSet dsConsName = new DataSet();

                sqlDA.Fill(dsConsName);

                return dsConsName.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception Ex)
            {
                return "";
                sqlConn.Close();
            }
        }
    }
}
