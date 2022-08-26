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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Journal_Voucher_JournalVoucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    public string Financial_Year = "", fin_year = "", opertitle = "MANUAL JOURNAL VOUCHER", Defaultdate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        lblpreparedby.Text = Session["empcd"].ToString() + " : " + fn.GetEmpName(Session["empcd"].ToString());
        lblpreparedfor.Text = Session["brcd"].ToString() + " : " + fn.GetLocation(Session["brcd"].ToString());
        
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Defaultdate = Request.QueryString["Defaultdate"];
        if (Defaultdate == "")
        {
            Defaultdate = "today";
        }
        if (!IsPostBack)
        {
            hdnroundoff.Value = "N";

            double count = 0;
            count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) FROM webx_modules_rules where Module_Name='Manual Vouchers' and RULE_DESC='Decimal Values Y/N'"));
            if (count > 0)
            {
                hdnroundoff.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N FROM webx_modules_rules where Module_Name='Manual Vouchers' and RULE_DESC='Decimal Values Y/N'").ToString();
            }

            //hdnroundoff.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N FROM webx_modules_rules where Module_Name='Manual Vouchers' and RULE_DESC='Decimal Values Y/N'").ToString();

            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();

            txtRows.Text = "5";

            if (Defaultdate != "today")
            {
                txtVoucherDate.Text = Defaultdate;
            }
            else
            {
                txtVoucherDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            Show_Pbov_list_Display();
        }
        txtManualNo.Attributes.Add("onblur", "Manualbillblur('" + txtManualNo.ClientID.ToString() + "')");
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'07','../../images/Date_Control_Rule_Check.aspx')");
    }
    public void Show_Pbov_list(object sender, EventArgs e)
    {
        Show_Pbov_list_Display();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }
    public void Show_Pbov_list_Display()
    {
        string sql_display_pbov = "";
        if (RAD_Customer.Checked == true)
        {
            sql_display_pbov = "select custcd as code , custnm+':'+custcd  as name from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0 order by CUSTNM ";
        }
        else if (RAD_Vendor.Checked == true)
        {
            sql_display_pbov = "select vendorCode as code , vendorname+':'+vendorCode as name from webx_VENDOR_HDR WITH(NOLOCK) where Active='Y' and vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) order by vendorname";
        }
        else if (RAD_Emp.Checked == true)
        {
            if (SessionUtilities.Client.CompareTo("Ritco") == 0)
                sql_display_pbov = "select userid as code ,name+':'+userid as name  from webx_master_users  WITH(NOLOCK) where status='100' and BranchCode='" + SessionUtilities.CurrentBranchCode + "' order by name";
            else
                sql_display_pbov = "select userid as code ,name+':'+userid as name  from webx_master_users  WITH(NOLOCK) where status='100' order by name,BranchCode";   
            //sql_display_pbov = "select  userid as code ,name+':'+userid as name  from webx_master_users  WITH(NOLOCK) where status='100' ";
        }
        else if (RAD_Driver.Checked == true)
        {
            sql_display_pbov = "select Driver_id as code ,Driver_Name + ':' + convert(varchar,Manual_Driver_Code) as name from webx_fleet_drivermst WITH(NOLOCK) where PATINDEx ('%" + Session["brcd"].ToString() + "%',Driver_Location)>0 and ActiveFlag='Y' order by Driver_Name,Driver_Location";
        }
        else if (RAD_Vehicle.Checked == true)
        {
            sql_display_pbov = "select Vehno as code ,Vehno as name from webx_vehicle_hdr WITH(NOLOCK) where PATINDEx ('%" + Session["brcd"].ToString() + "%',Conrtl_branch)>0 and ActiveFlag='Y' order by Vehno";
        }
        
        SqlCommand cmd_pbov = new SqlCommand(sql_display_pbov, con);
        SqlDataReader dr_pbov;
        dr_pbov = cmd_pbov.ExecuteReader();
        Dr_Pbov_list.Items.Clear();
        Dr_Pbov_list.CssClass = "blackfnt";
        Dr_Pbov_list.Items.Add(new ListItem("Select", ""));
        while (dr_pbov.Read())
        {
            Dr_Pbov_list.Items.Add(new ListItem(dr_pbov.GetValue(1).ToString(), dr_pbov.GetValue(0).ToString()));
        }
        dr_pbov.Close();
        Dr_Pbov_list.Items.ToString().ToUpper();
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {   
            ((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
            ((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Year = Session["FinYear"].ToString();
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        string Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year);
        string[] VDate = txtVoucherDate.Text.Split('/');
        string EntryBy = Session["empcd"].ToString(), Transtype = "Journal", OppaccountDesc = "", OppaccountCode = "", OppaccountDesc_mode = "", OppaccountCode_mode = "";
        string sql_Acccode = "";
        string VoucherDate = Convert.ToDateTime(VDate[1] + "/" + VDate[0] + "/" + VDate[2]).ToString("yyyy/MM/dd");
        
        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {
            string PBOV_code = "", PBOV_Name = "", PBOV_TYP = "";
            if (Dr_Pbov_list.SelectedValue == "")
            {
                PBOV_code = "8888";
                PBOV_Name = txtCode.Text;
            }
            else
            {
                PBOV_code = Dr_Pbov_list.SelectedValue.ToString();
                string[] PBOV_Name_arr = Dr_Pbov_list.SelectedItem.Text.ToString().Split(':');
                PBOV_Name = PBOV_Name_arr[0].ToString();
            }
            
            if (RAD_Customer.Checked)
                PBOV_TYP = "P";
            else if (RAD_Vendor.Checked)
                PBOV_TYP = "V";
            else if (RAD_Emp.Checked)
                PBOV_TYP = "E";
            else if (RAD_Driver.Checked)
                PBOV_TYP = "D";
            else if (RAD_Vehicle.Checked)
                PBOV_TYP = "L";

            int i = 0;
            
            string sql_Acctrans = "", Acccode = "", Debit = "", Credit = "", Narration = "", Description = "";
            string Narration1 = "";
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((TextBox)gridrow.FindControl("txtAccCode")).Text.ToString();
                Description = ((TextBox)gridrow.FindControl("txtDescription")).Text.ToString();
                Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.ToString();
                i = i + 1;
                if (Acccode != "")
                 {
                     if (((HtmlInputRadioButton)gridrow.FindControl("rad_Particular")).Checked)
                     {
                         OppaccountCode = Acccode;
                         OppaccountDesc = Description;
                     }
                 }
                 
            }
            i = 0;
            double totDebit = 0;
            string debitamt, creditamt;
            decimal sumdebitamt = 0;
            decimal sumcreditamt = 0;
            
            string totDebitamt = ((TextBox)grvcontrols.FooterRow.FindControl("txtTotDebitAmt")).Text.ToString();
            string totCreditamt = ((TextBox)grvcontrols.FooterRow.FindControl("txtTotCreditAmt")).Text.ToString();

            double totalDebit = Convert.ToDouble(totDebitamt);
            double totalCredit = Convert.ToDouble(totCreditamt);

            if (totalDebit == totalCredit)
            {
                if (totalDebit == 0)
                    throw new Exception("Total Amount Should Be Greater Than Zero");
                else
                {
                    foreach (GridViewRow gridrow in grvcontrols.Rows)
                    {
                        debitamt = ((TextBox)gridrow.FindControl("txtDebitAmt")).Text.ToString();
                        creditamt = ((TextBox)gridrow.FindControl("txtCreditAmt")).Text.ToString();

                        sumdebitamt = sumdebitamt + Convert.ToDecimal(debitamt);
                        sumcreditamt = sumcreditamt + Convert.ToDecimal(creditamt);
                    }
                    if (sumdebitamt != sumcreditamt)
                    {
                        throw new Exception("Total Debit and Credit Amount Should Be Equal");
                    }
                }
            }

            if (totalDebit != totalCredit)
                throw new Exception("Total Debit Amount Should Be Equal to Total Credit Amount");

            string Xml_Acccode_Details = "<root>";

            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((TextBox)gridrow.FindControl("txtAccCode")).Text.ToString();
                Debit = ((TextBox)gridrow.FindControl("txtDebitAmt")).Text.ToString();
                Credit = ((TextBox)gridrow.FindControl("txtCreditAmt")).Text.ToString();
                Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.ToString();
                Description = ((TextBox)gridrow.FindControl("txtDescription")).Text.ToString();

                i = i + 1;
                totDebit=Convert.ToDouble(Debit)+totDebit;
                if (Acccode != "")
                {
                    sql_Acccode = "select Acccode,accdesc from webx_acctinfo WITH(NOLOCK) where Company_Acccode='" + Acccode + "'";
                    cmd = new SqlCommand(sql_Acccode, con, trans);
                    SqlDataReader dr;
                    dr = cmd.ExecuteReader();
                    string Accdesc = "";
                    while (dr.Read())
                    {
                        Acccode = dr["Acccode"].ToString().Trim();
                        Accdesc = dr["accdesc"].ToString().Trim();
                    }
                    dr.Close();

                    Xml_Acccode_Details = Xml_Acccode_Details + "<Acccode>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<Acccode>" + Acccode.Trim() + "</Acccode>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<Accdesc>" + Accdesc.Trim() + "</Accdesc>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<Debit>" + Debit.Trim() + "</Debit>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<Credit>" + Credit.Trim() + "</Credit>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<Narration>" + Narration.Trim() + "</Narration>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<PartyCode></PartyCode>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "<PartyName></PartyName>";
                    Xml_Acccode_Details = Xml_Acccode_Details + "</Acccode>";
                }
            }

            Xml_Acccode_Details = Xml_Acccode_Details + "</root>";

            string Xml_Other_Details = "<root><Other>";
            Xml_Other_Details = Xml_Other_Details + "<Finyear>" + Year.Trim() + "</Finyear>";
            Xml_Other_Details = Xml_Other_Details + "<Transdate>" + fn.Mydate1(txtVoucherDate.Text.Trim()).Trim() + "</Transdate>";
            Xml_Other_Details = Xml_Other_Details + "<Transtype>Journal</Transtype>";
            Xml_Other_Details = Xml_Other_Details + "<Voucherno>" + Voucherno.Trim() + "</Voucherno>";
            Xml_Other_Details = Xml_Other_Details + "<Brcd>" + Session["brcd"].ToString().Trim() + "</Brcd>";
            Xml_Other_Details = Xml_Other_Details + "<Entryby>" + Session["empcd"].ToString().Trim() + "</Entryby>";
            Xml_Other_Details = Xml_Other_Details + "<Opertitle>" + "MANUAL JOURNAL VOUCHER" + "</Opertitle>";
            Xml_Other_Details = Xml_Other_Details + "<ManualNo>" + txtManualNo.Text.Trim() + "</ManualNo>";
            Xml_Other_Details = Xml_Other_Details + "<preparefor>" + txtPreparedFor.Text.Trim() + "</preparefor>";
            Xml_Other_Details = Xml_Other_Details + "<Refno>" + txtRefNo.Text.Trim() + "</Refno>";
            Xml_Other_Details = Xml_Other_Details + "<Narration>" + txtNarration.Text.Trim() + "</Narration>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_code>" + PBOV_code.Trim() + "</pbov_code>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_name>" + PBOV_Name.Trim() + "</pbov_name>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_typ>" + PBOV_TYP.Trim() + "</pbov_typ>";
            Xml_Other_Details = Xml_Other_Details + "<OppAccount>" + OppaccountCode.Trim() + "</OppAccount>";
            Xml_Other_Details = Xml_Other_Details + "<Jv_Type>Normal JV</Jv_Type>";
            Xml_Other_Details = Xml_Other_Details + "</Other></root>";


            string sql = "usp_Generate_ManualJVAccountDetails_Ver2";
            cmd = new SqlCommand(sql, con, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Xml_Acccode_Details", SqlDbType.Text).Value = Xml_Acccode_Details.Replace("&", "&amp;").Trim();
            cmd.Parameters.Add("@Xml_Other_Details", SqlDbType.Text).Value = Xml_Other_Details.Replace("&", "&amp;").Trim();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();

            double LedgerDiff = 0;
            sql_Acctrans = "select sum(debit) - sum(credit) as Differance from webx_acctrans_" + fin_year + " where voucher_cancel='N' and voucherno='" + Voucherno + "'";
            cmd = new SqlCommand(sql_Acctrans, con, trans);
            SqlDataReader dr_count = cmd.ExecuteReader();
            while (dr_count.Read())
            {
                LedgerDiff = Convert.ToDouble(dr_count["Differance"].ToString().Trim());
            }
            dr_count.Close();

            if (LedgerDiff != 0)
            {
                throw new Exception("Error : Debit Amount Not Equal To Credit Amount");
            }
            else
            {
                trans.Commit();
            }

            //trans.Commit();
            con.Close();
            //Response.Redirect("./voucher_Done.aspx?VoucherType=Journal&VoucherNo=" + Voucherno + "&Defaultdate=" + txtVoucherDate.Text, false);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            msg = msg.Replace('\r', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }
        Response.Redirect("./voucher_Done.aspx?VoucherType=Journal&VoucherNo=" + Voucherno + "&Defaultdate=" + txtVoucherDate.Text, false);         
    }    
}
