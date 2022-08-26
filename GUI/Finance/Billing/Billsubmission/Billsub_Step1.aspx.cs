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

public partial class Finance_Billing_Billsubmission_Billsub_Step1 : System.Web.UI.Page
{

   //// SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    //SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Party_code;
    string orgncd;
    string fincmplbr;
    string billno;
    string fromdt;
    string Todt;
    string PAYBAS, manualbillno="";

    string TRN_MOD;
    string sqlmain;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    public static string Fromdate = "", Todate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtbsbdt.ClientID + "," + txtsubto.ClientID + "," + txtsubcontactno.ClientID + "," + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        Party_code = Request.QueryString.Get("Party_code");
        billno = Request.QueryString.Get("billno");
        manualbillno = Request.QueryString.Get("manualbillno");
            orgncd = "All";
            fincmplbr = Session["brcd"].ToString();
            //Response.Write("fincmplbr - " + fincmplbr);
            fromdt = Request.QueryString.Get("fromtdate");
            Fromdate = Request.QueryString.Get("fromtdate");
            Todt = Request.QueryString.Get("todate");
            Todate = Request.QueryString.Get("todate");
            PAYBAS = Request.QueryString.Get("paybas");
            //string TRN_MOD = Request.QueryString.Get("trnmod");
            

            fromdt = fn.Mydate1(fromdt);
            Todt = fn.Mydate1(Todt);

            if (fromdt=="")
            {
                fromdt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (Todt=="")
            {
                Todt=System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            

        if (billno == "")
        {
            //fromdt = fn.Mydate1(fromdt);
           // Todt = fn.Mydate1(Todt);
            lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
           
            lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
            lblpaybas.Text = fn.Getpaybas(PAYBAS);
           
            lblbillno.Text = "";

           
        }
        else
        {
            lbldaterange.Text = "-";
            lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
            lblpaybas.Text = fn.Getpaybas(PAYBAS);
           
            lblbillno.Text = billno.Trim();
            
        }

        BindGrid();
        
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "webx_BillSubmission";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;

        myAdapter.SelectCommand.Parameters.Add("@billno", SqlDbType.VarChar).Value = billno.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Party_code", SqlDbType.VarChar).Value = Party_code.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Billtype", SqlDbType.VarChar).Value = PAYBAS.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Todt", SqlDbType.DateTime).Value = Todt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value =  fincmplbr.Trim();
        myAdapter.SelectCommand.Parameters.Add("@manualbillno", SqlDbType.VarChar).Value = manualbillno.Trim();
        
        
       

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
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string billno_nos = "";
        string billnonos = "";
        string docketlist = txtdocketlist.Value.ToString();
        string[] docketlist_arr;
        docketlist_arr = docketlist.Split(',');
        string checkeddockno = txtdocketlist_count.Value.ToString();
        int total_checked = Convert.ToInt32(checkeddockno);
        //Response.Write("total_checked " + total_checked);

        if (total_checked == 1)
        {
            string bill_no = docketlist;
            billno_nos = "'" + bill_no + "'";
            billnonos = bill_no;
        }
        else
        {

            for (int i = 0; i < total_checked; i++)
            {
                string bill_no = docketlist_arr[i].ToString();
                if (billno_nos == "")
                {
                    billno_nos = "'" + bill_no + "'";
                    billnonos = bill_no;
                }
                else
                {
                    billno_nos = billno_nos + "," + "'" + bill_no + "'";
                    billnonos = billnonos + "," + bill_no;
                }

            }
        }
        //for (int i = 0; i <= total_checked; i++)
        //{
        //    string bill_no = docketlist_arr[i].ToString();
        //    if (billno_nos == "")
        //    {
        //        billno_nos = "'" + bill_no + "'";
        //        billnonos = bill_no ;
        //    }
        //    else
        //    {
        //        billno_nos = billno_nos + "," + "'" + bill_no + "'";
        //         billnonos = billnonos + "," + bill_no ;
        //    }

        //}
        //Response.Write("<br>billno_nos " + billno_nos);
        //Response.End();
        string billstatusnew = "Bill Submitted";
        string BSUBEMPCD = Session["empcd"].ToString().ToUpper();
        string BILLSUBTO = txtsubto.Text.ToString().ToUpper();
        string SUBTOTEL = txtsubcontactno.Text.ToString().ToUpper();
        string bsbdt = "";

        //DateTime billsubdate = Convert.ToDateTime(txtbsbdt.Text.ToString());
        bsbdt = fn.Mydate1(txtbsbdt.Text.ToString());
        //bsbdt = billsubdate.ToString("dd/MM/yyyy");
        SqlCommand cmd = new SqlCommand();
        string sql_update = "update webx_billmst set BSUBEMPCD='" + BSUBEMPCD + "',BILLSUBTO='" + BILLSUBTO + "',SUBTOTEL='" + SUBTOTEL + "',bsbdt='" + bsbdt + "',billstatus='" + billstatusnew + "' where billno in (" + billno_nos + ")";
        //Response.Write("<br>sql_update " + sql_update);
        //Response.Write("<br>billno_nos - " + billno_nos);
        cmd = new SqlCommand(sql_update, conn);
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("Billsub_Step2.aspx?billnos=" + billnonos);
       //// Response.End();
    }
    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
