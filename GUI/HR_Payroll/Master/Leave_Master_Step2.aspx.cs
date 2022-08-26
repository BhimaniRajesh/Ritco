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
public partial class GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step2 : System.Web.UI.Page
{
    SqlConnection conn;
    public string Sql_Select, Code;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            BindData();
        }
        //btnAdd.Attributes.Add("onclick", "javascript:return CheckData()");
        //btnEdit.Attributes.Add("onclick", "javascript:return CheckData()");
        //btnInactivate.Attributes.Add("onclick", "javascript:return CheckData()");
       // btnListing.Attributes.Add("onclick", "javascript:return CheckData_List(" + cboLeaveCode.ClientID + ")");
        
    }

    private void BindData()
    {
        conn.Open();
        Sql_Select = "Webx_LeaveMaster_Selection";
        SqlCommand SqlCmd = new SqlCommand(Sql_Select, conn);
        SqlCmd.CommandType = CommandType.StoredProcedure;

        SqlCmd.Parameters.Add("@id", SqlDbType.VarChar).Value = "";

        SqlDataReader dr = SqlCmd.ExecuteReader();
        cboLeaveCode.Items.Clear();
        cboLeaveCode.Items.Add(new ListItem("--Select One--","All"));

        while (dr.Read())
        {
            cboLeaveCode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            //cboLeaveCode.Items.Add(new ListItem(dr.GetValue(1).ToString()));
        }
        dr.Close();
        conn.Close();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("./Leave_Master_Step1.aspx?N,1");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string code = cboLeaveCode.SelectedValue.ToString();
        Response.Redirect("./Leave_Master_Step1.aspx?Y,"+code);
    }
    protected void btnInactivate_Click(object sender, EventArgs e)
    {
        string code = cboLeaveCode.SelectedValue.ToString();
         conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string sql_delete = " update WEBX_LEAVETYPEMST set ACTIVEFLAG='Y',updatedby='" + Session["brcd"].ToString() + "',updateddate=getdate() where LEAVE_CODE='" + code + "'";
            SqlCommand sqlcmd1 = new SqlCommand(sql_delete, conn);
            sqlcmd1.Transaction = trans;
            sqlcmd1.ExecuteNonQuery();

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
        Response.Redirect("./Leave_Master_Step2.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string code = cboLeaveCode.SelectedValue.ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string sql_delete = " update WEBX_LEAVETYPEMST set Deleted='Y',updatedby='" + Session["brcd"].ToString() + "',updateddate=getdate() where LEAVE_CODE='" + code + "'";
            SqlCommand sqlcmd1 = new SqlCommand(sql_delete, conn);
            sqlcmd1.Transaction = trans;
            sqlcmd1.ExecuteNonQuery();

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
        Response.Redirect("./Leave_Master_Step2.aspx");
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        string Code = cboLeaveCode.SelectedValue.ToString();

        Response.Redirect("./Leave_Master_Step3.aspx?LeaveCode=" + Code);
    }
}
