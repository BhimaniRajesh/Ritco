using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Tyre_OldTyres_RemoldResult : System.Web.UI.Page
{
    string VendorID = "", FromDT = "", ToDT = "", RemoldID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        ////USP_GEN_REMOLD_BILLNO

        if (!IsPostBack)
        {
            tblTyreList.Visible = false;
            VendorID = Request.QueryString["VendorID"].Trim();
            FromDT = Request.QueryString["FromDT"].Trim();
            ToDT = Request.QueryString["ToDT"].Trim();
            RemoldID = Request.QueryString["RemoldID"].Trim();
            Bind_GV_Remold();
        }
    }
    protected void GV_TyreRemold_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlRemoldRej = (DropDownList)e.Row.FindControl("ddlRemoldRej");
            TextBox txtRemoldAmount = (TextBox)e.Row.FindControl("txtRemoldAmount");
            TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");

            ddlRemoldRej.Attributes.Add("OnChange", "javascript:OnAction();");
            //txtRemoldAmount.Attributes.Add("OnBlur", "javascript:FillPayment();");
        }
    }

    /// <summary>
    /// bind grid 1
    /// </summary>
    public void Bind_GV_Remold()
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
        CTIM.VendorCode = VendorID.Trim();
        CTIM.CLAIM_REMOLD_SALE_ID = RemoldID.Trim();
        CTIM.GetRemoldID_List(GV_Remold, FromDT, ToDT);
    }
    /// <summary>
    /// bind grid 2
    /// display list of tyres agaist Remold ID
    /// </summary>
    public void Bind_GV_TyreRemold(string Remold_ID)
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
        CTIM.VendorCode = VendorID.Trim();
        CTIM.CLAIM_REMOLD_SALE_ID = Remold_ID.Trim();
        CTIM.GetRemoldID_ListDtls(GV_TyreRemold);
    }

    /// <summary>  
    /// Display List of tyres for Remold
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LinkUpdateRemoldTyre(object sender, EventArgs e)
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        String Str = "";
        tblTyreList.Visible = true;
        LinkButton L1 = (LinkButton)sender;
        GridViewRow GR = L1.Parent.Parent as GridViewRow;

        LinkButton lnk_Update = (LinkButton)GR.FindControl("lnk_Update");
        HiddenField hdf_RemoldID = (HiddenField)GR.FindControl("hdf_RemoldID");
        lnk_Update.Enabled = false;
        Bind_GV_TyreRemold(hdf_RemoldID.Value);
    }
    /// <summary>
    /// Submit data & generate New Bill no.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Boolean IsCommited = false;
        string BRCD,Finyear,BILLNO="";
        BRCD=SessionUtilities.CurrentBranchCode.Trim();
        Finyear= SessionUtilities.FinYear.ToString().Trim();
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        
        //Generete system Bill no 

        CTIM.GENERATE_BILLNO(BRCD, Finyear);

        BILLNO = CTIM.BILL_NO;
        if (hdfNetAmt.Value != "") { CTIM.NetPay = Convert.ToDouble(hdfNetAmt.Value); } else { CTIM.NetPay = 0.00; }
        CTIM.company_code = SessionUtilities.DefaultCompanyCode.Trim();        

        foreach (GridViewRow gridrow in GV_TyreRemold.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtRemoldNo = gridrow.FindControl("txtRemoldNo") as TextBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtVendorNM = gridrow.FindControl("txtVendorNM") as TextBox;
            TextBox txtRemoldAmount = gridrow.FindControl("txtRemoldAmount") as TextBox;
            TextBox txtReason = gridrow.FindControl("txtReason") as TextBox;
            HiddenField hdf_SRNO = gridrow.FindControl("hdf_SRNO") as HiddenField;
            HiddenField hdfVendorCode = gridrow.FindControl("hdfVendorCode") as HiddenField;
            HiddenField hdfSysTyre_No = gridrow.FindControl("hdfSysTyre_No") as HiddenField;
            DropDownList ddlRemoldRej = gridrow.FindControl("ddlRemoldRej") as DropDownList;

            if (chkSelect.Checked)
            {
                CTIM.SR_NO = Convert.ToInt32(hdf_SRNO.Value);
                CTIM.TYRE_ID = txtSysTyreNo.Text.Trim(); //hdfSysTyre_No.Value.Trim();
                CTIM.CLAIM_REMOLD_SALE_ID = txtRemoldNo.Text.Trim();
                CTIM.VendorCode = hdfVendorCode.Value.Trim();
                if (txtRemoldAmount.Text != "")
                {
                    CTIM.REMOLD_AMT = Convert.ToDouble(txtRemoldAmount.Text.Trim());
                    CTIM.RMOLD_YN = "Y";
                }
                else
                {
                    CTIM.REMOLD_AMT = 0.00;
                    CTIM.RMOLD_YN = "N";
                }
                
                CTIM.R_REMARK = txtReason.Text.Trim();
                CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();
                CTIM.UPDATEDBY = SessionUtilities.CurrentEmployeeID.Trim();

                if (ddlRemoldRej.SelectedValue == "P") { CTIM.STATUS = "PASSED"; CTIM.RMOLD_YN = "Y"; }
                if (ddlRemoldRej.SelectedValue == "R") { CTIM.STATUS = "REJECTED"; CTIM.RMOLD_YN = "N"; }
                if (txtRemoldAmount.Text != "") { CTIM.REMOLD_AMT = Convert.ToDouble(txtRemoldAmount.Text); } else { CTIM.REMOLD_AMT = 0.00; }
                
                CTIM.UpdateTyre_RemoldPayment();
                IsCommited = true;
            }
        }
        //CTIM.INSERT_VENDOR_BILL();
        if (IsCommited)
        {
            btnSubmit.Enabled = false;
            Response.Redirect("Remold_Msg.aspx?RemoldID=" + CTIM.CLAIM_REMOLD_SALE_ID + "&BILLNO=" + CTIM.BILL_NO);
        }
    }
}