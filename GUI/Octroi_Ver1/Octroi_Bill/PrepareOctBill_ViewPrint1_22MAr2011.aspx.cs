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

public partial class GUI_Octroi_Ver1_Octroi_Bill_PrepareOctBill_ViewPrint1 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public string printyn = "", billno = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        billno = Request.QueryString["billno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        string sqlHeader = "SELECT convert(varchar,A.bgndt,103) as bgndt,convert(varchar,A.bduedt,103) as bduedt,isnull(B.custaddress,'') as custaddress ,isnull(B.telno,'') as telno,isnull(B.emailids,'') as emailids,A.*  FROM webx_billmst A inner join webx_Custhdr B on A.PTMSCD = B.Custcd WHERE billno='" + billno + "'";
        SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlHeader);
        if (dr.Read())
        {
            lblCustomer_Name.Text = dr["PTMSNM"].ToString() + '~' + dr["PTMSCD"].ToString();
            //lblCustomerType.Text = dr[""].ToString();
            lblbgndt.Text = dr["bgndt"].ToString();
            lblduedate.Text = dr["bduedt"].ToString();
            lblbillsubloc.Text = fn.GetLocation(dr["BILLSUBBRCD"].ToString()) + ' ' + dr["BILLSUBBRCD"].ToString();
            lblbillcolloc.Text = fn.GetLocation(dr["BILLCOLBRCD"].ToString()) + ' ' + dr["BILLCOLBRCD"].ToString();
            lblManualbillno.Text = dr["manualbillno"].ToString();
            lblRemark.Text = dr["REMARK"].ToString();
            lblbillamt.Text = dr["BILLAMT"].ToString();
            Lbl_Party_address.Text = dr["custaddress"].ToString();
            Lbl_Party_tellno.Text = dr["telno"].ToString();
            Lbl_Party_Email.Text = dr["emailids"].ToString();
        }

        BindGridView();
    }

    public void BindGridView()
    {
        string sqlDetail = "select Dockno,declval,OCT_AMT,oct_Percentage,clearance_chrg,processing_per,process_chrg,OTCHG,SVRCAMT,CESSAMT,Hedu_Cess,DKTTOT,OCT_RECEIPTNO,RECPTDT=convert(varchar,RECPTDT,103) from webx_billdet where Billno= '" + billno + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlDetail);
        gvOctroiDetails.DataSource = ds;
        Bind();
    }

    public void Bind()
    {
        string sql = "select * from webx_modules_rules where Rule_DESC = 'Service Tax For Octroi Bill' and Module_name = 'Prepare Octroi Bill'";
        SqlDataReader drRule = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
        if (drRule.Read())
        {
            string status = drRule["RULE_Y_N"].ToString();
            if (status == "N")
            {
                gvOctroiDetails.Columns[9].Visible = false;
                gvOctroiDetails.Columns[10].Visible = false;
                gvOctroiDetails.Columns[11].Visible = false;
                gvOctroiDetails.DataBind();
            }
            else
            {
                gvOctroiDetails.DataBind();
                gvOctroiDetails.Columns[9].Visible = true;
                gvOctroiDetails.Columns[10].Visible = true;
                gvOctroiDetails.Columns[11].Visible = true;
            }
        }
    }

    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        gvOctroiDetails.PageIndex = e.NewPageIndex;
        BindGridView();
    }
}
