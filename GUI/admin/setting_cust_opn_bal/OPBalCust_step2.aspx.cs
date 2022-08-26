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

public partial class GUI_admin_setting_cust_opn_bal_OPBalCust_step2 : System.Web.UI.Page
{
    public string sqlCustomer, sqlVendor, SlectedTpe = "", Custaccount = "", custcls = "", vendcls = "", CustaccountDesc = "", Vend_account = "", Vend_accountDesc = "", vendor_type="";
    public static string vendor_code, vendor_name, vendoracccode, Acccode, custloc, vendorloc;
    public static string tblStr1, tblStr2, tblStr3, custcd, vendcd, yearsuffix, currfinyear, Entryby, Branch, mHeadOfficeCode, Financial_Year = "", fin_year = "";
    public double opendebit, opencredit;
    public double opendebit_i=0, opencredit_i=0;
    public static int intTotalRecords = 0;
    string Driver_Code = "", DRV_account = "", DRV_accountDesc = "", DRVloc = "";
    string Emp_Code = "", Emp_account = "", Emp_accountDesc = "", Emploc = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        custcd = Convert.ToString(Request.QueryString["custcode"]);
        SlectedTpe = Convert.ToString(Request.QueryString["SlectedTpe"]);
        CustaccountDesc = Convert.ToString(Request.QueryString["CustaccountDesc"]);
        Vend_account = Convert.ToString(Request.QueryString["Vend_account"]).Trim();
        vendor_type = Convert.ToString(Request.QueryString["vendor_type"]);
        Vend_accountDesc = Convert.ToString(Request.QueryString["Vend_accountDesc"]);
        Custaccount = Convert.ToString(Request.QueryString["Custaccount"]).Trim();
        vendcd = Convert.ToString(Request.QueryString["vendorcode"]);
        custloc = Convert.ToString(Request.QueryString["custloc"]);
        vendorloc = Convert.ToString(Request.QueryString["vendorloc"]);

        Emp_Code = Convert.ToString(Request.QueryString["Emp_Code"]);
        Emp_account = Convert.ToString(Request.QueryString["Emp_account"]);
        Emp_accountDesc = Convert.ToString(Request.QueryString["Emp_accountDesc"]);
        Emploc = Convert.ToString(Request.QueryString["Emploc"]);


        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        Driver_Code = Convert.ToString(Request.QueryString["Driver_Code"]);
        DRV_account = Convert.ToString(Request.QueryString["DRV_account"]);
        DRV_accountDesc = Convert.ToString(Request.QueryString["DRV_accountDesc"]);
        DRVloc = Convert.ToString(Request.QueryString["DRVloc"]);

       // Response.Write("Driver_Code-" + Driver_Code);

