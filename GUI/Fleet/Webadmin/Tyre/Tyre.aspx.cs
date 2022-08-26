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
using ApplicationManager;

public partial class GUI_Fleet_Webadmin_Tyre_Tyre : System.Web.UI.Page
{
    public MyFleetDataSet _dateset = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TYREMSTDataTable dt_TyreMst = new MyFleetDataSet.TYREMSTDataTable();
    static string tyreid;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            //dt_TyreMst.AddTYREMSTRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            BindDDCat();
            RadioButtonList1.SelectedIndex = 0;

            if(RadioButtonList1.SelectedIndex == 0){OEM();}else{StandAlone();}
            //txtDispPattern.ReadOnly = true;
            //txtDispPattern.Visible = false;
            txtTreadDepth.ReadOnly = true;
            string script;
            script = @"<SCRIPT language='javascript'> funPageLoad();" + "</SCRIPT>";
            this.RegisterStartupScript("MyAlert", script);
            
            //RadioButtonList1.Attributes.Add("OnClick", "javascript:checkOEMSL();");
            txtVehNo.Attributes.Add("OnBlur","javascript:checkVehNo();");
            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/VehicleNo_TyreMst.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&vehcat=" + txtVehcat.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");

            
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtWarrenyExpireDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtWarrenyExpireDate.ClientID + @"\')')");
            //img_CalendarDate.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtPurchaseDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtPurchaseDate.ClientID + @"\')')");
            txtKms.Visible = false;
            BindDropDown("USP_TYRESIZE", "TYRE_SIZENAME", "TYRE_SIZEID", ddlSize); 
            BindDropDown("USP_TYREMANUFACTURER", "MFG_Name", "MFG_ID", ddlManufacturer);
            //BindDropDown("USP_VEHNO", "VEHNO", "VEH_INTERNAL_NO", ddlVehicleNo); 
            
            BindDropDown("USP_TYRETYPE", "CodeDesc", "CodeId", ddlTyreType);
            BindDropDown("USP_LOCATION", "LocName", "LocCode", ddlLocation);
            BindDropDown("USP_VENDOR", "VENDORNAME", "VENDORCODE", ddlVendor);
            BindDropDown("USP_TYRE_CAT", "CodeDesc", "CodeId", ddlTyreCategory);
            BindDropDown("USP_TYRE_MODEL", "MODEL_NO", "TYRE_MODEL_ID", ddlTyreModel);
            BindDropDown("USP_TYRE_POS", "CodeDesc", "CodeId", ddlTyrePosCategory);
            //BindDropDown("USP_TYREPOSITION", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
            BindDropDown("usp_Bind_TyrePos_TyreMst", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
            BindDropDown("USP_TYREPATTERN", "TYREPAT_CODE", "TYRE_PATTERNID", ddlTyrePattern); 
            WarrentyRow.Visible = false;
            //ddlTyreCategory_SelectedIndexChanged(sender, e); 
            if (Request.QueryString["id"] != null)
            {
                tyreid = Request.QueryString["id"].ToString();
                FillData();
            }
            else
            {
                tyreid = null;
            }
            
        }
        txtVehcat.Attributes.Add("OnFocus", "javascript:document.getElementById('" + ddlTyreType.ClientID.ToString() + "').focus();");
        txtTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(" + txtTyreNo.ClientID.ToString() + ");");
        //TextBox1.Attributes.Add("OnKeyUp", "javascript:check1(" + TextBox1.ClientID.ToString() + ");");
    }
    public void FillData()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "USP_TYREMST";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@TYRE_ID",tyreid);
        cmd.Parameters.AddWithValue("@TYRE_OE", "");
        cmd.Parameters.AddWithValue("@TYRE_NO", "");
        cmd.Parameters.AddWithValue("@TYRE_CATEGORY", "");
        cmd.Parameters.AddWithValue("@TYRE_SIZEID", "");
        cmd.Parameters.AddWithValue("@MFG_ID", "");
        cmd.Parameters.AddWithValue("@TYRE_TYPEID", "");
        cmd.Parameters.AddWithValue("@TYRE_TREAD_DEPTH_32NDS", "");
        cmd.Parameters.AddWithValue("@TYRE_PURDT", "");
        cmd.Parameters.AddWithValue("@TYRE_PUR_KMS", "");
        cmd.Parameters.AddWithValue("@TYRE_COST", "0");
        cmd.Parameters.AddWithValue("@TYRE_VEHNO", "");
        cmd.Parameters.AddWithValue("@TYRE_LOCATION", "");
        cmd.Parameters.AddWithValue("@TYRE_VENDOR", "");
        cmd.Parameters.AddWithValue("@TYRE_ENTRYBY", "");
        cmd.Parameters.AddWithValue("@VEH_INTERNAL_NO", "");
        cmd.Parameters.AddWithValue("@TYREPOS_ID", "");
        cmd.Parameters.AddWithValue("@TYRE_ACTIVEFLAG", "");
        cmd.Parameters.AddWithValue("@TYRE_STATUS", "");
        cmd.Parameters.AddWithValue("@TYRE_PATTERN_DESC", "");
        cmd.Parameters.AddWithValue("@OPCODE", "3");
        cmd.Parameters.AddWithValue("@TYRE_MODEL_ID", "");
        cmd.Parameters.AddWithValue("@POS_CATEGORY", "");
        cmd.Parameters.AddWithValue("@Tyre_Weight", 0);
        cmd.Parameters.AddWithValue("@Outer_Dimension", 0); 
		cmd.Parameters.AddWithValue("@Company_Code", 0);
        //DataSet ds = new DataSet();
        //adp.Fill(ds);
        SqlDataReader dr = cmd.ExecuteReader();
    
        while (dr.Read())
        {
            if (dr["TYRE_OE"].ToString() == "YES")
            {
                RadioButtonList1.SelectedIndex = 0;
            }
            if (dr["TYRE_OE"].ToString() == "NO")
            {
                RadioButtonList1.SelectedIndex = 1;
            }
            txtTyreNo.Text = dr["TYRE_NO"].ToString();
            hfVehIntId.Value = dr["VEH_INTERNAL_NO"].ToString();

            ddlTyreCategory.SelectedValue = dr["TYRE_CATEGORY"].ToString();
            ddlSize.SelectedValue = dr["TYRE_SIZEID"].ToString();
            ddlTyrePattern.SelectedValue = dr["TYRE_PATTERN_CODE"].ToString();
            //txtDispPattern.Text = dr["TYRE_PATTERN_DESC"].ToString();
            ddlManufacturer.SelectedValue = dr["MFG_ID"].ToString();
            ddlTyreType.SelectedValue = dr["TYRE_TYPEID"].ToString();
            txtVehNo.Text = dr["TYRE_VEHNO"].ToString();
            //ddlVehicleNo.SelectedValue = 
            ddlTyrePosition.SelectedValue = dr["TYREPOS_ID"].ToString();
            ddlLocation.SelectedValue = dr["TYRE_LOCATION"].ToString();
            ddlVendor.SelectedValue = dr["TYRE_VENDOR"].ToString();
            ddlTyreModel.SelectedValue = dr["TYRE_MODEL_ID"].ToString();
            txtTreadDepth.Text = dr["TYRE_TREAD_DEPTH_32NDS"].ToString();
            if (dr["TYRE_PURDT"].ToString() != "")
            {
                txtPurchaseDate.Text = Convert.ToDateTime(dr["TYRE_PURDT"].ToString()).ToString("dd/MM/yyyy");
            }
            txtPurchaseKM.Text = dr["TYRE_PUR_KMS"].ToString();
            txtCost.Text = dr["TYRE_COST"].ToString();

            ddlTyrePosCategory.SelectedValue = "0" + dr["POS_CATEGORY"].ToString();
            BindPosCategory();
            ddlTyrePosition.SelectedValue = dr["TYREPOS_ID"].ToString();
            BindModel();
            ddlTyreModel.SelectedValue = dr["TYRE_MODEL_ID"].ToString();
            txtTyre_Weight.Text = dr["Tyre_Weight"].ToString();
            txtOuter_Dimention.Text = dr["Outer_Dimension"].ToString();
            if (dr["TRUCK_TRAILER"].ToString() != "")
            {
                txtVehcat.Text = dr["TRUCK_TRAILER"].ToString();
            }
            else
            {
                txtVehcat.Text = "";
            }
            if (dr["TYRE_ACTIVEFLAG"].ToString() == "Y")
            {
                ddlActive.SelectedIndex = 0;
            }
            else
            {
                ddlActive.SelectedIndex = 1; 
            }
        }
        if (RadioButtonList1.SelectedIndex == 0) { OEM(); } else { StandAlone(); }
        if (ddlTyreCategory.SelectedIndex == 1)
        {
            ddlTyrePattern.Enabled = false;
            txtTreadDepth.ReadOnly = true;
        }
        if (ddlTyreCategory.SelectedIndex == 2)
        {
            ddlTyrePattern.Enabled = false;
            txtTreadDepth.ReadOnly = false;
        }
        if (ddlTyreCategory.SelectedIndex == 3)
        {
            ddlTyrePattern.Enabled = true;
            txtTreadDepth.ReadOnly = false;
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if(strProc=="USP_TYRE_MODEL")
        {
            cmd.Parameters.AddWithValue("@MFG_ID", ddlManufacturer.SelectedValue);
        }
        if (strProc=="USP_TYRESIZE")
        {
            cmd.Parameters.AddWithValue("@TYRE_MODEL_ID", ddlTyreModel.SelectedValue);
        }
        if (strProc == "USP_TYREPOSITION")
        {
            cmd.Parameters.AddWithValue("@POS_ALLOWED", ddlTyrePosCategory.SelectedValue);
        }
        if (strProc == "usp_Bind_TyrePos_TyreMst")
        {
            cmd.Parameters.AddWithValue("@VEHNO", hfVehIntId.Value);
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
    public void BindDDCat()
    {
        ddlSelectCat.Items.Clear();
        ddlSelectCat.Items.Add(new ListItem("Warrenty Expires on","1"));
        ddlSelectCat.Items.Add(new ListItem("At KMS.", "2"));
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 0)
        {
            OEM();
        }
        else
        {
            StandAlone();
        }
        ddlTyreCategory_SelectedIndexChanged(sender, e);
    }
    public void OEM()
    {
        //lblCategory.Visible = false;
        //ddlTyreCategory.Visible = false;
        rLocVen.Visible = false;
        rPos.Visible = true;
        //txtVehNo.Visible = true;
        //btnPopupVehno.Visible = true;
        txtVehNo.ReadOnly = false;
        txtVehNo.Enabled = true;
        btnPopupVehno.Enabled = true;
        //ddlVehicleNo.Visible = true;
        //Label7.Visible = true;
       // Panel4.Visible = true;
        txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo();");
        btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../../GUI/popups/VehicleNo_TyreMst.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&vehcat=" + txtVehcat.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");

    }
    public void StandAlone()
    {
        txtVehNo.Attributes.Add("OnBlur", "");
        btnPopupVehno.Attributes.Add("OnClick", "");
        //lblCategory.Visible = true;
        //ddlTyreCategory.Visible = true;
        //ddlVehicleNo.Visible = false;
        txtVehNo.ReadOnly = true;
        txtVehNo.Enabled = false;
        btnPopupVehno.Enabled = false;
        txtVehNo.Text = "";
        rPos.Visible = false;
        //txtVehNo.Visible = false;
        //btnPopupVehno.Visible = false;
        //Panel4.Visible = false;
        //Label7.Visible = false;
        rLocVen.Visible = true;
    }
    


    protected void ddlSelectCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSelectCat.SelectedValue == "1")
        {
            //img_Calendar.Visible = true;
            txtWarrenyExpireDate.Visible = true;
            txtKms.Visible = false;  
        }
        else
        {
            //img_Calendar.Visible = false;
            txtWarrenyExpireDate.Visible = false;
            txtKms.Visible = true;
        }
    }
    //protected void ddlSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    string strSQL = "SELECT P.TYREPAT_CODE FROM WEBX_FLEET_TYREPATTERN AS P INNER JOIN webx_fleet_tyremodelmst AS M ON P.TYRE_PATTERNID = M.TYRE_PATTERNID WHERE (P.ACTIVE_FLAG = 'Y') AND (M.TYRE_MODEL_ID = " + ddlTyreModel.SelectedValue + ")";
    //    string strSQL = "SELECT WEBX_FLEET_TYREPATTERN.TYREPAT_CODE FROM WEBX_FLEET_TYREPATTERN INNER JOIN WEBX_FLEET_TYRESIZEMST ON WEBX_FLEET_TYREPATTERN.TYRE_PATTERNID = WEBX_FLEET_TYRESIZEMST.TYRE_PATTERNID WHERE WEBX_FLEET_TYREPATTERN.ACTIVE_FLAG='Y' AND WEBX_FLEET_TYRESIZEMST.TYRE_SIZEID='" + ddlSize.SelectedValue + "'";
    //    conn.Open();
    //    SqlCommand cmd = new SqlCommand(strSQL, conn);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            txtDispPattern.Text = dr["TYREPAT_CODE"].ToString();
    //        }
    //    }
    //    else
    //    {
    //        txtDispPattern.Text = "";
    //    }
    //    dr.Close();
    //    conn.Close();

    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls_TyreMaster TyreMst = new cls_TyreMaster(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        TyreMst.TYRE_ID = "";
        try
        {
            if (tyreid == null) { TyreMst.OPCODE = "1"; } else { TyreMst.OPCODE = "2"; TyreMst.TYRE_ID = tyreid; }
           
            if(RadioButtonList1.SelectedIndex == 0)
            {
                TyreMst.TYRE_OE = "YES";
                TyreMst.TYRE_LOCATION = "";
                TyreMst.TYRE_VENDOR ="";
                //TyreMst.TYRE_VEHNO = ddlVehicleNo.SelectedValue;
                TyreMst.TYRE_VEHNO = txtVehNo.Text;
                TyreMst.TYRE_STATUS = "Mounted";
                TyreMst.POS_CATEGORY = ddlTyrePosCategory.SelectedValue;
                TyreMst.TYREPOS_ID = ddlTyrePosition.SelectedValue;
            }
            else
            {
                TyreMst.POS_CATEGORY = "";
                TyreMst.TYREPOS_ID = "";
                TyreMst.TYRE_OE = "NO";
                TyreMst.TYRE_LOCATION = ddlLocation.SelectedValue;
                TyreMst.TYRE_VENDOR = ddlVendor.SelectedValue;
                TyreMst.TYRE_VEHNO = "";
                TyreMst.TYRE_STATUS = "Available"; 
            }
            TyreMst.TYRE_CATEGORY = ddlTyreCategory.SelectedValue;
            TyreMst.TYRE_NO = txtTyreNo.Text;
            TyreMst.TYRE_MODEL_ID = ddlTyreModel.SelectedValue;
            TyreMst.TYRE_SIZEID = ddlSize.SelectedValue;
            //TyreMst.TYRE_PATTERN_DESC = txtDispPattern.Text;
            TyreMst.TYRE_PATTERN_DESC = ddlTyrePattern.SelectedValue;
            TyreMst.MFG_ID = ddlManufacturer.SelectedValue;
            TyreMst.TYRE_TYPEID = ddlTyreType.SelectedValue;
            TyreMst.Tyre_Weight = txtTyre_Weight.Text;
            TyreMst.Outer_Dimension = txtOuter_Dimention.Text;
      
            //if (ddlSelectCat.SelectedIndex == 0)
            //{
            //    TyreMst.TYRE_WARRANTY_EXPDT = null;
            //    TyreMst.TYRE_WARRANTY_EXPKMS = "0";
            //}
            //else
            //{
            //    TyreMst.TYRE_WARRANTY_EXPDT = null;
            //    TyreMst.TYRE_WARRANTY_EXPKMS = txtKms.Text;
            //}
            TyreMst.TYRE_TREAD_DEPTH_32NDS = txtTreadDepth.Text;
            TyreMst.TYRE_PURDT = txtPurchaseDate.Text;
            TyreMst.TYRE_PUR_KMS = txtPurchaseKM.Text;
            TyreMst.TYRE_COST = txtCost.Text;
            //TyreMst.TYRE_ENTRYDT = System.DateTime.Now.ToShortDateString(); 
            TyreMst.TYRE_ENTRYBY = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            TyreMst.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();

            if (ddlActive.SelectedIndex == 0)
            {
                TyreMst.TYRE_ACTIVEFLAG = "Y";
            }
            else
            {
                TyreMst.TYRE_ACTIVEFLAG = "N";
            }

            TyreMst.VEH_INTERNAL_NO = hfVehIntId.Value;
           
            TyreMst.BeginTransaction();
            
            try
            {
                TyreMst.InsertTyreMaster();
                IsCommitted = TyreMst.CommitTransaction();
            }
            catch (Exception ex)
            {
                TyreMst.RollBackTransaction();
                lbl_Page_Error.ForeColor = System.Drawing.Color.Red;
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Red;
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
             Response.Redirect("TireSearch.aspx");
        }
    }
    public void clear()
    {
        RadioButtonList1.SelectedIndex = 0; ddlTyreCategory.SelectedIndex = 0; ddlManufacturer.SelectedIndex = 0; ddlTyreType.SelectedIndex = 0; ddlSize.SelectedIndex = 0;
        txtVehNo.Text=""; ddlTyrePosition.SelectedIndex = 0; ddlLocation.SelectedIndex = 0; ddlVendor.SelectedIndex = 0; ddlActive.SelectedIndex = 0;
        txtTyreNo.Text = ""; ddlTyrePattern.SelectedIndex = 0;
        //txtDispPattern.Text = ""; 
        txtWarrenyExpireDate.Text = ""; txtKms.Text = ""; txtTreadDepth.Text = ""; txtPurchaseDate.Text = ""; txtPurchaseKM.Text = ""; txtCost.Text = ""; 
    }

    protected void ddlTyreModel_SelectedIndexChanged(object sender, EventArgs e)
    {

        //if (ddlTyreCategory.SelectedIndex == 1)
        //{
        //    txtDispPattern.ReadOnly = true;
        //    txtTreadDepth.ReadOnly = true;
        //}
        //if (ddlTyreCategory.SelectedIndex == 2)
        //{
        //    txtDispPattern.ReadOnly = true;
        //    txtTreadDepth.ReadOnly = false;
        //}
        //if (ddlTyreCategory.SelectedIndex == 3)
        //{
        //    txtDispPattern.ReadOnly = false;
        //    txtTreadDepth.ReadOnly = false;
        //}

        if (ddlTyreCategory.SelectedItem.Text == "New")
        {
            cls_TyreMaster TyreMst = new cls_TyreMaster(Session["SqlProvider"].ToString().Trim());
            TyreMst.FillTreadDepth(ddlTyreModel.SelectedValue);
            txtTreadDepth.Text = TyreMst.TYRE_TREAD_DEPTH_32NDS;
            txtTreadDepth.ReadOnly = true;
        }
        else
        {
            txtTreadDepth.Text = "";
            txtTreadDepth.ReadOnly = false; 
        }
       
        ddlSize.Items.Clear();
        BindDropDown("USP_TYRESIZE", "TYRE_SIZENAME", "TYRE_SIZEID", ddlSize);


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string strSQL = "SELECT P.TYRE_PATTERNID,P.TYREPAT_CODE FROM WEBX_FLEET_TYREPATTERN AS P INNER JOIN webx_fleet_tyremodelmst AS M ON P.TYRE_PATTERNID = M.TYRE_PATTERNID WHERE (P.ACTIVE_FLAG = 'Y') AND (M.TYRE_MODEL_ID = " + ddlTyreModel.SelectedValue + ")";
        //string strSQL = "SELECT WEBX_FLEET_TYREPATTERN.TYREPAT_CODE FROM WEBX_FLEET_TYREPATTERN INNER JOIN WEBX_FLEET_TYRESIZEMST ON WEBX_FLEET_TYREPATTERN.TYRE_PATTERNID = WEBX_FLEET_TYRESIZEMST.TYRE_PATTERNID WHERE WEBX_FLEET_TYREPATTERN.ACTIVE_FLAG='Y' AND WEBX_FLEET_TYRESIZEMST.TYRE_SIZEID='" + ddlSize.SelectedValue + "'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(strSQL, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlTyrePattern.SelectedValue = dr["TYRE_PATTERNID"].ToString();
                //txtDispPattern.Text = dr["TYREPAT_CODE"].ToString();
            }
        }
        else
        {
            ddlTyrePattern.SelectedIndex = 0; 
            //txtDispPattern.Text = "";
        }
        dr.Close();
        conn.Close();
        ddlTyreCategory_SelectedIndexChanged(sender, e);
    }
    public void BindModel()
    {
        ddlTyreModel.Items.Clear();
        BindDropDown("USP_TYRE_MODEL", "MODEL_NO", "TYRE_MODEL_ID", ddlTyreModel);
    }
    protected void ddlManufacturer_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindModel();
        ddlTyreCategory_SelectedIndexChanged(sender, e);
    }
    protected void ddlTyreCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTyreCategory.SelectedIndex == 1)
        {
            ddlTyrePattern.Enabled = false; 
            //txtDispPattern.ReadOnly = true;
            txtTreadDepth.ReadOnly = true;
        }
        if (ddlTyreCategory.SelectedIndex == 2)
        {
            ddlTyrePattern.Enabled = false;
            //txtDispPattern.ReadOnly = true;
            txtTreadDepth.ReadOnly = false;
            //txtTreadDepth.Text = "";
        }
        if (ddlTyreCategory.SelectedIndex == 3)
        {
            ddlTyrePattern.Enabled = true;
            ddlTyrePattern.SelectedIndex = 0;
            //txtDispPattern.ReadOnly = false;
            txtTreadDepth.ReadOnly = false;
            //txtDispPattern.Text = "";
            txtTreadDepth.Text = "";
        }
    }
    public void BindPosCategory()
    {
        ddlTyrePosition.Items.Clear();
        //BindDropDown("USP_TYREPOSITION", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
        BindDropDown("usp_Bind_TyrePos_TyreMst", "TYREPOS_CODE", "TYREPOS_ID", ddlTyrePosition);
        
    }
    protected void ddlTyrePosCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPosCategory();
        ddlTyreCategory_SelectedIndexChanged(sender, e);
    }
   
}
