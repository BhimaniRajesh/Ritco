using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using Microsoft.ApplicationBlocks.Data;

public partial class Finance_Billing_Billcollection_billmr_step1 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Party_code;
    string orgncd;
  
    string billno;
    string fromdt;
    string Todt;
    string PAYBAS, manualbillno = "", BillColType="";

    string TRN_MOD;
    string sqlmain;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    string PTMSCD,PTMSNM;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");

        Party_code = Request.QueryString.Get("Party_code");
        PTMSCD = Request.QueryString.Get("Party_code");
        billno = Request.QueryString.Get("billno");
        fromdt = Request.QueryString.Get("fromtdate");
        Todt = Request.QueryString.Get("todate");
        PAYBAS = Request.QueryString.Get("paybas");
        manualbillno = Request.QueryString.Get("manualbillno");
        BillColType = Request.QueryString.Get("BillColType");

        if (!IsPostBack)
        {
            string fincmplbr;            
            if (billno != "")
            {
                string sql = "select PTMSCD,PTMSNM from webx_billmst where billno='" + billno + "'";
                DataTable PartyDtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
                if (PartyDtl.Rows.Count > 0)
                {
                    PTMSCD = PartyDtl.Rows[0]["PTMSCD"].ToString();
                    PTMSNM = PartyDtl.Rows[0]["PTMSNM"].ToString();
                }
            }
            if (manualbillno != "")
            {
                string sql = "select PTMSCD,PTMSNM from webx_billmst where manualbillno='" + manualbillno + "'";
                DataTable PartyDtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
                if (PartyDtl.Rows.Count > 0)
                {
                    PTMSCD = PartyDtl.Rows[0]["PTMSCD"].ToString();
                    PTMSNM = PartyDtl.Rows[0]["PTMSNM"].ToString();
                }
            }

            Hnd_PTMSCD.Value = PTMSCD;
            orgncd = "All";
            fincmplbr = Session["brcd"].ToString();            

            if (fromdt == "")
            {
                fromdt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (Todt == "")
            {
                Todt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (billno == "")
            {
                lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
                lblparty.Text = PTMSCD.ToString() + ":" + fn.Getcustomer(PTMSCD);
                if (PAYBAS == "1")
                {
                    lblpaybas.Text = "Paid Bill";// fn.Getpaybas(PAYBAS);
                }
                if (PAYBAS == "2")
                {
                    lblpaybas.Text = "TBB Bill";// fn.Getpaybas(PAYBAS);
                }
                else if (PAYBAS == "7")
                {
                    lblpaybas.Text = "Supplementary Bill";// fn.Getpaybas(PAYBAS);
                }
                else if (PAYBAS == "6")
                {
                    lblpaybas.Text = "Octroi Bill";
                }
                else if (PAYBAS == "15")
                {
                    lblpaybas.Text = "ALL Type Of Bills";
                }
                lblbillno.Text = "-";
            }
            else
            {
                lbldaterange.Text = "-";
                lblparty.Text = "-";
                lblpaybas.Text = "-";
                lblbillno.Text = billno.Trim();
            }
            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string fincmplbr;
        fincmplbr = SessionUtilities.CurrentBranchCode.ToString();
        string sql = "webx_BillCollection_Ver2";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;

        myAdapter.SelectCommand.Parameters.Add("@billno", SqlDbType.VarChar).Value = billno.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Party_code", SqlDbType.VarChar).Value = Party_code.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Billtype", SqlDbType.VarChar).Value = PAYBAS.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Todt", SqlDbType.DateTime).Value = Todt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = fincmplbr.Trim();
        myAdapter.SelectCommand.Parameters.Add("@manualbillno", SqlDbType.VarChar).Value = manualbillno.Trim();
        myAdapter.SelectCommand.Parameters.Add("@BillColType", SqlDbType.VarChar).Value = BillColType.Trim();
        
        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");
        intTotalRecords = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;

        dockdata.DataBind();
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        BindGrid();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string billno_nos = "";
        string billnonos = "";
        string docketlist = txtdocketlist.Value.ToString();
        string[] docketlist_arr;
        docketlist_arr = docketlist.Split(',');
        string checkeddockno = txtdocketlist_count.Value.ToString();
        int total_checked = Convert.ToInt32(checkeddockno);

        foreach (GridViewRow gridrow in dockdata.Rows)
        {   
            CheckBox chkDock = (CheckBox)gridrow.FindControl("chkDock");
            Label billno = (Label)gridrow.FindControl("billno");
            if (chkDock.Checked)
            {
                if (billnonos == "")
                {
                    billnonos = billno.Text.ToString();
                }
                else
                {
                    billnonos = billnonos + "," + billno.Text.ToString();
                }
            }
        }
        Session["billnonos"] = billnonos;
        Response.Redirect("billmr_step2.aspx?Party_code=" + Hnd_PTMSCD.Value + "&PAYBAS=" + PAYBAS + "&fromdt=" + fromdt + "&Todt=" + Todt + "&BillColType=" + BillColType);        
    }
    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
