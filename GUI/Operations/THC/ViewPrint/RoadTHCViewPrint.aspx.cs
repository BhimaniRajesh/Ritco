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

public partial class GUI_Operations_THC_ViewPrint_RoadTHCViewPrint : System.Web.UI.Page
{
    string thcno, strQuery;
    SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {
        imgLogo.ImageUrl = "~/GUI/images/" + Session["logofile"];
        lblClientName.Text = Convert.ToString(Session["ClientName"]);
        lblClientAddress.Text = Convert.ToString(Session["ClientAddress"]);
        lblDocName.Text = SessionUtilities.THCCalledAs;
        if (lblDocName.Text == "THC")
        {
            lblDocName.Text = "TRUCK HIRE CHALLAN";
        }
        else if (lblDocName.Text == "VHC")
        {
            lblDocName.Text = "VEHICLE HIRE CONTRACT";
        }
        else
        {
            lblDocName.Text = SessionUtilities.THCCalledAs;
        }
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        thcno = Request.QueryString["thcno"];

        string[] Split = thcno.Split(new Char[] { ',' });
        thcno = Convert.ToString(Split[0]);

        if (Convert.ToString(Split[1]).Trim() == "0")
            hdnflagprint.Value = "N";
        else
            hdnflagprint.Value = "Y";

        string print_yn = Convert.ToString(Split[1]);

        if (hdnflagprint.Value == "Y")
        {
            tblMain.CssClass = "prnttbl";
            tblopesummary.CssClass = "prnttbl";
            tbl2.CssClass = "prnttbl";
            tblDriverDetail.CssClass = "prnttbl";
            tblArrival.CssClass = "prnttbl";
            tblFinInfo.CssClass = "prnttbl";
            tblAdvanceBalance.CssClass = "prnttbl";
            tblBalenceCharge.CssClass = "prnttbl";
            tblMFSummary.CssClass = "prnttbl";
            tblLast.CssClass = "prnttbl";
        }

        BindFinData();

        strQuery = "Select Convert(varchar,thcdt,06) as THCDate,ManualTHCNo,(Routecd + ':' + Routename) as routename from webx_thc_summary with(nolock) where THCNO ='" + thcno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            LblTHCNo.Text = thcno;
            LblMTHCNo.Text = dr["ManualTHCNo"].ToString();
            LblTHCDt.Text = dr["THCDate"].ToString();
            lblRoute.Text = dr["routename"].ToString();
        }
        dr.Close();
        conn.Close();

