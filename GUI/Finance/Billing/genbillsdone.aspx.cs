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
using System.Text;





public partial class Finance_Billing_Billgeneration_genbillsdone : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    ////SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    //SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    string Party_code;
    string orgncd;
   public static string fincmplbr;
 
    string fromdt;
    string Todt;
    string PAYBAS;
    public static string Fromdate = "", Todate = "", Financial_Year = "";
	
    string TRN_MOD;
    MyFunctions fn = new MyFunctions();

    public int intTotalRecords;

    protected void Page_Load(object sender, EventArgs e)
    {

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Party_code = Request.QueryString.Get("Party_code");
         orgncd = "All";
          fincmplbr = Session["brcd"].ToString();
        //Response.Write("fincmplbr - " + fincmplbr);
         fromdt = Request.QueryString.Get("fromtdate");
		 Fromdate= Request.QueryString.Get("fromtdate");
         Todt = Request.QueryString.Get("todate");
		 Todate = Request.QueryString.Get("todate");
         PAYBAS = Request.QueryString.Get("paybas");
         TRN_MOD = Request.QueryString.Get("trnmod");
         //TRN_MOD = "4";

        fromdt = fn.Mydate1(fromdt);
        Todt = fn.Mydate1(Todt);
        //for query display**************************
        string billdate;
        billdate = System.DateTime.Now.ToString("dd/MM/yyyy");
       
        txtbgndt.Text = billdate.ToString(); //System.DateTime.Now.ToShortDateString();
        DateTime dt = DateTime.Today.AddDays(15);
        txtduedate.Text = dt.ToString("dd/MM/yyyy");
        lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
        LblPTMSCD.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
        lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
        lblpaybas.Text = fn.Getpaybas(PAYBAS);
        lblmod.Text = fn.Gettrnmod(TRN_MOD);
        txtbillsubloc.Text = Session["brcd"].ToString();
        txtbillcolloc.Text = Session["brcd"].ToString();
        string sql = "select  billsub_loccode,billcol_loccode from WEBX_CUSTCONTRACT_charge WITH(NOLOCK) where custcode='" + Party_code.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            txtbillsubloc.Text = Convert.ToString(dr["billsub_loccode"]);
            txtbillcolloc.Text = Convert.ToString(dr["billcol_loccode"]);
           
        }
        conn.Close();

        //*******************************************
        BindGrid();
		txtbgndt.Attributes.Add("onblur", "javascript:return Onblurbilldate(" + txtbgndt.ClientID + ")");
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtbgndt.ClientID + "," + txtduedate.ClientID + "," + txtbillsubloc.ClientID + "," + txtbillcolloc.ClientID + "," + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ","+txtManualbillno.ClientID+")");
         
        }
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "webx_UNI_BillGeneration_new";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;

     

        myAdapter.SelectCommand.Parameters.Add("@fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Todt", SqlDbType.DateTime).Value = Todt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Party_code", SqlDbType.VarChar).Value = Party_code.Trim();
        myAdapter.SelectCommand.Parameters.Add("@orgncd", SqlDbType.VarChar).Value = orgncd.Trim();
        myAdapter.SelectCommand.Parameters.Add("@fincmplbr", SqlDbType.VarChar).Value = fincmplbr.Trim();
        myAdapter.SelectCommand.Parameters.Add("@PAYBAS", SqlDbType.VarChar).Value = PAYBAS.Trim();
        myAdapter.SelectCommand.Parameters.Add("@TRN_MOD", SqlDbType.VarChar).Value = TRN_MOD.Trim();

        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");

        intTotalRecords = ds.Tables[0].Rows.Count;

        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        BindGrid();

    }
    public string GenBillno(string loccode)
    {


        string NewCode = "";
        string finyear = Financial_Year;
       // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_next_BILL_code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = loccode.Trim();
        cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = finyear.Trim();
        

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            NewCode = Convert.ToString(dr["NewCode"]);
        }

        if (NewCode == null) NewCode = "";
        return NewCode;
    }
   
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Response.Write("hi....");
        //Response.End();

        string sql1 = "";
        string Loccode = Session["brcd"].ToString();
        string showmessage = "";
        string billsubbrcd = txtbillsubloc.Text.ToString();
        string billcolbrcd = txtbillcolloc.Text.ToString();
        string Billno = "";
        if (Session["Client"].ToString() == "RCPL")
        {
            Billno = GenBillno(billsubbrcd.ToString());
        }
        else
        {
             Billno = GenBillno(Loccode.ToString());
        }
        string custnm = fn.Getcustomer(Party_code.Trim());

        string bbrcd = Session["brcd"].ToString();

        string bgndt = fn.Mydate1(txtbgndt.Text.ToString());
        string billduedt = fn.Mydate1(txtduedate.Text.ToString());
        string BCLDT = "NUll";
        string BCBSDT = "NUll";
        string BSBDT = "NULL";
        string Brnm = fn.GetLocation(bbrcd);
        string Paybas = "2";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //sql1 = "select * from webx_location where loccode='" + billsubbrcd + "'";
        //Response.Write("sql1- " + sql1);
        //Response.End();
        //SqlCommand cmd = new SqlCommand(sql1, conn);
        //SqlDataReader dr = null;
        //dr = cmd.ExecuteReader();
        //string Billgen = "";
        //string billsub = "";
        //string billcol = "";
        ////if (dr.Read() == "")
        ////{

        ////}
        ////else
        ////{
        //    while (dr.Read())
        //    {

        //         Billgen = Convert.ToString(dr["Billgen"]);
        //         billsub = Convert.ToString(dr["billsub"]);
        //         billcol = Convert.ToString(dr["billcol"]);


        //    }
        //    if (billsub!="Y")
        //    {
        //        showmessage = "Bill Submission is not available for " + billsubbrcd + " : " + fn.GetLocation(billsubbrcd) + " branch!!!";
        //    }
        ////}
        //sql1 = "select * from webx_location where loccode='" + billcolbrcd + "'";
        ////SqlCommand cmd = new SqlCommand(sql1, conn);
        ////SqlDataReader dr = null;
        //dr = cmd.ExecuteReader();

        ////if (dr.Read() == "")
        ////{

        ////}
        ////else
        ////{
        //    while (dr.Read())
        //    {

        //        Billgen = Convert.ToString(dr["Billgen"]);
        //        billsub = Convert.ToString(dr["billsub"]);
        //        billcol = Convert.ToString(dr["billcol"]);


        //    }
        //    if (billsub != "Y")
        //    {
        //        showmessage = "Bill Collection is not available for " + billcolbrcd + " : " + fn.GetLocation(billcolbrcd) + " branch!!!";
        //    }
        ////}

        string sql = "WEBX_Customer_Other";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = Party_code.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();
        string PTMSCD = Party_code.Trim();
        string PTMSNM = fn.Getcustomer(Party_code.Trim());

        string PTMSTEL = "";
        string PTMSEMAIL = "";
        string PTMSADDR = "";
        while (dr.Read())
        {
            PTMSCD = Party_code.Trim();
            PTMSNM = fn.Getcustomer(Party_code.Trim());
            PTMSTEL = Convert.ToString(dr["CUSTTEL"]);
            PTMSEMAIL = Convert.ToString(dr["CUSTEMAIL"]);
            PTMSADDR = Convert.ToString(dr["CUSTADDRESS"]);


        }
        dr.Close();
        string BILLSTATUS = "Bill Generated";
        string remarks = txtremars.Text.ToString();
        string spe_inst = txtspl_ins.Text.ToString();
        string bgenempcd = Session["empcd"].ToString();
        string BILLAMT = "0";
        string PENDAMT = "0";

        SqlTransaction trn;
        trn = conn.BeginTransaction();

        //SqlTransaction trn1;
       

        try  //  try FOR ALL
        {
          
            //conn.Open();
            //SqlTransaction myTrans = conn.BeginTransaction();
            //cmd.Transaction = myTrans;
            //conn.Close();


            cmd = new SqlCommand("Webx_INSERT_billmst", conn, trn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@BILLNO", Billno);
            cmd.Parameters.AddWithValue("@BGNDT", bgndt);
            cmd.Parameters.AddWithValue("@BSBDT", DBNull.Value);
            cmd.Parameters.AddWithValue("@BDUEDT", billduedt);
            cmd.Parameters.AddWithValue("@BCLDT", DBNull.Value);
            cmd.Parameters.AddWithValue("@BCBSDT", DBNull.Value);
            cmd.Parameters.AddWithValue("@BBRCD", bbrcd);
            cmd.Parameters.AddWithValue("@BBRNM", Brnm);
            cmd.Parameters.AddWithValue("@PAYBAS", Paybas);
            cmd.Parameters.AddWithValue("@PTMSCD", PTMSCD);
            cmd.Parameters.AddWithValue("@PTMSNM", PTMSNM);
            cmd.Parameters.AddWithValue("@PTMSTEL", PTMSTEL);
            cmd.Parameters.AddWithValue("@PTMSEMAIL", PTMSEMAIL);
            cmd.Parameters.AddWithValue("@PTMSADDR", PTMSADDR);
            cmd.Parameters.AddWithValue("@REMARK", remarks);
            cmd.Parameters.AddWithValue("@BILLAMT", BILLAMT);
            cmd.Parameters.AddWithValue("@PENDAMT", PENDAMT);
            cmd.Parameters.AddWithValue("@BILLSTATUS", BILLSTATUS);
            cmd.Parameters.AddWithValue("@bgenempcd", bgenempcd);
            cmd.Parameters.AddWithValue("@billsubbrcd", billsubbrcd);
            cmd.Parameters.AddWithValue("@billcolbrcd", billcolbrcd);
            cmd.Parameters.AddWithValue("@spe_inst", spe_inst);
            cmd.Parameters.AddWithValue("@Manualbillno", txtManualbillno.Text);

           
            cmd.ExecuteNonQuery();
          

            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    CheckBox chkdoc = (CheckBox)e.Row.FindControl("chkDock");


            //}

            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{

            //    CheckBox chkdoc = (CheckBox)e.Row.FindControl("chkDock");
            //    Label docketno = (Label)e.Row.FindControl("docketno");


            //}
            string docket_nos = "";
            bool chkDock = false;


            string docketlist = txtdocketlist.Value.ToString();
            string[] docketlist_arr;
            docketlist_arr = docketlist.Split(',');
            string checkeddockno = txtdocketlist_count.Value.ToString();
            int total_checked = Convert.ToInt32(checkeddockno);
            if (total_checked == 1)
            {
                string docket_no = docketlist;
                docket_nos = docket_no.ToString();

            }
            else
            {

                for (int i = 0; i <= total_checked; i++)
                {
                    string docket_no = docketlist_arr[i].ToString();
                    if (docket_nos == "")
                    {
                        docket_nos = docket_no;
                    }
                    else
                    {
                        docket_nos = docket_nos + "," + docket_no;
                    }

                }

            }
            SqlCommand cmd_insert = new SqlCommand();

          
            
          
       //     SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
      //      conn1.Open();
      //   /  // SqlTransaction trn1;
       
         //   trn1 = conn1.BeginTransaction();
       //     dr = cmd.ExecuteReader();

            string DOCKNO = "";
            string DOCKSF = "";
            string paybas = "";
            string ORGNCD = "";
            string DESTCD = "";
            string REASSIGN_DESTCD = "";
            string DOCKDT="";
            string cdeldt="";

            string CSGNCD = "";
            string CSGNNM = "";
            string CSGECD = "";
            string CSGENM = "";
            string COD_DOD = "";
            string diplomat = "";
            string dlypdcno = "";
            string billstatus = "";
            double FREIGHT = 0;

            int FRT_RATE = 0;
            int DKTCHG = 0;
            int FOV = 0;
            int OTCHG = 0;

            int DIPLOMATCHG = 0;
            int DACC_CHRG = 0;
            int CODCHG = 0;
            double SVRCAMT = 0;
            double dkttot = 0;
            decimal hedu_cessamt = 0;
            double dktamt=0;
            string DLY_LOC = "";
            int CHRGWT=0;
            int demchgs = 0;
            int cess = 0;
            int totcessamt = 0;
            decimal tothedu_cess = 0;
            int totSVRCAMT = 0;
            double billamt = 0;
            string sql_update = "";
            //DateTime dockdt1,cedldt1;
           // foreach (DataGridItem gridrow in dockdata.Items)
            string[] docketNos_list_arr;
            docketNos_list_arr = docket_nos.Split(',');
            for (int i = 0; i < docketNos_list_arr.Length; i++)
            {

              //  Label docketno = (Label)gridrow.FindControl("docketno");
               // CheckBox chkdoc = (CheckBox)e.Row.FindControl("chkDock");
               // CheckBox chkOrderNo = (CheckBox)gridrow.FindControl("chkOrderNo");
               // if (chkOrderNo.Checked)
               // {
                    cmd = new SqlCommand("webx_UNI_BillGeneration1_New", conn, trn);
                    string docketno = docketNos_list_arr[i].ToString();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@docknos", SqlDbType.VarChar).Value = docketno.Trim();

                    dr = null;
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {

                        DOCKNO = Convert.ToString(dr["DOCKNO"]);
                        DOCKSF = Convert.ToString(dr["DOCKSF"]);
                        paybas = Convert.ToString(dr["paybas"]);



                        ORGNCD = Convert.ToString(dr["ORGNCD"]);
                        DESTCD = Convert.ToString(dr["DESTCD"]);
                        REASSIGN_DESTCD = Convert.ToString(dr["REASSIGN_DESTCD"]);
                        //DOCKDT = fn.Mydate1(Convert.ToString(dr["DOCKDT"]));
                        DOCKDT = Convert.ToString(dr["DOCKDT"]);
                        cdeldt = Convert.ToString(dr["cdeldt"]);
                        //dockdt1 = fn.Mydate1(Convert.ToDateTime(DOCKDT));
                        //if (cdeldt == null)
                        //{
                        //    cdeldt1 = null;
                        //}
                        //else
                        //{

                        //    cdeldt1 = fn.Mydate1(Convert.ToDateTime(dr["cdeldt"]));
                        //}
                        CSGNCD = Convert.ToString(dr["CSGNCD"]);
                        CSGNNM = Convert.ToString(dr["CSGNNM"]);
                        CSGECD = Convert.ToString(dr["CSGECD"]);
                        CSGENM = Convert.ToString(dr["CSGENM"]);
                        COD_DOD = Convert.ToString(dr["COD_DOD"]);
                        diplomat = Convert.ToString(dr["diplomat"]);
                        dlypdcno = Convert.ToString(dr["dlypdcno"]);
                        billstatus = Convert.ToString(dr["billstatus"]);
                        FREIGHT = Convert.ToDouble(dr["FREIGHT"]);

                        FRT_RATE = Convert.ToInt16(dr["FRT_RATE"]);
                        DKTCHG = Convert.ToInt16(dr["DKTCHG"]);
                        FOV = Convert.ToInt16(dr["FOV"]);
                        OTCHG = Convert.ToInt16(dr["OTCHG"]);
                        DIPLOMATCHG = Convert.ToInt16(dr["DIPLOMATCHG"]);
                        DACC_CHRG = Convert.ToInt16(dr["DACC_CHRG"]);
                        CODCHG = Convert.ToInt16(dr["CODCHG"]);
                        SVRCAMT = Convert.ToDouble(dr["SVCTAX"]);
                        dkttot = Convert.ToDouble(dr["dkttot"]);
                        DLY_LOC = Convert.ToString(dr["DLY_LOC"]);
                        CHRGWT = Convert.ToInt16(dr["CHRGWT"]);
                        DKTCHG = Convert.ToInt16(dr["DKTCHG"]);
                        cess = Convert.ToInt16(dr["cess"]);
                        FOV = Convert.ToInt16(dr["FOV"]);
                        hedu_cessamt = Convert.ToInt16(dr["hedu_cess"]);

                        if (dr["demchgs"] is DBNull)
                        {
                            demchgs = 0;
                        }
                        else
                        {
                            demchgs = Convert.ToInt16(dr["demchgs"]);
                        }


                        dktamt = dkttot - SVRCAMT;
                        totcessamt = totcessamt + cess;
                        totSVRCAMT = totSVRCAMT + Convert.ToInt16(SVRCAMT);
                        tothedu_cess = tothedu_cess + hedu_cessamt;
                        billamt = billamt + dkttot;
                    }
                    dr.Close();
                    cmd_insert = new SqlCommand("Webx_INSERT_billdet", conn, trn);
                    cmd_insert.CommandType = CommandType.StoredProcedure;

                    cmd_insert.Parameters.AddWithValue("@BILLNO", Billno);
                    cmd_insert.Parameters.AddWithValue("@DOCKNO", DOCKNO);
                    cmd_insert.Parameters.AddWithValue("@DOCKSF", DOCKSF);
                    cmd_insert.Parameters.AddWithValue("@ORGNCD", ORGNCD);
                    cmd_insert.Parameters.AddWithValue("@REASSIGN_DESTCD", REASSIGN_DESTCD);
                    cmd_insert.Parameters.AddWithValue("@DOCKDT", DOCKDT);
                    cmd_insert.Parameters.AddWithValue("@CDELDT", cdeldt);
                    cmd_insert.Parameters.AddWithValue("@DELYDT", cdeldt);
                    cmd_insert.Parameters.AddWithValue("@CHRGWT", CHRGWT);
                    cmd_insert.Parameters.AddWithValue("@DKTAMT", dktamt);
                    cmd_insert.Parameters.AddWithValue("@SVRCAMT", SVRCAMT);
                    cmd_insert.Parameters.AddWithValue("@DKTTOT", dkttot);
                    cmd_insert.Parameters.AddWithValue("@OTCHG", OTCHG);
                    cmd_insert.Parameters.AddWithValue("@DKTCHG", DKTCHG);
                    cmd_insert.Parameters.AddWithValue("@FOVCHG", FOV);
                    cmd_insert.Parameters.AddWithValue("@cessamt", cess);
                    cmd_insert.Parameters.AddWithValue("@demchgs", demchgs);

                    cmd_insert.ExecuteNonQuery();
                    sql_update = "Update WebX_Trans_Docket_Status set Billed='Y' where dockno='" + DOCKNO + "'";
                    //Response.Write("<br>sql_update " + sql_update);
                    cmd_insert = new SqlCommand(sql_update, conn, trn);
                    cmd_insert.ExecuteNonQuery();
                    if (Session["Client"].ToString() == "RCPL")
                    {
                        sql_update = "Update webx_BA_calculation set billno='" + Billno + "' where dockno='" + DOCKNO + "'";
                        //Response.Write("<br>sql_update " + sql_update);
                        cmd_insert = new SqlCommand(sql_update, conn, trn);
                        cmd_insert.ExecuteNonQuery();

                    }
                    cmd_insert = null;
                //}
            }
            

              

              
           
           
          
            //**********for bill det*********************************
           
            string sql_chgrtae = "Select * from WEBX_CHARGEMST";
            cmd = new SqlCommand(sql_chgrtae, conn, trn);
            SqlDataReader dr1 = null;
            dr1 = cmd.ExecuteReader();
            string ServiceTax = "", OtherTax = "", H_OtherTax = "";
            while (dr1.Read())
            {
                ServiceTax = Convert.ToString(dr1["ServiceTax"].ToString());
                OtherTax = Convert.ToString(dr1["EDU_CESS_RATE"].ToString());

                H_OtherTax = Convert.ToString(dr1["HEDU_CESS_RATE"].ToString());
            }
            dr1.Close();
            if (Request.QueryString.Get("trnmod") == "2")
            {
                ServiceTax = "3";
            }
            string svctax_str = ",svctax_rate=" + ServiceTax + ",cess_rate  =" + OtherTax + ",H_cess_rate=" + H_OtherTax + "";

            sql_update = "update Webx_billmst set billamt=" + billamt + ",pendamt=" + billamt + ",svrcamt=" + totSVRCAMT + ",cessamt=" + totcessamt + ",banknm='ST',hedu_cess=" + tothedu_cess + " " + svctax_str + " where billno='" + Billno + "'";
            Response.Write("<br>sql_update " + sql_update);
            cmd = new SqlCommand(sql_update, conn, trn);

            cmd.ExecuteNonQuery();
            //Response.Write("<br>totcessamt " + totcessamt);
            //Response.Write("<br>totSVRCAMT " + totSVRCAMT);
            //Response.Write("<br>billamt " + billamt);
            //Response.End();
            //myTrans.Commit();


          
            if (Session["Client"].ToString() == "RLL")
            {
                string sql_TBB_acct = "exec usp_TBB_Transaction 2,'" + Billno.ToString() + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "',''";
                cmd = new SqlCommand(sql_TBB_acct, conn, trn);
                cmd.ExecuteNonQuery();

            }
            else
            {
                cmd_insert = new SqlCommand("usp_BillTransaction", conn, trn);
                cmd_insert.CommandType = CommandType.StoredProcedure;
                int transno = 1;
                string finYear = Financial_Year;

                cmd_insert.Parameters.AddWithValue("@transNo", transno);
                cmd_insert.Parameters.AddWithValue("@docNo", Billno);
                cmd_insert.Parameters.AddWithValue("@finYear", finYear);
                cmd_insert.ExecuteNonQuery();
            }
           // trn.Rollback();
            trn.Commit();
            //trn1.Commit();
            //trn.Rollback();
           // trn1.Rollback();
            conn.Close();
            
                 if (Session["Client"].ToString() == "RCPL")
                 {
                     Response.Redirect("genbillsdone_RCPL.aspx?billno=" + Billno);
                 }
                 else
                 {
                   Response.Redirect("genbilldone2.aspx?billno=" + Billno);
                 }
           
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
         //   trn1.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();

        }
    }
    protected void chkDock_CheckedChanged1(object sender, EventArgs e)
    {
        CheckBox checkbox = (CheckBox)sender;
        GridViewRow row = (GridViewRow)checkbox.NamingContainer;

        Response.Write(row.Cells[0].Text);
    }
}
