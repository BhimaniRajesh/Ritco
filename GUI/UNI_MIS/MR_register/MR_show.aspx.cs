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

public partial class MR_show : System.Web.UI.Page
{



    public static string strDateRange,dttype,mrno,servtyp;
    public static string strro,strdockno;
    public static string strloc;
    public static string strmrparty;
    public static string strmrtype;
    public static string strstatus;
    public static string strcash;
    public static string strAmtGrThan;
    public static string strAall = "All";


    public static int intCurrentPageNo;
    public static int intPageSize = 25;
    public static DataTable dt = new DataTable();



    protected void Page_Load(object sender, EventArgs e)
    {
        


        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["MRDate"].ToString();
            strro = Request.QueryString["RO"].ToString();
            if (strro == "-All-" || strro == "")
            {
                strro = "ALL";
            }
            strloc = Request.QueryString["Location"].ToString();
            if (strloc == "-All-" || strloc == "")
            {
                strloc = "ALL";
            }
            strmrparty = Request.QueryString["MRParty"].ToString();
            if (strmrparty == "")
            {
                strmrparty = "All";
            }
            
            strmrtype = Request.QueryString["MRType"].ToString();

            if (strmrtype == "-All-")
            {
                strmrtype = "All";
            }

            strstatus = Request.QueryString["Status"].ToString();
            if (strstatus == "-All-")
            {
                strstatus = "All";
            }



            strcash = Request.QueryString["cash"].ToString();
            if (strcash == "-All-")
            {
                strcash = "All";
            }

            strAmtGrThan = Request.QueryString["AmtGrThan"].ToString();
            if (strAmtGrThan == "")
            {
                strAmtGrThan = "0";
            }


            servtyp = Request.QueryString["servtyp"].ToString();
            dttype = Request.QueryString["dttype"].ToString();
            mrno = Request.QueryString["mrno"].ToString();
            strdockno = Request.QueryString["dockno"].ToString();
          //  strmrparty = Request.QueryString["MRParty"].ToString();

        }



        lblro.Text = strro;
        lblloc.Text = strloc;
        lblmrparty.Text = strmrparty;
        lblmrtype.Text = strmrtype;
        lblstatus.Text = strstatus;
        lblcash.Text = strcash;
        lblamtgrt.Text = strAmtGrThan + ".00";
        lbldno.Text = strdockno;
        lblmr.Text = mrno;

