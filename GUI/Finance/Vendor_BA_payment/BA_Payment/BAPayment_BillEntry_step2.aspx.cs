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
   // public static string VendorCode = "", CloseYear, Year,dkt_call = "", AcctOpenTable, str_PAN_NO, str_SERVTAXNO, AcctTable, mHeadOfficeCode, mAcctTransTable, brcd, abc, yearSuffix, finyearstart, YearString, VendorCodeName = "", empcd, RptTyp = "", strDateRange, RouteMode = "";

    SqlConnection conn;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    protected void Page_Load(object sender, EventArgs e)
    {
        double minchrg = 0, maxchrg = 0;
       
        string VendorCode = "", CloseYear, Year, dkt_call = "", AcctOpenTable, str_PAN_NO, str_SERVTAXNO, AcctTable, mHeadOfficeCode, mAcctTransTable, brcd, abc, yearSuffix, finyearstart, YearString, VendorCodeName = "", empcd, RptTyp = "", strDateRange, RouteMode = "";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        strDateRange = Request.QueryString["DOCDate"].ToString();
        VendorCode = Request.QueryString["Vendcd"].ToString();
        RptTyp = Request.QueryString["DocType"].ToString();
        RouteMode = Request.QueryString["RouteMode"].ToString();
        if (!IsPostBack)
        {
             AcctTable = "webx_acctinfo";
            dkt_call = Session["DocketCalledAs"].ToString();
             Year = Session["FinYear"].ToString();
           
            abc = Year.Substring(2, 2);
            //Response.Write("<br>Year " + Year);
            //Response.Write("<br>Year " + abc);
            // Response.End();
             CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
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

            
            lblDockDt.Text = strDateRange;
           
            mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
            brcd = Session["brcd"].ToString();
            empcd = Session["empcd"].ToString();
            transdate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            vendorbilldt.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            duedt.Text = System.DateTime.Today.AddDays(15).ToString("dd/MM/yyyy");
            string sqlstr = "select vendorcode+' : '+ vendorname,isnull(PAN_NO,'') as PAN_NO,isnull(SERVTAXNO,'') as SERVTAXNO from webx_vendor_hdr where vendorcode='" + VendorCode + "'";
            // Response.Write("<br> sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            dread.Read();


            str_PAN_NO = Convert.ToString(dread.GetValue(1).ToString());
            str_SERVTAXNO = Convert.ToString(dread.GetValue(2).ToString());
            VendorCodeName = Convert.ToString(dread.GetValue(0).ToString());
            lblVend.Text = VendorCodeName;
            lblTyp.Text = Request.QueryString["str_DocType"].ToString();
            dread.Close();

            //VendorCodeName = Convert.ToString(dread.GetValue(0).ToString());
            //lblVend.Text = VendorCodeName;
            //lblTyp.Text = Request.QueryString["str_DocType"].ToString();
            //dread.Close();
            string sql_minmax = "";


            if (RptTyp.ToUpper() == "DLY")
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

            String SQL_TDSACC = "select * from webx_acctinfo where acccode ='CLA0015'";
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
        string VendorCode = Request.QueryString["Vendcd"].ToString();
        string RptTyp = Request.QueryString["DocType"].ToString();
        string mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
        string  brcd = Session["brcd"].ToString();
        string  empcd = Session["empcd"].ToString();
        string dkt_call = Session["DocketCalledAs"].ToString();

        string RouteMode = Request.QueryString["RouteMode"].ToString();
        string[] strDateRange_arr = Request.QueryString["DOCDate"].ToString().Split('-');
        String fromdt=strDateRange_arr[0].ToString().Trim();
         String tomdt=strDateRange_arr[1].ToString().Trim();

         //string sqlstr = "select vendorcode+' : '+ vendorname,isnull(PAN_NO,'') as PAN_NO,isnull(SERVTAXNO,'') as SERVTAXNO from webx_vendor_hdr where vendorcode='" + VendorCode + "'";
         //// Response.Write("<br> sqlstr : " + sqlstr);
         //SqlCommand cmd = new SqlCommand(sqlstr, conn);
         //SqlDataReader dread = cmd.ExecuteReader();
         //while (dread.Read())
         //{
         //     str_PAN_NO = Convert.ToString(dread.GetValue(1).ToString());
         //     str_SERVTAXNO = Convert.ToString(dread.GetValue(2).ToString());
         //     VendorCodeName = Convert.ToString(dread.GetValue(0).ToString());
         //}
         //dread.Close();
         string SQL_grid = "exec webx_bapayment_DirectPayment '" + fromdt + "','" + tomdt + "','" + VendorCode + "','" + RptTyp + "','" + brcd + "','" + RouteMode + "'";

       // Response.Write("<br> SQL_grid : "+SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        //dgDocket.AllowPaging = false;
        da.Fill(ds);
        dgDocket.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
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
            string dkt_call = Session["DocketCalledAs"].ToString();
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


           // String SQL_status = "exec usp_bapayment_validdkt '" + MDockets + "'";
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

            MR_BILL_Status1 = "Y";
            if (MR_BILL_Status1 == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.White;
            }
            else
            {
                e.Row.Cells[1].Enabled = false;
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

            //Label lblPaybas = (Label)e.Row.FindControl("lblPaybas");
            //Label lbltrnmod = (Label)e.Row.FindControl("lbltrnmod");


            //Label delDoor = (Label)e.Row.FindControl("dely_door_yn");
            //Label delgodown = (Label)e.Row.FindControl("dely_godown_yn");

            //trn = lbltrnmod.Text.ToString();
            //Pay = lblPaybas.Text.ToString();
            //string dely_door_yn = e.Row.Cells[13].Text.ToString();
            //string dely_godown_yn = e.Row.Cells[14].Text.ToString();

            //dely_door_yn = delDoor.Text.ToString();
            //dely_godown_yn = delgodown.Text.ToString();

            //string chargeType = "";

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
        conn.Close();
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        string VendorCode = Request.QueryString["Vendcd"].ToString();

        string RptTyp = Request.QueryString["DocType"].ToString();
        string RouteMode = Request.QueryString["RouteMode"].ToString();
        string AcctTable = "webx_acctinfo";
        string dkt_call = Session["DocketCalledAs"].ToString();
        string Year = Session["FinYear"].ToString();
        string  brcd = Session["brcd"].ToString();
        string  abc = Year.Substring(2, 2);
        string empcd = Session["empcd"].ToString();
        //Response.Write("<br>Year " + Year);
        //Response.Write("<br>Year " + abc);
        // Response.End();
        string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        string YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
        string yearSuffix = YearString;
        string finyearstart = "01 APR " + abc;
        Year = abc;
        string mAcctTransTable = "webx_acctrans_" + yearSuffix;
        string  AcctOpenTable = "WEBX_acctopening_" + yearSuffix;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string VendorCodeName = "", str_PAN_NO = "", str_SERVTAXNO="";
        string sqlstr = "select vendorcode+' : '+ vendorname,isnull(PAN_NO,'') as PAN_NO,isnull(SERVTAXNO,'') as SERVTAXNO from webx_vendor_hdr where vendorcode='" + VendorCode + "'";
        // Response.Write("<br> sqlstr : " + sqlstr);
        SqlCommand cmd11 = new SqlCommand(sqlstr, conn);
        SqlDataReader dread11 = cmd11.ExecuteReader();
        while (dread11.Read())
        {
            str_PAN_NO = Convert.ToString(dread11.GetValue(1).ToString());
            str_SERVTAXNO = Convert.ToString(dread11.GetValue(2).ToString());
            VendorCodeName = Convert.ToString(dread11.GetValue(0).ToString());
        }
        dread11.Close();
        

        
        //Response.End();
        string sql_billno = "Exec sp_get_next_be_code '" + brcd + "'";
        SqlCommand cmd = new SqlCommand(sql_billno, conn);

        string BillNo = (string)cmd.ExecuteScalar();
        double othChrg = Convert.ToDouble(oth_amt.Text);
        double DEDUCTION = Convert.ToDouble(oth_ded.Text);
        string transdate1 = transdate.Text.ToString();
        double servicetaxrate = Convert.ToDouble(svtax_rate.Text);
        double servicetax = Convert.ToDouble(svrcamt.Text);
        double othertax = Convert.ToDouble(cessamt.Text);
        double tdsrate = Convert.ToDouble(tds_rate.Text);
        double tds = Convert.ToDouble(tds_chrg.Text);
        string tdsacccode1 = tdsacccode.SelectedValue.ToString();
        string tdsgrpcode = tdsacccode1;
        string tdsgrpdesc =  fn.getAccountDesc(AcctTable, tdsacccode1);
        string tdsaccdesc = fn.getAccountDesc(AcctTable, tdsacccode1);
        string tdsfor1 = tdsfor.SelectedValue.ToString();
        double TotalNetpayable1 = Convert.ToDouble(TotalNetpayable.Text);
        string PayMode = "";// cboModeOfTransaction.SelectedValue.ToString();
        double appramt = TotalNetpayable1;
        double TotalNetCommision = 0, Totalcommision=0;
        Totalcommision = Convert.ToDouble(txtNetCommission.Text);
        TotalNetCommision = Totalcommision - DEDUCTION + othChrg;
        Boolean flag = true;

        string finyear = YearString;
        double colamt = appramt;
        double Debit = appramt;
        double Credit = appramt;
        string Chqcleardate = "OK";
        string tableNametrans = mAcctTransTable;
        string v_approve_reject_branch = brcd;
        string voucherType = "";

        string chqno = "null";
        string chqdt = "null";

         Year = abc;
         string VoucherNo = fn.NextVoucherno(brcd, Year);
       // string VoucherNo = "VRBLR-0700069";
        string Bookcode = "BA Commision";
        double Currbalance = 0;

        string DocNo = "", Docsf = "", Deptcode = "", Oppaccount = "", Payto = "";


        string Voucher_Cancel = "N";
        string opertitle = "Manual Voucher";
        string transNo = "", PBOV_CODE = "", PBOV_NAME = "", PBOV_TYP = "", docNo = "";
        string cessaccdesc = "", cessacccode = "", serviceacccode = "", serviceaccdesc = "";
        
        string vehExpAcccode="VOC0001";

        if (Session["Client"].ToString() == "RLL" || Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
        {
            if (RptTyp.ToUpper() == "DLY")
            {
                if (RouteMode == "All")
                {
                    vehExpAcccode = "PE105";
                }
                else
                {
                    vehExpAcccode = "PE107";
                    if (Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
                    {
                        vehExpAcccode = "PE105";
                    }
                }
            }
            else
            {
                if (RouteMode == "All")
                {
                    vehExpAcccode = "PE104";
                }
                else
                {
                    vehExpAcccode = "PE106";
                    if (Session["Client"].ToString() == "RCPL" || Session["Client"].ToString() == "ASL")
                    {
                        vehExpAcccode = "PE104";
                    }
                }
            }
        }
        string vehExpAccdesc = fn.getAccountDesc(AcctTable, vehExpAcccode);



        string[] VendorCodeName_arr = VendorCodeName.Split(':');
        string PBOV_code = VendorCodeName_arr[0].ToString().Trim();
        string PBOV_Name = VendorCodeName_arr[1].ToString().Trim();
        string PBOV_typ = "V";

        // string expacccode = fn.GetVendorAccount(PBOV_code);
        string expacccode = "LCL0002";
        string expaccount = fn.getAccountDesc(AcctTable, expacccode);

        string expaccdesc = expaccount;

        string panno = str_PAN_NO;
        string servicetaxNo = str_SERVTAXNO;

        string Entryby = empcd;
        string entryfor = empcd;

        cessacccode = "ALS0010";
        cessaccdesc = fn.getAccountDesc(AcctTable, cessacccode);
        serviceacccode = "ALS0009";
        serviceaccdesc = fn.getAccountDesc(AcctTable, serviceacccode);

        string voucher_status = "Approved";

        string v_approve_reject_by = "";
        //string v_approve_reject_branch = "";
        string v_closed_by = empcd;
        string v_closed_branch = brcd;
        string oppacccode = "";
        string v_approve_reject_dt = "null";

        string Narration = "", abc12 = "";
        string prepareByLoc = brcd;
        Payto = txtremarks.Text.ToString();
        string acccode = "";
        

        if (Totalcommision < 0 || Totalcommision == 0)
        {

            //reduredt
            Response.Redirect("ErrorPage.aspx");
        }
        SqlTransaction trans;
        string transtyp1 = "Journal";
        trans = conn.BeginTransaction();
        try
        {

            if (flag == true)
            {

                string[] transdate1_arr = transdate1.Split('/');

                string trdt = Convert.ToDateTime(transdate1_arr[1] + "/" + transdate1_arr[0] + "/" + transdate1_arr[2]).ToString("dd MMM yy");


                Narration = "When Bill Entry for BA is generated : " + BillNo;
                opertitle = "BA Bill Entry ";
                string TransNo = "1";
                Currbalance = 0;
                double Bookamt = 0;
                docNo = BillNo;
                if (TotalNetpayable1 > 0)
                {
                    Bookamt = TotalNetpayable1 + DEDUCTION + othChrg;
                }


                if (TotalNetCommision > 0)
                {
                    Debit = TotalNetCommision;
                    Credit = 0;
                    acccode = vehExpAcccode;
                    Oppaccount = expaccdesc;
                    oppacccode = expacccode;

                    //       finyear,           Transdate,  Voucherno,           Acccode,           chqno,          chqdate,        Debit,          Credit,         Narration,          Transtype,          Currbalance,            docno,      brcd,            Deptcode,          Oppaccount,       Entryby,    Entrydt,Voucher_Cancel,autoentry,oppacccode,voucher_status,v_approve_reject_by,v_approve_reject_branch,v_closed_by,     v_closed_branch,v_approve_reject_dt,v_closed_dt,Payto,            entryfor,       prepareByLoc,           PBOV_code,          PBOV_Name,          PBOV_typ,           panno,          servicetaxNo
                    string sql_Bookamt = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,Null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    Response.Write("<br> sql_colamt : " + sql_Bookamt);

                    SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();


                    Debit = 0;
                    Credit = TotalNetCommision;
                    acccode = expacccode;
                    Oppaccount = vehExpAccdesc;
                    oppacccode = vehExpAcccode;

                    string sql_Bookamt1 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "' ";
                    /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                    Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                    sqlcmd = new SqlCommand(sql_Bookamt1, conn);
                    sqlcmd.Transaction = trans;
                    sqlcmd.ExecuteNonQuery();

                }

                if (tds > 0)
                {
                    Debit = tds;
                    Credit = 0;
                    acccode = expacccode;
                    Oppaccount = tdsaccdesc;
                    oppacccode = tdsacccode1;


                    string sql_tds1 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_tds1 : " + sql_tds1);
                    SqlCommand sqlcmd1 = new SqlCommand(sql_tds1, conn);
                    sqlcmd1.Transaction = trans;
                    sqlcmd1.ExecuteNonQuery();

                    Debit = 0;
                    Credit = tds;
                    acccode = tdsacccode1;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_tds2 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
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


                    string sql_servicetax1 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_servicetax1 : " + sql_servicetax1);
                    SqlCommand sqlcmd2 = new SqlCommand(sql_servicetax1, conn);
                    sqlcmd2.Transaction = trans;
                    sqlcmd2.ExecuteNonQuery();


                    Debit = 0;
                    Credit = servicetax;
                    acccode = serviceacccode;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_servicetax2 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
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


                    string sql_othertax1 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br> sql_othertax1 : " + sql_othertax1);
                    SqlCommand sqlcmd3 = new SqlCommand(sql_othertax1, conn);
                    sqlcmd3.Transaction = trans;
                    sqlcmd3.ExecuteNonQuery();


                    Debit = 0;
                    Credit = othertax;
                    acccode = cessacccode;
                    Oppaccount = expaccount;
                    oppacccode = expacccode;


                    string sql_othertax2 = "exec WEBX_acctrans_insertData_BA_Payment '" + yearSuffix     + "','" + trdt + "','" + VoucherNo + "','" + acccode + "',Null,null,'" + Debit + "','" + Credit + "','" + Narration + "','" + transtyp1 + "','" + Currbalance + "','" + docNo + "','" + brcd + "','" + Deptcode + "','" + Oppaccount + "','" + Entryby + "','','N','Y','" + oppacccode + "','Closed','" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','null','null' ";
                    Response.Write("<br>sql_othertax2 : " + sql_othertax2);
                    sqlcmd3 = new SqlCommand(sql_othertax2, conn);
                    sqlcmd3.Transaction = trans;
                    

                    sqlcmd3.ExecuteNonQuery();
                }


                string billdt = trdt;
                // string VENDORBILLDT = vendorbilldt.Text.ToString();
                string[] VENDORBILLDT_arr = vendorbilldt.Text.ToString().Split('/');
                string VENDORBILLDT = Convert.ToDateTime(VENDORBILLDT_arr[1] + "/" + VENDORBILLDT_arr[0] + "/" + VENDORBILLDT_arr[2]).ToString("dd MMM yy");

                string[] Duedt_arr = duedt.Text.ToString().Split('/');
                string Duedt = Convert.ToDateTime(Duedt_arr[1] + "/" + Duedt_arr[0] + "/" + Duedt_arr[2]).ToString("dd MMM yy");


                string VENDORCODE = PBOV_code;
                string VENDORNAME = PBOV_Name;

                double PCAMT = Convert.ToDouble(txtNetCommission.Text);
                double ADVAMT = 0;
                double OTHAMT = othChrg;
                double SVCTAX = Convert.ToDouble(svrcamt.Text);
                double cess_amt = Convert.ToDouble(cessamt.Text);
                string REMARK = txtremarks.Text.ToString();
                string PAYDT = "null";
                string VOUCHERNO = "null";
                double OTHERDED = Convert.ToDouble(oth_ded.Text);
                double SVCTAXDED = 0;
                double OTHERCHRG = 0;


                double NETAMT = Convert.ToDouble(TotalNetpayable.Text);
                string  AcctOTHERDED = "", AcctSVCTAXDED = "";
                string betype = "BA Payment";

                double totdiscount = 0;


                string sql_billentry = "INSERT INTO WEBX_VENDORBILL_HDR " +
                "(BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, VOUCHERNO, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,tdsacccode,tdsaccdesc,discount,pendamt,servicetaxrate) " +
                "VALUES     " +
                "('" + BillNo + "','.','" + brcd + "','" + billdt + "','" + VENDORCODE + "','" + VENDORNAME + "','" + VENDORBILLDT + "','" + vendorbillno.Text.ToString() + "','" + PCAMT + "','" + ADVAMT + "','" + OTHAMT + "','" + SVCTAX + "','" + Duedt + "','" + Entryby + "',getdate(),'" + REMARK + "',getdate(),'" + VOUCHERNO + "','" + OTHERDED + "','" + tdsrate + "','" + tds + "','" + SVCTAXDED + "','" + OTHERCHRG + "','" + NETAMT + "','" + tdsfor1 + "','" + cess_amt + "','" + tdsgrpcode + "','" + tdsgrpdesc + "','" + betype + "','" + tdsacccode1 + "','" + tdsaccdesc + "','" + totdiscount + "','" + NETAMT + "','" + servicetaxrate + "')";
               // Response.Write("<br>sql_othertax2 : " + sql_billentry);
                SqlCommand sqlcmd4 = new SqlCommand(sql_billentry, conn);

                sqlcmd4.Transaction = trans;
                
                sqlcmd4.ExecuteNonQuery();
               
               

                string sql_vend_contvalue = "";
                if (RptTyp.ToUpper() == "DLY")
                {

                    sql_vend_contvalue = "select isnull(slabfrom,0) as slabfrom,isnull(slabto,0) as slabto from webx_vendor_contract_charges with(NOLOCK) where matrixcode='6' and  chargetype = 'Fixed' and VendorCode='" + PBOV_code + "'";
                }
                else
                {
                    sql_vend_contvalue = "select isnull(slabfrom,0) as slabfrom,isnull(slabto,0) as slabto from webx_vendor_contract_charges with(NOLOCK) where matrixcode='7' and  chargetype = 'Fixed' and VendorCode='" + PBOV_code + "'";
                }

               // Response.Write("<br> sql_vend_contvalue : " + sql_vend_contvalue);
                SqlCommand sqlcmd_contvalue = new SqlCommand(sql_vend_contvalue, conn);
                sqlcmd_contvalue.Transaction = trans;
                sqlcmd_contvalue.ExecuteNonQuery();
                

                string chrgbasis = "Per trip";
                string slabbasis = "Per Km.";
                double ADVPAID = 0, OTHDED = 0, tdsded = 0, discount = 0,                minchrg = 0,                maxchrg = 0;


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

                    if (lblslabrate.Text == "")
                    {
                        lblslabrate.Text = "0.00";
                    }
                    if (lblcommision.Text == "")
                    {
                        lblcommision.Text = "0.00";
                    }

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
                        string sql_bapayment_docket = "insert into webx_bapayment_docket with (ROWLOCK) (Dockno,docksf,voucherno,transdate,Commission,slabrate,docType,BENO) values('" + dktno + "','" + dktsf + "','" + VoucherNo + "','" + trdt + "','" + st_commission + "','" + st_slabrate + "','" + docType + "','" + BillNo + "')";
                        Response.Write("<br> sql_bapayment_docket : " + sql_bapayment_docket);
                        SqlCommand sqlcmd_docket = new SqlCommand(sql_bapayment_docket, conn);
                        sqlcmd_docket.Transaction = trans;
                        sqlcmd_docket.ExecuteNonQuery();

                        if (st_commission > 0 && st_slabrate > 0)
                        {
                            string sql_billentry_det = "INSERT INTO WEBX_VENDORBILL_DET " +
                                "(BILLNO, BILLSF, DOCNO, DOCSF, PCAMT, OTHAMT, SVCTAX, CESS, ADVPAID,OTHDED, SVCTAXDED, voucherNo, paydt,netpay,tdsded,tds_rate,svctaxrate,discount)" +
                                "VALUES('" + BillNo + "','.','" + dktno + "','" + dktsf + "','" + PCAMT + "','" + OTHAMT + "','" + st_svctax + "','" + st_cess + "','" + ADVPAID + "','" + OTHDED + "','" + SVCTAXDED + "',null,null,'" + st_commission + "','" + tdsded + "','" + tdsrate + "','" + servicetaxrate + "','" + discount + "')";

                            //Response.Write("<br> sql_billentry_det : " + sql_billentry_det);
                            SqlCommand sqlcmd_sql_billentry_det = new SqlCommand(sql_billentry_det, conn);
                            sqlcmd_sql_billentry_det.Transaction = trans;
                            sqlcmd_sql_billentry_det.ExecuteNonQuery();
                        }
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

          // trans.Rollback();
           // Response.Write("<br>Year :----------Done - ");
            //Response.End();
           trans.Commit();

            conn.Close();
            Response.Write("<br><br><br>" + abc12);
            Response.Redirect("BAPayment_BillEntry_done.aspx?" + BillNo);
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

        


        //conn.Close();
    }
}
