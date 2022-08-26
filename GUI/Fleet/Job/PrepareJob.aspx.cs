
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
        
        lblOrderStatus.Text = "Open";

        System.DateTime nowdt = System.DateTime.Today;
        ServerDt = nowdt.ToString("dd/MM/yyyy");

        if (!IsPostBack)
        {
            txtOrderDate.Text = strrightnow;
            Session["Type_Code"] = null;
            JobCardTypeList();
            //txtOrderDate.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            txtVehicleNo.Attributes.Add("onBlur", "javascript:CheckVehicleNo(this," + lblCategory.ClientID.ToString().Trim() + "," + lblMfg.ClientID.ToString().Trim() + "," + lblModel.ClientID.ToString().Trim() + "," + lblError.ClientID.ToString().Trim() + "," + txtKMReading.ClientID.ToString().Trim() + "," + txt_Tmp_CurrentKM.ClientID.Trim() + ");");
        	txtEstLabourHrs.Attributes.Add("onBlur", "javascript:CheckEstLabourHrs(this," + txtEstLabourHrs.ClientID.ToString().Trim() + ");");
		}
    }
    public void JobCardTypeList()
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        string strSql = "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CODETYPE='JOBCARDTYP' ";
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
        foreach (GridViewRow gridrow in gvTaskDetails.Rows)
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
        if (gvTaskDetails.Rows.Count != 0)
        {
            tblSubmit.Visible = true;
            //cmdSubmit.Visible = true;
        }
        else
        {
            //cmdSubmit.Visible = false;
            tblSubmit.Visible = false;
        }
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
        gvTaskDetails.DataSource = _dataSet.AddJob;
        gvTaskDetails.DataBind();
        if (gvTaskDetails.Rows.Count != 0)
        {
            tblSubmit.Visible = true;  
            //cmdSubmit.Visible = true;
        }
        else
        {
            tblSubmit.Visible = false;
            //cmdSubmit.Visible = false;
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

               
                string YearVal="";
                string msql = "USP_CREATE_JOB_ORDER_NO";
                SqlCommand cmd4 = new SqlCommand(msql, conn, trans);
                cmd4.CommandType = CommandType.StoredProcedure;

                //if (Session["FinYear_Change"] != null)
                //{
                //    YearVal = Session["FinYear_Change"].ToString().Trim();
                //}

                GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                YearVal = objFinYear.FinancialYear();

                cmd4.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = Convert.ToString(Session["brcd"]);
                cmd4.Parameters.Add("@FIN_YEAR", SqlDbType.VarChar).Value = YearVal;
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
                cmd.Parameters.Add("@OrderType", SqlDbType.VarChar).Value = ddlOrderType.SelectedItem.Value;
                cmd.Parameters.Add("@OrderDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtOrderDate.Text.Trim(), dtfi);
                cmd.Parameters.Add("@OrderStatus", SqlDbType.VarChar).Value = lblOrderStatus.Text.Trim();
                cmd.Parameters.Add("@SCType", SqlDbType.VarChar).Value = ddlSCtype.SelectedItem.Text.Trim();
                if (ddlSCtype.SelectedItem.Text.Trim() == "Vendor")
                {                  
                    cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = ddlVendor.SelectedItem.Value.Trim();
                    cmd.Parameters.Add("@Work_Loc", SqlDbType.VarChar).Value = "";
                }
                if (ddlSCtype.SelectedItem.Text.Trim() == "Workshop")
                {
                    cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@Work_Loc", SqlDbType.VarChar).Value = ddlWLoc.SelectedItem.Value.Trim();   
                }
                
                //cmd.Parameters.Add("@Km_Read", SqlDbType.Decimal).Value = Convert.ToDecimal(txtKMReading.Text.Trim());
                cmd.Parameters.Add("@Km_Read", SqlDbType.Decimal).Value = txt_Tmp_CurrentKM.Text == "" ? 0 : Convert.ToDecimal(txt_Tmp_CurrentKM.Text.Trim());
                
                cmd.Parameters.Add("@EstHrs", SqlDbType.Decimal).Value = txttotEstHrs.Text == "" ? 0 : Convert.ToDecimal(txttotEstHrs.Text.Trim());
                cmd.Parameters.Add("@EstCost", SqlDbType.Decimal).Value = txttotEstCost.Text == "" ? 0 : Convert.ToDecimal(txttotEstCost.Text.Trim());

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
                cmd.Parameters.Add("@JS_BRCD", SqlDbType.VarChar,10).Value = Convert.ToString(Session["brcd"]);
                cmd.Parameters.Add("@JS_Approve_By", SqlDbType.VarChar, 50).Value = Convert.ToString(Session["empcd"]);
                cmd.Parameters.Add("@TOT_EST_PART_COST", SqlDbType.Decimal).Value = (txtTotalPartCost.Text == "") ? 0 : Convert.ToDecimal(txtTotalPartCost.Text);
                cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = Convert.ToString(Session["empcd"]);
                cmd.Parameters.Add("@Company_Code", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim();
                
                cmd.ExecuteNonQuery();

                string old_W_GRPCD = "";
                foreach (GridViewRow gridrow in gvTaskDetails.Rows)
                {
                    DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");  
                    string W_GRPCD = ((DropDownList)gridrow.FindControl("ddlWorkGroup")).SelectedItem.Value.Trim();
                    string Desc = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Text.Trim();
                    string TASKCD = ((DropDownList)gridrow.FindControl("ddlTask")).SelectedItem.Value.Trim();
                    string TaskType = ddlTaskType.SelectedItem.Text;
                    //string TaskType = ((TextBox)gridrow.FindControl("txtTaskType")).Text.Trim();

                    string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text.Trim();
                    string EstHrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();
                    string EstCost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();
                    string sql = "usp_job_OrderDetInsertUpdate";
                    SqlCommand cmd2 = new SqlCommand(sql, conn, trans);
                    cmd2.CommandType = CommandType.StoredProcedure;
                    
                    cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;
                    cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";
                    cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();
                    cmd2.Parameters.Add("@EstHrs", SqlDbType.Float).Value = Convert.ToDouble(EstHrs.Trim());
                    cmd2.Parameters.Add("@EstCost", SqlDbType.Float).Value = Convert.ToDouble(EstCost.Trim());
                    cmd2.Parameters.Add("@Taskcd", SqlDbType.Int).Value = TASKCD.Trim();
                    cmd2.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = Remarks;
                    cmd2.Parameters.Add("@SMTask", SqlDbType.VarChar).Value = "No";
                    cmd2.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue.ToString().Trim());
                    
                    cmd2.ExecuteNonQuery();
                }
                foreach (GridViewRow gridrow in gvSMTaskDet.Rows)
                {
                    HiddenField hfWrkGrpID = (HiddenField)gridrow.FindControl("hfWrkGrpID");
                    CheckBox chkSelect = (CheckBox)gridrow.FindControl("chkSelect");
                    HiddenField hfTaskId = (HiddenField)gridrow.FindControl("hfTaskId");
                    HiddenField hfTaskTypeId = (HiddenField)gridrow.FindControl("hfTaskTypeId");
                    TextBox txtEstHrs = (TextBox)gridrow.FindControl("txtEstHrs");
                    TextBox txtEstCost = (TextBox)gridrow.FindControl("txtEstCost");
                    TextBox txtRemarks = (TextBox)gridrow.FindControl("txtRemarks");
                    if (chkSelect.Checked == true)
                    {
                        string sql = "usp_job_OrderDetInsertUpdate";

                        SqlCommand cmd2 = new SqlCommand(sql, conn, trans);

                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim(); ;
                        cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = "";
                        cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = hfWrkGrpID.Value.Trim();
                        cmd2.Parameters.Add("@EstHrs", SqlDbType.Float).Value = (txtEstHrs.Text == "" ? 0 : Convert.ToDouble(txtEstHrs.Text));
                        cmd2.Parameters.Add("@EstCost", SqlDbType.Float).Value = (txtEstCost.Text == "" ? 0 : Convert.ToDouble(txtEstCost.Text));
                        cmd2.Parameters.Add("@Taskcd", SqlDbType.Int).Value = (hfTaskId.Value == "" ? 0 : Convert.ToDouble(hfTaskId.Value));
                        cmd2.Parameters.Add("@T_Remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                        cmd2.Parameters.Add("@SMTask", SqlDbType.VarChar).Value = "Yes";
                        cmd2.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(hfTaskTypeId.Value);

                        cmd2.ExecuteNonQuery();
                    }
                }
                foreach (GridViewRow gridrow in gvSMTaskDet.Rows)
                {
                    HiddenField hfWrkGrpID = (HiddenField)gridrow.FindControl("hfWrkGrpID");
                    HiddenField hfTaskId = (HiddenField)gridrow.FindControl("hfTaskId");
                    HiddenField hfTaskTypeId = (HiddenField)gridrow.FindControl("hfTaskTypeId");
                    CheckBox chkSelect = (CheckBox)gridrow.FindControl("chkSelect");
                    if (chkSelect.Checked == true)
                    {
                        string sql = "usp_SMJob_OrderDetInsert";
                        SqlCommand cmd2 = new SqlCommand(sql, conn, trans);

                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.Add("@Job_Order_No", SqlDbType.VarChar, 50).Value = OrderNo.Trim(); ;
                        cmd2.Parameters.Add("@Vehicle_No", SqlDbType.VarChar, 15).Value = txtVehicleNo.Text.ToString();
                        cmd2.Parameters.Add("@Task_Id", SqlDbType.Int).Value = Convert.ToInt32(hfTaskId.Value);
                        cmd2.Parameters.Add("@JS_KM", SqlDbType.Decimal).Value = Convert.ToDecimal(txt_Tmp_CurrentKM.Text);
                        cmd2.Parameters.Add("@Entry_By", SqlDbType.VarChar, 50).Value = Convert.ToString(Session["empcd"]);
                        cmd2.Parameters.Add("@JS_Dt", SqlDbType.VarChar, 13).Value = txtOrderDate.Text.Trim();

                        cmd2.ExecuteNonQuery();
                    }
                }
                foreach (DataGridItem gridrow2 in dgSpare.Items)
                {
                    DropDownList ddlWorkGroup = (DropDownList)gridrow2.FindControl("ddlWorkGroup");
                    DropDownList ddlTaskType = (DropDownList)gridrow2.FindControl("ddlTaskType");
                    DropDownList ddlPartNo = (DropDownList)gridrow2.FindControl("ddlPartNo");
                    TextBox txtQty = (TextBox)gridrow2.FindControl("txtQty");
                    TextBox txtCostUnit = (TextBox)gridrow2.FindControl("txtCostUnit");
                    TextBox txtCost = (TextBox)gridrow2.FindControl("txtCost");
                    TextBox txtSpareRemark = (TextBox)gridrow2.FindControl("txtSpareRemark");

                    string spsql = "usp_Job_EstSparePart";
                    SqlCommand spcmd = new SqlCommand(spsql, conn, trans);
                    spcmd.CommandType = CommandType.StoredProcedure;
                    spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo.Trim();
                    spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = ddlPartNo.SelectedValue;
                    spcmd.Parameters.Add("@Qty", SqlDbType.Int).Value = (txtQty.Text != "") ? Convert.ToInt32(txtQty.Text) : 0;
                    spcmd.Parameters.Add("@Cost_Unit", SqlDbType.Float).Value = (txtCostUnit.Text != "") ? Convert.ToDouble(txtCostUnit.Text) : 0;
                    spcmd.Parameters.Add("@Cost", SqlDbType.Float).Value = (txtCost.Text != "") ? Convert.ToDouble(txtCost.Text) : 0;
                    spcmd.Parameters.Add("@S_Remark", SqlDbType.VarChar).Value = txtSpareRemark.Text;
                    spcmd.Parameters.Add("@W_GRPCD", SqlDbType.Int).Value = Convert.ToInt32(ddlWorkGroup.SelectedValue);
                    spcmd.Parameters.Add("@TaskTypeID", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue);   
                    
                    spcmd.ExecuteNonQuery();
                }
                trans.Commit();
                //   trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                //Response.Write("Error" + e1.Message);
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
        string STR = "select distinct m.VENDORCODE,m.VENDORNAME+':'+m.VENDORCODE as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='14' and (vendorbrcd='ALL' or vendorbrcd='" + Session["brcd"].ToString() + "' or  patindex('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) ";
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
    protected void gvTaskDetails_ItemDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            DropDownList ddlTask = (DropDownList)e.Row.FindControl("ddlTask");
            DropDownList ddlWorkGroup = (DropDownList)e.Row.FindControl("ddlWorkGroup");
            DropDownList ddlTaskType = (DropDownList)e.Row.FindControl("ddlTaskType");
            //TextBox txtTaskType = (TextBox)e.Row.FindControl("txtTaskType");
            TextBox txtEstHrs = (TextBox)e.Row.FindControl("txtEstHrs");
            TextBox txtEstCost = (TextBox)e.Row.FindControl("txtEstCost");
            TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");
            BindTaskList(ddlTask);
            BindWorkGroupList(ddlWorkGroup);
            BindTaskType(ddlTaskType);
            //txtTaskType.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString() + "').focus();");
            //txtEstHrs.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString() + "').focus();");
            txtEstCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtRemarks.ClientID.ToString().Trim() + "').focus();");   
            //ddlTask.Attributes.Add("OnChange", "javascript:OnTaskDescChange(" + e.Row.RowIndex + "," + ddlTask.ClientID.ToString().Trim() + "," + txtTaskType.ClientID.ToString().Trim() + "," + txtEstHrs.ClientID.ToString().Trim() + "," + txtEstCost.ClientID.ToString().Trim() + "," + txtEstLabourHrs.ClientID.ToString().Trim() + ");");
            ddlTask.Attributes.Add("OnChange", "javascript:OnTaskDescChange(" + e.Row.RowIndex + "," + ddlTask.ClientID.ToString().Trim() + "," + ddlTaskType.ClientID.ToString().Trim() + "," + txtEstHrs.ClientID.ToString().Trim() + "," + txtEstCost.ClientID.ToString().Trim() + "," + txtEstLabourHrs.ClientID.ToString().Trim() + ");");

            txtEstHrs.Attributes.Add("OnBlur", "javascript:OnEstHrsCalculate(this," + txtEstCost.ClientID.ToString().Trim() + "," + txtEstLabourHrs.ClientID.ToString().Trim() + ");");
            ///ddl_Driver2.Attributes.Add("OnChange", "javascript:GetDriver2Details(this," + LblDriver2Name.ClientID.ToString() + "," + lblLicnoD2.ClientID.ToString() + "," + lblValidDtD2.ClientID.ToString() + ");");
        }
    }
    //protected void txtQty_TextChanged(object sender, EventArgs e)
    //{
    //    foreach (DataGridItem gridrow2 in dgSpare.Items)
    //    {
    //        int mqty = 0; Double mcost = 0;
    //        string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
    //        string CostUnit = ((TextBox)gridrow2.FindControl("txtCostUnit")).Text.Trim();
    //        if (Qty != "")
    //        {
    //            mqty = Convert.ToInt32(Qty);
    //        }
    //        if (CostUnit != "")
    //        {
    //            mcost = Convert.ToDouble(CostUnit);
    //        }
    //        Double ToatlCost = mqty * mcost;
    //        string Cost = ((TextBox)gridrow2.FindControl("txtCost")).Text = Convert.ToString(ToatlCost);

    //    }
    //    if (gvSMTaskDet.Rows.Count != 0 && gvTaskDetails.Rows.Count != 0 && dgSpare.Items.Count != 0)
    //    {
    //        tblSubmit.Visible = true;
    //        //cmdSubmit.Visible = true;
    //    }
    //    else
    //    {
    //        //cmdSubmit.Visible = false;
    //        tblSubmit.Visible = false;
    //    }
    //}
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
            DropDownList ddlTaskType = (DropDownList)e.Item.FindControl("ddlTaskType");

            DropDownList ddlPartNo = ((DropDownList)e.Item.FindControl("ddlPartNo"));
            TextBox txtCostUnit = (TextBox)e.Item.FindControl("txtCostUnit");
            TextBox txtCost = (TextBox)e.Item.FindControl("txtCost");
            TextBox txtSpareRemark = (TextBox)e.Item.FindControl("txtSpareRemark");
            TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
            
            BindWorkGroupList(ddlWorkGroup);
            BindTaskType(ddlTaskType);
 
            ddlPartNo.DataTextField = "Description";
            ddlPartNo.DataValueField = "Part_Id";

            ddlPartNo.DataSource = ds1.Tables["Webx_Fleet_spareParthdr"];

            ddlPartNo.DataBind();
            ddlPartNo.Items.Insert(0, "");
            ddlPartNo.Attributes.Add("OnChange", "javascript:OnPartDescChange(" + e.Item.ItemIndex + "," + ddlPartNo.ClientID.ToString().Trim() + ","+ ddlTaskType.ClientID.Trim() +"," + txtCostUnit.ClientID.ToString().Trim() + "," + txtCost.ClientID.ToString() + "," + txtSpareRemark.ClientID.ToString() + ");");
            txtQty.Attributes.Add("OnBlur", "javascript:OnPartDescCalculate(" + txtQty.ClientID.ToString()  + "," + txtCostUnit.ClientID.ToString() + "," + txtCost.ClientID.ToString() + ");");
            txtCostUnit.Attributes.Add("OnBlur", "javascript:OnPartDescCalculate(" + txtQty.ClientID.ToString() + "," + txtCostUnit.ClientID.ToString() + "," + txtCost.ClientID.ToString() + ");");
            ///txtCostUnit.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtSpareRemark.ClientID.ToString() + "').focus();");
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

            datarow_Spare = ((MyFleetDataSet.JobSparePartRow)((DataRowView)e.Item.DataItem).Row);

            ((DropDownList)e.Item.FindControl("ddlPartNo")).SelectedItem.Text = datarow_Spare.PartNo;
            //((DropDownList)e.Item.FindControl("ddlPDesc")).SelectedItem.Text = datarow_Spare.PartDesc;

            ((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
            ((TextBox)e.Item.FindControl("txtCostUnit")).Text = datarow_Spare.Cost_Unit;
            ((TextBox)e.Item.FindControl("txtCost")).Text = datarow_Spare.Cost;
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
    public void BindTaskType(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindTaskType(d);
    }
    public void BindWorkGroupList(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.BindWorkGroup(d);
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

    protected void ddlWorkGroup_SelectedChanged(object sender, EventArgs e)
    {
        DropDownList ddlWorkGroup = (DropDownList)sender;
        DataGridItem item = (DataGridItem)ddlWorkGroup.Parent.Parent;
        DropDownList ddlPartNo = (DropDownList)dgSpare.Items[item.ItemIndex].FindControl("ddlPartNo");
        DropDownList ddlTaskType = (DropDownList)dgSpare.Items[item.ItemIndex].FindControl("ddlTaskType");
        BindPartDesc(ddlPartNo, ddlWorkGroup.SelectedValue);
        //BindTaskType(ddlTaskType);
    }
    public void BindPartDesc(DropDownList d,string strWGRPDC)
    {
        d.Items.Clear();
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        string strSql = "select  Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y' and W_GRPDC = " + strWGRPDC + "";
        objJs.BindDropDown(d, strSql);
    }
    //protected void txtEstCost_TextChanged(object sender, EventArgs e)
    //{
    //    Double mCost = 0;
    //    Double totCost = 0;
    //    foreach (GridViewRow gridrow in gvTaskDetails.Rows)
    //    {
    //        if (((TextBox)gridrow.FindControl("txtEstCost")).Visible == true)
    //        {
    //            string Cost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();
    //            if (Cost != "")
    //            {
    //                mCost = Convert.ToDouble(Cost);
    //            }
    //            totCost = totCost + mCost;
    //            txttotEstCost.Text = Convert.ToString(totCost);
    //            mCost = 0;
    //        }
    //    }
    //}

    //protected void txtEstHrs_TextChanged(object sender, EventArgs e)
    //{
    //    Double mHrs = 0;
    //    Double totHrs = 0;
    //    foreach (GridViewRow gridrow in gvTaskDetails.Rows)
    //    {
    //        if (((TextBox)gridrow.FindControl("txtEstHrs")).Visible == true)
    //        {
    //            string Hrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();

    //            if (Hrs != "")
    //            {
    //                mHrs = Convert.ToDouble(Hrs);
    //            }
    //            totHrs = totHrs + mHrs;
    //            txttotEstHrs.Text = Convert.ToString(totHrs);
    //            mHrs = 0;
    //        }
    //    }
    //}


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
        if (dgSpare.Items.Count != 0)
        {
            tblSubmit.Visible = true;
            //cmdSubmit.Visible = true;
        }
        else
        {
            //cmdSubmit.Visible = false;
            tblSubmit.Visible = false;
        }
    }
    public void BindSpareGrid()
    {
        dgSpare.DataSource = _dataSet.JobSparePart;
        dgSpare.DataBind();
        _lastEditedPage = dgSpare.CurrentPageIndex;
    }
    protected void ddlOrderType_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlOrderType.SelectedIndex == 0)
        {
            rowTaskDet.Visible = false;
            rowSparePart.Visible = false;
            //rowSMTask.Visible = false;
            rowSMTaskbtn.Visible = false;
            rowManualTaskbtn.Visible = false;
        }
        else if (ddlOrderType.SelectedValue == "06")
        {
            rowTaskDet.Visible = false;
            rowSparePart.Visible = false;
            //rowSMTask.Visible = true;
            rowSMTaskbtn.Visible = false;
            rowManualTaskbtn.Visible = true;
            //rowSMTaskbtn.Visible = true;
            //btnAddSMTask_Click(sender, e)
            //rowSMTask.Visible = true;
        }
        else
        {
            rowTaskDet.Visible = true;
            rowSparePart.Visible = true;
            //rowSMTask.Visible = false;
            rowSMTaskbtn.Visible = true;
            rowManualTaskbtn.Visible = false;
        }
    }
    protected void btnAddManualTask_Click(object sender, EventArgs e)
    {
        rowTaskDet.Visible = true;
        rowManualTaskbtn.Visible = false;
        rowSparePart.Visible = true;
    }
    protected void btnAddSMTask_Click(object sender, EventArgs e)
    {
        //tblSMTaskDet.Visible = true;
        //pnlSMTaskHdr.Visible = true;

        //rowSMTaskbtn.Visible = true; 
 
        //tblSMTaskbtn.Visible = false; 
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.VehNo = txtVehicleNo.Text;
        objJs.BindGridSM(gvSMTaskDet);

        if (gvSMTaskDet.Rows.Count != 0 && gvTaskDetails.Rows.Count != 0 && dgSpare.Items.Count != 0)
        {
            tblSubmit.Visible = true;
            //cmdSubmit.Visible = true;
        }
        else
        {
            //cmdSubmit.Visible = false;
            tblSubmit.Visible = false;
        }

        if (gvSMTaskDet.Rows.Count > 0)
        {
            lblSMTaskErr.Text = "";
            rowSMTaskbtn.Visible = false;
            rowSMTask.Visible = true;
            //rowSMTaskbtn.Visible = true;
            //tblSMTaskDet.Visible = true;
            //pnlSMTaskHdr.Visible = false;
        }
        else
        {
            lblSMTaskErr.Text = "No Schedule Maintenance Task is due for this Vehicle.";
            rowSMTaskbtn.Visible = true;
            rowSMTask.Visible = false;
            //rowSMTaskbtn.Visible = false;
            //tblSMTaskDet.Visible = true;
            //pnlSMTaskHdr.Visible = true;
        }
    }
    protected void gvSMTaskDet_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtEstHrs = (TextBox)e.Row.FindControl("txtEstHrs");
            TextBox txtEstCost = (TextBox)e.Row.FindControl("txtEstCost");
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            chkSelect.Attributes.Add("OnClick", "javascript:OnSelectSM(this)");
            txtEstCost.Text = Convert.ToString(Convert.ToDecimal(txtEstHrs.Text) * Convert.ToDecimal(txtEstLabourHrs.Text));
        }
    }

    
}
