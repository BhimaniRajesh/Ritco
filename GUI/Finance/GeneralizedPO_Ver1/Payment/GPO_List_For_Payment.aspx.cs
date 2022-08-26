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

public partial class GUI_Finance_GeneralizedPO_Payment_GPO_List_For_Payment : System.Web.UI.Page
{
    #region Variable[s]    
    string strDateRange, strven, strpo;
    DataSet ds1 = new DataSet();
    MyFunctions fn = new MyFunctions();
    string Fromdt = "", Todate = "";
    string strvendor = "";
    public string POCode, FromDate, ToDate, PartyCode, Str, DockNo;
    public string BillNo, DocTypeFlag, FlagDoc, RO, LO, ROText, LOText;
    string VendorName = "", Vendorcode = "";
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {        
        string sql = "";       
        
        if (!IsPostBack)
        {
            FromDate = Convert.ToString(Request.QueryString["fromdt"]);
            ToDate = Convert.ToString(Request.QueryString["todt"]);
            PartyCode = Convert.ToString(Request.QueryString["Party"]);
            RO = Convert.ToString(Request.QueryString["RO"]);
            LO = Convert.ToString(Request.QueryString["LO"]);
            ROText = Convert.ToString(Request.QueryString["ROText"]);
            LOText = Convert.ToString(Request.QueryString["LOText"]);
            POCode = ((Request.QueryString["POCode"] != null) ? Request.QueryString["POCode"].ToString() : "");
            lblFromDateToDate.Text = WebXConvert.ToDateTime(FromDate, "en-GB").ToString("dd MMM yyyy") + " - " + WebXConvert.ToDateTime(ToDate, "en-GB").ToString("dd MMM yyyy");
            lblPartyCode.Text = PartyCode;
            lblDocketNo.Text = POCode;
            lblRO.Text = ROText;
            lblLO.Text = LOText;
            if (POCode == "")
            {
                lblDocketNo.Text = "NA";
            }
            if (FromDate == "NA" && ToDate == "NA")
            {
                lblFromDateToDate.Text = "NA";
            }
            if (PartyCode == "" || PartyCode == null || PartyCode == "NA")
            {
                lblPartyCode.Text = "NA";
            }
            else
            {
                lblVendor.Text = PartyCode;
                string[] Vendor_Cls_Arr = PartyCode.ToString().Split('~');
                if (PartyCode != "" || PartyCode == "NA")
                {
                    VendorName = Vendor_Cls_Arr[0];
                    Vendorcode = Vendor_Cls_Arr[1];
                }
            }            
            ddlTDSBind();
            DipsplayReport();
            VendorDetails();
            tdDocketHeader.Text = "Selected Payment of General PO Criteria";
        }
        TxtVoucherDT.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
    }
    public void ddlTDSBind()
    {
        string sql = "select Acccode as code , accdesc+':'+company_acccode as name from vw_tds_payable With(NOLOCK)";        
        SqlDataReader dr_Tds;
        dr_Tds = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
        DDL_Tdstype.Items.Clear();
        DDL_Tdstype.CssClass = "blackfnt";
        DDL_Tdstype.Items.Add(new ListItem("Select", ""));
        while (dr_Tds.Read())
        {
            DDL_Tdstype.Items.Add(new ListItem(dr_Tds.GetValue(1).ToString(), dr_Tds.GetValue(0).ToString()));
        }
        dr_Tds.Close();
        DDL_Tdstype.Items.ToString().ToUpper();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
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
            throw ex1;
        }
    }
    public void DipsplayReport()
    {        
        string sql = "";
        sql = "Exec USP_GPO_LIST_FOR_PAYMENT '" + Fromdt + "','" + Todate + "','" + Vendorcode + "','" + POCode + "','" + SessionUtilities.FinYear + "','" + ROText + "','" + LOText + "' ";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql);
        GV_Booking.DataSource = ds;
        GV_Booking.DataBind();
        if (ds.Tables[0].Rows.Count > 0)
        {
            lblVendor.Text = ds.Tables[0].Rows[0]["VendorCd"].ToString();
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
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
        string Voucherno = fn.NextVoucherno(Session["Brcd"].ToString(), Session["Finyear"].ToString().Substring(2, 2));
        //string[] ARR_vendcd = lblloc.Text.Split(':');        
        //string ptmsptcd = ARR_vendcd[0].ToString(), ptmsptnm = ARR_vendcd[1].ToString();
        string ptmsptcd = "", ptmsptnm = "";
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
        SqlCommand sqlcmd;
        double CurrPayment = 0, PendPaymt = 0, Total = 0;
        SqlTransaction trans;
        trans = conn.BeginTransaction();

        try
        {
            if (PayMode == "Bank" || PayMode == "Both")
            {
                Sql = "INSERT INTO WEBX_CHQ_DET(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values " +
                    "(" + ChqNo + "," + ChqDate + "," + ChqAmt + ",'" + ddrBankaccode.SelectedItem.Text.ToString() + "','" + ptmsptcd + "','" + ptmsptnm + "',Null,Null,Null,'" + SessionUtilities.CurrentEmployeeID + "','" + fn.GetEmpName(SessionUtilities.CurrentEmployeeID) + "','" + SessionUtilities.CurrentBranchCode + "','" + fn.GetLocation(SessionUtilities.CurrentBranchCode) + "',NULL,NULL,null,'O',NULL,'" + ChqAmt + "')";
                object ObjSQL = SqlHelper.ExecuteDataset(trans, CommandType.Text, Sql);

                Sql = "UPDATE WEBX_CHQ_DET SET VOUCHERNO='" + Voucherno + "',transdate='" + fn.Mydate1(TxtVoucherDT.Text) + "',acccode='" + Bankaccode + "',depoloccode='" + SessionUtilities.CurrentBranchCode + "',DepoFlag='Y' where chqno=" + ChqNo + " and convert(varchar,chqdt,106)=convert(datetime," + ChqDate + ",106)";
                sqlcmd = new SqlCommand(Sql, conn, trans);
                sqlcmd.ExecuteNonQuery();
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
                    PendPaymt = Convert.ToDouble(LblPendamt.Text) - Convert.ToDouble(TXTCurramt.Text);
                    Sql = "INSERT INTO WEBX_GENERAL_POASSET_PAYDET SELECT [pocode],[Vendorcd],null,[DUEDT],[PAYDT],'" + Voucherno + "',[TotalAmt]," + CurrPayment + "," + PendPaymt + ",'" + DDL_Tdstype.SelectedValue.ToString() + "','" + Cashcode + "','" + Bankaccode + "'," + CashAmt + "," + ChqAmt + "," + ChqNo + "," + ChqDate + "  FROM  webx_GENERAL_POASSET_HDr WHERE POCODE='" + LblBillno.Text + "'";
                    Response.Write("<br>Sql-" + Sql);
                    sqlcmd = new SqlCommand(Sql, conn, trans);
                    sqlcmd.ExecuteNonQuery();

                    Sql = "update WEBX_GENERAL_POASSET_HDr set pendamt=isnull(pendamt,0)-" + CurrPayment + " ,finclosedt='" + fn.Mydate1(TxtVoucherDT.Text) + "',voucherNo='" + Voucherno + "',PAYDT='" + fn.Mydate1(TxtVoucherDT.Text) + "'   where  POCODE='" + LblBillno.Text + "'";
                    sqlcmd = new SqlCommand(Sql, conn, trans);
                    sqlcmd.ExecuteNonQuery();
                }
            }
            Sql = "Insert into WEBX_vouchertrans (finyear,Transdate,Voucherno,Acccode,chqno,chqdate,Debit,Credit,Narration,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,tdsfor,Cash_Acccode,Bank_Acccode,CashAmt) values " +
                "('" + Session["finyear"].ToString() + "','" + fn.Mydate1(TxtVoucherDT.Text) + "','" + Voucherno + "','" + HND_CR_Account.Value + "'," + ChqNo + "," + ChqDate + "," + NetPay + ",0,'PO Balance Payment','" + PayMode + "',0,NULL,'" + Session["brcd"].ToString() + "',Null,'" + Session["empcd"].ToString() + "',getdate(),'N','Submitted',NULL,'" + Vendorcode + "','" + Session["empcd"].ToString() + "',0,0," + TxtTds_Rate.Text + "," + TxtTds_Amt.Text + ",0,0,0,0,0,0," + NetPay + ",'" + ptmsptcd + "','" + ptmsptnm + "','V','" + V_PANNO.Text + "','" + V_Staxno.Text + "',Null,'" + ddrBankaccode.SelectedValue.ToString() + "'," + ChqAmt + ",'" + PayMode + "',0,0,'" + DDL_Tdstype.SelectedValue.ToString() + "',NULL,NULL,'" + DDL_TdstFor.SelectedValue.ToString() + "','" + Cashcode + "','" + Bankaccode + "'," + CashAmt + ")";
            Response.Write("<br>Sql-" + Sql);
            sqlcmd = new SqlCommand(Sql, conn, trans);
            sqlcmd.ExecuteNonQuery();
            Sql = "insert into WEBX_vouchertrans_arch select * from  WEBX_vouchertrans where voucherNo='" + Voucherno + "'";
            Response.Write("<br>Sql-" + Sql);
            sqlcmd = new SqlCommand(Sql, conn, trans);
            sqlcmd.ExecuteNonQuery();

            Sql = "delete from  WEBX_vouchertrans where voucherNo='" + Voucherno + "'";
            sqlcmd = new SqlCommand(Sql, conn, trans);
            sqlcmd.ExecuteNonQuery();

            //Sql = "exec usp_Vendor_PO_Billentry_transaction 2,'" + Voucherno + "','" + Session["finyear"].ToString().Substring(2, 2) + "'"; ;
            //sqlcmd = new SqlCommand(Sql, conn, trans);
            //sqlcmd.ExecuteNonQuery();

            trans.Commit();
            conn.Close();
            Response.Redirect("./Payment_Done.aspx?Voucherno=" + Voucherno, false);
        }
        catch (Exception e1)
        {
            trans.Rollback();
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            Response.End();
        }
    }
    public void VendorDetails()
    {
        if (lblVendor.Text != "")
        {
            string Vendor = lblVendor.Text.ToString();
            string[] Vendor_Cls_Arr = Vendor.ToString().Split('~');
            if (Vendor != "" || Vendor == "NA")
            {
                VendorName = Vendor_Cls_Arr[0];
                Vendorcode = Vendor_Cls_Arr[1];
            }
        }
        SqlDataReader dr;
        string Panno = "", servtaxno = "", sql = "";
        sql = "select Pan_no,servtaxno from webx_vendor_hdr A With(NOLOCK) where Vendorcode='" + Vendorcode + "'";
        dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
        while (dr.Read())
        {
            Panno = dr["Pan_no"].ToString();
            servtaxno = dr["servtaxno"].ToString();
        }
        dr.Close();
        V_Staxno.Text = servtaxno;
        V_PANNO.Text = Panno;
    }
}
