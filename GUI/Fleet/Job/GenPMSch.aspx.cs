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
public partial class GUI_Fleet_Job_PMRemGen : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.WorkGroupRow datarow_Wgrp;
    string W_GRPCD = "";
    MyFleetDataSet.FinTaskRow datarow_FTask;
    string Type_Code = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
       // Session["Main"] = null;
        this.Title = pagetitle;
        lblError.Visible = false;
        lblError.Text = "";
        if (!IsPostBack)
        {

            addVehCategory();
            Session["TASKLIST"] = null;
            Session["Type_Code"] = null;
                Session["Main"] =null;
        }



        //if (Session["Main"] == null)
        //{

        //    Session["Main"] = Session["sub"];
        //}
        //else

        //{


        //      Session["Main"]=  Session["Main"].ToString()+"-"+Session["sub"].ToString();


        //}




    }


    public void addVehCategory()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_AddCategoty";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "C";
        cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = "";


        SqlDataReader dr = cmd.ExecuteReader();

        // ddlVehCategory.Items.Clear();

        ddlVehCategory.Items.Add(new ListItem("Select", "-1"));
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlVehCategory.Items.Add(new ListItem(dr["type_Name"].ToString(), dr["type_code"].ToString()));

            }
        }

        dr.Close();

        conn.Close();

    }

    //protected void txtVehNo_TextChanged(object sender, EventArgs e)
    //{


    //    if (txtVehicleNo.Text.ToString().Trim() != "")
    //    {

    //        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //        conn.Open();
    //        string STR = "select * from webx_VEHICLE_HDR where  VEHNO='" + txtVehicleNo.Text.ToString().Trim() + "'";
    //        string DataFound = "N";
    //        SqlCommand cmd = new SqlCommand(STR, conn);
    //        SqlDataReader dr = cmd.ExecuteReader();
    //        if (dr.HasRows)
    //        {
    //            while (dr.Read())
    //            {
    //                DataFound = "Y";

    //            }


    //        }
    //        dr.Close();

    //        conn.Close();
    //        if (DataFound == "N")
    //        {

    //            lblCheck.Visible = true;
    //            lblCheck.Text = "Invalid Vehicle Number!";
    //        }

    //        else
    //        {
    //            lblCheck.Text = "";
    //        }
    //    }



    //    if (lblCheck.Text == "")
    //    {
    //        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //        conn.Open();
    //        string str = "select T.* from WEBX_VEHICLE_TYPE T,WEBX_VEHICLE_HDR H where T.Type_code=H.Vehicle_Type and H.VehNO='" + txtVehicleNo.Text.Trim() + "'";
    //        SqlCommand cmd = new SqlCommand(str, conn);

    //        lblMfg.Text = "";
    //        lblModel.Text = "";
    //        lblCategory.Text = "";

    //        Type_Code = "";


    //        SqlDataReader dr1 = cmd.ExecuteReader();

    //        if (dr1.HasRows)
    //        {
    //            while (dr1.Read())
    //            {
    //                lblMfg.Text = Convert.ToString(dr1["Made_by"]);
    //                lblModel.Text = Convert.ToString(dr1["Model_No"]);
    //                lblCategory.Text = Convert.ToString(dr1["Type_Name"]);

    //                Session["Type_Code"] = Convert.ToString(dr1["Type_Code"]);


    //            }

    //        }
    //        dr1.Close();

    //        conn.Close();

    //    }


    //}



    protected void ddlVehCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str = "usp_Job_AddCategoty";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "M";
        cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = ddlVehCategory.SelectedItem.Value.ToString().Trim();
        SqlDataReader dr1 = cmd.ExecuteReader();

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                lblMfg.Text = Convert.ToString(dr1["Made_by"]);
                lblModel.Text = Convert.ToString(dr1["Model_No"]);


            }

        }
        dr1.Close();

        conn.Close();
    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string usedcode = "";
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select  distinct W_GRPCD,W_GRPCD+':'+w_GRPDESC as w_GRPDESC from WEBX_FLEET_WORKGROUP where  ACTIVE_FLAG='Y' and VEH_CAT='" + ddlVehCategory.SelectedItem.Value.Trim() + "'    order by W_GRPCD ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_FLEET_WORKGROUP");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlWorkGroup = ((DropDownList)e.Item.FindControl("ddlWorkGroup"));
          ddlWorkGroup.DataTextField = "w_GRPDESC";
          //  ddlWorkGroup.DataTextField = "W_GRPCD";
            
            ddlWorkGroup.DataValueField = "W_GRPCD"; 
            ddlWorkGroup.DataSource = ds1.Tables["WEBX_FLEET_WORKGROUP"];
            ddlWorkGroup.DataBind();
            ddlWorkGroup.Items.Insert(0, "");
 
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {


            datarow_Wgrp = ((MyFleetDataSet.WorkGroupRow)((DataRowView)e.Item.DataItem).Row);

            ((DropDownList)e.Item.FindControl("ddlWorkGroup")).SelectedItem.Text = datarow_Wgrp.W_GRPCD;
           ((Label)e.Item.FindControl("lblW_GRPCD")).Text = datarow_Wgrp.W_GRPCD;
            ((Label)e.Item.FindControl("lblDesc")).Text = datarow_Wgrp.Desc;
            ((Label)e.Item.FindControl("lblUnit")).Text = datarow_Wgrp.Unit;

            ((Label)e.Item.FindControl("lblSIDays")).Text = datarow_Wgrp.SDays;
            ((Label)e.Item.FindControl("lblSIKms")).Text = datarow_Wgrp.SKms;

            ((Label)e.Item.FindControl("lblANDays")).Text = datarow_Wgrp.ANDays;
            ((Label)e.Item.FindControl("lblANKms")).Text = datarow_Wgrp.ANKms;

        }

       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {





        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_WorkGroupList";

        SqlCommand sqlcmd = new SqlCommand(str, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        //   sqlcmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = Session["Type_Code"].ToString().Trim();
        sqlcmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = ddlVehCategory.SelectedItem.Value.Trim();
        sqlcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = "";

        SqlDataReader dr1 = sqlcmd.ExecuteReader();
        int count = 0;

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {

               // if (count < rowno)
               // {

                    string W_GRPCD = Convert.ToString(dr1["W_GRPCD"]);
                    string desc = Convert.ToString(dr1["desc1"]);
                    string unit = Convert.ToString(dr1["Unit"]);
                    string SIDays = Convert.ToString(dr1["SIDays"]);
                    string SIKms = Convert.ToString(dr1["SIKms"]);
                    string ANDays = Convert.ToString(dr1["ANDays"]);
                    string ANKms = Convert.ToString(dr1["ANKms"]);

                    _dataSet.WorkGroup.AddWorkGroupRow(W_GRPCD, desc, unit, SIDays, SIKms, ANDays, ANKms);

               // }

               // count = count + 1;


            }

        }
        dr1.Close();
        conn.Close();
        BindGrid();
        if (DataGrid1.Items.Count != 0)
        {
            cmdFinalize.Visible = true;

        }

        else
        {

            cmdFinalize.Visible = false;
        }



    }



    public void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.WorkGroup;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;



    }
   


    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();




        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            string WorkGroup = ((DropDownList)gridrow.FindControl("ddlWorkGroup")).SelectedItem.Value.Trim();
            string str = "usp_Job_WorkGroupList";
            SqlCommand sqlcmd = new SqlCommand(str, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = "";
            sqlcmd.Parameters.Add("@W_GRPCD", SqlDbType.VarChar).Value = WorkGroup.ToString().Trim();
            SqlDataReader dr1 = sqlcmd.ExecuteReader();


            if (dr1.HasRows)
            {
                while (dr1.Read())
                {

                    ((Label)gridrow.FindControl("lblW_GRPCD")).Text = Convert.ToString(dr1["W_GRPCD"]);



                    ((Label)gridrow.FindControl("lblDesc")).Text = Convert.ToString(dr1["desc1"]);
                    ((Label)gridrow.FindControl("lblUnit")).Text = Convert.ToString(dr1["Unit"]);
                    ((Label)gridrow.FindControl("lblSIDAys")).Text = Convert.ToString(dr1["SIDays"]);
                    ((Label)gridrow.FindControl("lblSIKms")).Text = Convert.ToString(dr1["SIKms"]);
                    ((Label)gridrow.FindControl("lblANDays")).Text = Convert.ToString(dr1["ANDays"]);
                    ((Label)gridrow.FindControl("lblANKms")).Text = Convert.ToString(dr1["ANKms"]);



                }
            }

            dr1.Close();


        }
        conn.Close();

    }



    protected void cmdFinalize_Click(object sender, EventArgs e)
    {

        //insert  w_grpcd,its task  into WEBX_FLEET_PM_SCH_HDR,WEBX_FLEET_PM_SCH_DET
        string PMSCH_CODE = "";

        string selvalues = "";
        string[] selvaluesArr;
        string[] selvaluesArr1;
        string[] selvaluesArr2;
        lblError.Text = "";
        string DataFound = "N";
        int mcount=0;
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            if (((CheckBox)gridrow.FindControl("chkSelect")).Checked)
            {
                mcount = mcount + 1;
            }
        }

        if (mcount==0)
        {


            lblError.Visible = true;
            lblError.Text = "Select Atleast One WorkGroup!";


        }

        else
        {
            lblError.Visible = false;
            lblError.Text = "";

        }

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

            System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

       if( lblError.Text=="")
       {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        bool success = false;
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();


        try
        {

            string msql = "usp_Job_CreatePMSCHCode";
            SqlCommand cmd4 = new SqlCommand(msql, conn, trans);
            cmd4.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr4 = cmd4.ExecuteReader();
            if (dr4.HasRows)
            {
                while (dr4.Read())
                {

                    PMSCH_CODE = Convert.ToString(dr4[0]);

                }

            }

            dr4.Close();


        
              
                string W_GRPCD = "";

                selvalues = Session["Main"].ToString();

                 selvaluesArr = selvalues.Split(new char[] { '-' });

                int maxarr = selvaluesArr.GetUpperBound(0);

                for (int i = 0; i <= maxarr; i++)
                {

                    string subArray = selvaluesArr[i].ToString().Trim();

                    selvaluesArr1 = subArray.Split(new char[] { ':' });

                    int maxarr1 = selvaluesArr1.GetUpperBound(0);
                    for (int j = 0; j <= maxarr1; j++)
                    {

                        W_GRPCD = selvaluesArr1[j].ToString().Trim();

                        string next = "";

                        if (j + 1 <= maxarr1)
                        {
                            next = selvaluesArr1[j + 1].ToString().Trim();
                        }

                       if (next != "")
                        {
                            selvaluesArr2 = next.Split(new char[] { ',' });
                            int maxarr2 = selvaluesArr2.GetUpperBound(0);
                            int count = 0;

                            foreach (DataGridItem gridrow in DataGrid1.Items)
                            {

                              if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                              {

                                    string mGroupcode = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();

                                    if (mGroupcode.Trim() == W_GRPCD.Trim())
                                  {
                           
                           
                           
                           for (int k = 0; k <= maxarr2; k++)
                            {

                                           count = count + 1;
                                            string tackcd = "";

                                            tackcd = selvaluesArr2[k].ToString().Trim();

                                            string sql2 = "usp_Job_PMSCHDetInsertUpdate";
                                            SqlCommand cmd2 = new SqlCommand(sql2, conn, trans);

                                            cmd2.CommandType = CommandType.StoredProcedure;
                                            cmd2.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = PMSCH_CODE.Trim();

                                            cmd2.Parameters.Add("@W_grpcd", SqlDbType.VarChar).Value = W_GRPCD.Trim();

                                            cmd2.Parameters.Add("@Taskcd", SqlDbType.VarChar).Value = tackcd.Trim();

                                            cmd2.ExecuteNonQuery();

                                            DataFound = "Y";
                                
                             


                            }

                       }
                    }

                }


                        }
                    }

                }




            if(DataFound=="Y")
            {
                string sql1 = "usp_Job_PMSCHHdrInsertUpdate";
                SqlCommand cmd = new SqlCommand(sql1, conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@PMSCHCD", SqlDbType.VarChar).Value = PMSCH_CODE.Trim();

                cmd.Parameters.Add("@PMSCH_Date", SqlDbType.DateTime).Value = Convert.ToDateTime(strrightnow, dtfi);

                cmd.Parameters.Add("@VEHCAT", SqlDbType.VarChar).Value = ddlVehCategory.SelectedItem.Value.Trim();



                cmd.ExecuteNonQuery();


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
          

            Response.Redirect("PMResult.aspx?PMSCH_CODE=" + PMSCH_CODE);
           // Response.Redirect("WorkgrpResult.aspx?WGrp=" + mDesc);
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

    public void BindGrid1()
    {
        GridView1.DataSource = _dataSet.FinTask;
        GridView1.DataBind();
        if (GridView1.Rows.Count != 0)
        {
            lblHeader.Text = "Task List Of WorkGroup " + Session["w_grpcd"].ToString().Trim();
            GridView1.Visible = true;
             Button1.Visible = true;

        }
        else
        {

            lblHeader.Text = "No Records Found.. ";

            GridView1.Visible = false;
           Button1.Visible = false;
        }


    }




    protected void btnSub_Click(object sender, EventArgs e)
    {
        string taskcd = "";
        string mtaskcd = "";
        string DataFoundFlag = "N";
        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
            {


                if (taskcd == "")
                {
                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                }

                else
                {
 

                    string[] selvaluesArr;
                    string[] selvaluesArr1;
                    if (Session["TASKLIST"] != null)
                    {


                    

                    }
                    else
                    {
                        taskcd = taskcd + "," + ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();

                    }

                }


            }


        }

        Session["sub"] = Session["w_grpcd"].ToString().Trim() + ":" + taskcd;




        if (Session["Main"] == null)
        {

            Session["Main"] = Session["sub"];
        }
        else
        {
            Session["Main"] = Session["Main"].ToString() + "-" + Session["sub"].ToString();

        }


        if (Session["TASKLIST"] == null)
        {
           
            Session["TASKLIST"] = taskcd + ",";

        }

        else
        {


            foreach (GridViewRow gridrow in GridView1.Rows)
            {
                if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                {
                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();

                    Session["TASKLIST"] = Session["TASKLIST"].ToString() + taskcd + ",";


                }
            }

            string[] sesion_arr = Session["TASKLIST"].ToString().Split(',');
            string session_str = Session["TASKLIST"].ToString();
            foreach (GridViewRow gridrow in GridView1.Rows)
            {

                if (((CheckBox)gridrow.FindControl("chkSelect")).Checked != true)
                {

                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                    for (int i = 0; i < sesion_arr.Length; i++)
                    {
                        if (sesion_arr[i].ToString() == taskcd)
                        {
                            string mrtaskcd = taskcd + ",";

                            Session["TASKLIST"] = session_str.Replace(mrtaskcd, "");
                        }
                    }
                    session_str = Session["TASKLIST"].ToString();
                }
                else if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                {
                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                    for (int i = 0; i < sesion_arr.Length; i++)
                    {
                        if (sesion_arr[i].ToString() == taskcd)
                        {
                            string taskcd_str = taskcd + ",";
                            Session["TASKLIST"] = session_str.Replace(taskcd_str, "");
                            Session["TASKLIST"] = Session["TASKLIST"].ToString() + taskcd + ",";
                        }


                    }
                    session_str = Session["TASKLIST"].ToString();
                }
            }
            session_str = Session["TASKLIST"].ToString();

        }


        table1.Visible = false;

        Button1.Visible = false;

    }




    protected void DataGrid1_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        string Keys = "";
        string mDesc = "";

        if (((Control)e.CommandSource).ID == "AddTask")
        {
            int thisRow = (((DataGridItem)((System.Web.UI.Control)e.CommandSource).Parent.Parent).ItemIndex);
            Keys = DataGrid1.DataKeys[thisRow].ToString().Trim();
            Keys = Keys.Trim().ToString();

            Session["w_grpcd"] = null;
            Session["w_grpcd"] = Keys;

            W_GRPCD = Session["w_grpcd"].ToString();


            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
           

          //  lblHeader.Text = "Add Task For Workgroup " + mDesc;
            table1.Visible = true;
            //Session["w_grpcd"] = null;
            //Session["w_grpcd"] = Keys;

         //   SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
           // conn.Open();

            string str = "usp_Job_ViewTaskList";

            SqlCommand sqlcmd = new SqlCommand(str, conn);


            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = Keys.ToString().Trim();
            _dataSet.FinTask.Clear();
            SqlDataReader dr = sqlcmd.ExecuteReader();

            if (dr.HasRows)
            {
                while (dr.Read())
                {


                    bool ChkSel = false;
                    string taskcd = Convert.ToString(dr["taskcd"]);
                    string DataFound = "N";

                    if (Session["TASKLIST"] != null)
                    {

                        string[] selvaluesArr;
                        string tasklist = Session["TASKLIST"].ToString().Trim();

                        selvaluesArr = tasklist.Split(new char[] { ',' });

                        int maxarr = selvaluesArr.GetUpperBound(0);

                        for (int i = 0; i <= maxarr; i++)
                        {

                            if (taskcd == selvaluesArr[i].ToString().Trim())
                            {

                                DataFound = "Y";
                            }
                        }

                    }


                    if (DataFound == "Y")
                    {
                        ChkSel = true;
                    }

                    else
                    {
                        ChkSel = false;
                    }

                    string desc = Convert.ToString(dr["TASKDESC"]);
                    string tasktype = Convert.ToString(dr["task_Type"]);

                    _dataSet.FinTask.AddFinTaskRow(ChkSel, taskcd, desc, tasktype);

                }

            }

            dr.Close();

            BindGrid1();


            if (DataGrid1.Items.Count != 0)
            {

                btnSubmit.Visible = true;
            }

            else
            {


                btnSubmit.Visible = false;

            }





        }
    }

    protected void DataGrid1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {

            datarow_FTask = ((MyFleetDataSet.FinTaskRow)((DataRowView)e.Row.DataItem).Row);

            ((CheckBox)e.Row.FindControl("chkSelect")).Checked = datarow_FTask.chkSelect;
            ((Label)e.Row.FindControl("lblTaskCd")).Text = datarow_FTask.Taskcd;

            ((Label)e.Row.FindControl("lblTaskDesc")).Text = datarow_FTask.TeakDesc;
            ((Label)e.Row.FindControl("lblTaskType")).Text = datarow_FTask.TaskType;

        }


    }


}
