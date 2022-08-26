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



public partial class GUI_Fleet_Job_CloseJobOrder : System.Web.UI.Page
{

    DataView dvwProducts;
    private GridViewHelper helper;



    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.JobSpPartIssueRow datarow_SpIssue;
    MyFleetDataSet.JobSparePartRow datarow_Spare;

    MyFleetDataSet.AckJobOrderRow datarow_AJob;

    MyFleetDataSet.AckJobOrderDataTable dt_AckJobOrder = new MyFleetDataSet.AckJobOrderDataTable();
    MyFleetDataSet.JobSparePartDataTable dt_SparePart = new MyFleetDataSet.JobSparePartDataTable();


    public string ServerDt;
    //public string g_taskcd;

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
        lblError.Text = "";

        string ONo = Request.QueryString["ONo"].ToString();

        if (!IsPostBack)
        {
            Session["g_taskcd"] = null;
            AddOrderNo(ONo);
            Inetialized();
            BindSummary(ONo);

            txttotActLabCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtEstimatedSparePart.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtActPartCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtTotEstimatedCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtJobCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            //txtDCActRetrunDt.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
        }
       


          System.DateTime righnow = System.DateTime.Today;
          ServerDt = righnow.ToString("dd/MM/yyyy");
         

    }


    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {

        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;


        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");

        // row.Cells[0].Text = "VSlipNo:" + selvaluesArr[0].ToString().Trim() + "&nbsp;&nbsp;VehicleNo:" + selvaluesArr[1].ToString().Trim() + "&nbsp;&nbsp;VehicleType:" + selvaluesArr[2].ToString().Trim() + "&nbsp;&nbsp;VehicleNo:" + selvaluesArr[2].ToString().Trim();
        row.Cells[0].Text = "Work Group Code & Description:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
        //   row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;


    }

    public void BindSummary(string strOrderNo)
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo =  strOrderNo;
        objJs.BindGridSummary(gvSummary);
    }

    public void Inetialized()
    {
        DataTable dtHdr = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        string strOrderType = "";
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        dtHdr = objJs.GetDataJobHdrCloure();
        if (dtHdr.Rows.Count > 0)
        {
            foreach (DataRow dr in dtHdr.Rows) 
            {
                lblVehicleNo.Text = Convert.ToString(dr["VEHNO"]);
                string VehArrStatus = Convert.ToString(dr["VEH_ARRV_STATUS"]);
                lblDate.Text = Convert.ToString(dr["OrderDt1"]);
                lblOrderType.Text = Convert.ToString(dr["JobCardTypeDesc"]);
                lblOrderStatus.Text = Convert.ToString(dr["ORDER_STATUS"]);
                strOrderType = Convert.ToString(dr["ORDER_TYPE"]);
                lblCategory.Text = Convert.ToString(dr["Category"]);
                lblMfg.Text = Convert.ToString(dr["Madeby"]);
                lblModel.Text = Convert.ToString(dr["Model"]);
                lblSCType.Text = Convert.ToString(dr["SERVICE_CENTER_TYPE"]);
                lblVendor.Text = Convert.ToString(dr["Vendor"]);
                lblwLoc.Text = Convert.ToString(dr["Location"]);
                lblKMReading.Text = Convert.ToString(dr["KM_Reading"]);
                lbltotEstLHrs.Text = Convert.ToString(dr["TOT_EST_LABOUR_HRS"]);
                lbltotEstLCost.Text = Convert.ToString(dr["TOT_EST_LABOUR_COST"]);
                txtActPartCost.Text = Convert.ToString(dr["TOT_ACT_PART_COST"]);
                txtJobCost.Text = Convert.ToString(dr["TOT_ACT_PART_COST"]);
                LblSendDt.Text = Convert.ToString(dr["SENDDT_WORKSHOP"]);
                LblReturnDt.Text = Convert.ToString(dr["RETURNDT_WORKSHOP"]);
                txtTotEstimatedCost.Text = Convert.ToString(dr["TOT_ESTIMATED_COST"]);
                lblWLocHead.Visible = false;
                lblwLoc.Visible = false;
                lblVendorHead.Visible = false;
                lblVendor.Visible = false;
                if (lblSCType.Text.Trim() == "Workshop")
                {
                    lblWLocHead.Visible = true;
                    lblwLoc.Visible = true;
                    lblwLoc.Text = Convert.ToString(dr["Location"]);
                    lblVendorHead.Visible = false;
                    lblVendor.Visible = false;
                }
                if (lblSCType.Text.Trim() == "Vendor")
                {
                    lblVendorHead.Visible = true;
                    lblVendor.Visible = true;
                    lblVendor.Text = Convert.ToString(dr["Vendor"]);
                    lblWLocHead.Visible = false;
                    lblwLoc.Visible = false;
                }
            }
        }
        BindGrid();
        BindGridSpare();
        if (strOrderType == "06")
        {
            rowSM_Hdr.Visible = true;
            rowNOSM_Hdr.Visible = false;
            rowSM_Submit.Visible = true;
        }
        else
        {
            //rowSM_Hdr.Visible = false;
            //rowNOSM_Hdr.Visible = false;
            rowSM_Submit.Visible = false;
        }
    }
    
    public void BindGrid()
    {
        DataTable dt = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        dt = objJs.GetDataJobTaskCloure();

        _dataSet.AckJobOrder.Clear();

        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr1 in dt.Rows) 
            {
                string W_GRPCD = Convert.ToString(dr1["WorkGroup"]);
                string taskcd = Convert.ToString(dr1["TASKCD"]);
                if (Session["g_taskcd"] == "" || Session["g_taskcd"] == null)
                {
                    Session["g_taskcd"] = taskcd;
                }
                else
                {
                    Session["g_taskcd"] = Session["g_taskcd"].ToString() + "," + taskcd;
                }
                string TaskType = Convert.ToString(dr1["TaskType"]);
                string TaskDesc = Convert.ToString(dr1["taskdesc"]);
                string Remark = Convert.ToString(dr1["T_REMARKS"]);
                string EstHrs = "0";
                string EstCost = "0";
                string W_EST_LABOUR_HRS = Convert.ToString(dr1["W_EST_LABOUR_HRS"]);
                string W_EST_LABOUR_COST = Convert.ToString(dr1["W_EST_LABOUR_COST"]);
                _dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, Remark, "", "", W_EST_LABOUR_HRS,W_EST_LABOUR_COST);
            }
        }
        GridView1.DataSource = _dataSet.AckJobOrder;
        GridView1.DataBind();
        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            string w_GRPCD = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();
            ((TextBox)gridrow.FindControl("txtActualLabourCost")).Visible = true;
        }
    }

    public void BindGridSpare()
    {
        DataTable dt = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        dt = objJs.GetDataJobPartList();

        _dataSet.AckJobOrder.Clear();
        double tot_Qty = 0;
        double tot_COST = 0;

        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr1 in dt.Rows) 
            {
                string WorkGroup = Convert.ToString(dr1["W_GRPDESC"]);
                string PART_CODE = Convert.ToString(dr1["PART_CODE"]);
                string PART_DESC = Convert.ToString(dr1["PART_DESC"]);
                string PART_QTY = Convert.ToString(dr1["PART_QTY"]);
                string COST_UNIT = Convert.ToString(dr1["COST_UNIT"]);
                string COST = Convert.ToString(dr1["COST"]);
                string S_Remarks = Convert.ToString(dr1["S_Remarks"]);

                tot_COST = tot_COST + Convert.ToDouble(COST);
                tot_Qty = tot_Qty + Convert.ToDouble(PART_QTY);

                dt_SparePart.AddJobSparePartRow(WorkGroup,PART_CODE, PART_DESC, PART_QTY, COST_UNIT, COST, S_Remarks);
            }
        }
        dgSpare.DataSource = dt_SparePart;
        dgSpare.DataBind();
        txtActPartCost.Text = tot_COST.ToString();
        txtEstimatedSparePart.Text = Convert.ToString(tot_COST);
        lblPartQty.Text = Convert.ToString(tot_Qty);
    }

    public void AddOrderNo(string Ono)
    {
        DataTable dt = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = Ono;
        dt = objJs.GetDataAddJobOrder();
        if (dt.Rows.Count > 0)
        {
            foreach(DataRow dr in dt.Rows) 
            {
                ddlWONo.Items.Add(new ListItem(Convert.ToString(dr["JOB_ORDER_NO"]), Convert.ToString(dr["JOB_ORDER_NO"])));
            }
        }
    }
    protected void ddlWONo_SelectedIndexChanged(object sender, EventArgs e)
    {
        Inetialized();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string Flag = ""; //job order Closed/Updated
        DateTime mServerDt = DateTime.Now;
        Double Cost = 0, Hrs = 0, KmRead = 0;
        string OrderNo = ddlWONo.SelectedItem.Text.Trim();
        Double totspcost = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        DateTime mActReturnDt = new DateTime();
        //DateTime   ODate = new  DateTime();
        //DateTime CLDate = new DateTime();

        int count = 0;

        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            bool Chk_Sel = ((CheckBox)gridrow.FindControl("chk_Flag")).Checked;
            if (Chk_Sel == true)
            {
                count = count + 1;
            }
        }
        if (txtDCActRetrunDt.Text.ToString() == "")
        {
            lblError.Text = "Please enter Actual date of return";
            lblError.Visible = true;
        }
        if (lblError.Text == "")
        {
            mActReturnDt = Convert.ToDateTime(txtDCActRetrunDt.Text.ToString(), dtfi);// Convert.ToDateTime(txtReturnDt_WS.Text, dtfi);
        }
        if (lblError.Text == "")
        {
            DateTime mSendDt = new DateTime();
            mSendDt = Convert.ToDateTime(LblSendDt.Text, dtfi);
            if (mActReturnDt < mSendDt)
            {
                lblError.Visible = true;
                lblError.Text = "Actual return date cannot be less than Send date to Workshop  !";
            }
            if (mActReturnDt > mServerDt)
            {
                lblError.Visible = true;
                lblError.Text = "Actual return date cannot be greater than today's Date !";
            }
        }
      
        if (lblError.Text == ""  && count<1)
        {
            lblError.Visible = true;
            lblError.Text = "Atleast One Task Should be Closed!";
        }
        else
        {
            lblError.Visible = false;
            lblError.Text = "";
        }
        if (lblError.Text == "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                if (txttotActLabCost.Text.Trim() != "")
                {
                    Cost = Convert.ToDouble(txttotActLabCost.Text.Trim());
                }
                Hrs = Convert.ToDouble("0.0");
                foreach (DataGridItem gridrow in dgSpare.Items)
                {
                    string Qty = ((TextBox)gridrow.FindControl("txtQty")).Text.Trim();
                    string CostUnit = ((Label)gridrow.FindControl("lblCostUnit")).Text.Trim();
                    Double mCost = 0;
                    mCost = Convert.ToDouble(Qty) * Convert.ToDouble(CostUnit);
                    if (CostUnit != "")
                    {
                        totspcost = totspcost + Convert.ToDouble(mCost);
                    }
                }

                string str1 = "usp_Job_JobHdrClose";

                SqlCommand cmd2 = new SqlCommand(str1, conn, trans);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();
                cmd2.Parameters.Add("@TotALHrs", SqlDbType.Float).Value = Hrs;
                cmd2.Parameters.Add("@TotALCost", SqlDbType.Float).Value = Cost;
                cmd2.Parameters.Add("@PartTotCost", SqlDbType.Float).Value = totspcost;
                cmd2.Parameters.Add("@CLOSE_KM_READING", SqlDbType.Float).Value = txtCloseKM.Text.Trim();
                cmd2.Parameters.Add("@TOT_ACTUAL_COST", SqlDbType.Float).Value = ((txtJobCost.Text == "") ? 0 : Convert.ToDecimal(txtJobCost.Text));
                
                cmd2.ExecuteNonQuery();

                string old_W_FRPCD = "";
                Double tHrs = 0, tCost = 0;
                int RemTaskCntr = 0;
                foreach (GridViewRow gridrow2 in GridView1.Rows)
                {
                    string w_GRPCD = ((Label)gridrow2.FindControl("lblW_GRPCD")).Text.Trim();
                    string Action = ((TextBox)gridrow2.FindControl("txtAction")).Text.Trim();
                    bool Chk_Sel = ((CheckBox)gridrow2.FindControl("chk_Flag")).Checked;
                    TextBox txtActualLabourCost = (TextBox)gridrow2.FindControl("txtActualLabourCost");
                    TextBox txtAction = (TextBox)gridrow2.FindControl("txtAction");
                    DropDownList ddlAMC = (DropDownList)gridrow2.FindControl("ddlAMC");

                    if (Chk_Sel == true)
                    {
                        string taskcd = ((Label)gridrow2.FindControl("lblTaskCode")).Text.Trim();
                        DateTime Date = new DateTime();
                        if (w_GRPCD != "")
                        {
                            if (txtActualLabourCost.Visible == true)
                            {
                                Double  mCost = 0;
                                if (txtActualLabourCost.Text == "")
                                {
                                    mCost = 0;
                                }
                                else
                                {
                                    mCost = Convert.ToDouble(txtActualLabourCost.Text.Trim());
                                }
                                string mmstr = "update WEBX_FLEET_PM_JOBORDER_DET  set W_ACT_LABOUR_COST='" + mCost + "',TASK_ACTIONDESC='" + txtAction.Text.Trim()  + "' where  Taskcd='" + taskcd.Trim() + "'";
                                SqlCommand mcmd = new SqlCommand(mmstr, conn, trans);
                                mcmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            //INSERT NEW TASKS

                            string W_GRPCD = ((DropDownList)gridrow2.FindControl("ddlWorkGroup")).SelectedItem.Value.Trim();
                            string TASKCD = ((DropDownList)gridrow2.FindControl("ddlTask")).SelectedItem.Value.Trim();
                            string Remarks = "";

                            //string EstHrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();
                            //string EstCost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();

                            string sql = "usp_job_OrderDetInsertUpdate";
                            SqlCommand cmd3 = new SqlCommand(sql, conn, trans);

                            cmd3.CommandType = CommandType.StoredProcedure;
                            cmd3.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;
                            cmd3.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";
                            cmd3.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                            cmd3.Parameters.Add("@EstHrs", SqlDbType.Float).Value = "0.00";
                            cmd3.Parameters.Add("@EstCost", SqlDbType.Float).Value = "0.00";
                            cmd3.Parameters.Add("@Taskcd", SqlDbType.Int).Value = ((TASKCD == "") ? 0 : Convert.ToInt32(TASKCD));
                            cmd3.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = Remarks;
                            //cmd3.Parameters.Add("@JS_KM", SqlDbType.Float).Value = Convert.ToDecimal(lblKMReading.Text);

                            cmd3.ExecuteNonQuery();

                            Double mCost = 0;
                            //mCost = Convert.ToDouble(((TextBox)gridrow2.FindControl("txtActualLabourCost")).Text.Trim());
                            if (txtActualLabourCost.Text == "")
                            {
                                mCost = 0;
                            }
                            else
                            {
                                mCost = Convert.ToDouble(txtActualLabourCost.Text.Trim());
                            }
                            string mmstr = "update WEBX_FLEET_PM_JOBORDER_DET  set W_ACT_LABOUR_COST='" + mCost + "',TASK_ACTIONDESC='" + txtAction.Text.Trim() + "' where  Convert(VarChar,Taskcd)='" + taskcd.Trim() + "'";
                            SqlCommand mcmd = new SqlCommand(mmstr, conn, trans);
                            mcmd.ExecuteNonQuery();
                        }   
                    }
                    else
                    {
                        RemTaskCntr = RemTaskCntr + 1;
                    }
                }
                //string strupd = "update   WEBX_FLEET_PM_JOBORDER_HDR set Order_status='Completed' ,JOB_Order_Closedt=getdate(),ACTRETURNDT_WORKSHOP='" + mActReturnDt + "'  where JOB_ORDER_NO = '" + ddlWONo.SelectedItem.Text.Trim() + "'";
                //SqlCommand cmdUP = new SqlCommand(strupd, conn, trans);
                //cmdUP.ExecuteNonQuery();
                string strupd = "Usp_CloseJobSheetUpdateStatus";
                SqlCommand cmdUP = new SqlCommand(strupd, conn, trans);
                cmdUP.CommandType = CommandType.StoredProcedure;
                cmdUP.Parameters.Add("@JOB_ORDER_NO", SqlDbType.VarChar, 50).Value = ddlWONo.SelectedItem.Text.Trim();
                cmdUP.Parameters.Add("@JOB_Order_Closedt", SqlDbType.VarChar, 50).Value = mActReturnDt.ToString().Trim();
                cmdUP.Parameters.Add("@JS_BRCD", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                cmdUP.Parameters.Add("@JS_Approve_By_Close", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                cmdUP.ExecuteNonQuery();

                //JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
                //objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
                ////objJs.JobOrderToDt = mActReturnDt.ToString().Trim();
                //objJs.JobOrderToDt = txtDCActRetrunDt.Text.ToString().Trim();
                //objJs.JS_BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
                //objJs.CloseJobSheetUpdateStatus();
                Flag = "C";

                foreach (DataGridItem gridrow2 in dgSpare.Items)
                {
                    string Part_code = ((DropDownList)gridrow2.FindControl("ddlPartNo")).SelectedItem.Value.Trim();
                    string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
                    string CostUnit = ((Label)gridrow2.FindControl("lblCostUnit")).Text.Trim();
                    string mCost1 = ((TextBox)gridrow2.FindControl("txtCost")).Text.Trim();
                    string S_Remark = ((TextBox)gridrow2.FindControl("txtSpareRemark")).Text.Trim();
                    Double mCost = 0;
                    mCost=Convert.ToDouble(Qty) * Convert.ToDouble(CostUnit); 
                    if (CostUnit != "")
                    {
                        mCost = Convert.ToDouble(mCost);
                    }

                    mCost1 = mCost.ToString();
                    string spsql = "usp_Job_ActSparePart";
                    SqlCommand spcmd = new SqlCommand(spsql, conn, trans);
                    spcmd.CommandType = CommandType.StoredProcedure;

                    spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = Part_code;
                    spcmd.Parameters.Add("@Qty", SqlDbType.Float).Value = Convert.ToDouble(Qty);
                    spcmd.Parameters.Add("@Cost_Unit", SqlDbType.Float).Value = Convert.ToDouble(mCost);
                    spcmd.Parameters.Add("@Cost", SqlDbType.Float).Value = Convert.ToDouble(mCost1);
                    spcmd.Parameters.Add("@S_Remark", SqlDbType.VarChar).Value = S_Remark;

                    spcmd.ExecuteNonQuery();
                }
                trans.Commit();
                //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                lbl_Page_Error.Text = e1.Message.ToString();
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("CloseJobOrderResult.aspx?OrderNo=" + OrderNo + "&Flag=" + Flag);
            }
        }
    }
    protected void txtTaskRow_TextChanged(object sender, EventArgs e)
    {

        dt_AckJobOrder.Clear();
        if ((txtTaskRow.Text == "") || (txtTaskRow.Text == "0")) txtTaskRow.Text = "1";

        int TotRec = 0;
        string w_GRPD = "";
        string Task_Code = "";
        string Task_Desc = "";
        string TASKTYP = "";
        string Task_Remark = "";
        string Est_LabourHrs = "";
        string Est_LabourCost = "";


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str1 = "usp_Job_JobOrderDetListView";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();

        SqlDataReader mdr1 = cmd1.ExecuteReader();
        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                TotRec = TotRec + 1;

                if (w_GRPD == "")
                {
                    w_GRPD = Convert.ToString(mdr1["WorkGroup"]);
                }
                else
                {
                    w_GRPD = w_GRPD + "," + Convert.ToString(mdr1["WorkGroup"]);
                }

                
                 if (Task_Code == "")
                {
                    Task_Code = Convert.ToString(mdr1["Taskcd"]);
                }
                else
                {
                    Task_Code = Task_Code + "," + Convert.ToString(mdr1["Taskcd"]);
                }



                if (Task_Desc == "")
                {
                    Task_Desc = Convert.ToString(mdr1["taskdesc"]);
                }
                else
                {
                    Task_Desc = Task_Desc + "," + Convert.ToString(mdr1["taskdesc"]);
                }

                if (TASKTYP == "")
                {
                    TASKTYP = Convert.ToString(mdr1["TaskType"]);
                }
                else
                {
                    TASKTYP = TASKTYP + "," + Convert.ToString(mdr1["TaskType"]);
                }


                if (Task_Remark == "")
                {
                    Task_Remark = Convert.ToString(mdr1["T_Remarks"]);
                }
                else
                {
                    Task_Remark = Task_Remark + "," + Convert.ToString(mdr1["T_Remarks"]);
                }

                if (Est_LabourHrs == "")
                {
                    Est_LabourHrs = Convert.ToString(mdr1["W_EST_LABOUR_HRS"]);
                }
                else
                {
                    Est_LabourHrs = Est_LabourHrs + "," + Convert.ToString(mdr1["W_EST_LABOUR_HRS"]);
                }


                if (Est_LabourCost == "")
                {
                    Est_LabourCost = Convert.ToString(mdr1["W_EST_LABOUR_COST"]);
                }
                else
                {
                    Est_LabourCost = Est_LabourCost + "," + Convert.ToString(mdr1["W_EST_LABOUR_COST"]);
                }



            }
        }

    

        string[] Arr_w_GRPD;
        string[] Arr_Task_Code;
        string[] Arr_Task_Desc;
        string[] Arr_TASKTYP;
        string[] Arr_Task_Remark;
        string[] Arr_Est_LabourHrs;
        string[] Arr_Est_LabourCost;

        Arr_w_GRPD = w_GRPD.Split(new Char[] { ',' });
        Arr_Task_Code=Task_Code.Split(new Char[] { ',' });
        Arr_Task_Desc = Task_Desc.Split(new Char[] { ',' });
        Arr_TASKTYP = TASKTYP.Split(new Char[] { ',' });
        Arr_Task_Remark = Task_Remark.Split(new Char[] { ',' });
        Arr_Est_LabourHrs = Est_LabourHrs.Split(new Char[] { ',' });
        Arr_Est_LabourCost = Est_LabourCost.Split(new Char[] { ',' });


        for (int i = 0; i < Convert.ToInt32(txtTaskRow.Text) + TotRec; i++)
        {
            if (TotRec > i)
            {
                dt_AckJobOrder.AddAckJobOrderRow(Arr_w_GRPD[i], Arr_Task_Code[i], Arr_Task_Desc[i], Arr_TASKTYP[i], Arr_Task_Remark[i], "", "", Arr_Est_LabourHrs[i], Arr_Est_LabourCost[i]);
            }
            else
            {
                dt_AckJobOrder.AddAckJobOrderRow("", "", "", "", "", "", "", "", "");
            }
        }
        txtTaskRow.Text = "0";

        BindTaskGrid();
    }
    public void BindTaskGrid()
    {
        GridView1.DataSource = dt_AckJobOrder;
        GridView1.DataBind();
    }

    protected void txtRow_TextChanged(object sender, EventArgs e)
    {

        dt_SparePart.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";

        
        int TotRec = 0;
        string PartNo = "";
        string PartDesc = "";
        string PartQty = "";
        string Part_Rate = "";
        string Part_Cost = "";
        string Part_Remark = "";
        string W_GRPDESC = "";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str1 = "usp_Job_JobOrderDetPartView";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();

        SqlDataReader mdr1 = cmd1.ExecuteReader();
        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                TotRec = TotRec + 1;

                if (W_GRPDESC == "")
                {
                    W_GRPDESC = Convert.ToString(mdr1["W_GRPDESC"]);
                }
                else
                {
                    W_GRPDESC = W_GRPDESC + "," + Convert.ToString(mdr1["W_GRPDESC"]);
                }

                if (PartNo == "")
                {
                    PartNo = Convert.ToString(mdr1["PART_CODE"]);
                }
                else
                {
                    PartNo = PartNo + "," + Convert.ToString(mdr1["PART_CODE"]);
                }


                if (PartDesc == "")
                {
                    PartDesc = Convert.ToString(mdr1["PART_DESC"]);
                }
                else
                {
                    PartDesc = PartDesc + "," + Convert.ToString(mdr1["PART_DESC"]);
                }

                if (PartQty == "")
                {
                    PartQty = Convert.ToString(mdr1["PART_QTY"]);
                }
                else
                {
                    PartQty = PartQty + "," + Convert.ToString(mdr1["PART_QTY"]);
                }

                if (Part_Rate == "")
                {
                    Part_Rate = Convert.ToString(mdr1["COST_UNIT"]);
                }
                else
                {
                    Part_Rate = Part_Rate + "," + Convert.ToString(mdr1["COST_UNIT"]);
                }

                if (Part_Cost == "")
                {
                    Part_Cost = Convert.ToString(mdr1["COST"]);
                }
                else
                {
                    Part_Cost = Part_Cost + "," + Convert.ToString(mdr1["COST"]);
                }

                if (Part_Remark == "")
                {
                    Part_Remark = Convert.ToString(mdr1["S_Remarks"]);
                }
                else
                {
                    Part_Remark = Part_Remark + "," + Convert.ToString(mdr1["S_Remarks"]);
                }

            }
        }

        string[] Arr_WDesc;
        string[] Arr_PartNo;
        string[] Arr_PartDesc;
        string[] Arr_PartQty ;
        string[] Arr_Part_Rate;
        string[] Arr_Part_Cost;
        string[] Arr_Part_Remark;


        Arr_WDesc = W_GRPDESC.Split(new Char[] { ',' });
        Arr_PartNo = PartNo.Split(new Char[] { ',' });
        Arr_PartDesc = PartDesc.Split(new Char[] { ',' });
        Arr_PartQty = PartQty.Split(new Char[] { ',' });
        Arr_Part_Rate = Part_Rate.Split(new Char[] { ',' });
        Arr_Part_Cost = Part_Cost.Split(new Char[] { ',' });
        Arr_Part_Remark = Part_Remark.Split(new Char[] { ',' });


        for (int i = 0; i < Convert.ToInt32(txtRow.Text) + TotRec; i++)
        {
            if (TotRec > i)
            {
                dt_SparePart.AddJobSparePartRow(Arr_WDesc[i], Arr_PartNo[i], Arr_PartDesc[i], Arr_PartQty[i], Arr_Part_Rate[i], Arr_Part_Cost[i], Arr_Part_Remark[i]);
                //dt_AckJobOrder.AddAckJobOrderRow(Arr_w_GRPD[i], Arr_Task_Code[i], Arr_Task_Desc[i], Arr_TASKTYP[i], Arr_Task_Remark[i], "", "", Arr_Est_LabourHrs[i], Arr_Est_LabourCost[i]);
            }
            else
            {
                dt_SparePart.AddJobSparePartRow("", "", "", "", "", "", "");
            }
        }

        BindSpareGrid();


        //string rowno;
        //int mroww = 0;
        //int miroww = 0;

        //rowno = txtRow.Text;
        //mroww = Convert.ToInt16(rowno);
        //int i;

        //int iroww = 0;
        //foreach (DataGridItem gridrow in dgSpare.Items)
        //{
        //    iroww = iroww + 1;
        //}
        //miroww = iroww;

        //if (mroww < miroww)
        //{
        //    miroww = mroww;
        //}

        //if (iroww >= 0)
        //{
        //    for (i = iroww - 1; i > -1 + miroww; i--)
        //    {
        //        _dataSet.JobSparePart.RemoveJobSparePartRow(_dataSet.JobSparePart[i]);
        //    }
        //}

        //for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        //{
        //    _dataSet.JobSparePart.AddJobSparePartRow("", "", "", "", "","");
        //}

        //BindSpareGrid();

    }


    



    public void BindSpareGrid()
    {
        dgSpare.DataSource = dt_SparePart;
        dgSpare.DataBind();
    }

    protected void txtEstHrs_TextChanged(object sender, EventArgs e)
    {
        Double mHrs = 0;
        Double totHrs = 0;

        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            if (((TextBox)gridrow.FindControl("txtEstHrs")).Visible == true)
            {
                string Hrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();

                if (Hrs != "")
                {
                    mHrs = Convert.ToDouble(Hrs);

                }

                totHrs = totHrs + mHrs;

                //txttotActLabHrs.Text = Convert.ToString(totHrs);
                mHrs = 0;
            }

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


    //protected void txtEstCost_TextChanged(object sender, EventArgs e)
    //{
    //    Double mCost = 0;
    //    Double totCost = 0;
    //    foreach (GridViewRow gridrow in GridView1.Rows)
    //    {
    //        if (((TextBox)gridrow.FindControl("txtEstCost")).Visible == true)
    //        {
    //            string Cost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();
    //            if (Cost != "")
    //            {
    //                mCost = Convert.ToDouble(Cost);
    //            }
    //            totCost = totCost + mCost;
    //            txttotActLabCost.Text = Convert.ToString(totCost);
    //            mCost = 0;
    //        }
    //    }
    //}
    public void BindWorkGroupList(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.BindWorkGroup(d);
    }
    public void BindTaskList(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindTaskList(d, "0");
    }
     protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            //BindTaskList((DropDownList)e.Row.FindControl("ddlTask"));
            DropDownList ddlTask = (DropDownList)e.Row.FindControl("ddlTask");
            DropDownList ddlWorkGroup = (DropDownList)e.Row.FindControl("ddlWorkGroup");
            TextBox txtTaskType = (TextBox)e.Row.FindControl("txtTaskType");
            //TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");
            Label lblW_GRPCD = (Label)e.Row.FindControl("lblW_GRPCD");
            Label lblTaskDesc = (Label)e.Row.FindControl("lblTaskDesc");
            
            BindWorkGroupList(ddlWorkGroup);
            datarow_AJob = ((MyFleetDataSet.AckJobOrderRow)((DataRowView)e.Row.DataItem).Row);

            if (datarow_AJob.Taskcd != "")
            {
                lblW_GRPCD.Text = datarow_AJob.W_GRPCD;
                lblTaskDesc.Text = datarow_AJob.TaskDesc;
                ddlWorkGroup.Visible = false;
                ddlTask.Visible = false;
            }
            else
            {
                ddlWorkGroup.Visible = true;
                ddlTask.Visible = true;
            }
            ((Label)e.Row.FindControl("lblTaskCode")).Text = datarow_AJob.Taskcd;
            ((TextBox)e.Row.FindControl("txtTaskType")).Text = datarow_AJob.TaskType;
            ((Label)e.Row.FindControl("lblRemark")).Text = datarow_AJob.Remark;

            //((TextBox)e.Row.FindControl("txtEstHrs")).Text = datarow_AJob.EstHrs;
            ((TextBox)e.Row.FindControl("txtActualLabourCost")).Text = datarow_AJob.EstCost;

            ((Label)e.Row.FindControl("lblEstHrs")).Text = datarow_AJob.T_EstHrs;
            ((Label)e.Row.FindControl("lblEstCost")).Text = datarow_AJob.T_EstCost;
            DropDownList ddlAMC = (DropDownList)e.Row.FindControl("ddlAMC");
            ddlAMC.Attributes.Add("OnChange", "javascript:OnAMCChange(this," + ((TextBox)e.Row.FindControl("txtActualLabourCost")).ClientID.ToString() + ")");
            BindTaskList(ddlTask);
            ddlTask.Attributes.Add("OnChange", "javascript:OnTaskDescChange(" + e.Row.RowIndex + "," + ddlTask.ClientID.ToString().Trim() + "," + txtTaskType.ClientID.ToString().Trim() + ");");
        }
    }

    public void BindPart(DropDownList d)
    {

        //d.Items.Add(new ListItem("Select", ""));
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //string STR = "select  distinct Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y'  Order by Part_Id";
        string STR = "select  distinct Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y' UNION select '','Select' from Webx_Fleet_spareParthdr  Order by Part_Id";

        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandType = CommandType.Text;

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr["Description"]), Convert.ToString(dr["Part_Id"])));
            }
        }
        dr.Close();
        conn.Close();

    }


        protected void dgSpare_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
            {
                BindPart((DropDownList)e.Item.FindControl("ddlPartNo"));
            }
            if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
            {

                datarow_Spare = ((MyFleetDataSet.JobSparePartRow)((DataRowView)e.Item.DataItem).Row);

                ((Label)e.Item.FindControl("lblW_GRPCD")).Text = datarow_Spare.WORKGROUP.Trim(); 
                ((DropDownList)e.Item.FindControl("ddlPartNo")).SelectedItem.Value =  datarow_Spare.PartNo.Trim();
                ((DropDownList)e.Item.FindControl("ddlPartNo")).SelectedItem.Text = datarow_Spare.PartDesc.Trim();
                ((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
                ((Label)e.Item.FindControl("lblCostUnit")).Text = datarow_Spare.Cost_Unit;
                ((TextBox)e.Item.FindControl("txtCost")).Text = datarow_Spare.Cost;
                ((TextBox)e.Item.FindControl("txtSpareRemark")).Text = datarow_Spare.Reamrk;
            }
        }
        protected void txtQty_TextChanged(object sender, EventArgs e)
        {
            foreach (DataGridItem gridrow2 in dgSpare.Items)
            {

                Double mqty = 0; Double mcost = 0;
                string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
                string CostUnit = ((Label)gridrow2.FindControl("lblCostUnit")).Text.Trim();
                if (Qty != "")
                {
                    //mqty = Convert.ToInt32(Qty);
                    mqty = Convert.ToDouble(Qty.ToString());
                }

                if (CostUnit != "")
                {
                    mcost = Convert.ToDouble(CostUnit);
                }

                Double ToatlCost = mqty * mcost;

                string Cost = ((TextBox)gridrow2.FindControl("txtCost")).Text = Convert.ToString(ToatlCost);

            }
        }

    protected void ddlPartNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (DataGridItem gridrow in dgSpare.Items)
        {
            DropDownList ddlPartNo = ((DropDownList)gridrow.FindControl("ddlPartNo"));
            if (ddlPartNo.Text != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                string STR = "select Selling_Price  from WEBX_FLEET_SPAREPARTHDR where    Part_Id='" + ddlPartNo.SelectedItem.Value.Trim() + "'";
                conn.Open();
                SqlCommand cmd = new SqlCommand(STR, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        ((Label)gridrow.FindControl("lblCostUnit")).Text = dr["Selling_Price"].ToString().Trim();
                    }
                }
                dr.Close();
                conn.Close();
            }
            else
            {
                ((TextBox)gridrow.FindControl("txtQty")).Text = "";
                ((Label)gridrow.FindControl("lblCostUnit")).Text = "";
                ((TextBox)gridrow.FindControl("txtCost")).Text = "";
                ((TextBox)gridrow.FindControl("txtSpareRemark")).Text = "";
            }
        }

    }

  


    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        GridViewRow row = (GridViewRow)ddlWorkGroup.Parent.Parent;
        DropDownList ddlTask = (DropDownList)GridView1.Rows[row.RowIndex].FindControl("ddlTask");
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        ddlTask.Items.Clear();
        objJs.BindTaskList(ddlTask, ddlWorkGroup.SelectedValue);
    }

    protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            DropDownList ddlTask = ((DropDownList)gridrow.FindControl("ddlTask"));
            if (ddlTask.Text != "")
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                string STR = "select convert(varchar,taskcd) as taskcd,taskdesc,tasktyp,(select codedesc from webx_master_general where codetype='JOBTSKTYP' and codeid=tasktyp)as tasktypedesc from WEBX_FLEET_TASKMST where active_flag='Y'  and    taskcd=" + ddlTask.SelectedItem.Value.Trim() + "";
                conn.Open();
                SqlCommand cmd = new SqlCommand(STR, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //((Label)gridrow.FindControl("lblTaskType")).Text = dr["tasktypedesc"].ToString().Trim();
                        ((TextBox)gridrow.FindControl("txtTaskType")).Text = dr["tasktypedesc"].ToString().Trim();
                    }
                }

                dr.Close();
                conn.Close();


            }
        }
    }
    protected void cmdSubmitSM_Click(object sender, EventArgs e)
    {
        string Flag = ""; //job order Closed/Updated
        DateTime mServerDt = DateTime.Now;
        Double Cost = 0, Hrs = 0, KmRead = 0;
        string OrderNo = ddlWONo.SelectedItem.Text.Trim();
        Double totspcost = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        DateTime mActReturnDt = new DateTime();
        //DateTime   ODate = new  DateTime();
        //DateTime CLDate = new DateTime();


       
        if (txtDCActRetrunDt.Text.ToString() == "")
        {
            lblError.Text = "Please enter Actual date of return";
            lblError.Visible = true;
        }
        if (lblError.Text == "")
        {
            mActReturnDt = Convert.ToDateTime(txtDCActRetrunDt.Text.ToString(), dtfi);// Convert.ToDateTime(txtReturnDt_WS.Text, dtfi);
        }
        if (lblError.Text == "")
        {
            DateTime mSendDt = new DateTime();
            mSendDt = Convert.ToDateTime(LblSendDt.Text, dtfi);
            if (mActReturnDt < mSendDt)
            {
                lblError.Visible = true;
                lblError.Text = "Actual return date cannot be less than Send date to Workshop  !";
            }
            if (mActReturnDt > mServerDt)
            {
                lblError.Visible = true;
                lblError.Text = "Actual return date cannot be greater than today's Date !";
            }
        }

        if (lblError.Text == "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                if (txttotActLabCost.Text.Trim() != "")
                {
                    Cost = Convert.ToDouble(txttotActLabCost.Text.Trim());
                }
                Hrs = Convert.ToDouble("0.0");
                foreach (DataGridItem gridrow in dgSpare.Items)
                {
                    string Qty = ((TextBox)gridrow.FindControl("txtQty")).Text.Trim();
                    string CostUnit = ((Label)gridrow.FindControl("lblCostUnit")).Text.Trim();
                    Double mCost = 0;
                    mCost = Convert.ToDouble(Qty) * Convert.ToDouble(CostUnit);
                    if (CostUnit != "")
                    {
                        totspcost = totspcost + Convert.ToDouble(mCost);
                    }
                }

                string str1 = "usp_Job_JobHdrClose";

                SqlCommand cmd2 = new SqlCommand(str1, conn, trans);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();
                cmd2.Parameters.Add("@TotALHrs", SqlDbType.Float).Value = Hrs;
                cmd2.Parameters.Add("@TotALCost", SqlDbType.Float).Value = Cost;
                cmd2.Parameters.Add("@PartTotCost", SqlDbType.Float).Value = totspcost;
                cmd2.Parameters.Add("@CLOSE_KM_READING", SqlDbType.Float).Value = txtCloseKM.Text.Trim();
                cmd2.Parameters.Add("@TOT_ACTUAL_COST", SqlDbType.Float).Value = ((txtJobCost.Text == "") ? 0 : Convert.ToDecimal(txtJobCost.Text));

                cmd2.ExecuteNonQuery();

                string old_W_FRPCD = "";
                Double tHrs = 0, tCost = 0;
                int RemTaskCntr = 0;
               
                //cmdUP.ExecuteNonQuery();
                string strupd = "Usp_CloseJobSheetUpdateStatus";
                SqlCommand cmdUP = new SqlCommand(strupd, conn, trans);
                cmdUP.CommandType = CommandType.StoredProcedure;
                cmdUP.Parameters.Add("@JOB_ORDER_NO", SqlDbType.VarChar, 50).Value = ddlWONo.SelectedItem.Text.Trim();
                cmdUP.Parameters.Add("@JOB_Order_Closedt", SqlDbType.VarChar, 50).Value = mActReturnDt.ToString().Trim();
                cmdUP.Parameters.Add("@JS_BRCD", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                cmdUP.Parameters.Add("@JS_Approve_By_Close", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                cmdUP.ExecuteNonQuery();

                Flag = "C";
                trans.Commit();
                //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                lbl_Page_Error.Text = e1.Message.ToString();
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("CloseJobOrderResult.aspx?OrderNo=" + OrderNo + "&Flag=" + Flag);
            }
        }
    }
}
