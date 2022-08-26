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
using System.Text;
using System.IO;


public partial class GUI_Fleet_Reports_TripResult : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();


        if (!IsPostBack)
        {

            //Do Work
        }


    }

   /* protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) //this will fire on each row of the datasource 
    {
         // (our datatable in this case) being bound to the GridView. 
        Label img = new Label();

        e.Row.Cells[0].Controls.Add(img);
        img.Attributes.Add("onclick", "javascript: return fun()");

       
    }
*/


    public    void BindGrid()
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable("GridView1");

        DataColumn newColumn;
        //dt.Columns.Add(new DataColumn("ID", typeof(string)));
        


        newColumn = dt.Columns.Add("Tripsheet No", Type.GetType("System.String"));
        
        
        newColumn = dt.Columns.Add("Manual No", Type.GetType("System.String"));

          string [] selvaluesArr1;
          string[] selvaluesArr2;
          string[] selvaluesArr3;

        string Status=Session["Stat"].ToString().Trim();

        string Exp = Session["Exp"].ToString().Trim();


        string Enroute = Session["Enroute"].ToString().Trim();


          selvaluesArr1 = Status.Split(new char[] { ',' });
        int maxarr1 = selvaluesArr1.GetUpperBound(0);
        for (int i = 0; i <= maxarr1; i++)
        {

            string  Value=selvaluesArr1[i].ToString().Trim();

            if(Value.Trim()=="SDate")
            {
            newColumn=dt.Columns.Add("Tripsheet Start Date", Type.GetType("System.String"));
            }
              if(Value.Trim()=="EndDate")
            {
            newColumn=dt.Columns.Add("Tripsheet End Date", Type.GetType("System.String"));
            }

              if(Value.Trim()=="StLoc")
            {
            newColumn=dt.Columns.Add("Start Location", Type.GetType("System.String"));
            }

              if(Value.Trim()=="EndLoc")
            {
            newColumn=dt.Columns.Add("End Location", Type.GetType("System.String"));
            }

              if(Value.Trim()=="VehCat")
            {
            newColumn=dt.Columns.Add("Vehicle Category", Type.GetType("System.String"));
            }

              if(Value.Trim()=="DName")
            {
            newColumn=dt.Columns.Add("Driver Name", Type.GetType("System.String"));
            }

            if(Value.Trim()=="Cat")
            {
            newColumn=dt.Columns.Add("Category", Type.GetType("System.String"));
            }

              if(Value.Trim()=="Vehno")
            {
            newColumn=dt.Columns.Add("Vehicle No", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Stat")
            {
            newColumn=dt.Columns.Add("Status", Type.GetType("System.String"));
            }

            if (Value.Trim() == "StartKM")
            {
                newColumn = dt.Columns.Add("Starting KM", Type.GetType("System.String"));
            }

            if (Value.Trim() == "CloseKM")
            {
                newColumn = dt.Columns.Add("Closing KM", Type.GetType("System.String"));
            }
            if (Value.Trim() == "TotKM")
            {
                newColumn = dt.Columns.Add("Total KM", Type.GetType("System.String"));
            }

            if (Value.Trim() == "AppKMPL")
            {
                newColumn = dt.Columns.Add("Approved KMPL", Type.GetType("System.String"));
            }

            if (Value.Trim() == "ActKMPL")
            {
                newColumn = dt.Columns.Add("Actual KMPL", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Dsl")
            {
                newColumn = dt.Columns.Add("Diesel Quantity", Type.GetType("System.String"));
            }

            // new 
            if (Value.Trim() == "BillStat")
            {
                newColumn = dt.Columns.Add("Bill Prepared Y/N", Type.GetType("System.String"));
            }

            if (Value.Trim() == "BillNo")
            {
                newColumn = dt.Columns.Add("Bill No.", Type.GetType("System.String"));
            }
            if (Value.Trim() == "ThcStat")
            {
                newColumn = dt.Columns.Add("THC Attached Y/N", Type.GetType("System.String"));
            }
            if (Value.Trim() == "ThcNo")
            {
                newColumn = dt.Columns.Add("THC No.", Type.GetType("System.String"));
            }




            if (Value.Trim() == "Custcode=(select CUSTNM from webx_custhdr where CUSTCD=Custcode)")
            {
                newColumn = dt.Columns.Add("Customer name", Type.GetType("System.String"));
            }

            if (Value.Trim() == "TotalTHCAmt=(select sum(TotalAmt) from WEBX_FLEET_TRIPTHCDET where tripsheetno=vslipno group by tripsheetno)")
            {
                newColumn = dt.Columns.Add("THC Amount", Type.GetType("System.String"));
            }


        




        }

        selvaluesArr2 = Exp.Split(new char[] { ',' });
        int maxarr2 = selvaluesArr2.GetUpperBound(0);
        for (int i = 0; i <= maxarr2; i++)
        {

            string Value = selvaluesArr2[i].ToString().Trim();

            if (Value.Trim() == "Adv")
            {

              //  HyperLinkField hf = new HyperLinkField();

             //   hf.HeaderText = "Advance";
        //    newColumn=      dt.Columns.Add(hf);

                newColumn = dt.Columns.Add("Advance", Type.GetType("System.String"));


            //    newColumn =




            }
            if (Value.Trim() == "Rep")
            {
                newColumn = dt.Columns.Add("Repair Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Fuel")
            {
                newColumn = dt.Columns.Add("Fuel Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Spare")
            {
                newColumn = dt.Columns.Add("Spare Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Inc")
            {
                newColumn = dt.Columns.Add("Incidental deduction", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Claim")
            {
                newColumn = dt.Columns.Add("Claim Amount", Type.GetType("System.String"));
            }
 



        }

        selvaluesArr3 = Enroute.Split(new char[] { ',' });
        int maxarr3 = selvaluesArr3.GetUpperBound(0);
        for (int i = 0; i <= maxarr3; i++)
        {

            string Value = selvaluesArr3[i].ToString().Trim();

            if (Value.Trim() == "RTO")
            {
                newColumn = dt.Columns.Add("RTO", Type.GetType("System.String"));
            }
              
              if (Value.Trim() == "Border")
            {
                newColumn = dt.Columns.Add("Border/Check Post", Type.GetType("System.String"));
            }

            
            if (Value.Trim() == "Toll")
            {
                newColumn = dt.Columns.Add("Toll", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Sales")
            {
                newColumn = dt.Columns.Add("Sales Tax seal", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Escorts")
            {
                newColumn = dt.Columns.Add("Escorts", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Octroi")
            {
                newColumn = dt.Columns.Add("Octroi", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Load")
            {
                newColumn = dt.Columns.Add("Loading", Type.GetType("System.String"));
            }
            if (Value.Trim() == "UnLoad")
            {
                newColumn = dt.Columns.Add("UnLoading", Type.GetType("System.String"));
            }
            if (Value.Trim() == "EnRep")
            {
                newColumn = dt.Columns.Add("Enroute Rapairs", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Penalty")
            {
                newColumn = dt.Columns.Add("Penalty", Type.GetType("System.String"));
            }
            if (Value.Trim() == "TyrePunct")
            {
                newColumn = dt.Columns.Add("Tyre Puncture", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Weigh")
            {
                newColumn = dt.Columns.Add("Weigh Bridge Expenses", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Park")
            {
                newColumn = dt.Columns.Add("Parking", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Tele")
            {
                newColumn = dt.Columns.Add("Telephone", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Temp")
            {
                newColumn = dt.Columns.Add("Temporary Permit", Type.GetType("System.String"));
            }
            if (Value.Trim() == "DDAllow")
            {
                newColumn = dt.Columns.Add("Driver Daily Allowance", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Incent")
            {
                newColumn = dt.Columns.Add("Incentive Payable", Type.GetType("System.String"));
            }
            if (Value.Trim() == "OtExp")
            {
                newColumn = dt.Columns.Add("Other Expense", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Broker")
            {
                newColumn = dt.Columns.Add("Broker Commission", Type.GetType("System.String"));
            }




           

        }



        newColumn = dt.Columns.Add("Total Expense", Type.GetType("System.String"));

       
      


           string sql = "usp_Voucher_Trip_Register";

           SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        {
        

            dtFrom = Convert.ToDateTime(Session["dtFrom"].ToString().Trim(), dtfi);
            dtTo = Convert.ToDateTime(Session["dtTo"].ToString().Trim(), dtfi);


        }

        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.VarChar).Value = Session["dtFrom"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.VarChar).Value = Session["dtTo"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = Session["Status"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = Session["Branch"].ToString().Trim();

        // new 
        da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = Session["VehicleNo"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = Session["Driver"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Manual", SqlDbType.VarChar).Value = Session["Manual"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Tripsheet", SqlDbType.VarChar).Value = Session["Tripsheetno"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@DateGNorCL", SqlDbType.VarChar).Value = Session["DateGNorCL"].ToString().Trim();

        SqlDataReader  dr=sqlcmd.ExecuteReader();

        if(dr.HasRows)
        {

            while(dr.Read())
            {
                DataRow newRow;
                newRow = dt.NewRow();
                //newRow["ID"] = "<a href='#'>X</a>";
                //newRow["ID"]="<a href = '../EventsCalendar/Edit.aspx '>" + "Edit" + "</a>";

                newRow["Tripsheet No"] = Convert.ToString(dr["VSlipNo"]);
                //newRow["Tripsheet No"] = "<a href = '../EventsCalendar/Edit.aspx '>" + Convert.ToString(dr["VSlipNo"]);

                newRow["Manual No"] = Convert.ToString(dr["Manual_tripsheetno"]);


              if(!dt.Columns.Contains("Tripsheet Start Date")==false)
              {
                  newRow["Tripsheet Start Date"] = Convert.ToString(dr["StartDate"]);
              }
              if (!dt.Columns.Contains("Tripsheet End Date") == false)
              {
                  newRow["Tripsheet End Date"] = Convert.ToString(dr["EndDate"]);

              }

              if (!dt.Columns.Contains("Start Location") == false)
              {
                  newRow["Start Location"] = Convert.ToString(dr["Tripsheet_startloc"]);
              }
              if (!dt.Columns.Contains("End Location") == false)
              {
                  newRow["End Location"] = Convert.ToString(dr["Tripsheet_Endloc"]);

              }

              if (!dt.Columns.Contains("Vehicle Category") == false)
              {
                  newRow["Vehicle Category"] = Convert.ToString(dr["V_type"]);

              }

 
              if (!dt.Columns.Contains("Vehicle No") == false)
              {
                  newRow["Vehicle No"] = Convert.ToString(dr["VehicleNo"]);
              }

              if (!dt.Columns.Contains("Driver Name") == false)
              {
                  newRow["Driver Name"] = Convert.ToString(dr["DriverName"]);
              }


              if (!dt.Columns.Contains("Status") == false)
              {
                  newRow["Status"] = Convert.ToString(dr["Status"]);
              }




              if (!dt.Columns.Contains("Category") == false)
              {
                  newRow["Category"] = Convert.ToString(dr["Category"]);
              }

                // new

              if (!dt.Columns.Contains("Starting KM") == false)
              {
                  newRow["Starting KM"] = Convert.ToString(dr["f_issue_startKM"]);
              }

              if (!dt.Columns.Contains("Closing KM") == false)
              {
                  newRow["Closing KM"] = Convert.ToString(dr["f_closure_CloseKM"]);
              }
              if (!dt.Columns.Contains("Total KM") == false)
              {
                  newRow["Total KM"] = Convert.ToString(dr["TotKM"]);
              }


              if (!dt.Columns.Contains("Approved KMPL") == false)
              {
                  newRow["Approved KMPL"] = Convert.ToString(dr["Approved_KMPL"]);
              }

              if (!dt.Columns.Contains("Actual KMPL") == false)
              {
                  newRow["Actual KMPL"] = Convert.ToString(dr["Actual_KMPL"]);
              }


              if (!dt.Columns.Contains("Diesel Quantity") == false)
              {
                  newRow["Diesel Quantity"] = Convert.ToString(dr["TotDiesel"]);
              }


              //new
              if (!dt.Columns.Contains("Bill Prepared Y/N") == false)
              {
                  newRow["Bill Prepared Y/N"] = Convert.ToString(dr["Billed_yn"]);
              }

              if (!dt.Columns.Contains("Bill No.") == false)
              {
                  newRow["Bill No."] = Convert.ToString(dr["BillNo"]);
              }

              if (!dt.Columns.Contains("THC Attached Y/N") == false)
              {
                  newRow["THC Attached Y/N"] = Convert.ToString(dr["Thc_attached_yn"]);
              }

              if (!dt.Columns.Contains("Customer name") == false)
              {
                  newRow["Customer name"] = Convert.ToString(dr["Custcode"]);
              }

              if (!dt.Columns.Contains("THC Amount") == false)
              {
                  newRow["THC Amount"] = Convert.ToString(dr["TotalTHCAmt"]);
              }





                //Expense

              if (!dt.Columns.Contains("Advance") == false)
              {
                  newRow["Advance"] = Convert.ToString(dr["TotAdvExp"]);
              }
              if (!dt.Columns.Contains("Repair Expense") == false)
              {
                  newRow["Repair Expense"] = Convert.ToString(dr["TotRepairExp"]);

              }
              if (!dt.Columns.Contains("Fuel Expense") == false)
              {
                  newRow["Fuel Expense"] = Convert.ToString(dr["TotOilExp"]);
              }

              if (!dt.Columns.Contains("Spare Expense") == false)
              {
                  newRow["Spare Expense"] = Convert.ToString(dr["TotSpareExp"]);
              }
              if (!dt.Columns.Contains("Incidental deduction") == false)
              {
                  newRow["Incidental deduction"] = Convert.ToString(dr["TotIncDedExp"]);
              }


              if (!dt.Columns.Contains("Claim Amount") == false)
              {
                  newRow["Claim Amount"] = Convert.ToString(dr["TotClaimsAmt"]);
              }



              if (!dt.Columns.Contains("RTO") == false)
              {
                  newRow["RTO"] = Convert.ToString(dr["RTO"]);
              }

              if (!dt.Columns.Contains("Border/Check Post") == false)
              {
                  newRow["Border/Check Post"] = Convert.ToString(dr["Border_Check_Post"]);
              }


              if (!dt.Columns.Contains("Toll") == false)
              {
                  newRow["Toll"] = Convert.ToString(dr["Toll"]);

              }
              if (!dt.Columns.Contains("Sales Tax seal") == false)
              {
                  newRow["Sales Tax seal"] = Convert.ToString(dr["Sales_Tax_seal"]);
              }

              if (!dt.Columns.Contains("Escorts") == false)
              {
                  newRow["Escorts"] = Convert.ToString(dr["Escorts"]);
              }


              if (!dt.Columns.Contains("Octroi") == false)
              {
                  newRow["Octroi"] = Convert.ToString(dr["Octroi"]);
              }
              if (!dt.Columns.Contains("Loading") == false)
              {
                  newRow["Loading"] = Convert.ToString(dr["Loading"]);

              }
              if (!dt.Columns.Contains("UnLoading") == false)
              {
                  newRow["UnLoading"] = Convert.ToString(dr["UnLoading"]);
              }

              if (!dt.Columns.Contains("Enroute Rapairs") == false)
              {
                  newRow["Enroute Rapairs"] = Convert.ToString(dr["Enroute_Rapairs"]);
              }

               

              if (!dt.Columns.Contains("Penalty") == false)
              {
                  newRow["Penalty"] = Convert.ToString(dr["Penalty"]);
              }
              if (!dt.Columns.Contains("Tyre Puncture") == false)
              {
                  newRow["Tyre Puncture"] = Convert.ToString(dr["Tyre_Puncture"]);

              }
              if (!dt.Columns.Contains("Weigh Bridge Expenses") == false)
              {
                  newRow["Weigh Bridge Expenses"] = Convert.ToString(dr["Weigh_Bridge_Expenses"]);
              }

              if (!dt.Columns.Contains("Parking") == false)
              {
                  newRow["Parking"] = Convert.ToString(dr["Parking"]);
              }
              if (!dt.Columns.Contains("Telephone") == false)
              {
                  newRow["Telephone"] = Convert.ToString(dr["Telephone"]);
              }

              if (!dt.Columns.Contains("Temporary Permit") == false)
              {
                  newRow["Temporary Permit"] = Convert.ToString(dr["Temporary_Permit"]);
              }

              if (!dt.Columns.Contains("Driver Daily Allowance") == false)
              {
                  newRow["Driver Daily Allowance"] = Convert.ToString(dr["Driver_Daily_Allowance"]);
              }


              if (!dt.Columns.Contains("Incentive Payable") == false)
              {
                  newRow["Incentive Payable"] = Convert.ToString(dr["Incentive_Payable"]);
              }

              if (!dt.Columns.Contains("Other Expense") == false)
              {
                  newRow["Other Expense"] = Convert.ToString(dr["Other_Expense"]);
              }
              if (!dt.Columns.Contains("Broker Commission") == false)
              {
                  newRow["Broker Commission"] = Convert.ToString(dr["Broker_Commission"]);
              }

              if (!dt.Columns.Contains("Total Expense") == false)
              {
                  newRow["Total Expense"] = Convert.ToString(dr["Total"]);
              }    




                dt.Rows.Add(newRow);
             
            }
        }

        dr.Close();
 
        conn.Close();






     //foreach (DataColumn col in dt.Columns)

     //   {

     //       HyperLinkField bfield = new HyperLinkField();
     //       bfield.DataTextField = col.ColumnName;

     //       bfield.HeaderText = col.ColumnName;
     //    //   GridView1.Columns.Add(bfield);

     //       if (bfield.HeaderText == "Advance")
     //       {
     //           bfield.DataNavigateUrlFields = VSlipNo;

     //           bfield.DataTextField = "VSlipNo";

     //           bfield.DataTextFormatString = "~/GUI/Fleet/Operations/Reports";


     //       }

     //   }

        //ds.Relations.Add("InnerVal", ds.Tables[0].Columns["Manual_tripsheetno"],// making a relation between two tables.
        //ds.Tables[0].Columns["Manual_tripsheetno"]);  
       
         ds.Tables.Add(dt);

         GridView1.DataSource = ds.Tables["GridView1"];
         






        
         HyperLinkField hfield = ((HyperLinkField)GridView1.Columns[0]);
         hfield.DataNavigateUrlFields =  new string[] { dt.Columns[0].ColumnName, dt.Columns[1].ColumnName };
         //hfield.DataNavigateUrlFormatString = "{0}";
         hfield.DataNavigateUrlFormatString = "~/GUI/Fleet/Operations/Issue/frmViewPrintVehicleIssueSlip.aspx?VslipNo={0}&PrintMode=0";

         hfield.DataTextField =  hfield.DataNavigateUrlFields[0];
         //hfield.NavigateUrl = "../Issue/frmViewPrintVehicleIssueSlip.aspx?VslipNo=" + hfield.DataNavigateUrlFields[0];
        

         





     //   GridView1.DataSource = dt;
        GridView1.DataBind();
       






        

       

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;



        DataSet ds = new DataSet();
        DataTable dt = new DataTable("GridView1");

        DataColumn newColumn;
        newColumn = dt.Columns.Add("Tripsheet No", Type.GetType("System.String"));
        newColumn = dt.Columns.Add("Manual No", Type.GetType("System.String"));
        string[] selvaluesArr1;
        string[] selvaluesArr2;
        string[] selvaluesArr3;

        string Status = Session["Stat"].ToString().Trim();

        string Exp = Session["Exp"].ToString().Trim();


        string Enroute = Session["Enroute"].ToString().Trim();


        selvaluesArr1 = Status.Split(new char[] { ',' });
        int maxarr1 = selvaluesArr1.GetUpperBound(0);
        for (int i = 0; i <= maxarr1; i++)
        {

            string Value = selvaluesArr1[i].ToString().Trim();

            if (Value.Trim() == "SDate")
            {
                newColumn = dt.Columns.Add("Tripsheet Start Date", Type.GetType("System.String"));
            }
            if (Value.Trim() == "EndDate")
            {
                newColumn = dt.Columns.Add("Tripsheet End Date", Type.GetType("System.String"));
            }

            if (Value.Trim() == "StLoc")
            {
                newColumn = dt.Columns.Add("Start Location", Type.GetType("System.String"));
            }

            if (Value.Trim() == "EndLoc")
            {
                newColumn = dt.Columns.Add("End Location", Type.GetType("System.String"));
            }

            if (Value.Trim() == "VehCat")
            {
                newColumn = dt.Columns.Add("Vehicle Category", Type.GetType("System.String"));
            }

            if (Value.Trim() == "DName")
            {
                newColumn = dt.Columns.Add("Driver Name", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Cat")
            {
                newColumn = dt.Columns.Add("Category", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Vehno")
            {
                newColumn = dt.Columns.Add("Vehicle No", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Stat")
            {
                newColumn = dt.Columns.Add("Status", Type.GetType("System.String"));
            }



            //new
            if (Value.Trim() == "StartKM")
            {
                newColumn = dt.Columns.Add("Starting KM", Type.GetType("System.String"));
            }

            if (Value.Trim() == "CloseKM")
            {
                newColumn = dt.Columns.Add("Closing KM", Type.GetType("System.String"));
            }
            if (Value.Trim() == "TotKM")
            {
                newColumn = dt.Columns.Add("Total KM", Type.GetType("System.String"));
            }

            if (Value.Trim() == "AppKMPL")
            {
                newColumn = dt.Columns.Add("Approved KMPL", Type.GetType("System.String"));
            }

            if (Value.Trim() == "ActKMPL")
            {
                newColumn = dt.Columns.Add("Actual KMPL", Type.GetType("System.String"));
            }









            if (Value.Trim() == "Dsl")
            {
                newColumn = dt.Columns.Add("Diesel Quantity", Type.GetType("System.String"));
            }

            //new
            if (Value.Trim() == "BillStat")
            {
                newColumn = dt.Columns.Add("Bill Prepared Y/N", Type.GetType("System.String"));
            }
            if (Value.Trim() == "BillNo")
            {
                newColumn = dt.Columns.Add("Bill No.", Type.GetType("System.String"));
            }
            if (Value.Trim() == "ThcStat")
            {
                newColumn = dt.Columns.Add("THC Attached Y/N", Type.GetType("System.String"));
            }
            if (Value.Trim() == "ThcNo")
            {
                newColumn = dt.Columns.Add("THC No.", Type.GetType("System.String"));
            }


            if (Value.Trim() == "Custcode=(select CUSTNM from webx_custhdr where CUSTCD=Custcode)")
            {
                newColumn = dt.Columns.Add("Customer name", Type.GetType("System.String"));
            }

            if (Value.Trim() == "TotalTHCAmt=(select sum(TotalAmt) from WEBX_FLEET_TRIPTHCDET where tripsheetno=vslipno group by tripsheetno)")
            {
                newColumn = dt.Columns.Add("THC Amount", Type.GetType("System.String"));
            }

            


        }

        selvaluesArr2 = Exp.Split(new char[] { ',' });
        int maxarr2 = selvaluesArr2.GetUpperBound(0);
        for (int i = 0; i <= maxarr2; i++)
        {

            string Value = selvaluesArr2[i].ToString().Trim();

            if (Value.Trim() == "Adv")
            {
                newColumn = dt.Columns.Add("Advance", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Rep")
            {
                newColumn = dt.Columns.Add("Repair Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Fuel")
            {
                newColumn = dt.Columns.Add("Fuel Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Spare")
            {
                newColumn = dt.Columns.Add("Spare Expense", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Inc")
            {
                newColumn = dt.Columns.Add("Incidental deduction", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Claim")
            {
                newColumn = dt.Columns.Add("Claim Amount", Type.GetType("System.String"));
            }




        }

        selvaluesArr3 = Enroute.Split(new char[] { ',' });
        int maxarr3 = selvaluesArr3.GetUpperBound(0);
        for (int i = 0; i <= maxarr3; i++)
        {

            string Value = selvaluesArr3[i].ToString().Trim();

            if (Value.Trim() == "RTO")
            {
                newColumn = dt.Columns.Add("RTO", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Border")
            {
                newColumn = dt.Columns.Add("Border/Check Post", Type.GetType("System.String"));
            }


            if (Value.Trim() == "Toll")
            {
                newColumn = dt.Columns.Add("Toll", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Sales")
            {
                newColumn = dt.Columns.Add("Sales Tax seal", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Escorts")
            {
                newColumn = dt.Columns.Add("Escorts", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Octroi")
            {
                newColumn = dt.Columns.Add("Octroi", Type.GetType("System.String"));
            }

            if (Value.Trim() == "Load")
            {
                newColumn = dt.Columns.Add("Loading", Type.GetType("System.String"));
            }
            if (Value.Trim() == "UnLoad")
            {
                newColumn = dt.Columns.Add("UnLoading", Type.GetType("System.String"));
            }
            if (Value.Trim() == "EnRep")
            {
                newColumn = dt.Columns.Add("Enroute Rapairs", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Penalty")
            {
                newColumn = dt.Columns.Add("Penalty", Type.GetType("System.String"));
            }
            if (Value.Trim() == "TyrePunct")
            {
                newColumn = dt.Columns.Add("Tyre Puncture", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Weigh")
            {
                newColumn = dt.Columns.Add("Weigh Bridge Expenses", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Park")
            {
                newColumn = dt.Columns.Add("Parking", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Tele")
            {
                newColumn = dt.Columns.Add("Telephone", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Temp")
            {
                newColumn = dt.Columns.Add("Temporary Permit", Type.GetType("System.String"));
            }
            if (Value.Trim() == "DDAllow")
            {
                newColumn = dt.Columns.Add("Driver Daily Allowance", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Incent")
            {
                newColumn = dt.Columns.Add("Incentive Payable", Type.GetType("System.String"));
            }
            if (Value.Trim() == "OtExp")
            {
                newColumn = dt.Columns.Add("Other Expense", Type.GetType("System.String"));
            }
            if (Value.Trim() == "Broker")
            {
                newColumn = dt.Columns.Add("Broker Commission", Type.GetType("System.String"));
            }


        }



        newColumn = dt.Columns.Add("Total Expense", Type.GetType("System.String"));







        string sql = "usp_Voucher_Trip_Register";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";

        //{


        //    dtFrom = Convert.ToDateTime(Session["dtFrom"].ToString().Trim(), dtfi);
        //    dtTo = Convert.ToDateTime(Session["dtTo"].ToString().Trim(), dtfi);


        //}

        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.VarChar).Value = Session["dtFrom"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.VarChar).Value = Session["dtTo"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = Session["Status"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = Session["Branch"].ToString().Trim();

        // new 
        da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = Session["VehicleNo"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = Session["Driver"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Manual", SqlDbType.VarChar).Value = Session["Manual"].ToString().Trim();
        da.SelectCommand.Parameters.Add("@Tripsheet", SqlDbType.VarChar).Value = Session["Tripsheetno"].ToString().Trim();

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if (dr.HasRows)
        {

            while (dr.Read())
            {
                DataRow newRow;
                newRow = dt.NewRow();
                newRow["Tripsheet No"] = Convert.ToString(dr["VSlipNo"]);

                newRow["Manual No"] = Convert.ToString(dr["Manual_tripsheetno"]);

                if (!dt.Columns.Contains("Tripsheet Start Date") == false)
                {
                    newRow["Tripsheet Start Date"] = Convert.ToString(dr["StartDate"]);
                }
                if (!dt.Columns.Contains("Tripsheet End Date") == false)
                {
                    newRow["Tripsheet End Date"] = Convert.ToString(dr["EndDate"]);

                }

                if (!dt.Columns.Contains("Start Location") == false)
                {
                    newRow["Start Location"] = Convert.ToString(dr["Tripsheet_startloc"]);
                }
                if (!dt.Columns.Contains("End Location") == false)
                {
                    newRow["End Location"] = Convert.ToString(dr["Tripsheet_Endloc"]);

                }

                if (!dt.Columns.Contains("Vehicle Category") == false)
                {
                    newRow["Vehicle Category"] = Convert.ToString(dr["V_type"]);

                }


                if (!dt.Columns.Contains("Vehicle No") == false)
                {
                    newRow["Vehicle No"] = Convert.ToString(dr["VehicleNo"]);
                }

                if (!dt.Columns.Contains("Driver Name") == false)
                {
                    newRow["Driver Name"] = Convert.ToString(dr["DriverName"]);
                }


                if (!dt.Columns.Contains("Status") == false)
                {
                    newRow["Status"] = Convert.ToString(dr["Status"]);
                }




                if (!dt.Columns.Contains("Category") == false)
                {
                    newRow["Category"] = Convert.ToString(dr["Category"]);
                }

                //new
                if (!dt.Columns.Contains("Starting KM") == false)
                {
                    newRow["Starting KM"] = Convert.ToString(dr["f_issue_startKM"]);
                }

                if (!dt.Columns.Contains("Closing KM") == false)
                {
                    newRow["Closing KM"] = Convert.ToString(dr["f_closure_CloseKM"]);
                }
                if (!dt.Columns.Contains("Total KM") == false)
                {
                    newRow["Total KM"] = Convert.ToString(dr["TotKM"]);
                }


                if (!dt.Columns.Contains("Approved KMPL") == false)
                {
                    newRow["Approved KMPL"] = Convert.ToString(dr["Approved_KMPL"]);
                }

                if (!dt.Columns.Contains("Actual KMPL") == false)
                {
                    newRow["Actual KMPL"] = Convert.ToString(dr["Actual_KMPL"]);
                }




                if (!dt.Columns.Contains("Diesel Quantity") == false)
                {
                    newRow["Diesel Quantity"] = Convert.ToString(dr["TotDiesel"]);
                }


                //new
                if (!dt.Columns.Contains("Bill Prepared Y/N") == false)
                {
                    newRow["Bill Prepared Y/N"] = Convert.ToString(dr["Billed_yn"]);
                }

                if (!dt.Columns.Contains("Bill No.") == false)
                {
                    newRow["Bill No."] = Convert.ToString(dr["BillNo"]);
                }

                if (!dt.Columns.Contains("THC Attached Y/N") == false)
                {
                    newRow["THC Attached Y/N"] = Convert.ToString(dr["Thc_attached_yn"]);
                }



                if (!dt.Columns.Contains("Customer name") == false)
                {
                    newRow["Customer name"] = Convert.ToString(dr["Custcode"]);
                }

                if (!dt.Columns.Contains("THC Amount") == false)
                {
                    newRow["THC Amount"] = Convert.ToString(dr["TotalTHCAmt"]);
                } 




                if (!dt.Columns.Contains("Advance") == false)
                {
                    newRow["Advance"] = Convert.ToString(dr["TotAdvExp"]);
                }
                if (!dt.Columns.Contains("Repair Expense") == false)
                {
                    newRow["Repair Expense"] = Convert.ToString(dr["TotRepairExp"]);

                }
                if (!dt.Columns.Contains("Fuel Expense") == false)
                {
                    newRow["Fuel Expense"] = Convert.ToString(dr["TotOilExp"]);
                }

                if (!dt.Columns.Contains("Spare Expense") == false)
                {
                    newRow["Spare Expense"] = Convert.ToString(dr["TotSpareExp"]);
                }
                if (!dt.Columns.Contains("Incidental deduction") == false)
                {
                    newRow["Incidental deduction"] = Convert.ToString(dr["TotIncDedExp"]);
                }


                if (!dt.Columns.Contains("Claim Amount") == false)
                {
                    newRow["Claim Amount"] = Convert.ToString(dr["TotClaimsAmt"]);
                }



                if (!dt.Columns.Contains("RTO") == false)
                {
                    newRow["RTO"] = Convert.ToString(dr["RTO"]);
                }

                if (!dt.Columns.Contains("Border/Check Post") == false)
                {
                    newRow["Border/Check Post"] = Convert.ToString(dr["Border_Check_Post"]);
                }


                if (!dt.Columns.Contains("Toll") == false)
                {
                    newRow["Toll"] = Convert.ToString(dr["Toll"]);

                }
                if (!dt.Columns.Contains("Sales Tax seal") == false)
                {
                    newRow["Sales Tax seal"] = Convert.ToString(dr["Sales_Tax_seal"]);
                }

                if (!dt.Columns.Contains("Escorts") == false)
                {
                    newRow["Escorts"] = Convert.ToString(dr["Escorts"]);
                }


                if (!dt.Columns.Contains("Octroi") == false)
                {
                    newRow["Octroi"] = Convert.ToString(dr["Octroi"]);
                }
                if (!dt.Columns.Contains("Loading") == false)
                {
                    newRow["Loading"] = Convert.ToString(dr["Loading"]);

                }
                if (!dt.Columns.Contains("UnLoading") == false)
                {
                    newRow["UnLoading"] = Convert.ToString(dr["UnLoading"]);
                }

                if (!dt.Columns.Contains("Enroute Rapairs") == false)
                {
                    newRow["Enroute Rapairs"] = Convert.ToString(dr["Enroute_Rapairs"]);
                }



                if (!dt.Columns.Contains("Penalty") == false)
                {
                    newRow["Penalty"] = Convert.ToString(dr["Penalty"]);
                }
                if (!dt.Columns.Contains("Tyre Puncture") == false)
                {
                    newRow["Tyre Puncture"] = Convert.ToString(dr["Tyre_Puncture"]);

                }
                if (!dt.Columns.Contains("Weigh Bridge Expenses") == false)
                {
                    newRow["Weigh Bridge Expenses"] = Convert.ToString(dr["Weigh_Bridge_Expenses"]);
                }

                if (!dt.Columns.Contains("Parking") == false)
                {
                    newRow["Parking"] = Convert.ToString(dr["Parking"]);
                }
                if (!dt.Columns.Contains("Telephone") == false)
                {
                    newRow["Telephone"] = Convert.ToString(dr["Telephone"]);
                }

                if (!dt.Columns.Contains("Temporary Permit") == false)
                {
                    newRow["Temporary Permit"] = Convert.ToString(dr["Temporary_Permit"]);
                }

                if (!dt.Columns.Contains("Driver Daily Allowance") == false)
                {
                    newRow["Driver Daily Allowance"] = Convert.ToString(dr["Driver_Daily_Allowance"]);
                }


                if (!dt.Columns.Contains("Incentive Payable") == false)
                {
                    newRow["Incentive Payable"] = Convert.ToString(dr["Incentive_Payable"]);
                }

                if (!dt.Columns.Contains("Other Expense") == false)
                {
                    newRow["Other Expense"] = Convert.ToString(dr["Other_Expense"]);
                }
                if (!dt.Columns.Contains("Broker Commission") == false)
                {
                    newRow["Broker Commission"] = Convert.ToString(dr["Broker_Commission"]);
                }

                if (!dt.Columns.Contains("Total Expense") == false)
                {
                    newRow["Total Expense"] = Convert.ToString(dr["Total"]);
                }    

                dt.Rows.Add(newRow);

            }
        }

        dr.Close();

        conn.Close();

        //foreach (DataColumn col in dt.Columns)
        //{
        //    HyperLinkField hlf = new HyperLinkField();

        //    hlf.HeaderText = col.ColumnName;

        //    GridView1.Columns.Add(hlf);

        //}

        
       ds.Tables.Add(dt);

       GridView1.DataSource = ds.Tables["GridView1"];

      //  GridView1.DataSource = dt;
        GridView1.DataBind();


    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // reference the Delete Link Command Column.
            //LinkButton db = (LinkButton)e.Row.Cells[6].Controls[0];
            //db.OnClientClick = string.Format("return confirm('Are you want to delete the Order?');");
        }
         
        
    }


   


    protected void btnXML_Click(object sender, EventArgs e)
    {


        GridView1.AllowPaging = false;
        GridView1.BorderWidth = 1;
        GridView1.CssClass = "blackfnt";
        GridView1.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TripsheetRegister.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(GridView1);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();



    }





}
