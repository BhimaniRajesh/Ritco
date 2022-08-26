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
    Int16 i = -3;
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
        string sql = "SELECT airlinename FROM webx_airline_master";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location = null;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            //if (airportstr == "")
            //{
            //    airportstr = dr_Location.GetValue(0).ToString();
            //}
            //else
            //{
            //    airportstr = airportstr + "," + dr_Location.GetValue(0).ToString();
            //}
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["airlinename"] + "'"));  
        }
        dr_Location.Close();
    }
    protected void GrdPaidFollow_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GrdPaidFollow.EditIndex = e.NewEditIndex;
        i = Convert.ToInt16(e.NewEditIndex);
        getdata();
        tmptext = ((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Text.Replace("'", "''");
        //editAirport.Value = tmptext;
        //HiddenField editAirport = ((HiddenField)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("editAirport"));

        //((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Attributes.Add("onblur", "javascript:return airportcheck(this," + editAirport.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'

    }
    protected void GrdPaidFollow_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SqlCommand cmd = new SqlCommand("update webx_airline_master set airlinename='" + ((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txtaname")).Text.Replace("'", "''") + "' where airlinecode = '" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblacode")).Text + "'", cn);
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
        SqlCommand cmd = new SqlCommand("delete from webx_airline_master where airlinecode = '" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblacode")).Text + "'", cn);
        cmd.ExecuteNonQuery();
        getdata();
        
    }
    private void getdata()
    {
        string sqlGet = "Select airlinecode, airlinename from webx_airline_master";
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
        SqlCommand cmd = new SqlCommand("delete from webx_airline_master where airlinecode = '" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblacode")).Text + "'", cn);
        cmd.ExecuteNonQuery();
        getdata();
    }
    //protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    {
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //        if (e.Row.RowState == DataControlRowState.Edit)
    //            {
    //                HiddenField editAirport = ((HiddenField)e.Row.FindControl("editAirport"));
    //                ((TextBox)e.Row.FindControl("txtaname")).Attributes.Add("onblur", "javascript:return abc(this," + editAirport.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'
    //            }
    //        }
    //    }
      
    //}
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //{
        if (e.Row.RowIndex == i)
        {
            //Int32 j = e.Row.RowIndex + 2;
            ((TextBox)e.Row.FindControl("txtaname")).Attributes.Add("onblur", "abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txtaname")).ClientID.ToString() + ")");
        }
                //((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur","abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl0" + j + "_hiddenhdateedit')");
                //ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");
            //}
            //else
            //{
              //  ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl" + j + "_hiddenhdateedit')");
                //ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");
                //txtMblNo.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");

    }
}
