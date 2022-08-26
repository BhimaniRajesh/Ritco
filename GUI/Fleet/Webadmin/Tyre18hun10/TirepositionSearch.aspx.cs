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

public partial class admin_TyreSize : System.Web.UI.Page
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
            lnkbtnView.Attributes.Add("onClick", "window.open('ViewTyrePosition.aspx','new_win','width=750,height=500,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('ViewTyrePosition.aspx?print=0','new_win','width=750,height=500,scrollbars=yes');");
            BindDropDown("USP_TYRE_POS_Search", "CodeDesc", "CodeId", ddlTyrePosition);
            BindDropDown("USP_VEH_CAT_Search", "CodeDesc", "CodeId", ddlVehCategory);
            btnPopupTyrePos.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyrePosCode.aspx?PosCode=" + txtPosition.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
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
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_TyrePos_list";    
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@TyrePosId", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TyrePosCode", SqlDbType.VarChar).Value = txtPosition.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TyrePos", SqlDbType.VarChar).Value = ddlTyrePosition.SelectedValue;
        da.SelectCommand.Parameters.Add("@VehCategory", SqlDbType.VarChar).Value = ddlVehCategory.SelectedValue; 
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
        conn.Close();
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
        string strSQL = "SELECT TYREPOS_CODE AS [Tyre Position Code],TYREPOS_DESC AS [Tyre Position Description],"
	                    + " (SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYPOS' AND CODEID=POS_ALLOWED) as [Position Allowed],"
			            + " (SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='VHCAT' AND CODEID=TRUCK_TRAILER) as [Vehicle Type Category],"
                        + " CONVERT(VARCHAR,TYREPOS_ENTRYDT,106) as [Entry Date],ACTIVE_FLAG as [Active Flag]   FROM WEBX_FLEET_TYREPOS  order by convert(datetime,TYREPOS_ENTRYDT,106) desc";
        CreateXLS(strSQL, "TyrePositionMaster.xls");
    }
}
