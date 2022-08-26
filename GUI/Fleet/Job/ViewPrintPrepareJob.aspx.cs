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
public partial class GUI_Fleet_Job_ViewPrintPrepareJob : System.Web.UI.Page
{

    string OrderNo = "";

    protected void Page_Load(object sender, EventArgs e)
    {
     string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;


        OrderNo = Request.QueryString["ONo"];

        if (!IsPostBack)
        {

            Inetialzed();
            BindGrid();
            BindGridPart();
        }
    }


    public void Inetialzed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string str = "select convert(varchar,JOB_ORDER_DT,106) as Odate  "
           + " ,convert(varchar,SENDDT_WORKSHOP,106) as SENDDT_WORKSHOP  "
          + "  ,convert(varchar,RETURNDT_WORKSHOP,106) as RETURNDT_WORKSHOP "
           + " ,(select CodeDesc from webx_master_general where codetype='JOBCARDTYP' and codeid=ORDER_TYPE)as JobCardTypeDesc  "
           + " , Convert(varchar,SENDDT_WORKSHOP,106) as SENDDT_WORKSHOP,Convert(varchar,RETURNDT_WORKSHOP,106) as RETURNDT_WORKSHOP,Convert(varchar,ACTRETURNDT_WORKSHOP,106) as ACTRETURNDT_WORKSHOP "
+ "  ,(case when Service_center_TYpe='Vendor' then (select Vendorname from webx_Vendor_hdr where VendorCode=H.Vendor_Code) "
 + "  else (select LocName from WEBX_LOCATION where LocCode=H.ws_LocCode)  end ) as Vend_Loc "
+ "  ,(select  Type_Name from   webx_Vehicle_type T, webx_vehicle_hdr R  where Vehicle_type=Type_code  and R.Vehno=H.Vehno)  as Veh_cat "
+ "  ,(select  Model_No from   webx_Vehicle_type T, webx_vehicle_hdr R  where Vehicle_type=Type_code  and R.Vehno=H.Vehno)  as Model "
+  "  ,(select  Made_by from   webx_Vehicle_type T, webx_vehicle_hdr R  where Vehicle_type=Type_code  and R.Vehno=H.Vehno)  as Mafg, "

+  "   * from WEBX_FLEET_PM_JOBORDER_HDR  H where  JOB_ORDER_NO='" + OrderNo + "'";
        SqlCommand cmd = new SqlCommand(str, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                lblVehicleNo.Text = Convert.ToString(dr["VEHNO"]);
                lblOrderType.Text = Convert.ToString(dr["JobCardTypeDesc"]);
                lblOrderStatus.Text = Convert.ToString(dr["ORDER_STATUS"]);
                lblSCType.Text = Convert.ToString(dr["SERVICE_CENTER_TYPE"]);
              //  lblApprovedBy.Text = Convert.ToString(dr["Approved_By"]);
                lblKMReading.Text = Convert.ToString(dr["KM_READING"]);

                LblCloseKM.Text = Convert.ToString(dr["CLOSE_KM_READING"]);

                lblEstHrs.Text = Convert.ToString(dr["TOT_EST_LABOUR_HRS"]);
                lblEstCost.Text = Convert.ToString(dr["TOT_EST_LABOUR_COST"]);

                LblActLabourHrs.Text = Convert.ToString(dr["TOT_ACT_LABOUR_HRS"]);
                LblActLabourCost.Text = Convert.ToString(dr["TOT_ACT_LABOUR_COST"]);

                LblTotActPartCost.Text = Convert.ToString(dr["TOT_ACT_PART_COST"]);
                string TOT_ACT_PART_COST = "0", TOT_ACT_LABOUR_COST = "0";
                Double mTOT_ACT_PART_COST = 0, mTOT_ACT_LABOUR_COST = 0;
                Double JobCost = 0;

                if (dr["TOT_ACT_PART_COST"].ToString() != null && dr["TOT_ACT_PART_COST"].ToString()!="")
                {
                    TOT_ACT_PART_COST = dr["TOT_ACT_PART_COST"].ToString();
                    mTOT_ACT_PART_COST = Convert.ToDouble(TOT_ACT_PART_COST);
                }

                if (dr["TOT_ACT_LABOUR_COST"].ToString() != null && dr["TOT_ACT_LABOUR_COST"].ToString() !="")
                {
                    TOT_ACT_LABOUR_COST = dr["TOT_ACT_LABOUR_COST"].ToString();
                    mTOT_ACT_LABOUR_COST = Convert.ToDouble(TOT_ACT_LABOUR_COST);
                }


                JobCost = Convert.ToDouble(mTOT_ACT_PART_COST) + Convert.ToDouble(mTOT_ACT_LABOUR_COST);
                LblJobCost.Text = Convert.ToString(JobCost);



                lblMfg.Text = Convert.ToString(dr["Mafg"]);
                lblModel.Text = Convert.ToString(dr["Model"]);
                lblCategory.Text = Convert.ToString(dr["Veh_cat"]);

                lblOrderNo.Text = OrderNo;
                lblDate.Text = Convert.ToString(dr["Odate"]);


                if (dr["SERVICE_CENTER_TYPE"].ToString().Trim() == "Workshop")
                {
                    lblWLoc.Visible = true;
                    lblVendor.Visible = false;
                    lblBoth.Text = Convert.ToString(dr["Vend_Loc"]);

                }

                if (dr["SERVICE_CENTER_TYPE"].ToString().Trim() == "Vendor")
                {
                    lblWLoc.Visible = false;

                    lblVendor.Visible = true;
                    lblBoth.Text = Convert.ToString(dr["Vend_Loc"]);

                }

                LblSendDt.Text = Convert.ToString(dr["SENDDT_WORKSHOP"]);
                LblReturnDt.Text = Convert.ToString(dr["RETURNDT_WORKSHOP"]);
                LblActReturnDt.Text = Convert.ToString(dr["ACTRETURNDT_WORKSHOP"]);



            }


        }

        dr.Close();

    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        SqlCommand cmd = new SqlCommand("usp_Job_JobOrderDetListView", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        DataGrid1.DataSource = ds;
        DataGrid1.DataBind();
        conn.Close();
    }


    public void BindGridPart()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        SqlCommand cmd = new SqlCommand("usp_Job_JobOrderDetPartView", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        DataGrid2.DataSource = ds;
        DataGrid2.DataBind();
        conn.Close();
    }


}
