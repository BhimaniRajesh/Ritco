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
using ApplicationManager;

public partial class GUI_Fleet_Operations_Issue_frmNewTripDetailsUpdateNext : System.Web.UI.Page
{
    private double sum = 0;
    static string str_Connection_String = "";

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    MyFleetDataSet.EnrouteExpenseLegWiseDataTable dtEnrouteExpense = new MyFleetDataSet.EnrouteExpenseLegWiseDataTable();
    MyFleetDataSet.ExternalCustDetailsRow datarow_ExternalCustDetails;
    MyFleetDataSet.EnrouteExpenseLegWise123Row datarow_EnrouteExpenseLegWise;
    MyFleetDataSet.TripsheetCnoteLegWiseRow datarow_TripsheetCnoteLegWise;

    public string strPolarity = "";

    public double totExAmt = 0, totStandardAmt = 0;
    public double totExAmt2 = 0, totStandardAmt2 = 0;
    public double totExAmt3 = 0, totStandardAmt3 = 0;
    public double totExAmt4 = 0, totStandardAmt4 = 0;
    public double totExAmt5 = 0, totStandardAmt5 = 0;
    public double totExAmt6 = 0, totStandardAmt6 = 0;

    string stVSlipId = "", strVEHNO = "", strStartKM = "";
    SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {
       

        if (!IsPostBack)
        {
            try
            {
                if (Session["SqlProvider"] != null)
                {
                    str_Connection_String = Session["SqlProvider"].ToString();
                    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    conn.Open();
                }
                else
                {
                    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
                }
            }
            catch (Exception Ex)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
            }

            stVSlipId = Request.QueryString["id"];
            strVEHNO = Request.QueryString["VEHNO"];
            strStartKM = Request.QueryString["StartKM"];

            hdnVehno.Value = strVEHNO;
            hdnStartKM.Value = strStartKM;

            Session["Tripsheet"] = stVSlipId;

            Previous_ExternalCustDetails();
            InetializEnrouteExpense();
            //BindGridEnExpense();
            
             Previous_CNOTEEntry();

             Tr1.Visible = false;
             trgvCnoterowdetails.Visible = false;
             trgvCnotedetails.Visible = false;


        }
    }
    
    public void Previous_CNOTEEntry()
    {
        //string mSTR = " select From_Point,To_Point,Category_Type,Document_Name,Convert(varchar,Start_Date_Tm,103) as StartDate,Substring(Convert(varchar,Start_Date_Tm,108),1,2) as StartTime_HH,Substring(Convert(varchar,Start_Date_Tm,108),4,2) as StartTime_MM,Convert(varchar,End_Date_Tm,103) as EndDate,Substring(Convert(varchar,End_Date_Tm,108),1,2) as EndTime_HH,Substring(Convert(varchar,End_Date_Tm,108),4,2) as EndTime_MM,Start_KM_Read,End_KM_Read,KM_Read,Substring(Convert(varchar,Transit_Time,108),1,2) as Transit_HH,Substring(Convert(varchar,Transit_Time,108),4,2) as Transit_MM,Substring(Convert(varchar,Idle_Time,108),1,2) as IdleTime_HH,Substring(Convert(varchar,Idle_Time,108),4,2) as IdleTime_MM from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        string mSTR = " select ((select Location from webx_citymaster where city_code=B.FROM_POINT)+' : '+(select Location from webx_citymaster where city_code=B.TO_POINT)) AS LEG,A.DockNo,A.DOCKDT,(A.ORGNCD+' : '+A.DESTCD) as ORG_DEST,A.PKGSNO,A.ACTUWT,A.CHRGWT,A.SubTotal,A.DKTTOT,A.LEGID from Webx_Fleet_Trip_Dockets as A inner join WEBX_FLEET_NEW_VEHICLE_LOGDETAIL as B on A.TRIPSHEETNO=B.TRIPSHEETNO and A.LEGID=B.LEGID where A.TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();

        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow gv in dt.Rows)
            {
                count = count + 1;

                string LEG = Convert.ToString(gv["LEGID"]);
                string DockNo = Convert.ToString(gv["DockNo"]);
                string DOCKDT = Convert.ToString(gv["DOCKDT"]);
                string ORG_DEST = Convert.ToString(gv["ORG_DEST"]);
                string PKGSNO = Convert.ToString(gv["PKGSNO"]);
                string ACTUWT = Convert.ToString(gv["ACTUWT"]);
                string CHRGWT = Convert.ToString(gv["CHRGWT"]);
                string SubTotal = Convert.ToString(gv["SubTotal"]);
                string DKTTOT = Convert.ToString(gv["DKTTOT"]);

                _dataSet.TripsheetCnoteLegWise.AddTripsheetCnoteLegWiseRow(LEG, DockNo, DOCKDT, ORG_DEST, PKGSNO, ACTUWT, CHRGWT, SubTotal, DKTTOT);
                
            }
        }
        BindGridCNOTE();

        Session["dbVEHLogRow"] = mcount;

        txtAddCnoterow.Text = count.ToString();
    }
    public void BindGridCNOTE()
    {
        gvCnote.DataSource = _dataSet.TripsheetCnoteLegWise;
        gvCnote.DataBind();
    }

    private void BindGridEnExpense()
    {
        gvEnroute.DataSource = dtEnrouteExpense;
        gvEnroute.DataBind();
    }

    public void InetializEnrouteExpense()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        //string str = "SELECT G.Trip_Exp_Header + ' (' +G.Polarity + ')' as CodeDesc,G.Polarity , E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt"
        //      + ", E.Remarks FROM Webx_Trip_Expense_Master AS G INNER JOIN WEBX_FLEET_ENROUTE_EXP AS E "
        //      + "ON G.ID = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "') ORDER BY G.ID ";


        string str = " SELECT G.Trip_Exp_Header + ' (' +G.Polarity + ')' as CodeDesc,G.Polarity ,E.TripsheetNo,E.id,E.STANDARD1,E.ACTUAL1,E.STANDARD2,E.ACTUAL2,E.STANDARD3,E.ACTUAL3,E.STANDARD4,E.ACTUAL4,E.STANDARD5,E.ACTUAL5,E.STANDARD6,E.ACTUAL6 FROM Webx_Trip_Expense_Master AS G INNER JOIN WEBX_FLEET_ENROUTE_EXP_LEGWISE_VIEW AS E ON G.ID = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "') ORDER BY G.ID ";


        DataTable dtDR = new DataTable();
        dtDR = objTripSheet.ExecuteSql(str);
        Double mAmt = 0, mEAmt = 0;

        Double mAmt2 = 0, mEAmt2 = 0;
        Double mAmt3 = 0, mEAmt3 = 0;
        Double mAmt4 = 0, mEAmt4 = 0;
        Double mAmt5 = 0, mEAmt5 = 0;
        Double mAmt6 = 0, mEAmt6 = 0;



        if (dtDR.Rows.Count > 0)
        {

            EnrouteHeaderDetails(Request.QueryString["id"]);

            foreach (DataRow dr in dtDR.Rows)
            {
                string mCodeDesc = Convert.ToString(dr["codedesc"]);
                string id = Convert.ToString(dr["id"]);
                string Amount1 = Convert.ToString(dr["ACTUAL1"]);
                string Exe_amt1 = Convert.ToString(dr["STANDARD1"]);

                string Amount2 = Convert.ToString(dr["ACTUAL2"]);
                string Exe_amt2 = Convert.ToString(dr["STANDARD2"]);

                string Amount3 = Convert.ToString(dr["ACTUAL3"]);
                string Exe_amt3 = Convert.ToString(dr["STANDARD3"]);

                string Amount4 = Convert.ToString(dr["ACTUAL4"]);
                string Exe_amt4 = Convert.ToString(dr["STANDARD4"]);

                string Amount5 = Convert.ToString(dr["ACTUAL5"]);
                string Exe_amt5 = Convert.ToString(dr["STANDARD5"]);

                string Amount6 = Convert.ToString(dr["ACTUAL6"]);
                string Exe_amt6 = Convert.ToString(dr["STANDARD6"]);

                if (Amount1 == "")
                {
                    Amount1 = "0";
                }
                if (Exe_amt1 == "")
                {
                    Exe_amt1 = "0";
                }
                mAmt = mAmt + Convert.ToDouble(Amount1);
                mEAmt = mEAmt + Convert.ToDouble(Exe_amt1);
                if (Amount1 == "0")
                {
                    Amount1 = "";
                }
                if (Exe_amt1 == "0")
                {
                    Exe_amt1 = "0";
                }

                /////////////////

                if (Amount2 == "")
                {
                    Amount2 = "0";
                }
                if (Exe_amt2 == "")
                {
                    Exe_amt2 = "0";
                }
                mAmt2 = mAmt2 + Convert.ToDouble(Amount2);
                mEAmt2 = mEAmt2 + Convert.ToDouble(Exe_amt2);
                if (Amount2 == "0")
                {
                    Amount2 = "";
                }
                if (Exe_amt2 == "0")
                {
                    Exe_amt2 = "0";
                }

                /////////////////////////

                if (Amount3 == "")
                {
                    Amount3 = "0";
                }
                if (Exe_amt3 == "")
                {
                    Exe_amt3 = "0";
                }
                mAmt3 = mAmt3 + Convert.ToDouble(Amount3);
                mEAmt3 = mEAmt3 + Convert.ToDouble(Exe_amt3);
                if (Amount3 == "0")
                {
                    Amount3 = "";
                }
                if (Exe_amt3 == "0")
                {
                    Exe_amt3 = "0";
                }

                /////////////////////////////

                if (Amount4 == "")
                {
                    Amount4 = "0";
                }
                if (Exe_amt4 == "")
                {
                    Exe_amt4 = "0";
                }
                mAmt4 = mAmt4 + Convert.ToDouble(Amount4);
                mEAmt4 = mEAmt4 + Convert.ToDouble(Exe_amt4);
                if (Amount4 == "0")
                {
                    Amount4 = "";
                }
                if (Exe_amt4 == "0")
                {
                    Exe_amt4 = "0";
                }

                ///////////////////////////////

                if (Amount5 == "")
                {
                    Amount5 = "0";
                }
                if (Exe_amt5 == "")
                {
                    Exe_amt5 = "0";
                }
                mAmt5 = mAmt5 + Convert.ToDouble(Amount5);
                mEAmt5 = mEAmt5 + Convert.ToDouble(Exe_amt5);
                if (Amount5 == "0")
                {
                    Amount5 = "";
                }
                if (Exe_amt5 == "0")
                {
                    Exe_amt5 = "0";
                }

                //////////////////////////////


                if (Amount6 == "")
                {
                    Amount6 = "0";
                }
                if (Exe_amt6 == "")
                {
                    Exe_amt6 = "0";
                }
                mAmt6 = mAmt6 + Convert.ToDouble(Amount6);
                mEAmt6 = mEAmt6 + Convert.ToDouble(Exe_amt6);
                if (Amount6 == "0")
                {
                    Amount6 = "";
                }
                if (Exe_amt6 == "0")
                {
                    Exe_amt6 = "0";
                }

                /////////////////////


                if (strPolarity == "")
                {
                    strPolarity = Convert.ToString(dr["Polarity"]);
                }
                else
                {
                    strPolarity = strPolarity + "," + Convert.ToString(dr["Polarity"]);
                }


                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt = totExAmt + Convert.ToDouble(Convert.ToString(dr["ACTUAL1"]) == "" ? "0" : Convert.ToString(dr["ACTUAL1"]));
                    totStandardAmt = totStandardAmt + Convert.ToDouble(Convert.ToString(dr["STANDARD1"]) == "" ? "0" : Convert.ToString(dr["STANDARD1"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt = totExAmt - Convert.ToDouble(Convert.ToString(dr["ACTUAL1"]) == "" ? "0" : Convert.ToString(dr["ACTUAL1"]));
                    totStandardAmt = totStandardAmt - Convert.ToDouble(Convert.ToString(dr["STANDARD1"]) == "" ? "0" : Convert.ToString(dr["STANDARD1"]));
                }
                hfETotalAmt.Value = Convert.ToString(totExAmt);
                hfEnAmtTotal.Value = Convert.ToString(totStandardAmt);

                ///////////////////////////////////////////////////////

                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt2 = totExAmt2 + Convert.ToDouble(Convert.ToString(dr["ACTUAL2"]) == "" ? "0" : Convert.ToString(dr["ACTUAL2"]));
                    totStandardAmt2 = totStandardAmt2 + Convert.ToDouble(Convert.ToString(dr["STANDARD2"]) == "" ? "0" : Convert.ToString(dr["STANDARD2"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt2 = totExAmt2 - Convert.ToDouble(Convert.ToString(dr["ACTUAL2"]) == "" ? "0" : Convert.ToString(dr["ACTUAL2"]));
                    totStandardAmt2 = totStandardAmt2 - Convert.ToDouble(Convert.ToString(dr["STANDARD2"]) == "" ? "0" : Convert.ToString(dr["STANDARD2"]));
                }
                hfETotalAmt2.Value = Convert.ToString(totExAmt2);
                hfEnAmtTotal2.Value = Convert.ToString(totStandardAmt2);

                ///////////////////////////////////////////////////////

                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt3 = totExAmt3 + Convert.ToDouble(Convert.ToString(dr["ACTUAL3"]) == "" ? "0" : Convert.ToString(dr["ACTUAL3"]));
                    totStandardAmt3 = totStandardAmt3 + Convert.ToDouble(Convert.ToString(dr["STANDARD3"]) == "" ? "0" : Convert.ToString(dr["STANDARD3"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt3 = totExAmt3 - Convert.ToDouble(Convert.ToString(dr["ACTUAL3"]) == "" ? "0" : Convert.ToString(dr["ACTUAL3"]));
                    totStandardAmt3 = totStandardAmt3 - Convert.ToDouble(Convert.ToString(dr["STANDARD3"]) == "" ? "0" : Convert.ToString(dr["STANDARD3"]));
                }
                hfETotalAmt3.Value = Convert.ToString(totExAmt3);
                hfEnAmtTotal3.Value = Convert.ToString(totStandardAmt3);

                ///////////////////////////////////////////////////////

                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt4 = totExAmt4 + Convert.ToDouble(Convert.ToString(dr["ACTUAL4"]) == "" ? "0" : Convert.ToString(dr["ACTUAL4"]));
                    totStandardAmt4 = totStandardAmt4 + Convert.ToDouble(Convert.ToString(dr["STANDARD4"]) == "" ? "0" : Convert.ToString(dr["STANDARD4"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt4 = totExAmt4 - Convert.ToDouble(Convert.ToString(dr["ACTUAL4"]) == "" ? "0" : Convert.ToString(dr["ACTUAL4"]));
                    totStandardAmt4 = totStandardAmt4 - Convert.ToDouble(Convert.ToString(dr["STANDARD4"]) == "" ? "0" : Convert.ToString(dr["STANDARD4"]));
                }
                hfETotalAmt4.Value = Convert.ToString(totExAmt4);
                hfEnAmtTotal4.Value = Convert.ToString(totStandardAmt4);

                ///////////////////////////////////////////////////////

                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt5 = totExAmt5 + Convert.ToDouble(Convert.ToString(dr["ACTUAL5"]) == "" ? "0" : Convert.ToString(dr["ACTUAL5"]));
                    totStandardAmt5 = totStandardAmt5 + Convert.ToDouble(Convert.ToString(dr["STANDARD5"]) == "" ? "0" : Convert.ToString(dr["STANDARD5"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt5 = totExAmt5 - Convert.ToDouble(Convert.ToString(dr["ACTUAL5"]) == "" ? "0" : Convert.ToString(dr["ACTUAL5"]));
                    totStandardAmt5 = totStandardAmt5 - Convert.ToDouble(Convert.ToString(dr["STANDARD5"]) == "" ? "0" : Convert.ToString(dr["STANDARD5"]));
                }
                hfETotalAmt5.Value = Convert.ToString(totExAmt5);
                hfEnAmtTotal5.Value = Convert.ToString(totStandardAmt5);

                ///////////////////////////////////////////////////////

                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt6 = totExAmt6 + Convert.ToDouble(Convert.ToString(dr["ACTUAL6"]) == "" ? "0" : Convert.ToString(dr["ACTUAL6"]));
                    totStandardAmt6 = totStandardAmt6 + Convert.ToDouble(Convert.ToString(dr["STANDARD6"]) == "" ? "0" : Convert.ToString(dr["STANDARD6"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt6 = totExAmt6 - Convert.ToDouble(Convert.ToString(dr["ACTUAL6"]) == "" ? "0" : Convert.ToString(dr["ACTUAL6"]));
                    totStandardAmt6 = totStandardAmt6 - Convert.ToDouble(Convert.ToString(dr["STANDARD6"]) == "" ? "0" : Convert.ToString(dr["STANDARD6"]));
                }
                hfETotalAmt6.Value = Convert.ToString(totExAmt6);
                hfEnAmtTotal6.Value = Convert.ToString(totStandardAmt6);

                //_dataSet.EnrouteExpenseLegWise.AddEnrouteExpenseLegWiseRow(id, Amount1, Exe_amt1, Amount2, Exe_amt2, Amount3, Exe_amt3, Amount4, Exe_amt4, Amount5, Exe_amt5, Amount6, Exe_amt6);
                _dataSet.EnrouteExpenseLegWise.AddEnrouteExpenseLegWiseRow(id, Exe_amt1, Amount1, Exe_amt2, Amount2, Exe_amt3, Amount3, Exe_amt4, Amount4, Exe_amt5, Amount5, Exe_amt6, Amount6);

            }
        }

        gvEnroute.DataSource = _dataSet.EnrouteExpenseLegWise;
        gvEnroute.DataBind();

        //tb_Row_No.Text = "2";
  
    }

    public void Previous_ExternalCustDetails()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        //string mSTR = "  select (A.From_Point +':'+ A.To_Point) as LEG,CUST_CODE,CHALLAN_DETAILS,BROKER_DETAILS,BILL_FREIGHT_AMT,FREIGHT_ADVANCE,FREIGHT_BALANCE,REMARKS from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL AS A LEFT OUTER JOIN WEBX_FLEET_NEW_EXTERNAL_CUST_DETAILS AS B ON A.TripsheetNo=B.TripsheetNo where A.CATEGORY_TYPE='1' AND A.TripsheetNo='" + Session["Tripsheet"].ToString() + "'  ";
        string mSTR = " select ((select Location from webx_citymaster where city_code=A.From_Point)+' : '+ (select Location from webx_citymaster where city_code=A.To_Point)) as LEG,(SELECT CUSTNM FROM webx_CUSTHDR WHERE CUSTCD=CUST_CODE) AS CUSTNM,CUST_CODE,CHALLAN_DETAILS,BROKER_DETAILS,BILL_FREIGHT_AMT,FREIGHT_ADVANCE,FREIGHT_BALANCE,REMARKS from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL AS A LEFT OUTER JOIN WEBX_FLEET_NEW_EXTERNAL_CUST_DETAILS AS B ON A.TripsheetNo=B.TripsheetNo where A.CATEGORY_TYPE='1' AND A.TripsheetNo='" + Session["Tripsheet"].ToString() + "'  ";
       
        int count = 0;
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;
                string LEG = Convert.ToString(dr["LEG"]);
                string CUST_CODE = Convert.ToString(dr["CUST_CODE"]);
                string CHALLAN_DETAILS = Convert.ToString(dr["CHALLAN_DETAILS"]);
                string BROKER_DETAILS = Convert.ToString(dr["BROKER_DETAILS"]);
                string BILL_FREIGHT_AMT = Convert.ToString(dr["BILL_FREIGHT_AMT"]);
                string FREIGHT_ADVANCE = Convert.ToString(dr["FREIGHT_ADVANCE"]);
                string FREIGHT_BALANCE = Convert.ToString(dr["FREIGHT_BALANCE"]);
                string REMARKS = Convert.ToString(dr["REMARKS"]);
                string CustName = Convert.ToString(dr["CUSTNM"]);

                _dataSet.ExternalCustDetails.AddExternalCustDetailsRow(LEG, CUST_CODE, CHALLAN_DETAILS, BROKER_DETAILS, BILL_FREIGHT_AMT, FREIGHT_ADVANCE, FREIGHT_BALANCE, REMARKS, CustName);
                
            }
            BindGrid(); 
        }
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "0";
        _dataSet.EnrouteExpenseLegWise.Clear();
        string strPolarity = "";
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            DropDownList ddlNExpense = (DropDownList)row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");

            TextBox txtAmount2 = (TextBox)row.FindControl("txtAmount2");
            TextBox txtEAmt2 = (TextBox)row.FindControl("txtEAmt2");
            HiddenField hfEAmt2 = (HiddenField)row.FindControl("hfEAmt2");
            HiddenField hfPolarity2 = (HiddenField)row.FindControl("hfPolarity2");

            TextBox txtAmount3 = (TextBox)row.FindControl("txtAmount3");
            TextBox txtEAmt3 = (TextBox)row.FindControl("txtEAmt3");
            HiddenField hfEAmt3 = (HiddenField)row.FindControl("hfEAmt3");
            HiddenField hfPolarity3 = (HiddenField)row.FindControl("hfPolarity3");

            TextBox txtAmount4 = (TextBox)row.FindControl("txtAmount4");
            TextBox txtEAmt4 = (TextBox)row.FindControl("txtEAmt4");
            HiddenField hfEAmt4 = (HiddenField)row.FindControl("hfEAmt4");
            HiddenField hfPolarity4 = (HiddenField)row.FindControl("hfPolarity4");

            TextBox txtAmount5 = (TextBox)row.FindControl("txtAmount5");
            TextBox txtEAmt5 = (TextBox)row.FindControl("txtEAmt5");
            HiddenField hfEAmt5 = (HiddenField)row.FindControl("hfEAmt5");
            HiddenField hfPolarity5 = (HiddenField)row.FindControl("hfPolarity5");

            TextBox txtAmount6 = (TextBox)row.FindControl("txtAmount6");
            TextBox txtEAmt6 = (TextBox)row.FindControl("txtEAmt6");
            HiddenField hfEAmt6 = (HiddenField)row.FindControl("hfEAmt6");
            HiddenField hfPolarity6 = (HiddenField)row.FindControl("hfPolarity6");

            if (strPolarity == "")
            {
                strPolarity = hfPolarity.Value + "~";
            }
            else
            {
                strPolarity = strPolarity + hfPolarity.Value + "~";
            }
            _dataSet.EnrouteExpenseLegWise.AddEnrouteExpenseLegWiseRow(ddlNExpense.SelectedValue, txtEAmt.Text, txtAmount.Text, txtEAmt2.Text, txtAmount2.Text, txtEAmt3.Text, txtAmount3.Text, txtEAmt4.Text, txtAmount4.Text, txtEAmt5.Text, txtAmount5.Text, txtEAmt6.Text, txtAmount6.Text);
        }
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) _dataSet.EnrouteExpenseLegWise.AddEnrouteExpenseLegWiseRow("", "", "", "", "", "", "", "", "", "", "", "", "");
        tb_Row_No.Text = "0";
        gvEnroute.DataSource = _dataSet.EnrouteExpenseLegWise;
        gvEnroute.DataBind();

        if (strPolarity != "")
        {
            strPolarity = strPolarity.Substring(0, strPolarity.Length - 1);
        }

        string[] strPol = strPolarity.Split('~');
        int len = strPol.Length;
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            txtEAmt.Text = hfEAmt.Value;
            if (len > 0)
            {
                HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");
                hfPolarity.Value = strPol[row.RowIndex].ToString();
            }
            len = len - 1;
        }

        EnrouteHeaderDetails(Request.QueryString["id"]);
    }

    public void EnrouteHeaderDetails(string stVSlipId)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand cmd = new SqlCommand("USP_FLEET_NEW_ENROUTE_HEADER_TRIPSHEET", conn);

        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = stVSlipId;
        DataSet ds = new DataSet();

        da.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();

    }


    public void BindGrid()
    {
        dgLegDet.DataSource = _dataSet.ExternalCustDetails;
        dgLegDet.DataBind();
    }

    protected void dgLegDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            //datarow_ExternalCustDetails = ((MyFleetDataSet.ExternalCustDetailsRow)((DataRowView)e.Item.DataItem).Row);
            //((TextBox)e.Item.FindControl("txtLeg")).Text = datarow_ExternalCustDetails.Leg;
            //((TextBox)e.Item.FindControl("txtCustCodeName")).Text = datarow_ExternalCustDetails.CustCode;
            //((TextBox)e.Item.FindControl("txtChallan")).Text = datarow_ExternalCustDetails.ChallanDetails;

            //((TextBox)e.Item.FindControl("txtBrokerDetails")).Text = datarow_ExternalCustDetails.BrokerDetails;
            //((TextBox)e.Item.FindControl("txtBillFreightAmt")).Text = datarow_ExternalCustDetails.BillFreight;

            //((TextBox)e.Item.FindControl("txtFreightAdvance")).Text = datarow_ExternalCustDetails.FreightAdv;
            //((TextBox)e.Item.FindControl("txtFreightBalance")).Text = datarow_ExternalCustDetails.Freightbal;
            //((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_ExternalCustDetails.Remarks;

            TextBox txtCustCodeName = (TextBox)e.Item.FindControl("txtCustCodeName");
            TextBox txtCustName = (TextBox)e.Item.FindControl("txtCustCodeName");


            TextBox txtBillFreightAmt = (TextBox)e.Item.FindControl("txtBillFreightAmt");
            TextBox txtFreightAdvance = (TextBox)e.Item.FindControl("txtFreightAdvance");
            TextBox txtFreightBalance = (TextBox)e.Item.FindControl("txtFreightBalance");

            txtCustCodeName.Attributes.Add("Onblur", "javascript:GetCustomerDetails(" + e.Item.ItemIndex + "," + txtCustCodeName.ClientID.ToString() + "," + txtCustName.ClientID.ToString() + ");");

            txtBillFreightAmt.Attributes.Add("OnBlur", "javascript:CheckFreightBalance(" + txtBillFreightAmt.ClientID.ToString() + "," + txtFreightAdvance.ClientID.ToString() + "," + txtFreightBalance.ClientID.ToString() + ");");
            txtFreightAdvance.Attributes.Add("OnBlur", "javascript:CheckFreightBalance(" + txtBillFreightAmt.ClientID.ToString() + "," + txtFreightAdvance.ClientID.ToString() + "," + txtFreightBalance.ClientID.ToString() + ");");
           

        }
    }


    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddlNExpense = (DropDownList)e.Row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            TextBox txtEAmt = (TextBox)e.Row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");

            TextBox txtAmount2 = (TextBox)e.Row.FindControl("txtAmount2");
            TextBox txtEAmt2 = (TextBox)e.Row.FindControl("txtEAmt2");
            HiddenField hfEAmt2 = (HiddenField)e.Row.FindControl("hfEAmt2");
            HiddenField hfPolarity2 = (HiddenField)e.Row.FindControl("hfPolarity2");

            TextBox txtAmount3 = (TextBox)e.Row.FindControl("txtAmount3");
            TextBox txtEAmt3 = (TextBox)e.Row.FindControl("txtEAmt3");
            HiddenField hfEAmt3 = (HiddenField)e.Row.FindControl("hfEAmt3");
            HiddenField hfPolarity3 = (HiddenField)e.Row.FindControl("hfPolarity3");

            TextBox txtAmount4 = (TextBox)e.Row.FindControl("txtAmount4");
            TextBox txtEAmt4 = (TextBox)e.Row.FindControl("txtEAmt4");
            HiddenField hfEAmt4 = (HiddenField)e.Row.FindControl("hfEAmt4");
            HiddenField hfPolarity4 = (HiddenField)e.Row.FindControl("hfPolarity4");

            TextBox txtAmount5 = (TextBox)e.Row.FindControl("txtAmount5");
            TextBox txtEAmt5 = (TextBox)e.Row.FindControl("txtEAmt5");
            HiddenField hfEAmt5 = (HiddenField)e.Row.FindControl("hfEAmt5");
            HiddenField hfPolarity5 = (HiddenField)e.Row.FindControl("hfPolarity5");

            TextBox txtAmount6 = (TextBox)e.Row.FindControl("txtAmount6");
            TextBox txtEAmt6 = (TextBox)e.Row.FindControl("txtEAmt6");
            HiddenField hfEAmt6 = (HiddenField)e.Row.FindControl("hfEAmt6");
            HiddenField hfPolarity6 = (HiddenField)e.Row.FindControl("hfPolarity6");


            txtEAmt.Enabled = false;
            txtEAmt2.Enabled = false;
            txtEAmt3.Enabled = false;
            txtEAmt4.Enabled = false;
            txtEAmt5.Enabled = false;
            txtEAmt6.Enabled = false;

            BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);

            txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtAmount2.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtAmount3.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtAmount4.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtAmount5.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtAmount6.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");

            txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt2.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt3.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt4.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt5.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt6.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            
            ddlNExpense.Attributes.Add("onChange", "return CheckValidExp(" + e.Row.RowIndex + "," + ddlNExpense.ClientID.ToString() +
            "," + txtEAmt.ClientID.ToString() + "," + hfEAmt.ClientID.ToString() + "," + hfPolarity.ClientID.ToString() + 
            "," + txtEAmt2.ClientID.ToString() + "," + hfEAmt2.ClientID.ToString() + "," + hfPolarity2.ClientID.ToString() + 
            "," + txtEAmt3.ClientID.ToString() + "," + hfEAmt3.ClientID.ToString() + "," + hfPolarity3.ClientID.ToString() + 
            "," + txtEAmt4.ClientID.ToString() + "," + hfEAmt4.ClientID.ToString() + "," + hfPolarity4.ClientID.ToString() + 
            "," + txtEAmt5.ClientID.ToString() + "," + hfEAmt5.ClientID.ToString() + "," + hfPolarity5.ClientID.ToString() +
            "," + txtEAmt6.ClientID.ToString() + "," + hfEAmt6.ClientID.ToString() + "," + hfPolarity6.ClientID.ToString() + ");");

            if (_dataSet.EnrouteExpenseLegWise.Count > 0)
            {
                //ddlNExpense.SelectedItem.Text = _dataSet.EnrouteExpenseLegWise[e.Row.RowIndex]["NExpense"].ToString();
                ddlNExpense.SelectedValue = _dataSet.EnrouteExpenseLegWise[e.Row.RowIndex]["Expense"].ToString();
            }

            if (strPolarity != "")
            {
                string[] strArr = strPolarity.ToString().Split(',');
                for (int i = 0; i < strArr.Length; i++)
                {
                    if (e.Row.RowIndex == i)
                    {
                        hfPolarity.Value = strArr[i].ToString();
                    }
                }
            }

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txtETotalAmt = (TextBox)e.Row.FindControl("txtETotalAmt");
            TextBox txtEnAmtTotal = (TextBox)e.Row.FindControl("txtEnAmtTotal");

            TextBox txtETotalAmt2 = (TextBox)e.Row.FindControl("txtETotalAmt2");
            TextBox txtEnAmtTotal2 = (TextBox)e.Row.FindControl("txtEnAmtTotal2");

            TextBox txtETotalAmt3 = (TextBox)e.Row.FindControl("txtETotalAmt3");
            TextBox txtEnAmtTotal3 = (TextBox)e.Row.FindControl("txtEnAmtTotal3");

            TextBox txtETotalAmt4 = (TextBox)e.Row.FindControl("txtETotalAmt4");
            TextBox txtEnAmtTotal4 = (TextBox)e.Row.FindControl("txtEnAmtTotal4");

            TextBox txtETotalAmt5 = (TextBox)e.Row.FindControl("txtETotalAmt5");
            TextBox txtEnAmtTotal5 = (TextBox)e.Row.FindControl("txtEnAmtTotal5");

            TextBox txtETotalAmt6 = (TextBox)e.Row.FindControl("txtETotalAmt6");
            TextBox txtEnAmtTotal6 = (TextBox)e.Row.FindControl("txtEnAmtTotal6");

            txtETotalAmt.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal.ClientID.ToString() + "').disabled='true';");

            txtETotalAmt2.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt2.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal2.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal2.ClientID.ToString() + "').disabled='true';");

            txtETotalAmt3.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt3.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal3.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal3.ClientID.ToString() + "').disabled='true';");

            txtETotalAmt4.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt4.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal4.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal4.ClientID.ToString() + "').disabled='true';");

            txtETotalAmt5.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt5.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal5.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal5.ClientID.ToString() + "').disabled='true';");

            txtETotalAmt6.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt6.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal6.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal6.ClientID.ToString() + "').disabled='true';");

            txtEnAmtTotal.Text = Convert.ToString(totExAmt);
            txtETotalAmt.Text = Convert.ToString(totStandardAmt);

            txtEnAmtTotal2.Text = Convert.ToString(totExAmt2);
            txtETotalAmt2.Text = Convert.ToString(totStandardAmt2);

            txtEnAmtTotal3.Text = Convert.ToString(totExAmt3);
            txtETotalAmt3.Text = Convert.ToString(totStandardAmt3);

            txtEnAmtTotal4.Text = Convert.ToString(totExAmt4);
            txtETotalAmt4.Text = Convert.ToString(totStandardAmt4);

            txtEnAmtTotal5.Text = Convert.ToString(totExAmt5);
            txtETotalAmt5.Text = Convert.ToString(totStandardAmt5);

            txtEnAmtTotal6.Text = Convert.ToString(totExAmt6);
            txtETotalAmt6.Text = Convert.ToString(totStandardAmt6);
        }
    }

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    
  
    
    protected void add_rowCnote(object sender, EventArgs e)
    {
        if ((txtAddCnoterow.Text == "") || (txtAddCnoterow.Text == "0")) txtAddCnoterow.Text = "0";

        _dataSet.TripsheetCnoteLegWise.Rows.Clear();

        foreach (GridViewRow row in gvCnote.Rows)
        {
			DropDownList ddlLegID = (DropDownList)row.FindControl("ddlLegID");
            TextBox txtCnoteNo = (TextBox)row.FindControl("txtCnoteNo");
            TextBox txtBkgDate = (TextBox)row.FindControl("txtBkgDate");
            TextBox txtOriginDestination = (TextBox)row.FindControl("txtOriginDestination");
            TextBox txtPackage = (TextBox)row.FindControl("txtPackage");
            TextBox txtActualWeight = (TextBox)row.FindControl("txtActualWeight");
            TextBox txtChargedWeight = (TextBox)row.FindControl("txtChargedWeight");
            TextBox txtSubTotal = (TextBox)row.FindControl("txtSubTotal");
            TextBox txtCnoteTotal = (TextBox)row.FindControl("txtCnoteTotal");
            
            _dataSet.TripsheetCnoteLegWise.AddTripsheetCnoteLegWiseRow(ddlLegID.SelectedValue, txtCnoteNo.Text, txtBkgDate.Text, txtOriginDestination.Text, txtPackage.Text, txtActualWeight.Text, txtChargedWeight.Text, txtSubTotal.Text, txtCnoteTotal.Text);
        }
        
        
        //lbl_VehicleLog_Err.Text = "";
        int count = 0;
        string rowno;
        rowno = txtAddCnoterow.Text;
        int mroww = 0;

        mroww = Convert.ToInt16(rowno);

        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (GridViewRow row in gvCnote.Rows)
            {
                iroww = iroww + 1;
            }
            miroww = iroww;
            if (mroww < miroww)
            {
                miroww = mroww;
            }
            if (iroww >= 0)
            {
                for (i = iroww - 1; i > -1 + miroww; i--)
                {
                    _dataSet.TripsheetCnoteLegWise.RemoveTripsheetCnoteLegWiseRow(_dataSet.TripsheetCnoteLegWise[i]);

                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddCnoterow.Text); i++)
            {
                _dataSet.TripsheetCnoteLegWise.AddTripsheetCnoteLegWiseRow("", "", "", "", "", "", "", "", "");
               
            }
        }
        
        //for (int i = 0; i < Convert.ToInt32(txtAddCnoterow.Text); i++) _dataSet.TripsheetCnoteLegWise.AddTripsheetCnoteLegWiseRow("", "", "", "", "", "", "", "", "");
        //txtAddCnoterow.Text = "0";
        gvCnote.DataSource = _dataSet.TripsheetCnoteLegWise;
        gvCnote.DataBind();
    }

    protected void gvCnote_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
			DropDownList ddlLegID = (DropDownList)e.Row.FindControl("ddlLegID");
            TextBox txtCnoteNo = (TextBox)e.Row.FindControl("txtCnoteNo");
            TextBox txtBkgDate = (TextBox)e.Row.FindControl("txtBkgDate");
            TextBox txtOriginDestination = (TextBox)e.Row.FindControl("txtOriginDestination");
            TextBox txtPackage = (TextBox)e.Row.FindControl("txtPackage");
            TextBox txtActualWeight = (TextBox)e.Row.FindControl("txtActualWeight");
            TextBox txtChargedWeight = (TextBox)e.Row.FindControl("txtChargedWeight");
            TextBox txtSubTotal = (TextBox)e.Row.FindControl("txtSubTotal");
            TextBox txtCnoteTotal = (TextBox)e.Row.FindControl("txtCnoteTotal");
            
            BindDropDown("USP_FLEET_NEW_LEG_TYPE_CNOTE", "CodeDesc", "CodeId", ddlLegID);

            txtCnoteNo.Attributes.Add("OnBlur", "javascript:CheckCnoteNo(" + e.Row.RowIndex + "," + txtCnoteNo.ClientID.ToString() + "," + txtBkgDate.ClientID.ToString() + "," + txtOriginDestination.ClientID.ToString() + "," + txtPackage.ClientID.ToString() + "," + txtActualWeight.ClientID.ToString() + "," + txtChargedWeight.ClientID.ToString() + "," + txtSubTotal.ClientID.ToString() + "," + txtCnoteTotal.ClientID.ToString() + ");");
        
            if (_dataSet.TripsheetCnoteLegWise.Count > 0)
            {
                ddlLegID.SelectedValue = _dataSet.TripsheetCnoteLegWise[e.Row.RowIndex]["LEGID"].ToString().Trim();
                //ddlTypeofProduct.SelectedValue = _dataSet.TripMovementLog[e.Row.RowIndex]["TypeofProduct"].ToString().Trim();
            }
        
        }
    }

    protected void SubmitData(object sender, EventArgs e)
    {
      
        {
            TripSheet objTripSheet = new TripSheet(str_Connection_String);

            string mTripSheetNo = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            //DateTime mServerDt = new DateTime;

            mTripSheetNo = Request.QueryString["id"];
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();


            try
            {


                #region CUST_DETAILS

                sqlDEL = "Delete from WEBX_FLEET_NEW_EXTERNAL_CUST_DETAILS where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                foreach (DataGridItem gridrow in dgLegDet.Items)
                {
                    SqlCommand sql_insert_Ext = new SqlCommand("USP_FLEET_INSERT_EXTERNAL_CUST_DETAILS", conn, trans);
                    sql_insert_Ext.CommandType = CommandType.StoredProcedure;

                    sql_insert_Ext.Parameters.Add("@TripsheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_Ext.Parameters.Add("@LEG_DETAILS", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtLeg")).Text.ToString();
                    sql_insert_Ext.Parameters.Add("@CUST_CODE", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtCustCodeName")).Text.ToString();

                    sql_insert_Ext.Parameters.Add("@CHALLAN_DETAILS", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtChallan")).Text.ToString().Trim();
                    sql_insert_Ext.Parameters.Add("@BROKER_DETAILS", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtBrokerDetails")).Text.ToString();

                    sql_insert_Ext.Parameters.Add("@BILL_FREIGHT_AMT", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtBillFreightAmt")).Text.ToString());
                    sql_insert_Ext.Parameters.Add("@FREIGHT_ADVANCE", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtFreightAdvance")).Text.ToString());
                    sql_insert_Ext.Parameters.Add("@FREIGHT_BALANCE", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtFreightBalance")).Text.ToString());
                    sql_insert_Ext.Parameters.Add("@REMARKS", SqlDbType.VarChar, 500).Value = ((TextBox)gridrow.FindControl("txtRemarks")).Text.ToString();
                   
                    sql_insert_Ext.ExecuteNonQuery();
                }

                #endregion

                #region gvEnroute

                sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP_LEGWISE_VIEW where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                string From_Leg1 = "", To_Leg1 = "";
                string From_Leg2 = "", To_Leg2 = "";
                string From_Leg3 = "", To_Leg3 = "";
                string From_Leg4 = "", To_Leg4 = "";
                string From_Leg5 = "", To_Leg5 = "";
                string From_Leg6 = "", To_Leg6 = "";

                foreach (GridViewRow gridrow in GridView1.Rows)
                {
                    HiddenField hdnLegname1_From = (HiddenField)gridrow.FindControl("hdnLegname1_From");
                    HiddenField hdnLegname1_To = (HiddenField)gridrow.FindControl("hdnLegname1_To");

                    HiddenField hdnLegname2_From = (HiddenField)gridrow.FindControl("hdnLegname2_From");
                    HiddenField hdnLegname2_To = (HiddenField)gridrow.FindControl("hdnLegname2_To");

                    HiddenField hdnLegname3_From = (HiddenField)gridrow.FindControl("hdnLegname3_From");
                    HiddenField hdnLegname3_To = (HiddenField)gridrow.FindControl("hdnLegname3_To");

                    HiddenField hdnLegname4_From = (HiddenField)gridrow.FindControl("hdnLegname4_From");
                    HiddenField hdnLegname4_To = (HiddenField)gridrow.FindControl("hdnLegname4_To");

                    HiddenField hdnLegname5_From = (HiddenField)gridrow.FindControl("hdnLegname5_From");
                    HiddenField hdnLegname5_To = (HiddenField)gridrow.FindControl("hdnLegname5_To");

                    HiddenField hdnLegname6_From = (HiddenField)gridrow.FindControl("hdnLegname6_From");
                    HiddenField hdnLegname6_To = (HiddenField)gridrow.FindControl("hdnLegname6_To");

                    From_Leg1 = hdnLegname1_From.Value.ToString();
                    To_Leg1 = hdnLegname1_To.Value.ToString();

                    From_Leg2 = hdnLegname2_From.Value.ToString();
                    To_Leg2 = hdnLegname2_To.Value.ToString();

                    From_Leg3 = hdnLegname3_From.Value.ToString();
                    To_Leg3 = hdnLegname3_To.Value.ToString();

                    From_Leg4 = hdnLegname4_From.Value.ToString();
                    To_Leg4 = hdnLegname4_To.Value.ToString();

                    From_Leg5 = hdnLegname5_From.Value.ToString();
                    To_Leg5 = hdnLegname5_To.Value.ToString();

                    From_Leg6 = hdnLegname6_From.Value.ToString();
                    To_Leg6 = hdnLegname6_To.Value.ToString();

                }


                foreach (GridViewRow gridrow in gvEnroute.Rows)
                {
                    DropDownList ddlNExpense = (DropDownList)gridrow.FindControl("ddlNExpense");
                    HiddenField hfPolarity = (HiddenField)gridrow.FindControl("hfPolarity");
                    TextBox txtRemarks = (TextBox)gridrow.FindControl("txtRemarks");

                    TextBox txtAmount = (TextBox)gridrow.FindControl("txtAmount");
                    TextBox txtEAmt = (TextBox)gridrow.FindControl("txtEAmt");
                    HiddenField hfEAmt = (HiddenField)gridrow.FindControl("hfEAmt");
                    TextBox txtEnAmtTotal = (TextBox)gridrow.FindControl("txtEnAmtTotal");

                    TextBox txtAmount2 = (TextBox)gridrow.FindControl("txtAmount2");
                    TextBox txtEAmt2 = (TextBox)gridrow.FindControl("txtEAmt2");
                    HiddenField hfEAmt2 = (HiddenField)gridrow.FindControl("hfEAmt2");
                    TextBox txtEnAmtTotal2 = (TextBox)gridrow.FindControl("txtEnAmtTotal2");

                    TextBox txtAmount3 = (TextBox)gridrow.FindControl("txtAmount3");
                    TextBox txtEAmt3 = (TextBox)gridrow.FindControl("txtEAmt3");
                    HiddenField hfEAmt3 = (HiddenField)gridrow.FindControl("hfEAmt3");
                    TextBox txtEnAmtTotal3 = (TextBox)gridrow.FindControl("txtEnAmtTotal3");

                    TextBox txtAmount4 = (TextBox)gridrow.FindControl("txtAmount4");
                    TextBox txtEAmt4 = (TextBox)gridrow.FindControl("txtEAmt4");
                    HiddenField hfEAmt4 = (HiddenField)gridrow.FindControl("hfEAmt4");
                    TextBox txtEnAmtTotal4 = (TextBox)gridrow.FindControl("txtEnAmtTotal4");

                    TextBox txtAmount5 = (TextBox)gridrow.FindControl("txtAmount5");
                    TextBox txtEAmt5 = (TextBox)gridrow.FindControl("txtEAmt5");
                    HiddenField hfEAmt5 = (HiddenField)gridrow.FindControl("hfEAmt5");
                    TextBox txtEnAmtTotal5 = (TextBox)gridrow.FindControl("txtEnAmtTotal5");

                    TextBox txtAmount6 = (TextBox)gridrow.FindControl("txtAmount6");
                    TextBox txtEAmt6 = (TextBox)gridrow.FindControl("txtEAmt6");
                    HiddenField hfEAmt6 = (HiddenField)gridrow.FindControl("hfEAmt6");
                    TextBox txtEnAmtTotal6 = (TextBox)gridrow.FindControl("txtEnAmtTotal6");


                    SqlCommand sql_insert_veh = new SqlCommand("USP_FLEET_INSERT_LEGWISE_ENROUTE", conn, trans);
                    sql_insert_veh.CommandType = CommandType.StoredProcedure;

                    //First Leg

                    sql_insert_veh.Parameters.Add("@TripsheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_veh.Parameters.Add("@ID", SqlDbType.VarChar, 50).Value = ddlNExpense.SelectedValue;
                    sql_insert_veh.Parameters.Add("@Polarity", SqlDbType.VarChar, 1).Value = hfPolarity.Value.ToString();
                 
                    if (txtAmount.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent1", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent1", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt1", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt1", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt1", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }

                    sql_insert_veh.Parameters.Add("@From_Leg1", SqlDbType.VarChar, 50).Value = From_Leg1;
                    sql_insert_veh.Parameters.Add("@To_Leg1", SqlDbType.VarChar, 50).Value = To_Leg1;


                  //Second Leg

                    if (txtAmount2.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent2", SqlDbType.Float).Value = Convert.ToDouble(txtAmount2.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent2", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt2.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt2", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt2.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt2.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt2", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt2.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt2", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }
                    sql_insert_veh.Parameters.Add("@From_Leg2", SqlDbType.VarChar, 50).Value = From_Leg2;
                    sql_insert_veh.Parameters.Add("@To_Leg2", SqlDbType.VarChar, 50).Value = To_Leg2;

                    //Third Leg

                    if (txtAmount3.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent3", SqlDbType.Float).Value = Convert.ToDouble(txtAmount3.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent3", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt3.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt3", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt3.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt3.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt3", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt3.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt3", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }
                    sql_insert_veh.Parameters.Add("@From_Leg3", SqlDbType.VarChar, 50).Value = From_Leg3;
                    sql_insert_veh.Parameters.Add("@To_Leg3", SqlDbType.VarChar, 50).Value = To_Leg3;

                    //Fouth Leg

                    if (txtAmount4.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent4", SqlDbType.Float).Value = Convert.ToDouble(txtAmount4.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent4", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt4.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt4", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt4.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt4.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt4", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt4.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt4", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }
                    sql_insert_veh.Parameters.Add("@From_Leg4", SqlDbType.VarChar, 50).Value = From_Leg4;
                    sql_insert_veh.Parameters.Add("@To_Leg4", SqlDbType.VarChar, 50).Value = To_Leg4;

                    //Fifth Leg

                    if (txtAmount5.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent5", SqlDbType.Float).Value = Convert.ToDouble(txtAmount5.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent5", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt5.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt5", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt5.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt5.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt5", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt5.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt5", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }
                    sql_insert_veh.Parameters.Add("@From_Leg5", SqlDbType.VarChar, 50).Value = From_Leg5;
                    sql_insert_veh.Parameters.Add("@To_Leg5", SqlDbType.VarChar, 50).Value = To_Leg5;

                    //Sixth Leg

                    if (txtAmount6.Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent6", SqlDbType.Float).Value = Convert.ToDouble(txtAmount6.Text.ToString());
                    }
                    else
                    {
                        sql_insert_veh.Parameters.Add("@Amount_Spent6", SqlDbType.Float).Value = Convert.ToDouble("0");
                    }
                    if (hfEAmt6.Value != "")
                    {
                        sql_insert_veh.Parameters.Add("@Exe_Appr_Amt6", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt6.Value.ToString());
                    }
                    else
                    {
                        if (txtEAmt6.Text != "")
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt6", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt6.Text.ToString());
                        }
                        else
                        {
                            sql_insert_veh.Parameters.Add("@Exe_Appr_Amt6", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                    }
                    sql_insert_veh.Parameters.Add("@From_Leg6", SqlDbType.VarChar, 50).Value = From_Leg6;
                    sql_insert_veh.Parameters.Add("@To_Leg6", SqlDbType.VarChar, 50).Value = To_Leg6;


                    sql_insert_veh.ExecuteNonQuery();
                }

                #endregion


                #region CNOTE_DETAILS

                sqlDEL = "Delete from Webx_Fleet_Trip_Dockets where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

               foreach (GridViewRow gridrow in gvCnote.Rows)
                {
                    TextBox txtCnoteNo = (TextBox)gridrow.FindControl("txtCnoteNo");
                    TextBox txtBkgDate = (TextBox)gridrow.FindControl("txtBkgDate");
                    TextBox txtOriginDestination = (TextBox)gridrow.FindControl("txtOriginDestination");
                    TextBox txtPackage = (TextBox)gridrow.FindControl("txtPackage");
                    TextBox txtActualWeight = (TextBox)gridrow.FindControl("txtActualWeight");
                    TextBox txtChargedWeight = (TextBox)gridrow.FindControl("txtChargedWeight");
                    TextBox txtSubTotal = (TextBox)gridrow.FindControl("txtSubTotal");
                    TextBox txtCnoteTotal = (TextBox)gridrow.FindControl("txtCnoteTotal");
                    DropDownList ddlLegID = (DropDownList)gridrow.FindControl("ddlLegID");

                    string Origin = "";
                    string Destination = "";

                    string[] strArray;
                    strArray = txtOriginDestination.Text.Split(new char[] { '-' });

                    Origin = strArray[0].Trim();
                    Destination = strArray[1].Trim();

                    SqlCommand cmdCnote = new SqlCommand("USP_FLEET_INSERT_CNOTE_HDR_LEGWISE", conn, trans);
                    cmdCnote.CommandType = CommandType.StoredProcedure;
                    cmdCnote.Parameters.Add("@Tripsheetno", SqlDbType.VarChar).Value = mTripSheetNo;
                    cmdCnote.Parameters.Add("@LEGID", SqlDbType.VarChar).Value = ddlLegID.SelectedValue.ToString().Trim();
                    cmdCnote.Parameters.Add("@DockNo", SqlDbType.VarChar).Value = txtCnoteNo.Text.ToString();
                    cmdCnote.Parameters.Add("@DOCKDT", SqlDbType.VarChar).Value = txtBkgDate.Text.ToString();
                    cmdCnote.Parameters.Add("@ORGNCD", SqlDbType.VarChar).Value = Origin;
                    cmdCnote.Parameters.Add("@DESTCD", SqlDbType.VarChar).Value = Destination;
                    cmdCnote.Parameters.Add("@PKGSNO", SqlDbType.VarChar).Value = txtPackage.Text.ToString();
                    cmdCnote.Parameters.Add("@ACTUWT", SqlDbType.VarChar).Value = txtActualWeight.Text.ToString();
                    cmdCnote.Parameters.Add("@CHRGWT", SqlDbType.VarChar).Value = txtChargedWeight.Text.ToString();
                    cmdCnote.Parameters.Add("@SubTotal", SqlDbType.VarChar).Value = txtSubTotal.Text.ToString();
                    cmdCnote.Parameters.Add("@DKTTOT", SqlDbType.VarChar).Value = txtCnoteTotal.Text.ToString();
                    cmdCnote.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdCnote.ExecuteNonQuery();
                }

                #endregion


                double Total_Enroute_Standard_Amt= 0;
                double Total_Enroute_Amount_Actual = 0;
                double Total_Enroute_Deviation = 0;
                double Total_Enroute_Deviation_Percentage = 0;

                //Convert.ToDouble(hfEnAmtTotal.Value) + Convert.ToDouble(hfEnAmtTotal2.Value) + Convert.ToDouble(hfEnAmtTotal3.Value) + Convert.ToDouble(hfEnAmtTotal4.Value) + Convert.ToDouble(hfEnAmtTotal5.Value) + Convert.ToDouble(hfEnAmtTotal6.Value);

                Total_Enroute_Standard_Amt = Convert.ToDouble(hfEnAmtTotal.Value) + Convert.ToDouble(hfEnAmtTotal2.Value) + Convert.ToDouble(hfEnAmtTotal3.Value) + Convert.ToDouble(hfEnAmtTotal4.Value) + Convert.ToDouble(hfEnAmtTotal5.Value) + Convert.ToDouble(hfEnAmtTotal6.Value);
                hdnTotalEnrouteStandard.Value = Total_Enroute_Standard_Amt.ToString();

                Total_Enroute_Amount_Actual = Convert.ToDouble(hfETotalAmt.Value) + Convert.ToDouble(hfETotalAmt2.Value) + Convert.ToDouble(hfETotalAmt3.Value) + Convert.ToDouble(hfETotalAmt4.Value) + Convert.ToDouble(hfETotalAmt5.Value) + Convert.ToDouble(hfETotalAmt6.Value);
                hdnTotalEnrouteActual.Value = Total_Enroute_Amount_Actual.ToString();

                Total_Enroute_Deviation = Convert.ToDouble(Total_Enroute_Amount_Actual) - Convert.ToDouble(Total_Enroute_Standard_Amt);
                hdnDeviationEnroute.Value = Total_Enroute_Deviation.ToString();

                if (Total_Enroute_Amount_Actual == 0 || Total_Enroute_Amount_Actual == 0.00)
                {
                    Total_Enroute_Deviation_Percentage = 0;
                    hdnDeviationEnroutePerc.Value = Total_Enroute_Deviation_Percentage.ToString();
                }
                else
                {
                    Total_Enroute_Deviation_Percentage = (Total_Enroute_Deviation * 100) / Total_Enroute_Amount_Actual;
                    hdnDeviationEnroutePerc.Value = Total_Enroute_Deviation_Percentage.ToString();
                }

                sqlDEL = "Delete from WEBX_FLEET_NEW_TRIP_TOTAL_ENROUTE_FUEL where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                SqlCommand sql_insert_Enroute_Total = new SqlCommand("USP_FLEET_INSERT_ENROUTE_SUMMARY", conn, trans);
                sql_insert_Enroute_Total.CommandType = CommandType.StoredProcedure;

                sql_insert_Enroute_Total.Parameters.Add("@TRIPSHEETNO", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                sql_insert_Enroute_Total.Parameters.Add("@TOT_STANDARD_ENROUTE", SqlDbType.Float).Value = Convert.ToDouble(hdnTotalEnrouteStandard.Value.ToString());
                sql_insert_Enroute_Total.Parameters.Add("@TOT_ACTUAL_ENROUTE", SqlDbType.Float).Value = Convert.ToDouble(hdnTotalEnrouteActual.Value.ToString());
                sql_insert_Enroute_Total.Parameters.Add("@TOT_DEVIATION_ENROUTE", SqlDbType.Float).Value = Convert.ToDouble(hdnDeviationEnroute.Value.ToString());
                sql_insert_Enroute_Total.Parameters.Add("@TOT_DEVIATION_PERCENT_ENROUTE", SqlDbType.Float).Value = Convert.ToDouble(hdnDeviationEnroutePerc.Value.ToString());

                sql_insert_Enroute_Total.ExecuteNonQuery();


                trans.Commit();
                //trans.Rollback();
                success = true;


            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("frmNewTripFuelDetails.aspx?ID=" + mTripSheetNo + "&StartKM=" + hdnStartKM.Value, true);
                //Response.Redirect("frmNewTripDetailsUpdateNext.aspx?id=" + mTripSheetNo , true);
                //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
            }
        }
    }
}
