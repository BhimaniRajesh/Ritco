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

public partial class Octroi_Agent_Voucher_Result_Page : System.Web.UI.Page
{
    string Agent, AgentBill, BillEntry, AgentCode;
    DateTime From = new DateTime();
    DateTime To = new DateTime();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yyyy");
            lblDtTo.Text = To.ToString("dd MMM yyyy");
            AgentCode = Request.QueryString["AgentCode"];
            Agent = Request.QueryString["Agent"];
            if (Agent != "" && Agent != null)
            {
                lblBillType.Text = "Octroi Agent ";
                lblAgeType.Text = Agent;
            }
            AgentBill = Request.QueryString["AgentBill"];
            if (AgentBill != "" && AgentBill != null)
            {
                lblBillType.Text = "Agent Bill No ";
                lblAgeType.Text = AgentBill;
            }
            BillEntry = Request.QueryString["BillEntry"];
            if (BillEntry != "" && BillEntry != null)
            {
                lblBillType.Text = "Bill Entry No ";
                lblAgeType.Text = BillEntry;
            }
            BindGrid();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvAgentVoucher.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select ocbillno,ocagbillno,convert(varchar,OCBILLDT,106) as entrydt,ocagcd +' : '+ocagnm as Name,octotaldue,convert(varchar,ocduedt,106)as ocduedt from webx_oct_hdr where ocbilldt between '" + lblDtFrom.Text + "' and '" + lblDtTo.Text + "' and  voucherNo is null and ocbrcd='" + Session["brcd"] + "' and cancel_yn<>'Y'";
        if (Agent != "" && Agent != null)
        {
            sql = "select ocbillno,ocagbillno,convert(varchar,OCBILLDT,106) as entrydt,ocagcd +' : '+ocagnm as Name,octotaldue,convert(varchar,ocduedt,106)as ocduedt from webx_oct_hdr where ocbilldt between '" + lblDtFrom.Text + "' and '" + lblDtTo.Text + "' and ocagcd='" + AgentCode.ToString().Trim() + "' and voucherNo is null and cancel_yn<>'Y'";
        }
        if (AgentBill != "" && AgentBill != null)
        {
            sql = "select ocbillno,ocagbillno,convert(varchar,OCBILLDT,106) as entrydt,ocagcd +' : '+ocagnm as Name,octotaldue,convert(varchar,ocduedt,106)as ocduedt from webx_oct_hdr where ocbilldt between '" + lblDtFrom.Text + "' and '" + lblDtTo.Text + "' and ocagbillno='" + AgentBill.ToString().Trim() + "' and voucherNo is null and ocbrcd='" + Session["brcd"] + "' and cancel_yn<>'Y' ";
        }
        if (BillEntry != "" && BillEntry != null)
        {
            sql = "select ocbillno,ocagbillno,convert(varchar,OCBILLDT,106) as entrydt,ocagcd +' : '+ocagnm as Name,octotaldue,convert(varchar,ocduedt,106)as ocduedt from webx_oct_hdr where ocbilldt between '" + lblDtFrom.Text + "' and '" + lblDtTo.Text + "' and ocbillno='" + BillEntry.ToString().Trim() + "' and voucherNo is null and ocbrcd='" + Session["brcd"] + "' and cancel_yn<>'Y'";
        }

        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        gvAgentVoucher.DataSource = dv;
        gvAgentVoucher.DataBind();
        conn.Close();
    }
    protected void HeaderChecked(object sender, EventArgs e)
    {
        Int32 i;
        i = 0;            
        CheckBox AgentCh = ((CheckBox)gvAgentVoucher.HeaderRow.FindControl("HeaderLevelCheckBox"));
        
        if (AgentCh.Checked == true)
        {
            foreach (GridViewRow datarow in gvAgentVoucher.Rows)
            {
                gvAgentVoucher.SelectedIndex = i;
                CheckBox AgeChecked = ((CheckBox)gvAgentVoucher.SelectedRow.FindControl("RowLevelCheckBox"));
                AgeChecked.Checked = true;
                i += 1;
            }
        }
        else if (AgentCh.Checked == false)
        {
            foreach (GridViewRow datarow in gvAgentVoucher.Rows)
            {
                gvAgentVoucher.SelectedIndex = i;
                CheckBox AgeChecked = ((CheckBox)gvAgentVoucher.SelectedRow.FindControl("RowLevelCheckBox"));
                AgeChecked.Checked = false;
                i += 1;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
        string BillEntry = "";
        int i = 0;
        
            foreach (GridViewRow datarow in gvAgentVoucher.Rows)
            {

                CheckBox AgeChecked = ((CheckBox)datarow.FindControl("RowLevelCheckBox"));
                if (AgeChecked.Checked == true)
                {
                    gvAgentVoucher.SelectedIndex = datarow.RowIndex;
                    Label BillNo = ((Label)gvAgentVoucher.SelectedRow.FindControl("lblBillEntry"));
                    
                    if (BillEntry == "")
                    {
                        BillEntry = "'" + BillNo.Text + "'";
                    }
                    else
                    {
                        BillEntry = BillEntry + ",'" + BillNo.Text + "'";
                    }                   
                }                
            }
            Response.Redirect("Result_Sub_Page.aspx?BillEntry=" + BillEntry + "&BillType=" + lblBillType.Text + "&AgentType=" + lblAgeType.Text + "&FromDt=" + lblDtFrom.Text + "&ToDt=" + lblDtTo.Text);
    }
}
