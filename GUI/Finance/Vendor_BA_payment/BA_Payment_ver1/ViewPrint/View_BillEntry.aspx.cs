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
using System.IO;

public partial class GUI_Finance_Vendor_BA_payment_BA_Payment_ViewPrint_View_BillEntry : System.Web.UI.Page
{
    string BillNo, strqry, strManifestquery;
    SqlConnection conn;
    public static string st_rutcd,dtyp="", st_rutcat, st_thcno, lng, THC_Detail, strqry_remarks;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        BillNo = Request.QueryString["BillNo"];
        string[] Split = BillNo.Split(new Char[] { ',' });
        BillNo = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        BindGrid();
        strqry = "select doctype=(select top 1 (case  when doctype='DLY' then 'Delivery'  when doctype='BKG' then 'Booking' end) from webx_bapayment_docket  b with(NOLOCK) where beno=a.billno),billno,billdt=convert(varchar,paydt,6),vendor=vendorcode+' : '+vendorname,vendorbillno,Vendbilldt=convert(varchar,billdt,6),totcommision=pcamt,tdsacccode,servicetaxrate,svctax,cessamt,othamt,tdsrate,otherded,TDS,netamt,TDSDEDFOR=(case when tdsfor='NC' then 'NON Corporate' else 'Corporate' end),remark from WEBX_VENDORBILL_HDR a with(NOLOCK) where billno='" + BillNo + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, conn);
        
        conn.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblBillno.Text = Convert.ToString(dr["billno"]);
            transdate.Text = Convert.ToString(dr["billdt"]);
            vendorname.Text = Convert.ToString(dr["vendor"]);
            vendorbillno.Text = Convert.ToString(dr["vendorbillno"]);
            vendorbilldt.Text = Convert.ToString(dr["Vendbilldt"]);
            //duedt.Text = Convert.ToString(dr[""]);
            txtNetCommission.Text = Convert.ToString(dr["totcommision"]);
            lblTDSType.Text = Convert.ToString(dr["tdsacccode"]);
            svtax_rate.Text = Convert.ToString(dr["servicetaxrate"]);
            lblTDSDeductedFor.Text = Convert.ToString(dr["TDSDEDFOR"]);
            svrcamt.Text = Convert.ToString(dr["svctax"]);
            cessamt.Text = Convert.ToString(dr["cessamt"]);
            oth_amt.Text = Convert.ToString(dr["othamt"]);
            tds_rate.Text = Convert.ToString(dr["tdsrate"]);
            oth_ded.Text = Convert.ToString(dr["otherded"]);
            tds_chrg.Text = Convert.ToString(dr["TDS"]);
            TotalNetpayable.Text = Convert.ToString(dr["netamt"]);
            txtremarks.Text = Convert.ToString(dr["remark"]);
            Label18.Text = Convert.ToString(dr["doctype"]);
            dtyp = Convert.ToString(dr["doctype"]);
        }
        dr.Close();
        conn.Close();
        
    }
    private void BindGrid()
    {
        conn.Open();
        string str = "select distinct d.docno,d.docsf,origin=(select top 1 loccode +' : '+locname from webx_location where loccode=orgncd),desination=(select top 1 loccode +' : '+locname from webx_location where loccode=destcd),paybas=(select top 1 codedesc from webx_master_general where codetype='PAYTYP' and codeid=D1.paybas),mode=(select top 1 codedesc from webx_master_general where codetype='TRN' and codeid=D1.trn_mod),dockdt=convert(varchar,dockdt,6),pkgsno,actuwt,subtotal,stax_cess_hcess=(isnull(D2.svctax,0)+isnull(D2.cess,0)+isnull(D2.hedu_cess,0)),slabrate,pcamt,cast(isnull(d3.commission ,0) as decimal(9,2)) as commission from WEBX_VENDORBILL_det d with(NOLOCK) inner join webx_master_docket D1 with(NOLOCK) on d.docno=d1.dockno inner join webx_master_docket_charges D2 with(NOLOCK) on d.docno=d2.dockno inner join webx_bapayment_docket D3 with(NOLOCK) on d.docno=d3.dockno where billno='" + BillNo + "' and   doctype=(select distinct doctype from webx_bapayment_docket where beno='" + BillNo + "')";
        SqlCommand sqlcmd = new SqlCommand(str, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        conn.Close();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            Label lblColname = (Label)e.Row.FindControl("lblColname");

           // dkt_colname.Text = dkt_call + " No.";
            ///lblColDockdt.Text = dkt_call + " Date";
            if(dtyp=="Delivery")
            {
                lblColname.Text = "Delivery Expenses";
            }
            if (dtyp == "Booking")
            {
                lblColname.Text = "PickUp Expenses";
            }
                
           
        }
    }

    protected void btnDwnXLS_Click(object sender, EventArgs e)
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;
        dgDocket.Font.Name = "Verdana";

        btnDwnXLS.Visible = false;
        Table3.Border = 1;
       

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BillEntry.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(tblMain);
        frm.Controls.Add(dgDocket);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
}
