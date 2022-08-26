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
    SqlConnection cn; //= new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            Response.Redirect("FrmDetainedDockets.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&docketno=" + TxtAdviceNo.Text + "");
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
    
}
