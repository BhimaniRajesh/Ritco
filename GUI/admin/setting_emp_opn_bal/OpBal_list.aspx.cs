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

public partial class GUI_admin_setting_emp_opn_bal_OpBal_list : System.Web.UI.Page
{
    //string sql_insert = "";
    //public static string loc_level, tblStr1, tblStr2, tblStr3, Branch, yearsuffix, currfinyear, emp_code, Entryby, EntryDt, Acccode, sql_insert_final, mHeadOfficeCode;
    //public static string employeesubledgeracctList = "'ASS0001','CA00016','EXP0005'";
    //public double opendebit_i, opencredit_i, opendebit, opencredit;
    SqlDataReader dtr;
    DateFunction DAccess = new DateFunction();
    public DataSet1 _dataSet = new DataSet1();
    DataAccess D_Access = new DataAccess();
    string sql = "";
    int _lastEditedPage;
    string YearVal;
    string EmpId, Opendebit_ASS0001, Opencredit_ASS0001, Opendebit_CA00016, Opencredit_CA00016, Opendebit_EXP0005, Opencredit_EXP0005;
    string Branch, currfinyear, yearsuffix, actable, acctran, loc_level, loc_name, Empcd, acctopen;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Branch = Convert.ToString(Request.QueryString["branch"]);
            //Entryby = Session["empcd"].ToString();
            //mHeadOfficeCode = Branch;
            //EntryDt = System.DateTime.Today.ToString("dd MMM yyyy");
            //currfinyear = System.DateTime.Today.ToString("yyyy");
            //string finyear = System.DateTime.Today.ToString("yy");
            //int year = Convert.ToInt32(finyear);
            //int yearnext = year + 1;
            //string yearnew = Convert.ToString(yearnext);
            //if (yearnew.Length <= 1)
            //{
            //    yearnew = "0" + yearnew;
            //}
            //yearsuffix = finyear + "_" + yearnew;

            //tblStr1 = "webx_acctinfo";
            //tblStr2 = "webx_acctopening_employee_" + yearsuffix;
            //tblStr3 = "webx_acctopening_" + yearsuffix;
            //BindGrid();
            Branch = "";
            Branch = Request.QueryString["branch"].ToString().Trim();
            currfinyear = System.DateTime.Today.ToString("yyyy");
            string finyear = System.DateTime.Today.ToString("yy");
            int year = Convert.ToInt32(finyear);
            int yearnext = year + 1;
            string yearnew = Convert.ToString(yearnext);
            if (yearnew.Length <= 1)
            {
                yearnew = "0" + yearnew;
            }
            yearsuffix = finyear + "_" + yearnew;

