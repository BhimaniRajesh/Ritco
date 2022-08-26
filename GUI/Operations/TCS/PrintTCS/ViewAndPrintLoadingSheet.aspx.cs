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

public partial class GUI_Operations_TCS_PrintTCS_ViewAndPrintLoadingSheet : System.Web.UI.Page
{
    public string lsno;
    public string strLoadingSheetNo;
    public static string strLoadingSheetDate;
    public static string strLoadingSheetDateAsItIs;
    public static string strLoadingRouteCode;
    public static string strLoadingBranch;
    public static string strLoadingBranchCode;
    public static string strLoadingVehicle;
    public static string strLoadingSheetTCDate;
    public static string strLoadingSheetPrepBy, strEnterBy;
    public static string strLoadingSheetTCDateInTimeFormat, strEnterAt;    
    public static string Total_Pack;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lsno = HttpUtility.UrlDecode(Request.QueryString["MFNo"].ToString());

            string[] Split = lsno.Split(new Char[] { ',' });
            strLoadingSheetNo = Convert.ToString(Split[0]);
            //Response.Write(strLoadingSheetNo);
            //Response.End();
            string print_yn = Convert.ToString(Split[1]);

            //strLoadingSheetNo = "lsdel_0000021";

            //Get and Populate Loading Sheet details and display in tabular format
            getLoadingSheetDetails();

