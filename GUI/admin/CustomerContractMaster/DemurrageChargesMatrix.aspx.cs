using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebX.Controllers;

public partial class GUI_admin_CustomerContractMaster_DemurrageChargesMatrix : System.Web.UI.Page
{
    protected DataTable dtddlProd
    {
        get { return ViewState["dtddlProd"] == null ? new DataTable() : ViewState["dtddlProd"] as DataTable; }
        set { ViewState["dtddlProd"] = value; }
    }
    static DataTable dtcharges;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        hdntransmode.Value = Request.QueryString["transmode"].ToString();
        hdnchargetype.Value = Request.QueryString["chargetype"].ToString();
        hdnbasedon1.Value = Request.QueryString["basedon1"].ToString();
        hdnbasecode1.Value = Request.QueryString["basecode1"].ToString();
        hdnbasedon2.Value = Request.QueryString["basedon2"].ToString();
        hdnbasecode2.Value = Request.QueryString["basecode2"].ToString();
        hdnfrom.Value = Request.QueryString["from"].ToString();
        hdnto.Value = Request.QueryString["to"].ToString();
        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();

        hdnchargecode.Value = Request.QueryString["chargecode"].ToString();
        hdnmatrixtype.Value = Request.QueryString["matrixtype"].ToString();

        lblchargename.Text = ChargeMasterController.GetChargeName("DKT", hdnchargecode.Value, hdnbasedon1.Value, hdnbasecode1.Value, hdnchargetype.Value);

        if (hdnchargetype.Value.CompareTo("BKG") == 0)
            lblinstance.Text = "(Booking Charge)";
        else
            lblinstance.Text = "(Delivery Charge)";
        lblfilterfrom.Text = hdnfrom.Value;
        lblfilterto.Text = hdnto.Value;
        if (hdnmatrixtype.Value.CompareTo("C") == 0)
            lblmatrixtype.Text = "City - City";
        else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            lblmatrixtype.Text = "Locaton - Location";
        else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            lblmatrixtype.Text = "Region - Region";

