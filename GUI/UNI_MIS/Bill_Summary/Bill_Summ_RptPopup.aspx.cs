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
using System.Globalization;

public partial class GUI_UNI_MIS_Bill_Summary_Bill_Summ_RptPopup : System.Web.UI.Page
{
    public static SqlDataReader da;    
    public string BillGenDate, BillSubDate, BillDueDate, BillCollDate, BillGenBy, BillCollBy, BillBranch, BillType, PartyCode;
    public string PartyMail, BillSubBy, BillClose, PartyAdd, PartyPhone;
    string BillTyped, Bill_Number;
    DataSet ds = new DataSet();
    double Amount, Tax, Total;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblBill_No.Text = Request.QueryString["Bill_Number"];

        Bill_Number = lblBill_No.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "select  *  from webx_billmst where billno='" + Bill_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);        
        da = sqlCommand.ExecuteReader();

        while (da.Read())
        {
            DateTime BillGenDate1 = new DateTime();
            DateTime BillSubDate1 = new DateTime();
            DateTime BillDueDate1 = new DateTime();
            DateTime BillCollDate1 = new DateTime();

            if (da["bgndt"] != System.DBNull.Value)
            {
                BillGenDate1 = Convert.ToDateTime(da["bgndt"].ToString());
            }            
            BillGenDate = BillGenDate1.ToString("dd/MM/yyyy");

            if (da["bsbdt"] != System.DBNull.Value)
            {
                BillSubDate1 = Convert.ToDateTime(da["bsbdt"]);
            }
            
            BillSubDate = BillSubDate1.ToString("dd/MM/yyyy");

            if (da["bduedt"] != System.DBNull.Value)
            {
                BillDueDate1 = Convert.ToDateTime(da["bduedt"].ToString());
            }
            BillDueDate = BillDueDate1.ToString("dd/MM/yyyy");
            if (da["bcldt"] != System.DBNull.Value)
            {
                BillCollDate1 = Convert.ToDateTime(da["bcldt"].ToString());
            }
            BillCollDate = BillCollDate1.ToString("dd/MM/yyyy");

            BillGenBy = da["bgenempcd"].ToString();
            BillCollBy = da["bcolempcd"].ToString();
            BillBranch = da["bbrcd"].ToString() + " : " + da["bbrnm"].ToString();

            string BillType1 = da["paybas"].ToString();            
            if (BillType1 == "1")
            {
                BillTyped = "Paid";
            }
            if (BillType1 == "2")
            {
                BillTyped = "TBB";
            }
            if (BillType1 == "3")
            {
                BillTyped = "To Pay";
            }
            BillType = BillTyped.ToString();
            PartyCode = da["ptmscd"].ToString() + " : " + da["ptmsnm"].ToString();
            PartyMail = da["ptmsemail"].ToString();
            BillSubBy = da["bsubempcd"].ToString();
            BillClose = da["bcbsempcd"].ToString();
            PartyPhone = da["ptmstel"].ToString();
            PartyAdd = da["ptmsaddr"].ToString();
        }
        conn.Close();

        Bindgrid();
    }

    private void Bindgrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "select M.DOCKNO + M.DOCKSF as DocNo,M.ORGNCD As BookingBranch,M.reassign_destcd As DeliveryBranch,M.CDELDT As CommitedDelDt,M.DELYDT as actualdeldate,M.Dockdt as bookdate,d.DKTTOT as dkttot,m.chrgwt as chargewt ,d.SVCtax as svctax from webx_BILLDET M  left outer join  vw_Bill_Print_XLS D on m.dockno+m.docksf=d.dockno+d.docksf where M.Billno='" + Bill_Number + "'";        
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);
        da = sqlCommand.ExecuteReader();

        DataTable dt = new DataTable();

        dt.Columns.Add("RowCounter", typeof(string));
        dt.Columns.Add("DocNo", typeof(string));
        dt.Columns.Add("BookBranch", typeof(string));
        dt.Columns.Add("Delivery", typeof(string));
        dt.Columns.Add("DocDate", typeof(string));
        dt.Columns.Add("CommDate", typeof(string));
        dt.Columns.Add("ActualDate", typeof(string));
        dt.Columns.Add("ChrgWeight", typeof(string));
        dt.Columns.Add("DocAmt", typeof(string));
        dt.Columns.Add("SevTax", typeof(string));
        dt.Columns.Add("DocTotal", typeof(string));

        DataRow dr;
        DateTime Date = new DateTime();
        DateTime comDate = new DateTime();
        DateTime actDate = new DateTime();
        int count = 1;

         while (da.Read())
            {
                dr = dt.NewRow();
                dr["RowCounter"] = count++;
                dr["DocNo"] = da["DocNo"].ToString();
                dr["BookBranch"] = da["BookingBranch"].ToString();
                dr["Delivery"] = da["DeliveryBranch"].ToString();
                Date =Convert.ToDateTime(da["bookdate"]);
                dr["DocDate"] = Date.ToString("dd/MM/yyyy");
                comDate = Convert.ToDateTime(da["CommitedDelDt"]);
                dr["CommDate"] = comDate.ToString("dd/MM/yyyy");
                actDate = Convert.ToDateTime(da["actualdeldate"]);
                dr["ActualDate"] = actDate.ToString("dd/MM/yyyy"); 
                dr["ChrgWeight"] = da["chargewt"].ToString();
                //dr["DocAmt"] = drRows["dkttot"].ToString();
                //dr["SevTax"] = drRows["svctax"].ToString();
                //dr["DocTotal"] = drRows["MRSNo"].ToString();

                if (da["dkttot"] is DBNull)
                {
                    dr["DocAmt"] = "0.00";
                }
                else
                {
                    dr["DocAmt"] = Convert.ToDouble(da["dkttot"]).ToString("0.00");
                    Amount += Convert.ToDouble(da["dkttot"]);
                }

                if (da["svctax"] is DBNull)
                {
                    dr["SevTax"] = "0.00";
                }
                else
                {
                    dr["SevTax"] = Convert.ToDouble(da["svctax"]).ToString("0.00");
                    Tax += Convert.ToDouble(da["svctax"]);
                }

                dr["DocTotal"] =Convert.ToDouble(dr["DocAmt"]) + Convert.ToDouble(dr["SevTax"]);
                Total += Convert.ToDouble(dr["DocTotal"]);

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblDocAmt.Text = Amount.ToString();
                lblSerTax.Text = Tax.ToString();
                lblDocTotal.Text = Total.ToString();                               
            }
            da.Close();
            conn.Close();
    }
}
