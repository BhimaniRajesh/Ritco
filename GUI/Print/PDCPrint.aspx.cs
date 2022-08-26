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

public partial class GUI_Print_PDCPrint : System.Web.UI.Page
{
    SqlConnection cn;
    static string strDRSNo;
    static string strPDCType;
    static string Vendor;
    public int cnt;
    public static string strRemainData;
    public static string strCal;
    public static string strPreparedBy;
    public static string strPreparedBy1, PDC_Detail;
    public double totpkgs=0.00, totactualweight=0.00, totfreightamount=0.00;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //scn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");

        if (IsPostBack == false)
        {
            strDRSNo = HttpUtility.UrlDecode(Request.QueryString["DRSNo"].ToString());
            strPDCType = "P";

            Prepare();
            getData();
            remainData();
            cal();
            dosprint();
        }
        btnPrint.Attributes.Add("onclick", "Javascript:OpenInWindow('PrintPRS.aspx','400','700','0','0')");
    }

    private void dosprint()
    {

        cn.Open();

        string sql1 = "Select top 1 pdcno As PRSNo, convert(varchar,pdcdt,6) As PRS_Date, pdcbr As PRS_Location, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),6) As thisDate,vendor_type,driverName ,empcd, Manualpdcno From webx_pdchdr with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        string sql2 = "Select top 1 pdcno As PRSNo, convert(varchar,pdcdt,6) As PRS_Date, pdcbr As PRS_Location, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),6) As thisDate,vendor_type,driverName ,empcd, Manualpdcno From webx_pdchdr with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        string sql3 = "Select S.* From (" + sql1 + " union " + sql2 + ")S";

        SqlCommand cmdGetData = new SqlCommand(sql3, cn);
        SqlDataReader dr = cmdGetData.ExecuteReader();

        while (dr.Read())
        {
            lblDrsNo.Text = dr[0].ToString();
            lblDrsDate.Text = dr[1].ToString();
            lblManualDrsNo.Text = dr["Manualpdcno"].ToString();
            lblRunSheetLoc.Text = dr[2].ToString();
            lblBaVendor.Text = dr[3].ToString();
            lblVhclNo.Text = dr[4].ToString();
            lblStartingKM.Text = dr[5].ToString();
            lblEndingKM.Text = dr[6].ToString();
            lblDistance.Text = dr[7].ToString();
            lblDateTime.Text = dr[8].ToString();
            lblDriverNm.Text = dr[10].ToString();
            lblPreparedBy.Text = dr[11].ToString();
            lblAt.Text = dr[2].ToString();

            string vendortype = dr["vendor_type"].ToString();

            switch (vendortype)
            {
                case "1":
                    vendortype = "Market";
                    break;
                case "2":
                    vendortype = "Attached";
                    break;
                case "3":
                    vendortype = "Own";
                    lblBaVendor.Text = "By Company";
                    break;
            }
        }
        dr.Close();
        cn.Close();


        PDC_Detail = "\\n";
        PDC_Detail = PDC_Detail + string.Empty.PadLeft(27) + "RELOGISTICS INDIA PVT LTD" + "\\n";
        PDC_Detail = PDC_Detail + string.Empty.PadLeft(38) + "PDC" + "\\n";
        PDC_Detail = PDC_Detail + "Page No. : 1" + "\\n";
        PDC_Detail = PDC_Detail + "PRS No:" + strDRSNo + string.Empty.PadLeft(30 - Convert.ToInt32(strDRSNo.ToString().Length)) + "Manual PRS No:" + lblManualDrsNo.Text + "\\n";
        PDC_Detail = PDC_Detail + "PRS Date:" + lblDrsDate.Text + "\\n";
        PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        PDC_Detail = PDC_Detail + "|RunSheetLoc|" + lblRunSheetLoc.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblRunSheetLoc.Text.Length)) + "|BA/Vendor  |" + lblBaVendor.Text + "\\n";
        PDC_Detail = PDC_Detail + "|VehicleNo  |" + lblVhclNo.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblVhclNo.Text.Length)) + "|DriverName |" + lblDriverNm.Text + "\\n";
        PDC_Detail = PDC_Detail + "|Start KM   |" + lblStartingKM.Text + string.Empty.PadLeft(15 - Convert.ToInt32(lblStartingKM.Text.Length)) + "|  End KM   |" + lblEndingKM.Text + string.Empty.PadLeft(11 - Convert.ToInt32(lblEndingKM.Text.Length)) + "| Distance |" + lblDistance.Text + "\\n";
        PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";

        cnt = 1;
        cn.Close();

        cn.Open();
        string sqlRemainData = "Select * From vw_DRS_View_Print_2 with(NOLOCK) Where PDCNo='" + strDRSNo.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sqlRemainData, cn);
        SqlDataReader dr1;
        dr1 = cmd.ExecuteReader();
        PDC_Detail = PDC_Detail + "|" + "Docket No/|TranMode/|BkgLoc|      Cosignee/      |" + "\\n";
        PDC_Detail = PDC_Detail + "|" + "Docket Dt |Pay Basis|DelLoc|      BillParty      |  Pkg  |ActWt|  FrtAmt |Sign|" + "\\n";
        PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        //int cnt = 1;
        while (dr1.Read())
        {
            string dockno = dr1["DocketNo"].ToString();
            string Paybas = dr1["Pay_Basis"].ToString();
            string DockDt = dr1["Docket_Date"].ToString();
            string BookingLocation = dr1["LocFrom"].ToString();
            string DeliveryLocation = dr1["LocTo"].ToString();
            string BillingParty = dr1["Cnee_BillingParty"].ToString();
            double Packages = Convert.ToDouble(dr1["Pkgs"]);
            double ActualWeight = Convert.ToDouble(dr1["ACTUWT"]);
            double FreightAmount = Convert.ToDouble(dr1["FrieghtAmount"]);
            string TransMode = dr1["TransMode"].ToString();
            if (BillingParty.ToString().Length > 20)
            { 
            
            }
            if (Convert.ToInt32(BillingParty.Length) > 20)
            {
                BillingParty = BillingParty.Substring(0, 20);
            }
            totpkgs = totpkgs + Packages;
            totactualweight = totactualweight + ActualWeight;
            totfreightamount = totfreightamount + FreightAmount;

            PDC_Detail = PDC_Detail + "|" + dockno + string.Empty.PadLeft(10 - Convert.ToInt32(dockno.ToString().Length)) + "|" + Paybas + string.Empty.PadLeft(9 - Convert.ToInt32(Paybas.ToString().Length))+ "|" + BookingLocation + string.Empty.PadLeft(6 - Convert.ToInt32(BookingLocation.ToString().Length)) + "|" + BillingParty + string.Empty.PadLeft(20 - Convert.ToInt32(BillingParty.ToString().Length)) + " | " + Packages + string.Empty.PadLeft(5 - Convert.ToInt32(Packages.ToString().Length)) + " |" + ActualWeight + string.Empty.PadLeft(5 - Convert.ToInt32(ActualWeight.ToString().Length)) + "|" + FreightAmount + string.Empty.PadLeft(10 - Convert.ToInt32(FreightAmount.ToString().Length)) + "|" + "\\n";
            
            PDC_Detail = PDC_Detail + "|" + DockDt + string.Empty.PadLeft(10 - Convert.ToInt32(DockDt.ToString().Length)) + "|" + TransMode + string.Empty.PadLeft(9 - Convert.ToInt32(TransMode.ToString().Length)) + "|" + DeliveryLocation + string.Empty.PadLeft(6 - Convert.ToInt32(DeliveryLocation.ToString().Length)) + "|" + "\\n";
            PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        }
        
        PDC_Detail = PDC_Detail + "|" + string.Empty.PadLeft(18) + string.Empty.PadLeft(20)+ "| Grand Total " + "|" + totpkgs + "|" + totactualweight + "|" + totfreightamount + "|" + "\\n";
        PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        PDC_Detail = PDC_Detail + "|" + string.Empty.PadLeft(21) + "|" + string.Empty.PadLeft(16) + "|" + lblPreparedBy.Text + "|" + lblAt.Text + "|" + lblDrsDate.Text + "\\n";
        PDC_Detail = PDC_Detail + "| Staff Name  "  + "| Sign " + string.Empty.PadLeft(6) + "| Prepared By"  + "| At " + string.Empty.PadLeft(4) + "| Date & Time" + string.Empty.PadLeft(2) + "\\n";
        PDC_Detail = PDC_Detail + "--------------------------------------------------------------------------------" + "\\n";
        dr1.Close();

        PDC_Detail = "objPrint.Print_Line('" + PDC_Detail + "');";
    }
    private void Prepare()
    {
        cn.Open();
        string sql = "Select (USerID + ': ' + Name) as emp From WebX_Master_Users Where UserID='" + Session["empcd"].ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblPreparedBy.Text = dr["emp"].ToString();
        }
        dr.Close();
        cn.Close();
    }
    private void getData()
    {
        cn.Open();

        string sql1 = "Select top 1 pdcno As PRSNo, convert(varchar,pdcdt,6) As PRS_Date, pdcbr As PRS_Location, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),6) As thisDate,vendor_type,driverName ,empcd, Manualpdcno From webx_pdchdr with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        //string sql2 = "Select pdcno As PRSNo, convert(varchar,pdcdt,106) As PRS_Date, pdcbr As PRS_Location, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),106) As thisDate,vendor_type,driverName ,empcd, Manualpdcno From webx_pdchdr_arch with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        string sql2 = "Select top 1 pdcno As PRSNo, convert(varchar,pdcdt,6) As PRS_Date, pdcbr As PRS_Location, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),6) As thisDate,vendor_type,driverName ,empcd, Manualpdcno From webx_pdchdr with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        string sql3 = "Select S.* From (" + sql1 + " union " + sql2 + ")S";

        SqlCommand cmdGetData = new SqlCommand(sql3, cn);
        SqlDataReader dr = cmdGetData.ExecuteReader();

        while (dr.Read())
        {
            lblDrsNo.Text = dr[0].ToString();
            lblDrsDate.Text = dr[1].ToString();
            lblManualDrsNo.Text = dr["Manualpdcno"].ToString();
            lblRunSheetLoc.Text = dr[2].ToString();
            lblBaVendor.Text = dr[3].ToString();
            lblVhclNo.Text = dr[4].ToString();
            lblStartingKM.Text = dr[5].ToString();
            lblEndingKM.Text = dr[6].ToString();
            lblDistance.Text = dr[7].ToString();
            lblDateTime.Text = dr[8].ToString();
            lblDriverNm.Text = dr[10].ToString();
            lblPreparedBy.Text = dr[11].ToString();
            lblAt.Text = dr[2].ToString();

            string vendortype = dr["vendor_type"].ToString();

            switch (vendortype)
            {
                case "1":
                    vendortype = "Market";
                    break;
                case "2":
                    vendortype = "Attached";
                    break;
                case "3":
                    vendortype = "Own";
                    lblBaVendor.Text = "By Company";
                    break;
            }
        }
        dr.Close();
        cn.Close();

    }

    private void remainData()
    {
        int count = 0;
        cn.Open();
        string sqlRemainData = "Select * From vw_DRS_View_Print_2 with(NOLOCK) Where PDCNo='" + strDRSNo.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sqlRemainData, cn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        DataSet dsRemainData = new DataSet();
        strRemainData = "<table border='1' cellspacing='1' cellpadding='1' class='boxbg' width='100%'>" +
                        "<tr bgcolor='#FFFFFF'><td width='3%' align='left'><font class='blackfnt'>" +
                        "Sr.<br />No.</font></td><td align='left'><font class='blackfnt'>Docket No./<br />Pay Basis" +
                        "</font></td><td align='left'><font class='blackfnt'>Docket Dt.</font></td><td align='left'>" +
                        "<font class='blackfnt'>Bkg.<br />Loc.</font></td><td align='left'><font class='blackfnt'>" +
                        "Dely.<br/>Loc.</font></td><td align='left' width='15%'><font class='blackfnt'>C'nee/<br />Bill Party" +
                        "</font></td><td align='right'><font class='blackfnt'>Pkgs.</font></td><td align='right'>" +
                        "<font class='blackfnt'>Act. Wt.</font></td><td align='right'><font class='blackfnt'>Frt. Amount" +
                        "</font></td><td align='left'><font class='blackfnt'>Trans.<br/>Mode</font></td><td align='left'>" +
                        "<font class='blackfnt'>Sign &amp; Stamp</font></td></tr>";

        sqlDA.Fill(dsRemainData);

        int j;

        if (dsRemainData.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsRemainData.Tables[0].Rows.Count; i++)
            {
                j = i + 1;
                strRemainData += "<tr bgcolor='#FFFFFF'><td class='blackfnt'>" + j.ToString() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][0].ToString().Trim() + " / " + dsRemainData.Tables[0].Rows[i][1].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + getDateInddMMMyyFormat(dsRemainData.Tables[0].Rows[i][14].ToString().Trim()) + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][2].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][3].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][5].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][6].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][7].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][8].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>" + dsRemainData.Tables[0].Rows[i][10].ToString().Trim() + "</td>";
                strRemainData += "<td class='blackfnt'>&nbsp;</td></tr>";
            }
        }

        cn.Close();
    }

    private void cal()
    {
        cn.Open();
        string sqlCal = "Select Sum(cast(Pkgs as int)) As GrandPkgs,Sum(ACTUWT) As GrandWt,Sum(FrieghtAmount) As GrandFreight,Sum(BA_Payment) As GrandST From vw_DRS_View_Print_2_HB Where PDCNo='" + strDRSNo + "'";
        SqlCommand cmd = new SqlCommand(sqlCal, cn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        DataSet dsCal = new DataSet();
        strCal = "";
        sqlDA.Fill(dsCal);
        if (dsCal.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsCal.Tables[0].Rows.Count; i++)
            {
                strCal += "<td colspan='6' align='right'><font class='blackfnt'><b>" + "Grand Total" + "</b></font></td>";
                strCal += "<td class='blackfnt'>" + dsCal.Tables[0].Rows[i][0].ToString().Trim() + "</td>";
                strCal += "<td class='blackfnt'>" + dsCal.Tables[0].Rows[i][1].ToString().Trim() + "</td>";
                strCal += "<td class='blackfnt'>" + dsCal.Tables[0].Rows[i][2].ToString().Trim() + "</td>";
            }
            strCal += "<td class='blackfnt'>&nbsp;</td><td class='blackfnt'>&nbsp;</td>";
        }
        cn.Close();
    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}
