
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



public partial class GUI_Job_Workgrp : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.WorkGroupRow datarow_Wgrp;


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
            addVehCategory();
            //Do Work
            
            txtRow.Text = "0";
        }
    }



    public void addVehCategory()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

        string str = "usp_Job_AddCategoty";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@Flag",SqlDbType.VarChar).Value="C";
         cmd.Parameters.Add("@Category",SqlDbType.VarChar).Value="";
        

        SqlDataReader dr = cmd.ExecuteReader();
       
      // ddlVehCategory.Items.Clear();

       ddlVehCategory.Items.Add(new ListItem("Select", ""));
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

        string str1 = "select  *   from webx_fleet_workgroup  where 1=1     and VEH_CAT='" + ddlVehCategory.SelectedItem.Value.ToString().Trim() + "'";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
       
      
        SqlDataReader mdr1 = cmd1.ExecuteReader();

        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                int mSiDays = 0, mSiKms = 0, mANdays = 0, mAnKms = 0;



                string w_GRPD = Convert.ToString(mdr1["w_GRPCD"]);
                string Desc = Convert.ToString(mdr1["w_GRPDESC"]);
                string Unit = Convert.ToString(mdr1["W_UOM"]);
                string SiDays = Convert.ToString(Convert.ToInt32(mdr1["SERVICE_INTERVALS_DAY"]));
                if (SiDays == "0")
                {
                    SiDays = "";
                }
               

                string SiKms = Convert.ToString(Convert.ToInt32(mdr1["SERVICE_INTERVALS_KMS"]));
                if (SiKms == "0")
                {
                    SiKms = "";
                }
                
                
                string ANdays = Convert.ToString(Convert.ToInt32(mdr1["ADV_NOTIFICATION_DAY"]));
                if (ANdays == "0")
                {
                    ANdays = "";
                }

               string AnKms = Convert.ToString(Convert.ToInt32(mdr1["ADV_NOTIFACATION_KMS"]));
               if (AnKms == "0")
               {
                   AnKms = "";
               }



                _dataSet.WorkGroup.AddWorkGroupRow(w_GRPD, Desc, Unit, SiDays, SiKms, ANdays, AnKms);

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





                }








    }

    protected void txtRow_TextChanged(object sender, EventArgs e)
   {
       
       string rowno;
       int mroww = 0;
       int miroww = 0;

       rowno = txtRow.Text;
       mroww = Convert.ToInt16(rowno);
       int i;


       int iroww = 0;
       foreach (DataGridItem gridrow in dgWorkgroup.Items)
       {
           iroww = iroww + 1;
       }
       miroww = iroww;

       if (mroww < miroww)
       {
           miroww = mroww;
       }

      // if (iroww >= 0)
       if (mroww < miroww)
       {
           for (i = iroww - 1; i > -1 + miroww; i--)
           {
               _dataSet.WorkGroup.RemoveWorkGroupRow(_dataSet.WorkGroup[i]);
           }
       }

       for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
       {
           _dataSet.WorkGroup.AddWorkGroupRow("", "", "", "", "", "", "");
       }

       BindGrid();
         
       




      //  ----------------

      
    
    }


    public void BindGrid()
    {
        dgWorkgroup.DataSource = _dataSet.WorkGroup;
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


            if (SIDays != "" && ANDays!="")
            {
                int mSIDays=0,  mANDays=0;
                mSIDays = Convert.ToInt32(SIDays);
                mANDays = Convert.ToInt32(ANDays);
                if (mANDays > mSIDays)
                {
                    lblError.Visible = true;
                    lblError.Text = "Advance Notification must be less than Service Interval ! ";

                }
                else
                {     lblError.Visible = false;
                    lblError.Text="";

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

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            bool success = false;
            SqlTransaction trans;

            trans = conn.BeginTransaction();
            try
            {

                string Category = ddlVehCategory.SelectedItem.Value.ToString().Trim();




                string STR = "delete  from WEBX_FLEET_WORKGROUP  where  VEH_CAT='" + Category.Trim() + "'";
                SqlCommand mcmd1 = new SqlCommand(STR, conn, trans);
                mcmd1.ExecuteNonQuery();





                foreach (DataGridItem gridrow in dgWorkgroup.Items)
                {

                    string Desc = ((TextBox)gridrow.FindControl("txtDesc")).Text;
                    string Unit = ((DropDownList)gridrow.FindControl("ddlUnit")).Text;

                    string SIDays = ((TextBox)gridrow.FindControl("txtServiceIDays")).Text;
                    string SIKms = ((TextBox)gridrow.FindControl("txtServiceIKms")).Text;
                    string ANDays = ((TextBox)gridrow.FindControl("txtAdvNoteDays")).Text;
                    string ANKms = ((TextBox)gridrow.FindControl("txtAdvNoteKms")).Text;


                    //usp_Job_CreateWorkGroup
                    string mW_Grpcd = "";
                    string str1 = "usp_Job_CreateWorkGroup";
                    SqlCommand mcmd = new SqlCommand(str1, conn, trans);
                    mcmd.CommandType = CommandType.StoredProcedure;

                    SqlDataReader cmdDr = mcmd.ExecuteReader();
                    if (cmdDr.HasRows)
                    {
                        while (cmdDr.Read())
                        {
                            mW_Grpcd = Convert.ToString(cmdDr[0]);

                        }

                    }
                    cmdDr.Close();

                    string str = "usp_Job_WorkgroupInsertUpdate";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = Category;
                    cmd.Parameters.Add("@WorkGrpCode", SqlDbType.VarChar).Value = mW_Grpcd;
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
                Response.Redirect("WorkgrpResult.aspx?WGrp=" + mDesc);

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

            datarow_Wgrp = ((MyFleetDataSet.WorkGroupRow)((DataRowView)e.Item.DataItem).Row);


            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_Wgrp.Desc;


             
            ((DropDownList)e.Item.FindControl("ddlUnit")).SelectedItem.Text = datarow_Wgrp.Unit;

            ((TextBox)e.Item.FindControl("txtServiceIDays")).Text = datarow_Wgrp.SDays;

            ((TextBox)e.Item.FindControl("txtServiceIKms")).Text = datarow_Wgrp.SKms;

            ((TextBox)e.Item.FindControl("txtAdvNoteDays")).Text = datarow_Wgrp.ANDays;


            ((TextBox)e.Item.FindControl("txtAdvNoteKms")).Text = datarow_Wgrp.ANKms;
 

        }


    }



}
