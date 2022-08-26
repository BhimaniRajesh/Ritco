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

public partial class GUI_Fleet_Operations_Expense_ExpenseVoucherAdd : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.EnExpense1Row datarow_Exp1;
    MyFleetDataSet.EnExpense2Row datarow_Exp2;
    MyFleetDataSet.EnExpense3Row datarow_Exp3;
    MyFleetDataSet.EnExpense4Row datarow_Exp4;
    MyFleetDataSet.FEnExpenseRow datarow_Exp;

    int k = 0, l = 0, m = 0, n = 0;

    int mDataCount1 = 6, mDataCount2 = 3, mDataCount3 = 1, mDataCount4 = 2;
    int mDataCount = 7;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack && !IsCallback)
        {
            if (mDataCount1 == 6)
            {
                txtRow1.Text = mDataCount1.ToString();
            }

            if (mDataCount2 == 3)
            {

                txtRow2.Text = mDataCount2.ToString();
            }

            if (mDataCount3 == 1)
            {

                txtRow3.Text = mDataCount3.ToString();
            }

            if (mDataCount4 == 2)
            {

                txtRow4.Text = mDataCount4.ToString();
            }

            if (mDataCount == 7)
            {
                txtRow.Text = mDataCount.ToString();
            }
         

            Inetial();
        }
    }


    public void Inetial()
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;


        rowno = txtRow1.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense1.Items)
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
                _dataSet.EnExpense1.RemoveEnExpense1Row(_dataSet.EnExpense1[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow1.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense1.AddEnExpense1Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense1.AddEnExpense1Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid1();



        mroww = 0;
        miroww = 0;
        rowno = txtRow2.Text;
        mroww = Convert.ToInt16(rowno);



        iroww = 0;
        foreach (DataGridItem gridrow in dgExpense2.Items)
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
                _dataSet.EnExpense2.RemoveEnExpense2Row(_dataSet.EnExpense2[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow2.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense2.AddEnExpense2Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense2.AddEnExpense2Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid2();




        mroww = 0;
        miroww = 0;
        rowno = txtRow3.Text;
        mroww = Convert.ToInt16(rowno);



        iroww = 0;
        foreach (DataGridItem gridrow in dgExpense3.Items)
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
                _dataSet.EnExpense3.RemoveEnExpense3Row(_dataSet.EnExpense3[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow3.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense3.AddEnExpense3Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense3.AddEnExpense3Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid3();



        mroww = 0;
        miroww = 0;
        rowno = txtRow4.Text;
        mroww = Convert.ToInt16(rowno);



        iroww = 0;
        foreach (DataGridItem gridrow in dgExpense4.Items)
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
                _dataSet.EnExpense4.RemoveEnExpense4Row(_dataSet.EnExpense4[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow4.Text); i++)
        {
            int j = i + 1;

            if (i == 0)
            {
                _dataSet.EnExpense4.AddEnExpense4Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense4.AddEnExpense4Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid4();





        mroww = 0;
        miroww = 0;


        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);

        iroww = 0;
        foreach (DataGridItem gridrow in dgExpense.Items)
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
                _dataSet.FEnExpense.RemoveFEnExpenseRow(_dataSet.FEnExpense[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid();

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
        foreach (DataGridItem gridrow in dgExpense.Items)
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
                _dataSet.FEnExpense.RemoveFEnExpenseRow(_dataSet.FEnExpense[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid();


    }

    //protected void txtRow_TextChanged(object sender, EventArgs e)
    //{
    //    string rowno;
    //    int mroww = 0;
    //    int miroww = 0;
    //    int miroww1 = 0;
    //    rowno = txtRow1.Text;
    //    mroww = Convert.ToInt16(rowno);
    //    int i;
    //    miroww1 = mroww;

    //    int iroww = 0;
    //    foreach (DataGridItem gridrow in dgExpense1.Items)
    //    {
    //        iroww = iroww + 1;
    //    }
    //    miroww = iroww;

    //    if (mroww < miroww)
    //    {
    //        miroww = mroww;
    //    }


    //    if (iroww >= 0)
    //    {
    //        for (i = iroww - 1; i > -1 + miroww; i--)
    //        {
    //            _dataSet.EnExpense1.RemoveEnExpense1Row(_dataSet.EnExpense1[i]);
    //        }
    //    }



    //    for (i = 0 + miroww; i < Int16.Parse(txtRow1.Text); i++)
    //    {
    //        int j = i + 1;
    //        if (i == 0)
    //        {
    //            _dataSet.EnExpense1.AddEnExpense1Row(j.ToString(), "", "", "", "", "");
    //        }
    //        else
    //        {

    //            _dataSet.EnExpense1.AddEnExpense1Row(j.ToString(), "", "", "", "", "");
    //        }

    //    }

    //    BindGrid1();

    //}




   /* protected void txtRow_TextChanged(object sender, EventArgs e)
    {


        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtRow1.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense1.Items)
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
                _dataSet.EnExpense1.RemoveEnExpense1Row(_dataSet.EnExpense1[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow1.Text); i++)
        {

            if (i == 0)
            {
                _dataSet.EnExpense1.AddEnExpense1Row("", "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense1.AddEnExpense1Row("", "", "", "", "", "");
            }

        }

        BindGrid1();


    }*/


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
        dgExpense1.DataSource = _dataSet.EnExpense1;
        dgExpense1.DataBind();
        _lastEditedPage = dgExpense1.CurrentPageIndex;

    }
    public void BindGrid2()
    {
        dgExpense2.DataSource = _dataSet.EnExpense2;
        dgExpense2.DataBind();
        _lastEditedPage = dgExpense2.CurrentPageIndex;
    }


    public void BindGrid3()
    {
        dgExpense3.DataSource = _dataSet.EnExpense3;
        dgExpense3.DataBind();
        _lastEditedPage = dgExpense3.CurrentPageIndex;

    }

    public void BindGrid4()
    {
        dgExpense4.DataSource = _dataSet.EnExpense4;
        dgExpense4.DataBind();
        _lastEditedPage = dgExpense4.CurrentPageIndex;
    }

    public void BindGrid()
    {
        dgExpense.DataSource = _dataSet.FEnExpense;
        dgExpense.DataBind();
        _lastEditedPage = dgExpense.CurrentPageIndex;

    }


    protected void txtVehNo_TextChanged(object sender, EventArgs e)
    {
        string Driver_WO_Vehicle = "N";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        foreach (DataGridItem gridrow in dgExpense1.Items)
        {
            string DataF = "N";

            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {
                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }
            }


        }


        //2 nd  grid

        foreach (DataGridItem gridrow in dgExpense2.Items)
        {
            string DataF = "N";

            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {
                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }
            }


        }
        //3 rd  grid


        foreach (DataGridItem gridrow in dgExpense3.Items)
        {
            string DataF = "N";

            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {
                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }
            }


        }
        //4 th grid


        foreach (DataGridItem gridrow in dgExpense4.Items)
        {
            string DataF = "N";

            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {
                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }
            }


        }






    }
    protected void dgExpense_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='FEXP' and codeid in ('01','02','03','04','05','06')    Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp1 = ((MyFleetDataSet.EnExpense1Row)((DataRowView)e.Item.DataItem).Row);

            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());

            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;


            ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp1.VehicleNo;
            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU1(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");

            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp1.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp1.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp1.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp1.Remarks;

        }

    }






    protected void dgExpense2_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='FEXP'  and codeid in ('07','08','09')   Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp2 = ((MyFleetDataSet.EnExpense2Row)((DataRowView)e.Item.DataItem).Row);


            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());

            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;
            ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp2.VehicleNo;
            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU2(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp2.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp2.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp2.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp2.Remarks;


        }

    }


    protected void dgExpense3_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='FEXP' and codeid in ('10')      Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp3 = ((MyFleetDataSet.EnExpense3Row)((DataRowView)e.Item.DataItem).Row);


            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());
            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;
            ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp3.VehicleNo;

            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU3(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");


            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp3.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp3.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp3.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp3.Remarks;


        }

    }

    protected void dgExpense4_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='FEXP'  and codeid in ('11','12')   Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp4 = ((MyFleetDataSet.EnExpense4Row)((DataRowView)e.Item.DataItem).Row);

            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());

            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;

            ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp4.VehicleNo;
            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU4(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");

            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp4.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp4.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp4.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp4.Remarks;


        }

    }


    protected void dgExpenseRepair_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='VEXP' Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp = ((MyFleetDataSet.FEnExpenseRow)((DataRowView)e.Item.DataItem).Row);





            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());
            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;



            ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp.VehicleNo;

            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp.Remarks;


        }

    }

    protected void txtRow2_TextChanged(object sender, EventArgs e)
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;
        int miroww1 = 0;
        rowno = txtRow2.Text;
        mroww = Convert.ToInt16(rowno);
        int i;
        miroww1 = mroww;

        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense2.Items)
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
                _dataSet.EnExpense2.RemoveEnExpense2Row(_dataSet.EnExpense2[i]);
            }
        }

        //if (miroww1 > iroww-1)
        //{
        //    for (i = iroww ; iroww - 1 < -1 + miroww; i--)
        //    {
        //        _dataSet.EnExpense2.RemoveEnExpense2Row(_dataSet.EnExpense2[i]);
        //    }
        //}




        for (i = 0 + miroww; i < Int16.Parse(txtRow2.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense2.AddEnExpense2Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense2.AddEnExpense2Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid2();

    }
    protected void txtRow4_TextChanged(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtRow4.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense4.Items)
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
                _dataSet.EnExpense4.RemoveEnExpense4Row(_dataSet.EnExpense4[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow4.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense4.AddEnExpense4Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense4.AddEnExpense4Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid4();


    }


    protected void txtRow3_TextChanged(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtRow3.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense3.Items)
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
                _dataSet.EnExpense3.RemoveEnExpense3Row(_dataSet.EnExpense3[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow3.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.EnExpense3.AddEnExpense3Row(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.EnExpense3.AddEnExpense3Row(j.ToString(), "", "", "", "", "");
            }

        }

        BindGrid4();


    }
    protected void SubmitData(object sender, EventArgs e)
    {

    }

}
