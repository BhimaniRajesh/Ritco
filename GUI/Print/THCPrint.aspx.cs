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

public partial class GUI_Print_THCPrint : System.Web.UI.Page
{
    string thcno, strqry, strManifestquery;
    SqlConnection conn;
    Int32 t1, t2, t3;
    decimal t4, t5;
    Int32 m1, m2, m3, m4, m5, m6;
    public int cnt = 1;
    public static string st_rutcd, st_rutcat, st_thcno, lng, THC_Detail;

    protected void Page_Load(object sender, EventArgs e)
    {
        //string logo = Session["logofile"].ToString();
        //imgLogo.ImageUrl = "~/GUI/images/" + logo;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        thcno = Request.QueryString["tcno"];
        //strqry = "Select balamtbrcd,Hedu_Cess,advamt,advpaidby,tds_rate,tds_chrg,pan_no,tds_acccode,mamul_chrg,load_chrg,tds_accdesc,tdsgrpcode,tdsgrpdesc,tdsfor,svrcamt,cessamt,netbalamt,svrc_rate,pcamt,tel_chrg,thcno,CONVERT(varchar,thcdt,6) as thcdt,manualthcno,routecd,routename,rut_cat,sourcehb,tobh_code,vendor_name,advamt,vendor_code,Payload=isnull((case when isnull(Payload,0)>0 then Payload*1000 end),0),advpaidby,driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype ,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where type_code=Vehicle_type),FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),reg_date=CONVERT(varchar,t.vehregdt,06),act_dept_time=(convert(varchar,actdept_dt,6)+' '+actdept_tm ),OPENKM,aech_dept_time=(convert(varchar,sehedept_dt,6)+' '+schedept_tm ),LateDeptReason=(select top 1 codedesc as type_name1 from webx_master_general where codetype='LATE_D' and codeid=LateDeptReason),CHASISNO,engineno,sealno_out,THCNEW_ENTRYBY=(select name from webx_master_users where UserId =THCNEW_ENTRYBY), THCNEW_ENTRYDT=(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) ) from webx_thc_summary t with(NOLOCK) left outer join webx_vehicle_hdr V with(NOLOCK)on t.Vehno=v.vehno where THCNO+thcsf ='" + thcno + "'";
        strqry = "Select balamtbrcd,Hedu_Cess,advamt,advpaidby,tds_rate,tds_chrg,pan_no,tds_acccode,mamul_chrg,load_chrg,tds_accdesc,tdsgrpcode,tdsgrpdesc,tdsfor,svrcamt,cessamt,netbalamt,svrc_rate,pcamt,tel_chrg,thcno,CONVERT(varchar,thcdt,6) as thcdt,manualthcno,routecd,routename,rut_cat,sourcehb,tobh_code,vendor_name,advamt,vendor_code,Payload=isnull((case when isnull(Payload,0)>0 then Payload*1000 end),0),advpaidby,driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype ,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where t.vehtype <> '' and type_code=t.vehtype),FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),reg_date=CONVERT(varchar,t.vehregdt,06),act_dept_time=(convert(varchar,actdept_dt,6)+' '+actdept_tm ),OPENKM,aech_dept_time=(convert(varchar,sehedept_dt,6)+' '+schedept_tm ),LateDeptReason=(select top 1 codedesc as type_name1 from webx_master_general where codetype='LATE_D' and codeid=LateDeptReason),CHASISNO,engineno,sealno_out,THCNEW_ENTRYBY=(select name from webx_master_users where UserId =THCNEW_ENTRYBY), THCNEW_ENTRYDT=(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) ) from webx_thc_summary t with(NOLOCK) left outer join webx_vehicle_hdr V with(NOLOCK)on t.Vehno=v.vehno where THCNO+thcsf ='" + thcno + "'";
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
            LblCurLoc.Text = dr["sourcehb"].ToString();
            LblVendorName.Text = dr["vendor_name"].ToString();
            lblTHCMode.Text = dr["rut_cat"].ToString();
            if ((dr["rut_cat"].ToString().Trim()) == "S")
            {
                lblTHCMode.Text = "Surface";
            }
            else if ((dr["rut_cat"].ToString().Trim()) == "A")
            {
                lblTHCMode.Text = "Air";
            }
            else if ((dr["rut_cat"].ToString().Trim()) == "R")
            {
                lblTHCMode.Text = "Rail";
            }
            else
            {
                lblTHCMode.Text = "";
            }
            LblNxtStop.Text = dr["tobh_code"].ToString();
            LblVendorType.Text = dr["vtype"].ToString();
            //lblOnVehicleFree.Text = dr[""].ToString();
            lblSealNo.Text = dr["sealno_out"].ToString();
            //lblPhoneNo.Text = dr[""].ToString();
            lblActualDepDate.Text = dr["act_dept_time"].ToString();
            lblScheduleDt.Text = dr["aech_dept_time"].ToString();
            lblLateDeptReason.Text = dr["LateDeptReason"].ToString();
            lblStartKM.Text = dr["OPENKM"].ToString();
            LblVehNO.Text = dr["vehno"].ToString();
            LblVehType.Text = dr["vehtype"].ToString();
            LblFitValDt.Text = dr["FITNESSDATE"].ToString();
            LblRegDate.Text = dr["reg_date"].ToString();
            LblInsValDt.Text = dr["INS_DATE"].ToString();
            LblCapacity.Text = dr["Payload"].ToString();
            LblChassisNo.Text = dr["CHASISNO"].ToString();
            LblEngineNo.Text = dr["engineno"].ToString();


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


            lblStandardConAmt.Text = dr["pcamt"].ToString();
            lblConAmt.Text = dr["pcamt"].ToString();
            lblTeleCharges.Text = dr["tel_chrg"].ToString();
            lblHamali.Text = dr["load_chrg"].ToString();
            lblMamul.Text = dr["mamul_chrg"].ToString();
            lblTDSRate.Text = dr["tds_rate"].ToString();
            lblTDSAmt.Text = dr["tds_chrg"].ToString();
            lblServiceTaxRate.Text = dr["svrc_rate"].ToString();
            lblPartyPANNo.Text = dr["pan_no"].ToString();
            lblServiceTax.Text = dr["svrcamt"].ToString();
            lblCess.Text = dr["cessamt"].ToString();
            //lblTDSType.Text = dr[""].ToString();
            lblTDSDedFor.Text = dr["tdsfor"].ToString();
            lblAdvAmt.Text = dr["advamt"].ToString();
            lblAdvAmtPaidBy.Text = dr["advpaidby"].ToString();
            lblBalAmt.Text = dr["netbalamt"].ToString();
            lblBalPayableAt.Text = dr["balamtbrcd"].ToString();

            lblPreparedBy.Text = dr["THCNEW_ENTRYBY"].ToString();
            lblEntryDtandTime.Text = dr["THCNEW_ENTRYDT"].ToString();

        }
        dr.Close();
        conn.Close();