            //Paint dockets of the LS No.
            paintDocketListing();
        }
        //btnPrint.Attributes.Add("onclick", "Javascript:OpenInWindow('PrintLoadingSheet.aspx','400','700','0','0')");
    }

    private void getLoadingSheetDetails()
    {
        try
        {
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            string strSQL = "Select (select top 1 userid+' - '+Name from webx_master_users where userid=h.entryby) as EnterBy,(select top 1 DeliveryLocation from vw_LS_Detail_HR where LSNo=replace(h.LSNo,'.',''))as DevLoc,* From vw_LS_Header h Where replace(LSNo,'.','')='" + strLoadingSheetNo + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
            DataSet dsLS = new DataSet();

            sqlDA.Fill(dsLS);

            if (dsLS.Tables[0].Rows.Count > 0)
            {
                strLoadingSheetDate = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["LSDate"].ToString()).ToString("dd/MM/yyyy");
                strLoadingSheetDateAsItIs = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["LSDate"].ToString()).ToString("dd MMM yy");
                strLoadingRouteCode = dsLS.Tables[0].Rows[0]["Route_Code"].ToString();
                strLoadingBranch = dsLS.Tables[0].Rows[0]["LS_Branch"].ToString() + " - " + dsLS.Tables[0].Rows[0]["DevLoc"].ToString();//
                strLoadingBranchCode = dsLS.Tables[0].Rows[0]["LS_Branch"].ToString() + ":" + getBranchName(dsLS.Tables[0].Rows[0]["LS_Branch"].ToString()); 
                strLoadingVehicle = dsLS.Tables[0].Rows[0]["LS_VehicleNo"].ToString();
                strLoadingSheetTCDate = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["tcdt"].ToString()).ToString("dd/MM/yyyy");
                strLoadingSheetPrepBy = dsLS.Tables[0].Rows[0]["EnterBy"].ToString();
                //strLoadingSheetPrepBy = dsLS.Tables[0].Rows[0]["entryby"].ToString() + " : " + getEmployeeName(dsLS.Tables[0].Rows[0]["entryby"].ToString());
                strLoadingSheetTCDateInTimeFormat = Convert.ToDateTime(dsLS.Tables[0].Rows[0]["tcdt"].ToString()).ToString("HH : mm");
                strEnterAt = Session["HeadOfficeCode"].ToString()+" - "+ System.DateTime.Now.ToString("dd MMM yy");
                strEnterBy = Session["empcd"].ToString() + " - " + Session["empnm"].ToString();
            }
        }
        catch (Exception Ex)
        {

        }
    }

    private string getEmployeeName(string strEmployeeCode)
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            sqlConn.Open();

            string strSQL = "Select name as  empnm from webx_master_users where userid = '" + strEmployeeCode + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsEmployee = new DataSet();

            sqlDA.Fill(dsEmployee);

            return (dsEmployee.Tables[0].Rows.Count > 0 ? dsEmployee.Tables[0].Rows[0][0].ToString() : "-");
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getBranchName(string strBranchCode)
    {
        try
        {
            if (strBranchCode == "")
            {
                return "";
            }
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "webx_Check_Location";

            sqlCommand.Parameters.AddWithValue("@BRCD", strBranchCode);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsBranch = new DataSet();

            sqlDA.Fill(dsBranch);

            return (dsBranch.Tables[0].Rows.Count > 0 ? dsBranch.Tables[0].Rows[0]["LocName"].ToString() : "");
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private void paintDocketListing()
    {
        try
        {
            double package_l = 0;
            double package_b = 0;
            double weight_l = 0;
            double weight_b = 0;

            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");
            sqlConn.Open();

            string strSQL = "Select distinct (select top 1 codedesc from webx_master_general where codetype='Trn' and codeid=d.trn_mod)+' - '+ (select codedesc from webx_master_general where codetype='SERVTY' and codeid=service_class) as Mode,( from_loc+' - '+to_loc ) as LocationTo,(select top 1 codedesc from webx_master_general where codetype='paytyp' and codeid=paybas) as Pay_Mode,* From vw_LS_Detail_HR h with(NOLOCK) inner join webx_master_docket  D  with(NOLOCK)  on h.Docket_No=d.dockno+d.docksf where h.lsno='" + strLoadingSheetNo + "' order by d.dockno asc";
            //string strSQL = "Select * From vw_LS_Detail_HR Where replace(LSNo,'.','')='" + strLoadingSheetNo.Replace(".", "") + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDocketList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("DocketNo", typeof(string));
            dt.Columns.Add("Mode", typeof(string));
            dt.Columns.Add("DocketDate", typeof(string));
            dt.Columns.Add("BookingLocation", typeof(string));
            dt.Columns.Add("LocationTo", typeof(string));
            dt.Columns.Add("ConsName", typeof(string));
            dt.Columns.Add("CosgName", typeof(string));           
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsDocketList);
            int i = 1;

            if (dsDocketList.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["DocketNo"] = drRows["Docket_No"].ToString()+ " / " + Convert.ToString(drRows["Pay_Mode"]);
                    dr["Mode"] = drRows["Mode"].ToString();
                    dr["DocketDate"] = Convert.ToDateTime(drRows["BookingDt"].ToString()).ToString("dd MMM yy") + " - " + (drRows["DelyDate"] == System.DBNull.Value ? "" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
                    dr["BookingLocation"] = drRows["BookingLocation"].ToString() + " : " + drRows["DeliveryLocation"].ToString();
                    dr["LocationTo"] = drRows["LocationTo"].ToString();
                    dr["ConsName"] = getConsName(drRows["csgncd"].ToString(), drRows["ConsignorName"].ToString());
                    dr["CosgName"] = getConsName(drRows["csgecd"].ToString(), drRows["csgenm"].ToString());
                    dr["PackagesLB"] = drRows["Packages_L"].ToString() + "/" + drRows["Packages_B"].ToString();
                    dr["WeightLB"] = drRows["Weight_L"].ToString() + "/" + drRows["Weight_B"].ToString();
                    package_l += Convert.ToDouble(drRows["Packages_L"].ToString());
                    package_b += Convert.ToDouble(drRows["Packages_B"].ToString());
                    weight_l += Convert.ToDouble(drRows["Weight_L"].ToString());
                    weight_b += Convert.ToDouble(drRows["Weight_B"].ToString());

                    //dr.BeginEdit();
                    dt.Rows.Add(dr);
                    dt.Rows.Add("Comment", "", "", "", "", "Tally Count:", "");
                }

                lblPackage.Text = package_l.ToString("0.00") + "/" + package_b.ToString("0.00");
                lblWeight.Text = weight_l.ToString("0.00") + "/" + weight_b.ToString("0.00");
                Total_Pack = "of " + package_b.ToString();
                rptDocketList.DataSource = dt;
                rptDocketList.DataBind();
            }
        }
        catch (Exception Ex)
        {

        }
    }

    private string getConsName(string strConsCode, string strConsName)
    {
        if (strConsCode == "8888")
        {
            return strConsName;
        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ECfy#$");

            try
            {
                sqlConn.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConn;
                sqlCommand.CommandText = "select CustNm from webx_Custhdr where Custcd='" + strConsCode + "'";

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
                DataSet dsConsName = new DataSet();

                sqlDA.Fill(dsConsName);

                return dsConsName.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception Ex)
            {
                return "";
                sqlConn.Close();
            }
        }
    }
}
