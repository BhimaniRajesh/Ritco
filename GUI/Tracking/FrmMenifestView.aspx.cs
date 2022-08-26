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
        //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=TLL.NET;");
        d = 0.0M;
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //mfno = Request.QueryString["MFNo"];
        mfno = Request.QueryString["tcno"];
        //mfno = "BLR_/MF/0000008";
        strqry = "Select Distinct convert(varchar,TCDT,6) as MF_Date,TCBR,route_code as Route,THCBR,THCNO,VEHNO,convert(varchar,thcdt,6) as THC_Date,tobh_code as TOHUB_BR,TCBR,TCBR + '-' + ToBH_Code as  fromto,(select rutnm from webx_rutmas with(NOLOCK) where rutcd=t.route_code) as rutnm ,e.EntryBy,e.Name,tcdt as mf_dt,(select LocCode+' : '+LocName from webx_location where loccode=t.tcbr)as Location From VW_tchdr_new t with(NOLOCK)  left outer join webx_master_users e with(NOLOCK)  on t.Entryby=e.UserId Where TCNo='" + mfno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, cn);
        cmd.Connection.Open();
        dr = cmd.ExecuteReader();
        dr.Read();
        lblMFNo.Text = mfno;
        lblMFDate.Text = Convert.ToString(dr[0]);
        LblMFLocation.Text = Convert.ToString(dr[1]);
        LblNextLocation.Text = Convert.ToString(dr[7]);
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
        LblTHCDate.Text = Convert.ToString(dr[6]);
        LblTHCLocation.Text = Convert.ToString(dr[3]);
        LblVehicle.Text = Convert.ToString(dr[5]);
        LblPreparedBy.Text = Convert.ToString(dr[11]) + ":" + Convert.ToString(dr[12]);
        //LblAt.Text = Convert.ToString(dr[1]) + " / " + Convert.ToDateTime(dr[13]).ToString("dd MMM yy hh:mm");
        //LblDateTime.Text = Convert.ToDateTime(dr[13]).ToString("dd MMM yy hh:mm");//Convert.ToString(dr[13]);
        lblPreparedAt.Text = Convert.ToString(dr[14]) + " - " + lblMFDate.Text;
        dr.Close();
        cmd.Connection.Close();
        cn.Open();
        strqry = "select  Manual_tcno from webx_tchdr where tcno='" + LblTHCNo.Text + "'";
        cmd = new SqlCommand(strqry, cn);
        lblMMFNo.Text = (cmd.ExecuteScalar() == System.DBNull.Value ? "" : lblMMFNo.Text);
        //strqry = "Select (select from_loc+' - '+to_loc from webx_master_docket where dockno=vw_MF_View_Print.dockno)LocationTo,TCNO,dockno,Payment_Basis,BookingDate,ORGNCD+ ' - ' +DESTCD as Location,C_DelyDate,Cnor_Name,Pkgs_LB,convert(varchar,ActualWt_LB)+' -- '+convert(varchar,(select freight from WebX_Master_Docket_Charges where WebX_Master_Docket_Charges.dockno=vw_MF_View_Print.dockno)) as Freight,cnee_name,(select freight from WebX_Master_Docket_Charges where WebX_Master_Docket_Charges.dockno=vw_MF_View_Print.dockno) as Freight1 From vw_MF_View_Print Where TCNo='" + mfno + "'";
        strqry = "Select distinct (select codedesc from webx_master_general where codetype='Trn' and codeid=(select trn_mod from webx_master_docket where dockno=m.DockNo))+' - '+ (select codedesc from webx_master_general where codetype='SERVTY' and codeid=(select service_class from webx_master_docket where dockno=m.DockNo))as Mode,(select from_loc+' - '+to_loc from webx_master_docket where dockno=m.dockno)LocationTo,m.TCNO,m.dockno,m.Payment_Basis,m.BookingDate,m.ORGNCD+ ' - ' +m.DESTCD as Location,m.C_DelyDate,m.Cnor_Name,m.Pkgs_LB,convert(varchar,m.ActualWt_LB)+' - '+convert(varchar,(select cast(SubTotal as decimal(9,2)) from WebX_Master_Docket_Charges where dockno=m.dockno)) as Freight,m.cnee_name,(select cast(SubTotal as decimal(9,2)) from WebX_Master_Docket_Charges where dockno=m.dockno) as Freight1 From vw_MF_View_Print m,VW_tchdr_new t where m.TCNo=t.TCNo and m.tcno='" + mfno + "'";
        
        SqlDataAdapter da = new SqlDataAdapter(strqry, cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "manifest");
        GrdPaidFollow.DataSource = ds.Tables["manifest"];
        GrdPaidFollow.DataBind();
        strqry = "Select TCNO,Cast(SUM(LOADPKGSNO) As varchar) + '/'+ Cast(IsNull(SUM(PKGSNO),0) As Varchar) As Grand_Pkgs,Cast(SUM(LOADACTUWT) As varchar) + '/'+ Cast(IsNull(SUM(ACTUWT),0) As Varchar) As Grand_Pkgs From vw_MF_View_Print with(NOLOCK) Where TCNo='" + mfno + "' Group By TCNO ";
        cmd = new SqlCommand(strqry, cn);
        dr = cmd.ExecuteReader();
        dr.Read();
        GrdPaidFollow.FooterRow.Cells[8].Text = Convert.ToString(dr[1]);
        GrdPaidFollow.FooterRow.Cells[9].Text = Convert.ToString(dr[2]) + " - " + Convert.ToString(d);
        //GrdPaidFollow.FooterRow.Cells[10].Text = Convert.ToString(d);
        GrdPaidFollow.FooterRow.CssClass = "blackfnt";
        GrdPaidFollow.FooterRow.HorizontalAlign = HorizontalAlign.Center;
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
    }
}
