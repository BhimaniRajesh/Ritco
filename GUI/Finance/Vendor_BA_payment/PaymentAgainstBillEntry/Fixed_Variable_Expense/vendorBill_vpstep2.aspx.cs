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

public partial class VendorPayment_new_vendorBill_vpstep2 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    string strsession1, strsession2;
    string documenttype, vendortype, vendor,BillNo1, fromdate, todt, fromdate1, todt1;

    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;

    protected void Page_Load(object sender, EventArgs e)
    {
        documenttype = Request.QueryString.Get("documenttype");
        BillNo1 = Request.QueryString.Get("BillNo1");
        vendortype = Request.QueryString.Get("vendortype");
        vendor = Request.QueryString.Get("vendor");
        fromdate = Request.QueryString.Get("fromdate").ToString();
        todt = Request.QueryString.Get("todt").ToString();

        fromdate1 = fn.Mydate1(fromdate);
        todt1 = fn.Mydate1(todt);

        BindGrid();
    }

    private void BindGrid()
    {
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;

        if (BillNo1 == "" || BillNo1 == null)
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "WEBX_VENDORPAYMENT_SELECTBILL_M";

            cmd.Parameters.AddWithValue("@DATEFROM", fromdate1);
            cmd.Parameters.AddWithValue("@DATETO", todt1);
            //cmd.Parameters.AddWithValue("@VENDTYPE", vendortype);
            cmd.Parameters.AddWithValue("@VENDCD", vendor);
            cmd.Parameters.AddWithValue("@DOCTYPE", documenttype);

            if (documenttype == "THC")
            {
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

                DataSet ds = new DataSet();
                sqlDA.Fill(ds);
                //docdata.Visible = true;
                THCdata.DataSource = ds;
                //intTotalRecords = ds.Tables[0].Rows.Count;
                THCdata.DataBind();
                //Button1.Visible = true;

            }
            else
            {
                Response.Write("Hello");
                //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

                //DataSet ds = new DataSet();
                //sqlDA.Fill(ds);
                //PDC.Visible = true;
                //PDC.DataSource = ds;
                //intTotalRecords = ds.Tables[0].Rows.Count;
                //PDC.DataBind();
                //Button2.Visible = true;
            }




        }
        conn.Close();



    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }
}
