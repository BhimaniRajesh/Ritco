using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_Operations_DocketNonDeliveryUpdate_DocketNonDeliveryCriteria : BasePage
{
    string _fromDate="",_toDate="";
    readonly MyFunctions fn = new MyFunctions();
    SqlConnection _con;

    //public string GenXml
    //{
    //    get
    //    {
    //        if (ViewState["Xml_MR_Wise_Det"] != null)
    //            return ViewState["Xml_MR_Wise_Det"] as string;
    //        else
    //            return "";
    //    }
    //    set
    //    {
    //        ViewState["Xml_MR_Wise_Det"] = value;
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        
        _con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        hBrCd.Value = Session["brcd"].ToString().Trim();
        const string gridData = "USP_GET_DeliveryMR_Details";
        _fromDate = Request.QueryString.Get("fromdt");
        _toDate = Request.QueryString.Get("todt");
        //SqlParameter[] arParms = new SqlParameter[4];
        //arParms[0] = ControllersHelper.GetSqlParameter("@FromDt", _fromDate.ToString().Trim(), SqlDbType.Text);
        //arParms[1] = ControllersHelper.GetSqlParameter("@ToDt", _toDate.ToString().Trim(), SqlDbType.Text);
        //arParms[2] = ControllersHelper.GetSqlParameter("@DockNo", Request.QueryString["DocketNo"].ToString().Trim(), SqlDbType.Text);
        //arParms[3] = ControllersHelper.GetSqlParameter("@Brcd", Session["brcd"].ToString().Trim(), SqlDbType.Text);

        SqlCommand sqlCmd = new SqlCommand(gridData, _con);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@FromDt", SqlDbType.VarChar).Value = _fromDate.ToString().Trim();
        sqlCmd.Parameters.Add("@ToDt", SqlDbType.Text).Value = _toDate.ToString().Trim();
        sqlCmd.Parameters.Add("@DockNo", SqlDbType.Text).Value = Request.QueryString["DocketNo"].ToString().Trim();
        sqlCmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        
        try
        {
            if (!IsPostBack && !IsCallback)
            {
				CreateToken();
                //DataSet dsGridData = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, gridData,arParms);
                //if (dsGridData.Tables.Count > 0)
                //{
                //    GV_DDMRList.DataSource = dsGridData.Tables[0];
                //    GV_DDMRList.DataBind();
                //}
                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                sqlCmd.CommandTimeout = 300;
                DataSet dsGridData = new DataSet();
                da.Fill(dsGridData);
                if (dsGridData.Tables.Count > 0)
                {
                    GV_DDMRList.DataSource = dsGridData.Tables[0];
                    GV_DDMRList.DataBind();
                }
                da.Dispose();
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }

    protected void OnVendorChange(object sender, EventArgs e)
    {
        _con.Open();
        string sql = "";
        if (cboVendors.SelectedIndex < 0)
        {
            sql = "Exec usp_Vendor_Vehicles '','" + cboVendorType.Items[cboVendorType.SelectedIndex].Value + "'";
        }
        else
        {
            sql = "Exec usp_Vendor_Vehicles '" + cboVendors.Items[cboVendors.SelectedIndex].Value + "','" + cboVendorType.Items[cboVendorType.SelectedIndex].Value + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, _con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds= new DataSet();
        da.Fill(ds);

        cboVehicles.DataSource = ds;
        cboVehicles.DataValueField = ds.Tables[0].Columns[0].ColumnName;
        cboVehicles.DataTextField = ds.Tables[0].Columns[1].ColumnName;
        cboVehicles.DataBind();

        _con.Close();
    }
    protected void OnVehicleChange(object sender, EventArgs e)
    {
        _con.Open();
        string sqlType = "Select TypeCode='',Type_Name='--Select--' Union Select TypeCode=Convert(Varchar,Type_Code), [Type_Name] From WebX_Vehicle_Type Where ActiveFlag='Y' and Type_Code in (Select Vehicle_Type From WebX_Vehicle_Hdr Where Vehno=ltrim(rtrim('" + cboVehicles.SelectedValue + "'))) ";
        SqlCommand cmdType = new SqlCommand(sqlType, _con);
        SqlDataAdapter daType = new SqlDataAdapter(cmdType);
        DataSet dsType = new DataSet();
        daType.Fill(dsType);
        cboVehicleTypes.DataSource = dsType;
        cboVehicleTypes.DataBind();

        string sqlFtl = "Select CodeID='',CodeDesc='--Select--' Union SELECT CodeID,CodeDesc=codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y' and  codeid in (Select FTLTYPE From WebX_Vehicle_Hdr Where Vehno=ltrim(rtrim('" + cboVehicles.SelectedValue + "')))";
        SqlCommand cmdFtl = new SqlCommand(sqlFtl, _con);
        SqlDataAdapter daFtl = new SqlDataAdapter(cmdFtl);
        DataSet dsFtl = new DataSet();
        daFtl.Fill(dsFtl);
        cboFTLTypes.DataSource = dsFtl;
        cboFTLTypes.DataBind();

        string sqlTrip = "Select CodeSlipNo='',VSlipNo='--Select--',Manual_TripSheetNo='' Union (select CodeSlipNo=VSlipNo,VSlipNo,Manual_TripSheetNo from WEBX_FLEET_VEHICLE_ISSUE I,webx_vehicle_hdr V where vehno=VehicleNo and isnull(cancel_status,'N')='N' and VehicleNo='" + cboVehicles.SelectedValue + "' and f_closure_closekm is null )";
        SqlCommand cmdTrip = new SqlCommand(sqlTrip, _con);
        SqlDataAdapter daTrip = new SqlDataAdapter(cmdTrip);
        DataSet dsTrip = new DataSet();
        daTrip.Fill(dsTrip);
        cboTripSheet.DataSource = dsTrip;
        cboTripSheet.DataBind();
        
        _con.Close();
    }
    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        string vendorType = cboVendorType.SelectedValue;
        if (vendorType == "XX")
        {
            txtMarketVendor.Visible = true;
            txtMktVeh.Visible = true;
            txtMarketVendor.Text = "";
            txtMktVeh.Text = "";
            cboVendors.Visible = false;
            cboVehicles.Visible = false;
        }
        else
        {
            cboVendors.Visible = true;
            cboVehicles.Visible = true;
            txtMarketVendor.Visible = false;
            txtMktVeh.Visible = false;
        }
        if (vendorType == "05")
        {
            cboTripSheet.Enabled = true;
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            try
            {
		ConsumeToken();
                string xmlMrDet = "<root>";
                foreach (GridViewRow gridrow in GV_DDMRList.Rows)
                {
                    var lblDockno = (Label)gridrow.FindControl("LblDOCKNO");
                    var lblMrsno = (Label)gridrow.FindControl("LblMRSNO");
                    var lblDocketdt = (Label)gridrow.FindControl("LblDOCKETDT");
                    var lblConsignee = (Label)gridrow.FindControl("LblConsignee");
                    var lblDdlCharge = (Label)gridrow.FindControl("LblDDLCharge");
                    var lblPrivate = (Label)gridrow.FindControl("LblPrivate");

                    var txtBookedPkt = (TextBox)gridrow.FindControl("TxtBookedPkt");
                    var txtGievnPkt = (TextBox)gridrow.FindControl("TxtGievnPkt");
                    var txtPendPkt = (TextBox)gridrow.FindControl("TxtPendPkt");
                    var lblChrgwt = (Label)gridrow.FindControl("LblCHRGWT");

                    var chkDocno = (CheckBox)gridrow.FindControl("Chk_Docno");
                    xmlMrDet = xmlMrDet + "<MR_Det>";
                    if (chkDocno.Checked == true)
                    {
			//Add By Trushar Patel On 5 May 2015
			//string sqlTrip = "SELECT * FROM [dbo].[WEBX_MR_HDR] WMH WITH(NOLOCK) WHERE [DDMR_Y_N] = 'Y' AND [MRSNO]='"+lblMrsno.Text+"'";
			//SqlCommand cmdTrip = new SqlCommand(sqlTrip, _con);
			//SqlDataAdapter daTrip = new SqlDataAdapter(cmdTrip);
			//DataSet dsTrip = new DataSet();
 			//daTrip.Fill(dsTrip);
                        //if (dsTrip.Tables[0].Rows.Count > 0)
                        //{
                        //    throw new Exception("DDMR Already Generated For This Docket");
                        //}

                        var updateStr = "UPDATE Webx_DDMR_DET SET PendPkt=0 WHERE PendPkt>0 AND DOCKNO='" + lblDockno.Text + "'";
                        SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, updateStr);

                        xmlMrDet = xmlMrDet + "<Dockno>" + lblDockno.Text + "</Dockno>";
                        xmlMrDet = xmlMrDet + "<DockDt>" + lblDocketdt.Text + "</DockDt>";
                        xmlMrDet = xmlMrDet + "<MRNo>" + lblMrsno.Text + "</MRNo>";
                        xmlMrDet = xmlMrDet + "<Consignee>" + lblConsignee.Text + "</Consignee>";
                        if (lblDdlCharge.Text.ToString() == "0.00 (FOC)")
                        {
                            xmlMrDet = xmlMrDet + "<Charge>0.00</Charge>";
                        }
                        else
                        {
                            xmlMrDet = xmlMrDet + "<Charge>" + lblDdlCharge.Text + "</Charge>";
                        }
                        xmlMrDet = xmlMrDet + "<PrivateMr>" + lblPrivate.Text + "</PrivateMr>";
                        xmlMrDet = xmlMrDet + "<BookedPkt>" + Convert.ToDouble(txtBookedPkt.Text) + "</BookedPkt>";
                        xmlMrDet = xmlMrDet + "<GivenPkt>" + Convert.ToDouble(txtGievnPkt.Text) + "</GivenPkt>";
                        xmlMrDet = xmlMrDet + "<PendPkt>" + Convert.ToDouble(txtPendPkt.Text) + "</PendPkt>";
                        xmlMrDet = xmlMrDet + "<ChargeWeight>" + Convert.ToDouble(lblChrgwt.Text) + "</ChargeWeight>";
                    }
                    xmlMrDet = xmlMrDet + "</MR_Det>";
                }
                xmlMrDet = xmlMrDet + "</root>";

                string xmlMrHdr = "<root><MR_HDR>";
                string Vendor_Detail = "", vendorCode = "", vendorName = "";
                string[] VendorCls;
                string vendorType = cboVendorType.SelectedValue;
                if (vendorType != "XX")
                {
                    Vendor_Detail = cboVendors.SelectedItem.ToString();
                    VendorCls = Vendor_Detail.Split(':');
                    vendorCode = VendorCls[0];
                    vendorName = VendorCls[1];
                }
                xmlMrHdr = xmlMrHdr + "<ManualMRNo>" + TxtManualDDMRNo.Text + "</ManualMRNo>";
                xmlMrHdr = xmlMrHdr + "<DDMRDt>" + fn.Mydate1(TxtDDMRDate.Text) + "</DDMRDt>";
                xmlMrHdr = xmlMrHdr + "<Brcd>" + Session["brcd"] + "</Brcd>";
                xmlMrHdr = xmlMrHdr + "<FromLoc>" + TxtFromLoc.Text + "</FromLoc>";
                xmlMrHdr = xmlMrHdr + "<ToLoc>" + TxtToLoc.Text + "</ToLoc>";
                xmlMrHdr = xmlMrHdr + "<VendType>" + cboVendorType.SelectedValue + "</VendType>";

                if (vendorType == "XX")
                {
                    xmlMrHdr = xmlMrHdr + "<VendorCode>9888</VendorCode>";
                    xmlMrHdr = xmlMrHdr + "<VendorName>" + txtMarketVendor.Text + "</VendorName>";
                    xmlMrHdr = xmlMrHdr + "<Vehicle>" + txtMktVeh.Text + "</Vehicle>";
                }
                else
                {
                    xmlMrHdr = xmlMrHdr + "<VendorCode>" + vendorCode + "</VendorCode>";
                    xmlMrHdr = xmlMrHdr + "<VendorName>" + vendorName + "</VendorName>";
                    xmlMrHdr = xmlMrHdr + "<Vehicle>" + cboVehicles.SelectedValue + "</Vehicle>";
                }
                xmlMrHdr = xmlMrHdr + "<VehicleType>" + cboVehicleTypes.SelectedValue + "</VehicleType>";
                xmlMrHdr = xmlMrHdr + "<FTLType>" + cboFTLTypes.SelectedValue + "</FTLType>";
                if (vendorType == "05")
                {
                    xmlMrHdr = xmlMrHdr + "<TripSheetNo>" + cboTripSheet.SelectedValue + "</TripSheetNo>";
                }
                else
                {
                    xmlMrHdr = xmlMrHdr + "<TripSheetNo></TripSheetNo>";
                }
                xmlMrHdr = xmlMrHdr + "<Remarks>" + TxtRemarks.Text + "</Remarks>";
                xmlMrHdr = xmlMrHdr + "<DriverNm>" + TxtDriverName.Text + "</DriverNm>";
                xmlMrHdr = xmlMrHdr + "<DriverMobileNo>" + TxtMobNo.Text + "</DriverMobileNo>";
                xmlMrHdr = xmlMrHdr + "<LicenceNo>" + TxtLicenseNo.Text + "</LicenceNo>";
                xmlMrHdr = xmlMrHdr + "<RTO>" + TxtRTO.Text + "</RTO>";
                xmlMrHdr = xmlMrHdr + "<LicenceDate>" + fn.Mydate1(TxtValDate.Text) + "</LicenceDate>";

                xmlMrHdr = xmlMrHdr + "<ContractAmt>" + Convert.ToDouble(TxtContrctAmt.Text) + "</ContractAmt>";
                xmlMrHdr = xmlMrHdr + "<BalanceAmt>" + Convert.ToDouble(TxtBalAmt.Text) + "</BalanceAmt>";
                xmlMrHdr = xmlMrHdr + "<BalanceLoc>" + TxtBalLoc.Text + "</BalanceLoc>";
                xmlMrHdr = xmlMrHdr + "<AdvanceAmt>" + Convert.ToDouble(TxtAdvAmt.Text) + "</AdvanceAmt>";
                xmlMrHdr = xmlMrHdr + "<AdvanceLoc>" + TxtAdvLoc.Text + "</AdvanceLoc>";

                xmlMrHdr = xmlMrHdr + "</MR_HDR></root>";

                string ddmrsno = "", tranXaction = "";
                var conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    const string sql = "Usp_DDMR_Generate";

                    SqlParameter[] prm = new SqlParameter[5];
                    prm[0] = new SqlParameter("@MR_Location", SqlDbType.VarChar);
                    prm[0].Value = Session["brcd"].ToString();
                    prm[1] = new SqlParameter("@Xml_DDMR_HDR", SqlDbType.Text);
                    prm[1].Value = xmlMrHdr.Replace("&", "&amp;").Replace("–", "-").Trim();
                    prm[2] = new SqlParameter("@Xml_DDMR_DET", SqlDbType.Text);
                    prm[2].Value = xmlMrDet.Replace("&", "&amp;").Replace("–", "-").Trim();
                    prm[3] = new SqlParameter("@FinYear", SqlDbType.Text);
                    prm[3].Value = Session["FinYear"].ToString().Substring(2, 2).Trim();
                    prm[4] = new SqlParameter("@EntryBy", SqlDbType.Text);
                    prm[4].Value = Session["empcd"].ToString();

                    DataTable resultDtl = SqlHelper.ExecuteDataset(trans, CommandType.StoredProcedure, sql, prm).Tables[0];
                    if (resultDtl.Rows.Count > 0)
                    {
                        DataRow resultDtlRow = resultDtl.Rows[0];
                        if (resultDtlRow["Status"] != DBNull.Value)
                        {
                            int status = Convert.ToInt32(resultDtlRow["Status"]);
                            tranXaction = resultDtlRow["Message"].ToString();

                            if (status == 0 && tranXaction != "Done")
                                throw new Exception(resultDtlRow["Message"].ToString());
                            if (status == 1)
                            {
                                ddmrsno = resultDtlRow["MRSNO"].ToString();
                            }
                        }
                        else
                            throw new Exception("Unknown Exception");
                    }
                    trans.Commit();
                }
                catch (Exception exp)
                {
                    trans.Rollback();
                    throw exp;
                }
                finally
                {
                    if (conn.State == ConnectionState.Open)
                        conn.Close();
                    conn.Dispose();
                }
                Response.Redirect("DDMR_Done.aspx?DDMRSNO=" + ddmrsno + "&TranXaction=" + tranXaction);
                //ConsumeToken();
            }
            catch (Exception ex)
            {
                //MsgBox.Show(ex.Message);
				  //btnShow.Text=ex.Message;
            }
        }
    }
    protected void ButStep1_Click(object sender, EventArgs e)
    {
        ButStep1.Enabled = false;
        btnFromLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtFromLoc.ClientID.ToString() + "','none')");
        btnToLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtToLoc.ClientID.ToString() + "','none')");
        ButAdvLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtAdvLoc.ClientID.ToString() + "','none')");
        ButBalLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtBalLoc.ClientID.ToString() + "','none')");

        TxtToLoc.Attributes.Add("onblur", "LocBlur('" + TxtToLoc.ClientID.ToString() + "')");
        TxtAdvLoc.Attributes.Add("onblur", "LocBlur('" + TxtAdvLoc.ClientID.ToString() + "')");
        TxtBalLoc.Attributes.Add("onblur", "LocBlur('" + TxtBalLoc.ClientID.ToString() + "')");

        //TxtDDMRDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        TxtDDMRDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../images/Date_Control_Rule_Check.aspx')");
        TxtValDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        TxtFromLoc.Text = Session["brcd"].ToString();
        TxtToLoc.Text = Session["brcd"].ToString();
        TxtAdvLoc.Text = Session["brcd"].ToString();
        TxtBalLoc.Text = Session["brcd"].ToString();
        //Step1.Visible = false;
        //gridview.Visible = false;
        GV_DDMRList.Enabled = false;
        DDMRProcess.Visible = true;
        submit.Visible = true;
        TxtManualDDMRNo.Focus();
        //popVendor();
        _con.Open();

        string sql_Type = "Select TypeCode='',Type_Name='--Select--' Union Select TypeCode=Convert(Varchar,Type_Code), [Type_Name] From WebX_Vehicle_Type Where ActiveFlag='Y' ";
        SqlCommand cmd_Type = new SqlCommand(sql_Type, _con);
        SqlDataAdapter da_Type = new SqlDataAdapter(cmd_Type);
        DataSet ds_Type = new DataSet();
        da_Type.Fill(ds_Type);
        cboVehicleTypes.DataSource = ds_Type;
        cboVehicleTypes.DataBind();

        string sql_FTL = "Select CodeID='',CodeDesc='--Select--' Union SELECT CodeID,CodeDesc=codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
        SqlCommand cmd_FTL = new SqlCommand(sql_FTL, _con);
        SqlDataAdapter da_FTL = new SqlDataAdapter(cmd_FTL);
        DataSet ds_FTL = new DataSet();
        da_FTL.Fill(ds_FTL);
        cboFTLTypes.DataSource = ds_FTL;
        cboFTLTypes.DataBind();

        _con.Close();

        //foreach (GridViewRow gridrow in GV_DDMRList.Rows)
        //{
        //    Label Lbl_Dockno = (Label)gridrow.FindControl("LblDOCKNO");
        //    Label LblMRSNO = (Label)gridrow.FindControl("LblMRSNO");
        //    Label LblDOCKETDT = (Label)gridrow.FindControl("LblDOCKETDT");
        //    Label LblConsignee = (Label)gridrow.FindControl("LblConsignee");
        //    Label LblDDLCharge = (Label)gridrow.FindControl("LblDDLCharge");
        //    Label LblPrivate = (Label)gridrow.FindControl("LblPrivate");
            
        //    TextBox TxtBookedPkt = (TextBox)gridrow.FindControl("TxtBookedPkt");
        //    TextBox TxtGievnPkt = (TextBox)gridrow.FindControl("TxtGievnPkt");
        //    TextBox TxtPendPkt = (TextBox)gridrow.FindControl("TxtPendPkt");

        //    CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
        //    Xml_MR_Det = Xml_MR_Det + "<MR_Det>";
        //    if (Chk_Docno.Checked==true)
        //    {
        //        Xml_MR_Det = Xml_MR_Det + "<Dockno>" + Lbl_Dockno.Text.ToString() + "</Dockno>";
        //        Xml_MR_Det = Xml_MR_Det + "<DockDt>" + LblDOCKETDT.Text.ToString() + "</DockDt>";
        //        Xml_MR_Det = Xml_MR_Det + "<MRNo>" + LblMRSNO.Text.ToString() + "</DockMRNono>";
        //        Xml_MR_Det = Xml_MR_Det + "<Consignee>" + LblConsignee.Text.ToString() + "</Consignee>";
        //        Xml_MR_Det = Xml_MR_Det + "<Charge>" + LblDDLCharge.Text.ToString() + "</Charge>";
        //        Xml_MR_Det = Xml_MR_Det + "<PrivateMr>" + LblPrivate.Text.ToString() + "</PrivateMr>";
        //        Xml_MR_Det = Xml_MR_Det + "<BookedPkt>" + TxtBookedPkt.Text.ToString() + "</BookedPkt>";
        //        Xml_MR_Det = Xml_MR_Det + "<GivenPkt>" + TxtGievnPkt.Text.ToString() + "</GivenPkt>";
        //        Xml_MR_Det = Xml_MR_Det + "<PendPkt>" + TxtPendPkt.Text.ToString() + "</PendPkt>";
        //    }
        //    Xml_MR_Det = Xml_MR_Det + "</MR_Det>";
        //}

    }
}
