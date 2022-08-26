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


public partial class GUI_Fleet_Operations_Issue_JobOrderCancelled : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    //int _lastEditedPage;
    MyFleetDataSet.JobOrderCancelDataTable dt_JobOrderCancel = new MyFleetDataSet.JobOrderCancelDataTable();
    SqlConnection conn = new SqlConnection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btn_Submit.Attributes.Add("OnClick", "javascript:return CheckSubmit()");
            dt_JobOrderCancel.AddJobOrderCancelRow("", "", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
        }
    }

    private void BindGrid()
    {
        gvJobOrderCancel.DataSource = dt_JobOrderCancel;
        gvJobOrderCancel.DataBind();
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_JobOrderCancel.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_JobOrderCancel.AddJobOrderCancelRow("", "", "", "", "");
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }

    protected void gvJobOrderCancel_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtJOB_ORDER_NO = (TextBox)e.Row.FindControl("txtJOB_ORDER_NO"); 
            ((TextBox)e.Row.FindControl("txtCancellation_Date")).Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            txtJOB_ORDER_NO.Attributes.Add("OnBlur", "javascript:CheckManualJobOrderNo(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txtJob_Order_No")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtCancel_Reason")).ClientID.ToString() + "," + lbl_Page_Error.ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtJob_Order_Date")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtVehicle_No")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtJobSheet_Branch")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtOrder_Status")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtCancellation_Date")).ClientID.ToString() + ");");
            ((TextBox)e.Row.FindControl("txtCancellation_Date")).Attributes.Add("OnBlur", "javascript:CheckCancelDate(" + ((TextBox)e.Row.FindControl("txtJob_Order_No")).ClientID.ToString() + "," + ((TextBox)e.Row.FindControl("txtCancellation_Date")).ClientID.ToString() + "," + txtJOB_ORDER_NO.ClientID.ToString() + ");");
            Image img_cal = (Image)e.Row.FindControl("img_cal");
            TextBox txtCancellation_Date = (TextBox)e.Row.FindControl("txtCancellation_Date");
            img_cal.Attributes.Add("OnClick", "javascript:cal.select(" + txtCancellation_Date.ClientID + ",'" + img_cal.ClientID + "','dd/MM/yyyy');");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_JobOrderCancel JobOrderCancel = new cls_JobOrderCancel(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        foreach (GridViewRow gvr in gvJobOrderCancel.Rows)
        {
            JobOrderCancel.Job_Order_No = ((TextBox)gvr.FindControl("txtJob_Order_No")).Text;
            JobOrderCancel.Job_Order_Dt = ((TextBox)gvr.FindControl("txtJob_Order_Date")).Text;
            JobOrderCancel.VEHNO = ((TextBox)gvr.FindControl("txtVehicle_No")).Text;
            JobOrderCancel.JS_BRCD = ((TextBox)gvr.FindControl("txtJobSheet_Branch")).Text;
            JobOrderCancel.ORDER_STATUS = ((TextBox)gvr.FindControl("txtOrder_Status")).Text;
            //JobOrderCancel.VENDOR = ((TextBox)gvr.FindControl("txtVendor")).Text;
            
            SqlCommand cmd = new SqlCommand("Update_Manual_JobOrder_Cancel", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@JOB_ORDER_NO", SqlDbType.VarChar);
            param1.Direction = ParameterDirection.Input;

            SqlParameter param2 = new SqlParameter("@Cancel_Dt", SqlDbType.VarChar);
            param2.Direction = ParameterDirection.Input;

            SqlParameter param3 = new SqlParameter("@Cancel_Remarks", SqlDbType.VarChar);
            param3.Direction = ParameterDirection.Input;

            cmd.Parameters.Add(param1);
            cmd.Parameters.Add(param2);
            cmd.Parameters.Add(param3);
       
            try
            {
                cmd.Parameters[0].Value = ((TextBox)gvr.FindControl("txtJob_Order_No")).Text;
                cmd.Parameters[1].Value = ((TextBox)gvr.FindControl("txtCancellation_Date")).Text;
                cmd.Parameters[2].Value = ((TextBox)gvr.FindControl("txtCancel_Reason")).Text;
             
                cmd.ExecuteNonQuery();
                lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
                lbl_Page_Error.Text = "The Job Order Cancel Has Been Successfully Updated";
            }
            catch (Exception ex)
            {
                lbl_Page_Error.ForeColor = System.Drawing.Color.Red;
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
    }
    
}
