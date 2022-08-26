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
public partial class GUI_Fleet_Job_PrepareJob : System.Web.UI.Page
{
    DataView dvwProducts;
    private GridViewHelper helper;
    
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.AddJobRow datarow_Wgrp;
    MyFleetDataSet.JobSparePartRow datarow_Spare;
    string Type_Code = "";

    string cols = "";
    public string ServerDt;

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


        txtOrderDate.Text = strrightnow;
        lblOrderStatus.Text = "Open";

        System.DateTime nowdt = System.DateTime.Today;
        ServerDt = nowdt.ToString("dd/MM/yyyy");

        if (!IsPostBack)
        {
            Session["Type_Code"] = null;
            JobCardTypeList();
            txttotEstHrs.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txttotEstCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTaskRow.ClientID.ToString() + "').focus();");
            txtOrderDate.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            txtVehicleNo.Attributes.Add("onBlur", "javascript:CheckVehicleNo(this," + lblCategory.ClientID.ToString().Trim() + "," + lblMfg.ClientID.ToString().Trim() + "," + lblModel.ClientID.ToString().Trim() + "," + lblError.ClientID.ToString().Trim() + "," + txtKMReading.ClientID.ToString().Trim() + ");");
            lblCategory.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtOrderDate.ClientID.ToString() + "').focus();");
            lblMfg.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtOrderDate.ClientID.ToString() + "').focus();");
            lblModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtOrderDate.ClientID.ToString() + "').focus();");
            txtKMReading.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEstLabourHrs.ClientID.ToString() + "').focus();");
            if (Request.QueryString["OrderNo"] != null)
            {
                FillJobHeaderDetails(Request.QueryString["OrderNo"].ToString().Trim());
                FillJobTaskDetails(Request.QueryString["OrderNo"].ToString().Trim());
                FillJobSparePartDetails(Request.QueryString["OrderNo"].ToString().Trim());
            }
        }
    }
    public void FillJobHeaderDetails(string strOrderNo)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.JobOrderNo = strOrderNo;
        DataTable dtHdr = new DataTable();
        dtHdr = objJs.GetDataJobOrderHdr();
        if (dtHdr.Rows.Count > 0)
        {
            txtVehicleNo.Text = dtHdr.Rows[0]["VEHNO"].ToString();
            lblCategory.Text = dtHdr.Rows[0]["Type_Name"].ToString();
            lblMfg.Text = dtHdr.Rows[0]["Made_by"].ToString();
            lblModel.Text = dtHdr.Rows[0]["Model_No"].ToString();
            lblDriverCodeVal.Text = dtHdr.Rows[0]["JOB_ORDER_NO"].ToString();

            txtOrderDate.Text = dtHdr.Rows[0]["JOB_ORDER_DT"].ToString();
            ddlOrderType.Text = dtHdr.Rows[0]["ORDER_TYPE"].ToString();

            lblOrderStatus.Text = dtHdr.Rows[0]["ORDER_STATUS"].ToString();

            ddlSCtype.SelectedValue = dtHdr.Rows[0]["SERVICE_CENTER_TYPE"].ToString();
            if (dtHdr.Rows[0]["SERVICE_CENTER_TYPE"].ToString() == "Workshop")
            {
                ddlWLoc.SelectedValue = dtHdr.Rows[0]["WS_LOCCODE"].ToString();
            }
            else
            {
                ddlVendor.Text = dtHdr.Rows[0]["VENDOR_CODE"].ToString();
            }
            txtDCSendDt.Text = dtHdr.Rows[0]["SENDDT_WORKSHOP"].ToString();
            txtDCReturnDt.Text = dtHdr.Rows[0]["RETURNDT_WORKSHOP"].ToString();
            txtKMReading.Text = dtHdr.Rows[0]["KM_READING"].ToString();
            txtEstLabourHrs.Text = dtHdr.Rows[0]["Estimated_Labour_Hrs"].ToString();
            txttotEstHrs.Text = dtHdr.Rows[0]["TOT_EST_LABOUR_HRS"].ToString();
            txttotEstCost.Text = dtHdr.Rows[0]["TOT_EST_LABOUR_COST"].ToString();
            txtTotalEstimatedLabHours.Text = dtHdr.Rows[0]["TOT_EST_LABOUR_HRS"].ToString();
            txtTotalEstimatedLabCost.Text = dtHdr.Rows[0]["TOT_EST_LABOUR_COST"].ToString();
            txtTotalEstimated.Text = dtHdr.Rows[0]["TOT_ESTIMATED_COST"].ToString();
            txtTotalPartCost.Text = Convert.ToString(Convert.ToDouble(dtHdr.Rows[0]["TOT_ESTIMATED_COST"].ToString()) - Convert.ToDouble(dtHdr.Rows[0]["TOT_EST_LABOUR_COST"].ToString()));
        }
    }

    public void FillJobTaskDetails(string strOrderNo)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.JobOrderNo = strOrderNo;
        DataSet ds = new DataSet();
        ds = objJs.GetDataJobOrderTask();
        DataGrid1.DataSource = ds;
        DataGrid1.DataBind();

        foreach (GridViewRow row in DataGrid1.Rows)
        {
            DropDownList ddlTask = (DropDownList)DataGrid1.Rows[row.RowIndex].FindControl("ddlTask");
            DropDownList ddlWorkGroup = (DropDownList)DataGrid1.Rows[row.RowIndex].FindControl("ddlWorkGroup");
            ddlWorkGroup.Items.Clear();
            ddlTask.Items.Clear();
            BindWorkGroupList(ddlWorkGroup);
            ddlWorkGroup.SelectedValue = ds.Tables[0].Rows[row.RowIndex]["W_GRPCD"].ToString().Trim();
            objJs.BindTaskList(ddlTask, ddlWorkGroup.SelectedValue);  
            ddlTask.SelectedValue = ds.Tables[0].Rows[row.RowIndex]["TASKCD"].ToString().Trim();
        }
    }
    public void FillJobSparePartDetails(string strOrderNo)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.JobOrderNo = strOrderNo;
        DataSet  ds = new DataSet();
        ds = objJs.GetDataJobOrderSparePart();
        dgSpare.DataSource = ds;
        dgSpare.DataBind();
        foreach (DataGridItem item in dgSpare.Items)
        {
            DropDownList ddlPartNo = (DropDownList)dgSpare.Items[item.ItemIndex].FindControl("ddlPartNo");
            DropDownList ddlWorkGroup = (DropDownList)dgSpare.Items[item.ItemIndex].FindControl("ddlWorkGroup");
            ddlWorkGroup.Items.Clear();
            ddlPartNo.Items.Clear();
            BindWorkGroupList(ddlWorkGroup);
            ddlWorkGroup.SelectedValue = ds.Tables[0].Rows[item.ItemIndex]["W_GRPCD"].ToString().Trim();
            BindPartDesc(ddlPartNo, ddlWorkGroup .SelectedValue);
            ddlPartNo.SelectedValue = ds.Tables[0].Rows[item.ItemIndex]["PART_CODE"].ToString().Trim();
        }
    }
    public void JobCardTypeList()
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        string strSql = " SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CODETYPE='JOBCARDTYP' ";
        objJs.BindDropDown(ddlOrderType, strSql);
    }
    protected void txtTaskRow_TextChanged(object sender, EventArgs e)
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtTaskRow.Text;
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
        for (i = 0 + miroww; i < Int16.Parse(txtTaskRow.Text); i++)
        {
            _dataSet.AddJob.AddAddJobRow("", "", "", "");
        }
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
        lblError.Text = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mIssueDt = new DateTime();
        //mIssueDt = Convert.ToDateTime(lblDate.Text, dtfi);
        if (txtOrderDate.Text != "")
        {
            mIssueDt = Convert.ToDateTime(txtOrderDate.Text, dtfi);
        }
        DateTime mEstSendDt = new DateTime();
        //mEstSendDt = Convert.ToDateTime(txtDCSendDt_WS.CalendarDate.ToString(), dtfi) ;// Convert.ToDateTime(txtSendDt_WS.Text, dtfi);
        mEstSendDt = Convert.ToDateTime(txtDCSendDt.Text.ToString(), dtfi);// Convert.ToDateTime(txtSendDt_WS.Text, dtfi);
        DateTime mEstReturnDt = new DateTime();
        //mEstReturnDt = Convert.ToDateTime(txtDCReturnDt_WS.CalendarDate.ToString(), dtfi);// Convert.ToDateTime(txtReturnDt_WS.Text, dtfi);
        mEstReturnDt = Convert.ToDateTime(txtDCReturnDt.Text.ToString(), dtfi);// Convert.ToDateTime(txtReturnDt_WS.Text, dtfi);
        if (mEstSendDt < mIssueDt)
        {
            lblError.Visible = true;
            lblError.Text = "Send date to Workshop cannot be less than Job sheet Date !";
        }
        if (mEstReturnDt < mEstSendDt)
        {
            lblError.Visible = true;
            lblError.Text = "Estimated return date to Workshop cannot be less than Send date to Workshop !";
        }
        if(lblError.Text=="")
        {
            string OrderNo = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();

            try
            {
                if (Request.QueryString["OrderNo"] != null)
                {
                    OrderNo = Request.QueryString["OrderNo"].ToString(); 
                }

                string sql1 = "usp_Job_OrderHdrUpdate";
                SqlCommand cmd = new SqlCommand(sql1, conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                cmd.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehicleNo.Text.Trim();
                cmd.Parameters.Add("@OrderType", SqlDbType.VarChar).Value = ddlOrderType.SelectedItem.Value;
                cmd.Parameters.Add("@OrderDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtOrderDate.Text.Trim(), dtfi);
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
                cmd.Parameters.Add("@EstHrs", SqlDbType.Decimal).Value = Convert.ToDecimal(txttotEstHrs.Text.Trim());
                cmd.Parameters.Add("@EstCost", SqlDbType.Decimal).Value = Convert.ToDecimal(txttotEstCost.Text.Trim());

                cmd.Parameters.Add("@SENDDT_WORKSHOP", SqlDbType.DateTime).Value = mEstSendDt;
                cmd.Parameters.Add("@RETURNDT_WORKSHOP", SqlDbType.DateTime).Value = mEstReturnDt;
                if (txtEstLabourHrs.Text != "")
                {
                    cmd.Parameters.Add("@Estimated_Labour_Hrs", SqlDbType.Decimal).Value = Convert.ToDecimal(txtEstLabourHrs.Text.ToString());
                }
                else
                {
                    cmd.Parameters.Add("@Estimated_Labour_Hrs", SqlDbType.Decimal).Value = Convert.ToDecimal("0".ToString());
                }
                if (txtTotalEstimated.Text != "")
                {
                    cmd.Parameters.Add("@TOT_ESTIMATED_COST", SqlDbType.Decimal).Value = Convert.ToDecimal(txtTotalEstimated.Text.ToString());
                }
                else
                {
                    cmd.Parameters.Add("@TOT_ESTIMATED_COST", SqlDbType.Decimal).Value = Convert.ToDecimal("0".ToString());
                }
                cmd.Parameters.Add("@JS_BRCD", SqlDbType.VarChar, 4).Value = Convert.ToString(SessionUtilities.CurrentBranchCode);
                cmd.ExecuteNonQuery();
                string old_W_GRPCD = "";

                JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
                objJs.ExecuteNonQry("Delete from WEBX_FLEET_PM_JOBORDER_DET Where JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'");
                objJs.ExecuteNonQry("Delete from WEBX_FLEET_PM_JOBORDER_SPARE_EST_DET Where JOB_ORDER_NO='" + OrderNo.ToString().Trim() + "'");

                foreach (GridViewRow gridrow in DataGrid1.Rows)
                {
                    string W_GRPCD = ((DropDownList)gridrow.FindControl("ddlWorkGroup")).SelectedItem.Value.Trim();
                    string Desc = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Text.Trim();
                    string TASKCD = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Value.Trim();
                    string TaskType = ((TextBox)gridrow.FindControl("txtTaskType")).Text.Trim();
                    string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text.Trim();
                    string EstHrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();
                    string EstCost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();

                    //if (old_W_GRPCD != W_GRPCD)
                    //{
                    string sql = "usp_job_OrderDetInsertUpdate";
                    SqlCommand cmd2 = new SqlCommand(sql, conn, trans);

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";
                    cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                    // cmd2.Parameters.Add("@TaskDesc", SqlDbType.VarChar).Value = Desc.Trim();
                    // cmd2.Parameters.Add("@TaskTypecd", SqlDbType.VarChar).Value = tasktype_code.Trim();
                    cmd2.Parameters.Add("@EstHrs", SqlDbType.Float).Value = Convert.ToDouble(EstHrs.Trim());
                    cmd2.Parameters.Add("@EstCost", SqlDbType.Float).Value = Convert.ToDouble(EstCost.Trim());
                    cmd2.Parameters.Add("@Taskcd", SqlDbType.Int).Value = TASKCD.Trim();
                    cmd2.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = Remarks;

                    cmd2.ExecuteNonQuery();
                }
                foreach (DataGridItem gridrow2 in dgSpare.Items)
                {
                    string Part_code = ((DropDownList)gridrow2.FindControl("ddlPartNo")).SelectedItem.Value.Trim();
                    string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
                    string CostUnit = ((TextBox)gridrow2.FindControl("txtCostUnit")).Text.Trim();
                    string mCost1 = ((TextBox)gridrow2.FindControl("txtCost")).Text.Trim();
                    string S_Remark = ((TextBox)gridrow2.FindControl("txtSpareRemark")).Text.Trim();
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup"); 
                    Double mCostUnit = 0;
                    if (CostUnit != "")
                    {
                        mCostUnit = Convert.ToDouble(CostUnit);
                    }

                    string spsql = "usp_Job_EstSparePart";
                    SqlCommand spcmd = new SqlCommand(spsql, conn, trans);
                    spcmd.CommandType = CommandType.StoredProcedure;
                    spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = Part_code;
                    spcmd.Parameters.Add("@Qty", SqlDbType.Int).Value = Convert.ToInt32(Qty);
                    spcmd.Parameters.Add("@Cost_Unit", SqlDbType.Float).Value = Convert.ToDouble(mCostUnit);
                    spcmd.Parameters.Add("@Cost", SqlDbType.Float).Value = Convert.ToDouble(mCost1);
                    spcmd.Parameters.Add("@S_Remark", SqlDbType.VarChar).Value = S_Remark;
                    spcmd.Parameters.Add("@W_GRPCD", SqlDbType.Int).Value = Convert.ToInt32(ddlWorkGroup.SelectedValue);   
                    spcmd.ExecuteNonQuery();
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
    }

    public void addVendor()
    {
        ddlVendor.Items.Clear();
        string STR = "select distinct m.VENDORCODE,m.VENDORNAME+':'+m.VENDORCODE as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='14' and (vendorbrcd='ALL' or vendorbrcd='" + SessionUtilities.CurrentBranchCode.ToString() + "' or  patindex('%" + SessionUtilities.CurrentBranchCode.ToString() + "%',vendorbrcd)>0 ) ";
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString().Trim());
        objJs.BindDropDown(ddlVendor, STR);
    }

    public void addLocation()
    {
        ddlWLoc.Items.Clear();
        string STR = "select LocCode,LocName from webx_location where ActiveFlag='Y'";
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString().Trim());
        objJs.BindDropDown(ddlWLoc, STR);
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
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            DropDownList ddlTask = (DropDownList)e.Row.FindControl("ddlTask");
            DropDownList ddlWorkGroup = (DropDownList)e.Row.FindControl("ddlWorkGroup");
            TextBox txtTaskType = (TextBox)e.Row.FindControl("txtTaskType");
            TextBox txtEstHrs = (TextBox)e.Row.FindControl("txtEstHrs");
            TextBox txtEstCost = (TextBox)e.Row.FindControl("txtEstCost");
            TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");
            BindTaskList(ddlTask);
            if (Request.QueryString["OrderNo"] != null)
            {

            }
            BindWorkGroupList(ddlWorkGroup);
            txtTaskType.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString() + "').focus();");
            txtEstHrs.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString() + "').focus();");
            txtEstCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString().Trim() + "').focus();");   
            ddlTask.Attributes.Add("OnChange", "javascript:OnTaskDescChange(" + e.Row.RowIndex + "," + ddlTask.ClientID.ToString().Trim() + "," + txtTaskType.ClientID.ToString().Trim() + "," + txtEstHrs.ClientID.ToString().Trim() + "," + txtEstCost.ClientID.ToString().Trim() + "," + txtEstLabourHrs.ClientID.ToString().Trim() + ");");
        }
    }
    protected void txtQty_TextChanged(object sender, EventArgs e)
    {
        foreach (DataGridItem gridrow2 in dgSpare.Items)
        {
            int mqty = 0; Double mcost = 0;
            string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
            string CostUnit = ((TextBox)gridrow2.FindControl("txtCostUnit")).Text.Trim();
            if (Qty != "")
            {
                mqty = Convert.ToInt32(Qty);
            }
            if (CostUnit != "")
            {
                mcost = Convert.ToDouble(CostUnit);
            }
            Double ToatlCost = mqty * mcost;
            string Cost = ((TextBox)gridrow2.FindControl("txtCost")).Text = Convert.ToString(ToatlCost);
        }
    }
    protected void dgSpare_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select  distinct Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y'  Order by Part_Id ", conn);
        conn.Close();
        da1.Fill(ds1, "Webx_Fleet_spareParthdr");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlWorkGroup = (DropDownList)e.Item.FindControl("ddlWorkGroup");
            DropDownList ddlPartNo = ((DropDownList)e.Item.FindControl("ddlPartNo"));
            TextBox txtCostUnit = (TextBox)e.Item.FindControl("txtCostUnit");
            TextBox txtCost = (TextBox)e.Item.FindControl("txtCost");
            TextBox txtSpareRemark = (TextBox)e.Item.FindControl("txtSpareRemark");
            TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
            
            BindWorkGroupList(ddlWorkGroup);

            ddlPartNo.DataTextField = "Description";
            ddlPartNo.DataValueField = "Part_Id";

            ddlPartNo.DataSource = ds1.Tables["Webx_Fleet_spareParthdr"];

            ddlPartNo.DataBind();
            ddlPartNo.Items.Insert(0, "");
            ddlPartNo.Attributes.Add("OnChange", "javascript:OnPartDescChange(" + e.Item.ItemIndex + "," + ddlPartNo.ClientID.ToString().Trim() + "," + txtCostUnit.ClientID.ToString().Trim() + "," + txtCost.ClientID.ToString() + "," + txtSpareRemark.ClientID.ToString() + ");");
            txtQty.Attributes.Add("OnBlur", "javascript:OnPartDescCalculate(this," + txtCostUnit.ClientID.ToString() + "," + txtCost.ClientID.ToString() + ");");
            txtCostUnit.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtSpareRemark.ClientID.ToString() + "').focus();");
            txtCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtSpareRemark.ClientID.ToString() + "').focus();");
            //BindPartDesc(ddlPartNo,ddlWorkGroup.SelectedValue);
        }

        DataSet ds2 = new DataSet();
        SqlDataAdapter da2 = new SqlDataAdapter("select  distinct   PartName from WEBX_FLEET_PARTMST where  ACTIVEFLAG='Y'  order by PartName ", conn);
        conn.Close();
        da2.Fill(ds2, "WEBX_FLEET_PARTMST");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            /*DropDownList ddlPDesc = ((DropDownList)e.Item.FindControl("ddlPDesc"));
            ddlPDesc.DataTextField = "PartName";
            ddlPDesc.DataValueField = "PartName";

            ddlPDesc.DataSource = ds2.Tables["WEBX_FLEET_PARTMST"];

            ddlPDesc.DataBind();
            ddlPDesc.Items.Insert(0, "");*/



        }



        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            //datarow_Spare = ((MyFleetDataSet.JobSparePartRow)((DataRowView)e.Item.DataItem).Row);

            //((DropDownList)e.Item.FindControl("ddlPartNo")).SelectedItem.Text = datarow_Spare.PartNo;
            //((DropDownList)e.Item.FindControl("ddlPDesc")).SelectedItem.Text = datarow_Spare.PartDesc;

            //((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
            //((TextBox)e.Item.FindControl("txtCostUnit")).Text = datarow_Spare.Cost_Unit;
            //((TextBox)e.Item.FindControl("txtCost")).Text = datarow_Spare.Cost;
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
    public void BindTaskList(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindTaskList(d,"0"); 
    }

    public void BindWorkGroupList(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.BindWorkGroup(d);
    }
    protected void DataGrid1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
    }
    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        GridViewRow row = (GridViewRow)ddlWorkGroup.Parent.Parent;
        DropDownList ddlTask = (DropDownList)DataGrid1.Rows[row.RowIndex].FindControl("ddlTask");
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        ddlTask.Items.Clear();
        objJs.BindTaskList(ddlTask, ddlWorkGroup.SelectedValue);
    }

    protected void ddlWorkGroup_SelectedChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        DataGridItem item = (DataGridItem)ddlWorkGroup.Parent.Parent;
        DropDownList ddlPartNo = (DropDownList)dgSpare.Items[item.ItemIndex].FindControl("ddlPartNo");
        BindPartDesc(ddlPartNo, ddlWorkGroup.SelectedValue);
    }
    public void BindPartDesc(DropDownList d,string strWGRPDC)
    {
        d.Items.Clear();
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        string strSql = "select  Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y' and W_GRPDC = " + strWGRPDC + "";
        objJs.BindDropDown(d, strSql);
    }
    protected void txtEstCost_TextChanged(object sender, EventArgs e)
    {
        Double mCost = 0;
        Double totCost = 0;
        foreach (GridViewRow gridrow in DataGrid1.Rows)
        {
            if (((TextBox)gridrow.FindControl("txtEstCost")).Visible == true)
            {
                string Cost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();
                if (Cost != "")
                {
                    mCost = Convert.ToDouble(Cost);
                }
                totCost = totCost + mCost;
                txttotEstCost.Text = Convert.ToString(totCost);
                mCost = 0;
            }
        }
    }

    protected void txtEstHrs_TextChanged(object sender, EventArgs e)
    {
        Double mHrs = 0;
        Double totHrs = 0;
        foreach (GridViewRow gridrow in DataGrid1.Rows)
        {
            if (((TextBox)gridrow.FindControl("txtEstHrs")).Visible == true)
            {
                string Hrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();

                if (Hrs != "")
                {
                    mHrs = Convert.ToDouble(Hrs);
                }
                totHrs = totHrs + mHrs;
                txttotEstHrs.Text = Convert.ToString(totHrs);
                mHrs = 0;
            }
        }
    }
  
  



    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;

        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;

        int iroww = 0;
        foreach (DataGridItem gridrow in dgSpare.Items)
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
                _dataSet.JobSparePart.RemoveJobSparePartRow(_dataSet.JobSparePart[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            _dataSet.JobSparePart.AddJobSparePartRow("", "", "", "", "", "", "", "", "", "", "", "");
        }

        BindSpareGrid();

    }


    public void BindSpareGrid()
    {
        dgSpare.DataSource = _dataSet.JobSparePart;
        dgSpare.DataBind();
        _lastEditedPage = dgSpare.CurrentPageIndex;
    }







    protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
