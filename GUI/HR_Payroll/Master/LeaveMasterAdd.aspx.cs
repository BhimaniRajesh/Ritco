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

public partial class GUI_HR_Payroll_Master_LeaveMasterAdd : System.Web.UI.Page
{
    SqlConnection conn;
    static DataTable dt;
    int no;
    public string SQLInsert, CarryOverValue, AffectSalaryValue, strrightnow, LeaveCode, flag, Sql_Select, SQL_Update;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        LeaveCode = Convert.ToString(Request.QueryString["Code"]);
        string[] Split = LeaveCode.Split(new Char[] { ',' });
        LeaveCode = Convert.ToString(Split[0]);
        flag = Convert.ToString(Split[1]);

        if (!IsPostBack)
        {
            getstring();
            if (flag == "E")
            {
                tblAddrows.Visible = false;
                GridLeaveType.Visible = false;
                GridView1.Visible = true;
                
                EditRows();
                
            }
            else if (flag == "A")
            {
                tblAddrows.Visible = true;
                GridLeaveType.Visible = true;
                GridView1.Visible = false;
               
                BindRows();
               
                btnAddrows.Attributes.Add("onclick", "javascript:return CheckData(" + txtAddrows.ClientID + "," + btnAddrows.ClientID + ")");
            }
            
        }
       
        
        
    }
    private void getstring()
    {
        conn.Open();
        string Branch = Session["brcd"].ToString();
        string sql = "select Upper(LEAVE_NAME) as code from WEBX_LEAVETYPEMST WHERE DELETED='N'";
        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        SqlDataReader drCode;
        drCode = sqlCommand.ExecuteReader();
        while (drCode.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(drCode["code"] + "'"));
        }
        if (drCode.HasRows == false)
        {
            Page.RegisterArrayDeclaration("str", "'TEST'");
        }
        drCode.Close();

        conn.Close();
    }	

    private void EditRows()
    {
        conn.Open();
        Sql_Select = "Webx_LeaveMaster_List";
        SqlCommand SqlCmd = new SqlCommand(Sql_Select, conn);
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(SqlCmd);

        da.SelectCommand.Parameters.Add("@Code", SqlDbType.VarChar).Value = LeaveCode.ToString().Trim();
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("LEAVE_NAME", typeof(string));
        dt.Columns.Add("LEAVE_DESC", typeof(string));
        dt.Columns.Add("AFFECT_SALARY", typeof(string));
        dt.Columns.Add("CARRY_OVER", typeof(string));
        dt.Columns.Add("CARRY_OVER_LIMIT", typeof(string));

        DataRow dr3, dr4;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr3 = dt.NewRow();
            dr3["LEAVE_NAME"] = (drRows["LEAVE_NAME"]);
            dr3["LEAVE_DESC"] = (drRows["LEAVE_DESC"]);
            dr3["AFFECT_SALARY"] = (drRows["AFFECT_SALARY"]);
            dr3["CARRY_OVER"] = (drRows["CARRY_OVER"]);
            dr3["CARRY_OVER_LIMIT"] = (drRows["CARRY_OVER_LIMIT"]);
            dt.Rows.Add(dr3);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            TextBox Code = (TextBox)gridrow.FindControl("txtCode");
            TextBox Description = (TextBox)gridrow.FindControl("txtDescription");
            CheckBox AffectsSalary = (CheckBox)gridrow.FindControl("ChkAffectSalary");
            CheckBox CarryOver = (CheckBox)gridrow.FindControl("chkCarryOver");
            TextBox CarryOverLimit = (TextBox)gridrow.FindControl("txtCarryOverLimit");
            Label chkdisp1 = (Label)gridrow.FindControl("chkdisp1");
            Label chkdisp2 = (Label)gridrow.FindControl("chkdisp2");
            chkdisp1.Visible = false;
            if (chkdisp1.Text.ToString() == "Yes")
            {
                AffectsSalary.Checked = true;
            }
            else
            {
                AffectsSalary.Checked = false;
            }
            chkdisp2.Visible = false;
            if (chkdisp2.Text.ToString() == "Yes")
            {
                CarryOver.Checked = true;
            }
            else
            {
                CarryOver.Checked = false;
            }
            
        }
        
    }

    private void BindRows()
    {
        dt = new DataTable();
        if (txtAddrows.Text == "")
        {
            txtAddrows.Text = "1";
        }
        no = Convert.ToInt32(txtAddrows.Text);
        if (no <= 0)
        {
            btnSubmitGridData.Visible = false;
        }
        else
        {
            btnSubmitGridData.Visible = true;
        }
        for (int i = 0; i < no; i++)
        {
            dt.Rows.Add();
        }

        GridLeaveType.DataSource = dt;
        GridLeaveType.DataBind();

        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd MMM yyyy");
    }
    protected void btnAddrows_Click(object sender, EventArgs e)
    {
        BindRows();
    }
    protected void btnSubmitGridData_Click(object sender, EventArgs e)
    {
        conn.Open();
        if (flag == "E")
        {
            foreach (GridViewRow gridrow in GridView1.Rows)
            {
                TextBox Code = (TextBox)gridrow.FindControl("txtCode");
                TextBox Description = (TextBox)gridrow.FindControl("txtDescription");
                CheckBox AffectsSalary = (CheckBox)gridrow.FindControl("ChkAffectSalary");
                CheckBox CarryOver = (CheckBox)gridrow.FindControl("chkCarryOver");
                TextBox CarryOverLimit = (TextBox)gridrow.FindControl("txtCarryOverLimit");

                if (Code.Text != "")
                {
                    SQL_Update = "Webx_LeaveMaster_Update";
                    SqlCommand SqlCmd = new SqlCommand(SQL_Update, conn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;

                    string brcd = Convert.ToString(Session["brcd"]);
                    string empcd = Convert.ToString(Session["Empcd"]);

                    SqlCmd.Parameters.Add("@Code", SqlDbType.VarChar).Value = Code.Text.ToString().Trim();
                    SqlCmd.Parameters.Add("@LeaveName", SqlDbType.VarChar).Value = Code.Text.ToString().Trim();
                    SqlCmd.Parameters.Add("@LeaveDesc", SqlDbType.VarChar).Value = Description.Text.ToString().Trim();
                    
                   
                    if (AffectsSalary.Checked == true)
                    {
                        AffectSalaryValue = "Y";
                    }
                    else
                    {
                        AffectSalaryValue = "N";
                    }
                    SqlCmd.Parameters.Add("@AffectSalary", SqlDbType.VarChar).Value = AffectSalaryValue.ToString();
                    
                    if (CarryOver.Checked == true)
                    {
                        CarryOverValue = "Y";
                    }
                    else
                    {
                        CarryOverValue = "N";
                    }

                    SqlCmd.Parameters.Add("@CarryOver", SqlDbType.VarChar).Value = CarryOverValue.ToString();
                    if (CarryOverLimit.Text == "")
                    {
                        SqlCmd.Parameters.Add("@CarryOverLimit", SqlDbType.Int).Value = 0;
                    }
                    else
                    {
                        SqlCmd.Parameters.Add("@CarryOverLimit", SqlDbType.Int).Value = Convert.ToInt32(CarryOverLimit.Text);
                    }
                    SqlCmd.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    SqlCmd.Parameters.Add("@UpdateBy", SqlDbType.VarChar).Value = empcd.ToString().Trim();

                    SqlCmd.ExecuteNonQuery();
                }


            }
            Response.Redirect("./LeaveMasterSelection.aspx?");
        }
        else
        {
            foreach (GridViewRow gridrow in GridLeaveType.Rows)
            {
                TextBox Code = (TextBox)gridrow.FindControl("txtCode");
                TextBox Description = (TextBox)gridrow.FindControl("txtDescription");
                CheckBox AffectsSalary = (CheckBox)gridrow.FindControl("ChkAffectSalary");
                CheckBox CarryOver = (CheckBox)gridrow.FindControl("chkCarryOver");
                TextBox CarryOverLimit = (TextBox)gridrow.FindControl("txtCarryOverLimit");

                if (Code.Text != "")
                {
                    SQLInsert = "Webx_LeaveMaster_InsertData";
                    SqlCommand SqlCmd = new SqlCommand(SQLInsert, conn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;

                    string brcd = Convert.ToString(Session["brcd"]);
                    string empcd = Convert.ToString(Session["Empcd"]);

                    SqlCmd.Parameters.Add("@LeaveName", SqlDbType.VarChar).Value = Code.Text.ToString().Trim();
                    SqlCmd.Parameters.Add("@LeaveDesc", SqlDbType.VarChar).Value = Description.Text.ToString().Trim();
                    if (AffectsSalary.Checked == true)
                    {
                        AffectSalaryValue = "Y";
                    }
                    else
                    {
                        AffectSalaryValue = "N";
                    }
                    SqlCmd.Parameters.Add("@AffectSalary", SqlDbType.VarChar).Value = AffectSalaryValue.ToString();
                    if (CarryOver.Checked == true)
                    {
                        CarryOverValue = "Y";
                    }
                    else
                    {
                        CarryOverValue = "N";
                    }
                    SqlCmd.Parameters.Add("@CarryOver", SqlDbType.VarChar).Value = CarryOverValue.ToString();
                    SqlCmd.Parameters.Add("@CarryOverLimit", SqlDbType.Int).Value = Convert.ToInt32(CarryOverLimit.Text);
                    SqlCmd.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    SqlCmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = empcd.ToString().Trim();

                    SqlCmd.ExecuteNonQuery();
                }


            }
            Response.Redirect("./LeaveMasterSelection.aspx?");
        }
        
        conn.Close();
    }
    protected void GridLeaveType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            int no = e.Row.RowIndex + 2;
            String a, b,c;
            if (no < 10)
            {

                a = "'ctl00_MyCPH1_GridLeaveType_ctl0" + Convert.ToString(no) + "_txtCode'";
                b = "'ctl00_MyCPH1_GridLeaveType_ctl0" + Convert.ToString(no) + "_txtDescription'";
                c = "'ctl00_MyCPH1_GridLeaveType_ctl0" + Convert.ToString(no) + "_txtCarryOverLimit'";
            }
            else
            {
                a = "'ctl00_MyCPH1_GridLeaveType_ctl" + Convert.ToString(no) + "_txtCode'";
                b = "'ctl00_MyCPH1_GridLeaveType_ctl" + Convert.ToString(no) + "_txtDescription'";
                c = "'ctl00_MyCPH1_GridLeaveType_ctl" + Convert.ToString(no) + "_txtCarryOverLimit'";
            }
            //((TextBox)(e.Row.FindControl("txtCode"))).Attributes.Add("onblur", "return Check_txtCode(" + a + "," + b + "," + c + ")");
            //((TextBox)(e.Row.FindControl("txtDescription"))).Attributes.Add("onblur", "return Check_txtCode(" + a + "," + b + "," + c + ")");
            //((TextBox)(e.Row.FindControl("txtCarryOverLimit"))).Attributes.Add("onblur", "return Check_txtCode(" + a + "," + b + "," + c + ")");
            //((Button)(e.Row.FindControl("btnSubmitGridData"))).Attributes.Add("onclick", "return Check_txtCode(" + a + "," + b + "," + c + ")");
            btnSubmitGridData.Attributes.Add("onclick", "return Check_txtCode(" + a + "," + b + "," + c + ")");
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int no = e.Row.RowIndex + 2;
            String a, b,c;
            if (no < 10)
            {

                a = "'ctl00_MyCPH1_GridView1_ctl0" + Convert.ToString(no) + "_txtCode'";
                b = "'ctl00_MyCPH1_GridView1_ctl0" + Convert.ToString(no) + "_txtDescription'";
                c = "'ctl00_MyCPH1_GridView1_ctl0" + Convert.ToString(no) + "_txtCarryOverLimit'";
            }
            else
            {
                a = "'ctl00_MyCPH1_GridView1_ctl" + Convert.ToString(no) + "_txtCode'";
                b = "'ctl00_MyCPH1_GridView1_ctl" + Convert.ToString(no) + "_txtDescription'";
                c = "'ctl00_MyCPH1_GridView1_ctl" + Convert.ToString(no) + "_txtCarryOverLimit'";
            }
            //((TextBox)(e.Row.FindControl("txtCode"))).Attributes.Add("onblur", "return Check_txtCode_Update(" + a + "," + b + "," + c + ")");
            //((TextBox)(e.Row.FindControl("txtDescription"))).Attributes.Add("onblur", "return Check_txtCode_Update(" + a + "," + b + "," + c + ")");
            //((TextBox)(e.Row.FindControl("txtCarryOverLimit"))).Attributes.Add("onblur", "return Check_txtCode_Update(" + a + "," + b + "," + c + ")");
            btnSubmitGridData.Attributes.Add("onclick", "return Check_txtCode(" + a + "," + b + "," + c + ")");
        }
    }
}
