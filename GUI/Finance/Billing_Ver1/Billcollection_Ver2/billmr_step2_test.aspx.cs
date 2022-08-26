using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class Finance_Billing_Billcollection_billmr_step2 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    string Party_code = "", fromdt = "", Todt = "", fincmplbr = "", billno_nos = "", PAYBAS = "", ManualMR_Duplicate_Chk = "Y";
    string Footer_Visibleflag = "";
    string Xml_Dkt_Bill = "";

    public string GenXml
    {
        get {
            if (ViewState["Xml_Dkt_Wise_Bill_Coll"] != null)
                return ViewState["Xml_Dkt_Wise_Bill_Coll"] as string;
            else
                return "";
        }
        set {
            ViewState["Xml_Dkt_Wise_Bill_Coll"] = value;
        }
    }
     protected void Page_Load(object sender, EventArgs e)
    {
        Party_code = Request.QueryString.Get("Party_code");
        billno_nos = Session["billnonos"].ToString();// Request.QueryString.Get("billno_nos");
        fromdt = Request.QueryString.Get("fromdt");
        PAYBAS = Request.QueryString.Get("PAYBAS");
        Todt = Request.QueryString.Get("Todt");
        fincmplbr = Session["brcd"].ToString();
        lbldaterange.Text = fromdt.ToString() + "-" + Todt.ToString();
        lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
        lblmrsbr.Text = fincmplbr + ":" + fn.GetLocation(fincmplbr);
        lblpartydetail.Text = lblparty.Text;
        CheckBox Onaccount = (CheckBox)this.UCMyReceiptControls.FindControl("Onaccount");
        HiddenField Hnd_Party = (HiddenField)this.UCMyReceiptControls.FindControl("Hnd_Party");
        
        Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
        Onaccount.Enabled = false;  
        if (!IsPostBack)
        {
            BindGrid();
            Hnd_Party.Value = Party_code.ToString();
            txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            //Response.Write("<br>ManualMR_Duplicate_Chk:-" + ManualMR_Duplicate_Chk);
            if (ManualMR_Duplicate_Chk == "Y")
            {
               // Response.Write("<br>ManualMR_Duplicate_Chk:-" + ManualMR_Duplicate_Chk);
                Txt_manualMRsno.Attributes.Add("onblur", "ManualMRsno('" + Txt_manualMRsno.ClientID.ToString() + "')");
            }
        }
         
    }
   public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "WEBX_BILLMST_Detail_1 '" + Session["billnonos"].ToString() + "'";
        //Response.Write("sql:-" + sql);
        //Response.End();

        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        dockdata.DataSource = ds;
        dockdata.DataBind();

        sql = "select RUleID+'~'+RULE_value+'~'+rule_Y_N from Webx_Modules_Rules WITH(NOLOCK) where Module_Name in ('Bill Collection')";
        SqlDataReader dr = null;
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        string[] DR_Value_Arr = null;
        while (dr.Read())
        {
            DR_Value_Arr = dr.GetValue(0).ToString().Split('~');
            if (DR_Value_Arr[0] == "RULE03")
            {
                Hnd_Mindate.Value = DR_Value_Arr[1];
            }
            else if (DR_Value_Arr[0] == "RULE04")
            {
                Hnd_Maxdate.Value = DR_Value_Arr[1];
            }
            else if (DR_Value_Arr[0] == "RULE05")
            {
                Hnd_AlloW_BackDate.Value = DR_Value_Arr[2];
            }
            else if (DR_Value_Arr[0] == "RULE20")
            {
                ManualMR_Duplicate_Chk = DR_Value_Arr[2];
            }

           // Response.Write("<br>ManualMR_Duplicate_Chk:-" + ManualMR_Duplicate_Chk);
            
            //Hnd_Mindate.Value = dr.GetValue(0).ToString();
           // Hnd_AlloW_BackDate.Value = dr.GetValue(1).ToString();
           // Hnd_Maxdate.Value = dr.GetValue(2).ToString();
             
        }

        conn.Close(); 
    }
    int J = 0, RowCnt = 0;
    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        int Index_Plus = 5;
        GridView oGridView = (GridView)sender;
        if (oGridView.ID == "GridView1")
        {
            Index_Plus = 0;
        }
        RowCnt = RowCnt + 1;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
             GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
             TextBox[] txtcharge = new TextBox[23];
            // HiddenField Hnd_CHG;
             Label Header_Chg;
             HiddenField Hnd_CHG = (HiddenField)e.Row.FindControl("Hnd_SCHG");
             TextBox tds = (TextBox)e.Row.FindControl("tds");
             TextBox unexpamt = (TextBox)e.Row.FindControl("unexpamt");
            
             string[] Hnd_CHG_Arr = Hnd_CHG.Value.ToString().Split(new string[] { "*/" }, StringSplitOptions.None);
             if (oGridView.ID != "GridView1")
             {
                 tds.Attributes.Add("onblur", "javascript:Bill_Wise_Calc(this," + RowCnt + ")");
                 unexpamt.Attributes.Add("onblur", "javascript:Bill_Wise_Calc(this," + RowCnt + ")");
             }
             for (int i = 1; i <= Hnd_CHG_Arr.Length; i++)
             {
                 txtcharge[i] = (TextBox)e.Row.FindControl("CHG" + i.ToString());
                 // Hnd_CHG = (HiddenField)e.Row.FindControl("Hnd_CHG" + i.ToString());
                 if (oGridView.ID != "GridView1")
                 {
                     txtcharge[i].Attributes.Add("onblur", "javascript:Bill_Wise_Calc(this," + RowCnt + ")");
                 }
                 else
                 {
                     txtcharge[i].Attributes.Add("onblur", "javascript:Docket_Wise_Calc_1(" + HND_Dkt_Billno.Value + "," + RowCnt + ")");
                 }
                 e.Row.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());
                 oGridView.HeaderRow.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());
                 if (oGridView.ID == "GridView1")
                 {
                     if (Footer_Visibleflag == "")
                     {
                         Footer_Visibleflag = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString()).ToString();
                     }
                     else
                     {
                         Footer_Visibleflag = Footer_Visibleflag + '~' + Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString()).ToString();
                     }
                 }
                 Header_Chg = (Label)oGridView.HeaderRow.FindControl("Lbl_Chg_" + i.ToString());
                 Header_Chg.Text = Get_Charges_Header_Text(Hnd_CHG_Arr[i - 1].ToString());
             }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            string[] Arr_Footer_Visibleflag = Footer_Visibleflag.ToString().Split('~');
            for (int i = 1; i < 11; i++)
            {
                if (oGridView.ID == "GridView1")
                {
                  // string abc = Arr_Footer_Visibleflag[i-1];
                  // bool ABc = (Arr_Footer_Visibleflag[i - 1].ToString() == "False") ? false : true;
                   e.Row.Cells[i + Index_Plus].Visible = (Arr_Footer_Visibleflag[i - 1].ToString() == "False") ? false : true;
                   //oGridView.FooterRow.Cells[i + Index_Plus].Visible = ABc;
                }
            }
        }
    }
    public bool Get_Charges_Value(string Hnd_CHG_value) 
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        string Bill_ColFlag = Arr_Hnd_CHG[2].ToString();
        string Active_Flag = Arr_Hnd_CHG[3].ToString();
      //  string Active_Flag = Arr_Hnd_CHG[4].ToString();
        bool Rturn_Value = false;
        if (Bill_ColFlag == "Y" && Active_Flag == "Y")
        {
            Rturn_Value = true;
        }
        return Rturn_Value;
    }
    public string Get_Charges_Header_Text(string Hnd_CHG_value)
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        string Charges_Header_Text = Arr_Hnd_CHG[1].ToString() + "(" + Arr_Hnd_CHG[4].ToString() + ")";
        return Charges_Header_Text;
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
       

    }
    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
    protected void submit_Click(object sender, EventArgs e)
    {
          

    }
    protected void submit_Click1(object sender, EventArgs e)
    {
        TextBox txtChqNo = (TextBox)this.UCMyReceiptControls.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)this.UCMyReceiptControls.FindControl("txtChqDate");
        TextBox txtChqAmt = (TextBox)this.UCMyReceiptControls.FindControl("txtChqAmt");
        TextBox txtAmtApplA = (TextBox)this.UCMyReceiptControls.FindControl("txtAmtApplA");
        TextBox txtCashAmt = (TextBox)this.UCMyReceiptControls.FindControl("txtCashAmt");
        TextBox Txt_OnAccount_Balance = (TextBox)this.UCMyReceiptControls.FindControl("Txt_OnAccount_Balance");
        TextBox Txt_ColAmt = (TextBox)this.UCMyReceiptControls.FindControl("Txt_ColAmt");
        TextBox txtRecBank = (TextBox)this.UCMyReceiptControls.FindControl("txtRecBank");
        TextBox Txt_BankBR = (TextBox)this.UCMyReceiptControls.FindControl("Txt_BankBR");
        TextBox txtNetPay = (TextBox)this.UCMyReceiptControls.FindControl("txtNetPay");
        DropDownList ddlPayMode = (DropDownList)this.UCMyReceiptControls.FindControl("ddlPayMode");
        DropDownList ddrCashcode = (DropDownList)this.UCMyReceiptControls.FindControl("ddrCashcode");
        DropDownList ddrBankaccode = (DropDownList)this.UCMyReceiptControls.FindControl("ddrBankaccode");
        DropDownList DDL_Tdstype = (DropDownList)this.UCMyReceiptControls.FindControl("DDL_Tdstype");
        CheckBox Onaccount = (CheckBox)this.UCMyReceiptControls.FindControl("Onaccount");
        RadioButtonList rdDiposited = (RadioButtonList)this.UCMyReceiptControls.FindControl("rdDiposited");
        HiddenField Hnd_Party = (HiddenField)this.UCMyReceiptControls.FindControl("Hnd_Party");
        string Str_Onaccount = "N";
        if (Onaccount.Checked)
        {
            Str_Onaccount = "Y";
        }
        string[] Diposited = rdDiposited.Text.ToString().Split(',');

        string Xml_Chq_Det = "<root><ChqDet>";
        Xml_Chq_Det = Xml_Chq_Det + "<Chqno>" + txtChqNo.Text.ToString() + "</Chqno>";
        Xml_Chq_Det = Xml_Chq_Det + "<Chqdt>" + fn.Mydate1(txtChqDate.Text.ToString()) + "</Chqdt>";
        Xml_Chq_Det = Xml_Chq_Det + "<Chqamt>" + txtChqAmt.Text.ToString() + "</Chqamt>";
        Xml_Chq_Det = Xml_Chq_Det + "<Banknm>" + txtRecBank.Text.ToString() + "</Banknm>";
        Xml_Chq_Det = Xml_Chq_Det + "<Bankbrn>" + Txt_BankBR.Text.ToString() + "</Bankbrn>";
        Xml_Chq_Det = Xml_Chq_Det + "<Ptmsptcd>" + Hnd_Party.Value.ToString() + "</Ptmsptcd>";
        Xml_Chq_Det = Xml_Chq_Det + "<Ptmsptnm>" + fn.Getcustomer(Hnd_Party.Value.ToString()) + "</Ptmsptnm>";
        Xml_Chq_Det = Xml_Chq_Det + "<ColAmt>" + Txt_ColAmt.Text.ToString() + "</ColAmt>";
        Xml_Chq_Det = Xml_Chq_Det + "<brcd>" + Session["brcd"].ToString() + "</brcd>";
        Xml_Chq_Det = Xml_Chq_Det + "<Acccode>" + ddrBankaccode.SelectedValue.ToString() + "</Acccode>";
        Xml_Chq_Det = Xml_Chq_Det + "<Onaccount>" + Str_Onaccount.ToString() + "</Onaccount>";
        Xml_Chq_Det = Xml_Chq_Det + "<Diposited>" + Diposited[0] + "</Diposited>";
        Xml_Chq_Det = Xml_Chq_Det + "</ChqDet></root>";

        string Xml_BillMR_DET = "<root>", MR_Amt_Error_Flag = "N", ErrMsg = "", Net_Amt_MrAmt_Flag = "N";
        double Tot_Tds = 0, Tot_Ded = 0;
        foreach (GridViewRow gridrow in dockdata.Rows)
        {
            MR_Amt_Error_Flag = "N";
            ErrMsg = "";
            Net_Amt_MrAmt_Flag = "N";
            HiddenField Hnd_Billno = (HiddenField)gridrow.FindControl("Hnd_Billno");
            HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");
            HiddenField Hidden_svctax_rate = (HiddenField)gridrow.FindControl("Hidden_svctax_rate");
            HiddenField Hidden_cess_rate = (HiddenField)gridrow.FindControl("Hidden_cess_rate");
            HiddenField Hidden_H_cess_rate = (HiddenField)gridrow.FindControl("Hidden_H_cess_rate");
            TextBox Totalamt = (TextBox)gridrow.FindControl("Totalamt");
            TextBox unexpamt = (TextBox)gridrow.FindControl("unexpamt");
            TextBox Txt_Remarks = (TextBox)gridrow.FindControl("Txt_Remarks");
            
            TextBox[] txtcharge = new TextBox[10];
            TextBox tds = (TextBox)gridrow.FindControl("tds");
            Tot_Tds = Tot_Tds + Convert.ToDouble(tds.Text.ToString());

            Xml_BillMR_DET = Xml_BillMR_DET + "<BillMRDET>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<TOTBILL>" + txtpendamt.Value.ToString() + "</TOTBILL>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<TDSDED>" + tds.Text.ToString() + "</TDSDED>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<NETAMT>" + Totalamt.Text.ToString() + "</NETAMT>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<UNEXPDED>" + unexpamt.Text.ToString() + "</UNEXPDED>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<DOCNO>" + Hnd_Billno.Value.ToString() + "</DOCNO>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<STax_Rate>" + Hidden_svctax_rate.Value.ToString() + "</STax_Rate>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<Cess_Rate>" + Hidden_cess_rate.Value.ToString() + "</Cess_Rate>";
            Xml_BillMR_DET = Xml_BillMR_DET + "<HCess_Rate>" + Hidden_H_cess_rate.Value.ToString() + "</HCess_Rate>";
            if (Convert.ToDouble(txtpendamt.Value.ToString()) == Convert.ToDouble(Totalamt.Text.ToString()))
            {
                Net_Amt_MrAmt_Flag = "Y";
                if (Convert.ToDouble(unexpamt.Text.ToString()) > 0)
                {
                    ErrMsg = "There is Some Mismatch For Net Amount And Pending Amount, PLz Tyr Again";
                    MR_Amt_Error_Flag = "Y";
                }
            }
            for (int i = 1; i < 11; i++)
            {
                txtcharge[i - 1] = (TextBox)gridrow.FindControl("CHG" + i.ToString());
                if (Convert.ToDouble(txtcharge[i - 1].Text.ToString()) > 0 && Net_Amt_MrAmt_Flag == "Y")
                {
                    ErrMsg = "There is Some Mismatch For Net Amount And Pending Amount, PLz Tyr Again";
                    MR_Amt_Error_Flag = "Y";
                }
                Xml_BillMR_DET = Xml_BillMR_DET + "<CHG" + i + ">" + txtcharge[i - 1].Text.ToString() + "</CHG" + i + ">";
                Tot_Ded = Tot_Ded + Convert.ToDouble(txtcharge[i - 1].Text.ToString());
            }
            Tot_Ded = Tot_Ded + Convert.ToDouble(tds.Text.ToString());
            Xml_BillMR_DET = Xml_BillMR_DET + "<Remarks>" + Txt_Remarks.Text.ToString() + "</Remarks>";
            
            Xml_BillMR_DET = Xml_BillMR_DET + "</BillMRDET>";
        }
        Xml_BillMR_DET = Xml_BillMR_DET + "</root>";

        string sql = "WEBX_Customer_Other";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = Party_code.Trim();
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();
        string PTMSCD = Hnd_Party.Value.Trim();
        string PTMSNM = fn.Getcustomer(Hnd_Party.Value.Trim());
        string PTMSTEL = "";
        string PTMSEMAIL = "";
        string PTMSADDR = "";
        while (dr.Read())
        {
            PTMSCD = Hnd_Party.Value.Trim();
            PTMSNM = fn.Getcustomer(Hnd_Party.Value.Trim());
            PTMSTEL = Convert.ToString(dr["CUSTTEL"]);
            PTMSEMAIL = Convert.ToString(dr["CUSTEMAIL"]);
            PTMSADDR = Convert.ToString(dr["CUSTADDRESS"]);
        }
        dr.Close();

        string TotalAmt = "0.00";
        if (ddlPayMode.SelectedValue.ToString() == "Cash")
        {
            TotalAmt = txtCashAmt.Text.ToString();
        }
        else if (ddlPayMode.SelectedValue.ToString() == "Bank")
        {
            TotalAmt = txtChqAmt.Text.ToString();
        }

        string Xml_MRHDR = "<root><MRHDR>";
        Xml_MRHDR = Xml_MRHDR + "<MRSDT>" + fn.Mydate1(txtVoucherDate.Text.ToString()) + "</MRSDT>";
        Xml_MRHDR = Xml_MRHDR + "<MRSTYPE>" + PAYBAS + "</MRSTYPE>";
        Xml_MRHDR = Xml_MRHDR + "<MRSBR>" + Session["brcd"].ToString() + "</MRSBR>";
        Xml_MRHDR = Xml_MRHDR + "<MRBRNNM>" + fn.GetLocation(Session["brcd"].ToString()) + "</MRBRNNM>";
        Xml_MRHDR = Xml_MRHDR + "<PTCD>" + PTMSCD + "</PTCD>";
        Xml_MRHDR = Xml_MRHDR + "<PTMSNM>" + PTMSNM + "</PTMSNM>";
        Xml_MRHDR = Xml_MRHDR + "<PTMSTEL>" + PTMSTEL + "</PTMSTEL>";
        Xml_MRHDR = Xml_MRHDR + "<PTMSADDR>" + PTMSADDR + "</PTMSADDR>";
        Xml_MRHDR = Xml_MRHDR + "<PAYBAS>" + PAYBAS + "</PAYBAS>";
        Xml_MRHDR = Xml_MRHDR + "<MRSAMT>" + TotalAmt.ToString() + "</MRSAMT>";
        Xml_MRHDR = Xml_MRHDR + "<NETAMT>" + TotalAmt.ToString() + "</NETAMT>";
        Xml_MRHDR = Xml_MRHDR + "<DEDUCTION>" + Tot_Ded.ToString("F2") + "</DEDUCTION>";
        Xml_MRHDR = Xml_MRHDR + "<MRSCASH>" + txtCashAmt.Text.ToString() + "</MRSCASH>";
        Xml_MRHDR = Xml_MRHDR + "<MRSCHQ>" + txtChqAmt.Text.ToString() + "</MRSCHQ>";
        Xml_MRHDR = Xml_MRHDR + "<MRSCHQNO>" + txtChqNo.Text.ToString() + "</MRSCHQNO>";
        Xml_MRHDR = Xml_MRHDR + "<MRSCHQDT>" + fn.Mydate1(txtChqDate.Text.ToString()) + "</MRSCHQDT>";
        Xml_MRHDR = Xml_MRHDR + "<MRSBANK>" + txtRecBank.Text.ToString() + "</MRSBANK>";
        Xml_MRHDR = Xml_MRHDR + "<MRS_CLOSED>" + "Y" + "</MRS_CLOSED>";
        Xml_MRHDR = Xml_MRHDR + "<DED_TDS>" + Tot_Tds.ToString("F2") + "</DED_TDS>";
        Xml_MRHDR = Xml_MRHDR + "<MR_CANCEL>" + "N" + "</MR_CANCEL>";
        Xml_MRHDR = Xml_MRHDR + "<BILLMR>" + "Y" + "</BILLMR>";
        Xml_MRHDR = Xml_MRHDR + "<finclosedt>" + fn.Mydate1(txtVoucherDate.Text.ToString()) + "</finclosedt>";
        Xml_MRHDR = Xml_MRHDR + "<paymode>" + ddlPayMode.SelectedValue.ToString() + "</paymode>";
        Xml_MRHDR = Xml_MRHDR + "<BankAcccode>" + ddrBankaccode.SelectedValue.ToString() + "</BankAcccode>";
        Xml_MRHDR = Xml_MRHDR + "<BankAccdesc>" + "" + "</BankAccdesc>";
        Xml_MRHDR = Xml_MRHDR + "<tdsacccode>" + DDL_Tdstype.SelectedValue.ToString() + "</tdsacccode>";
        Xml_MRHDR = Xml_MRHDR + "<tdsaccdesc>" + DDL_Tdstype.SelectedItem.ToString() + "</tdsaccdesc>";
        Xml_MRHDR = Xml_MRHDR + "<tdsfor>" + "" + "</tdsfor>";
        Xml_MRHDR = Xml_MRHDR + "<ManualMrsno>" + Txt_manualMRsno.Text.ToString() + "</ManualMrsno>";
        Xml_MRHDR = Xml_MRHDR + "<COMPANY_CODE>" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "</COMPANY_CODE>";
        Xml_MRHDR = Xml_MRHDR + "</MRHDR></root>";

		Response.Write("Sql :" + Xml_MRHDR);
		Response.End();

        /*sql = "Usp_BillMR_Generate";
        GenXml = "<root>" + GenXml + "</root>";
        SqlCommand sqlCmd = new SqlCommand(sql, conn);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@MR_Location", SqlDbType.VarChar).Value = Session["brcd"].ToString();
        sqlCmd.Parameters.Add("@Xml_Dkt_Bill", SqlDbType.Text).Value = GenXml.Replace("&", "&amp;").Replace("–", "-").Trim();//xmlTHC.Trim();
        sqlCmd.Parameters.Add("@Xml_Chq_Det ", SqlDbType.Text).Value = Xml_Chq_Det.Replace("&", "&amp;").Replace("–", "-").Trim();
        sqlCmd.Parameters.Add("@Xml_BillMR_DET", SqlDbType.Text).Value = Xml_BillMR_DET.Replace("&", "&amp;").Replace("–", "-").Trim();//xmlTHC.Trim();
        sqlCmd.Parameters.Add("@Xml_MRHDR", SqlDbType.Text).Value = Xml_MRHDR.Replace("&", "&amp;").Replace("–", "-").Trim();
        sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = Session["FinYear"].ToString().Substring(2, 2).Trim();
        sqlCmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = Session["empcd"].ToString();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        string MRSNO = ds.Tables[0].Rows[0]["MRSNO"].ToString();
        string TranXaction = ds.Tables[0].Rows[0]["TranXaction"].ToString();
        conn.Close();
        Response.Redirect("BillMrDone.aspx?MRSNO=" + MRSNO + "&TranXaction=" + TranXaction);*/
    }
    protected void Show_DocketWise_Collection(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        Tr_MultiView.Visible = true;
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        LinkButton L1=(LinkButton ) sender ;
        GridViewRow GR = L1.Parent.Parent as GridViewRow;
        //
        Label LblSrno = (Label)GR.FindControl("LblSrno");
        HND_Dkt_Billno.Value = LblSrno.Text;
        string sql = " exec WEBX_BILLMST_Detail_2 '" + L1.Text + "'";
        Lbl_MtV_1.Text = "Docket Wise Bill Collection Details For Billno - <b>" + L1.Text + "</b>";
       //HND_Dkt_Billno.Value = L1.Text;
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata1");
        GridView1.DataSource = ds;
        GridView1.DataBind();
        conn.Close();
        foreach (GridViewRow gridrow in dockdata.Rows)
        {

            LinkButton LK_Btn = (LinkButton)gridrow.FindControl("LK_Btn");
            TextBox[] txtcharge = new TextBox[10];
            LK_Btn.Enabled = false;
            if (LK_Btn.Text.ToString() == L1.Text)
             {
                for (int i = 1; i < 11; i++)
                {
                    txtcharge[i - 1] = (TextBox)gridrow.FindControl("CHG" + i.ToString());
                    txtcharge[i - 1].Enabled = false;
               }
           }

        }
        submit.Visible = false;
    }
    protected void Save_DocketWise_Collection(object sender, EventArgs e)
    {
        Tr_MultiView.Visible = false;
        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            Label Lbl_Dockno = (Label)gridrow.FindControl("Lbl_Dockno");
            TextBox Txt_Remarks = (TextBox)gridrow.FindControl("Txt_Remarks");
            TextBox[] txtcharge = new TextBox[10];
            Xml_Dkt_Bill = Xml_Dkt_Bill + "<Dkt_Bill>";
            Xml_Dkt_Bill = Xml_Dkt_Bill + "<Dockno>" + Lbl_Dockno.Text.ToString() + "</Dockno>";
            Xml_Dkt_Bill = Xml_Dkt_Bill + "<Billno>" + HND_Dkt_Billno.Value.ToString() + "</Billno>";
            for (int i = 1; i < 11; i++)
            {
                txtcharge[i-1] = (TextBox)gridrow.FindControl("CHG" + i.ToString());
                Xml_Dkt_Bill = Xml_Dkt_Bill + "<CHG" + i + ">" + txtcharge[i-1].Text.ToString() +"</CHG" + i + ">";
            }
            Xml_Dkt_Bill = Xml_Dkt_Bill + "<Remarks>" + Txt_Remarks.Text.ToString() + "</Remarks>";
            Xml_Dkt_Bill = Xml_Dkt_Bill + "</Dkt_Bill>";
        }
        foreach (GridViewRow gridrow in dockdata.Rows)
        {

            LinkButton LK_Btn = (LinkButton)gridrow.FindControl("LK_Btn");
            if (LK_Btn.Text.ToString() == HND_Dkt_Billno.Value.ToString())
            {
                LK_Btn.Enabled = false;
            }
            else
            {
                LK_Btn.Enabled = true;
            }
        }
        //Hnd_DKt_BIll.Value = Hnd_DKt_BIll.Value.ToString() + Xml_Dkt_Bill.ToString();
        //Xml_Dkt_Bill = Xml_Dkt_Bill + "</root>";
        HND_Dkt_Billno.Value = "";
        
       GenXml = GenXml + Xml_Dkt_Bill.ToString();
       submit.Visible = true;
        
    }
}
