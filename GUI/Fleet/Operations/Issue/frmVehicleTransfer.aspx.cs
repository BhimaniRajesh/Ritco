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

public partial class GUI_Fleet_Operations_Issue_frmVehicleTransfer : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    //int _lastEditedPage;
    MyFleetDataSet.VehicleTransferDataTable dt_VehicleTransfer = new MyFleetDataSet.VehicleTransferDataTable();
    SqlConnection conn = new SqlConnection();

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            dt_VehicleTransfer.AddVehicleTransferRow("", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
        }
    }

    private void BindGrid()
    {
        gvVehicleTransfer.DataSource = dt_VehicleTransfer;
        gvVehicleTransfer.DataBind();
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_VehicleTransfer.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        foreach (GridViewRow gvr in gvVehicleTransfer.Rows)
        {
            dt_VehicleTransfer.AddVehicleTransferRow(
                ((TextBox)gvr.FindControl("txtVehNo")).Text,
                ((TextBox)gvr.FindControl("txtNewVehNo")).Text,
                ((TextBox)gvr.FindControl("txtNewContlBranch")).Text,
                ((TextBox)gvr.FindControl("txtVehTransferDt")).Text
            );
        }


        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_VehicleTransfer.AddVehicleTransferRow("", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();

        //for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        //{
        //    dt_VehicleTransfer.AddVehicleTransferRow("", "", "", "");
        //}
        //tb_Row_No.Text = "0";
        //BindGrid();
        //lbl_Page_Error.Text = "";
    }

    protected void gvVehicleTransfer_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {        
            TextBox txtVehNo = (TextBox)e.Row.FindControl("txtVehNo");
            TextBox txtNewVehNo = (TextBox)e.Row.FindControl("txtNewVehNo");
            TextBox txtNewContlBranch = (TextBox)e.Row.FindControl("txtNewContlBranch");
            TextBox txtVehTransferDt = (TextBox)e.Row.FindControl("txtVehTransferDt");
            Button btnPopupVehNo = (Button)e.Row.FindControl("btnPopupVehNo");
            Button btnPopupLoc = (Button)e.Row.FindControl("btnPopupLoc");

            TextBox txtVehInternalNo = (TextBox)e.Row.FindControl("txtVehInternalNo");
            TextBox txtCurrContlLoc = (TextBox)e.Row.FindControl("txtCurrContlLoc");
            TextBox txtCurrKmRead = (TextBox)e.Row.FindControl("txtCurrKmRead");

            txtVehNo.Attributes.Add("OnBlur", "javascript:CheckVehicleNo(" + e.Row.RowIndex + "," + txtVehNo.ClientID.ToString() + "," + txtVehInternalNo.ClientID.ToString() + "," + txtCurrContlLoc.ClientID.ToString() + "," + txtCurrKmRead.ClientID.ToString() + "," + txtNewVehNo.ClientID.ToString() + "," + txtNewContlBranch.ClientID.ToString() + "," + txtVehTransferDt.ClientID.ToString() + ");");
            btnPopupVehNo.Attributes.Add("OnClick", "javascript:window.open('popup-Vehicle.aspx?VEHNO=" + txtVehNo.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=400, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupLoc.Attributes.Add("OnClick", "javascript:window.open('Popup-Location.aspx?hfloccode=" + txtNewContlBranch.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=400, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            txtNewVehNo.Attributes.Add("OnBlur", "javascript:CheckNewVehicleNo(" + txtNewVehNo.ClientID.ToString() + ");");
            txtNewContlBranch.Attributes.Add("OnBlur", "javascript:CheckNewControllingBranch(" + txtNewContlBranch.ClientID.ToString() + ");");
            //txtVehTransferDt.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            txtVehTransferDt.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx');CheckTransferDate(" + txtVehNo.ClientID.ToString() + "," + txtVehTransferDt.ClientID.ToString() + ");");
            Image img_cal = (Image)e.Row.FindControl("img_cal");
            img_cal.Attributes.Add("OnClick", "javascript:cal.select(" + txtVehTransferDt.ClientID + ",'" + img_cal.ClientID + "','dd/MM/yyyy');");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_VehicleTransfer VehTrans = new cls_VehicleTransfer(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false;

        try
        {
            foreach (GridViewRow gridrow in gvVehicleTransfer.Rows)
            {
                TextBox txtVehNo = (TextBox)gridrow.FindControl("txtVehNo");
                TextBox txtNewVehNo = (TextBox)gridrow.FindControl("txtNewVehNo");
                TextBox txtNewContlBranch = (TextBox)gridrow.FindControl("txtNewContlBranch");
                TextBox txtVehTransferDt = (TextBox)gridrow.FindControl("txtVehTransferDt");
                Button btnPopupVehNo = (Button)gridrow.FindControl("btnPopupVehNo");
                Button btnPopupLoc = (Button)gridrow.FindControl("btnPopupLoc");

                TextBox txtVehInternalNo = (TextBox)gridrow.FindControl("txtVehInternalNo");
                TextBox txtCurrContlLoc = (TextBox)gridrow.FindControl("txtCurrContlLoc");
                TextBox txtCurrKmRead = (TextBox)gridrow.FindControl("txtCurrKmRead");

                VehTrans.VEHNO = txtVehNo.Text.ToString().Trim();
                VehTrans.VEH_INTERNAL_NO = txtVehInternalNo.Text.ToString().Trim();
                VehTrans.CURLOC = txtCurrContlLoc.Text.ToString().Trim();
                VehTrans.Current_KM_Read = txtCurrKmRead.Text.ToString().Trim();
                VehTrans.New_VehicleNo = txtNewVehNo.Text.ToString().Trim();
                VehTrans.New_Control_Loc = txtNewContlBranch.Text.ToString().Trim();
                VehTrans.Veh_Transfer_Date = txtVehTransferDt.Text.ToString().Trim();
                VehTrans.EntryBy = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                //VehTrans.UpdatedBy = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                //VehTrans.UpdatedDt = DTM.ConvertToDate(hfTodayDate.Value.ToString());

                VehTrans.BeginTransaction();
                //VehTrans.InsertVehicleTransfer();
                //IsCommitted = VehTrans.CommitTransaction();

                try
                {
                    if (lbl_Page_Error.Text == "")
                    {
                        VehTrans.InsertVehicleTransfer();
                        IsCommitted = VehTrans.CommitTransaction();
                    }
                }
                catch (Exception ex)
                {
                    VehTrans.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }

            }
        }
        catch(Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }
        if (IsCommitted)
        {
            //tb_Row_No.text = "0";
            dt_VehicleTransfer.Rows.Clear();
            dt_VehicleTransfer.AddVehicleTransferRow("", "", "", "");
            BindGrid();

            lbl_Submit.ForeColor = System.Drawing.Color.Green;
            lbl_Submit.Text = "Record is Inserted";
        }

    }

}
