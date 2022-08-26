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

public partial class GUI_Job_Tasks : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.WorkGroupRow datarow_Wgrp;
    MyFleetDataSet.AddTasksRow datarow_ATask;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        //lblMsg.Text = "";
        //lblMsg.Visible = false;
        if (!IsPostBack)
        {
            WorkGroupList();
            //Do Work


         
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str = "usp_Job_GenTaskList";
        SqlCommand sqlcmd = new SqlCommand(str, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        sqlcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedItem.Value;
        sqlcmd.Parameters.Add("@G_TASKCD", SqlDbType.VarChar).Value = "0";
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgGenTask.DataSource = ds;
        dgGenTask.DataBind();
        conn.Close();
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

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        //ddlTaskType
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select   codeID ,codedesc  from WEBX_MASTER_GENERAL where  codetype='FTASK' and statuscode='Y'  order by codedesc ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_MASTER_GENERAL");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlTaskType = ((DropDownList)e.Item.FindControl("ddlTaskType"));
            ddlTaskType.DataTextField = "Codedesc";
            ddlTaskType.DataValueField = "codeid";
            ddlTaskType.DataSource = ds1.Tables["WEBX_MASTER_GENERAL"];
            ddlTaskType.DataBind();
            ddlTaskType.Items.Insert(0, "");
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_ATask = ((MyFleetDataSet.AddTasksRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_ATask.Desc;
            ((Label)e.Item.FindControl("lblTaskType")).Text = datarow_ATask.TaskType;
            ((DropDownList)e.Item.FindControl("ddlTaskType")).SelectedItem.Text = datarow_ATask.TaskType;
        }
    }
}
