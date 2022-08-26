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

public partial class GUI_admin_OpeningBalance_OPBalBranch_step2 : System.Web.UI.Page
{
    
    SqlDataReader dtr;
    DateFunction DAccess = new DateFunction();
    public DataSet1 _dataSet = new DataSet1();
    DataAccess D_Access = new DataAccess();
    string sql = "";
    string Branch, acc_code, ACC_CAT, currfinyear, yearsuffix, actable, acctran, loc_level, loc_name, finYear;
    int _lastEditedPage;
    string YearVal;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Branch = Convert.ToString(Request.QueryString["branch"]).Trim();
            if (Branch=="")
            {
                Branch = Session["brcd"].ToString();
            }
            ACC_CAT = Convert.ToString(Request.QueryString["ACC_CAT"]).Trim();
            acc_code = Request.QueryString["acccode"].ToString().Trim();
            string YearVal1 = Request.QueryString["YearVal"].ToString().Trim();
            actable = "webx_acctinfo";
            acctran = "webx_acctopening_" + YearVal1;

            DataTable DT = new DataTable();
            DT = DAccess.gettable("select count(*) as num from " + acctran + " where acccode='" + acc_code + "' and brcd='" + Branch + "'");
            string num = DT.Rows[0]["num"].ToString();
            string yearVal = Session["FinYear"].ToString();

            if (num == "0")
            {
                Hashtable myHT = new Hashtable();
                myHT.Add("TableName", acctran);
                myHT.Add("opendebit", "0.00");
                myHT.Add("opencredit", "0.00");
                myHT.Add("opendebit_i", "0.00");
                myHT.Add("opencredit_i", "0.00");
                myHT.Add("finyear", Session["FinYear"].ToString());
                myHT.Add("acccode", acc_code);
                myHT.Add("brcd", Branch);
                DataAccess.insertQuary("insert_webx_acctopening", myHT);
            }


