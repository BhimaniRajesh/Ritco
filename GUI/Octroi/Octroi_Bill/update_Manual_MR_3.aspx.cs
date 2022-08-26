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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, mrno, docno,entrydt;




    MyFunctions fn = new MyFunctions();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //txtindclamt.Attributes.Add("onblur", "javascript:fcaltotchqamt1(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + ")");
        //txtchqdt.Attributes.Add("onblur", "javascript:OnBlurChqDetail(" + txtchqno.ClientID + "," + txtchqdt.ClientID + "," + txtindchqamt.ClientID + "," + txtonacctamt.ClientID + "," + txtonacct.ClientID + "," + txtindclamt.ClientID + "," + cbopaytype.ClientID + "," + colamt.ClientID + "," + txtbanknm.ClientID + "," + txtbankbrn.ClientID + ")");
        t_tds.Attributes.Add("onblur", "javascript:calculation1(" + t_tds.ClientID + "," + t_othrdid.ClientID + "," + t_othramt.ClientID + "," + t_tdsamt.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + ","+lbltds.ClientID+")");
        
        //t_othrdid.Attributes.Add("onblur", "javascript:calculation1(" + t_othrdid.ClientID + "," + t_tdsamt.ClientID + "," + t_mramt.ClientID + "," + t_tds.ClientID + "," + t_netamt.ClientID + ")");

        t_othramt.Attributes.Add("onblur", "javascript:calculation1(" + t_tds.ClientID + "," + t_othrdid.ClientID + "," + t_othramt.ClientID + "," + t_tdsamt.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + "," + lbltds.ClientID + ")");
        t_othrdid.Attributes.Add("onblur", "javascript:calculation1(" + t_tds.ClientID + "," + t_othrdid.ClientID + "," + t_othramt.ClientID + "," + t_tdsamt.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + "," + lbltds.ClientID + ")");

       // btnsubmit.Attributes.Add("onclick","javascript:san1(" + t_netamt.ClientID + "," + .ClientID + ")");
        //t_othrdid.Attributes.Add("onblur", "javascript:calculation1(" + t_othrdid.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + ")");
        //t_othramt.Attributes.Add("onblur", "javascript:calculation1(" + t_othramt.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + ")");


        TextBox colamt = (TextBox)this.chqdetail11.FindControl("colamt");

        btnsubmit.Attributes.Add("onclick", "javascript:return san1(" + t_netamt.ClientID + "," + colamt.ClientID + ")");
        Button1.Attributes.Add("onclick", "javascript:return san1(" + t_netamt.ClientID + "," + colamt.ClientID + ")");

        



        if (!IsPostBack)
        {
              mrno = Request.QueryString["mrno"].ToString();
              lmrno.Text = mrno;
              Session["mmno"] = mrno;
            
             SqlDataReader drtds;
             SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
             conn2.Open();

             entrydt = System.DateTime.Now.ToString();
            //string sql = "select acccode,accdesc,acccategory from webx_acctinfo where acccode='CLA0014' order by accdesc";
            //SqlCommand cmd = new SqlCommand(sql, conn2);
            //drtds = cmd.ExecuteReader();

            //tdsacccode.Items.Clear();
            //while (drtds.Read())
            //{
            //    tdsacccode.Items.Add(new ListItem("Select",""));
            //    tdsacccode.Items.Add(new ListItem(drtds.GetValue(1).ToString(), drtds.GetValue(0).ToString()));

            //}

            //drtds.Close();
        disp();
        }





       

       // DipsplayReport();


    }

    public void disp()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

