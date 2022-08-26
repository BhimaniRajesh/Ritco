using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_dcr_add : System.Web.UI.Page
{
    MyDataSet ds = new MyDataSet();

    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        getLoginBrLevel();

        if (LoginBrLevel != "1")
        {
            Response.Redirect("~/GUI/ADMIN/dcr_series_alloted.aspx");
        }

        if (!IsPostBack)
        {
            BlankRow("1");
            BindGrid();
        }
    }

    protected void BindGrid()
    {
        DataView dv = ds.DCRSeries.DefaultView;
        dgGeneral.DataSource = dv;
        dgGeneral.DataBind();
    }


    protected MyDataSet.DCRSeriesRow GetDataRow(int rowIndex)
    {
        MyDataSet.DCRSeriesRow _mydatarow;
        _mydatarow = ds.DCRSeries[rowIndex];

        _mydatarow.SrNo = Convert.ToString((rowIndex + 1)).Trim();
        _mydatarow.BookCode   =   ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtBookCode")).Text;
        _mydatarow.SeriesFrom = ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtSeriesFrom")).Text;
        _mydatarow.AlloteTo = ((TextBox)dgGeneral.Rows[rowIndex].FindControl("txtAlloteTo")).Text;

        return _mydatarow;
    }
    protected void MyDataRows()
    {
        srno="";
        MyDataSet.DCRSeriesRow datarow;
        //DropDownList cbo;
        foreach (GridViewRow gr in dgGeneral.Rows)
        {
            if (gr.RowIndex != -1)
            {
                srno = Convert.ToString(gr.RowIndex+2).Trim();
                BlankRow("");
                datarow = ds.DCRSeries[gr.RowIndex];
                datarow = GetDataRow(gr.RowIndex);
                ds.DCRSeries[gr.RowIndex].ItemArray = datarow.ItemArray;
            }
        }

        //if(srno!="") BlankRow(srno);
    }



    protected void BlankRow(string srno)
    {
      ds.DCRSeries.AddDCRSeriesRow(srno, "", "", "");
    }

    protected void AddNewRow(Object sender, EventArgs e)
    {
        if (dgGeneral.Rows.Count < 10)
        {
        MyDataRows();
        BlankRow(srno);
        BindGrid();
        }    
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
            
            cboBusType.DataSource = getBusinessType();
            cboBusType.DataTextField = "CodeDesc";
            cboBusType.DataValueField = "CodeID";
            cboBusType.DataBind();
            cbo.SelectedValue = "DKT";
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
                BindGrid();
            }
        }
    }
    
    protected string GenerateArgument()
    {
        string arg="";
        for (int index = 0; index < dgGeneral.Rows.Count; index++)
        {
            //BOOKCODE^DOC_TYPE^DOC_NO^LEAFS^AlloteTo
            DropDownList cboDocType = (DropDownList)dgGeneral.Rows[index].FindControl("cboDocType");
            TextBox txtBookCode = (TextBox)dgGeneral.Rows[index].FindControl("txtBookCode");
            TextBox txtSeriesFrom = (TextBox)dgGeneral.Rows[index].FindControl("txtSeriesFrom");
            DropDownList cboLeafs = (DropDownList)dgGeneral.Rows[index].FindControl("cboTotalLeafs");
            TextBox txtAlloteTo = (TextBox)dgGeneral.Rows[index].FindControl("txtAlloteTo");

            DropDownList cboBusType = (DropDownList)dgGeneral.Rows[index].FindControl("cboBusType");

            if (index == 0)
            {
                arg = txtBookCode.Text.Trim() + "^" + cboDocType.Text.Trim() + "^" + txtSeriesFrom.Text.Trim() + "^" + cboLeafs.Text.Trim() + "^" + txtAlloteTo.Text.Trim();
                if (cboDocType.SelectedValue == "DKT")
                    arg = arg + "^" + cboBusType.SelectedValue.Trim();
                else
                    arg = arg + "^-1";
            }
            else
            {
                arg = arg + "," + txtBookCode.Text.Trim() + "^" + cboDocType.Text.Trim() + "^" + txtSeriesFrom.Text.Trim() + "^" + cboLeafs.Text.Trim() + "^" + txtAlloteTo.Text.Trim();
                if (cboDocType.SelectedValue == "DKT")
                    arg = arg + "^" + cboBusType.SelectedValue.Trim();
                else
                    arg = arg + "^-1";
            }
        }
        return arg;
    }


    protected void btnSaveSeries_Click(object sender, EventArgs e)
    {
        lblResultHdr.Text = "Recent Result :";
        //ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString, CommandType.StoredProcedure, "usp_DCR_Insert_Multiple2", new SqlParameter("@doc_array", GenerateArgument()), new SqlParameter("@entryby", Session["empcd"].ToString().Trim()));
        ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_DCR_Insert_Multiple2", new SqlParameter("@doc_array", GenerateArgument()), new SqlParameter("@entryby", Session["empcd"].ToString().Trim()));
        dgResult.DataSource = ds1;
        dgResult.DataBind();
    }

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
        string cmd = "SELECT CodeId,CodeDesc FROM webx_master_general where CodeType='BUT' AND StatusCode = 'Y'";
        DataSet dset = SqlHelper.ExecuteDataset(sqlCon, CommandType.Text, cmd);
        return dset;
    }

    protected void cboDocType_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow dr in dgGeneral.Rows)
        {
            if (dr.RowType == DataControlRowType.DataRow)
            {
                DropDownList cboBusType = (DropDownList)dr.FindControl("cboBusType");
                DropDownList cboDocType = (DropDownList)dr.FindControl("cboDocType");
                Label lblNA = (Label)dr.FindControl("lblNA");
                if (cboDocType.SelectedValue == "DKT")
                {
                    cboBusType.Visible = true;
                    lblNA.Visible = false;
                    //cboBusType.DataSource = getBusinessType();
                    //cboBusType.DataTextField = "CodeDesc";
                    //cboBusType.DataValueField = "CodeID";
                    //cboBusType.DataBind();
                }
                else
                {
                    cboBusType.Visible = false;
                    lblNA.Visible = true;
                }
            }
        }
    }
}
