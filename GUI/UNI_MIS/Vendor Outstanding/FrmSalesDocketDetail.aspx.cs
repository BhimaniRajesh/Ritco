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
using System.Globalization; 
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    string strqry,mode,sql;
    string FDate,TDate,VCode,Status,Arg;
    protected void Page_Load(object sender, EventArgs e)
    {
    cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    FDate = Convert.ToString(Request.QueryString["fromdate"]);
    TDate = Convert.ToString(Request.QueryString["todate"]);
    VCode = Convert.ToString(Request.QueryString["vcode"]);
    Status  = Convert.ToString(Request.QueryString["status"]);
    Arg = Convert.ToString(Request.QueryString["arg"]);
    lblDateRange.Text = FDate +" - "+TDate;
    lblStatus.Text = Status;
    lblLocation.Text = VCode;  
        if (!IsPostBack)
        {
            BindTheData();
        }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_Vendor_OS_Details";
        cmd.Parameters.AddWithValue("@vendor", VCode);
        cmd.Parameters.AddWithValue("@fromdt", FDate);
        cmd.Parameters.AddWithValue("@todt", TDate);
        cmd.Parameters.AddWithValue("@vendID", Arg);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "DocketDtl");
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);//
        if ((Arg == "1") || (Arg == "1a") || (Arg == "1b"))
        {
            DataRow dr;
            DataColumn dc9 = new DataColumn("thcos", typeof(Decimal));
            ds.Tables["DocketDtl"].Columns.Add(dc9);
            for (int i = 0; i < ds.Tables["DocketDtl"].Rows.Count; i++)
            {
                dr = ds.Tables["DocketDtl"].Rows[i];
                dr["thcos"] = (Convert.ToDecimal(ds.Tables["DocketDtl"].Rows[i]["THC_Expense"] == System.DBNull.Value ? 0.00 : ds.Tables["DocketDtl"].Rows[i]["THC_Expense"]) - Convert.ToDecimal(Convert.ToDouble(ds.Tables["DocketDtl"].Rows[i]["THC_Paid"]) == 0.00 ? 0.00 : ds.Tables["DocketDtl"].Rows[i]["THC_Paid"]));                
            }
        }
        BindGrid();
        GrdToPayFollow.DataBind();
    }
    protected void BindGrid()
    {
        if (GrdToPayFollow.Columns.Count == 1)
        {
            if ((Arg == "2") || (Arg == "2a") || (Arg == "2b"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "PRS No.";
                bf_HelpDesk.DataField = "pdcno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "pdcbr";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "PRS Date";
                bf_HelpDesk.DataField = "pdcdt"; 
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Code";
                bf_HelpDesk.DataField = "vendorcode";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Name";
                bf_HelpDesk.DataField = "vendorname";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "PRS Amount";
                bf_HelpDesk.DataField = "pdc_amt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Expense";
                bf_HelpDesk.DataField = "PRS_expense";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Paid";
                bf_HelpDesk.DataField = "PRS_paid";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "OS";
                bf_HelpDesk.DataField = "PRS_os";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

            }
            else if ((Arg == "3") || (Arg == "3a") || (Arg == "3b"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "DRS No.";
                bf_HelpDesk.DataField = "pdcno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "pdcbr";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "DRS Date";
                bf_HelpDesk.DataField = "pdcdt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Code";
                bf_HelpDesk.DataField = "vendorcode";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Name";
                bf_HelpDesk.DataField = "vendorname";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "DRS Amount";
                bf_HelpDesk.DataField = "pdc_amt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Expense";
                bf_HelpDesk.DataField = "DRS_expense";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Paid";
                bf_HelpDesk.DataField = "DRS_paid";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "OS";
                bf_HelpDesk.DataField = "DRS_os";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

            }
            else if ((Arg == "5") || (Arg == "5a") || (Arg == "5b"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Octroi Bill No.";
                bf_HelpDesk.DataField = "OCBILLNO";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Octroi Bill Date";
                bf_HelpDesk.DataField = "OCBILLDT";
                bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "OCBRCD";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor";
                bf_HelpDesk.DataField = "OCAGCD";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Due Date";
                bf_HelpDesk.DataField = "OCDUEDT";
                bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Remarks";
                bf_HelpDesk.DataField = "REMARK";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Voucher No.";
                bf_HelpDesk.DataField = "VOUCHERNO";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Expense";
                bf_HelpDesk.DataField = "Octroi_expense";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Paid";
                bf_HelpDesk.DataField = "Octroi_paid";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "OS";
                bf_HelpDesk.DataField = "Octroi_Os";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

            }
            else if ((Arg == "1") || (Arg == "1a") || (Arg == "1b"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "THC No.";
                bf_HelpDesk.DataField = "thcno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "THC Date";
                bf_HelpDesk.DataField = "thcdt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "thcbr";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Route Name";
                bf_HelpDesk.DataField = "routename";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vehicle No.";
                bf_HelpDesk.DataField = "vehno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Weight";
                bf_HelpDesk.DataField = "my_ld_actuwt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Code";
                bf_HelpDesk.DataField = "vendor_code";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Name";
                bf_HelpDesk.DataField = "vendor_name";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Expense";
                bf_HelpDesk.DataField = "THC_expense";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Paid";
                bf_HelpDesk.DataField = "THC_paid";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "OS";
                bf_HelpDesk.DataField = "thcos";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
            else if ((Arg == "4") || (Arg == "4a") || (Arg == "4b"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Bill No.";
                bf_HelpDesk.DataField = "billno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Bill Date";
                bf_HelpDesk.DataField = "billdt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "brcd";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Code";
                bf_HelpDesk.DataField = "vendorcode";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Name";
                bf_HelpDesk.DataField = "vendorname";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Bill No.";
                bf_HelpDesk.DataField = "vendorbillno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor Bill Date";
                bf_HelpDesk.DataField = "vendorbilldt";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Remarks";
                bf_HelpDesk.DataField = "Remark";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Voucher No.";
                bf_HelpDesk.DataField = "voucherno";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Expense";
                bf_HelpDesk.DataField = "Other_expense";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Paid";
                bf_HelpDesk.DataField = "Other_paid";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "OS";
                bf_HelpDesk.DataField = "Other_OS";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
        }

    }
    int _counter = 0;
    protected void GrdToPayFollow_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            _counter += 1;
            Label l = (Label)e.Row.FindControl("LblSrNo");
            l.Text = _counter.ToString();
            l.DataBind();
        }
    }
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        _counter = e.NewPageIndex * GrdToPayFollow.PageSize;
        GrdToPayFollow.PageIndex = e.NewPageIndex;
        BindTheData();
        //GrdToPayFollow.DataBind();  
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
        BindTheData();
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    
   protected void cmdexcel_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("ExcelDocketDetail.csv"), false);

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_Vendor_OS_Details";
        cmd.Parameters.AddWithValue("@vendor", VCode);
        cmd.Parameters.AddWithValue("@fromdt", FDate);
        cmd.Parameters.AddWithValue("@todt", TDate);
        cmd.Parameters.AddWithValue("@vendID", Arg);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "DocketDtl");
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);//
        if ((Arg == "1") || (Arg == "1a") || (Arg == "1b"))
        {
            DataRow dr;
            DataColumn dc9 = new DataColumn("thcos", typeof(Decimal));
            ds.Tables["DocketDtl"].Columns.Add(dc9);
            for (int i = 0; i < ds.Tables["DocketDtl"].Rows.Count; i++)
            {
                dr = ds.Tables["DocketDtl"].Rows[i];
                dr["thcos"] = (Convert.ToDecimal(ds.Tables["DocketDtl"].Rows[i]["THC_Expense"] == System.DBNull.Value ? 0.00 : ds.Tables["DocketDtl"].Rows[i]["THC_Expense"]) - Convert.ToDecimal(Convert.ToDouble(ds.Tables["DocketDtl"].Rows[i]["THC_Paid"]) == 0.00 ? 0.00 : ds.Tables["DocketDtl"].Rows[i]["THC_Paid"]));
            }
        }
        DataTable dt2 = ds.Tables["DocketDtl"];// (DataTable)Session["dt1"];

        int iColCount = dt2.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(dt2.Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);
        // Now write all the rows.
        foreach (DataRow dr in dt2.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();
        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("ExcelDocketDetail.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "ExcelDocketDetail.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
    }
    protected void GrdToPayFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
        
    }
}
