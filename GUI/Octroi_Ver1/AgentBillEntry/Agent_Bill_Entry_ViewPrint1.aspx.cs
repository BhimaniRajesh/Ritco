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
using Microsoft.ApplicationBlocks.Data; 

public partial class GUI_Octroi_Ver1_AgentBillEntry_Agent_Bill_Entry_ViewPrint1 : System.Web.UI.Page
{
    public string BillNo = "", printyn = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        BillNo = Request.QueryString["billno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        string sqlHeader = "select OCBILLDT=convert(varchar,OCBILLDT,103), OCAGBILLDT = convert(varchar,OCAGBILLDT,103),OCDUEDT =convert(varchar,OCDUEDT,103),* from webx_oct_hdr where ocbillno = '" + BillNo + "'";
        SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlHeader);
        if (dr.Read())
        {
            lblOctAgent.Text = dr["OCAGNM"].ToString() + '~' + dr["OCAGCD"].ToString();
            lblbilldt.Text = dr["OCBILLDT"].ToString();
            lbloctamt.Text = dr["OCAGOCTAMT"].ToString();
            lblagntbillno.Text = dr["OCAGBILLNO"].ToString();
            lblagnttax.Text = dr["OCAGSERCHRG"].ToString();
            lblagntbilldt.Text = dr["OCAGBILLDT"].ToString();
            lblothrchg.Text = dr["OCAGOTHCHRG"].ToString();
            lblserchgper.Text = dr["servchargeper"].ToString();
            lblfrmcharg.Text = dr["formchrg"].ToString();
            lblclearchrg.Text = dr["clearchrg"].ToString();
            lblsundry.Text = dr["sundrychrg"].ToString();
            lbltotdue.Text = dr["NetAmt"].ToString();
            lblduedate.Text = dr["OCDUEDT"].ToString();
            dr.Close();
        }

        BindGridView();
    }

    public void BindGridView()
    {
        string sqlDetail = "select DOCKNO,OCTAMT,RECPTNO,RECPTDT=convert(varchar,RECPTDT,103) from webx_Oct_Det where OCBILLNO = '" + BillNo + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlDetail);
        gvAgentBillDetails.DataSource = ds;
        gvAgentBillDetails.DataBind();
    }

    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        gvAgentBillDetails.PageIndex = e.NewPageIndex;
        BindGridView();
    }
}
