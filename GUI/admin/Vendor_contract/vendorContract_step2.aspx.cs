using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class GUI_Admin_Vendor_contract_vendorContract_step2 : System.Web.UI.Page
{

    public static string vendtyp, vendorCode,CONTRACTCD, Flag;
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
         CONTRACTCD = Request.QueryString.Get("ContID");
         Flag = Request.QueryString.Get("Flag");
         tblPenalty.Style["display"] = "none";
         tblPenalty1.Style["display"] = "none";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {

            String SQL_Step2 = "select vendorCode,vendorName,vendor_type,Penalty_hour=isnull(Penalty_hour,0),Penalty_perContract=isnull(Penalty_perContract,0),Incentive_hour=isnull(Incentive_hour,0),Incentive_perContract=isnull(Incentive_perContract,0)  from webx_vendor_contract_summary where CONTRACTCD='" + CONTRACTCD + "'";

            SqlCommand Step2 = new SqlCommand(SQL_Step2, conn);

            SqlDataReader dr = Step2.ExecuteReader();
            while (dr.Read())
            {
                vendorCode = dr["vendorCode"].ToString();
                txtincperctr.Text = dr["Incentive_perContract"].ToString();
                txtincperhour.Text = dr["Incentive_hour"].ToString();
                txtpenperctr.Text = dr["Penalty_perContract"].ToString();
                txtpenperhour.Text = dr["Penalty_hour"].ToString();

                vendtyp = dr["vendor_type"].ToString().Trim();


            }


            if (vendtyp == "3" || vendtyp == "03" || vendtyp == "05" || vendtyp == "5")
            {
                long_trip_city.Visible = true;
                // lo.visible = true;
                if (vendtyp == "3" || vendtyp == "03")
                {
                    long_trip.Visible = true;
                    long_trip_km.Visible = true;

                    Mileage.Visible = true;
                }
            }

            if (vendtyp == "4" || vendtyp == "04")
            {
                // lo.visible = true;
                Col.Visible = true;


            }

            if (vendtyp == "2" || vendtyp == "02")
            {
                // lo.visible = true;
                month_fix.Visible = true;


            }

            if (vendtyp == "9" || vendtyp == "09")
            {
                // lo.visible = true;
                Air.Visible = true;

            }

            if (vendtyp == "10" || vendtyp == "010")
            {
                // lo.visible = true;
                Rail.Visible = true;

            }

            if (vendtyp == "8" || vendtyp == "08")
            {
                // lo.visible = true;
                Dely.Visible = true;
                Bkg.Visible = true;

            }

            if (Flag == "Y")
            {

                RetriveData();
               

            }
        }
        conn.Close();

    }

    private void RetriveData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        String sql_edit = "select top 1  matrixcode,slabvalue from webx_vendor_contract_charges where vendorcode='" + vendorCode + "' and contractcd='" + CONTRACTCD + "' order by chargeid desc";
        SqlCommand cmd3 = new SqlCommand(sql_edit, cn);
        SqlDataReader dr = cmd3.ExecuteReader();
        String mcode="" ;
        while (dr.Read())
        {
            //txtaddwtchrg.Text = dr["slabvalue"].ToString();
             mcode = dr["matrixcode"].ToString();
        }


       
        if (mcode == "1")
        {
            m1.Checked = true;
        }
        if (mcode == "11")
        {
            m11.Checked = true;
        }
        if (mcode == "2")
        {
            m2.Checked = true;
        }
        if (mcode == "3")
        {
            m3.Checked = true;
        }
        if (mcode == "4")
        {
            m4.Checked = true;
        }
        if (mcode == "5")
        {
            m5.Checked = true;
        }
        if (mcode == "6")
        {
            m6.Checked = true;
        }
        
        if (mcode == "7")
        {
            m7.Checked = true;
        }
        //if (mcode == "8")
        //{
        //    m8.Checked = true;
        //}
        if (mcode == "9")
        {
            m9.Checked = true;
        }
        if (mcode == "10")
        {
            m10.Checked = true;
        }
        dr.Close();

        String sql_edit1 = "select Penalty_hour,Penalty_perContract,Incentive_hour,Incentive_perContract from  webx_vendor_contract_summary where vendorcode='" + vendorCode + "' and contractcd='" + CONTRACTCD + "'";
        SqlCommand cmd4 = new SqlCommand(sql_edit1, cn);
        SqlDataReader dr1 = cmd4.ExecuteReader();
        while (dr1.Read())
        {
            txtpenperhour.Text = dr1["Penalty_hour"].ToString();
            txtpenperctr.Text = dr1["Penalty_perContract"].ToString();
            txtincperhour.Text = dr1["Incentive_hour"].ToString();
            txtincperctr.Text = dr1["Incentive_perContract"].ToString();
        }

        dr1.Close();

        cn.Close();
    }

    protected void Submit_Click(object sender, EventArgs e)
    {

        conn.Open();
        Int32 Penalty_hour,Penalty_perContract,Incentive_hour,Incentive_perContract;



        if (txtpenperhour.Text == "")
        {
            Penalty_hour = 0;
        }
        else
        {
            Penalty_hour = Convert.ToInt32(txtpenperhour.Text);
        }
         
         if (txtpenperctr.Text == "")
         {
             Penalty_perContract = 0;
         }
         else
         {
             Penalty_perContract = Convert.ToInt32(txtpenperctr.Text);
         }

         
         if (txtincperhour.Text == "")
         {
             Incentive_hour = 0;
         }
         else
         {
             Incentive_hour = Convert.ToInt32(txtincperhour.Text);
         }


         if (txtincperctr.Text == "")
         {
             Incentive_perContract = 0;
         }
         else
         {
             Incentive_perContract = Convert.ToInt32(txtincperctr.Text);
         }
         String sql_Step2_update = "update webx_vendor_contract_summary set [Penalty_hour]='" + Penalty_hour + "',[Penalty_perContract]= '" + Penalty_perContract + "',[Incentive_hour]	 ='" + Incentive_hour + "',[Incentive_perContract]='" + Incentive_perContract + "' where CONTRACTCD='" + CONTRACTCD + "'";

         SqlCommand cmduP = new SqlCommand(sql_Step2_update, conn);
         cmduP.ExecuteNonQuery();
         string st_matrixcode;
         string ContID = CONTRACTCD;
         string final;
         final = "?ContID=" + ContID;
         final += "&Flag=" + Flag;
         final += "&vendorCode=" + vendorCode;

         Response.Write("<br> vendtyp : " + vendtyp);
         if (vendtyp == "3" || vendtyp == "03" || vendtyp == "5" || vendtyp == "05")
         {
             if (vendtyp == "3" || vendtyp == "03")
             {
                 if (m1.Checked == true)
                 {
                     final += "&st_matrixcode=6";
                     Response.Redirect("vendorContract_longhaulroad_trip.aspx" + final);
                 }

                 if (m2.Checked == true)
                 {
                     final += "&st_matrixcode=6";
                     Response.Redirect("vendorContract_longhaulroad_km.aspx" + final);
                 }
                 if (m9.Checked == true)
                 {
                     final += "&st_matrixcode=6";
                     Response.Redirect("vendorContract_mileagebasis.aspx" + final);
                 }
             }
                  if (m11.Checked == true)
             {
                 final += "&st_matrixcode=6";
                 Response.Redirect("vendorContract_longhaulroad_trip_City.aspx" + final);
             }
         }
         if (vendtyp == "4" || vendtyp == "04")
         {

             if (m3.Checked == true)
             {
                 Response.Redirect("vendorContract_coload.aspx" + final);
             }
         }

         if (vendtyp == "2" || vendtyp == "02")
         {

             if (m10.Checked == true)
             {
                 Response.Redirect("vendorContract_local.aspx" + final);
             }
         }
         if (vendtyp == "9" || vendtyp == "09")
         {
             if (m4.Checked == true)
             {
                 Response.Redirect("vendorContract_air.aspx" + final);
             }
         }

         if (vendtyp == "10")
         {
             if (m5.Checked == true)
             {
                 Response.Redirect("vendorContract_rail.aspx" + final);
             }
         }
         if (vendtyp == "8" || vendtyp == "08")
         {
             if (m6.Checked == true)
             {
                 final += "&st_matrixcode=6";
                 Response.Redirect("vendorContract_delivery.aspx" + final);
             }
             if (m7.Checked == true)
             {
                 final += "&st_matrixcode=7";
                 Response.Redirect("vendorContract_pickup.aspx" + final);
             }
         }
         //if (m8.Checked == true)
         //{
         //    Response.Redirect("vendorContract_octroi.aspx" + final);
         //}
         
         


    }
}
