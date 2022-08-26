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

public partial class GUI_admin_setting_cust_opn_bal_sel_brnch : System.Web.UI.Page
{
    public string custcode, vendorcode,custloc,vendorloc;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnSubmit.Attributes.Add("onclick", "javascript:return OnSubmit()");
           //***********Modue Entry
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                BindGrind();
                conn.Close();
        }
    }
    protected void GV_MODULE_RULE_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField Hnd_RULE_YN = (HiddenField)(e.Row.FindControl("Hnd_RULE_YN"));
            CheckBox CHK_RULE_YN = (CheckBox)(e.Row.FindControl("CHK_RULE_YN"));
            if (Hnd_RULE_YN.Value == "Y")
            {
                CHK_RULE_YN.Checked = true;
            }

        }
    }
    public void BindGrind()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "select * from Webx_Modules_Rules where Module_Name in ('Bill Generation','Bill Collection')";
        //***********Paybas Type
         
        SqlCommand Cmd = new SqlCommand(Sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_MODULE_RULE.DataSource = ds;
        GV_MODULE_RULE.DataBind();
    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
              string Sql = "", From_Accdesc = "", To_Accdesc = "";
           
            Sql = "delete from Webx_Accounting_Rule where Module_Code='1212121'";
            SqlCommand Cmd = new SqlCommand(Sql, conn, trans);
            Cmd.ExecuteNonQuery();
            string RULE_YN = "N";
            foreach (GridViewRow gridrow in GV_MODULE_RULE.Rows)
            {
                Response.Write("RULE_YN" + RULE_YN);
                 HiddenField Hnd_RULE_YN = (HiddenField)gridrow.FindControl("Hnd_RULE_YN");
                 HiddenField Hnd_RULEID = (HiddenField)gridrow.FindControl("Hnd_RULEID");
                 CheckBox CHK_RULE_YN = (CheckBox)gridrow.FindControl("CHK_RULE_YN");
                 if (CHK_RULE_YN.Checked)
                 {
                     RULE_YN = "Y";
                 }
                 else
                 {
                     RULE_YN = "N"; 
                 }
                 TextBox TXT_RULE_VALUE = (TextBox)gridrow.FindControl("TXT_RULE_VALUE");
                 Sql = "UPDATE Webx_Modules_Rules set RULE_VALUE ='" + TXT_RULE_VALUE.Text.ToString() + "',RULE_Y_N='" + RULE_YN + "' Where RULEID='" + Hnd_RULEID.Value.ToString() + "' ";
                 Response.Write("<br> Sql :- " + Sql);
                 Cmd = new SqlCommand(Sql, conn, trans);
                 Cmd.ExecuteNonQuery();
            }   
             
            trans.Commit();
            conn.Close();
            //Response.End();
            Response.Redirect("../ManageRules.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }
       

     }
}
