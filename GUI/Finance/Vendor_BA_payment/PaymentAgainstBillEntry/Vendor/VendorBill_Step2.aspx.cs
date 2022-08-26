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

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_Vendor_VendorBill_Step2 : System.Web.UI.Page
{
    string documenttype, docno1, vendortype, vendor, fromdate, todt, fromdate1, todt1 ,RouteMode="";

    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;

    protected void Page_Load(object sender, EventArgs e)
    {
        //documenttype = Request.QueryString.Get("documenttype");
        //docno1 = Request.QueryString.Get("docno1");
        vendortype = Request.QueryString.Get("vendortype");
        vendor = Request.QueryString.Get("vendor");
        fromdate = Request.QueryString.Get("fromdate").ToString();
        todt = Request.QueryString.Get("todt").ToString();
        RouteMode = Request.QueryString.Get("RouteMode").ToString();
        fromdate1 = fn.Mydate1(fromdate);
        todt1 = fn.Mydate1(todt);

        Button1.Attributes.Add("onclick", "javascript:CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        //Button2.Attributes.Add("onclick", "javascript:CheckPDCSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");

        //if (docno1 == "" || docno1 == null)
        //{
            lblDocDate.Text = fromdate1.Trim() + "-" + todt1.Trim();
            lblVendor.Text = fn.GetVendor(vendor);
            lblVendorType.Text = fn.GetVendorType(vendortype);
            //lblDocNo.Text = "All";
            //lblDocType.Text = documenttype;
        //}
        //else
        //{
        //    lblDocDate.Text = "-";
        //    lblDocNo.Text = docno1.ToString();

        //}
        BindGrid();

    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;

        //if (docno1 == "" || docno1 == null)
        //{
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "WEBX_vendorpayment_selectdoc_m";

            cmd.Parameters.AddWithValue("@DATEFROM", fromdate1);
            cmd.Parameters.AddWithValue("@DATETO", todt1);
            cmd.Parameters.AddWithValue("@VENDTYPE", vendortype);
            cmd.Parameters.AddWithValue("@VENDCD", vendor);
            cmd.Parameters.AddWithValue("@DOCTYPE", "THC");
            cmd.Parameters.AddWithValue("@rut_cat", RouteMode);
            cmd.Parameters.AddWithValue("@Balamtbrcd", Session["brcd"].ToString());
            //if (documenttype == "THC")
            //{
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

                DataSet ds = new DataSet();
                sqlDA.Fill(ds);
                docdata.Visible = true;
                docdata.DataSource = ds;
                intTotalRecords = ds.Tables[0].Rows.Count;
                docdata.DataBind();
                Button1.Visible = true;

            //}
            //else
            //{
            //    SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            //    DataSet ds = new DataSet();
            //    sqlDA.Fill(ds);
            //    PDC.Visible = true;
            //    PDC.DataSource = ds;
            //    intTotalRecords = ds.Tables[0].Rows.Count;
            //    PDC.DataBind();
            //    Button2.Visible = true;
            //}

        //}
        conn.Close();

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }
    protected void docdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string billno_nos = "";
        string billnonos = "";
        string docketlist = txtdocketlist.Value.ToString();
        //Response.Write(docketlist);
        //Response.End();
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

        //string final = "?billno_nos=" + billnonos;
        string final = "?checkeddockno=" + checkeddockno;
        final += "&vendortype=" + vendortype;
        final += "&vendor=" + vendor;
        final += "&fromdate=" + fromdate;
        final += "&todt=" + todt;
        final += "&documenttype=" + documenttype;
        final += "&RouteMode=" + RouteMode;
        Response.Redirect("vendorBill_step3.aspx" + final);


    }

    //protected void Button2_Click(object sender, EventArgs e)
    //{
    //    string billno_nos = "";
    //    string billnonos = "";
    //    string docketlist = txtdocketlist.Value.ToString();
    //    string[] docketlist_arr;
    //    docketlist_arr = docketlist.Split(',');
    //    string checkeddockno = txtdocketlist_count.Value.ToString();
    //    int total_checked = Convert.ToInt16(docketlist);

    //    if (total_checked == 1)
    //    {
    //        string bill_no = docketlist;
    //        billno_nos = "'" + bill_no + "'";
    //        billnonos = bill_no;
    //    }
    //    else
    //    {

    //        for (int i = 0; i <= total_checked; i++)
    //        {
    //            string bill_no = docketlist_arr[i].ToString();
    //            if (billno_nos == "")
    //            {
    //                billno_nos = "'" + bill_no + "'";
    //                billnonos = bill_no;
    //            }
    //            else
    //            {
    //                billno_nos = billno_nos + "," + "'" + bill_no + "'";
    //                billnonos = billnonos + "," + bill_no;
    //            }

    //        }
    //    }

    //    string final = "?billno_nos=" + billnonos;
    //    final += "&checkeddockno=" + checkeddockno;
    //    final += "&vendortype=" + vendortype;
    //    final += "&vendor=" + vendor;
    //    final += "&fromdate=" + fromdate;
    //    final += "&todt=" + todt;
    //    final += "&documenttype=" + documenttype;
    //    Response.Redirect("vendorBill_step3.aspx" + final);
    //}
}
