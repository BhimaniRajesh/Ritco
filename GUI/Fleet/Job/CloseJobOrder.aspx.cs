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
            
            txtActCostUnit.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtActQty.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtActPartCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");

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
        row.Cells[0].Text = "Work Group Code & Description:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
    }

    public void BindSummary(string strOrderNo)
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = strOrderNo;
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
                //txtActPartCost.Text = Convert.ToString(dr["TOT_ACT_PART_COST"]);
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
                if (Convert.ToString(dr["Job_Order_Close_Type"]) == "Operational")
                {
                    txtDCActRetrunDt.Text = Convert.ToString(dr["RETURNDT_WORKSHOP"]);
                    txtCloseKM.Text = Convert.ToString(dr["CLOSE_KM_READING"]);
                    txtDCActRetrunDt.ReadOnly = true;
                    txtCloseKM.ReadOnly = true;
                }
                else
                {
                    txtDCActRetrunDt.ReadOnly = false;
                    txtCloseKM.ReadOnly = false;
                }

                txttotActLabCost.Text = Convert.ToString(dr["TOT_ACT_LABOUR_COST"]);
                txtActPartCost.Text = Convert.ToString(dr["TOT_ACT_PART_COST"]);
                txtJobCost.Text = Convert.ToString(Convert.ToDecimal((txttotActLabCost.Text == "" ? "0" : txttotActLabCost.Text)) + Convert.ToDecimal(txtActPartCost.Text == "" ? "0" : txtActPartCost.Text));

            }
        }
        BindGrid();
        BindGridSpare();
    }

    public void BindGrid()
    {
        DataTable dt = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        objJs.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
        dt = objJs.GetDataJobTaskCloure();

        _dataSet.AckJobOrder.Clear();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr1 in dt.Rows)
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

                string W_Action = Convert.ToString(dr1["TASK_ACTIONDESC"]);
                string W_AMC = Convert.ToString(dr1["AMC"]);
                string W_Act_Cost = Convert.ToString(dr1["W_ACT_LABOUR_COST"]);

                string SRNO = Convert.ToString(dr1["DET_SRNO"]);

                //_dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, Remark, "", "", W_EST_LABOUR_HRS, W_EST_LABOUR_COST, W_Action, W_AMC, W_Act_Cost);
                _dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, Remark, "", "", W_EST_LABOUR_HRS, W_EST_LABOUR_COST, W_Action, W_AMC, W_Act_Cost, SRNO);
            }
        }
        gvTaskDetails.DataSource = _dataSet.AckJobOrder;
        gvTaskDetails.DataBind();
        foreach (GridViewRow gridrow in gvTaskDetails.Rows)
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
        objJs.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
        dt = objJs.GetDataJobPartList();

        _dataSet.AckJobOrder.Clear();
        double tot_Qty = 0;
        double tot_COST_Unit = 0;
        double tot_COST = 0;

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr1 in dt.Rows)
            {
                string WorkGroup = Convert.ToString(dr1["W_GRPDESC"]);
                string PART_CODE = Convert.ToString(dr1["PART_CODE"]);
                string PART_DESC = Convert.ToString(dr1["PART_DESC"]);
                string PART_QTY = Convert.ToString(dr1["PART_QTY"]);
                string COST_UNIT = Convert.ToString(dr1["COST_UNIT"]);
                string COST = Convert.ToString(dr1["COST"]);
                string S_Remarks = Convert.ToString(dr1["S_Remarks"]);

                string strAct_Qty = Convert.ToString(dr1["ACT_PART_QTY"]);
                string strAct_COST_UNIT = Convert.ToString(dr1["ACT_COST_UNIT"]);
                string str_COST = Convert.ToString(dr1["ACT_COST"]);
                string TaskType = Convert.ToString(dr1["TaskType"]);

                string SPARE_SRNO = Convert.ToString(dr1["SPARE_SRNO"]);

                tot_COST = tot_COST + (COST == "" ? 0 : Convert.ToDouble(COST));
                tot_COST_Unit = tot_COST_Unit + (COST_UNIT == "" ? 0 : Convert.ToDouble(COST_UNIT));
                tot_Qty = tot_Qty + (PART_QTY == "" ? 0 : Convert.ToDouble(PART_QTY));

                //dt_SparePart.AddJobSparePartRow(WorkGroup, PART_CODE, PART_DESC, PART_QTY, COST_UNIT, COST, S_Remarks, strAct_Qty, strAct_COST_UNIT, str_COST, TaskType);
                dt_SparePart.AddJobSparePartRow(WorkGroup, PART_CODE, PART_DESC, PART_QTY, COST_UNIT, COST, S_Remarks, strAct_Qty, strAct_COST_UNIT, str_COST, TaskType, SPARE_SRNO);
            }
        }
        dgSpare.DataSource = dt_SparePart;
        dgSpare.DataBind();

        //txtActPartCost.Text = tot_COST.ToString();
        txtEstimatedSparePart.Text = Convert.ToString(tot_COST);
        lblTotPartCostUnit.Text = Convert.ToString(tot_COST_Unit);
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
            foreach (DataRow dr in dt.Rows)
            {
                ddlWONo.Items.Add(new ListItem(Convert.ToString(dr["JOB_ORDER_NO"]), Convert.ToString(dr["JOB_ORDER_NO"])));
            }
        }
    }
    protected void ddlWONo_SelectedIndexChanged(object sender, EventArgs e)
    {
        Inetialized();
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

        string strAction = "";
        string strAMC = "";
        string strActLabourCost = "";

        string strSNO = "";

        DataTable dtOrderDetView = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        objJs.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
        dtOrderDetView = objJs.JobOrderDetListView();

        if (dtOrderDetView.Rows.Count > 0)
        {
            foreach (DataRow mdr1 in dtOrderDetView.Rows)
            {
                TotRec = TotRec + 1;

                if (w_GRPD == "")
                {
                    w_GRPD = Convert.ToString(mdr1["WorkGroup"]);
                    Task_Code = Convert.ToString(mdr1["Taskcd"]);
                    Task_Desc = Convert.ToString(mdr1["taskdesc"]);
                    TASKTYP = Convert.ToString(mdr1["TaskType"]);
                    Task_Remark = Convert.ToString(mdr1["T_Remarks"]);
                    Est_LabourHrs = Convert.ToString(mdr1["W_EST_LABOUR_HRS"]);
                    Est_LabourCost = Convert.ToString(mdr1["W_EST_LABOUR_COST"]);

                    strAction = Convert.ToString(mdr1["TASK_ACTIONDESC"]);
                    strAMC = Convert.ToString(mdr1["AMC"]);
                    strActLabourCost = Convert.ToString(mdr1["W_ACT_LABOUR_COST"]);

                    strSNO = Convert.ToString(mdr1["DET_SRNO"]);
                }
                else
                {
                    w_GRPD = w_GRPD + "," + Convert.ToString(mdr1["WorkGroup"]); 
                    Task_Code = Task_Code + "," + Convert.ToString(mdr1["Taskcd"]); 
                    Task_Desc = Task_Desc + "," + Convert.ToString(mdr1["taskdesc"]); 
                    TASKTYP = TASKTYP + "," + Convert.ToString(mdr1["TaskType"]); 
                    Task_Remark = Task_Remark + "," + Convert.ToString(mdr1["T_Remarks"]); 
                    Est_LabourHrs = Est_LabourHrs + "," + Convert.ToString(mdr1["W_EST_LABOUR_HRS"]); 
                    Est_LabourCost = Est_LabourCost + "," + Convert.ToString(mdr1["W_EST_LABOUR_COST"]); 

                    strAction = strAction + "," + Convert.ToString(mdr1["TASK_ACTIONDESC"]); 
                    strAMC = strAMC + "," + Convert.ToString(mdr1["AMC"]); 
                    strActLabourCost = strActLabourCost + "," + Convert.ToString(mdr1["W_ACT_LABOUR_COST"]);
                    strSNO = strSNO + "," + Convert.ToString(mdr1["DET_SRNO"]);
                }
                //if (w_GRPD == "") { w_GRPD = Convert.ToString(mdr1["WorkGroup"]); } else { w_GRPD = w_GRPD + "," + Convert.ToString(mdr1["WorkGroup"]); }
                //if (Task_Code == "") { Task_Code = Convert.ToString(mdr1["Taskcd"]); } else { Task_Code = Task_Code + "," + Convert.ToString(mdr1["Taskcd"]); }
                //if (Task_Desc == "") { Task_Desc = Convert.ToString(mdr1["taskdesc"]); } else { Task_Desc = Task_Desc + "," + Convert.ToString(mdr1["taskdesc"]); }
                //if (TASKTYP == "") { TASKTYP = Convert.ToString(mdr1["TaskType"]); } else { TASKTYP = TASKTYP + "," + Convert.ToString(mdr1["TaskType"]); }
                //if (Task_Remark == "") { Task_Remark = Convert.ToString(mdr1["T_Remarks"]); } else { Task_Remark = Task_Remark + "," + Convert.ToString(mdr1["T_Remarks"]); }
                //if (Est_LabourHrs == "") { Est_LabourHrs = Convert.ToString(mdr1["W_EST_LABOUR_HRS"]); } else { Est_LabourHrs = Est_LabourHrs + "," + Convert.ToString(mdr1["W_EST_LABOUR_HRS"]); }
                //if (Est_LabourCost == "") { Est_LabourCost = Convert.ToString(mdr1["W_EST_LABOUR_COST"]); } else { Est_LabourCost = Est_LabourCost + "," + Convert.ToString(mdr1["W_EST_LABOUR_COST"]); }

                //if (strAction == "") { strAction = Convert.ToString(mdr1["TASK_ACTIONDESC"]); } else { strAction = strAction + "," + Convert.ToString(mdr1["TASK_ACTIONDESC"]); }
                //if (strAMC == "") { strAMC = Convert.ToString(mdr1["AMC"]); } else { strAMC = strAMC + "," + Convert.ToString(mdr1["AMC"]); }
                //if (strActLabourCost == "") { strActLabourCost = Convert.ToString(mdr1["W_ACT_LABOUR_COST"]); } else { strActLabourCost = strActLabourCost + "," + Convert.ToString(mdr1["W_ACT_LABOUR_COST"]); }
            }
        }

        string[] Arr_w_GRPD;
        string[] Arr_Task_Code;
        string[] Arr_Task_Desc;
        string[] Arr_TASKTYP;
        string[] Arr_Task_Remark;
        string[] Arr_Est_LabourHrs;
        string[] Arr_Est_LabourCost;

        string[] Arr_Action;
        string[] Arr_AMC;
        string[] Arr_ActLabourCost;

        string[] Arr_SRNO;

        Arr_w_GRPD = w_GRPD.Split(new Char[] { ',' });
        Arr_Task_Code = Task_Code.Split(new Char[] { ',' });
        Arr_Task_Desc = Task_Desc.Split(new Char[] { ',' });
        Arr_TASKTYP = TASKTYP.Split(new Char[] { ',' });
        Arr_Task_Remark = Task_Remark.Split(new Char[] { ',' });
        Arr_Est_LabourHrs = Est_LabourHrs.Split(new Char[] { ',' });
        Arr_Est_LabourCost = Est_LabourCost.Split(new Char[] { ',' });

        Arr_Action = strAction.Split(new Char[] { ',' });
        Arr_AMC = strAMC.Split(new Char[] { ',' });
        Arr_ActLabourCost = strActLabourCost.Split(new Char[] { ',' });
        Arr_SRNO = strSNO.Split(new Char[] { ',' });

        

        for (int i = 0; i < Convert.ToInt32(txtTaskRow.Text) + TotRec; i++)
        {
            if (TotRec > i)
            {
                if (Arr_w_GRPD.Length != Arr_ActLabourCost.Length)
                {
                    dt_AckJobOrder.AddAckJobOrderRow(Arr_w_GRPD[i], Arr_Task_Code[i], Arr_Task_Desc[i], Arr_TASKTYP[i], Arr_Task_Remark[i], "", "", Arr_Est_LabourHrs[i], Arr_Est_LabourCost[i], "", "", "", Arr_SRNO[i]);
                }
                else
                {
                    dt_AckJobOrder.AddAckJobOrderRow(Arr_w_GRPD[i], Arr_Task_Code[i], Arr_Task_Desc[i], Arr_TASKTYP[i], Arr_Task_Remark[i], "", "", Arr_Est_LabourHrs[i], Arr_Est_LabourCost[i], Arr_Action[i], Arr_AMC[i], Arr_ActLabourCost[i], Arr_SRNO[i]);
                }
            }
            else
            {
                dt_AckJobOrder.AddAckJobOrderRow("", "", "", "", "", "", "", "", "", "", "", "", "");
            }
        }
        txtTaskRow.Text = "0";

        BindTaskGrid();
    }
    public void BindTaskGrid()
    {
        gvTaskDetails.DataSource = dt_AckJobOrder;
        gvTaskDetails.DataBind();
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
        //string Act_Part_Qty = "";
        //string Act_Part_Cost = "";
        string strACT_PART_QTY = "";
        string strACT_COST_UNIT = "";
        string strACT_COST = "";
        string strTaskType = "";
        string strSRNO = "";

        DataTable dtOrderDetView = new DataTable();
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        objJs.JobOrderNo = ddlWONo.SelectedItem.Text.Trim();
        objJs.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
        dtOrderDetView = objJs.GetDataJobPartList();
        

        if (dtOrderDetView.Rows.Count > 0)
        {
            foreach (DataRow mdr1 in dtOrderDetView.Rows)
            {
                TotRec = TotRec + 1;


                if (W_GRPDESC == "")
                {
                    W_GRPDESC = Convert.ToString(mdr1["W_GRPDESC"]);
                    PartNo = Convert.ToString(mdr1["PART_CODE"]);
                    PartDesc = Convert.ToString(mdr1["PART_DESC"]);
                    PartQty = Convert.ToString(mdr1["PART_QTY"]);
                    Part_Rate = Convert.ToString(mdr1["COST_UNIT"]);
                    Part_Cost = Convert.ToString(mdr1["COST"]);
                    Part_Remark = Convert.ToString(mdr1["S_Remarks"]);

                    strACT_PART_QTY = Convert.ToString(mdr1["ACT_PART_QTY"]);
                    strACT_COST_UNIT = Convert.ToString(mdr1["ACT_COST_UNIT"]);
                    strACT_COST = Convert.ToString(mdr1["ACT_COST"]);
                    strTaskType = Convert.ToString(mdr1["TaskType"]);
                    strSRNO = Convert.ToString(mdr1["SPARE_SRNO"]);
                }
                else
                {
                    W_GRPDESC = W_GRPDESC + "," + Convert.ToString(mdr1["W_GRPDESC"]); 
                    PartNo = PartNo + "," + Convert.ToString(mdr1["PART_CODE"]); 
                    PartDesc = PartDesc + "," + Convert.ToString(mdr1["PART_DESC"]); 
                    PartQty = PartQty + "," + Convert.ToString(mdr1["PART_QTY"]); 
                    Part_Rate = Part_Rate + "," + Convert.ToString(mdr1["COST_UNIT"]); 
                    Part_Cost = Part_Cost + "," + Convert.ToString(mdr1["COST"]); 
                    Part_Remark = Part_Remark + "," + Convert.ToString(mdr1["S_Remarks"]); 

                    strACT_PART_QTY = strACT_PART_QTY + "," + Convert.ToString(mdr1["ACT_PART_QTY"]); 
                    strACT_COST_UNIT = strACT_COST_UNIT + "," + Convert.ToString(mdr1["ACT_COST_UNIT"]); 
                    strACT_COST = strACT_COST + "," + Convert.ToString(mdr1["ACT_COST"]); 
                    strTaskType = strTaskType + "," + Convert.ToString(mdr1["TaskType"]);
                    strSRNO = strSRNO + "," + Convert.ToString(mdr1["SPARE_SRNO"]);
                }
                //if (W_GRPDESC == "") { W_GRPDESC = Convert.ToString(mdr1["W_GRPDESC"]); } else { W_GRPDESC = W_GRPDESC + "," + Convert.ToString(mdr1["W_GRPDESC"]); }
                //if (PartNo == "") { PartNo = Convert.ToString(mdr1["PART_CODE"]); } else { PartNo = PartNo + "," + Convert.ToString(mdr1["PART_CODE"]); }
                //if (PartDesc == "") { PartDesc = Convert.ToString(mdr1["PART_DESC"]); } else { PartDesc = PartDesc + "," + Convert.ToString(mdr1["PART_DESC"]); }
                //if (PartQty == "") { PartQty = Convert.ToString(mdr1["PART_QTY"]); } else { PartQty = PartQty + "," + Convert.ToString(mdr1["PART_QTY"]); }
                //if (Part_Rate == "") { Part_Rate = Convert.ToString(mdr1["COST_UNIT"]); } else { Part_Rate = Part_Rate + "," + Convert.ToString(mdr1["COST_UNIT"]); }
                //if (Part_Cost == "") { Part_Cost = Convert.ToString(mdr1["COST"]); } else { Part_Cost = Part_Cost + "," + Convert.ToString(mdr1["COST"]); }
                //if (Part_Remark == "") { Part_Remark = Convert.ToString(mdr1["S_Remarks"]); } else { Part_Remark = Part_Remark + "," + Convert.ToString(mdr1["S_Remarks"]); }

                //if (strACT_PART_QTY == "") { strACT_PART_QTY = Convert.ToString(mdr1["ACT_PART_QTY"]); } else { strACT_PART_QTY = strACT_PART_QTY + "," + Convert.ToString(mdr1["ACT_PART_QTY"]); }
                //if (strACT_COST_UNIT == "") { strACT_COST_UNIT = Convert.ToString(mdr1["ACT_COST_UNIT"]); } else { strACT_COST_UNIT = strACT_COST_UNIT + "," + Convert.ToString(mdr1["ACT_COST_UNIT"]); }
                //if (strACT_COST == "") { strACT_COST = Convert.ToString(mdr1["ACT_COST"]); } else { strACT_COST = strACT_COST + "," + Convert.ToString(mdr1["ACT_COST"]); }
                //if (strTaskType == "") { strTaskType = Convert.ToString(mdr1["TaskType"]); } else { strTaskType = strTaskType + "," + Convert.ToString(mdr1["TaskType"]); }
                //if (Act_Part_Qty == "") { Act_Part_Qty = Convert.ToString(mdr1["Actual_Part_Qty"]); } else { Act_Part_Qty = Act_Part_Qty + "," + Convert.ToString(mdr1["Actual_Part_Qty"]); }
                //if (Act_Part_Cost == "") { Act_Part_Cost = Convert.ToString(mdr1["Actual_Part_Cost"]); } else { Act_Part_Cost = Act_Part_Cost + "," + Convert.ToString(mdr1["Actual_Part_Cost"]); }
            }
        }

        string[] Arr_WDesc;
        string[] Arr_PartNo;
        string[] Arr_PartDesc;
        string[] Arr_PartQty;
        string[] Arr_Part_Rate;
        string[] Arr_Part_Cost;
        string[] Arr_Part_Remark;

        string[] Arr_ACT_PART_QTY;
        string[] Arr_ACT_COST_UNIT;
        string[] Arr_ACT_COST;
        string[] Arr_TaskType;
        string[] Arr_Spare_Srno;

        //string[] Arr_Act_Part_Qty;
        //string[] Arr_Actual_Part_Cost;

        Arr_WDesc = W_GRPDESC.Split(new Char[] { ',' });
        Arr_PartNo = PartNo.Split(new Char[] { ',' });
        Arr_PartDesc = PartDesc.Split(new Char[] { ',' });
        Arr_PartQty = PartQty.Split(new Char[] { ',' });
        Arr_Part_Rate = Part_Rate.Split(new Char[] { ',' });
        Arr_Part_Cost = Part_Cost.Split(new Char[] { ',' });
        Arr_Part_Remark = Part_Remark.Split(new Char[] { ',' });
        //Arr_Act_Part_Qty = Act_Part_Qty.Split(new Char[] { ',' });
        //Arr_Actual_Part_Cost = Act_Part_Cost.Split(new Char[] { ',' });
        Arr_ACT_PART_QTY = strACT_PART_QTY.Split(new Char[] { ',' });
        Arr_ACT_COST_UNIT = strACT_COST_UNIT.Split(new Char[] { ',' });
        Arr_ACT_COST = strACT_COST.Split(new Char[] { ',' });
        Arr_TaskType = strTaskType.Split(new Char[] { ',' });
        Arr_Spare_Srno = strSRNO.Split(new Char[] { ',' });


        for (int i = 0; i < Convert.ToInt32(txtRow.Text) + TotRec; i++)
        {
            if (TotRec > i)
            {
                //dt_SparePart.AddJobSparePartRow(Arr_WDesc[i], Arr_PartNo[i], Arr_PartDesc[i], Arr_PartQty[i], Arr_Part_Rate[i], Arr_Part_Cost[i], Arr_Part_Remark[i], Arr_Act_Part_Qty[i], Arr_Actual_Part_Cost[i]);
                dt_SparePart.AddJobSparePartRow(Arr_WDesc[i], Arr_PartNo[i], Arr_PartDesc[i], Arr_PartQty[i], Arr_Part_Rate[i], Arr_Part_Cost[i], Arr_Part_Remark[i], Arr_ACT_PART_QTY[i], Arr_ACT_COST_UNIT[i], Arr_ACT_COST[i], Arr_TaskType[i], Arr_Spare_Srno[i]);
            }
            else
            {
                dt_SparePart.AddJobSparePartRow("", "", "", "", "", "", "", "", "", "", "", "");
            }
        }
        BindSpareGrid();
    }
    public void BindSpareGrid()
    {
        dgSpare.DataSource = dt_SparePart;
        dgSpare.DataBind();
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
    protected void gvTaskDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            //BindTaskList((DropDownList)e.Row.FindControl("ddlTask"));
            DropDownList ddlTask = (DropDownList)e.Row.FindControl("ddlTask");
            DropDownList ddlWorkGroup = (DropDownList)e.Row.FindControl("ddlWorkGroup");
            DropDownList ddlTaskType = (DropDownList)e.Row.FindControl("ddlTaskType");

            
            TextBox txtTaskType = (TextBox)e.Row.FindControl("txtTaskType");
            //TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");
            Label lblW_GRPCD = (Label)e.Row.FindControl("lblW_GRPCD");
            Label lblTaskDesc = (Label)e.Row.FindControl("lblTaskDesc");

            
            BindWorkGroupList(ddlWorkGroup);
            BindTaskType(ddlTaskType); 
            datarow_AJob = ((MyFleetDataSet.AckJobOrderRow)((DataRowView)e.Row.DataItem).Row);

            if (datarow_AJob.Taskcd != "")
            {
                lblW_GRPCD.Text = datarow_AJob.W_GRPCD;
                lblTaskDesc.Text = datarow_AJob.TaskDesc;
                ddlWorkGroup.Visible = false;
                ddlTask.Visible = false;
                ddlTaskType.Visible = false;
                txtTaskType.Visible = true;
            }
            else
            {
                ddlWorkGroup.Visible = true;
                ddlTask.Visible = true;
                ddlTaskType.Visible = true;
                txtTaskType.Visible = false;
            }


            HiddenField hfW_GRPCD = (HiddenField)e.Row.FindControl("hfW_GRPCD");
            HiddenField hfTaskCd = (HiddenField)e.Row.FindControl("hfTaskCd");

            hfW_GRPCD.Value = datarow_AJob.W_GRPCD;
            hfTaskCd.Value = datarow_AJob.Taskcd;  


            ((Label)e.Row.FindControl("lblTaskCode")).Text = datarow_AJob.Taskcd;
            ((TextBox)e.Row.FindControl("txtTaskType")).Text = datarow_AJob.TaskType;
            ((Label)e.Row.FindControl("lblRemark")).Text = datarow_AJob.Remark;

          
            //((TextBox)e.Row.FindControl("txtEstHrs")).Text = datarow_AJob.EstHrs;
            ((TextBox)e.Row.FindControl("txtActualLabourCost")).Text = datarow_AJob.EstCost;

            ((TextBox)e.Row.FindControl("txtEstHrs")).Text = datarow_AJob.T_EstHrs;
            ((TextBox)e.Row.FindControl("txtEstCost")).Text = datarow_AJob.T_EstCost;

            ((TextBox)e.Row.FindControl("txtAction")).Text = datarow_AJob.ActionTaken; 
            

            DropDownList ddlAMC = (DropDownList)e.Row.FindControl("ddlAMC");

            if (datarow_AJob.AMC == "No")
            {
                ddlAMC.SelectedValue = "1";
            }
            if (datarow_AJob.AMC == "Yes")
            {
                ddlAMC.SelectedValue = "2";
            }
            ((TextBox)e.Row.FindControl("txtActualLabourCost")).Text = datarow_AJob.ActCost; 
            
            ddlAMC.Attributes.Add("OnChange", "javascript:OnAMCChange(this," + ((TextBox)e.Row.FindControl("txtActualLabourCost")).ClientID.ToString() + ")");
            BindTaskList(ddlTask);
            ddlTask.Attributes.Add("OnChange", "javascript:OnTaskDescChange(" + e.Row.RowIndex + "," + ddlTask.ClientID.ToString().Trim() + "," + ddlTaskType.ClientID.ToString().Trim() + ");");
        }
    }

    public void BindPart(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindPart(d);
    }

    public void BindTaskType(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindTaskType(d);
    }
    protected void dgSpare_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlWorkGroup = (DropDownList)e.Item.FindControl("ddlWorkGroup");
            Label lblW_GRPCD = (Label)e.Item.FindControl("lblW_GRPCD");

            DropDownList ddlPartNo = (DropDownList)e.Item.FindControl("ddlPartNo");
            Label lblPartDesc = (Label)e.Item.FindControl("lblPartDesc");

            Label lblEstQty = (Label)e.Item.FindControl("lblEstQty");
            Label lblEstCostUnit = (Label)e.Item.FindControl("lblEstCostUnit");
            Label lblCost = (Label)e.Item.FindControl("lblCost");

            TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
            TextBox txtCostUnit = (TextBox)e.Item.FindControl("txtCostUnit");
            TextBox txtActualCost = (TextBox)e.Item.FindControl("txtActualCost");

            HiddenField hfPartCode = (HiddenField)e.Item.FindControl("hfPartCode");

            TextBox txtSpareRemark = (TextBox)e.Item.FindControl("txtSpareRemark");
            TextBox txtTaskType = (TextBox)e.Item.FindControl("txtTaskType");
            DropDownList ddlTaskType = (DropDownList)e.Item.FindControl("ddlTaskType");
            //TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
            //TextBox txtCostUnit = (TextBox)e.Item.FindControl("txtCostUnit");
            //TextBox txtActualCost = (TextBox)e.Item.FindControl("txtActualCost");

            

                
                
            //TextBox txtTaskType = (TextBox)e.Item.FindControl("txtTaskType");

            BindWorkGroupList(ddlWorkGroup);
            BindPart(ddlPartNo);
            BindTaskType(ddlTaskType);
            ddlPartNo.Attributes.Add("OnChange", "javascript:OnPartDescChange(" + e.Item.ItemIndex + ",this," + txtCostUnit.ClientID.ToString().Trim() + "," + txtQty.ClientID.ToString().Trim() + "," + txtActualCost.ClientID.ToString().Trim() + "," + txtSpareRemark.ClientID.ToString().Trim() + ");");
            txtQty.Attributes.Add("OnBlur", "javascript:calculateSpareCost(" + txtQty.ClientID.ToString() + "," + txtCostUnit.ClientID.ToString() + "," + txtActualCost.ClientID.ToString() + ")");
            txtCostUnit.Attributes.Add("OnBlur", "javascript:calculateSpareCost(" + txtQty.ClientID.ToString() + "," + txtCostUnit.ClientID.ToString() + "," + txtActualCost.ClientID.ToString() + ")");
            txtActualCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtSpareRemark.ClientID.ToString() + "').focus();");
            datarow_Spare = ((MyFleetDataSet.JobSparePartRow)((DataRowView)e.Item.DataItem).Row);

            hfPartCode.Value = datarow_Spare.PartNo;  
            lblW_GRPCD.Text = datarow_Spare.WORKGROUP.Trim();
            ddlPartNo.SelectedItem.Value = datarow_Spare.PartNo.Trim();
            ddlPartNo.SelectedItem.Text = datarow_Spare.PartDesc.Trim();
            lblPartDesc.Text = datarow_Spare.PartDesc.Trim();
            lblEstQty.Text = datarow_Spare.Qty;
            lblEstCostUnit.Text = datarow_Spare.Cost_Unit;
            lblCost.Text = datarow_Spare.Cost;
            txtSpareRemark.Text = datarow_Spare.Reamrk;
            //txtCostUnit.Text = datarow_Spare.Actual_Part_Cost;
            txtQty.Text = datarow_Spare.Act_Qty;
            txtCostUnit.Text = datarow_Spare.Act_Cost_Unit;
            txtActualCost.Text = datarow_Spare.Act_Cost;
            txtTaskType.Text = datarow_Spare.TaskType;
            if (datarow_Spare.WORKGROUP != "")
            {
                lblW_GRPCD.Text = datarow_Spare.WORKGROUP;
                ddlWorkGroup.Visible = false;
                ddlPartNo.Visible = false;
                lblW_GRPCD.Visible = true;
                lblPartDesc.Visible = true;
                ddlTaskType.Visible = false;
                txtTaskType.Visible = true;
            }
            else
            {
                txtTaskType.Visible = false; 
                ddlTaskType.Visible = true;
                lblW_GRPCD.Visible = false;
                lblPartDesc.Visible = false;
                ddlPartNo.Visible = true;
                ddlWorkGroup.Visible = true;
            }
        }
    }
    protected void ddlWorkGroupPart_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        DataGridItem row = (DataGridItem)ddlWorkGroup.Parent.Parent;
        DropDownList ddlPartNo = (DropDownList)dgSpare.Items[row.ItemIndex].FindControl("ddlPartNo");
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        ddlPartNo.Items.Clear();
        objJs.BindPartList(ddlPartNo, ddlWorkGroup.SelectedValue);
    }

    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        GridViewRow row = (GridViewRow)ddlWorkGroup.Parent.Parent;
        DropDownList ddlTask = (DropDownList)gvTaskDetails.Rows[row.RowIndex].FindControl("ddlTask");
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        ddlTask.Items.Clear();
        objJs.BindTaskList(ddlTask, ddlWorkGroup.SelectedValue);
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

        foreach (GridViewRow gridrow in gvTaskDetails.Rows)
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

        if (lblError.Text == "" && count < 1)
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
                //if (txttotActLabCost.Text.Trim() != "")
                //{
                //    Cost = Convert.ToDouble(txttotActLabCost.Text.Trim());
                //}
                //Hrs = Convert.ToDouble("0.0");
                //foreach (DataGridItem gridrow in dgSpare.Items)
                //{
                //    string Qty = ((TextBox)gridrow.FindControl("txtQty")).Text.Trim();
                //    string CostUnit = ((TextBox)gridrow.FindControl("txtActualCost")).Text.Trim();
                //    Double mCost = 0;
                //    mCost = Convert.ToDouble(Qty) * Convert.ToDouble(CostUnit);
                //    if (CostUnit != "")
                //    {
                //        totspcost = totspcost + Convert.ToDouble(mCost);
                //    }
                //}

                string str1 = "usp_Job_JobHdrClose";
                SqlCommand cmd2 = new SqlCommand(str1, conn, trans);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();
                cmd2.Parameters.Add("@TotALCost", SqlDbType.Float).Value = ((txttotActLabCost.Text == "") ? 0 : Convert.ToDecimal(txttotActLabCost.Text));
                cmd2.Parameters.Add("@PartTotCost", SqlDbType.Float).Value = ((txtActPartCost.Text == "") ? 0 : Convert.ToDecimal(txtActPartCost.Text));
                cmd2.Parameters.Add("@CLOSE_KM_READING", SqlDbType.Float).Value = txtCloseKM.Text.Trim();
                cmd2.Parameters.Add("@TOT_ACTUAL_COST", SqlDbType.Float).Value = ((txtJobCost.Text == "") ? 0 : Convert.ToDecimal(txtJobCost.Text));
                cmd2.Parameters.Add("@Job_Order_Close_Type", SqlDbType.VarChar).Value = "Financial";
                cmd2.Parameters.Add("@JS_Approve_By", SqlDbType.VarChar).Value = Session["empcd"].ToString();
                cmd2.Parameters.Add("@JOB_Order_Closedt", SqlDbType.DateTime).Value = mActReturnDt;
                cmd2.ExecuteNonQuery();

                //string str1 = "usp_Job_JobHdrClose";

                //SqlCommand cmd2 = new SqlCommand(str1, conn, trans);
                //cmd2.CommandType = CommandType.StoredProcedure;
                //cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();
                //cmd2.Parameters.Add("@TotALCost", SqlDbType.Float).Value = (txttotActLabCost.Text == "" ? 0 : Convert.ToDouble(txttotActLabCost.Text.Trim()));
                //cmd2.Parameters.Add("@PartTotCost", SqlDbType.Float).Value = (txtActPartCost.Text == "" ? 0 : Convert.ToDouble(txtActPartCost.Text.Trim()));
                //cmd2.Parameters.Add("@CLOSE_KM_READING", SqlDbType.Float).Value = txtCloseKM.Text.Trim();
                //cmd2.Parameters.Add("@TOT_ACTUAL_COST", SqlDbType.Float).Value = ((txtJobCost.Text == "") ? 0 : Convert.ToDecimal(txtJobCost.Text));

                //cmd2.ExecuteNonQuery();

                string old_W_FRPCD = "";
                Double tHrs = 0, tCost = 0;
                int RemTaskCntr = 0;
                foreach (GridViewRow gridrow2 in gvTaskDetails.Rows)
                {
                    CheckBox chk_Flag = (CheckBox)gridrow2.FindControl("chk_Flag");
                    Label lblW_GRPCD = (Label)gridrow2.FindControl("lblW_GRPCD");
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup");

                    HiddenField hfW_GRPCD = (HiddenField)gridrow2.FindControl("hfW_GRPCD");  
                    HiddenField hfTaskCd = (HiddenField)gridrow2.FindControl("hfTaskCd");  

                    Label lblTaskDesc = (Label)gridrow2.FindControl("lblTaskDesc");
                    DropDownList ddlTask = (DropDownList)gridrow2.FindControl("ddlTask");

                    Label lblRemark = (Label)gridrow2.FindControl("lblRemark");
                    TextBox txtAction = (TextBox)gridrow2.FindControl("txtAction");
                    TextBox txtEstHrs = (TextBox)gridrow2.FindControl("txtEstHrs");
                    TextBox txtEstCost = (TextBox)gridrow2.FindControl("txtEstCost");

                    DropDownList ddlAMC = (DropDownList)gridrow2.FindControl("ddlAMC");
                    DropDownList ddlTaskType = (DropDownList)gridrow2.FindControl("ddlTaskType");

                    TextBox txtActualLabourCost = (TextBox)gridrow2.FindControl("txtActualLabourCost");
                    HiddenField DETSRNO = (HiddenField)gridrow2.FindControl("DETSRNO");

                    //string sql = "usp_Job_Task_InsertUpdate";
                    string sql = "usp_Job_Task_InsertUpdate_27Apr12";
                    SqlCommand cmd3 = new SqlCommand(sql, conn, trans);

                    cmd3.CommandType = CommandType.StoredProcedure;
                    cmd3.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    cmd3.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedValue;
                    cmd3.Parameters.Add("@WDESC", SqlDbType.VarChar).Value = hfW_GRPCD.Value; 
                    cmd3.Parameters.Add("@EstHrs", SqlDbType.Float).Value = (txtEstHrs.Text == "") ? 0 : Convert.ToDouble(txtEstHrs.Text);
                    cmd3.Parameters.Add("@EstCost", SqlDbType.Float).Value = (txtEstCost.Text == "") ? 0 : Convert.ToDouble(txtEstCost.Text);
                    cmd3.Parameters.Add("@ActHrs", SqlDbType.Float).Value = 0;
                    cmd3.Parameters.Add("@ActCost", SqlDbType.Float).Value = (txtActualLabourCost.Text == "") ? 0 : Convert.ToDouble(txtActualLabourCost.Text);
                    cmd3.Parameters.Add("@Taskcd", SqlDbType.Int).Value = (ddlTask.SelectedValue == "") ? 0 : Convert.ToInt32(ddlTask.SelectedValue);
                    cmd3.Parameters.Add("@Taskcd1", SqlDbType.VarChar).Value = hfTaskCd.Value; 
                    cmd3.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = lblRemark.Text;
                    cmd3.Parameters.Add("@Task_ActionDesc", SqlDbType.VarChar).Value = txtAction.Text.Trim();
                    cmd3.Parameters.Add("@Task_Completed", SqlDbType.VarChar).Value = (chk_Flag.Checked == true) ? "Yes" : "No";
                    cmd3.Parameters.Add("@AMC", SqlDbType.VarChar).Value = (ddlAMC.SelectedValue == "2") ? "Yes" : "No";
                    if (ddlTaskType.Visible == true)
                    {
                        cmd3.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue);
                    }
                    else
                    {
                        cmd3.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = 0;
                    }
                    cmd3.Parameters.Add("@SRNO", SqlDbType.Int).Value = (DETSRNO.Value == "") ? 0 : Convert.ToInt32(DETSRNO.Value);
                    cmd3.ExecuteNonQuery();
                }

                //string strupd = "Usp_CloseJobSheetUpdateStatus";
                //SqlCommand cmdUP = new SqlCommand(strupd, conn, trans);
                //cmdUP.CommandType = CommandType.StoredProcedure;
                //cmdUP.Parameters.Add("@JOB_ORDER_NO", SqlDbType.VarChar, 50).Value = ddlWONo.SelectedItem.Text.Trim();
                //cmdUP.Parameters.Add("@JOB_Order_Closedt", SqlDbType.VarChar, 50).Value = mActReturnDt.ToString().Trim();
                //cmdUP.Parameters.Add("@JS_BRCD", SqlDbType.VarChar, 50).Value = Session["brcd"].ToString().Trim();
                //cmdUP.Parameters.Add("@JS_Approve_By_Close", SqlDbType.VarChar, 50).Value = Session["empcd"].ToString().Trim();
                //cmdUP.ExecuteNonQuery();

                Flag = "C";

                foreach (DataGridItem gridrow2 in dgSpare.Items)
                {
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup");
                    Label lblW_GRPCD = (Label)gridrow2.FindControl("lblW_GRPCD");
                    DropDownList ddlPartNo = (DropDownList)gridrow2.FindControl("ddlPartNo");
                    Label lblPartDesc = (Label)gridrow2.FindControl("lblPartDesc");
                    TextBox txtQty = (TextBox)gridrow2.FindControl("txtQty");
                    TextBox txtCostUnit = (TextBox)gridrow2.FindControl("txtCostUnit");
                    TextBox txtActualCost = (TextBox)gridrow2.FindControl("txtActualCost");
                    TextBox txtSpareRemark = (TextBox)gridrow2.FindControl("txtSpareRemark");
                    HiddenField hfPartCode = (HiddenField)gridrow2.FindControl("hfPartCode");
                    DropDownList ddlTaskType = (DropDownList)gridrow2.FindControl("ddlTaskType");
                    HiddenField SPARESRNO = (HiddenField)gridrow2.FindControl("SPARESRNO");

                    //string spsql = "usp_Job_ActSparePart";
                    string spsql = "usp_Job_ActSparePart_28Apr12";
                    SqlCommand spcmd = new SqlCommand(spsql, conn, trans);
                    spcmd.CommandType = CommandType.StoredProcedure;

                    spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    if (ddlWorkGroup.Visible == true)
                    {
                        spcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedValue;
                    }
                    else
                    {
                        spcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = "";
                    }
                    if (ddlPartNo.Visible == true)
                    {
                        spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = ddlPartNo.SelectedValue;
                    }
                    else
                    {
                        spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = "";
                    }
                    spcmd.Parameters.Add("@S_Remark", SqlDbType.VarChar).Value = txtSpareRemark.Text;
                    spcmd.Parameters.Add("@ACT_PART_QTY", SqlDbType.Float).Value = (txtQty.Text == "") ? 0 : Convert.ToDouble(txtQty.Text);
                    spcmd.Parameters.Add("@ACT_COST_UNIT", SqlDbType.Float).Value = (txtCostUnit.Text == "") ? 0 : Convert.ToDouble(txtCostUnit.Text);
                    spcmd.Parameters.Add("@ACT_COST", SqlDbType.Float).Value = (txtActualCost.Text == "") ? 0 : Convert.ToDouble(txtActualCost.Text);
                    spcmd.Parameters.Add("@Part_Code", SqlDbType.VarChar).Value = hfPartCode.Value;
                    if (ddlTaskType.Visible == true)
                    {
                        spcmd.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue);
                    }
                    else
                    {
                        spcmd.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = 0;
                    }
                    spcmd.Parameters.Add("@SPARE_SRNO", SqlDbType.Int).Value = (SPARESRNO.Value == "") ? 0 : Convert.ToInt32(SPARESRNO.Value);
                    spcmd.ExecuteNonQuery();
                }
                //trans.Commit();
                ////trans.Rollback();
                //success = true;

                 try
                {
                    //GetMailDetails(OrderNo.Trim(), conn, trans);
                    //trans.Commit();
                    ////trans.Rollback();
                    //success = true;

                    JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));

                    string sqlJob = "";
                    SqlCommand cmdJob = new SqlCommand(sqlJob, conn, trans);

                    int mACT_LABOUR_COST = 0;
                    int mact_cost = 0;
                    int mTOT_ACTUAL_COST = 0;

                    //sqlJob = "select * from vwJobOrderCostIssue where ACT_LABOUR_COST+act_cost<>TOT_ACTUAL_COST and JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'";
                    sqlJob = "select * from vwJobOrderCostIssue where JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'";

                    int mrecord = 0;

                    SqlCommand cd = new SqlCommand(sqlJob, conn, trans);
                    SqlDataReader cdr = cd.ExecuteReader();
                    if (cdr.HasRows)
                    {
                        while (cdr.Read())
                        {
                            mrecord = mrecord + 1;
                            mACT_LABOUR_COST = Convert.ToInt32(cdr["ACT_LABOUR_COST"]);
                            mact_cost = Convert.ToInt32(cdr["act_cost"]);
                            mTOT_ACTUAL_COST = Convert.ToInt32(cdr["TOT_ACTUAL_COST"]);

                        }
                    }
                    cdr.Close();

                    //if (mrecord > 0)
                    if (mTOT_ACTUAL_COST != mact_cost + mACT_LABOUR_COST)
                    {
                        trans.Rollback();
                        success = false;

                    }
                    else
                    {
                        //GetMailDetails(OrderNo.Trim(), conn, trans);
                        trans.Commit();
                        //trans.Rollback();
                        success = true;
                    }

                }
                 catch (Exception ex)
                 {
                     //if (hfFrom.Value == "")
                     //{
                     //    lblError.Text = "There is invalid or no email id for User : " + Session["empcd"].ToString() + ".\n Message Details : " + ex.Message.ToString();
                     //}
                     //if (hfToBranch.Value == "")
                     //{
                     //    lblError.Text = "Invalid Email Address. \n To : " + hfToBranch.Value + "\n" + hfToRegion.Value + "\n Message Details : " + ex.Message.ToString();
                     //}
                     //if (hfToBranch.Value == "" && hfToRegion.Value == "")
                     //{
                     //    lblError.Text = "Invalid Email Address. \n To : " + hfToBranch.Value + "\n" + hfToRegion.Value + "\n Message Details : " + ex.Message.ToString();
                     //}
                     //if (hfFrom.Value == "" && hfToBranch.Value == "" && hfToRegion.Value == "")
                     //{
                     //    lblError.Text = "Invalid Email Address. \n From : " + hfFrom.Value + "\n To : " + hfToBranch.Value + "\n" + hfToRegion.Value + "\n Message Details : " + ex.Message.ToString();
                     //}
                     trans.Rollback();
                 }


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
    protected void cmdOperationlSubmit_Click(object sender, EventArgs e)
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

        foreach (GridViewRow gridrow in gvTaskDetails.Rows)
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

        if (lblError.Text == "" && count < 1)
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
                string str1 = "usp_Job_JobHdrClose";
                SqlCommand cmd2 = new SqlCommand(str1, conn, trans);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = ddlWONo.SelectedItem.Text.Trim();
                cmd2.Parameters.Add("@TotALCost", SqlDbType.Float).Value = ((txttotActLabCost.Text == "") ? 0 : Convert.ToDecimal(txttotActLabCost.Text));
                cmd2.Parameters.Add("@PartTotCost", SqlDbType.Float).Value = ((txtActPartCost.Text == "") ? 0 : Convert.ToDecimal(txtActPartCost.Text)); 
                cmd2.Parameters.Add("@CLOSE_KM_READING", SqlDbType.Float).Value = txtCloseKM.Text.Trim();
                cmd2.Parameters.Add("@TOT_ACTUAL_COST", SqlDbType.Float).Value = ((txtJobCost.Text == "") ? 0 : Convert.ToDecimal(txtJobCost.Text));
                cmd2.Parameters.Add("@Job_Order_Close_Type", SqlDbType.VarChar).Value = "Operational";
                cmd2.Parameters.Add("@JS_Approve_By", SqlDbType.VarChar).Value = Session["empcd"].ToString();
                cmd2.Parameters.Add("@JOB_Order_Closedt", SqlDbType.DateTime).Value = mActReturnDt;
                cmd2.ExecuteNonQuery();

                string old_W_FRPCD = "";
                Double tHrs = 0, tCost = 0;
                int RemTaskCntr = 0;
                foreach (GridViewRow gridrow2 in gvTaskDetails.Rows)
                {
                    CheckBox chk_Flag = (CheckBox)gridrow2.FindControl("chk_Flag");
                    Label lblW_GRPCD = (Label)gridrow2.FindControl("lblW_GRPCD");
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup");
                    DropDownList ddlTaskType = (DropDownList)gridrow2.FindControl("ddlTaskType");


                    HiddenField hfW_GRPCD = (HiddenField)gridrow2.FindControl("hfW_GRPCD");
                    HiddenField hfTaskCd = (HiddenField)gridrow2.FindControl("hfTaskCd");

                    Label lblTaskDesc = (Label)gridrow2.FindControl("lblTaskDesc");
                    DropDownList ddlTask = (DropDownList)gridrow2.FindControl("ddlTask");

                    Label lblRemark = (Label)gridrow2.FindControl("lblRemark");
                    TextBox txtAction = (TextBox)gridrow2.FindControl("txtAction");
                    TextBox txtEstHrs = (TextBox)gridrow2.FindControl("txtEstHrs");
                    TextBox txtEstCost = (TextBox)gridrow2.FindControl("txtEstCost");

                    DropDownList ddlAMC = (DropDownList)gridrow2.FindControl("ddlAMC");

                    TextBox txtActualLabourCost = (TextBox)gridrow2.FindControl("txtActualLabourCost");
                    HiddenField DETSRNO = (HiddenField)gridrow2.FindControl("DETSRNO");

                    string sql = "usp_Job_Task_InsertUpdate_27Apr12";
                    SqlCommand cmd3 = new SqlCommand(sql, conn, trans);

                    cmd3.CommandType = CommandType.StoredProcedure;
                    cmd3.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    cmd3.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedValue;
                    cmd3.Parameters.Add("@WDESC", SqlDbType.VarChar).Value = hfW_GRPCD.Value;
                    cmd3.Parameters.Add("@EstHrs", SqlDbType.Float).Value = (txtEstHrs.Text == "") ? 0 : Convert.ToDouble(txtEstHrs.Text);
                    cmd3.Parameters.Add("@EstCost", SqlDbType.Float).Value = (txtEstCost.Text == "") ? 0 : Convert.ToDouble(txtEstCost.Text);
                    cmd3.Parameters.Add("@ActHrs", SqlDbType.Float).Value = 0;
                    cmd3.Parameters.Add("@ActCost", SqlDbType.Float).Value = (txtActualLabourCost.Text == "") ? 0 : Convert.ToDouble(txtActualLabourCost.Text);
                    cmd3.Parameters.Add("@Taskcd", SqlDbType.Int).Value = (ddlTask.SelectedValue == "") ? 0 : Convert.ToInt32(ddlTask.SelectedValue);
                    cmd3.Parameters.Add("@Taskcd1", SqlDbType.VarChar).Value = hfTaskCd.Value;
                    cmd3.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = lblRemark.Text;
                    cmd3.Parameters.Add("@Task_ActionDesc", SqlDbType.VarChar).Value = txtAction.Text.Trim();
                    cmd3.Parameters.Add("@Task_Completed", SqlDbType.VarChar).Value = (chk_Flag.Checked == true) ? "Yes" : "No";
                    cmd3.Parameters.Add("@AMC", SqlDbType.VarChar).Value = (ddlAMC.SelectedValue == "2") ? "Yes" : "No";
                    if (ddlTaskType.Visible == true)
                    {
                        cmd3.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue);
                    }
                    else
                    {
                        cmd3.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = 0;
                    }
                    cmd3.Parameters.Add("@SRNO", SqlDbType.Int).Value = (DETSRNO.Value == "") ? 0 : Convert.ToInt32(DETSRNO.Value);

                    cmd3.ExecuteNonQuery();
                }
                Flag = "C";

                foreach (DataGridItem gridrow2 in dgSpare.Items)
                {
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup");
                    Label lblW_GRPCD = (Label)gridrow2.FindControl("lblW_GRPCD");
                    DropDownList ddlPartNo = (DropDownList)gridrow2.FindControl("ddlPartNo");
                    Label lblPartDesc = (Label)gridrow2.FindControl("lblPartDesc");
                    TextBox txtQty = (TextBox)gridrow2.FindControl("txtQty");
                    TextBox txtCostUnit = (TextBox)gridrow2.FindControl("txtCostUnit");
                    TextBox txtActualCost = (TextBox)gridrow2.FindControl("txtActualCost");
                    TextBox txtSpareRemark = (TextBox)gridrow2.FindControl("txtSpareRemark");
                    DropDownList ddlTaskType = (DropDownList)gridrow2.FindControl("ddlTaskType");
                    HiddenField hfPartCode = (HiddenField)gridrow2.FindControl("hfPartCode");
                    HiddenField SPARESRNO = (HiddenField)gridrow2.FindControl("SPARESRNO");

                    //string spsql = "usp_Job_ActSparePart";
                    string spsql = "usp_Job_ActSparePart_28Apr12";
                    SqlCommand spcmd = new SqlCommand(spsql, conn, trans);
                    spcmd.CommandType = CommandType.StoredProcedure;

                    spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    if (ddlWorkGroup.Visible == true)
                    {
                        spcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedValue;
                    }
                    else
                    {
                        spcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = "";
                    }
                    if (ddlPartNo.Visible == true)
                    {
                        spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = ddlPartNo.SelectedValue;
                    }
                    else
                    {
                        spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = "";
                    }
                    spcmd.Parameters.Add("@S_Remark", SqlDbType.VarChar).Value = txtSpareRemark.Text;
                    spcmd.Parameters.Add("@ACT_PART_QTY", SqlDbType.Float).Value = (txtQty.Text == "") ? 0 : Convert.ToDouble(txtQty.Text);
                    spcmd.Parameters.Add("@ACT_COST_UNIT", SqlDbType.Float).Value = (txtCostUnit.Text == "") ? 0 : Convert.ToDouble(txtCostUnit.Text);
                    spcmd.Parameters.Add("@ACT_COST", SqlDbType.Float).Value = (txtActualCost.Text == "") ? 0 : Convert.ToDouble(txtActualCost.Text);
                    spcmd.Parameters.Add("@Part_Code", SqlDbType.VarChar).Value = hfPartCode.Value;
                    if (ddlTaskType.Visible == true)
                    {
                        spcmd.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue);
                    }
                    else
                    {
                        spcmd.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = 0;
                    }
                    spcmd.Parameters.Add("@SPARE_SRNO", SqlDbType.Int).Value = (SPARESRNO.Value == "") ? 0 : Convert.ToInt32(SPARESRNO.Value);
                    spcmd.ExecuteNonQuery();
                }


                JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));

                string sqlJob = "";
                SqlCommand cmdJob = new SqlCommand(sqlJob, conn, trans);

                int mACT_LABOUR_COST = 0;
                int mact_cost = 0;
                int mTOT_ACTUAL_COST = 0;

                //sqlJob = "select * from vwJobOrderCostIssue where ACT_LABOUR_COST+act_cost<>TOT_ACTUAL_COST and JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'";
                sqlJob = "select * from vwJobOrderCostIssue where JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'";

                int mrecord = 0;

                SqlCommand cd = new SqlCommand(sqlJob, conn, trans);
                SqlDataReader cdr = cd.ExecuteReader();
                if (cdr.HasRows)
                {
                    while (cdr.Read())
                    {
                        mrecord = mrecord + 1;
                        mACT_LABOUR_COST = Convert.ToInt32(cdr["ACT_LABOUR_COST"]);
                        mact_cost = Convert.ToInt32(cdr["act_cost"]);
                        mTOT_ACTUAL_COST = Convert.ToInt32(cdr["TOT_ACTUAL_COST"]);

                    }
                }
                cdr.Close();

                //if (mrecord > 0)
                if (mTOT_ACTUAL_COST != mact_cost + mACT_LABOUR_COST)
                {
                    trans.Rollback();
                    success = false;

                }
                else
                {
                    trans.Commit();
                    //trans.Rollback();
                    success = true;
                }



                //trans.Commit();
                //trans.Rollback();
                //success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                //Response.Write("Error" + e1.Message);
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
