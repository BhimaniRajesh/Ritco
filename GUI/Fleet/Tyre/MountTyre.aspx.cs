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
public partial class TYRE1_MountTyre : System.Web.UI.Page
{
 //   SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TyreIssueRow datarow;
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        //
        txtTyreNo.Attributes.Add("OnBlur", "javascript:GetTyreDetails(" + txtTyreNo.ClientID.ToString() + "," + txtTyreSize.ClientID.ToString() + "," + txtTyrePattern.ClientID.ToString() + "," + txtTyrePosition.ClientID.ToString() + "," + txtManufacturer.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + txtVehNumber.ClientID.ToString() + "," + pnlMountTyre.ClientID.ToString() + "," + pnlDismountTyre.ClientID.ToString() + "," + Label7.ClientID.ToString() + "," + hfTyreId.ClientID.ToString() + "," + hfPosCategory.ClientID.ToString() + "," + hfTruckTrailer.ClientID.ToString() + "," + txtCurrentKMRead.ClientID.ToString() + ");");
        txtTyreSize.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Date.ClientID.ToString() + "').focus();");
        txtKM.Attributes.Add("OnFocus", "javascript:document.getElementById('" + ddlTyrePosition.ClientID.ToString() + "').focus();");
        txtTyrePattern.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Date.ClientID.ToString() + "').focus();");
        txtTyrePosition.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Date.ClientID.ToString() + "').focus();");
        txtManufacturer.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Date.ClientID.ToString() + "').focus();");
        txtVehNumber.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Date.ClientID.ToString() + "').focus();");
        //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + tb_Date.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + tb_Date.ClientID + @"\')')");
        //txtVehId.Attributes.Add("OnBlur", "javascript:hide(" + btnMount.ClientID.ToString() + ");");
        btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/SearchTyreNo.aspx?tyreno=" + txtTyreNo.ClientID + "&tyrepos=" + txtTyrePosition.ClientID + "&tyresize=" + txtTyreSize.ClientID + "&tyrepat=" + txtTyrePattern.ClientID + "&tyremfg=" + txtManufacturer.ClientID + "&vehno=" + txtVehNumber.ClientID.ToString() + "&lbl7=" + Label7.ClientID.ToString() + "&pnlM=" + pnlMountTyre.ClientID.ToString() + "&pnlD=" + pnlDismountTyre.ClientID.ToString() + "&tyreid=" + hfTyreId.ClientID.ToString() + "&lDate=" + Label12.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo();");
        //txt.Attributes.Add("OnBlur", "javascript:ConSP();");
        //btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo_TyreMst.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&PosCate=" + hfPosCategory.ClientID.ToString() + "&vehcat=" + hfVehCate.ClientID.ToString() + "&TT=" + hfTruckTrailer.ClientID.ToString() + "&km=" + hfkm.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');ConSP();return false;");
        btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo_TyreMount.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&PosCate=" + hfPosCategory.ClientID.ToString() + "&vehcat=" + hfVehCate.ClientID.ToString() + "&TT=" + hfTruckTrailer.ClientID.ToString() + "&km=" + txtKM.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        if (!IsPostBack)
        {
            BindDropDown("USP_TYREPOSITION", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition); 
            BindDropDown("usp_locations", "locname", "loccode", ddlLocation);
            BindDropDown("usp_locations", "locname", "loccode", ddlLocation);
            BindDropDown("USP_TYRE_DISMOUNT_REASON", "CodeDesc", "CodeId", ddlTyreDismountReason);     
            //pnlMountTyre.Visible = false;
            //pnlDismountTyre.Visible = false;
            
            hfTyreId.Value = null;
        }
        string script;
        script = @"<SCRIPT language='javascript'> func(" + pnlDismountTyre.ClientID.ToString() + "," + pnlMountTyre.ClientID.ToString() + ");" + "</SCRIPT>";
        this.RegisterStartupScript("MyAlert", script);
    }
   
    protected void txtVehNo_TextChanged(object sender, EventArgs e)
    {
       
    }
    protected void gvTyreMount_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList dTyrePos = (DropDownList)e.Row.FindControl("ddlTyrePosition");
            BindDropDown("USP_TYREPOSITION", "TYREPOS_CODE", "TYREPOS_ID", dTyrePos); 
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string strPosCat = "";
        if (hfPosCategory.Value == "2")
        {
            strPosCat = "0" + hfPosCategory.Value;
        }
        else
        {
            strPosCat = "";
        }
        if (strProc == "USP_TYREPOSITION")
        {
            cmd.Parameters.AddWithValue("@POS_ALLOWED", strPosCat);
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
    protected void btnMount_Click(object sender, EventArgs e)
    {
        conn.Open(); 
        SqlCommand cmd = new SqlCommand("usp_TyreMount_InsertUpadte", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = hfTyreId.Value.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TyreVehNo", SqlDbType.VarChar).Value = txtVehNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TOT_LAB_HRS", SqlDbType.Int).Value = txtTotalLabourHours.Text == "" ? 0 : Convert.ToInt32(txtTotalLabourHours.Text.ToString().Trim());
        da.SelectCommand.Parameters.Add("@TOT_COST", SqlDbType.Int).Value = txtTotalLabourCost.Text == "" ? 0 : Convert.ToInt32(txtTotalLabourCost.Text.ToString().Trim());
        da.SelectCommand.Parameters.Add("@AXLE_CONFIG", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@WHEEL_CONFIG", SqlDbType.VarChar).Value = "";
        string[] Todt = tb_Date.Text.ToString().Split('/');
        DateTime d1 = new DateTime(Convert.ToInt32(Todt[2].ToString()), Convert.ToInt32(Todt[1].ToString()), Convert.ToInt32(Todt[0].ToString()));
        da.SelectCommand.Parameters.Add("@DATE_MOUNT", SqlDbType.DateTime).Value = d1;
        da.SelectCommand.Parameters.Add("@TYREPOS_CODE", SqlDbType.VarChar, 20).Value = ddlTyrePosition.SelectedValue; 
        da.SelectCommand.Parameters.Add("@Veh_Id", SqlDbType.Int).Value = Convert.ToInt32(hfVehIntId.Value.ToString().Trim());
        da.SelectCommand.Parameters.Add("@KM_RUN", SqlDbType.Decimal).Value = txtCurrentKMRead.Text == "" ? 0 : Convert.ToDouble(txtCurrentKMRead.Text);
        da.SelectCommand.Parameters.Add("@MANUAL_KM_RUN", SqlDbType.Int).Value = txtManualKMRead.Text == "" ? 0 : Convert.ToDouble(txtManualKMRead.Text);
        da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().ToUpper().Trim(); 
                
        cmd.ExecuteNonQuery();
        conn.Close();
        ClearText();
    }
    protected void btnDismount_Click(object sender, EventArgs e)
    {
        conn.Open(); 
        SqlCommand cmd = new SqlCommand("usp_TyreDismount_InsertUpadte", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = hfTyreId.Value.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TyreVehNo", SqlDbType.VarChar).Value = hfVehIntId.Value;//txtVehNumber.Text.ToString().Trim();

        da.SelectCommand.Parameters.Add("@TPA_LOC", SqlDbType.VarChar).Value = ddlLocation.SelectedValue.ToString().Trim();
        da.SelectCommand.Parameters.Add("@EST_LABHRS", SqlDbType.Int).Value = txtTotalLabourHours.Text == "" ? 0 : Convert.ToInt32(txtTotalLabourHours.Text.ToString().Trim());
        da.SelectCommand.Parameters.Add("@EST_COST", SqlDbType.Int).Value = txtTotalLabourCost.Text == "" ? 0 : Convert.ToInt32(txtTotalLabourCost.Text.ToString().Trim());
        da.SelectCommand.Parameters.Add("@DISMOUNT_REASON", SqlDbType.VarChar).Value = ddlTyreDismountReason.SelectedItem.Text.ToString().Trim();

        string[] Todt = tb_Date.Text.ToString().Split('/');
        DateTime d1 = new DateTime(Convert.ToInt32(Todt[2].ToString()), Convert.ToInt32(Todt[1].ToString()), Convert.ToInt32(Todt[0].ToString()));
        da.SelectCommand.Parameters.Add("@DISMOUNT_DATE", SqlDbType.DateTime).Value = d1;
        da.SelectCommand.Parameters.Add("@KM_RUN", SqlDbType.Decimal).Value = txtCurrentKMRead.Text == "" ? 0 : Convert.ToDouble(txtCurrentKMRead.Text);
        da.SelectCommand.Parameters.Add("@MANUAL_KM_RUN", SqlDbType.Int).Value = txtManualKMRead.Text == "" ? 0 : Convert.ToDouble(txtManualKMRead.Text);

        cmd.ExecuteNonQuery();
        conn.Close();
        ClearText();
    }
    public void ClearText()
    {
        txtTyreNo.Text = "";
        txtTyreNo.Focus();
        txtTyreSize.Text = "";
        txtTyrePattern.Text = "";
        txtTyrePosition.Text = "";
        txtManufacturer.Text = "";
        txtVehNumber.Text = "";
        tb_Date.Text = "";
        txtTotalLabourHours.Text = "";
        txtTotalLabourCost.Text = "";
        txtVehNo.Text = "";
        ddlTyrePosition.SelectedIndex = 0;
        ddlTyreDismountReason.SelectedIndex = 0;
        txtRemark.Text = "";
        ddlLocation.SelectedIndex = 0;
        txtTotalLabourHours.Text = "";
        txtTotalLabourCost.Text = "";
        txtCurrentKMRead.Text = "";
        txtManualKMRead.Text = "";
    }
}
