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
    MyFleetDataSet.WEBX_TRIPROUTE_EXPDataTable dt_TripRouteExp = new MyFleetDataSet.WEBX_TRIPROUTE_EXPDataTable(); 
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDropDown("USP_TRIPROUTEMST", "RUTDESC", "RUTCD", ddlRoute);
            conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
            dt_TripRouteExp.AddWEBX_TRIPROUTE_EXPRow("","","","","","","","","","","");  
            BindGrid();
            lbl_Page_Error.Text = "";

            if (Request.QueryString["Id"] != null)
            {
                RowNo.Visible = false;
                GetValue(Request.QueryString["Id"].ToString());
            }

            foreach (GridViewRow r in gvTripRouteExp.Rows)
            {
                DropDownList ddlRouteSegment = (DropDownList)r.FindControl("ddlRouteSegment");
                
                DropDownList ddl_Vehicle_type = (DropDownList)r.FindControl("ddl_Vehicle_type");
                DropDownList ddlFueExp = (DropDownList)r.FindControl("ddlFueExp");
                DropDownList ddlRateType = (DropDownList)r.FindControl("ddlRateType");

                ddlRoute.Attributes.Add("onChange", "return FillRouteSegment(" + r.RowIndex + "," + ddlRoute.ClientID.ToString() + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");
                //string script;
                //script = @"<SCRIPT language='javascript'> PageLoad();" + "</SCRIPT>";
                //this.RegisterStartupScript("MyAlert", script);
            }
            
            
            
        }
    }
    public void GetValue(string ID)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_TRIPROUTEEXP_VIEW";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@ID", SqlDbType.VarChar, 5).Value = Convert.ToString(ID);
        da.SelectCommand.Parameters.Add("@route_code", SqlDbType.VarChar, 1000).Value = "0";

        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (GridViewRow gvr in gvTripRouteExp.Rows)
        {
            //DropDownList ddlRouteSegment = (DropDownList)gvr.FindControl("ddlRouteSegment");
            DropDownList ddl_Vehicle_type = (DropDownList)gvr.FindControl("ddl_Vehicle_type");
            DropDownList ddlFueExp = (DropDownList)gvr.FindControl("ddlFueExp");
            TextBox txtStandardRate = (TextBox)gvr.FindControl("txtStandardRate");
            CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
            //HiddenField hfRouteSegment = (HiddenField)gvr.FindControl("hfRouteSegment");
            //hfRouteSegment.Value = ds.Tables[0].Rows[0]["route_segment"].ToString();
            ddlRoute.SelectedValue = ds.Tables[0].Rows[0]["route_code"].ToString();
            //hfRS.Value = ds.Tables[0].Rows[0]["route_segment"].ToString();
            //ddlRouteSegment.SelectedValue = ds.Tables[0].Rows[0]["route_segment"].ToString();
            ddl_Vehicle_type.SelectedValue = ds.Tables[0].Rows[0]["vt"].ToString();
            ddlFueExp.SelectedValue = ds.Tables[0].Rows[0]["fec"].ToString();
            txtStandardRate.Text = ds.Tables[0].Rows[0]["standard_rate"].ToString();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gvTripRouteExp.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gvTripRouteExp.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }
        }
        conn.Close();
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
            dt_TripRouteExp.AddWEBX_TRIPROUTE_EXPRow("", "", "", "", "", "", "", "", "", "","");  
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
            //DropDownList ddlRateType = (DropDownList)e.Row.FindControl("ddlRateType");
            DropDownList ddl_Vehicle_type = (DropDownList)e.Row.FindControl("ddl_Vehicle_type");
            DropDownList ddlFueExp = (DropDownList)e.Row.FindControl("ddlFueExp");

            BindDropDown("USP_Vehicle_Type_Trip_Route_Exp", "type_name", "type_code", ddl_Vehicle_type);
            BindDropDown("USP_FUELEXP", "CodeDesc", "CodeId", ddlFueExp);
            //BindDropDown("USP_EXPRate", "CodeDesc", "CodeId", ddlRateType);

            //ddlRouteSegment.Items.Add(new ListItem("Select","0"));
            //ddlRateType.Attributes.Add("onChange", "return CheckValidRS(" + e.Row.RowIndex + "," + ddlRateType.ClientID.ToString() + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");
            //ddl_Vehicle_type.Attributes.Add("onChange", "return CheckValidFTL(" + e.Row.RowIndex + "," + ddlRateType.ClientID.ToString() + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");
            //ddlFueExp.Attributes.Add("onChange", "return CheckValidFUEL(" + e.Row.RowIndex + "," + ddlRateType.ClientID.ToString() + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");

            ddl_Vehicle_type.Attributes.Add("onChange", "return CheckValidVehicleType(" + e.Row.RowIndex + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");
            ddlFueExp.Attributes.Add("onChange", "return CheckValidFUEL(" + e.Row.RowIndex + "," + ddl_Vehicle_type.ClientID.ToString() + "," + ddlFueExp.ClientID.ToString() + ");");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_TripRouteExp objTripRouteExp = new cls_TripRouteExp(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gvTripRouteExp.Rows)
            {
                //DropDownList ddlRateType = (DropDownList)gvr.FindControl("ddlRateType");
                DropDownList ddl_Vehicle_type = (DropDownList)gvr.FindControl("ddl_Vehicle_type");
                DropDownList ddlFueExp = (DropDownList)gvr.FindControl("ddlFueExp");
                TextBox txtStandardRate = (TextBox)gvr.FindControl("txtStandardRate");
                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
                objTripRouteExp.ROUTE_CODE = ddlRoute.SelectedValue;
                objTripRouteExp.ROUTE_SEGMENT = "";
                //objTripRouteExp.EXP_RATE_CODE = ddlRateType.SelectedValue;
                objTripRouteExp.EXP_RATE_CODE = "";
                objTripRouteExp.VEHICLE_TYPE = ddl_Vehicle_type.SelectedValue;
                objTripRouteExp.FULEXP_CODE = ddlFueExp.SelectedValue;
                objTripRouteExp.STANDARD_RATE = txtStandardRate.Text;
                if (cbFlag.Checked == true) { objTripRouteExp.ACTIVE_FLAG = "Y"; } else { objTripRouteExp.ACTIVE_FLAG = "N"; }
                if (Request.QueryString["ID"] != null)
                {
                    objTripRouteExp.ID = Request.QueryString["ID"].ToString();
                }
                else
                {
                    objTripRouteExp.ID = "";
                }
                objTripRouteExp.ENTER_BY = SessionUtilities.CurrentBranchCode.ToString().Trim();

                objTripRouteExp.BeginTransaction();
                try
                {
                    objTripRouteExp.InsertUpddateRouteExpMst();
                    IsCommitted = objTripRouteExp.CommitTransaction();
                }
                catch (Exception ex)
                {
                    objTripRouteExp.RollBackTransaction();
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
}