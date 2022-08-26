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
using Microsoft.VisualBasic;
public partial class FrmCriteria : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        //string conName = txtDateFrom.ClientID;
        //string scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtDateFrom.Attributes.Add("onclick", scriptStr);
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            FillRO();
            FillLocation();
        }
    }
    private void FillRO()
    {
        
        Session["loc"] = "HQTR";
        string sqlstr = "select loccode,locname from webx_location where (report_loc='" + Session["LOC"] + "' and report_loc<>loccode ) or loc_level=(select loc_level from webx_location where loc_level='1' ) order by locname";        
        //select Type_code,[type_name] as type_name1 from webx_VENDOR_TYPE where Type_code='1'
        //select loccode+' : '+locname c1,loccode from webx_location where (report_loc='HQTR' and report_loc<>loccode ) or loc_level=(select loc_level from webx_location where loc_level='1' ) order by c1
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
       sqlstr = "select [type_name] as type_name1,Type_code from webx_VENDOR_TYPE where Type_code between 1 and 16";
       SqlDataAdapter da = new SqlDataAdapter(sqlstr, cn);
       ds.Clear(); 
       da.Fill(ds);
       CmbRO.DataSource = ds;
       CmbRO.DataTextField = "type_name1";
       CmbRO.DataValueField = "Type_code";
       CmbRO.DataBind();  
       
    }
    private void FillLocation()
        {
        //SqlCommand cmd = new SqlCommand("SELECT CURRBRCD FROM webx_empmst WHERE (EMPCD = 'P1438')", cn);
        String sqlstr = "select top 1 'All' as c1,'All' as c2 from webx_vendor_hdr m,webx_vendor_det n  union select m.vendorcode+' : '+m.vendorname c1,m.vendorcode c2 from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + CmbRO.Text + "' and (vendorbrcd='ALL' or vendorbrcd='" + Session["brcd"] + "')";

        //select top 1 'All' as c1,'All' as c2 from webx_vendor_hdr m,webx_vendor_det n  union select m.vendorcode+' : '+m.vendorname c1,m.vendorcode c2 from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='1' and (vendorbrcd='ALL' or vendorbrcd='UNHO')
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open(); 
        }
        
        ds.Clear(); 
        SqlDataAdapter da = new SqlDataAdapter(sqlstr, cn);
        da.Fill(ds);
        CmbLoc.DataSource = ds;
        CmbLoc.DataTextField = "c1";
        CmbLoc.DataValueField = "c2";
        CmbLoc.DataBind();  
    }
    protected void CmbRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation();    
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            BtnSubmit.Text = "Processing....";
            BtnSubmit.ForeColor = System.Drawing.Color.Red;
            BtnSubmit.BackColor = System.Drawing.Color.White;
            Response.Redirect("FrmVendorOutstanding.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&vendortype=" + CmbRO.Text.Trim()  + "&typename=" + CmbRO.SelectedItem.Text.Trim() + "&vendorcode=" + CmbLoc.Text.Trim() + "");
        }
    }
    public void abc(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radDate.SelectedItem.Text == " Last Week (Including Today)")
        {
            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
            DateTime MyDate = DateTime.Today;
            MyDate = MyDate + TimeSpan.FromDays(-7);
            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            
        }
        else
        {
            if (radDate.SelectedItem.Text == " Date Range [dd/mm/yyyy]")
            {
                DateTime MyDate = DateTime.Today;
                MyDate = MyDate + TimeSpan.FromDays(-31);
              //  txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateFrom.ReadOnly = false;
                txtDateTo.ReadOnly = false;
                
            }

            if (radDate.SelectedItem.Text == " Today:")
            {
                txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
                txtDateFrom.ReadOnly = true;
                txtDateTo.ReadOnly = true;
                
            }
        }
    }
    //protected void pqr()
    //{
    //    if (radDate.SelectedItem.Text == " Today:")
    //    {
    //        txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
    //        txtDateTo.Text = txtDateFrom.Text;
    //        txtDateFrom.ReadOnly = true;
    //        txtDateTo.ReadOnly = true;

    //    }
    //    else
    //        if (radDate.SelectedItem.Text == " Last Week (Including Today)")
    //        {
    //            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
    //            DateTime MyDate = DateTime.Today;
    //            MyDate = MyDate + TimeSpan.FromDays(-7);
    //            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
    //            txtDateFrom.ReadOnly = true;
    //            txtDateTo.ReadOnly = true;

    //        }    
    //}
}
