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
public partial class GUI_admin_OpeningBalance_SelectBranch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AccountTrans Acctrans = new AccountTrans();
            string validlocs = Acctrans.getValidBranch();

            //string strjs = " javascript : var raisedon=document.getElementById('" + txtBranchCode.ClientID + "');" +
            //               " var valuetoCompare = '" + validlocs + "';" +
            //               " raisedon.value = raisedon.value.toUpperCase();" +
            //               " raisedon.focus();" +
            //               " return; }";
            //Acctrans = null;
            //txtBranchCode.Attributes.Add("OnBlur", strjs);
            getAcccode();
            //getYear();
            


        }
    }
    
    public void getAcccode()
    {   
        DateFunction DAccess = new DateFunction();
        DataSet ds = new DataSet();
        //string str = "select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc from webx_acctinfo where substring(groupcode,1,3) in ('ASS','LIA') order by Accdesc";
        //string str="select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,* from webx_acctinfo where (substring(groupcode,1,3) in ('ASS','LIA') ) or (groupcode in (select groupcode from webx_groups where substring(parentcode,1,3) in ('ASS','LIA'))) order by Accdesc";
        //string str = "select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,acccategory from webx_acctinfo with(NOLOCK) where acccategory in ('ASSET','LIABILITY','EXPENSES','INCOME','BANK','CASH') order by acccategory,Accdesc";
        string str = "select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,acccategory from webx_acctinfo with(NOLOCK) where groupcode in (select groupcode from webx_groups where main_category='" + DDLACC_CAT.SelectedValue.ToString() + "') order by acccategory,Accdesc";
        ds = DAccess.getdataset(str);
        dlstAcccode.DataSource = ds;
        dlstAcccode.DataValueField = "Acccode";
        dlstAcccode.DataTextField = "Accdesc";
        dlstAcccode.DataBind();
        dlstAcccode.Items.Insert(0, "All");
        dlstAcccode.Items[0].Value = "";
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
        string YearVal = "";
        DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (mpLabel != null)
        {
            YearVal = mpLabel.SelectedItem.Value;
        }
        string ACC_CAT = DDLACC_CAT.SelectedValue.ToString();
        string branch1 = txtBranchCode.Text;
        string acccode="";
        if (dlstAcccode.SelectedItem.Value=="")
        {
            acccode="All";
        }
        else
	    {
            acccode=dlstAcccode.SelectedItem.Value;
	    }
        if (error.Text=="")
        {
            Response.Redirect("OPBalBranch_step2.aspx?branch=" + branch1 + "&acccode=" + acccode + "&YearVal=" + YearVal + "&ACC_CAT=" + ACC_CAT);
        }
        
    }
    protected void text_change(object sender, EventArgs e)
    {
        AccountTrans Acctrans = new AccountTrans();
        string validlocs = Acctrans.getValidBranch();
        if (validlocs != "")
        {
            string flag = "N";
            string loc = validlocs;
            string[] arLocation = new string[0];
            char[] split_arLocation = { ',' };
            arLocation = loc.Split(split_arLocation);
            for (int x = 0; x < arLocation.Length; x++)
            {
                string tempLoc = arLocation[x];
                if (tempLoc == txtBranchCode.Text)
                {
                    error.Visible = false;
                    flag = "N";
                    break;
                }
                else
                {
                    flag = "Y";
                }
            }
            if (flag == "Y")
            {
                error.Visible = true;
                error.Text = "'Invalid Branch !!!'";
                hdnerror.Value = flag;
            }
            else
            {
                error.Visible = false;
                error.Text = "";
                hdnerror.Value = flag;
            }
        }
    }

    protected void DDLACC_CAT_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string str = "";
        string ACC_CAT = DDLACC_CAT.SelectedValue.ToString();

        if (ACC_CAT == "All")
        {
            str = "select 'All' as Acccode,'All' as Accdesc,'All' as groupcode,'All' as acccategory  from webx_location  union select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,acccategory from webx_acctinfo with(NOLOCK) where acccategory in ('ASSET','LIABILITY','EXPENSES','INCOME','BANK','CASH') order by Accdesc,Acccode";
        }
        else
        {
            str = "select 'All' as Acccode,'All' as Accdesc,'All' as groupcode,'All' as acccategory union select distinct Acccode,Accdesc + ' : ' + Acccode as  Accdesc,groupcode,acccategory from webx_acctinfo with(NOLOCK) where groupcode in (select groupcode from webx_groups where main_category='" + ACC_CAT + "') order by Accdesc,Acccode";
        }
        SqlCommand cmd = new SqlCommand(str, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dlstAcccode.Items.Clear();
        while (dread.Read())
        {
            dlstAcccode.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));

        }
        dlstAcccode.SelectedValue = "All";

        dread.Close();
        conn.Close();

    }
}
