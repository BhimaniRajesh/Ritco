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
public partial class Tyre_Warranty : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {   
            string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            Common objCommon = new Common();
            objCommon.doCacheRoutine();
            this.Title = pagetitle;
           
            //txtKMRun.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtTreadDepth.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtTotalCost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtPurchasePrice.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtManufacturer.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            //txtTyreNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            

            txtTyreNo.Attributes.Add("OnBlur", "javascript:GetTyreDetails("
            + "" + txtTyreNo.ClientID.ToString() + ","
            + "" + hfTyreId.ClientID.ToString() + ","
            + "" + txtManufacturer.ClientID.ToString() + ","
            + "" + txtPurchasePrice.ClientID.ToString() + ","
            + "" + txtKMRun.ClientID.ToString() + ","
            + "" + txtModel.ClientID.ToString() + ","
            + "" + txtTreadDepth.ClientID.ToString() + ","
            + "" + hfVehId.ClientID.ToString() + ","
            + "" + txtTotalCost.ClientID.ToString() + ");");

            //TextBox1.Attributes.Add("OnBlur", "javascript:FillTreadDepth();");

            btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/Warranty_TyreNo.aspx?"
            + "hfTyreNo=" + txtTyreNo.ClientID.ToString().Trim() + ""
            + "&hTyreID=" + hfTyreId.ClientID.ToString().Trim() + ""
            + "&hfMFG=" + txtManufacturer.ClientID.ToString().Trim() + ""
            + "&hfTyreCost=" + txtPurchasePrice.ClientID.ToString().Trim() + ""
            + "&hfTOTKM=" + txtKMRun.ClientID.ToString().Trim() + ""
            + "&hfModel=" + txtModel.ClientID.ToString().Trim() + ""
            + "&hfLastTreadDepth=" + txtTreadDepth.ClientID.ToString().Trim() + ""
            + "&hfVehId=" + hfVehId.ClientID.ToString().Trim() + ""
            + "&hfTotalCost=" + txtTotalCost.ClientID.ToString().Trim() + ""
            + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        
            string script;
            script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
            this.RegisterStartupScript("MyAlert", script);
            //img_CalendarDate.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtWarrantyDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtWarrantyDate.ClientID + @"\')')");
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtClaimWarrantyDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtClaimWarrantyDate.ClientID + @"\')')");

            txtReplaceTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(" + txtReplaceTyreNo.ClientID.ToString() + ");");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls_Tyre_Warranty cWarranty = new cls_Tyre_Warranty(Session["SqlProvider"].ToString().Trim());
        cWarranty.W_ID = "";
        try
        {   
            cWarranty.TYRE_ID  = hfTyreId.Value.ToString();
            cWarranty.USED_COST = txtUsedCost.Text.ToString().Trim();
            cWarranty.WARRANTY_DT = txtWarrantyDate.Text.ToString().Trim();
            cWarranty.WARRANTY_KM = txtWarrantyKM.Text.ToString().Trim();
            cWarranty.CLAIMING_DT = txtClaimWarrantyDate.Text.ToString().Trim();
            cWarranty.REPLACE_TYRENO = txtReplaceTyreNo.Text.ToString().Trim();
            try
            {
                cWarranty.InsertUpdateWarranty();
                lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
                lbl_Page_Error.Text = "!!    Tyre Warranty has been saved successfully    !!";
                clear();
            }
            catch (Exception ex)
            {
                lbl_Page_Error.ForeColor = System.Drawing.Color.Red;
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Red;
            lbl_Page_Error.Text = ex.Message.ToString();
        }   
    }
    public void clear()
    {
        txtTyreNo.Text = "";
        txtUsedCost.Text = "";
        txtWarrantyDate.Text = "";
        txtWarrantyKM.Text = "";
        txtClaimWarrantyDate.Text = "";
        txtReplaceTyreNo.Text = "";
        txtTyreNo.Focus();
    }

  
}
