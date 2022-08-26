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
            lnkbtnView.Attributes.Add("onClick", "window.open('ViewTyrePattern.aspx','new_win','width=600,height=500,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('ViewTyrePattern.aspx?print=0','new_win','width=600,height=500,scrollbars=yes');");
            BindDropDown("USP_TYRE_POS_Search", "CodeDesc", "CodeId", ddlTyrePosition);
            btnPopupTyrePatCode.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyrePattern.aspx?TyrePatCode=" + txtPatCode.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
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
        string sql = "usp_TyrePat_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@PatId", SqlDbType.VarChar, 10).Value = "";
        da.SelectCommand.Parameters.Add("@TyrePatId", SqlDbType.VarChar).Value = txtPatCode.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@POSITION", SqlDbType.VarChar).Value = ddlTyrePosition.SelectedValue; 
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
        string strSQL = "SELECT TYREPAT_CODE AS [TYRE PATTERN CODE],TYRE_PATTERN_DESC AS [TYRE PATTERN DESCRIPTION],(SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYPOS' AND CODEID=POS_ALLOWED) AS [TYRE POSITIION],CONVERT(VARCHAR,ENTRYDT,106) AS [ENTRY DATE],ACTIVE_FLAG AS [ACTIVE FLAG] FROM [WEBX_FLEET_TYREPATTERN] order by convert(datetime,ENTRYDT,106) desc";
        CreateXLS(strSQL, "TyrePatternMaster.xls");
    }
}
