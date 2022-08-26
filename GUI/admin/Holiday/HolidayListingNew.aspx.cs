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
    public string holidaystr, tmptext;
    Int16 i = -3;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //txtLocCod.Attributes.Add("onblur", "javascript:return Locationcheck(" + txtLocCod.ClientID + ")");
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            getdata();
        }
    }
    private void getstring(string str)
    {
        holidaystr = "";
        string sql = "select convert(varchar,HDAY_date,103) as hday_date from webx_holiday where HDAY_REGION in(select stcd from webx_state where stnm='" + str + "')";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            //if (holidaystr == "")
            //{
            //    holidaystr = dr_Location.GetValue(0).ToString();
            //}
            //else
            //{
            //    holidaystr = holidaystr + "," + dr_Location.GetValue(0).ToString();
            //}
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["hday_date"] + "'"));  
        }
        dr_Location.Close();
    }
    static string dt;
    //public static HiddenField h1;
    protected void GrdPaidFollow_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GrdPaidFollow.EditIndex = e.NewEditIndex;
        i = Convert.ToInt16(e.NewEditIndex);
        string statenm = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.EditIndex].FindControl("lblstateadd")).Text;
        dt = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.EditIndex].FindControl("lblhdate")).Text;
        //hiddenhdate.Value = dt; 
        //h1.Value = dt;
        getstring(statenm);
        getdata();
        //tmptext = ((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Text.Replace("'", "''");
        //editAirport.Value = tmptext;
        //HiddenField editAirport = ((HiddenField)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("editAirport"));

        //((TextBox)GrdPaidFollow.Rows[e.NewEditIndex].FindControl("txtaname")).Attributes.Add("onblur", "javascript:return abc(this," + editAirport.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'

    }
    protected void GrdPaidFollow_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SqlCommand cmd = new SqlCommand("update webx_holiday set UPDTBY='" + Session["empcd"].ToString().Trim() + "',HDAY_DATE=convert(datetime,'" + (((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txthdate")).Text) + "',103),HDAY_NOTE='" + ((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txtnote")).Text + "',UPDTON = '" + System.DateTime.Now.ToShortDateString() + "' where HDAY_REGION  in (select stcd from webx_state where stnm='" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblstatedit")).Text + "') and convert(varchar,hday_date,103)='" + dt + "'", cn);
        //update webx_holiday set UPDTBY='" + Session["empcd"].ToString().Trim() + "',HDAY_REGION='" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblstatedit")).Text + "',HDAY_DATE='" + Convert.ToDateTime(((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txthdate")).Text) + "',HDAY_NOTE='" + ((TextBox)GrdPaidFollow.Rows[e.RowIndex].FindControl("txthdate")).Text + "',ACTIVEFLAG='" + txtActFlag.Text + "',UPDTON = '" + System.DateTime.Now.ToShortDateString() + "' where HDAY_REGION='" + strdRg + "' and HDAY_DATE='" + strdLocWhole[1].ToString() + "'
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
        SqlCommand cmd = new SqlCommand("delete from webx_holiday where HDAY_REGION = '" + ((Label)GrdPaidFollow.Rows[e.RowIndex].FindControl("lblstateadd")).Text + "'", cn);
        cmd.ExecuteNonQuery();
        getdata();
        
    }
    private void getdata()
    {
        string sqlGet = "select *,(select top 1  stnm from webx_state where stcd=webx_HOLIDAY.hday_region) as stnm,convert(varchar, HDAY_DATE,103) as HDAY_DATE_103 from webx_HOLIDAY";
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds, "Holiday");
        GrdPaidFollow.DataSource = ds.Tables["Holiday"];
        GrdPaidFollow.DataBind(); 
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
 
    }
    protected void delairport(object sender,EventArgs e)
    {
        GrdPaidFollow.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).DataItemIndex;
        string dtdelete;
        dtdelete = ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblhdate")).Text;
        SqlCommand cmd = new SqlCommand("delete from webx_holiday where HDAY_REGION  in (select stcd from webx_state where stnm='" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblstateadd")).Text + "') and convert(varchar,hday_date,103)='" + dtdelete + "'", cn);
        //SqlCommand cmd = new SqlCommand("delete from webx_airport_master where airportcode = '" + ((Label)GrdPaidFollow.Rows[GrdPaidFollow.SelectedIndex].FindControl("lblacode")).Text + "'", cn);
        cmd.ExecuteNonQuery();
        getdata();
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //{
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //    if (e.Row.RowState == DataControlRowState.Edit)
        //        {

        //            //HiddenField editAirport = ((HiddenField)e.Row.FindControl("editAirport"));
        //            ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "javascript:return holidaycheck(this," + txthdate.ClientID + ")");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'
        //        }
        //    }
        //}
        if (e.Row.RowIndex == i)
        {
            //ctl00_MyCPH1_GrdPaidFollow_ctl02_hiddenhdateadd
            Int32 j = i + 2;
            if (j < 10)
            {
                ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl0" + j + "_hiddenhdateedit')");
                //((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur","abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl0" + j + "_hiddenhdateedit')");
                //ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");
            }
            else
            {
                ((TextBox)e.Row.FindControl("txthdate")).Attributes.Add("onblur", "ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");abc(" + e.Row.RowIndex + "," + ((TextBox)e.Row.FindControl("txthdate")).ClientID.ToString() + ",'ctl00_MyCPH1_GrdPaidFollow_ctl" + j + "_hiddenhdateedit')");
                //ValidateDate(" + ((TextBox)e.Row.FindControl("txthdate")).ClientID + ");
                //txtMblNo.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");

            }

        }

    }
}
