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
public partial class GUI_Fleet_Job_PreparePM_JobOrder : System.Web.UI.Page
{
    DataView dvwProducts;
    private GridViewHelper helper;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.AddJobRow datarow_Wgrp;
    string Type_Code = "";

    string cols = "";



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
        string strrightnow = righnow.ToString("dd/MM/yyyy");


        lblDate.Text = strrightnow;
        lblOrderStatus.Text = "Open";


        if (!IsPostBack)
        {
           

            Session["Type_Code"] = null;

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (GridViewRow gridrow in DataGrid1.Rows)
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
                _dataSet.AddJob.RemoveAddJobRow(_dataSet.AddJob[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            _dataSet.AddJob.AddAddJobRow("", "", "", "");
        }



        BindGrid();


        //    AddOrder();


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

        DataGrid1.DataSource = _dataSet.AddJob;
        DataGrid1.DataBind();
        if (DataGrid1.Rows.Count != 0)
        {

            cmdSubmit.Visible = true;

        }

        else
        {
            cmdSubmit.Visible = false;

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

            string sql1 = "usp_Job_OrderHdrInsertUpdate";
            SqlCommand cmd = new SqlCommand(sql1, conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();



            cmd.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";



            cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehicleNo.Text.Trim();
            cmd.Parameters.Add("@OrderType", SqlDbType.VarChar).Value = ddlOrderType.SelectedItem.Text.Trim();
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

            cmd.Parameters.Add("@Km_Read", SqlDbType.Decimal).Value = Convert.ToDecimal(txtKMReading.Text.Trim());
            cmd.Parameters.Add("@EstHrs", SqlDbType.Decimal).Value = Convert.ToDecimal(txtEstHrs.Text.Trim());
            cmd.Parameters.Add("@EstCost", SqlDbType.Decimal).Value = Convert.ToDecimal(txtEstCost.Text.Trim());

            cmd.ExecuteNonQuery();
            string old_W_GRPCD = "";

            foreach (GridViewRow gridrow in DataGrid1.Rows)
            {
                string W_GRPCD = ((DropDownList)gridrow.FindControl("ddlWorkGroup")).SelectedItem.Value.Trim();
                string Desc = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Text.Trim();

                string TASKCD = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Value.Trim();



                string TaskType = ((Label)gridrow.FindControl("lblTaskType")).Text.Trim();
                string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text.Trim();




                if (old_W_GRPCD != W_GRPCD)
                {
                    string sql = "usp_job_OrderDetInsertUpdate";
                    SqlCommand cmd2 = new SqlCommand(sql, conn, trans);

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;

                    cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";


                    cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                 
                    cmd2.Parameters.Add("@EstHrs", SqlDbType.Float).Value = Convert.ToDouble(txtEstHrs.Text.Trim());
                    cmd2.Parameters.Add("@EstCost", SqlDbType.Float).Value = Convert.ToDouble(txtEstCost.Text.Trim());

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






                string msql1 = "usp_job_OrderTaskDetInsertUpdate";
                SqlCommand cmd3 = new SqlCommand(msql1, conn, trans);

                cmd3.CommandType = CommandType.StoredProcedure;
                cmd3.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;



                cmd3.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";

                cmd3.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();

                cmd3.Parameters.Add("@Taskcd", SqlDbType.VarChar).Value = TASKCD.Trim();

                cmd3.Parameters.Add("@TaskDesc", SqlDbType.VarChar).Value = Desc.Trim();
                cmd3.Parameters.Add("@TaskTypecd", SqlDbType.VarChar).Value = tasktype_code.Trim();

                cmd3.Parameters.Add("@Remark", SqlDbType.VarChar).Value = Remarks.Trim();
                cmd3.ExecuteNonQuery();








            }

            trans.Commit();
            //   trans.Rollback();
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


    protected void txtVehNo_TextChanged(object sender, EventArgs e)
    {


        if (txtVehicleNo.Text.ToString().Trim() != "")
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string STR = "select * from webx_VEHICLE_HDR where  VEHNO='" + txtVehicleNo.Text.ToString().Trim() + "'";
            string DataFound = "N";
            SqlCommand cmd = new SqlCommand(STR, conn);
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
            if (DataFound == "N")
            {

                lblCheck.Visible = true;
                lblCheck.Text = "Invalid Vehicle Number!";
            }

            else
            {
                lblCheck.Text = "";
            }
        }



        if (lblCheck.Text == "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string str = "select T.* from WEBX_VEHICLE_TYPE T,WEBX_VEHICLE_HDR H where T.Type_code=H.Vehicle_Type and H.VehNO='" + txtVehicleNo.Text.Trim() + "'";
            SqlCommand cmd = new SqlCommand(str, conn);

            lblMfg.Text = "";
            lblModel.Text = "";
            lblCategory.Text = "";

            Type_Code = "";

            SqlDataReader dr1 = cmd.ExecuteReader();

            if (dr1.HasRows)
            {
                while (dr1.Read())
                {
                    lblMfg.Text = Convert.ToString(dr1["Made_by"]);
                    lblModel.Text = Convert.ToString(dr1["Model_No"]);
                    lblCategory.Text = Convert.ToString(dr1["Type_Name"]);

                    Session["Type_Code"] = Convert.ToString(dr1["Type_Code"]);

                }
            }
            dr1.Close();

            conn.Close();

        }


    }

    public void addVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
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
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
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
        lblVendor.Visible = false;
        ddlVendor.Visible = false;
        lblWLoc.Visible = false;
        ddlWLoc.Visible = false;

        if (ddlSCtype.SelectedItem.Text.Trim() == "Vendor")
        {
            lblVendor.Visible = true;
            ddlVendor.Visible = true;

            lblWLoc.Visible = false;
            ddlWLoc.Visible = false;
            addVendor();
        }

        if (ddlSCtype.SelectedItem.Text.Trim() == "Workshop")
        {
            lblVendor.Visible = false;
            ddlVendor.Visible = false;

            lblWLoc.Visible = true;
            ddlWLoc.Visible = true;
            addLocation();

        }
    }




    protected void DataGrid1_ItemDataBound(object sender, GridViewRowEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select  distinct W_GRPCD, W_GRPDESC from WEBX_FLEET_WORKGROUP where  VEH_CAT='" + Session["Type_Code"].ToString().Trim() + "'  order by W_GRPCD ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_FLEET_WORKGROUP");

        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            DropDownList ddlWorkGroup = ((DropDownList)e.Row.FindControl("ddlWorkGroup"));
            ddlWorkGroup.DataTextField = "W_GRPDESC";
            ddlWorkGroup.DataValueField = "W_GRPCD";

            ddlWorkGroup.DataSource = ds1.Tables["WEBX_FLEET_WORKGROUP"];

            ddlWorkGroup.DataBind();
            ddlWorkGroup.Items.Insert(0, "");

          

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


    protected void cmdSubmit_Click1(object sender, EventArgs e)
    {
        AddOrder();
    }
    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        // DropDownList ddlWorkGroup = (DropDownList)(Object)(sender);

        //  DropDownList ddlWorkGroup =

        foreach (GridViewRow gridrow in DataGrid1.Rows)
        {


            DropDownList ddlWorkGroup = ((DropDownList)gridrow.FindControl("ddlWorkGroup"));

            DropDownList ddlTask = ((DropDownList)gridrow.FindControl("ddlTask"));

            if (ddlTask.Text == "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                string STR = "select t.Taskdesc,t.taskcd , T.*  from Webx_fleet_task T ,WEBX_FLEET_PM_JOBORDER_TASKDET  P  where  t.TASKCD*=p.TASKCD and task_copmletion_dt  is  null  and T.W_GRPCD='" + ddlWorkGroup.SelectedItem.Value.Trim() + "'";
                conn.Open();
                SqlCommand cmd = new SqlCommand(STR, conn);
                SqlDataReader dr = cmd.ExecuteReader();

                ddlTask.Items.Clear();
                ddlTask.Items.Insert(0, "");
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                        ddlTask.Items.Add(new ListItem(Convert.ToString(dr["Taskdesc"]), Convert.ToString(dr["taskcd"])));
                    }

                }

                dr.Close();
                conn.Close();


            }
        }



    }

    protected void DataGrid1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       


    }
    protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in DataGrid1.Rows)
        {


            DropDownList ddlWorkGroup = ((DropDownList)gridrow.FindControl("ddlWorkGroup"));

            DropDownList ddlTask = ((DropDownList)gridrow.FindControl("ddlTask"));

            if (ddlTask.Text != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                string STR = "select Codedesc,Codeid   from Webx_fleet_task T ,webx_Master_General  P  where  t.tasktype_Code=p.codeid and        Codetype='FTASK'  and    T.W_GRPCD='" + ddlWorkGroup.SelectedItem.Value.Trim() + "'";
                conn.Open();
                SqlCommand cmd = new SqlCommand(STR, conn);
                SqlDataReader dr = cmd.ExecuteReader();


                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                       
                        ((Label)gridrow.FindControl("lblTaskType")).Text = dr["Codedesc"].ToString().Trim();

                    }

                }

                dr.Close();
                conn.Close();


            }
        }

    }



}