        BindManifestMovment();

        dosprint();
    }
    private void dosprint()
    {
        string route = LblRoute.Text;
        if (Convert.ToInt32(route.Length) > 15)
        {
            route = route.Substring(0, 14);
        }
        string ScheduleDt = lblScheduleDt.Text;
        if (Convert.ToInt32(ScheduleDt.Length) > 20)
        {
            ScheduleDt = ScheduleDt.Substring(0, 20);
        }


        THC_Detail = "\\n";
        THC_Detail = THC_Detail + string.Empty.PadLeft(27) + "RELOGISTICS INDIA PVT LTD" + "\\n";
        THC_Detail = THC_Detail + string.Empty.PadLeft(38) + "THC" + "\\n";
        THC_Detail = THC_Detail + "Page No. : 1" + "\\n";
        THC_Detail = THC_Detail + "VHC Number:" + thcno + string.Empty.PadLeft(30 - Convert.ToInt32(thcno.ToString().Length)) + "Manual THC No:" + LblMTHCNo.Text + "\\n";
        THC_Detail = THC_Detail + "VHC Date:" + LblTHCDt.Text + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        THC_Detail = THC_Detail + "|Route   |" + route + string.Empty.PadLeft(15 - Convert.ToInt32(route.ToString().Length)) + "|CurrLoc |" + LblCurLoc.Text + string.Empty.PadLeft(11 - Convert.ToInt32(LblCurLoc.Text.Length)) + "|VendorName|" + LblVendorName.Text + string.Empty.PadLeft(20 - Convert.ToInt32(LblVendorName.Text.Length)) + "\\n";
        THC_Detail = THC_Detail + "|VHC Mode|" + lblTHCMode.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblTHCMode.Text.Length)) + "|NextStop|" + LblNxtStop.Text + string.Empty.PadLeft(11 - Convert.ToInt32(LblNxtStop.Text.Length)) + "|VendorType|" + LblVendorType.Text + "\\n";
        THC_Detail = THC_Detail + "|Start KM|" + lblStartKM.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblStartKM.Text.Length)) + "| Seal No|" + lblSealNo.Text + string.Empty.PadLeft(11 - Convert.ToInt32(lblSealNo.Text.Length)) + "|LateReason|" + lblLateDeptReason.Text + "\\n";
        THC_Detail = THC_Detail + "|AcDeptDt|" + lblActualDepDate.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblActualDepDate.Text.Length)) + "|ScDtTime|" + ScheduleDt + string.Empty.PadLeft(20 - Convert.ToInt32(ScheduleDt.ToString().Length)) + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";

        THC_Detail = THC_Detail + string.Empty.PadLeft(27) + "Vehicle & Driver Summary" + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        THC_Detail = THC_Detail + "|Number   |" + LblVehNO.Text + string.Empty.PadLeft(14 - Convert.ToInt32(LblVehNO.Text.ToString().Length)) + "|VehType|" + LblVehType.Text + string.Empty.PadLeft(14 - Convert.ToInt32(LblVehType.Text.Length)) + "|FitnessValidityDate|" + LblFitValDt.Text  + "\\n";
        THC_Detail = THC_Detail + "|PayloadKg|" + LblCapacity.Text + string.Empty.PadLeft(11 - Convert.ToInt32(LblCapacity.Text.ToString().Length)) + "|Engine no  |" + LblEngineNo.Text + string.Empty.PadLeft(11 - Convert.ToInt32(LblEngineNo.Text.Length)) + "|Registration Date    |" + LblRegDate.Text  + "\\n";
        THC_Detail = THC_Detail + "|ChassisNo|" + LblChassisNo.Text + string.Empty.PadLeft(11 - Convert.ToInt32(LblChassisNo.Text.ToString().Length)) + "|Insurance Validity Date|" + LblInsValDt.Text + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";

        THC_Detail = THC_Detail + "|   Driver Name   "  + "|  License No   "  +"|  Validity Date  "  + "|   Issued by RTO   |"  + "\\n";
        THC_Detail = THC_Detail + "|" + string.Empty.PadLeft(3) + Lbldriver1.Text + string.Empty.PadLeft(14 - Convert.ToInt32(Lbldriver1.Text.ToString().Length)) + "|" + Lbldriver1lic.Text + string.Empty.PadLeft(15 - Convert.ToInt32(Lbldriver1lic.Text.ToString().Length)) + "|" + Lbldriver1valdt.Text + string.Empty.PadLeft(17 - Convert.ToInt32(Lbldriver1valdt.Text.ToString().Length)) + "|" + Lbldriver1RTO.Text + string.Empty.PadLeft(10) + "\\n";
        THC_Detail = THC_Detail + "|" + string.Empty.PadLeft(3) + Lbldriver2.Text + string.Empty.PadLeft(14 - Convert.ToInt32(Lbldriver2.Text.ToString().Length)) + "|" + Lbldriver2lic.Text + string.Empty.PadLeft(15 - Convert.ToInt32(Lbldriver2lic.Text.ToString().Length)) + "|" + Lbldriver2valdt.Text + string.Empty.PadLeft(17 - Convert.ToInt32(Lbldriver2valdt.Text.ToString().Length)) + "|" + Lbldriver2RTO.Text + string.Empty.PadLeft(10) + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";

        THC_Detail = THC_Detail + string.Empty.PadLeft(27) + "Advance Details" + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        THC_Detail = THC_Detail + "|StdConAmt   |" + lblStandardConAmt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblStandardConAmt.Text.ToString().Length)) + "|Con.Amt     |" + lblConAmt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblConAmt.Text.Length)) + "|TeleCharge|" + lblTeleCharges.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblTeleCharges.Text.Length)) + "\\n";
        THC_Detail = THC_Detail + "|Hamali(+/-) |" + lblHamali.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblHamali.Text.Length)) + "|Mamul       |" + lblMamul.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblMamul.Text.Length)) + "|TDSRate(%)|" + lblTDSRate.Text + "\\n";
        THC_Detail = THC_Detail + "|TDSAmt(-)   |" + lblTDSAmt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblTDSAmt.Text.Length)) + "|ServicTaxRat|" + lblServiceTaxRate.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblServiceTaxRate.Text.Length)) + "|PANNo     |" + lblPartyPANNo.Text + "\\n";
        THC_Detail = THC_Detail + "|ServicTax(+)|" + lblServiceTax.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblServiceTax.Text.Length)) + "|Cess(+)     |" + lblCess.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblCess.Text.ToString().Length)) + "\\n";
        THC_Detail = THC_Detail + "|TDS Type    |" + lblTDSType.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblTDSType.Text.Length)) + "|TDSDedFor   |" + lblTDSDedFor.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblTDSDedFor.Text.ToString().Length)) + "\\n";
        THC_Detail = THC_Detail + "|Advance Amt |" + lblAdvAmt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblAdvAmt.Text.Length)) + "|AdvAmtPaidBy|" + lblAdvAmtPaidBy.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblAdvAmtPaidBy.Text.ToString().Length)) + "\\n";
        THC_Detail = THC_Detail + "|Balance Amt |" + lblBalAmt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblBalAmt.Text.Length)) + "|BalPayableAt|" + lblBalPayableAt.Text + string.Empty.PadLeft(10 - Convert.ToInt32(lblBalPayableAt.Text.ToString().Length)) + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";

        THC_Detail = THC_Detail + string.Empty.PadLeft(27) + "Manifest Summary" + "\\n";
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        
        cnt = 1;
        conn.Close();
        strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT ,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno+thcsf ='" + thcno + "'";
        SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);

        
        conn.Open();
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        int ik = 1;

        THC_Detail = THC_Detail + "|SRNo" + "|   ManifestNo   " + "|ManualMFNo" + "| From-To |" + "NoOfDkt|" + " Pakage(L/B) |" + " Weight(L/B) |" + "\\n";
        while (dr.Read())
        {
            //string totActualWt = dr["TOT_LOAD_ACTWT"].ToString() + "/" + dr["TOT_ACTUWT"].ToString();
            //if (Convert.ToInt32(totActualWt.Length) > 8)
            //{
            //    totActualWt = totActualWt.Substring(0, 7);
            //}

            //string totActualWt = dr["TOT_LOAD_ACTWT"].ToString() + "/" + dr["TOT_ACTUWT"].ToString();
            //if (Convert.ToInt32(totActualWt.Length) > 8)
            //{
            //    totActualWt = totActualWt.Substring(0, 7);
            //}

            THC_Detail = THC_Detail + "|" + cnt + string.Empty.PadLeft(3) + "|" + string.Empty.PadLeft(0) + dr["TCNO"].ToString() + string.Empty.PadLeft(20 - Convert.ToInt32(dr["TCNO"].ToString().Length)) + "|" + dr["manual_tcno"].ToString() + string.Empty.PadLeft(10 - Convert.ToInt32(dr["manual_tcno"].ToString().Length)) + "|" + dr["fromto"].ToString() + string.Empty.PadLeft(09 - Convert.ToInt32(dr["fromto"].ToString().Length)) + "|" + dr["TOT_DKT"].ToString() + string.Empty.PadLeft(7 - Convert.ToInt32(dr["TOT_DKT"].ToString().Length)) + "|" + dr["TOT_LOAD_PKGS"].ToString() + "/" + dr["TOT_PKGS"].ToString() + string.Empty.PadLeft(06 - Convert.ToInt32(dr["TOT_LOAD_PKGS"].ToString().Length) + Convert.ToInt32(dr["TOT_PKGS"].ToString().Length)) + "|" + dr["TOT_LOAD_ACTWT"].ToString() + "/" + dr["TOT_ACTUWT"].ToString() + "\\n";
            cnt = cnt + 1;
        }
        THC_Detail = THC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        THC_Detail = THC_Detail + "|   Staff Name   " + "|    Sign    " + "| Prepared by   " + "|    At    " + "| Entry Date & Time |" + "\\n";
        THC_Detail = THC_Detail + "|" + string.Empty.PadLeft(16) + "|" + string.Empty.PadLeft(12) + "|" + lblPreparedBy.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblPreparedBy.Text.ToString().Length)) + "|" + string.Empty.PadLeft(10) + "|" + lblEntryDtandTime.Text + string.Empty.PadLeft(19 - Convert.ToInt32(lblEntryDtandTime.Text.ToString().Length)) + "|" + "\\n";
        THC_Detail = "objPrint.Print_Line('" + THC_Detail + "');";
        dr.Close();
    }

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
