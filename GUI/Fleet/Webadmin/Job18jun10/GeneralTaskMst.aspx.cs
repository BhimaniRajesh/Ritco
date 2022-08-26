
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
using ApplicationManager;


public partial class GeneralTaskMst : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    //MyFleetDataSet.WorkGroupRow datarow_Wgrp;
    MyFleetDataSet.WEBX_FLEET_GENERALTASKMSTRow datarow_Wgrp;
    MyFleetDataSet.WEBX_FLEET_GENERALTASKMSTDataTable dt_WorkGroup = new MyFleetDataSet.WEBX_FLEET_GENERALTASKMSTDataTable();
    //MyFleetDataSet.TaskRow datarow_Wgrp;
    //MyFleetDataSet.TaskDataTable dt_WorkGroup = new MyFleetDataSet.TaskDataTable();
    //MyFleetDataSet.Work_GroupDataTable dt_WorkGroup = new MyFleetDataSet.Work_GroupDataTable();


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
            WorkGroupList();
            //Do Work
            txtRow.Text = "0";
        }
    }

    public void WorkGroupList()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str = "usp_WorkGroupList";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@GroupCode", System.Data.SqlDbType.VarChar).Value = '0';
        SqlDataReader dr = cmd.ExecuteReader();
        ddlWorkGroup.Items.Insert(0, "");
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlWorkGroup.Items.Add(new ListItem(dr["W_GRPDESC"].ToString(), dr["W_GRPCD"].ToString()));
            }
        }
        dr.Close();
        conn.Close();
    }

    public void BindTaskType(DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "USP_General_TaskTypeList";
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





    protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds1 = new DataSet();
        string str1 = "Select [W_GRPCD],[TASKCD],[TASKDESC],[LABOUR_HRS],[ACTIVE_FLAG],[TASKTYP] From WEBX_FLEET_GENERALTASKMST Where W_GRPCD=" + ddlWorkGroup.SelectedValue.ToString().Trim();
        SqlDataAdapter da1 = new SqlDataAdapter("select   codeID ,codedesc  from WEBX_MASTER_GENERAL where  codetype='FTASK' and statuscode='Y'  order by codedesc ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_MASTER_GENERAL");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            BindTaskType((DropDownList)e.Item.FindControl("ddlTaskType"));
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Wgrp = ((MyFleetDataSet.WEBX_FLEET_GENERALTASKMSTRow)((DataRowView)e.Item.DataItem).Row);

            TextBox txtDesc = (TextBox)e.Item.FindControl("txtDesc");
            DropDownList ddlTaskType = (DropDownList)e.Item.FindControl("ddlTaskType");
            TextBox txtLabourHrs = (TextBox)e.Item.FindControl("txtLabourHrs");
            CheckBox ckh_Active_Flag = (CheckBox)e.Item.FindControl("ckh_Active_Flag");
            HiddenField hfTaskCd = (HiddenField)e.Item.FindControl("hfTaskCd");
            hfTaskCd.Value = datarow_Wgrp.TASKCD; 
            txtDesc.Text = datarow_Wgrp.TASKDESC;
            ddlTaskType.SelectedValue = datarow_Wgrp.TASKTYP;
            txtLabourHrs.Text = datarow_Wgrp.LABOUR_HRS;
            if (datarow_Wgrp.ACTIVE_FLAG == "Y")
            {
                ckh_Active_Flag.Checked = true;
            }
            else
            {
                ckh_Active_Flag.Checked = false;
            }
        }
    }
    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string str1 = "select  W_GRPCD, TASKDESC  as Desc1 , TASKTYP,T_UOM  as Unit,SERVICE_INTERVALS_DAY  as SIDays  ,SERVICE_INTERVALS_KMS  as SIKms,ADV_NOTIFICATION_DAY  as ANDays,  ADV_NOTIFACATION_KMS  as ANKms from WEBX_FLEET_TASKMST  where 1=1     and W_GRPCD=" + ddlWorkGroup.SelectedItem.Value.ToString().Trim() + "";
        string str1 = "Select [W_GRPCD],[TASKCD],[TASKDESC],[LABOUR_HRS],[ACTIVE_FLAG],[TASKTYP] From WEBX_FLEET_GENERALTASKMST Where W_GRPCD=" + ddlWorkGroup.SelectedValue.ToString().Trim();
        SqlCommand cmd1 = new SqlCommand(str1, conn);

        SqlDataReader mdr1 = cmd1.ExecuteReader();

        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                string w_GRPCD = Convert.ToString(mdr1["w_GRPCD"]);
                string TASKCD = Convert.ToString(mdr1["TASKCD"]);
                string TASKDESC = Convert.ToString(mdr1["TASKDESC"]);
                string LABOUR_HRS = Convert.ToString(mdr1["LABOUR_HRS"]);
                string ACTIVE_FLAG = Convert.ToString(mdr1["ACTIVE_FLAG"]);
                string TASKTYP = Convert.ToString(mdr1["TASKTYP"]);

                dt_WorkGroup.AddWEBX_FLEET_GENERALTASKMSTRow(w_GRPCD, TASKCD, TASKDESC, LABOUR_HRS, ACTIVE_FLAG, TASKTYP);
            }
        }
        mdr1.Close();
        conn.Close();
        BindGrid();
        int mcount = 0;
        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            mcount = mcount + 1;
        }
        txtRow.Text = mcount.ToString();
    }
    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        int TotRec = 0;
        string W_GRPCD = "";
        string TASKCD = "";
        string TASKDESC = "";
        string LABOUR_HRS = "";
        string ACTIVE_FLAG = "";
        string TASKTYP = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str1 = "Select [W_GRPCD],[TASKCD],[TASKDESC],[LABOUR_HRS],[ACTIVE_FLAG],[TASKTYP] From WEBX_FLEET_GENERALTASKMST Where W_GRPCD=" + ddlWorkGroup.SelectedValue.ToString().Trim();
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        SqlDataReader mdr1 = cmd1.ExecuteReader();
        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                TotRec = TotRec + 1;
                W_GRPCD = Convert.ToString(mdr1["W_GRPCD"]);
                if (TASKCD == "")
                {
                    TASKCD = Convert.ToString(mdr1["TASKCD"]);
                }
                else
                {
                    TASKCD = TASKCD + "," + Convert.ToString(mdr1["TASKCD"]);
                }
                if (TASKDESC == "")
                {
                    TASKDESC = Convert.ToString(mdr1["TASKDESC"]);
                }
                else
                {
                    TASKDESC = TASKDESC + "," + Convert.ToString(mdr1["TASKDESC"]);
                }
                if (LABOUR_HRS == "")
                {
                    LABOUR_HRS = Convert.ToString(mdr1["LABOUR_HRS"]);
                }
                else
                {
                    LABOUR_HRS = LABOUR_HRS + "," + Convert.ToString(mdr1["LABOUR_HRS"]);
                }
                if (ACTIVE_FLAG == "")
                {
                    ACTIVE_FLAG = Convert.ToString(mdr1["ACTIVE_FLAG"]);
                }
                else
                {
                    ACTIVE_FLAG = ACTIVE_FLAG + "," + Convert.ToString(mdr1["ACTIVE_FLAG"]);
                }
                if (TASKTYP == "")
                {
                    TASKTYP = Convert.ToString(mdr1["TASKTYP"]);
                }
                else
                {
                    TASKTYP = TASKTYP + "," + Convert.ToString(mdr1["TASKTYP"]);
                }
            }
        }

        string[] Arr_TASKCD;
        string[] Arr_TASKDESC;
        string[] Arr_LABOUR_HRS;
        string[] Arr_ACTIVE_FLAG;
        string[] Arr_TASKTYP;

        Arr_TASKCD = TASKCD.Split(new Char[] { ',' });
        Arr_TASKDESC = TASKDESC.Split(new Char[] { ',' });
        Arr_LABOUR_HRS = LABOUR_HRS.Split(new Char[] { ',' });
        Arr_ACTIVE_FLAG = ACTIVE_FLAG.Split(new Char[] { ',' });
        Arr_TASKTYP = TASKTYP.Split(new Char[] { ',' });

        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";

        for (int i = 0; i < (Convert.ToInt32(txtRow.Text) + dgWorkgroup.Items.Count) ; i++)
        {
            if (TotRec >i)
            {
                dt_WorkGroup.AddWEBX_FLEET_GENERALTASKMSTRow("", Arr_TASKCD[i], Arr_TASKDESC[i], Arr_LABOUR_HRS[i], Arr_ACTIVE_FLAG[i], Arr_TASKTYP[i]);
            }
            else
            {
                dt_WorkGroup.AddWEBX_FLEET_GENERALTASKMSTRow("", "", "", "", "", "");
            }
        }

        txtRow.Text = "0";
        BindGrid();
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string WGrp = "";
        lblError.Text = "";

        string mDesc = "";
        if (lblError.Text == "")
        {
            //lblError.Text = "DONE";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            bool success = false;
            SqlTransaction trans;
            trans = conn.BeginTransaction();
            try
            {
                foreach (DataGridItem gridrow in dgWorkgroup.Items)
                {

                    TextBox txtDesc = (TextBox)gridrow.FindControl("txtDesc");
                    DropDownList ddlTaskType = (DropDownList)gridrow.FindControl("ddlTaskType");
                    TextBox txtLabourHrs = (TextBox)gridrow.FindControl("txtLabourHrs");
                    CheckBox ckh_Active_Flag = (CheckBox)gridrow.FindControl("ckh_Active_Flag");
                    HiddenField hfTaskCd = (HiddenField)gridrow.FindControl("hfTaskCd");

                    string str = "usp_Insert_WEBX_FLEET_GENERALTASKMST";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedItem.Value;
                    cmd.Parameters.Add("@TASKCD", SqlDbType.Int).Value = (hfTaskCd.Value == "") ? 0 : Convert.ToInt32(hfTaskCd.Value);
                    cmd.Parameters.Add("@TASKDESC", SqlDbType.VarChar).Value = txtDesc.Text.ToString().Trim();
                    cmd.Parameters.Add("@LABOUR_HRS", SqlDbType.VarChar).Value = txtLabourHrs.Text.ToString().Trim();
                    cmd.Parameters.Add("@ACTIVE_FLAG", SqlDbType.VarChar).Value = (ckh_Active_Flag.Checked == true) ? "Y" : "N";
                    cmd.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    cmd.Parameters.Add("@TASKTYP", SqlDbType.VarChar).Value = ddlTaskType.SelectedValue.ToString().Trim();
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
                Response.Redirect("GeneralTaskList.aspx");
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
