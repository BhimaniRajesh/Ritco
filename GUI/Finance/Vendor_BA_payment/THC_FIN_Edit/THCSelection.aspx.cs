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

public partial class GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THCSelection : System.Web.UI.Page
{
    public string DocumentNo, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "";
    //public string billnonos, checkeddockno;
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
        //RouteMode = Request.QueryString["RouteMode"];
        fromdt = fn.Mydate(fromdt);
        todt = Request.QueryString["dtTo"];
        todt = fn.Mydate(todt);
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            ManualNo = Convert.ToString(Request.QueryString["ManualNo"]);
            //dtFrom = Convert.ToString(Request.QueryString["dtFrom"]);
            //dtTo = Convert.ToString(Request.QueryString["dtTo"]);
            VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
           // AdvanceBalance = Convert.ToString(Request.QueryString["AdvanceBalance"]);
            SessionBranch = Session["BRCD"].ToString();
            AdvanceBalance = "A";
            // f = Convert.ToDateTime(Request.QueryString["dtFrom"]);

            // t = Convert.ToDateTime(Request.QueryString["dtTo"]);


            lblDocDate.Text = fromdt + " TO " + todt;
            lblDocType.Text = "THC";

           // Button1.Attributes.Add("onclick", "return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
            string str_datecls = "", str_manulthcno = "", str_vehno = "", str_thcno = "";
            if (AdvanceBalance == "A")
            {
                //lblAdvanceBalance.Text = "Advance Payment";
                if (VehicleNo != "")
                {
                    VehicleArray = VehicleNo.Split(',');

                    for (i = 0; i < VehicleArray.Length; i++)
                    {
                        s2 += "'" + VehicleArray[i] + "',";
                        //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid FROM webx_THC_summary T where (case when T.balamtbrcd is null then  T.finCmplbr else  T.balamtbrcd end )='" + SessionBranch + "'   and   vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + dtFrom + "',106) and convert(varchar,'" + dtTo + "',106) and T.VEHNO = '" + VehicleArray[i] + "'  ORDER BY t.thcno,t.thcdt asc ";
                    }

                    s2 = s2.Substring(0, s2.Length - 1);
                    //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.Vendor_Name as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.VEHNO in( " + s2 + " )ORDER BY t.thcno,t.thcdt asc ";
                    str_vehno = "and T.VEHNO in( " + s2 + " )";
                    //cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();

                }
                else if (ManualNo != "")
                {
                    ManualNoArray = ManualNo.Split(',');
                    for (i = 0; i < ManualNoArray.Length; i++)
                    {
                        s2 += "'" + ManualNoArray[i] + "',";
                    }
                    s2 = s2.Substring(0, s2.Length - 1);
                    // sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.Vendor_Name as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.VEHNO in ( " + s2 + " )  ORDER BY t.thcno,t.thcdt asc ";
                    str_manulthcno = " and T.Manualthcno in ( " + s2 + " ) ";
                    //cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();

                }
                else if (DocumentNo != "")
                {
                    DocumentArray = DocumentNo.Split(',');

                    for (i = 0; i < DocumentArray.Length; i++)
                    {
                        s2 += "'" + DocumentArray[i] + "',";
                    }
                    s2 = s2.Substring(0, s2.Length - 1);
                    //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.THCNO in ( " + s2 + " ) ORDER BY t.thcno,t.thcdt asc ";
                    str_thcno = " and T.Thcno in ( " + s2 + " ) ";
                    cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();
                }
                else
                {
                    str_datecls = "and convert(varchar,t.thcdt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ";
                }
                sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T where ISNULL(T.FromModule,'') != 'NEWMVC' AND vendorBENo is null and balvoucherNo is null  and  (Cancelled='N' or Cancelled is null) and (Advance_paid='O' or Advance_paid is null or Advance_paid='N' or (Advance_paid='F' AND ADVAMT=0) /* or Advance_paid='Y'*/ )  AND (CASE WHEN MONTH(thcdt)<=3 THEN YEAR(thcdt) - 1 ELSE YEAR(thcdt) END) =" + Session["FinYear"].ToString() +" and thcclose_mode is null  " + str_datecls + str_thcno + str_manulthcno + str_vehno + "";
                //Response.Write("<br>sql-" + sql);
                //Response.End();
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
               // lblAdvanceBalance.Text = "Balance Payment";

                if (VehicleNo != "")
                {
                    VehicleArray = VehicleNo.Split(',');

                    for (i = 0; i < VehicleArray.Length; i++)
                    {
                        s2 += "'" + VehicleArray[i] + "',";
                        //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid FROM webx_THC_summary T where (case when T.balamtbrcd is null then  T.finCmplbr else  T.balamtbrcd end )='" + SessionBranch + "'   and   vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + dtFrom + "',106) and convert(varchar,'" + dtTo + "',106) and T.VEHNO = '" + VehicleArray[i] + "'  ORDER BY t.thcno,t.thcdt asc ";
                    }

                    s2 = s2.Substring(0, s2.Length - 1);
                    //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.Vendor_Name as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.VEHNO in( " + s2 + " )ORDER BY t.thcno,t.thcdt asc ";
                    str_vehno = "and T.VEHNO in( " + s2 + " )";
                    //cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();

                }
                else if (ManualNo != "")
                {
                    ManualNoArray = ManualNo.Split(',');
                    for (i = 0; i < ManualNoArray.Length; i++)
                    {
                        s2 += "'" + ManualNoArray[i] + "',";
                    }
                    s2 = s2.Substring(0, s2.Length - 1);
                    //sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.Vendor_Name as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.VEHNO in ( " + s2 + " )  ORDER BY t.thcno,t.thcdt asc ";
                    str_manulthcno = " and T.Manualthcno in ( " + s2 + " ) ";
                    //cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();

                }
                else if (DocumentNo != "")
                {
                    DocumentArray = DocumentNo.Split(',');

                    for (i = 0; i < DocumentArray.Length; i++)
                    {
                        s2 += "'" + DocumentArray[i] + "',";
                    }
                    s2 = s2.Substring(0, s2.Length - 1);
                    // sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T where vendorBENo is null and balvoucherNo is null and t.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and T.THCNO in ( " + s2 + " ) ORDER BY t.thcno,t.thcdt asc ";
                    str_thcno = " and T.Thcno in ( " + s2 + " ) ";

                    cmd = new SqlCommand(sql, conn);
                    //sqlDA = new SqlDataAdapter(cmd);
                    //ds = new DataSet();
                    //sqlDA.Fill(ds);

                    //GridTHCList.DataSource = ds;
                    //intTotalRecords = ds.Tables[0].Rows.Count;
                    //GridTHCList.DataBind();
                }
                else
                {
                    str_datecls = "and convert(varchar,t.thcdt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ";
                }
                sql = "select distinct Advance_paid,T.THCNO as thcno,T.thcsf as thcsf,Convert(varchar,t.thcdt,106) as thcdt, T.VEHNO as vehno,t.routecd as routecd,t.routename, t.thcbr as thcbr, t.coming_from as tobrcd,THCNEW_MODE,T.Advance_paid,T.VENDOR_CODE as VendorCode,T.VENDOR_NAME as VendorName FROM webx_THC_summary T where ISNULL(T.FromModule,'') != 'NEWMVC' AND vendorBENo is null and balvoucherNo is null  and  (thcclose_mode is null or thcclose_mode!='F') and thcnew_mode='F'  and  isnull(Advance_paid,'N')='N' and balamtbrcd='" + Session["brcd"].ToString() + "'" + str_datecls + str_thcno + str_manulthcno + str_vehno + "   and rut_cat='" + RouteMode.ToString() + "'";
                cmd = new SqlCommand(sql, conn);
                sqlDA = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sqlDA.Fill(ds);

                GridTHCList.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                GridTHCList.DataBind();
            }

        }

    }
    //protected void Button1_Click(object sender, EventArgs e)
    //{

    //    string billno_nos = "";
    //    string billnonos = "";
    //    string docketlist = txtdocketlist.Value.ToString();
    //    string[] docketlist_arr;
    //    docketlist_arr = docketlist.Split(',');
    //    string checkeddockno = txtdocketlist_count.Value.ToString();
    //    int total_checked = Convert.ToInt16(docketlist);

    //    if (total_checked == 1)
    //    {
    //        string bill_no = docketlist;
    //        billno_nos = "'" + bill_no + "'";
    //        billnonos = bill_no;
    //    }
    //    else
    //    {

    //        for (int i = 0; i <= total_checked; i++)
    //        {
    //            string bill_no = docketlist_arr[i].ToString();
    //            if (billno_nos == "")
    //            {
    //                billno_nos = "'" + bill_no + "'";
    //                billnonos = bill_no;
    //            }
    //            else
    //            {
    //                billno_nos = billno_nos + "," + "'" + bill_no + "'";
    //                billnonos = billnonos + "," + bill_no;
    //            }

    //        }
    //    }

    //    if (AdvanceBalance == "A")
    //    {
    //        string final = "?billno_nos=" + billnonos;
    //        final += "&checkeddockno=" + checkeddockno;
    //        final += "&fromdt=" + fromdt;
    //        final += "&Todt=" + todt;
    //        Response.Redirect("THCAdvancePayment.aspx" + final);

    //    }
    //    else if (AdvanceBalance == "B")
    //    {
    //        string final = "?billno_nos=" + billnonos;
    //        final += "&checkeddockno=" + checkeddockno;
    //        final += "&fromdt=" + fromdt;
    //        final += "&Todt=" + todt;
    //        Response.Redirect("THCBalancePayment.aspx" + final);
    //    }
    //}
}
