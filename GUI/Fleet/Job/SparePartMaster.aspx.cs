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


public partial class GUI_Fleet_Job_SparePartMaster : System.Web.UI.Page
{

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.PartVendorRow datarow_PVendor;
    string Type_Code = "";
    int mDataCount = 0;

    string PartId="";  string AddEditMode="";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        
        this.Title = pagetitle;
        PartId=Request.QueryString["id"];

        if (!IsPostBack)
        {
            WorkGroupList(ddlWorkGroup);
            BindTaskType(ddlTaskType);

            if (PartId != "" && PartId != null)
            {
                Inetialized();
               AddEditMode = "U";
                ViewState["AddEditMode"] = AddEditMode;
            }
            else
            {
                AddEditMode = "I";
                ViewState["AddEditMode"] = AddEditMode;
            }

            //mDataCount = 0;
            //if (mDataCount == 0)
            //{
            //    //mDataCount = mDataCount + 1;
            //    //Inetialized_Repair_Expense();
               
            //}
            //txtRow.Text = mDataCount.ToString();
            BindGrid();
        }



    }
    public void BindTaskType(DropDownList d)
    {
        JobSheet objJs = new JobSheet(Session["SqlProvider"].ToString());
        d.Items.Clear();
        objJs.BindTaskType(d);
    }
    public void WorkGroupList(DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string str = "usp_WorkGroupList";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@GroupCode", System.Data.SqlDbType.VarChar).Value = '0';
        SqlDataReader dr = cmd.ExecuteReader();

        d.Items.Insert(0, "Select");
        if (dr.HasRows)
        {
            while (dr.Read())
            {   
                d.Items.Add(new ListItem(dr["W_GRPDESC"].ToString(), dr["W_GRPCD"].ToString()));
            }
        }

        dr.Close();

        conn.Close();

    }
    public void Inetialized()
    {
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "usp_SparePartHdr_List";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.CommandType = CommandType.StoredProcedure;
        conn.Open();


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        string mFlag = "", mLocation="";

        sqlcmd2.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = "01/01/1950";
        sqlcmd2.Parameters.Add("@createdto", SqlDbType.DateTime).Value = "01/01/1950";
        sqlcmd2.Parameters.Add("@PartID", SqlDbType.VarChar).Value = PartId;

        SqlDataReader r2 = sqlcmd2.ExecuteReader();
         
        string mPartType="",mPartCat="";
        while (r2.Read())
        {
            txtReorderQry.Text = r2["Reorder_qty"].ToString().Trim();
            txtReorder.Text=r2["Reorder_Point"].ToString().Trim();
            txtInvUnt.Text=r2["Unit_Of_Inventory"].ToString().Trim();
            txtExpDate.Text = r2["ExpdT1"].ToString().Trim();
            txtExpKms.Text=r2["ExpKms"].ToString().Trim();
            ddlTaskType.SelectedValue = r2["TaskTypeId"].ToString().Trim();
            lblPartId.Text = PartId.Trim();


            txtDesc.Text=r2["Description"].ToString().Trim();
            txtAvgCost.Text=r2["Avg_Cost"].ToString().Trim();

            txtSellPrice.Text=r2["Selling_Price"].ToString().Trim();

            mPartType = r2["Part_Type"].ToString().Trim();
            for (int i = 0; i < cboPartType.Items.Count; i++)
            {
                if (mPartType == cboPartType.Items[i].Value)
                {
                    cboPartType.SelectedIndex = i;
                }
            }

            for (int i = 0; i < ddlWorkGroup.Items.Count; i++)
            {
                if (r2["W_GRPDC"].ToString() == ddlWorkGroup.Items[i].Value)
                {
                    ddlWorkGroup.SelectedIndex = i;
                }
            }
        }

        r2.Close();

        sql = "usp_SparePartDet_List";
        SqlCommand sqlcmd3 = new SqlCommand(sql, conn);
        sqlcmd3.CommandType = CommandType.StoredProcedure;
      

        sqlcmd3.Parameters.Add("@PartID", SqlDbType.VarChar).Value = PartId;

        SqlDataReader r3 = sqlcmd3.ExecuteReader();

        int count = 0;


        while (r3.Read())
        {
                 string vendor=r3["VendorCode"].ToString().Trim();
                 string VendorPNo=r3["Vendor_Part_No"].ToString().Trim();
                 string Mafg=r3["Manufacturer"].ToString().Trim();
                 string Cost=r3["Cost"].ToString().Trim();
                 string LeadTime=r3["LeadTime"].ToString().Trim();


                 _dataSet.PartVendor.AddPartVendorRow(vendor, VendorPNo, Mafg, Cost, LeadTime);

                 count = count + 1;
        }




        r3.Close();
        BindGrid();


        txtRow.Text = count.ToString();
        conn.Close();

    }



    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
         

        //string rowno;
        //int mroww = 0;
        //int miroww = 0;

        //rowno = txtRow.Text;
        //mroww = Convert.ToInt16(rowno);
        //int i;


        //int iroww = 0;
        //foreach (DataGridItem gridrow in dgVendor.Items)
        //{
        //    iroww = iroww + 1;
        //}
        //miroww = iroww;

        //if (mroww < miroww)
        //{
        //    miroww = mroww;
        //}

        //if (iroww >= 0)
        //{
        //    for (i = iroww - 1; i > -1 + miroww; i--)
        //    {
        //        _dataSet.PartVendor.RemovePartVendorRow(_dataSet.PartVendor[i]);
        //    }
        //}

        //for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        //{
        //    _dataSet.PartVendor.AddPartVendorRow("", "", "", "", "");
        //}










        //string rowno;
        //int mroww = 0;
        //int miroww = 0;
        //rowno = txtRow.Text;

        //mroww = Convert.ToInt16(rowno);
        //int i;
        //int iroww = 0;
        //foreach (DataGridItem gridrow in dgVendor.Items)
        //{
        //    iroww = iroww + 1;
        //}
        //miroww = iroww;

        //if (mroww < miroww)
        //{
        //    miroww = mroww;
        //}
        //if (iroww >= 0)
        //{
        //    for (i = iroww - 1; i > -1 + miroww; i--)
        //    {
        //        _dataSet.PartVendor.RemovePartVendorRow(_dataSet.PartVendor[i]);
        //    }
        //}

        //for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        //{
        //    _dataSet.PartVendor.AddPartVendorRow("", "", "", "", "");
        //}




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

        foreach (DataGridItem gridrow in dgVendor.Items)
        {
            iroww = iroww + 1;
        }


        if (iroww > 0)
        {

            int tmp = 0;

            conn.Open();

            string STR11 = "select *  from WEBX_FLEET_SparePartDet where Part_ID ='" + PartId.Trim() + "'  ";

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



        if (dgVendor.Items.Count == 0)
        {

            for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
            {
                _dataSet.PartVendor.AddPartVendorRow("", "", "", "", "");
            }

        }
        else
        {

            //int mcount = iroww;

            if (iroww > count)
            {
                int j = 0;

                int t = iroww;

                foreach (DataGridItem gridrow in dgVendor.Items)
                {

                    if (t > count)
                    {
                        t = t - 1;

                        _dataSet.PartVendor.RemovePartVendorRow(_dataSet.PartVendor[t]);

                    }

                }

            }


            for (i = 0; i < Int16.Parse(txtRow.Text); i++)
            {
                _dataSet.PartVendor.AddPartVendorRow("", "","","","");
            }


        }




        BindGrid();








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



    public void BindGrid()
    {
        dgVendor.DataSource = _dataSet.PartVendor;
        dgVendor.DataBind();
        _lastEditedPage = dgVendor.CurrentPageIndex;



    }

    //protected void DataGrid1_ItemCommand(object source, DataGridCommandEventArgs e)
    //{
    //    if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
    //    {

    //        if (LblError.Text == "")
    //        {
    //            _dataSet.SalesInvoice.RemoveSalesInvoiceRow(_dataSet.SalesInvoice[e.Item.DataSetIndex]);
    //            if (((DataGrid1.PageCount - DataGrid1.CurrentPageIndex) == 1 & DataGrid1.Items.Count == 1))
    //            {
    //                if ((DataGrid1.PageCount > 1))
    //                {
    //                    _lastEditedPage -= 1;
    //                }
    //                else
    //                {
    //                    _lastEditedPage = 0;
    //                }
    //            }
    //            DataGrid1.CurrentPageIndex = _lastEditedPage;
    //            BindGrid();
    //            getTotal();
    //        }


    //    }
    //}


    protected void dgVendor_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
         

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct VENDORNAME,VENDORCODE from webx_VENDOR_HDR where VENDOR_TYPE='15' Order By VENDORNAME", conn);
        conn.Close();
        da1.Fill(ds1, "webx_VENDOR_HDR");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList cboVendorName = ((DropDownList)e.Item.FindControl("cboVendorName"));
            cboVendorName.DataTextField = "VENDORNAME";
            cboVendorName.DataValueField = "VENDORCODE";
            cboVendorName.DataSource = ds1.Tables["webx_VENDOR_HDR"];
            cboVendorName.DataBind();
            cboVendorName.Items.Insert(0, "");
        }

 

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_PVendor = ((MyFleetDataSet.PartVendorRow)((DataRowView)e.Item.DataItem).Row);
            ((DropDownList)e.Item.FindControl("cboVendorName")).Text = datarow_PVendor.VendorName;
            ((TextBox)e.Item.FindControl("txtVendorPtNo")).Text = datarow_PVendor.VendorPNo;
            ((TextBox)e.Item.FindControl("txtMfg")).Text = datarow_PVendor.Mafg;
            ((TextBox)e.Item.FindControl("txtCost")).Text = datarow_PVendor.Cost;
            ((TextBox)e.Item.FindControl("txtLeadTime")).Text = datarow_PVendor.LeadTime;
 
        }

  }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string  mPart_Id="";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        AddEditMode = ViewState["AddEditMode"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        bool success = false;
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();


        try
        {

            if (AddEditMode.ToString().Trim() == "I")
            {
                string msql = "usp_CreateSparePartCode";
                SqlCommand cmd4 = new SqlCommand(msql, conn, trans);
                cmd4.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr4 = cmd4.ExecuteReader();
                if (dr4.HasRows)
                {
                    while (dr4.Read())
                    {
                        mPart_Id = Convert.ToString(dr4[0]);
                    }
                }
                dr4.Close();
            }
            else
            {
                mPart_Id=PartId;
            }
            string sql2 = "usp_SparePartHdrInsertUpdate";
            SqlCommand cmd2 = new SqlCommand(sql2, conn, trans);

            cmd2.CommandType = CommandType.StoredProcedure;

            
            cmd2.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.Trim();
            cmd2.Parameters.Add("@PartID", SqlDbType.VarChar).Value = mPart_Id.Trim();
            cmd2.Parameters.Add("@PartType", SqlDbType.VarChar).Value = cboPartType.SelectedItem.Value.Trim();
            cmd2.Parameters.Add("@PartCat", SqlDbType.VarChar).Value = "";
            cmd2.Parameters.Add("@SellPrice", SqlDbType.Decimal).Value = Convert.ToDecimal(txtSellPrice.Text.Trim());
            cmd2.Parameters.Add("@AvgCost", SqlDbType.Decimal).Value = Convert.ToDecimal(txtAvgCost.Text.Trim());
            cmd2.Parameters.Add("@Desc", SqlDbType.VarChar).Value = txtDesc.Text.Trim();
            cmd2.Parameters.Add("@UnitOfInv", SqlDbType.VarChar).Value = txtInvUnt.Text.Trim();
            cmd2.Parameters.Add("@ReorderPoint", SqlDbType.VarChar).Value = txtReorder.Text.Trim();
            cmd2.Parameters.Add("@ReorderQty", SqlDbType.Int).Value = Convert.ToInt32(txtReorderQry.Text.Trim());
            cmd2.Parameters.Add("@ExpDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtExpDate.Text.Trim(),dtfi);
            cmd2.Parameters.Add("@ExpKms", SqlDbType.Int).Value = Convert.ToInt32(txtExpKms.Text.Trim());
            cmd2.Parameters.Add("@W_GRPDC", SqlDbType.Int).Value = Convert.ToInt32(ddlWorkGroup.SelectedValue.ToString().Trim());
            cmd2.Parameters.Add("@TaskTypeId", SqlDbType.Int).Value = Convert.ToInt32(ddlTaskType.SelectedValue.Trim());  
            cmd2.ExecuteNonQuery();

            string sql3 = "Delete from Webx_Fleet_sparePartDet  where Part_Id='" + mPart_Id + "'";
            SqlCommand scmd2 = new SqlCommand(sql3, conn, trans);
            scmd2.ExecuteNonQuery();


            foreach(DataGridItem gridrow in dgVendor.Items)
            {
                string Vendor = ((DropDownList)gridrow.FindControl("cboVendorName")).SelectedItem.Value;

                string VendorPNo = ((TextBox)gridrow.FindControl("txtVendorPtNo")).Text;
                string Mafg = ((TextBox)gridrow.FindControl("txtMfg")).Text;
                string Cost = ((TextBox)gridrow.FindControl("txtCost")).Text;
                string LeadTime = ((TextBox)gridrow.FindControl("txtLeadTime")).Text;

                string sql1 = "usp_SparePartDetInsertUpdate";
                SqlCommand cmd1 = new SqlCommand(sql1, conn, trans);

                cmd1.CommandType = CommandType.StoredProcedure;

                cmd1.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.Trim();
                cmd1.Parameters.Add("@PartID", SqlDbType.VarChar).Value = mPart_Id;
                cmd1.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = Vendor.Trim();
                cmd1.Parameters.Add("@VendorPNo", SqlDbType.VarChar).Value = VendorPNo.Trim();
                cmd1.Parameters.Add("@Mafg", SqlDbType.VarChar).Value = Mafg;
                cmd1.Parameters.Add("@Cost", SqlDbType.Decimal).Value = Convert.ToDecimal(Cost);
                cmd1.Parameters.Add("@LeadTime", SqlDbType.VarChar).Value = LeadTime;

                cmd1.ExecuteNonQuery();
            }
           trans.Commit();
    //     trans.Rollback();
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
            string PartDesc = txtDesc.Text;
            Response.Redirect("SparePartResult.aspx?PartDesc=" + PartDesc);
        }
    }
    protected void dgVendor_ItemCommand(object source, DataGridCommandEventArgs e)
    {

        
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
               int count1 = 0;
           
                _dataSet.PartVendor.RemovePartVendorRow(_dataSet.PartVendor[e.Item.DataSetIndex]);
                if (((dgVendor.PageCount - dgVendor.CurrentPageIndex) == 1 & dgVendor.Items.Count == 1))
                {
                    if ((dgVendor.PageCount > 1))
                    {
                        _lastEditedPage -= 1;
                    }
                    else
                    {
                        _lastEditedPage = 0;
                    }
                }
                dgVendor.CurrentPageIndex = _lastEditedPage;
                BindGrid();


                foreach (DataGridItem gridrow in dgVendor.Items)
             
                {
                    count1 = count1 + 1;

                }


                txtRow.Text = count1.ToString();
        }
      



    }
}
