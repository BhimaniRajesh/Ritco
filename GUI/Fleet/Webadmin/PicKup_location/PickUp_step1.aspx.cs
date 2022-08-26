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
using System.Text; 



public partial class GUI_WebAdmin_PicKup_location_PickUp_step1 : System.Web.UI.Page
{
    SqlConnection conn;
    static string Pickuplocid, PicLoc;
   // String PicLoc;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        String sqlstr = "select top 1 0 as city_code,'--Select--' as location from webx_citymaster union select city_code,location from webx_citymaster with(NOLOCK) order by location ";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);

        conn.Open();


        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                cboCity.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        conn.Close();
        if (!(Page.IsPostBack))
        {
            Pickuplocid = Request.QueryString["id"];

            if (Pickuplocid != "" && Pickuplocid != null)
            {
                RetriveData();
                lblloccode.Text = Pickuplocid;
                PicLoc = txtLocname.Text;
            }
        }
        //onChange="javascript:this.value=this.value.toUpperCase();"
        txtLocname.Attributes.Add("onChange", "javascript:this.value=this.value.toUpperCase();");


        btnSave.Attributes.Add("onclick", "javascript:return Chk(" + txtLocname.ClientID + "," + cboCity.ClientID + "," + btnSave.ClientID + ")");
      //  btnSubmit.Attributes.Add("onclick", "javascript:return Chk(" + txtLocname.ClientID + "," + cboCity.ClientID + "," + btnSubmit.ClientID + ")");

    }

    private void RetriveData()
    {
        /// SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
        /// 

        


        conn.Open();
        string sql = "select pickup_locname,City_Code,ActiveFlag from webx_PICKUP_Location where pickup_loccode='" + Pickuplocid.ToString().Trim() + "'";
        SqlCommand cmd1 = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd1.ExecuteReader();

        while (dr.Read())
        {
            txtLocname.Text = Convert.ToString(dr["pickup_locname"]);
            txtActFlag.Text = Convert.ToString(dr["ActiveFlag"]);
            cboCity.Text = Convert.ToString(dr["City_Code"]);


            if (txtActFlag.Text == "Y")
            {
                c1.Checked = true;
            }
            else
            {
                c1.Checked = false;
            }
        }
        conn.Close();
    }

    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (Page.IsValid == true)

        //String PICklocname = txtLocname.Text;
        //String citycode = cboCity.SelectedValue.ToString();

       
                 string sql;
                 // Response.Write("<br> Pickuplocid : " + Pickuplocid);
                 //Response.End();
                 if (Pickuplocid != "" && Pickuplocid != null)
                 {

                     if (PicLoc == txtLocname.Text)
                     {
                         // SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
                         conn.Open();
                         sql = "update webx_PICKUP_Location set pickup_locname='" + txtLocname.Text + "',City_Code='" + cboCity.SelectedValue.ToString() + "',ActiveFlag='" + txtActFlag.Text + "' where pickup_loccode='" + Pickuplocid + "'";
                         SqlCommand cmd = new SqlCommand(sql, conn);
                         cmd.ExecuteNonQuery();
                         conn.Close();
                         Response.Redirect("PickupMaster.aspx");
                       
                     }
                     else
                     {
                         string SQL_validate = "Select count(*) as cnt from   webx_PICKUP_Location where pickup_locname='" + txtLocname.Text + "' and City_Code='" + cboCity.SelectedValue.ToString() + "'";
                         conn.Open();
                         SqlCommand validate = new SqlCommand(SQL_validate, conn);
                         Int32 a;
                         a = Convert.ToInt32(validate.ExecuteScalar());
                         conn.Close();
                         if (a > 0)
                         {
                             lbvalidate.Visible = true;
                             // Page.IsValid = false;
                         }
                         else
                         {
                             lbvalidate.Visible = false;
                             conn.Open();
                             sql = "update webx_PICKUP_Location set pickup_locname='" + txtLocname.Text + "',City_Code='" + cboCity.SelectedValue.ToString() + "',ActiveFlag='" + txtActFlag.Text + "' where pickup_loccode='" + Pickuplocid + "'";
                             SqlCommand cmd = new SqlCommand(sql, conn);
                             cmd.ExecuteNonQuery();
                             conn.Close();
                             Response.Redirect("PickupMaster.aspx");
                         }
                     }
                     
                 }
                 else
                 {
                     string SQL_validate = "Select count(*) as cnt from   webx_PICKUP_Location where pickup_locname='" + txtLocname.Text + "' and City_Code='" + cboCity.SelectedValue.ToString() + "'";
                     conn.Open();
                     SqlCommand validate = new SqlCommand(SQL_validate, conn);
                     Int32 a;
                     a = Convert.ToInt32(validate.ExecuteScalar());
                     conn.Close();
                     if (a > 0)
                     {
                         lbvalidate.Visible = true;
                         // Page.IsValid = false;
                     }
                     else
                     {
                         lbvalidate.Visible = false;
                         {//SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
                             conn.Open();
                             sql = "insert into webx_PICKUP_Location (pickup_locname,City_Code,ActiveFlag,EntryDate) values ('" + txtLocname.Text + "','" + cboCity.SelectedValue.ToString() + "','" + txtActFlag.Text + "',getdate())";
                            // Response.Write("<br> sql ; " + sql);
                             //Response.End();
                             SqlCommand cmd = new SqlCommand(sql, conn);
                             cmd.ExecuteNonQuery();
                             conn.Close();
                           }
                             Response.Redirect("PickupMaster.aspx");
                     }

            
         } 

        

        
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("PickUp_step2.aspx");
    }
}
