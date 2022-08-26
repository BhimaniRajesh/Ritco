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
    
    //public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    //MyFleetDataSet.TyreIssueRow datarow;
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
        if (!IsPostBack)
        {
            //btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km="+ hfkm.ClientID.ToString() +"',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo_TyreRotate.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "&vehcat=" + hfVehcate.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDate.ClientID + @"\')')");
            txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(" + txtVehNo.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfKm.ClientID.ToString() + ");");
            //img_CalendarDate.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtTDMDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtTDMDate.ClientID + @"\')')");
            DateRow.Visible = false;
        }
        //string script;
        //script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
        //this.RegisterStartupScript("MyAlert", script);
    }

    public void BindGrid()
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(Session["SqlProvider"].ToString().Trim());
        cTDM.VehId = Convert.ToInt32(hfVehIntId.Value);
        cTDM.BindGridTyreDetails(gvTreadDepth); 
    }

    protected void gvTreadDepth_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtTWI1 = (TextBox)e.Row.FindControl("txtTWI1");
            TextBox txtTWI2 = (TextBox)e.Row.FindControl("txtTWI2");
            TextBox txtTWI3 = (TextBox)e.Row.FindControl("txtTWI3");
            TextBox lblAvgTWI = (TextBox)e.Row.FindControl("lblAvgTWI");
            Label lblLastAvgTWI = (Label)e.Row.FindControl("lblLastAvgTWI");
            HiddenField hfTyreNo = (HiddenField)e.Row.FindControl("hfTyreNo");
            HiddenField hfOldTDMAvg = (HiddenField)e.Row.FindControl("hfOldTDMAvg");
            cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(Session["SqlProvider"].ToString().Trim());
            cTDM.TYRE_ID = hfTyreNo.Value.ToString();
            cTDM.checkTreadDepth();

            if (cTDM.IsRecordFound == false)
            {
                lblLastAvgTWI.Text = e.Row.Cells[3].Text.ToString().Trim();
            }

            lblAvgTWI.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnSubmit.ClientID.ToString() + "').focus();");
            txtTWI1.Attributes.Add("OnBlur", "javascript:CalculateAvg1(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + lblAvgTWI.ClientID.ToString() + "," + hfTyreNo.ClientID.ToString() + "," + hfOldTDMAvg.ClientID.ToString() + ");");
            txtTWI2.Attributes.Add("OnBlur", "javascript:CalculateAvg2(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + lblAvgTWI.ClientID.ToString() + "," + hfTyreNo.ClientID.ToString() + "," + hfOldTDMAvg.ClientID.ToString() + ");");
            txtTWI3.Attributes.Add("OnBlur", "javascript:CalculateAvg3(" + txtTWI1.ClientID.ToString() + "," + txtTWI2.ClientID.ToString() + "," + txtTWI3.ClientID.ToString() + "," + lblAvgTWI.ClientID.ToString() + "," + hfTyreNo.ClientID.ToString() + "," + hfOldTDMAvg.ClientID.ToString() + ");");
        }
    }   

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        cTDM.TD_ID = "";
        try
        {
            foreach (GridViewRow r in gvTreadDepth.Rows)
            {
                cTDM.VehId = Convert.ToInt32(hfVehIntId.Value.ToString());
                cTDM.TYRE_ID = gvTreadDepth.Rows[r.RowIndex].Cells[0].Text.ToString();
                cTDM.VEH_NO = txtVehNo.Text.ToString().Trim();
                cTDM.AVG_TWI = ((TextBox)gvTreadDepth.Rows[r.RowIndex].FindControl("lblAvgTWI")).Text.ToString().Trim();
                cTDM.TWI1 = ((TextBox)gvTreadDepth.Rows[r.RowIndex].FindControl("txtTWI1")).Text.ToString().Trim();
                cTDM.TWI2 = ((TextBox)gvTreadDepth.Rows[r.RowIndex].FindControl("txtTWI2")).Text.ToString().Trim();
                cTDM.TWI3 = ((TextBox)gvTreadDepth.Rows[r.RowIndex].FindControl("txtTWI3")).Text.ToString().Trim();
                cTDM.TDM_DT = txtTDMDate.Text.ToString().Trim();
                try
                {
                    cTDM.InsertUpdateTDM();
                }
                catch (Exception ex)
                {
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
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
            txtVehNo.Text = "";
            hfVehIntId.Value = "01";
            DateRow.Visible = false;
            btnSubmit.Visible = false;
            BindGrid();
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindGrid();
        if (gvTreadDepth.Rows.Count != 0)
        {
            DateRow.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            DateRow.Visible = false;
            btnSubmit.Visible = false;
        }
        lbl_Page_Error.Text = "";
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("TreadDepthMeasurement.aspx");
    }
    protected void gvTreadDepth_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#E0E0E0'");

        //    e.Row.Attributes.Add("onmouseout","this.style.backgroundColor=this.originalstyle;");

        //}
    }
}
