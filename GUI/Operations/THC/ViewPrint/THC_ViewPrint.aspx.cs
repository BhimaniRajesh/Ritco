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

public partial class GUI_Operations_THC_ViewPrint_THC_ViewPrint : System.Web.UI.Page
{
    string thcno, strqry, strManifestquery;
    SqlConnection conn;
    Int32 t1, t2, t3;
    decimal t4, t5;
    Int32 m1, m2, m3, m4, m5, m6;
    public static string st_rutcd, st_rutcat, st_thcno, lng, THC_Detail, strqry_remarks;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        thcno = Request.QueryString["tcno"];
        strqry = "Select convert(varchar,t.vehregdt,106) as vehregdt,incentive,otherAmt = (load_chrg + mamul_chrg),balamtbrcd,Hedu_Cess,advamt,advpaidby,tds_rate,tds_chrg,pan_no,tds_acccode,mamul_chrg,load_chrg,tds_accdesc,tdsgrpcode,tdsgrpdesc,tdsfor,svrcamt,cessamt,netbalamt,svrc_rate,pcamt,tel_chrg,thcno,CONVERT(varchar,thcdt,6) as thcdt,manualthcno,routecd,routename,rut_cat,sourcehb,tobh_code,vendor_name,advamt,vendor_code,Payload=isnull((case when isnull(Payload,0)>0 then Payload*1000 end),0),advpaidby,driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype ,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where type_code=Vehicle_type),FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),reg_date=CONVERT(varchar,t.vehregdt,06),act_dept_time=(convert(varchar,actdept_dt,6)+' '+actdept_tm ),OPENKM,aech_dept_time=(convert(varchar,sehedept_dt,6)+' '+schedept_tm ),LateDeptReason=(select top 1 codedesc as type_name1 from webx_master_general where codetype='LATE_D' and codeid=LateDeptReason),CHASISNO,engineno,sealno_out,THCNEW_ENTRYBY=(select Top 1 name from webx_master_users where UserId =THCNEW_ENTRYBY), THCNEW_ENTRYDT=(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) ),* from webx_thc_summary t with(NOLOCK) left outer join webx_vehicle_hdr V with(NOLOCK)on t.Vehno=v.vehno where THCNO+thcsf ='" + thcno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            LblTHCNo.Text = thcno;
            LblMTHCNo.Text = dr["manualthcno"].ToString();
            LblTHCDt.Text = dr["thcdt"].ToString();
            LblRoute.Text = dr["routecd"].ToString() + ":" + dr["routename"].ToString();
            lblVehicleTrackNo.Text = dr["VTRACK_NO"].ToString();
            lblVendor.Text = dr["vendor_name"].ToString();
            lblTHCMode.Text = dr["rut_cat"].ToString();
            
            if (Convert.ToString(dr["rut_cat"]) == "S")
            {
                lblTHCMode.Text = "Surface";
            }
            else if (Convert.ToString(dr["rut_cat"]) == "A")
            {
                lblTHCMode.Text = "Air";
            }
            else if (Convert.ToString(dr["rut_cat"]) == "R")
            {
                lblTHCMode.Text = "Rail";
            }
            else
            {
                lblTHCMode.Text = "";
            }
            //LblNxtStop.Text = dr["tobh_code"].ToString();

            lblVendorType.Text = dr["vtype"].ToString();
            lblVehicleNo.Text = dr["vehno"].ToString();
            lblRCBookNo.Text = dr["RCBOOKNO"].ToString();
            lblVehicleType.Text = dr["vehtype"].ToString();
            lblVehicleRegDt.Text = dr["vehregdt"].ToString();
            lblEngineNo.Text = dr["engineno"].ToString();
            lblInsuranceDt.Text = dr["INS_DATE"].ToString();
            lblChassisNo.Text = dr["CHASISNO"].ToString();
            lblFitnessDt.Text = dr["FITNESSDATE"].ToString();
            lblSealNo.Text = dr["sealno_out"].ToString();
            //lblVehicleFreeSpace.Text = dr[""].ToString();
            lblStartKM.Text = dr["OPENKM"].ToString();
            lblClosingKM.Text = dr["CLOSEKM"].ToString();

            //lblActualDepDate.Text = dr["act_dept_time"].ToString();
            //lblScheduleDt.Text = dr["aech_dept_time"].ToString();
            //lblLateDeptReason.Text = dr["LateDeptReason"].ToString();
            
            
            
            //LblRegDate.Text = dr["reg_date"].ToString();
            
