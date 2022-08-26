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

public partial class GUI_admin_AirportMaster_AirportListing : System.Web.UI.Page
{
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    { 
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            getdata();
        }
    }
    private void getdata()
    {
        string sqlGet = "Select a.pincode, a.cityname,a.stastename as statecode,(select top 1 stnm from webx_state where stcd= a.stastename) as state from webx_pincode_master a";
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds, "pincode");
        GrdPaidFollow.DataSource = ds.Tables["pincode"];
        GrdPaidFollow.DataBind(); 
    }
    protected void delairport(object sender,EventArgs e)
    {
        GrdPaidFollow.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).DataItemIndex;
        SqlCommand cmd = new SqlCommand("delete from webx_pincode_master where pincode = '" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblpin")).Text + "' and cityname = '" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblcity")).Text + "' and stastename in (select stcd from webx_state where stcd='" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblstate")).Text + "')", cn);
        cmd.ExecuteNonQuery();
        getdata();
    }
    protected void editpincode(object sender, EventArgs e)
    {
        GrdPaidFollow.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).DataItemIndex;
        string stnm, citynm, pcode;
        stnm = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblstate")).Text;
        citynm = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblcity")).Text;
        pcode = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblpin")).Text;
        Response.Redirect("FrmPincodeCriteria.aspx?stnm=" + stnm + "&citynm="+ citynm +"&pcode="+ pcode +"&md=edit");
    }
}