        lbltransmode.Text = fn.Gettrnmod(hdntransmode.Value);
        if (!IsPostBack)
        {
            DropDownList cmbprodtype = new DropDownList();
            DataTable dtprod = new DataTable();
            dtprod = DocketController.BindMaster("PROD", cmbprodtype);
            dtddlProd = dtprod;

            DataTable dt = new DataTable();


            dt.Columns.Add("Srno", typeof(string));
            dt.Columns.Add("FromLocation", typeof(string));
            dt.Columns.Add("ToLocation", typeof(string));
            dt.Columns.Add("ProductType", typeof(string));
            dt.Columns.Add("FreeStorageDay", typeof(string));
            dt.Columns.Add("Slab1", typeof(string));
            dt.Columns.Add("SlabRate1", typeof(string));
            dt.Columns.Add("Slab2", typeof(string));
            dt.Columns.Add("SlabRate2", typeof(string));
            dt.Columns.Add("Slab3", typeof(string));
            dt.Columns.Add("SlabRate3", typeof(string));
            dt.Columns.Add("RateType", typeof(string));
            dt.Columns.Add("DemurrageCalculationBasis", typeof(string));
            dt.Rows.Add();
            dtcharges = new DataTable();
            DemurrageChargesMatrixConroller ObjCharge = new DemurrageChargesMatrixConroller();
            dtcharges = ObjCharge.GetDemurrageChargeDetail(hdncontractid.Value, hdnbasecode1.Value, hdnfrom.Value, hdnto.Value, hdntransmode.Value, hdnmatrixtype.Value);
            if (dtcharges.Rows.Count > 0)
                grvcharges.DataSource = dtcharges;
            else
                grvcharges.DataSource = dt;

            grvcharges.DataBind();




        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        DemurrageChargesMatrixConroller ObjCharge = new DemurrageChargesMatrixConroller();
        DemurrageChargesMatrix ObjChargeMatrix = new DemurrageChargesMatrix();
         bool Flag =false;
        try
        { foreach (GridViewRow gvr in grvcharges.Rows)
        {
            CheckBox chkyes = (CheckBox)gvr.FindControl("chkyes");
            TextBox txtfrom=(TextBox)gvr.FindControl("txtfrom");
            TextBox txtto=(TextBox)gvr.FindControl("txtto");
            DropDownList ddlProductType=(DropDownList)gvr.FindControl("ddlProductType");
            TextBox txtFreeStorageDay=(TextBox)gvr.FindControl("txtFreeStorageDay");
            DropDownList ddlratetype=(DropDownList)gvr.FindControl("ddlratetype");
            DropDownList ddlCalculationBasis=(DropDownList)gvr.FindControl("ddlCalculationBasis");
           
            if (chkyes.Checked == true)
            {
                ObjChargeMatrix.ContractId = hdncontractid.Value;
                ObjChargeMatrix.FromLocation = txtfrom.Text;
                ObjChargeMatrix.ToLocation = txtto.Text;
                ObjChargeMatrix.TransMode = hdntransmode.Value;
                ObjChargeMatrix.BusinessType = hdnbasecode1.Value;
                ObjChargeMatrix.ProductType = ddlProductType.SelectedValue;
                ObjChargeMatrix.DemurrageCalculationBasis = ddlCalculationBasis.SelectedValue;
                ObjChargeMatrix.RateType = ddlratetype.SelectedValue;
                ObjChargeMatrix.FreeStorageDay = Convert.ToInt32(txtFreeStorageDay.Text);
                ObjChargeMatrix.EntryBy = SessionUtilities.CurrentEmployeeID;
                ObjChargeMatrix.MatrixType = hdnmatrixtype.Value;
                for (int i = 1; i <= 3; i++)
                {
                    
                    TextBox txtFromSlab = (TextBox)gvr.FindControl("txtFrom" + i);
                    TextBox txtToSlab = (TextBox)gvr.FindControl("txtTo" + i);
                    TextBox txtrate = (TextBox)gvr.FindControl("txtrate" + i);
                    DemurrageChargesMatrixSlab objSlab = new DemurrageChargesMatrixSlab();
                    objSlab.FromSlab = Convert.ToInt32(txtFromSlab.Text);
                    objSlab.ToSlab = Convert.ToInt32(txtToSlab.Text);
                    objSlab.Rate = Convert.ToDouble(txtrate.Text);
                    objSlab.SlabCode = "SLAB" + i;
                    ObjChargeMatrix.ListDetails.Add(objSlab);
                }
                Flag = ObjCharge.Insert(ObjChargeMatrix);
            }
        }
        //Flag = ObjCharge.Insert(ObjChargeMatrix);
        if (Flag)
        {
            Response.Redirect("CCM_DisplayResult.aspx?" + Request.QueryString.ToString());
        }
        else
        {
            MsgBox.Show("Record Is Not Inserted");
        }

        }
        catch (Exception ex)
        {

        }
    }
    protected void btnaddrows_Click(object sender, EventArgs e)
    {
        int rows = 0;
        try
        {
            rows = Convert.ToInt16(txtrows.Text);
        }
        catch (Exception ex)
        {

        }

        for (int i = 0; i < rows; i++)
        {
            dtcharges.Rows.Add();
        }

        grvcharges.DataSource = dtcharges;
        grvcharges.DataBind();

    }
    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            string loctype = "";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                loctype = "city";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                loctype = "branch";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                loctype = "zone";
            }

            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");

            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtfrom','grvcharges','4row')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','txtto','grvcharges','4row')");
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkyes");
            chk.Checked = true;

            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");

            DropDownList ddlProductType = (DropDownList)e.Row.FindControl("ddlProductType");
            ddlProductType.DataTextField = "codedesc";
            ddlProductType.DataValueField = "codeid";
            ddlProductType.DataSource = dtddlProd;
            ddlProductType.DataBind();
            ddlProductType.Items.Insert(0, new ListItem("ALL", "0"));
            try
            {
                ddlProductType.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ProductType"));
            }
            catch (Exception ex) { }
         
            DropDownList ddlratetype = (DropDownList)e.Row.FindControl("ddlratetype");
            try
            {
                ddlratetype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RateType"));
            }
            catch (Exception ex) { }

            DropDownList ddlCalculationBasis = (DropDownList)e.Row.FindControl("ddlCalculationBasis");
            try
            {
                ddlCalculationBasis.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DemurrageCalculationBasis"));
            }
            catch (Exception ex) { }
            for (int i = 1; i <= 3; i++)
            {

                TextBox txtFromSlab = (TextBox)e.Row.FindControl("txtFrom" + i);
                TextBox txtToSlab = (TextBox)e.Row.FindControl("txtTo" + i);
                TextBox txtrate = (TextBox)e.Row.FindControl("txtrate" + i);
                HiddenField hdnSrno = (HiddenField)e.Row.FindControl("hdnSrno");
                DemurrageChargesMatrixConroller objSlab = new DemurrageChargesMatrixConroller();
                DataTable dtSlab = new DataTable();
                if (hdnSrno.Value != "")
                {
                    dtSlab = objSlab.GetDemurrageChargeSlabDetail(Convert.ToInt32(hdnSrno.Value), "SLAB" + i);
                    txtFromSlab.Text = dtSlab.Rows[0]["FromSlab"].ToString();
                    txtToSlab.Text = dtSlab.Rows[0]["ToSlab"].ToString();
                    txtrate.Text = dtSlab.Rows[0]["RateAmount"].ToString();
                }
             
             
            }


            HtmlInputButton btnfrom = (HtmlInputButton)e.Row.FindControl("btnfrom");
            HtmlInputButton btnto = (HtmlInputButton)e.Row.FindControl("btnto");
            string testtype = "", loctype = "";
            if (hdnmatrixtype.Value.CompareTo("C") == 0)
            {
                testtype = "citytest"; loctype = "city";
            }
            else if (hdnmatrixtype.Value.CompareTo("L") == 0)
            {
                testtype = "loctest"; loctype = "branch";
            }
            else if (hdnmatrixtype.Value.CompareTo("R") == 0)
            {
                testtype = "zonetest"; loctype = "zone";
            }

            txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtfrom.ClientID.ToString() + "','none')");

            txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'" + testtype + "')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('" + loctype + "','" + txtto.ClientID.ToString() + "','none')");
        }
    }
}