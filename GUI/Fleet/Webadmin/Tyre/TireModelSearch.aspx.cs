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

public partial class TyreModelSearch : System.Web.UI.Page
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

            btnPopupModelNo.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreModel.aspx?ModNo=" + txtTyreModelNo.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            lnkbtnView.Attributes.Add("onClick", "window.open('ViewTyreModel.aspx','new_win','width=800,height=500,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('ViewTyreModel.aspx?print=0','new_win','width=800,height=500,scrollbars=yes');");
            BindDropDown("USP_TYRE_Pattern_Search", "TYREPAT_CODE", "TYRE_PATTERNID", ddlTyrePatternCategory);
            btnPopupTyreSize.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreSize.aspx?SizeNm=" + txtSizeName.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupTyreMfg.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreManufacturer.aspx?MfgNm=" + txtManufacturerName.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
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
        string sql = "usp_TyreModel_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@TYRE_MODEL_ID", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_MODELNO", SqlDbType.VarChar).Value = txtTyreModelNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TYRE_MFG", SqlDbType.VarChar).Value = txtManufacturerName.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TYRE_PAT_CATEGORY", SqlDbType.VarChar).Value = ddlTyrePatternCategory.SelectedItem.Text.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_SIZE", SqlDbType.VarChar).Value = txtSizeName.Text.ToString().Trim();
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
        string strSQL = "SELECT TMO.MODEL_NO AS [TYRE MODEL CODE], "
                      + " TMO.MODEL_DESC AS [TYRE MODEL DESCRIPTION], TMO.TREAD_DEPTH AS [TREAD DEPTH IN SEC], "
                      + "TPAT.TYREPAT_CODE AS [TYRE PATTERN CODE], TMFG.MFG_NAME AS [TYRE MANUFACTURER],"
                      + " TSIZE.TYRE_SIZENAME AS [TYRE SIZE],CONVERT(VARCHAR,TMO.ENTRY_DT,106) AS [ENTRY DATE],"
                      + " TMO.ACTIVE_FLAG AS [ACTIVE FLAG] "
				      + " FROM  WEBX_FLEET_TYREMODELMST AS TMO INNER JOIN WEBX_FLEET_TYREPATTERN AS TPAT ON  TMO.TYRE_PATTERNID = TPAT.TYRE_PATTERNID INNER JOIN WEBX_FLEET_TYREMFG AS TMFG ON TMO.MFG_ID = TMFG.MFG_ID INNER JOIN WEBX_FLEET_TYRESIZEMST AS TSIZE ON TMO.TYRE_SIZEID = TSIZE.TYRE_SIZEID order by convert(datetime,SIZE_ENTRYDT,106) desc";
        CreateXLS(strSQL, "TyreModelMaster.xls");
    }
}
