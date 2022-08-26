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


public partial class GUI_Finance_GeneralizedPO_Ver1_POBillEntryPayment_Payment_2 : BasePage
{
    SqlConnection con;
    string strDateRange, strven, strpo;
    DataSet ds1 = new DataSet();
    MyFunctions fn = new MyFunctions();
    string Fromdt = "", Todate = "";
    string strvendor = "", Vendorcode = "", AcctHead = "";
    public bool isSuccess { get { return (ViewState["isSuccess"] != null) ? Convert.ToBoolean(ViewState["isSuccess"]) : false; } set { ViewState["isSuccess"] = value; } }
    public string Voucherno { get { return (ViewState["Voucherno"] != null) ? ViewState["Voucherno"].ToString() : ""; } set { ViewState["Voucherno"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        usrMsg.Hide();
        string sql = "";
        SqlCommand sqlcmd;
        SqlDataReader dr;
        if (!IsPostBack)
        {
            CreateToken();
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            Fromdt = Request.QueryString["Fromdt"].ToString();
            Todate = Request.QueryString["Todate"].ToString();
            strven = Request.QueryString["ven"].ToString();
            strpo = Request.QueryString["po"].ToString();
            TxtVoucherDT.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            if (strpo == "")
            {
                lblro.Text = "-";
                lblloc.Text = strven + ":" + fn.GetVendor(strven);
                lblseldet.Text = Fromdt + "-" + Todate;
                lblVendor.Text = fn.GetVendor(strven);
                Vendorcode = strven;
            }
            else
            {
                lblro.Text = strpo;
                lblseldet.Text = "-";
                lblloc.Text = "-";
                if (strven != "")
                {
                lblVendor.Text = fn.GetVendor(strven);
                Vendorcode = strven;
                }


                sql = "Exec usp_Bill_Listing '" + lblro.Text + "','"+Vendorcode+"','" + Fromdt + "','" + Todate + "','" + Session["Brcd"].ToString() + "','','POBILL' ";
                sqlcmd = new SqlCommand(sql, con);

                dr = sqlcmd.ExecuteReader();

                while (dr.Read())
                {
                    strvendor = dr["vendorcd"].ToString();
                    Vendorcode = dr["Vendorcode"].ToString();
                }
                dr.Close();
                lblloc.Text = strvendor;
                lblVendor.Text = strvendor;
            }
            string Panno = "", servtaxno = "";
            sql = "select Pan_no,servtaxno,AcctHead  from webx_vendor_hdr A With(NOLOCK) Inner join webx_AcctHead  B With(NOLOCK) on B.Codeid=A.vendor_type where Vendorcode='" + Vendorcode + "'";
            sqlcmd = new SqlCommand(sql, con);
            dr = sqlcmd.ExecuteReader();

            while (dr.Read())
            {
                Panno = dr["Pan_no"].ToString();
                servtaxno = dr["servtaxno"].ToString();
                AcctHead = dr["AcctHead"].ToString();
            }
            dr.Close();
            V_Staxno.Text = servtaxno;
            V_PANNO.Text = Panno;
            sql = "select Acccode as code , accdesc+':'+company_acccode as name from vw_tds_payable With(NOLOCK)";
            SqlCommand cmd_pbov = new SqlCommand(sql, con);
            SqlDataReader dr_Tds;
            dr_Tds = cmd_pbov.ExecuteReader();
            DDL_Tdstype.Items.Clear();
            DDL_Tdstype.CssClass = "blackfnt";
            DDL_Tdstype.Items.Add(new ListItem("Select", ""));
            while (dr_Tds.Read())
            {
                DDL_Tdstype.Items.Add(new ListItem(dr_Tds.GetValue(1).ToString(), dr_Tds.GetValue(0).ToString()));
            }
            dr_Tds.Close();
            DDL_Tdstype.Items.ToString().ToUpper();
            DipsplayReport();
        }
    }

    public void DipsplayReport()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";

        sql = "Exec usp_Bill_Listing '" + strpo + "','" + strven + "','" + Fromdt + "','" + Todate + "','" + Session["brcd"].ToString() + "','','POBILL' ";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql);

        //conn.Open();
        //SqlCommand cmd = new SqlCommand(sql, conn);
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_Booking.DataSource = ds;
            GV_Booking.DataBind();
            btn_submit.Enabled = true;
        }
        else
        {
            btn_submit.Enabled = false;
        }

    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;
        DipsplayReport();
    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Booking.PageCount;
        GV_Booking.PageIndex = i;
        DipsplayReport();
    }
    public void fst(object sender, EventArgs e)
    {
        GV_Booking.PageIndex = 0;
        DipsplayReport();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_Booking.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=ServiceTax_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplayReport();
            GV_Booking.RenderControl(hw);
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            usrMsg.Show(ex1.Message);
            return;
            // lblloc.Text = ex1.Message;
        }

    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        double CurrPayment = 0, PendPaymt = 0, Total = 0;
        double CurrPaymentTot = 0;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            if (IsTokenValid())
            {
                string Sql = "";
                DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
                DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
                DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
                TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");
                TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
                TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
                TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
                TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
                string ChqDate = "'" + fn.Mydate1(txtChqDate.Text) + "'";
                string PayMode = ddlPayMode.SelectedValue.ToString();
                string Bankaccode = ddrBankaccode.SelectedValue.ToString();
                string Cashcode = ddrCashcode.SelectedValue.ToString();
                string NetPay = txtNetPay.Text.ToString();
                string CashAmt = txtCashAmt.Text.ToString();
                string ChqAmt = txtChqAmt.Text.ToString();
                string ChqNo = "'" + txtChqNo.Text.ToString() + "'";

                Voucherno = fn.NextVoucherno(Session["Brcd"].ToString(), Session["Finyear"].ToString().Substring(2, 2));

                string[] ARR_vendcd = lblloc.Text.Split(':');
                string ptmsptcd = ARR_vendcd[0].ToString(), ptmsptnm = ARR_vendcd[1].ToString();

                SqlCommand sqlcmd;

                if (PayMode == "Cash")
                {
                    ChqAmt = "0.00";
                    ChqNo = "NULL";
                    ChqDate = "NULL";
                }
                else if (PayMode == "Bank")
                {
                    CashAmt = "0.00";
                }

                foreach (GridViewRow gridrow in GV_Booking.Rows)
                {
                    Label LblBillno = (Label)gridrow.FindControl("LblBillno");
                    Label LblPendamt = (Label)gridrow.FindControl("LblPendamt");
                    HiddenField Hnd_totalAmt = (HiddenField)gridrow.FindControl("Hnd_totalAmt");
                    CheckBox chksrno = (CheckBox)gridrow.FindControl("chksrno");
                    TextBox TXTCurramt = (TextBox)gridrow.FindControl("TXTCurramt");
                    if (chksrno.Checked)
                    {
                        Total = Convert.ToDouble(Hnd_totalAmt.Value);
                        CurrPayment = Convert.ToDouble(TXTCurramt.Text);
                        CurrPaymentTot = CurrPaymentTot + CurrPayment;
                        PendPaymt = Convert.ToDouble(LblPendamt.Text) - Convert.ToDouble(TXTCurramt.Text);
                        Sql = "INSERT INTO [WEBX_GENERAL_POASSET_PAYDET] SELECT [Billno],[Vendorcode],null,[DUEDT],PAYDT='" + fn.Mydate1(TxtVoucherDT.Text) + "','" + Voucherno + "',[Netamt]," + CurrPayment + "," + PendPaymt + ",'" + DDL_Tdstype.SelectedValue.ToString() + "','" + Cashcode + "','" + Bankaccode + "'," + CashAmt + "," + ChqAmt + "," + ChqNo + "," + ChqDate + "  FROM  WEBX_PO_BILL_hdr WHERE Billno='" + LblBillno.Text + "'";
                        Response.Write("<br>Sql-" + Sql);
                        sqlcmd = new SqlCommand(Sql, conn, trans);
                        sqlcmd.ExecuteNonQuery();

                        Sql = "update WEBX_PO_BILL_hdr set pendamt=isnull(pendamt,0)-" + CurrPayment + " ,finclosedt='" + fn.Mydate1(TxtVoucherDT.Text) + "',voucherNo='" + Voucherno + "',PAYDT='" + fn.Mydate1(TxtVoucherDT.Text) + "'   where  Billno='" + LblBillno.Text + "'";
                        sqlcmd = new SqlCommand(Sql, conn, trans);
                        sqlcmd.ExecuteNonQuery();

                        Sql = "update WEBX_GENERAL_POASSET_HDR set pendamt=isnull(pendamt,0)-" + CurrPayment + ",PAIDAMT=isnull(PAIDAMT,0)-" + CurrPayment + ",finclosedt='" + fn.Mydate1(TxtVoucherDT.Text) + "',voucherNo='" + Voucherno + "',PAYDT='" + fn.Mydate1(TxtVoucherDT.Text) + "'   where  Billno='" + LblBillno.Text + "'";
                        sqlcmd = new SqlCommand(Sql, conn, trans);
                        sqlcmd.ExecuteNonQuery();

                    }
                }
                if (PayMode == "Cash")
                {
                    ChqAmt = "0.00";
                    ChqNo = "NULL";
                    ChqDate = "NULL";
                    CashAmt = Convert.ToString(CurrPaymentTot - Convert.ToDouble(TxtTds_Amt.Text));
                }
                else if (PayMode == "Bank")
                {
                    CashAmt = "0.00";
                    ChqAmt = Convert.ToString(CurrPaymentTot - Convert.ToDouble(TxtTds_Amt.Text));
                }
                if (PayMode == "Bank" || PayMode == "Both")
                {
                    Sql = "insert into WEBX_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values " +
                        "(" + ChqNo + "," + ChqDate + "," + CurrPaymentTot + ",'" + ddrBankaccode.SelectedItem.Text.ToString() + "','" + ptmsptcd + "','" + ptmsptnm + "',Null,Null,Null,'" + Session["Empcd"].ToString() + "','" + fn.GetEmpName(Session["Empcd"].ToString()) + "','" + Session["brcd"].ToString() + "','" + fn.GetLocation(Session["brcd"].ToString()) + "',NULL,NULL,null,'O',NULL,'" + CurrPaymentTot + "')";
                    Response.Write("<br>Sql-" + Sql);
                    sqlcmd = new SqlCommand(Sql, conn, trans);
                    sqlcmd.ExecuteNonQuery();

                    Sql = "update WEBX_chq_det set voucherNo='" + Voucherno + "',transdate='" + fn.Mydate1(TxtVoucherDT.Text) + "',acccode='" + Bankaccode + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where chqno=" + ChqNo + " and convert(varchar,chqdt,106)=convert(datetime," + ChqDate + ",106)";
                    sqlcmd = new SqlCommand(Sql, conn, trans);
                    sqlcmd.ExecuteNonQuery();

                }

                Sql = "Insert into WEBX_vouchertrans (finyear,Transdate,Voucherno,Acccode,chqno,chqdate,Debit,Credit,Narration,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,tdsfor,Cash_Acccode,Bank_Acccode,CashAmt,opertitle) values " + "('" + Session["finyear"].ToString() + "','" + fn.Mydate1(TxtVoucherDT.Text) + "','" + Voucherno + "','UNS0004'," + ChqNo + "," + ChqDate + "," + CurrPaymentTot + ",0,'PO Balance Payment','" + PayMode + "',0,NULL,'" + Session["brcd"].ToString() + "',Null,'" + Session["empcd"].ToString() + "',getdate(),'N','Submitted',NULL,'" + Vendorcode + "','" + Session["empcd"].ToString() + "',0,0," + TxtTds_Rate.Text + "," + TxtTds_Amt.Text + ",0,0,0,0,0,0," + NetPay + ",'" + ptmsptcd + "','" + ptmsptnm + "','V','" + V_PANNO.Text + "','" + V_Staxno.Text + "',Null,'" + ddrBankaccode.SelectedValue.ToString() + "'," + ChqAmt + ",'" + PayMode + "',0,0,'" + DDL_Tdstype.SelectedValue.ToString() + "',NULL,NULL,'" + DDL_TdstFor.SelectedValue.ToString() + "','" + Cashcode + "','" + Bankaccode + "'," + CashAmt + ",'PO Balance Payment')";
                Response.Write("<br>Sql-" + Sql);
                sqlcmd = new SqlCommand(Sql, conn, trans);
                sqlcmd.ExecuteNonQuery();
                //Sql = "insert into WEBX_vouchertrans_arch select Srno,finyear,Transdate,Voucherno,Acccode,Chqno,Chqdate,Debit,Credit,Chqcleardate,Narration,Payto,Bookcode,Transtype,Currbalance,DocNo,Docsf,Brcd,Deptcode,Oppaccount,Entryby,Entrydt,Voucher_Cancel,autoentry,opertitle,transNo,PBOV_CODE,PBOV_NAME,PBOV_TYP,oppacccode,voucher_status,v_approve_reject_by,v_approve_reject_branch,v_closed_by,v_closed_branch,v_approve_reject_dt,v_closed_dt,Appr_Credit,Cancel_Reason,empcdfor,preparefor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othertax,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,Panno,servicetaxNo,DEDUCTION,TotChrg,BANKNAME,CHQAMT,TRANSMODE,tdsacccode,svctaxacccode,othChrg,servicetaxCharged,depositdt,servchargeper,sundrychrg,formchrg,clearchrg,vendosdays,vendbillduedt,vendbillno,vendbilldt,tdsgrpcode,tdsgrpdesc,tdsfor,Manual_voucherno,Business_type,Accounting_Brcd,Refno,H_edu_cess,Cash_Acccode,Bank_Acccode,CashAmt,SBCess,SBCRate,KKCess,KKCRate from  WEBX_vouchertrans where voucherN//o='" + Voucherno + "'";
Sql = "insert into WEBX_vouchertrans_arch (finyear,Transdate,Voucherno,Acccode,chqno,chqdate,Debit,Credit,Narration,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,tdsfor,Cash_Acccode,Bank_Acccode,CashAmt,opertitle) select finyear,Transdate,Voucherno,Acccode,chqno,chqdate,Debit,Credit,Narration,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,tdsfor,Cash_Acccode,Bank_Acccode,CashAmt,opertitle from  WEBX_vouchertrans where voucherNo='" + Voucherno + "'";
                Response.Write("<br>Sql-" + Sql);
                sqlcmd = new SqlCommand(Sql, conn, trans);
                sqlcmd.ExecuteNonQuery();

                Sql = "delete from  WEBX_vouchertrans where voucherNo='" + Voucherno + "'";
                sqlcmd = new SqlCommand(Sql, conn, trans);
                sqlcmd.ExecuteNonQuery();

                Sql = "exec usp_POBillTransaction 2,'" + Voucherno + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + SessionUtilities.DefaultCompanyCode.ToString() + "'";
                sqlcmd = new SqlCommand(Sql, conn, trans);
                sqlcmd.ExecuteNonQuery();


                trans.Commit();
                conn.Close();
                isSuccess = true;
                ConsumeToken();
                //Response.Redirect("./Payment_Done.aspx?Voucherno=" + Voucherno);
            }
        }
        catch (Exception e1)
        {
            //Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            trans.Rollback();
            conn.Close();
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            usrMsg.Show(msg);
            return;
            //Response.Redirect("Message.aspx?" + e1.Message);
            //Response.End();
        }
        finally
        {
            trans.Dispose();
            if (conn != null)
                conn.Close();
        }
        if(isSuccess)
            Response.Redirect("./Payment_Done.aspx?Voucherno=" + Voucherno,false);

    }
}
