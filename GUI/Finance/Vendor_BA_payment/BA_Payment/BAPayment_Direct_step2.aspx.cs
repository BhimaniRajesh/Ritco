using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


public partial class GUI_Finance_VendorPayment_new_BA_Payment_BAPayment_Direct_step2 : System.Web.UI.Page
{
    public static string VendorCode = "",dkt_call="",  sql_minmax, abc,Year, str_PAN_NO,RouteMode="", str_SERVTAXNO, YearString, CloseYear, errMsg = "", yearSuffix, AcctOpenTable, AcctTable, mAcctTransTable, finyearstart, mHeadOfficeCode, brcd, empcd, VendorCodeName = "", RptTyp = "", strDateRange;
    SqlConnection conn;
    double minchrg = 0, maxchrg = 0;


    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        dkt_call = Session["DocketCalledAs"].ToString();
            String Year = Session["FinYear"].ToString();
            brcd = Session["brcd"].ToString();
             abc = Year.Substring(2, 2);
            //Response.Write("<br>Year " + Year);
           // Response.Write("<br>Year " + abc);
             //Response.End();
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            finyearstart = "01 APR " + abc;
            Year = abc;
            mAcctTransTable = "webx_acctrans_" + yearSuffix;
            AcctOpenTable = "WEBX_acctopening_" + yearSuffix;
            AcctTable = "webx_acctinfo";

            strDateRange = Request.QueryString["DOCDate"].ToString();
            VendorCode = Request.QueryString["Vendcd"].ToString();
            RptTyp = Request.QueryString["DocType"].ToString();
            RouteMode = Request.QueryString["RouteMode"].ToString();
            lblDockDt.Text = strDateRange;
            String sqlstr = "select vendorcode+' : '+ vendorname,isnull(PAN_NO,'') as PAN_NO,isnull(SERVTAXNO,'') as SERVTAXNO from webx_vendor_hdr where vendorcode='" + VendorCode + "'";
            // Response.Write("<br> sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            
            empcd = Session["empcd"].ToString();
            transdate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            dread.Read();


            str_PAN_NO = Convert.ToString(dread.GetValue(1).ToString());
            str_SERVTAXNO = Convert.ToString(dread.GetValue(2).ToString());
            VendorCodeName = Convert.ToString(dread.GetValue(0).ToString());
            lblVend.Text = VendorCodeName;
            lblTyp.Text = Request.QueryString["str_DocType"].ToString();
            dread.Close();
           

            
            if( RptTyp.ToUpper()=="DLY" )
            {
                sql_minmax = "select slabfrom=isnull(slabfrom,0),slabto=isnull(slabto,0),slabrate=isnull(slabrate,0),chargeType,vehtype=isnull(vehtype,0),vendorCode from webx_vendor_contract_charges where matrixcode='6' and  chargetype = 'Fixed' and VendorCode='" + VendorCode + "'";
            }
            else
            {
                sql_minmax = "select slabfrom=isnull(slabfrom,0),slabto=isnull(slabto,0),slabrate=isnull(slabrate,0),chargeType,vehtype=isnull(vehtype,0),vendorCode from webx_vendor_contract_charges where matrixcode='7' and  chargetype = 'Fixed' and VendorCode='" + VendorCode + "'";
            }


            SqlCommand cmd_minmax = new SqlCommand(sql_minmax, conn);
            SqlDataReader dread_minmax = cmd_minmax.ExecuteReader();
            while (dread_minmax.Read())
            {
                minchrg = Convert.ToDouble(dread_minmax["slabfrom"]);
                maxchrg = Convert.ToDouble(dread_minmax["slabto"]);
            }

            dread_minmax.Close();

           
                if (!IsPostBack)
                {
                    String SQL_TDSACC = "select acccode,accdesc from webx_acctinfo where acccode ='CLA0015'";
                    tdsacccode.Items.Clear();
                    tdsacccode.Items.Add(new ListItem("-- Select --", ""));
                    SqlCommand cmd1 = new SqlCommand(SQL_TDSACC, conn);
                    SqlDataReader dread1 = cmd1.ExecuteReader();
                    {

                        while (dread1.Read())
                        {
                            tdsacccode.Items.Add(new ListItem(dread1.GetValue(1).ToString(), dread1.GetValue(0).ToString()));

                        }

                    }
                    dread1.Close();
                    BindGrid();
                }

      

