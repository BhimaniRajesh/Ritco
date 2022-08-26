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

public partial class GUI_Octroi_Octroi_Bill_AgentBill_ViewPrint : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public static int rowcnt;
    public static double octtot;
    string billno = "";
    SqlConnection con;
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        billno = Request.QueryString["billno"].ToString();
        Ptrinyn = Request.QueryString["printyn"].ToString();
        lblbillno.Text = billno;
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";
        if (Ptrinyn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }
        

       
        con.Open();
        string sqlqry = "SELECT distinct convert(varchar,ocbilldt,106) as ocbilldt,convert(varchar,ocduedt,106) as ocduedt,convert(varchar,ocagbilldt,106) as ocagbilldt,* FROM webx_oct_hdr a,webx_oct_det b WHERE a.ocbillno='" + billno + "' AND b.ocbillno='" + billno + "'";
        SqlCommand cmd = new SqlCommand(sqlqry);
        cmd.Connection = con;
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblbillno.Text = billno;
            
            
            lblbilldate.Text = dr["ocbilldt"].ToString();
            lblagent.Text = dr["ocagcd"].ToString() + " ~ " + dr["ocagnm"].ToString();
            lblagentbillno.Text = dr["ocagbillno"].ToString();
            lbloctroipaid.Text = dr["ocagoctamt"].ToString();
            lblagentbilldate.Text = dr["ocagbilldt"].ToString();
            lblagentserchrg.Text = dr["ocagserchrg"].ToString();
            lblserchrgper.Text = dr["servchargeper"].ToString();
            lblothchrg.Text = dr["ocagothchrg"].ToString();
            lblclearchrg.Text = dr["clearchrg"].ToString();
            lblformchrg.Text = dr["formchrg"].ToString();
            lblsundrychrg.Text = dr["sundrychrg"].ToString();
            lbltotdue.Text = dr["octotaldue"].ToString();
            lblduedate.Text = dr["ocduedt"].ToString();
            lblremark.Text = dr["remark"].ToString();
        }

        dr.Close();
        dataBind();
        con.Close();

    }
    protected void dataBind()
    {
        if(con.State==0)
        con.Open();
        string q2 = "select * from webx_oct_det where ocbillno='" + billno + "'";
        SqlCommand cmd1 = new SqlCommand(q2, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvagentbill.DataSource = ds;
        gvagentbill.DataBind();

        octtot = 0;
        int i = ds.Tables[0].Rows.Count;
        rowcnt = i;

        grrwocnt.Value = Convert.ToString(i);


        if (i > 0)
        {
            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                octtot += Convert.ToDouble(drRows["octamt"]);
            }
            if (gvagentbill.FooterRow != null)
            {
                gvagentbill.FooterRow.Cells[1].Text = "Total";
                gvagentbill.FooterRow.Cells[3].Text = Convert.ToString(octtot);
                gvagentbill.FooterRow.CssClass = "blackfnt";
                gvagentbill.FooterRow.BackColor = System.Drawing.Color.White;
                gvagentbill.FooterRow.HorizontalAlign = HorizontalAlign.Right;
            }
        }
        else
        {
            gvagentbill.CssClass = "redfnt";

        }
        con.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvagentbill.PageIndex = e.NewPageIndex;
        dataBind();
    }

    protected void gvagentbill_SelectedIndexChanged(object sender, EventArgs e)
    {

    }




    protected void gvagentbill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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

    }
}
