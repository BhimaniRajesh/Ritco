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

public partial class GUI_Finance_Accounts_Debit_Voucher_DebitVoucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    public string newdate = "";
    public static string  Defaultdate="";
    protected void Page_Load(object sender, EventArgs e)
    {

        newdate = Convert.ToString(Request.QueryString["Vdate"]);
        
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        Defaultdate = Request.QueryString["Defaultdate"];
        if (Defaultdate == "")
        {
            Defaultdate = "today";
        }
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
            FillBusDiv();
            if (Defaultdate != "today")
            {
                txtVoucherDate.Text = Defaultdate;
            }
            else
            {
                txtVoucherDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
           // txtVoucherDate.Text=System.DateTime.Now.ToString("dd/MM/yyyy");
            txtVoucherDate.CssClass = "blackfnt";

            string sql = "select acccode,accdesc from webx_acctinfo where accdesc like '%tds%'";
            SqlCommand cmd1 = new SqlCommand(sql, con);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            while (dr.Read())
            {
                Tdssection.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            Tdssection.CssClass = "blackfnt";
            txtPreparedLoc.Text = Session["brcd"].ToString();
            txtAccLoc.Text = Session["brcd"].ToString();
            txtPreparedBy.Text = Session["empcd"].ToString();
            Show_Pbov_list_Display();
              
        }
        btnPreparedLoc.Attributes.Add("onclick", "popuplist('Location','" + txtPreparedLoc.ClientID.ToString() + "','none')");

        txtPreparedLoc.Attributes.Add("onblur", "LocBlur('" + txtPreparedLoc.ClientID.ToString() + "')");
        txtAccLoc.Attributes.Add("onblur", "LocBlur('" + txtAccLoc.ClientID.ToString() + "')");
        //  .Attributes.Add("onblur", "PaidBlur('" + txtPaidTo.ClientID.ToString() + "')");
        txtManualNo.Attributes.Add("onblur", "Manualbillblur('" + txtManualNo.ClientID.ToString() + "')");

        btnAccLoc.Attributes.Add("onclick", "popuplist('AccLoc','" + txtAccLoc.ClientID.ToString() + "','none')");
        //txtAccLoc.Attributes.Add("onblur", "AccBlur('" + txtAccLoc.ClientID.ToString() + "')");
        txtServiceTax.Attributes.Add("onblur", "GetTot()");
        txtEduCess.Attributes.Add("onblur", "GetTot()");
        txtHEduCess.Attributes.Add("onblur", "GetTot()");
        txtTDSRate.Attributes.Add("onblur", "GetTot()");
        txtSrvTaxNo.Attributes.Add("onchange", "CheckTax()");
        txtPanNo.Attributes.Add("onchange", "CheckPan(this)");
        txtCashAmt.Attributes.Add("onblur", " CheckCashBank()");
        txtChqAmt.Attributes.Add("onblur", " CheckCashBank()");

        
        
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
            sql_display_pbov = "select  userid as code ,name+':'+userid as name  from webx_master_users  WITH(NOLOCK) where status='100' ";
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

        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }
    private void FillBusDiv()
    {
        string strSql = "Select top 1 '-1' as CodeId ,'--Select One--' as CodeDesc Union select CodeId,CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y'";
        cmd = new SqlCommand(strSql, con);
        
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            ddlBusinessDiv.Items.Add(new ListItem(dr.GetValue(1).ToString(),dr.GetValue(0).ToString()));
        }
        dr.Close();
        ddlBusinessDiv.SelectedIndex = 1;
        ddlBusinessDiv.CssClass = "blackfnt";
    }

    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
            ((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
            //((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot('" + ((TextBox)e.Row.FindControl("txtAmt")).ClientID.ToString() + "','" + ((TextBox)e.Row.FindControl("txtTotAmt")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot()");
        }   
    }
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            txtCashAmt.Text = txtNetPay.Text;
            txtCashAmt.Enabled = false;
            ddrCashcode.Enabled = true;

            txtChqAmt.Enabled = false;
            txtChqNo.Enabled = false;
            txtChqAmt.Text = "0.00";
            txtChqNo.Text = "";
            //txtBank.Enabled = false;
            txtChqAmt.Text = "";
            txtChqNo.Text = "";

            ddrBankaccode.SelectedValue = "";
            ddrBankaccode.Enabled = false;
            txtChqDate.Text = "";
            txtChqDate.Enabled = false;

            ddrCashcode.Items.Clear();
            string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
        }
        else if (ddlPayMode.SelectedItem.Text == "Bank")
        {
            txtCashAmt.Enabled = false;
            txtCashAmt.Text = "0.00";
            ddrCashcode.SelectedValue = "";
            ddrCashcode.Enabled = false;

            txtChqAmt.Enabled = false;
            txtChqNo.Enabled = true;
            //txtBank.Enabled = true;
            txtChqAmt.Text = txtNetPay.Text;

            txtCashAmt.Text = "";

            ddrBankaccode.Enabled = true;
            txtChqDate.Enabled = true;

            ddrBankaccode.Items.Clear();

            string strSql = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.CssClass = "blackfnt";

        }
        else if (ddlPayMode.SelectedItem.Text == "Both")
        {
            txtCashAmt.Enabled = true;
            txtChqAmt.Enabled = true;
            txtChqNo.Enabled = true;
            txtChqDate.Enabled = true;
            ddrBankaccode.Enabled = true;
            ddrCashcode.Enabled = true;

            ddrCashcode.Items.Clear();
            string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.Items.Clear();
            string strSql1 = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql1, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
            ddrBankaccode.CssClass = "blackfnt";
            //txtBank.Enabled = true;
        }
    }
    protected void txtAmtApplL_TextChanged(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Year = Session["FinYear"].ToString();
        string opertitle = "MANUAL CREDIT VOUCHER";
        string Financial_Year = Session["FinYear"].ToString();
        string Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year.Substring(2,2));
        string[] VDate = txtVoucherDate.Text.Split('/');
        string EntryBy = Session["empcd"].ToString(), Transtype = "", OppaccountDesc = "", OppaccountCode = "";
        string sql_Acccode = "";
        string VoucherDate = Convert.ToDateTime(VDate[1] + "/" + VDate[0] + "/" + VDate[2]).ToString("yyyy/MM/dd");
        string finyear = Session["FinYear"].ToString();
        string[] CDate;
        string ChqDate, Chqno = "", Str_Onaccount="N";
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            ChqDate = "NULL";
            Chqno = "NULL";//txtChqNo.Text
            txtChqAmt.Text = "0";
            txtChqNo.Text = "0";
            Transtype = "CASH RECEIPT";
            OppaccountDesc = "";
            OppaccountCode = "CAS0002";
        }
        else
        {
            Chqno = "'" + txtChqNo.Text + "'";
            CDate = txtChqDate.Text.Split('/');
            ChqDate = Convert.ToDateTime(CDate[1] + "/" + CDate[0] + "/" + CDate[2]).ToString("yyyy/MM/dd");
            ChqDate = "'" + ChqDate + "'";
            Transtype = "BANK RECEIPT";
            OppaccountDesc = "";
            OppaccountCode = "ACA0002";
            if (rdDiposited.SelectedItem.Text == "Yes")
            {
                OppaccountCode=ddrBankaccode.SelectedValue.ToString();
            }        
        }

        if (ddlPayMode.SelectedItem.Text == "BOTH")
        {
            Transtype = "Both RECEIPT";
        }
        double adjustamt = Convert.ToDouble(txtChqAmt.Text);
        if (Onaccount.Checked)
        {
            Str_Onaccount = "Y";
            adjustamt = 0;
        }
        if (txtServiceTax.Text == "")
        {
            txtServiceTax.Text = "0.00";
        }
        if (txtEduCess.Text == "")
        {
            txtEduCess.Text = "0.00";
        }
        if (txtHEduCess.Text == "")
        {
            txtHEduCess.Text = "0.00";
        }
        if (txtTDSRate.Text == "")
        {
            txtTDSRate.Text = "0";
        }



        SqlTransaction trans;
        trans = con.BeginTransaction();
       try
        {
            string PBOV_code = "", PBOV_Name = "", PBOV_typ = "";
            if (Dr_Pbov_list.SelectedValue == "")
            {
                PBOV_code = "8888";
                PBOV_Name = txtCode.Text;
            }
            else
            {
                // string[] PBOV_code_arr = txtPaidTo.Text.Split('~');
                PBOV_code = Dr_Pbov_list.SelectedValue.ToString();
                PBOV_Name = Dr_Pbov_list.SelectedItem.Text.ToString();
            }
            //PBOV_Name = txtCode.Text;
            PBOV_typ = "P";

            string strSql = "insert into webx_vouchertrans_arch(Voucherno,Transdate,Manual_Voucherno,Brcd,Entryby,Business_type,Accounting_Brcd,preparefor,Refno,Pbov_code,pbov_name,Narration,";
            strSql += "servicetax,othertax,H_edu_cess,servicetaxNo,tdsacccode,tdsrate,tds,Panno,";
            strSql += "Transmode,CHQAMT,chqno,Acccode,bankname,Chqdate,Netamt,Debit,Credit,";
            strSql += "voucher_cancel,finyear,srno,Transtype,Entrydt)";
            strSql += "values('" + Voucherno + "','" + VoucherDate + "','" + txtManualNo.Text + "','" + txtPreparedLoc.Text + "','" + txtPreparedBy.Text + "','" + ddlBusinessDiv.SelectedValue + "','" + txtAccLoc.Text + "','" + txtPreparedFor.Text + "','" + txtReferenceNo.Text + "','" + PBOV_code + "','" + txtCode.Text + "','" + txtNarration.Text + "',";
            strSql += "" + txtServiceTax.Text + "," + txtEduCess.Text + "," + txtHEduCess.Text + ", '" + txtSrvTaxNo.Text + "',''," + txtTDSRate.Text + "," + txtTDSAmt.Text + ",'" + txtPanNo.Text + "',";
            strSql += "'" + ddlPayMode.SelectedItem.Text + "'," + txtChqAmt.Text + ",'" + txtChqNo.Text + "','',''," + ChqDate + "," + txtNetPay.Text + ",0," + txtNetPay.Text + ",";
            strSql += "'N'," + Financial_Year + ",100,'" + Transtype + "',getdate())";
            cmd = new SqlCommand(strSql, con, trans);
            cmd.ExecuteNonQuery();

            string sql_Acctrans = "", Acccode = "", Debit = "", Credit = "", Narration = "", Description = "";

            if (ddlPayMode.SelectedItem.Text != "Cash")
            {
                string sql_chk = "select chqamt,adjustamt,banknm from webx_chq_det where chqno=" + Chqno + " and convert(varchar,chqdt,106)=convert(datetime,'" + fn.Mydate1(txtChqDate.Text) + "',106)";
                SqlCommand cmd_chk = new SqlCommand(sql_chk, con, trans);
                SqlDataReader dr_chk = null;
                // conn.Open();
                dr_chk = cmd_chk.ExecuteReader();
                string chque_yn_chk = "N";
                if (dr_chk.Read())
                {
                    chque_yn_chk = "Y";
                }
                dr_chk.Close();
                //    conn.Close();
                if (chque_yn_chk == "Y")
                {
                    Response.Write("<br><br><br><font class='blackboldfnt' color='red' ><B>Error : Duplicate Cheque Entered </b></font>");
                    trans.Rollback();
                    // Response.Redirect("Message.aspx?" + e1.Message);
                    Response.End();

                }
            }
            if (ddlPayMode.SelectedItem.Text != "Cash")
            {
                strSql = "insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,adjustamt,bankbrn,chq_trf,Onaccount_YN) values(" + Chqno + ",'" + fn.Mydate1(txtChqDate.Text) + "'," + txtChqAmt.Text + ",'" + txtRecBank.Text.ToString() + "','" + PBOV_code + "','" + PBOV_Name + "','','','','','','" + Session["brcd"].ToString() + "','" + fn.GetLocation(Session["brcd"].ToString()) + "','',''," + adjustamt + ",'" + fn.GetLocation(Session["brcd"].ToString()) + "','" + Session["brcd"].ToString() + "','" + Str_Onaccount + "')";
                cmd = new SqlCommand(strSql, con, trans);
                cmd.ExecuteNonQuery();
                if (rdDiposited.SelectedItem.Text == "Yes")
                {
                    strSql = "update webx_chq_det set banknm='" + ddrBankaccode.SelectedItem.Text.ToString() + "',voucherNo='" + Voucherno + "',transdate='" + VoucherDate + "',acccode='" + OppaccountCode + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where Chqno=" + Chqno + " and convert(varchar,chqdt,106)=convert(datetime,'" + fn.Mydate1(txtChqDate.Text) + "',106)";
                    cmd = new SqlCommand(strSql, con, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((TextBox)gridrow.FindControl("txtAccCode")).Text.ToString();


                Credit = ((TextBox)gridrow.FindControl("txtAmt")).Text.ToString();
                Debit = "0.00";
                Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.ToString().Replace("'", "''");
                Description = ((TextBox)gridrow.FindControl("txtDescription")).Text.ToString().Replace("'", "''");
                if (Acccode != "")
                {
                    sql_Acccode = "select Acccode,accdesc from webx_acctinfo WITH(NOLOCK) where Company_Acccode='" + Acccode + "'";
                    cmd = new SqlCommand(sql_Acccode, con, trans);

                    dr = cmd.ExecuteReader();
                    string Accdesc = "";
                    while (dr.Read())
                    {
                        Acccode = dr["Acccode"].ToString().Trim();
                        Accdesc = dr["Accdesc"].ToString().Trim();
                    }
                    dr.Close();

                    if (Str_Onaccount == "Y" && Acccode!="CDA0001")
                    {
                        Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : On Account Cheque Facility is not Availble for :" + Accdesc + "</b></font></center>");
                        //string msg = e1.Message.ToString();
                        //msg = msg.Replace('\n', ' ');
                        trans.Rollback();
                        //Response.Redirect("Message.aspx?" + e1.Message);
                        Response.End();
                    }
                    sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            sql_Acccode = "select Acccode from webx_acctinfo WITH(NOLOCK) where Acccode='" + OppaccountCode + "'";
            cmd = new SqlCommand(sql_Acccode, con, trans);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                OppaccountCode = dr["Acccode"].ToString().Trim();
            }
            dr.Close();
            Narration = txtNarration.Text;
            OppaccountDesc = "";




            if (Convert.ToDouble(txtServiceTax.Text) > 0)
            {
                Credit = txtServiceTax.Text.ToString();
                Debit = "0.00";
                Acccode = "CLO0023";
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtEduCess.Text) > 0)
            {
                Credit = txtEduCess.Text.ToString();
                Debit = "0.00";
                Acccode = "LCS0001";
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtHEduCess.Text) > 0)
            {
                Credit = txtHEduCess.Text.ToString();
                Debit = "0.00";
                Acccode = "LCS0002";
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtTDSAmt.Text) > 0)
            {
                Debit = txtTDSAmt.Text.ToString();
                Credit = "0.00";
                Acccode = Tdssection.SelectedValue.ToString();
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

            }

            if (ddlPayMode.SelectedItem.Text != "Both")
            {
                Debit = txtNetPay.Text.ToString();
                Credit = "0.00";
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();
            }
            else
            {
                Debit = txtCashAmt.Text.ToString();
                Credit = "0.00";
                OppaccountCode = "CAS0002";
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "',Null,Null,'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

                Debit = txtChqAmt.Text.ToString();
                Credit = "0.00";
                OppaccountCode = "ACA0002";
                if (rdDiposited.SelectedItem.Text == "Yes")
                {
                    OppaccountCode = ddrBankaccode.SelectedValue.ToString();
                }
                sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "'," + Chqno + "," + ChqDate + ",'" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'','" + txtAccLoc.Text + "','','','" + EntryBy + "','','N','N','',null,Null,Null,Null,Null,'','','" + PBOV_code + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();
            }

            trans.Commit();
            con.Close();
            Response.Redirect("./voucher_Done.aspx?VoucherType=Credit&VoucherNo=" + Voucherno + "&Defaultdate=" + txtVoucherDate.Text, false);

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

        //lblMsg.Text = "Insert Successfully";
        //Response.Redirect("InsertDone.aspx?VoucherDate="+ VoucherDate);
    }
    
}
