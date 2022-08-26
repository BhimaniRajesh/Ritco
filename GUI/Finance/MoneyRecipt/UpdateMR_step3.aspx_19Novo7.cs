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

public partial class GUI_Finance_MoneyRecipt_UpdateMR_step3 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public static string Party_code, fincmplbr, fromdt, Todt, PAYBAS, Mrstype = "", Mrstype_desc = "";
    string MRsno;
    DateTime Fromdate, Todate;
    public static int totdkt = 0, intTotalRecords=0;

    double totalamtbill = 0;
    double totalbillamt = 0;
    string finYear = "07";
    // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    // SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    protected void Page_Load(object sender, EventArgs e)
    {

        if(!IsPostBack)
        {
            MRsno = Request.QueryString.Get("MRsno");
            fromdt= Request.QueryString.Get("fromdt");
            Todt= Request.QueryString.Get("Todt");
            Mrstype = Request.QueryString.Get("Mrstype");
            TxtCBSDT.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            Mrstype_desc = Request.QueryString.Get("Mrstype_desc");
           
            lbldaterange.Text = fromdt + "-" + Todt;
            if (fromdt != "")
            {
                Fromdate = Convert.ToDateTime(fromdt);
                fromdt = Fromdate.ToString("dd/MM/yyyy");//Convert.ToString().ToString("dd/MM/yyyy");
            }

            if (Todt != "")
            {
                Todate = Convert.ToDateTime(Todt);
                Todt = Todate.ToString("dd/MM/yyyy");
            }
           // lbldaterange.Text = fromdt + "-" + Todt;
            //Response.Write("MRsno-" + MRsno);
            
            DipsplayReport();
            
            JavascriptCalculation();
        }
    }
    public void JavascriptCalculation()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //**************for user control data***************************************
        TextBox txtchqno = (TextBox)this.chqdetail11.FindControl("txtchqno");
        TextBox txtchqdt = (TextBox)this.chqdetail11.FindControl("txtchqdt");
        TextBox txtindchqamt = (TextBox)this.chqdetail11.FindControl("txtindchqamt");
        HiddenField txtonacctamt = (HiddenField)this.chqdetail11.FindControl("txtonacctamt");
        TextBox txtonacct = (TextBox)this.chqdetail11.FindControl("txtonacct");
        TextBox txtindclamt = (TextBox)this.chqdetail11.FindControl("txtindclamt");
        DropDownList cbopaytype = (DropDownList)this.chqdetail11.FindControl("cbopaytype");
        TextBox colamt = (TextBox)this.chqdetail11.FindControl("colamt");
        TextBox txtbanknm = (TextBox)this.chqdetail11.FindControl("txtbanknm");
        TextBox txtbankbrn = (TextBox)this.chqdetail11.FindControl("txtbankbrn");
        DropDownList tdsacccode = (DropDownList)this.chqdetail11.FindControl("tdsacccode");
        //***************************************************************************************

       // cbopaytype.Attributes.Add("onblur", "javascript:Javascript:ChequeText_validation(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
       
        foreach (GridViewRow gridrow in GV_Booking.Rows)
         {

             TextBox txttds_rate = (TextBox)gridrow.FindControl("txttds_rate");
             TextBox txttdsamt = (TextBox)gridrow.FindControl("txttdsamt");
             TextBox txtDED_OTH = (TextBox)gridrow.FindControl("txtDED_OTH");
             TextBox txtotchg = (TextBox)gridrow.FindControl("txtotchg");
             TextBox totalamt = (TextBox)gridrow.FindControl("totalamt");
             HiddenField totMramt = (HiddenField)gridrow.FindControl("totMramt");
             //TextBox TotalNetamt = (TextBox)gridrow.FindControl("TotalNetamt");
             
             txttds_rate.Attributes.Add("onblur", "javascript:return fcal_MRamt(" + txttds_rate.ClientID + "," + txttdsamt.ClientID + "," + txtDED_OTH.ClientID + "," + txtotchg.ClientID + "," + totalamt.ClientID + "," + totMramt.ClientID + "," + colamt.ClientID + ")");
             txtDED_OTH.Attributes.Add("onblur", "javascript:return fcal_MRamt(" + txttds_rate.ClientID + "," + txttdsamt.ClientID + "," + txtDED_OTH.ClientID + "," + txtotchg.ClientID + "," + totalamt.ClientID + "," + totMramt.ClientID + "," + colamt.ClientID + ")");
             txtotchg.Attributes.Add("onblur", "javascript:return fcal_MRamt(" + txttds_rate.ClientID + "," + txttdsamt.ClientID + "," + txtDED_OTH.ClientID + "," + txtotchg.ClientID + "," + totalamt.ClientID + "," + totMramt.ClientID + "," + colamt.ClientID + ")");
             
        }
        submit.Attributes.Add("onclick", "javascript:return ClearDockets(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + "," + tdsacccode.ClientID + "," + TxtCBSDT.ClientID + ")");
             
        
    }
    public void DipsplayReport()
    {

       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        string sql = "";


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_mrs_details";
        
        sqlCommand.Parameters.AddWithValue("@docknos", MRsno);
       

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds);
        intTotalRecords = ds.Tables[0].Rows.Count;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            DateTime s;
            s = Convert.ToDateTime(dr["mrsdt"]);


            dr["mrsdt"] = s;
        }





        GV_Booking.DataSource = ds;




        GV_Booking.DataBind();

        if (GV_Booking.Rows.Count == 0)
        {

        }
        if (GV_Booking.Rows.Count <= 25)
        {
            ////LinkButton1.Visible = false;
            ////LinkButton2.Visible = false;

        }




        //Response.Write("hi..1");
        //Response.End();








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
    

    protected void submit_Click1(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
          
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //**************for user control data***************************************
        TextBox txtchqno = (TextBox)this.chqdetail11.FindControl("txtchqno");
        TextBox txtchqdt = (TextBox)this.chqdetail11.FindControl("txtchqdt");
        TextBox txtindchqamt = (TextBox)this.chqdetail11.FindControl("txtindchqamt");
        HiddenField txtonacctamt = (HiddenField)this.chqdetail11.FindControl("txtonacctamt");
        TextBox txtonacct = (TextBox)this.chqdetail11.FindControl("txtonacct");
        TextBox txtindclamt = (TextBox)this.chqdetail11.FindControl("txtindclamt");
        DropDownList cbopaytype = (DropDownList)this.chqdetail11.FindControl("cbopaytype");
        TextBox colamt = (TextBox)this.chqdetail11.FindControl("colamt");
        TextBox txtbanknm = (TextBox)this.chqdetail11.FindControl("txtbanknm");
        TextBox txtbankbrn = (TextBox)this.chqdetail11.FindControl("txtbankbrn");
        DropDownList tdsacccode = (DropDownList)this.chqdetail11.FindControl("tdsacccode");
        //***************************************************************************************

        string chee = txtchqno.Text.ToString();

        string PAYMODE = cbopaytype.SelectedValue.ToString(), strmrsno="";
        foreach (GridViewRow gridrow in GV_Booking.Rows)
        {

            TextBox txttds_rate = (TextBox)gridrow.FindControl("txttds_rate");
            TextBox txttdsamt = (TextBox)gridrow.FindControl("txttdsamt");
            TextBox txtDED_OTH = (TextBox)gridrow.FindControl("txtDED_OTH");
            TextBox txtotchg = (TextBox)gridrow.FindControl("txtotchg");
            TextBox totalamt = (TextBox)gridrow.FindControl("totalamt");
            HiddenField Hidden_MRSNO = (HiddenField)gridrow.FindControl("Hidden_MRSNO");
            HiddenField Hidden_ptname = (HiddenField)gridrow.FindControl("Hidden_ptname");
            HiddenField Hidden_ptcd = (HiddenField)gridrow.FindControl("Hidden_ptcd");
            HiddenField Frt_amt = (HiddenField)gridrow.FindControl("Frtamt");
            HiddenField svctax_amt = (HiddenField)gridrow.FindControl("svctax_amt");
            HiddenField Hidden_svctax_rate = (HiddenField)gridrow.FindControl("Hidden_svctax_rate");
            HiddenField Hidden_cess_rate = (HiddenField)gridrow.FindControl("Hidden_cess_rate");

          
       
        string chqno, chqdt, indclamt, indchqamt;
        string[] chqno_Arr, chqdt_arr, indclamt_arr, indchqamt_arr, BANKNM_ARR, BANKBRANCH_ARR;
        string banknm, bankbr, cbsdt = fn.Mydate1(TxtCBSDT.Text), remark = "", BankCode = "", BANKDESC="";
        string ErrMsg = "", MRSNo = Hidden_MRSNO.Value, PTCD = Hidden_ptcd.Value, PTNAME = Hidden_ptname.Value, manual_docno=TxtmanualMR.Text;
        
        if(strmrsno=="")
        {
            strmrsno = MRSNo;
        }
        else
        {
            strmrsno = strmrsno + "~" + MRSNo;
        }
            double cess_rate = Convert.ToDouble(Hidden_cess_rate.Value);
        double   svctax_rate = Convert.ToDouble(Hidden_svctax_rate.Value);
        double   Frtamt = Convert.ToDouble(Frt_amt.Value);  
        double Svctax = Convert.ToDouble(svctax_amt.Value);
        double OTCHG = Convert.ToDouble(txtotchg.Text); 
       double DED_OTH = Convert.ToDouble(txtDED_OTH.Text);
        double Othded_frt = 0, Othded_svctax = 0, Othded_cess = 0, OthChrg_frt = 0, OthChrg_svctax = 0, OthChrg_cess = 0;
        double tot = Svctax + Frtamt + OTCHG, Netamt = Convert.ToDouble(totalamt.Text), Tdsamt = Convert.ToDouble(txttdsamt.Text), deductamt = DED_OTH + Tdsamt, tds_rate = Convert.ToDouble(txttds_rate.Text);
        double  MRSCASH,MRSCHQ;
            if (Svctax > 0)
        {
            Othded_frt = (DED_OTH / (1 + (svctax_rate / 100) + (svctax_rate / 100) * (cess_rate / 100)));
            Othded_svctax = (Othded_frt * svctax_rate) / 100;
            Othded_cess = (Othded_svctax * cess_rate) / 100;

            OthChrg_frt = (OTCHG / (1 + (svctax_rate / 100) + (svctax_rate / 100) * (cess_rate / 100)));
            OthChrg_svctax = (OthChrg_frt * svctax_rate) / 100;
            OthChrg_cess = (OthChrg_svctax * cess_rate) / 100; ;
        }
        else
        {
            Othded_frt = DED_OTH;
            Othded_svctax = 0;
            Othded_cess = 0;
            OthChrg_frt = OTCHG;
            OthChrg_svctax = 0;
            OthChrg_cess = 0;
        }

            if (PAYMODE == "cash")
            {
                MRSCASH = Convert.ToDouble(totalamt.Text);
	                MRSCHQ=0;
            }
            else
            {
                 MRSCHQ = Convert.ToDouble(totalamt.Text);
                 MRSCASH = 0;
            }
        string svctax_cls = ",Othded_frt=" + Othded_frt + ",Othded_svctax=" + Othded_svctax + ",Othded_cess=" + Othded_cess + ",OthChrg_frt=" + OthChrg_frt + ",OthChrg_svctax=" + OthChrg_svctax + ",OthChrg_cess=" + OthChrg_cess + "";

        string sql = "Update webx_MR_HDR set Paymode='" + PAYMODE + "',MRSAMT = " + tot + ", NETAMT = " + Netamt + ", DEDUCTION = " + deductamt + ", MRSCASH = " + MRSCASH + ", MRSCHQ = " + MRSCHQ + ",MRSCBSTO = '" + cbsdt + "', DED_OTH = " + DED_OTH + ", DED_TDS = " + Tdsamt + ",MRS_CLOSED='Y',remark='" + remark + "',tds_rate=" + tds_rate + ",miscchrg=" + OTCHG + ",BankAcccode='" + BankCode + "',BankAccdesc='" + BANKDESC + "',finclosedt='" + cbsdt + "',finclose_empcd='" + Session["empcd"].ToString() + "',manual_docno='" + manual_docno + "'" + svctax_cls + " where MRSNO = '" + MRSNo + "'";
       // Response.Write("<br>sql-" + sql);
       // Response.End();
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

            if (PAYMODE != "cash")
             {
            chqno = txtchqno.Text.ToString();
            chqdt = txtchqdt.Text.ToString();
            indclamt = txtindclamt.Text.ToString();
            indchqamt = txtindchqamt.Text.ToString();
            if (chqdt != "-")
            {
                chqdt = "'" + chqdt + "'";
            }
            else
            {
                chqdt = "null";
            }
            //  ErrMsg=overbalcheque(chqno,chqdt,indclamt);

        }

        string paytype = cbopaytype.SelectedValue.ToString();
        chqno_Arr = txtchqno.Text.ToString().Split(',');
        chqdt_arr = txtchqdt.Text.ToString().Split(',');
        indclamt_arr = txtindclamt.Text.ToString().Split(',');
        indchqamt_arr = txtindchqamt.Text.ToString().Split(',');
        BANKNM_ARR = txtbanknm.Text.ToString().Split(',');
        BANKBRANCH_ARR = txtbankbrn.Text.ToString().Split(',');
        if (PAYMODE != "Cash")
        {
            for (int i = 0; i < 3; i++)
            {
              
                //Response.End();
                chqno = chqno_Arr[i];
                if (chqno != "")
                {
                    chqdt = fn.Mydate1(chqdt_arr[i]);
                    indclamt = indclamt_arr[i];
                    indchqamt = indchqamt_arr[i];
                    banknm = BANKNM_ARR[i];
                    bankbr = BANKBRANCH_ARR[i];
                    if (chqdt != "-")
                    {
                        chqdt = "'" + chqdt + "'";
                    }
                    else
                    {
                        chqdt = "null";
                    }
                    //  ErrMsg=overbalcheque(chqno,chqdt,indclamt);
                }


            }
        }
        ///errmsr*********************

        if (ErrMsg == "")
        {
           
             sql = "delete from webx_billchqdetail where docno='" + MRSNo + "'";
             cmd = new SqlCommand(sql, conn);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (PAYMODE != "cash")
            {
                for (int i = 0; i < 3; i++)
                {
                    chqno = chqno_Arr[i];
                    if (chqno != "")
                    {
                        chqdt = fn.Mydate1(chqdt_arr[i]);
                    }
                    indclamt = indclamt_arr[i];
                    indchqamt = indchqamt_arr[i];
                    banknm = BANKNM_ARR[i];
                    bankbr = BANKBRANCH_ARR[i];
                    if (chqno != "")
                    {
                        chqdt = fn.Mydate1(chqdt_arr[i]);
                        if (chqdt != "-")
                        {
                            chqdt = "'" + chqdt + "'";
                        }
                        else
                        {
                            chqdt = "null";
                        }

                        //ErrMsg=overbalcheque(chqno,chqdt,indclamt);
                        string docsf = ".";
                        string doctype = "2";
                        string CloseYN = "1";
                        sql = "insert into webx_billchqdetail(chqno,chqdt,chqamt,clamt,banknm,bankbrn,docno,doctype,docsf)values('" + chqno + "'," + chqdt + "," + indchqamt + "," + Netamt + ",'" + banknm + "','" + bankbr + "','" + MRSNo + "','" + doctype + "','" + docsf + "')";
                        cmd = new SqlCommand(sql, conn);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        if (CloseYN != "")
                        {
                            sql = "select chqamt,adjustamt,banknm from webx_chq_det where chqno='" + chqno + "' and convert(datetime,chqdt,106)=convert(varchar," + chqdt + ",106)";
                            cmd = new SqlCommand(sql, conn);
                            SqlDataReader dr = null;
                            conn.Open();
                            dr = cmd.ExecuteReader();

                            if (dr.Read())
                            {
                                //NewCode = Convert.ToString(dr["NewCode"]);
                                sql = "update webx_chq_det set adjustamt=adjustamt+" + Netamt + " where chqno='" + chqno + "' and convert(datetime,chqdt,106)=convert(varchar," + chqdt + ",106)";
                                SqlCommand cmd1 = new SqlCommand(sql, conn1);
                                conn1.Open();
                                cmd1.ExecuteNonQuery();
                                conn1.Close();

                                //   Call BillTransaction(3,session("brcd"),MRSNo,".")
                            }
                            else
                            {
                                string brcd = Session["brcd"].ToString();
                                string brnm = fn.GetLocation(brcd);
                                string ptmsptcd = PTCD;
                                string ptmsptnm = PTNAME;
                                sql = "insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,adjustamt,bankbrn,chq_trf) values('" + chqno + "'," + chqdt + "," + indchqamt + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','','','','','','" + brcd + "','" + brnm + "','',''," + Netamt + ",'" + bankbr + "','" + brcd + "')";
                                SqlCommand cmd1 = new SqlCommand(sql, conn1);


                                conn1.Open();
                                cmd1.ExecuteNonQuery();
                                conn1.Close();
                            }
                            dr.Close();
                            conn.Close();
                        }


                    }
               
                }
            }
            }

            //**************end for loop*************************





           
        }

        Response.Redirect("UpdateMR_Done.aspx?Mrsnos="+strmrsno);
    }


}
