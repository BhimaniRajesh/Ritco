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

public partial class GUI_Operation_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_RunSheetList : System.Web.UI.Page
{

    public static string Pdcty="",docno = "", manno = "", vehno = "", date1 = "", date2 = "", tp = "", sqlstr = "", advbal = "", RouteMode = "";
    protected string pdcnos = "";
    public int intTotalRecords;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        docno = Request.QueryString["docno"].ToString();
        manno = Request.QueryString["manno"].ToString();
        vehno = Request.QueryString["vehno"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        advbal = Request.QueryString["advbal"].ToString();
        Pdcty = Request.QueryString["Pdcty"].ToString();
        RouteMode = Request.QueryString.Get("RouteMode").ToString();
        tp = Request.QueryString["tp"].ToString();
        //Response.Write(tp);
        if (tp.CompareTo("0") == 0)
        {
            lbldates.Text = fn.Mydate(date1) + " ~ " + fn.Mydate(date2);
            trdates.Visible = true;
        }
        else if (tp.CompareTo("1") == 0)
        {
            lbldocno.Text = docno;
            trdocno.Visible = true;
        }
        else if (tp.CompareTo("2") == 0)
        {
            lblmanpdcno.Text = manno;
            trmanno.Visible = true;
        }
        else if (tp.CompareTo("3") == 0)
        {
            lblvehno.Text = vehno;
            trvehno.Visible = true;
        }
         string str_RouteMode = "";
        if (RouteMode == "All")
        {
            str_RouteMode = "and trn_mode in ('1','3','4')";
        }
        else if (RouteMode == "2")
        {
            str_RouteMode = "And trn_mode='2'";
        }
        if (Session["Client"].ToString() == "RCPL")
        {
                        str_RouteMode = "";
        }
       

        /* 
           *  0 for date
           *  1 for documnetno
           *  2 for manno 
           *  3 for vehno 
        */

        btnsubmit1.Attributes.Add("onclick", "return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        if (advbal == "A")
        {
            //sqlstr = "SELECT pdcno,pdcdt,CONVERT(VARCHAR,pdcdt,106) AS prs_drs,pdcbrstr=(select loccode  +  ' : ' +  locname from webx_location where loccode=a.pdcbr),";
            //sqlstr = sqlstr + "strba=(select vendorcode + ' : ' + vendorname from webx_VENDOR_HDR where  vendorcode=a.vendorcode),";
            //sqlstr = sqlstr + "vehno,pdc_status FROM webx_pdchdr a ";
            //sqlstr = sqlstr + "WHERE Pdcty='" + Pdcty + "' and (( finCmplbr='" + Session["brcd"].ToString() + "' ";
            //sqlstr = sqlstr + "AND (pdc_status='GE' OR pdc_status='OC'))) AND vendorBENo IS NULL   " + str_RouteMode + "  and bacode not in (select vendorcode from webx_VENDOR_HDR)";


            sqlstr = "SELECT pdcno,pdcdt,CONVERT(VARCHAR,pdcdt,106) AS prs_drs,pdcbrstr=(select loccode  +  ' : ' +  locname from webx_location where loccode=a.pdcbr),";
            sqlstr = sqlstr + "strba=(select vendorcode + ' : ' + vendorname from webx_VENDOR_HDR where  vendorcode=a.vendorcode),";
            sqlstr = sqlstr + "vehno,pdc_status FROM webx_pdchdr a ";
            sqlstr = sqlstr + "WHERE Pdcty='" + Pdcty + "' and (( finCmplbr='" + Session["brcd"].ToString() + "' ";
            sqlstr = sqlstr + "AND (pdc_status='GE' OR pdc_status='OC'))) AND vendorBENo IS NULL  and adv_voucherno is NULL and bacode not in (select vendorcode from webx_VENDOR_HDR) and (Cancelled='N' or Cancelled is NULL) ";


            if (tp.CompareTo("0") == 0)
            {
                sqlstr = sqlstr + "AND CONVERT(VARCHAR,pdcdt,106)  BETWEEN CONVERT(datetime,'" + fn.Mydate1(date1) + "',106) AND CONVERT(datetime,'" + fn.Mydate1(date2) + "',106)";
            }
            else if (tp.CompareTo("1") == 0)
            {
                //sqlstr = sqlstr + " AND pdcno IN ('" + docno + "')";
                sqlstr = sqlstr + " AND pdcno in ('" + docno.Replace(" ", "").Replace(",", "','") + "')";
            }
            else if (tp.CompareTo("2") == 0)
            {
                sqlstr = sqlstr + " AND manualpdcno IN ('" + manno + "')";
            }
            else if (tp.CompareTo("3") == 0)
            {
                sqlstr = sqlstr + " AND vehno IN ('" + vehno + "')";
            }
            sqlstr = sqlstr;
            //Response.Write(sqlstr);
            //Response.End();
        }
        else
        {
            //sqlstr = "SELECT pdcno,pdcdt,CONVERT(VARCHAR,pdcdt,106) AS prs_drs,pdcbrstr=(select loccode  +  ' : ' +  locname from webx_location where loccode=a.pdcbr),";
            //sqlstr = sqlstr + "strba=(select vendorcode + ' : ' + vendorname from webx_VENDOR_HDR where  vendorcode=a.vendorcode),";
            //sqlstr = sqlstr + "vehno,pdc_status FROM webx_pdchdr a ";
            //sqlstr = sqlstr + "WHERE  Pdcty='" + Pdcty + "' and  (( balamtbrcd='" + Session["brcd"].ToString() + "' AND pdc_status='AD')  ";
            //sqlstr = sqlstr + " ) and balamt>0 AND vendorBENo IS NULL    " + str_RouteMode + "  and bacode not in (select vendorcode from webx_VENDOR_HDR)";

            sqlstr = "SELECT pdcno,pdcdt,CONVERT(VARCHAR,pdcdt,106) AS prs_drs,pdcbrstr=(select loccode  +  ' : ' +  locname from webx_location where loccode=a.pdcbr),";
            sqlstr = sqlstr + "strba=(select vendorcode + ' : ' + vendorname from webx_VENDOR_HDR where  vendorcode=a.vendorcode),";
            sqlstr = sqlstr + "vehno,pdc_status FROM webx_pdchdr a ";
            sqlstr = sqlstr + "WHERE  Pdcty='" + Pdcty + "' and  (( balamtbrcd='" + Session["brcd"].ToString() + "' AND Bal_VoucherNO is NULL) ";
            sqlstr = sqlstr + " ) and balamt>0 AND vendorBENo IS NULL and bacode not in (select vendorcode from webx_VENDOR_HDR) and (Cancelled='N' or Cancelled is NULL)";


            if (tp.CompareTo("0") == 0)
                sqlstr = sqlstr + " AND CONVERT(VARCHAR,pdcdt,106)  BETWEEN CONVERT(datetime,'" + fn.Mydate1(date1) + "',106) AND CONVERT(datetime,'" + fn.Mydate1(date2) + "',106)";
            else if (tp.CompareTo("1") == 0)
                //sqlstr = sqlstr + " AND pdcno IN (" + numSplit(docno, ',') + ")";
                sqlstr = sqlstr + " AND pdcno in ('" + docno.Replace(" ", "").Replace(",", "','") + "')";
            else if (tp.CompareTo("2") == 0)
                sqlstr = sqlstr + " AND manualpdcno IN (" + numSplit(manno, ',') + ")";
            else if (tp.CompareTo("3") == 0)
                sqlstr = sqlstr + " AND vehno IN (" + numSplit(vehno, ',') + ") ";

            sqlstr = sqlstr;
            //Response.Write(sqlstr);
            //Response.End();
        }
       
            dataBind();
        
    }


    protected void dataBind()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmdoct = new SqlCommand(sqlstr);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

       // Response.Write("<br>sqlstr-" + sqlstr);
       // Response.End();
        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvpdclist.CssClass = "redfnt";
            gvpdclist.HorizontalAlign = HorizontalAlign.Center;
            gvpdclist.Visible = false;
            tblsubmit.Visible = false;
            tblgrid.Visible = true;
        }
        gvpdclist.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        gvpdclist.DataBind();

