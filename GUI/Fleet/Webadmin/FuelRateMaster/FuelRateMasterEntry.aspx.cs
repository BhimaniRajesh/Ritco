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
using ApplicationManager;

public partial class FuelRateMasterEntry : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.WEBX_FLEET_FuelRateMSTRow datarow_Wgrp;
    MyFleetDataSet.WEBX_FLEET_FuelRateMSTDataTable dt_WorkGroup = new MyFleetDataSet.WEBX_FLEET_FuelRateMSTDataTable();
    MyFunctions fn = new MyFunctions();

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
            fn.Fill_Vendor_Dataset_Fuel();
            WorkGroupList();
            //Do Work
            txtRow.Text = "0";
        }
    }
    public void WorkGroupList()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //string str = "usp_WorkGroupList";
        //SqlCommand cmd = new SqlCommand(str, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@GroupCode", System.Data.SqlDbType.VarChar).Value = '0';
        //SqlDataReader dr = cmd.ExecuteReader();
        //ddlWorkGroup.Items.Insert(0, "");
        //if (dr.HasRows)
        //{
        //    while (dr.Read())
        //    {
        //        ddlWorkGroup.Items.Add(new ListItem(dr["W_GRPDESC"].ToString(), dr["W_GRPCD"].ToString()));
        //    }
        //}
        //dr.Close();
        //conn.Close();
    }

    public void BindTaskType(DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "USP_General_FuelTypeList";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr["TaskType"]), Convert.ToString(dr["TaskTypeId"])));
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





    protected void dgWorkgroup_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        string VendorName = "", Vendorcode = "";
        string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');

        if (Txt_Vendor.Text.ToString() != "")
        {
            VendorName = Vendor_Cls_Arr[0];
            Vendorcode = Vendor_Cls_Arr[1];
        }

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds1 = new DataSet();
        string str1 = "select [Srno],[Vend_Code],(Select Location from webx_citymaster where convert(varchar,city_code)=From_City )as [From_City],[Fuel_Type],[Rate],[Active] from WEBX_FLEET_FuelRateMST  Where Vend_Code='" + Vendorcode.ToString().Trim() + "'";
        SqlDataAdapter da1 = new SqlDataAdapter("select   codeID ,codedesc  from WEBX_MASTER_GENERAL where  CodeType='FUELTY' and statuscode='Y'  order by codedesc ", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_MASTER_GENERAL");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            BindTaskType((DropDownList)e.Item.FindControl("ddlFuelType"));
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Wgrp = ((MyFleetDataSet.WEBX_FLEET_FuelRateMSTRow)((DataRowView)e.Item.DataItem).Row);

            TextBox txtFromCity = (TextBox)e.Item.FindControl("txtFromCity");
            DropDownList ddlFuelType = (DropDownList)e.Item.FindControl("ddlFuelType");
            TextBox txtRate = (TextBox)e.Item.FindControl("txtRate");
            CheckBox ckh_Active_Flag = (CheckBox)e.Item.FindControl("ckh_Active_Flag");
            HiddenField hfTaskCd = (HiddenField)e.Item.FindControl("hfTaskCd");
            HiddenField hfFromCity = (HiddenField)e.Item.FindControl("hfFromCity");
            hfTaskCd.Value = datarow_Wgrp.TaskTYP;
            txtFromCity.Text = datarow_Wgrp.FromCity;
            ddlFuelType.SelectedValue = datarow_Wgrp.FuelType;
            txtRate.Text = datarow_Wgrp.Rate;
            if (datarow_Wgrp.Active == "Y")
            {
                ckh_Active_Flag.Checked = true;
            }
            else
            {
                ckh_Active_Flag.Checked = false;
            }

            txtFromCity.Attributes.Add("OnBlur", "javascript:return CheckFromValidCityN( " + txtFromCity.ClientID.ToString().Trim() + ", " + hfFromCity.ClientID.ToString().Trim() + ")");
        }
    }
    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        string VendorName = "", Vendorcode = "";
        string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');

        if (Txt_Vendor.Text.ToString() != "")
        {
            VendorName = Vendor_Cls_Arr[0];
            Vendorcode = Vendor_Cls_Arr[1];
        }

        int TotRec = 0;
        string W_GRPCD = "";
        string FromCity = "";
        string FuelType = "";
        string Rate = "";
        string Active = "";
        string TaskTYP = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str1 = "select [Srno],[Vend_Code],(Select Location from webx_citymaster where convert(varchar,city_code)=From_City )as [From_City],[Fuel_Type],[Rate],[Active] from WEBX_FLEET_FuelRateMST Where Vend_Code='" + Vendorcode.ToString().Trim() + "'";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        SqlDataReader mdr1 = cmd1.ExecuteReader();
        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                TotRec = TotRec + 1;
                W_GRPCD = Convert.ToString(mdr1["Vend_Code"]);
                if (FromCity == "")
                {
                    FromCity = Convert.ToString(mdr1["From_City"]);
                }
                else
                {
                    FromCity = FromCity + "," + Convert.ToString(mdr1["From_City"]);
                }
                if (FuelType == "")
                {
                    FuelType = Convert.ToString(mdr1["Fuel_Type"]);
                }
                else
                {

                    FuelType = FuelType + "," + Convert.ToString(mdr1["Fuel_Type"]);
                }
                if (Rate == "")
                {
                    Rate = Convert.ToString(mdr1["Rate"]);
                }
                else
                {
                    Rate = Rate + "," + Convert.ToString(mdr1["Rate"]);
                }
                if (Active == "")
                {
                    Active = Convert.ToString(mdr1["Active"]);
                }
                else
                {
                    Active = Active + "," + Convert.ToString(mdr1["Active"]);
                }
                if (TaskTYP == "")
                {
                    TaskTYP = Convert.ToString(mdr1["Srno"]);
                }
                else
                {
                    TaskTYP = TaskTYP + "," + Convert.ToString(mdr1["Srno"]);
                }
            }
        }

        string[] Arr_FromCity;
        string[] Arr_FuelType;
        string[] Arr_Rate;
        string[] Arr_Active;
        string[] Arr_TaskTYP;

        Arr_FromCity = FromCity.Split(new Char[] { ',' });
        Arr_FuelType = FuelType.Split(new Char[] { ',' });
        Arr_Rate = Rate.Split(new Char[] { ',' });
        Arr_Active = Active.Split(new Char[] { ',' });
        Arr_TaskTYP = TaskTYP.Split(new Char[] { ',' });

        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";

        for (int i = 0; i < (Convert.ToInt32(txtRow.Text) + dgWorkgroup.Items.Count); i++)
        {
            if (TotRec > i)
            {
                dt_WorkGroup.AddWEBX_FLEET_FuelRateMSTRow("", Arr_FromCity[i], Arr_FuelType[i], Arr_Rate[i], Arr_Active[i], Arr_TaskTYP[i]);
            }
            else
            {
                dt_WorkGroup.AddWEBX_FLEET_FuelRateMSTRow("", "", "", "", "", "");
            }
        }

        txtRow.Text = "0";
        BindGrid();
    }

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
        string VendorName = "", Vendorcode = "";
        string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');

        if (Txt_Vendor.Text.ToString() != "")
        {
            VendorName = Vendor_Cls_Arr[0];
            Vendorcode = Vendor_Cls_Arr[1];
        }
        string WGrp = "";
        lblError.Text = "";

        string mDesc = "";
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
                foreach (DataGridItem gridrow in dgWorkgroup.Items)
                {

                    TextBox txtFromCity = (TextBox)gridrow.FindControl("txtFromCity");
                    DropDownList ddlFuelType = (DropDownList)gridrow.FindControl("ddlFuelType");
                    TextBox txtRate = (TextBox)gridrow.FindControl("txtRate");
                    CheckBox ckh_Active_Flag = (CheckBox)gridrow.FindControl("ckh_Active_Flag");
                    HiddenField hfTaskCd = (HiddenField)gridrow.FindControl("hfTaskCd");
                    HiddenField hfFromCity = (HiddenField)gridrow.FindControl("hfFromCity");

                    string str = "usp_Insert_WEBX_FLEET_FuelRateMST";
                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Vendorcode", SqlDbType.VarChar).Value = Vendorcode.ToString().Trim();
                    cmd.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = txtFromCity.Text.ToString().Trim();
                    //cmd.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = hfFromCity.value.ToString().Trim();
                    cmd.Parameters.Add("@FuelType", SqlDbType.VarChar).Value = ddlFuelType.SelectedValue.ToString().Trim();
                    cmd.Parameters.Add("@Rate", SqlDbType.Float).Value = Convert.ToDouble(txtRate.Text.ToString().Trim());
                    cmd.Parameters.Add("@ACTIVE_FLAG", SqlDbType.VarChar).Value = (ckh_Active_Flag.Checked == true) ? "Y" : "N";
                    cmd.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString();
                    cmd.Parameters.Add("@Update_BY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString();
                    cmd.Parameters.Add("@TASKTYP", SqlDbType.Int).Value = (hfTaskCd.Value == "") ? 0 : Convert.ToInt32(hfTaskCd.Value);
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
                Response.Redirect("TripRouteExpDone.aspx");
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

    protected void Txt_Vendor_OnChange(object sender, EventArgs e)
    {
        string VendorName = "", Vendorcode = "";
        string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');

        if (Txt_Vendor.Text.ToString() != "")
        {
            VendorName = Vendor_Cls_Arr[0];
            Vendorcode = Vendor_Cls_Arr[1];
        }
        //added by anupam
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string str1 = "Select [W_GRPCD],[TASKCD],[TASKDESC],[LABOUR_HRS],[ACTIVE_FLAG],[TASKTYP] From WEBX_FLEET_GENERALTASKMST Where W_GRPCD=" + ddlWorkGroup.SelectedValue.ToString().Trim();
        string str1 = "select [Srno],[Vend_Code],(Select Location from webx_citymaster where convert(varchar,city_code)=From_City )as [From_City],[Fuel_Type],[Rate],[Active] from WEBX_FLEET_FuelRateMST Where Vend_Code='" + Vendorcode.ToString().Trim() + "'";
        SqlCommand cmd1 = new SqlCommand(str1, conn);
        SqlDataReader mdr1 = cmd1.ExecuteReader();

        if (mdr1.HasRows)
        {
            while (mdr1.Read())
            {
                string W_GRPCD = Convert.ToString(mdr1["Vend_Code"]);
                string FromCity = Convert.ToString(mdr1["From_City"]);
                string FuelType = Convert.ToString(mdr1["Fuel_Type"]);
                string Rate = Convert.ToString(mdr1["Rate"]);
                string Active = Convert.ToString(mdr1["Active"]);
                string TaskTYP = Convert.ToString(mdr1["Srno"]);

                dt_WorkGroup.AddWEBX_FLEET_FuelRateMSTRow(W_GRPCD, FromCity, FuelType, Rate, Active, TaskTYP);
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
        //added by anupam
    }
}