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

public partial class GUI_Octroi_ViewnPrint_VendorPayment_viewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string vno="";
        
        string billno=Request.QueryString["billno"].ToString();

        string sqlqry = "SELECT billno,vendorname,voucherno,acccode,accdesc,vendorbillno,pcamt,convert(varchar,duedt,106) as duedt,refno,remark,deduction_chrg,discount,servicetaxrate,svctax,othertax,othertaxrate,tds,tdsrate,netamt,convert(varchar,vendorbilldt,106) as vendorbilldt,convert(varchar,entrydt,106) as entrydt FROM webx_vendorbill_hdr where billno='" + billno + "'";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd = new SqlCommand(sqlqry, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblbillno.Text = dr["billno"].ToString();
            lblentrydt.Text = dr["entrydt"].ToString();
            lblvendorname.Text = dr["vendorname"].ToString();
            lblvendoraccto.Text = dr["acccode"].ToString() + " : " +  dr["accdesc"].ToString();
            lblvendorbillno.Text = dr["vendorbillno"].ToString();
            lblvendorbillamt.Text = dr["pcamt"].ToString();
            lblvendorbilldate.Text=dr["vendorbilldt"].ToString();
            lblduedate.Text = dr["duedt"].ToString();
            lblrefno.Text = dr["refno"].ToString();
            lblremark.Text = dr["remark"].ToString();
            lblothded.Text = dr["deduction_chrg"].ToString();
            lbldiscrec.Text = dr["discount"].ToString();
            double sum = 0;
            string a, b, c;
            a = dr["pcamt"].ToString();
            b = dr["deduction_chrg"].ToString();
            c = dr["discount"].ToString();
            //sum = Convert.ToDouble(dr["pcamt"].ToString()) - Convert.ToDouble(dr["deduction_chrg"].ToString()) - Convert.ToDouble(dr["discount"].ToString());
            lblnetamt.Text = sum.ToString();


            lblsertax.Text = dr["servicetaxrate"].ToString();
            lblsertaxcenvet.Text = dr["svctax"].ToString();
            lbleducess.Text = dr["othertaxrate"].ToString();
            lblcessnoth.Text = dr["othertax"].ToString();
            lbltds.Text = dr["tdsrate"].ToString();
            lbltdscontract.Text = dr["tds"].ToString();
            lblnetpay.Text = dr["netamt"].ToString();
            vno=dr["voucherno"].ToString();

         

        }
        dr.Close();
        string sql2 = "SELECT acccode,accdesc,narration,debit FROM webx_vendorbill_det WHERE voucherno='" + vno + "'";
        SqlCommand cmdacchead = new SqlCommand(sql2, con);
        SqlDataReader dr2;
        dr2=cmdacchead.ExecuteReader();

        while(dr2.Read())
        {
            lblacchead.Text=dr2["acccode"].ToString() + " : " + dr2["accdesc"].ToString();
            lbldebit.Text=dr2["debit"].ToString();
            lblnarraion.Text=dr2["narration"].ToString();
        }
        dr2.Close();
        con.Close();

    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvvendorlist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void gvvendorlist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       /* if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.CssClass = bgbluegrey;

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
            oTableCell1.Text = lblremark.Text;
            oTableCell1.HorizontalAlign = HorizontalAlign.Left;
            oTableCell1.ColumnSpan = 10;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oGridViewRow1.CssClass = "bgwhite";
            //oGridView.Controls[0].Controls.AddAt(rowcnt + 3, oGridViewRow1);

            rowcnt = oGridView.Rows.Count;
            oGridView.Controls[0].Controls.AddAt(rowcnt + 2, oGridViewRow1);

        }
*/
    }
    
}