        DisplayMrDetails();


    }




    private void DisplayMrDetails()
    {


        ///UNI_MIS/mr_register/MR_show.aspx?MRDate=01%20jan%2008%20-%2031%20jan%2008&RO=All&Location=All&MRParty=&MRType=All&Status=Y&cash=All&AmtGrThan=&dttype=mrsdt&mrno=&dockno=&servtyp=All

        // SqlConnection sqlConn = new SqlConnection(strConnection);

     SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

      // SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");

     // http://localhost:1593/San_ECFY/(S(3ekoxi55yn23bdq0dwkfxy55))/GUI/UNI_MIS/MR_register/MR_show.aspx?MRDate=01%20Oct%2007%20-%2031%20Oct%2007&RO=All&Location=All&MRParty=&MRType=3&Status=All&cash=All&AmtGrThan=&dttype=mrsdt&mrno=&dockno=&servtyp=All
        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        // EXEC webx_MR_DETAIL_ver6 'all','01 JAN 08','23 MAR 08','ALL','ALL',0,'ALL','ALL','ALL','ALL','ALL','mrsdt','ALL','',''

        ///UNI_MIS/mr_register/MR_register.aspx

        sqlCommand.CommandText = "webx_MR_DETAIL_ver10";

        string[] strArrDtFromTo = strDateRange.Split('-');


        sqlCommand.Parameters.AddWithValue("@DATEFROM", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@DATETO", strArrDtFromTo[1]);

        //sqlCommand.Parameters.AddWithValue("@DATEFROM", "01 aug 07");
        //sqlCommand.Parameters.AddWithValue("@DATETO", "31 aug 07");


        sqlCommand.Parameters.AddWithValue("@MRTYP", strmrtype);
        sqlCommand.Parameters.AddWithValue("@MRSTATUS", strstatus);
        sqlCommand.Parameters.AddWithValue("@MRAMT","0");
        sqlCommand.Parameters.AddWithValue("@MRBRCD", strloc.ToUpper());
        sqlCommand.Parameters.AddWithValue("@BOOKBRCD", strAall.ToUpper());
        sqlCommand.Parameters.AddWithValue("@DELBRCD", strAall.ToUpper());
        sqlCommand.Parameters.AddWithValue("@MRCASH", strcash.ToUpper());
        sqlCommand.Parameters.AddWithValue("@RO", strro);
        sqlCommand.Parameters.AddWithValue("@SVCTYPE", servtyp);
        sqlCommand.Parameters.AddWithValue("@mrdatetype",dttype);
        sqlCommand.Parameters.AddWithValue("@CUSTCD", strmrparty);
        sqlCommand.Parameters.AddWithValue("@mrlist", mrno);
        sqlCommand.Parameters.AddWithValue("@dockno", strdockno);




        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
         

        sqlDA.Fill(ds);


        dt.Clear();
        dt.Columns.Clear();

        dt.Columns.Add("RowCounter", typeof(string));
        dt.Columns.Add("MRSNo", typeof(string));
        dt.Columns.Add("MRSDT", typeof(string));
        dt.Columns.Add("MRSTYPE", typeof(string));
        dt.Columns.Add("MRSBR", typeof(string));
        dt.Columns.Add("MRBRNNM", typeof(string));
        //   dt.Columns.Add("PTCD", typeof(string));
        dt.Columns.Add("PartyNAME", typeof(string));
        dt.Columns.Add("ORGNCD", typeof(string));
        dt.Columns.Add("DOCBKNM", typeof(string));
        dt.Columns.Add("DESTCD", typeof(string));
       // dt.Columns.Add("DOCDLNM", typeof(string));
        dt.Columns.Add("MRSAMT", typeof(string));
        dt.Columns.Add("dockno", typeof(string));
        dt.Columns.Add("Closeamt", typeof(string));
        dt.Columns.Add("MRS_Closed", typeof(string));
        dt.Columns.Add("Paymode", typeof(string));
        dt.Columns.Add("finclosedt", typeof(string));
        dt.Columns.Add("DEDUCTION", typeof(string));
        dt.Columns.Add("miscchrg", typeof(string));
        dt.Columns.Add("MR_CANCEL", typeof(string));
        dt.Columns.Add("NETAMT", typeof(string));
        dt.Columns.Add("chq_amt", typeof(string));
        dt.Columns.Add("remark", typeof(string));
        dt.Columns.Add("report_loc", typeof(string));
        dt.Columns.Add("MRChequeDetails", typeof(string));
        dt.Columns.Add("TDSDED", typeof(string));
        dt.Columns.Add("FRTDED", typeof(string));
        dt.Columns.Add("CLMDED", typeof(string));
        dt.Columns.Add("unexpded", typeof(string));
        dt.Columns.Add("MRS_Status", typeof(string));
        dt.Columns.Add("BA", typeof(string));
        dt.Columns.Add("ded_oth", typeof(string));
        dt.Columns.Add("othchrg_frt", typeof(string));

        dt.Columns.Add("frt_new", typeof(string));



        DataRow dr;

        int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

        //Total variables declaration
        double dblTotalAmount = 0;
        double dblTotalCloseAmount = 0;
        double dblTotalFrtDed = 0;
        double dblTotalTDSAmt = 0;
        double dblTotalUnadjustedAmt = 0;
        double dblTotalClaimedAmt = 0;
        string strclose;
        string strcancel;
             string strmr="";
        //SqlConnection sqlConn2 = new SqlConnection("data source=123.108.47.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_LIVE_net;Connect Timeout=10000;");
        SqlConnection sqlConn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn2.Open();

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["RowCounter"] = loopCounter++;


            //dr["aHrefLink"] = strHrefLink;

            dr["MRSNo"] = drRows["MRSNo"].ToString();
            strmr= drRows["MRSNo"].ToString();
            //*********dr[" "] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();
            //  dr["MRSDT"] = convert.drRows["MRSDT"].ToString();
            // dr["MRSTYPE"] = drRows["MRSTYPE"].ToString();

            if (drRows["MRSDT"] is DBNull)
            {
                dr["MRSDT"] = "-";
            }
            else
            {
                dr["MRSDT"] = Convert.ToDateTime(drRows["MRSDT"]).ToString("dd MMM yyyy");
            }


            //dr["MRSTYPE"] = drRows["MRSTYPE"].ToString();

            dr["MRSTYPE"] = GetMRType(Convert.ToInt32(drRows["MRSTYPE"]));

            dr["MRSBR"] = drRows["MRSBR"].ToString();

            dr["MRBRNNM"] = drRows["MRBRNNM"].ToString();
            // dr["PTCD"] = drRows["PTCD"].ToString();
            dr["PartyNAME"] = drRows["PTCD"].ToString() + " : " + drRows["PTNAME"].ToString();
            dr["ORGNCD"] = drRows["ORGNCD"].ToString();
            dr["DOCBKNM"] = drRows["DOCBKNM"].ToString();
            dr["DESTCD"] = drRows["DESTCD"].ToString();
           // dr["DOCDLNM"] = drRows["DOCDLNM"].ToString();

            if (drRows["MRSAMT"] is DBNull)
            {
                dr["MRSAMT"] = "0.00";
            }
            else
            {
                dr["MRSAMT"] = Convert.ToDouble(drRows["MRSAMT"]).ToString("0.00");
                dblTotalAmount += Convert.ToDouble(drRows["MRSAMT"]);
            }


            if (drRows["badesc1"] is DBNull)
            {
                dr["ba"] = "-";
            }
            else
            {
                dr["ba"] =  drRows["badesc1"].ToString();
               
            }


            // dr["MRSAMT"] = drRows["MRSAMT"].ToString();
            dr["dockno"] = drRows["dockno"].ToString();
            // dr["Closeamt"] = drRows["Closeamt"].ToString();

            if (drRows["netamt"] is DBNull)
            {
                dr["netamt"] = "0.00";
            }
            else
            {
                dr["netamt"] = Convert.ToDouble(drRows["netamt"]).ToString("0.00");
                dblTotalCloseAmount += Convert.ToDouble(drRows["netamt"]);
            }


             dr["MRS_Closed"] = drRows["MRS_Closed"].ToString();
            dr["Paymode"] = drRows["Paymode"].ToString();




            if (drRows["finclosedt"] is DBNull)
            {
                dr["finclosedt"] = "-";

            }
            else
            {
                dr["finclosedt"] = Convert.ToDateTime(drRows["finclosedt"]).ToString("dd MMM yyyy");
            }

            // dr["finclosedt"] = drRows["finclosedt"].ToString();
            dr["DEDUCTION"] = drRows["DEDUCTION"].ToString();
            dr["miscchrg"] = drRows["miscchrg"].ToString();
            //dr["MR_CANCEL"] = drRows["MR_CANCEL"].ToString();
            strclose = drRows["MRS_Closed"].ToString();
            strcancel = drRows["MR_CANCEL"].ToString();

            if (strclose == "N" && strcancel == "N")
            {
                dr["MRS_Status"] = "MR - Generated ";
            }
            else if (strclose == "Y" && strcancel == "N")
            {
                dr["MRS_Status"] = "MR - Close ";
            }

            if (strcancel == "Y")
            {
                dr["MRS_Status"] = "Cancelled MR";
            }


            //dr["NETAMT"] = drRows["NETAMT"].ToString();
            dr["chq_amt"] = drRows["chq_amt"].ToString();
            dr["remark"] = drRows["remark"].ToString();
            dr["report_loc"] = drRows["report_loc"].ToString();

            string sql_chq = "select distinct CHQNO + '/' + convert(varchar,chqdt,106) as CHQNO from WEBX_BILLCHQDETAIL where DOCNO='" + strmr + "'";
           
            // Response.Write("<br> sql_chq : " + sql_chq);
           // SqlConnection sqlConn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim() + " Min Pool Size=5;Max Pool Size=180; Connect Timeout=10;");
         
            SqlCommand cmdchq=new SqlCommand(sql_chq,sqlConn2);
            //SqlDataReader drchq = cmdchq.ExecuteReader();
            SqlDataAdapter ddd = new SqlDataAdapter(cmdchq);
            DataSet dds = new DataSet();
            ddd.Fill(dds);
            string chqlist = "";

            foreach(DataRow drchq in dds.Tables[0].Rows)
            {

                if (chqlist == "")
                {
                    chqlist = drchq["CHQNO"].ToString();
                }
                else
                {
                    chqlist = chqlist + "," + drchq["CHQNO"].ToString();
                }

            }
            sqlConn2.Close();
            
            //and   and DOC_CURLOC='" & orgncd & "'";

            dr["MRChequeDetails"] = chqlist;



            //  dr["TDSDED"] = drRows["TDSDED"].ToString();


            if (drRows["new_tds"] is DBNull)
            {
                dr["TDSDED"] = "0.00";
            }
            else
            {
                dr["TDSDED"] = Convert.ToDouble(drRows["new_tds"]).ToString("0.00");
                dblTotalTDSAmt += Convert.ToDouble(drRows["new_tds"]);
            }




            if (drRows["new_add"] is DBNull)
            {
                dr["othchrg_frt"] = "0.00";
            }
            else
            {
                dr["othchrg_frt"] = Convert.ToDouble(drRows["new_add"]).ToString("0.00");
               // dblTotalAmount += Convert.ToDouble(drRows["othchrg_frt"]);
            }



            if (drRows["ded_oth"] is DBNull)
            {
                dr["ded_oth"] = "0.00";
            }
            else
            {
                dr["ded_oth"] = Convert.ToDouble(drRows["ded_oth"]).ToString("0.00");
              //  dblTotalAmount += Convert.ToDouble(drRows["MRSAMT"]);
            }


            // dr["FRTDED"] = drRows["FRTDED"].ToString();

            if (drRows["frt"] is DBNull)
            {
                dr["frt_new"] = "0.00";
            }
            else
            {
                dr["frt_new"] = Convert.ToDouble(drRows["frt"]).ToString("0.00");
                 
            }


            // dr["CLMDED"] = drRows["CLMDED"].ToString();


            if (drRows["new_clm"] is DBNull)
            {
                dr["CLMDED"] = "0.00";
            }
            else
            {
                dr["CLMDED"] = Convert.ToDouble(drRows["new_clm"]).ToString("0.00");
                dblTotalClaimedAmt += Convert.ToDouble(drRows["new_clm"]);
            }


            
            if (drRows["unex"] is DBNull)
            {
                dr["unexpded"] = "0.00";
            }
            else
            {
                dr["unexpded"] = Convert.ToDouble(drRows["unex"]).ToString("0.00");
                
            }

            dt.Rows.Add(dr);
           



        }
        sqlConn2.Close();

        dblTotalAmount = dblTotalAmount+1;

        GV_MR.DataSource = dt;
        GV_MR.DataBind();

        if (GV_MR.Rows.Count == 0)
        {
            ttt1.Visible = false;
        }




    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_MR.PageIndex = e.NewPageIndex;

      //  DisplayMrDetails();


    }

    private string GetMRType(int intMRTypeValue)
    {
        string strMRType = "";
        switch (intMRTypeValue)
        {
            case 1:
                strMRType = "Paid";
                break;
            case 2:
                strMRType = "TBB";
                break;
            case 3:
                strMRType = "To Pay";
                break;
            case 4:
                strMRType = "Octroi";
                break;
           
            case 5:
                strMRType = "Cancelled";
                break;

            case 6:
                strMRType = "Misc.";
                break;
          
            case 7:
                strMRType = "Supplimentry";
                break;
            case 8:
                strMRType = "Trial TBB";
                break;
        }

        return strMRType;
    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_MR.PageCount;
        GV_MR.PageIndex = i;

        DisplayMrDetails();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_MR.PageIndex = 0;

        DisplayMrDetails();


    }
    private void InitializeComponent()
    {

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_MR.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=MR_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayMrDetails();
            p1.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }
    
    }

}

