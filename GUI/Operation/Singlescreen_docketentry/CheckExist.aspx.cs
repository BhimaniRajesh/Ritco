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

public partial class GUI_Finance_Billing_BillEdit_BringBillDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
  
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
                
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
     
        if(mode.CompareTo("loc")==0)
            qry = "SELECT loccode FROM webx_location";
        else if(mode.CompareTo("doc")==0)
            qry = "SELECT dockno FROM webx_master_docket WHERE dockno='" + code + "'";
        else if (mode.CompareTo("city") == 0)
        {
            qry = "SELECT rtrim(ltrim(location)) FROM webx_citymaster WHERE location='" + code + "'";
        }
        else if (mode.CompareTo("docket") == 0)
        {
            con.Open();
            String strSQLNextStop = "usp_validate_docket_entry";

            SqlCommand sqlCommand = new SqlCommand(strSQLNextStop, con);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            DataSet dsdockno = new DataSet();

            sqlCommand.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = code;
            sqlCommand.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

            SqlDataReader dr_dockno;
            dr_dockno = sqlCommand.ExecuteReader();

            int count = 0;
            if (dr_dockno.Read())
            {
                count = Convert.ToInt16(dr_dockno[0].ToString());
            }
            dr_dockno.Close();

            if (count == 0)
                Response.Write("true|" + Session["DocketCalledAs"].ToString() + " is in Use or Not in Series or Invalid " + Session["DocketCalledAs"].ToString() + "|");
            else
                Response.Write("false|");

            return;
        }

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
       

        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              if(dr[0].ToString().ToUpper().CompareTo(code.ToUpper())==0)
              {
                  i = 1; break;
              }
            }
            dr.Close();

        // FINDING PINCODE OF THAT CITY IF VALID
            string pincode = "";
            if (mode.CompareTo("city") == 0 && i==1)
            {
                qry = "SELECT pincode FROM webx_pincode_master WHERE cityname='" + code + "'";
                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (pincode.CompareTo("") == 0)
                        pincode = dr["pincode"].ToString();
                    else
                        pincode = pincode + "," + dr["pincode"].ToString();
                }
                dr.Close();
            }


           if(i==0)
               Response.Write("false|");
           else if(i==1)
               Response.Write("true|");

           if (mode.CompareTo("city") == 0)
           {
               Response.Write(pincode + "|");
           }

        con.Close();
    }
 
}
