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

public partial class GUI_Finance_Fix_Asset_Fix_Asset_Add : System.Web.UI.Page
{
    public static string straccd, p;
    public DataTable dt_san = new DataTable();
    public double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    protected void Page_Load(object sender, EventArgs e)
    {

        p = Request.QueryString["pa"].ToString();


        if (!IsPostBack)
        {

            creategrid();
            // Validation();
            //        straccd = "";
            //        if (p == "1")
            //        {
            //            popgrp();
            //        }
            //        else
            //        {
            //            popgrp();
            //            straccd = Request.QueryString["accode"].ToString();
            //            filldata();

            //        }
        }
        //    btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");

        btn_submit.Attributes.Add("onClick", "javascript:return ch()");

    }


    public void creategrid()
    {
        dt_san.Clear();
        Int32 i;
        DataRow drow;


        for (i = 0; i < 10; i++)
        {
            drow = dt_san.NewRow();
            dt_san.Rows.Add(drow);

        }


        GV_D.DataSource = dt_san;
        GV_D.DataBind();

    }

    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtacccode = (TextBox)(e.Row.FindControl("txtassetcd"));
            Button btncodepopup = ((Button)(e.Row.FindControl("btncodepopup")));
            btncodepopup.Attributes.Add("onclick", "javascript:return nwOpen2('" + txtacccode.ClientID.ToString() + "')");



            TextBox txtastnm = ((TextBox)(e.Row.FindControl("txtastnm")));
            TextBox txtdesc = ((TextBox)(e.Row.FindControl("txtdesc")));
            TextBox txtqty = ((TextBox)(e.Row.FindControl("txtqty")));
            TextBox txtperct = ((TextBox)(e.Row.FindControl("txtperct")));
            TextBox txtrate = ((TextBox)(e.Row.FindControl("txtrate")));
            TextBox txttot = ((TextBox)(e.Row.FindControl("txttot")));
            TextBox txttot2 = ((TextBox)(e.Row.FindControl("txttottot")));


        //  //  txtrate.Attributes.Add("onblur", "javascript:return check2(" + txtqty.ClientID + "," + txtperct.ClientID + "," + txtrate.ClientID + "," + txttot.ClientID + ")");
            txtrate.Attributes.Add("onblur", "javascript:checkfinal()");

        //    //        txtoctamt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + txtoctamt.ClientID + ")");
        //    //        txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");

      // }


    }


    public string getnewcd()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "exec sp_get_next_FAPO_code '"+Session["BRCD"].ToString()+"','07'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        string cd1 = (string)sqlcmd.ExecuteScalar();

      //  string cd = Convert.ToString(cd1);

        return cd1;


    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
                                //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                                //conn.Open();
                                //string sql = "";
                              

                                //string pocd = getnewcd();

                                //sql = "Insert into webx_POASSET_HDR(pocode,podate,VENDORCD,qutno,qutdate,reqno,reqdt,totalqty,totalamt,attn,ENTRYBY,ENTRYON,POSTATUS,Pendamt,po_loccode,chqdate,PayMode,acccode,accdesc,Chqno,paidamt,terms_condition,tax_type)"+
                                //      "values('" + pocd + "','" + txtpodt.Text + "','" + txtven.Text + "','" + txtqno.Text + "'," + txtqdt.Text + ",'','',15," + txtbalamt.Text + ",'" + txtkind.Text + "','" + Session["empcd"].ToString() + "',getdate(),'P'," + txtbalamt.Text + ",'" + Session["brcd"].ToString() + "'," + txtChequeDate.Text + ",'" + cboModeOfTransaction.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "'," + txtChequeNo.Text + "," + txtCashAmount.Text + ",'term and cndt','tax_type ')";


                                //                                                                   // sql = "Insert into webx_POASSET_HDR(pocode,podate,VENDORCD,qutno,qutdate,reqno,reqdt,totalqty,totalamt,attn,ENTRYBY,ENTRYON,POSTATUS)" +
                                //                                                                        //"values('" + pocd + "','" + txtpodt.Text + "','" + txtven.Text + "','" + txtqno.Text + "'," + txtqdt.Text + ",'','',15," + txtbalamt.Text + ",'" + txtkind.Text + "','" + Session["empcd"].ToString() + "',getdate(),'P')";
                                                                                                    
                                                                                                    
                                                                                                    
                                //                                                                    //+txtbalamt.Text + ",'" + Session["brcd"].ToString() + "'," + txtChequeDate.Text + ",'" + cboModeOfTransaction.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "'," + txtChequeNo.Text + "," + txtCashAmount.Text + ",'term and cndt','tax_type ')";


                         
                                //try
                                //{
                                //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

                                //    sqlcmd.ExecuteNonQuery();
                                //}
                                //catch (Exception e1)
                                //{
                                //    btn_submit.Text = e1.Message;
                                //}

                                ////Response.Redirect("fa.aspx");






    }


    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (cboModeOfTransaction.SelectedValue.ToString() != "")
        {

            string sql = "";

            if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
            {
                sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or bkloccode like '" + Session["brcd"].ToString() + "%') AND acccategory='BANK')) order by accdesc asc";
            }
            else
            {
                sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            cboPaymentAccount.DataSource = ds;
            cboPaymentAccount.DataTextField = "accdesc";
            cboPaymentAccount.DataValueField = "asscodeval";
            cboPaymentAccount.DataBind();
            cboPaymentAccount.CssClass = "blackfnt";
        }
    }

    protected void cboPaymentAccount_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
