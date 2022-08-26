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

public partial class Operation_Device_ : System.Web.UI.Page
{
    static string CDT_Code, AddEditMode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            //getLocationStr();
            txtRefNo.Attributes.Add("onblur", "javascript:tupper(this)");
            txtBillCode.Attributes.Add("onblur", "javascript:tupper(this)");
            //txtNumber.Attributes.Add("onblur", "javascript:Locationcheck(this)");   
            CDM_Type();
            Vendor();
            chkActive.Checked = true;
            txtActive.Text = "Y";
            txtStartDt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            CDT_Code = Request.QueryString["id"];
            if (CDT_Code != null && CDT_Code !="")
            {
                RetriveData();
                AddEditMode = "U";
                txtEndDt.Enabled = true;
                lblAddEdit.Text = "Edit Existing";
            }
            else
            {
                AddEditMode = "I";
                txtEndDt.Enabled = false;
                lblAddEdit.Text = "Add New";
            }
            cboType.Focus();
        }
    }

    private void Vendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,webx_Vendor_Type vt where vt.Type_Code=vh.Vendor_Type and vt.Type_Code=vh.vendcat and vt.Type_Name ='Service Provider-Communication'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "VENDORNAME";
        cboVendor.DataValueField = "VENDORNAME";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "--Select--");
        conn.Close();
    }

    private void CDM_Type()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();        
        SqlDataAdapter da = new SqlDataAdapter("select CDT_Desc from Tel_Comm_Device_Type_Master", conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cboType.DataSource = ds;
        cboType.DataTextField = "CDT_Desc";
        cboType.DataValueField = "CDT_Desc";
        cboType.DataBind();
        cboType.Items.Insert(0, "--Select--");
        conn.Close();
    }

    private void RetriveData()
    {
        DateTime From = new DateTime();
        DateTime To = new DateTime();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select * from Tel_Comm_Device_Master where CDM_Code='" + CDT_Code + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblTypeCode.Text = Convert.ToString(dr["CDM_Code"]);
            cboType.SelectedValue = Convert.ToString(dr["CDM_Type"]);            
            txtNumber.Text = Convert.ToString(dr["CDM_Number"]);
            cboVendor.SelectedValue = Convert.ToString(dr["CDM_Vendor"]);
            txtPerson.Text = Convert.ToString(dr["CDM_Person"]);
            lblLocation.Text = Convert.ToString(dr["CDM_Location"]);
            txtRefNo.Text = Convert.ToString(dr["CDM_Cust_Ref"]);
            txtBillCode.Text = Convert.ToString(dr["CDM_Bill_Code"]);
            txtAmount.Text = Convert.ToString(dr["CDM_Credit_Amt"]);
            txtActive.Text = Convert.ToString(dr["CDM_Active"]);
            if (txtActive.Text.Trim() == "Y")
            {
                chkActive.Checked = true;
            }
            else
            {
                chkActive.Checked = false;
            }
            From = Convert.ToDateTime(dr["CDM_Start_Dt"]);
            txtStartDt.Text = From.ToString("dd/MM/yyyy");
            if (dr["CDM_End_Dt"].ToString() != "" && dr["CDM_End_Dt"].ToString() != null)
            {
                To = Convert.ToDateTime(dr["CDM_End_Dt"]);
                txtEndDt.Text = To.ToString("dd/MM/yyyy");
            }
            lblPersonName.Text = Convert.ToString(dr["CDM_Person_Name"]);
        }
        conn.Close();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            DateTime Start = new DateTime();
            DateTime End = new DateTime();

            Start = Convert.ToDateTime(txtStartDt.Text, dtfi);
            if (txtEndDt.Text != "")
            {
                End = Convert.ToDateTime(txtEndDt.Text, dtfi);
            }

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_Comm_Device_InsertUpdate", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (AddEditMode.ToString().Trim() == "I")
            {
                cmd.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = "I";
                cmd.Parameters.Add("@CDM_Code", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@CDM_Type", SqlDbType.VarChar).Value = cboType.SelectedItem.Text;
                cmd.Parameters.Add("@CDM_Number", SqlDbType.VarChar).Value = txtNumber.Text.Trim();
                cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = cboVendor.SelectedItem.Text.Trim();
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = txtPerson.Text.Trim();
                cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = lblLocation.Text.Trim();
                cmd.Parameters.Add("@CDM_Cust_Ref", SqlDbType.VarChar).Value = txtRefNo.Text.Trim();
                cmd.Parameters.Add("@CDM_Bill_Code", SqlDbType.VarChar).Value = txtBillCode.Text.Trim();
                cmd.Parameters.Add("@CDM_Credit_Amt", SqlDbType.Int).Value = txtAmount.Text.Trim();
                cmd.Parameters.Add("@CDM_Active", SqlDbType.VarChar).Value = txtActive.Text.Trim();
                cmd.Parameters.Add("@CDM_Start_Dt", SqlDbType.DateTime).Value = Start;
                cmd.Parameters.Add("@CDM_Person_Name", SqlDbType.VarChar).Value = lblPersonName.Text.Trim();
                
                //cmd.Parameters.Add("@CDM_End_Dt", SqlDbType.DateTime).Value = "";            
            }
            else
            {
                cmd.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = "U";
                cmd.Parameters.Add("@CDM_Code", SqlDbType.VarChar).Value = lblTypeCode.Text.Trim();
                cmd.Parameters.Add("@CDM_Type", SqlDbType.VarChar).Value = cboType.SelectedItem.Text.Trim();
                cmd.Parameters.Add("@CDM_Number", SqlDbType.VarChar).Value = txtNumber.Text.Trim();
                cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = cboVendor.SelectedItem.Text.Trim();
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = txtPerson.Text.Trim();
                cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = lblLocation.Text.Trim();
                cmd.Parameters.Add("@CDM_Cust_Ref", SqlDbType.VarChar).Value = txtRefNo.Text.Trim();
                cmd.Parameters.Add("@CDM_Bill_Code", SqlDbType.VarChar).Value = txtBillCode.Text.Trim();
                cmd.Parameters.Add("@CDM_Credit_Amt", SqlDbType.Int).Value = txtAmount.Text.Trim();
                cmd.Parameters.Add("@CDM_Active", SqlDbType.VarChar).Value = txtActive.Text.Trim();                
                cmd.Parameters.Add("@CDM_Start_Dt", SqlDbType.DateTime).Value = Start;
                if (txtEndDt.Text != "")
                {
                    cmd.Parameters.Add("@CDM_End_Dt", SqlDbType.DateTime).Value = End;
                }
                cmd.Parameters.Add("@CDM_Person_Name", SqlDbType.VarChar).Value = lblPersonName.Text.Trim();
            }
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Master_Page.aspx");
        }
    }
    protected void txtPerson_TextChanged(object sender, EventArgs e)
    {
        string Loc = "";
        string EmpCode = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select wl.Loccode + ' : ' + wl.LocName AS Location, we.empnm as empnm from webx_location wl,webx_EMPMST we where wl.loccode=we.currbrcd and we.empcd='" + txtPerson.Text.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        
        while(dr.Read())
        {
            Loc= Convert.ToString(dr["Location"]);
            EmpCode= Convert.ToString(dr["empnm"]);
            
        }
        conn.Close();

        if (Loc != "" && Loc != null)
        {
            lblLocation.Text = Loc;
            lblPersonName.Text = EmpCode;
        }
        else
        {
            lblPersonName.Text = "Assigned to Person ID is not Existing";            
        }
    }
    public void Person(object source, ServerValidateEventArgs value)
    {
        string Loc = "";
        string EmpCode = "";
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (CDT_Code != "" && CDT_Code != null)
        {
            sql = "select wl.Loccode + ' : ' + wl.LocName AS Location, we.empnm as empnm from webx_location wl,webx_EMPMST we where wl.loccode=we.currbrcd and we.empcd ='" + txtPerson.Text.Trim() + "'";
        }
        else
        {
            sql = "select wl.Loccode + ' : ' + wl.LocName AS Location, we.empnm as empnm from webx_location wl,webx_EMPMST we where wl.loccode=we.currbrcd and we.empcd <> '" + txtPerson.Text.Trim() + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Loc = Convert.ToString(dr["Location"]);
            EmpCode = Convert.ToString(dr["empnm"]);

        }
        conn.Close();

        if (Loc != "" && Loc != null)
        {
            value.IsValid = true;
        }
        else
        {
            value.IsValid = false; 
        }
    }
    protected void chkActive_CheckedChanged(object sender, EventArgs e)
    {
        if (chkActive.Checked == true)
        {
            txtActive.Text = "Y";
        }
        else
        {
            txtActive.Text = "N";
        }
    }
    public string Locationstr = "";
    public string getLocationStr()
    {
        
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();
        string sql = "select cdm_number from Tel_Comm_Device_Master";
         //where CDM_Number='" + txtNumber.Text.Trim() + "'
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            if (Locationstr == "")
            {
                Locationstr = dr_Location.GetValue(0).ToString();
            }
            else
            {
                Locationstr = Locationstr + "," + dr_Location.GetValue(0).ToString();
            }
        }
        dr_Location.Close();
        sqlConn.Close();
        return Locationstr;
    }
    public void Number(object source, ServerValidateEventArgs value)
    {
        string Desc = "";
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (CDT_Code != "" && CDT_Code != null)
        {
            sql = "select * from Tel_Comm_Device_Master where CDM_Number = '" + txtNumber.Text.Trim() + "' and CDM_Code <> '" + CDT_Code + "'";
        }
        else
        {
           sql = "select * from Tel_Comm_Device_Master where CDM_Number='" + txtNumber.Text.Trim() + "'";
        }
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Desc = Convert.ToString(dr["CDM_Number"]);
        }
        conn.Close();
        if (Desc != null && Desc != "")
        {
            value.IsValid = false; 
        }
        else
        {
            value.IsValid = true;
        }
    }
    protected void txtNumber_TextChanged(object sender, EventArgs e)
    {
        string Desc = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand("Tele_Comm_Device_MST_Search", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@Desc", SqlDbType.VarChar).Value = txtNumber.Text;

        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Desc = Convert.ToString(dr["Phone_No"]);
        }
        conn.Close();
        if (Desc == "1")
        {
            lblNumber.Text = "This Number is Existing";
        }
        else
        {
            lblNumber.Text = "";
        }
    }
    public void ToDate(object source, ServerValidateEventArgs value)
    {
        if (txtEndDt.Text != "")
        {            
            string[] strDtFrom = txtStartDt.Text.Split('/');
            DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
            string[] strDtTo = txtEndDt.Text.Split('/');
            DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
            DateTime dt3 = System.DateTime.Now;
            if (DateTime.Compare(dt1, dt2) > 0 )
            {
                value.IsValid = false;
            }
            else
            {
                value.IsValid = true;
            }
            if (dt2 > dt3)
            {
                value.IsValid = false;
            }
            else
            {
                value.IsValid = true;
            }
            if (dt1 > dt3)
            {
                value.IsValid = false;
            }
            else
            {
                value.IsValid = true;
            }
        }
    }
}
