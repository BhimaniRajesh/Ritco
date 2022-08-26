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

public partial class Issue_frmCloseVehicleIssueSlip : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    private double sum = 0;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.SparePartRow datarow_Spare;


    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;
    MyFleetDataSet.HSD_OIL_EXPRow datarow_HSDOIL;
    MyFleetDataSet.Repair_ExpenseRow datarow_Repair;
    MyFleetDataSet.Incidental_DedRow datarow_IncDed;


    string stVSlipId = "";
    //public string strDriverCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            conn.Open();
            stVSlipId = Request.QueryString["id"];

            string sql = "select V.VSlipNo,Convert(varchar,VSlipDt,106) VSlipDt,VehicleNo as Vehno,f_issue_startkm as Start_km,f_issue_fill "
                      + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
                      + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                      + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt,v.driver1 "
                      + " from WEBX_FLEET_VEHICLE_ISSUE v,webx_fleet_vehicle_request r "
                      + " where 1=1 and V.VSlipNo*=r.VSlipId"
                      + " and V.VSlipNo='" + stVSlipId + "'";

            SqlCommand cmdVI = new SqlCommand(sql, conn);
            cmdVI.CommandType = CommandType.Text;
            SqlDataReader dataReadVI = cmdVI.ExecuteReader();
            while (dataReadVI.Read())
            {
                lblIssueNo.Text = dataReadVI["VSlipNo"].ToString();
                lblIssueDt.Text = dataReadVI["VSlipDt"].ToString();
                lblVehno.Text = dataReadVI["Vehno"].ToString();
                lblDriverName.Text = dataReadVI["driver_name"].ToString();
                Session["strDriverCode"] = dataReadVI["driver1"].ToString();
                
                lblLicno.Text = dataReadVI["License_no"].ToString();
                lblValidDt.Text = dataReadVI["valdity_dt"].ToString();
                lblStartKm.Text = dataReadVI["Start_km"].ToString();
                lblFuelFilled.Text = dataReadVI["f_issue_fill"].ToString();
            }
            dataReadVI.Close();


            
            sql = " Select Request_id,convert(varchar,Request_Dt,103) Request_Dt,Request_by,CategoryName=(select categoryname from WEBX_FLEET_CATEGORY where categorycode=category_id)"
                + " ,orgn_address "
                + " ,Orgn_city=(select location from webx_citymaster where city_code=Orgn_city),Orgn_pin "
                + ",Orgn_Phone,Orgn_Email "
                //+ ",Orgn_Loccode=(select pickup_locname from webx_PICKUP_Location where pickup_loccode=Orgn_Loccode) "
                + ",0 as Orgn_Loccode"
                + ",Destn_address "
                + ",Destn_city=(select location from webx_citymaster where city_code=Destn_city),Destn_pin "
                + ",Destn_Phone,Destn_Email "
                //+ ",Destn_Loccode=(select pickup_locname from webx_PICKUP_Location where pickup_loccode=Destn_Loccode) "
               + ",0 as Destn_Loccode"
                + ",Vehtype=(select Type_Name from webx_Vehicle_Type where Type_Code=Vehtype) "
                + ",VehClass=(select class_name from webx_vehicle_class where classid=VehClass) "
                + ",No_Passenger "
                + ",convert(varchar,Start_date_time,103)  Start_date_time "
                + ",convert(varchar,Start_date_time,108)  Start_time "
                + ",convert(varchar,End_dt_tm,103) End_dt_tm "
                + ",convert(varchar,End_dt_tm,108) End_tm "
                + ",convert(varchar,Start_date_time,113)  JStart_date_time "
                + ",convert(varchar,End_dt_tm,113)  JEnd_dt_tm "
                + ",AC_NONAC "
                + ",(case  "
                + "       when Confirm_YN= 'N'  and Reject_YN= 'N'  then 'Requested'  "
                + "       when Confirm_YN='Y'  and Reject_YN= 'N'   then  'Confirmed'	 "
                + "       when Reject_YN= 'Y'  then  'Rejected'	 end ) RequestStatus "
                + ",(case  "
                + "       when Arrival_Mode= 'A'  then  'Air'  "
                + "       when Arrival_Mode= 'R'  then   'Train'  end) Arrival_Mode "
                + ",Arrived_By,convert(varchar,Arrival_Dt,103)  Arrival_Dt,convert(varchar,Arrival_Dt,108)  Arrival_tm "
                + "   from webx_fleet_vehicle_request where 1=1 and VSlipId='" + stVSlipId + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.Text;

            DataGrid1.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            DataGrid1.DataBind();
            conn.Close();



            //DataGrid2.DataSource = _dataSet.SparePart;
            //DataGrid2.DataBind();
            //_lastEditedPage = DataGrid2.CurrentPageIndex;


            
            txtAddrow.Text = "1";
            Inetialized();
            BindGrid();


           
            if (mDataCount == 0)
            {
                mDataCount = mDataCount + 1;
                Inetialized_AdvanceTaken();
                BindGrid();
            }
            txtAddRowAdv.Text = mDataCount.ToString();



            mDataCount = 0;
            if (mDataCount == 0)
            {
                mDataCount = mDataCount + 1;
                Inetialized_HSD_OIL_EXP();
                BindGrid();
            }
            txtAddRowOilExp.Text = mDataCount.ToString();


            mDataCount = 0;
            if (mDataCount == 0)
            {
                mDataCount = mDataCount + 1;
                Inetialized_Repair_Expense();
                BindGrid();
            }
            txtAddRowRepairExp.Text = mDataCount.ToString();



            mDataCount = 0;
            if (mDataCount == 0)
            {
                mDataCount = mDataCount + 1;
                Inetialized_Incidental_Ded();
                BindGrid();
            }
            txtAddRowIncidental.Text = mDataCount.ToString();



            conn.Close();
        }
        else
        {
            ReverseBind();
        }
    }

    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    }

    public void Inetialized_HSD_OIL_EXP()
    {
        _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "","", "", "", "", "", "");
    }

    public void Inetialized_Repair_Expense()
    {
        _dataSet.Repair_Expense.AddRepair_ExpenseRow("", "", "", "", "", "", "");
    }

    public void Inetialized_Incidental_Ded()
    {
        _dataSet.Incidental_Ded.AddIncidental_DedRow("", "", "", "", "", "", "");
    }

    protected void add_rowAdv(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;

        rowno = txtAddRowAdv.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            iroww = iroww + 1;
        }

        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }

        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.AdvanceTaken.RemoveAdvanceTakenRow(_dataSet.AdvanceTaken[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtAddRowAdv.Text); i++)
        {
            _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
        }

        BindGrid();

    }


    protected void add_rowOil(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddRowOilExp.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            iroww = iroww + 1;
        }
        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }


        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.HSD_OIL_EXP.RemoveHSD_OIL_EXPRow(_dataSet.HSD_OIL_EXP[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtAddRowOilExp.Text); i++)
        {
            _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "","", "", "", "", "", "");
        }

        BindGrid();

    }


    protected void add_rowRepair(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;

        rowno = txtAddRowRepairExp.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgRepairExp.Items)
        {
            iroww = iroww + 1;
        }
        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }

        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.Repair_Expense.RemoveRepair_ExpenseRow(_dataSet.Repair_Expense[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtAddRowRepairExp.Text); i++)
        {
            _dataSet.Repair_Expense.AddRepair_ExpenseRow("", "", "", "", "", "", "");
        }

        BindGrid();


    }

    protected void add_rowIncidental(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddRowIncidental.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgIncidental.Items)
        {
            iroww = iroww + 1;
        }

        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }

        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.Incidental_Ded.RemoveIncidental_DedRow(_dataSet.Incidental_Ded[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtAddRowIncidental.Text); i++)
        {
            _dataSet.Incidental_Ded.AddIncidental_DedRow("", "", "", "", "", "", "");
        }

        BindGrid();


    }

    protected void dgAdvanceDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {


        //DataSet ds1 = new DataSet();
        //SqlDataAdapter da1 = new SqlDataAdapter("select distinct Locname,Loccode from PRL_LOCATION where ActiveFlag='Y' Order By Locname", conn);
        //conn.Close();
        //da1.Fill(ds1, "PRL_LOCATION");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            /*DropDownList cboAdvPlace = ((DropDownList)e.Item.FindControl("cboAdvPlace"));
            cboAdvPlace.DataTextField = "Locname";
            cboAdvPlace.DataValueField = "Loccode";
            cboAdvPlace.DataSource = ds1.Tables["PRL_LOCATION"];
            cboAdvPlace.DataBind();
            cboAdvPlace.Items.Insert(0, "");*/
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            datarow_Adv = ((MyFleetDataSet.AdvanceTakenRow)((DataRowView)e.Item.DataItem).Row);

            //((DropDownList)e.Item.FindControl("cboAdvPlace")).SelectedValue = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvPlace")).Text = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvDt")).Text = datarow_Adv.AdvDt;
            ((TextBox)e.Item.FindControl("txtAdvAmt")).Text = datarow_Adv.AdvAmt;
            ((TextBox)e.Item.FindControl("txtTHCno")).Text = datarow_Adv.THCno;
            ((TextBox)e.Item.FindControl("txtBranchCode")).Text = datarow_Adv.BranchCode;
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow_Adv.Signature;

                
        }
    }

    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_HSDOIL = ((MyFleetDataSet.HSD_OIL_EXPRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtOilPlace")).Text = datarow_HSDOIL.OilPlace;

            ((TextBox)e.Item.FindControl("txtPPName")).Text = datarow_HSDOIL.PPName;


            ((TextBox)e.Item.FindControl("txtKM_Reading")).Text = datarow_HSDOIL.KM_Reading;
            ((TextBox)e.Item.FindControl("txtBillno")).Text = datarow_HSDOIL.Billno;
            ((TextBox)e.Item.FindControl("txtBilldt")).Text = datarow_HSDOIL.Billdt;
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Text = datarow_HSDOIL.Diesel_Ltr;
            ((TextBox)e.Item.FindControl("txtOil_Ltr")).Text = datarow_HSDOIL.Oil_Ltr;
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_HSDOIL.Amt;


        }

    }


    protected void dgRepairExp_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Repair = ((MyFleetDataSet.Repair_ExpenseRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtSupplier")).Text = datarow_Repair.Supplier;
            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_Repair.Desc;
            ((TextBox)e.Item.FindControl("txtQtn")).Text = datarow_Repair.Qtn;
            ((TextBox)e.Item.FindControl("txtRate_Unit")).Text = datarow_Repair.Rate_Unit;
            ((TextBox)e.Item.FindControl("txtRepairBillno")).Text = datarow_Repair.Billno;
            ((TextBox)e.Item.FindControl("txtRepairBilldt")).Text = datarow_Repair.Billdt;
            ((TextBox)e.Item.FindControl("txtRepairAmt")).Text = datarow_Repair.Amt;

        }

    }



    protected void dgIncidental_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_IncDed = ((MyFleetDataSet.Incidental_DedRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtIncdt")).Text = datarow_IncDed.Dt;
            ((TextBox)e.Item.FindControl("txtIncTripFrom")).Text = datarow_IncDed.TripPeriod_From;
            ((TextBox)e.Item.FindControl("txtIncTripTo")).Text = datarow_IncDed.TripPeriod_To;
            ((TextBox)e.Item.FindControl("txtVoucherNo")).Text = datarow_IncDed.VoucherNo;
            ((TextBox)e.Item.FindControl("txtVoucherDt")).Text = datarow_IncDed.VoucherDt;
            ((TextBox)e.Item.FindControl("txtRecvDt")).Text = datarow_IncDed.RecvDt;
            ((TextBox)e.Item.FindControl("txtIncAmt")).Text = datarow_IncDed.Amt;


        }

    }

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    protected void DataGrid2_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {

            _dataSet.PassDetail.RemovePassDetailRow(_dataSet.PassDetail[e.Item.DataSetIndex]);
            if (((DataGrid2.PageCount - DataGrid1.CurrentPageIndex) == 1 & DataGrid2.Items.Count == 1))
            {
                if ((DataGrid2.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            DataGrid2.CurrentPageIndex = _lastEditedPage;
            BindGrid();


        }

    }

    protected void DataGrid2_ItemDataBound(object sender, DataGridItemEventArgs e)
    {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct PartName,PartId from WEBX_FLEET_PARTMST where ActiveFlag='Y' Order By PartName", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_FLEET_PARTMST");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList cboPartName = ((DropDownList)e.Item.FindControl("cboPartName"));
            cboPartName.DataTextField = "PartName";
            cboPartName.DataValueField = "PartId";
            cboPartName.DataSource = ds1.Tables["WEBX_FLEET_PARTMST"];
            cboPartName.DataBind();
            cboPartName.Items.Insert(0, "");
        }

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            datarow_Spare = ((MyFleetDataSet.SparePartRow)((DataRowView)e.Item.DataItem).Row);

            ((DropDownList)e.Item.FindControl("cboPartName")).SelectedValue = datarow_Spare.Partno;
            ((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
            ((TextBox)e.Item.FindControl("txtRate")).Text = datarow_Spare.Rate;
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Spare.Amt;
            ((TextBox)e.Item.FindControl("txtRemark")).Text = datarow_Spare.Remark;

            //double value = double.Parse(DataBinder.Eval(e.Item.DataItem, "Amt").ToString());
            //sum += value;



        }
        else if (e.Item.ItemType == ListItemType.Footer)
        {
            //e.Item.Cells[0].Text = "<b>Total </b>";
            //((TextBox)e.Item.FindControl("txtTotalAmt")).Text = sum.ToString();

        }

    }

    


    /*protected void DataGrid2_ItemCreated(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Footer)
        {   
              e.Item.Cells[0].Text = "<b>Total </b>";
            ((TextBox)e.Item.FindControl("txtTotalAmt")).Text = sum.ToString();
        }
    } */


    private void ReverseBind()
    {
        MyFleetDataSet.SparePartRow datarow_Spare;

        foreach (DataGridItem gridrow in DataGrid2.Items)
        {
            datarow_Spare = _dataSet.SparePart[gridrow.DataSetIndex];
            //datarow_Spare.Partno = ((DropDownList)gridrow.FindControl("cboPartName")).Text;
            datarow_Spare.Partno = ((DropDownList)gridrow.FindControl("cboPartName")).SelectedItem.Value;
            datarow_Spare.Qty= ((TextBox)gridrow.FindControl("txtQty")).Text;
            datarow_Spare.Rate = ((TextBox)gridrow.FindControl("txtRate")).Text;
            datarow_Spare.Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
            datarow_Spare.Remark = ((TextBox)gridrow.FindControl("txtRemark")).Text;
            _dataSet.SparePart[gridrow.DataSetIndex].ItemArray = datarow_Spare.ItemArray;
        }
    }
    
    public void BindGrid()
    {
        DataGrid2.DataSource = _dataSet.SparePart;
        DataGrid2.DataBind();
        _lastEditedPage = DataGrid2.CurrentPageIndex;


        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;


        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;


        dgRepairExp.DataSource = _dataSet.Repair_Expense;
        dgRepairExp.DataBind();
        _lastEditedPage = dgRepairExp.CurrentPageIndex;


        dgIncidental.DataSource = _dataSet.Incidental_Ded;
        dgIncidental.DataBind();
        _lastEditedPage = dgIncidental.CurrentPageIndex;
    }



    public void Inetialized()
    {
        _dataSet.SparePart.AddSparePartRow("", "0", "0", "0", "");
    }

    protected void add_row(object sender, EventArgs e)
    {
        string rowno;
        rowno = txtAddrow.Text;
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in DataGrid2.Items)
        {
            iroww = iroww + 1;
        }

        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1; i--)
            {
                _dataSet.SparePart.RemoveSparePartRow(_dataSet.SparePart[i]);
            }
        }

        for (i = 0; i < Int16.Parse(txtAddrow.Text); i++)
        {
            _dataSet.SparePart.AddSparePartRow("", "0", "0", "0", "");
        }

        BindGrid();
    }

    protected void CalcAmt(object sender, EventArgs e)
    {
        
        /*
        double ContractAmt, OtherCharge, TDSRate,TDSAmt,AdvancePaid, CustIssueTot;
        double ContractDed, BalPaid,CustCloseTot;
        double CustNet;

        ContractAmt = Convert.ToDouble(txtContractAmt.Text.ToString());
        OtherCharge=Convert.ToDouble(txtOtherCharge.Text.ToString());
        TDSRate = Convert.ToDouble(txtTDSRate.Text.ToString());
        TDSAmt =((TDSRate / 100) * ContractAmt); //Convert.ToDouble(txtTDSAmt.Text.ToString());
        AdvancePaid = Convert.ToDouble(txtAdvancePaid.Text.ToString());
        txtTDSAmt.Text = TDSAmt.ToString();
        CustIssueTot = ContractAmt + OtherCharge - (TDSAmt + AdvancePaid);
        lblCustIssueTot.Text = CustIssueTot.ToString();


        ContractDed = Convert.ToDouble(txtContractDed.Text.ToString());
        BalPaid = Convert.ToDouble(txtBalPaid.Text.ToString());
        CustCloseTot = BalPaid - ContractDed;
        lblCustCloseTot.Text = CustCloseTot.ToString();


        CustNet = CustIssueTot + CustCloseTot;
        lblCustNet.Text = CustNet.ToString();


        double AdvDriver, ExpSpares, ExpFuel, Comm, ExpIssueTot;
        AdvDriver = Convert.ToDouble(txtAdvDriver.Text.ToString());
        ExpSpares = Convert.ToDouble(txtExpSpares.Text.ToString());
        ExpFuel = Convert.ToDouble(txtExpFuel.Text.ToString());
        Comm = Convert.ToDouble(txtComm.Text.ToString());
        ExpIssueTot = AdvDriver + ExpSpares + ExpFuel + Comm;
        lblExpIssueTot.Text = ExpIssueTot.ToString();


        double BalDriver, Incentive, Deposit, ExpenseDed, ExpCloseTot;
        double ExpTot;

        
        BalDriver = Convert.ToDouble(txtBalDriver.Text.ToString());
        Incentive = Convert.ToDouble(txtIncentive.Text.ToString());
        Deposit = Convert.ToDouble(txtDeposit.Text.ToString());
        ExpenseDed = Convert.ToDouble(txtExpenseDed.Text.ToString());
        ExpCloseTot = BalDriver + Incentive + Deposit - ExpenseDed;
        lblExpCloseTot.Text = ExpCloseTot.ToString();
        
        ExpTot=ExpIssueTot+ExpCloseTot;
        lblExpTot.Text = ExpTot.ToString();
        */    

        
    }

    protected void SpareCalc(object sender, EventArgs e)
    {
        
        
        double mQty, mRate, mAmt,mTotAmt;
        mTotAmt = 0;
        MyFleetDataSet.SparePartRow datarow_Spare;

        foreach (DataGridItem gridrow in DataGrid2.Items)
        {
           
            datarow_Spare = _dataSet.SparePart[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                TextBox tbQty = (TextBox)DataGrid2.Items[gridrow.ItemIndex].FindControl("txtQty");
                TextBox tbRate = (TextBox)DataGrid2.Items[gridrow.ItemIndex].FindControl("txtRate");
                TextBox tbAmt = (TextBox)DataGrid2.Items[gridrow.ItemIndex].FindControl("txtAmt");
                
                if (tbQty.ClientID == ((TextBox)sender).ClientID)
                {
                    mQty = Convert.ToDouble(tbQty.Text.ToString());
                    mRate = Convert.ToDouble(tbRate.Text.ToString());
                    mAmt = mQty * mRate;
                    mTotAmt = Convert.ToDouble(mTotAmt) + Convert.ToDouble(mAmt);
                    tbAmt.Text = mAmt.ToString();
                }

                if (tbRate.ClientID == ((TextBox)sender).ClientID)
                {
                    mQty = Convert.ToDouble(tbQty.Text.ToString());
                    mRate = Convert.ToDouble(tbRate.Text.ToString());
                    mAmt = mQty * mRate;
                    mTotAmt = Convert.ToDouble(mTotAmt) + Convert.ToDouble(mAmt);
                    tbAmt.Text = mAmt.ToString();
                }

                _dataSet.SparePart[gridrow.DataSetIndex].ItemArray = datarow_Spare.ItemArray;

            }
            //txtExpSpares.Text = mTotAmt.ToString();
            
        }



       
    }

    protected void SubmitData(object sender, EventArgs e)
    {

        double mTotAdvExp = 0;
        double mTotOilExp = 0;
        double mTotRepairExp = 0;
        double mTotIncDedExp = 0;

        string mTripSheetNo = "";
        string sql = "";
        string sqlDEL = "";
        SqlCommand cmdDEL = new SqlCommand();


        lblError.Text = "";
        string StartKM, CloseKM;
        double mStartKM, mCloseKM;
        //string mReqId = "";
        //txtCloseKM

        StartKM = lblStartKm.Text;
        CloseKM = txtCloseKM.Text;

        mStartKM = Convert.ToDouble(StartKM.ToString());
        mCloseKM = Convert.ToDouble(CloseKM.ToString());


        if (mCloseKM < mStartKM)
        {

            lblError.Text = "Closing KM should be greater than Starting KM.";
        }
        
        if (lblError.Text == "")
        {

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";

        mTripSheetNo = lblIssueNo.Text.ToString();


        bool success = false;
        SqlTransaction trans;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        trans = conn.BeginTransaction();
        try
        {
            SqlCommand cmd = new SqlCommand("usp_CloseVehicleIssue", conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
            cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = Session["strDriverCode"].ToString();
            cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.ToString();
            
            cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtCloseKM.Text.ToString();
            cmd.Parameters.Add("@f_closure_fill", SqlDbType.Float).Value = txtFuelFilledEnroute.Text.ToString();
            cmd.Parameters.Add("@Contractamt", SqlDbType.Float).Value = "0";// txtContractAmt.Text.ToString();
            cmd.Parameters.Add("@c_Othercharg", SqlDbType.Float).Value = "0";// txtOtherCharge.Text.ToString();
            cmd.Parameters.Add("@c_TDSrate", SqlDbType.Float).Value = "0";// txtTDSRate.Text.ToString();
            cmd.Parameters.Add("@c_TDSamt", SqlDbType.Float).Value = "0";//txtTDSAmt.Text.ToString();
            cmd.Parameters.Add("@c_TDStype", SqlDbType.VarChar).Value = "0";// txtTDSType.Text.ToString();
            cmd.Parameters.Add("@c_Advamt_paid", SqlDbType.Float).Value = "0";// txtAdvancePaid.Text.ToString();
            cmd.Parameters.Add("@c_issue_tot", SqlDbType.Float).Value = "0";//lblCustIssueTot.Text.ToString();
            cmd.Parameters.Add("@c_dedamt", SqlDbType.Float).Value = "0";//txtContractDed.Text.ToString();
            cmd.Parameters.Add("@c_Balamt_paid", SqlDbType.Float).Value = "0";// txtBalPaid.Text.ToString();
            cmd.Parameters.Add("@c_closure_tot", SqlDbType.Float).Value = "0";// lblCustIssueTot.Text.ToString();
            cmd.Parameters.Add("@c_net_amt", SqlDbType.Float).Value = "0";// lblCustNet.Text.ToString();

            cmd.Parameters.Add("@e_issue_advamt", SqlDbType.Float).Value = "0";// txtAdvDriver.Text.ToString();
            cmd.Parameters.Add("@e_issue_spare", SqlDbType.Float).Value = "0";// txtExpSpares.Text.ToString();
            cmd.Parameters.Add("@e_issue_fuel", SqlDbType.Float).Value = "0";// txtExpFuel.Text.ToString();
            cmd.Parameters.Add("@e_issue_comm", SqlDbType.Float).Value = "0";// txtComm.Text.ToString();
            cmd.Parameters.Add("@e_closure_balamt", SqlDbType.Float).Value = "0";// txtBalDriver.Text.ToString();
            cmd.Parameters.Add("@e_closure_incentive", SqlDbType.Float).Value = "0";//txtIncentive.Text.ToString();
            cmd.Parameters.Add("@e_closure_deposit", SqlDbType.Float).Value = "0";// txtDeposit.Text.ToString();
            cmd.Parameters.Add("@e_closure_dedamt", SqlDbType.Float).Value = "0";// txtExpenseDed.Text.ToString();
            cmd.Parameters.Add("@e_issue_totamt", SqlDbType.Float).Value = "0";// lblExpIssueTot.Text.ToString();
            cmd.Parameters.Add("@e_closure_totamt", SqlDbType.Float).Value = "0";// lblExpCloseTot.Text.ToString();
            cmd.Parameters.Add("@e_net_amt", SqlDbType.Float).Value = "0";// lblExpTot.Text.ToString();



            cmd.ExecuteNonQuery();

            Session["strDriverCode"] = null;


            foreach (DataGridItem gridrow in DataGrid2.Items)
            {
                SqlCommand Detail = new SqlCommand("usp_AddSpareDetails", conn, trans);
                Detail.CommandType = CommandType.StoredProcedure;

                string PartId = ((DropDownList)gridrow.FindControl("cboPartName")).SelectedValue;
                string Qty = ((TextBox)gridrow.FindControl("txtQty")).Text;
                string rate = ((TextBox)gridrow.FindControl("txtRate")).Text;
                string Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                string remark = ((TextBox)gridrow.FindControl("txtRemark")).Text;

                datarow_Spare = _dataSet.SparePart[gridrow.DataSetIndex];


                Detail.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
                Detail.Parameters.Add("@PartId", SqlDbType.VarChar).Value = PartId.ToString();
                Detail.Parameters.Add("@Qty", SqlDbType.Float).Value = Qty.ToString();
                Detail.Parameters.Add("@rate", SqlDbType.Float).Value = rate.ToString();
                Detail.Parameters.Add("@Amt", SqlDbType.Float).Value = Amt.ToString();
                Detail.Parameters.Add("@remark", SqlDbType.VarChar).Value = remark.ToString();

                _dataSet.SparePart[gridrow.DataSetIndex].ItemArray = datarow_Spare.ItemArray;

                Detail.ExecuteNonQuery();
            }



            sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();

            foreach (DataGridItem gridrow in dgAdvanceDet.Items)
            {
                //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;
                string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                DateTime mAdvDt = new DateTime();
                mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                string mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;

                mTotAdvExp = mTotAdvExp + Convert.ToDouble(mAdvAmt);

                string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                string mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;


                sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,THCno,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature) values ("
                     + "'" + mTripSheetNo + "','" + mTHCno + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "') ";
                SqlCommand AdvDetail = new SqlCommand(sql, conn, trans);
                AdvDetail.CommandType = CommandType.Text;

                datarow_Adv = _dataSet.AdvanceTaken[gridrow.DataSetIndex];

                _dataSet.AdvanceTaken[gridrow.DataSetIndex].ItemArray = datarow_Adv.ItemArray;

                AdvDetail.ExecuteNonQuery();
            }




            sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();

            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                string mPPName = ((TextBox)gridrow.FindControl("txtPPName")).Text;
                string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                string mBillno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);

                string mDiesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
                string mOil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
                string mAmt = ((TextBox)gridrow.FindControl("txtAmt")).Text;

                mTotOilExp = mTotOilExp + Convert.ToDouble(mAmt);


                sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,PetrolPName,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount) values ( "
                     + "'" + mTripSheetNo + "', '" + mOilPlace + "','" + mPPName + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "') ";
                SqlCommand HSDOilDetail = new SqlCommand(sql, conn, trans);
                HSDOilDetail.CommandType = CommandType.Text;

                datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];

                _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;

                HSDOilDetail.ExecuteNonQuery();


            }

            string mActual_KMPL = txtActual_KMPL.Text;
            string mActual_Approved = txtKMPL_Approved.Text;
            string mApproved_Ltr = txtApprovedLtrs.Text;
            string mApproved_Rate = txtApprovedRate.Text;
            string mApproved_Amt = txtApprovedAmt.Text;
            string mAmount = txtAmt.Text;


            sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPHDR where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();


            sql = " Insert into WEBX_TRIPSHEET_OILEXPHDR (TripSheetNo,Actual_KMPL,Actual_Approved,Approved_Ltr,Approved_Rate,Approved_Amt,Amount) values ( "
                    + "'" + mTripSheetNo + "','" + mActual_KMPL + "','" + mActual_Approved + "','" + mApproved_Ltr + "','" + mApproved_Rate + "','" + mApproved_Amt + "','" + mAmount + "') ";
            SqlCommand HSDOilHeader = new SqlCommand(sql, conn, trans);
            HSDOilHeader.CommandType = CommandType.Text;
            HSDOilHeader.ExecuteNonQuery();





            sqlDEL = "Delete from WEBX_TRIPSHEET_REPAIREXP where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();

            foreach (DataGridItem gridrow in dgRepairExp.Items)
            {
                string mSupplier = ((TextBox)gridrow.FindControl("txtSupplier")).Text;
                string mDesc = ((TextBox)gridrow.FindControl("txtDesc")).Text;
                string mQtn = ((TextBox)gridrow.FindControl("txtQtn")).Text;
                string mRate_Unit = ((TextBox)gridrow.FindControl("txtRate_Unit")).Text;


                string mBillno = ((TextBox)gridrow.FindControl("txtRepairBillno")).Text;
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtRepairBilldt")).Text, dtfi);

                string mAmt = ((TextBox)gridrow.FindControl("txtRepairAmt")).Text;
                mTotRepairExp = mTotRepairExp + Convert.ToDouble(mAmt);

                sql = " Insert into WEBX_TRIPSHEET_REPAIREXP (TripSheetNo,Supplier,SuppDesc,Qtn,Rate_Unit,BillNo,BillDt,Amt) values ( "
                     + "'" + mTripSheetNo + "','" + mSupplier + "','" + mDesc + "','" + mQtn + "','" + mRate_Unit + "','" + mBillno + "','" + mBilldt + "','" + mAmt + "')";
                SqlCommand RepairExpDetail = new SqlCommand(sql, conn, trans);
                RepairExpDetail.CommandType = CommandType.Text;

                datarow_Repair = _dataSet.Repair_Expense[gridrow.DataSetIndex];

                _dataSet.Repair_Expense[gridrow.DataSetIndex].ItemArray = datarow_Repair.ItemArray;

                RepairExpDetail.ExecuteNonQuery();

            }



            sqlDEL = "Delete from WEBX_TRIPSHEET_INCDED where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();

            foreach (DataGridItem gridrow in dgIncidental.Items)
            {

                DateTime mDt = new DateTime();
                mDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtIncdt")).Text, dtfi);


                DateTime mTripPeriod_From = new DateTime();
                mTripPeriod_From = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtIncTripFrom")).Text, dtfi);

                DateTime mTripPeriod_To = new DateTime();
                mTripPeriod_To = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtIncTripTo")).Text, dtfi);

                string mVoucherNo = ((TextBox)gridrow.FindControl("txtVoucherNo")).Text;

                DateTime mVoucherDt = new DateTime();
                mVoucherDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtVoucherDt")).Text, dtfi);

                DateTime mRecvDt = new DateTime();
                mRecvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtRecvDt")).Text, dtfi);

                string mAmt = ((TextBox)gridrow.FindControl("txtIncAmt")).Text;
                mTotIncDedExp = mTotIncDedExp + Convert.ToDouble(mAmt);


                sql = " Insert into WEBX_TRIPSHEET_INCDED (TripSheetNo,IncDt,TripFromDt,TripToDt,VoucherNo,VoucherDt,RecdDt,Amt) values ( "
                     + "'" + mTripSheetNo + "','" + mDt + "','" + mTripPeriod_From + "','" + mTripPeriod_To + "','" + mVoucherNo + "','" + mVoucherDt + "','" + mRecvDt + "','" + mAmt + "')";
                SqlCommand IncDedExpDetail = new SqlCommand(sql, conn, trans);
                IncDedExpDetail.CommandType = CommandType.Text;

                datarow_IncDed = _dataSet.Incidental_Ded[gridrow.DataSetIndex];

                _dataSet.Incidental_Ded[gridrow.DataSetIndex].ItemArray = datarow_IncDed.ItemArray;

                IncDedExpDetail.ExecuteNonQuery();

            }


            string mPreparedBy = txtPreparedBy.Text;
            string mCheckedBy = txtCheckedBy.Text;
            string mApprovedBy = txtApprovedBy.Text;
            string mAuditedBy = txtAuditedBy.Text;

            sql = " Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + mTotAdvExp + "',TotOilExp='" + mTotOilExp + "',TotRepairExp='" + mTotRepairExp + "',TotIncDedExp='" + mTotIncDedExp + "', PreparedBy='" + mPreparedBy + "',CheckedBy='" + mCheckedBy + "',ApprovedBy='" + mApprovedBy + "',AuditedBy='" + mAuditedBy + "' Where VSlipNo ='" + mTripSheetNo + "' ";
            SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
            TripHeader.CommandType = CommandType.Text;
            TripHeader.ExecuteNonQuery();




            trans.Commit();
            success = true;
        }
        catch (Exception e1)
        {
            Response.Write("Error" + e1.Message);
            trans.Rollback();
            Response.End();
        }
        finally
        {
            conn.Close();
        }
        if (success)
            Response.Redirect("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString(), true);
        
        }

    }
  
}
