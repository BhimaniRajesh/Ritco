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

public partial class TripRouteExpMst : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.WEBX_TRIP_ROUTE_EXP_FUELDataTable dt_TripRouteExp = new MyFleetDataSet.WEBX_TRIP_ROUTE_EXP_FUELDataTable(); 
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            conn.ConnectionString = Session["SqlProvider"].ToString().Trim();
            BindDropDown("USP_TRIPROUTEMST", "RUTDESC", "RUTCD", ddlRoute);
            dt_TripRouteExp.AddWEBX_TRIP_ROUTE_EXP_FUELRow("", "", "", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["Id"] != null)
            {
                RowNo.Visible = false;
                GetValue(Request.QueryString["Id"].ToString());
            }
            //script = @"<SCRIPT language='javascript'> PageLoad();" + "</SCRIPT>";
            //this.RegisterStartupScript("MyAlert", script);
            
        }
    }
    public void GetValue(string ID)
    {
        TripRouteFuelExp objTripRouteExp = new TripRouteFuelExp(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        objTripRouteExp.ROUTE_CODE = ddlRoute.SelectedValue;
       
        ds = objTripRouteExp.GetFuelExpDetails(ID);
        
        foreach (GridViewRow gvr in gvTripRouteExp.Rows)
        {
            DropDownList ddl_Vehicle_type = (DropDownList)gvr.FindControl("ddl_Vehicle_type");
            TextBox tb_KMPL = (TextBox)gvr.FindControl("tb_KMPL");
            CheckBox chk_Flag = (CheckBox)gvr.FindControl("chk_Flag");
            ddlRoute.SelectedValue = ds.Tables[0].Rows[0]["route_code"].ToString();
            GetAvgDieselRate(ds.Tables[0].Rows[0]["route_code"].ToString());
            ddl_Vehicle_type.SelectedValue = ds.Tables[0].Rows[0]["Vehicle_Type_Code"].ToString();
            tb_KMPL.Text = ds.Tables[0].Rows[0]["KMPL"].ToString();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gvTripRouteExp.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gvTripRouteExp.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TripRouteExp.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TripRouteExp.AddWEBX_TRIP_ROUTE_EXP_FUELRow("", "", "", "", "", "");
        }
        ddlRoute.SelectedIndex = -1;
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gvTripRouteExp.DataSource = dt_TripRouteExp;
        gvTripRouteExp.DataBind();

    }

    protected void gvTripRouteExp_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddl_Vehicle_type = (DropDownList)e.Row.FindControl("ddl_Vehicle_type");
            TextBox tb_KMPL = (TextBox)e.Row.FindControl("tb_KMPL");
            Label lbl_FTLtype_Err = (Label)e.Row.FindControl("lbl_FTLtype_Err");
            Label lbl_KMPL_Err = (Label)e.Row.FindControl("lbl_KMPL_Err");

            BindDropDown("USP_VEHICLE_TYPE", "TYPE_NAME", "TYPE_CODE", ddl_Vehicle_type);
            ddl_Vehicle_type.Attributes.Add("onChange", "return CheckValidVehType(" + e.Row.RowIndex + "," + ddl_Vehicle_type.ClientID.ToString() + "," + lbl_FTLtype_Err.ClientID.ToString() + ");");
            tb_KMPL.Attributes.Add("OnBlur", "return CheckKMPL(this," + lbl_KMPL_Err.ClientID.ToString() + ")");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        TripRouteFuelExp objTripRouteExp = new TripRouteFuelExp(Session["SqlProvider"].ToString().Trim());
        AvgDieselRate objAvgDieselRate = new AvgDieselRate(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        objTripRouteExp.ROUTE_CODE = ddlRoute.SelectedValue;
        try
        {
            foreach (GridViewRow gvr in gvTripRouteExp.Rows)
            {
                DropDownList ddl_Vehicle_type = (DropDownList)gvr.FindControl("ddl_Vehicle_type");
                TextBox tb_KMPL = (TextBox)gvr.FindControl("tb_KMPL");
                CheckBox chk_Flag = (CheckBox)gvr.FindControl("chk_Flag");
                
                objTripRouteExp.Vehicle_Type_Code = ddl_Vehicle_type.SelectedValue;
                objTripRouteExp.Route_Fuel_Exp_Code = "";
                objTripRouteExp.KMPL = tb_KMPL.Text.Trim();
                if (chk_Flag.Checked == true) { objTripRouteExp.Active_Flag = "Y"; } else { objTripRouteExp.Active_Flag = "N"; }
                if (Request.QueryString["Id"] != null)
                {
                    objTripRouteExp.Id = Request.QueryString["Id"].ToString();
                }
                else
                {
                    objTripRouteExp.Id = "";
                }

                objTripRouteExp.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                objAvgDieselRate.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                objAvgDieselRate.AvgDieRate = tb_Avg_Diesel_Rate.Text.ToString();
                objTripRouteExp.BeginTransaction();
                objAvgDieselRate.BeginTransaction(); 
                try
                {
                    if (hfId.Value == "")
                    {
                        objAvgDieselRate.ROUTE_CODE = ddlRoute.SelectedValue;  
                        objAvgDieselRate.InsertAvgDieselRate();
                    }
                    else
                    {
                        objAvgDieselRate.AvgDieselRateId = Convert.ToInt32(hfId.Value);
                        objAvgDieselRate.UpdateAvgDieselRate();
                    }
                    objTripRouteExp.InsertUpddateRouteExpMst();
                    IsCommitted = objTripRouteExp.CommitTransaction();
                    IsCommitted = objAvgDieselRate.CommitTransaction();
                }
                catch (Exception ex)
                {
                    objTripRouteExp.RollBackTransaction();
                    objAvgDieselRate.RollBackTransaction(); 
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
            Response.Redirect("TripRouteExpSearch.aspx");
        }
    }
    protected void ddlRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAvgDieselRate(ddlRoute.SelectedValue);
    }
    public void GetAvgDieselRate(string route)
    {
        DataTable dt = new DataTable();
        AvgDieselRate objAvgDieselRate = new AvgDieselRate(Session["SqlProvider"].ToString().Trim());
        objAvgDieselRate.ROUTE_CODE = route;
        dt = objAvgDieselRate.GetAvgDieselRate();
        if (dt.Rows.Count > 0)
        {
            hfId.Value = dt.Rows[0]["AvgDieselRateId"].ToString();
            tb_Avg_Diesel_Rate.Text = dt.Rows[0]["AvgDieselRate"].ToString();
        }
        else
        {
            hfId.Value = "";
            tb_Avg_Diesel_Rate.Text = "0.00";
        }
    }
}