            actable = "webx_acctinfo";
            acctran = "webx_acctopening_" + yearsuffix;
            acctopen = "webx_acctopening_employee_" + yearsuffix;
            Initialize();
            BindGrid();
        }
    }
    private void Initialize()
    {
        

        string SQLcheckloc = "select loccode,locname,loc_level from webx_location where loccode='" + Branch + "' and ACTIVEFLAG='Y'";
        dtr = DAccess.getreader(SQLcheckloc);
        while (dtr.Read())
        {
            loc_level = dtr["loc_level"].ToString().Trim();
            loc_name = dtr["locname"].ToString().Trim();
        }
        dtr.Close();
        Label1.Text = "For Branch " + " : " + loc_name;
        //if (acc_code == "All")
        //{
        //    sql = "select a.Acccode,a.Accdesc,b.finyear,convert(varchar,(convert(money,(b.opendebit),2))) as opendebit,convert(varchar,(convert(money,(b.opencredit),2))) as opencredit,convert(varchar,(convert(money,(b.opendebit_i),2))) as opendebit_i,convert(varchar,(convert(money,(b.opencredit_i),2))) as opencredit_i,b.brcd from " + acctran + " b ," + actable + " a where  a.Acccode=b.Acccode and substring(groupcode,1,3) in ('ASS','LIA') and b.brcd='" + Branch + "' order by a.Accdesc";
        //}
        //else
        //{
        sql = "select d.UserId,d.EmpId + ' : ' + d.Name as EmpId,isNull(a.Loccode,''),convert(varchar,(convert(money,isNull(a.Opendebit,0.00),2))) as Opendebit_ASS0001,convert(varchar,(convert(money,isNull(a.Opencredit,0.00),2))) as Opencredit_ASS0001 , convert(varchar,(convert(money,isNull(b.Opendebit,0.00),2))) as Opendebit_CA00016,convert(varchar,(convert(money,isNull(b.Opencredit,0.00),2))) as Opencredit_CA00016,convert(varchar,(convert(money,isNull(c.Opendebit,0.00),2))) as Opendebit_EXP0005, convert(varchar,(convert(money,isNull(c.Opencredit,0.00),2))) as Opencredit_EXP0005 from acccode_ASS0001 a,acccode_CA00016 b,acccode_EXP0005 c,WebX_Master_Users d where d.UserId *= a.Empcd and d.UserId *= b.Empcd and d.UserId *= c.Empcd and  d.BranchCode = '" + Branch + "' and d.UserId is Not Null order by d.EmpId ";
        //sql = "select a.Empcd,d.EmpId + ':' + d.Name as EmpId,a.Loccode,convert(varchar,(convert(money,(a.Opendebit),2))) as Opendebit_ASS0001,convert(varchar,(convert(money,(a.Opencredit),2))) as Opencredit_ASS0001 , convert(varchar,(convert(money,(b.Opendebit),2))) as Opendebit_CA00016,convert(varchar,(convert(money,(b.Opencredit),2))) as Opencredit_CA00016,convert(varchar,(convert(money,(c.Opendebit),2))) as Opendebit_EXP0005, convert(varchar,(convert(money,(c.Opencredit),2))) as Opencredit_EXP0005 from acccode_ASS0001 a,acccode_CA00016 b,acccode_EXP0005 c,WebX_Master_Users d  where  a.Loccode = 'DEL' and a.Empcd = d.UserId order by d.EmpId"; 
        
        //}
        
        dtr = DAccess.getreader(sql);
        EmpId="";
        Opendebit_ASS0001="";
        Opencredit_ASS0001="";
        Opendebit_CA00016="";
        Opencredit_CA00016="";
        Opendebit_EXP0005="";
        Opencredit_EXP0005 = "";

        while (dtr.Read())
        {
            Empcd = dtr["UserId"].ToString();
            EmpId = dtr["EmpId"].ToString();
            Opendebit_ASS0001 = dtr["Opendebit_ASS0001"].ToString();
            Opencredit_ASS0001 = dtr["Opencredit_ASS0001"].ToString();
            Opendebit_CA00016 = dtr["Opendebit_CA00016"].ToString();
            Opencredit_CA00016 = dtr["Opencredit_CA00016"].ToString();
            Opendebit_EXP0005 = dtr["Opendebit_EXP0005"].ToString();
            Opencredit_EXP0005 = dtr["Opencredit_EXP0005"].ToString();
            _dataSet.OpenBal_Emp.AddOpenBal_EmpRow("", EmpId, Opendebit_ASS0001, Opencredit_ASS0001, Opendebit_CA00016, Opencredit_CA00016, Opendebit_EXP0005, Opencredit_EXP0005,Empcd);
        }
        dtr.Close();

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
    private void BindGrid()
    {
        myGrid.DataSource = _dataSet.OpenBal_Emp;
        myGrid.DataBind();
        _lastEditedPage = myGrid.CurrentPageIndex;
    }
    protected void myGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        
        DataSet1.OpenBal_EmpRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            string strStaff_Advance_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Advance_Dr")).ClientID;
            string strStaff_Advance_Cr = ((TextBox)e.Item.FindControl("txt_Staff_Advance_Cr")).ClientID;
            string strStaff_Loan_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Loan_Dr")).ClientID;
            string strStaff_Loan_Cr= ((TextBox)e.Item.FindControl("txt_Staff_Loan_Cr")).ClientID;
            string strStaff_Imprest_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Dr")).ClientID;
            string strStaff_Imprest_Cr = ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Cr")).ClientID;

            TextBox Staff_Advance_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Advance_Dr"));
            TextBox Staff_Advance_Cr = ((TextBox)e.Item.FindControl("txt_Staff_Advance_Cr"));
            TextBox Staff_Loan_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Loan_Dr"));
            TextBox Staff_Loan_Cr = ((TextBox)e.Item.FindControl("txt_Staff_Loan_Cr"));
            TextBox Staff_Imprest_Dr = ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Dr"));
            TextBox Staff_Imprest_Cr = ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Cr"));

            string str1 = "javascript:return chk(this," + strStaff_Advance_Cr + ")";
            string str2 = "javascript:return chk(this," + strStaff_Advance_Dr + ")";
            Staff_Advance_Dr.Attributes.Add("onBlur", str1);
            Staff_Advance_Cr.Attributes.Add("onBlur", str2);

            string str3 = "javascript:return chk(this," + strStaff_Loan_Cr + ")";
            string str4 = "javascript:return chk(this," + strStaff_Loan_Dr + ")";
            Staff_Loan_Dr.Attributes.Add("onBlur", str3);
            Staff_Loan_Cr.Attributes.Add("onBlur", str4);

            string str5 = "javascript:return chk(this," + strStaff_Imprest_Cr + ")";
            string str6 = "javascript:return chk(this," + strStaff_Imprest_Dr + ")";
            Staff_Imprest_Dr.Attributes.Add("onBlur", str5);
            Staff_Imprest_Cr.Attributes.Add("onBlur", str6);

        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.OpenBal_EmpRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtAccountCode")).Text = datarow.Account_Code_Desc;
            ((TextBox)e.Item.FindControl("txt_Staff_Advance_Dr")).Text = datarow.staff_adv_Dr;
            ((TextBox)e.Item.FindControl("txt_Staff_Advance_Cr")).Text = datarow.staff_adv_Cr;
            ((TextBox)e.Item.FindControl("txt_Staff_Loan_Dr")).Text = datarow.staff_Loan_Dr;
            ((TextBox)e.Item.FindControl("txt_Staff_Loan_Cr")).Text = datarow.staff_Loan_Cr;
            ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Dr")).Text = datarow.staff_imprest_Dr;
            ((TextBox)e.Item.FindControl("txt_Staff_Imprest_Cr")).Text = datarow.staff_imprest_Cr;
        }
    }
    public void btnSubmit_onClick(object sender, EventArgs e)
    {
        DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (mpLabel != null)
        {
            YearVal = mpLabel.SelectedItem.Value;
        }
        acctopen = "webx_acctopening_employee_" + YearVal;
        DataSet1.OpenBal_EmpRow datarow;
        foreach (DataGridItem gridrow in myGrid.Items)
         {
             datarow = _dataSet.OpenBal_Emp[gridrow.DataSetIndex];
             string strSKU = ((CheckBox)gridrow.FindControl("chk")).Checked.ToString();
             if (strSKU == "True")
             {

                 string strempcd = datarow.empcd;
                 string staff_adv_Dr = ((TextBox)gridrow.FindControl("txt_Staff_Advance_Dr")).Text;
                 string staff_adv_Cr = ((TextBox)gridrow.FindControl("txt_Staff_Advance_Cr")).Text;
                 string staff_Loan_Dr = ((TextBox)gridrow.FindControl("txt_Staff_Loan_Dr")).Text; ;
                 string staff_Loan_Cr = ((TextBox)gridrow.FindControl("txt_Staff_Loan_Cr")).Text; ;
                 string staff_imprest_Dr = ((TextBox)gridrow.FindControl("txt_Staff_Imprest_Dr")).Text;
                 string staff_imprest_Cr = ((TextBox)gridrow.FindControl("txt_Staff_Imprest_Cr")).Text;
                 Hashtable myHT = new Hashtable();
                 myHT.Add("ASS0001_openDebit", staff_adv_Dr);
                 myHT.Add("ASS0001_openCredit", staff_adv_Cr);
                 myHT.Add("CA00016_openDebit", staff_Loan_Dr);
                 myHT.Add("CA00016_openCredit", staff_Loan_Cr);
                 myHT.Add("EXP0005_openDebit",  staff_imprest_Dr);
                 myHT.Add("EXP0005_openCredit", staff_imprest_Cr);
                 myHT.Add("empcode",strempcd);
                 myHT.Add("tname", acctopen);
                 DataAccess.insertQuary("usp_openBal_emp", myHT);
             }
             
         }
         Response.Redirect("OpBal_done.aspx");
    }
    //private void BindGrid()
    //{
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //string sql = "select  * from webx_master_users where branchcode='" + Branch + "'";

        //SqlCommand cmd = new SqlCommand(sql, conn);
        //SqlDataAdapter da = new SqlDataAdapter(cmd);

        //DataSet ds = new DataSet();
        //da.Fill(ds);

        //HOList.Visible = true;
        //HOList.DataSource = ds;
        //HOList.DataBind();

        //conn.Close();

    
}

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //foreach (GridViewRow gridrow in HOList.Rows)
        //{
        //    CheckBox chk = (CheckBox)gridrow.FindControl("chkBill");
        //    Label employeecode = (Label)gridrow.FindControl("lblempcd");

        //    TextBox d1 = (TextBox)gridrow.FindControl("Debit2");
        //    TextBox c1 = (TextBox)gridrow.FindControl("Credit3");
        //    TextBox d2 = (TextBox)gridrow.FindControl("Debit2");
        //    TextBox c2 = (TextBox)gridrow.FindControl("Credit3");
        //    TextBox d3 = (TextBox)gridrow.FindControl("Debit2");
        //    TextBox c3 = (TextBox)gridrow.FindControl("Credit3");


        //    string employee = employeecode.Text;
        //    string[] empcd;
        //    empcd = employee.Split(':');
        //    emp_code = empcd[0].ToString();
        //    double opdebit1 = Convert.ToDouble(d1.Text);
        //    double opencredit1 = Convert.ToDouble(c1.Text);

        //    double opdebit2 = Convert.ToDouble(d2.Text);
        //    double opencredit2 = Convert.ToDouble(c2.Text);

        //    double opdebit3 = Convert.ToDouble(d3.Text);
        //    double opencredit3 = Convert.ToDouble(c3.Text);

        //    if (chk.Checked == true)
        //    {
        //        SqlConnection conn11 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //        conn11.Open();
        //        string sql = "Select * from " + tblStr2 + " where Empcd ='" + emp_code + "' and loccode='" + Branch + "'";
        //        SqlCommand cmd = new SqlCommand(sql, conn11);
        //        SqlDataReader dr1;
        //        dr1 = cmd.ExecuteReader();
        //        if (dr1.Read())
        //        {
        //            SqlConnection conn21 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn21.Open();

        //            string sqlStr = "UPDATE " + tblStr2 + " SET Opendebit=" + opdebit1 + ",Opencredit=" + opencredit1 + " Where Empcd='" + emp_code + "' and Loccode='" + Branch + "' and Acccode='ASS0001'";
        //            string sqlStr1 = "UPDATE " + tblStr2 + " SET Opendebit=" + opdebit2 + ",Opencredit=" + opencredit2 + " Where Empcd='" + emp_code + "' and Loccode='" + Branch + "' and Acccode='CA00016'";
        //            string sqlStr2 = "UPDATE " + tblStr2 + " SET Opendebit=" + opdebit3 + ",Opencredit=" + opencredit3 + " Where Empcd='" + emp_code + "' and Loccode='" + Branch + "' and Acccode='EXP0005'";

        //            SqlCommand cmdsqlStr = new SqlCommand(sqlStr, conn21);
        //            SqlCommand cmdsqlStr1 = new SqlCommand(sqlStr1, conn21);
        //            SqlCommand cmdsqlStr2 = new SqlCommand(sqlStr2, conn21);

        //            cmdsqlStr.ExecuteNonQuery();
        //            cmdsqlStr1.ExecuteNonQuery();
        //            cmdsqlStr2.ExecuteNonQuery();

        //            conn21.Close();
        //        }
        //        else
        //        {
        //            SqlConnection conn31 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn31.Open();
        //            string sqlstr = "INSERT INTO " + tblStr2 + " (Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt) VALUES ('ASS0001','" + opdebit1 + "','" + opencredit1 + "','" + emp_code + "','" + Branch + "','" + Entryby + "','" + EntryDt + "')";
        //            string sqlstr1 = "INSERT INTO " + tblStr2 + " (Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt) VALUES ('CA00016','" + opdebit2 + "','" + opencredit2 + "','" + emp_code + "','" + Branch + "','" + Entryby + "','" + EntryDt + "')";
        //            string sqlstr2 = "INSERT INTO " + tblStr2 + " (Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt) VALUES ('EXP0005','" + opdebit3 + "','" + opencredit3 + "','" + emp_code + "','" + Branch + "','" + Entryby + "','" + EntryDt + "')";

        //            SqlCommand cmdsqlStr = new SqlCommand(sqlstr, conn31);
        //            SqlCommand cmdsqlStr1 = new SqlCommand(sqlstr1, conn31);
        //            SqlCommand cmdsqlStr2 = new SqlCommand(sqlstr2, conn31);

        //            cmdsqlStr.ExecuteNonQuery();
        //            cmdsqlStr1.ExecuteNonQuery();
        //            cmdsqlStr2.ExecuteNonQuery();

        //            conn31.Close();
        //        }
        //        dr1.Close();
        //        conn11.Close();

        //        SqlConnection conn41 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //        conn41.Open();
        //        string sql_ind = "select Acccode,sum(opendebit) as opendebit_i ,sum(Opencredit)as opencredit_i  from " + tblStr2 +" where Loccode='" + Branch + "' and acccode in (" + employeesubledgeracctList + ") Group by Acccode";
        //        SqlCommand cmd4 = new SqlCommand(sql_ind, conn41);
        //        SqlDataReader dr4;
        //        dr4 = cmd4.ExecuteReader();
        //        while(dr4.Read())
        //        {
        //            Acccode = Convert.ToString(dr4["Acccode"]);
        //            opencredit_i = Convert.ToDouble(dr4["opendebit_i"]);
        //            opendebit_i = Convert.ToDouble(dr4["opencredit_i"]);

        //            if (opendebit_i > opencredit_i)
        //            {
        //                opendebit_i = opendebit_i - opencredit_i;
        //                opencredit_i = 0;
        //            }
        //            else
        //            {
        //                opencredit_i = opencredit_i - opendebit_i;
        //                opendebit_i = 0;
        //            }
        //            SqlConnection conn51 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn51.Open();
        //            string sqlint = "select * from " + tblStr3 + " where brcd='" + Branch + "' and acccode='" + Acccode + "'";
        //            SqlCommand cmd5 = new SqlCommand(sqlint, conn51);
        //            SqlDataReader dr5;
        //            dr5 = cmd5.ExecuteReader();
        //            string sql_insert="";
        //            if (dr5.Read())
        //            {
        //                sql_insert = "update " + tblStr3 + " set opendebit_i='" + opendebit_i + "',opencredit_i='" + opencredit_i + "'  where brcd='" + Branch + "' and acccode='" + Acccode + "' ";
        //            }
        //            else
        //            {
        //                //sql_insert = "insert into " + tblStr3 + " (opendebit_i,opencredit_i) values ('" + opendebit_i + "','" + opencredit_i + "') where brcd='" + Branch + "' and acccode='" + Acccode + "' ";
        //            }
        //            SqlConnection conn61 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn61.Open();
        //            SqlCommand cmd6 = new SqlCommand(sql_insert, conn61);
        //            cmd6.ExecuteNonQuery();
        //            conn61.Close();

        //            SqlConnection conn71 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn71.Open();
        //            string sql_final = "select Acccode,sum(opendebit_i) as opendebit_i ,sum(opencredit_i) as opencredit_i from " + tblStr3 + " where acccode='" + Acccode + "'group by acccode";
        //            SqlCommand cmd7 = new SqlCommand(sql_final, conn71);
        //            SqlDataReader dr7;
        //            dr7 = cmd7.ExecuteReader();
        //            if (dr7.Read())
        //            {
        //                Acccode = Convert.ToString(dr7["Acccode"]);
        //                opendebit = Convert.ToDouble(dr7["opendebit_i"]);
        //                opencredit = Convert.ToDouble(dr7["opencredit_i"]);

        //                if (opendebit > opencredit)
        //                {
        //                    opendebit = opendebit - opencredit;
        //                    opencredit = 0;
        //                }
        //                else
        //                {
        //                    opencredit = opencredit - opendebit;
        //                    opendebit = 0;
        //                }
        //                if (opencredit == opendebit)
        //                {
        //                    opendebit = 0;
        //                    opencredit = 0;
        //                }

        //                SqlConnection conn81 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //                conn81.Open();
        //                string sqlint1 = "select * from " + tblStr3 + " where brcd='" + mHeadOfficeCode + "' and acccode='" + Acccode + "'";
        //                SqlCommand cmd8 = new SqlCommand(sql_final, conn81);
        //                SqlDataReader dr8;
        //                dr8 = cmd8.ExecuteReader();
        //                if (dr8.Read())
        //                {
        //                    sql_insert_final = "update " + tblStr3 + " set opendebit='" + opendebit + "',opencredit='" + opencredit + "'  where brcd='" + mHeadOfficeCode + "' and acccode='" + Acccode + "' ";
        //                }
        //                else
        //                {
        //                   // sql_insert_final = "insert into " + tblStr3 + " (opendebit,opencredit) values ('" + opendebit + "','" + opencredit + "') where brcd='" + mHeadOfficeCode + "' and acccode='" + Acccode + "' ";
        //                }
        //                SqlConnection conn91 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //                conn91.Open();
        //                SqlCommand cmd9 = new SqlCommand(sql_insert_final, conn91);
        //                cmd9.ExecuteNonQuery();
        //                conn91.Close();
                        
        //                dr8.Close();
        //                conn81.Close();

        //            }
        //            dr7.Close();
        //            conn51.Close();

                    
        //        }
        //        dr4.Close();
        //        dr1.Close();
        //    }
            
        //}
        //conn.Close();
    //}
    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{
    //    HOList.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}
//}
