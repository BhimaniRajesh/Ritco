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

public partial class GUI_Operations_TCS_PrintTCS_FrmMenifestView : System.Web.UI.Page
{
    string mfno, strqry;
    SqlConnection cn;
    decimal d;
    protected void Page_Load(object sender, EventArgs e)
    {
		hdnContainerName.Value = ConfigurationManager.AppSettings["SOPContainerName"].ToString();
        d = 0.0M;
        cn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
        string logo = "WebXpress_logo.gif";
        imgLogo.ImageUrl = "~/GUI/images/" + logo;
        mfno = Request.QueryString["MFNo"];
        string[] Split = mfno.Split(new Char[] { ',' });
        mfno = Convert.ToString(Split[0]);
        mfno = mfno.Replace('.', ' ');
        string print_yn = Convert.ToString(Split[1]);
        strqry = "Select convert(varchar,T.TCDT,6) as MF_Date,T.TCBR,T.route_code as Route,T.THCBR,T.THCNO,T.VEHNO,convert(varchar,T.thcdt,6)+' '+convert(varchar,T.thcdt,108) as THC_Date,T.tobh_code as TOHUB_BR,T.TCBR,T.TCBR + '-' + T.ToBH_Code as  fromto,(select top 1 rutnm from webx_rutmas with(NOLOCK) where rutcd=t.route_code) as rutnm ,T.EntryBy,e.Name,T.tcdt as mf_dt,(select top 1  LocCode+' : '+LocName from webx_location where loccode=t.tcbr)as Location,ts.routename From VW_tchdr_new t with(NOLOCK)  left outer join webx_master_users e with(NOLOCK)  on t.Entryby=e.UserId left outer join webx_thc_summary ts with(NOLOCK)  on ts.thcno=t.thcno Where TCNo='" + mfno.Trim() + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, cn);
        cmd.Connection.Open();
        dr = cmd.ExecuteReader();
        dr.Read();
        lblMFNo.Text = mfno;
        lblMFDate.Text = Convert.ToString(dr[0]);
        LblMFLocation.Text = Convert.ToString(dr[1]);
        LblNextLocation.Text = Convert.ToString(dr[7]);
        LblRoute.Text = Convert.ToString(dr["routename"]);
        LblTHCNo.Text = Convert.ToString(dr[4]);
        LblFromTo.Text = Convert.ToString(dr[9]);
        LblTHCDate.Text = Convert.ToString(dr[6]);
        LblTHCLocation.Text = Convert.ToString(dr[3]);
        LblVehicle.Text = Convert.ToString(dr[5]);
        LblStaffName.Text = Convert.ToString(dr[11]) + ":" + Convert.ToString(dr[12]);
        LblPreparedBy.Text = Convert.ToString(dr["EntryBy"]) + ":" + Convert.ToString(dr["Name"]);
        LblAt.Text = "HQTR" + " - " + System.DateTime.Now.ToString("dd MMM yy");
        lblPreparedAt.Text = Convert.ToString(dr[14]) + " - " + lblMFDate.Text;
        dr.Close();
        cmd.Connection.Close();
        cn.Open();
        strqry = "select  Manual_tcno from webx_tchdr where tcno='" + LblTHCNo.Text + "'";
        cmd = new SqlCommand(strqry, cn);
        lblMMFNo.Text = (cmd.ExecuteScalar() == System.DBNull.Value ? "" : lblMMFNo.Text);
        strqry = "Select (select top 1 codedesc from webx_master_general where codetype='Trn' and codeid=(select top 1 trn_mod from webx_master_docket where dockno=m.DockNo))+' - '+ (select top 1 codedesc from webx_master_general where codetype='SVCTYP' and codeid=(select top 1 service_class from webx_master_docket where dockno=m.DockNo))as Mode,docksf,(select top 1 from_loc+' - '+to_loc from webx_master_docket where dockno=m.dockno)LocationTo,m.TCNO,m.dockno,m.Payment_Basis,m.BookingDate,m.ORGNCD+ ' - ' +m.DESTCD as Location,m.C_DelyDate,m.Cnor_Name,m.Pkgs_LB,convert(varchar,m.ActualWt_LB)+' - '+convert(varchar,(select top 1 (case when paybas='P03' and docksf='.' then cast(DKTTOT as decimal(9,2)) else '0.00' end) from WebX_Master_Docket_Charges where dockno=m.dockno)) as Freight,m.cnee_name,(select top 1 (case when paybas='P03' and docksf='.' then cast(DKTTOT as decimal(9,2)) else '0.00' end) from WebX_Master_Docket_Charges where dockno=m.dockno) as Freight1,privatemark,invno,invamt, PackaginType=(select codedesc from webx_master_general where codetype like 'PKGS' and codeid=m.pkgsty), Contents=(select codedesc from webx_master_general where codetype like 'PROD' and codeid=m.prodcd),POD  From vw_MF_View_Print m,VW_tchdr_new t where m.TCNo=t.TCNo and m.tcno='" + mfno + "' ORDER BY m.dockno asc";
        SqlDataAdapter da = new SqlDataAdapter(strqry, cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "manifest");
        GrdPaidFollow.DataSource = ds.Tables["manifest"];
        GrdPaidFollow.DataBind();
        //strqry = "select distinct top 1 H.TCNO,(Cast((H.TOT_PKGS) As varchar) + '/'+ Cast((H.TOT_LOAD_PKGS) As varchar)) As Grand_Pkgs,(cast((H.TOT_ACTUWT) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT) As varchar) ) As Grand_weight From Webx_TCTRN T with(NOLOCK) INNER JOIN Webx_TCHDR H with(NOLOCK) on T.TCNO=H.TCNO INNER JOIN WebX_Master_Docket D with(NOLOCK) on T.dockno=D.dockno Where H.TCNo='" + mfno + "' and T.dockno=D.dockno Group By H.TCNO,H.TOT_PKGS,H.TOT_LOAD_PKGS,H.TOT_ACTUWT,H.TOT_LOAD_ACTWT";
        //strqry = "select distinct top 1 H.TCNO,(Cast((H.TOT_PKGS) As varchar) + '/'+ Cast((H.TOT_LOAD_PKGS) As varchar)) As Grand_Pkgs,(cast((H.TOT_ACTUWT+isNULL(WTADJ,0)) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT+isNULL(WTADJ,0)) As varchar) ) As Grand_weight From Webx_TCTRN T with(NOLOCK) INNER JOIN Webx_TCHDR H with(NOLOCK) on T.TCNO=H.TCNO INNER JOIN WebX_Master_Docket D with(NOLOCK) on T.dockno=D.dockno Where H.TCNo='" + mfno + "' and T.dockno=D.dockno Group By H.TCNO,H.TOT_PKGS,H.TOT_LOAD_PKGS,H.TOT_ACTUWT,H.TOT_LOAD_ACTWT,WTADJ";
        //strqry = "select distinct top 1 WTADJ_PM,H.TCNO,(Cast((H.TOT_PKGS) As varchar) + '/'+ Cast((H.TOT_LOAD_PKGS) As varchar)) As Grand_Pkgs,(Case when WTADJ_PM = '+' then (cast((SUM(T.LOADACTUWT)+isNULL(WTADJ,0)) As varchar) + '/'+ cast((SUM(D.CHRGWT)+isNULL(WTADJ,0)) As varchar)) when WTADJ_PM = '-' then (cast((SUM(T.LOADACTUWT)-isNULL(WTADJ,0)) As varchar) + '/'+ cast((SUM(D.CHRGWT)-isNULL(WTADJ,0)) As varchar)) else (cast((H.TOT_ACTUWT) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT) As varchar)) end ) As Grand_weight From Webx_TCTRN T with(NOLOCK) INNER JOIN Webx_TCHDR H with(NOLOCK) on T.TCNO=H.TCNO INNER JOIN WebX_Master_Docket D with(NOLOCK) on T.dockno=D.dockno Where H.TCNo='" + mfno + "' and T.dockno=D.dockno Group By H.TCNO,H.TOT_PKGS,H.TOT_LOAD_PKGS,H.TOT_ACTUWT,H.TOT_LOAD_ACTWT,WTADJ,WTADJ_PM";
        strqry = "select distinct top 1 WTADJ_PM,H.TCNO,(Cast((H.TOT_PKGS) As varchar) + '/'+ Cast((H.TOT_LOAD_PKGS) As varchar)) As Grand_Pkgs,(Case when WTADJ_PM = '+' then (cast((SUM(T.LOADACTUWT)+isNULL(WTADJ,0)) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT+isNULL(WTADJ,0)) As varchar)) when WTADJ_PM = '-' then (cast((SUM(T.LOADACTUWT)-isNULL(WTADJ,0)) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT-isNULL(WTADJ,0)) As varchar)) else (cast((H.TOT_ACTUWT) As varchar) + '/'+ cast((H.TOT_LOAD_ACTWT) As varchar)) end ) As Grand_weight From Webx_TCTRN T with(NOLOCK) INNER JOIN Webx_TCHDR H with(NOLOCK) on T.TCNO=H.TCNO INNER JOIN WebX_Master_Docket D with(NOLOCK) on T.dockno=D.dockno Where H.TCNo='" + mfno + "' and T.dockno=D.dockno Group By H.TCNO,H.TOT_PKGS,H.TOT_LOAD_PKGS,H.TOT_ACTUWT,H.TOT_LOAD_ACTWT,WTADJ,WTADJ_PM";
        cmd = new SqlCommand(strqry, cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            GrdPaidFollow.FooterRow.Cells[7].Text = Convert.ToString(dr[2]);
            GrdPaidFollow.FooterRow.Cells[8].Text = Convert.ToString(dr[3]) + " - " + Convert.ToString(d);
            GrdPaidFollow.FooterRow.CssClass = "blackfnt";
            GrdPaidFollow.FooterRow.HorizontalAlign = HorizontalAlign.Center;
        }
        dr.Close();


