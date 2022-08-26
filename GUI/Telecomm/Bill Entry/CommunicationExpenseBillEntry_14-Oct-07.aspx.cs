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

public partial class CommunicationExpenseBill_Entry : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    DataSet ds;
    string sql;
    public string anch = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {            
            lblVendor.Text = Request.QueryString["Vendor"];
            txtEntryDt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");            
            DataColumn dc0 = new DataColumn("Name", typeof(string));
            DataRow dr;
            dt.Columns.Add(dc0);
            for (int i = 0; i < 5; i++)
            {
                dr = dt.NewRow();
                dt.Rows.Add(dr);
            }
            gvBillDetails.DataSource = dt;
            gvBillDetails.DataBind(); 
        }
    }
    
    protected void txtNumber_TextChanged(object sender, EventArgs e)
    {
        int rowcount = Convert.ToInt16(txtNumber.Text);
        DataColumn dc0 = new DataColumn("Name", typeof(string));
        DataRow dr;
        dt.Columns.Add(dc0);
        for (int i = 0; i < rowcount; i++)
        {
            dr = dt.NewRow();
            dt.Rows.Add(dr);
        }
        gvBillDetails.DataSource = dt;
        gvBillDetails.DataBind();   
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (HidTotalAmount.Value.Trim() != "")
        {
            string BillEntryNo = SysGenNo();
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_Comm_Bill_Entry_HDR_Insert", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Bill_Entry_No", SqlDbType.VarChar).Value = BillEntryNo.Trim();
            cmd.Parameters.Add("@Bill_Entry_Dt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtEntryDt.Text, dtfi);
            cmd.Parameters.Add("@Bill_Vendor", SqlDbType.VarChar).Value = lblVendor.Text.Trim();
            cmd.Parameters.Add("@Bill_Tot_Amt", SqlDbType.Float).Value = HidTotalAmount.Value.Trim();
            cmd.Parameters.Add("@Bill_Svc_Tax", SqlDbType.Float).Value = HidSvcTax.Value.Trim();
            cmd.Parameters.Add("@Bill_Tot_Cess", SqlDbType.Float).Value = HidCess.Value.Trim();
            cmd.Parameters.Add("@Bill_TDS_Rate", SqlDbType.Float).Value = lblTDSRate.Text.Trim();
            cmd.Parameters.Add("@Bill_TDS", SqlDbType.Float).Value = lblTDS.Text.Trim();
            cmd.Parameters.Add("@Bill_Total", SqlDbType.Float).Value = HidTotal.Value.Trim();
            cmd.Parameters.Add("@Bill_Net_Pay", SqlDbType.Float).Value = HidNetPay.Value.Trim();

            cmd.ExecuteNonQuery();

            string GetTBH_Code = "";
            string sql = "select ID from TeleComm_Bill_HDR where Bill_Entry_No='" + BillEntryNo + "'";
            SqlCommand cmd2 = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd2.ExecuteReader();
            while (dr.Read())
            {
                GetTBH_Code = Convert.ToString(dr["ID"]);
            }
            dr.Close();

            string DeviceNo, BillNo, BillDate, DueDate, Amount, ServiceTax, Cess, Total;

            foreach (GridViewRow datarow in gvBillDetails.Rows)
            {
                SqlCommand cmd1 = new SqlCommand("usp_Comm_Bill_Entry_DET_Insert", conn);
                cmd1.CommandType = CommandType.StoredProcedure;

                DeviceNo = ((DropDownList)datarow.FindControl("ddlDevNo")).SelectedItem.Text;
                BillNo = ((TextBox)datarow.FindControl("txtBillNo")).Text;
                BillDate = ((TextBox)datarow.FindControl("txtBillDt")).Text;
                DueDate = ((TextBox)datarow.FindControl("txtDueDt")).Text;
                Amount = ((TextBox)datarow.FindControl("txtAmt")).Text;
                ServiceTax = ((TextBox)datarow.FindControl("txtSvcTax")).Text;
                Cess = ((TextBox)datarow.FindControl("txtCess")).Text;
                Total = ((TextBox)datarow.FindControl("lblTot")).Text;

                if (DeviceNo != "- Select One -")
                {
                    cmd1.Parameters.Add("@TBH_ID", SqlDbType.Int).Value = GetTBH_Code.Trim();
                    cmd1.Parameters.Add("@Bill_Dev_No", SqlDbType.VarChar).Value = DeviceNo.Trim();
                    cmd1.Parameters.Add("@Bill_No", SqlDbType.VarChar).Value = BillNo.Trim();
                    cmd1.Parameters.Add("@Bill_Dt", SqlDbType.DateTime).Value = Convert.ToDateTime(BillDate, dtfi);
                    cmd1.Parameters.Add("@Bill_Due_Dt", SqlDbType.DateTime).Value = Convert.ToDateTime(DueDate, dtfi);
                    cmd1.Parameters.Add("@Bill_Amt", SqlDbType.Float).Value = Amount.Trim();
                    cmd1.Parameters.Add("@Bill_Svc_Tax", SqlDbType.Float).Value = ServiceTax.Trim();
                    cmd1.Parameters.Add("@Bill_Cess", SqlDbType.Float).Value = Cess.Trim();
                    cmd1.Parameters.Add("@Bill_Total", SqlDbType.Float).Value = Total.Trim();

                    cmd1.ExecuteNonQuery();
                }
            }
            conn.Close();
            Response.Redirect("Result_Gen_Doc.aspx?DocNo=" + BillEntryNo);
        }
    }
    public string SysGenNo()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string mNewCode;
        string sql1 = "select max(rtrim(right((Bill_Entry_No),5))) from Telecomm_Bill_HDR";
        SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
        string i;
        i = Convert.ToString(Command.ExecuteScalar());
        if (i == "")
        {
            i = "0";
        }
        conn.Close();
        int j = Convert.ToInt16(i);
        int k = j + 1;
        string m = k.ToString();

        if (m.Length == 1)
        {
            m = "0000" + m;
        }
        else if (m.Length == 2)
        {
            m = "000" + m;
        }
        else if (m.Length == 3)
        {
            m = "00" + m;
        }
        else if (m.Length == 4)
        {
            m = "0" + m;
        }
        else if (m.Length == 5)
        {
            m = m;
        }

        mNewCode = "BE" + Session["brcd"].ToString().Trim() + m.ToString();        
        return mNewCode;
    }
    string DevNo = "";
    protected void CheckDeviceNo_TextChanged(object sender, EventArgs e)
    {
        gvBillDetails.SelectedIndex = ((GridViewRow)((DropDownList)sender).Parent.Parent).DataItemIndex;
        string DevNo = ((DropDownList)gvBillDetails.SelectedRow.FindControl("ddlDevNo")).SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql = "select CDM_Type,CDM_Person_Name from Tel_Comm_Device_Master where CDM_Number='" + DevNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            ((Label)gvBillDetails.SelectedRow.FindControl("DeviceType")).Text = Convert.ToString(dr["CDM_Type"]);
            ((Label)gvBillDetails.SelectedRow.FindControl("EmpName")).Text = Convert.ToString(dr["CDM_Person_Name"]);
        }
        conn.Close();

        //gvBillDetails.SelectedIndex = ((GridViewRow)((TextBox)sender).Parent.Parent).DataItemIndex;
        //string txtDevNo = ((TextBox)gvBillDetails.SelectedRow.FindControl("txtDevNo")).Text.Trim();

        //if (txtDevNo != "")
        //{
        //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //    conn.Open();
        //    sql = "select CDM_Number from Tel_Comm_Device_Master where CDM_Number='" + txtDevNo + "'";
        //    SqlCommand cmd = new SqlCommand(sql, conn);
        //    SqlDataReader dr = cmd.ExecuteReader();

        //    while (dr.Read())
        //    {
        //        DevNo = Convert.ToString(dr["CDM_Number"]);
        //    }
        //    conn.Close();

        //    if (DevNo == "")
        //    {
        //        //gvBillDetails.SelectedIndex = ((GridViewRow)((Label)sender).Parent.Parent).DataItemIndex;
        //        ((System.Web.UI.HtmlControls.HtmlGenericControl)gvBillDetails.SelectedRow.FindControl("lblDevNo")).InnerHtml = "Please Insert Correct Device No";
        //        //((TextBox)gvBillDetails.SelectedRow.FindControl("txtDes.Add("onblvNo")).Attributeur","javascript:return GiveAlert()");            
        //        ((TextBox)gvBillDetails.SelectedRow.FindControl("txtDevNo")).Text = "";
        //        ((TextBox)gvBillDetails.SelectedRow.FindControl("txtDevNo")).Focus();
        //    }
        //    else
        //    {
        //        ((System.Web.UI.HtmlControls.HtmlGenericControl)gvBillDetails.SelectedRow.FindControl("lblDevNo")).InnerHtml = "";
        //        //((Label)gvBillDetails.SelectedRow.FindControl("lblDevNo")).Text = "";
        //    }
        //}
    }
    protected void gvBillDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)        
        {            
            DropDownList DevNo = ((DropDownList)e.Row.FindControl("ddlDevNo"));
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter("select CDM_Number from Tel_Comm_Device_Master where CDM_Vendor='" + lblVendor.Text + "'", conn);
            da.Fill(ds);
            DevNo.DataSource = ds;
            DevNo.DataTextField = "CDM_Number";
            DevNo.DataValueField = "CDM_Number";
            DevNo.DataBind();
            DevNo.Items.Insert(0, "- Select One -");

            TextBox tb = ((TextBox)e.Row.FindControl("txtDueDt"));
            anch = "<a href='#' onclick=\"cal.select(" + tb.ClientID + ",'anchor1','dd/MM/yyyy');\" id=\"a1\" runat=\"server\"> <img src=\"./../../images/calendar.jpg\" border=\"0\" /></a>";
        }
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
            
        //}
    }
}
