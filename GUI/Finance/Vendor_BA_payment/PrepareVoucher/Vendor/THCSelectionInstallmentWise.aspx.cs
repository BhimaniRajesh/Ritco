using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSelectionInstallmentWise : System.Web.UI.Page
{
    public string DocumentNo, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "", VendorCode="";
    public static string AdvanceBalance;
    public string[] VehicleArray, DocumentArray, ManualNoArray;
    public int intTotalRecords;
    int i;
    SqlCommand cmd;
    SqlDataAdapter sqlDA;
    DataSet ds;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        fromdt = Request.QueryString["dtFrom"];
        RouteMode = Request.QueryString["RouteMode"];
        VendorCode = Request.QueryString["VendorCode"];
        fromdt = fn.Mydate(fromdt);
        todt = Request.QueryString["dtTo"];
        todt = fn.Mydate(todt);
        
        if (!IsPostBack)
        {
            if(VendorCode =="")
            {
                Button1.Visible = false;
            }
            else
            {
                Button1.Visible = true;
            }
            BindGrid();
        }
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        ManualNo = Convert.ToString(Request.QueryString["ManualNo"]);
        VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
        AdvanceBalance = Convert.ToString(Request.QueryString["AdvanceBalance"]);
        SessionBranch = Session["BRCD"].ToString();
        lblDocDate.Text = fromdt + " TO " + todt;
        lblDocType.Text = "THC";

        Button1.Attributes.Add("onclick", "return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        Button1.Attributes.Add("onclick", "return CheckDocketSelection()");
        string str_datecls = "", str_manulthcno = "", str_vehno = "", str_thcno = "";

        if (AdvanceBalance == "A")
        {
            lblAdvanceBalance.Text = "Advance Payment";
            if (VehicleNo != "")
            {
                VehicleArray = VehicleNo.Split(',');

                for (i = 0; i < VehicleArray.Length; i++)
                {
                    s2 += "'" + VehicleArray[i] + "',";
                }

                s2 = s2.Substring(0, s2.Length - 1);
                str_vehno = "and T.VEHNO in( " + s2 + " )";
            }
            else if (ManualNo != "")
            {
                ManualNoArray = ManualNo.Split(',');
                for (i = 0; i < ManualNoArray.Length; i++)
                {
                    s2 += "'" + ManualNoArray[i] + "',";
                }
                s2 = s2.Substring(0, s2.Length - 1);
                str_manulthcno = " and T.Manualthcno in ( " + s2 + " ) ";
            }
            else if (DocumentNo != "")
            {
                DocumentArray = DocumentNo.Split(',');

                for (i = 0; i < DocumentArray.Length; i++)
                {
                    s2 += "'" + DocumentArray[i] + "',";
                }
                s2 = s2.Substring(0, s2.Length - 1);
                str_thcno = " and T.Thcno in ( " + s2 + " ) ";
                cmd = new SqlCommand(sql, conn);
            }
            else
            {
                str_datecls = "and convert(varchar,t.thcdt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ";
            }
            sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T where ISNULL(T.FromModule,'') != 'NEWMVC' AND ((select top 1 h.Vendor_Type from webx_VENDOR_HDR h where h.VendorCode=T.Vendor_Code) !=05 or (T.VENDOR_CODE='' OR T.VENDOR_CODE='"+VendorCode+"')) and pcamt !=0 and (ISNULL(AdvanceCash,0)>0 OR ISNULL(AdvanceCheque,0)>0 OR ISNULL(OtherAdvance,0)>0) and vendorBENo is null and balvoucherNo is null  and  (Cancelled='N' or Cancelled is null) and (((Advance_paid='O' or Advance_paid is null) and rut_cat='" + RouteMode.ToString() + "' ) or Advance_paid='N' or (Advance_paid='F' and advamt=0 and advamt_lastpaid=0))   and  T.finCmplbr='" + Session["brcd"].ToString() + "' " + str_datecls + str_thcno + str_manulthcno + str_vehno + "";
            cmd = new SqlCommand(sql, conn);
            sqlDA = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sqlDA.Fill(ds);

            GridTHCList.DataSource = ds;
            intTotalRecords = ds.Tables[0].Rows.Count;
            GridTHCList.DataBind();

        }
        else if (AdvanceBalance == "B")
        {
            lblAdvanceBalance.Text = "Balance Payment";

            if (VehicleNo != "")
            {
                VehicleArray = VehicleNo.Split(',');

                for (i = 0; i < VehicleArray.Length; i++)
                {
                    s2 += "'" + VehicleArray[i] + "',";
                }

                s2 = s2.Substring(0, s2.Length - 1);
                 str_vehno = "and T.VEHNO in( " + s2 + " )";
            }
            else if (ManualNo != "")
            {
                ManualNoArray = ManualNo.Split(',');
                for (i = 0; i < ManualNoArray.Length; i++)
                {
                    s2 += "'" + ManualNoArray[i] + "',";
                }
                s2 = s2.Substring(0, s2.Length - 1);
                str_manulthcno = " and T.Manualthcno in ( " + s2 + " ) ";
            }
            else if (DocumentNo != "")
            {
                DocumentArray = DocumentNo.Split(',');

                for (i = 0; i < DocumentArray.Length; i++)
                {
                    s2 += "'" + DocumentArray[i] + "',";
                }
                s2 = s2.Substring(0, s2.Length - 1);
                 str_thcno = " and T.Thcno in ( " + s2 + " ) ";
                cmd = new SqlCommand(sql, conn);
            }
            else
            {
                str_datecls = "and convert(varchar,t.thcdt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ";
            }
            sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T cross apply(select TCNT=count(*) from webx_thchdr where thcno=T.thcno and tobh_code is null)TH  OUTER APPLY(SELECT SUM(InstalmentAmount) AS ChqPaidAmt FROM dbo.Webx_Thc_AdvanceInstalment_Det WHERE ThcNo=T.thcno AND InstalmentType='ADVCHQ')Ch OUTER APPLY(SELECT SUM(InstalmentAmount) AS casePaidAmt FROM dbo.Webx_Thc_AdvanceInstalment_Det WHERE ThcNo=T.thcno AND InstalmentType='ADVCSH')cs where  ((select top 1 h.Vendor_Type from webx_VENDOR_HDR h where h.VendorCode=T.Vendor_Code) !=05 or  (T.VENDOR_CODE='' OR T.VENDOR_CODE='" + VendorCode + "')) and vendorBENo is null and balvoucherNo is null  and   (((thcclose_mode is null or thcclose_mode!='F') and thcnew_mode='F'  and  Advance_paid='F' and   rut_cat='" + RouteMode.ToString() + "' ) or (Advance_paid='Y' and (thcclose_mode is null )) ) AND T.AdvanceCash=ISNULL(cs.casePaidAmt,0) AND t.AdvanceCheque=ISNULL(ch.ChqPaidAmt,0) and balamtbrcd='" + Session["brcd"].ToString() + "'" + str_datecls + str_thcno + str_manulthcno + str_vehno + " and (case when t.sourcehb<>tobh_code and TCNT=1 then 1 when t.sourcehb=tobh_code and (select top 1 actarrv_dt from webx_thchdr where thcno=T.thcno order by thcdt desc) is not NULL then 1 end)=1 and netbalamt > 0 AND ISNULL(cancelled,'N')='N' and ISNULL(IsBTHProposal,0)=0 ";

            cmd = new SqlCommand(sql, conn);
            sqlDA = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sqlDA.Fill(ds);

            GridTHCList.DataSource = ds;
            intTotalRecords = ds.Tables[0].Rows.Count;
            GridTHCList.DataBind();
        }



    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridTHCList.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //*************Comminted by sandeep Maurya on 30 Dec 2016*******************************//
        string billno_nos = "";
        string billnonos = "";
        string docketlist = txtdocketlist.Value.ToString();
        //string[] docketlist_arr;
        //docketlist_arr = docketlist.Split(',');
        string checkeddockno = txtdocketlist_count.Value.ToString();
        int total_checked = Convert.ToInt16(docketlist);

        if (total_checked > 0)
        {
            string bill_no = docketlist;
            billno_nos = "'" + bill_no + "'";
            billnonos = bill_no;
        }
        else
        {
            for (int i = 0; i <= total_checked; i++)
            {
                string bill_no = docketlist.ToString();
                if (billno_nos == "")
                {
                    billno_nos = "'" + bill_no + "'";
                    billnonos = bill_no;
                }
                else
                {
                    billno_nos = billno_nos + "," + "'" + bill_no + "'";
                    billnonos = billnonos + "," + bill_no;
                }

            }
        }
        //**************************End*****************************************//

        if (Convert.ToString(Request.QueryString["AdvanceBalance"]) == "A")
        {
            string final = "?billno_nos=" + billnonos;
            final += "&checkeddockno=" + checkeddockno;
            //string final = "?billno_nos=1";
            //final += "&checkeddockno=" + hdnTHCNo.Value;
            final += "&fromdt=" + fromdt;
            final += "&Todt=" + todt;
            final += "&VendorCode=" + VendorCode;
            Response.Redirect("THCAdvancePaymentInstallmentWise.aspx" + final);
        }
        else if (Convert.ToString(Request.QueryString["AdvanceBalance"]) == "B")
        {
            string final = "?billno_nos=" + billnonos;
            final += "&checkeddockno=" + checkeddockno;
            //string final = "?billno_nos=1";
            //final += "&checkeddockno=" + hdnTHCNo.Value;
            final += "&fromdt=" + fromdt;
            final += "&Todt=" + todt;
            final += "&VendorCode=" + VendorCode;
            Response.Redirect("THCBalancePayment.aspx" + final);
        }
    }
}