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
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    //private void FillLocation()
    //{
    //    String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + CmbRO.SelectedValue.ToString() + "' and report_loc<>loccode order by locname";
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open(); 
    //    }
    //    CmbLoc.Items.Clear();
    //    //for (int i = 1; i < CmbLoc.Items.Count; i++)
    //    //{
    //    //    if (CmbLoc.Items[i].Text == "All")
    //    //    {
    //    //        CmbLoc.Items.Remove("All");
    //    //    }
    //    //}
    //    CmbLoc.Items.Add("All"); 
       
    //    SqlCommand cmd = new SqlCommand(sqlstr, cn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            CmbLoc.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    CmbLoc.SelectedItem.Text = "All"; 
    //}
   
   
    protected void CmdSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("FrmExpArrival.aspx?location=" + TextBox1.Text + "&type=" + CmbRptType.Text + "");
    }
}
