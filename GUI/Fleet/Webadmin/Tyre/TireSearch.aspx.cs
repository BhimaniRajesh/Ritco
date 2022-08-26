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
            lnkbtnView.Attributes.Add("onClick", "window.open('ViewTyreMaster.aspx','new_win','width=800,height=500,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('ViewTyreMaster.aspx?print=0','new_win','width=800,height=500,scrollbars=yes');");
            BindDropDown("USP_TYRE_CATEGORY_Search", "CodeDesc", "CodeId", ddlTyreCategory);
            btnPopupTyreSize.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreSize.aspx?SizeNm=" + txtSizeName.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupTyreMfg.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreManufacturer.aspx?MfgNm=" + txtManufacturerName.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            BindDropDown("USP_TYRE_CAT_Search", "CodeDesc", "CodeDesc", ddlTyreTypeCategory);
            txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo("+ txtVehNo.ClientID.ToString() +","+ hfVehIntId.ClientID.ToString() +");");

            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            
            btnPopupTyreNo.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/popup_TyreNo.aspx?TyreNo=" + txtTyreNo.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            BindDropDown("USP_TYRE_POS_Search", "CodeDesc", "CodeId", ddlTyrePosCategory);
            BindDropDown("USP_TYREPOSITION_Search", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
            BindDropDown("USP_TYREPATTERN_Search", "TYREPAT_CODE", "TYRE_PATTERNID", ddlTyrePattern); 
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (strProc == "USP_TYREPOSITION_Search")
        {
            cmd.Parameters.AddWithValue("@POS_ALLOWED", ddlTyrePosCategory.SelectedValue);
        }
        if (strProc == "USP_TYREPOSITION")
        {
            cmd.Parameters.AddWithValue("@POS_ALLOWED", ddlTyrePosCategory.SelectedValue);
        }
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
    public void BindPosCategory()
    {
        ddlTyrePosition.Items.Clear();
        BindDropDown("USP_TYREPOSITION_Search", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Tyre_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@Tyre_Id", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_NO", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@MODEL_NO", SqlDbType.VarChar).Value = txtTyreModelNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@MFG_NAME", SqlDbType.VarChar).Value = txtManufacturerName.Text.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_CATEGORY", SqlDbType.VarChar).Value = ddlTyreCategory.SelectedItem.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@SIZE_NAME", SqlDbType.VarChar).Value = txtSizeName.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TYRE_TYPEID", SqlDbType.VarChar).Value = ddlTyreTypeCategory.SelectedItem.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = txtVehNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@PATCODE", SqlDbType.VarChar).Value = ddlTyrePattern.SelectedValue;
        da.SelectCommand.Parameters.Add("@TYREPOSCAT", SqlDbType.VarChar).Value = ddlTyrePosCategory.SelectedValue;
        da.SelectCommand.Parameters.Add("@TYREPOS", SqlDbType.VarChar).Value = ddlTyrePosition.SelectedValue;
        da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = ddlTyreStatus.SelectedValue;
        da.SelectCommand.Parameters.Add("@ACTIVEFLAG", SqlDbType.VarChar).Value = ddlStatus.SelectedValue;
             
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
        string strSQL = "SELECT TYRE_NO AS [Tyre No.],CATEGORY AS [Tyre Type Category],MFG_NAME AS [Tyre Manufacturer Name],MODEL_NO AS [Tyre Model No],SIZE_NAME AS [Tyre Size],TYRE_OE AS [Original Equipment],TYREPAT_CODE as [Tyre Pattern],TYRE_TREAD_DEPTH_32NDS as [Tyre Tread Depth],TYRE_PURDT as [Tyre Purchase Date],TYRE_PUR_KMS AS [Tyre Purchase KM],TYRE_COST as [Tyre Cost],VEHNO as [Vehicle Number],TYRETYPE as [Tyre Type Category],POSCATEGORY as [Tyre Position Category],TYREPOSCODE as [Tyre Position Code],LOCATION as [Tyre Location],VENDOR as [Tyre Vendor],TYRE_STATUS as [Tyre Status],TYRE_ACTIVEFLAG as [Active Flag] from vwTyreList order by convert(datetime,TYRE_ENTRYDT,106) desc";
        CreateXLS(strSQL, "TyreMaster.xls");
    }
    protected void ddlTyrePosCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPosCategory();
    }

  
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
