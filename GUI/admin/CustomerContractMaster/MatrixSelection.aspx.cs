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
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_AllTest_MatrixSelection : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdnservicecode.Value = Request.QueryString["servicecode"].ToString();

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Session Expired&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        cstheader.CustCode = hdncustcode.Value;
        cstheader.ContractID = hdncontractid.Value;

        if (!IsPostBack)
        {
            txtfrom.MaxLength = 50;
            txtto.MaxLength = 50;
            txtfrom.Width = 150;
            txtto.Width = 150;

            cmbtransmode.DataSource = DataProvider.GetActiveGeneralMaster("TRN");
            cmbtransmode.DataBind();

            hdnbasedon1.Value = DocketRules.GetDefaultValue("CHRG_RULE");
            if (hdnbasedon1.Value.CompareTo("NONE") == 0)
            {
                hdnbasedon2.Value = "NONE";
                ddlbasecode1.Items.Add(new ListItem("NONE", "NONE"));
                ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
            }
            else
            {
                ddlbasecode1.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon1.Value);
                ddlbasecode1.DataBind();
                trbasedon1.Style["display"] = "block";
                hdnbasedon2.Value = ChargeMasterController.GetChargeSubRule("DKT", hdnbasedon1.Value, ddlbasecode1.SelectedValue);
                if (hdnbasedon2.Value.CompareTo("NONE") == 0)
                {
                    ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
                    trbasedon2.Style["display"] = "none";
                }
                else
                {
                    trbasedon2.Style["display"] = "block";
                    ddlbasecode2.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon2.Value);
                    ddlbasecode2.DataBind();
                }
            }



            if (hdnservicecode.Value.CompareTo("1.1") == 0)
            {
                cmbtransmode.Items.Add(new ListItem("All", "A"));
                cmbtransmode.SelectedValue = "A";
                cmbtransmode.Enabled = false;
            }

            if (hdnservicecode.Value.CompareTo("1.1") == 0)
            {
                lblname.Text = "Sundry - Single Slab Matrix";
            }
            else if (hdnservicecode.Value.CompareTo("1.2") == 0)
            {
                lblname.Text = "Sundry - Multiple Slab Matrix";
            }
            else if (hdnservicecode.Value.CompareTo("2.1") == 0)
            {
                lblname.Text = "FTL Freight Matrix";
                txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'citytest')");
                txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'citytest')");
            }
            else if (hdnservicecode.Value.CompareTo("3.1") == 0)
            {
                trbasedon1.Style["display"] = "none";
                trbasedon2.Style["display"] = "none";
                hdnchargecode.Value = Request.QueryString["chargecode"].ToString();
                hdnchargetype.Value = Request.QueryString["chargetype"].ToString();
                hdnbasedon1.Value = Request.QueryString["basedon1"].ToString();
                hdnbasecode1.Value = Request.QueryString["basecode1"].ToString();
                hdnbasedon2.Value = Request.QueryString["basedon2"].ToString();
                hdnbasecode2.Value = Request.QueryString["basecode2"].ToString();

                lblname.Text = ChargeMasterController.GetChargeName("DKT", hdnchargecode.Value, hdnbasedon1.Value, hdnbasecode1.Value, hdnchargetype.Value);
                if (hdnchargetype.Value.CompareTo("BKG") == 0)
                    lblinstance.Text = "(Booking Charges)";
                else
                    lblinstance.Text = "(Delivery Charges)";

                lblfrom.Text = "From Location";
                lblto.Text = "To Location";
            }

            if (cmbmatrixtype.SelectedValue.CompareTo("C") == 0)
            {
                btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('city','" + txtfrom.ClientID.ToString() + "','none')");
                btnto.Attributes.Add("onclick", "javascript:return windowPopUp('city','" + txtto.ClientID.ToString() + "','none')");
            }
            else if (cmbmatrixtype.SelectedValue.CompareTo("L") == 0)
            {
                btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('branch','" + txtfrom.ClientID.ToString() + "','none')");
                btnto.Attributes.Add("onclick", "javascript:return windowPopUp('branch','" + txtto.ClientID.ToString() + "','none')");
            }
            else if (cmbmatrixtype.SelectedValue.CompareTo("R") == 0)
            {
                btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('zone','" + txtfrom.ClientID.ToString() + "','none')");
                btnto.Attributes.Add("onclick", "javascript:return windowPopUp('zone','" + txtto.ClientID.ToString() + "','none')");
            }
        }
    }

    protected void ddlbasecode1_SelectedIndexChanged(object sender, EventArgs e)
    {
        hdnbasedon2.Value = ChargeMasterController.GetChargeSubRule("DKT", hdnbasedon1.Value, ddlbasecode1.SelectedValue);
        if (hdnbasedon2.Value.CompareTo("NONE") == 0)
        {
            ddlbasecode2.Items.Clear();
            ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
            trbasedon2.Style["display"] = "none";
        }
        else
        {
            if (hdnservicecode.Value.CompareTo("2.1") != 0)
            {
                trbasedon2.Style["display"] = "block";
                ddlbasecode2.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon2.Value);
                ddlbasecode2.DataBind();
            }
        }
    }

    protected void cmbmatrixtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (hdnservicecode.Value.CompareTo("2.1") == 0)
        {
            if (cmbmatrixtype.SelectedValue.CompareTo("C") == 0)
            {
                txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'citytest')");
                txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'citytest')");
            }
            else if (cmbmatrixtype.SelectedValue.CompareTo("L") == 0)
            {
                txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'loctest')");
                txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'loctest')");
            }
            else if (cmbmatrixtype.SelectedValue.CompareTo("R") == 0)
            {
                txtfrom.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'zonetest')");
                txtto.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'zonetest')");
            }
        }
        else
        {
            txtfrom.Attributes.Add("onblur", "this.value=this.value.toUpperCase();");
            txtto.Attributes.Add("onblur", "this.value=this.value.toUpperCase();");
        }


        if (cmbmatrixtype.SelectedValue.CompareTo("C") == 0)
        {
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('city','" + txtfrom.ClientID.ToString() + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('city','" + txtto.ClientID.ToString() + "','none')");
        }
        else if (cmbmatrixtype.SelectedValue.CompareTo("L") == 0)
        {
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('branch','" + txtfrom.ClientID.ToString() + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('branch','" + txtto.ClientID.ToString() + "','none')");
        }
        else if (cmbmatrixtype.SelectedValue.CompareTo("R") == 0)
        {
            btnfrom.Attributes.Add("onclick", "javascript:return windowPopUp('zone','" + txtfrom.ClientID.ToString() + "','none')");
            btnto.Attributes.Add("onclick", "javascript:return windowPopUp('zone','" + txtto.ClientID.ToString() + "','none')");
        }
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        //if (hdnservicecode.Value.CompareTo("2.1") == 0)
        //{
        //    if (txtfrom.Text.CompareTo("") == 0)
        //    {
        //        Response.Redirect("ErrorPage.aspx?heading=Please Enter From Location");
        //        return;
        //    }
        //    if (txtto.Text.CompareTo("") == 0)
        //    {
        //        Response.Redirect("ErrorPage.aspx?heading=Please Enter To Location");
        //        return;
        //    }
        //}

        if (hdnservicecode.Value.CompareTo("1.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&basedon1=" + hdnbasedon1.Value + "&basecode1=" + ddlbasecode1.SelectedValue;
            url = url + "&basedon2=" + hdnbasedon2.Value + "&basecode2=" + ddlbasecode2.SelectedValue;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("SingleSlabSundryFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("1.2") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&basedon1=" + hdnbasedon1.Value + "&basecode1=" + ddlbasecode1.SelectedValue;
            url = url + "&basedon2=" + hdnbasedon2.Value + "&basecode2=" + ddlbasecode2.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("MultipleSlabSundryFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("2.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&basedon1=" + hdnbasedon1.Value + "&basecode1=" + ddlbasecode1.SelectedValue;
            url = url + "&basedon2=" + hdnbasedon2.Value + "&basecode2=" + ddlbasecode2.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("FTLFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("3.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&basedon1=" + hdnbasedon1.Value + "&basecode1=" + hdnbasecode1.Value;
            url = url + "&basedon2=" + hdnbasedon2.Value + "&basecode2=" + hdnbasecode2.Value;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text + "&chargecode=" + hdnchargecode.Value;
            url = url + "&chargetype=" + hdnchargetype.Value;
            if (lblname.Text == "Demurrage Charges")
            {
                Response.Redirect("DemurrageChargesMatrix.aspx?" + url);
            }
            else
            {
                Response.Redirect("CCMLocWiseOtherCharges.aspx?" + url);
            }
        }

    }

}
