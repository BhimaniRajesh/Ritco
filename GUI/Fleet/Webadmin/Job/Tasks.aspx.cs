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

        lblMsg.Text = "";
        lblMsg.Visible = false;
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

    


    //public void addVehCategory()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    string str = "usp_Job_AddCategoty";
    //    SqlCommand cmd = new SqlCommand(str, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;

    //    cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "C";
    //    cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = "";


    //    SqlDataReader dr = cmd.ExecuteReader();

    //    // ddlVehCategory.Items.Clear();
    //    ddlVehCategory.Items.Insert(0, "");
    //   // ddlVehCategory.Items.Add(new ListItem("Select", ""));
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            ddlVehCategory.Items.Add(new ListItem(dr["type_Name"].ToString(), dr["type_code"].ToString()));

    //        }
    //    }

    //    dr.Close();

    //    conn.Close();

    //}




    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_TaskList";

        SqlCommand sqlcmd = new SqlCommand(str,conn);
 
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        sqlcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedItem.Value;
        sqlcmd.Parameters.Add("@G_TASKCD", SqlDbType.VarChar).Value = "0";                   
              
        DataSet ds = new DataSet();
        da.Fill(ds);

        dgTask.DataSource = ds;
        dgTask.DataBind();

        conn.Close();



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

            string STR11 = "select *  from WEBX_FLEET_TASKMST where W_GRPCD ='" + Session["w_grpcd"].ToString().Trim() + "'  ";

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

        BindGrid1();



      


        conn.Close();
        int m = 0;
      
 
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
            BindGrid1();




        }
        int count = 0;
        foreach (DataGridItem gridrow in dgAddTask.Items)
        {
            count = count + 1;
        }
        txtRow.Text = count.ToString();




    }

     

    public void BindGrid1()
    {

        DataGrid1.Visible = false;
        dgAddTask.Visible = true;
        dgAddTask.DataSource = _dataSet.AddTasks;
        dgAddTask.DataBind();
        _lastEditedPage = dgAddTask.CurrentPageIndex;

        if (dgAddTask.Items.Count != 0 )
        {
            cmdSubmit.Visible = true;

        }
        else
        {
            cmdSubmit.Visible = false;
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



    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        

      

          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            bool success = false;
            SqlTransaction trans;

            trans = conn.BeginTransaction();
            try
            {

                

            string STR = "delete  from WEBX_FLEET_TASKMST  where  w_grpcd=" + Session["w_grpcd"].ToString().Trim() + "";
            SqlCommand mcmd = new SqlCommand(STR, conn, trans);
            mcmd.ExecuteNonQuery();
      
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

            string sql = "usp_Job_AddTaskInsertUpdate";
            SqlCommand cmd = new SqlCommand(sql, conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = Session["w_grpcd"].ToString().Trim();
            cmd.Parameters.Add("@TaskDesc", SqlDbType.VarChar).Value = Desc;

            cmd.Parameters.Add("@TaskTypecd", SqlDbType.VarChar).Value = tasktype_code;


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
     
      //  _dataSet.AddTasks.Clear();
    //    BindGrid1();
        lblMsg.Visible = true;

        lblMsg.Text="Tasks Are Successfully Added for  workgroup  "+ Session["w_grpcd"].ToString().Trim() ;

        table1.Visible = false;
    }


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



    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
         
        string Keys = "";
        string mDesc = "";

        if (((Control)e.CommandSource).ID == "AddTask")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            Keys = dgTask.DataKeys[thisRow].Values[0].ToString();
            Keys = Keys.Trim().ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string STR = "select w_grpDesc  from webx_fleet_workgroup  where w_Grpcd=" + Keys.Trim() + "";
            SqlCommand cmd1 = new SqlCommand(STR, conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            if (dr1.HasRows)
            {
                while (dr1.Read())
                {
                    mDesc = Convert.ToString(dr1["w_grpDesc"]);


                }


            }
            dr1.Close();

          //  conn.Close();

            lblHeader.Text = "Add Task For Workgroup " + mDesc;
            table1.Visible = true;
            Session["w_grpcd"] = null;
            Session["w_grpcd"] = Keys;

            _dataSet.AddTasks.Clear();

            int count = 0;
            string str = "usp_Job_ViewTaskList";

            SqlCommand sqlcmd = new SqlCommand(str, conn);


            sqlcmd.CommandType = CommandType.StoredProcedure;

            sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = Session["w_grpcd"].ToString().Trim();


            SqlDataReader mdr1 = sqlcmd.ExecuteReader();
            if (mdr1.HasRows)
            {
                while (mdr1.Read())
                {
                    count = count + 1;

                    string desc = Convert.ToString(mdr1["taskdesc"]);
                    string tasktype = Convert.ToString(mdr1["task_type"]);
                    _dataSet.AddTasks.AddAddTasksRow(desc, tasktype);
                }

            }
            mdr1.Close();
            conn.Close();
            BindGrid1();
            table2.Visible = true;
            int mcount = 0;
            foreach (DataGridItem gridrow in dgAddTask.Items)
            {
                mcount = mcount + 1;
            }
            txtRow.Text = mcount.ToString();


        }


        if (((Control)e.CommandSource).ID == "ViewTask")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            Keys = dgTask.DataKeys[thisRow].Values[0].ToString();
            Keys = Keys.Trim().ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string STR = "select w_grpDesc  from webx_fleet_workgroup  where w_Grpcd=" + Keys.Trim() + "";
            SqlCommand cmd1 = new SqlCommand(STR, conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            if (dr1.HasRows)
            {
                while (dr1.Read())
                {
                    mDesc = Convert.ToString(dr1["w_grpDesc"]);


                }


            }
            dr1.Close();

         //   conn.Close();

            lblHeader.Text = "View Task For Workgroup " + mDesc;
            Session["w_grpcd"] = null;
            Session["w_grpcd"] = Keys;

            string str = "usp_Job_ViewTaskList";

            SqlCommand sqlcmd = new SqlCommand(str, conn);


            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = Session["w_grpcd"].ToString().Trim();


            DataSet ds = new DataSet();
            da.Fill(ds);

            table1.Visible = true;

            table2.Visible = false;
            dgAddTask.Visible = false;
            DataGrid1.Visible = true;
            DataGrid1.DataSource = ds;
            DataGrid1.DataBind();
            cmdSubmit.Visible = false;
            conn.Close();

 
        }
 

    }




}
