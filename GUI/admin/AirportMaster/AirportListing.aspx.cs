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
    public string airportstr, tmptext;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //txtLocCod.Attributes.Add("onblur", "javascript:return Locationcheck(" + txtLocCod.ClientID + ")");
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        getstring();
        if (!IsPostBack)
        {
            getdata();
        }
    }
    private void getstring()
    {
        airportstr = "";
        string sql = "SELECT airportcity FROM webx_airport_master";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            if (airportstr == "")
            {
                airportstr = dr_Location.GetValue(0).ToString();
            }
            else
            {
                airportstr = airportstr + "," + dr_Location.GetValue(0).ToString();
            }
        }
        dr_Location.Close();
    }
    protected void GrdPaidFollow_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GrdPaidFollow.EditIndex = e.NewEditIndex;
        getdata();
        tmptext = ((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Text.Replace("'", "''");
        //editAirport.Value = tmptext;
        HiddenField editAirport = ((HiddenField)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("editAirport"));

        ((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Attributes.Add("onblur", "javascript:return airportcheck(this," + editAirport.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'

    }
    protected void GrdPaidFollow_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {             
        SqlCommand cmd = new SqlCommand("update webx_airport_master set airportcity='" + ((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txtaname")).Text.Replace("'", "''") + "' where airportcode = '" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblacode")).Text + "'", cn);
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
        SqlCommand cmd=new SqlCommand("delete from webx_airport_master where airportcode = '" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblacode")).Text + "'",cn);
        cmd.ExecuteNonQuery();
        getdata();
        
    }
    private void getdata()
    {
        string sqlGet = "Select airportcode, airportcity from webx_airport_master";
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds, "Airport");
        GrdPaidFollow.DataSource = ds.Tables["Airport"];
        GrdPaidFollow.DataBind(); 
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
 
    }
    protected void delairport(object sender,EventArgs e)
    {
        GrdPaidFollow.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).DataItemIndex;
        SqlCommand cmd = new SqlCommand("delete from webx_airport_master where airportcode = '" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblacode")).Text + "'", cn);
        cmd.ExecuteNonQuery();
        getdata();
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        {
        if (e.Row.RowType == DataControlRowType.DataRow)
            {
            if (e.Row.RowState == DataControlRowState.Edit)
                {

                    HiddenField editAirport = ((HiddenField)e.Row.FindControl("editAirport"));
                    ((TextBox)e.Row.FindControl("txtaname")).Attributes.Add("onblur", "javascript:return airportcheck(this," + editAirport.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'
                }
            }
        }
    }
}
