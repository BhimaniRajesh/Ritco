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
public partial class ChiragDesing_thcprintview_new : System.Web.UI.Page
{
    string thcno,strqry;
    SqlConnection cn;
    Int32 t1, t2, t3;
    decimal t4,t5;
    Int32 m1, m2, m3, m4, m5, m6;
    protected void Page_Load(object sender, EventArgs e)
    {
        //cn.ConnectionString = "Data Source=202.87.45.69;Initial Catalog=WebXpress_New;UID=sa;pwd=!@ECfy#$";
        t5 = t4 = 0.0M;
        t1 = t2 = t3 = m1 = m2 = m3 = m4 = m5 = m6= 0; 
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpress_New;UID=sa;pwd=!@ECfy#$");
        //thcno = "BLR_/THC/0004975.";
        thcno = Request.QueryString["tcno"];
        strqry = "Select top 1  e.Name,convert(varchar,thcdt,106) as thcdt_new,t.*,advamt,(select locname from webx_location where loccode=sourcehb) as location,(select top 1  ManualTHCNo from  webx_thc_summary where thcno=thcno)as MTHCNo,(select locname from webx_location where loccode=tobh_code) as nextstop from vw_ThcHdr_New t with (NOLOCK) , webx_master_users e with (NOLOCK) where t.THCNEW_entryby*=e.UserID and  THCNO = '" + thcno + "' order by actdept_dt desc";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, cn);
        cn.Open();
        dr = cmd.ExecuteReader();
        dr.Read();
        LblTHCNo.Text = thcno;
        LblTHCDt.Text = Convert.ToString(dr["thcdt_new"]);
        LblTHCUpdateOn.Text = Convert.ToString(dr["thcdt_new"]);
        LblMTHCNo.Text = Convert.ToString(dr["MTHCNo"] == System.DBNull.Value ? "-" : dr["MTHCNo"]);
        //string qry = "select  ManualTHCNo from  webx_thc_summary where thcno+thcsf='" & thcno & "'";
        LblRoute.Text = Convert.ToString(dr["routecd"]) +" : "+ Convert.ToString(dr["routename"]);
        //if ((dr[10] == System.DBNull.Value) || (Convert.ToString(dr[10]) == ""))
        //{
        //}
        //else
        //{
        //}
        if (dr["rut_cat"] != System.DBNull.Value)
        {
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
        }
        else 
        {
            lblTHCMode.Text = "-"; 
        }
        LblCurLoc.Text = Convert.ToString(dr["sourcehb"]) + ":" + Convert.ToString(dr["location"]);
        LblNxtStop.Text = Convert.ToString(dr["tobh_code"] == System.DBNull.Value ? "THC Arrived at " + Convert.ToString(dr["sourcehb"]) + " : " + Convert.ToString(dr["location"]) + "" : Convert.ToString(dr["tobh_code"]) + " : " + Convert.ToString(dr["nextstop"]));
        LblPreparedBy.Text = Convert.ToString(dr["thcnew_entryby"]) + " : " + Convert.ToString(dr["empnm"]);
        LblAt.Text = Convert.ToString(dr["thcbr"]);
        if (dr["thcdt"] != System.DBNull.Value)
        {
            LblDatetime.Text = Convert.ToDateTime(dr["thcdt"]).ToString("dd-MMM-yyyy hh:mm:ss");
        }
        dr.Close();

