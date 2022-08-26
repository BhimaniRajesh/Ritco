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
using System.Text;
using System.IO;

public partial class GUI_Fleet_Job_Default : System.Web.UI.Page
{
    DataView dvwProducts;
    private GridViewHelper helper;

    string[] cols = new string[2];
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.PMRemainderRow datarow_PMRow;



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

        Session["Pass"] = null;
        if (!IsPostBack)
        {
          //  Session["Type_Code"] = null;


            ViewRemainders();


        }
    }



    public void ViewRemainders()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string Flag = "";
        string sql = "select  *  from WEBX_FLEET_PM_JOBORDER_HDR";
        SqlCommand  cmd2 =new SqlCommand(sql,conn);
        SqlDataReader  dr1=cmd2.ExecuteReader();
        if(dr1.HasRows)
        {
            while(dr1.Read())
            {
                Flag = Convert.ToString(dr1[0]);
            }


        }
        dr1.Close();
 
        string str = "usp_Job_ViewRemainders";

        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = Flag.Trim();

      
        string mVehno = "";

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                string w_GRPCD = Convert.ToString(dr["W_GRPCD"]);
                string JOB_ORDER_NO = Convert.ToString(dr["JOB_ORDER_NO"]);

                string JobOrderDate = Convert.ToString(dr["JobOrderDate"]);

                string VEHNO = Convert.ToString(dr["VEHNO"]);
                string Desc1 = Convert.ToString(dr["Desc1"]);
                string VEH_CAT = Convert.ToString(dr["VEH_CAT"]);

                string ComplDate = Convert.ToString(dr["ComplDate"]);

                string KmRead = Convert.ToString(dr["KmRead"]);

                string Current_KM_READ = Convert.ToString(dr["Current_KM_READ"]);

                string PM_Due_Kms = Convert.ToString(dr["PM_Due_Kms"]);
                string PM_Due_Days = Convert.ToString(dr["PM_Due_Days"]);

                string REMARKS = Convert.ToString(dr["REMARKS"]);

             

                if (mVehno == VEHNO)
                {
                    mVehno = "";

                }
                else
                {
                    mVehno = VEHNO;

                }

        
                _dataSet.PMRemainder.AddPMRemainderRow(false, false, w_GRPCD, mVehno, VEH_CAT, Desc1, JOB_ORDER_NO, JobOrderDate, ComplDate, KmRead, Current_KM_READ, PM_Due_Kms, PM_Due_Days, REMARKS);
                mVehno = VEHNO;
  
            }
 
        }

        dr.Close();

  
        GridView1.DataSource = _dataSet.PMRemainder;

        GridView1.DataBind();
 
        conn.Close();


        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            string VEHNO = ((Label)gridrow.FindControl("lblVehNo")).Text.Trim();

            if (VEHNO != "")
            {
                ((RadioButton)gridrow.FindControl("radSel")).Visible = true;
                ((CheckBox)gridrow.FindControl("chkSel")).Visible = true;

            }

            else
            {

                ((RadioButton)gridrow.FindControl("radSel")).Visible = false;
                ((CheckBox)gridrow.FindControl("chkSel")).Visible = true;
            }



        }
 

    }




    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
      
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
                  
        row.Cells[0].Text = "Vehicle No-Vehicle Category:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
   
    }



    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string mW_GRPCD="";
        string VEHNO = "",mVEHNO="";

        int count=0;
        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            if (((RadioButton)gridrow.FindControl("radSel")).Checked == false)
            {
                
                count = count + 1;
            }
            }
     


        
        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            if (((RadioButton)gridrow.FindControl("radSel")).Checked == true || ((CheckBox)gridrow.FindControl("chkSel")).Checked == true)
            {
               


                  VEHNO = ((Label)gridrow.FindControl("lblVehNo")).Text.Trim();

                
                    string W_GRPCD = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();

                    if (mW_GRPCD == "")
                    {
                        mW_GRPCD = W_GRPCD;
                    }
                    else
                    {
                        mW_GRPCD = mW_GRPCD +","+ W_GRPCD;

                    }


                    if (VEHNO != "")
                    {
                        mVEHNO = VEHNO;
                    }
            }


        }

          Session["Pass"] = mVEHNO + ":" + mW_GRPCD;
     
        Response.Redirect("PMRemPMGeneration.aspx?mVEHNO=" +mVEHNO +  "&mW_GRPCD="+mW_GRPCD);

        }

      
   

    //protected void SetAllLevel0(object sender, CommandEventArgs e)
    //{
    //    string prev = "";
    //    string tmp = "";
    ////    string level0 = GridView1.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[1].ToString().Trim();
    //    bool firstBool = false;
    //    //BindGrid();
    //    for (int index = Convert.ToInt32(e.CommandArgument.ToString()); index <= GridView1.Rows.Count - 1; index++)
    //    {
    //        tmp = GridView1.DataKeys[index].Values[1].ToString().Trim();
    //     //   if ((tmp == prev || prev == "") && tmp == level0) //

    //            if ((tmp == prev || prev == "")) //
    //           {
    //            CheckBox cb = (CheckBox)GridView1.Rows[index].FindControl("chkSel");
    //            if (prev == "") { firstBool = cb.Checked; }
    //            //if (e.CommandName.ToString().Trim() == "Plus")
    //            //{
    //            cb.Checked = !firstBool;
    //            //}

    //            //if (e.CommandName.ToString().Trim() == "Minus")
    //            //{
    //            //    cb.Checked = false;
    //            //}

    //        }
    //        prev = GridView1.DataKeys[index].Values[1].ToString().Trim();
    //    }
    //    //lblDone1.Visible = false;
    //    //lblDone2.Visible = false;
    //}


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {

            datarow_PMRow = ((MyFleetDataSet.PMRemainderRow)((DataRowView)e.Row.DataItem).Row);


           // datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);

            if (e.Row.RowIndex >= -1)
            {
                string strSelRadio = ((RadioButton)e.Row.FindControl("radSel")).ClientID;
                ((RadioButton)e.Row.FindControl("radSel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");
            }

             
            ((CheckBox)e.Row.FindControl("radSel")).Checked = datarow_PMRow.radSel;
            ((CheckBox)e.Row.FindControl("chkSel")).Checked = datarow_PMRow.chkSel;




            ((Label)e.Row.FindControl("lblW_GRPCD")).Text = datarow_PMRow.W_GRPCD;
           ((Label)e.Row.FindControl("lblVehNo")).Text = datarow_PMRow.Vehno;

            ((Label)e.Row.FindControl("lblVeh_Cat")).Text = datarow_PMRow.VehCat;
            ((Label)e.Row.FindControl("lblDesc")).Text = datarow_PMRow.Desc;
            ((Label)e.Row.FindControl("lblJONo")).Text = datarow_PMRow.JoNo;




            ((Label)e.Row.FindControl("lblJODate")).Text = datarow_PMRow.JoDate;
            ((Label)e.Row.FindControl("lblJCDate")).Text = datarow_PMRow.JcDate;
            ((Label)e.Row.FindControl("lblKMRead")).Text = datarow_PMRow.KmRead;


            ((Label)e.Row.FindControl("lblCKMRead")).Text = datarow_PMRow.CKmRead;
            ((Label)e.Row.FindControl("lblPMDays")).Text = datarow_PMRow.PMDays;
            ((Label)e.Row.FindControl("lblPMKms")).Text = datarow_PMRow.PMKms;

            ((Label)e.Row.FindControl("lblRemark")).Text = datarow_PMRow.Remarks;


        }
    }


}