//        SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");


       string sql = "select * from webx_mr_hdr where mrsno='" + mrno + "'";

       conn.Open();

        SqlCommand cmd = new SqlCommand(sql, conn);



        // SqlDataAdapter da = new SqlDataAdapter(cmd);

        //DataSet ds = new DataSet();

        //da.Fill(ds);

          SqlDataReader dr;


          dr = cmd.ExecuteReader();

          while (dr.Read())
          {
              lmrtype.Text = dr["mrstype"].ToString();
              lparty.Text = dr["ptname"].ToString();
              lbranch.Text = dr["orgncd"].ToString() + " : " + dr["docbknm"].ToString();
              ldate.Text = dr["mrsdt"].ToString();
              lmrbranch.Text = dr["mrsbr"].ToString() + " : " + dr["mrbrnnm"].ToString(); ;
              ldlybranch.Text = dr["destcd"].ToString() + " : " + dr["docdlnm"].ToString(); ;
          


          
          }

          dr.Close();



          string sql2 = "select * from webx_mr_det where mrsno='" + mrno + "'";
 
          SqlCommand cmd2 = new SqlCommand(sql2, conn);



          // SqlDataAdapter da = new SqlDataAdapter(cmd);

          //DataSet ds = new DataSet();

          //da.Fill(ds);

          SqlDataReader dr2;


          dr2 = cmd2.ExecuteReader();

          while (dr2.Read())
          {
              lcno.Text = dr2["dockno"].ToString();
              lrecptno.Text = dr2["recptno"].ToString();
              loctamt.Text = dr2["octamt"].ToString();
              if (dr2["servchrg_per"].ToString() == "")
              {
                  lservchg.Text = "0.00";
                  t_servtax.Text = "0.00";
              }
              else
              {
                  lservchg.Text = dr2["servchrg_per"].ToString();
                  t_servtax.Text = dr2["servchrg_per"].ToString();
              
              }
              if (dr2["servchrg"].ToString() == "")
              {
                  lamt.Text = "0.00";
                //  t_tdsamt.Text = "0.00";
              }
              else
              {
                  lamt.Text = dr2["servchrg"].ToString();
                //  t_tdsamt.Text = dr2["servchrg"].ToString();
              }

              if (dr2["otchg"].ToString() == "")
              {
                  lothamt.Text = "0.00";
                 
              }
              else
              {

                  lothamt.Text = dr2["otchg"].ToString();
                  
                      //dr2["otchg"].ToString();
              }

              lmramt.Text = dr2["tot"].ToString();
              t_mramt.Text = dr2["tot"].ToString();
              t_tot.Text = dr2["tot"].ToString(); ;
              t_netamt.Text = dr2["tot"].ToString();
              t_othrdid.Text = "0.00";
              t_tds.Text = "0.00";
              t_othramt.Text = "0.00";
              
               
            
          }
        



    }
   
    
    
    

     protected void Button1_Click(object sender, EventArgs e)
    {
         
    }

    public string getAccountDesc(string code)
{


string accdesc = "";
SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
conn.Open();
string sql = "Select accdesc From webx_acctinfo where acccode='" + code + "'";
SqlCommand cmd = new SqlCommand(sql, conn);

SqlDataReader dr = null;
dr = cmd.ExecuteReader();

while (dr.Read())
{
accdesc = Convert.ToString(dr["accdesc"]);
}

if (accdesc == null) accdesc = "";
return accdesc;
}


    protected void btnsubmit_Click(object sender, EventArgs e)
    {

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
        DropDownList tdsacccode1 = (DropDownList)this.chqdetail11.FindControl("tdsacccode");
        //***************************************************************************************



         //btnsubmit.Attributes.Add("onclick","javascript:san1(" + t_netamt.ClientID + "," + colamt.ClientID + ")");
         //Button1.Attributes.Add("onclick","javascript:san1(" + t_netamt.ClientID + "," + colamt.ClientID + ")");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

       // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");
        conn.Open(); 
        string tdsfor=ddltdsdidfor.SelectedValue.ToString();
        string grpcode=cbopaytype.SelectedValue.ToString();
        string tdsacccode="";
        string tdsaccdesc="";
         string PAYMODE = cbopaytype.SelectedValue.ToString();
        string chqno, chqdt, indclamt, indchqamt;
        string[] chqno_Arr, chqdt_arr, indclamt_arr, indchqamt_arr,BANKNM_ARR,BANKBRANCH_ARR;
        string banknm, bankbr;
        string ErrMsg="";
        //********************for chqdetai***************
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
        //string MRSNo = MRNogen(Session["brcd"].ToString());
        //string MRSBR = Session["brcd"].ToString();
        //string MRBRNNM = fn.GetLocation(MRSBR);
        string paytype = cbopaytype.SelectedValue.ToString();
        chqno_Arr = txtchqno.Text.ToString().Split(',');
        chqdt_arr = txtchqdt.Text.ToString().Split(',');
        indclamt_arr = txtindclamt.Text.ToString().Split(',');
        indchqamt_arr = txtindchqamt.Text.ToString().Split(',');
        BANKNM_ARR = txtbanknm.Text.ToString().Split(',');
        BANKBRANCH_ARR = txtbankbrn.Text.ToString().Split(',');
        if (PAYMODE != "cash")
        {
            for (int i = 0; i < 3; i++)
            {
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
             conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string sql = "delete from webx_billchqdetail where docno='" + mrno + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
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
                        sql = "insert into webx_billchqdetail(chqno,chqdt,chqamt,clamt,banknm,bankbrn,docno,doctype,docsf)values('" + chqno + "'," + chqdt + "," + indchqamt + "," + indclamt + ",'" + banknm + "','" + bankbr + "','" + mrno + "','" + doctype + "','" + docsf + "')";
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
                                sql = "update webx_chq_det set adjustamt=adjustamt+" + indclamt + " where chqno='" + chqno + "' and convert(datetime,chqdt,106)=convert(varchar," + chqdt + ",106)";
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
                                string ptmsptcd = "8888";
                                string ptmsptnm = lparty.Text;
                                sql = "insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,adjustamt,bankbrn,chq_trf) values('" + chqno + "'," + chqdt + "," + indchqamt + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','','','','','','" + brcd + "','" + brnm + "','',''," + indclamt + ",'" + bankbr + "','" + brcd + "')";
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

            //************************************************


            if (grpcode == "LIA020")
            {
                if (tdsfor == "C")
                {
                    tdsacccode = "LCT0002";
                    tdsaccdesc = "TEST";
                }
                else
                {
                    tdsacccode = "LCT0004";
                    tdsaccdesc = "TEST";

                }

            }
            else
            {
                if (tdsfor == "C")
                {
                    tdsacccode = "LCT0006";
                    tdsaccdesc = "TEST";
                }
                else
                {
                    tdsacccode = "LCT0008";
                    tdsaccdesc = "TEST";

                }

            }


            double MRSCASH = Convert.ToDouble(colamt.Text);
            double MRSCHQ = Convert.ToDouble(colamt.Text);
            string closeyn, mrclose, closeempcd;
            DateTime cbsdt = System.DateTime.Now;
            closeyn = mrclose = "";



            if (cbopaytype.SelectedItem.Text == "Cash")
            {
                MRSCHQ = 0;
            }
            else
            {
                MRSCASH = 0;

            }




            //CloseYN=Request.Form("CloseYN") 
            //if CloseYN="0" then
            //    MRS_CLOSED="N"
            //    cbsdt="null"
            //    closeempcd="null"
            //else
            //    cbsdt="getdate()"
            //    MRS_CLOSED="Y"
            //    closeempcd="'" & session("empcd") & "'"
            //end if

            if (closeyn == "0")
            {
                mrclose = "N";
                cbsdt = Convert.ToDateTime(null);
                closeempcd = null;
            }
            else
            {
                mrclose = "Y";
                closeempcd = Session["empcd"].ToString();

            }



            t_tdsamt.Enabled = true;
            t_netamt.Enabled = true;

            double d1 = Convert.ToDouble(lbltds.Value);







            sql = "Update webx_MR_HDR set tdsgrpcode='" + grpcode + "',miscchrg='" + t_othramt.Text + "',tdsgrpdesc='" + tdsacccode + "',tdsacccode='" + tdsacccode + "',tdsaccdesc='" + tdsaccdesc + "', tdsfor= '" + ddltdsdidfor.SelectedValue.ToString() + "', Paymode='" + cbopaytype.SelectedValue.ToString() + "',MRSAMT = " + t_mramt.Text + ", NETAMT = " + t_netamt.Text + ", DEDUCTION = " + t_othrdid.Text + ", MRSCASH = " + MRSCASH + ", MRSCHQ = " + MRSCHQ + ",MRSCBSTO = '" + cbsdt + "', DED_OTH = " + t_othrdid.Text + ", DED_TDS = " + d1 + ",MRS_CLOSED='" + mrclose + "',remark='abc',tds_rate=" + t_tds.Text + ",BankAcccode='Test',BankAccdesc='" + txtbanknm.Text + "',finclosedt='" + cbsdt + "',finclose_empcd=" + closeempcd + ",col_stax=" + t_servtax.Text + "  where MRSNO = '" + mrno + "'";

             conn.Open();
            try
            {

                SqlCommand cmdd = new SqlCommand(sql, conn);

                cmdd.ExecuteNonQuery();
                Response.Redirect("update_Manual_MR_4.aspx?mrno" + mrno);
            }
            catch (Exception e1)
            {
                lblerr.Text = "1." + e1.Message;
            }


            string strchno, strchdt, strchamt, strbnknm, stradjamt, strbnkbr;
            strchno = txtchqno.Text;
            strchdt = txtchqdt.Text;
            strchamt = txtindchqamt.Text;
            strbnknm = txtbanknm.Text;
            stradjamt = txtindclamt.Text;
            strbnkbr = txtbankbrn.Text;

            string[] strchno2, strchdt2, strchdt3, strchamt2, strbnknm2, stradjamt2, strbnkbr2;
            //DateTime[] date2,date3;


            strchno2 = strchno.Split(',');
            strchdt2 = strchdt.Split(',');



            strchamt2 = strchamt.Split(',');
            strbnknm2 = strbnknm.Split(',');
            stradjamt2 = stradjamt.Split(',');
            strbnkbr2 = strbnkbr.Split(',');

            //strchdt2 = strchdt2.Split('/');
            //strchdt3 = strchdt2[1] + strchdt2[0] + strchdt2[2];





            //for(int i=0;i<=2;i++)
            //{
            // //   string strchdt4 = Convert.ToDateTime(strchdt2[i]).ToString("MM/dd/yy");




            //    if (strchno2[i] != "" || strchdt2[i] != "" || strchamt2[i] != "" || strbnknm2[i] != "" || stradjamt2[i] != "" || strbnkbr2[i] != "")
            //    {
            //        string[] dt2 = strchdt2[i].Split('/');
            //        string dt3 = dt2[1] +"/"+ dt2[0] +"/"+ dt2[2];


            //        string sql2 = "INSERT INTO webx_chq_det(CHQNO,CHQDT,CHQAMT,BANKNM,PTMSPTNM,BRCD,ADJUSTAMT,BANKBRN,ENTRYDT) VALUES('" + strchno2[i] + "','" + dt3 + "','" + strchamt2[i] + "','" + strbnknm2[i] + "','" + lparty.Text + "','" + Session["brcd"].ToString() + "','" + stradjamt2[i] + "','" + strbnkbr2[i] + "','" + entrydt + "')";


            //        try
            //        {

            //            SqlCommand cmdd2 = new SqlCommand(sql2, conn);

            //            cmdd2.ExecuteNonQuery();
            //           Response.Redirect("update_Manual_MR_4.aspx?mrno" + mrno);
            //        }
            //        catch (Exception e1)
            //        {
            //            lblerr.Text += "2." + e1.Message;


            //        }
            //    }

            //}



        }

    }
}
