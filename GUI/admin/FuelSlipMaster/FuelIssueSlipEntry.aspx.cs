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
using Microsoft.ApplicationBlocks.Data;
using ApplicationManager;

public partial class GUI_admin_FuelSlipMaster_FuelIssueSlipEntry : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    static DataTable dt = new DataTable("table1");
    DataRow drow;
    static string VendorCity;
    static string GlobalGetVendorCode;
    string UserSlipNo;
    string WithoutLastUserSlipNo;

    //string VendorCity;

    //Change1 Start
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    bool success = false;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetRow datarow_Wgrp;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable dt_WorkGroup = new MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tblGrid.Visible = false;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
            sql = "SELECT '0' AS Vendorcode, '--Select--' AS Vendorname UNION SELECT HDR.VENDORCODE, HDR.VENDORNAME +' + '+ DET.VendorCity +' + '+ HDR.VENDORCODE AS VendorName FROM webx_VENDOR_HDR HDR Inner JOIN webx_VENDOR_Det Det On HDR.VENDORCODE=Det.VENDORCODE And HDR.Vendor_Type='12'  AND HDR.Active = 'Y'";
            //sql = "SELECT HDR.VENDORCODE, HDR.VENDORNAME +' + '+ DET.VendorCity +' + '+ HDR.VENDORCODE AS VendorName FROM webx_VENDOR_HDR HDR Inner JOIN webx_VENDOR_Det Det On HDR.VENDORCODE=Det.VENDORCODE And HDR.Vendor_Type='12' ORDER BY HDR.VendorName ASC";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            ddVendorName.Items.Clear();
            txtEntryDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            fn.Fill_VehicleOpenTripsheet_Dataset();


            btnFinalSubmit.Attributes.Add("OnClick", "javascript:return CheckEmptyGrid(this)");


            //fn.Fill_VehicleMaster_Dataset(); 
            //txtVehicleNo.Attributes.Add("Onblur", "javascript:GetVehicleDetails(this);");

            while (dr.Read())
            {
                ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["VENDORCODE"].ToString()));
            }
            dr.Close();
            conn.Close();

            // ShowDCRs();
            //Change 2 Start
            //  txtRow.Text = "0";
            //if (Request.QueryString["id"] != null)
            //{
            //    BindVehicleModel(chklstVehicleModel, Request.QueryString["id"].ToString());
            //    DataTable dt = new DataTable();
            //    dt = GetVehicleModelEdit(Request.QueryString["id"].ToString());
            //    if (dt.Rows.Count > 0)
            //    {
            //        for (int j = 0; j < dt.Rows.Count; j++)
            //        {
            //            for (int i = 0; i < chklstVehicleModel.Items.Count; i++)
            //            {
            //                if (dt.Rows[j]["TYPE_CODE"].ToString() == chklstVehicleModel.Items[i].Value)
            //                {
            //                    chklstVehicleModel.Items[i].Selected = true;
            //                }
            //            }
            //        }
            //    }
            //    GetVehicleModelEditDet(Request.QueryString["id"].ToString());
            //}
            //else
            //{
            //    BindVehicleModel(chklstVehicleModel, "");
            //}

            //Change 2 End



            //GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            //int index = gvRow.RowIndex;
            //Button btnEdit = (Button)dgWorkgroup.Rows[index].FindControl("btnEdit");


            //for (int i = 0; i < dgWorkgroup.Rows.Count; i++)
            //{
            //    TextBox txtVehicleNo = (TextBox)dgWorkgroup.Rows[i].FindControl("txtVehicleNo");
            //}
            setinitrow();
        }
    }
    protected void ShowDCRs()
    {
        //tblDCR.Visible = true; 
        //string strCMD = "Exec usp_Get_Fuel_Vendor_Contract";
        //SqlDataSource1.SelectCommand = strCMD;
        //dgGeneral.DataBind(); 

        //string strCMD = "Exec usp_Get_Fuel_Vendor_City_Code_Name";
        //SqlDataSource1.SelectCommand = strCMD;
        //ddVendorName.DataBind(); 

        //SqlDataReader dr;
        //dr = sqlcmd.ExecuteReader();
        //ddVendorName.Items.Clear();  
        //while (dr.Read())
        //{
        //    ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["VENDORCODE"].ToString()));
        //}
        //dr.Close();

    }

    protected void ddVendorName_SelectedIndexChanged(object sender, EventArgs e)
    {
        GlobalGetVendorCode = ddVendorName.SelectedValue;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //conn.Open();
        //SqlCommand cmd = new SqlCommand("usp_GetVendorPhoneNo", conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@P_VendorCode", SqlDbType.VarChar).Value = GetVendorName.Trim();
        //cmd.Parameters.Add("@Vendorphone", SqlDbType.VarChar, 30);
        //cmd.Parameters["@Vendorphone"].Direction = ParameterDirection.Output;
        //cmd.ExecuteNonQuery();
        //conn.Close();


        conn.Open();
        SqlCommand cmd = new SqlCommand("usp_GetVendorPhoneNo", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@P_VendorCode", SqlDbType.VarChar).Value = GlobalGetVendorCode.Trim();
        cmd.Parameters.Add("@Vendorphone", SqlDbType.VarChar, 30);
        cmd.Parameters.Add("@VendorCity", SqlDbType.VarChar, 30);
        cmd.Parameters["@Vendorphone"].Direction = ParameterDirection.Output;
        cmd.Parameters["@VendorCity"].Direction = ParameterDirection.Output;
        cmd.ExecuteNonQuery();
        conn.Close();


        string VendorContactN = cmd.Parameters["@Vendorphone"].Value.ToString();
        VendorCity = cmd.Parameters["@VendorCity"].Value.ToString();

        //trDataGrid.Visible = false;

        if (VendorContactN != "")
        {
            lblVendorContactNo.Text = VendorContactN;
        }

        else
        {
            lblVendorContactNo.Text = "NA";
        }


        //OLD REFER THIS
        //SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn.Open();
        //SqlCommand c = new SqlCommand("", cn);
        //SqlDataAdapter d = new SqlDataAdapter(c);
        //DataSet s = new DataSet();
        //d.Fill(s);
        //ddVendorName.DataSource = s;
        //ddVendorName.DataTextField = "c1";
        //ddVendorName.DataValueField = "c1";
        //ddVendorName.DataBind();  

    }


    //protected void Redirect(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/GUI/admin/FuelSlipMaster/FuelSlipEntryView.aspx");
    //}

    //Change 3 Start
    public void GetVehicleModelEditDet(string strId)
    {
        DataTable dt = new DataTable();
        dt = BLL_Helper.GetDataTable(Session["SqlProvider"].ToString(), CommandType.Text, "select *from Webx_Fleet_SM_Task_Det Where SMTask_Id=" + strId, new SqlParameter[] { });
        foreach (DataRow mdr1 in dt.Rows)
        {
            int mSiDays = 0, mSiKms = 0, mANdays = 0, mAnKms = 0;
            string task_id = Convert.ToString(mdr1["Task_Id"]);
            string w_GRPD = Convert.ToString(mdr1["W_GRPCD"]);
            string Desc = Convert.ToString(mdr1["TASKDESC"]);
            string TASKTYP = Convert.ToString(mdr1["TASKTYP"]);
            string Unit = Convert.ToString(mdr1["T_UOM"]);
            string SiDays = "0";
            string estimated_hrs = Convert.ToString(mdr1["Estimated_Hrs"]);

            if (mdr1["SERVICE_INTERVALS_DAY"].ToString() != null)
            {
                SiDays = Convert.ToString(Convert.ToInt32(mdr1["SERVICE_INTERVALS_DAY"]));
            }
            if (SiDays == "0")
            {
                SiDays = "";
            }
            string SiKms = "0";
            if (mdr1["SERVICE_INTERVALS_KMS"].ToString() != null)
            {
                SiKms = Convert.ToString(Convert.ToInt32(mdr1["SERVICE_INTERVALS_KMS"]));
            }
            if (SiKms == "0")
            {
                SiKms = "";
            }
            string ANdays = "0";
            if (mdr1["ADV_NOTIFICATION_DAY"].ToString() != null)
            {
                ANdays = Convert.ToString(Convert.ToInt32(mdr1["ADV_NOTIFICATION_DAY"]));
            }
            if (ANdays == "0")
            {
                ANdays = "";
            }
            string AnKms = "0";
            if (mdr1["ADV_NOTIFACATION_KMS"].ToString() != null)
            {
                AnKms = Convert.ToString(Convert.ToInt32(mdr1["ADV_NOTIFACATION_KMS"]));
            }
            if (AnKms == "0")
            {
                AnKms = "";
            }
            dt_WorkGroup.AddWebx_Fleet_SM_Task_DetRow(task_id, w_GRPD, Desc, TASKTYP, Unit, SiDays, SiKms, ANdays, AnKms, estimated_hrs);
        }
        BindGrid();
    }
    //protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    //{
    //    if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
    //    {
    //        datarow_Wgrp = ((MyFleetDataSet.Webx_Fleet_SM_Task_DetRow)((DataRowView)e.Item.DataItem).Row);
    //        //DropDownList ddlWorkGroup_Gv = (DropDownList)e.Item.FindControl("ddlWorkGroup"); 
    //        DropDownList ddlUnit = (DropDownList)e.Item.FindControl("ddlUnit");
    //        TextBox txtServiceIDays = (TextBox)e.Item.FindControl("txtServiceIDays");
    //        TextBox txtServiceIKms = (TextBox)e.Item.FindControl("txtServiceIKms");
    //        TextBox txtAdvNoteDays = (TextBox)e.Item.FindControl("txtAdvNoteDays");
    //        TextBox txtAdvNoteKms = (TextBox)e.Item.FindControl("txtAdvNoteKms");
    //        HiddenField hfTaskId = (HiddenField)e.Item.FindControl("hfTaskId");
    //        TextBox txtEstHours = (TextBox)e.Item.FindControl("txtEstHours");
    //        //ddlUnit.Attributes.Add("OnChange", "javascript:OnUnitChange()");
    //        //WorkGroupList(ddlWorkGroup_Gv); 
    //        hfTaskId.Value = datarow_Wgrp.Task_Id;
    //        // ddlWorkGroup_Gv.SelectedValue = datarow_Wgrp.W_GRPCD; 
    //        //ddlUnit.SelectedValue = datarow_Wgrp.T_UOM;
    //        txtServiceIKms.Text = datarow_Wgrp.SERVICE_INTERVALS_KMS;
    //        txtAdvNoteKms.Text = datarow_Wgrp.ADV_NOTIFACATION_KMS;
    //        txtEstHours.Text = datarow_Wgrp.Estimated_Hrs;

    //        //***********************************************************************

    //        TextBox txtVehicleNo = (TextBox)e.Item.FindControl("txtVehicleNo");
    //        txtVehicleNo.Attributes.Add("Onblur", "javascript:GetTripSheetVehicleDetails(this)");

    //        Label lblVendorCity = (Label)e.Item.FindControl("lblVendorCity");
    //        lblVendorCity.Text = VendorCity;

    //        //***********************************************************************
    //    }

    //    //TextBox txtVehicleNo = (TextBox)e.Item.FindControl("txtVehicleNo");
    //    //txtVehicleNo.Attributes.Add("Onblur", "javascript:GetTripSheetVehicleDetails(this);");


    //}
    public DataTable GetVehicleModelEdit(string strId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@Id", (strId == null) ? "" : strId);
        dt = BLL_Helper.GetDataTable(Session["SqlProvider"].ToString(), CommandType.StoredProcedure, "USP_Get_Vehicle_Model_Edit", prm);
        return dt;
    }

    public void WorkGroupList(DropDownList ddl)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string str = "usp_WorkGroupList";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@GroupCode", System.Data.SqlDbType.VarChar).Value = '0';
        SqlDataReader dr = cmd.ExecuteReader();

        ddl.Items.Insert(0, "");
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddl.Items.Add(new ListItem(dr["W_GRPDESC"].ToString(), dr["W_GRPCD"].ToString()));
            }
        }

        dr.Close();

        conn.Close();

    }

    public void BindTaskType(DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "usp_SMTaskTypeList";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@TaskTypeID", SqlDbType.VarChar, 50).Value = "1";
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr["TaskType"]), Convert.ToString(dr["TaskTypeID"])));
            }
        }
        dr.Close();
        conn.Close();
    }


    protected void dgWorkgroup_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        //if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        //{
        //    _dataSet.WorkGroup.RemoveWorkGroupRow(_dataSet.WorkGroup[e.Item.DataSetIndex]);
        //    if (((dgWorkgroup.PageCount - dgWorkgroup.CurrentPageIndex) == 1 & dgWorkgroup.Items.Count == 1))
        //    {
        //        if ((dgWorkgroup.PageCount > 1))
        //        {
        //            _lastEditedPage -= 1;
        //        }
        //        else
        //        {
        //            _lastEditedPage = 0;
        //        }
        //    }
        //    dgWorkgroup.CurrentPageIndex = _lastEditedPage;
        //    BindGrid();
        //}
        //int count = 0;
        //foreach (DataGridItem gridrow in dgWorkgroup.Items)
        //{
        //    count = count + 1;
        //}
        //txtRow.Text = count.ToString();
    }


    //protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow gridrow in dgWorkgroup.Rows)
    //    {
    //        //DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
    //        //TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
    //        // DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
    //        DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
    //        TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
    //        TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
    //        TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
    //        TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms");

    //        string Unit = "";
    //        Unit = ddlUnit.SelectedItem.Text;
    //        if (Unit == "BOTH")
    //        {
    //            txtServiceIDays.Visible = true;
    //            txtServiceIKms.Visible = true;
    //            txtAdvNoteDays.Visible = true;
    //            txtAdvNoteKms.Visible = true;
    //        }
    //        if (Unit == "DAYS")
    //        {
    //            txtServiceIKms.Text = "";
    //            txtAdvNoteKms.Text = "";

    //            txtServiceIDays.Visible = true;
    //            txtServiceIKms.Visible = false;
    //            txtAdvNoteDays.Visible = true;
    //            txtAdvNoteKms.Visible = false;
    //        }
    //        if (Unit == "KMS")
    //        {
    //            txtServiceIDays.Text = "";
    //            txtAdvNoteDays.Text = "";
    //            txtServiceIDays.Visible = false;
    //            txtServiceIKms.Visible = true;
    //            txtAdvNoteDays.Visible = false;
    //            txtAdvNoteKms.Visible = true;
    //        }

    //        if (Unit == "")
    //        {
    //            txtServiceIDays.Text = "";
    //            txtAdvNoteDays.Text = "";
    //            txtServiceIKms.Text = "";
    //            txtAdvNoteKms.Text = "";

    //            txtServiceIDays.Visible = false;
    //            txtServiceIKms.Visible = false;
    //            txtAdvNoteDays.Visible = false;
    //            txtAdvNoteKms.Visible = false;
    //        }
    //    }
    //}

    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        daynamicdata();  
        //string script;
        //script = @"<SCRIPT language='javascript'> OnUnitChange();" + "</SCRIPT>";
        //this.RegisterStartupScript("MyAlert", script);
    }

    public void daynamicdata()
    {
        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";
        if (Request.QueryString["id"] != null)
        {
            GetVehicleModelEditDet(Request.QueryString["id"].ToString());
        }
        for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
        {
            dt_WorkGroup.AddWebx_Fleet_SM_Task_DetRow("", "", "", "", "", "", "", "", "", "");
        }
        //txtRow.Text = "0";
        BindGrid();
    }
    public void BindGrid()
    {
        dgWorkgroup.DataSource = dt_WorkGroup;// _dataSet.WorkGroup;
        dgWorkgroup.DataBind();
        //_lastEditedPage = dgWorkgroup.CurrentPageIndex;

        if (dgWorkgroup.Rows.Count != 0)
        {
            btnFinalSubmit.Visible = true;

        }
        else
        {
            btnFinalSubmit.Visible = false;
        }
    }

    //private void InsertHdr()
    //{

    //    string strVehicleTypeCode = "";
    //    for (int i = 0; i < chklstVehicleModel.Items.Count; i++)
    //    {
    //        if (chklstVehicleModel.Items[i].Selected == true)
    //        {
    //            strVehicleTypeCode = strVehicleTypeCode + chklstVehicleModel.Items[i].Value + ",";
    //        }
    //    }
    //    if (strVehicleTypeCode == "")
    //    {
    //        success = false;
    //        lblError.Text = "Select Vehicle Model.";
    //    }
    //    else
    //    {
    //        lblError.Text = "";
    //        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //        conn.Open();

    //        SqlTransaction trans;
    //        trans = conn.BeginTransaction();
    //        try
    //        {
    //            if(Request.QueryString["id"] == null)
    //            {
    //                string str = "USP_Insert_Webx_Fleet_SM_Task_Hdr";
    //                SqlCommand cmd = new SqlCommand(str, conn, trans);
    //                cmd.CommandType = CommandType.StoredProcedure;

    //                cmd.Parameters.Add("@VEH_TYPE_CODE", SqlDbType.VarChar, 8000).Value = strVehicleTypeCode.ToString().Substring(0, strVehicleTypeCode.Length - 1);
    //                cmd.Parameters.Add("@Entry_By", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString();

    //                cmd.ExecuteNonQuery();
    //            }
    //            else
    //            {
    //                string str = "USP_Update_Webx_Fleet_SM_Task_Hdr";
    //                SqlCommand cmd = new SqlCommand(str, conn, trans);
    //                cmd.CommandType = CommandType.StoredProcedure;
    //                cmd.Parameters.Add("@SMTask_id", SqlDbType.VarChar, 10).Value = Request.QueryString["id"].ToString();
    //                cmd.Parameters.Add("@VEH_TYPE_CODE", SqlDbType.VarChar, 8000).Value = strVehicleTypeCode.ToString().Substring(0, strVehicleTypeCode.Length - 1);
    //                cmd.Parameters.Add("@Entry_By", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString();

    //                cmd.ExecuteNonQuery();
    //            }


    //            trans.Commit();
    //            success = true;
    //        }
    //        catch (Exception e1)
    //        {
    //            Response.Write("Error" + e1.Message);
    //            trans.Rollback();
    //            Response.End();
    //        }
    //        finally
    //        {
    //            conn.Close();
    //        }
    //    }
    //}
    protected void Button1_Click(object sender, EventArgs e)
    {
        string WGrp = "";
        lblError.Text = "";

        string mDesc = "";
        foreach (GridViewRow gridrow in dgWorkgroup.Rows)
        {
            // DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
            //TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
            // DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
            DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
            TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
            TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
            TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
            TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms");



            string SIKms = txtServiceIKms.Text;
            string ANDays = txtAdvNoteDays.Text;
            string ANKms = txtAdvNoteKms.Text;

            if (lblError.Text == "")
            {

            }
            if (lblError.Text == "")
            {
                if (SIKms != "" && ANKms != "")
                {
                    int mSIKms = 0, mANKms = 0;
                    mSIKms = Convert.ToInt32(SIKms);
                    mANKms = Convert.ToInt32(ANKms);
                    if (mANKms > mSIKms)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance Notification must be less than Service Interval ! ";
                    }
                    else
                    {
                        lblError.Visible = false;
                        lblError.Text = "";
                    }
                }
            }
        }

        if (lblError.Text == "")
        {
            //lblError.Text = "DONE";
            //InsertHdr();
            if (success == true)
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

                //bool success = false;
                SqlTransaction trans;

                trans = conn.BeginTransaction();
                try
                {
                    foreach (DataGridItem gridrow in dgWorkgroup.Rows)
                    {
                        // DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
                        // TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
                        //DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
                        DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
                        TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
                        TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
                        TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
                        TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms");
                        HiddenField hfTaskId = (HiddenField)gridrow.FindControl("hfTaskId");
                        TextBox txtEstHours = (TextBox)gridrow.FindControl("txtEstHours");

                        string str = "Usp_Insert_Webx_Fleet_SM_Task_Det";
                        SqlCommand cmd = new SqlCommand(str, conn, trans);
                        cmd.CommandType = CommandType.StoredProcedure;

                        // cmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup_Gv.SelectedValue;
                        //cmd.Parameters.Add("@TASKDESC", SqlDbType.VarChar).Value = txtDesc.Text.ToString().Trim();
                        //  cmd.Parameters.Add("@TASKTYP", SqlDbType.VarChar).Value = ddlTaskType.SelectedValue;
                        cmd.Parameters.Add("@T_UOM", SqlDbType.VarChar).Value = ddlUnit.SelectedValue;
                        if (txtServiceIDays.Text != "" && txtServiceIDays.Text != null)
                        {
                            cmd.Parameters.Add("@SERVICE_INTERVALS_DAY", SqlDbType.Decimal).Value = Convert.ToDecimal(txtServiceIDays.Text.ToString().Trim());
                        }
                        else
                        {
                            cmd.Parameters.Add("@SERVICE_INTERVALS_DAY", SqlDbType.Decimal).Value = nullvalue;
                        }
                        if (txtServiceIKms.Text != "" && txtServiceIKms.Text != null)
                        {
                            cmd.Parameters.Add("@SERVICE_INTERVALS_KMS", SqlDbType.Decimal).Value = Convert.ToDecimal(txtServiceIKms.Text.ToString().Trim());
                        }
                        else
                        {
                            cmd.Parameters.Add("@SERVICE_INTERVALS_KMS", SqlDbType.Decimal).Value = nullvalue;
                        }
                        if (txtAdvNoteDays.Text != "" && txtAdvNoteDays.Text != null)
                        {
                            cmd.Parameters.Add("@ADV_NOTIFICATION_DAY", SqlDbType.Decimal).Value = Convert.ToDecimal(txtAdvNoteDays.Text.ToString().Trim());
                        }
                        else
                        {
                            cmd.Parameters.Add("@ADV_NOTIFICATION_DAY", SqlDbType.Decimal).Value = nullvalue;
                        }
                        if (txtAdvNoteKms.Text != "" && txtAdvNoteKms.Text != null)
                        {
                            cmd.Parameters.Add("@ADV_NOTIFACATION_KMS", SqlDbType.Decimal).Value = Convert.ToDecimal(txtAdvNoteKms.Text.ToString().Trim());
                        }
                        else
                        {
                            cmd.Parameters.Add("@ADV_NOTIFACATION_KMS", SqlDbType.Decimal).Value = nullvalue;
                        }

                        cmd.Parameters.Add("@ACTIVE_FLAG", SqlDbType.VarChar).Value = "Y";
                        cmd.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString();
                        if (Request.QueryString["id"] != null)
                        {
                            cmd.Parameters.Add("@UPDATEMODE", SqlDbType.VarChar).Value = "Update";
                            cmd.Parameters.Add("@SMTask_Id", SqlDbType.Int).Value = Convert.ToInt32(Request.QueryString["id"].ToString());
                        }
                        else
                        {
                            cmd.Parameters.Add("@UPDATEMODE", SqlDbType.VarChar).Value = "";
                            cmd.Parameters.Add("@SMTask_Id", SqlDbType.Int).Value = 0;
                        }
                        cmd.Parameters.Add("@TASK_ID", SqlDbType.Int).Value = (hfTaskId.Value == "" ? 0 : Convert.ToInt32(hfTaskId.Value));
                        cmd.Parameters.Add("@Estimated_Hrs", SqlDbType.Decimal).Value = (txtEstHours.Text == "" ? 0 : Convert.ToInt32(txtEstHours.Text));

                        cmd.ExecuteNonQuery();
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
                    Response.Redirect("SMTaskList.aspx");
                }
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //trDataGrid.Visible = true;
        tblGrid.Visible = true;
        ddVendorName.Enabled = false;
        daynamicdata();
       
    }
    protected void ddFuelType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in dgWorkgroup.Rows)
        {
            DropDownList ddFuelType = (DropDownList)gridrow.FindControl("ddFuelType");
            TextBox txtVendorRate = (TextBox)gridrow.FindControl("txtVendorRate");
            TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)gridrow.FindControl("txtamounttotal");

            string GetProduct = ddFuelType.SelectedValue;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_GetVendorRate", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = GlobalGetVendorCode.Trim();
            cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = GetProduct.Trim();
            cmd.Parameters.Add("@Rate", SqlDbType.VarChar, 30);

            cmd.Parameters["@Rate"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            conn.Close();


            string VendorRate = cmd.Parameters["@Rate"].Value.ToString();

            if (VendorRate != "")
            {
                txtVendorRate.Text = VendorRate;
            }
            if (ddFuelType.SelectedValue == "AddBlue")
            {
                txtIGST.Enabled = true;
                txtSGST.Enabled = true;
                txtCGST.Enabled = true;
            }
            else
            {
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
                txtIGST.Text = "0.00";
                txtSGST.Text = "0.00";
                txtCGST.Text = "0.00";
                txtamounttotal.Text = "0.00";
            }
        }
    }
    protected void dgWorkgroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtVehicleNo = (TextBox)e.Row.FindControl("txtVehicleNo");
            TextBox txtQtyLiter = (TextBox)e.Row.FindControl("txtQtyLiter");
            TextBox txtVendorRate = (TextBox)e.Row.FindControl("txtVendorRate");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            TextBox txtVendorCity = (TextBox)e.Row.FindControl("txtVendorCity");
            //Button btnFinalSubmit = (Button)e.Row.FindControl("btnFinalSubmit");
            TextBox txtIGST = (TextBox)e.Row.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)e.Row.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)e.Row.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)e.Row.FindControl("txtamounttotal");
            txtIGST.Enabled = false;
            txtSGST.Enabled = false;
            txtCGST.Enabled = false;
            txtIGST.Text = "0.00";
            txtSGST.Text = "0.00";
            txtCGST.Text = "0.00";
            txtamounttotal.Text = "0.00";

            txtQtyLiter.Attributes.Add("OnBlur", "javascript:CalculateBalance_FuelSlipQnty(" + e.Row.RowIndex + ");");
            txtAmount.Attributes.Add("OnBlur", "javascript:CalculateBalance_FuelSlipAmt(" + e.Row.RowIndex + ");");
            txtVehicleNo.Attributes.Add("Onblur", "javascript:GetTripSheetVehicleDetails(this)");
            txtIGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");
            txtSGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");
            txtCGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");


            Label lblVendorCity = (Label)e.Row.FindControl("lblVendorCity");
            txtVendorCity.Text = VendorCity;

            TextBox txtSlipNo = (TextBox)e.Row.FindControl("txtSlipNo");
            Label lbl_txtSlipNo_Err = (Label)e.Row.FindControl("lbl_txtSlipNo_Err");
            txtSlipNo.Attributes.Add("OnBlur", "javascript:CheckValidSlipNo(this," + lbl_txtSlipNo_Err.ClientID.ToString() + ");");

        }
    }
    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        addrow();
    }
    protected void btnFinalSubmit_Click(object sender, EventArgs e)
    {
        if (success == false)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlTransaction trans;

            trans = conn.BeginTransaction();
            try
            {
                foreach (GridViewRow gridrow in dgWorkgroup.Rows)
                {

                    int TotalCount = dgWorkgroup.Rows.Count;

                    TextBox txtVehicleNo = (TextBox)gridrow.FindControl("txtVehicleNo");
                    TextBox txtTripsheetNo = (TextBox)gridrow.FindControl("txtTripsheetNo");
                    TextBox txtTripsheetOpenDate = (TextBox)gridrow.FindControl("txtTripsheetOpenDate");
                    TextBox txtVendorCity = (TextBox)gridrow.FindControl("txtVendorCity");
                    DropDownList ddFuelType = (DropDownList)gridrow.FindControl("ddFuelType");
                    TextBox txtSlipNo = (TextBox)gridrow.FindControl("txtSlipNo");
                    TextBox txtSlipDate = (TextBox)gridrow.FindControl("txtSlipDate");
                    TextBox txtQtyLiter = (TextBox)gridrow.FindControl("txtQtyLiter");
                    TextBox txtVendorRate = (TextBox)gridrow.FindControl("txtVendorRate");
                    TextBox txtAmount = (TextBox)gridrow.FindControl("txtAmount");
                    TextBox txtRemark = (TextBox)gridrow.FindControl("txtRemark");
                    TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
                    TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
                    TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");
                    TextBox txtamounttotal = (TextBox)gridrow.FindControl("txtamounttotal");

                    if (txtIGST.Text == "") { txtIGST.Text = "0.00"; }
                    if (txtSGST.Text == "") { txtSGST.Text = "0.00"; }
                    if (txtCGST.Text == "") { txtCGST.Text = "0.00"; }
                    if (txtamounttotal.Text == "") { txtamounttotal.Text = "0.00"; }

                    string str = "Usp_FuelIssueSlipEntry_Insert";

                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    string EntryBy = Session["empcd"].ToString();
                    string UpdateBy = Session["empcd"].ToString();
                    string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

                    cmd.CommandType = CommandType.StoredProcedure;

                    string[] strDtFrom = txtEntryDate.Text.Split('/');
                    DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

                    string[] strDtTo = txtTripsheetOpenDate.Text.Split('/');
                    DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

                    string[] strDtTo1 = txtSlipDate.Text.Split('/');
                    DateTime d3 = new DateTime(Convert.ToInt16(strDtTo1[2]), Convert.ToInt16(strDtTo1[1]), Convert.ToInt16(strDtTo1[0]));

                    cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = ddVendorName.SelectedValue;
                    cmd.Parameters.Add("@SlipEntryDate", SqlDbType.VarChar).Value = d1;
                    cmd.Parameters.Add("@VendorContactNo", SqlDbType.VarChar).Value = lblVendorContactNo.Text;

                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehicleNo.Text;
                    cmd.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = txtTripsheetNo.Text;
                    cmd.Parameters.Add("@TripsheetOpenDate", SqlDbType.VarChar).Value = d2;
                    cmd.Parameters.Add("@VendorCity", SqlDbType.VarChar).Value = txtVendorCity.Text;
                    cmd.Parameters.Add("@FuelType", SqlDbType.VarChar).Value = ddFuelType.SelectedValue;
                    cmd.Parameters.Add("@SlipNo", SqlDbType.VarChar).Value = txtSlipNo.Text;
                    cmd.Parameters.Add("@SlipDate", SqlDbType.VarChar).Value = d3;
                    cmd.Parameters.Add("@QtyLiter", SqlDbType.VarChar).Value = txtQtyLiter.Text;
                    cmd.Parameters.Add("@VendorRate", SqlDbType.VarChar).Value = txtVendorRate.Text;
                    cmd.Parameters.Add("@Amount", SqlDbType.VarChar).Value = txtAmount.Text;
                    cmd.Parameters.Add("@Remark", SqlDbType.VarChar).Value = txtRemark.Text;

                    cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                    cmd.Parameters.Add("@EntryDate", SqlDbType.VarChar).Value = EntryDate;
                    cmd.Parameters.Add("@IGST", SqlDbType.Float).Value = txtIGST.Text.ToString();
                    cmd.Parameters.Add("@SGST", SqlDbType.Float).Value = txtSGST.Text.ToString();
                    cmd.Parameters.Add("@CGST", SqlDbType.Float).Value = txtCGST.Text.ToString();
                    cmd.Parameters.Add("@TotalAmount", SqlDbType.Float).Value = txtamounttotal.Text.ToString();



                    if (dgWorkgroup.Rows.Count == 1)
                    {
                        UserSlipNo = "'" + txtSlipNo.Text + "'" + ",";

                    }
                    else
                    {
                        UserSlipNo = "'" + txtSlipNo.Text + "'" + "," + UserSlipNo;

                    }
                    WithoutLastUserSlipNo = UserSlipNo.Substring(0, UserSlipNo.Length - 1);



                    //if (dgWorkgroup.Rows.Count == 1)
                    //{
                    //    UserSlipNo = "'" + txtSlipNo.Text + "'";
                    //}
                    //else
                    //{
                    //    UserSlipNo = "'" + txtSlipNo.Text + "," + UserSlipNo;
                    //    int currCount = (TotalCount - 1);
                    //    if (currCount == 0)
                    //    {
                    //        string comma = "'";
                    //        UserSlipNo = "'" + txtSlipNo.Text + "," + UserSlipNo + comma;
                    //    }
                    //}
                    //WithoutLastUserSlipNo = UserSlipNo;

                    cmd.ExecuteNonQuery();
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
                Response.Redirect("FuelIssueSlip_Result.aspx?QUserSlipNo=" + WithoutLastUserSlipNo);
            }
        }
    }
    public void setinitrow()
    {

        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("txtVehicleNo", typeof(string)));
        dt.Columns.Add(new DataColumn("txtTripsheetNo", typeof(string)));
        dt.Columns.Add(new DataColumn("txtTripsheetOpenDate", typeof(string)));
        dt.Columns.Add(new DataColumn("txtVendorCity", typeof(string)));
        dt.Columns.Add(new DataColumn("ddFuelType", typeof(string)));
        dt.Columns.Add(new DataColumn("txtSlipNo", typeof(string)));
        dt.Columns.Add(new DataColumn("txtSlipDate", typeof(string)));
        dt.Columns.Add(new DataColumn("txtVendorRate",typeof(string)));
        dt.Columns.Add(new DataColumn("txtQtyLiter", typeof(string)));
        dt.Columns.Add(new DataColumn("txtAmount", typeof(string)));
        dt.Columns.Add(new DataColumn("txtRemark", typeof(string)));
        dt.Columns.Add(new DataColumn("txtIGST", typeof(string)));
        dt.Columns.Add(new DataColumn("txtSGST", typeof(string)));
        dt.Columns.Add(new DataColumn("txtCGST", typeof(string)));
        dt.Columns.Add(new DataColumn("txtamounttotal", typeof(string)));
        dr = dt.NewRow();
        dr["txtVehicleNo"] = string.Empty;
        dr["txtTripsheetNo"] = string.Empty;
        dr["txtTripsheetOpenDate"] = string.Empty;
        dr["txtVendorCity"] = string.Empty;
        dr["ddFuelType"] = string.Empty;
        dr["txtSlipNo"] = string.Empty;
        dr["txtSlipDate"] = string.Empty;
        dr["txtVendorRate"] = string.Empty;
        dr["txtQtyLiter"] = string.Empty;
        dr["txtAmount"] = string.Empty;
        dr["txtRemark"] = string.Empty;
        dr["txtIGST"] = string.Empty;
        dr["txtSGST"] = string.Empty;
        dr["txtCGST"] = string.Empty;
        dr["txtamounttotal"] = string.Empty;
        dt.Rows.Add(dr);

        ViewState["cutrow"] = dt;

        dgWorkgroup.DataSource = dt;
        dgWorkgroup.DataBind();
    }
    public void addrow()
    {
        if (ViewState["cutrow"] != null)
        {
            DataTable cutdt = (DataTable)ViewState["cutrow"];
            DataRow cutdr = null;
            if (cutdt.Rows.Count > 0)
            {
                cutdr = cutdt.NewRow();
                cutdt.Rows.Add(cutdr);

                ViewState["cutrow"] = cutdt;
                for (int i = 0; i < cutdt.Rows.Count-1; i++)
                {
                    TextBox txtVehicleNo = (TextBox)dgWorkgroup.Rows[i].Cells[1].FindControl("txtVehicleNo");
                    TextBox txtTripsheetNo = (TextBox)dgWorkgroup.Rows[i].Cells[2].FindControl("txtTripsheetNo");
                    TextBox txtTripsheetOpenDate = (TextBox)dgWorkgroup.Rows[i].Cells[3].FindControl("txtTripsheetOpenDate");
                    TextBox txtVendorCity = (TextBox)dgWorkgroup.Rows[i].Cells[4].FindControl("txtVendorCity");
                    DropDownList ddFuelType = (DropDownList)dgWorkgroup.Rows[i].Cells[5].FindControl("ddFuelType");
                    TextBox txtSlipNo = (TextBox)dgWorkgroup.Rows[i].Cells[6].FindControl("txtSlipNo");
                    TextBox txtSlipDate = (TextBox)dgWorkgroup.Rows[i].Cells[7].FindControl("txtSlipDate");
                    TextBox txtQtyLiter = (TextBox)dgWorkgroup.Rows[i].Cells[8].FindControl("txtQtyLiter");
                    TextBox txtVendorRate = (TextBox)dgWorkgroup.Rows[i].Cells[9].FindControl("txtVendorRate");
                    TextBox txtAmount = (TextBox)dgWorkgroup.Rows[i].Cells[10].FindControl("txtAmount");
                    TextBox txtRemark = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtRemark");
                    TextBox txtIGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtIGST");
                    TextBox txtSGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtSGST");
                    TextBox txtCGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtCGST");
                    TextBox txtamounttotal = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtamounttotal");

                    cutdt.Rows[i]["txtVehicleNo"] = txtVehicleNo.Text;
                    cutdt.Rows[i]["txtTripsheetNo"] = txtTripsheetNo.Text;
                    cutdt.Rows[i]["txtTripsheetOpenDate"] = txtTripsheetOpenDate.Text;
                    cutdt.Rows[i]["txtVendorCity"] = txtVendorCity.Text;
                    cutdt.Rows[i]["ddFuelType"] = ddFuelType.SelectedValue;
                    cutdt.Rows[i]["txtSlipNo"] = txtSlipNo.Text;
                    cutdt.Rows[i]["txtSlipDate"] = txtSlipDate.Text;
                    cutdt.Rows[i]["txtQtyLiter"] = txtQtyLiter.Text;
                    cutdt.Rows[i]["txtVendorRate"] = txtVendorRate.Text;
                    cutdt.Rows[i]["txtAmount"] = txtAmount.Text;
                    cutdt.Rows[i]["txtRemark"] = txtRemark.Text;
                    cutdt.Rows[i]["txtIGST"] = txtIGST.Text;
                    cutdt.Rows[i]["txtSGST"] = txtSGST.Text;
                    cutdt.Rows[i]["txtCGST"] = txtCGST.Text;
                    cutdt.Rows[i]["txtamounttotal"] = txtamounttotal.Text;

                }
                dgWorkgroup.DataSource = cutdt;
                dgWorkgroup.DataBind();
            }
        }
        setPreviousData();
    }
    public void setPreviousData()
    {
        int row = 0;
        if (ViewState["cutrow"] != null)
        {
            DataTable cutdt = (DataTable)ViewState["cutrow"];

            if (cutdt.Rows.Count > 0)
            {
                for (int i = 0; i < cutdt.Rows.Count; i++)
                {
                    TextBox txtVehicleNo = (TextBox)dgWorkgroup.Rows[i].Cells[1].FindControl("txtVehicleNo");
                    TextBox txtTripsheetNo = (TextBox)dgWorkgroup.Rows[i].Cells[2].FindControl("txtTripsheetNo");
                    TextBox txtTripsheetOpenDate = (TextBox)dgWorkgroup.Rows[i].Cells[3].FindControl("txtTripsheetOpenDate");
                    TextBox txtVendorCity = (TextBox)dgWorkgroup.Rows[i].Cells[4].FindControl("txtVendorCity");
                    DropDownList ddFuelType = (DropDownList)dgWorkgroup.Rows[i].Cells[5].FindControl("ddFuelType");
                    TextBox txtSlipNo = (TextBox)dgWorkgroup.Rows[i].Cells[6].FindControl("txtSlipNo");
                    TextBox txtSlipDate = (TextBox)dgWorkgroup.Rows[i].Cells[7].FindControl("txtSlipDate");
                    TextBox txtQtyLiter = (TextBox)dgWorkgroup.Rows[i].Cells[8].FindControl("txtQtyLiter");
                    TextBox txtVendorRate = (TextBox)dgWorkgroup.Rows[i].Cells[9].FindControl("txtVendorRate");
                    TextBox txtAmount = (TextBox)dgWorkgroup.Rows[i].Cells[10].FindControl("txtAmount");
                    TextBox txtRemark = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtRemark");
                    TextBox txtIGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtIGST");
                    TextBox txtSGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtSGST");
                    TextBox txtCGST = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtCGST");
                    TextBox txtamounttotal = (TextBox)dgWorkgroup.Rows[i].Cells[11].FindControl("txtamounttotal");

                    if (i < cutdt.Rows.Count - 1)
                    {
                        txtVehicleNo.Text = cutdt.Rows[i]["txtVehicleNo"].ToString();
                        txtTripsheetNo.Text = cutdt.Rows[i]["txtTripsheetNo"].ToString();
                        txtTripsheetOpenDate.Text = cutdt.Rows[i]["txtTripsheetOpenDate"].ToString();
                        txtVendorCity.Text = cutdt.Rows[i]["txtVendorCity"].ToString();
                        //ddFuelType.SelectedItem.Text = cutdt.Rows[i]["ddFuelType"].ToString();
                        ddFuelType.SelectedValue = cutdt.Rows[i]["ddFuelType"].ToString();
                        txtSlipNo.Text = cutdt.Rows[i]["txtSlipNo"].ToString();
                        txtSlipDate.Text = cutdt.Rows[i]["txtSlipDate"].ToString();
                        txtQtyLiter.Text = cutdt.Rows[i]["txtQtyLiter"].ToString();
                        txtVendorRate.Text = cutdt.Rows[i]["txtVendorRate"].ToString();
                        txtAmount.Text = cutdt.Rows[i]["txtAmount"].ToString();
                        txtRemark.Text = cutdt.Rows[i]["txtRemark"].ToString();
                        txtIGST.Text = cutdt.Rows[i]["txtIGST"].ToString();
                        txtSGST.Text = cutdt.Rows[i]["txtSGST"].ToString();
                        txtCGST.Text = cutdt.Rows[i]["txtCGST"].ToString();
                        txtamounttotal.Text= cutdt.Rows[i]["txtamounttotal"].ToString();
                        // state.SelectedIndex = 1;

                    
                        //  country.SelectedIndex = 1;
                    }
                    row++;
                }
            }

        }
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        ImageButton lb = (ImageButton)sender;
        GridViewRow gvRow = (GridViewRow)lb.NamingContainer;
        int rowID = gvRow.RowIndex;
        if (ViewState["cutrow"] != null)
        {

            DataTable dt = (DataTable)ViewState["cutrow"];
            if (dt.Rows.Count > 1)
            {
                if (gvRow.RowIndex < dt.Rows.Count )
                {
                    //Remove the Selected Row data and reset row number  
                    dt.Rows.Remove(dt.Rows[rowID]);
                    ResetRowID(dt);
                }
            }

            //Store the current data in ViewState for future reference  
            ViewState["cutrow"] = dt;

            //Re bind the GridView for the updated data  
            dgWorkgroup.DataSource = dt;
            dgWorkgroup.DataBind();
        }

        //Set Previous Data on Postbacks  
        setPreviousData();
    }
    private void ResetRowID(DataTable dt)
    {
        int rowNumber = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow row in dt.Rows)
            {
                row[0] = rowNumber;
                rowNumber++;
            }
        }
    }  

}