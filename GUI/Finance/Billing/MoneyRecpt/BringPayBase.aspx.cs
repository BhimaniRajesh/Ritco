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

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("paybase") == 0)
        {
            string docno = Request.QueryString["code"].ToString();
            string qry = "SELECT *  FROM webx_docket WITH(NOLOCK) WHERE dockno='" + docno + "' AND paybas IN ('P03','P09','P02','P08')";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            string docketmode="",topaymr="",paidmr="",paybas="",tbb_bill="";
            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                docketmode = dr["docket_mode"].ToString();
                topaymr = dr["topaymr"].ToString();
                paidmr = dr["paidmr"].ToString();
                paybas = dr["paybas"].ToString();
                tbb_bill = dr["tbb_bill"].ToString();
            }
            dr.Close();

            // VARIABLE ARE FED WITH DATABASE RECORD NOW CONDITIONING WILL BE DONE
            if (i != 0)
            {
                if (docketmode.CompareTo("F") != 0)
                {
                    Response.Write("false|This docket is not Financially Completed|");
                    return;
                }
                else
                {
                    if (topaymr.CompareTo("Y") == 0)
                    {
                        string sqltopay = "SELECT msrno FROM vw_mr_hdr WHERE dockno='" + docno + "' AND mr_cancel='N'";
                        SqlCommand cmdtopaymr = new SqlCommand(sqltopay, con);
                        SqlDataReader drtopaymr;
                        drtopaymr = cmdtopaymr.ExecuteReader();
                        int recflag = 0;
                        string msrno = "";
                        while (drtopaymr.Read())
                        {
                            recflag = 1;
                            msrno = dr["msrno"].ToString();
                        }
                        drtopaymr.Close();

                        if (recflag == 1)
                        {
                            Response.Write("false|Mr already Made for this Docket MRSNO" + msrno + "|");
                            return;
                        }
                        else
                        {
                            if (paybas.CompareTo("P03") == 0)
                            {
                                string sqlpaybas = "SELECT * FROM webx_PDCTRN WHERE dockno='" + docno + "' AND pdcty='D' UNION SELECT * FROM webx_PDCTRN_arch WHERE dockno='" + docno + "' AND pdcty='D'";
                                SqlCommand cmdpaybas = new SqlCommand(sqltopay, con);
                                SqlDataReader drpaybas;
                                drpaybas = cmdtopaymr.ExecuteReader();
                                int recpay = 0;
                                while (drpaybas.Read())
                                {
                                    recpay = 1;
                                }
                                if (recpay == 0)
                                {
                                    Response.Write("false|DRS Not Made For this Docket|");
                                    return;
                                }
                                else
                                {
                                    Response.Write("true|" + topaymr + "|");
                                }
                            }
                            else
                            {
                                Response.Write("true|" + topaymr + "|");
                            }

                        }
                    }
                    else
                    {
                        if (tbb_bill.CompareTo("Y") == 0)
                        {
                            string sqlpaybas = "SELECT * FROM vw_billdet WHERE dockno='" + docno + "'";
                            SqlCommand cmdpaybas = new SqlCommand(sqlpaybas, con);
                            SqlDataReader drpaybas;
                            drpaybas = cmdpaybas.ExecuteReader();
                            int ii = 0;
                            string bilno="";
                            while (drpaybas.Read())
                            {
                                ii = 1;
                                bilno = dr["billno"].ToString();
                            }
                            if (ii == 1)
                            {
                                Response.Write("false|Bill already Made for this Docket Billno is : " + bilno + "|");
                            }

                        }
                        else if (paidmr.CompareTo("Y") == 0)
                        {
                            Response.Write("false|Paid MR Aleady Made for the docket|");
                        }
                        else
                        {
                            Response.Write("true|" + topaymr + "|");
                        }
                    }
                }
            }
            else
            {
                Response.Write("false|Plz Enter TBB/To Pay/BOD/National Docket |");
            }

        }
            
        con.Close();
    }
}
