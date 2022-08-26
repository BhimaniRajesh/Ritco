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
public partial class GUI_Fleet_Job_FinalizeTask : System.Web.UI.Page
{

    string W_GRPCD = "";
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.FinTaskRow datarow_FTask;


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        this.Title = pagetitle;
        Session["W_GRPCD"] = null;
        Session["taskcd"] = null;
        W_GRPCD = Request.QueryString["id"];
     //   Session["sub"] = null;
       // Session["Main"] = null;

//        string scr = @"<script>
//             function Done()
//           {
//               
//                window.close();
//            } 
//          </script>";
//        Page.RegisterClientScriptBlock("done", scr);


        if (!IsPostBack)
        {
            Inetialized();

         //   Session["TASKLIST"] = null;

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

    public void Inetialized()
    {
       

         
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_ViewTaskList";

        SqlCommand sqlcmd = new SqlCommand(str, conn);


        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = W_GRPCD.ToString().Trim();

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if (dr.HasRows)
        {
            while (dr.Read())
            {

            
                bool  ChkSel=false;
                string taskcd = Convert.ToString(dr["taskcd"]);
                 string DataFound="N";

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

                           DataFound="Y";
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

        BindGrid();


        if (DataGrid1.Rows.Count != 0)
        {

            btnSubmit.Visible = true;
        }

        else
        {


            btnSubmit.Visible = false;

        }




    }




    public void BindGrid()
    {
            DataGrid1.DataSource = _dataSet.FinTask;
            DataGrid1.DataBind();
     
    }






    protected void btnSubmit_Click(object sender, EventArgs e)
    { 
        string   taskcd="";
          string  mtaskcd="";
        string DataFoundFlag = "N";
        foreach (GridViewRow gridrow in DataGrid1.Rows)
        {

            if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
            {


                if (taskcd == "")
                {
                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                }

                else
                {

                    //  taskcd = taskcd + "," +  ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();



                    string[] selvaluesArr;
                    string[] selvaluesArr1;
                    if (Session["TASKLIST"] != null)
                    {


                      //  string tasklist = Session["TASKLIST"].ToString().Trim();

                        //selvaluesArr = tasklist.Split(new char[] { ',' });
                        //int maxarr = selvaluesArr.GetUpperBound(0);
                        //selvaluesArr1 = taskcd.Split(new char[] { ',' });

                        //int maxarr1 = selvaluesArr1.GetUpperBound(0);
                        //string remtask = "";

                        //for (int i = 0; i <= maxarr; i++)
                        //{
                        //    for (int j = 0; j <= maxarr1; j++)
                        //    {
                        //        if (selvaluesArr[i].ToString().Trim() == selvaluesArr1[j].ToString().Trim())
                        //        {
                        //            DataFoundFlag = "Y";
                        //        }
                        //    }
                        //}





                        //string tasklist = Session["TASKLIST"].ToString().Trim();

                        //selvaluesArr = tasklist.Split(new char[] { ',' });
                        //int maxarr = selvaluesArr.GetUpperBound(0);
                        //selvaluesArr1 = taskcd.Split(new char[] { ',' });

                        //int maxarr1 = selvaluesArr1.GetUpperBound(0);
                        //string remtask = "";

                        //for (int i = 0; i <= maxarr; i++)
                        //{
                        //    for (int j = 0; j <= maxarr1; j++)
                        //    {
                        //        if (selvaluesArr[i].ToString().Trim() == selvaluesArr1[j].ToString().Trim())
                        //        {
                        //            DataFoundFlag = "Y";
                        //        }
                        //    }
                        //}









                        //if (DataFoundFlag == "Y")
                        //{

                        //    taskcd = taskcd;
                        //}
                        //else
                        //{
                        //    taskcd = taskcd + "," + ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                        //    //taskcd.Remove(



                        //}


                    }
                    else
                    {
                        taskcd = taskcd + "," + ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();

                    }

                }


            }
   

        }
      
            Session["sub"] = W_GRPCD + ":" + taskcd;

 

        
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
           // Session["TASKLIST"] = taskcd;
            Session["TASKLIST"] = taskcd + ",";

        }

        else
        {

            //string[] selvaluesArr;
            //string[] selvaluesArr1;
            //string tasklist = Session["TASKLIST"].ToString().Trim();

            //selvaluesArr = tasklist.Split(new char[] { ',' });
            //int maxarr = selvaluesArr.GetUpperBound(0);
            //selvaluesArr1 = taskcd.Split(new char[] { ',' });

            //int maxarr1 = selvaluesArr1.GetUpperBound(0);
            //string remtask = "";

            //for (int i = 0; i <= maxarr; i++)
            //{
            //    for (int j = 0; j <= maxarr; j++)
            //    {


            //        if (selvaluesArr[i].ToString().Trim() == selvaluesArr1[j].ToString().Trim())
            //        {
            //            DataFoundFlag = "Y";

            //             taskcd.Remove(selvaluesArr1[j].ToString().Trim());
            //        }
     
            //    }
            //}

            //if (DataFoundFlag == "Y")
            //{
            //    taskcd.Remove()
           //  Session["TASKLIST"] = Session["TASKLIST"].ToString() + "," + taskcd ;
            foreach (GridViewRow gridrow in DataGrid1.Rows)
            {
                if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                {
                    taskcd = ((Label)gridrow.FindControl("lblTaskCd")).Text.Trim();
                    
                    Session["TASKLIST"] = Session["TASKLIST"].ToString() + taskcd + ",";
                      
                
                }
            }
          
            string[] sesion_arr = Session["TASKLIST"].ToString().Split(',');
            string session_str = Session["TASKLIST"].ToString();
            foreach (GridViewRow gridrow in DataGrid1.Rows)
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
       

    }
    protected void DataGrid1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow ))
        {

            datarow_FTask = ((MyFleetDataSet.FinTaskRow)((DataRowView)e.Row.DataItem).Row);

            ((CheckBox)e.Row.FindControl("chkSelect")).Checked = datarow_FTask.chkSelect;
            ((Label)e.Row.FindControl("lblTaskCd")).Text = datarow_FTask.Taskcd;

            ((Label)e.Row.FindControl("lblTaskDesc")).Text = datarow_FTask.TeakDesc;
            ((Label)e.Row.FindControl("lblTaskType")).Text = datarow_FTask.TaskType;
           
        }


    }
}
