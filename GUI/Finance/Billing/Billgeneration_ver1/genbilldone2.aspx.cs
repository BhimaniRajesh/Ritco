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
using System.Text;
using System.IO;
public partial class Finance_Billing_Billgeneration_genbilldone2 : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
   // SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string billno;
    SqlConnection conn;
    MyFunctions fn = new MyFunctions();
    String frmdate, todate, fdate, tdate, pcode, billtype, billstatus;
    //decimal totcodchg, tothldchrg, totstatechrg, tothlddlychrg, totnformchrg, totfodcharge, tototchg, subtotal, totsvctax, totcess, totheducess, totqty1, totamt1, totqty2, totamt2;
    decimal totcodchg, tot_oth, totfuel, tothldchrg, totstatechrg, tothlddlychrg, totnformchrg, totfodcharge, tototchg, subtotal, totsvctax, totcess, totheducess, totqty1, totamt1, totqty2, totamt2;
    Boolean flgxls2;
    string Number;
    string deciml;
    string _number;
    string _deciml;
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Initialize(); 
        billno = Request.QueryString.Get("billno");
        BindGrid();

    }
    public void BindGrid()
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "webx_UNI_Billdata";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;

        myAdapter.SelectCommand.Parameters.Add("@billno", SqlDbType.VarChar).Value = billno.Trim();
       
        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");

        GrdLoadUnload.DataSource = ds;
        GrdLoadUnload.DataBind();
        conn.Close();
    }
    protected void xls1(object sender, EventArgs e)
    {
        tblxls1.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkbilldtl")).Text;
        //old structure
        //string sql = "select d.DOCKNO,d.DOCKSF,d.DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.DACC_CHRG,d.DKTCHG,d.CODCHG,d.DIPLOMATCHG,d.OTCHG,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_docket_invoicedet i where i.dockno=d.dockno and i.docksf=d.docksf),spl_svc_req,DCCharge,DDCharge,hld_chrg,state_chrg,hld_dlychrg,nform_chrg,FODCharge,0 as diesel_chrg,D.CESS,d.trn_mod from vw_Bill_Print_XLS d,Webx_billDET b where d.dockno=b.dockno and d.docksf=b.docksf and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        //new structure
        //string sql = "select d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS as Cessamount,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        //Change 08  March 2008
        string sql = "select d.ctr_no,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,c.DKTTOT,c.SVCTAX,c.FOV,c.schg13 as DACC,c.schg01 as DKTCHG,c.schg12 as CODCHG,c.schg03 as OTCHG,c.schg21 as FOD,c.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,c.CESS as Cessamount,d.trn_mod,c.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from webx_master_docket d with(NOLOCK) inner join webx_master_docket_charges c with(NOLOCK) on d.dockno=c.dockno  inner join Webx_billDET b with(NOLOCK) on d.dockno=b.dockno  where  b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataSet dsxls1 = new DataSet();
        da.Fill(dsxls1, "xls1");
        GrdXLS1.DataSource = dsxls1.Tables["xls1"];
        GrdXLS1.DataBind();
        //SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "' union select * from Webx_billmst_arch where billno='" + bno + "'", conn);
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblpartyname.Text = Convert.ToString(dr["ptmsnm"]);
            lblpbillno.Text = bno;
        }
        dr.Close();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BillDeatail.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls1);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + Server.MapPath("..\\..\\..\\images\\webxpress_logo.gif") + " />";
        //String tag = "<img src=" + iamegyrl + " />";
        //Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        //tblxls1.Visible = false; 
    }
    protected void xls2(object sender, EventArgs e)
    {
        flgxls2 = true;
        tblxls2.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
        lblABillNo.Text = bno;
        //old structure
        //string sql = "select d.DOCKNO,d.DOCKSF,d.DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.DACC_CHRG,d.DKTCHG,d.CODCHG,d.DIPLOMATCHG,d.OTCHG,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_docket_invoicedet i where i.dockno=d.dockno and i.docksf=d.docksf),spl_svc_req,DCCharge,DDCharge,hld_chrg,state_chrg,hld_dlychrg,nform_chrg,FODCharge,0 as diesel_chrg,D.CESS,d.trn_mod from vw_Bill_Print_XLS d,Webx_billDET b where d.dockno=b.dockno and d.docksf=b.docksf and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        //new structure
        string sql = "select D.ctr_no,(isnull(d.SCHG02,0)+isnull(d.SCHG03,0)+isnull(d.SCHG04,0)+isnull(d.SCHG12,0)+isnull(d.SCHG06,0)+isnull(d.SCHG09,0)+isnull(d.SCHG10,0)+isnull(d.SCHG13,0)+isnull(d.SCHG14,0)+isnull(d.SCHG15,0)+isnull(d.SCHG16,0)+isnull(d.SCHG17,0)+isnull(d.SCHG18,0)+isnull(d.SCHG19,0)+isnull(d.SCHG20,0)+isnull(d.SCHG21,0)+isnull(d.SCHG22,0)+isnull(d.SCHG23,0)+isnull(d.UCHG01,0)+isnull(d.UCHG02,0)+isnull(d.UCHG03,0)+isnull(d.UCHG04,0)+isnull(d.UCHG05,0)-isnull(d.UCHG06,0)-isnull(d.UCHG07,0)-isnull(d.UCHG08,0)-isnull(d.UCHG09,0)-isnull(d.UCHG10,0)) as Miscellineous,d.invno as InvoiceNumber,d.SCHG20 as FuelCharges,SubTotal,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GrdXLS2.DataSource = dsxls2.Tables["xls2"];
        GrdXLS2.DataBind();

        subtotal = 0;
        for (int i = 0; i < dsxls2.Tables["xls2"].Rows.Count; i++)
        {
            subtotal += Convert.ToDecimal(dsxls2.Tables["xls2"].Rows[i]["SubTotal"]);
        }
        lblsubtotal.Text = Convert.ToString(subtotal);
        conn.Open();
        //SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "' union select * from Webx_billmst_arch where billno='" + bno + "'", conn);
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
                //return;
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
                //return;
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }


            //lbltotalinword.Text = "Rs. " + Convert.ToString(dr["BillAmt"]);
        }
        dr.Close();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Portrait.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls2);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + iamegyrl + " />";
        //Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblxls2.Visible = false;
    }
    protected void GrdXLS1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Docket";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Bill";
            oTableCell.ColumnSpan = 17;
            oTableCell.Font.Bold = true;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }
            dno = ((Label)e.Row.FindControl("lblinvoiceno")).Text;
            sql = "select distinct invno from Webx_master_docket_invoice where Dockno='" + dno + "'";
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand(sql, conn);
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            dr = cmd.ExecuteReader();
            invno = "";
            while (dr.Read())
            {
                invno = invno + "," + Convert.ToString(dr["invno"]);
            }
            if (invno.Length > 0)
            {
                invno = invno.Substring(1, invno.Length - 1);
            }
            dr.Close();
            ((Label)e.Row.FindControl("lblinvoiceno")).Text = invno;
        }
    }
    protected void GrdXLS2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {

        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }

        }
        tot_oth = tot_oth + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "OTCHG") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "OTCHG"));
        //totfuel = totfuel + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "FuelCharges") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "FuelCharges"));
        totcodchg = totcodchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "codchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "codchg"));
        tothldchrg = tothldchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_chrg"));
        totstatechrg = totstatechrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "state_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "state_chrg"));
        tothlddlychrg = tothlddlychrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_dlychrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_dlychrg"));
        totnformchrg = totnformchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "nform_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "nform_chrg"));
        totfodcharge = totfodcharge + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "fod") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "fod"));
        tototchg = tototchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "otchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "otchg"));
        totsvctax = totsvctax + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "servicetax") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "servicetax"));
        totcess = totcess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "cess"));
        totheducess = totheducess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hedu_cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hedu_cess"));
        //FuelCharges
        //lblFuelCharges.Text = Convert.ToString(totfuel);
        lblOtherCharges.Text = Convert.ToString(tot_oth);
        lblcoddod.Text = Convert.ToString(totcodchg);
        lblhandlecharge.Text = Convert.ToString(tothldchrg);
        lblstatechrg.Text = Convert.ToString(totstatechrg);
        lblholidaychrg.Text = Convert.ToString(tothlddlychrg);
        lblnformcharge.Text = Convert.ToString(totnformchrg);
        lblfodcharge.Text = Convert.ToString(totfodcharge);
        lblothercharge.Text = Convert.ToString(tototchg);
        lblservicetax.Text = Convert.ToString(totsvctax);
        lblcessontax.Text = Convert.ToString(totcess);
        lblhigheducess.Text = Convert.ToString(totheducess);
    }
    protected void xls3(object sender, EventArgs e)
    {
        flgxls2 = false;
        tblxls2.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
        lblABillNo.Text = bno;

        //string sql = "select d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        //Change 04 March 2008
        string sql = "select D.ctr_no,(isnull(d.SCHG02,0)+isnull(d.SCHG03,0)+isnull(d.SCHG04,0)+isnull(d.SCHG12,0)+isnull(d.SCHG06,0)+isnull(d.SCHG09,0)+isnull(d.SCHG10,0)+isnull(d.SCHG13,0)+isnull(d.SCHG14,0)+isnull(d.SCHG15,0)+isnull(d.SCHG16,0)+isnull(d.SCHG17,0)+isnull(d.SCHG18,0)+isnull(d.SCHG19,0)+isnull(d.SCHG20,0)+isnull(d.SCHG21,0)+isnull(d.SCHG22,0)+isnull(d.SCHG23,0)+isnull(d.UCHG01,0)+isnull(d.UCHG02,0)+isnull(d.UCHG03,0)+isnull(d.UCHG04,0)+isnull(d.UCHG05,0)-isnull(d.UCHG06,0)-isnull(d.UCHG07,0)-isnull(d.UCHG08,0)-isnull(d.UCHG09,0)-isnull(d.UCHG10,0)) as Miscellineous,d.invno as InvoiceNumber,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,SubTotal,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GrdXLS2.DataSource = dsxls2.Tables["xls2"];
        GrdXLS2.DataBind();
        //lblcoddod.Text = Convert.ToString(OTCHG);
        //lblcoddod.Text = Convert.ToString(totcodchg);
        //lblhandlecharge.Text = Convert.ToString(tothldchrg);
        //lblstatechrg.Text = Convert.ToString(totstatechrg);
        //lblholidaychrg.Text = Convert.ToString(tothlddlychrg);
        //lblnformcharge.Text = Convert.ToString(totnformchrg);
        //lblfodcharge.Text = Convert.ToString(totfodcharge);
        //lblothercharge.Text = Convert.ToString(tototchg);
        //lblservicetax.Text = Convert.ToString(totsvctax);
        //lblcessontax.Text = Convert.ToString(totcess);
        //lblhigheducess.Text = Convert.ToString(totheducess);
        conn.Open();
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
                //return;
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
                //return;
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls2);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + iamegyrl + " />";
        //Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblxls2.Visible = false;
    }
    protected void xls4(object sender, EventArgs e)
    {
        tblbulk.Visible = true;
        tblxls2.Visible = false;
        grd1.Visible = true;
        grd2.Visible = false;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lblBillNew1")).Text;
        lblABillNo.Text = bno;

        //string sql = "select D.ctr_no,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        string sql = "select distinct DocketNo,DocketDate,Cnee,ChargeWeight,Rate,Destination,VehicleNo,DONumber,PKGSNO,InvoiceNo,FREIGHT,UnLoadingCharge,Amount from VW_RITCOBill where billno='" + bno + "' order by DocketDate";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataSet dsxls4 = new DataSet();
        da.Fill(dsxls4, "xls4");
        GridView1.DataSource = dsxls4.Tables["xls4"];
        GridView1.DataBind();
        GridView1.FooterRow.Cells[09].Text = Convert.ToString(totqty1);
        GridView1.FooterRow.Cells[11].Text = Convert.ToString(totamt1);
        conn.Open();
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();


        SqlCommand cmd1 = new SqlCommand("select Convert(varchar,h.bgndt,106) as bgndt,ptmsnm,c.custnm as CustomerName,c.CustAddress as CustAddress,h.manualbillno as manualbillno,* from Webx_billmst h,webx_custhdr c where c.custcd=h.ptmscd and billno='" + bno + "'", conn);

        SqlDataReader dr1 = cmd1.ExecuteReader();
        if (dr1.Read())
        {
            //lblpartyname.Text = Convert.ToString(dr["ptmsnm"]);
            //lblpbillno.Text = bno;
            lblBillNox.Text = bno;
            lblBillDt.Text = Convert.ToString(dr1["bgndt"]);
            //lblBranch.Text = Convert.ToString(dr1["bbrcd"]);
            //lblCustCode.Text = Convert.ToString(dr1["ptmscd"]);
            lblManualBillNo.Text = Convert.ToString(dr1["manualbillno"]);
            lblCustName.Text = Convert.ToString(dr1["CustomerName"]);

            //lblAddress.Text = Convert.ToString(dr1["PTMSADDR"]);
            //remarks_new.Text = Convert.ToString(dr1["REMARK"]);


        }
        dr1.Close();

        //SqlCommand cmdSTD = new SqlCommand("select DKTAMT,* from Webx_billDET where billno='" + bno + "'", conn);
        //SqlDataReader drSTD = cmdSTD.ExecuteReader();
        //if (drSTD.Read())
        //{

        //    lbl_Inwords.Text = Convert.ToString(totamt1);
        //    NumberToText rupee = new NumberToText();
        //    lbl_Inwords.Text = rupee.numberToText(lbl_Inwords.Text);

        //}
        //drSTD.Close();


        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblbulk);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + iamegyrl + " />";
        //Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblbulk.Visible = false;
    }
    protected void xls5(object sender, EventArgs e)
    {
        tblbulk.Visible = true;
        tblxls2.Visible = false;
        grd2.Visible = true;
        grd1.Visible = false;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lblBillNew11")).Text;
        lblABillNo.Text = bno;


        //string sql = "select D.ctr_no,SubTotal,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        string sql = "select DocketNo,DocketDate,Cnee,ChargeWeight,Destination,Rate,VehicleNo,DONumber,PKGSNO,InvoiceNo,FREIGHT,UnLoadingCharge,Amount,THC_ArrivalDate,* from VW_RITCOBill where billno='" + bno + "' order by DocketDate";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GridView2.DataSource = dsxls2.Tables["xls2"];
        GridView2.DataBind();
        GridView2.FooterRow.Cells[10].Text = Convert.ToString(totqty2);
        GridView2.FooterRow.Cells[12].Text = Convert.ToString(totamt2);
        conn.Open();
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();

        SqlCommand cmd2 = new SqlCommand("select Convert(varchar,h.bgndt,106) as bgndt,ptmsnm,c.custnm as CustomerName,c.CustAddress as CustAddress,h.manualbillno as manualbillno,* from Webx_billmst h,webx_custhdr c where c.custcd=h.ptmscd and billno='" + bno + "'", conn);

        SqlDataReader dr2 = cmd2.ExecuteReader();
        if (dr2.Read())
        {
            
            lblBillNox.Text = bno;
            lblBillDt.Text = Convert.ToString(dr2["bgndt"]);
           
            lblCustName.Text = Convert.ToString(dr2["CustomerName"]);
            lblManualBillNo.Text = Convert.ToString(dr2["manualbillno"]);
            

        }
        dr2.Close();

        

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblbulk);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + iamegyrl + " />";
        //Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblbulk.Visible = false;
    }
    public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }


                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";

                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;

                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
    protected void dockdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.Pager)
        {
            if (Convert.ToString(Session["Client"]) == "EXL")
            {
                e.Row.Cells[10].Visible = false;
                e.Row.Cells[11].Visible = false;
                e.Row.Cells[13].Visible = false;
                e.Row.Cells[14].Visible = false;
            }
            else if (Convert.ToString(Session["Client"]) == "PRRL")
            {
                e.Row.Cells[10].Visible = false;
                e.Row.Cells[12].Visible = false;
                e.Row.Cells[13].Visible = false;
                e.Row.Cells[14].Visible = false;
            }
            //else if (Convert.ToString(Session["Client"]) == "RCI")
            //{
            //    e.Row.Cells[10].Visible = false;
            //    e.Row.Cells[11].Visible = false;
            //    e.Row.Cells[12].Visible = false;
            //}
            else if (Convert.ToString(Session["Client"]) == "UFL")
            {
                e.Row.Cells[10].Visible = false;
                e.Row.Cells[11].Visible = false;
                e.Row.Cells[12].Visible = false;
                e.Row.Cells[13].Visible = false;
            }
            else
            {
                e.Row.Cells[11].Visible = false;
                e.Row.Cells[12].Visible = false;
                e.Row.Cells[13].Visible = false;
                e.Row.Cells[14].Visible = false;
            }
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totqty1 = totqty1 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ChargeWeight") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "ChargeWeight"));
            totamt1 = totamt1 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "Amount"));
            Int64 amt1 = Convert.ToInt64(totamt1);
            RupeesToWords rupee = new RupeesToWords();
            lbl_Inwords.Text = Convert.ToString(rupee.NumberToText(amt1));
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totqty2 = totqty2 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ChargeWeight") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "ChargeWeight"));
            totamt2 = totamt2 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "Amount"));
            //lbl_Inwords.Text = Convert.ToString(totamt2);
            Int64 amt = Convert.ToInt64(totamt2);
            RupeesToWords rupee = new RupeesToWords();
            lbl_Inwords.Text = Convert.ToString(rupee.NumberToText(amt));

        }
    }
}
