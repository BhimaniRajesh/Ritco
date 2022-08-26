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
using System.Globalization;
using System.Data.SqlClient;
//using CrystalDecisions.CrystalReports.Engine; 
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    string vtype = "";
    string vcode = "";
    string[] Arr = new string[2];
    
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        vtype = Request.QueryString["vendortype"];
        vcode = Request.QueryString["vendorcode"] == "All" ? "-" : Request.QueryString["vendorcode"];
        if (!IsPostBack)
        {
            //info.AddMergedColumns(new int[] { 2, 3, 4 }, "DRS");
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtRO.Text = Request.QueryString["typename"];
            txtLocation.Text = Request.QueryString["vendorcode"];
            lbldaterange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            BindTheData();
        }
    }
    public void BindTheData()
    {
        
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        if (vtype == "1")
        {
            cmd.CommandText = "webx_octroi_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
        }
        else if (vtype == "2")
        {
            cmd.CommandText = "webx_PRS_DRS_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@prstype", "P");
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", "2");
        }
        else if (vtype == "3")
        {
            cmd.CommandText = "webx_THC_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);

        }
        else if (vtype == "4")
        {
            cmd.CommandText = "webx_PRS_DRS_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@prstype", "D");
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", "4");

        }
        else if ((vtype == "5") || (vtype == "6") ||(vtype == "7") ||(vtype == "8") ||(vtype == "9") ||(vtype == "10") ||(vtype == "11") ||(vtype == "12") ||(vtype == "13") ||(vtype == "14") ||(vtype == "15"))
        {
            cmd.CommandText = "webx_Other_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", vtype);
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        Bindgrid();
        GrdPaidFollow.DataBind();  
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

            Int32 s;
            if (vtype == "1")
            {
                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "octroi_expense"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[3];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[3].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "octroi_paid"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[4];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[4].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "octroi_os"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[5];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[5].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }
            }
            else if (vtype == "2" || vtype == "4")
            {
                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PRS_expense"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[3];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[3].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PRS_paid"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[4];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[4].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PRS_os"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[5];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[5].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }
            }

            else if (vtype == "3")
            {
                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "THC_expense"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[3];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[3].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "THC_paid"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[4];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[4].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }

                s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "THC_os"));
                if (s == 0)
                {
                    DataControlFieldCell dfield;
                    dfield = (DataControlFieldCell)e.Row.Cells[5];
                    HyperLinkField hlf;
                    hlf = (HyperLinkField)dfield.ContainingField;
                    //hlf.DataTextField = "";
                    e.Row.Cells[5].Text = "0";
                    hlf.ItemStyle.Font.Underline = false;
                }
            }
            //else if ((vtype == "5") || (vtype == "6") || (vtype == "7") || (vtype == "8") || (vtype == "9") || (vtype == "10") || (vtype == "11") || (vtype == "12") || (vtype == "13") || (vtype == "14") || (vtype == "15") || (vtype == "16"))
            //{
            //    s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Other_expense"));
            //    if (s == 0)
            //    {
            //        DataControlFieldCell dfield;
            //        dfield = (DataControlFieldCell)e.Row.Cells[3];
            //        HyperLinkField hlf;
            //        hlf = (HyperLinkField)dfield.ContainingField;
            //        //hlf.DataTextField = "";
            //        e.Row.Cells[3].Text = "0";
            //        hlf.ItemStyle.Font.Underline = false;
            //    }

            //    s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Other_paid"));
            //    if (s == 0)
            //    {
            //        DataControlFieldCell dfield;
            //        dfield = (DataControlFieldCell)e.Row.Cells[4];
            //        HyperLinkField hlf;
            //        hlf = (HyperLinkField)dfield.ContainingField;
            //        //hlf.DataTextField = "";
            //        e.Row.Cells[4].Text = "0";
            //        hlf.ItemStyle.Font.Underline = false;
            //    }

            //    s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Other_os"));
            //    if (s == 0)
            //    {
            //        DataControlFieldCell dfield;
            //        dfield = (DataControlFieldCell)e.Row.Cells[5];
            //        HyperLinkField hlf;
            //        hlf = (HyperLinkField)dfield.ContainingField;
            //        //hlf.DataTextField = "";
            //        e.Row.Cells[5].Text = "0";
            //        hlf.ItemStyle.Font.Underline = false;
            //    }
            //}
        }
    }
    protected void Bindgrid()
    {
        GrdPaidFollow.AutoGenerateColumns = false;
        GrdPaidFollow.AllowSorting = false;
        if (GrdPaidFollow.Columns.Count == 1)
        {
            if (vtype == "1")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor";
                bf_HelpDesk.DataField = "vendor";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "VendorCode";
                bf_HelpDesk.DataField = "OCAGCD";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.Visible = false;  
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Buss.";
                hf_HelpDesk.DataTextField = "octroi_expense";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "OCAGCD";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                //hf_HelpDesk.NavigateUrl = "FrmSalesDocketDetail.aspx?vcode=" + bf_HelpDesk.DataField;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=5&status=Octroi Expense";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();               
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Coll.";
                hf_HelpDesk.DataTextField = "octroi_paid";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "OCAGCD";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=5a&status=Octroi Paid";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "O/S";
                hf_HelpDesk.DataTextField = "octroi_OS";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "OCAGCD";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=5b&status=Octroi Outstanding";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);
            }
            else if ((vtype == "2") || (vtype == "4"))
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor";
                bf_HelpDesk.DataField = "vendor";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendorcode";
                bf_HelpDesk.DataField = "vendorcode";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.Visible = false;  
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Expense";
                hf_HelpDesk.DataTextField = "PRS_expense";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendorcode";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                if (vtype == "2")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=2&status=PRS Expense";
                else if (vtype == "4")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=3&status=DRS Expense";
                
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Paid";
                hf_HelpDesk.DataTextField = "PRS_paid";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendorcode";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                if (vtype == "2")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=2a&status=PRS Paid";
                else if (vtype == "4")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=3a&status=DRS Paid";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "O/S";
                hf_HelpDesk.DataTextField = "PRS_OS";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendorcode";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                if (vtype == "2")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=2b&status=PRS Outstanding";
                else if (vtype == "4")
                    hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=3b&status=DRS Outstanding";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);
            }
            else if (vtype == "3")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendor";
                bf_HelpDesk.DataField = "vendor";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderText = "Vendorcode";
                bf_HelpDesk.DataField = "vendor_code";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.Visible = false;  
                GrdPaidFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Expense";
                hf_HelpDesk.DataTextField = "THC_expense";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendor_code";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=1&status=THC Expense";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "Paid";
                hf_HelpDesk.DataTextField = "THC_paid";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendor_code";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=1a&status=THC Paid";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderText = "O/S";
                hf_HelpDesk.DataTextField = "THC_OS";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "vendor_code";
                Arr[1] = "vendor";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=1b&status=THC Outstanding";
                GrdPaidFollow.Columns.Add(hf_HelpDesk);
            }
        }
        else if ((vtype == "5") || (vtype == "6") || (vtype == "7") || (vtype == "8") || (vtype == "9") || (vtype == "10") || (vtype == "11") || (vtype == "12") || (vtype == "13") || (vtype == "14") || (vtype == "15") || (vtype == "16"))
        {
            BoundField bf_HelpDesk = new BoundField();
            bf_HelpDesk = new BoundField();
            bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
            bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            bf_HelpDesk.HeaderText = "Vendor";
            bf_HelpDesk.DataField = "vendor";
            bf_HelpDesk.HtmlEncode = false;
            bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            GrdPaidFollow.Columns.Add(bf_HelpDesk);

            bf_HelpDesk = new BoundField();
            bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
            bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            bf_HelpDesk.HeaderText = "Vendorcode";
            bf_HelpDesk.DataField = "vendorcode";
            bf_HelpDesk.HtmlEncode = false;
            bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            bf_HelpDesk.Visible = false;
            GrdPaidFollow.Columns.Add(bf_HelpDesk);

            HyperLinkField hf_HelpDesk;
            hf_HelpDesk = new HyperLinkField();
            hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
            hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            hf_HelpDesk.HeaderText = "Expense";
            hf_HelpDesk.DataTextField = "Other_expense";
            hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
            hf_HelpDesk.ControlStyle.Font.Underline = true;
            Array.Clear(Arr, 0, 2);
            Arr[0] = "vendorcode";
            Arr[1] = "vendor";
            hf_HelpDesk.DataNavigateUrlFields = Arr;
            hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=4&status=DRS Expense";
            GrdPaidFollow.Columns.Add(hf_HelpDesk);

            hf_HelpDesk = new HyperLinkField();
            hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
            hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            hf_HelpDesk.HeaderText = "Paid";
            hf_HelpDesk.DataTextField = "Other_paid";
            hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
            hf_HelpDesk.ControlStyle.Font.Underline = true;
            Array.Clear(Arr, 0, 2);
            Arr[0] = "vendorcode";
            Arr[1] = "vendor";
            hf_HelpDesk.DataNavigateUrlFields = Arr;
            hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=4a&status=DRS Paid";
            GrdPaidFollow.Columns.Add(hf_HelpDesk);

            hf_HelpDesk = new HyperLinkField();
            hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
            hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            hf_HelpDesk.HeaderText = "O/S";
            hf_HelpDesk.DataTextField = "Other_OS";
            hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
            hf_HelpDesk.ControlStyle.Font.Underline = true;
            Array.Clear(Arr, 0, 2);
            Arr[0] = "vendorcode";
            Arr[1] = "vendor";
            hf_HelpDesk.DataNavigateUrlFields = Arr;
            hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?vcode={0}&fromdate=" + TxtFDt.Text + "&todate=" + TxtTDt.Text + "&arg=4b&status=DRS Outstanding";
            GrdPaidFollow.Columns.Add(hf_HelpDesk);
        }       
    }

    protected void GrdToPayFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.Header)
        //    e.Row.SetRenderMethodDelegate(RenderHeader);
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if ((vtype == "1"))
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow;
                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oTableCell.Font.Bold = true;
                oTableCell.ColumnSpan = 1;
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);



                oTableCell = new TableCell();
                oTableCell.ColumnSpan = 1;
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.CssClass = "blackfnt"; 
                oTableCell.ColumnSpan = 3;
                oTableCell.Text = "Octroi";
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);


                oGridViewRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);  
            }
            else if ((vtype == "2") || (vtype == "4"))
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow;
                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oTableCell.Font.Bold = true;
                
                oTableCell.ColumnSpan = 1;
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);



                oTableCell = new TableCell();
                oTableCell.ColumnSpan = 1;
                
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 3;
                if (vtype == "2")
                {
                    oTableCell.Text = "PRS";
                }
                else
                {
                    oTableCell.Text = "DRS";
                }
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);


                oGridViewRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);
            }
            else if (vtype == "3")
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow;
                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oTableCell.Font.Bold = true;
                //oTableCell.Text = "smarty sandy"; 
                oTableCell.ColumnSpan = 1;
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.ColumnSpan = 1;
                //oTableCell.Text = "hiiii sandy"; 
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 3;
                oTableCell.Text = "THC";
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);


                oGridViewRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);
            }
            else if ((vtype == "5") || (vtype == "6") || (vtype == "7") || (vtype == "8") || (vtype == "9") || (vtype == "10") || (vtype == "11") || (vtype == "12") || (vtype == "13") || (vtype == "14") || (vtype == "15") || (vtype == "16"))
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow;
                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oTableCell.Font.Bold = true;
                oTableCell.Text = "";
                oTableCell.ColumnSpan = 1;
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.ColumnSpan = 1;
                //oTableCell.Text = "hiiii sandy"; 
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 3;
                oTableCell.Text = "Other";
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);


                oGridViewRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);
            }
        }

        
    }

    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        _counter = e.NewPageIndex * GrdPaidFollow.PageSize;
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["LoadUnload"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        GrdPaidFollow.DataBind();  
       
    }
    
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {

    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_ToPay_arrv_out";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        Session["LoadUnload"] = ds;
        Response.Redirect("FrmToPayFollowUpRPT.aspx");  
        }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("ExcelVendorOutstanding.csv"), false);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        if (vtype == "1")
        {
            cmd.CommandText = "webx_octroi_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
        }
        else if (vtype == "2")
        {
            cmd.CommandText = "webx_PRS_DRS_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@prstype", "P");
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", "2");
        }
        else if (vtype == "3")
        {
            cmd.CommandText = "webx_THC_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);

        }
        else if (vtype == "4")
        {
            cmd.CommandText = "webx_PRS_DRS_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@prstype", "D");
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", "4");

        }
        else if ((vtype == "5") || (vtype == "6") || (vtype == "7") || (vtype == "8") || (vtype == "9") || (vtype == "10") || (vtype == "11") || (vtype == "12") || (vtype == "13") || (vtype == "14") || (vtype == "15"))
        {
            cmd.CommandText = "webx_Other_Vendor_OS2";
            cmd.Parameters.AddWithValue("@vendor", vcode);
            cmd.Parameters.AddWithValue("@fromdt", TxtFDt.Text);
            cmd.Parameters.AddWithValue("@todt", TxtTDt.Text);
            cmd.Parameters.AddWithValue("@ventype", vtype);
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        Bindgrid();
        GrdPaidFollow.DataBind();  
        DataTable dt2 = ds.Tables["LoadUnload"];// (DataTable)Session["dt1"];

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
        foreach (DataRow dr1 in dt2.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr1[i]))
                {
                    sw.Write(dr1[i].ToString());
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
        fs = System.IO.File.Open(Server.MapPath("ExcelVendorOutstanding.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "ExcelVendorOutstanding.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
    }
}
