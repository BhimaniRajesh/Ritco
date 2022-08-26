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
using Microsoft.ApplicationBlocks.Data;
using ApplicationManager;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRoute : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable dt_WorkGroup = new MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable();
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
        if (!IsPostBack)
        {
            fn.Fill_Location_Dataset();
            BlankRow("1");
            BindGridVehicle();
            txtRouteType1.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType2.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType3.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType4.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType5.Attributes.Add("Onblur", "javascript:TrimCity(this);");


            //TdOption1.Visible = false;
            TdOption2.Visible = false;
            TdOption3.Visible = false;
            TdOption4.Visible = false;
            TdOption5.Visible = false;
            TdOption6.Visible = false;
            TdOption7.Visible = false;
            TdOption8.Visible = false;

            //Td2.Visible = false;
            //Td3.Visible = false;
            //Td4.Visible = false;
            //Td5.Visible = false;
            //Td6.Visible = false;
            //Td7.Visible = false;
            //Td8.Visible = false;

            //TdOption1Total.Visible = false;
            TdOption2Total.Visible = false;
            TdOption3Total.Visible = false;
            TdOption4Total.Visible = false;
            TdOption5Total.Visible = false;
            TdOption6Total.Visible = false;
            TdOption7Total.Visible = false;
            TdOption8Total.Visible = false;


            //TdOption1GTotal.Visible = false;
            TdOption2GTotal.Visible = false;
            TdOption3GTotal.Visible = false;
            TdOption4GTotal.Visible = false;
            TdOption5GTotal.Visible = false;
            TdOption6GTotal.Visible = false;
            TdOption7GTotal.Visible = false;
            TdOption8GTotal.Visible = false;
        }
    }


    protected void btnFinalSubmit_Click(object sender, EventArgs e)
    {
        if (TdOption1.Visible == true)
        {
        }
        if (TdOption2.Visible == true && TdOption1.Visible == true)
        {
        }
        if (TdOption3.Visible == true && TdOption2.Visible == true && TdOption1.Visible == true)
        {


        }
        if (TdOption4.Visible == true && TdOption3.Visible == true && TdOption2.Visible == true && TdOption1.Visible == true)
        {

        }
        if (TdOption5.Visible == true && TdOption4.Visible == true && TdOption3.Visible == true && TdOption2.Visible == true && TdOption1.Visible == true)
        {


        }
    }


    protected void BindGridVehicle()
    {
        MyDataSet.DCRSeriesRow datarow;

        //LinkButton clickedLinkButton = (LinkButton);
        //if (clickedLinkButton == null)
        //    return;

        //if (clickedLinkButton.ID == "AddRow")
        //{
        //    DataView dv = ds.DCRSeries.DefaultView;
        //    dgGeneral.DataSource = dv;
        //    dgGeneral.DataBind();
        //}

        //if (clickedLinkButton.ID == "AddRow2")
        //{

        //    DataView dv2 = ds.DCRSeries.DefaultView;
        //    dgGeneral2.DataSource = dv2;
        //    dgGeneral2.DataBind();
        //}

    }


    protected MyDataSet.DCRSeriesRow GetDataRow(int rowIndex)
    {
        MyDataSet.DCRSeriesRow _mydatarow;
        _mydatarow = ds.DCRSeries[rowIndex];

        _mydatarow.SrNo = Convert.ToString((rowIndex + 1)).Trim();
        //_mydatarow.BookCode = ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtBookCode")).Text;
        //_mydatarow.SeriesFrom = ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtSeriesFrom")).Text;
        //_mydatarow.AlloteTo = ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtAlloteTo")).Text;

        return _mydatarow;
    }  
    protected void MyDataRows()
    {
        srno = "";
        MyDataSet.DCRSeriesRow datarow;

        //LinkButton clickedLinkButton = (LinkButton);
        //if (clickedLinkButton == null)
        //    return;

        //if (clickedLinkButton.ID == "AddRow")
        //{
        //    foreach (GridViewRow gr in dgGeneral.Rows)
        //    {
        //        if (gr.RowIndex != -1)
        //        {
        //            srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //            BlankRow("");
        //            datarow = ds.DCRSeries[gr.RowIndex];
        //            datarow = GetDataRow(gr.RowIndex);
        //            ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //        }
        //    }
        //}

        //if (clickedLinkButton.ID == "AddRow2")
        //{

        //    foreach (GridViewRow gr in dgGeneral2.Rows)
        //    {
        //        if (gr.RowIndex != -1)
        //        {
        //            srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //            BlankRow("");
        //            datarow = ds.DCRSeries[gr.RowIndex];
        //            datarow = GetDataRow(gr.RowIndex);
        //            ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //        }
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral3.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral4.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral5.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral6.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral7.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
        //foreach (GridViewRow gr in dgGeneral8.Rows)
        //{
        //    if (gr.RowIndex != -1)
        //    {
        //        srno = Convert.ToString(gr.RowIndex + 2).Trim();
        //        BlankRow("");
        //        datarow = ds.DCRSeries[gr.RowIndex];
        //        datarow = GetDataRow(gr.RowIndex);
        //        ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
        //    }
        //}
    }



    protected void BlankRow(string srno)
    {
        ds.DCRSeries.AddDCRSeriesRow(srno, "", "", "");
    }

    protected void AddNewRow(Object sender, EventArgs e)
    {
        //if (dgGeneral.Rows.Count < 10 || dgGeneral2.Rows.Count < 10 || dgGeneral3.Rows.Count < 10 || dgGeneral4.Rows.Count < 10 || dgGeneral5.Rows.Count < 10 || dgGeneral6.Rows.Count < 10 || dgGeneral7.Rows.Count < 10 || dgGeneral8.Rows.Count < 10)
        //{
        MyDataRows();
        BlankRow(srno);
        BindGridVehicle();
        //}

        //LinkButton clickedLinkButton = sender as LinkButton;
        //if (clickedLinkButton == null)
        //    return;

        //if (clickedLinkButton.ID == "AddRow")
        //{

        //}
        //else if (clickedLinkButton.ID == "AddRow2")
        //{
        //}
        //if (clickedLinkButton.ID == "AddRow3")
        //{
        //}
        //else if (clickedLinkButton.ID == "AddRow4")
        //{
        //}
        //if (clickedLinkButton.ID == "AddRow5")
        //{
        //}
        //else if (clickedLinkButton.ID == "AddRow6")
        //{
        //}
        //if (clickedLinkButton.ID == "AddRow7")
        //{
        //}
        //else if (clickedLinkButton.ID == "AddRow8")
        //{
        //}

    }

    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cboBusType = (DropDownList)e.Row.FindControl("cboBusType");

            DropDownList cbo = (DropDownList)e.Row.FindControl("cboDocType");
            Label lblNA = (Label)e.Row.FindControl("lblNA");
            //ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString, CommandType.StoredProcedure, "usp_Documents");
            DataSet newds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_Documents");
            cbo.DataSource = newds1;
            cbo.DataBind();

            //cboBusType.DataSource = getBusinessType();
            //cboBusType.DataTextField = "CodeDesc";
            //cboBusType.DataValueField = "CodeID";
            //cboBusType.DataBind();
            //cbo.SelectedValue = "DKT";
            //if (cbo.Items[0].Value == "DKT")
            //{
            //    cboBusType.Visible = true;
            //    lblNA.Visible = false;
            //}
            //else
            //{
            //    cboBusType.Visible = false;
            //    lblNA.Visible = true;
            //}
        }
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteRow")
        {
            MyDataRows();
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            if (((GridView)(sender)).Rows.Count > 1)
            {
                MyDataSet.DCRSeriesRow dsRow;
                dsRow = ds.DCRSeries[thisRow];
                ds.DCRSeries.RemoveDCRSeriesRow(dsRow);
                BindGridVehicle();
            }
        }
    }

    //protected string GenerateArgument()
    //{
    //    string arg = "";
    //    for (int index = 0; index < dgGeneral.Rows.Count; index++)
    //    {
    //        //BOOKCODE^DOC_TYPE^DOC_NO^LEAFS^AlloteTo
    //        DropDownList cboDocType = (DropDownList)dgGeneral.Rows[index].FindControl("cboDocType");
    //        TextBox txtBookCode = (TextBox)dgGeneral.Rows[index].FindControl("txtBookCode");
    //        TextBox txtSeriesFrom = (TextBox)dgGeneral.Rows[index].FindControl("txtSeriesFrom");
    //        DropDownList cboLeafs = (DropDownList)dgGeneral.Rows[index].FindControl("cboTotalLeafs");
    //        TextBox txtAlloteTo = (TextBox)dgGeneral.Rows[index].FindControl("txtAlloteTo");

    //        DropDownList cboBusType = (DropDownList)dgGeneral.Rows[index].FindControl("cboBusType");

    //        if (index == 0)
    //        {
    //            arg = txtBookCode.Text.Trim() + "^" + cboDocType.Text.Trim() + "^" + txtSeriesFrom.Text.Trim() + "^" + cboLeafs.Text.Trim() + "^" + txtAlloteTo.Text.Trim();
    //            if (cboDocType.SelectedValue == "DKT")
    //                arg = arg + "^" + cboBusType.SelectedValue.Trim();
    //            else
    //                arg = arg + "^-1";
    //        }
    //        else
    //        {
    //            arg = arg + "," + txtBookCode.Text.Trim() + "^" + cboDocType.Text.Trim() + "^" + txtSeriesFrom.Text.Trim() + "^" + cboLeafs.Text.Trim() + "^" + txtAlloteTo.Text.Trim();
    //            if (cboDocType.SelectedValue == "DKT")
    //                arg = arg + "^" + cboBusType.SelectedValue.Trim();
    //            else
    //                arg = arg + "^-1";
    //        }
    //    }
    //    return arg;
    //}


    //protected void btnSaveSeries_Click(object sender, EventArgs e)
    //{
    //    lblResultHdr.Text = "Recent Result :";
    //    //ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString, CommandType.StoredProcedure, "usp_DCR_Insert_Multiple2", new SqlParameter("@doc_array", GenerateArgument()), new SqlParameter("@entryby", Session["empcd"].ToString().Trim()));
    //    ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_DCR_Insert_Multiple2", new SqlParameter("@doc_array", GenerateArgument()), new SqlParameter("@entryby", Session["empcd"].ToString().Trim()));
    //    dgResult.DataSource = ds1;
    //    dgResult.DataBind();
    //}

    private void getLoginBrLevel()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "Select Loc_Level From WebX_Location Where LocCode='" + Session["brcd"].ToString().Trim() + "'";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.Text;

        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            LoginBrLevel = dr[0].ToString().Trim();
        }
    }

    protected void dg_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cbo = (DropDownList)e.Row.FindControl("cboDocType");
            //ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString, CommandType.StoredProcedure, "usp_Documents");
            ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_Documents");
            cbo.DataSource = ds1;
            cbo.DataBind();
        }
    }

    private DataSet getBusinessType()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string cmd = "SELECT CodeId,CodeDesc FROM webx_master_general where CodeType='BUT'";
        DataSet dset = SqlHelper.ExecuteDataset(sqlCon, CommandType.Text, cmd);
        return dset;
    }
}
