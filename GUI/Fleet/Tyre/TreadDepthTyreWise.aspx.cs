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
           
            txtKMRun.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtTreadDepth.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtTyrePosition.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtVehNumber.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtManufacturer.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
            txtLastAvgTWI.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtTWI1.ClientID.ToString() + "').focus();");
           
            txtTyreNo.Attributes.Add("OnBlur", "javascript:GetTyreDetails(" + txtTyreNo.ClientID.ToString() + ","
            + "" + txtKMRun.ClientID.ToString() + ","
            + "" + txtTreadDepth.ClientID.ToString() + ","
            + "" + txtTyrePosition.ClientID.ToString() + ","
            + "" + txtVehNumber.ClientID.ToString() + ","
            + "" + txtManufacturer.ClientID.ToString() + ","
            + "" + txtModel.ClientID.ToString() + ","
            + "" + hfTyreId.ClientID.ToString() + ","
            + "" + txtLastAvgTWI.ClientID.ToString() + ","
            + "" + hfVehId.ClientID.ToString() +");");

            //TextBox1.Attributes.Add("OnBlur", "javascript:FillTreadDepth();");

            btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/TdmTyreNo.aspx?"
            + "tyreId=" + hfTyreId.ClientID + ""
            + "&tyreno=" + txtTyreNo.ClientID + ""
            + "&KMRun=" + txtKMRun.ClientID + ""
            + "&TreadDepth=" + txtTreadDepth.ClientID + ""
            + "&TyrePosition=" + txtTyrePosition.ClientID + ""
            + "&VehNumber=" + txtVehNumber.ClientID + ""
            + "&Manufacturer=" + txtManufacturer.ClientID + ""
            + "&Model=" + txtModel.ClientID + ""
            + "&LastAvgTWI=" + txtLastAvgTWI.ClientID + ""
            + "&VehId=" + hfVehId.ClientID + "'"
            + ",null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        

            string script;
            script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
            this.RegisterStartupScript("MyAlert", script);

            txtTWI1.Attributes.Add("OnBlur", "javascript:CalculateAvg1(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + txtAvgTWI.ClientID.ToString() + "," + txtTyreNo.ClientID.ToString() + "," + txtTreadDepth.ClientID.ToString() + ");");
            txtTWI2.Attributes.Add("OnBlur", "javascript:CalculateAvg2(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + txtAvgTWI.ClientID.ToString() + "," + txtTyreNo.ClientID.ToString() + "," + txtTreadDepth.ClientID.ToString() + ");");
            txtTWI3.Attributes.Add("OnBlur", "javascript:CalculateAvg3(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + txtAvgTWI.ClientID.ToString() + "," + txtTyreNo.ClientID.ToString() + "," + txtTreadDepth.ClientID.ToString() + ");");

            //img_CalendarDate.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtTDMDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtTDMDate.ClientID + @"\')')");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(Session["SqlProvider"].ToString().Trim());
        cTDM.TD_ID = "";
        try
        {
            if (hfVehId.Value != "")
            {
                cTDM.VehId = Convert.ToInt32(hfVehId.Value.ToString());
            }
            else
            {
                cTDM.VehId = 0;
            }
            cTDM.TYRE_ID = txtTyreNo.Text.ToString().Trim(); 
            cTDM.VEH_NO = txtVehNumber.Text.ToString().Trim();
            cTDM.AVG_TWI = txtAvgTWI.Text.ToString();
            cTDM.TWI1 = txtTWI1.Text.ToString().Trim();
            cTDM.TWI2 = txtTWI2.Text.ToString().Trim();
            cTDM.TWI3 = txtTWI3.Text.ToString().Trim();
            cTDM.TDM_DT = txtTDMDate.Text.ToString().Trim();
            cTDM.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
            try
            {
                cTDM.InsertUpdateTDM();
            }
            catch (Exception ex)
            {
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }
        finally
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "!!    Tread Depth Measurement has been saved successfully    !!";
            clear();
            hfVehId.Value = "01";
        }
    }
    public void clear()
    {
        txtTyreNo.Text = "";
        txtVehNumber.Text = "";
        txtKMRun.Text = "";
        txtTreadDepth.Text = "";
        txtTyrePosition.Text = "";
        txtVehNumber.Text = "";
        txtManufacturer.Text = "";
        txtModel.Text = "";
        hfTyreId.Value = "";
        txtLastAvgTWI.Text = "";
        txtTWI1.Text = "0.0";
        txtTWI2.Text = "0.0";
        txtTWI3.Text = "0.0";
        txtAvgTWI.Text = "0.0";
        txtTDMDate.Text = "";
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("TreadDepthMeasurement.aspx");
    }
}
