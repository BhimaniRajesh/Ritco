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
using WebX.Controllers;
  
public partial class GUI_Octroi_Octroi_Bill_PrepareOctBill : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public string custis = "";
    protected void Page_Load(object sender, EventArgs e)
    {  
        if (!IsPostBack)
        {
            pnlHeader.Visible = true;
            pnlDetail.Visible = false;
            pnlFooter.Visible = false;
            btn_submit.Visible = false;               

            fn.Fill_Customer_Dataset();
            fn.Fill_Location_Dataset();
            Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
        }
    }    
    protected void submit1_Click(object sender, EventArgs e)
    {
        try
        {
            pnlHeader.Visible = false;
            pnlDetail.Visible = true;
            pnlFooter.Visible = true;
            btn_submit.Visible = true;
            TB_Button.Visible = true;
            string billdate, Sublocation = "", collLocation = "", BT_Wise_YN = "N", BIll_POD_Approval_YN = "N";

            billdate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbgndt.Text = billdate.ToString();
            DateTime dt = DateTime.Today.AddDays(15);
            txtduedate.Text = dt.ToString("dd/MM/yyyy");
            custis = Billto.SelectedValue;
            lblCustomer_Name.Text = Party_code.Text;
            lblCustomerType.Text = Billto.SelectedItem.Text;


            SqlDataReader dr = null;
            string[] str = Party_code.Text.Split('~');

            Session["PartyCode"] = str[1].ToString();
            Session["PartyType"] = Billto.SelectedValue;

            hidCustomerTypeBillto.Value = Billto.SelectedValue;

            string sql = "exec Usp_Cust_Billdetails  '" + str[1].ToString() + "'";
            dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
            if (dr.Read())
            {
                Sublocation = dr["billsub_loccode"].ToString();
                collLocation = dr["billcol_loccode"].ToString();

                txtbillsubloc.Text = fn.GetLocation(Sublocation) + '~' + Sublocation;
                txtbillcolloc.Text = fn.GetLocation(collLocation) + '~' + collLocation;

                if (Sublocation == "")
                {
                    txtbillsubloc.Text = fn.GetLocation(SessionUtilities.CurrentBranchCode) + '~' + SessionUtilities.CurrentBranchCode;
                    Sublocation = SessionUtilities.CurrentBranchCode;
                }

                if (collLocation == "")
                {
                    txtbillcolloc.Text = fn.GetLocation(SessionUtilities.CurrentBranchCode) + '~' + SessionUtilities.CurrentBranchCode;
                    collLocation = SessionUtilities.CurrentBranchCode;
                }

                Lbl_Party_address.Text = dr["custaddress"].ToString();
                Lbl_Party_tellno.Text = dr["telno"].ToString();
                Lbl_Party_Email.Text = dr["emailids"].ToString();
                Lbl_Credit_Limit.Text = dr["credit_limit"].ToString();
                Lbl_Credit_days.Text = dr["credit_day"].ToString();
            }
            string Outstanding_amt = "0.00";
            sql = "exec WebxNet_OutStd_Cust_billLoc '" + collLocation + "', '" + str[1].ToString() + "'";
            dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
            if (dr.Read())
            {
                Outstanding_amt = dr.GetValue(3).ToString();
            }
            Lbl_Outstanding_amt.Text = Outstanding_amt.ToString();

            sql = "select RUleID+'~'+RULE_value+'~'+rule_Y_N from Webx_Modules_Rules WITH(NOLOCK) where Module_Name in ('Bill Generation')";
            dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
            string[] DR_Value_Arr = null;

            while (dr.Read())
            {
                DR_Value_Arr = dr.GetValue(0).ToString().Split('~');
                if (DR_Value_Arr[0] == "RULE01")
                {
                    BT_Wise_YN = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE02")
                {
                    BIll_POD_Approval_YN = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE03")
                {
                    Hnd_Mindate.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE04")
                {
                    Hnd_Maxdate.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE05")
                {
                    Hnd_Mindate.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE08")
                {
                    Hnd_OutStd_Limit_Allow.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE07")
                {
                    Hnd_BillGen_Loc_BasedOn.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE09")
                {
                    Hnd_ON_CR_Limit_Allow.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE13")
                {
                    Hnd_manual_billno_Mandatory.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE14")
                {
                    Hnd_Duplicate_check.Value = DR_Value_Arr[2];
                }

            }
            //Add Service Portion On 31 May 2015 By Bipin Rupavatiya
            DateTime curdt;
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            curdt = Convert.ToDateTime(txtbgndt.Text, enGB);
            HdnServiceTaxRate.Value = Convert.ToString(TaxRateController.GetServiceTaxRate(curdt));
            HdnEduCessRate.Value = Convert.ToString(TaxRateController.GetEduCessRate(curdt));
            HdnHEduCessRate.Value = Convert.ToString(TaxRateController.GetHEduCessRate(curdt));
            //
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Prepare Octroi Bill Error&detail1=Prepare Octroi Bill Error&detail2=" + strex);
            return;
        }
    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("PrepareOctBill.aspx");
    }
    protected void BtnBillGeneration_Click(object sender, EventArgs e)
    {
        try
        {
            string Branch_Code = SessionUtilities.CurrentBranchCode;
            string Branch_Name = fn.GetLocation(Branch_Code);
            string[] Party = Party_code.Text.Split('~');
            string[] BillSubBrcd = txtbillsubloc.Text.Split('~');
            string[] BillColBrcd = txtbillcolloc.Text.Split('~');
            string STax_Y_N = "", svctax_rate = "0", cess_rate = "0", H_cess_rate = "0";

            string sqlSTax_Y_N = "select * from webx_modules_rules where RULEID = 'RULE40' and Module_name = 'Prepare Octroi Bill' and Rule_DESC = 'Service Tax For Octroi Bill'";
            SqlDataReader drSTax_Y_N = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlSTax_Y_N);
            if (drSTax_Y_N.Read())
            {
                STax_Y_N = drSTax_Y_N["RULE_Y_N"].ToString();
                if (STax_Y_N == "Y")
                {
                    svctax_rate = drSTax_Y_N["RULE_VALUE"].ToString();
                    cess_rate = "2";
                    H_cess_rate = "1";
                }                
            }

            string Xml_BillMst = "<root><BillMst>";
            Xml_BillMst = Xml_BillMst + "<BGNDT>" + DateFunction.ConvertStringToDate(txtbgndt.Text.Trim()).ToString("MM/dd/yyyy") + "</BGNDT>";
            Xml_BillMst = Xml_BillMst + "<BDUEDT>" + DateFunction.ConvertStringToDate(txtduedate.Text.Trim()).ToString("MM/dd/yyyy") + "</BDUEDT>";
            Xml_BillMst = Xml_BillMst + "<BBRCD>" + Branch_Code.ToString() + "</BBRCD>";
            Xml_BillMst = Xml_BillMst + "<BBRNM>" + Branch_Name.ToString() + "</BBRNM>";
            Xml_BillMst = Xml_BillMst + "<PAYBAS>" + "6" + "</PAYBAS>";
            Xml_BillMst = Xml_BillMst + "<PTMSCD>" + Party[1].ToString() + "</PTMSCD>";
            Xml_BillMst = Xml_BillMst + "<PTMSNM>" + Party[0].ToString() + "</PTMSNM>";
            Xml_BillMst = Xml_BillMst + "<REMARK>" + txtRemark.Text.Trim() + "</REMARK>";
            Xml_BillMst = Xml_BillMst + "<BILLAMT>" + hidBillAmt.Value + "</BILLAMT>";
            Xml_BillMst = Xml_BillMst + "<PENDAMT>" + hidBillAmt.Value + "</PENDAMT>";
            Xml_BillMst = Xml_BillMst + "<BILLSTATUS>" + "Bill Generated" + "</BILLSTATUS>";
            Xml_BillMst = Xml_BillMst + "<closebill>" + "N" + "</closebill>";
            Xml_BillMst = Xml_BillMst + "<BGENEMPCD>" + Session["Empcd"].ToString() + "</BGENEMPCD>";
            Xml_BillMst = Xml_BillMst + "<BILL_CANCEL>" + "N" + "</BILL_CANCEL>";
            Xml_BillMst = Xml_BillMst + "<BILLSUBBRCD>" + BillSubBrcd[1].ToString() + "</BILLSUBBRCD>";
            Xml_BillMst = Xml_BillMst + "<BILLCOLBRCD>" + BillColBrcd[1].ToString() + "</BILLCOLBRCD>";
            Xml_BillMst = Xml_BillMst + "<SVRCAMT>" + hidTotStaxAmt.Value + "</SVRCAMT>";
            Xml_BillMst = Xml_BillMst + "<CESSAMT>" + hidTotCessAmt.Value + "</CESSAMT>";
            Xml_BillMst = Xml_BillMst + "<manualbillno>" + txtManualbillno.Text + "</manualbillno>";			
            Xml_BillMst = Xml_BillMst + "</BillMst></root>";

            string Xml_BillDet = "<root>";
            foreach (DataGridItem drow in OctroiBillDetails1.OctDetails.Items)
            {
                TextBox txtdockno = (TextBox)drow.FindControl("txtdockno");
                HiddenField hidStatus = (HiddenField)drow.FindControl("hidStatus");
                TextBox txtdeclval = (TextBox)drow.FindControl("txtdeclval");
                HiddenField hiddeclval = (HiddenField)drow.FindControl("hiddeclval");
                TextBox txtoctamt = (TextBox)drow.FindControl("txtoctamt");
                HiddenField hidoctamt = (HiddenField)drow.FindControl("hidoctamt");
                TextBox txtoctper = (TextBox)drow.FindControl("txtoctper");
                HiddenField hidoctper = (HiddenField)drow.FindControl("hidoctper");
                TextBox txtclearchrg = (TextBox)drow.FindControl("txtclearchrg");
                TextBox txtprochrg_per = (TextBox)drow.FindControl("txtprochrg_per");
                TextBox txtprochrg = (TextBox)drow.FindControl("txtprochrg");
                TextBox txtotchg = (TextBox)drow.FindControl("txtotchg");
                TextBox txtRate = (TextBox)drow.FindControl("txtRate");
                TextBox txtstax = (TextBox)drow.FindControl("txtstax");
                HiddenField hidstax = (HiddenField)drow.FindControl("hidstax");
                TextBox txtcess = (TextBox)drow.FindControl("txtcess");
                HiddenField hidcess = (HiddenField)drow.FindControl("hidcess");
                TextBox txthcess = (TextBox)drow.FindControl("txthcess");
                HiddenField hidhcess = (HiddenField)drow.FindControl("hidhcess");
                TextBox txttotalamt = (TextBox)drow.FindControl("txttotalamt");
                HiddenField hidtotalamt = (HiddenField)drow.FindControl("hidtotalamt");
                TextBox txtrcptno = (TextBox)drow.FindControl("txtrcptno");
                HiddenField hidrcptno = (HiddenField)drow.FindControl("hidrcptno");
                TextBox txtrcptdate = (TextBox)drow.FindControl("txtrcptdate");
                HiddenField hidrcptdate = (HiddenField)drow.FindControl("hidrcptdate");
                RadioButton rdbParty = (RadioButton)drow.FindControl("rdbParty");
                HiddenField hidPartyName = (HiddenField)drow.FindControl("hidPartyName");

                if (txtdockno.Text != "")
                {
                    Xml_BillDet = Xml_BillDet + "<BillDet>";
                    Xml_BillDet = Xml_BillDet + "<DOCKNO>" + txtdockno.Text + "</DOCKNO>";
                    Xml_BillDet = Xml_BillDet + "<DOCKSF>" + "." + "</DOCKSF>";                   
                    Xml_BillDet = Xml_BillDet + "<DKTTOT>" + hidtotalamt.Value + "</DKTTOT>";
                    Xml_BillDet = Xml_BillDet + "<OCT_RECEIPTNO>" + hidrcptno.Value + "</OCT_RECEIPTNO>";
                    Xml_BillDet = Xml_BillDet + "<OCT_AMT>" + WebXConvert.ToDouble(hidoctamt.Value).ToString("F2") + "</OCT_AMT>";                   
                    Xml_BillDet = Xml_BillDet + "<totamt>" + WebXConvert.ToDouble(hidBillAmt.Value).ToString("F2") + "</totamt>";
                    Xml_BillDet = Xml_BillDet + "<declval>" + WebXConvert.ToDouble(hiddeclval.Value).ToString("F2") + "</declval>";
                    Xml_BillDet = Xml_BillDet + "<OTCHG>" + txtotchg.Text + "</OTCHG>";
                    Xml_BillDet = Xml_BillDet + "<process_chrg>" + txtprochrg.Text + "</process_chrg>";
                    Xml_BillDet = Xml_BillDet + "<oct_percentage>" + hidoctper.Value + "</oct_percentage>";
                    Xml_BillDet = Xml_BillDet + "<clearance_chrg>" + txtclearchrg.Text + "</clearance_chrg>";
                    Xml_BillDet = Xml_BillDet + "<processing_per>" + txtprochrg_per.Text + "</processing_per>";
                    Xml_BillDet = Xml_BillDet + "<recptdt>" + DateFunction.ConvertStringToDate(hidrcptdate.Value).ToString("MM/dd/yyyy") + "</recptdt>";                    
                    Xml_BillDet = Xml_BillDet + "<octroipaid_by>" + Billto.SelectedValue + "</octroipaid_by>";
                    Xml_BillDet = Xml_BillDet + "<oct_Custcd>" + Party[1].ToString() + "</oct_Custcd>";
                    Xml_BillDet = Xml_BillDet + "<oct_Custnm>" + Party[0].ToString() + "</oct_Custnm>";
                    Xml_BillDet = Xml_BillDet + "<bill_mr_dt>" + DateFunction.ConvertStringToDate(txtbgndt.Text.Trim()).ToString("MM/dd/yyyy") + "</bill_mr_dt>";
                    Xml_BillDet = Xml_BillDet + "<customer_paidby>" + SessionUtilities.CurrentEmployeeID + "</customer_paidby>";
                    Xml_BillDet = Xml_BillDet + "<customer_paidat>" + Branch_Code.ToString() + "</customer_paidat>";
                    Xml_BillDet = Xml_BillDet + "<OCT_DET_YN>" + hidStatus.Value + "</OCT_DET_YN>";
                    
                    if (OctroiBillDetails1.hidSRule.Value == "Y")
                    {
                        Xml_BillDet = Xml_BillDet + "<SVRCAMT>" + WebXConvert.ToDouble(hidstax.Value).ToString("F2") + "</SVRCAMT>";
                        Xml_BillDet = Xml_BillDet + "<CESSAMT>" + WebXConvert.ToDouble(hidcess.Value).ToString("F2") + "</CESSAMT>";
                        Xml_BillDet = Xml_BillDet + "<Hedu_Cess>" + WebXConvert.ToDouble(hidhcess.Value).ToString("F2") + "</Hedu_Cess>";
						
                    }
                    else
                    {
                        Xml_BillDet = Xml_BillDet + "<SVRCAMT>" + "0" + "</SVRCAMT>";
                        Xml_BillDet = Xml_BillDet + "<CESSAMT>" + "0" + "</CESSAMT>";
                        Xml_BillDet = Xml_BillDet + "<Hedu_Cess>" + "0" + "</Hedu_Cess>";
						
                    }

                    if (Party[1].ToString() == "8888")
                    {
                        Xml_BillDet = Xml_BillDet + "<Party>" + "8888" + "</Party>";
                        if (rdbParty.Checked == true)
                        {
                            Xml_BillDet = Xml_BillDet + "<rbPartyStatus>" + "T" + "</rbPartyStatus>";
                            Xml_BillDet = Xml_BillDet + "<PartyName>" + hidPartyName.Value + "</PartyName>";
                        }
                        else
                        {
                            Xml_BillDet = Xml_BillDet + "<rbPartyStatus>" + "F" + "</rbPartyStatus>";
                            Xml_BillDet = Xml_BillDet + "<PartyName>" + hidPartyName.Value + "</PartyName>";
                        }
                    }
                    else
                    {
                        Xml_BillDet = Xml_BillDet + "<Party>" + "NA" + "</Party>";
                        Xml_BillDet = Xml_BillDet + "<rbPartyStatus>" + "NA" + "</rbPartyStatus>";
                        Xml_BillDet = Xml_BillDet + "<PartyName>" + "NA" + "</PartyName>";
                    }

                    Xml_BillDet = Xml_BillDet + "</BillDet> ";
                }
            }
            // Response.Write("<br>Xml_BillDet :- " + Xml_BillDet);            
            Xml_BillDet = Xml_BillDet + "</root>";


            string sql = "usp_Prepare_OctroiBill_Generate";
            SqlParameter[] parm = new SqlParameter[5];
            parm[0] = ControllersHelper.GetSqlParameter("@Bill_Location", Branch_Code.Trim(), SqlDbType.VarChar);
            parm[1] = ControllersHelper.GetSqlParameter("@Xml_BillMst", Xml_BillMst.Replace("&", "&amp;").Trim(), SqlDbType.Xml);
            parm[2] = ControllersHelper.GetSqlParameter("@Xml_BillDet", Xml_BillDet.Replace("&", "&amp;").Trim(), SqlDbType.Xml);
            parm[3] = ControllersHelper.GetSqlParameter("@FinYear", SessionUtilities.FinYear.Substring(2, 2).Trim(), SqlDbType.VarChar);
            parm[4] = ControllersHelper.GetSqlParameter("@Businesstype", "N", SqlDbType.VarChar);

            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sql, parm);

            string Billno = ds.Tables[0].Rows[0]["Billno"].ToString();
            string TranXaction = ds.Tables[0].Rows[0]["TranXaction"].ToString();
            Response.Redirect("PrepareOctBill_Done.aspx?billno=" + Billno + "&TranXaction=" + TranXaction,false);
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Prepare Octroi Bill Generation Error&detail1=Prepare Octroi Bill Generation Error&detail2=" + strex);
            return;
        }
    }    
}
