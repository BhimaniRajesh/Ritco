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



public partial class GUI_Job_Taskdet : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    //MyFleetDataSet.WorkGroupRow datarow_Wgrp;
    MyFleetDataSet.TaskRow datarow_Wgrp;
    MyFleetDataSet.TaskDataTable dt_WorkGroup = new MyFleetDataSet.TaskDataTable();
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


    //protected void dgWorkgroup_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        BindTaskType((DropDownList)e.Row.FindControl("ddlTaskType"));
    //    }
    //}


    //public void addVehCategory()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //            conn.Open();

    //    string str = "usp_Job_AddCategoty";
    //    SqlCommand cmd = new SqlCommand(str, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;

    //    cmd.Parameters.Add("@Flag",SqlDbType.VarChar).Value="C";
    //     cmd.Parameters.Add("@Category",SqlDbType.VarChar).Value="";
        

    //    SqlDataReader dr = cmd.ExecuteReader();
       
    //  // ddlVehCategory.Items.Clear();

    //   ddlVehCategory.Items.Add(new ListItem("Select", ""));
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            ddlVehCategory.Items.Add(new ListItem(dr["type_Name"].ToString(), dr["type_code"].ToString()));

    //        }
    //    }

    //    dr.Close();
        
    //   conn.Close();

    //}




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

        
        //ddlTaskType
        
        
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ////double sum = 0;
        //DataSet ds1 = new DataSet();
        //SqlDataAdapter da1 = new SqlDataAdapter("select   codeID ,codedesc  from WEBX_MASTER_GENERAL where  codetype='FTASK' and statuscode='Y'  order by codedesc ", conn);
        //conn.Close();
        //da1.Fill(ds1, "WEBX_MASTER_GENERAL");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            //DropDownList ddlTaskType = ((DropDownList)e.Item.FindControl("ddlTaskType"));
            //ddlTaskType.DataTextField = "Codedesc";
            //ddlTaskType.DataValueField = "codeid";
            //ddlTaskType.DataSource = ds1.Tables["WEBX_MASTER_GENERAL"];
            //ddlTaskType.DataBind();
            //ddlTaskType.Items.Insert(0, "");
            BindTaskType((DropDownList)e.Item.FindControl("ddlTaskType"));
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Wgrp = ((MyFleetDataSet.TaskRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_Wgrp.TaskDesc;
            ((DropDownList)e.Item.FindControl("ddlTaskType")).SelectedValue = datarow_Wgrp.TaskType;

            ((DropDownList)e.Item.FindControl("ddlUnit")).SelectedValue = datarow_Wgrp.UOM;
            ((TextBox)e.Item.FindControl("txtServiceIDays")).Text = datarow_Wgrp.SIDays;
            ((TextBox)e.Item.FindControl("txtServiceIKms")).Text = datarow_Wgrp.SIKms;
            ((TextBox)e.Item.FindControl("txtAdvNoteDays")).Text = datarow_Wgrp.ANDays;
            ((TextBox)e.Item.FindControl("txtAdvNoteKms")).Text = datarow_Wgrp.ANKms;




            string MUnit = "";
            MUnit = datarow_Wgrp.UOM;
            if (MUnit == "BOTH")
            {
                ((TextBox)e.Item.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtAdvNoteKms")).ReadOnly = false;
            }

            if (MUnit == "DAYS")
            {
                ((TextBox)e.Item.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtAdvNoteKms")).ReadOnly = true;
            }

            if (MUnit == "KMS")
            {
                ((TextBox)e.Item.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)e.Item.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtAdvNoteKms")).ReadOnly = false;
            }

            if (MUnit == "")
            {
                ((DropDownList)e.Item.FindControl("ddlUnit")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)e.Item.FindControl("txtAdvNoteKms")).ReadOnly = true;
            }



        //    ((Label)e.Item.FindControl("lblTaskType")).Text = datarow_ATask.TaskType;
        //    ((DropDownList)e.Item.FindControl("ddlTaskType")).SelectedItem.Text = datarow_ATask.TaskType;
        }


    }




    protected void ddlWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string str1 = "select  W_GRPCD, TASKDESC  as Desc1 , TASKTYP,T_UOM  as Unit,SERVICE_INTERVALS_DAY  as SIDays  ,SERVICE_INTERVALS_KMS  as SIKms,ADV_NOTIFICATION_DAY  as ANDays,  ADV_NOTIFACATION_KMS  as ANKms from WEBX_FLEET_TASKMST  where 1=1     and W_GRPCD=" + ddlWorkGroup.SelectedItem.Value.ToString().Trim() + "";
        SqlCommand cmd1 = new SqlCommand(str1, conn);

        SqlDataReader mdr1 = cmd1.ExecuteReader();

        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                int mSiDays = 0, mSiKms = 0, mANdays = 0, mAnKms = 0;



                string w_GRPD = Convert.ToString(mdr1["w_GRPCD"]);
                string Desc = Convert.ToString(mdr1["Desc1"]);
                string TASKTYP = Convert.ToString(mdr1["TASKTYP"]);
                string Unit = Convert.ToString(mdr1["Unit"]);
                string SiDays = "0";
                if (mdr1["SIDays"].ToString() != null)
               {
                   SiDays = Convert.ToString(Convert.ToInt32(mdr1["SIDays"]));
               }

                if (SiDays == "0")
                {
                    SiDays = "";
                }


                string SiKms = "0";
                if (mdr1["SIKms"].ToString() != null)
                {
                    SiKms = Convert.ToString(Convert.ToInt32(mdr1["SIKms"]));
                }

                if (SiKms == "0")
                {
                    SiKms = "";
                }


                string ANdays = "0";

                if (mdr1["ANDays"].ToString() != null)
                {
                    ANdays = Convert.ToString(Convert.ToInt32(mdr1["ANDays"]));
                }
                if (ANdays == "0")
                {
                    ANdays = "";
                }

                string AnKms = "0";
                if (mdr1["ANKms"].ToString() != null)
                {
                    AnKms = Convert.ToString(Convert.ToInt32(mdr1["ANKms"]));
                }

                if (AnKms == "0")
                {
                    AnKms = "";
                }


                dt_WorkGroup.AddTaskRow(w_GRPD, Desc, TASKTYP, Unit, SiKms, SiDays, AnKms,ANdays);
                //_dataSet.WorkGroup.AddWorkGroupRow(w_GRPD, Desc, Unit, SiDays, SiKms, ANdays, AnKms);

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


        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            string Unit = "";
            Unit = ((DropDownList)gridrow.FindControl("ddlUnit")).SelectedItem.Text.Trim();
            if (Unit == "BOTH")
            {



                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;

            }

            if (Unit == "DAYS")
            {

                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;




            }



            if (Unit == "KMS")
            {

                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;
            }

            if (Unit == "" || Unit == "null")
            {
                ((DropDownList)gridrow.FindControl("ddlUnit")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;

            }



        }








    }


    //protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    //{
    //    //ddlTaskType

    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    //double sum = 0;
    //    DataSet ds1 = new DataSet();
    //    SqlDataAdapter da1 = new SqlDataAdapter("select   codeID ,codedesc  from WEBX_MASTER_GENERAL where  codetype='FTASK' and statuscode='Y'  order by codedesc ", conn);
    //    conn.Close();
    //    da1.Fill(ds1, "WEBX_MASTER_GENERAL");

    //    if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
    //    {
    //        DropDownList ddlTaskType = ((DropDownList)e.Item.FindControl("ddlTaskType"));
    //        ddlTaskType.DataTextField = "Codedesc";
    //        ddlTaskType.DataValueField = "codeid";
    //        ddlTaskType.DataSource = ds1.Tables["WEBX_MASTER_GENERAL"];
    //        ddlTaskType.DataBind();
    //        ddlTaskType.Items.Insert(0, "");
    //    }


    //    if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
    //    {

    //        datarow_ATask = ((MyFleetDataSet.AddTasksRow)((DataRowView)e.Item.DataItem).Row);


    //        ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_ATask.Desc;


    //        ((Label)e.Item.FindControl("lblTaskType")).Text = datarow_ATask.TaskType;
    //        ((DropDownList)e.Item.FindControl("ddlTaskType")).SelectedItem.Text = datarow_ATask.TaskType;


    //    }


    //}


    protected void txtRow_TextChanged(object sender, EventArgs e)
    {

        int TotRec = 0;
        string w_GRPD = "";
        string Desc = "";
        string TASKTYP = "";
        string Unit = "";
        string m_Unit = "";

        string SiDays = "";
        string SIKms = "";

        string ANDays = "";
        string ANKms = "";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str1 = "select  W_GRPCD, TASKDESC  as Desc1 , TASKTYP,T_UOM  as Unit,SERVICE_INTERVALS_DAY  as SIDays  ,SERVICE_INTERVALS_KMS  as SIKms,ADV_NOTIFICATION_DAY  as ANDays,  ADV_NOTIFACATION_KMS  as ANKms from WEBX_FLEET_TASKMST  where 1=1     and W_GRPCD=" + ddlWorkGroup.SelectedItem.Value.ToString().Trim() + "";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        SqlDataReader mdr1 = cmd1.ExecuteReader();
        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                 TotRec = TotRec + 1;
                w_GRPD = Convert.ToString(mdr1["w_GRPCD"]);

                if (Desc == "")
                {
                    Desc = Convert.ToString(mdr1["Desc1"]);
                }
                else
                {
                    Desc = Desc+ "," + Convert.ToString(mdr1["Desc1"]);
                }

                //Desc = Convert.ToString(mdr1["Desc1"]);
                //TASKTYP = Convert.ToString(mdr1["TASKTYP"]);
                if (TASKTYP == "")
                {
                    TASKTYP = Convert.ToString(mdr1["TASKTYP"]);
                }
                else
                {
                    TASKTYP = TASKTYP + "," + Convert.ToString(mdr1["TASKTYP"]);
                }



                Unit = Convert.ToString(mdr1["Unit"]);

                if (m_Unit == "")
                {
                    if (Convert.ToString(mdr1["Unit"]) == null || Convert.ToString(mdr1["Unit"]) =="")
                    {
                        m_Unit = ",";
                    }
                    else
                    {
                        m_Unit = Convert.ToString(mdr1["Unit"]);
                    }
                }
                else
                {
                    m_Unit = m_Unit + "," + Convert.ToString(mdr1["Unit"]);
                }

                Unit = m_Unit;
                //SiDays = "0";
                //if (mdr1["SIDays"].ToString() != null)
               // {
                //    SiDays = Convert.ToString(Convert.ToInt32(mdr1["SIDays"]));

               // }

                if (SiDays == "")
                {
                    if (mdr1["SIDays"].ToString() != null)
                    {
                        SiDays = Convert.ToString(Convert.ToInt32(mdr1["SIDays"]));
                    }
                    else
                    {
                        SiDays = " ";
                    }
                }
                else
                {
                    if (mdr1["SIDays"].ToString() != null)
                    {
                        SiDays = SiDays + "," + Convert.ToString(Convert.ToInt32(mdr1["SIDays"]));
                    }
                    else
                    {
                        SiDays = SiDays + "," + " ";
                    }
                }




                //if (SiDays == "0")
                //{
                //    SiDays = "";
               // }


                //SiKms = "0";
                //if (mdr1["SIKms"].ToString() != null)
               // {
                //    SiKms = Convert.ToString(Convert.ToInt32(mdr1["SIKms"]));
               // }




                if (SIKms == "")
                {
                    if (mdr1["SIKms"].ToString() != null)
                    {
                        SIKms = Convert.ToString(Convert.ToInt32(mdr1["SIKms"]));
                    }
                    else
                    {
                        SIKms = " ";
                    }
                }
                else
                {
                    if (mdr1["SIKms"].ToString() != null)
                    {
                        SIKms = SIKms + "," + Convert.ToString(Convert.ToInt32(mdr1["SIKms"]));
                    }
                    else
                    {
                        SIKms = SIKms + "," + " ";
                    }
                }



                //if (SiKms == "0")
                //{
                //    SiKms = "";
               // }


                //ANdays = "0";

                //if (mdr1["ANDays"].ToString() != null)
               // {
                //    ANdays = Convert.ToString(Convert.ToInt32(mdr1["ANDays"]));
               // }
                //if (ANdays == "0")
                //{
                //    ANdays = "";
               // }


                if (ANDays == "")
                {
                    if (mdr1["ANDays"].ToString() != null)
                    {
                        ANDays = Convert.ToString(Convert.ToInt32(mdr1["ANDays"]));
                    }
                    else
                    {
                        ANDays = " ";
                    }
                }
                else
                {
                    if (mdr1["ANDays"].ToString() != null)
                    {
                        ANDays = ANDays + "," + Convert.ToString(Convert.ToInt32(mdr1["ANDays"]));
                    }
                    else
                    {
                        ANDays = ANDays + "," + " ";
                    }
                }




                //AnKms = "0";
               // if (mdr1["ANKms"].ToString() != null)
               // {
               //     AnKms = Convert.ToString(Convert.ToInt32(mdr1["ANKms"]));
               // }



                if (ANKms == "")
                {
                    if (mdr1["ANKms"].ToString() != null)
                    {
                        ANKms = Convert.ToString(Convert.ToInt32(mdr1["ANKms"]));
                    }
                    else
                    {
                        ANKms = " ";
                    }
                }
                else
                {
                    if (mdr1["ANKms"].ToString() != null)
                    {
                        ANKms = ANKms + "," + Convert.ToString(Convert.ToInt32(mdr1["ANKms"]));
                    }
                    else
                    {
                        ANKms = ANKms + "," + " ";
                    }
                }


                //if (AnKms == "0")
               // {
                //    AnKms = "";
               // }




            }
        }

        //string[] Arr_CaseOrders;
        //Arr_CaseOrders = TempOrderNo.Split(new Char[] { ',' });
        //Arr_CaseOrders[x2];

        string[] Arr_Desc ;
        string[] Arr_TASKTYP ;
        string[] Arr_Unit;
        string[] Arr_SiDays;
        string[] Arr_SiKms;
        string[] Arr_ANdays;
        string[] Arr_AnKms;

        Arr_Desc = Desc.Split(new Char[] { ',' });
        Arr_TASKTYP = TASKTYP.Split(new Char[] { ',' });
        Arr_Unit = Unit.Split(new Char[] { ',' });
        Arr_SiDays = SiDays.Split(new Char[] { ',' });
        Arr_SiKms = SIKms.Split(new Char[] { ',' });
        Arr_ANdays = ANDays.Split(new Char[] { ',' });
        Arr_AnKms = ANKms.Split(new Char[] { ',' });


        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";

        for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
        {
            if (TotRec >i)
            {
                dt_WorkGroup.AddTaskRow("", Arr_Desc[i], Arr_TASKTYP[i], Arr_Unit[i], Arr_SiKms[i], Arr_SiDays[i], Arr_AnKms[i], Arr_ANdays[i]);
                //dt_WorkGroup.AddTaskRow(w_GRPD, Desc, TASKTYP, Unit, SiKms, SiDays, AnKms, ANdays);

            }
            else
            {
                dt_WorkGroup.AddTaskRow("", "", "", "", "", "", "", "");
            }


        }




        //foreach (DataGridItem gridrow in dgWorkgroup.Items)
        //{
        //    string MUnit = "";
        //    MUnit = ((DropDownList)gridrow.FindControl("ddlUnit")).SelectedItem.Text.Trim();
        //    if (MUnit == "BOTH")
        //    {
        //        ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;
        //    }

        //    if (MUnit == "DAYS")
        //    {
        //        ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;
        //    }

        //    if (MUnit == "KMS")
        //    {
        //        ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;
        //    }

        //    if (MUnit == "")
        //    {
        //        ((DropDownList)gridrow.FindControl("ddlUnit")).Enabled = false;
        //        ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
        //        ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;
        //    }

        //}



        txtRow.Text = "0";
        BindGrid();
    }


   // protected void txtRow_TextChanged(object sender, EventArgs e)
   //{

   //    dt_WorkGroup.Clear();
   //    if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";

   //    for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
   //    {
   //        dt_WorkGroup.AddTaskRow("", "", "", "", "", "", "","");
   //    }
   //    txtRow.Text = "0";
   //    BindGrid();
   // }


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
        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            string SIDays = ((TextBox)gridrow.FindControl("txtServiceIDays")).Text;
            string SIKms = ((TextBox)gridrow.FindControl("txtServiceIKms")).Text;
            string ANDays = ((TextBox)gridrow.FindControl("txtAdvNoteDays")).Text;
            string ANKms = ((TextBox)gridrow.FindControl("txtAdvNoteKms")).Text;

            if (lblError.Text == "")
            {


                if (SIDays != "" && ANDays != "")
                {
                    int mSIDays = 0, mANDays = 0;
                    mSIDays = Convert.ToInt32(SIDays);
                    mANDays = Convert.ToInt32(ANDays);
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
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            conn.Open();

            bool success = false;
            SqlTransaction trans;

            trans = conn.BeginTransaction();
            try
            {

                string W_GRPCD = ddlWorkGroup.SelectedItem.Value;
                string STR = "delete  from WEBX_FLEET_TASKMST  where  W_GRPCD='" + W_GRPCD.Trim() + "'";
                SqlCommand mcmd1 = new SqlCommand(STR, conn, trans);
                mcmd1.ExecuteNonQuery();


                foreach (DataGridItem gridrow in dgWorkgroup.Items)
                {

                    string Desc = ((TextBox)gridrow.FindControl("txtDesc")).Text;
                    string TaskType = ((DropDownList)gridrow.FindControl("ddlTaskType")).SelectedItem.Value;
                    string Unit = ((DropDownList)gridrow.FindControl("ddlUnit")).Text;

                    string SIDays = ((TextBox)gridrow.FindControl("txtServiceIDays")).Text;
                    string SIKms = ((TextBox)gridrow.FindControl("txtServiceIKms")).Text;
                    string ANDays = ((TextBox)gridrow.FindControl("txtAdvNoteDays")).Text;
                    string ANKms = ((TextBox)gridrow.FindControl("txtAdvNoteKms")).Text;


                    ////usp_Job_CreateWorkGroup
                    //string mW_Grpcd = "";
                    //string str1 = "usp_Job_CreateWorkGroup";
                    //SqlCommand mcmd = new SqlCommand(str1, conn, trans);
                    //mcmd.CommandType = CommandType.StoredProcedure;

                    //SqlDataReader cmdDr = mcmd.ExecuteReader();
                    //if (cmdDr.HasRows)
                    //{
                    //    while (cmdDr.Read())
                    //    {
                    //        mW_Grpcd = Convert.ToString(cmdDr[0]);

                    //    }

                    //}
                    //cmdDr.Close();

                    string str = "usp_Job_TaskInsertUpdate";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@TaskType", SqlDbType.VarChar).Value = TaskType;
                    cmd.Parameters.Add("@WorkGrpCode", SqlDbType.VarChar).Value = ddlWorkGroup.SelectedItem.Value;
                    cmd.Parameters.Add("@Desc", SqlDbType.VarChar).Value = Desc;
                    cmd.Parameters.Add("@Unit", SqlDbType.VarChar).Value = Unit;
                    if (SIDays != "" && SIDays != null)
                    {
                        cmd.Parameters.Add("@SIDays", SqlDbType.Decimal).Value = Convert.ToDecimal(SIDays);
                    }

                    else
                    {
                        cmd.Parameters.Add("@SIDays", SqlDbType.Decimal).Value = nullvalue;
                    }

                    if (SIKms != "" && SIKms != null)
                    {
                        cmd.Parameters.Add("@SIKms", SqlDbType.Decimal).Value = Convert.ToDecimal(SIKms);
                    }

                    else
                    {
                        cmd.Parameters.Add("@SIKms", SqlDbType.Decimal).Value = nullvalue;
                    }

                    if (ANDays != "" && ANDays != null)
                    {
                        cmd.Parameters.Add("@ANDays", SqlDbType.Decimal).Value = Convert.ToDecimal(ANDays);
                    }

                    else
                    {
                        cmd.Parameters.Add("@ANDays", SqlDbType.Decimal).Value = nullvalue;

                    }
                    if (ANKms != "" && ANKms != null)
                    {

                        cmd.Parameters.Add("@ANKms", SqlDbType.Decimal).Value = Convert.ToDecimal(ANKms);
                    }
                    else
                    {
                        cmd.Parameters.Add("@ANKms", SqlDbType.Decimal).Value = nullvalue;
                    }


                    cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();

                    cmd.ExecuteNonQuery();





                    if (mDesc == "")
                    {
                        mDesc = Desc;

                    }
                    else
                    {
                        mDesc = mDesc + "," + Desc;
                    }

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
                Response.Redirect("Tasks.aspx");

            }

        }



        
    }

    protected void ddlTaskType_SelectedIndexChanged(object sender, EventArgs e)
    {


        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            string TaskType = "";
            TaskType = ((DropDownList)gridrow.FindControl("ddlTaskType")).SelectedItem.Value;


            if (TaskType == "01")
            {
                ((DropDownList)gridrow.FindControl("ddlUnit")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;
            }


            if (TaskType == "02")
            {
                ((DropDownList)gridrow.FindControl("ddlUnit")).Enabled = false;
                ((DropDownList)gridrow.FindControl("ddlUnit")).SelectedIndex = 0;
                ((TextBox)gridrow.FindControl("txtServiceIDays")).Text = "";
                ((TextBox)gridrow.FindControl("txtServiceIDays")).Text = "";
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).Text = "";
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).Text = "";


                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;
            }


        }

    
    }



    protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e)
    {
        

        foreach (DataGridItem gridrow in dgWorkgroup.Items)
        {
            string Unit = "";
             Unit = ((DropDownList)gridrow.FindControl("ddlUnit")).SelectedItem.Text;
             if (Unit == "BOTH")
             {



                 ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
                 ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
                 ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
                 ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;

             }

            if (Unit == "DAYS")
            {

                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = true;




            }



            if (Unit == "KMS")
            {




                ((TextBox)gridrow.FindControl("txtServiceIDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtServiceIKms")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvNoteDays")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvNoteKms")).ReadOnly = false;



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


    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
         

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            //datarow_Wgrp = ((MyFleetDataSet.WorkGroupRow)((DataRowView)e.Item.DataItem).Row);
            datarow_Wgrp = ((MyFleetDataSet.TaskRow)((DataRowView)e.Item.DataItem).Row);


            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_Wgrp.TaskDesc;



            ((DropDownList)e.Item.FindControl("ddlUnit")).SelectedItem.Text = datarow_Wgrp.UOM;

            ((TextBox)e.Item.FindControl("txtServiceIDays")).Text = datarow_Wgrp.SIDays;

            ((TextBox)e.Item.FindControl("txtServiceIKms")).Text = datarow_Wgrp.SIKms;

            ((TextBox)e.Item.FindControl("txtAdvNoteDays")).Text = datarow_Wgrp.ANDays;


            ((TextBox)e.Item.FindControl("txtAdvNoteKms")).Text = datarow_Wgrp.ANKms;
 

        }


    }



}
