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
using System.IO;
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn;// = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    string strqry,mode;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strqry = Convert.ToString(Request.QueryString["str"]);
        strqry = strqry.Replace("@", "+");
        //LblRptName.Text = "";
        //LblRptName.Text = "LOCATION:-" + Convert.ToString(Request.QueryString["Location"]) + "";
        lblDateRange.Text = Convert.ToString(Request.QueryString["daterange"]);
        lblLocation.Text = Convert.ToString(Request.QueryString["Location"]); 
        if (!IsPostBack)
        {
            mode = Convert.ToString(Request.QueryString["mode"]);
            BindTheData();
            //if (mode == "CNNo")
            //{
            //    bindcnno();
            //  }
            //else if (mode == "MFIn")
            //{
            //    bindmfin();
            //  }
            //else if (mode == "MFOut")
            //{
            //    bindmfout();
            //  }
            //else if (mode == "DRS")
            //{
            //    binddrs();
            //  }
            switch (mode)
            {
                case "CNNo":
                    bindcnno();
                    break;
                case "MFIn":
                    bindmfin();
                    break;
                case "MFOut":
                    bindmfout(); 
                    break;
                case "DRS":
                    binddrs(); 
                    break;
                default:
                    break;
             }
            GrdToPayFollow.DataBind();

        }
    }
    protected void bindmfin()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        GrdToPayFollow.Columns.Clear();
        //Unit un;
        //un = new Unit(10);
        BoundField bf_HelpDesk = new BoundField();

        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "SR.NO.";
        bf_HelpDesk.DataField = "SR.No";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "MF No.";
        bf_HelpDesk.DataField = "tcno";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Booking Location";
        bf_HelpDesk.DataField = "tcbr";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Bkg. Date";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "tcdt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Delivery Location";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "ToBH_CODE";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);
        
        
        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Delivery Date";
        bf_HelpDesk.DataField = "thcdt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total CNotes";
        bf_HelpDesk.DataField = "TOT_DKT";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total Act. Wt";
        bf_HelpDesk.DataField = "TOT_ACTUWT";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);
    
    }
    protected void bindcnno()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        GrdToPayFollow.Columns.Clear();
        //Unit un;
        //un = new Unit(10);
        BoundField bf_HelpDesk = new BoundField();

        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "SR.NO.";
        bf_HelpDesk.DataField = "SR.No";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = Convert.ToString((Session["DocketCalledAs"])); 
        bf_HelpDesk.DataField = "docket";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Dely. Location";
        bf_HelpDesk.DataField = "reassign_destcd";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Consignor";
        bf_HelpDesk.DataField = "Consignor";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Left;    
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Consignee";
        bf_HelpDesk.DataField = "Consignee";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Left;    
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);


        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Bkg. Date";
        bf_HelpDesk.DataField = "cdeldt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Dep. Date";
        bf_HelpDesk.DataField = "dep_dt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Arrival Date";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "arrv_dt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Dely. Date";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "dely_dt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

    }
    protected void bindmfout()
    {

        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        GrdToPayFollow.Columns.Clear();
        //Unit un;
        //un = new Unit(10);
        BoundField bf_HelpDesk = new BoundField();

        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "SR.NO.";
        bf_HelpDesk.DataField = "SR.No";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "MF No.";
        bf_HelpDesk.DataField = "tcno";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Booking Location";
        bf_HelpDesk.DataField = "tcbr";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        
        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Bkg. Date";
        bf_HelpDesk.DataField = "tcdt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Delivery Location";
        bf_HelpDesk.DataField = "ToBH_CODE";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total CNotes";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "TOT_DKT";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total Act. Wt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "TOT_ACTUWT";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

    }
    protected void binddrs()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        GrdToPayFollow.Columns.Clear();
        //Unit un;
        //un = new Unit(10);
        BoundField bf_HelpDesk = new BoundField();

        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "SR.NO.";
        bf_HelpDesk.DataField = "SR.No";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "DRS No.";
        bf_HelpDesk.DataField = "pdcno";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Location";
        bf_HelpDesk.DataField = "pdcbr";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        GrdToPayFollow.Columns.Add(bf_HelpDesk);


        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Date";
        bf_HelpDesk.DataField = "pdcdt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        bf_HelpDesk.DataFormatString = "{0:dd-MMM-yy}";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total CNotes";
        bf_HelpDesk.DataField = "TOT_DKTQTY_Load";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

        bf_HelpDesk = new BoundField();
        //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
        bf_HelpDesk.HeaderText = "Total Act. Wt";
        bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
        bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White; 
        bf_HelpDesk.ItemStyle.CssClass = "blackfnt";   
        bf_HelpDesk.DataField = "TOT_DKTWT_Load";
        //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
        bf_HelpDesk.HtmlEncode = false;
        //bf_HelpDesk.SortExpression = "locName";
        GrdToPayFollow.Columns.Add(bf_HelpDesk);

    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        
        cmd.Connection = cn;
        cmd.CommandText = strqry;
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }

        sqlDA.Fill(ds, "DocketDtl");
        DataColumn dc = new DataColumn("SR.No", typeof(Int32));
        DataRow dr;
        Int32 i = ds.Tables["DocketDtl"].Rows.Count;
        ds.Tables["DocketDtl"].Columns.Add(dc);
        for (int j = 1; j <= i; j++)
        {
            dr = ds.Tables["DocketDtl"].Rows[j-1];
            dr["SR.No"] = j;
            //ds.Tables["DocketDtl"].Rows.Add(dr);
        }
        //ds.Tables["DocketDtl"].Columns.Add(dc);       
        ds.Tables["DocketDtl"].AcceptChanges();  
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);// 
        //if (mode == "CNNo")
        //{ GrdToPayFollow.DataBind(); }
    }
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdToPayFollow.PageIndex = e.NewPageIndex;
        BindTheData();
        GrdToPayFollow.DataBind();  
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
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "ViewMR")
        {
            //LinkButton l1;
            //string a;
            //l1 = (LinkButton)e.Item.FindControl("lblPaidDocket");
            //a = l1.Text;
            //Response.Redirect("FrmDocketDetail.aspx");
        }
    }

   protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DocketDetail.csv"), false);

        ////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        //// First we will write the headers.
        //SqlDataAdapter sqlDA = new SqlDataAdapter(strqry, cn);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "DocketDtl");

        //DataTable dt2 = ds.Tables["DocketDtl"];// (DataTable)Session["dt1"];

        //int iColCount = dt2.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(dt2.Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);
        //// Now write all the rows.
        //foreach (DataRow dr in dt2.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();
        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("DocketDetail.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DocketDetail.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        GrdToPayFollow.AllowPaging = false;
        BindTheData();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(GrdToPayFollow);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
