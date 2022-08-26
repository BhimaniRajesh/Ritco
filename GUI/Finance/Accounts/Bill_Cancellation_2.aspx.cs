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

public partial class GUI_Finance_Accounts_Bill_Cancellation_2 : System.Web.UI.Page
{

    public static string strDateRange, strbillno, strcust, strbilltype, para;
    public static SqlConnection conn;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    public string mBusType;
    protected void Page_Load(object sender, EventArgs e)
    {
           conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
           para = Request.QueryString["para1"].ToString();
           if (para == "1")
            {

                strDateRange = Request.QueryString["strdt"].ToString();
                strbillno = "";
                strcust = Request.QueryString["strcust"].ToString();
                strbilltype = Request.QueryString["strbilltype"].ToString();
            }
            else
            {
                strbillno = Request.QueryString["strbillno"].ToString();
                strDateRange = "";
                strcust ="";
                strbilltype = "";
            }
            mBusType = Request.QueryString["BusType"].ToString();
            if (!IsPostBack)
            {
                 DipsplayReport();
                btn_submit.Attributes.Add("onclick", "javascript:return check_submit()");
            }
    }

    public void DipsplayReport()
    {   
        string billno = "";
        string empval ="";
        string lival = "0";
        string sqlcust="";
        string sqlbilltype="";
        string wheredtrange="";
        if (strcust == "")
            {
                sqlcust = "";
                lblcust.Text = "-";

            }
            else
            {
                sqlcust = "and ptmscd='" + strcust + "'";
                lblcust.Text = strcust;
            }


            if (strbilltype == "All")
            {
                sqlbilltype = "";
            }
               
            else
            {
                sqlbilltype = "and paybas='" + strbilltype + "'";
            }
            if (strbilltype == "")
            {
                lblseldet.Text = "-";
            }
            if (strDateRange == "")
            {
                lblseldet.Text = "-";
            }

            else
            {
                string[] strArrDtFromTo = strDateRange.Split('-');
                string strfrmdt = strArrDtFromTo[0];
                string strtodt = strArrDtFromTo[1];

                wheredtrange = " And (convert(datetime,bgndt,106)  ";
                wheredtrange += "  between convert(varchar,'" + strArrDtFromTo[0] + "',106) and convert(varchar,'" + strArrDtFromTo[1] + "',106))";


                lblseldet.Text = strDateRange;
            }

        string sql = "";
        if (para == "1")
        {
            sql = "select billno,bbrcd,bbrnm,ptmscd,ptmsnm,paybas=(case when paybas='2' then 'TBB BIll' when paybas='6' then 'Octroi BIll' else 'Trip Sheet Bill' end ),BILLAMT,Convert(varchar,bgndt,106) bgndt ,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,pendamt from webx_billmst where   billstatus != 'Bill Collected' and billstatus != 'Bill Cancelled' and CloseBill='N' and Bill_Cancel='N' " + sqlbilltype + sqlcust + wheredtrange + " and billamt=pendamt order by bgndt";
        }
        else
        {
            sql = "select billno,bbrcd,bbrnm,ptmscd,ptmsnm,paybas=(case when paybas='2' then 'TBB BIll' when paybas='6' then 'Octroi BIll' else 'Trip Sheet Bill' end ),BILLAMT,Convert(varchar,bgndt,106) bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,pendamt from webx_billmst where   billstatus != 'Bill Collected' and billstatus != 'Bill Cancelled' and CloseBill='N' and Bill_Cancel='N' and billno = '" + strbillno + "' and billamt=pendamt  order by bgndt";//and bbrcd='" + Session["brcd"].ToString() + "'
        }
        conn.Open();

        SqlCommand sqlCommand = new SqlCommand(sql,conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");


        ds.Tables[0].Columns.Add("Sno");
        ds.Tables[0].Columns.Add("Loc");
        ds.Tables[0].Columns.Add("cust");
           
        int sno = 1;
            //ds.Tables[0].Rows["report_loc"].ToString();

           foreach (DataRow dr in ds.Tables[0].Rows)
           {
               dr["Sno"] = sno;
               sno++;

               dr["Loc"] = dr["bbrcd"].ToString() + " : " + dr["bbrnm"].ToString();
               dr["cust"] = dr["ptmscd"].ToString() + " : " + dr["ptmsnm"].ToString();
               lblcust.Text = dr["ptmscd"].ToString() + " : " + dr["ptmsnm"].ToString();
           }

        GV_Booking.DataSource=ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
         
        GV_Booking.DataBind();
        if (GV_Booking.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }
        if (GV_Booking.Rows.Count == 0)
        {
            btn_submit.Visible = false;
        }

    }
    

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Booking.PageCount;
        GV_Booking.PageIndex = i;
        DipsplayReport();
    }
    public void fst(object sender, EventArgs e)
    {
        GV_Booking.PageIndex = 0;
        DipsplayReport();
    }
    protected void btn_submit1(object sender, EventArgs e)
    {
        string bilno="";
        string bills = "";
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
         
        string billstatusnew = "Bill Cancelled";

        SqlTransaction trn;
        trn = conn.BeginTransaction();


        try  //  try FOR ALL
        {
            foreach (GridViewRow gr in GV_Booking.Rows)
            {

                if (((CheckBox)gr.FindControl("chkbill")).Checked == true)
                {
                    bilno = gr.Cells[2].Text.ToString();
                    bills += bilno + " , ";


                    string paybas = gr.Cells[5].Text.ToString();


                    string sql = "update webx_billmst set BCANEMPCD='" + Session["EMPCD"].ToString() + "',CANCOMMENT='" + txtreson.Text + "',Bill_Cancel='Y',BCANDt='" + fn.Mydate1(txtdt.Text) + "',billstatus='" + billstatusnew + "' where billno='" + bilno + "'";

                    SqlCommand cmd = new SqlCommand(sql, conn,trn);
                    cmd.ExecuteNonQuery();

                    sql = "select paybas from webx_billmst where   billno='" + bilno + "'";
                    SqlDataReader dr_chk;
                    cmd = new SqlCommand(sql, conn, trn);
                    dr_chk = cmd.ExecuteReader();

                    if (dr_chk.Read())
                    {
                        paybas = Convert.ToString(dr_chk["paybas"]);
                    }
                    dr_chk.Close();
                    string sql2 = "";

                    if (paybas == "6")
                    {
                        sql2 = "update webx_trans_docket_status set OctroiBill='N' where dockno in (select dockno from webx_billdet where  billno='" + bilno + "') ";

                    }
                    else if (paybas == "9")
                    {
                        sql2 = "update webx_fleet_vehicle_issue set Billed_Yn='N' where VslipNo in (select TripSheetNo from Webx_billdet_TS where  billno='" + bilno + "') ";

                    }
                    else
                    {
                        sql2 = "update webx_trans_docket_status set Billed='N'  where dockno in (select dockno from webx_billdet where  billno='" + bilno + "') ";

                    }

                    SqlCommand cmd2 = new SqlCommand(sql2, conn, trn);
                    cmd2.ExecuteNonQuery();
                    if (paybas == "6")
                    {
                        sql2 = "exec usp_octroibill_cancel_transaction 1,'" + bilno + "','" + Session["finyear"].ToString().Substring(2,2) + "'";
                        cmd2 = new SqlCommand(sql2, conn, trn);
                        cmd2.ExecuteNonQuery();
                    }
                    else if (paybas == "9")
                    {
                        sql2 = "exec usp_TripBillcancel_Transaction 1,'" + bilno + "','" + Session["finyear"].ToString() + "'";
                        cmd2 = new SqlCommand(sql2, conn, trn);
                        cmd2.ExecuteNonQuery();

                    }
                    else
                    {
                        sql2 = "exec usp_Billcancel_Transaction 1,'" + bilno + "','" + Session["finyear"].ToString().Substring(2,2) + "'";
                        cmd2 = new SqlCommand(sql2, conn, trn);
                        cmd2.ExecuteNonQuery();
                    }

                }
            }
            int cnt = bills.Length;
            bills = bills.Substring(0, cnt - 2);
            trn.Commit();
            conn.Close();
            //Response.Redirect("Result.aspx?bills=" + bills);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();

        }
        
        Response.Redirect("Result.aspx?bills=" + bills);
    }
}