            currfinyear = System.DateTime.Today.ToString("yyyy");
            string finyear = System.DateTime.Today.ToString("yy");
            int year = Convert.ToInt32(finyear);
            int yearnext = year + 1;
            string yearnew = Convert.ToString(yearnext);
            if (yearnew.Length <= 1)
            {
                yearnew = "0" + yearnew;
            }
            //yearsuffix = finyear + "_" + yearnew;
            
            
            Initialize();
            BindGrid();
            
        }
    }
    private void BindGrid()
    {
        myGrid.DataSource = _dataSet.OpenBal_Baranch;
        myGrid.DataBind();
        
        _lastEditedPage = myGrid.CurrentPageIndex;
    }
    private void Initialize()
    {

        string Acccode, Accdesc, opencredit, opencredit_i, opendebit, opendebit_i;
       
        string SQLcheckloc = "select loccode,locname,loc_level from webx_location where loccode='" + Branch + "' and ACTIVEFLAG='Y'";
        dtr = DAccess.getreader(SQLcheckloc);
        while (dtr.Read())
        {
            loc_level = dtr["loc_level"].ToString().Trim();
            loc_name = dtr["locname"].ToString().Trim();
        }
        dtr.Close();
        Label1.Text = "For Branch " + " : " + loc_name + "  And Account Category " + ACC_CAT;
        string HeadOffice = Session["HeadOfficeCode"].ToString().Trim();
        string BRCD = Session["brcd"].ToString().Trim();
        string WHERE_ACCC = "", ST_brcd="";
        if (ACC_CAT == "All")
        {
            WHERE_ACCC = "   groupcode in (select groupcode from webx_groups where main_category='" + ACC_CAT + "')  ";
        }
        else
        {
            WHERE_ACCC = "  groupcode in (select groupcode from webx_groups where main_category='" + ACC_CAT + "') ";
        }

        if (HeadOffice == BRCD)
        {


            if (Branch == "")
            {
                ST_brcd = HeadOffice;
            }
            else
            {
                ST_brcd = Branch;
            }

            if (acc_code == "All")
            {
                sql = "select a.Company_Acccode as Acccode,a.Acccode as Acccode1,a.Accdesc,b.finyear,isnull(b.opendebit,0) as opendebit,isnull(b.opencredit,0) as opencredit,isnull(b.opendebit_i,0) as opendebit_i,isnull(b.opencredit_i,0) as opencredit_i,b.brcd from " + actable + " a  with(NOLOCK) left outer join " + acctran + " b with(NOLOCK) on  a.Acccode=b.Acccode and b.brcd='" + ST_brcd + "'  where  " + WHERE_ACCC + "    order by a.Accdesc";
            }
            else
            {
                sql = "select a.Company_Acccode as Acccode,a.Acccode as Acccode1,a.Accdesc,b.finyear,isnull(b.opendebit,0) as opendebit,isnull(b.opencredit,0) as opencredit,isnull(b.opendebit_i,0) as opendebit_i,isnull(b.opencredit_i,0) as opencredit_i,b.brcd from  " + actable + " a with(NOLOCK) left outer join " + acctran + " b with(NOLOCK) on  a.Acccode=b.Acccode and b.brcd='" + ST_brcd + "'  where  " + WHERE_ACCC + "  and a.Acccode='" + acc_code + "'  order by a.Accdesc";
            }
 
        }
        else
        {
            if (Branch == "")
            {
                ST_brcd = BRCD;
            }
            else
            {
                ST_brcd = Branch;
            }

            if (acc_code == "All")
            {
                sql = "select a.Company_Acccode as Acccode,a.Acccode as Acccode1,a.Accdesc,b.finyear,isnull(b.opendebit,0) as opendebit,isnull(b.opencredit,0) as opencredit,isnull(b.opendebit_i,0) as opendebit_i,isnull(b.opencredit_i,0) as opencredit_i,b.brcd from  " + actable + " a with(NOLOCK) left outer join " + acctran + " b with(NOLOCK) on  a.Acccode=b.Acccode  and b.brcd='" + ST_brcd + "'  where   " + WHERE_ACCC + "  order by a.Accdesc";
            }
            else
            {
                sql = "select a.Company_Acccode as Acccode,a.Acccode as Acccode1,a.Accdesc,b.finyear,isnull(b.opendebit,0) as opendebit,isnull(b.opencredit,0) as opencredit,isnull(b.opendebit_i,0) as opendebit_i,isnull(b.opencredit_i,0) as opencredit_i,b.brcd from  " + actable + " a with(NOLOCK) left outer join " + acctran + " b with(NOLOCK) on  a.Acccode=b.Acccode  and b.brcd='" + ST_brcd + "'  where  " + WHERE_ACCC + "  and a.Acccode='" + acc_code + "'  order by a.Accdesc";
            }
 
        }
            
            Acccode = "";
            string Acccode1 = "";
            Accdesc = "";
            opencredit = "";
            opencredit_i = "";
            opendebit = "";
            opendebit_i = "";
            opencredit_i = "";
            opendebit_i = "";
            finYear = "";
            dtr = DAccess.getreader(sql);
            //_dataSet.OpenBal_Baranch.AddOpenBal_BaranchRow("", "", "", "", "", "", "", "", "");
            
            while (dtr.Read())
            {
                Acccode = dtr["Acccode"].ToString().Trim();
                Acccode1 = dtr["Acccode1"].ToString().Trim();
                Accdesc = dtr["Accdesc"].ToString().Trim();
                opencredit = dtr["opencredit"].ToString().Trim() ;
                opencredit_i = dtr["opencredit_i"].ToString().Trim() ;
                opendebit = dtr["opendebit"].ToString().Trim() ;
                opendebit_i = dtr["opendebit_i"].ToString().Trim() ;
                finYear = dtr["finyear"].ToString().Trim();
                finYear = "1 Apr " + finYear;
                //finYear = dtr["FinStartDate"].ToString().Trim();
                if (finYear == "" || finYear == null)
                {
                    finYear = "Select";
                }
                _dataSet.OpenBal_Baranch.AddOpenBal_BaranchRow("", Acccode, Accdesc, opendebit, opencredit, opendebit_i, opencredit_i, opencredit_i, opendebit_i, finYear);

            }
            dtr.Close();

    }
    protected void myGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            /*
            string openbal = ((TextBox)e.Item.FindControl("txtOpenBal")).ClientID;
            string CloseBal = ((TextBox)e.Item.FindControl("txtCloseBal")).ClientID;
            string str1 = "javascript:return chk(this," + openbal + "," + CloseBal + ")";
            TextBox txtOpen = ((TextBox)e.Item.FindControl("txtOpenBal"));
            TextBox txtClose = ((TextBox)e.Item.FindControl("txtCloseBal"));
            txtOpen.Attributes.Add("onBlur", str1);
            txtClose.Attributes.Add("onBlur", str1);

            string Opening_Credit_In_fo = ((TextBox)e.Item.FindControl("txtOp_Cr_In")).ClientID;
            string Opening_Debit_In_fo = ((TextBox)e.Item.FindControl("txtOp_Dr_In")).ClientID;
            string str2 = "javascript:return chk(this," + Opening_Credit_In_fo + "," + Opening_Debit_In_fo + ")";
            TextBox txtOpen_fo = ((TextBox)e.Item.FindControl("txtOp_Cr_In"));
            TextBox txtClose_fo = ((TextBox)e.Item.FindControl("txtOp_Dr_In"));
            txtOpen_fo.Attributes.Add("onBlur", str2);
            txtClose_fo.Attributes.Add("onBlur", str2);
            */ 
        }
        DataSet1.OpenBal_BaranchRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.OpenBal_BaranchRow)((DataRowView)e.Item.DataItem).Row);
            string acccode = datarow.Account_Code,company_acccode="";
            string sql_acctcode = "select acccode from webx_acctinfo with(NOLOCK) where company_acccode='"+acccode+"'";
            dtr = DAccess.getreader(sql_acctcode);
                while (dtr.Read())
                {
                   company_acccode=Convert.ToString(dtr["acccode"]);;
                }

                ((TextBox)e.Item.FindControl("txtAcct_Code")).Text = datarow.Account_Code;
            ((HiddenField)e.Item.FindControl("hdn_acccode")).Value = company_acccode;
            
            ((TextBox)e.Item.FindControl("txtAcct_Desc")).Text = datarow.Account_Description;
            ((TextBox)e.Item.FindControl("txtOp_Cr_Cu")).Text = datarow.opencredit_Cummulative;
            ((TextBox)e.Item.FindControl("txtOp_Cr_In")).Text = datarow.opencredit_in;
            ((TextBox)e.Item.FindControl("txtOp_Dr_Cu")).Text = datarow.opendebit_Cummulative;
            ((TextBox)e.Item.FindControl("txtOp_Dr_In")).Text = datarow.opendebit_in;
            if(((TextBox)e.Item.FindControl("txtOp_Cr_Cu")).Text=="")
            {
                ((TextBox)e.Item.FindControl("txtOp_Cr_Cu")).Text = "0.00";
            }
            if (((TextBox)e.Item.FindControl("txtOp_Cr_In")).Text == "")
            {
                ((TextBox)e.Item.FindControl("txtOp_Cr_In")).Text = "0.00";
            }
            if (((TextBox)e.Item.FindControl("txtOp_Dr_Cu")).Text == "")
            {
                ((TextBox)e.Item.FindControl("txtOp_Dr_Cu")).Text = "0.00";
            }
            if (((TextBox)e.Item.FindControl("txtOp_Dr_In")).Text == "")
            {
                ((TextBox)e.Item.FindControl("txtOp_Dr_In")).Text = "0.00";
            }
            ((TextBox)e.Item.FindControl("txtOpenBal")).Text = datarow.openign_bal;
            ((TextBox)e.Item.FindControl("txtCloseBal")).Text = datarow.closing_bal;
            if (((TextBox)e.Item.FindControl("txtOpenBal")).Text == "")
            {
                ((TextBox)e.Item.FindControl("txtOpenBal")).Text = "0.00";
            }
            if (((TextBox)e.Item.FindControl("txtCloseBal")).Text == "")
            {
                ((TextBox)e.Item.FindControl("txtCloseBal")).Text = "0.00";
            }
            ((Label)e.Item.FindControl("lblFinYear")).Text = datarow.FinYear;
        }

        if (loc_level == "1")
        {
            myGrid.Columns[7].Visible = false;
            myGrid.Columns[8].Visible = false;

        }
        else
        {
            myGrid.Columns[3].Visible = false;
            myGrid.Columns[4].Visible = false;
            myGrid.Columns[5].Visible = false;
            myGrid.Columns[6].Visible = false;
        }
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet1)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string YearVal = "";
        string tempDate = "";
        DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (mpLabel != null)
        {
            YearVal = mpLabel.SelectedItem.Text;

            string date_time = YearVal;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '-' };
            arDate_time = date_time.Split(split_arDate_time);
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
            }
        }

        Branch = Convert.ToString(Request.QueryString["branch"]).Trim();
        acc_code = Request.QueryString["acccode"].ToString().Trim();
        currfinyear = System.DateTime.Today.ToString("yyyy");
        string finyear = System.DateTime.Today.ToString("yy");
        int year = Convert.ToInt32(finyear);
        int yearnext = year + 1;
        string yearnew = Convert.ToString(yearnext);
        string YearVal1 = Request.QueryString["YearVal"].ToString().Trim();
        actable = "webx_acctinfo";
        acctran = "webx_acctopening_" + YearVal1;

        string SQLcheckloc = "select loccode,locname,loc_level from webx_location where loccode='" + Branch + "' and ACTIVEFLAG='Y'";
        dtr = DAccess.getreader(SQLcheckloc);
        while (dtr.Read())
        {
            loc_level = dtr["loc_level"].ToString().Trim();
        }
        dtr.Close();
        double new_Opening_Credit_In = 0.00;
        double new_Opening_Credit_Cu = 0.00;
        double new_Opening_Credit_In_1 = 0.00;

        double new_Opening_Debit_In = 0.00;
        double new_Opening_Debit_Cu = 0.00;
        double new_Opening_Debit_In_1 = 0.00;

        if (loc_level == "1")
        {
            DataSet1.OpenBal_BaranchRow datarow;
            foreach (DataGridItem gridrow in myGrid.Items)
            {
                datarow = _dataSet.OpenBal_Baranch[gridrow.DataSetIndex];
                string strSKU = ((CheckBox)gridrow.FindControl("chk")).Checked.ToString();
                if (strSKU == "True")
                {
                    string strAcc_Code = ((HiddenField)gridrow.FindControl("hdn_acccode")).Value;
                    double Opening_Credit_Cu_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOp_Cr_Cu")).Text);
                    double Opening_Credit_In_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOp_Cr_In")).Text);
                    double Opening_Debit_Cu_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOp_Dr_Cu")).Text);
                    double Opening_Debit_In_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOp_Dr_In")).Text);

                    double Opening_Credit_Cu = Convert.ToDouble(datarow.opencredit_Cummulative);  //_dataset.datarow.opencredit_Cummulative;
                    double Opening_Credit_In = Convert.ToDouble(datarow.opencredit_in);
                    double Opening_Debit_Cu = Convert.ToDouble(datarow.opendebit_Cummulative);
                    double Opening_Debit_In = Convert.ToDouble(datarow.opendebit_in);
                    
                    ////////////////Start Update //////////////////////
                    if (Opening_Debit_In_fo < Opening_Debit_In)
                    {
                        new_Opening_Debit_In = (Opening_Debit_In - Opening_Debit_In_fo);
                        new_Opening_Debit_In_1 = (Opening_Debit_In - new_Opening_Debit_In);
                        new_Opening_Debit_Cu = (Opening_Debit_Cu - new_Opening_Debit_In);
                        Hashtable myHT = new Hashtable();
                        myHT.Add("accode", strAcc_Code);
                        myHT.Add("tname", acctran);
                        myHT.Add("debit_i", new_Opening_Debit_In_1);
                        myHT.Add("debit", new_Opening_Debit_Cu);
                        myHT.Add("finyear", tempDate);
                        myHT.Add("branch", Branch);
                        DataAccess.insertQuary("usp_update_webx_acctopening_Dr", myHT);

                    }
                    if (Opening_Debit_In_fo > Opening_Debit_In)
                    {
                        new_Opening_Debit_In = (Opening_Debit_In_fo - Opening_Debit_In);
                        new_Opening_Debit_In_1 = (new_Opening_Debit_In + Opening_Debit_In);
                        new_Opening_Debit_Cu = (Opening_Debit_Cu + new_Opening_Debit_In);

                        Hashtable myHT = new Hashtable();
                        myHT.Add("accode", strAcc_Code);
                        myHT.Add("tname", acctran);
                        myHT.Add("debit_i", new_Opening_Debit_In_1);
                        myHT.Add("debit", new_Opening_Debit_Cu);
                        myHT.Add("finyear", tempDate);
                        myHT.Add("branch", Branch);
                        DataAccess.insertQuary("usp_update_webx_acctopening_Dr", myHT);
                    }
                    ///////////////////End Debit Update////////////////////////////////////////////////////////////////
                    ///////////////////Start Credit Update////////////////////////////////////////////////////////////////
                    if (Opening_Credit_In_fo < Opening_Credit_In)
                    {
                        new_Opening_Credit_In = (Opening_Credit_In - Opening_Credit_In_fo);
                        new_Opening_Credit_In_1 = (Opening_Credit_In - new_Opening_Credit_In);
                        new_Opening_Credit_Cu = (Opening_Credit_Cu - new_Opening_Credit_In);
                       
                        Hashtable myHT = new Hashtable();
                        myHT.Add("accode", strAcc_Code);
                        myHT.Add("tname", acctran);
                        myHT.Add("credit_i", new_Opening_Credit_In_1);
                        myHT.Add("credit", new_Opening_Credit_Cu);
                        myHT.Add("finyear", tempDate);
                        myHT.Add("branch", Branch);
                        DataAccess.insertQuary("usp_update_webx_acctopening_Cr", myHT);
                    }
                    if (Opening_Credit_In_fo > Opening_Credit_In)
                    {
                        new_Opening_Credit_In = (Opening_Credit_In_fo - Opening_Credit_In);
                        new_Opening_Credit_In_1 = new_Opening_Credit_In + Opening_Credit_In;
                        new_Opening_Credit_Cu = (Opening_Credit_Cu + new_Opening_Credit_In);

                        Hashtable myHT = new Hashtable();
                        myHT.Add("accode", strAcc_Code);
                        myHT.Add("tname", acctran);
                        myHT.Add("credit_i", new_Opening_Credit_In_1);
                        myHT.Add("credit", new_Opening_Credit_Cu);
                        myHT.Add("finyear", tempDate);
                        myHT.Add("branch", Branch);
                        DataAccess.insertQuary("usp_update_webx_acctopening_Cr", myHT);
                    }
                    
                    ////////////////End Update//////////////////////
                }
            }
        }
        else
        {
            DataSet1.OpenBal_BaranchRow datarow;
            foreach (DataGridItem gridrow in myGrid.Items)
            {
                datarow = _dataSet.OpenBal_Baranch[gridrow.DataSetIndex];
                string strSKU = ((CheckBox)gridrow.FindControl("chk")).Checked.ToString();
                if (strSKU == "True")
                {
                    string strAcc_Code = ((HiddenField)gridrow.FindControl("hdn_acccode")).Value;// ((TextBox)gridrow.FindControl("txtAcct_Code")).Text;
                    double Opening_Debit_In_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCloseBal")).Text);
                    double Opening_Credit_In_fo = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOpenBal")).Text);
                    string Opening_Debit_In_str = "0.00", Opening_Credit_In_str = "0.00";
                    Opening_Debit_In_str = Convert.ToString(datarow.opendebit_in);
                    Opening_Credit_In_str = Convert.ToString(datarow.opencredit_in);
                    if (Opening_Debit_In_str == "")
                    {
                        Opening_Debit_In_str = "0.00";
                    }
                    if (Opening_Credit_In_str == "")
                    {
                        Opening_Credit_In_str = "0.00";
                    }
                    double Opening_Debit_In = Convert.ToDouble(Opening_Debit_In_str);
                    double Opening_Credit_In = Convert.ToDouble(Opening_Credit_In_str);

                   
                    Hashtable myHT = new Hashtable();
                    myHT.Add("accode", strAcc_Code);
                    myHT.Add("tname", acctran);
                    myHT.Add("debit_i", Opening_Debit_In_fo);
                    myHT.Add("credit_i", Opening_Credit_In_fo);
                    myHT.Add("finyear", tempDate);
                    myHT.Add("branch", Branch);
                    DataAccess.insertQuary("usp_update_webx_acctopening_Branch", myHT);
                }
            }
        }
        Response.Redirect("OpBal_done.aspx");
    }
    protected void myGrid_SelectedIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        myGrid.CurrentPageIndex = e.NewPageIndex;
        BindGrid();
    }
}
