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

public partial class GUI_Octroi_Octroi_Bill_OctCustBill_viewPrint : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public   double octtot;
    public  int rowcnt;
    public  string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        string billno="";
       
        billno = Request.QueryString["billno"].ToString();
        Ptrinyn = Request.QueryString["printyn"].ToString();
        lblbillno.Text = billno;
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";
        if (Ptrinyn=="1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sqlqry = "SELECT convert(varchar,bgndt,106) as bgndt,convert(varchar,bduedt,106) as bduedt,* FROM webx_billmst WHERE billno='" + billno + "'";
        SqlCommand cmd = new SqlCommand(sqlqry);
        cmd.Connection = con;
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        
        while (dr.Read())
        {
            lblbilldate.Text = dr["bgndt"].ToString();
            lblpartyname.Text = dr["ptmscd"].ToString();// +"~" + fn.Getcustomer(dr["ptmscd"].ToString());
            lblgenloc.Text = dr["bbrcd"].ToString();// +"~" + fn.GetLocation(dr["bbrcd"].ToString());
            lblgenforloc.Text = dr["bbrcd"].ToString();// +"~" + fn.GetLocation(dr["bbrcd"].ToString());
            lblsubloc.Text = dr["billsubbrcd"].ToString();// +"~" + fn.GetLocation(dr["billsubbrcd"].ToString());
            lblcollectat.Text = dr["billcolbrcd"].ToString();// +"~" + fn.GetLocation(dr["billcolbrcd"].ToString()); 
            lblbillamt.Text=dr["billamt"].ToString();
            lblduedate.Text=dr["bduedt"].ToString();
            lblremark.Text= dr["remark"].ToString();
        }

        dr.Close();
        string q2 = "select distinct a.Dockno,a.DockSf,b.OCTAMT,a.OCT_SVCCHG,a.TOTAMT,a.declval,b.clearance_chrg,b.oct_percentage,b.process_chrg,b.OTCHG,b.RECPTNO,b.processing_per,convert(varchar,b.RECPTDT,106) as RECPTDT,orgncd=(select orgncd from webx_master_docket dkt where dkt.dockno=a.Dockno),destcd=(select destcd from webx_Master_docket dkt where dkt.dockno=a.Dockno) from  vw_billdet  a,webx_oct_det b where  a.dockno=b.dockno and a.billno=b.billno and a.billno='" + billno + "'";
        
        SqlCommand cmd1 = new SqlCommand(q2,con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds);
        docdata.DataSource = ds;
        docdata.DataBind();
        octtot=0;
        int i = ds.Tables[0].Rows.Count;
        rowcnt = i;

        grrwocnt.Value = Convert.ToString(i);
        if (i>= 0)
        {
            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                octtot += Convert.ToDouble(drRows["octamt"]);
            }
            try
            {
                if (docdata.FooterRow != null)
                {
                    docdata.FooterRow.Cells[1].Text = "Total";
                    docdata.FooterRow.Cells[4].Text = Convert.ToString(octtot);
                    docdata.FooterRow.CssClass = "blackfnt";
                    docdata.FooterRow.BackColor = System.Drawing.Color.White;
                    docdata.FooterRow.HorizontalAlign = HorizontalAlign.Right;
                }
            }
            catch (Exception exp)
            {
                Response.Write(exp.Message);
            }
        }
        else
        {
            docdata.CssClass = "redfnt";
            lblremark.Visible = false;
        }
         con.Close();

        }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void docdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
    public void GridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();

        if (e.Row.RowType == DataControlRowType.Header)
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
            oTableCell1.CssClass = "blackfnt";
            oTableCell1.Text = lblremark.Text;
            oTableCell1.HorizontalAlign = HorizontalAlign.Left;
            oTableCell1.ColumnSpan = 10;
            oGridViewRow1.Cells.Add(oTableCell1);
           
         
            oGridViewRow1.CssClass = "bgwhite";
            oGridView.Controls[0].Controls.AddAt(rowcnt + 3, oGridViewRow1);
           
            rowcnt = oGridView.Rows.Count;
            oGridView.Controls[0].Controls.AddAt(rowcnt+1, oGridViewRow1);
           
        }

    }
}
