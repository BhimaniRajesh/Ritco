using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using ApplicationManager;

public partial class GUI_Job_Taskdet : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    bool success = false;
    //MyFleetDataSet.WorkGroupRow datarow_Wgrp;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetRow datarow_Wgrp;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable dt_WorkGroup = new MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable();
    //MyFleetDataSet.Work_GroupDataTable dt_WorkGroup = new MyFleetDataSet.Work_GroupDataTable();

    public void BindVehicleModel(CheckBoxList cb,string strId)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string strVehModel = "USP_Fill_Vehicle_Model";
        SqlCommand cmd = new SqlCommand(strVehModel, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = strId;   
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        chklstVehicleModel.DataSource = ds;
        
        chklstVehicleModel.DataTextField = "TYPE_NAME";
        chklstVehicleModel.DataValueField = "TYPE_CODE";

        chklstVehicleModel.DataBind();
    }
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

        _dataSet.WorkGroup.Clear();

        if (!IsPostBack)
        {
            txtRow.Text = "0";
            if (Request.QueryString["id"] != null)
            {
                BindVehicleModel(chklstVehicleModel, Request.QueryString["id"].ToString());
                DataTable dt = new DataTable();
                dt = GetVehicleModelEdit(Request.QueryString["id"].ToString());
                if (dt.Rows.Count > 0)
                {
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        for (int i = 0; i < chklstVehicleModel.Items.Count; i++)
                        {
                            if (dt.Rows[j]["TYPE_CODE"].ToString() == chklstVehicleModel.Items[i].Value)
                            {
                                chklstVehicleModel.Items[i].Selected = true;
                            }
                        }
                    }
                }
                GetVehicleModelEditDet(Request.QueryString["id"].ToString());
            }
            else
            {
                BindVehicleModel(chklstVehicleModel, "");
            }
        }
    }
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
    protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            //datarow_Wgrp = ((MyFleetDataSet.WorkGroupRow)((DataRowView)e.Item.DataItem).Row);
            datarow_Wgrp = ((MyFleetDataSet.Webx_Fleet_SM_Task_DetRow)((DataRowView)e.Item.DataItem).Row);

            DropDownList ddlWorkGroup_Gv = (DropDownList)e.Item.FindControl("ddlWorkGroup");
            TextBox txtDesc = (TextBox)e.Item.FindControl("txtDesc");
            DropDownList ddlTaskType = (DropDownList)e.Item.FindControl("ddlTaskType");
            DropDownList ddlUnit = (DropDownList)e.Item.FindControl("ddlUnit");
            TextBox txtServiceIDays = (TextBox)e.Item.FindControl("txtServiceIDays");
            TextBox txtServiceIKms = (TextBox)e.Item.FindControl("txtServiceIKms");
            TextBox txtAdvNoteDays = (TextBox)e.Item.FindControl("txtAdvNoteDays");
            TextBox txtAdvNoteKms = (TextBox)e.Item.FindControl("txtAdvNoteKms");

            HiddenField hfTaskId = (HiddenField)e.Item.FindControl("hfTaskId");
            TextBox txtEstHours = (TextBox)e.Item.FindControl("txtEstHours");

            //ddlWorkGroup_Gv.Attributes.Add("OnChange", "javascript:OnWorkGroupChange(" + e.Item.ItemIndex + ",this," + txtDesc.ClientID.ToString() + ");");
            
            ddlUnit.Attributes.Add("OnChange", "javascript:OnUnitChange()");

            ddlWorkGroup_Gv.Attributes.Add("OnChange", "javascript:OnWorkGrpChange(" + e.Item.ItemIndex + "," + txtDesc.ClientID.ToString() + ",this);");
            txtDesc.Attributes.Add("OnBlur", "javascript:OnDescChange(" + e.Item.ItemIndex + ",this," + ddlWorkGroup_Gv.ClientID.ToString() + ");");
            BindTaskType(ddlTaskType);
            WorkGroupList(ddlWorkGroup_Gv);

            hfTaskId.Value = datarow_Wgrp.Task_Id;
            ddlWorkGroup_Gv.SelectedValue = datarow_Wgrp.W_GRPCD;
            txtDesc.Text = datarow_Wgrp.TASKDESC;
            ddlTaskType.SelectedValue = datarow_Wgrp.TASKTYP;
            ddlUnit.SelectedValue = datarow_Wgrp.T_UOM; 
            txtServiceIDays.Text = datarow_Wgrp.SERVICE_INTERVALS_DAY;
            txtServiceIKms.Text = datarow_Wgrp.SERVICE_INTERVALS_KMS;
            txtAdvNoteDays.Text = datarow_Wgrp.ADV_NOTIFICATION_DAY;
            txtAdvNoteKms.Text = datarow_Wgrp.ADV_NOTIFACATION_KMS;
            txtEstHours.Text = datarow_Wgrp.Estimated_Hrs;

            //if (datarow_Wgrp.T_UOM.ToString().ToUpper() == "BOTH")
            //{
            //    txtServiceIDays.Visible = true;
            //    txtServiceIKms.Visible = true;
            //    txtAdvNoteDays.Visible = true;
            //    txtAdvNoteKms.Visible = true;
            //}
            //if (datarow_Wgrp.T_UOM.ToString().ToUpper() == "DAYS")
            //{
            //    txtServiceIDays.Visible = true;
            //    txtServiceIKms.Visible = false;
            //    txtAdvNoteDays.Visible = true;
            //    txtAdvNoteKms.Visible = false;
            //}
            //if (datarow_Wgrp.T_UOM.ToString().ToUpper() == "KMS")
            //{
            //    txtServiceIDays.Visible = false;
            //    txtServiceIKms.Visible = true;
            //    txtAdvNoteDays.Visible = false;
            //    txtAdvNoteKms.Visible = true;
            //}

            //if (datarow_Wgrp.T_UOM.ToString().ToUpper() == "")
            //{
            //    txtServiceIDays.Visible = false;
            //    txtServiceIKms.Visible = false;
            //    txtAdvNoteDays.Visible = false;
            //    txtAdvNoteKms.Visible = false;
            //}
        }
    }
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
        string STR = "USP_TaskTypeList";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }
        dr.Close();
        conn.Close();

    }


    protected void dgWorkgroup_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
            _dataSet.WorkGroup.RemoveWorkGroupRow(_dataSet.WorkGroup[e.Item.DataSetIndex]);
            if (((dgWorkgroup.PageCount - dgWorkgroup.CurrentPageIndex) == 1 & dgWorkgroup.Items.Count == 1))
            {
                if ((dgWorkgroup.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            dgWorkgroup.CurrentPageIndex = _lastEditedPage;
            BindGrid();
        }
        int count = 0;
        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            count = count + 1;
        }
        txtRow.Text = count.ToString();
    }
    protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
            TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
            DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
            DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
            TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
            TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
            TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
            TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms"); 

            string Unit = "";
            Unit = ddlUnit.SelectedItem.Text;
            if (Unit == "BOTH")
            {
                txtServiceIDays.Visible = true;
                txtServiceIKms.Visible = true;
                txtAdvNoteDays.Visible = true;
                txtAdvNoteKms.Visible = true;
            }
            if (Unit == "DAYS")
            {
                txtServiceIKms.Text = "";
                txtAdvNoteKms.Text = "";

                txtServiceIDays.Visible = true;
                txtServiceIKms.Visible = false;
                txtAdvNoteDays.Visible = true;
                txtAdvNoteKms.Visible = false;
            }
            if (Unit == "KMS")
            {
                txtServiceIDays.Text = "";
                txtAdvNoteDays.Text = "";
                txtServiceIDays.Visible = false;
                txtServiceIKms.Visible = true;
                txtAdvNoteDays.Visible = false;
                txtAdvNoteKms.Visible = true;
            }

            if (Unit == "")
            {
                txtServiceIDays.Text = "";
                txtAdvNoteDays.Text = "";
                txtServiceIKms.Text = "";
                txtAdvNoteKms.Text = "";

                txtServiceIDays.Visible = false;
                txtServiceIKms.Visible = false;
                txtAdvNoteDays.Visible = false;
                txtAdvNoteKms.Visible = false;
            }
        }
    }
    //protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    //{
    //    if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
    //    {
    //        DropDownList ddlWorkGroup_Gv = (DropDownList)e.Item.FindControl("ddlWorkGroup");
    //        TextBox txtDesc = (TextBox)e.Item.FindControl("txtDesc");
            
    //        DropDownList ddlTaskType = (DropDownList)e.Item.FindControl("ddlTaskType");
    //        DropDownList ddlUnit = (DropDownList)e.Item.FindControl("ddlUnit");
    //        TextBox txtServiceIDays = (TextBox)e.Item.FindControl("txtServiceIDays");
    //        TextBox txtServiceIKms = (TextBox)e.Item.FindControl("txtServiceIKms");
    //        TextBox txtAdvNoteDays = (TextBox)e.Item.FindControl("txtAdvNoteDays");
    //        TextBox txtAdvNoteKms = (TextBox)e.Item.FindControl("txtAdvNoteKms"); 

            
    //    }
    //}
    protected void txtRow_TextChanged(object sender, EventArgs e)
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
        //string script;
        //script = @"<SCRIPT language='javascript'> OnUnitChange();" + "</SCRIPT>";
        //this.RegisterStartupScript("MyAlert", script);
    }
    public void BindGrid()
    {
        dgWorkgroup.DataSource = dt_WorkGroup;// _dataSet.WorkGroup;
        dgWorkgroup.DataBind();
        _lastEditedPage = dgWorkgroup.CurrentPageIndex;

        if (dgWorkgroup.Items.Count != 0)
        {
            btnSubmit.Visible = true;

        }
        else
        {
            btnSubmit.Visible = false;
        }
    }

    private void InsertHdr()
    {
        
        string strVehicleTypeCode = "";
        for (int i = 0; i < chklstVehicleModel.Items.Count; i++)
        {
            if (chklstVehicleModel.Items[i].Selected == true)
            {
                strVehicleTypeCode = strVehicleTypeCode + chklstVehicleModel.Items[i].Value + ",";
            }
        }
        if (strVehicleTypeCode == "")
        {
            success = false;
            lblError.Text = "Select Vehicle Model.";
        }
        else
        {
            lblError.Text = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            
            SqlTransaction trans;
            trans = conn.BeginTransaction();
            try
            {
                if(Request.QueryString["id"] == null)
                {
                    string str = "USP_Insert_Webx_Fleet_SM_Task_Hdr";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@VEH_TYPE_CODE", SqlDbType.VarChar, 8000).Value = strVehicleTypeCode.ToString().Substring(0, strVehicleTypeCode.Length - 1);
                    cmd.Parameters.Add("@Entry_By", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();

                    cmd.ExecuteNonQuery();
                }
                else
                {
                    string str = "USP_Update_Webx_Fleet_SM_Task_Hdr";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@SMTask_id", SqlDbType.VarChar, 10).Value = Request.QueryString["id"].ToString();
                    cmd.Parameters.Add("@VEH_TYPE_CODE", SqlDbType.VarChar, 8000).Value = strVehicleTypeCode.ToString().Substring(0, strVehicleTypeCode.Length - 1);
                    cmd.Parameters.Add("@Entry_By", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();

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
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string WGrp = "";
        lblError.Text = "";

        string mDesc = "";
        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
            TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
            DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
            DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
            TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
            TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
            TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
            TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms"); 


            string SIDays = txtServiceIDays.Text;
            string SIKms = txtServiceIKms.Text;
            string ANDays = txtAdvNoteDays.Text;
            string ANKms = txtAdvNoteKms.Text;

            if (lblError.Text == "")
            {
                if (SIDays != "" && ANDays != "")
                {
                    Double mSIDays = 0, mANDays = 0;
                    mSIDays = Convert.ToDouble(SIDays);
                    mANDays = Convert.ToDouble(ANDays);
                    if (mANDays > mSIDays)
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
            InsertHdr();
            if (success == true)
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

                //bool success = false;
                SqlTransaction trans;

                trans = conn.BeginTransaction();
                try
                {
                    foreach (DataGridItem gridrow in dgWorkgroup.Items)
                    {
                        DropDownList ddlWorkGroup_Gv = (DropDownList)gridrow.FindControl("ddlWorkGroup");
                        TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
                        DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
                        DropDownList ddlUnit = (DropDownList)gridrow.FindControl("ddlUnit");
                        TextBox txtServiceIDays = (TextBox)gridrow.FindControl("txtServiceIDays");
                        TextBox txtServiceIKms = (TextBox)gridrow.FindControl("txtServiceIKms");
                        TextBox txtAdvNoteDays = (TextBox)gridrow.FindControl("txtAdvNoteDays");
                        TextBox txtAdvNoteKms = (TextBox)gridrow.FindControl("txtAdvNoteKms");
                        HiddenField hfTaskId  = (HiddenField)gridrow.FindControl("hfTaskId");
                        TextBox txtEstHours = (TextBox)gridrow.FindControl("txtEstHours");
                        
                        string str = "Usp_Insert_Webx_Fleet_SM_Task_Det";
                        SqlCommand cmd = new SqlCommand(str, conn, trans);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup_Gv.SelectedValue;
                        cmd.Parameters.Add("@TASKDESC", SqlDbType.VarChar).Value = txtDesc.Text.ToString().Trim();
                        cmd.Parameters.Add("@TASKTYP", SqlDbType.VarChar).Value = ddlTaskType.SelectedValue;
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
                        cmd.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
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


    
}
