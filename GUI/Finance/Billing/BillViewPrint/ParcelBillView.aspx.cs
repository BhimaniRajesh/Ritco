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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
using System.Text;

public partial class GUI_Finance_Billing_BillViewPrint_ParcelBillView : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn;
    private GridViewHelper helper;
    String frmdate, todate, fdate, tdate, billno, mbillno, pcode, billtype, billstatus;
    Boolean flgxls2;
    string Number, billamount;
    string deciml;
    string _number, bno, strQuery;
    string _deciml;
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    string iamegyrl = "";
    public int FGTotal = 0;
    public string todayDate;
    public double totAmount = 0.0, totAmount1 = 0.0, totAmount2 = 0.0, totAmount3 = 0.0, totAmount4 = 0.0, totAmount5 = 0.0, totAmount6 = 0.0;
    double totWeight = 0.0, tot_Amount = 0.0, totSubTotal = 0.0, totServiceTax = 0.0, totCess = 0.0, totTotal = 0.0;
    MyFunctions fn = new MyFunctions();
    double pkgs, totFREIGHT, totdetention, totOther, totSubtotal, totservicetax, totcess, tottotal;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        flgxls2 = false;
        if (!IsPostBack)
        {
            tblall.Visible = false;
            tblbillno.Visible = false;
            Array str, str1;
            string logo = Session["logofile"].ToString();
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            billno = Request.QueryString["billno"];
            mbillno = Request.QueryString["mbillno"];
            pcode = Request.QueryString["partycode"];
            
            
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            frmdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            todate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            lbldaterange.Text = TxtDateRange.Text;
            
            
            lblbillno.Text = billno;
            lblmbillno.Text = mbillno;
            lblccode.Text = pcode;
            if (lblbillno.Text == "" && lblmbillno.Text == "")
            {
                tblall.Visible = true;
            }
            else
            {
                tblbillno.Visible = true;
                if (lblbillno.Text != "")
                {
                    lblmbillno.Visible = false;
                    lbldmbillno.Visible = false;
                }
                else
                {
                    lblbillno.Visible = false;
                    lbldbillno.Visible = false;
                }
            }
            BindTheData();
        }

    }

    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        if (billno != "")
        {
            cmd.CommandText = "select billno,manualbillno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where billno='" + billno + "' and paybas='2' ";
        }
        else if (mbillno != "")
        {
            cmd.CommandText = "select billno,manualbillno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where manualbillno='" + mbillno + "' and paybas='2'";
        }
        else
        {
            if ((pcode != ""))
            {
                cmd.CommandText = "select billno,manualbillno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
            }
            else
            {
                cmd.CommandText = "select billno,manualbillno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas='2' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
            }
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "Billdetail");
        GrdLoadUnload.DataSource = ds.Tables["Billdetail"];
        GrdLoadUnload.DataBind();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();
    }
    
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DateTime d1;
            if (((Label)e.Row.FindControl("lblgendate")).Text != "" && ((Label)e.Row.FindControl("lblgendate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblgendate")).Text);
                ((Label)e.Row.FindControl("lblgendate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblduedate")).Text != "" && ((Label)e.Row.FindControl("lblduedate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblduedate")).Text);
                ((Label)e.Row.FindControl("lblduedate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblsubdate")).Text != "" && ((Label)e.Row.FindControl("lblsubdate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblsubdate")).Text);
                ((Label)e.Row.FindControl("lblsubdate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblcollectiondate")).Text != "" && ((Label)e.Row.FindControl("lblcollectiondate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblcollectiondate")).Text);
                ((Label)e.Row.FindControl("lblcollectiondate")).Text = d1.ToString("dd MMM yyyy");
            }
            ((Label)e.Row.FindControl("lblbilltype")).Text = "2" == "2" ? "TBB" : ((Label)e.Row.FindControl("lblbilltype")).Text;
        }

    }
    
    protected void xlsView(object sender, EventArgs e)
    {
        tblbillGrid2.Visible = true;
        //tblbillGrid3.Visible = true;
        //tblbillGrid4.Visible = true;
        //tblbillGrid5.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkbilldtl")).Text;
        strQuery = "Select c.custnm as CustomerName,c.CustAddress as CustAddress,H.BILLNO,rtrim(left(convert(varchar,H.BGNDT,03),6))+' '+right(convert(varchar,H.BGNDT,03),2) as BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,sum(d.dkttot)as BILLAMT,sum(D.SVRCAMT) as STAX,sum(D.DKTCHG)as DKTCHG,sum(D.FOVCHG)as FOVCHG,sum(D.OTCHG)as OTCHG,h.manualbillno from Webx_BILLMST h,Webx_BILLDET D,webx_custhdr c  Where H.billno=D.Billno and  c.custcd=h.ptmscd and  H.billno ='" + bno + "' group by H.BILLNO,H.BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,c.custnm,c.CustAddress,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,h.manualbillno";
        SqlCommand cmd = new SqlCommand(strQuery, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblBill_no.Text = bno.ToString();
            lblBillDate.Text = Convert.ToString(dr["BGNDT"]);
            lblCustCode.Text = Convert.ToString(dr["PTMSCD"]);
            lblCustName.Text = Convert.ToString(dr["CustomerName"]);
            lblCustAdd.Text = Convert.ToString(dr["CustAddress"]);

        }
        dr.Close();

        strQuery = "select BBRCD,Adderess=(select LocAddr from webx_location where loccode=m.BBRCD) from webx_billmst m where m.billno='" + bno + "'";
        SqlCommand cmd1 = new SqlCommand(strQuery, cn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        while (dr1.Read())
        {
            //lblBranch.Text = Convert.ToString(dr1["BBRCD"]);
            //lblAddress.Text = Convert.ToString(dr1["Adderess"]);
        }
        dr1.Close();

        BindGridBillView();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        BillViewGridDetail.Font.Size = 8;
        Response.AddHeader("content-disposition", "attachment;filename=" + bno + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblbillGrid2);
        //frm.Controls.Add(tblbillGrid3);
        //frm.Controls.Add(tblbillGrid4);
        //frm.Controls.Add(tblbillGrid5);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    private void BindGridBillView()
    {
        SqlConnection Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        string sql = "select distinct * from VW_ParcelBill where billno='" + bno + "'";
        SqlCommand cmdSTD = new SqlCommand(sql, Conn);
        SqlDataAdapter da = new SqlDataAdapter(cmdSTD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        BillViewGridDetail.DataSource = ds;
        BillViewGridDetail.DataBind();
    }

    protected void xlsdetail(object sender, EventArgs e)
    {
        //tblbillGrid9.Visible = true;
        //tblbillGrid6.Visible = true;
        //tblbillGrid7.Visible = true;
        //tblbillGrid8.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkbilldt2")).Text;
        strQuery = "Select c.custnm as CustomerName,c.CustAddress as CustAddress,H.BILLNO,rtrim(left(convert(varchar,H.BGNDT,03),6))+' '+right(convert(varchar,H.BGNDT,03),2) as BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,sum(d.dkttot)as BILLAMT,sum(D.SVRCAMT) as STAX,sum(D.DKTCHG)as DKTCHG,sum(D.FOVCHG)as FOVCHG,sum(D.OTCHG)as OTCHG,h.manualbillno from Webx_BILLMST h,Webx_BILLDET D,webx_custhdr c  Where H.billno=D.Billno and  c.custcd=h.ptmscd and  H.billno ='" + bno + "' group by H.BILLNO,H.BGNDT,H.PTMSCD,H.PTMSBRCD,H.PTMSNM,H.PTMSADDR,c.custnm,c.CustAddress,H.PTMSADDR,H.PTMSTEL,H.PTMSEMAIL,h.manualbillno";
        SqlCommand cmd = new SqlCommand(strQuery, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblBill_no.Text = bno;
            lblBillDate.Text = Convert.ToString(dr["BGNDT"]);
            lblCustCode.Text = Convert.ToString(dr["PTMSCD"]);

        }
        dr.Close();

        BindGridBillViewDetail();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        BillViewGridDetail.Font.Size = 8;
        Response.AddHeader("content-disposition", "attachment;filename=" + bno + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        //frm.Controls.Add(tblbillGrid9);
        //frm.Controls.Add(tblbillGrid6);
        //frm.Controls.Add(tblbillGrid7);
        //frm.Controls.Add(tblbillGrid8);
        frm.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
    }

    private void BindGridBillViewDetail()
    {
        SqlConnection Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        string sql = "select distinct * from VW_VarunaBillDetail_newFormat where billno='" + bno + "'";
        SqlCommand cmdSTD = new SqlCommand(sql, Conn);
        SqlDataAdapter da = new SqlDataAdapter(cmdSTD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        BillViewGridDetail.DataSource = ds;
        BillViewGridDetail.DataBind();
    }
    protected void BillViewGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblWeight = (Label)e.Row.FindControl("lblWeight");
            totWeight = totWeight + Convert.ToDouble(lblWeight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotalWeight = (Label)e.Row.FindControl("lblFooTotalWeight");
            lblFooTotalWeight.Text = totWeight.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblamount = (Label)e.Row.FindControl("lblamount");
            tot_Amount = tot_Amount + Convert.ToDouble(lblamount.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotaFreight = (Label)e.Row.FindControl("lblFooTotaFreight");
            lblFooTotaFreight.Text = tot_Amount.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSubtotal = (Label)e.Row.FindControl("lblSubtotal");
            totSubTotal = totSubTotal + Convert.ToDouble(lblSubtotal.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotalSubtotal = (Label)e.Row.FindControl("lblFooTotalSubtotal");
            lblFooTotalSubtotal.Text = totSubTotal.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblservicetax = (Label)e.Row.FindControl("lblservicetax");
            totServiceTax = totServiceTax + Convert.ToDouble(lblservicetax.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotalservicetax = (Label)e.Row.FindControl("lblFooTotalservicetax");
            lblFooTotalservicetax.Text = totServiceTax.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblcess = (Label)e.Row.FindControl("lblcess");
            totCess = totCess + Convert.ToDouble(lblcess.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotalCess = (Label)e.Row.FindControl("lblFooTotalCess");
            lblFooTotalCess.Text = totCess.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbltotal = (Label)e.Row.FindControl("lbltotal");
            totTotal = totTotal + Convert.ToDouble(lbltotal.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFooTotaltotal = (Label)e.Row.FindControl("lblFooTotaltotal");
            lblFooTotaltotal.Text = totTotal.ToString();
        }

        //if (billamount != "")
        //{
        //    double amount = Convert.ToDouble(billamount);
        //    Int64 amt = Convert.ToInt64(amount);
        //    RupeesToWords rupee = new RupeesToWords();
        //    //lblInwords.Text = Convert.ToString(rupee.NumberToText(amt)) + "Only";
        //}
    }
}