        strQuery = "select top 1 t.TripSheetNo,advamt,netbalamt,FromTo=(FROMCITY + '-' + TOCITY),pcamt,ConType=(SELECT TOP 1 codedesc FROM webx_master_general WHERE codetype='VCTYP' AND codeid=t.CONTTYP),thcbr,convert(varchar,THCCLOSE_ENTRYDT,06) as THCCLOSE_ENTRYDT,THCNEW_ENTRYBY=(select userid + ':' + name from webx_master_users where userid=THCNEW_ENTRYBY),(case when vendor_Code='9888' or vendor_Code='8888' then (vendor_Code +':'+Vendor_name) else  vendor_Code +':'+ (select top 1 VendorName from webx_Vendor_HDR where VendorCode=vendor_Code) end) as Vendor,Address=(select default_Addr from webx_Vendor_hdr where vendorcode=t.vendor_code),CHASISNO,engineno,FITNESSDATE=CONVERT(varchar,fitness_certdt,06),INS_DATE=CONVERT(varchar,veh_insurance,06),convert(varchar,t.vehregdt,06) as vehregdt,(select top 1 vendor_type from webx_vendor_hdr with(NOLOCK) where VENDORCODE=t.vendor_code) as vendor_type,(select top 1 codedesc as type_name1 from webx_master_general where codetype='vendty' and codeid=(select top 1 vendor_type from webx_vendor_hdr where VENDORCODE=t.vendor_code))as vtype,t.vehno as vehno,vehtype=(select top 1 type_name from webx_vehicle_type with(NOLOCK) where t.vehtype <> '' and type_code=t.vehtype),fincmplbr,balamtbrcd from webx_thc_summary t where thcno='" + thcno + "'";
        cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblConType.Text = dr["ConType"].ToString();
            lblConAmt.Text = dr["pcamt"].ToString();
            lblFromTo.Text = Convert.ToString(dr["FromTo"]);
            lblAvdAmt.Text = dr["advamt"].ToString();
            lblBalAmt.Text = dr["netbalamt"].ToString();
            lblVendorType.Text = dr["vtype"].ToString();
            lblVendorName.Text = dr["Vendor"].ToString();
            lblVehicleName.Text = dr["vehno"].ToString();
            lblAddress.Text = dr["Address"].ToString();
            lblVehicleType.Text = dr["vehtype"].ToString();
            lblRegistrationDate.Text = dr["vehregdt"].ToString();
            lblEngineNo.Text = dr["engineno"].ToString();
            lblInsurance.Text = dr["INS_DATE"].ToString();
            lblRegistrationDate.Text = dr["vehregdt"].ToString();
            lblChassisNo.Text = dr["CHASISNO"].ToString();
            lblFitnessDate.Text = dr["FITNESSDATE"].ToString();
            lblEnteredBy.Text = dr["THCNEW_ENTRYBY"].ToString();
            lblAt.Text = dr["thcbr"].ToString();
            lblDateTime.Text = dr["THCCLOSE_ENTRYDT"].ToString();
            lblAdvLoc.Text = Convert.ToString(dr["fincmplbr"]);
            lblBalLoc.Text = Convert.ToString(dr["balamtbrcd"]);
            lblTripSheetNo.Text = Convert.ToString(dr["TripSheetNo"]);
        }
        dr.Close();
        conn.Close();

        strQuery = "EXEC usp_webx_Get_VHC_BalAmt '" + thcno + "'";
        cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblBalAmt.Text = dr["BalanceAmt"].ToString();
        }
        dr.Close();
        conn.Close();

        tblMFDKT.CellSpacing = 1;

        if (Convert.ToString(Split[1]).Trim() == "0")
        {
            tblMFDKT.CssClass = "stbl";
        }
        else
        {
            tblMFDKT.CssClass = "prnttbl";
        }

        tblMFDKT.CellPadding = 0;
        TableRow tr1 = new TableRow();

        TableCell tctr1 = new TableCell();
        TableCell tctr3 = new TableCell();
        TableCell tctr5 = new TableCell();

        tctr1.Text = "Location";
        tctr1.Font.Bold = true;
        tctr1.Wrap = false;
        tctr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "hrow";
        tr1.Cells.Add(tctr1);

        tctr3.Text = "Arrival";
        tctr3.Font.Bold = true;
        tctr3.Wrap = false;
        tctr3.HorizontalAlign = HorizontalAlign.Center;
        tr1.Cells.Add(tctr3);

        tctr5.Text = "Departure";
        tctr5.Font.Bold = true;
        tctr5.Wrap = false;
        tctr5.HorizontalAlign = HorizontalAlign.Center;

        tr1.Cells.Add(tctr5);

        tblMFDKT.Rows.Add(tr1);

        conn.Open();
        string sql_DKTlist = "select sourcehb,convert(varchar,actarrv_dt,106)+' '+ actarrv_tm as actarrv_dt,convert(varchar,actdept_dt,106) + ' ' + actdept_tm  as actdept_dt from webx_thchdr with(NOLOCK) where thcno='" + thcno + "'";
        SqlCommand cmddktlist = new SqlCommand(sql_DKTlist, conn);
        SqlDataReader drdktlist = cmddktlist.ExecuteReader();

        while (drdktlist.Read())
        {
            tblMFDKT.Visible = true;
            TableRow tr3 = new TableRow();
            TableCell tctr31 = new TableCell();
            TableCell tctr33 = new TableCell();
            TableCell tctr36 = new TableCell();

            tctr31.Text = drdktlist["sourcehb"].ToString();
            tctr31.CssClass = "nrow";
            tctr31.Wrap = false;
            tctr31.HorizontalAlign = HorizontalAlign.Center;
            tr3.Cells.Add(tctr31);

            tctr33.Text = drdktlist["actarrv_dt"].ToString();
            tctr33.CssClass = "nrow";
            tctr33.Wrap = false;
            tctr33.HorizontalAlign = HorizontalAlign.Center;
            tr3.Cells.Add(tctr33);

            tctr36.Text = drdktlist["actdept_dt"].ToString();
            tctr36.CssClass = "nrow";
            tctr36.Wrap = false;
            tctr36.HorizontalAlign = HorizontalAlign.Center;
            tr3.Cells.Add(tctr36);
            
            tr3.BackColor = System.Drawing.Color.White;

            tblMFDKT.Rows.Add(tr3);
        }
        drdktlist.Close();

        string sql_driverdetail = "select driver1,driver1licno,CONVERT(varchar,driver1licvaldt,6) as dr1Valdt,driverrto1,CONVERT(varchar,driver2licvaldt,6) as dr2Valdt,driver2,driver2licno,driverrto2 from webx_thc_summary with(NOLOCK) where thcno='" + thcno + "'";
        SqlCommand cmddriverdetail = new SqlCommand(sql_driverdetail, conn);
        SqlDataReader drdirverdetail = cmddriverdetail.ExecuteReader();

        while (drdirverdetail.Read())
        {
            lbldriver1.Text = drdirverdetail["driver1"].ToString();
            lldriver1lic.Text = drdirverdetail["driver1licno"].ToString() + "|" + drdirverdetail["driverrto1"].ToString();
            lbldriver1RTO.Text = drdirverdetail["dr1Valdt"].ToString();
            lbldriver2.Text = drdirverdetail["driver2"].ToString();
            lbldriver2lic.Text = drdirverdetail["driver2licno"].ToString() + "|" + drdirverdetail["driverrto2"].ToString();
            lbldriver2RTO.Text = drdirverdetail["dr2Valdt"].ToString();
        }
        drdirverdetail.Close();

        strQuery = "select Utilization,CAPACITY from VwNet_ViewTHC where thcno='" + thcno + "'";
        SqlDataReader drcapacity;
        SqlCommand cmdcapacity = new SqlCommand(strQuery, conn);
        drcapacity = cmdcapacity.ExecuteReader();
        while (drcapacity.Read())
        {
            lblVehicleCapacity.Text = drcapacity["Capacity"].ToString();
            lblUtilization.Text = drcapacity["Utilization"].ToString();
        }
        drcapacity.Close();
        conn.Close();
        BindManifestMovment();
        BindGridMF();
    }
    private void BindGridMF()
    {
        conn.Open();
        string strManifestquery = "select TCNO,manual_tcno,tcdt=convert(varchar,tcdt,6) ,TCBR + '-' + ToBH_Code as fromto,TOT_DKT,TOT_LOAD_PKGS,TOT_PKGS,TOT_LOAD_ACTWT,TOT_ACTUWT,0 as AIRBILLTOTAMT from vw_tchdr_new with(NOLOCK) where thcno='" + thcno + "'";
        SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridMF.DataSource = ds;
        GridMF.DataBind();
        if (hdnflagprint.Value == "Y")
        {
            GridMF.CssClass = "prnttbl";
        }
        else
        {
            GridMF.CssClass = "stbl";
        }
        conn.Close();
    }

    private void BindManifestMovment()
    {
        conn.Open();
        string strManifestquery = "select frm_to=isnull(TCBR+'-'+tobh_code,'Total'),TCCNT=count(*),tot_DKT=sum(tot_DKT),tot_pkg=sum(tot_pkgs),tot_Wt=sum(tot_actuwt) from webx_tchdr where thcno='" + thcno + "' group by TCBR+'-'+tobh_code with Rollup order by count(*) desc,TCBR+'-'+tobh_code";
        SqlCommand sqlcmd = new SqlCommand(strManifestquery, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GrdManifest.DataSource = ds;
        GrdManifest.DataBind();

        if (hdnflagprint.Value == "Y")
        {
            GrdManifest.CssClass = "prnttbl";
        }
        else
        {
            GrdManifest.CssClass = "stbl";
        }


        SqlDataReader drMF;
        drMF = sqlcmd.ExecuteReader();
        while (drMF.Read())
        {
            lblTotalMFWeight.Text = drMF["tot_Wt"].ToString();
        }
        drMF.Close();
        conn.Close();
    }
    protected void GrdManifest_OnDataBound()
    {

    }
    private void BindFinData()
    {
        #region Payment Details
        #region Advance Details
        string strQuery = "SELECT isnull(accdesc,'') as Bank,*  FROM Webx_THC_PDC_FIN_DET LEFT OUTER JOIN webx_acctinfo ON Webx_THC_PDC_FIN_DET.acccode = webx_acctinfo.acccode WHERE  (DocType='THC' OR DocType='VHC') AND TransactionType='Advance Payment' AND Docno='" + thcno.Trim() + "'";
        SqlCommand cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblAdvPayMode.Text = dr["PaymentType"].ToString();
            lblAdvChqNo.Text = dr["ChqNo"].ToString();
            lblAdvBank.Text = dr["Bank"].ToString();
            lblAdvVoucherNo.Text = dr["Voucherno"].ToString();

            lblAdvVoucherNo.Text = "<a href=\"javascript:AdvanceVoucherView('" + lblAdvVoucherNo.Text + "')\"> " + lblAdvVoucherNo.Text + " </a> ";
            

        }
        dr.Close();
        conn.Close();
        #endregion
        #region Balance Details
        strQuery = "SELECT isnull(accdesc,'') as Bank,*  FROM Webx_THC_PDC_FIN_DET LEFT OUTER JOIN webx_acctinfo ON Webx_THC_PDC_FIN_DET.acccode = webx_acctinfo.acccode WHERE  (DocType='THC' OR DocType='VHC') AND TransactionType='Balance Payment' AND Docno='" + thcno.Trim() + "'";
        cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblBalPayMode.Text = dr["PaymentType"].ToString();
            lblBalChqNo.Text = dr["ChqNo"].ToString();
            lblBalBank.Text = dr["Bank"].ToString();
            lblBalVoucherNo.Text = dr["Voucherno"].ToString();
            lblBalVoucherNo.Text = "<a href=\"javascript:BalanceVoucherView('" + lblBalVoucherNo.Text + "')\"> " + lblBalVoucherNo.Text + " </a> ";

        }
        dr.Close();
        conn.Close();
        #endregion
        #endregion


        strQuery = "SELECT VendorBENo FROM Webx_THC_Summary WHERE THCNO='" + thcno.Trim() + "'";
        cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblVendorBill.Text = dr["VendorBENo"].ToString();
            //lblVendorBill.Text = "<a href=\"javascript:VendorBillView('" + lblVendorBill.Text + "')\"> " + lblVendorBill.Text + " </a> ";
        }
        dr.Close();
        conn.Close();
        //strQuery = "SELECT Voucherno FROM Webx_THC_PDC_FIN_DET TransactionType='Bill Entry' AND Docno='" + thcno.Trim() + "'";

        strQuery = "SELECT Voucherno FROM Webx_THC_PDC_FIN_DET WHERE TransactionType='Bill Entry' AND Docno='" + thcno.Trim() + "'";
        cmd = new SqlCommand(strQuery, conn);
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblVendorBill.Text = "<a href=\"javascript:VendorBillView('" + dr["Voucherno"].ToString() + "')\"> " + lblVendorBill.Text + " </a> ";
        }
        dr.Close();
        conn.Close();


        #region Advance Charges Value
        string sql_AdvChgValue = "exec usp_webx_Get_VHC_AdvChargeValue 'Advance Payment', '" + thcno.Trim() + "'";
        SqlCommand sqlcmd = new SqlCommand(sql_AdvChgValue, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        conn.Open();
        string sql_AdvCharges = "exec usp_webx_Get_VHC_ChargeNameList 'GE'";
        SqlCommand cmdAdvChg = new SqlCommand(sql_AdvCharges, conn);
        SqlDataReader drAdvChg = cmdAdvChg.ExecuteReader();

        string[] arrAdvChg = new string[10];
        string[] arrActiveAdvChg = new string[10];

        while (drAdvChg.Read())
        {
            if (drAdvChg["ACTIVECD"] != null)
            {
                arrAdvChg = drAdvChg["CHRGnm"].ToString().Split('~');
                arrActiveAdvChg = drAdvChg["ACTIVECD"].ToString().Split('~');

                tblAdvanceBalance.CellSpacing = 1;
                TableRow trAdvTitle = new TableRow();

                if (hdnflagprint.Value == "Y")
                {
                    tblAdvanceBalance.CssClass = "prnttbl";
                }
                else
                {
                    tblAdvanceBalance.CssClass = "stbl";
                }

                
                trAdvTitle.CssClass = "hrow";
                tblAdvanceBalance.Rows.AddAt(0, trAdvTitle);
                
                TableCell tcAdvTitle = new TableCell();
                tcAdvTitle.Text = SessionUtilities.THCCalledAs + " Advance Charges";
                tcAdvTitle.Font.Bold = true;
                tcAdvTitle.ColumnSpan = 4;
                tcAdvTitle.HorizontalAlign = HorizontalAlign.Center;
                trAdvTitle.Cells.Add(tcAdvTitle);

                for (int j = 0; j <= arrActiveAdvChg.Length - 1; j++)
                {
                    //tblAdvanceBalance.BorderWidth = 1;

                    TableRow trCharge = new TableRow();

                    trCharge.CssClass = "nrow";
                    tblAdvanceBalance.Rows.Add(trCharge);

                    TableCell tcTrChgName = new TableCell();
                    tcTrChgName.ID = arrAdvChg[j].ToString();
                    tcTrChgName.Text = arrAdvChg[j].ToString().Replace("Charges", "").Trim();
                    tcTrChgName.Wrap = false;
                    tcTrChgName.Style["width"] = "25%";
                    tcTrChgName.HorizontalAlign = HorizontalAlign.Left;
                    trCharge.Cells.Add(tcTrChgName);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        TableCell tcTrChgValue = new TableCell();
                        tcTrChgValue.ID = arrActiveAdvChg[j].ToString();
                        tcTrChgValue.Text = ds.Tables[0].Rows[0][arrActiveAdvChg[j].ToString().Trim()].ToString().Trim();
                        tcTrChgValue.Wrap = false;
                        tcTrChgValue.HorizontalAlign = HorizontalAlign.Right;
                        tcTrChgValue.Style["width"] = "25%";
                        trCharge.Cells.Add(tcTrChgValue);
                    }

                    if (j + 1 <= arrActiveAdvChg.Length - 1)
                    {
                        TableCell tcTrChgName1 = new TableCell();
                        tcTrChgName1.ID = arrAdvChg[j + 1].ToString();
                        tcTrChgName1.Text = arrAdvChg[j + 1].ToString().Replace("Charges", "").Trim();
                        tcTrChgName1.Wrap = false;
                        tcTrChgName1.Style["width"] = "25%";
                        tcTrChgName1.HorizontalAlign = HorizontalAlign.Left;
                        trCharge.Cells.Add(tcTrChgName1);

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            TableCell tcTrChgValue1 = new TableCell();
                            tcTrChgValue1.ID = arrActiveAdvChg[j + 1].ToString();
                            tcTrChgValue1.Text = ds.Tables[0].Rows[0][arrActiveAdvChg[j + 1].ToString().Trim()].ToString().Trim();
                            tcTrChgValue1.Wrap = false;
                            tcTrChgValue1.HorizontalAlign = HorizontalAlign.Right;
                            trCharge.Cells.Add(tcTrChgValue1);
                        }
                        j = j + 1;
                    }
                }
            }
        }
        drAdvChg.Close();
        conn.Close();
        #endregion

        #region Balance Charges Value
        string sql_BalChgValue = "exec usp_webx_Get_VHC_BalChargeValue 'Bill Entry', '" + thcno.Trim() + "'";
        sqlcmd = new SqlCommand(sql_BalChgValue, conn);
        da = new SqlDataAdapter(sqlcmd);
        ds = new DataSet();
        da.Fill(ds);

        conn.Open();
        string sql_BalCharges = "exec usp_webx_Get_VHC_ChargeNameList 'BAL'";
        SqlCommand cmdBalChg = new SqlCommand(sql_BalCharges, conn);
        SqlDataReader drBalChg = cmdBalChg.ExecuteReader();

        string[] arrBalChg = new string[10];
        string[] arrActiveBalChg = new string[10];

        while (drBalChg.Read())
        {
            if (drBalChg["ACTIVECD"] != null)
            {
                arrBalChg = drBalChg["CHRGnm"].ToString().Split('~');
                arrActiveBalChg = drBalChg["ACTIVECD"].ToString().Split('~');

                TableRow trBalTitle = new TableRow();
                trBalTitle.CssClass = "hrow";
                tblBalenceCharge.Rows.AddAt(0, trBalTitle);

                TableCell tcBalTitle = new TableCell();
                tcBalTitle.Text = SessionUtilities.THCCalledAs + " Balance Charges";
                tcBalTitle.Font.Bold = true;
                tcBalTitle.ColumnSpan = 4;
                tcBalTitle.HorizontalAlign = HorizontalAlign.Center;
                trBalTitle.Cells.Add(tcBalTitle);

                for (int j = 0; j <= arrActiveBalChg.Length - 1; j++)
                {
                    //tblBalenceCharge.BorderWidth = 1;

                    TableRow trCharge = new TableRow();
                    trCharge.CssClass = "nrow";
                    tblBalenceCharge.Rows.Add(trCharge);

                    TableCell tcTrChgName = new TableCell();
                    tcTrChgName.ID = "Bal" + arrBalChg[j].ToString();
                    tcTrChgName.Text = arrBalChg[j].ToString().Replace("Charges", "").Trim();
                    tcTrChgName.Wrap = false;
                    tcTrChgName.Style["width"] = "25%";
                    tcTrChgName.HorizontalAlign = HorizontalAlign.Left;
                    trCharge.Cells.Add(tcTrChgName);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        TableCell tcTrChgValue = new TableCell();
                        tcTrChgValue.ID = "Bal" + arrActiveBalChg[j].ToString();
                        tcTrChgValue.Text = ds.Tables[0].Rows[0][arrActiveBalChg[j].ToString().Trim()].ToString().Trim();
                        tcTrChgValue.Wrap = false;
                        tcTrChgValue.Style["width"] = "25%";
                        tcTrChgValue.HorizontalAlign = HorizontalAlign.Right;
                        trCharge.Cells.Add(tcTrChgValue);
                    }

                    if (j + 1 <= arrActiveBalChg.Length - 1)
                    {
                        TableCell tcTrChgName1 = new TableCell();
                        tcTrChgName1.ID = "Bal" + arrBalChg[j + 1].ToString();
                        tcTrChgName1.Text = arrBalChg[j + 1].ToString().Replace("Charges", "").Trim();
                        tcTrChgName1.Wrap = false;
                        tcTrChgName1.Style["width"] = "25%";
                        tcTrChgName1.HorizontalAlign = HorizontalAlign.Left;
                        trCharge.Cells.Add(tcTrChgName1);

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            TableCell tcTrChgValue1 = new TableCell();
                            tcTrChgValue1.ID = "Bal" + arrActiveBalChg[j + 1].ToString();
                            tcTrChgValue1.Text = ds.Tables[0].Rows[0][arrActiveBalChg[j + 1].ToString().Trim()].ToString().Trim();
                            tcTrChgValue1.Wrap = false;
                            tcTrChgValue1.HorizontalAlign = HorizontalAlign.Right;
                            trCharge.Cells.Add(tcTrChgValue1);
                        }
                        j = j + 1;
                    }
                }
            }
        }
        drBalChg.Close();
        conn.Close();
        #endregion
    }
}
