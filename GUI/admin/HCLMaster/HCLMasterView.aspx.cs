using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_HCLMaster_HCLMasterView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {
            tblMain.Visible = false;
        }
        else
        {
            //tblMain.Visible = true;
        }
    }
    public void GetHCLData()
    {
        try
        {
            var branchcode = txtBranchcode.Text;
            var objHCLMasterController = new HCLMasterController();
            var ds = new DataSet();
            ds = objHCLMasterController.GetDataForHCLView(branchcode);

            if (ds.Tables[0].Rows.Count > 0)
            {
                tblMain.Visible = true;
                lblOutgoingTHCType.Text = Convert.ToString(ds.Tables[0].Rows[0]["OutgoingThcType"]);
                lblOutgoingTHCRate.Text = ds.Tables[0].Rows[0]["OutgoingThcRate"].ToString();
                lblOutgoingTHCFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["OutgoingThcFromDate"]).ToString("dd/MM/yyyy");
                lblOutgoingTHCToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["OutgoingThcToDate"]).ToString("dd/MM/yyyy");

                lblIncomingTHCType.Text = Convert.ToString(ds.Tables[0].Rows[0]["IncomingThcType"]);
                lblIncomingTHCRate.Text = ds.Tables[0].Rows[0]["IncomingThcRate"].ToString();
                lblIncomingTHCFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["IncomingThcFromDate"]).ToString("dd/MM/yyyy");
                lblIncomingTHCToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["IncomingThcToDate"]).ToString("dd/MM/yyyy");

                lblDDMRType.Text = Convert.ToString(ds.Tables[0].Rows[0]["DDMRType"]);
                lblDDMRRate.Text = ds.Tables[0].Rows[0]["DDMRRate"].ToString();
                lblDDMRFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DDMRFromDate"]).ToString("dd/MM/yyyy");
                lblDDMRToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DDMRToDate"]).ToString("dd/MM/yyyy");

                lblMRType.Text = Convert.ToString(ds.Tables[0].Rows[0]["MRType"]);
                lblMRRate.Text = ds.Tables[0].Rows[0]["MRRate"].ToString();
                lblMRFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["MRFromDate"]).ToString("dd/MM/yyyy");
                lblMRToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["MRToDate"]).ToString("dd/MM/yyyy");
            }
            else
            {
                tblMain.Visible = false;
                UserMessage.Show("No Records Found..");
            }
        }
        catch (Exception Ex)
        {
            throw Ex;
        }
    }
    protected void btnGetData_Click(object sender, EventArgs e)
    {
        if (txtBranchcode.Text == "")
        {
            UserMessage.Show("Please Enter Branch code.");
            tblMain.Visible = false;
        }
        else if (txtBranchcode.Text != "")
        {
            GetHCLData();
        }
    }

}