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
using System.IO;
using System.Data.SqlClient;

public partial class GUI_Finance_Billing_BillViewPrint_BillNo_Popup_RITCO : System.Web.UI.Page
{
    string strQuery;
    DateTime dtBillDt = new DateTime();
    string Number;
    string deciml;
    string _number;
    string _deciml;
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    public static string billamt = "";
    public string client;

    protected void Page_Load(object sender, EventArgs e)
    {
        client = Session["Client"].ToString();
        if (client == "RITCO")
        {
            client = "'RITCO LOGISTICS PVT. LTD.'";
            //lblsrvtax.Text = "Service Tax No : DL-11/ST/R-19/GTD/63/05";
            //lblPan_no1.Text = "PAN No. : AACCRO305G";
           
        }
        Initialize();
        lblBillNo.Text = Request.QueryString["Bill_No"];
        imgLogo.Src = "../../../images/Ritco_Bill_Logo.gif";
        img1.Src = "../../../images/Ritco_Bill_Logo.gif";
        //img2.Src = "../../../images/Ritco_Bill_Logo.gif";
        img6.Src = "../../../images/Ritco_Logo.gif";
        img7.Src = "../../../images/Ritco_Logo.gif";
        //img8.Src = "../../../images/Ritco_Logo.gif";
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        strQuery = "Select round(billamt,0) as billamt,remark from webx_billmst where billno ='" + lblBillNo.Text + "' ";
        SqlCommand cmd = new SqlCommand(strQuery, sqlConn);
        SqlDataReader dr = cmd.ExecuteReader();
        double billamount = 0;
        if (dr.Read())
        {
            //billamount = Convert.ToDouble(dr["BILLAMT"]);
            //billamt = billamount.ToString("F2");
            billamt = Convert.ToString(dr["billamt"]);
            lblRemarks111.Text = Convert.ToString(dr["remark"]);
        }
        dr.Close();
        strQuery = "Select c.custnm as CustomerName,c.CustAddress as CustAddress,H.BILLNO,rtrim(left(convert(varchar,H.BGNDT,106),6))+' '+right(convert(varchar,H.BGNDT,106),2) as BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,sum(d.dkttot)as BILLAMT,sum(D.SVRCAMT) as STAX,sum(D.DKTCHG)as DKTCHG,sum(D.FOVCHG)as FOVCHG,sum(D.OTCHG)as OTCHG,h.manualbillno from Webx_BILLMST h,Webx_BILLDET D,webx_custhdr c  Where H.billno=D.Billno and  c.custcd=h.ptmscd and  H.billno ='" + lblBillNo.Text + "' group by H.BILLNO,H.BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,c.custnm,c.CustAddress,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,h.manualbillno";
        cmd = new SqlCommand(strQuery, sqlConn);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblManBillNo.Text = Convert.ToString(dr["manualbillno"]);
            lblBillDate.Text = Convert.ToString(dr["BGNDT"]);
            lblName.Text = Convert.ToString(dr["CustomerName"]);
            lblAddress.Text = Convert.ToString(dr["CustAddress"]);
            lblCustCode.Text = Convert.ToString(dr["PTMSCD"]);
        }
        dr.Close();
        strQuery = "exec USP_BILLVIEW_DETAILS '" + lblBillNo.Text + "'";

