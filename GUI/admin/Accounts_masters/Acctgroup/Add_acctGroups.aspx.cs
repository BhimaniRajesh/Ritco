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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_Accounts_masters_Acctgroup_Add_acctGroups : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    AccountTrans trans = new AccountTrans();
    DateTime DT = new DateTime();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        string Acccode = "";
        if (!IsPostBack)
        {
            if (!IsPostBack)
            {
                hdnmanualgrouprule.Value = "N";
                
                double count = 0;
                count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) from webx_modules_rules where Module_name='Group Master' and Rule_desc='Set Manual Group Code As System Generated Group Code'"));
                if (count > 0)
                {
                    hdnmanualgrouprule.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N from webx_modules_rules where Module_name='Group Master' and Rule_desc='Set Manual Group Code As System Generated Group Code'").ToString();
                }

                if (hdnmanualgrouprule.Value == "Y")
                    trManualGroupCode.Visible = false;
                else
                    trManualGroupCode.Visible = true;

                Acccode = Request.QueryString["Data"].ToString();
                hdntype.Value = Acccode;

                if (Acccode != "new")
                {   
                    loadData();
                }
                else
                {   
                    lblId.Text = "System Generated";
                }
            }
            //Submit.Attributes.Add("onClick","JavaScript:return valid(this,"+ dlstCategory.ClientID +"," + txtGroupCode.ClientID + "," + txtGroupDesc.ClientID + ")");
        }
        if (hdnmanualgrouprule.Value == "N")
        {
            txtGroupCode.Attributes.Add("onBlur", "javascript:return validId(this," + txtGroupCode.ClientID + "," + lblId.ClientID + "," + hdntype.ClientID + ")");
        }
    }
    public void loadData()
    {
        lblId.Text = Request.QueryString["Data"].ToString();
        string str = "select * from webx_Groups where Groupcode='" + Request.QueryString["Data"].ToString().Trim() + "'";
        ds = DAccess.getdataset(str);
        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            string Groupcode = dr["Groupcode"].ToString();
            string Company_code = dr["Company_Groupcode"].ToString();

            if (hdnmanualgrouprule.Value == "Y")
            {
                trManualGroupCode.Visible = false;
            }
            else
            {
                trManualGroupCode.Visible = true;
                txtGroupCode.Text = Company_code;
            }

            string Accdesc = dr["Groupdesc"].ToString();
            string parentcode = dr["Parentcode"].ToString();
            string Main_cat = dr["Main_Category"].ToString();
            lblId.Text = dr["Groupcode"].ToString();
            txtGroupDesc.Text = dr["Groupdesc"].ToString();

            if (Main_cat == "ASSET")
                dlstCategory.SelectedValue = "ASS001";
            else if (Main_cat == "EXPENSE")
                dlstCategory.SelectedValue = "EXP001";
            else if (Main_cat == "INCOME")
                dlstCategory.SelectedValue = "INC001";
            else if (Main_cat == "LIABILITY")
                dlstCategory.SelectedValue = "LIA001";

            string sql = "select Groupcode,Company_Groupcode + ' : ' + Groupdesc AS Groupdesc from webx_groups where main_category='" + dlstCategory.SelectedItem.Text + "'";
            ds = DAccess.getdataset(sql);
            ddrgroupcode.DataSource = ds;
            ddrgroupcode.DataValueField = "Groupcode";
            ddrgroupcode.DataTextField = "Groupdesc";
            ddrgroupcode.DataBind();
            ddrgroupcode.Items.Insert(0, "Select");
            ddrgroupcode.Items[0].Text = "Select";
            ddrgroupcode.SelectedValue = parentcode;
        }
    }
    public void Change_Group(object sender, EventArgs e)
    {
        string sql = "select Groupcode,Company_Groupcode + ' : ' + Groupdesc AS Groupdesc from webx_groups where main_category='" + dlstCategory.SelectedItem.Text + "'";
        ds = DAccess.getdataset(sql);
        ddrgroupcode.DataSource = ds;
        ddrgroupcode.DataValueField = "Groupcode";
        ddrgroupcode.DataTextField = "Groupdesc";
        ddrgroupcode.DataBind();
        ddrgroupcode.Items.Insert(0, "Select");
        ddrgroupcode.Items[0].Text = "Select";
        ddrgroupcode.Items[0].Selected = true;
    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        string ExistGroupCode = Request.QueryString["Data"].ToString();
        string Parent_Group_Code = "";
        string level = "";
        string sql = "";
        string Group_Code = "";
        string new_sys_Group_Code = ""; 

        if (ddrgroupcode.SelectedItem.Text != "Select")
        {
            Parent_Group_Code = ddrgroupcode.SelectedItem.Value;
            sql = "select top 1 Grouplevel from webx_groups where Groupcode = '" + Parent_Group_Code + "'";
            ds = DAccess.getdataset(sql);
            foreach (DataRow dr in ds.Tables["temp"].Rows)
            {
                level = Convert.ToString(Convert.ToInt16(dr["Grouplevel"].ToString()) + 1);
            }
        }
        else
        {
            Parent_Group_Code = dlstCategory.SelectedItem.Value;
            sql = "select top 1 Grouplevel from webx_groups where Groupcode = '" + Parent_Group_Code + "'";
            ds = DAccess.getdataset(sql);
            foreach (DataRow dr in ds.Tables["temp"].Rows)
            {
                if (string.IsNullOrEmpty(dr["Grouplevel"].ToString()))
                {
                    level = "0";
                    level = Convert.ToString(Convert.ToInt16(level) + 1);
                }
                else
                {
                    level = Convert.ToString(Convert.ToInt16(dr["Grouplevel"].ToString()) + 1);
                }
            }
        }

        if (ExistGroupCode == "new")
        {
            new_sys_Group_Code = trans.GetGroupCode(Parent_Group_Code);
            
            if (hdnmanualgrouprule.Value == "Y")
                Group_Code = new_sys_Group_Code;
            else
                Group_Code = txtGroupCode.Text;
        }
        else
        {
            if (hdnmanualgrouprule.Value == "Y")
                 Group_Code = ExistGroupCode;
            else
                 Group_Code = txtGroupCode.Text;
        }
        if (ExistGroupCode == "new")
        {   
            string acc_ = dlstCategory.SelectedItem.Value;
            string acc_prefix = acc_.Substring(0,3);
            string entry_by = Session["empcd"].ToString().Trim();
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@Groupcode", new_sys_Group_Code);
            param[1] = new SqlParameter("@Groupdesc", txtGroupDesc.Text);
            param[2] = new SqlParameter("@Parentcode", Parent_Group_Code);
            param[3] = new SqlParameter("@Grouplevel", level.ToString());
            param[4] = new SqlParameter("@Acct_prefix", acc_prefix);
            param[5] = new SqlParameter("@entryby", entry_by);
            param[6] = new SqlParameter("@Company_Groupcode", Group_Code);
            param[7] = new SqlParameter("@Main_Category", dlstCategory.SelectedItem.Text);
            DAccess.ExecuteNonQry(CommandType.StoredProcedure, "usp_insert_webx_groups", param);
        }
        else
        {
            string acc_ = dlstCategory.SelectedItem.Value;
            string acc_prefix = acc_.Substring(0,3);
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@Groupcode", ExistGroupCode);
            param[1] = new SqlParameter("@Groupdesc", txtGroupDesc.Text);
            param[2] = new SqlParameter("@Parentcode", Parent_Group_Code);
            param[3] = new SqlParameter("@Grouplevel", level);
            param[4] = new SqlParameter("@Acct_prefix", acc_prefix);
            param[5] = new SqlParameter("@Company_Groupcode", Group_Code);
            param[6] = new SqlParameter("@Main_Category", dlstCategory.SelectedItem.Text);
            DAccess.ExecuteNonQry(CommandType.StoredProcedure, "usp_update_webx_groups", param);
        }
        if (ExistGroupCode == "new")
        {
            Response.Redirect("Add_Edit_Done.aspx?flag=new&GroupCode=" + new_sys_Group_Code, true);
        }
        else
        {
            Response.Redirect("Add_Edit_Done.aspx?flag=old&GroupCode=" + ExistGroupCode, true);
        }
    }
}
