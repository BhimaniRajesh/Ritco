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

public partial class GUI_UNI_MIS_Bill_Register_BillNo_Popup : System.Web.UI.Page
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
    protected void Page_Load(object sender, EventArgs e)
    {
        Initialize(); 
        lblBillNo.Text = Request.QueryString["Bill_No"];
        lblBillNo1.Text = Request.QueryString["Bill_No"];
        lblBillNo2.Text = Request.QueryString["Bill_No"];

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection sqlConn = new SqlConnection("Data Source=ecfy15;Initial Catalog=WebXpressForNet;UID=sa;pwd=sa");
        sqlConn.Open();
        strQuery = "Select H.BILLNO,rtrim(left(convert(varchar,H.BGNDT,106),6))+' '+right(convert(varchar,H.BGNDT,106),2) as BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,sum(d.dkttot)as BILLAMT,sum(D.SVRCAMT) as STAX,sum(D.DKTCHG)as DKTCHG,sum(D.FOVCHG)as FOVCHG,sum(D.OTCHG)as OTCHG,h.manualbillno from Webx_BILLMST h,Webx_BILLDET D  Where H.billno=D.Billno and  H.billno ='" + lblBillNo.Text + "' group by H.BILLNO,H.BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,h.manualbillno union Select H.BILLNO,rtrim(left(convert(varchar,H.BGNDT,106),6))+' '+right(convert(varchar,H.BGNDT,106),2) as BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,sum(D.DKTtot)as BILLAMT,sum(D.SVRCAMT) as STAX,sum(D.DKTCHG)as DKTCHG,sum(D.FOVCHG)as FOVCHG,sum(D.OTCHG)as OTCHG,h.manualbillno from Webx_BILLMST_ARCH h,Webx_BILLDET_ARCH D  Where H.billno=D.Billno and  H.billno ='" + lblBillNo.Text + "' group by H.BILLNO,H.BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,h.manualbillno";
        SqlCommand cmd = new SqlCommand(strQuery, sqlConn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblManBillNo.Text = Convert.ToString(dr["manualbillno"]);
            lblManBillNo1.Text = Convert.ToString(dr["manualbillno"]);
            lblManBillNo2.Text = Convert.ToString(dr["manualbillno"]);
            lblBillDate.Text = Convert.ToString(dr["BGNDT"]);
            lblBillDate1.Text = Convert.ToString(dr["BGNDT"]);
            lblBillDate2.Text = Convert.ToString(dr["BGNDT"]);
            lblName.Text = Convert.ToString(dr["PTMSNM"]);
            lblName1.Text = Convert.ToString(dr["PTMSNM"]);
            lblName2.Text = Convert.ToString(dr["PTMSNM"]);
            lblCustCode.Text = Convert.ToString(dr["PTMSCD"]);
            lblCustCode1.Text = Convert.ToString(dr["PTMSCD"]);
            lblCustCode2.Text = Convert.ToString(dr["PTMSCD"]);
            lblNetPay.Text = Convert.ToString(dr["BILLAMT"]);
        }
        dr.Close();
        //strQuery = "select UCHG06,UCHG07,UCHG08,UCHG09,UCHG10,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + lblBillNo.Text + "' order by d.trn_mod,d.DOCKDT";
        strQuery = "select sum(D.DKTTOT-(a.SVCtax + a.CESS)) as BILLAMT,sum(a.SVCtax) as STAX,sum(a.CESS) as CESS,sum(a.FREIGHT) as FREIGHT ,0 as diesel_chrg , sum(a.schg01) as DKTCHG,sum(a.schg02) as COLL_LOADCHRG,sum(a.schg03) as OTCHG,sum(a.schg04) as nform_chrg,sum(a.schg05) as hld_chrg,sum(a.schg06) as oct_chrg,sum(a.schg07) as DCCharge,sum(a.schg08) as DDCharge, sum(a.schg09) as state_chrg,sum(a.schg10) as hld_dlychrg,sum(FOV) as FOV,sum(a.schg12) as CODCHG,sum(a.schg13) as DACC_CHRG,sum(a.schg14) as demchgs,sum(a.schg15) as MathadiCharge,sum(a.schg16) as RiskCharge,sum(a.schg17) as COLL_SURCHRG,sum(a.schg22) as COLL_DCDDCHRG,sum(a.schg23) as COLL_STSRECHRG,sum(a.schg18) as StatisticalCharge,sum(schg19) as DIPLOMATCHG,sum(a.schg20) as FUELCHRG,sum(a.uchg01) as User_chrg_1,sum(a.uchg02) as User_chrg_2,sum(a.uchg03) as User_chrg_3,sum(a.uchg04) as User_chrg_4,sum(a.uchg05) as User_chrg_5, sum(a.schg21) as FODCharge ,sum(a.uchg06) as User_chrg_6,sum(a.uchg07) as User_chrg_7,sum(a.uchg08) as User_chrg_8,sum(uchg09) as User_chrg_9,sum(uchg10) as User_chrg_10,sum(a.hedu_cess) as hieducess from Webx_BILLDET D with(Nolock),vw_docket_net a with(Nolock) Where  d.dockno=a.dockno and billno in  ('" + lblBillNo.Text + "') and d.docksf='.'";
        cmd = new SqlCommand(strQuery, sqlConn);
        SqlDataReader drd = cmd.ExecuteReader();
        while (drd.Read())
        {
            lblFreight.Text = Convert.ToString(drd["FREIGHT"]);
            lblFreight1.Text = Convert.ToString(drd["FREIGHT"]);
            lblFreight2.Text = Convert.ToString(drd["FREIGHT"]);
            lblDocChrg.Text = Convert.ToString(drd["DKTCHG"]);
            lblDocChrg1.Text = Convert.ToString(drd["DKTCHG"]);
            lblDocChrg2.Text = Convert.ToString(drd["DKTCHG"]);
            lblCollChrg.Text = Convert.ToString(drd["DCCharge"]);
            lblCollChrg1.Text = Convert.ToString(drd["DCCharge"]);
            lblCollChrg2.Text = Convert.ToString(drd["DCCharge"]);
            lblDevChrg.Text = Convert.ToString(drd["DDCharge"]);
            lblDevChrg1.Text = Convert.ToString(drd["DDCharge"]);
            lblDevChrg2.Text = Convert.ToString(drd["DDCharge"]);
            lblFOV.Text = Convert.ToString(drd["FOV"]);
            lblFOV1.Text = Convert.ToString(drd["FOV"]);
            lblFOV2.Text = Convert.ToString(drd["FOV"]);
            double misctot = Convert.ToDouble(drd["User_chrg_5"] == System.DBNull.Value ? 0.00 : drd["User_chrg_5"]) + Convert.ToDouble(drd["User_chrg_4"] == System.DBNull.Value ? 0.00 : drd["User_chrg_4"]) + Convert.ToDouble(drd["User_chrg_3"] == System.DBNull.Value ? 0.00 : drd["User_chrg_3"]) + Convert.ToDouble(drd["User_chrg_2"] == System.DBNull.Value ? 0.00 : drd["User_chrg_2"]) + Convert.ToDouble(drd["User_chrg_1"] == System.DBNull.Value ? 0.00 : drd["User_chrg_1"]) + Convert.ToDouble(drd["COLL_LOADCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_LOADCHRG"]) + Convert.ToDouble(drd["OTCHG"] == System.DBNull.Value ? 0.00 : drd["OTCHG"]) + Convert.ToDouble(drd["nform_chrg"] == System.DBNull.Value ? 0.00 : drd["nform_chrg"]) + Convert.ToDouble(drd["hld_chrg"] == System.DBNull.Value ? 0.00 : drd["hld_chrg"]) + Convert.ToDouble(drd["oct_chrg"] == System.DBNull.Value ? 0.00 : drd["oct_chrg"]) + Convert.ToDouble(drd["state_chrg"] == System.DBNull.Value ? 0.00 : drd["state_chrg"]) + Convert.ToDouble(drd["hld_dlychrg"] == System.DBNull.Value ? 0.00 : drd["hld_dlychrg"]) + Convert.ToDouble(drd["CODCHG"] == System.DBNull.Value ? 0.00 : drd["CODCHG"]) + Convert.ToDouble(drd["DACC_CHRG"] == System.DBNull.Value ? 0.00 : drd["DACC_CHRG"]) + Convert.ToDouble(drd["demchgs"] == System.DBNull.Value ? 0.00 : drd["demchgs"]) + Convert.ToDouble(drd["MathadiCharge"] == System.DBNull.Value ? 0.00 : drd["MathadiCharge"]) + Convert.ToDouble(drd["RiskCharge"] == System.DBNull.Value ? 0.00 : drd["RiskCharge"]) + Convert.ToDouble(drd["COLL_SURCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_SURCHRG"]) + Convert.ToDouble(drd["COLL_DCDDCHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_DCDDCHRG"]) + Convert.ToDouble(drd["COLL_STSRECHRG"] == System.DBNull.Value ? 0.00 : drd["COLL_STSRECHRG"]) + Convert.ToDouble(drd["StatisticalCharge"] == System.DBNull.Value ? 0.00 : drd["StatisticalCharge"]) + Convert.ToDouble(drd["DIPLOMATCHG"] == System.DBNull.Value ? 0.00 : drd["DIPLOMATCHG"]) + Convert.ToDouble(drd["FODCharge"] == System.DBNull.Value ? 0.00 : drd["FODCharge"]);
            lblOthChrg.Text = Convert.ToString(misctot);
            lblOthChrg1.Text = Convert.ToString(misctot);
            lblOthChrg2.Text = Convert.ToString(misctot);
            double DedChrg = Convert.ToDouble(drd["User_chrg_6"] == System.DBNull.Value ? 0.00 : drd["User_chrg_6"]) + Convert.ToDouble(drd["User_chrg_7"] == System.DBNull.Value ? 0.00 : drd["User_chrg_7"]) + Convert.ToDouble(drd["User_chrg_8"] == System.DBNull.Value ? 0.00 : drd["User_chrg_8"]) + Convert.ToDouble(drd["User_chrg_9"] == System.DBNull.Value ? 0.00 : drd["User_chrg_9"]) + Convert.ToDouble(drd["User_chrg_10"] == System.DBNull.Value ? 0.00 : drd["User_chrg_10"]);
            lblDeduChrg.Text = Convert.ToString(DedChrg);
            lblDeduChrg1.Text = Convert.ToString(DedChrg);
            lblDeduChrg2.Text = Convert.ToString(DedChrg);
            double Total = misctot + Convert.ToDouble(drd["FREIGHT"] == System.DBNull.Value ? 0.00 : drd["FREIGHT"]) + Convert.ToDouble(drd["DKTCHG"] == System.DBNull.Value ? 0.00 : drd["DKTCHG"]) + Convert.ToDouble(drd["DCCharge"] == System.DBNull.Value ? 0.00 : drd["DCCharge"]) + Convert.ToDouble(drd["DDCharge"] == System.DBNull.Value ? 0.00 : drd["DDCharge"]) + Convert.ToDouble(drd["FOV"] == System.DBNull.Value ? 0.00 : drd["FOV"]) - DedChrg;
            lblTot.Text = Convert.ToString(Total);
            lblTot1.Text = Convert.ToString(Total);
            lblTot2.Text = Convert.ToString(Total);
            lblSvcTax.Text = Convert.ToString(drd["STAX"]);
            lblSvcTax1.Text = Convert.ToString(drd["STAX"]);
            lblSvcTax2.Text = Convert.ToString(drd["STAX"]);
            lblCess.Text = Convert.ToString(drd["CESS"]);
            lblCess1.Text = Convert.ToString(drd["CESS"]);
            lblCess2.Text = Convert.ToString(drd["CESS"]);
            lblhigheducess.Text = Convert.ToString(drd["hieducess"]);
            lblhigheducess2.Text = Convert.ToString(drd["hieducess"]);
            lblhigheducess3.Text = Convert.ToString(drd["hieducess"]);
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
                //return;
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
                //return;
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
            lblNetPay1.Text = Convert.ToString(lblNetPay.Text);
            lbltotalinword1.Text = lbltotalinword2.Text = lbltotalinword.Text;
            lblNetPay2.Text = Convert.ToString(lblNetPay.Text);         
        }
        drd.Close();
        //select codedesc from webx_master_general where codeid='ST'
        strQuery = "select codedesc from webx_master_general where codeid='ST'";
        cmd = new SqlCommand(strQuery, sqlConn);
        drd = cmd.ExecuteReader();
        if(drd.Read())
        {
            if ((drd["codedesc"] != System.DBNull.Value) || (Convert.ToString(drd["codedesc"]) != ""))
            {
                lblsrvtax.Text = "Service Tax No: " + Convert.ToString(drd["codedesc"]);
            }
            else
            {
                lblsrvtax.Text = "";
            }
        }
        lblsrvtax2.Text = lblsrvtax.Text;
        lblsrvtax3.Text = lblsrvtax.Text;
        drd.Close();
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
}
