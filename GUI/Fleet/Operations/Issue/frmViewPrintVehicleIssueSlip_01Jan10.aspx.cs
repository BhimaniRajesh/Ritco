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

public partial class Issue_frmViewPrintVehicleIssueSlip : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);


    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    MyFleetDataSet.EnExpenseRow datarow_EnExp;
    int _lastEditedPage;
    string strVSlipNo = "";
    string sql = "";
    string DataFound = "N";
    Double TotalAdv = 0;
    Double sum = 0, sum1 = 0, msum = 0, msum1 = 0, msum2 = 0, msum3 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        strVSlipNo = Request.QueryString["VSlipNo"].Trim();



        if (!IsPostBack)
        {
            Session["VSlipNo"] = strVSlipNo;

            BindGrid();
            CheckTripSheet();

            TripJourneyDetails();

      
            if (DataFound == "Y")
            {

                table1.Visible = true;
               // HyperLink1.Visible = true;
                 Link11.Visible = true;

            }






        }
        
    }

    protected void dgTHC_RowDataBound(object sender, DataGridItemEventArgs e)
    {
        //  if (e.Item.ItemType == DataControlRowType.)
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            string Freight = Convert.ToString(e.Item.Cells[5].Text);
            string Lab = Convert.ToString(e.Item.Cells[6].Text);
            string Other = Convert.ToString(e.Item.Cells[7].Text);
            string Total = Convert.ToString(e.Item.Cells[8].Text);
            if (Freight == "")
            {
                Freight = "0";
            }


            if (Lab == "")
            {

                Lab = "0";

            }
            if (Other == "")
            {
                Other = "0";
            }

            if (Total == "")
            {
                Total = "0";
            }


            Double FreAmt = Convert.ToDouble(Freight);
            msum = msum + (FreAmt);
            // sum += Convert.ToDouble(cellValue);

            Double LabAmt = Convert.ToDouble(Lab);
            msum1 = msum1 + (LabAmt);






            Double OthAmt = Convert.ToDouble(Other);
            msum2 = msum2 + (OthAmt);

            Double TotAmt = Convert.ToDouble(Total);
            msum3 = msum3 + (TotAmt);



        }

        if (e.Item.ItemType == ListItemType.Footer)
        {
            e.Item.Cells[0].Text = "<b>Total</b>";
            //  e.Item.Cells(0).Text = "Total";
            //e.Item.Cells(8).Text = Format(sum, " ");
            //e.Item.Cells(9).Text = Format(sum_price, " ");

            e.Item.Cells[5].Font.Bold = true;
            e.Item.Cells[6].Font.Bold = true;
            e.Item.Cells[7].Font.Bold = true;
            e.Item.Cells[8].Font.Bold = true;

            e.Item.Cells[5].Text = Convert.ToString(msum);
            e.Item.Cells[6].Text = Convert.ToString(msum1);
            e.Item.Cells[7].Text = Convert.ToString(msum2);
            e.Item.Cells[8].Text = Convert.ToString(msum3);



        }
    }
    public void TripJourneyDetails()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        conn.Open();



     //   SqlCommand cmd = new SqlCommand("usp_Webx_Get_TripSheetDetails", conn);
          SqlCommand cmd = new SqlCommand("usp_ViewTripsheetTHC_Summary", conn);


        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = strVSlipNo;
        DataSet ds = new DataSet();


        da.Fill(ds);


        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();

        //   Session["VSlipNo"] = null;

    }

    public void ExpSummary()
    {





    }

  






    public void CheckTripSheet()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();






        SqlCommand cmd = new SqlCommand("usp_Webx_Get_TripSheetDetails", conn);


        cmd.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = strVSlipNo;
        cmd.CommandType = CommandType.StoredProcedure;
        
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                DataFound = "Y";

            }
        }
        dr.Close();
        conn.Close();


    }


    


    private void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        sql = " Select Request_id,convert(varchar,Request_Dt,103) Request_Dt,Request_by,CategoryName=(select categoryname from WEBX_FLEET_CATEGORY where categorycode=category_id)"
                + " ,orgn_address "
                + " ,Orgn_city=(select location from webx_citymaster where city_code=Orgn_city),Orgn_pin "
                + ",Orgn_Phone,Orgn_Email "
                + ",Orgn_Loccode=(select pickup_locname from webx_PICKUP_Location where pickup_loccode=Orgn_Loccode) "
                + ",Destn_address "
                + ",Destn_city=(select location from webx_citymaster where city_code=Destn_city),Destn_pin "
                + ",Destn_Phone,Destn_Email "
                + ",Destn_Loccode=(select pickup_locname from webx_PICKUP_Location where pickup_loccode=Destn_Loccode) "
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
                + "   from webx_fleet_vehicle_request where 1=1 and VSlipId='" + strVSlipNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.Text;

        DataGrid1.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataGrid1.DataBind();
        cmd.Dispose();
        conn.Close();


        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = " select (select Partname from WEBX_FLEET_PARTMST where PartId=V.PartId)PartId,Qty,"
             + "  Rate,Amt,Remark from WEBX_FLEET_VEHICLE_ISSUE_PARTDET V "
             + " Where VSlipNo='" + strVSlipNo + "'";
        SqlCommand cmd1 = new SqlCommand(sql, conn);
        cmd1.CommandType = CommandType.Text;
        DataGrid2.DataSource = cmd1.ExecuteReader(CommandBehavior.CloseConnection);
        DataGrid2.DataBind();
        cmd1.Dispose();
        conn.Close();


        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = " Select AdvLoc,convert(varchar,AdvDate,106)AdvDate,AdvAmt,THCno,BranchCode,Signature from WEBX_TRIPSHEET_ADVEXP "
            + " Where TripSheetNo='" + strVSlipNo + "'";
        SqlCommand cmd2 = new SqlCommand(sql, conn);
        cmd2.CommandType = CommandType.Text;
        dgAdvanceDet.DataSource = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
        dgAdvanceDet.DataBind();
        cmd2.Dispose();
        conn.Close();


        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = " Select Place,KM_Reading,BillNo,convert(varchar,BillDt,106)BillDt,Diesel_Ltr,Oil_Ltr,Diesel_Rate,Oil_Rate,Exe_Amt,Remark,Card_Cash,Last_Km_Read,FuelType,Brand,PetrolPName,Amount from WEBX_TRIPSHEET_OILEXPDET "
            + " Where TripSheetNo='" + strVSlipNo + "'";
        SqlCommand cmd3 = new SqlCommand(sql, conn);
        cmd3.CommandType = CommandType.Text;
        dgHSD_OIL_EXP.DataSource = cmd3.ExecuteReader(CommandBehavior.CloseConnection);
        dgHSD_OIL_EXP.DataBind();
        cmd3.Dispose();
        conn.Close();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
        //conn.Open();
        //sql = " Select * from WEBX_TRIPSHEET_OILEXPHDR "
        //    + " Where TripSheetNo='" + strVSlipNo + "'";
        //SqlCommand cmd4 = new SqlCommand(sql, conn);
        //cmd4.CommandType = CommandType.Text;
        //SqlDataReader dr = cmd4.ExecuteReader();
        //while (dr.Read())
        //{
        //    lblActual_KMPL.Text = dr["Actual_KMPL"].ToString();
        //    lblKMPL_Approved.Text = dr["Actual_Approved"].ToString();
        //    lblApprovedLtrs.Text = dr["Approved_Ltr"].ToString();
        //    lblApprovedRate.Text = dr["Approved_Rate"].ToString();
        //    lblApprovedAmt.Text = dr["Approved_Amt"].ToString();
        //    lblAmt.Text = dr["Amount"].ToString();
        //}
        //dr.Close();
        //conn.Close();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = " Select Supplier,SuppDesc,Qtn,Rate_Unit,BillNo,convert(varchar,BillDt,106)BillDt,Amt from WEBX_TRIPSHEET_REPAIREXP "
            + " Where TripSheetNo='" + strVSlipNo + "'";
        SqlCommand cmd5 = new SqlCommand(sql, conn);
        cmd5.CommandType = CommandType.Text;
        dgRepairExp.DataSource = cmd5.ExecuteReader(CommandBehavior.CloseConnection);
        dgRepairExp.DataBind();
        cmd5.Dispose();
        conn.Close();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = " Select convert(varchar,IncDt,103)IncDt,convert(varchar,TripFromDt,106)TripFromDt,convert(varchar,TripToDt,103)TripToDt,VoucherNo,convert(varchar,VoucherDt,103)VoucherDt,convert(varchar,RecdDt,103)RecdDt,Amt from WEBX_TRIPSHEET_INCDED "
            + " Where TripSheetNo='" + strVSlipNo + "'";
        SqlCommand cmd6 = new SqlCommand(sql, conn);
        cmd6.CommandType = CommandType.Text;
        dgIncidental.DataSource = cmd6.ExecuteReader(CommandBehavior.CloseConnection);
        dgIncidental.DataBind();
        cmd6.Dispose();
        conn.Close();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        



        sql = "select    Tripsheetno, (select codedesc from Webx_Master_General where CodeType='FULEXP'  "
            + " and  CodeId=convert(varchar,E.id)) + ' ('+polarity+')'  as NExp ,"
             + "Amount_spent as Amount,BillNo,convert(varchar,Dt,106) Date ,Exe_Appr_Amt as Exe_Amt ,Remarks from WEBX_FLEET_ENROUTE_EXP E"
            + "  where Tripsheetno='" + strVSlipNo + "' ";
             
        SqlCommand cmd8 = new SqlCommand(sql, conn);
        cmd8.CommandType = CommandType.Text;
        cmd8.CommandType = CommandType.Text;
        dgEnroute.DataSource = cmd8.ExecuteReader(CommandBehavior.CloseConnection);
        dgEnroute.DataBind();
        cmd8.Dispose();
        conn.Close();





        // New 


        conn.Open();


        

        sql = "select    Tripsheetid, Nature ,No_Of_Packs,Weight,Approx_Value"
                        + "  from WEBX_TRIPSHEET_CLAIMS "
            + "  where Tripsheetid='" + strVSlipNo + "' ";

        SqlCommand cmd9 = new SqlCommand(sql, conn);
        cmd9.CommandType = CommandType.Text;
        cmd9.CommandType = CommandType.Text;
        dgClaims.DataSource = cmd9.ExecuteReader(CommandBehavior.CloseConnection);
        dgClaims.DataBind();
        cmd9.Dispose();
        conn.Close();











        conn.Open();
        sql = " Select * from WEBX_FLEET_VEHICLE_ISSUE "
            + " Where VSlipNo='" + strVSlipNo + "'";
        SqlCommand cmd7 = new SqlCommand(sql, conn);
        cmd7.CommandType = CommandType.Text;
        SqlDataReader dr1 = cmd7.ExecuteReader();
        while (dr1.Read())
        {
            lblPreparedBy.Text = dr1["PreparedBy"].ToString();
            lblCheckedBy.Text = dr1["CheckedBy"].ToString();
            lblApprovedBy.Text = dr1["ApprovedBy"].ToString();
            lblAuditedBy.Text = dr1["AuditedBy"].ToString();
        }
        dr1.Close();
        conn.Close();




        //conn.Open();
        //sql = " Select Supplier,SuppDesc,Qtn,Rate_Unit,BillNo,convert(varchar,BillDt,103)BillDt,Amt from WEBX_TRIPSHEET_REPAIREXP "
        //    + " Where TripSheetNo='" + strVSlipNo + "'";
        //SqlCommand cmd5 = new SqlCommand(sql, conn);
        //cmd5.CommandType = CommandType.Text;
        //dgRepairExp.DataSource = cmd5.ExecuteReader(CommandBehavior.CloseConnection);
        //dgRepairExp.DataBind();
        //cmd5.Dispose();
        //conn.Close();






        // New Change



        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = "select  ADVLoc ,  ADVAmt  from  WEBX_TRIPSHEET_ADVEXP  where  TripsheetNo ='" + strVSlipNo + "'";
  
        SqlCommand cmd10 = new SqlCommand(sql, conn);
        cmd10.CommandType = CommandType.Text;
        dgAdvSummary.DataSource = cmd10.ExecuteReader(CommandBehavior.CloseConnection);
        dgAdvSummary.DataBind();
        cmd10.Dispose();
        conn.Close();







        conn.Open();
        sql = "select 'HSD/OIL Expenses' As Expenses, IsNull(sum(convert(numeric,H.Amount)),0) as Amount, sum(Convert(numeric,H.Exe_Amt)) as ApprovedAmount from WEBX_TRIPSHEET_OILEXPDET H  where TripsheetNo='" + strVSlipNo + "'"
     + "  Union"
     + "  select 'Repair Expenses' As Expenses, IsNull(sum(convert(numeric,Amt)),0) As Amount, 0 As ApprovedAmount   from WEBX_TRIPSHEET_REPAIREXP  where TripsheetNo='" + strVSlipNo + "' "
     + " Union  "
      + " select 'Incidental Deduction' As Expenses, IsNull(sum(convert(numeric,I.Amt)),0) as Amount, 0 As ApprovedAmount from WEBX_TRIPSHEET_INCDED I where TripsheetNo='" + strVSlipNo + "' "
     + " Union "
     + " select  'En-route Expenses' As Expenses,isnull(sum(convert(numeric(18,2),ExpMst.Polarity + convert(varchar,Amount_Spent))),0) as Amount_Spent,isnull(sum(convert(numeric(18,2),ExpMst.Polarity + convert(varchar,Exe_Appr_Amt))),0) as Exe_Appr_Amt from WEBX_FLEET_ENROUTE_EXP as EnExp right Outer join Webx_Trip_Expense_Master as ExpMst On EnExp.Id=ExpMst.Id where TripsheetNo='" + strVSlipNo + "' "


        +" Union "
            + "  select 'Spare Part Expenses' As Expenses, IsNull(sum(convert(numeric,Amt)),0) as   Amount,0 As ApprovedAmount from WEBX_FLEET_VEHICLE_ISSUE_PARTDET  where VSlipNo='" + strVSlipNo + "' ";




        SqlCommand cmd11 = new SqlCommand(sql, conn);
        cmd11.CommandType = CommandType.Text;
        dgExpense.DataSource = cmd11.ExecuteReader(CommandBehavior.CloseConnection);
       
        dgExpense.DataBind();
       //  dgExpense
        cmd11.Dispose();
        conn.Close();




        conn.Open();


        sql = "select  *  from WEBX_FLEET_TRIPTHCDET  where  TripsheetNo='" + strVSlipNo + "'";

        SqlCommand cmd13 = new SqlCommand(sql, conn);
        cmd13.CommandType = CommandType.Text;
        dgTHC.DataSource = cmd13.ExecuteReader(CommandBehavior.CloseConnection);
        dgTHC.DataBind();
        cmd13.Dispose();




        conn.Close();



        //conn.Open();


        //sql = "select  sum(convert(numeric,Amt)) as HAmount ,  from WEBX_TRIPSHEET_REPAIREXP   where  TripsheetNo='" + strVSlipNo + "'";

        //SqlCommand cmd12 = new SqlCommand(sql, conn);
        //cmd12.CommandType = CommandType.Text;
        //dgExpense.DataSource = cmd12.ExecuteReader(CommandBehavior.CloseConnection);
        //dgExpense.DataBind();
        //cmd12.Dispose();




        //conn.Close();






    }



    //protected void LinkButton1_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("frmTripSheetDetails.aspx?strVSlipNo=" + strVSlipNo);


    //                    //Response.Redirect("~/TYRE1/ServiceResult.aspx?mTyreNo=" + mTyreNo);
    //}
    protected void dgAdvSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Amt = Convert.ToString(e.Row.Cells[1].Text);
 

            if (Amt =="")
            {
               Amt = "0";
            }
          
            Double AmtValue = Convert.ToDouble(Amt);
            TotalAdv = TotalAdv + (AmtValue);
            // sum += Convert.ToDouble(cellValue);


        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "<b>Total</b>";
            //  e.Item.Cells(0).Text = "Total";
            //e.Item.Cells(8).Text = Format(sum, " ");
            //e.Item.Cells(9).Text = Format(sum_price, " ");

            e.Row.Cells[1].Font.Bold = true;
            e.Row.Cells[1].Text = Convert.ToString(TotalAdv);
          



        }
    }





    protected void dgExpense_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Amt = Convert.ToString(e.Row.Cells[1].Text);
            string AppAmt = Convert.ToString(e.Row.Cells[2].Text);
            if (AppAmt == "&nbsp;")
            {
                AppAmt = "0";
            }
            //     string cellValue = (DataBinder.Eval(e.Row.DataItem, "NetAmt")).ToString(); 

            // string cellValue = Convert.ToString(cellValue1);

            if (Amt == "")
            {

                Amt = "0";

            }
            if (AppAmt == "")
            {
                AppAmt = "0";
            }
            Double AmtValue = Convert.ToDouble(Amt);
            sum = sum + (AmtValue);
            // sum += Convert.ToDouble(cellValue);

            Double AppValue = Convert.ToDouble(AppAmt);
            sum1 = sum1 + (AppValue);



        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "<b>Total</b>";
            //  e.Item.Cells(0).Text = "Total";
            //e.Item.Cells(8).Text = Format(sum, " ");
            //e.Item.Cells(9).Text = Format(sum_price, " ");

            e.Row.Cells[2].Font.Bold = true;
            e.Row.Cells[1].Text = Convert.ToString(sum);
            e.Row.Cells[2].Text = Convert.ToString(sum1);



        }
    }










}
