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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Admin_Vendor_contract_VendorContract_view : System.Web.UI.Page
{
    public static string VendorCode, ContractID, Flag, vendnm = "", vendtyp, ContID, vendcd, TDSAPP;
    SqlConnection conn;
    static DataTable dtSlabRate = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            ContractID = Request.QueryString.Get("VendorView");
           // Response.Write("<br> ContractID : " + VendorCode);
            RetriveData();
        }
        conn.Close();
    }

    private void RetriveData()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        String SQL_EDIT = "select CONTRACTCD,vendorCode,vendorName,vencd=(vendorCode+' : '+vendorName),vendor_type as typ,vendor_type=(select top 1 codedesc from webx_master_general where codetype='vendty' and statuscode='Y' and codeid=vendor_type),contdt=convert(varchar,contractdt,106),contract_loccode,contract_locNAME=(select top 1 locname from webx_location where loccode=contract_loccode),vaildt=convert(varchar,valid_uptodt,106),exp_dt=convert(varchar,Start_dt,106),vendorpername,vendorperdesg,vendorwitness,compempname,compempdesg,compwitness,vendorcity,vendorpin,vendorcategory=(case when vendorcategory='C' then 'Contract' when vendorcategory='NC' then 'Non Contract' end),vendorcontractCat=(case when vendorcontractCat='C' then 'Contract' when vendorcontractCat='S' then 'Subcontract' end),tdsrate,noofcheques,secdepdt=convert(varchar,secdepdt,106),transtype,secdepAmt,payloccode,payinterval,monphchrg,serroad,serair,serrail,vendoradd,serexpress ,tdsappl_yn,Penalty_hour,Penalty_perContract,Incentive_hour,Incentive_perContract from webx_vendor_contract_summary where CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd1 = new SqlCommand(SQL_EDIT, conn);
        SqlDataReader dr = cmd1.ExecuteReader();

        while (dr.Read())
        {

            lblVendor_Name.Text = dr["vencd"].ToString();
            lblVendorAddress.Text = dr["vendoradd"].ToString();
            VendorCode = dr["vendorCode"].ToString();
            lblVendorCategory.Text = dr["vendorcategory"].ToString();
            lblVendorRepresentative.Text = dr["vendorpername"].ToString();
            lblVendorType.Text = dr["vendor_type"].ToString();
            lblVendorWitness.Text = dr["vendorwitness"].ToString();
            lblCompanyEmployeeName.Text = dr["compempname"].ToString();
            lblCompanyWitness.Text = dr["compwitness"].ToString();
            lblContractCategory.Text = dr["vendorcontractCat"].ToString();
            lblContractCode.Text = dr["CONTRACTCD"].ToString();
            lblContractDate.Text = dr["contdt"].ToString();
            lblContractsigninglocation.Text = dr["contract_loccode"].ToString()+ " : "+Convert.ToString(dr["contract_locNAME"]);
            lblDesignation.Text = dr["compempdesg"].ToString();
            lblDesignation_vendor.Text = dr["vendorperdesg"].ToString();
            lblEffectiveFromDate.Text = dr["exp_dt"].ToString();
            lblMonthlyPhoneCharges.Text = dr["monphchrg"].ToString();
            lblPaymentBasis.Text = dr["TransType"].ToString();
            lblPaymentInterval.Text = dr["payinterval"].ToString();
            lblPaymentLocation.Text = dr["payloccode"].ToString();
            lblSecurityDepositAmount.Text = dr["secdepAmt"].ToString();
            lblSecurityDepositCheque.Text = dr["noofcheques"].ToString();
            lblSecurityDepositDate.Text = dr["secdepdt"].ToString();
            lblTDSApplicable.Text = dr["tdsappl_yn"].ToString();
            lblTDSRate.Text = dr["tdsrate"].ToString();
            lblValidUntil.Text = dr["vaildt"].ToString();
            lblCityPin.Text = dr["vendorcity"].ToString() + '-' + dr["vendorpin"].ToString();

            lblRail.Text = dr["serrail"].ToString();
            lblRoad.Text = dr["serroad"].ToString();
            lblAir.Text = dr["serair"].ToString();
            lblExpress.Text = dr["serexpress"].ToString();


            //Penalty_hour,Penalty_perContract,Incentive_hour,Incentive_perContract

            lblLateContract.Text = dr["Penalty_perContract"].ToString();
            lblLatePenalty.Text = dr["Penalty_hour"].ToString();
            lblIncentive.Text = dr["Incentive_hour"].ToString();
            lblIncentiveContract.Text = dr["Incentive_perContract"].ToString();
            

        }

        dr.Close();

        String SQL_MCode = "select  distinct matrixcode from  webx_vendor_contract_charges V where CONTRACTCD='" + ContractID + "'";
        SqlCommand cmd2 = new SqlCommand(SQL_MCode, conn);
        SqlDataReader dr1 = cmd2.ExecuteReader();
        string mCode="";
        while (dr1.Read())
        {
             mCode = dr1["matrixcode"].ToString();
        }

        dr1.Close();
        
        if(mCode == "1")
        {
           // String sql_mcode1 = "select Distinct vehtype from webx_vendor_contract_charges where vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='1' and chargetype='Variable'     ";

            Matrix1();
        }
        else if(mCode == "2")
        {
            Matrix2();
        }
        else if (mCode == "9")
        {
            Matrix9();
        }
        else if (mCode == "10")
        {
            Matrix10();
        }
        else if (mCode == "4")
        {
            Matrix4();
        }
        else if (mCode == "6")
        {
            Matrix6();
        }
        else if (mCode == "7")
        {
            Matrix7();
        }
        else if (mCode == "5")
        {
            Matrix5();
        }

        
    }


    private void Matrix1()
    {
        tblMatrix1.Visible = true;
        String sql_mcode1 = "select Distinct vehtype from webx_vendor_contract_charges where vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='1' and chargetype='Variable'     ";
        sql_mcode1 = "select * from webx_vehicle_type where activeflag='Y'";
        SqlCommand cmd_mcode1 = new SqlCommand(sql_mcode1, conn);
        SqlDataReader dr_mcode1 = cmd_mcode1.ExecuteReader();
        String String_Vehtype_mcode1 = "";
        String String_Vehtype_mcode12 = "";
        while (dr_mcode1.Read())
        {
            if (String_Vehtype_mcode1 == "")
            {
                String_Vehtype_mcode1 = dr_mcode1["type_name"].ToString();
                String_Vehtype_mcode12 = dr_mcode1["type_code"].ToString();
            }
            else
            {
                String_Vehtype_mcode1 = String_Vehtype_mcode1 + '^' + dr_mcode1["type_name"].ToString();
                String_Vehtype_mcode12 = String_Vehtype_mcode12 + '^' + dr_mcode1["type_code"].ToString();
            }
        }

        string[] String_Vehtype_mcode1_Arr = String_Vehtype_mcode1.Split('^');
        string[] String_Vehtype_mcode12_Arr = String_Vehtype_mcode12.Split('^');

        dr_mcode1.Close();

        String sql_mcode1_route = "select Distinct routecd as rutcd, routecd=(select rutcd+':'+rutnm from webx_rutmas where rutcd=routecd) from webx_vendor_contract_charges where vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='1' and chargetype='Variable'     ";
        SqlCommand cmd_mcode1_route = new SqlCommand(sql_mcode1_route, conn);
        SqlDataReader dr_mcode1_route = cmd_mcode1_route.ExecuteReader();

        String String_Route_mcode1 = "";
        String String_Route_mcode12 = "";
        while (dr_mcode1_route.Read())
        {
            if (String_Route_mcode1 == "")
            {
                String_Route_mcode1 = dr_mcode1_route["routecd"].ToString();
                String_Route_mcode12 = dr_mcode1_route["rutcd"].ToString();
            }
            else
            {
                String_Route_mcode1 = String_Route_mcode1 + '^' + dr_mcode1_route["routecd"].ToString();
                 String_Route_mcode12 = String_Route_mcode12 + '^' + dr_mcode1_route["rutcd"].ToString();
            }
        }

        string[] String_Route_mcode1_Arr = String_Route_mcode1.Split('^');
         string[] String_Route_mcode12_Arr = String_Route_mcode12.Split('^');

        dr_mcode1_route.Close();

        TableRow tr = new TableRow();
        TableCell tc1 = new TableCell();
       // TableCell tc1 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "Step : 3 Charge Matrices ";
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);
        tc1.ColumnSpan = String_Vehtype_mcode1_Arr.Length+1;
        tblMatrix1.Rows.Add(tr);

        TableRow trveh = new TableRow();
       
        tc1 = new TableCell();
        tc1.Text = "Tonnage - >";
        trveh.Cells.Add(tc1);
        trveh.CssClass = "blackfnt";
        trveh.BackColor = System.Drawing.Color.White;

        for (int k = 0; k < String_Vehtype_mcode1_Arr.Length; k++)
        {
            TableCell tcVeh = new TableCell();

            tcVeh.Text = String_Vehtype_mcode1_Arr[k].ToString();
            trveh.Cells.Add(tcVeh);
        }
        tblMatrix1.Rows.Add(trveh);


        TableRow trRoute = new TableRow();
         tc1 = new TableCell();
         TableCell tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "Route";
        tc2.Text = "";

        trRoute.BackColor = System.Drawing.Color.White;
        trRoute.Cells.Add(tc1);
        tc2.ColumnSpan = String_Vehtype_mcode1_Arr.Length;
        trRoute.Cells.Add(tc2);
        tblMatrix1.Rows.Add(trRoute);


        
        //tc1 = new TableCell();
        // tc2 = new TableCell();
        //tc1.CssClass = "blackfnt";
        //tc1.Text = "Route";
       // tc2.Text = "";
        for (int Rk = 0; Rk < String_Route_mcode1_Arr.Length; Rk++)
        {
            TableRow trRouteData = new TableRow();
            trRouteData.BackColor = System.Drawing.Color.White;
            TableCell tcRoute = new TableCell();

            tcRoute.Text = String_Route_mcode1_Arr[Rk].ToString();
            tcRoute.CssClass = "blackfnt";
            trRouteData.Cells.Add(tcRoute);
            tcRoute.Wrap = false;
            for (int RDK = 0; RDK < String_Vehtype_mcode1_Arr.Length; RDK++)
            {

                String SQL_VEH_route = "select slabvalue from  webx_vendor_contract_charges  where convert(varchar,vehtype,106)='" + String_Vehtype_mcode12_Arr[RDK] + "' and  routecd='" + String_Route_mcode12_Arr[Rk] + "' and vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='1' and chargetype='Variable' ";
                SqlCommand cmd_VEH_route = new SqlCommand(SQL_VEH_route, conn);
                SqlDataReader drRDK = cmd_VEH_route.ExecuteReader();
                String Route_vehData = "";
                while(drRDK.Read())
                {
                    Route_vehData = drRDK["slabvalue"].ToString();
                }

                drRDK.Close();

                TableCell tcRDK = new TableCell();

                tcRDK.Text = Route_vehData;
                tcRDK.CssClass = "blackfnt";
                trRouteData.Cells.Add(tcRDK);
            }


            tblMatrix1.Rows.Add(trRouteData);
        }

        
        
        //trRouteData.Cells.Add(tc1);

        //tc2.ColumnSpan = String_Vehtype_mcode1_Arr.Length;
        //trRouteData.Cells.Add(tc2);
       
    }

    private void Matrix2()
    {
        tblMatrix2a_9.Visible = true;


        String SQL_MCODE2a = "select * from webx_vendor_contract_charges where matrixcode='2' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE2a, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Per Km.";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);
        }

        dr_mcode2.Close();

        tblMatrix2b.Visible = true;
        String sql_mcode1 = "select Distinct vehtype from webx_vendor_contract_charges where vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='2' and chargetype='Variable'     ";
        sql_mcode1 = "select * from webx_vehicle_type where activeflag='Y'";
        SqlCommand cmd_mcode1 = new SqlCommand(sql_mcode1, conn);
        SqlDataReader dr_mcode1 = cmd_mcode1.ExecuteReader();
        String String_Vehtype_mcode1 = "";
        String String_Vehtype_mcode12 = "";
        while (dr_mcode1.Read())
        {
            if (String_Vehtype_mcode1 == "")
            {
                String_Vehtype_mcode1 = dr_mcode1["type_name"].ToString();
                String_Vehtype_mcode12 = dr_mcode1["type_code"].ToString();
            }
            else
            {
                String_Vehtype_mcode1 = String_Vehtype_mcode1 + '^' + dr_mcode1["type_name"].ToString();
                String_Vehtype_mcode12 = String_Vehtype_mcode12 + '^' + dr_mcode1["type_code"].ToString();
            }
        }

        string[] String_Vehtype_mcode1_Arr = String_Vehtype_mcode1.Split('^');
        string[] String_Vehtype_mcode12_Arr = String_Vehtype_mcode12.Split('^');

        dr_mcode1.Close();

        String sql_mcode1_route = "select Distinct slabfrom,slabto from webx_vendor_contract_charges where vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='2' and chargetype='Variable'     ";
        SqlCommand cmd_mcode1_route = new SqlCommand(sql_mcode1_route, conn);
        SqlDataReader dr_mcode1_route = cmd_mcode1_route.ExecuteReader();

        String String_Route_mcode1 = "";
        String String_Route_mcode12 = "";
        while (dr_mcode1_route.Read())
        {
            if (String_Route_mcode1 == "")
            {
                String_Route_mcode1 = dr_mcode1_route["slabfrom"].ToString();
                String_Route_mcode12 = dr_mcode1_route["slabto"].ToString();
            }
            else
            {
                String_Route_mcode1 = String_Route_mcode1 + '^' + dr_mcode1_route["slabfrom"].ToString();
                String_Route_mcode12 = String_Route_mcode12 + '^' + dr_mcode1_route["slabto"].ToString();
            }
        }

        string[] String_Route_mcode1_Arr = String_Route_mcode1.Split('^');
        string[] String_Route_mcode12_Arr = String_Route_mcode12.Split('^');

        dr_mcode1_route.Close();

        TableRow tr = new TableRow();
        TableCell tc1 = new TableCell();
        // TableCell tc1 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "Variable Charges ";
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);
        tc1.ColumnSpan = String_Vehtype_mcode1_Arr.Length+2 ;
        tblMatrix2b.Rows.Add(tr);

        TableRow trveh = new TableRow();

        tc1 = new TableCell();
        tc1.Text = "Tonnage - >";
        tc1.ColumnSpan = 2;
        tc1.Wrap = false;
        trveh.Cells.Add(tc1);
        trveh.CssClass = "blackfnt";
        trveh.BackColor = System.Drawing.Color.White;

        for (int k = 0; k < String_Vehtype_mcode1_Arr.Length; k++)
        {
            TableCell tcVeh = new TableCell();

            tcVeh.Text = String_Vehtype_mcode1_Arr[k].ToString();
            trveh.Cells.Add(tcVeh);
        }
        tblMatrix2b.Rows.Add(trveh);


        TableRow trRoute = new TableRow();
        tc1 = new TableCell();
        TableCell tc2 = new TableCell();
        TableCell tc3 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc2.CssClass = "blackfnt";
        tc1.Text = "From";
        tc2.Text = "To";
        tc3.Text = "";
        trRoute.BackColor = System.Drawing.Color.White;
        trRoute.Cells.Add(tc1);
        tc3.ColumnSpan = String_Vehtype_mcode1_Arr.Length;
        trRoute.Cells.Add(tc2);
        trRoute.Cells.Add(tc3);
        tblMatrix2b.Rows.Add(trRoute);

        for (int Rk = 0; Rk < String_Route_mcode1_Arr.Length; Rk++)
        {
            TableRow trRouteData = new TableRow();
            trRouteData.BackColor = System.Drawing.Color.White;
            TableCell tcRoute = new TableCell();

            tcRoute.Text = String_Route_mcode1_Arr[Rk].ToString();
            tcRoute.CssClass = "blackfnt";
            trRouteData.Cells.Add(tcRoute);
            TableCell tcRoute1 = new TableCell();

            tcRoute1.Text = String_Route_mcode12_Arr[Rk].ToString();
            tcRoute1.CssClass = "blackfnt";
            trRouteData.Cells.Add(tcRoute1);
            tcRoute.Wrap = false;
            for (int RDK = 0; RDK < String_Vehtype_mcode1_Arr.Length; RDK++)
            {

                String SQL_VEH_route = "select slabrate from  webx_vendor_contract_charges  where convert(varchar,vehtype,106)='" + String_Vehtype_mcode12_Arr[RDK] + "' and  slabfrom='" + String_Route_mcode1_Arr[Rk] + "'and  slabto='" + String_Route_mcode12_Arr[Rk] + "' and vendorcode='" + VendorCode + "' and contractcd='" + ContractID + "' and matrixcode='2' and chargetype='Variable' ";
                SqlCommand cmd_VEH_route = new SqlCommand(SQL_VEH_route, conn);
                SqlDataReader drRDK = cmd_VEH_route.ExecuteReader();
                String Route_vehData = "";
                while (drRDK.Read())
                {
                    Route_vehData = drRDK["slabrate"].ToString();
                }

                drRDK.Close();



                TableCell tcRDK = new TableCell();

                tcRDK.Text = Route_vehData;
                tcRDK.CssClass = "blackfnt";
                trRouteData.Cells.Add(tcRDK);


                
            }


            tblMatrix2b.Rows.Add(trRouteData);
        }

    }

    private void Matrix9()
    {
    tblMatrix2a_9.Visible = true;


        String SQL_MCODE2a = "select * from webx_vendor_contract_charges where matrixcode='9' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE2a, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Per Km.";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);

            row12.Visible = false;
        }

        dr_mcode2.Close();
    }

    private void Matrix5()
    {
        tblMatrix2a_9.Visible = true;
        tblRailSlab.Visible = true;


        String SQL_MCODE2a = "select * from webx_vendor_contract_charges where matrixcode='5' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE2a, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Per Km.";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);

            RWAT.Visible = false;
        }

        dr_mcode2.Close();


        string SqlStr = "select * from webx_vendor_contract_charges where matrixcode='5' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";
        SqlCommand cmd = new SqlCommand(SqlStr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        int i = 1;
        while (dr.Read())
        {
            
            if (i == 1)
            {
                lblSF1.Text = Convert.ToString(dr["SlabFrom"]);
                lblST1.Text = Convert.ToString(dr["SlabTo"]);
            }
            if (i == 2)
            {
                lblSF2.Text = Convert.ToString(dr["SlabFrom"]);
                lblST2.Text = Convert.ToString(dr["SlabTo"]);
            }
            if (i == 3)
            {
                lblSF3.Text = Convert.ToString(dr["SlabFrom"]);
                lblST3.Text = Convert.ToString(dr["SlabTo"]);
            }
            if (i == 4)
            {
                lblSF4.Text = Convert.ToString(dr["SlabFrom"]);
                lblST4.Text = Convert.ToString(dr["SlabTo"]);
            }
            if (i == 5)
            {
                lblSF5.Text = Convert.ToString(dr["SlabFrom"]);
                lblST5.Text = Convert.ToString(dr["SlabTo"]);
            }
            if (i == 6)
            {
                lblSF6.Text = Convert.ToString(dr["SlabFrom"]);
                lblST6.Text = Convert.ToString(dr["SlabTo"]);

            }
            
            i = i + 1;
        }
        dr.Close();

        //tblSC.Visible = true;

        //string SqlStr1 = "select  c.*,c.routecd from webx_vendor_contract_charges c,webx_rutmas r where matrixcode='5' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "' and c.routecd = r.rutcd";
        //SqlCommand cmd1 = new SqlCommand(SqlStr1, conn);
        //SqlDataReader dr1 = cmd.ExecuteReader();

        //TableRow trHead = new TableRow();
        //TableCell tcHead1 = new TableCell();
        //TableCell tcHead2= new TableCell();
        //TableCell tcHead3 = new TableCell();
        //TableCell tcHead4 = new TableCell();
        //TableCell tcHead5 = new TableCell();
        //TableCell tcHead6 = new TableCell();
        //TableCell tcHead7 = new TableCell();
        //TableCell tcHead8 = new TableCell();
        //TableCell tcHead9 = new TableCell();
        //TableCell tcHead10 = new TableCell();

        //trHead.CssClass = "blackfnt";
        //trHead.BackColor = System.Drawing.Color.White;
        //tcHead1.Text = "Sr No.";
        //tcHead2.Text = "Route/Tonnage";
        //tcHead3.Text = "Min.";
        //tcHead4.Text = "Max";
        //tcHead5.Text = "Slab 1 Rate";
        //tcHead6.Text = "Slab 2 Rate";
        //tcHead7.Text = "Slab 3 Rate";
        //tcHead8.Text = "Slab 4 Rate";
        //tcHead9.Text = "Slab 5 Rate";
        //tcHead10.Text = "Slab 6 Rate";

        //tcHead1.HorizontalAlign = HorizontalAlign.Center;
        //tcHead2.HorizontalAlign = HorizontalAlign.Center;
        //tcHead3.HorizontalAlign = HorizontalAlign.Center;
        //tcHead4.HorizontalAlign = HorizontalAlign.Center;
        //tcHead5.HorizontalAlign = HorizontalAlign.Center;
        //tcHead6.HorizontalAlign = HorizontalAlign.Center;
        //tcHead7.HorizontalAlign = HorizontalAlign.Center;
        //tcHead8.HorizontalAlign = HorizontalAlign.Center;
        //tcHead9.HorizontalAlign = HorizontalAlign.Center;
        //tcHead10.HorizontalAlign = HorizontalAlign.Center;

        //tcHead1.Font.Bold = true;
        //tcHead2.Font.Bold = true;
        //tcHead3.Font.Bold = true;
        //tcHead4.Font.Bold = true;
        //tcHead5.Font.Bold = true;
        //tcHead6.Font.Bold = true;
        //tcHead7.Font.Bold = true;
        //tcHead8.Font.Bold = true;
        //tcHead9.Font.Bold = true;
        //tcHead10.Font.Bold = true;

        //trHead.Cells.Add(tcHead1);
        //trHead.Cells.Add(tcHead2);
        //trHead.Cells.Add(tcHead3);
        //trHead.Cells.Add(tcHead4);
        //trHead.Cells.Add(tcHead5);
        //trHead.Cells.Add(tcHead6);
        //trHead.Cells.Add(tcHead7);
        //trHead.Cells.Add(tcHead8);
        //trHead.Cells.Add(tcHead9);
        //trHead.Cells.Add(tcHead10);

        //tblSC.Rows.Add(trHead);
        //int srno = 1;
        //int j = 1;
        //while (dr1.Read())
        //{
        //    TableRow trDet = new TableRow();
        //    TableCell tcDet1 = new TableCell();
        //    TableCell tcDet2 = new TableCell();
        //    TableCell tcDet3 = new TableCell();
        //    TableCell tcDet4 = new TableCell();
        //    TableCell tcDet5 = new TableCell();
        //    TableCell tcDet6 = new TableCell();
        //    TableCell tcDet7 = new TableCell();
        //    TableCell tcDet8 = new TableCell();
        //    TableCell tcDet9 = new TableCell();
        //    TableCell tcDet10 = new TableCell();

        //    trDet.CssClass = "blackfnt";
        //    trDet.BackColor = System.Drawing.Color.White;

        //    tcDet1.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet2.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet3.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet4.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet5.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet6.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet7.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet8.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet9.HorizontalAlign = HorizontalAlign.Center;
        //    tcDet10.HorizontalAlign = HorizontalAlign.Center;
            


        //    tcDet1.Text = Convert.ToString(srno);
        //    tcDet2.Text = dr1["routecd"].ToString();
        //    //tcDet2.Text = "";
        //    tcDet3.Text = dr1["MinVal"].ToString();
        //    tcDet4.Text = dr1["MaxVal"].ToString();
        //    tcDet5.Text = dr1["slabrate"].ToString();
        //    tcDet6.Text = dr1["slabrate"].ToString();
        //    tcDet7.Text = dr1["slabrate"].ToString();
        //    tcDet8.Text = dr1["slabrate"].ToString();
        //    tcDet9.Text = dr1["slabrate"].ToString();
        //    tcDet10.Text = dr1["slabrate"].ToString();

        //    trDet.Cells.Add(tcDet1);
        //    trDet.Cells.Add(tcDet2);
        //    trDet.Cells.Add(tcDet3);
        //    trDet.Cells.Add(tcDet4);
        //    trDet.Cells.Add(tcDet5);
        //    trDet.Cells.Add(tcDet6);
        //    trDet.Cells.Add(tcDet7);
        //    trDet.Cells.Add(tcDet8);
        //    trDet.Cells.Add(tcDet9);
        //    trDet.Cells.Add(tcDet10);

        //    tblSC.Rows.Add(trDet);

           
        //}
        //dr1.Close();

        grvSlab.Visible = true;

        string[] arrrow = new string[9];
        string s = "";
        dtSlabRate = CreateDataTable();
        string sqlval = "select  c.*,c.routecd+':'+r.rutnm as rutnm from webx_vendor_contract_charges c,webx_rutmas r where matrixcode='5' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "' and c.routecd = r.rutcd";
        SqlCommand cmd1 = new SqlCommand(sqlval,conn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        int cnt = 0;
        while (dr1.Read())
        {
            if (cnt == 0)
            {
                s = dr1["rutnm"].ToString() + "~";
                s = s + dr1["MinVal"].ToString() + "~";
                s = s + dr1["MaxVal"].ToString() + "~";
                cnt += 3;
            }

            s = s + dr1["slabrate"].ToString() + "~";
            cnt += 1;
            if (cnt == 9)
            {
                s = s.Remove(s.Length - 1);
                arrrow = s.Split('~');
                cnt = 0;
                AddDataToTable(arrrow[0], arrrow[1], arrrow[2], arrrow[3], arrrow[4], arrrow[5], arrrow[6], arrrow[7], arrrow[8], dtSlabRate);
                arrrow = null;
                s = "";
            }
        }
        dr.Close();

        if (dtSlabRate.Rows.Count > 0)
        {
            grvSlab.DataSource = dtSlabRate;
            grvSlab.DataBind();
        }
        
    }

    private void AddDataToTable(string routecd, string MinVal, string MaxVal, string slab1, string slab2, string slab3, string slab4, string slab5, string slab6, DataTable myTable)
    {
        DataRow row;

        row = myTable.NewRow();
        row["rutnm"] = routecd;
        row["MinVal"] = MinVal;
        row["MaxVal"] = MaxVal;
        row["slab1"] = slab1;
        row["slab2"] = slab2;
        row["slab3"] = slab3;
        row["slab4"] = slab4;
        row["slab5"] = slab5;
        row["slab6"] = slab6;

        myTable.Rows.Add(row);
    }

    private DataTable CreateDataTable()
    {
        DataTable myDataTable = new DataTable();

        DataColumn myDataColumn;

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "rutnm";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "MinVal";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "MaxVal";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab1";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab2";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab3";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab4";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab5";
        myDataTable.Columns.Add(myDataColumn);

        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "slab6";
        myDataTable.Columns.Add(myDataColumn);

        return myDataTable;

    }

    private void Matrix10()
    {

        tblMatrix10.Visible = true;

        String SQL_MCODE10 = "select * from webx_vendor_contract_charges where matrixcode='10' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE10, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblfchrg.Text = Convert.ToString(dr_mcode2["slabvalue"]);
            
            row12.Visible = false;
        }

        dr_mcode2.Close();
    }

    private void Matrix4()
    {

        tblMatrix2a_9.Visible = true;

        String SQL_MCODE4 = "select * from webx_vendor_contract_charges where matrixcode='4' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE4, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Per Km.";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);

            RWAT.Visible = false;
        }

        dr_mcode2.Close();
    }

    private void Matrix6()
    {

        tblMatrix2a_9.Visible = true;

        String SQL_MCODE4 = "select * from webx_vendor_contract_charges where matrixcode='6' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE4, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Per Km.";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);

            RWAT.Visible = false;
        }

        dr_mcode2.Close();

        tblMatrix6.Visible = true;

        String SQL_MCODE6 = "select * from webx_vendor_contract_charges where matrixcode='6' and chargetype = 'ODA' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode6 = new SqlCommand(SQL_MCODE6, conn);
        SqlDataReader dr_mcode6 = cmd_mcode6.ExecuteReader();
       
        while (dr_mcode6.Read())
        {


            lblminchrg_oda.Text = Convert.ToString(dr_mcode6["slabfrom"]);

            lblmaxchrg_oda.Text = Convert.ToString(dr_mcode6["slabto"]);
            lblvariable_oda.Text = Convert.ToString(dr_mcode6["slabrate"]);

           
        }

        dr_mcode6.Close();

        tblMatrix6b.Visible = true;
        TableRow tr12 = new TableRow();
        TableCell tc112 = new TableCell();
        tc112.CssClass = "blackfnt";
        tc112.Text = "Variable Charges";
        tc112.ColumnSpan = 4;
        tr12.CssClass = "bgbluegrey";
        tr12.Cells.Add(tc112);
        tblMatrix6b.Rows.Add(tr12);

        TableRow tr = new TableRow();
        TableCell tc1 = new TableCell();
         TableCell tc2 = new TableCell();
         TableCell tc3 = new TableCell();
         TableCell tc4 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "From";
        tc2.CssClass = "blackfnt";
        tc2.Text = "To";
        tc3.CssClass = "blackfnt";
        tc3.Text = "Rate-Door";
        tc4.CssClass = "blackfnt";
        tc4.Text = "Rate-Godown";
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        tr.Cells.Add(tc3);
        tr.Cells.Add(tc4);

        tblMatrix6b.Rows.Add(tr);

        String SQL_MCODE6a = "select * from webx_vendor_contract_charges where matrixcode='6' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'  order by chargeid";

        SqlCommand cmd_mcode6a = new SqlCommand(SQL_MCODE6a, conn);
        SqlDataReader dr_mcode6a = cmd_mcode6a.ExecuteReader();
        String fromval = "", fromval1 = "", toval = "", toval1 = "", vhtype = "", rate_dorr = "", rate_godown = "";
        String String_from = "", String_to = "", String_Rate_Door = "", String_Rate_Godown="";

        while (dr_mcode6a.Read())
        {
            toval = dr_mcode6a["slabto"].ToString();
            fromval = dr_mcode6a["slabfrom"].ToString();
            vhtype= dr_mcode6a["vehtype"].ToString();
            if (vhtype == "1")
            {
                rate_dorr = dr_mcode6a["slabrate"].ToString();
            }
            if (vhtype == "2")
            {
                rate_godown = dr_mcode6a["slabrate"].ToString();
            }

            if (fromval != fromval1 && toval != toval1)
            {
                if (String_from == "")
                {

                    String_from = dr_mcode6a["slabfrom"].ToString();
                    String_to = dr_mcode6a["slabto"].ToString();
                   
                }
                else
                {
                    String_from = String_from + '^' + dr_mcode6a["slabfrom"].ToString();
                    String_to = String_to + '^' + dr_mcode6a["slabto"].ToString();
                    
                }

               

            }
            if (fromval != fromval1 && toval != toval1 && String_Rate_Door != rate_dorr)
            {
                if (String_Rate_Door == "")
                {
                    String_Rate_Door = rate_dorr;
                }
                else
                {
                    String_Rate_Door = String_Rate_Door + '^' + rate_dorr;
                }
            }

            if (vhtype == "2")
            {

                if (String_Rate_Godown == "")
                {
                    String_Rate_Godown = rate_godown;
                }
                else
                {
                    String_Rate_Godown = String_Rate_Godown + '^' + rate_godown;
                }
            }

            fromval1 = dr_mcode6a["slabfrom"].ToString();
            toval1 = dr_mcode6a["slabto"].ToString();
        }

        dr_mcode6a.Close();


        string[] String_from_arr = String_from.Split('^');
        string[] String_to_arr = String_to.Split('^');
        string[] String_Rate_Door_arr = String_Rate_Door.Split('^');
        string[] String_Rate_Godown_arr = String_Rate_Godown.Split('^');

        for (int DO_g = 0; DO_g < String_from_arr.Length; DO_g++)
        {
            TableRow tr_rate = new TableRow();
             tc1 = new TableCell();
             tc2 = new TableCell();
             tc3 = new TableCell();
             tc4 = new TableCell();

             tc1.CssClass = "blackfnt";
             tc1.Text = String_from_arr[DO_g];
             tc2.CssClass = "blackfnt";
             tc2.Text = String_to_arr[DO_g];
             tc3.CssClass = "blackfnt";
             tc3.Text = String_Rate_Door_arr[DO_g];
             tc4.CssClass = "blackfnt";
             tc4.Text = String_Rate_Godown_arr[DO_g];

             tr_rate.Cells.Add(tc1);
             tr_rate.Cells.Add(tc2);
             tr_rate.Cells.Add(tc3);
             tr_rate.Cells.Add(tc4);
             tr_rate.BackColor = System.Drawing.Color.White;
             tblMatrix6b.Rows.Add(tr_rate);
        }
    }

    private void Matrix7()
    {
        tblMatrix2a_9.Visible = true;

        String SQL_MCODE4 = "select * from webx_vendor_contract_charges where matrixcode='7' and chargetype = 'Fixed' and vendorcode='" + VendorCode + "' and CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd_mcode2 = new SqlCommand(SQL_MCODE4, conn);
        SqlDataReader dr_mcode2 = cmd_mcode2.ExecuteReader();
        String String_Vehtype_mcode2 = "";
        while (dr_mcode2.Read())
        {

            lblchargebasis.Text = Convert.ToString(dr_mcode2["chargebasis"]);
            lblslabbasis.Text = "Rs. of freight  ";
            lblAPPT.Text = Convert.ToString(dr_mcode2["Docname"]);

            lblminchrg.Text = Convert.ToString(dr_mcode2["slabfrom"]);

            lblmaxchrg.Text = Convert.ToString(dr_mcode2["slabto"]);

            RWAT.Visible = false;
        }

        dr_mcode2.Close();

        String SQL_validSertype = "select serroad,serAir,serrail,SerExpress from webx_vendor_contract_Summary where vendorcode='" + VendorCode + "'";
        SqlCommand cmd_mcode2a = new SqlCommand(SQL_validSertype, conn);
        SqlDataReader dr_mcode2a = cmd_mcode2a.ExecuteReader();
        String St_road = "", St_rail = "", St_Air = "", St_Exp = "";
        while (dr_mcode2a.Read())
        {
            St_road = Convert.ToString(dr_mcode2a["serroad"]);
            St_rail = Convert.ToString(dr_mcode2a["serrail"]);
            St_Air = Convert.ToString(dr_mcode2a["serAir"]);
            St_Exp = Convert.ToString(dr_mcode2a["SerExpress"]);

        }
        dr_mcode2a.Close();
        ///////////////////////////////////////////////Rail Start//////////////////////////

        if (St_rail == "Y")
        {

            tblMatrix7a.Visible = true;
            TableRow tr127a = new TableRow();
            TableCell tc1127a = new TableCell();
            tc1127a.CssClass = "blackfnt";
            tc1127a.Text = "Rail Variable Charges";
            tc1127a.ColumnSpan = 5;
            tr127a.CssClass = "bgbluegrey";
            tr127a.Cells.Add(tc1127a);
            tblMatrix7a.Rows.Add(tr127a);

            TableRow tr7a = new TableRow();
            TableCell tc17a = new TableCell();
            TableCell tc27a = new TableCell();
            TableCell tc37a = new TableCell();
            TableCell tc47a = new TableCell();
            TableCell tc57a = new TableCell();
            tc17a.CssClass = "blackfnt";
            tc17a.Text = "From";
            tc27a.CssClass = "blackfnt";
            tc27a.Text = "To";
            tc37a.CssClass = "blackfnt";
            tc37a.Text = "Rate-TBB";
            tc47a.CssClass = "blackfnt";
            tc47a.Text = "Rate-Topay";
            tc57a.CssClass = "blackfnt";
            tc57a.Text = "Rate-Paid";
            tr7a.CssClass = "bgbluegrey";
            tr7a.Cells.Add(tc17a);
            tr7a.Cells.Add(tc27a);
            tr7a.Cells.Add(tc37a);
            tr7a.Cells.Add(tc47a);
            tr7a.Cells.Add(tc57a);

            tblMatrix7a.Rows.Add(tr7a);

            String SQL_MCODE7a = "select * from webx_vendor_contract_charges where matrixcode='7' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and calmethod='3' and CONTRACTCD='" + ContractID + "'  order by chargeid";

            SqlCommand cmd_mcode7a = new SqlCommand(SQL_MCODE7a, conn);
            SqlDataReader dr_mcode7a = cmd_mcode7a.ExecuteReader();
            String fromval7a = "", fromval17a = "", toval7a = "", toval17a = "", vhtype7a = "", rate_dorr7a = "", rate_godown7a = "", rate_Paid7a = "";
            String String_from7a = "", String_to7a = "", String_Rate_Door7a = "", String_Rate_Godown7a = "", String_Rate_Paid7a = "";

            while (dr_mcode7a.Read())
            {
                toval7a = dr_mcode7a["slabto"].ToString();
                fromval7a = dr_mcode7a["slabfrom"].ToString();
                vhtype7a = dr_mcode7a["routecd"].ToString();
                if (vhtype7a == "P01")
                {
                    rate_dorr7a = dr_mcode7a["slabrate"].ToString();
                }
                if (vhtype7a == "P02")
                {
                    rate_godown7a = dr_mcode7a["slabrate"].ToString();
                }
                if (vhtype7a == "P03")
                {
                    rate_Paid7a = dr_mcode7a["slabrate"].ToString();
                }

                if (fromval7a != fromval17a && toval7a != toval17a)
                {
                    if (String_from7a == "")
                    {

                        String_from7a = dr_mcode7a["slabfrom"].ToString();
                        String_to7a = dr_mcode7a["slabto"].ToString();

                    }
                    else
                    {
                        String_from7a = String_from7a + '^' + dr_mcode7a["slabfrom"].ToString();
                        String_to7a = String_to7a + '^' + dr_mcode7a["slabto"].ToString();

                    }



                }
                if (vhtype7a == "P01")
                {
                    if (String_Rate_Door7a == "")
                    {
                        String_Rate_Door7a = rate_dorr7a;
                    }
                    else
                    {
                        String_Rate_Door7a = String_Rate_Door7a + '^' + rate_dorr7a;
                    }
                }

                if (vhtype7a == "P02")
                {

                    if (String_Rate_Godown7a == "")
                    {
                        String_Rate_Godown7a = rate_godown7a;
                    }
                    else
                    {
                        String_Rate_Godown7a = String_Rate_Godown7a + '^' + rate_godown7a;
                    }
                }

                if (vhtype7a == "P03")
                {

                    if (String_Rate_Paid7a == "")
                    {
                        String_Rate_Paid7a = rate_Paid7a;
                    }
                    else
                    {
                        String_Rate_Paid7a = String_Rate_Paid7a + '^' + rate_Paid7a;
                    }
                }

                fromval17a = dr_mcode7a["slabfrom"].ToString();
                toval17a = dr_mcode7a["slabto"].ToString();
            }

            dr_mcode7a.Close();


            string[] String_from_arr7a = String_from7a.Split('^');
            string[] String_to_arr7a = String_to7a.Split('^');
            string[] String_Rate_Door_arr7a = String_Rate_Door7a.Split('^');
            string[] String_Rate_Godown_arr7a = String_Rate_Godown7a.Split('^');
            string[] String_Rate_Paid7a_arr7a = String_Rate_Paid7a.Split('^');

            

            for (int DO_g7a = 0; DO_g7a < String_from_arr7a.Length; DO_g7a++)
            {
                TableRow tr_rate7a = new TableRow();
                tc17a = new TableCell();
                tc27a = new TableCell();
                tc37a = new TableCell();
                tc47a = new TableCell();
                tc57a = new TableCell();

                tc17a.CssClass = "blackfnt";
                tc17a.Text = String_from_arr7a[DO_g7a];
                tc27a.CssClass = "blackfnt";
                tc27a.Text = String_to_arr7a[DO_g7a];
                tc37a.CssClass = "blackfnt";
                tc37a.Text = String_Rate_Door_arr7a[DO_g7a];
                tc47a.CssClass = "blackfnt";
                tc47a.Text = String_Rate_Godown_arr7a[DO_g7a];
                tc57a.CssClass = "blackfnt";
                tc57a.Text = String_Rate_Paid7a_arr7a[DO_g7a];

                tr_rate7a.Cells.Add(tc17a);
                tr_rate7a.Cells.Add(tc27a);
                tr_rate7a.Cells.Add(tc37a);
                tr_rate7a.Cells.Add(tc47a);
                tr_rate7a.Cells.Add(tc57a);
                tr_rate7a.BackColor = System.Drawing.Color.White;
                tblMatrix7a.Rows.Add(tr_rate7a);
            }
        }


        ///////////////////////////////////////////////Rail END  Air Start//////////////////////////

        if(St_Air=="Y")
        {

            tblMatrix7b.Visible = true;
            TableRow tr127b = new TableRow();
            TableCell tc1127b = new TableCell();
            tc1127b.CssClass = "blackfnt";
            tc1127b.Text = "Air Variable Charges";
            tc1127b.ColumnSpan = 5;
            tr127b.CssClass = "bgbluegrey";
            tr127b.Cells.Add(tc1127b);
            tblMatrix7b.Rows.Add(tr127b);

            TableRow tr7b = new TableRow();
            TableCell tc17b = new TableCell();
            TableCell tc27b = new TableCell();
            TableCell tc37b = new TableCell();
            TableCell tc47b = new TableCell();
            TableCell tc57b = new TableCell();
            tc17b.CssClass = "blackfnt";
            tc17b.Text = "From";
            tc27b.CssClass = "blackfnt";
            tc27b.Text = "To";
            tc37b.CssClass = "blackfnt";
            tc37b.Text = "Rate-TBB";
            tc47b.CssClass = "blackfnt";
            tc47b.Text = "Rate-Topay";
            tc57b.CssClass = "blackfnt";
            tc57b.Text = "Rate-Paid";
            tr7b.CssClass = "bgbluegrey";
            tr7b.Cells.Add(tc17b);
            tr7b.Cells.Add(tc27b);
            tr7b.Cells.Add(tc37b);
            tr7b.Cells.Add(tc47b);
            tr7b.Cells.Add(tc57b);

            tblMatrix7b.Rows.Add(tr7b);

            String SQL_MCODE7b = "select * from webx_vendor_contract_charges where matrixcode='7' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and calmethod='1' and CONTRACTCD='" + ContractID + "'  order by chargeid";

            SqlCommand cmd_mcode7b = new SqlCommand(SQL_MCODE7b, conn);
            SqlDataReader dr_mcode7b = cmd_mcode7b.ExecuteReader();
            String fromval7b = "", fromval17b = "", toval7b = "", toval17b = "", vhtype7b = "", rate_dorr7b = "", rate_godown7b = "", rate_Paid7b = "";
            String String_from7b = "", String_to7b = "", String_Rate_Door7b = "", String_Rate_Godown7b = "", String_Rate_Paid7b = "";

            while (dr_mcode7b.Read())
            {
                toval7b = dr_mcode7b["slabto"].ToString();
                fromval7b = dr_mcode7b["slabfrom"].ToString();
                vhtype7b = dr_mcode7b["routecd"].ToString();
                if (vhtype7b == "P01")
                {
                    rate_dorr7b = dr_mcode7b["slabrate"].ToString();
                }
                if (vhtype7b == "P02")
                {
                    rate_godown7b = dr_mcode7b["slabrate"].ToString();
                }
                if (vhtype7b == "P03")
                {
                    rate_Paid7b = dr_mcode7b["slabrate"].ToString();
                }

                if (fromval7b != fromval17b && toval7b != toval17b)
                {
                    if (String_from7b == "")
                    {

                        String_from7b = dr_mcode7b["slabfrom"].ToString();
                        String_to7b = dr_mcode7b["slabto"].ToString();

                    }
                    else
                    {
                        String_from7b = String_from7b + '^' + dr_mcode7b["slabfrom"].ToString();
                        String_to7b = String_to7b + '^' + dr_mcode7b["slabto"].ToString();

                    }



                }
                if (vhtype7b == "P01")
                {
                    if (String_Rate_Door7b == "")
                    {
                        String_Rate_Door7b = rate_dorr7b;
                    }
                    else
                    {
                        String_Rate_Door7b = String_Rate_Door7b + '^' + rate_dorr7b;
                    }
                }

                if (vhtype7b == "P02")
                {

                    if (String_Rate_Godown7b == "")
                    {
                        String_Rate_Godown7b = rate_godown7b;
                    }
                    else
                    {
                        String_Rate_Godown7b = String_Rate_Godown7b + '^' + rate_godown7b;
                    }
                }

                if (vhtype7b == "P03")
                {

                    if (String_Rate_Paid7b == "")
                    {
                        String_Rate_Paid7b = rate_Paid7b;
                    }
                    else
                    {
                        String_Rate_Paid7b = String_Rate_Paid7b + '^' + rate_Paid7b;
                    }
                }

                fromval17b = dr_mcode7b["slabfrom"].ToString();
                toval17b = dr_mcode7b["slabto"].ToString();
            }

            dr_mcode7b.Close();


            string[] String_from_arr7b = String_from7b.Split('^');
            string[] String_to_arr7b = String_to7b.Split('^');
            string[] String_Rate_Door_arr7b = String_Rate_Door7b.Split('^');
            string[] String_Rate_Godown_arr7b = String_Rate_Godown7b.Split('^');
            string[] String_Rate_Paid7b_arr7b = String_Rate_Paid7b.Split('^');



            for (int DO_g7b = 0; DO_g7b < String_from_arr7b.Length; DO_g7b++)
            {
                TableRow tr_rate7b = new TableRow();
                tc17b = new TableCell();
                tc27b = new TableCell();
                tc37b = new TableCell();
                tc47b = new TableCell();
                tc57b = new TableCell();

                tc17b.CssClass = "blackfnt";
                tc17b.Text = String_from_arr7b[DO_g7b];
                tc27b.CssClass = "blackfnt";
                tc27b.Text = String_to_arr7b[DO_g7b];
                tc37b.CssClass = "blackfnt";
                tc37b.Text = String_Rate_Door_arr7b[DO_g7b];
                tc47b.CssClass = "blackfnt";
                tc47b.Text = String_Rate_Godown_arr7b[DO_g7b];
                tc57b.CssClass = "blackfnt";
                tc57b.Text = String_Rate_Paid7b_arr7b[DO_g7b];

                tr_rate7b.Cells.Add(tc17b);
                tr_rate7b.Cells.Add(tc27b);
                tr_rate7b.Cells.Add(tc37b);
                tr_rate7b.Cells.Add(tc47b);
                tr_rate7b.Cells.Add(tc57b);
                tr_rate7b.BackColor = System.Drawing.Color.White;
                tblMatrix7b.Rows.Add(tr_rate7b);
            }
        }


        ///////////////////////////////////////////////Air END  Road Start//////////////////////////

        if (St_road == "Y")
        {

            tblMatrix7c.Visible = true;
            TableRow tr127c = new TableRow();
            TableCell tc1127c = new TableCell();
            tc1127c.CssClass = "blackfnt";
            tc1127c.Text = "Road Variable Charges";
            tc1127c.ColumnSpan = 5;
            tr127c.CssClass = "bgbluegrey";
            tr127c.Cells.Add(tc1127c);
            tblMatrix7c.Rows.Add(tr127c);

            TableRow tr7c = new TableRow();
            TableCell tc17c = new TableCell();
            TableCell tc27c = new TableCell();
            TableCell tc37c = new TableCell();
            TableCell tc47c = new TableCell();
            TableCell tc57c = new TableCell();
            tc17c.CssClass = "blackfnt";
            tc17c.Text = "From";
            tc27c.CssClass = "blackfnt";
            tc27c.Text = "To";
            tc37c.CssClass = "blackfnt";
            tc37c.Text = "Rate-TBB";
            tc47c.CssClass = "blackfnt";
            tc47c.Text = "Rate-Topay";
            tc57c.CssClass = "blackfnt";
            tc57c.Text = "Rate-Paid";
            tr7c.CssClass = "bgbluegrey";
            tr7c.Cells.Add(tc17c);
            tr7c.Cells.Add(tc27c);
            tr7c.Cells.Add(tc37c);
            tr7c.Cells.Add(tc47c);
            tr7c.Cells.Add(tc57c);

            tblMatrix7c.Rows.Add(tr7c);

            String SQL_MCODE7c = "select * from webx_vendor_contract_charges where matrixcode='7' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and calmethod='2' and CONTRACTCD='" + ContractID + "'  order by chargeid";

            SqlCommand cmd_mcode7c = new SqlCommand(SQL_MCODE7c, conn);
            SqlDataReader dr_mcode7c = cmd_mcode7c.ExecuteReader();
            String fromval7c = "", fromval17c = "", toval7c = "", toval17c = "", vhtype7c = "", rate_dorr7c = "", rate_godown7c = "", rate_Paid7c = "";
            String String_from7c = "", String_to7c = "", String_Rate_Door7c = "", String_Rate_Godown7c = "", String_Rate_Paid7c = "";

            while (dr_mcode7c.Read())
            {
                toval7c = dr_mcode7c["slabto"].ToString();
                fromval7c = dr_mcode7c["slabfrom"].ToString();
                vhtype7c = dr_mcode7c["routecd"].ToString();
                if (vhtype7c == "P01")
                {
                    rate_dorr7c = dr_mcode7c["slabrate"].ToString();
                }
                if (vhtype7c == "P02")
                {
                    rate_godown7c = dr_mcode7c["slabrate"].ToString();
                }
                if (vhtype7c == "P03")
                {
                    rate_Paid7c = dr_mcode7c["slabrate"].ToString();
                }

                if (fromval7c != fromval17c && toval7c != toval17c)
                {
                    if (String_from7c == "")
                    {

                        String_from7c = dr_mcode7c["slabfrom"].ToString();
                        String_to7c = dr_mcode7c["slabto"].ToString();

                    }
                    else
                    {
                        String_from7c = String_from7c + '^' + dr_mcode7c["slabfrom"].ToString();
                        String_to7c = String_to7c + '^' + dr_mcode7c["slabto"].ToString();

                    }



                }
                if (vhtype7c == "P01")
                {
                    if (String_Rate_Door7c == "")
                    {
                        String_Rate_Door7c = rate_dorr7c;
                    }
                    else
                    {
                        String_Rate_Door7c = String_Rate_Door7c + '^' + rate_dorr7c;
                    }
                }

                if (vhtype7c == "P02")
                {

                    if (String_Rate_Godown7c == "")
                    {
                        String_Rate_Godown7c = rate_godown7c;
                    }
                    else
                    {
                        String_Rate_Godown7c = String_Rate_Godown7c + '^' + rate_godown7c;
                    }
                }

                if (vhtype7c == "P03")
                {

                    if (String_Rate_Paid7c == "")
                    {
                        String_Rate_Paid7c = rate_Paid7c;
                    }
                    else
                    {
                        String_Rate_Paid7c = String_Rate_Paid7c + '^' + rate_Paid7c;
                    }
                }

                fromval17c = dr_mcode7c["slabfrom"].ToString();
                toval17c = dr_mcode7c["slabto"].ToString();
            }

            dr_mcode7c.Close();


            string[] String_from_arr7c = String_from7c.Split('^');
            string[] String_to_arr7c = String_to7c.Split('^');
            string[] String_Rate_Door_arr7c = String_Rate_Door7c.Split('^');
            string[] String_Rate_Godown_arr7c = String_Rate_Godown7c.Split('^');
            string[] String_Rate_Paid7c_arr7c = String_Rate_Paid7c.Split('^');



            for (int DO_g7c = 0; DO_g7c < String_from_arr7c.Length; DO_g7c++)
            {
                TableRow tr_rate7c = new TableRow();
                tc17c = new TableCell();
                tc27c = new TableCell();
                tc37c = new TableCell();
                tc47c = new TableCell();
                tc57c = new TableCell();

                tc17c.CssClass = "blackfnt";
                tc17c.Text = String_from_arr7c[DO_g7c];
                tc27c.CssClass = "blackfnt";
                tc27c.Text = String_to_arr7c[DO_g7c];
                tc37c.CssClass = "blackfnt";
                tc37c.Text = String_Rate_Door_arr7c[DO_g7c];
                tc47c.CssClass = "blackfnt";
                tc47c.Text = String_Rate_Godown_arr7c[DO_g7c];
                tc57c.CssClass = "blackfnt";
                tc57c.Text = String_Rate_Paid7c_arr7c[DO_g7c];

                tr_rate7c.Cells.Add(tc17c);
                tr_rate7c.Cells.Add(tc27c);
                tr_rate7c.Cells.Add(tc37c);
                tr_rate7c.Cells.Add(tc47c);
                tr_rate7c.Cells.Add(tc57c);
                tr_rate7c.BackColor = System.Drawing.Color.White;
                tblMatrix7c.Rows.Add(tr_rate7c);
            }
        }


        ///////////////////////////////////////////////Road END  EXP Start//////////////////////////

        if (St_Exp == "Y")
        {

            tblMatrix7d.Visible = true;
            TableRow tr127d = new TableRow();
            TableCell tc1127d = new TableCell();
            tc1127d.CssClass = "blackfnt";
            tc1127d.Text = "Express Variable Charges";
            tc1127d.ColumnSpan = 5;
            tr127d.CssClass = "bgbluegrey";
            tr127d.Cells.Add(tc1127d);
            tblMatrix7d.Rows.Add(tr127d);

            TableRow tr7d = new TableRow();
            TableCell tc17d = new TableCell();
            TableCell tc27d = new TableCell();
            TableCell tc37d = new TableCell();
            TableCell tc47d = new TableCell();
            TableCell tc57d = new TableCell();
            tc17d.CssClass = "blackfnt";
            tc17d.Text = "From";
            tc27d.CssClass = "blackfnt";
            tc27d.Text = "To";
            tc37d.CssClass = "blackfnt";
            tc37d.Text = "Rate-TBB";
            tc47d.CssClass = "blackfnt";
            tc47d.Text = "Rate-Topay";
            tc57d.CssClass = "blackfnt";
            tc57d.Text = "Rate-Paid";
            tr7d.CssClass = "bgbluegrey";
            tr7d.Cells.Add(tc17d);
            tr7d.Cells.Add(tc27d);
            tr7d.Cells.Add(tc37d);
            tr7d.Cells.Add(tc47d);
            tr7d.Cells.Add(tc57d);

            tblMatrix7d.Rows.Add(tr7d);

            String SQL_MCODE7d = "select * from webx_vendor_contract_charges where matrixcode='7' and chargetype = 'Variable' and vendorcode='" + VendorCode + "' and calmethod='4' and CONTRACTCD='" + ContractID + "'  order by chargeid";

            SqlCommand cmd_mcode7d = new SqlCommand(SQL_MCODE7d, conn);
            SqlDataReader dr_mcode7d = cmd_mcode7d.ExecuteReader();
            String fromval7d = "", fromval17d = "", toval7d = "", toval17d = "", vhtype7d = "", rate_dorr7d = "", rate_godown7d = "", rate_Paid7d = "";
            String String_from7d = "", String_to7d = "", String_Rate_Door7d = "", String_Rate_Godown7d = "", String_Rate_Paid7d = "";

            while (dr_mcode7d.Read())
            {
                toval7d = dr_mcode7d["slabto"].ToString();
                fromval7d = dr_mcode7d["slabfrom"].ToString();
                vhtype7d = dr_mcode7d["routecd"].ToString();
                if (vhtype7d == "P01")
                {
                    rate_dorr7d = dr_mcode7d["slabrate"].ToString();
                }
                if (vhtype7d == "P02")
                {
                    rate_godown7d = dr_mcode7d["slabrate"].ToString();
                }
                if (vhtype7d == "P03")
                {
                    rate_Paid7d = dr_mcode7d["slabrate"].ToString();
                }

                if (fromval7d != fromval17d && toval7d != toval17d)
                {
                    if (String_from7d == "")
                    {

                        String_from7d = dr_mcode7d["slabfrom"].ToString();
                        String_to7d = dr_mcode7d["slabto"].ToString();

                    }
                    else
                    {
                        String_from7d = String_from7d + '^' + dr_mcode7d["slabfrom"].ToString();
                        String_to7d = String_to7d + '^' + dr_mcode7d["slabto"].ToString();

                    }



                }
                if (vhtype7d == "P01")
                {
                    if (String_Rate_Door7d == "")
                    {
                        String_Rate_Door7d = rate_dorr7d;
                    }
                    else
                    {
                        String_Rate_Door7d = String_Rate_Door7d + '^' + rate_dorr7d;
                    }
                }

                if (vhtype7d == "P02")
                {

                    if (String_Rate_Godown7d == "")
                    {
                        String_Rate_Godown7d = rate_godown7d;
                    }
                    else
                    {
                        String_Rate_Godown7d = String_Rate_Godown7d + '^' + rate_godown7d;
                    }
                }

                if (vhtype7d == "P03")
                {

                    if (String_Rate_Paid7d == "")
                    {
                        String_Rate_Paid7d = rate_Paid7d;
                    }
                    else
                    {
                        String_Rate_Paid7d = String_Rate_Paid7d + '^' + rate_Paid7d;
                    }
                }

                fromval17d = dr_mcode7d["slabfrom"].ToString();
                toval17d = dr_mcode7d["slabto"].ToString();
            }

            dr_mcode7d.Close();


            string[] String_from_arr7d = String_from7d.Split('^');
            string[] String_to_arr7d = String_to7d.Split('^');
            string[] String_Rate_Door_arr7d = String_Rate_Door7d.Split('^');
            string[] String_Rate_Godown_arr7d = String_Rate_Godown7d.Split('^');
            string[] String_Rate_Paid7d_arr7d = String_Rate_Paid7d.Split('^');



            for (int DO_g7d = 0; DO_g7d < String_from_arr7d.Length; DO_g7d++)
            {
                TableRow tr_rate7d = new TableRow();
                tc17d = new TableCell();
                tc27d = new TableCell();
                tc37d = new TableCell();
                tc47d = new TableCell();
                tc57d = new TableCell();

                tc17d.CssClass = "blackfnt";
                tc17d.Text = String_from_arr7d[DO_g7d];
                tc27d.CssClass = "blackfnt";
                tc27d.Text = String_to_arr7d[DO_g7d];
                tc37d.CssClass = "blackfnt";
                tc37d.Text = String_Rate_Door_arr7d[DO_g7d];
                tc47d.CssClass = "blackfnt";
                tc47d.Text = String_Rate_Godown_arr7d[DO_g7d];
                tc57d.CssClass = "blackfnt";
                tc57d.Text = String_Rate_Paid7d_arr7d[DO_g7d];

                tr_rate7d.Cells.Add(tc17d);
                tr_rate7d.Cells.Add(tc27d);
                tr_rate7d.Cells.Add(tc37d);
                tr_rate7d.Cells.Add(tc47d);
                tr_rate7d.Cells.Add(tc57d);
                tr_rate7d.BackColor = System.Drawing.Color.White;
                tblMatrix7d.Rows.Add(tr_rate7d);
            }
        }


        ///////////////////////////////////////////////EXP End//////////////////////////
    }
}
