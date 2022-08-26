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

public partial class GUI_Operations_THC_ViewPrint_thcprintview_new : System.Web.UI.Page
{
    string thcno, strqry,strManifestquery;
    SqlConnection conn;
    Int32 t1, t2, t3;
    decimal t4, t5;
    Int32 m1, m2, m3, m4, m5, m6;
    public static string st_rutcd, st_rutcat, st_thcno, lng;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        thcno = Request.QueryString["tcno"];
        strqry = "Select balamtbrcd,Hedu_Cess,advamt,advpaidby,tds_rate,tds_chrg,pan_no,tds_acccode,mamul_chrg,load_chrg,tds_accdesc,tdsgrpcode,tdsgrpdesc,tdsfor,svrcamt,cessamt,netbalamt,svrc_rate,pcamt,tel_chrg,thcno,CONVERT(varchar,thcdt,6) as thcdt,manualthcno,routecd,routename,rut_cat,sourcehb,tobh_code,vendor_name,advamt,vendor_code,Payload=isnull((case when isnull(Payload,0)>0 then Payload*1000 end),0),advpaidby,driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype ,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where type_code=Vehicle_type),FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),reg_date=CONVERT(varchar,t.vehregdt,06),act_dept_time=(convert(varchar,actdept_dt,6)+' '+actdept_tm ),OPENKM,aech_dept_time=(convert(varchar,sehedept_dt,6)+' '+schedept_tm ),LateDeptReason=(select top 1 codedesc as type_name1 from webx_master_general where codetype='LATE_D' and codeid=LateDeptReason),CHASISNO,engineno,sealno_out,THCNEW_ENTRYBY=(select name from webx_master_users where UserId =THCNEW_ENTRYBY), THCNEW_ENTRYDT=(convert(varchar,THCNEW_ENTRYDT,6)+' '+convert(varchar,THCNEW_ENTRYDT,108) ) from webx_thc_summary t with(NOLOCK) left outer join webx_vehicle_hdr V with(NOLOCK)on t.Vehno=v.vehno where THCNO+thcsf ='" + thcno + "'";
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
            Lbldriver1.Text = dr["driver1"].ToString();
            Lbldriver1lic.Text = dr["driver1licno"].ToString();
            Lbldriver1valdt.Text = dr["dr1Valdt"].ToString();
            Lbldriver1RTO.Text = dr["driverrto1"].ToString();
            Lbldriver2.Text = dr["driver2"].ToString();
            Lbldriver2lic.Text = dr["driver2licno"].ToString();
            Lbldriver2valdt.Text = dr["dr2Valdt"].ToString();
            Lbldriver2RTO.Text = dr["driverrto2"].ToString();
           
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

            //lblStaffname.Text = dr[""].ToString();
            //lblSign.Text = dr[""].ToString();
            lblPreparedBy.Text = dr["THCNEW_ENTRYBY"].ToString();
            //lblAt.Text = dr[""].ToString();
            lblEntryDtandTime.Text = dr["THCNEW_ENTRYDT"].ToString();
            
        }
        dr.Close();
        conn.Close();

        BindManifestMovment();
    }

    private void BindManifestMovment()
    {
        strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno+thcsf ='" + thcno + "'";
        SqlCommand sqlcmd = new SqlCommand(strManifestquery,conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GrdManifest.DataSource = ds;
        GrdManifest.DataBind();
    }
}
