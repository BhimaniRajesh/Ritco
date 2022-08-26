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

public partial class GUI_Operations_THC_ViewPrint_THCViewPrint : System.Web.UI.Page
{
    string thcno, strqry, strManifestquery,thcbranch="";
    SqlConnection conn;
    Int32 t1, t2, t3;
    decimal t4, t5;
    Int32 m1, m2, m3, m4, m5, m6;
    public static string st_rutcd, st_rutcat, st_thcno, lng, THC_Detail, strqry_remarks;
	
    protected void Page_Load(object sender, EventArgs e)
    {
        //string logo = Session["logofile"].ToString();
        string logo = "WebXpress_logo.gif";
        imgLogo.ImageUrl = "~/GUI/images/" + logo;

        //Response.Write(imgLogo.ImageUrl);
        //Response.End();
        //conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
        thcno = Request.QueryString["tcno"];
        //Response.Write(thcno);
        //Response.End();
        string[] Split = thcno.Split(new Char[] { ',' });
        thcno = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);

        //(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) )
		strqry = "Select NetBalancePaidAmt = isnull(TOTALAMTPAID,0),otherAmt = (CASE WHEN loadOperType='P' THEN (Isnull(tel_chrg,0)+Isnull(load_chrg,0) - Isnull(mamul_chrg,0)) WHEN loadOperType='M' THEN Isnull(tel_chrg,0)-(Isnull(load_chrg,0) + Isnull(mamul_chrg,0)) ELSE Isnull(mamul_chrg,0) END), convert(varchar,t.vehregdt,106) as vehregdt,incentive,balamtbrcd,Hedu_Cess,advamt,advpaidby,tds_rate,tds_chrg,pan_no,tds_acccode,mamul_chrg,load_chrg,tds_accdesc,tdsgrpcode,tdsgrpdesc,tdsfor,svrcamt,cessamt,netbalamt,svrc_rate,pcamt,tel_chrg,thcno,CONVERT(varchar,thcdt,6) as thcdt,manualthcno,routecd,routename,rut_cat,sourcehb,tobh_code,vendor_name,advamt,vendor_code,Payload=isnull((case when isnull(Payload,0)>0 then Payload*1000 end),0),advpaidby,driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype ,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where type_code=Vehicle_type),FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),reg_date=CONVERT(varchar,t.vehregdt,06),act_dept_time=(convert(varchar,actdept_dt,6)+' '+actdept_tm ),OPENKM,aech_dept_time=(convert(varchar,sehedept_dt,6)+' '+schedept_tm ),LateDeptReason=(select top 1 codedesc as type_name1 from webx_master_general where codetype='LATE_D' and codeid=LateDeptReason),CHASISNO,engineno,sealno_out,THCNEW_ENTRYBY=(select top 1 name from webx_master_users where UserId =THCNEW_ENTRYBY), THCNEW_ENTRYDT=(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) ) ";
		strqry += ",FROMCITY=ISNULL(FROMCITY,''),TOCITY=ISNULL(TOCITY,''),IsTransshipment = CASE WHEN IsTransshipment='Y' THEN 'Yes' ELSE 'No' END,Transshipment_TransitLocation =isnull(Transshipment_TransitLocation,''),Transshipment_Remark =isnull(Transshipment_Remark,''),Transshipment_TentativeFreight =isnull(Transshipment_TentativeFreight,0),ThcEditDate=ISNULL(CONVERT(varchar,FE.EditDate,106),''),ThcEditBy=ISNULL((select top 1 name from webx_master_users where UserId =FE.EditBy),''),* ";
        strqry += " from webx_thc_summary t with(NOLOCK) left outer join webx_vehicle_hdr V with(NOLOCK)on t.Vehno=v.vehno ";
		strqry += " outer apply(select top 1 FE.EditBy,FE.EditDate from Webx_Thc_Financial_Edit FE with(NOLOCK) where FE.THCNO=t.THCNO order by SrNo desc )FE ";        
        //strqry += " OUTER APPLY(SELECT SUM(D.InstalmentAmount) Amt FROM Webx_Thc_AdvanceInstalment_Det D WHERE d.ThcNo = t.thcno)Adv";
        strqry += " where t.THCNO+t.thcsf ='" + thcno + "'"; 

        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, conn);
        
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            LblTHCNo.Text = thcno;
            thcbranch = dr["thcbr"].ToString();
            HdnTHCNo.Value = thcno.Remove(thcno.Length - 1);
            LblMTHCNo.Text = dr["manualthcno"].ToString();
            LblTHCDt.Text = dr["thcdt"].ToString();
            LblRoute.Text = dr["routecd"].ToString() + ":" + dr["routename"].ToString();
            lblVehicleTrackNo.Text = dr["VTRACK_NO"].ToString();
            lblVendor.Text = dr["vendor_name"].ToString();
            lblTreepSheetNo.Text = dr["TripSheetNo"].ToString();
            if ((dr["rut_cat"].ToString().Trim()) == "S")
            {
                lblTHCMode.Text = "Surface";
            }
            else if ((dr["rut_cat"].ToString().Trim()) == "A")
            {
                lblTHCMode.Text = "Air";
                tdAirBill.Visible = true;
                tdAirNo.Visible = true;
                lblAirLineNo.Text = dr["airline_name"].ToString();
                lblFlighNo.Text = dr["flightno"].ToString();
                lblAirBillNo.Text = dr["airbillno"].ToString();
                
            }
            else if ((dr["rut_cat"].ToString().Trim()) == "R")
            {
                lblTHCMode.Text = "Rail";
            }
            else
            {
                lblTHCMode.Text = "";
            }
            lblVendorType.Text = dr["vtype"].ToString();
            lblVehicleNo.Text = dr["vehno"].ToString();
            lblRCBookNo.Text = dr["RCBOOKNO"].ToString();
            lblVehicleType.Text = dr["vehtype"].ToString();
            lblVehicleRegDt.Text = dr["reg_date"].ToString();
            lblEngineNo.Text = dr["engineno"].ToString();
            lblInsuranceDt.Text = dr["INS_DATE"].ToString();
            lblChassisNo.Text = dr["CHASISNO"].ToString();
            lblFitnessDt.Text = dr["FITNESSDATE"].ToString();
            lblSealNo.Text = dr["sealno_out"].ToString();
            lblVehicleFreeSpace.Text = dr["FreeSpace"].ToString() + " %";
            lblStartKM.Text = dr["OPENKM"].ToString() + "-" + dr["CLOSEKM"].ToString();
            lblPANNo.Text = Convert.ToString(dr["pan_no"]);
            lblAdvAt.Text = dr["fincmplbr"].ToString();
            lblBalAt.Text= dr["balamtbrcd"].ToString();
            lblCapacity.Text = dr["Capacity"].ToString();
			lbThcEditDate.Text = dr["ThcEditDate"].ToString();
			lbThcEditBy.Text = dr["ThcEditBy"].ToString();
            if (dr["driver1"].ToString() == "")
            {
                driver1.Visible = false;
            }
            else
            {
                driver1.Visible = true;
                Lbldriver1.Text = dr["driver1"].ToString();
                Lbldriver1lic.Text = dr["driver1licno"].ToString();
                Lbldriver1valdt.Text = dr["dr1Valdt"].ToString();
                Lbldriver1RTO.Text = dr["driverrto1"].ToString();
            }

            if (dr["driver2"].ToString() == "")
            {
                driver2.Visible = false;
            }
            else
            {
                driver2.Visible = true;
                Lbldriver2.Text = dr["driver2"].ToString();
                Lbldriver2lic.Text = dr["driver2licno"].ToString();
                Lbldriver2valdt.Text = dr["dr2Valdt"].ToString();
                Lbldriver2RTO.Text = dr["driverrto2"].ToString();
            }
            if (dr["driver1"].ToString() == "" && dr["driver2"].ToString() == "")
            {
                driver1.Visible = false;
                driver2.Visible = false;
                driverTable.Visible = false;
            }


            lblStandardConAmt.Text = dr["STDPCAMT"].ToString();
            lblTDSRate.Text = dr["tds_rate"].ToString();
            lblConAmt.Text = dr["pcamt"].ToString();
            lblTDS.Text = dr["tds_chrg"].ToString();
            lblIncentive.Text = dr["incentive"].ToString();
            lblTelephone.Text = dr["tel_chrg"].ToString();
            lblDeduction.Text = dr["oth_ded"].ToString();
            lblOther.Text = dr["otherAmt"].ToString();
            lblAdvancePaid.Text = dr["advAmt"].ToString();
            lblNetBalPayable.Text = dr["netbalamt"].ToString();
            lblAdvPaymentMode.Text = dr["adv_transtype"].ToString();
            lblBalPaymentMode.Text = dr["bal_transtype"].ToString();
            lblAdvVoucherNo.Text = dr["advVoucherNo"].ToString();
            lblBalVoucherNo.Text = dr["balvoucherNo"].ToString();

            lblAdvVoucherNo.Text = "<a href=\"javascript:popupmenu1('" + lblAdvVoucherNo.Text + "',0)\"> " + lblAdvVoucherNo.Text + " </a> ";
            lblBalVoucherNo.Text = "<a href=\"javascript:popupmenu2('" + lblBalVoucherNo.Text + "',0)\"> " + lblBalVoucherNo.Text + " </a> ";

            //lblAdvVoucherNo.Text = "<a href=\"javascript:popupmenu1('" + lblAdvVoucherNo.Text + "',0)\"></a> ";
            //lblBalVoucherNo.Text = "<a href=\"javascript:popupmenu2('" + lblBalVoucherNo.Text + "',0)\"></a> ";

            lblPreparedAtDt.Text = dr["THCCLOSE_ENTRYDT"].ToString();
            lblStaffname.Text = dr["THCCLOSE_ENTRYBY"].ToString();
            lblEnteredBy.Text = dr["THCNEW_ENTRYBY"].ToString();
            lblEnteredAtDt.Text = dr["THCNEW_ENTRYDT"].ToString();
            lblActWt.Text = dr["ld_actuwt"].ToString();
            lblChgWt.Text = dr["ld_cftwt"].ToString();
			
			lblTransshipment.Text = dr["IsTransshipment"].ToString();
            lblTransitLocation.Text = dr["Transshipment_TransitLocation"].ToString();
            lblTransshipmentRemark.Text = dr["Transshipment_Remark"].ToString();
            lblTentativeFreight.Text = dr["Transshipment_TentativeFreight"].ToString();

            lblFromCity.Text = dr["FROMCITY"].ToString();
            lblToCity.Text = dr["TOCITY"].ToString();

        }
        dr.Close();

        strqry = "select LocAddr,LocSTDCode,LocTelno,LocPinCode from webx_Location where Loccode='" + thcbranch + "'";
        cmd = new SqlCommand(strqry, conn);
        
       
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            txtLocAddress.Text = "<b>Address : </b>" + dr["LocAddr"].ToString();
            lblPinCode.Text = "<b>PinCode : </b>" + dr["LocPinCode"].ToString();
            lblPhone.Text = "<b>Phone : </b>" + dr["LocSTDCode"].ToString() + '-' + dr["LocTelno"].ToString();
        }
        dr.Close();

        if (lblVendor.Text == "")
        {
		//string strqryvendor = "select (vendor_code +':'+vendor_name) as vendor_name,vendor_code from webx_thc_summary where THCNO+thcsf ='" + thcno + "'";
	    thcno = thcno.Replace(".", "");
            string strqryvendor = "select (vendor_code +':'+vendor_name) as vendor_name,vendor_code from webx_thc_summary where THCNO ='" + thcno + "' and thcsf='.'";

            SqlDataReader drvendor;
            SqlCommand cmdvendor = new SqlCommand(strqryvendor, conn);


            drvendor = cmdvendor.ExecuteReader();
            while (drvendor.Read())
            {
                lblVendor.Text = drvendor["vendor_name"].ToString();
                if (drvendor["vendor_code"].ToString() == "9888" || drvendor["vendor_code"].ToString() == "8888")
                {
                    lblVendorType.Text = "Market Vendor";
                }
                
            }
            drvendor.Close();
        }
		strqry_remarks = "select thc_inrem as thc_inrem,thc_outrem as thc_outrem from webx_THCHDR  where THCNO+thcsf ='" + thcno + "'";
        SqlDataReader dr_remarks;
        SqlCommand cmd_remarks = new SqlCommand(strqry_remarks, conn);
        
        dr_remarks = cmd_remarks.ExecuteReader();
        while (dr_remarks.Read())
        {
            if (dr_remarks["thc_inrem"] != DBNull.Value)
            {
                lblRemarks123.Text = dr_remarks["thc_inrem"].ToString();
            }
            if (dr_remarks["thc_outrem"] != DBNull.Value)
            {
                lblRemarks11.Text = dr_remarks["thc_outrem"].ToString();
            }
            
        }
        dr_remarks.Close();
        conn.Close();


        tblMFDKT.Visible = true;
        tblMFDKT.CellSpacing = 1;
        tblMFDKT.CssClass = "boxbg";
        tblMFDKT.CellPadding = 1;
        //tblMFDKT.BorderWidth = Unit.Parse("1");
        TableRow tr1 = new TableRow();

        TableCell tctr1 = new TableCell();
        TableCell tctr3 = new TableCell();
        TableCell tctr5 = new TableCell();


        tctr1.Text = "Location";
        tctr1.CssClass = "blackfnt";
        tctr1.Wrap = false;
        tctr1.RowSpan = 2;
        tctr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr1);
        

        tctr3.Text = "Arrival";
        tctr3.CssClass = "blackfnt";
        tctr3.Wrap = false;
        tctr3.ColumnSpan = 2;
        tctr3.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr3);


        tctr5.Text = "Departure";
        tctr5.CssClass = "blackfnt";
        tctr5.Wrap = false;
        tctr5.ColumnSpan = 2;
        tctr5.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr5);

        tblMFDKT.Rows.Add(tr1);

        TableRow tr2 = new TableRow();

        TableCell tctr22 = new TableCell();
        TableCell tctr23 = new TableCell();

        TableCell tctr25 = new TableCell();
        TableCell tctr26 = new TableCell();

        tctr22.Text = "Actual";
        tctr22.CssClass = "blackfnt";
        tctr22.Wrap = false;
        tctr22.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr22);

        tctr23.Text = "Reason";
        tctr23.CssClass = "blackfnt";
        tctr23.Wrap = false;
        tctr23.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr23);

        tctr25.Text = "Actual";
        tctr25.CssClass = "blackfnt";
        tctr25.Wrap = false;
        tctr25.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr25);


        tctr26.Text = "Reason";
        tctr26.CssClass = "blackfnt";
        tctr26.Wrap = false;
        tctr26.HorizontalAlign = HorizontalAlign.Center;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tctr26);

        tblMFDKT.Rows.Add(tr2);

        conn.Open();
	thcno = thcno.Replace(".", "");
        string sql_DKTlist = "select sourcehb,convert(varchar,actarrv_dt,106) as actarrv_dt,actarrv_tm,convert(varchar,actdept_dt,106) as actdept_dt,actdept_tm,LATE_ARRIVAL,LateArrivalReason,* from webx_thchdr where THCNO ='" + thcno + "' and thcsf='.'";

        SqlCommand cmddktlist = new SqlCommand(sql_DKTlist, conn);
        SqlDataReader drdktlist = cmddktlist.ExecuteReader();

        int ik = 1;

        while (drdktlist.Read())
        {

            TableRow tr3 = new TableRow();

            TableCell tctr31 = new TableCell();
            TableCell tctr32 = new TableCell();
            TableCell tctr33 = new TableCell();

            TableCell tctr34 = new TableCell();
            TableCell tctr35 = new TableCell();
            TableCell tctr36 = new TableCell();
            TableCell tctr37 = new TableCell();

            tctr31.Text = drdktlist["sourcehb"].ToString();
            tctr31.CssClass = "blackfnt";
            tctr31.Wrap = false;
            tctr31.HorizontalAlign = HorizontalAlign.Center;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tctr31);

            
            tctr33.Text = drdktlist["actarrv_dt"].ToString() + ":" + drdktlist["actarrv_tm"].ToString();
            tctr33.CssClass = "blackfnt";
            tctr33.Wrap = false;
            tctr33.HorizontalAlign = HorizontalAlign.Center;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tctr33);

            tctr34.Text = drdktlist["LATE_ARRIVAL"].ToString();
            tctr34.CssClass = "blackfnt";
            tctr34.Wrap = false;
            tctr34.HorizontalAlign = HorizontalAlign.Center;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tctr34);

            tctr36.Text = drdktlist["actdept_dt"].ToString() + ":" + drdktlist["actdept_tm"].ToString();
            tctr36.CssClass = "blackfnt";
            tctr36.Wrap = false;
            tctr36.HorizontalAlign = HorizontalAlign.Center;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tctr36);
            tr3.BackColor = System.Drawing.Color.White;

            tctr37.Text = drdktlist["LateArrivalReason"].ToString();
            tctr37.CssClass = "blackfnt";
            tctr37.Wrap = false;
            tctr37.HorizontalAlign = HorizontalAlign.Center;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tctr37);
            tr3.BackColor = System.Drawing.Color.White;

            tblMFDKT.Rows.Add(tr3);
        }
        drdktlist.Close();
        conn.Close();
        BindManifestMovment();
		//RetrieveGridDataVoucher();
    }

	 public void RetrieveGridDataVoucher()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "Usp_ThcAdvance_AllVoucherDetailsViewPrint";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@ThcNo", SqlDbType.VarChar).Value = thcno;
        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = ds.Tables[0].DefaultView; 
        
        double totalSalary = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            totalSalary += Convert.ToDouble(dr["Debit"]);
        }  
        lblAdvancePaid.Text = totalSalary.ToString();

        //lblNetBalPayable.Text = (Convert.ToDouble(lblNetBalPayable.Text) - Convert.ToDouble(lblAdvancePaid.Text)).ToString();

        conn.Close();
    }
	
    private void BindManifestMovment()
    {
        //conn.Open();
        //strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno+thcsf ='" + thcno + "'";
        //SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds);
        //GrdManifest.DataSource = ds;
        //GrdManifest.DataBind();
        //conn.Close();
        conn.Open();

        //strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,(TOT_LOAD_ACTWT+isNULL(WTADJ,0)) as TOT_LOAD_ACTWT,(TOT_ACTUWT +isNULL(WTADJ,0)) as TOT_ACTUWT ,0 as AIRBILLTOTAMT from webx_tchdr with(NOLOCK) where thcno ='" + thcno.Replace(".", "") + "'";
        strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,(case when WTADJ_PM = '+' then  (TOT_LOAD_ACTWT+isNULL(WTADJ,0)) when WTADJ_PM = '-' then (TOT_LOAD_ACTWT-isNULL(WTADJ,0)) else (TOT_LOAD_ACTWT) end ) as TOT_LOAD_ACTWT, (case  when WTADJ_PM = '+' then  (TOT_ACTUWT+isNULL(WTADJ,0)) when WTADJ_PM = '-' then (TOT_ACTUWT-isNULL(WTADJ,0)) else (TOT_ACTUWT) end ) as TOT_ACTUWT, 0 as AIRBILLTOTAMT  from webx_tchdr with(NOLOCK) where thcno ='" + thcno.Replace(".", "") + "'";
        
        SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GrdManifest.DataSource = ds;
        GrdManifest.DataBind();
        conn.Close();
    }
}
