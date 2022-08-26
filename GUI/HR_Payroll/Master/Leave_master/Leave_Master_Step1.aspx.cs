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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step1 : System.Web.UI.Page
{
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection conn;
    public static string edit_yn = "", editcodeid = "", sql;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string[] edit_yn_arr = Request.QueryString.ToString().Replace("%2c",",").Split(',');
        editcodeid = edit_yn_arr[1].ToString();

        getstring();
        edit_yn = edit_yn_arr[0].ToString();
        if (edit_yn == "Y")
        {
            editcodeid = edit_yn_arr[1].ToString();
        }

        if (!IsPostBack)
        {
            roww.Text = "1";
            Inetialized();
            BindGrid();
            Validation();
            if (edit_yn == "N")
            {
                
                
            }
            else
            {
                roww.Enabled = false;
                RetriveData();
            }
        }
        else
        {
        }
        conn.Close();
    }
    private void getstring()
    {
        //conn.Open();
        string Branch = Session["brcd"].ToString();
        sql = "select Upper(LEAVE_NAME) as code from WEBX_LEAVETYPEMST WHERE DELETED='N'";
        
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

        //conn.Close();
    }	
    private void RetriveData()
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox Code = (TextBox)gridrow.FindControl("txtLeaveName");
            TextBox Description = (TextBox)gridrow.FindControl("txtLeaveDesc");
            CheckBox AffectsSalary = (CheckBox)gridrow.FindControl("ChkAffectSalary");
            CheckBox CarryOver = (CheckBox)gridrow.FindControl("chkCarryOver");
            TextBox CarryOverLimit = (TextBox)gridrow.FindControl("txtLeaveLimit");
            string Sql_Select = "Webx_LeaveMaster_Selection";
            SqlCommand SqlCmd = new SqlCommand(Sql_Select, conn);
            SqlCmd.CommandType = CommandType.StoredProcedure;

            SqlCmd.Parameters.Add("@id", SqlDbType.VarChar).Value = editcodeid;

            SqlDataReader dr = SqlCmd.ExecuteReader();


            while (dr.Read())
            {
                Code.Text = dr["LEAVE_NAME"].ToString();
                Description.Text = dr["LEAVE_DESC"].ToString();
                CarryOverLimit.Text = dr["CARRY_OVER_LIMIT"].ToString();
                if (dr["AFFECT_SALARY"].ToString() == "Y")
                {
                    AffectsSalary.Checked = true;
                }
                if (dr["CARRY_OVER"].ToString() == "Y")
                {
                    CarryOver.Checked = true;
                }
            }
            dr.Close();
        }

        conn.Close();
    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        if ((roww.Text == "") || (roww.Text == "0"))
        {
            roww.Text = "1";
        }
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
        Validation();

    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
    }
    private void Inetialized()
    {

        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
    }

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtLeaveName = (TextBox)gridrow.FindControl("txtLeaveName");
            TextBox txtLeaveLimit = (TextBox)gridrow.FindControl("txtLeaveLimit");


            txtLeaveLimit.Attributes.Add("onkeypress", "javascript:return validInt(event)");
            txtLeaveName.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
            if (edit_yn == "N")
            {
                txtLeaveName.Enabled = true;
                txtLeaveName.Attributes.Add("onblur", "javascript:return checkcode(this)");
            }
            else
            {
                txtLeaveName.Enabled = false;
                //txtLeaveName.Attributes.Add("onblur", "javascript:return checkcodeEdit(this)");
            }
        }
    }

    protected void Button11_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            foreach (GridViewRow gridrow in GV_D.Rows)
            {
                TextBox Code = (TextBox)gridrow.FindControl("txtLeaveName");
                TextBox Description = (TextBox)gridrow.FindControl("txtLeaveDesc");
                CheckBox AffectsSalary = (CheckBox)gridrow.FindControl("ChkAffectSalary");
                CheckBox CarryOver = (CheckBox)gridrow.FindControl("chkCarryOver");
                TextBox CarryOverLimit = (TextBox)gridrow.FindControl("txtLeaveLimit");

                if (Code.Text != "")
                {
                    SqlCommand SqlCmd;
                    if (edit_yn == "N")
                    {
                        string SQLInsert = "Webx_LeaveMaster_InsertData";
                        SqlCmd = new SqlCommand(SQLInsert, conn);
                    }
                    else
                    {
                        string SQL_Update = "Webx_LeaveMaster_Update";
                        SqlCmd = new SqlCommand(SQL_Update, conn);
                    }

                    SqlCmd.Transaction = trans;
                    SqlCmd.CommandType = CommandType.StoredProcedure;

                    string brcd = Convert.ToString(Session["brcd"]);
                    string empcd = Convert.ToString(Session["Empcd"]);
                    string AffectSalaryValue = "", CarryOverValue = "";
                    if (edit_yn == "Y")
                    {
                        SqlCmd.Parameters.Add("@Code", SqlDbType.VarChar).Value = editcodeid;
                    }
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
                    if (edit_yn == "N")
                    {
                        SqlCmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = empcd.ToString().Trim();
                    }
                    else
                    {
                        SqlCmd.Parameters.Add("@UpdateBy", SqlDbType.VarChar).Value = empcd.ToString().Trim();
                    }
                    SqlCmd.ExecuteNonQuery();
                }


            }
            trans.Commit();
            conn.Close();
            
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }

            trans.Rollback();


            conn.Close();
            Response.End();
        }
        Response.Redirect("../../masters.aspx");
       
       
    }
}