        conn.Close();
    }
    public void BindGrid()
    {
        string[] strDateRange_arr=strDateRange.Split('-');
        String fromdt=strDateRange_arr[0].ToString().Trim();
         String tomdt=strDateRange_arr[1].ToString().Trim();

         String SQL_grid = "exec webx_bapayment_DirectPayment '" + fromdt + "','" + tomdt + "','" + VendorCode + "','" + RptTyp + "','" + brcd + "','" + RouteMode + "'";

        //Response.Write("<br> SQL_grid : "+SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        //dgDocket.AllowPaging = false;
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
       
            dgDocket.PageIndex = e.NewPageIndex;
        
        BindGrid();

    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
           /// Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

            dkt_colname.Text = dkt_call + " No.";
            ///lblColDockdt.Text = dkt_call + " Date";
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldockno = (Label)e.Row.FindControl("lbldockno");
            string MDockets = lbldockno.Text.ToString();
            Label MR_BILL_Status = (Label)e.Row.FindControl("lblMR_BILL_Status");
            string MR_BILL_Status1 = MR_BILL_Status.Text.ToString();
           // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
           // conn.Open();



           // string SQL_status = "exec usp_bapayment_validdkt '" + MDockets + "'";
           // SqlCommand sqlcmd21 = new SqlCommand(SQL_status, conn);
           // SqlDataReader dr21;
           // dr21 = sqlcmd21.ExecuteReader();

           // String status_doc = "", attech_doc = "", ded="";
           //// double ded = 0;
           // while (dr21.Read())
           // {
           //     status_doc =dr21.GetValue(1).ToString();// dr21["OP_status"].ToString();
           //     attech_doc = dr21.GetValue(0).ToString();
           //     ded = dr21.GetValue(3).ToString();

           //     if (ded == "")
           //     {
           //         ded = "0";
           //     }
           // }
           // dr21.Close();


            if (MR_BILL_Status1 == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.White;
            }
            else
            {
                e.Row.Cells[0].Enabled = false;
                e.Row.BackColor = System.Drawing.Color.LightGray;
            }
          
            //e.Row.Cells[9].Text = status_doc;
            //e.Row.Cells[9].HorizontalAlign = HorizontalAlign.Center;
            //e.Row.Cells[10].Text = attech_doc;
            //e.Row.Cells[10].HorizontalAlign = HorizontalAlign.Center;
            //e.Row.Cells[21].Text = ded;
            //e.Row.Cells[21].HorizontalAlign = HorizontalAlign.Center;

            //String SQL_status1 = "", vehtype = "";
            //String trn = e.Row.Cells[11].Text.ToString();
            //String Pay = e.Row.Cells[12].Text.ToString();

            //Label lbldely_door_yn = (Label)e.Row.FindControl("lbldely_door_yn");
            //Label lbldely_godown_yn = (Label)e.Row.FindControl("lbldely_godown_yn");
            //string dely_door_yn = lbldely_door_yn.Text.ToString();
            //string dely_godown_yn = lbldely_godown_yn.Text.ToString();
            //String chargeType = "";

            //Label lblPaybas = (Label)e.Row.FindControl("lblPaybas");
            //Label lbltrnmod = (Label)e.Row.FindControl("lbltrnmod");

            //trn = lbltrnmod.Text.ToString();
            //Pay = lblPaybas.Text.ToString();

            //double slabrate = 0, MinVal = 0, actuwt = 0, Subtot = 0, MaxVal = 0, slabfrom = 0, slabto = 0, commission = 0, fin_commission = 0;
            //actuwt=Convert.ToDouble(e.Row.Cells[16].Text.ToString());
            //Subtot = Convert.ToDouble(e.Row.Cells[17].Text.ToString());
            //if (RptTyp.ToUpper() == "DLY")
            //{
            //    SQL_status1 = "exec webx_vendor_contract_drs_commCalc '" + trn + "','" + VendorCode + "','" + Pay + "'";
            //    SqlCommand sqlcmd22 = new SqlCommand(SQL_status1, conn);
            //    SqlDataReader dr22;
            //    dr22 = sqlcmd22.ExecuteReader();
              

            //    while (dr22.Read())
            //    {
            //        chargeType = dr22["chargeType"].ToString();
            //        vehtype = dr22["vehtype"].ToString();
            //        slabfrom = Convert.ToDouble(dr22["slabfrom"]);
            //        slabto = Convert.ToDouble(dr22["slabto"]);

            //        if (chargeType == "Fixed")
            //        {
            //            MinVal = slabfrom;
            //            MaxVal = slabto;
            //        }
            //        else
            //        {
            //            if (dely_door_yn == "Y" && vehtype == "1")
            //            {
            //                slabrate = Convert.ToDouble(dr22["slabrate"]);
            //            }
            //            if (dely_godown_yn == "Y" && vehtype == "2")
            //            {
            //                slabrate = Convert.ToDouble(dr22["slabrate"]);
            //            }

            //        }
            //    }
               


                
            //    commission = actuwt * slabrate;

            //    commission = Math.Round(commission, 2);
            //    if (commission < MinVal)
            //    {
            //        commission = MinVal;
            //    }
            //    else if (commission > MaxVal)
            //    {
            //        commission = MaxVal;
            //    }
            //    dr22.Close();

            //}
            //else
            //{
            //    SQL_status1 = "exec webx_vendor_contract_prs_commCalc '" + trn + "','" + VendorCode + "','" + Pay + "','" + Subtot + "'";

            //    commission=0;
            //    SqlCommand sqlcmd23 = new SqlCommand(SQL_status1, conn);
            //    SqlDataReader dr23;
            //    dr23 = sqlcmd23.ExecuteReader();


            //    while (dr23.Read())
            //    {
            //        slabrate = Convert.ToDouble(dr23["slabrate"]);

            //    }
            //    dr23.Close();
            //    commission = Subtot * slabrate / 100;
            //    commission = Math.Round(commission, 2);

            //    if (commission < minchrg)
            //    {
            //        commission = minchrg;
            //    }
            //    else if (commission > maxchrg)
            //    {
            //        commission = maxchrg;
            //    }
            //}



            //((Label)e.Row.FindControl("lblcommision")).Text = commission.ToString("F2");
            //((Label)e.Row.FindControl("lblslabrate")).Text = slabrate.ToString("F2");
            

            //e.Row.Cells[22].Text = slabrate.ToString("F2");
            //e.Row.Cells[22].HorizontalAlign = HorizontalAlign.Center;
            //e.Row.Cells[23].Text = commission.ToString("F2");
            //e.Row.Cells[23].HorizontalAlign = HorizontalAlign.Center;

            //HiddenField hdn = ((HiddenField)(e.Row.FindControl("hdncomm")));
            //hdn.Value = commission.ToString("F2");
        }

    }

    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
         conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
       
        if (cboModeOfTransaction.SelectedValue.ToString() != "")
        { 
            

            string sql = "";

            if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
            {
                sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where   (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK'))   order by accdesc asc";
            }
            else
            {
                sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            cboPaymentAccount.DataSource = ds;
            cboPaymentAccount.DataTextField = "accdesc";
            cboPaymentAccount.DataValueField = "asscodeval";
            cboPaymentAccount.DataBind();
            cboPaymentAccount.CssClass = "blackfnt";
        }
    }

    private void PopPaymentAcc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK'))  order by accdesc asc";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds, "tab1");

        cboPaymentAccount.DataSource = ds;
        cboPaymentAccount.DataTextField = "accdesc";
        cboPaymentAccount.DataValueField = "asscodeval";
        cboPaymentAccount.DataBind();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        double othChrg = Convert.ToDouble(oth_amt.Text);
        double DEDUCTION = Convert.ToDouble(oth_ded.Text);
        string transdate1 = transdate.Text.ToString();
        double servicetaxrate = Convert.ToDouble(svtax_rate.Text);
        double servicetax = Convert.ToDouble(svrcamt.Text);
        double othertax = Convert.ToDouble(cessamt.Text);
        double tdsrate = Convert.ToDouble(tds_rate.Text);
        double tds = Convert.ToDouble(tds_chrg.Text);
        string tdsacccode1 = tdsacccode.SelectedValue.ToString();
        string tdsfor1 = tdsfor.SelectedValue.ToString();
        double TotalNetpayable1 = Convert.ToDouble(TotalNetpayable.Text);
        string PayMode = cboModeOfTransaction.SelectedValue.ToString();
        double appramt = 0;
        if (PayMode == "Cheque")
        {
            if (txtPaymentAmt.Text.ToString() != "")
            {
                appramt = Convert.ToDouble(txtPaymentAmt.Text);
            }
            else
            {
                appramt = 0;
            }
        }
        else if (PayMode == "Cash")
        {
            if (txtCashAmount.Text.ToString() != "")
            {
                appramt = Convert.ToDouble(txtCashAmount.Text);
            }
            else
            {
                appramt = 0;
            }
        }



        Boolean flag = true;
        string finyear = YearString;
        double colamt = appramt;
        double Debit = appramt;
        double Credit = appramt;
        string Chqcleardate = "OK";
        string tableNametrans = mAcctTransTable;
        string v_approve_reject_branch = brcd;
        string voucherType = "";

        string acccode = cboPaymentAccount.SelectedValue.ToString();
        string cheqno = txtChequeNo.Text.ToString();
        string chqdate = txtChequeDate.Text.ToString();

        string[] cbacccode_arr = acccode.Split('~');
        string acccodecb = cbacccode_arr[0].ToString().Trim();
        string acccategory = cbacccode_arr[1].ToString().Trim();
        string accdesccb = cbacccode_arr[2].ToString().Trim();

        string transtyp1 = "", chqno = "", chqdt = "";

        if (PayMode == "Cash")
        {
            transtyp1 = "Cash Payment";
            chqno = "";
            chqdt = "";
        }
        else
        {
            transtyp1 = "Bank Payment";
            chqno = cheqno;
            chqdt =chqdate;
             string[] chqdt_arr = chqdate.Split('/');
             chqdt = Convert.ToDateTime(chqdt_arr[1] + "/" + chqdt_arr[0] + "/" + chqdt_arr[2]).ToString("dd MMM yy");

        }

        string transtype = PayMode;


        if (transtype == "Cheque")
        {
            chqno = txtChequeNo.Text.ToString();
            chqdt = txtChequeDate.Text.ToString();
            string[] strArrDtchqdate = chqdt.Split('/');
            chqdate = Convert.ToDateTime(strArrDtchqdate[1] + "/" + strArrDtchqdate[0] + "/" + strArrDtchqdate[2]).ToString("dd MMM yy");
            chqdt = chqdate;
            string sql_chq = "select isnull(sum(case when chqno is not null then 1 else 0 end),0) as srno from WEBX_chq_det with (NOLOCK) where chqno='" + chqno + "' and chqdt='" + chqdate + "' and ownCust='O'";

            SqlCommand cmd = new SqlCommand(sql_chq, conn);
            SqlDataReader dread = cmd.ExecuteReader();

            dread.Read();
            int srno = Convert.ToInt32(dread.GetValue(0).ToString());

            if (srno == 1)
            {
                errMsg = "Duplicate Cheque ,This cheque is already issued!!!";
                flag = false;
            }
            dread.Close();
        }

        if (transtyp1 == "Cash Payment" && flag == true)
        {
            string Brcd1 = brcd;
            string AcctTransTable = mAcctTransTable;
            string tblStr_OP = AcctOpenTable;
            string AccBrcd = brcd;
            string transdate_Server = transdate1;
            string enddate = transdate_Server;

            string cashval = fn.getOpenBal_Trans(acccodecb, enddate, AcctOpenTable, AcctTransTable, AccBrcd);


            double db_cashval = Convert.ToDouble(cashval.Substring(0, cashval.Length - 2).Trim());
            Response.Write("<br> cashval ; " + db_cashval);
            if ((cashval == "0.00" || db_cashval > 0) && db_cashval < appramt)
            {
                errMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + AccBrcd + " .";
            }

        }

        // NextVoucherno
        Year = abc;
       string VoucherNo = fn.NextVoucherno(brcd, Year);
        //string VoucherNo = "VRBLR-0700069";
        string Bookcode = "BA Commision";
        double Currbalance = 0;

        string DocNo = "", Docsf = "", Deptcode = "", Oppaccount = "", Payto = "";

        string Voucher_Cancel = "N";
        string opertitle = "Manual Voucher";
        string transNo = "", PBOV_CODE = "", PBOV_NAME = "", PBOV_TYP = "", docNo = "";
        string cessaccdesc = "", cessacccode = "", serviceacccode = "", serviceaccdesc = "", tdsaccdesc = "";

        string Entryby = empcd;
        string entryfor = empcd;

        string[] VendorCodeName_arr = VendorCodeName.Split(':');
        string PBOV_code = VendorCodeName_arr[0].ToString().Trim();
        string PBOV_Name = VendorCodeName_arr[1].ToString().Trim();
        string PBOV_typ = "B";

       // string expacccode = fn.GetVendorAccount(PBOV_code);
        string expacccode = "LCL0002";

        string expaccount = fn.getAccountDesc(AcctTable, expacccode);

        string voucher_status = "Approved";

        string v_approve_reject_by = "";
        //string v_approve_reject_branch = "";
        string v_closed_by = empcd;
        string v_closed_branch = brcd;
        string oppacccode="";
        string v_approve_reject_dt = "null";

        string panno = str_PAN_NO;
        string servicetaxNo = str_SERVTAXNO;
        tdsaccdesc = fn.getAccountDesc(AcctTable, tdsacccode1);

        cessacccode = "ALS0010";
        cessaccdesc = fn.getAccountDesc(AcctTable, cessacccode);
        serviceacccode = "ALS0009";
        serviceaccdesc = fn.getAccountDesc(AcctTable, serviceacccode);
        string Narration = "", abc12 = "";
        string prepareByLoc = brcd;
        //conn.BeginTransaction();

        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {

            string[] transdate1_arr = transdate1.Split('/');

            string trdt = Convert.ToDateTime(transdate1_arr[1] + "/" + transdate1_arr[0] + "/" + transdate1_arr[2]).ToString("dd MMM yy");


            if (flag == true)
            {
                //string Oppaccount = "";

                if (colamt > 0)
                {
                    string raisacccode = "VOC0001";
                    if (Session["Client"].ToString() == "RLL" || Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
                    {
                        if (RptTyp.ToUpper() == "DLY")
                        {
                            if (RouteMode == "All")
                            {
                                raisacccode = "PE105";
                            }
                            else
                            {
                                raisacccode = "PE107";
                                if (Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
                                {
                                    raisacccode = "PE105";
                                }
                            }
                        }
                        else
                        {
                            if (RouteMode == "All")
                            {
                                raisacccode = "PE104";
                            }
                            else
                            {
                                raisacccode = "PE106";
                                if (Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
                                {
                                    raisacccode = "PE104";
                                }
                            }
                        }
                    }
                    string raisaccount = fn.getAccountDesc(AcctTable, raisacccode);
                    string fromacccode = "LCL0002";
                    string fromaccdesc = fn.getAccountDesc(AcctTable, expacccode);
                    /// added on 18 dec by Dax ***********************************************
                    Debit = colamt + tds;
                    Credit = 0;
                    acccode = raisacccode;

                    Oppaccount = fromaccdesc;
                    oppacccode = fromacccode;
                    Narration = "BA Payment Voucher Generated   -" + VoucherNo;
                    string  sql_colamt = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    Response.Write("<br> sql_colamt : " + sql_colamt);

                    SqlCommand sqlcmd = new SqlCommand(sql_colamt, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();

                    Debit = 0;
                    Credit = colamt + tds;
                    acccode = fromacccode;
                    Oppaccount = raisaccount;
                    oppacccode = raisacccode;

                    string sql_colamt1 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    Response.Write("<br> sql_colamt : " + sql_colamt);
                    sqlcmd = new SqlCommand(sql_colamt1, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();

                    //******************************************************************

                     //expacccode = "LCL0002";
                    // expaccount = fn.getAccountDesc(AcctTable, expacccode);

                    Debit = colamt;
                    Credit = 0;
                    acccode = expacccode;

                    Oppaccount = accdesccb;
                    oppacccode = acccodecb;

                     sql_colamt = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    Response.Write("<br> sql_colamt : " + sql_colamt);

                    sqlcmd = new SqlCommand(sql_colamt, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();

                    Debit = 0;
                    Credit = colamt;
                    acccode = acccodecb;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;

                     sql_colamt1 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    Response.Write("<br> sql_colamt : " + sql_colamt);
                    sqlcmd = new SqlCommand(sql_colamt1, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();
                }

                if (tds > 0)
                {
                    Narration = "TDS Deducted for BA Voucher -" + VoucherNo;
                    Debit = tds;
                    Credit = 0;
                    acccode = expacccode;
                    Oppaccount = tdsaccdesc;
                    oppacccode = tdsacccode1;


                    string sql_tds1 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_tds1 : " + sql_tds1);
                    SqlCommand sqlcmd1 = new SqlCommand(sql_tds1, conn);
                    sqlcmd1.Transaction = trans;
                    sqlcmd1.ExecuteNonQuery();

                    Debit = 0;
                    Credit = tds;
                    acccode = tdsacccode1;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_tds2 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_tds2 : " + sql_tds2);
                    sqlcmd1 = new SqlCommand(sql_tds2, conn);
                    sqlcmd1.Transaction = trans;
                    sqlcmd1.ExecuteNonQuery();

                }

                if (servicetax > 0)
                {
                    Debit = servicetax;
                    Credit = 0;
                    acccode = expacccode;
                    Oppaccount = serviceaccdesc;
                    oppacccode = serviceacccode;


                    string sql_servicetax1 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_servicetax1 : " + sql_servicetax1);
                    SqlCommand sqlcmd2 = new SqlCommand(sql_servicetax1, conn);
                    sqlcmd2.Transaction = trans;
                    sqlcmd2.ExecuteNonQuery();


                    Debit = 0;
                    Credit = servicetax;
                    acccode = serviceacccode;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_servicetax2 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_servicetax2 : " + sql_servicetax2);
                    sqlcmd2 = new SqlCommand(sql_servicetax2, conn);
                    sqlcmd2.Transaction = trans;
                    sqlcmd2.ExecuteNonQuery();
                }

                if (othertax > 0)
                {
                    Debit = othertax;
                    Credit = 0;
                    acccode = expacccode;
                    Oppaccount = cessaccdesc;
                    oppacccode = cessacccode;


                    string sql_othertax1 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_othertax1 : " + sql_othertax1);
                    SqlCommand sqlcmd3 = new SqlCommand(sql_othertax1, conn);
                    sqlcmd3.Transaction = trans;
                    sqlcmd3.ExecuteNonQuery();


                    Debit = 0;
                    Credit = othertax;
                    acccode = cessacccode;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_othertax2 = "exec WEBX_acctrans_insertData_BA_Payment '" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br>sql_othertax2 : " + sql_othertax2);
                    sqlcmd3 = new SqlCommand(sql_othertax2, conn);
                    sqlcmd3.Transaction = trans;
                    sqlcmd3.ExecuteNonQuery();
                }

                Debit = 0;
                Credit = colamt;
                acccode = acccodecb;

                double OCTPaid = 0;
                double AgentServiceChrg = 0;
                double ServiceChargPaid = 0;
                double TotalDed = 0;
                double TotChrg = 0;
                double Netamt = Convert.ToDouble(txtNetCommission.Text);
                string preparefor = empcd;
                string empcdfor = brcd;
                string TRANSMODE = transtyp1;

                double CHQAMT = appramt;
                double servicetaxCharged = 0;
                string paid_to = "";
                string BANKNAME = "";

                string sql_voucherEntry = "Insert into WEBX_vouchertrans with (ROWLOCK)(finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Narration,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,othertax,tdsfor) values ('" + Year + "','" + trdt + "','" + VoucherNo + "','" + acccode + "','" + accdesccb + "','" + chqno + "','" + chqdt + "','" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Entryby + "',getdate(),'N','Submitted','" + paid_to + "','" + preparefor + "','" + empcdfor + "','" + servicetaxrate + "','" + servicetax + "','" + tdsrate + "','" + tds + "','0','" + othChrg + "','" + OCTPaid + "','" + AgentServiceChrg + "','" + ServiceChargPaid + "','" + TotalDed + "','" + Netamt + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + Bookcode + "','" + BANKNAME + "','" + CHQAMT + "','" + TRANSMODE + "','" + DEDUCTION + "','" + TotChrg + "','" + tdsacccode1 + "','" + serviceacccode + "','" + ServiceChargPaid + "','" + othertax + "','" + tdsfor1 + "')";
                Response.Write("<br> sql_voucherEntry : " + sql_voucherEntry);
                SqlCommand sqlcmd_vw = new SqlCommand(sql_voucherEntry, conn);
                sqlcmd_vw.Transaction = trans;
                sqlcmd_vw.ExecuteNonQuery();


                string sql_voucherEntry_arch = "insert into WEBX_vouchertrans_arch select * from  WEBX_vouchertrans where voucherNo='" + VoucherNo + "'";
                Response.Write("<br> sql_voucherEntry_arch : " + sql_voucherEntry_arch);
                sqlcmd_vw = new SqlCommand(sql_voucherEntry_arch, conn);
                sqlcmd_vw.Transaction = trans;
                sqlcmd_vw.ExecuteNonQuery();

                string sql_voucherEntry_delete = "delete from WEBX_vouchertrans where voucherNo='" + VoucherNo + "'";
                Response.Write("<br> sql_voucherEntry_delete : " + sql_voucherEntry_delete);
                sqlcmd_vw = new SqlCommand(sql_voucherEntry_delete, conn);
                sqlcmd_vw.Transaction = trans;
                sqlcmd_vw.ExecuteNonQuery();


                if (PayMode == "Cheque")
                {
                    string depositdt = trdt;
                    string ptmsptcd = PBOV_code;
                    string ptmsptnm = PBOV_Name;
                    double adjustamt = colamt;
                    string comments = "NULL";
                    string bacd = "NULL";
                    string banm = "NULL";
                    string brnm = "NULL";
                    string empnm = "NULL";
                    string staffnm = "NULL";
                    string staffcd = "NULL";
                    string BANKBRN = "";

                    string sql_chqentry = "insert into WEBX_chq_det with (ROWLOCK) (Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values('" + chqno + "','" + chqdt + "'," + colamt + ",'" + BANKNAME + "','" + ptmsptcd + "','" + ptmsptnm + "'," + comments + "," + bacd + "," + banm + ",'" + empcd + "'," + empnm + ",'" + brcd + "'," + brnm + "," + staffcd + "," + staffnm + ",Null,'0','" + BANKBRN + "','" + adjustamt + "')";
                    Response.Write("<br> sql_chqentry : " + sql_chqentry);
                    SqlCommand sqlcmd_chq = new SqlCommand(sql_chqentry, conn);
                    sqlcmd_chq.Transaction = trans;
                    sqlcmd_chq.ExecuteNonQuery();

                    string sql_chqUpdate = "update WEBX_chq_det with (ROWLOCK) set voucherNo='" + VoucherNo + "',transdate='" + depositdt + "',acccode='" + acccodecb + "',depoloccode='" + brcd + "',DepoFlag='Y' where convert(varchar,chqno,106)='" + chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdt + "',106)";
                    Response.Write("<br> sql_chqUpdate : " + sql_chqUpdate);
                    sqlcmd_chq = new SqlCommand(sql_chqUpdate, conn);
                    sqlcmd_chq.Transaction = trans;
                    sqlcmd_chq.ExecuteNonQuery();


                }

                string sql_vend_contvalue = "";
                if (RptTyp.ToUpper() == "DLY")
                {

                    sql_vend_contvalue = "select isnull(slabfrom,0) as slabfrom,isnull(slabto,0) as slabto from webx_vendor_contract_charges where matrixcode='6' and  chargetype = 'Fixed' and VendorCode='" + PBOV_code + "'";
                }
                else
                {
                    sql_vend_contvalue = "select isnull(slabfrom,0) as slabfrom,isnull(slabto,0) as slabto from webx_vendor_contract_charges where matrixcode='7' and  chargetype = 'Fixed' and VendorCode='" + PBOV_code + "'";
                }

                Response.Write("<br> sql_vend_contvalue : " + sql_vend_contvalue);
                SqlCommand sqlcmd_contvalue = new SqlCommand(sql_vend_contvalue, conn);
                sqlcmd_contvalue.Transaction = trans;
                sqlcmd_contvalue.ExecuteNonQuery();


                string chrgbasis = "Per trip";
                string slabbasis = "Per Km.";

                minchrg = 0;
                maxchrg = 0;


                string docketlist = "";
                foreach (GridViewRow gridrow in dgDocket.Rows)
                {
                    CheckBox chk = (CheckBox)gridrow.FindControl("chkOrderNo");

                    Label lbldkt = (Label)gridrow.FindControl("dktval");
                    Label lblPaybas = (Label)gridrow.FindControl("lblPaybas");
                    Label lbltrnmod = (Label)gridrow.FindControl("lbltrnmod");
                    Label lblorigin = (Label)gridrow.FindControl("lblorigin");
                    Label lbldestcd = (Label)gridrow.FindControl("lbldestcd");
                    Label lblpkgsno = (Label)gridrow.FindControl("lblpkgsno");
                    Label lblactuwt = (Label)gridrow.FindControl("lblactuwt");
                    Label lblchrgwt = (Label)gridrow.FindControl("lblchrgwt");
                    Label lbldkttot = (Label)gridrow.FindControl("lbldkttot");
                    Label lblfreight = (Label)gridrow.FindControl("lblfreight");
                    Label lblcess = (Label)gridrow.FindControl("lblcess");
                    Label lbldiplomatchg = (Label)gridrow.FindControl("lbldiplomatchg");
                    lbldiplomatchg.Text = "0";
                    Label lblsvctax = (Label)gridrow.FindControl("lblsvctax");
                    Label lblslabrate = (Label)gridrow.FindControl("lblslabrate");
                    Label lblcommision = (Label)gridrow.FindControl("lblcommision");
                    Label lbldktsf = (Label)gridrow.FindControl("lbldktsf");
                    Label lbldktno = (Label)gridrow.FindControl("lbldktno");
                   

                    string dktsf = lbldktsf.Text.ToString();
                    string dktno = lbldktno.Text.ToString();
                    string paybas = lblPaybas.Text.ToString();
                    string trnmod = lbltrnmod.Text.ToString();
                    string st_origin = lblorigin.Text.ToString();
                    string st_destcd = lbldestcd.Text.ToString();
                    double st_pkgsno = Convert.ToDouble(lblpkgsno.Text);
                    double st_actuwt = Convert.ToDouble(lblactuwt.Text);
                    double st_chrgwt = Convert.ToDouble(lblchrgwt.Text);
                    double st_dkttot = Convert.ToDouble(lbldkttot.Text);
                    double st_freight = Convert.ToDouble(lblfreight.Text);
                    double st_cess = Convert.ToDouble(lblcess.Text);
                    double st_diplomatchrg = Convert.ToDouble(lbldiplomatchg.Text);
                    double st_svctax = Convert.ToDouble(lblsvctax.Text);

                    double cess_stax = st_svctax + st_cess;
                    double subtotal = st_dkttot - (st_svctax + st_cess);
                    double st_commission = Convert.ToDouble(lblcommision.Text);
                    double st_slabrate = Convert.ToDouble(lblslabrate.Text);

                    string docType = RptTyp.ToUpper();
                    if (chk.Checked == true)
                    {
                        string sql_bapayment_docket = "insert into webx_bapayment_docket with (ROWLOCK) (Dockno,docksf,voucherno,transdate,Commission,slabrate,docType,activeflag) values('" + dktno + "','" + dktsf + "','" + VoucherNo + "','" + trdt + "','" + st_commission + "','" + st_slabrate + "','" + docType + "','Y')";
                        Response.Write("<br> sql_bapayment_docket : " + sql_bapayment_docket);
                        SqlCommand sqlcmd_docket = new SqlCommand(sql_bapayment_docket, conn);
                        sqlcmd_docket.Transaction = trans;
                        sqlcmd_docket.ExecuteNonQuery();


                        string sql_bapayment_Prof = "update  webx_DOCKET_Profitability with (ROWLOCK) set BA_Code='" + VendorCode + "' , BA_Comm_Cost='" + st_commission + "' where dockno='" + dktno + "'";
                        Response.Write("<br> sql_bapayment_Prof : " + sql_bapayment_Prof);
                        SqlCommand sqlcmd_docket_Prof = new SqlCommand(sql_bapayment_Prof, conn);
                        sqlcmd_docket_Prof.Transaction = trans;
                        sqlcmd_docket_Prof.ExecuteNonQuery();


                        if (docketlist == "")
                        {
                            docketlist = lbldkt.Text.ToString();
                        }
                        else
                        {
                            docketlist = docketlist + "," + lbldkt.Text.ToString();
                        }

                    }
                }

                string abcd = docketlist;

            }


            trans.Rollback();
            Response.Write("<br><br><br><br>Year :----------Done - ");
            Response.End();
            //trans.Commit();

            conn.Close();
            Response.Write("<br><br><br>" + abc12);
            Response.Redirect("DirectBAPayment_done.aspx?" + VoucherNo);
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                abc = "Insert Susccessfully !!!!!!!";
            }
            
            trans.Rollback();


            conn.Close();
            Response.End();
        }
        
        

        conn.Close();
    }
}
