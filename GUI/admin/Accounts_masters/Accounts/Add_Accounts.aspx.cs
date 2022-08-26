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

public partial class GUI_admin_Accounts_masters_Accounts_Add_Accounts : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    DateFunction DFun = new DateFunction();
    DataSet ds = new DataSet();
    DataTable dt = new DataTable();
    AccountTrans trans = new AccountTrans();
    public string Acccode = "";
    string accode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnmancoderule.Value = "N";
            hdnbrcdrule.Value = "N";

            double total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) as Total FROM webx_modules_rules where Module_Name='Account Master'"));

            if (total > 0)
            {
                hdnmancoderule.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N FROM webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Manual Account Code As System Generated Account Code'").ToString();
                hdnbrcdrule.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N FROM webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'").ToString();
            }

            if (hdnmancoderule.Value == "Y")
                trManualAccCode.Visible = false;
            else
                trManualAccCode.Visible = true;

            if (hdnbrcdrule.Value == "Y")
                trbrcd.Visible = true;
            else
                trbrcd.Visible = false;

            dlstAcctCategory.Items.Clear();
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, "select '--Select--' as Id,'' as Val union select Acccategory as Id,Acccategory as Val from webx_Acccategory_master where ActiveFlag='Y' order by Val");
            while (dr.Read())
            {
                dlstAcctCategory.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();
            dlstAcctCategory.CssClass = "blackfnt";

            Acccode = Request.QueryString["Data"].ToString();
            if (Acccode != "new")
            {
                loadData();
            }
            else
            {
                Table1.Visible = false;
                lblId.Text = "System Generated";
            }

        }
        string str = "";
        if (Acccode != "new")
        {
            Acccode = Request.QueryString["Data"].ToString();
            str = "javascript:return valid(this," + dlstCategory.ClientID + "," + dlstGroup.ClientID + "," + txtAcctDesc.ClientID + "," + dlstAcctCategory.ClientID + ")";

            btnSubmit.Attributes.Add("onClick", str);

            if (trManualAccCode.Visible == true)
                txtManCode.Attributes.Add("onblur", "CompAccBlur('" + txtManCode.ClientID.ToString() + "','" + Acccode + "','edit')");
        }
        if (Acccode == "new")
        {
            Acccode = "new";
            str = "javascript:return valid(this," + dlstCategory.ClientID + "," + dlstGroup.ClientID + "," + txtAcctDesc.ClientID + "," + dlstAcctCategory.ClientID + ")";

            btnSubmit.Attributes.Add("onClick", str);

            if (trManualAccCode.Visible == true)
                txtManCode.Attributes.Add("onblur", "CompAccBlur('" + txtManCode.ClientID.ToString() + "','" + Acccode + "','new')");
        }
    }
    public void loadData()
    {
        Acccode = Request.QueryString["Data"].ToString();
        string str = "select * from webx_acctInfo where Acccode='" + Acccode + "'";
        ds = DAccess.getdataset(str);
        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            string Groupcode = dr["Groupcode"].ToString();
            string cat = dr["Acccategory"].ToString();
            string Company_code = dr["Company_Acccode"].ToString();
            txtManCode.Text = Company_code;
            string Accdesc = dr["Accdesc"].ToString();
            lblId.Text = dr["Acccode"].ToString();
            accode = dr["Acccode"].ToString();
            txtAcctDesc.Text = Accdesc;

            if (dr["ACTIVEFLAG"].ToString() == "Y")
                chkActive.Checked = true;
            else
                chkActive.Checked = false;

            if (dr["IsExceptionLeger"].ToString().ToUpper() == "TRUE")
                chkExceptionLeger.Checked = true;
            else
                chkExceptionLeger.Checked = false;

            if (trManualAccCode.Visible == true)
            {
                txtManCode.Text = dr["Company_Acccode"].ToString();
            }
            if (trbrcd.Visible == true)
            {
                if (dr["brcd"].ToString().CompareTo("All") == 0)
                    chkallbrcd.Checked = true;
                else
                {
                    chkallbrcd.Checked = false;
                    trAllbrcd.Visible = true;
                    txtbrcd.Text = dr["brcd"].ToString();
                }
            }

            txtLocation.Text = dr["bkloccode"].ToString();
            txtAcctNumber.Text = dr["bkAcctNo"].ToString();

            dt = DAccess.gettable("select * from webx_groups where Groupcode='" + Groupcode + "'");

            string main_category = dt.Rows[0]["main_category"].ToString();

            dlstCategory.SelectedValue = main_category;

            if (cat == "BANK" || cat == "CC")
            {
                Table1.Visible = true;
            }
            else
            {
                Table1.Visible = false;
            }

            dlstAcctCategory.SelectedValue = cat;

            str = "select Groupcode,Parentcode,Groupdesc + ' : ' + Company_Groupcode as Groupdesc,Groupdesc as GroupdescMain FROM WEBX_GROUPS WHERE main_category = '" + main_category + "'";
            ds = DAccess.getdataset(str);
            dlstGroup.DataSource = ds;
            dlstGroup.DataValueField = "Groupcode";
            dlstGroup.DataTextField = "Groupdesc";
            dlstGroup.DataBind();
            dlstGroup.Items.Insert(0, "Select");
            dlstGroup.Items[0].Text = "Select";
            dlstGroup.SelectedValue = Groupcode;
        }
    }
    public void Group(string code, string select)
    {
        string str = "select Groupcode,Parentcode,Groupdesc + ' : ' + Company_Groupcode as Groupdesc,Groupdesc as GroupdescMain FROM WEBX_GROUPS WHERE main_category = '" + code + "'";
        ds = DAccess.getdataset(str);
        dlstGroup.DataSource = ds;
        dlstGroup.DataValueField = "Groupcode";
        dlstGroup.DataTextField = "GroupdescMain";
        dlstGroup.DataBind();
        dlstGroup.Items.Insert(0, "Select");
        dlstGroup.Items[0].Text = "Select";
        dlstGroup.SelectedValue = select;
    }
    public void Change_Group(object sender, EventArgs e)
    {
        string str = "select Groupcode,Parentcode,Groupdesc + ' : ' + Company_Groupcode as Groupdesc,Groupdesc as GroupdescMain from webx_groups where Main_Category='" + dlstCategory.SelectedItem.Value + "' Order by GroupdescMain";
        ds = DAccess.getdataset(str);
        dlstGroup.DataSource = ds;
        dlstGroup.DataValueField = "Groupcode";
        dlstGroup.DataTextField = "Groupdesc";
        dlstGroup.DataBind();
        dlstGroup.Items.Insert(0, "Select");
        dlstGroup.Items[0].Text = "Select";
        dlstGroup.Items[0].Selected = true;
    }
    public void change_cat_table(object sender, EventArgs e)
    {
        if (dlstAcctCategory.SelectedItem.Value == "BANK" || dlstAcctCategory.SelectedItem.Value == "CC")
        {
            Table1.Visible = true;
        }
        else
        {
            Table1.Visible = false;
            txtAcctNumber.Text = "";
            txtLocation.Text = "";
        }
    }
    public void check_Code(object sender, EventArgs e)
    {
        string num = "";
        string str = "select count(*) as numcode from WebX_acctinfo where Company_Acccode='" + txtManCode.Text + "'";
        SqlDataReader dtr = DAccess.getreader(str);
        while (dtr.Read())
        {
            num = dtr["numcode"].ToString();
        }
        dtr.Close();
        int new_num = Convert.ToInt16(num);
        if (new_num > 0)
        {
            txtManCode.Text = "";
        }
        else
        { }
    }
    protected void VisibleBrcdTextBox(object sender, EventArgs e)
    {
        if (chkallbrcd.Checked == true)
            trAllbrcd.Visible = false;
        else
            trAllbrcd.Visible = true;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Acccode = Request.QueryString["Data"].ToString();
        string company_acccode = "";
        string group_Code = "", check = "";
        string brcd = "";

        if (dlstGroup.SelectedItem.Text == "Select")
        {
            group_Code = dlstCategory.SelectedItem.Value;
        }
        else
        {
            group_Code = dlstGroup.SelectedItem.Value;
        }

        if (Acccode == "new")
        {
            if (group_Code != "")
            {
                string new_sys_Group_Code = trans.GetAccountCode(group_Code);

                if (chkActive.Checked == true)
                    check = "Y";
                else
                    check = "N";

                if (trManualAccCode.Visible == false)
                    company_acccode = new_sys_Group_Code;
                else
                    company_acccode = txtManCode.Text;

                if (trbrcd.Visible == false)
                    brcd = Session["brcd"].ToString();
                else
                {
                    if (chkallbrcd.Checked == true)
                        brcd = "All";
                    else
                        brcd = txtbrcd.Text;
                }

                Hashtable MyHT = new Hashtable();
                MyHT.Add("Acccode", new_sys_Group_Code);
                MyHT.Add("Accdesc", txtAcctDesc.Text);
                MyHT.Add("Groupcode", group_Code);
                MyHT.Add("Acccategory", dlstAcctCategory.SelectedItem.Value);
                MyHT.Add("Brcd", brcd);
                MyHT.Add("Entryby", Session["empcd"].ToString().Trim());
                MyHT.Add("ACTIVEFLAG", check);
                MyHT.Add("bkAcctNo", txtAcctNumber.Text);
                MyHT.Add("bkloccode", txtLocation.Text);
                MyHT.Add("IsExceptionLeger",chkExceptionLeger.Checked);
                MyHT.Add("Company_Acccode", company_acccode);

                string r_val = DAccess.insertQuary_New("usp_Account_Master", MyHT);
                if (r_val != "0")
                {
                    Server.Transfer("../Error/ErrorPage.aspx?PageHead='Account Code Insert'&ErrorMsg=" + r_val, true);
                }
                else
                {
                    Response.Redirect("Add_Edit_Done.aspx?flag=new&AccCode=" + new_sys_Group_Code, true);
                }
            }
        }
        else
        {
            string strAcccode = Acccode;

            if (chkActive.Checked == true)
                check = "Y";
            else
                check = "N";

            if (trManualAccCode.Visible == false)
                company_acccode = strAcccode;
            else
                company_acccode = txtManCode.Text;

            if (trbrcd.Visible == false)
                brcd = Session["brcd"].ToString();
            else
            {
                if (chkallbrcd.Checked == true)
                    brcd = "All";
                else
                    brcd = txtbrcd.Text;
            }

            Hashtable MyHT = new Hashtable();
            MyHT.Add("Acccode", strAcccode);
            MyHT.Add("Accdesc", txtAcctDesc.Text);
            MyHT.Add("Groupcode", group_Code);
            MyHT.Add("Acccategory", dlstAcctCategory.SelectedItem.Value);
            MyHT.Add("Brcd", brcd);
            MyHT.Add("Entryby", Session["empcd"].ToString().Trim());
            MyHT.Add("ACTIVEFLAG", check);
            MyHT.Add("bkAcctNo", txtAcctNumber.Text);
            MyHT.Add("bkloccode", txtLocation.Text);
            MyHT.Add("IsExceptionLeger", chkExceptionLeger.Checked);
            MyHT.Add("Company_Acccode", company_acccode);

            string r_val = DAccess.insertQuary_New("usp_Update_Account_Master", MyHT);
            if (r_val != "0")
            {
                Server.Transfer("../../../Error/ErrorPage.aspx?PageHead='Account Code Insert'&ErrorMsg=" + r_val, true);
            }
            else
            {
                Response.Redirect("Add_Edit_Done.aspx?flag=old&AccCode=" + strAcccode, true);
            }
        }
    }
}