            //LblCapacity.Text = dr["Payload"].ToString();
            
            

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
            lblAdvancePaid.Text = dr["advamt"].ToString();
            lblNetBalPayable.Text = dr["netbalamt"].ToString();
            lblAdvPaymentMode.Text = dr["adv_transtype"].ToString();
            lblBalPaymentMode.Text = dr["bal_transtype"].ToString();
            lblAdvVoucherNo.Text = dr["advVoucherNo"].ToString();
            lblBalVoucherNo.Text = dr["balvoucherNo"].ToString();


            //lblTeleCharges.Text = dr["tel_chrg"].ToString();
            //lblHamali.Text = dr["load_chrg"].ToString();
            //lblMamul.Text = dr["mamul_chrg"].ToString();
            
            
            //lblServiceTaxRate.Text = dr["svrc_rate"].ToString();
            //lblPartyPANNo.Text = dr["pan_no"].ToString();
            //lblServiceTax.Text = dr["svrcamt"].ToString();
            //lblCess.Text = dr["cessamt"].ToString();
            ////lblTDSType.Text = dr[""].ToString();
            //lblTDSDedFor.Text = dr["tdsfor"].ToString();
            //lblAdvAmt.Text = dr["advamt"].ToString();
            //lblAdvAmtPaidBy.Text = dr["advpaidby"].ToString();
            //lblBalAmt.Text = dr["netbalamt"].ToString();
            //lblBalPayableAt.Text = dr["balamtbrcd"].ToString();

            //lblStaffname.Text = dr[""].ToString();
            //lblSign.Text = dr[""].ToString();
            lblPreparedBy.Text = dr["THCNEW_ENTRYBY"].ToString();
            //lblAt.Text = dr[""].ToString();
            lblEntryDtandTime.Text = dr["THCNEW_ENTRYDT"].ToString();

        }
        dr.Close();
        
        strqry_remarks = "select TOP 1 thc_outrem from webx_THCHDR where THCNO+thcsf ='" + thcno + "' ";
        SqlDataReader dr_remarks;
        SqlCommand cmd_remarks = new SqlCommand(strqry_remarks, conn);
        conn.Open();
        dr_remarks = cmd_remarks.ExecuteReader();
        while (dr_remarks.Read())
        {
            lblRemarks11.Text = dr_remarks["thc_outrem"].ToString();
        }
        dr_remarks.Close();
        conn.Close();

        BindManifestMovment();

        //dosprint();
    }
    //private void dosprint()
    //{
    //    THC_Detail = "\\n";
    //    THC_Detail = THC_Detail + string.Empty.PadLeft(27) + "RELOGISTICS INDIA PVT LTD" + "\\n";
    //    THC_Detail = THC_Detail + string.Empty.PadLeft(45) + "THC" + "\\n";
    //    THC_Detail = THC_Detail + string.Empty.PadLeft(70) + "Page No. : 1" + "\\n";
    //    THC_Detail = THC_Detail + "VHC Number:" + thcno + string.Empty.PadLeft(15) + "Manual THC No:" + LblMTHCNo.Text + "\\n";
    //    THC_Detail = THC_Detail + "VHC Date     :" + LblTHCDt.Text + "\\n";
    //    THC_Detail = THC_Detail + "----------------------------------------------------------------------------------------" + "\\n";
    //    THC_Detail = THC_Detail + "| Route            |" + LblRoute.Text + string.Empty.PadLeft(15 - Convert.ToInt32(LblRoute.Text.Length)) + "| Current Location |" + LblCurLoc.Text + string.Empty.PadLeft(15 - Convert.ToInt32(LblCurLoc.Text.Length)) + "| Vendor Name |" + LblVendorName.Text + string.Empty.PadLeft(15 - Convert.ToInt32(LblVendorName.Text.Length)) + "\\n";
    //    THC_Detail = THC_Detail + "| VHC Mode         |" + lblTHCMode.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblTHCMode.Text.Length)) + "| Next Stop |" + LblNxtStop.Text + "| Vendor Type |" + LblVendorType.Text + "\\n";
    //    THC_Detail = THC_Detail + "| Act.Dept Dt&Time |" + lblActualDepDate.Text + "| Sche.Dt&Time |" + lblScheduleDt.Text + "| Late Dept. Reason |" + lblLateDeptReason.Text + "\\n";
    //    THC_Detail = THC_Detail + "| Starting KM      |" + lblStartKM.Text + "| Seal No |" + lblSealNo.Text + "\\n";
    //    THC_Detail = THC_Detail + "----------------------------------------------------------------------------------------" + "\\n";

    //    THC_Detail = THC_Detail + string.Empty.PadLeft(40) + "Vehicle Summary" + "\\n";
        
    //    int cnt = 1;
    //}

    private void BindManifestMovment()
    {
        strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno+thcsf ='" + thcno + "'";
        SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GrdManifest.DataSource = ds;
        GrdManifest.DataBind();
    }
}