        if (!IsPostBack)
        {
           
            Entryby = Session["empcd"].ToString();
            Branch = Session["brcd"].ToString();
            mHeadOfficeCode = Branch;
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

            tblStr1 = "webx_acctinfo";
            tblStr2 = "webx_acctopening_employee_" + fin_year;
            tblStr3 = "webx_acctopening_" + fin_year;

            if (SlectedTpe == "C")
            {
                p1.Visible = true;
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                if(custcd!="")
                {
                       custcls = "and d.custcd='" + custcd + "'";
                }
                sqlCustomer = "select   '" + Custaccount + "'+':'+'" + CustaccountDesc + "' as acctval, d.custcd +':'+ d.custnm as custval,d.custcd as custcode ,d.custnm as custname,isnull(m.opendebit,0) as opendebit,isnull(m.opencredit,0)  as opencredit from webx_custhdr d   left outer join " + tblStr2 + " m  on  d.custcd=m.empcd   and     acccode='" + Custaccount + "' and loccode='" + custloc + "' where      PATINDEx ('%" + custloc + "%',custloc)>0 " + custcls + " ";
                SqlCommand cmdCustomer = new SqlCommand(sqlCustomer, conn);
                //SqlDataReader dr;
                //dr = cmdCustomer.ExecuteReader();
                //if (dr.Read())
                //{
                //    lblCustomer.Text = dr["custcode"].ToString() + ":" + dr["custname"].ToString();
                //    txtDebit1.Text = dr["opendebit"].ToString();
                //    txtCredit1.Text = dr["opencredit"].ToString();
                //}
                //dr.Close();

                SqlDataAdapter da = new SqlDataAdapter(cmdCustomer);
                DataSet ds = new DataSet();
                da.Fill(ds, "tab");
                GV_Customer.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                GV_Customer.DataBind();
                conn.Close();

            }
            else if (SlectedTpe == "V")
            {
                p2.Visible = true;

                if (vendcd != "")
                {
                    vendcls = "and d.vendorcode='" + vendcd + "'";
                }
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                sqlVendor = "select   '" + Vend_account + "'+':'+'" + Vend_accountDesc + "' as acctval,d.vendorcode as VendorCode,d.vendorcode+':'+d.vendorName as Vendval,Cast(Cast(isnull(m.opendebit,0) As Money) as varchar) as Opendebit,Cast(Cast(isnull(m.opencredit,0) As Money) as varchar) as OpenCredit from  webx_vendor_hdr d    left outer join  " + tblStr2 + " m   on d.vendorcode=m.empcd  and loccode='" + vendorloc + "' inner join  webx_vendor_det c on d.vendorcode=c.vendorcode where  1=1  " + vendcls + "   and  PATINDEx ('%" + vendorloc + "%',vendorbrcd)>0  and vendor_type='" + vendor_type + "'order by vendorName ";
                //Response.Write("sqlVendor" + sqlVendor);
              //  Response.End();
                SqlCommand cmdVendor = new SqlCommand(sqlVendor, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmdVendor);
                DataSet ds = new DataSet();
                da.Fill(ds, "tab");
                GV_Vendor.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                GV_Vendor.DataBind();
                conn.Close();

                
                conn.Close();
            }
            else if (SlectedTpe == "D")
            {
                P3.Visible = true;
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                if (Driver_Code != "")
                {
                    //custcls = "and  convert(varchar,d.driver_id,106)='" + Driver_Code + "'";
                    custcls = "and manual_driver_code='" + Driver_Code + "'";
                }
                sqlCustomer = "select   '" + DRV_account + "'+':'+'" + DRV_accountDesc + "' as acctval, convert(varchar,d.driver_id,106) +':'+ d.driver_name as drvval, convert(varchar,d.driver_id,106) as driver_id , d.driver_name as driver_name,isnull(m.opendebit,0) as opendebit,isnull(m.opencredit,0)  as opencredit,manual_driver_code from WEBX_FLEET_DRIVERMST d  left outer join  " + tblStr2 + " m on convert(varchar,d.driver_id,106)=m.empcd       and acccode='" + DRV_account + "' and loccode='" + DRVloc + "' where   PATINDEx ('%" + DRVloc + "%',driver_location)>0  " + custcls + "";
                SqlCommand cmdCustomer = new SqlCommand(sqlCustomer, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmdCustomer);
                DataSet ds = new DataSet();
                da.Fill(ds, "tab");
                GV_Driver.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                GV_Driver.DataBind();
                conn.Close();

            }
            else if (SlectedTpe == "E")
            {
                P4.Visible = true;
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                if (Emp_Code != "")
                {
                    custcls = "and  convert(varchar,d.Userid,106)='" + Emp_Code + "'";
                }
                sqlCustomer = "select   '" + Emp_account + "'+':'+'" + Emp_accountDesc + "' as acctval, convert(varchar,d.Userid,106) +':'+ d.Name as drvval, convert(varchar,d.Userid,106) as Userid , d.name as Empname,isnull(m.opendebit,0) as opendebit,isnull(m.opencredit,0)  as opencredit from webx_master_users d  left outer join  " + tblStr2 + " m on convert(varchar,d.Userid,106)=m.empcd   and acccode='" + Emp_account + "' and loccode='" + Emploc + "' where  1=1 " + custcls + "";
                //Response.Write("<BR>sqlCustomer-" + sqlCustomer);
                SqlCommand cmdEmp = new SqlCommand(sqlCustomer, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmdEmp);
                DataSet ds = new DataSet();
                da.Fill(ds, "tab");
                GV_Emp.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                GV_Emp.DataBind();
                conn.Close();

            }
        }
        btnSubmit1.Attributes.Add("onclick", "javascript:return check_debit_credit1('C')");
        btnSubmit2.Attributes.Add("onclick", "javascript:return check_debit_credit1('V')");
        button3.Attributes.Add("onclick", "javascript:return check_debit_credit1('D')");
        Btn_Emp.Attributes.Add("onclick", "javascript:return check_debit_credit1('E')");
    }

    protected void btnSubmit1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {

            string Custcode = "";
            foreach (GridViewRow gr in GV_Customer.Rows)
            {

                if (((CheckBox)gr.FindControl("Chkcust")).Checked == true)
                {

                    opendebit = Convert.ToDouble(((TextBox)gr.FindControl("TxtDebit")).Text);
                    opencredit = Convert.ToDouble(((TextBox)gr.FindControl("TxtCredit")).Text);
                    Custcode = ((HiddenField)gr.FindControl("hnd_Custcode")).Value;

                    string sql_insert = "delete from " + tblStr2 + " where Acccode='" + Custaccount + "' and Empcd='" + Custcode + "' and Loccode='" + custloc + "'";
                    SqlCommand cmd = new SqlCommand(sql_insert, conn,trans);
                    cmd.ExecuteNonQuery();

                    sql_insert = "insert into " + tblStr2 + "(Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt,Updtby,updtdt) values('" + Custaccount + "'," + opendebit + "," + opencredit + ",'" + Custcode + "','" + custloc + "','" + Entryby + "',getdate(),'" + Entryby + "',getdate())";
                    cmd = new SqlCommand(sql_insert, conn, trans);
                    cmd.ExecuteNonQuery();
                }
            }


            string sql_ind = "select '" + Custaccount + "' as acccode, sum(a.opendebit) as opendebit_i ,sum(a.Opencredit)as opencredit_i  from " + tblStr2 + " a with (NOLOCK) ,webx_custhdr b  with (NOLOCK) where a.empcd=b.custcd  and loccode='" + custloc + "' and acccode='" + Custaccount + "'";
            SqlCommand cmd_ind = new SqlCommand(sql_ind, conn, trans);
            SqlDataReader dr_ind;
            dr_ind = cmd_ind.ExecuteReader();
            if (dr_ind.Read())
            {
                Acccode = Convert.ToString(dr_ind["acccode"]);
                opendebit_i = Convert.ToDouble(dr_ind["opendebit_i"]);
                opencredit_i = Convert.ToDouble(dr_ind["opencredit_i"]);

                if (opendebit_i > opencredit_i)
                {
                    opendebit_i = opendebit_i - opencredit_i;
                    opencredit_i = 0;
                }
                else
                {
                    opencredit_i = opencredit_i - opendebit_i;
                    opendebit_i = 0;
                }
                
               
            }
            else
            {

            }
            dr_ind.Close();
            string sqlUpdate = "delete from  " + tblStr3 + "  where brcd='" + custloc + "' and acccode='" + Acccode + "' ";
            SqlCommand cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();


            sqlUpdate = "Insert into  " + tblStr3 + "  (opendebit,opencredit,finyear,acccode,brcd,opendebit_i,opencredit_i,FinStartDate,Entryby)   values(0,0,'" + Session["Finyear"].ToString() + "','" + Acccode + "','" + custloc + "','" + opendebit_i + "','" + opencredit_i + "',NULL,'" + Entryby + "')  ";
            cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();
               
            trans.Commit();
            conn.Close();
            //Response.Redirect("sel_brnch.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }
            else
            {
                trans.Rollback();
                conn.Close();
            }
            Response.End();
        }

        Response.Redirect("sel_brnch.aspx");
    }
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string Vendorcode = "";
            foreach (GridViewRow gr in GV_Vendor.Rows)
            {

                if (((CheckBox)gr.FindControl("Chkcust")).Checked == true)
                {

                    opendebit = Convert.ToDouble(((TextBox)gr.FindControl("TxtDebit")).Text);
                    opencredit = Convert.ToDouble(((TextBox)gr.FindControl("TxtCredit")).Text);
                    Vendorcode = ((HiddenField)gr.FindControl("hnd_Vendorcode")).Value;

                    string sql_insert = "delete from " + tblStr2 + " where Acccode='" + Vend_account + "' and Empcd='" + Vendorcode + "' and Loccode='" + vendorloc + "'";
                    SqlCommand cmd = new SqlCommand(sql_insert, conn,trans);
                    cmd.ExecuteNonQuery();

                    sql_insert = "insert into " + tblStr2 + "(Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt,Updtby,updtdt) values('" + Vend_account + "'," + opendebit + "," + opencredit + ",'" + Vendorcode + "','" + vendorloc + "','" + Entryby + "',getdate(),'" + Entryby + "',getdate())";
                    cmd = new SqlCommand(sql_insert, conn,trans);
                    cmd.ExecuteNonQuery();
                }
            }



            string sql_ind = "select a.acccode as acccode, sum(a.opendebit) as opendebit_i,sum(a.Opencredit)as opencredit_i from " + tblStr2 + " a with (NOLOCK) ,webx_vendor_hdr b  with (NOLOCK) where a.empcd=b.vendorcode and loccode='" + vendorloc + "' and Acccode='" + Vend_account + "' group by a.acccode ";

            SqlCommand cmd_ind = new SqlCommand(sql_ind, conn,trans);
            SqlDataReader dr_ind;
            dr_ind = cmd_ind.ExecuteReader();
            if (dr_ind.Read())
            {
                Acccode = Convert.ToString(dr_ind["acccode"]);
                opencredit_i = Convert.ToDouble(dr_ind["opencredit_i"]);
                opendebit_i = Convert.ToDouble(dr_ind["opendebit_i"]);

                if (opendebit_i > opencredit_i)
                {
                    opendebit_i = opendebit_i - opencredit_i;
                    opencredit_i = 0;
                }
                else
                {
                    opencredit_i = opencredit_i - opendebit_i;
                    opendebit_i = 0;
                }
               
               
             
            }
            dr_ind.Close();
            string sqlUpdate = "delete from  " + tblStr3 + "   where brcd='" + vendorloc + "' and acccode='" + Vend_account + "' ";
            SqlCommand cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();


            sqlUpdate = "insert into     " + tblStr3 + "  (opendebit,opencredit,finyear,acccode,brcd,opendebit_i,opencredit_i,FinStartDate,Entryby) values(0,0,'" + Session["Finyear"].ToString() + "','" + Vend_account + "','" + vendorloc + "','" + opendebit_i + "','" + opencredit_i + "',NULL,'" + Entryby + "')   ";
            cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();
            trans.Commit();
            conn.Close();

            //Response.Redirect("sel_brnch.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }
            else
            {
                trans.Rollback();
                conn.Close();
            }

           Response.End();
        }
        Response.Redirect("sel_brnch.aspx");
    }
    protected void btnSubmit3_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {

            string Drivercode = "";
            foreach (GridViewRow gr in GV_Driver.Rows)
            {

                if (((CheckBox)gr.FindControl("Chkcust")).Checked == true)
                {
                    string opendebitstr = ((TextBox)gr.FindControl("TxtDebit")).Text.ToString();
                    string opencreditstr = ((TextBox)gr.FindControl("TxtCredit")).Text.ToString();
                    if (opendebitstr == "" || opendebitstr == null)
                    {
                        opendebitstr = "0.00";
                    }
                    if (opencreditstr == "" || opencreditstr == null)
                    {
                        opencreditstr = "0.00";
                    }
                    opendebit = Convert.ToDouble(opendebitstr);
                    opencredit = Convert.ToDouble(opencreditstr);
                    Drivercode = ((HiddenField)gr.FindControl("hnd_Drivercode")).Value;

                    string sql_insert = "delete from " + tblStr2 + " where Acccode='" + DRV_account + "' and Empcd='" + Drivercode + "' and Loccode='" + DRVloc + "'";
                    SqlCommand cmd = new SqlCommand(sql_insert, conn, trans);
                    cmd.ExecuteNonQuery();

                    sql_insert = "insert into " + tblStr2 + "(Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt,Updtby,updtdt) values('" + DRV_account + "'," + opendebit + "," + opencredit + ",'" + Drivercode + "','" + DRVloc + "','" + Entryby + "',getdate(),'" + Entryby + "',getdate())";
                    Response.Write("<BR>sql_insert-" + sql_insert);
                    cmd = new SqlCommand(sql_insert, conn, trans);
                    cmd.ExecuteNonQuery();
                }
            }


            string sql_ind = "select '" + DRV_account + "' as acccode, sum(a.opendebit) as opendebit_i ,sum(a.Opencredit)as opencredit_i  from " + tblStr2 + " a with (NOLOCK) ,WEBX_FLEET_DRIVERMST b  with (NOLOCK) where a.empcd=b.driver_id  and loccode='" + DRVloc + "' and acccode='" + DRV_account + "'";
            SqlCommand cmd_ind = new SqlCommand(sql_ind, conn, trans);
            SqlDataReader dr_ind;
            dr_ind = cmd_ind.ExecuteReader();
            if (dr_ind.Read())
            {
                Acccode = Convert.ToString(dr_ind["acccode"]);
                opendebit_i = Convert.ToDouble(dr_ind["opendebit_i"]);
                opencredit_i = Convert.ToDouble(dr_ind["opencredit_i"]);

                if (opendebit_i > opencredit_i)
                {
                    opendebit_i = opendebit_i - opencredit_i;
                    opencredit_i = 0;
                }
                else
                {
                    opencredit_i = opencredit_i - opendebit_i;
                    opendebit_i = 0;
                }


            }
            else
            {

            }
            dr_ind.Close();
            string sqlUpdate = "delete from  " + tblStr3 + "  where brcd='" + DRVloc + "' and acccode='" + DRV_account + "' ";
            SqlCommand cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();


            sqlUpdate = "Insert into  " + tblStr3 + " (opendebit,opencredit,finyear,acccode,brcd,opendebit_i,opencredit_i,FinStartDate,Entryby) values(0,0,'" + Session["Finyear"].ToString() + "','" + Acccode + "','" + DRVloc + "','" + opendebit_i + "','" + opencredit_i + "',NULL,'" + Entryby + "')  ";
            Response.Write("<BR>sqlUpdate-" + sqlUpdate);
            cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();

            trans.Commit();
            conn.Close();


            Response.Redirect("sel_brnch.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }
            else
            {
                trans.Rollback();
                conn.Close();
            }
            Response.End();
        }
    }
    protected void btnSubmit4_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            
            string EmpCode = "";
            foreach (GridViewRow gr in GV_Emp.Rows)
            {

                if (((CheckBox)gr.FindControl("Chkcust")).Checked == true)
                {
                    string opendebitstr = ((TextBox)gr.FindControl("TxtDebit")).Text.ToString();
                    string opencreditstr = ((TextBox)gr.FindControl("TxtCredit")).Text.ToString();
                    if (opendebitstr == "" || opendebitstr == null)
                    {
                        opendebitstr = "0.00";
                    }
                    if (opencreditstr == "" || opencreditstr == null)
                    {
                        opencreditstr = "0.00";
                    }
                    opendebit = Convert.ToDouble(opendebitstr);
                    opencredit = Convert.ToDouble(opencreditstr);
                    EmpCode = ((HiddenField)gr.FindControl("hnd_EmpCode")).Value;

                    string sql_insert = "delete from " + tblStr2 + " where Acccode='" + Emp_account + "' and Empcd='" + EmpCode + "' and Loccode='" + Emploc + "'";
                    SqlCommand cmd = new SqlCommand(sql_insert, conn, trans);
                    cmd.ExecuteNonQuery();

                    sql_insert = "insert into " + tblStr2 + "(Acccode,Opendebit,Opencredit,Empcd,Loccode,Entryby,Entrydt,Updtby,updtdt) values('" + Emp_account + "'," + opendebit + "," + opencredit + ",'" + EmpCode + "','" + Emploc + "','" + Entryby + "',getdate(),'" + Entryby + "',getdate())";
                    Response.Write("<BR>sql_insert-" + sql_insert);
                    cmd = new SqlCommand(sql_insert, conn, trans);
                    cmd.ExecuteNonQuery();
                }
            }


            string sql_ind = "select '" + Emp_account + "' as acccode, sum(a.opendebit) as opendebit_i ,sum(a.Opencredit)as opencredit_i  from " + tblStr2 + " a with (NOLOCK) ,WEBX_master_Users b  with (NOLOCK) where a.empcd=b.userid  and loccode='" + Emploc + "' and acccode='" + Emp_account + "'";
            SqlCommand cmd_ind = new SqlCommand(sql_ind, conn, trans);
            SqlDataReader dr_ind;
            dr_ind = cmd_ind.ExecuteReader();
            if (dr_ind.Read())
            {
                Acccode = Convert.ToString(dr_ind["acccode"]);
                opendebit_i = Convert.ToDouble(dr_ind["opendebit_i"]);
                opencredit_i = Convert.ToDouble(dr_ind["opencredit_i"]);

                if (opendebit_i > opencredit_i)
                {
                    opendebit_i = opendebit_i - opencredit_i;
                    opencredit_i = 0;
                }
                else
                {
                    opencredit_i = opencredit_i - opendebit_i;
                    opendebit_i = 0;
                }


            }
            else
            {

            }
            dr_ind.Close();
            string sqlUpdate = "delete from  " + tblStr3 + "  where brcd='" + Emploc + "' and acccode='" + Emp_account + "' ";
            SqlCommand cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();


            sqlUpdate = "Insert into  " + tblStr3 + " (opendebit,opencredit,finyear,acccode,brcd,opendebit_i,opencredit_i,FinStartDate,Entryby) values(0,0,'" + Session["Finyear"].ToString() + "','" + Acccode + "','" + Emploc + "','" + opendebit_i + "','" + opencredit_i + "',NULL,'" + Entryby + "')  ";
            Response.Write("<BR>sqlUpdate-" + sqlUpdate);
            cmdUpdate = new SqlCommand(sqlUpdate, conn, trans);
            cmdUpdate.ExecuteNonQuery();

            trans.Commit();
            conn.Close();
           // Response.End();

            Response.Redirect("sel_brnch.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }
            else
            {
                trans.Rollback();
                conn.Close();
            }
            Response.End();
        }
    }
}
