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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, stradvno, strbranch,strcust ,strmrtype , para, strdocno, strdocsf;
    public static SqlConnection conn;
    public  DataSet ds = new DataSet();
    MyFunctions fn = new MyFunctions();
    public static int intTotalRecords = 0;
    string FromDtae = "", ToDtae = "", Billtype = "", Billno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        btn_submit.Attributes.Add("onClick", "javascript:return ValidateForm(" + txtdt.ClientID + "," + txtreson.ClientID + ")");
        //btn_submit.Attributes.Add("onClick", "javascript:return ValidateForm2(" + txtreson.ClientID + ")");
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        Billtype = Request.QueryString["Billtype"].ToString();
        Billno = Request.QueryString["Billno"].ToString();
        conn.Open();
        if (!IsPostBack)
        {
            
            DipsplayReport();
        }
        conn.Close();
    }

    public void DipsplayReport()
    {

        string sql = "exec USP_BillEntry_Listing '" + FromDtae + "','" + ToDtae + "','" + Billno + "','" + Billtype + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        intTotalRecords = ds.Tables[0].Rows.Count;
        GV_Booking.DataSource = dv;
        GV_Booking.DataBind();

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
        string adno = "";
        string ads = "";
          string ads2 = "";

        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }


        string[] strDtFrom = txtdt.Text.Split('/');

        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

        //DateTime d1 = System.DateTime.Now;
        //Convert.ToDateTime(txtdt.Text).ToString("dd/MM/yyyy");

        string ddt = d1.ToString("MM/dd/yyyy");

        string sql = "",sql2 = "";
        string btyp = "";
        string list = "";
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        try
        {
            foreach (GridViewRow gr in GV_Booking.Rows)
            {

                if (((CheckBox)gr.FindControl("chkbill")).Checked == true)
                {
                    adno = gr.Cells[1].Text.ToString();
                    btyp = gr.Cells[5].Text.ToString();
                    list += adno + ",";

                    if (Billtype == "Octroi")
                    {
                        
                        sql = "update webx_oct_hdr set CANCEL_BY='" + Session["EMPCD"].ToString() + "',CANCEL_DT='" + ddt + "',cancel_reason='" + txtreson.Text + "',CANCEL_YN='Y' where ocbillno = '" + adno + "'";

                    }
                    else
                    {
                        sql = "update webx_vendorbill_hdr set cancel_by='" + Session["EMPCD"].ToString() + "',cancel_dt='" + ddt + "',cancel_Reason='" + txtreson.Text + "',bill_cancel='Y' where billno = '" + adno + "'";
                    }


                    SqlCommand cmd = new SqlCommand(sql, conn,trn);
                    cmd.ExecuteNonQuery();


                    if (Billtype == "THC")
                    {
                        sql2 = "update webx_THC_SUMMARY set vendorBENo = NULL,vendorBillNo = NULL  where vendorbillno='" + adno + "'";
                       
                    }
                    else if (Billtype == "PDC")
                    {

                        sql2 = "update webx_pdchdr set vendorBENo = NULL,vendorBillNo = NULL where vendorbillno='" + adno + "'";
                    }
                    else if (Billtype == "Octroi")
                    {

                        sql2 = "Update webx_trans_docket_status set Octroi='N' where Dockno in (select dockno from webx_oct_det where ocbillno='" + adno + "')";

                    }
                    else if (Billtype == "BA Payment")
                    {

                        sql2 = "update webx_BApayment_docket set activeflag='N' where beno='" + adno + "'";

                    }
                    if (Billtype != "Expense")
                    {
                        cmd = new SqlCommand(sql2, conn, trn);
                        cmd.ExecuteNonQuery();
                    }
                    if (Billtype == "THC" || Billtype == "PDC")
                    {
                        string sql_Acct_entry = "exec usp_VendorBillentry_Cancel_transaction 1,'" + adno + "','" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();
                        sql_Acct_entry = "exec usp_VendorBillentry_Cancel_transaction 2,'" + adno + "','" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();
                        //sql_Acct_entry = "exec usp_VendorBillentry_Cancel_transaction 3,'" + adno + "','" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        //sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        //// Response.Write("<br>" + sql_bal_acct_oth);
                        //sqlcmd3.ExecuteNonQuery();
                    }
                    else if (Billtype == "Octroi")
                    {

                        string sql_Acct_entry = "exec usp_Octroi_Agentbill_Cancel_Transaction 1,'" + adno + "','" + Session["finyear"].ToString().Substring(2, 2) + "'";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();
                    }
                    else if (Billtype == "BA Payment")
                    {

                        string sql_Acct_entry = "exec usp_BA_Billentry_Cancel_transaction '1','" + adno + "','" + Session["brcd"].ToString() + " ','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();
                    }
                    else if (Billtype == "Expense")
                    {

                        string sql_Acct_entry = "exec usp_Vendor_Other_Billentry_Cancel_transaction 1,'" + adno + "','" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();

                        sql_Acct_entry = "exec usp_Vendor_Other_Billentry_Cancel_transaction 2,'" + adno + "','" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "',''";
                        sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
                        // Response.Write("<br>" + sql_bal_acct_oth);
                        sqlcmd3.ExecuteNonQuery();
                    }
                    
                }


            }
            trn.Commit();
            //trn.Rollback();
            conn.Close();
            Response.Redirect("Result.aspx?ads=" + list);
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
      //  int cnt = ads2.Length;

     //   ads2 = ads2.Substring(0, cnt - 2);
       

      
        //string sql2 = "";


        //sql2 = "update webx_docket set octroimr='N' where dockno='" + docn + "'";




        //SqlCommand cmd2 = new SqlCommand(sql2, conn);
        //cmd2.ExecuteNonQuery();


        //cnt = ads.Length;

       

  
        
         

    }
}