        con.Close();
    
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvpdclist.PageIndex = e.NewPageIndex;
        dataBind();
    }

    protected void gvpdclist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    { 
        //foreach(GridViewRow grv in gvpdclist.Rows)
        //{
        //    LinkButton lnk = ((LinkButton)(grv.FindControl("lnkid")));
        //    CheckBox chk = ((CheckBox)(grv.FindControl("chkyes")));

        //    //if (chk.Checked == true)
        //    //{
        //        if(pdcnos.CompareTo("")==0)
        //            pdcnos = pdcnos + lnk.Text;
        //        else
        //            pdcnos = pdcnos + "," + lnk.Text;
        //    //}
        //}

        string billno_nos = "";
        string billnonos = "";
        string docketlist = txtdocketlist.Value.ToString();
        string[] docketlist_arr;
        docketlist_arr = docketlist.Split(',');
        string checkeddockno = txtdocketlist_count.Value.ToString();
        int total_checked = Convert.ToInt16(docketlist);

        if (total_checked == 1)
        {
            string bill_no = docketlist;
            billno_nos = "'" + bill_no + "'";
            billnonos = bill_no;
        }
        else
        {

            for (int i = 0; i <= total_checked; i++)
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

        
        if(advbal.CompareTo("A")==0)
        {
            string final = "?billno_nos=" + billnonos;
            final += "&checkeddockno=" + checkeddockno;
            final += "&advbal=" + advbal;
            final += "&pdcnos=" + pdcnos;
            Response.Redirect("RunSheetAdvancePayment.aspx?advbal=" + final);
        }
        else if(advbal.CompareTo("B")==0)
        {
            string final = "?billno_nos=" + billnonos;
            final += "&checkeddockno=" + checkeddockno;
            final += "&advbal=" + advbal;
            final += "&pdcnos=" + pdcnos;
            Response.Redirect("RunSheetBalancePayment.aspx?advbal=" + final);
        }
    }


    protected string numSplit(string no,char sp)
    {

        string[] str = no.Split(sp);
        string retstr = "";
        for (int i = 0; i < str.Length; i++)
        {
            if (retstr.CompareTo("") == 0)
                retstr = retstr + "'" + str[i] + "'";
            else
                retstr = retstr + ",'" + str[i] + "'";

        }
        return retstr;
    }
}
