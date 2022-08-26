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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_Crossing_ViewCrossingChallan : System.Web.UI.Page
{
    public string CrossingChallanNo;
    double pkgs = 0.0, weight = 0.0, ToPay = 0.0, varCrossing = 0.0, varDDC = 0.0, Bulky = 0.0, NetAmt = 0.0, SvcTax = 0.00, TotSvcTax = 0.00;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CrossingChallanNo = Convert.ToString(Request.QueryString["CrossingChallanNo"]);
            string[] Split = CrossingChallanNo.Split(new Char[] { ',' });
            CrossingChallanNo = Convert.ToString(Split[0]);
            lblCrossChallanNo.Text = CrossingChallanNo;
            string print_yn = Convert.ToString(Split[1]);

            BindGrid();

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql = "select Convert(varchar,ChallanDate,06) as ChallanDate,* from Webx_Crossing_Docket_Master where CrossingChallanNo='" + CrossingChallanNo + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                lblVoucherDt.Text = Convert.ToString(dr["ChallanDate"]);
                lblChallanLocation.Text = Convert.ToString(dr["ChallanLocCode"]);
                lblVehicleEntry.Text = Convert.ToString(dr["VehicleNo"]);
                lblVendor.Text = Convert.ToString(dr["VendorCode"]) + ':' + Convert.ToString(dr["VendorName"]);
                lblTotalTOPay.Text = Convert.ToString(dr["TotalToPay"]);
                lblTotalCrossing.Text = Convert.ToString(dr["TotalCrossing"]);
                lblTotalDDCharges.Text = Convert.ToString(dr["TotalDoorDelyChrg"]);
                lblTotalNetPayable.Text = Convert.ToString(dr["NetPayable"]);
                lblTotalBulkyCharges.Text = Convert.ToString(dr["TotalBulkyChrg"]);
                lblTruckFreight.Text = Convert.ToString(dr["TotalTruckFreight"]);
                lblAdvanceTruckFreight.Text = Convert.ToString(dr["TotalAdvanceFreight"]);
                lblBalanceFreight.Text = Convert.ToString(dr["TotalBalance"]);
            }
            dr.Close();
            conn.Close();

            sql = "SELECT DKTTOT=SUM(CASE WHEN d.dockdt>'01 Feb 2012' then C.subtotal else C.Dkttot End), " +
            "SVCTAX=SUM(CASE WHEN d.dockdt>'01 Feb 2012' then c.SVCTAX+c.CESS+c.hedu_cess else 0 End) " +
            "FROM Webx_Crossing_Docket_Detail S " +
            "inner join webx_master_docket_charges C ON C.dockno=S.dockno " +
            "inner join webx_master_docket D ON D.dockno=S.dockno " +
            "where CrossingChallan='" + CrossingChallanNo + "' AND S.paybas='P03' ";
            DataTable Dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
            if (Dt.Rows.Count > 0)
            {
                lblTotalTOPay.Text = Dt.Rows[0]["DKTTOT"].ToString();
                lblTotalSvcTax.Text = Dt.Rows[0]["SVCTAX"].ToString();
            }
        }
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //string sql = "select Paybas=(select codedesc from webx_master_general where codeid=paybas),Convert(varchar,DockDate,06) as DockDate,* from Webx_Crossing_Docket_Detail where CrossingChallan='" + CrossingChallanNo + "'";
        string sql = "select c.DockNo,Convert(varchar,c.DockDate,06) as DockDate,Paybas=(select top 1 CodeDesc from webx_master_general where CodeID=c.Paybas and Codetype='PAYTYP'),d.from_loc,d.to_loc,c.Pkgs,c.ActuWeight,c.DKTTOT,c.Ratetype,c.VendorRate,c.CrossingChrg,c.DoorDelyChrg,c.BulkyCharge,SVCTAX=(CASE WHEN d.dockdt>'01 Feb 2012' then s.SVCTAX+s.CESS+s.hedu_cess else 0 End) from Webx_Crossing_Docket_Detail c Inner Join Webx_master_docket d on d.dockno=c.dockno Inner Join Webx_master_docket_charges s on s.dockno=c.dockno where c.CrossingChallan='" + CrossingChallanNo + "' order by D.dockno";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        DocketDetail.DataSource = ds;
        DocketDetail.DataBind();
        conn.Close();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblPackages = (Label)e.Row.FindControl("lblPkgs");
            pkgs = pkgs + Convert.ToDouble(lblPackages.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotPackages = (Label)e.Row.FindControl("lblTotPackages");
            lblTotPackages.Text = pkgs.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblWeight = (Label)e.Row.FindControl("lblActualWt");
            weight = weight + Convert.ToDouble(lblWeight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotWeight = (Label)e.Row.FindControl("lblTotWeight");
            lblTotWeight.Text = weight.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblToPay = (Label)e.Row.FindControl("lblToPay");
            ToPay = ToPay + Convert.ToDouble(lblToPay.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotToPay = (Label)e.Row.FindControl("lblTotToPay");
            lblTotToPay.Text = ToPay.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblCrossing = (Label)e.Row.FindControl("lblCrossingChrg");
            varCrossing = varCrossing + Convert.ToDouble(lblCrossing.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotCrossing = (Label)e.Row.FindControl("lblTotCrossing");
            lblTotCrossing.Text = varCrossing.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblDDC = (Label)e.Row.FindControl("lblDDC");
            varDDC = varDDC + Convert.ToDouble(lblDDC.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotCrossing = (Label)e.Row.FindControl("lblTotDoorDeliveryChrg");
            lblTotCrossing.Text = varDDC.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblBulkyChrg = (Label)e.Row.FindControl("lblBulkyChrg");
            Bulky = Bulky + Convert.ToDouble(lblBulkyChrg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotBulkyChrg = (Label)e.Row.FindControl("lblTotBulkyChrg");
            lblTotBulkyChrg.Text = Bulky.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSvcTax = (Label)e.Row.FindControl("lblSvcTax");
            SvcTax = SvcTax + Convert.ToDouble(lblSvcTax.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotSvcTax = (Label)e.Row.FindControl("lblTotSvcTax");
            lblTotSvcTax.Text = SvcTax.ToString();
        }
        


        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    Label lblNetPayable = (Label)e.Row.FindControl("lblNetPayable");
        //    NetAmt = NetAmt + Convert.ToDouble(lblNetPayable.Text);
        //}
        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    Label lblTotNetPayable = (Label)e.Row.FindControl("lblTotNetPayable");
        //    lblTotNetPayable.Text = NetAmt.ToString();
        //}

    }
}
