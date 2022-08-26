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
public partial class GUI_Fleet_Job_PMRemPMGeneration : System.Web.UI.Page
{
    int mDataCount = 0;
    string cols = "", OrderNo="";
    string VEHNO = "" ,W_GRPCDList="";

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    string strrightnow = "";


    string mVehno = "", mW_Grpcd = "";
    MyFleetDataSet.AckJobOrderRow datarow_AJob;


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        this.Title = pagetitle;


        System.DateTime righnow = System.DateTime.Today;
          strrightnow = righnow.ToString("dd/MM/yyyy");


          lblDate.Text = strrightnow;
          lblOrderType.Text = "Preventive Maintenance";
          lblOrderStatus.Text = "Open";
      
          mVehno = Request.QueryString["mVehno"];
          mW_Grpcd = Request.QueryString["mW_GRPCD"];
        
          lblVehicleNo.Text = mVehno.Trim();

        if (!IsPostBack)
        { 
            Inetialized();
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



    public void Inetialized()
    {
         string selvalues="" ;
         string[] selvaluesArr;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


               selvalues = Session["Pass"].ToString();

              selvaluesArr = selvalues.Split(new char[] { ':' });

                    int maxarr1 = selvaluesArr.GetUpperBound(0);
                    for (int j = 0; j <= maxarr1; j++)
                    {

                        VEHNO = selvaluesArr[0].ToString().Trim();

                        if (j + 1 <= maxarr1)
                        {
                            W_GRPCDList = selvaluesArr[j + 1].ToString().Trim();
                        }

                    }

                
          string str = "usp_Job_GenaratePMOrder";

            SqlCommand cmd = new SqlCommand(str, conn);
            cmd.CommandType = CommandType.StoredProcedure;

          cmd.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = mVehno;

            cmd.Parameters.Add("@Detail", SqlDbType.VarChar).Value = mW_Grpcd;
        

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    lblVehicleNo.Text = VEHNO.Trim() ;
             
                    lblCategory.Text = Convert.ToString(dr["Vehcat"]);

                    lblMfg.Text = Convert.ToString(dr["MFG"]);
                    lblModel.Text = Convert.ToString(dr["Model"]);


                    
                }

            }

        dr.Close();
        conn.Close();

