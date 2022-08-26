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
    SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        //string conName = txtDateFrom.ClientID;
        //string scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtDateFrom.Attributes.Add("onclick", scriptStr);
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
        //string str = "select * from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        Session["loc"] = "HQTR";
        string sqlstr = "select loccode,locname from webx_location where (report_loc='" + Session["LOC"] + "' and report_loc<>loccode ) or loc_level=(select loc_level from webx_location where loc_level='1' ) order by locname";        
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        //CmbRO.DataSource = cmd.ExecuteReader();
        //CmbRO.DataTextField = "LocName";
        //CmbRO.DataValueField = "LocCode";
        //CmbRO.DataBind();
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        //ListItem a;
        //a = "All";
        //if (CmbRO.Items.FindByText("All")== a)
        //{

        //}
        //else
        //{
        //    CmbRO.Items.Add("All"); 
        //}
       for (int i = 1;i < CmbRO.Items.Count;i++) 
       {
           if (CmbRO.Items[i].Text == "All")
           {
               CmbRO.Items.Remove("All"); 
           }
       }
       CmbRO.Items.Add("All"); 
        SqlDataReader dread;
        //cmd = new SqlCommand(sqlstr, conn);
        dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                CmbRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        CmbRO.SelectedItem.Text = "All"; 
    }
    private void FillLocation()
    {
        String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + CmbRO.SelectedValue.ToString() + "' and report_loc<>loccode order by locname";
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open(); 
        }
        CmbLoc.Items.Clear();
        //for (int i = 1; i < CmbLoc.Items.Count; i++)
        //{
        //    if (CmbLoc.Items[i].Text == "All")
        //    {
        //        CmbLoc.Items.Remove("All");
        //    }
        //}
        CmbLoc.Items.Add("All"); 
       
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                CmbLoc.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        CmbLoc.SelectedItem.Text = "All"; 
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
            Response.Redirect("FrmToPayFollowUp.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&RO=" + CmbRO.Text + "&LocCode=" + CmbLoc.Text + "&CCode=" + TextBox1.Text + "");
        }
    }
    public void abc(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
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