        cmd = new SqlCommand("Select *,vendor_name,advamt,(select vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code) as vendor_type,(select [type_name] as type_name1 from webx_VENDOR_TYPE where Type_code=(select vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype from vw_thc_summary t with(NOLOCK) where THCNO='" + thcno + "'", cn);
        dr = cmd.ExecuteReader();
        dr.Read();
        LblVehNO.Text = Convert.ToString(dr["vehno"]);
        LblRegDate.Text = Convert.ToString(dr["vehregdt"]);
        if (LblRegDate.Text == "1/1/1900 12:00:00 AM")
        {
            LblRegDate.Text = ""; 
        }
        LblChassisNo.Text = Convert.ToString(dr["chasisno"]);
        LblVehType.Text = Convert.ToString(dr["type_of_vehicle"]);
        LblInsValDt.Text = Convert.ToString(dr["veh_insurance"]);
        if (LblInsValDt.Text == "1/1/1900 12:00:00 AM")
        {
            LblInsValDt.Text = "";
        }
        LblEngineNo.Text = Convert.ToString(dr["engineno"]);
        LblFitValDt.Text = Convert.ToString(dr["fitness_certdt"]);
        if (LblFitValDt.Text == "1/1/1900 12:00:00 AM")
        {
            LblFitValDt.Text = "";
        }
        LblAdvAmt.Text = Convert.ToString(dr["advamt"]);
        LblAdvPaidBy.Text = Convert.ToString(dr["advpaidby"]);
        Lbldriver1.Text = Convert.ToString(dr["driver1"]);
        Lbldriver1lic.Text = Convert.ToString(dr["driver1licno"]);
        Lbldriver1valdt.Text = Convert.ToDateTime(dr["driver1licvaldt"]).ToString("dd-MMM-yyyy");
        Lbldriver1RTO.Text = Convert.ToString(dr["driverrto1"]);
        if ((dr["driver2"] != System.DBNull.Value) && (Convert.ToString(dr["driver2"]) != ""))
        {
            Lbldriver2.Text = Convert.ToString(dr["driver2"]);
            Lbldriver2lic.Text = Convert.ToString(dr["driver2licno"]);
            Lbldriver2valdt.Text = Convert.ToDateTime(dr["driver2licvaldt"]).ToString("dd-MMM-yyyy");
            Lbldriver2RTO.Text = Convert.ToString(dr["driverrto2"]);
        }
        LblVendorName.Text = Convert.ToString(dr["vendor_code"]) + " : " + Convert.ToString(dr["vendor_name"]);
        LblVendorType.Text = Convert.ToString(dr["vtype"]); 
        dr.Close();
        BindIncomingOutgoing();
        BindProfitAnalysis();
        BindManifestLoadedAt();
        BindManifestMovment();
        //GrdManifestMovment
        //strqry = "select Manual_tcno from webx_tchdr where tcno='" + LblTHCNo.Text + "'";
        //cmd = new SqlCommand(strqry, cn);
        //lblMMFNo.Text = (cmd.ExecuteScalar() == System.DBNull.Value ? "" : lblMMFNo.Text);
        //strqry = "Select TCNO,dockno,Payment_Basis,BookingDate,ORGNCD,DESTCD,C_DelyDate,Cnor_Name,Pkgs_LB,ActualWt_LB,cnee_name,(select freight from webx_docket_charges where webx_docket_charges.dockno=vw_MF_View_Print.dockno)as Freight From vw_MF_View_Print Where TCNo='" + mfno + "'";
        //SqlDataAdapter da = new SqlDataAdapter(strqry, cn);
        //DataSet ds = new DataSet();
        //da.Fill(ds, "manifest");
        //GrdPaidFollow.DataSource = ds.Tables["manifest"];
        //GrdPaidFollow.DataBind();
        //strqry = "Select TCNO,Cast(SUM(LOADPKGSNO) As varchar) + '/'+ Cast(IsNull(SUM(PKGSNO),0) As Varchar) As Grand_Pkgs,Cast(SUM(LOADACTUWT) As varchar) + '/'+ Cast(IsNull(SUM(ACTUWT),0) As Varchar) As Grand_Pkgs From vw_MF_View_Print with(NOLOCK) Where TCNo='" + mfno + "' Group By TCNO ";
        //cmd = new SqlCommand(strqry, cn);
        //dr = cmd.ExecuteReader();
        //dr.Read();
        //GrdPaidFollow.FooterRow.Cells[7].Text = Convert.ToString(dr[1]);
        //GrdPaidFollow.FooterRow.Cells[8].Text = Convert.ToString(dr[2]);
        //GrdPaidFollow.FooterRow.Cells[9].Text = Convert.ToString(d);
        //GrdPaidFollow.FooterRow.CssClass = "blackfnt";
        //GrdPaidFollow.FooterRow.HorizontalAlign = HorizontalAlign.Center;
        //dr.Close(); 
    }
    protected void BindManifestMovment()
    {
        SqlDataAdapter da = new SqlDataAdapter("select TCBR,ToBH_Code,TCBR + '-' + ToBH_Code as fromto,count(*) as TCCNTR,sum(TOT_DKT) as TOTDKT,SUM(TOT_PKGS) as TOTPKGS,sum(TOT_ACTUWT) as TOTACTUWT from vw_TcHdr_New with(NOLOCK) where thcno='"+ thcno +"'  group by TCBR, ToBH_Code,TCBR + '-' + ToBH_Code", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "ManifestMovment");
        DataColumn dc = new DataColumn("sourcehb", typeof(string));
        DataColumn dc1 = new DataColumn("ld_tc", typeof(Int32));
        DataColumn dc2 = new DataColumn("ul_tc", typeof(Int32));
        ds.Tables["ManifestMovment"].Columns.Add(dc);
        ds.Tables["ManifestMovment"].Columns.Add(dc1);
        ds.Tables["ManifestMovment"].Columns.Add(dc2);
        DataRow dr;
        for (int i = 0; i < ds.Tables["ManifestMovment"].Rows.Count; i++)
        {
            dr = ds.Tables["ManifestMovment"].Rows[i];
            SqlDataReader dreader;
            SqlCommand cmd = new SqlCommand("select ld_tc,ul_tc,sourcehb from vw_thchdr_new with(NOLOCK) where thcno='" + thcno + "' and sourcehb='" + Convert.ToString(dr["tobh_code"]) + "'", cn);
            dreader = cmd.ExecuteReader();
            if (dreader.Read() == true)
            {
                dr["sourcehb"] = Convert.ToString(dreader["sourcehb"] == System.DBNull.Value ? "" : dreader["sourcehb"]);
                dr["ld_tc"] = Convert.ToInt32(dreader["ld_tc"] == System.DBNull.Value ? 0 : dreader["ld_tc"]);
                dr["ul_tc"] = Convert.ToInt32(dreader["ul_tc"] == System.DBNull.Value ? 0 : dreader["ul_tc"]);
            }
            dreader.Close();  
        }
        GrdManifestMovment.DataSource = ds.Tables["ManifestMovment"];
        GrdManifestMovment.DataBind();
        GrdManifestMovment.FooterRow.Cells[0].Text = "Total";
        GrdManifestMovment.FooterRow.Cells[0].Font.Bold = true;
        GrdManifestMovment.FooterRow.Cells[1].Text = Convert.ToString(m1);
        GrdManifestMovment.FooterRow.Cells[2].Text = Convert.ToString(m2);
        GrdManifestMovment.FooterRow.Cells[3].Text = Convert.ToString(m3);
        GrdManifestMovment.FooterRow.Cells[4].Text = Convert.ToString(m4);
        GrdManifestMovment.FooterRow.Cells[7].Text = Convert.ToString(m5);
        GrdManifestMovment.FooterRow.Cells[8].Text = Convert.ToString(m6);
        GrdManifestMovment.FooterRow.CssClass = "blackfnt";  

    }
    protected void BindIncomingOutgoing()
    {
        SqlDataAdapter da = new SqlDataAdapter("select sourcehb,(select locname from webx_location where loccode=sourcehb)as location,thc_inrem,thc_outrem from vw_ThcHdr_New with(NOLOCK) where thcno='" + thcno + "' order by actdept_dt", cn);
        DataSet ds= new DataSet() ;
        da.Fill(ds, "ICOG");
        GrdPaidFollow.DataSource = ds.Tables["ICOG"];
        GrdPaidFollow.DataBind();  
    }
    protected void BindProfitAnalysis()
    {
        SqlDataAdapter da = new SqlDataAdapter("select sum(d.freight) as Total_freight,sum(actuwt_in) as Total_wt, (sum(d.freight)/sum(actuwt_in)) as frt_per_kg from webx_dkt_track n with(NOLOCK) ,webx_docket_charges d with(NOLOCK)   where n.thcno='" + thcno + "'  and d.dockno=n.dockno ", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "ProfitAnalysis");
        GrdProfitAnalysis.DataSource = ds.Tables["ProfitAnalysis"];
        GrdProfitAnalysis.DataBind();
    }
    protected void BindManifestLoadedAt()
    {
        SqlDataAdapter da = new SqlDataAdapter("select TCNO ,TCBR,ToBH_Code,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno='" + thcno + "' ", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "ManifestLoaded");
        GrdManifestLoaded.DataSource = ds.Tables["ManifestLoaded"];
        GrdManifestLoaded.DataBind();
        GrdManifestLoaded.FooterRow.Cells[0].Text = "Total";
        GrdManifestLoaded.FooterRow.Cells[0].Font.Bold = true;     
        GrdManifestLoaded.FooterRow.Cells[4].Text = Convert.ToString(t1);
        GrdManifestLoaded.FooterRow.Cells[5].Text = Convert.ToString(t2) + " / " + Convert.ToString(t3);
        GrdManifestLoaded.FooterRow.Cells[6].Text = Convert.ToString(t4) + " / " + Convert.ToString(t5);
        //GrdManifestLoaded.FooterRow.Cells[7].Text = Convert.ToString(t5) + " / " + Convert.ToString(t6);
        GrdManifestLoaded.FooterRow.CssClass = "blackfnt";  
    }
   
    Label l1, l2, l3, l4, l5;
    protected void GrdManifestLoaded_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            l1 = (Label)e.Row.FindControl("lbl1");
            l2 = (Label)e.Row.FindControl("lbl2");
            l3 = (Label)e.Row.FindControl("lbl3");
            l4 = (Label)e.Row.FindControl("lbl4");
            l5 = (Label)e.Row.FindControl("lbl5");

            if ((l1.Text != "") && (l1.Text != System.DBNull.Value.ToString()))
            {
                t1 += Convert.ToInt32(l1.Text);
            }

            if ((l2.Text != "") && (l2.Text != System.DBNull.Value.ToString()))
            {
                t2 += Convert.ToInt32(l2.Text);
            }

            if ((l3.Text != "") && (l3.Text != System.DBNull.Value.ToString()))
            {
                t3 += Convert.ToInt32(l3.Text);
            }

            if ((l4.Text != "") && (l4.Text != System.DBNull.Value.ToString()))
            {
                t4 += Convert.ToDecimal(l4.Text);
            }

            if ((l5.Text != "") && (l5.Text != System.DBNull.Value.ToString()))
            {
                t5 += Convert.ToDecimal(l5.Text);
            }
        }
    }

    protected void GrdManifestMovment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        m1 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TCCNTR") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "TCCNTR"));
        m2 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TOTDKT") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "TOTDKT"));
        m3 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TOTPKGS") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "TOTPKGS"));
        m4 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TOTACTUWT") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "TOTACTUWT"));
        m5 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ld_tc") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "ld_tc"));
        m6 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ul_tc") == System.DBNull.Value ? 0 : DataBinder.Eval(e.Row.DataItem, "ul_tc"));
    }
}
