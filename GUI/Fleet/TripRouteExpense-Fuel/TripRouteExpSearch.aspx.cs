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
using System.IO;

public partial class TyrePatternSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            BindDropDown("USP_TRIPROUTEMST", "RUTDESC", "RUTCD", ddlRoute);
            lnkbtnView.Attributes.Add("onClick", "window.open('ViewTripRouteExp.aspx','new_win','width=800,height=600,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('ViewTripRouteExp.aspx?print=0','new_win','width=800,height=600,scrollbars=yes');");
                
            //btnPopupTyrePatCode.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyrePattern.aspx?TyrePatCode=" + txtPatCode.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        }
    }
    public void GetAvgDieselRate(string route)
    {
        DataTable dt = new DataTable();
        AvgDieselRate objAvgDieselRate = new AvgDieselRate(Session["SqlProvider"].ToString().Trim());
        objAvgDieselRate.ROUTE_CODE = route;
        dt = objAvgDieselRate.GetAvgDieselRate();
        if (dt.Rows.Count > 0)
        {
            lblAvgDieselRate.Text = dt.Rows[0]["AvgDieselRate"].ToString();
        }
        else
        {
            lblAvgDieselRate.Text = "";
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
    public void BindGrid()
    {
        TripRouteFuelExp objTripRouteExp = new TripRouteFuelExp(Session["SqlProvider"].ToString().Trim());
        objTripRouteExp.ROUTE_CODE = ddlRoute.SelectedValue;
        objTripRouteExp.Id = "0"; 
        objTripRouteExp.BindGridFuelExp(gvFuelExp); 
    }
    protected void btnShowTyre_OnClick(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void CreateXLS(string qry, string FileName)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataAdapter adp = new SqlDataAdapter(qry, conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        DataTable dataTable = ds.Tables[0];  //oClientInfo.GetClientData(Convert.ToInt16(Session["UserID"].ToString()));
        Response.ContentType = "Application/x-msexcel";
        Response.AddHeader("content-disposition", "attachment; filename=\"" + FileName + "\"");
        DataGrid csvGrid = new DataGrid();
        csvGrid.DataSource = dataTable;
        csvGrid.DataBind();
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
        csvGrid.RenderControl(htmlWriter);
        Response.Write(stringWriter.ToString());
        Response.End();
    }
  
    protected void lnkbtnXLS_Click(object sender, EventArgs e)
    {
        string strSQL = "select rutdesc as [Route Description],ftltyp_code as [FTL Type],KMPL as [KMPL],active_flag as [Active Flag] from   vw_TRIPROUTEFuelEXP_VIEW";
        CreateXLS(strSQL, "TripRouteFuelExpense.xls");
    }
    protected void ddlRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAvgDieselRate(ddlRoute.SelectedValue);
    }
}