        BindGrid();



    }

    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {

        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
 
        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
         
        row.Cells[0].Text = "Work Group Code & Description:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
 
    }



    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_GenaratePMOrder";

        SqlCommand cmd1 = new SqlCommand(str, conn);
        cmd1.CommandType = CommandType.StoredProcedure;
 
        cmd1.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = mVehno;

        cmd1.Parameters.Add("@Detail", SqlDbType.VarChar).Value = mW_Grpcd;
    
        SqlDataReader dr1 = cmd1.ExecuteReader();

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                string W_GRPCD = Convert.ToString(dr1["W_GRPDESC"]);

                string taskcd = Convert.ToString(dr1["TASKCD"]);
                string TaskType = Convert.ToString(dr1["TaskType"]);
                string TaskDesc = Convert.ToString(dr1["TASKDESC"]);
            
                string EstHrs = "0";
                string EstCost = "0";

                _dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, "", "", "");
                 
            }
             
        }
        dr1.Close();
        GridView1.DataSource = _dataSet.AckJobOrder;
        GridView1.DataBind();

        conn.Close();

    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        { 
            datarow_AJob = ((MyFleetDataSet.AckJobOrderRow)((DataRowView)e.Row.DataItem).Row);

            ((Label)e.Row.FindControl("lblW_GRPCD")).Text = datarow_AJob.W_GRPCD;
            ((Label)e.Row.FindControl("lblTaskCode")).Text = datarow_AJob.Taskcd;

            ((Label)e.Row.FindControl("lblTaskDesc")).Text = datarow_AJob.TaskDesc;
            ((Label)e.Row.FindControl("lblTaskType")).Text = datarow_AJob.TaskType;
            ((TextBox)e.Row.FindControl("txtRemarks")).Text = datarow_AJob.Remark;


        }
    }
    public void addVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
     
        string STR = "select VENDORCODE,VENDORNAME from webx_VENDOR_HDR where Active='Y'";
        conn.Open();
        SqlCommand cmd7 = new SqlCommand(STR, conn);
        SqlDataReader dr7 = cmd7.ExecuteReader();
        ddlVendor.Items.Clear();

        ddlVendor.Items.Add(new ListItem("Select", ""));

        if (dr7.HasRows)
        {
            while (dr7.Read())
            {

                ddlVendor.Items.Add(new ListItem(Convert.ToString(dr7["VENDORNAME"]), Convert.ToString(dr7["VENDORCODE"])));
            }

        }

        dr7.Close();
        conn.Close();

    }




    public void addLocation()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
        string STR = "select LocCode,LocName from webx_location where ActiveFlag='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlWLoc.Items.Clear();

        ddlWLoc.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlWLoc.Items.Add(new ListItem(Convert.ToString(dr["LocName"]), Convert.ToString(dr["LocCode"])));
            }

        }

        dr.Close();
        conn.Close();

    }


    protected void ddlSCtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblVendorHead.Visible = false;
        ddlVendor.Visible = false;
        lblWLocHead.Visible = false;
        ddlWLoc.Visible = false;

        if (ddlSCtype.SelectedItem.Text.Trim() == "Vendor")
        {
            lblVendorHead.Visible = true;
            ddlVendor.Visible = true;

            lblWLocHead.Visible = false;
            ddlWLoc.Visible = false;
            addVendor();
        }

        if (ddlSCtype.SelectedItem.Text.Trim() == "Workshop")
        {
            lblVendorHead.Visible = false;
            ddlVendor.Visible = false;

            lblWLocHead.Visible = true;
            ddlWLoc.Visible = true;
            addLocation();

        }

    }

    public void AddOrder()
    {
        string OrderNo = "";


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        bool success = false;
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();

        try
        {

            string msql = "usp_Job_CreateJobOrderNo";
            SqlCommand cmd4 = new SqlCommand(msql, conn, trans);
            cmd4.CommandType = CommandType.StoredProcedure;
            cmd4.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "JOB";

            SqlDataReader dr4 = cmd4.ExecuteReader();
            if (dr4.HasRows)
            {
                while (dr4.Read())
                {

                    OrderNo = Convert.ToString(dr4[0]);

                }

            }

            dr4.Close();


            string PM_SCHCODE = "";

            string msql1 = "select PM_SCH_CODE  from WEBX_FLEET_PM_SCH_HDR  where  VEHNO='"+lblVehicleNo.Text.Trim()+"'";
            SqlCommand cmd7 = new SqlCommand(msql1, conn, trans);
        
            SqlDataReader dr7 = cmd7.ExecuteReader();
            if (dr7.HasRows)
            {
                while (dr7.Read())
                {

                    PM_SCHCODE = Convert.ToString(dr7[0]);

                }

            }

            dr7.Close();

            string sql1 = "usp_Job_OrderHdrInsertUpdate";
            SqlCommand cmd = new SqlCommand(sql1, conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
            

            cmd.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = PM_SCHCODE;

            cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehicleNo.Text.Trim();
            cmd.Parameters.Add("@OrderType", SqlDbType.VarChar).Value = lblOrderType.Text.Trim();
            cmd.Parameters.Add("@OrderDate", SqlDbType.DateTime).Value = Convert.ToDateTime(lblDate.Text.Trim(), dtfi);
            cmd.Parameters.Add("@OrderStatus", SqlDbType.VarChar).Value = lblOrderStatus.Text.Trim();
            cmd.Parameters.Add("@SCType", SqlDbType.VarChar).Value = ddlSCtype.SelectedItem.Text.Trim();
           
            if (ddlSCtype.SelectedItem.Text.Trim() == "Workshop")
            {
                cmd.Parameters.Add("@Work_Loc", SqlDbType.VarChar).Value = ddlWLoc.SelectedItem.Value.Trim();
             
                cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = "";

            }
            if (ddlSCtype.SelectedItem.Text.Trim() == "Vendor")
            {

                cmd.Parameters.Add("@Work_Loc", SqlDbType.VarChar).Value = "";
             
                cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = ddlVendor.SelectedItem.Value.Trim();
            }

            cmd.Parameters.Add("@Km_Read", SqlDbType.Decimal).Value = Convert.ToDecimal(lblKMReading.Text.Trim());
            cmd.Parameters.Add("@EstHrs", SqlDbType.Decimal).Value = Convert.ToDecimal(0);
            cmd.Parameters.Add("@EstCost", SqlDbType.Decimal).Value = Convert.ToDecimal(0);

            cmd.ExecuteNonQuery();
            string old_W_GRPCD = "";

            foreach (GridViewRow gridrow in GridView1.Rows)
            {
                string W_GRPCD = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();

                string[] SqlValArr;
            
                SqlValArr = W_GRPCD.Split(new char[] { ':' });

                int maxarr = SqlValArr.GetUpperBound(0);

                 for (int i = 0; i <= maxarr; i++)
                 {


                       W_GRPCD = SqlValArr[0].ToString().Trim();
                 }



                string Desc = ((Label)gridrow.FindControl("lblTaskDesc")).Text.Trim();
                string TaskType = ((Label)gridrow.FindControl("lblTaskType")).Text.Trim();
                string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text.Trim();




                if (old_W_GRPCD != W_GRPCD)
                {
                    string sql = "usp_job_OrderDetInsertUpdate";
                    SqlCommand cmd2 = new SqlCommand(sql, conn, trans);

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;
                
                    cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = PM_SCHCODE;

                 
                    cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                   
                    cmd2.Parameters.Add("@EstHrs", SqlDbType.Float).Value = Convert.ToDouble(0);
                    cmd2.Parameters.Add("@EstCost", SqlDbType.Float).Value = Convert.ToDouble(0);

                    cmd2.ExecuteNonQuery();


                    old_W_GRPCD = W_GRPCD;

                }

                string tasktype_code = "";
                string str = "  select  codeid  from WEbX_MASTER_general   where  codetype='FTASK'  and codedesc='" + TaskType.Trim() + "'";
                SqlCommand cmd1 = new SqlCommand(str, conn, trans);
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                        tasktype_code = Convert.ToString(dr[0]);
                    }

                }

                dr.Close();






                string msql1TDet = "usp_job_OrderTaskDetInsertUpdate";
                SqlCommand cmd3 = new SqlCommand(msql1TDet, conn, trans);

                cmd3.CommandType = CommandType.StoredProcedure;
                cmd3.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                cmd3.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = PM_SCHCODE;
             
                cmd3.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                cmd3.Parameters.Add("@TaskDesc", SqlDbType.VarChar).Value = Desc.Trim();
                cmd3.Parameters.Add("@TaskTypecd", SqlDbType.VarChar).Value = tasktype_code.Trim();

                cmd3.Parameters.Add("@Remark", SqlDbType.VarChar).Value = Remarks.Trim();
                cmd3.ExecuteNonQuery();


            }


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
        {
            string Flag = "P";
           
            Response.Redirect("JobOrderResult.aspx?OrderNo=" + OrderNo + "&Flag=" + Flag);
        }





    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        AddOrder();
    }
}
