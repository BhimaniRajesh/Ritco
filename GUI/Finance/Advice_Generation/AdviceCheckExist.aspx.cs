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

        string adviceno = Request.QueryString["adviceno"].ToString();

        /*Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        */

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "SELECT convert(varchar,AdviceDt,103) as AdviceDt,RaisedOn,ADVICESTATUS,ADVICE_CANCEL FROM WEBX_ADVICE_HDR  WHERE  ADVICENO = '" + adviceno + "' and RaisedOn = '" + Session["brcd"].ToString() + "'";
        
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
       
        con.Open();
        dr = cmd.ExecuteReader();

        string AdviceDt = "", RaisedOn = "", Resstr = "", ADVICESTATUS = "", ADVICE_CANCEL = "",Advice_yn="N";
        
        int i = 0;
            while (dr.Read())
            {
              //if(dr[0].ToString().CompareTo(code)==0)
              //{ 
                  AdviceDt = dr["AdviceDt"].ToString();
                  RaisedOn = dr["RaisedOn"].ToString();
                  ADVICESTATUS = dr["ADVICESTATUS"].ToString();
                  
                  ADVICE_CANCEL = dr["ADVICE_CANCEL"].ToString();
                  Advice_yn = "Y";
                  i = 1; 
                  break;
              //}
            }
            Resstr = AdviceDt + "," + RaisedOn;

            Response.Write(Advice_yn + "|" + AdviceDt + "|" + RaisedOn + "|" + ADVICESTATUS + "|" + ADVICE_CANCEL);

        con.Close();
    }
 
}
