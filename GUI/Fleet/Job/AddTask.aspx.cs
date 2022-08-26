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


public partial class GUI_Job_AddTask : System.Web.UI.Page
{


    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.AddTasksRow datarow_ATask;

    string w_grpcd = "",mDesc=""; int mDataCount = 0;  

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

       w_grpcd=   Request.QueryString["id"];

       Session["w_grpcd"] = null;

       Session["w_grpcd"] = w_grpcd.ToString().Trim();

       SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       conn.Open();


       string STR = "select w_grpDesc  from webx_fleet_workgroup  where w_Grpcd='" + w_grpcd.Trim() + "'";
       SqlCommand cmd1 = new SqlCommand(STR,conn);
       SqlDataReader dr1 = cmd1.ExecuteReader();
       if (dr1.HasRows)
       {
           while (dr1.Read())
           {
               mDesc = Convert.ToString(dr1["w_grpDesc"]);


           }


       }
       dr1.Close();

       conn.Close();

       lblHeader.Text = "Add Task For Workgroup " + mDesc;

        if (!IsPostBack)
        {


            if (mDataCount == 0)
            {
                //mDataCount = mDataCount + 1;
                //Inetialized_AdvanceTaken();
                BindGrid();
            }
            txtRow.Text = mDataCount.ToString();
            Previous_Task();

        }


    }

    protected void dgAddTask_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {


            _dataSet.AddTasks.RemoveAddTasksRow(_dataSet.AddTasks[e.Item.DataSetIndex]);
            if (((dgAddTask.PageCount - dgAddTask.CurrentPageIndex) == 1 & dgAddTask.Items.Count == 1))
            {
                if ((dgAddTask.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            dgAddTask.CurrentPageIndex = _lastEditedPage;
            BindGrid();




        }
        int count = 0;
        foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            count = count + 1;
        }
        txtRow.Text = count.ToString();




    }

    public void Previous_Task()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        int count = 0;
        string str = "usp_Job_ViewTaskList";

        SqlCommand sqlcmd = new SqlCommand(str, conn);


        sqlcmd.CommandType = CommandType.StoredProcedure;

        sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = w_grpcd.ToString().Trim();


        SqlDataReader dr1 = sqlcmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                count = count + 1;

                string desc = Convert.ToString(dr1["taskdesc"]);
                string tasktype = Convert.ToString(dr1["task_type"]);






                _dataSet.AddTasks.AddAddTasksRow(desc, tasktype);



            }

        }
        dr1.Close();
        conn.Close();
        BindGrid();

        int mcount = 0;
        foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            mcount = mcount + 1;
        }
        txtRow.Text = mcount.ToString();

       


    }



    protected void txtRow_TextChanged(object sender, EventArgs e)
    {

 

        string rowno;
        int mroww = 0;
        int miroww = 0;
        int count = 0;
        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;
        //   mroww = mroww + 1;

        int iroww = 0;



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // New Change

        foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            iroww = iroww + 1;
        }

        
        if (iroww >= 0)
        {

            int tmp = 0;

            conn.Open();

            string STR11 = "select *  from WEBX_FLEET_TASK where W_GRPCD ='" + Session["w_grpcd"].ToString().Trim() + "'  ";

            SqlCommand STRcd = new SqlCommand(STR11, conn);
            SqlDataReader drSTR = STRcd.ExecuteReader();
            if (drSTR.HasRows)
            {
                while (drSTR.Read())
                {
                    count = count + 1;

                }
            }
            drSTR.Close();


            int counter = 0;


        }



        if (dgAddTask.Items.Count == 0)
        {

            for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
            {
                _dataSet.AddTasks.AddAddTasksRow("", "");
            }

        }
        else
        {
        
            int count1 = 0;

            if (iroww > count)
            {
                int j = 0;

                int t = iroww;

                foreach (DataGridItem gridrow in dgAddTask.Items)
                {

                    if (t > count)
                    {
                        t = t - 1;

                        _dataSet.AddTasks.RemoveAddTasksRow(_dataSet.AddTasks[t]);

                    }

                }

            }


            for (i = 0; i < Int16.Parse(txtRow.Text); i++)
            {
                _dataSet.AddTasks.AddAddTasksRow("", "");
            }


        }

        BindGrid();



        if (dgAddTask.Items.Count != 0)
        {
            btnSubmit.Visible = true;

        }
        else
        {
            btnSubmit.Visible = false;
        }
       

        conn.Close();
        int m = 0;
        /*

        foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            
            if (m < count)
            {
              
                ((TextBox)gridrow.FindControl("txtDesc")).ReadOnly = true;
                ((Label)gridrow.FindControl("lblTaskType")).Visible = true;
                        ((DropDownList)gridrow.FindControl("ddlTaskType")).Visible = false;
              
                 
                m = m + 1;
            }

            else
            {
                 ((TextBox)gridrow.FindControl("txtDesc")).ReadOnly = false;
                ((Label)gridrow.FindControl("lblTaskType")).Visible = false;
                 ((DropDownList)gridrow.FindControl("ddlTaskType")).Visible = true;
              
           
            }

        }


        */





    }
    
    public void BindGrid()
    {
        dgAddTask.DataSource = _dataSet.AddTasks;
        dgAddTask.DataBind();
        _lastEditedPage = dgAddTask.CurrentPageIndex;



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
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        if (dgAddTask.Items.Count != 0)
        {

            string STR = "delete  from WEBX_FLEET_TASK  where  w_grpcd='" + Session["w_grpcd"].ToString().Trim() + "'";
            SqlCommand mcmd = new SqlCommand(STR, conn);
            mcmd.ExecuteNonQuery();
        }
          foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            string TaskType = "";
            string Desc = ((TextBox)gridrow.FindControl("txtDesc")).Text.Trim();


            if (((Label)gridrow.FindControl("lblTaskType")).Visible == true)
            {

                 TaskType = ((Label)gridrow.FindControl("lblTaskType")).Text.Trim();
            }
            else
            {
                   TaskType = ((DropDownList)gridrow.FindControl("ddlTaskType")).SelectedItem.Text.Trim();
            }

        

            



           string tasktype_code = "";
           string str = "  select  codeid  from WEbX_MASTER_general   where  codetype='FTASK'  and codedesc='" + TaskType.Trim() + "'";
           SqlCommand cmd1 = new SqlCommand(str, conn);
           SqlDataReader dr = cmd1.ExecuteReader();
           if (dr.HasRows)
           {
               while (dr.Read())
               {

                   tasktype_code = Convert.ToString(dr[0]);
               }

           }


           dr.Close();

              
                        
            string sql = "usp_Job_AddTaskInsertUpdate";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;
                                    
            cmd.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = w_grpcd;
            cmd.Parameters.Add("@TaskDesc", SqlDbType.VarChar).Value = Desc;

            cmd.Parameters.Add("@TaskTypecd", SqlDbType.VarChar).Value = tasktype_code;
                                               
           
            cmd.ExecuteNonQuery();
        }
        
        conn.Close();

        Response.Redirect("Workgrp.aspx");


    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
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

            //((DropDownList)e.Item.FindControl("cboAdvPlace")).SelectedValue = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_ATask.Desc;


            ((Label)e.Item.FindControl("lblTaskType")).Text = datarow_ATask.TaskType;
            ((DropDownList)e.Item.FindControl("ddlTaskType")).SelectedItem.Text = datarow_ATask.TaskType;


        }


    }


}