        strqry = "select L.LocAddr,L.LocSTDCode,L.LocTelno,L.LocPinCode, CG.GSTINNumber from webx_Location L WITH(NOLOCK) INNER JOIN Webx_Master_CompanyGST CG WITH(NOLOCK) ON CG.BillingStateCode = L.LocState where Loccode='" + LblMFLocation.Text + "'";
        cmd = new SqlCommand(strqry, cn);


        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            txtLocAddress.Text = "<b>Address : </b>" + dr["LocAddr"].ToString();

            lblGstNo.Text = "<b>GST No. : </b>" + dr["GSTINNumber"].ToString();
            lblPhone.Text = "<b>Phone : </b>" + dr["LocSTDCode"].ToString() + '-' + dr["LocTelno"].ToString();
        }
        dr.Close();

    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        //BindTheData();
        //GrdPaidFollow.DataBind(); 
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        d = d + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "freight1") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "freight1"));

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnPOD = (HiddenField)e.Row.FindControl("hdnPOD");
            Label lblPOD = (Label)e.Row.FindControl("lblPOD");
            HiddenField hdnPODRejected = (HiddenField)e.Row.FindControl("hdnPODRejected");

            if (hdnPOD.Value != "" && hdnPOD.Value != "NA")
            {
                lblPOD.Text = "View";
            }
            else {
                lblPOD.Text = "NA";
            }

        }
    }
}
