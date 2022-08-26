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

public partial class Tyre_Remould : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.ODOMETERDataTable dt_Odometer = new MyFleetDataSet.ODOMETERDataTable();  
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dt_Odometer.AddODOMETERRow(0, System.DateTime.Now,"", 0, 0, System.DateTime.Now,"");
            BindGrid();
            lbl_Page_Error.Text = ""; 
        }
    }
    private void BindGrid()
    {
        gvOdometer.DataSource = dt_Odometer;
        gvOdometer.DataBind();
    }

    protected void gvOdometer_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((TextBox)e.Row.FindControl("txtVehicleNo")).Attributes.Add("OnBlur", "javascript:checkVehNo(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txtVehicleNo")).ClientID.ToString() + "," + ((HiddenField)e.Row.FindControl("hfVehid")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtCurKM")).ClientID.ToString() + ");");
            ((TextBox)e.Row.FindControl("txtCurKM")).Attributes.Add("OnFocus", "javascript:document.getElementById('" + ((TextBox)e.Row.FindControl("txtOdometerRead")).ClientID.ToString() + "').focus();");
            ((TextBox)e.Row.FindControl("txtOdometerRead")).Attributes.Add("OnBlur", "javascript:checkOdoReader(" + ((TextBox)e.Row.FindControl("txtOdometerRead")).ClientID.ToString() + ");");
            //((Image)e.Row.FindControl("img_Calendar")).Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + ((TextBox)e.Row.FindControl("txtOdoReadDate")).ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + ((TextBox)e.Row.FindControl("txtOdoReadDate")).ClientID + @"\')')");
            ((Button)e.Row.FindControl("btnPopupVehNo")).Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo_TyreOdometer.aspx?vehno=" + ((TextBox)e.Row.FindControl("txtVehicleNo")).ClientID + "&km=" + ((TextBox)e.Row.FindControl("txtCurKM")).ClientID + "&vehid=" + ((HiddenField)e.Row.FindControl("hfVehid")).ClientID + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //((DropDownList)e.Row.FindControl("ddlReason")).Attributes.Add("");
            DropDownList ddlReason = (DropDownList)e.Row.FindControl("ddlReason");
            BindDropDown("USP_TYRE_ODOMETER_REASON", "CodeDesc", "CodeId", ddlReason);   
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

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_Odometer.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_Odometer.AddODOMETERRow(0, System.DateTime.Now, "", 0, 0, System.DateTime.Now,"");
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_TyreOdometer TyreOdoMeter = new cls_TyreOdometer(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        TyreOdoMeter.Tran_No = 0;
        try
        {
            foreach (GridViewRow gvr in gvOdometer.Rows)
            {
                //TyreOdoMeter.VehicleNo = ((TextBox)gvr.FindControl("txtVehicleNo")).Text;
                TyreOdoMeter.VehicleNo = ((HiddenField)gvr.FindControl("hfVehid")).Value;
                TyreOdoMeter.Last_Km_Reading = Convert.ToDouble(((TextBox)gvr.FindControl("txtCurKM")).Text);
                TyreOdoMeter.Odometer_Reading = Convert.ToDouble(((TextBox)gvr.FindControl("txtOdometerRead")).Text);
                string[] Todt = ((TextBox)gvr.FindControl("txtOdoReadDate")).Text.ToString().Split('/');
                DateTime d1 = new DateTime(Convert.ToInt32(Todt[2].ToString()), Convert.ToInt32(Todt[1].ToString()), Convert.ToInt32(Todt[0].ToString()));
                TyreOdoMeter.Odometer_Reading_Dt = d1;
                //TyreOdoMeter.Odometer_Reading_Dt = Convert.ToDateTime(((TextBox)gvr.FindControl("txtOdoReadDate")).Text.ToString().Trim());
                TyreOdoMeter.BeginTransaction();
                TyreOdoMeter.Odometer_Reason = ((DropDownList)gvr.FindControl("ddlReason")).SelectedValue;  
                try
                {
                    TyreOdoMeter.InsertTyreRemould();
                    IsCommitted = TyreOdoMeter.CommitTransaction();
                }
                catch (Exception ex)
                {
                    TyreOdoMeter.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
            //tb_Row_No.Text = "0";
            //dt_Odometer.Rows.Clear();
            //dt_Odometer.AddODOMETERRow(0, System.DateTime.Now, "", 0, 0, System.DateTime.Now);
            //BindGrid();

            //lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            //lbl_Page_Error.Text = "!!    Tyre Odometer has been saved successfully   !!";
            Response.Redirect("TyreOdometerSearch.aspx");
        }
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

   
}
