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

public partial class GUI_Octroi_ViewnPrint_VendorBill_xls : System.Web.UI.Page
{
    string remark = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        string billno=Request.QueryString["billno"].ToString();
        
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sql = "SELECT convert(varchar,billdt,106) as billdt,convert(varchar,vendorbilldt,106) as vendorbilldt,convert(varchar,duedt,106) as duedt,* FROM WEBX_vendorBill_hdr WHERE billno='" + billno + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblbillno.Text = dr["billno"].ToString();
            lblbilldate.Text = dr["billdt"].ToString();
            lblvendorname.Text = dr["vendorcode"].ToString() + " : " + dr["vendorname"].ToString();
            lblvendorbillno.Text = dr["vendorbillno"].ToString();
            lblvendorbilldate.Text = dr["vendorbilldt"].ToString();
            lblduedate.Text = dr["duedt"].ToString();
            lblcontractamt.Text = dr["pcamt"].ToString();
            lbladvancepaid.Text = dr["advamt"].ToString();
            lblotheramount.Text = dr["othamt"].ToString();
            lbldeduction.Text = dr["otherded"].ToString();
            lblsertaxchrg.Text = dr["svctax"].ToString();
            lblservtaxded.Text = dr["svctaxded"].ToString();
            lblcess.Text = dr["cessamt"].ToString();
            lbltdsded.Text = dr["tds"].ToString();
            lblnetpay.Text = dr["netamt"].ToString();
            remark = dr["remark"].ToString();
        }

        dr.Close();
        /*
                    GRID DATA FILLING
         
         */

        string q2 = "SELECT *,pcamt+othamt+svctax+cess-advpaid-othded-svctaxded-tdsded as netpay FROM webx_vendorbill_det WHERE billno='" + billno + "'";
        SqlCommand cmd1 = new SqlCommand(q2, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvvendorbillsummary.DataSource = ds;
        gvvendorbillsummary.DataBind();
        double contractamt = 0, otheramt = 0, sertax = 0, cess = 0, advpaid = 0, ded = 0, srvtaxded = 0, tdsded = 0, netpay = 0;
        int i = ds.Tables[0].Rows.Count;
        rowcnt = i;

        grrwocnt.Value = Convert.ToString(i);
        if (i >= 0)
        {
            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                contractamt=Convert.ToDouble(drRows["pcamt"]);
                otheramt += Convert.ToDouble(drRows["othamt"]);
                sertax += Convert.ToDouble(drRows["svctax"]);
                cess += Convert.ToDouble(drRows["cess"]);
                advpaid += Convert.ToDouble(drRows["advpaid"]);
                ded += Convert.ToDouble(drRows["othded"]);
                srvtaxded += Convert.ToDouble(drRows["svctaxded"]);
                tdsded += Convert.ToDouble(drRows["tdsded"]);
                netpay += Convert.ToDouble(drRows["netpay"]);
            }
            try
            {
                if (gvvendorbillsummary.FooterRow != null)
                {
                    gvvendorbillsummary.FooterRow.Cells[1].Text = "Total";
                    gvvendorbillsummary.FooterRow.Cells[2].Text = Convert.ToString(contractamt);
                    gvvendorbillsummary.FooterRow.Cells[3].Text = Convert.ToString(otheramt);
                    gvvendorbillsummary.FooterRow.Cells[4].Text = Convert.ToString(sertax);
                    gvvendorbillsummary.FooterRow.Cells[5].Text = Convert.ToString(cess);
                    gvvendorbillsummary.FooterRow.Cells[6].Text = Convert.ToString(advpaid);
                    gvvendorbillsummary.FooterRow.Cells[7].Text = Convert.ToString(ded);
                    gvvendorbillsummary.FooterRow.Cells[8].Text = Convert.ToString(srvtaxded);
                    gvvendorbillsummary.FooterRow.Cells[10].Text = Convert.ToString(tdsded);
                    gvvendorbillsummary.FooterRow.Cells[11].Text = Convert.ToString(netpay);

                    gvvendorbillsummary.FooterRow.CssClass = "blackfnt";
                    gvvendorbillsummary.FooterRow.BackColor = System.Drawing.Color.White;
                    gvvendorbillsummary.FooterRow.HorizontalAlign = HorizontalAlign.Right;
                }
            }
            catch (Exception exp)
            {
                Response.Write(exp.Message);
            }
        }
        else
        {
            gvvendorbillsummary.CssClass = "redfnt";
        }





        con.Close();
    }

    int rowcnt = 0;
    public void gvvendorbillsummary_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();

        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.CssClass = "bgbluegrey";

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            GridView oGridView = (GridView)sender;

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();


            oTableCell1 = new TableCell();
            oTableCell1.CssClass = "blackfnt";
            oTableCell1.Text = "Remarks";
            oTableCell1.HorizontalAlign = HorizontalAlign.Right;
            oTableCell1.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.CssClass = "blackfnt";
            oTableCell1.Text = remark;
            oTableCell1.HorizontalAlign = HorizontalAlign.Left;
            oTableCell1.ColumnSpan = 10;
            oGridViewRow1.Cells.Add(oTableCell1);


            oGridViewRow1.CssClass = "bgwhite";
            oGridView.Controls[0].Controls.AddAt(rowcnt + 3, oGridViewRow1);

            rowcnt = oGridView.Rows.Count;
            oGridView.Controls[0].Controls.AddAt(rowcnt + 1, oGridViewRow1);
        }
    }




    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvvendorbillsummary_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
