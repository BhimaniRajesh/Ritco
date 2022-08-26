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

public partial class GUI_admin_Zone_Master_zonelist : System.Web.UI.Page
{
    SqlConnection cn;
    public string zonestr, tmptext;
    Int16 i = -3;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            getdata();
        }
    }
    private void getstring(string str)
    {
        zonestr = "";
        string sql = "";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {

            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["hday_date"] + "'"));
        }
        dr_Location.Close();
    }
    static string dt;
    protected void GrdPaidFollow_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GrdPaidFollow.EditIndex = e.NewEditIndex;
        i = Convert.ToInt16(e.NewEditIndex);
        string statenm = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.EditIndex].FindControl("lblstateadd")).Text;
        dt = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.EditIndex].FindControl("lblhdate")).Text;
       
        getstring(statenm);
        getdata();
    }
    protected void GrdPaidFollow_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SqlCommand cmd = new SqlCommand("", cn);
        cmd.ExecuteNonQuery();
        GrdPaidFollow.EditIndex = -1;
        getdata();

    }
    protected void GrdPaidFollow_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GrdPaidFollow.EditIndex = -1;
        getdata();
    }
    protected void GrdPaidFollow_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SqlCommand cmd = new SqlCommand("", cn);
        cmd.ExecuteNonQuery();
        getdata();

    }
    private void getdata()
    {
        string sqlGet = "select * from webx_zonemaster";
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        GrdPaidFollow.DataSource = ds;
        GrdPaidFollow.DataBind();
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }
    protected void delairport(object sender, EventArgs e)
    {
        GrdPaidFollow.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).DataItemIndex;
        string dtdelete;
        dtdelete = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblhdate")).Text;
        SqlCommand cmd = new SqlCommand("", cn);
        cmd.ExecuteNonQuery();
        getdata();
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex == i)
        {
            Int32 j = i + 2;
            if (j < 10)
            {
                ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl0" + j + "_hiddenhdateedit')");
                
            }
            else
            {
                ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl" + j + "_hiddenhdateedit')");
               
            }

        }

    }
}