        cmd = new SqlCommand(strQuery, sqlConn);
        SqlDataReader drd = cmd.ExecuteReader();
        while (drd.Read())
        {
            lblNoOfDocket.Text = Convert.ToString(drd["NoOfDocket"]);
            lblFreight.Text = Convert.ToString(drd["FREIGHT"]);
            lblDocChrg.Text = Convert.ToString(drd["DKTCHG"]);
            lblCollChrg.Text = Convert.ToString(drd["DCCharge"]);
            lblDevChrg.Text = Convert.ToString(drd["DDCharge"]);
            lblFOV.Text = Convert.ToString(drd["FOVCharge"]);
            double misctot = Convert.ToDouble(drd["User_chrg_5"] == System.DBNull.Value ? 0.00 : drd["User_chrg_5"]) + Convert.ToDouble(drd["User_chrg_4"] == System.DBNull.Value ? 0.00 : drd["User_chrg_4"]) + Convert.ToDouble(drd["User_chrg_3"] == System.DBNull.Value ? 0.00 : drd["User_chrg_3"]) + Convert.ToDouble(drd["User_chrg_2"] == System.DBNull.Value ? 0.00 : drd["User_chrg_2"]) + Convert.ToDouble(drd["User_chrg_1"] == System.DBNull.Value ? 0.00 : drd["User_chrg_1"]) + Convert.ToDouble(drd["COLL_LOADCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_LOADCHRG"]) + Convert.ToDouble(drd["OTCHG"] == System.DBNull.Value ? 0.00 : drd["OTCHG"]) + Convert.ToDouble(drd["nform_chrg"] == System.DBNull.Value ? 0.00 : drd["nform_chrg"]) + Convert.ToDouble(drd["hld_chrg"] == System.DBNull.Value ? 0.00 : drd["hld_chrg"]) + Convert.ToDouble(drd["oct_chrg"] == System.DBNull.Value ? 0.00 : drd["oct_chrg"]) + Convert.ToDouble(drd["state_chrg"] == System.DBNull.Value ? 0.00 : drd["state_chrg"]) + Convert.ToDouble(drd["hld_dlychrg"] == System.DBNull.Value ? 0.00 : drd["hld_dlychrg"]) + Convert.ToDouble(drd["CODCHG"] == System.DBNull.Value ? 0.00 : drd["CODCHG"]) + Convert.ToDouble(drd["DACC_CHRG"] == System.DBNull.Value ? 0.00 : drd["DACC_CHRG"]) + Convert.ToDouble(drd["demchgs"] == System.DBNull.Value ? 0.00 : drd["demchgs"]) + Convert.ToDouble(drd["MathadiCharge"] == System.DBNull.Value ? 0.00 : drd["MathadiCharge"]) + Convert.ToDouble(drd["RiskCharge"] == System.DBNull.Value ? 0.00 : drd["RiskCharge"]) + Convert.ToDouble(drd["COLL_SURCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_SURCHRG"]) + Convert.ToDouble(drd["COLL_DCDDCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_DCDDCHRG"]) + Convert.ToDouble(drd["COLL_STSRECHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_STSRECHRG"]) + Convert.ToDouble(drd["StatisticalCharge"] == System.DBNull.Value ? 0.00 : drd["StatisticalCharge"]) + Convert.ToDouble(drd["DIPLOMATCHG"] == System.DBNull.Value ? 0.00 : drd["DIPLOMATCHG"]) + Convert.ToDouble(drd["FODCharge"] == System.DBNull.Value ? 0.00 : drd["FODCharge"]);//+ Convert.ToDouble(drd["schg11"] == System.DBNull.Value ? 0.00 : drd["schg11"]);
            double DedChrg = Convert.ToDouble(drd["User_chrg_6"] == System.DBNull.Value ? 0.00 : drd["User_chrg_6"]) + Convert.ToDouble(drd["User_chrg_7"] == System.DBNull.Value ? 0.00 : drd["User_chrg_7"]) + Convert.ToDouble(drd["User_chrg_8"] == System.DBNull.Value ? 0.00 : drd["User_chrg_8"]) + Convert.ToDouble(drd["User_chrg_9"] == System.DBNull.Value ? 0.00 : drd["User_chrg_9"]) + Convert.ToDouble(drd["User_chrg_10"] == System.DBNull.Value ? 0.00 : drd["User_chrg_10"]);
            double Miscellianeous = Convert.ToDouble(drd["Miscellineous"] == System.DBNull.Value ? 0.00 : drd["Miscellineous"]);
            double Total = Convert.ToDouble(drd["FREIGHT"] == System.DBNull.Value ? 0.00 : drd["FREIGHT"]) + Convert.ToDouble(drd["DKTCHG"] == System.DBNull.Value ? 0.00 : drd["DKTCHG"]) + Convert.ToDouble(drd["DCCharge"] == System.DBNull.Value ? 0.00 : drd["DCCharge"]) + Convert.ToDouble(drd["DDCharge"] == System.DBNull.Value ? 0.00 : drd["DDCharge"]) + Convert.ToDouble(drd["FOVCharge"] == System.DBNull.Value ? 0.00 : drd["FOVCharge"]) + Miscellianeous;
            lblMiscellaneous.Text = Miscellianeous.ToString("F2");
            lblTot.Text = Total.ToString("F2");
            lblSvcTax.Text = Convert.ToString(drd["STAX"]);
            lblCess.Text = Convert.ToString(drd["CESS"]);
            lblhigheducess.Text = Convert.ToString(drd["hieducess"]);
            lblNetPay.Text = billamt;

            amtword = Convert.ToString(lblNetPay.Text);
            if (amtword == "")
            {
                amtword = "0";
            }
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
           
        }
        drd.Close();
        strQuery = "select codedesc from webx_master_general where codeid='ST'";
        cmd = new SqlCommand(strQuery, sqlConn);
        drd = cmd.ExecuteReader();
        if (drd.Read())
        {
            if ((drd["codedesc"] != System.DBNull.Value) || (Convert.ToString(drd["codedesc"]) != ""))
            {
                //lblsrvtax.Text = "Service Tax No: " + Convert.ToString(drd["codedesc"]);
            }
            else
            {
                //lblsrvtax.Text = "";
            }
        }
        drd.Close();
        string js = "<script language =\"javascript\" type=\"text/javascript\">window.print()</script>";
        Page.RegisterStartupScript("aaa", js);

    }
    public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }
                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";
                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;
                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        imgLogo.Visible = false;
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + lblBillNo.Text + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls);
        frm.RenderControl(htmlWrite);
        String tag = "<img src=" + Server.MapPath("webxpress_logo.gif") + " />";
        Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
