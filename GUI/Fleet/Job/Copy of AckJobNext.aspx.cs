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
public partial class GUI_Fleet_Job_AckJobNext : System.Web.UI.Page
{
    DataView dvwProducts;
    private GridViewHelper helper;
    

        
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.JobSparePartRow datarow_Spare;

    MyFleetDataSet.AckJobOrderRow datarow_AJob;

    int mDataCount = 0;
   
    string OrderNo = "";
 
    string cols = "";
     

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        this.Title = pagetitle;


        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");


    
        OrderNo = Request.QueryString["OrderNo"];

        if (!IsPostBack)
        {
          

            if (mDataCount == 0)
            {
       
            }
            txtRow.Text = mDataCount.ToString();

            Inetialized();
            BindGrid();


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

     //   string str = "usp_Job_JobOrderList";

        string str = "usp_Job_JobOrderDetList";
        
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
       
        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
      

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
            lblVehicleNo.Text = Convert.ToString(dr["VEHNO"]);
                string VehArrStatus = Convert.ToString(dr["VEH_ARRV_STATUS"]);
             //   string VehArrDt = Convert.ToString(dr["VEH_ARRV_DT"]);
              lblWONo.Text = Convert.ToString(dr["JOB_ORDER_NO"]);
            lblDate.Text   = Convert.ToString(dr["OrderDt1"]);
             lblOrderType.Text = Convert.ToString(dr["ORDER_TYPE"]);
               lblOrderStatus.Text= Convert.ToString(dr["ORDER_STATUS"]);
               lblCategory.Text = Convert.ToString(dr["Category"]);

               lblMfg.Text = Convert.ToString(dr["Madeby"]);
               lblModel.Text = Convert.ToString(dr["Model"]);


               lblSCType.Text = Convert.ToString(dr["SERVICE_CENTER_TYPE"]);
               lblVendor.Text = Convert.ToString(dr["Vendor"]);
               lblwLoc.Text = Convert.ToString(dr["Location"]);
           //    lblVendor.Text = Convert.ToString(dr["Vendor"]);


               lblWLocHead.Visible = false;
                lblwLoc.Visible=false;
                lblVendorHead.Visible = false;
                lblVendor.Visible = false;


                if (lblSCType.Text.Trim() == "Workshop")
               {
                   lblWLocHead.Visible = true;
                   lblwLoc.Visible = true;
                   lblwLoc.Text = Convert.ToString(dr["Location"]);
                   lblVendorHead.Visible = false;
                   lblVendor.Visible = false;

               }

               if (lblSCType.Text.Trim() == "Vendor")
               {
                   lblVendorHead.Visible = true;

                   lblVendor.Visible = true;

                   lblVendor.Text = Convert.ToString(dr["Vendor"]);

                   lblWLocHead.Visible = false;
                   lblwLoc.Visible = false;

               }


            }






        }

        dr.Close();
        conn.Close();

       



    }

    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
             
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
   

        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
        
    
        row.Cells[0].Text = "Work Group Code & Description:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";



    }


    public void BindGrid1()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

         string str = "usp_Job_JobOrderDetList";

        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
              

      //  SqlDataAdapter    da  = new SqlDataAdapter(cmd);

     
        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
    //    DataSet ds = new DataSet();
     //   da.Fill(ds);



        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                string W_GRPCD = Convert.ToString(dr1["WorkGroup"]);

                string taskcd = Convert.ToString(dr1["TASKCD"]);
                string TaskType = Convert.ToString(dr1["TaskType"]);
                string TaskDesc = Convert.ToString(dr1["TASKDESC"]);
                string Remark = Convert.ToString(dr1["REMARKS"]);
                string EstHrs = "0";
                string EstCost = "0";

                _dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, Remark, "", "");


            }



        }
        dr1.Close();




        GridViewHelper helper = new GridViewHelper(this.GridView1);
         cols = "W_GRPCD";

       // cols[0] = "W_GRPCD";


      //  cols[1] = "EstHrs";
      //  cols[2] = "EstHrs";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
   
       
       // GridView1.DataSource = ds;
       // GridView1.DataBind();

        GridView1.DataSource = _dataSet.AckJobOrder;
        GridView1.DataBind();

     //   _lastEditedPage = GridView1.CurrentPageIndex;

          



        conn.Close();

    }


    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_JobOrderDetList";

        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;


        //  SqlDataAdapter    da  = new SqlDataAdapter(cmd);


        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
        //    DataSet ds = new DataSet();
        //   da.Fill(ds);



        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                string W_GRPCD = Convert.ToString(dr1["WorkGroup"]);

                string taskcd = Convert.ToString(dr1["TASKCD"]);
                string TaskType = Convert.ToString(dr1["TaskType"]);
                string TaskDesc = Convert.ToString(dr1["TASKDESC"]);
                string Remark = Convert.ToString(dr1["REMARKS"]);
                string EstHrs = "0";
                string EstCost = "0";

                _dataSet.AckJobOrder.AddAckJobOrderRow(W_GRPCD, taskcd, TaskDesc, TaskType, Remark, "", "");

             }



        }
        dr1.Close();



 

        GridView1.DataSource = _dataSet.AckJobOrder;
        GridView1.DataBind();

       




        conn.Close();
        string old_W_FRPCD="";
        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            string w_GRPCD = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();


            if (old_W_FRPCD == w_GRPCD)
            {

                ((TextBox)gridrow.FindControl("txtEstHrs")).Visible = false;
                ((TextBox)gridrow.FindControl("txtEstCost")).Visible = false;

                old_W_FRPCD = w_GRPCD;

            }
            else
            {
                ((TextBox)gridrow.FindControl("txtEstHrs")).Visible = true;
                ((TextBox)gridrow.FindControl("txtEstCost")).Visible = true;

            }

            old_W_FRPCD = w_GRPCD;



        }

        //if (GridView1.Rows.Count != 0)
        //{
        //    lblHead.Visible = true;

        //}

        //else
        //{
        //    lblHead.Visible = false;

        //}






    }



    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        Double Cost=0,Hrs=0,KmRead=0;

        Double totcost = 0;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
       if(txttotEstCost.Text.Trim()!="")
        {
       Cost=Convert.ToDouble(txttotEstCost.Text.Trim());
       }

      if(txttotEstHrs.Text.Trim()!="")
        {
       Hrs=Convert.ToDouble(txttotEstHrs.Text.Trim());
       }


       if(txtKMReading.Text.Trim()!="")
        {

       KmRead=Convert.ToDouble(txtKMReading.Text.Trim());
      
       }
       foreach (DataGridItem gridrow in dgSpare.Items)
       {
           Double mcost = 0;
       

           string Cost1 = ((TextBox)gridrow.FindControl("txtCost")).Text.Trim();
           if (Cost1 != "")
           {
               mcost = Convert.ToDouble(Cost1);

           }
           totcost = totcost + mcost;
       
         }
        
       string str = "update WEBX_FLEET_PM_JOBORDER_HDR  set KM_READING='" + KmRead + "',TOT_EST_LABOUR_HRS='" + Hrs + "',TOT_EST_LABOUR_COST='" + Cost + "',  TOT_EST_PART_COST='" + totcost + "'";
       SqlCommand cmd = new SqlCommand(str, conn);
       cmd.ExecuteNonQuery();

       string old_W_FRPCD = "";
      
       Double tHrs = 0, tCost = 0;
       foreach (GridViewRow gridrow in GridView1.Rows)
       {
           string w_GRPCD = ((Label)gridrow.FindControl("lblW_GRPCD")).Text.Trim();
           string Hrs1 = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();
           string Cost1 = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();

         

                 if(((TextBox)gridrow.FindControl("txtEstHrs")).Visible==true && ((TextBox)gridrow.FindControl("txtEstCost")).Visible==true)
                {
                   Double mHrs = 0, mCost = 0;
                   
                       mHrs = Convert.ToDouble(Hrs1);
                   
                   
                   
                       mCost = Convert.ToDouble(Cost1);



                       string mmstr = "update WEBX_FLEET_PM_JOBORDER_DET  set W_EST_LABOUR_HRS='" + mHrs + "',W_EST_LABOUR_COST='" + mCost + "'  where  W_GRPCD='" + w_GRPCD.Trim() + "'   ";
                   SqlCommand mcmd = new SqlCommand(mmstr, conn);
                   mcmd.ExecuteNonQuery();

                

               }

         
           

       }



       

           foreach (DataGridItem gridrow2 in dgSpare.Items)
           {
               string Part_code = ((DropDownList)gridrow2.FindControl("ddlPartNo")).SelectedItem.Value.Trim();

               string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();

               string CostUnit = ((Label)gridrow2.FindControl("lblCostUnit")).Text.Trim();

               string mCost1 = ((TextBox)gridrow2.FindControl("txtCost")).Text.Trim();

               Double mCostUnit=0;
               if (CostUnit != "")
               {
                  mCostUnit=Convert.ToDouble(CostUnit);
               }



               string spsql = "usp_Job_EstSparePart";
               SqlCommand spcmd = new SqlCommand(spsql, conn);
               spcmd.CommandType = CommandType.StoredProcedure;

               spcmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = lblWONo.Text.Trim();
               spcmd.Parameters.Add("@PartNo", SqlDbType.VarChar).Value = Part_code;

               spcmd.Parameters.Add("@Qty", SqlDbType.Int).Value = Convert.ToInt32(Qty);
               spcmd.Parameters.Add("@Cost_Unit", SqlDbType.Float).Value = Convert.ToDouble(mCostUnit);

               spcmd.Parameters.Add("@Cost", SqlDbType.Float).Value = Convert.ToDouble(mCost1);
               spcmd.ExecuteNonQuery();


           }
      


       conn.Close();

        Response.Redirect("Master.aspx");


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
        foreach (DataGridItem gridrow in dgSpare.Items)
        {
            iroww = iroww + 1;
        }
        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }

        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.JobSparePart.RemoveJobSparePartRow(_dataSet.JobSparePart[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            _dataSet.JobSparePart.AddJobSparePartRow("", "", "", "", "");
        }

        BindSpareGrid();

    }


    public void BindSpareGrid()
    {
        dgSpare.DataSource = _dataSet.JobSparePart;
        dgSpare.DataBind();
        _lastEditedPage = dgSpare.CurrentPageIndex;
     }

   
    protected void txtEstHrs_TextChanged(object sender, EventArgs e)
    {
        Double mHrs = 0;
        Double totHrs = 0;

        foreach (GridViewRow gridrow in GridView1.Rows)
        {
           



            if (((TextBox)gridrow.FindControl("txtEstHrs")).Visible == true)
            {
                string Hrs = ((TextBox)gridrow.FindControl("txtEstHrs")).Text.Trim();

                if (Hrs != "")
                {
                    mHrs = Convert.ToDouble(Hrs);

                }

                totHrs = totHrs + mHrs;

                txttotEstHrs.Text = Convert.ToString(totHrs);

                mHrs = 0;
            }

        }
    }
    protected void txtEstCost_TextChanged(object sender, EventArgs e)
    {
        Double mCost = 0;
        Double totCost = 0;

        foreach (GridViewRow gridrow in GridView1.Rows)
        {

            if (((TextBox)gridrow.FindControl("txtEstCost")).Visible == true)
            {
                string Cost = ((TextBox)gridrow.FindControl("txtEstCost")).Text.Trim();


                if (Cost != "")
                {
                    mCost = Convert.ToDouble(Cost);

                }

                totCost = totCost + mCost;

                txttotEstCost.Text = Convert.ToString(totCost);
                mCost = 0;
            }


        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {

            datarow_AJob = ((MyFleetDataSet.AckJobOrderRow)((DataRowView)e.Row.DataItem).Row);

            ((Label)e.Row.FindControl("lblW_GRPCD")).Text = datarow_AJob.W_GRPCD;
            ((Label)e.Row.FindControl("lblTaskCode")).Text = datarow_AJob.Taskcd;

            ((Label)e.Row.FindControl("lblTaskDesc")).Text = datarow_AJob.TaskDesc;
            ((Label)e.Row.FindControl("lblTaskType")).Text = datarow_AJob.TaskType;
            ((Label)e.Row.FindControl("lblRemark")).Text = datarow_AJob.Remark;
       

        }
    }
    protected void dgSpare_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select  distinct PartId from WEBX_FLEET_PARTMST where  ACTIVEFLAG='Y'  Order by Partid ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_FLEET_PARTMST");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlPartNo = ((DropDownList)e.Item.FindControl("ddlPartNo"));
            ddlPartNo.DataTextField = "PartId";
            ddlPartNo.DataValueField = "PartId";

            ddlPartNo.DataSource = ds1.Tables["WEBX_FLEET_PARTMST"];

            ddlPartNo.DataBind();
            ddlPartNo.Items.Insert(0, "");

           

        }


        DataSet ds2 = new DataSet();
        SqlDataAdapter da2 = new SqlDataAdapter("select  distinct   PartName from WEBX_FLEET_PARTMST where  ACTIVEFLAG='Y'  order by PartName ", conn);
        conn.Close();
        da2.Fill(ds2, "WEBX_FLEET_PARTMST");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlPDesc = ((DropDownList)e.Item.FindControl("ddlPDesc"));
            ddlPDesc.DataTextField = "PartName";
            ddlPDesc.DataValueField = "PartName";

            ddlPDesc.DataSource = ds2.Tables["WEBX_FLEET_PARTMST"];

            ddlPDesc.DataBind();
            ddlPDesc.Items.Insert(0, "");



        }



        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            datarow_Spare = ((MyFleetDataSet.JobSparePartRow)((DataRowView)e.Item.DataItem).Row);

            ((DropDownList)e.Item.FindControl("ddlPartNo")).SelectedItem.Text = datarow_Spare.PartNo;
            ((DropDownList)e.Item.FindControl("ddlPDesc")).SelectedItem.Text = datarow_Spare.PartDesc;

            ((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
            ((Label)e.Item.FindControl("lblCostUnit")).Text = datarow_Spare.Cost_Unit;
            ((TextBox)e.Item.FindControl("txtCost")).Text = datarow_Spare.Cost;
        }
    }
    protected void txtQty_TextChanged(object sender, EventArgs e)
    {
        foreach (DataGridItem gridrow2 in dgSpare.Items)
        {
         
            int mqty = 0; Double mcost = 0;
            string Qty = ((TextBox)gridrow2.FindControl("txtQty")).Text.Trim();
            string CostUnit = ((Label)gridrow2.FindControl("lblCostUnit")).Text.Trim();
            if (Qty != "")
            {
                mqty = Convert.ToInt32(Qty);
            }

            if (CostUnit != "")
            {
                mcost = Convert.ToDouble(CostUnit);
            }

            Double ToatlCost = mqty * mcost;

            string Cost = ((TextBox)gridrow2.FindControl("txtCost")).Text = Convert.ToString(ToatlCost);

        }
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
