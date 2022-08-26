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

            string sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='TRN' AND statuscode='Y'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            cmbtransmode.DataSource = dt;
            cmbtransmode.DataBind();

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

                hdnchargecode.Value = Request.QueryString["chargecode"].ToString();
                hdnchargetype.Value = Request.QueryString["chargetype"].ToString();
                hdnbasedon.Value = Request.QueryString["basedon"].ToString();
                hdnbasecode.Value = Request.QueryString["basecode"].ToString();

                if (hdnchargetype.Value.CompareTo("BKG") == 0)
                    lblname.Text = "Booking Charges";
                else
                    lblname.Text = "Delivery Charges";

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
        if (hdnservicecode.Value.CompareTo("2.1") == 0)
        {
            if (txtfrom.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Please Enter From Location");
                return;
            }
            if (txtto.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Please Enter To Location");
                return;
            }
        }

        if (hdnservicecode.Value.CompareTo("1.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("SingleSlabSundryFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("1.2") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("MultipleSlabSundryFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("2.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text;
            Response.Redirect("FTLFreightMatrix.aspx?" + url);
        }
        else if (hdnservicecode.Value.CompareTo("3.1") == 0)
        {
            string url = "&custcode=" + hdncustcode.Value + "&contractid=" + hdncontractid.Value;
            url = url + "&matrixtype=" + cmbmatrixtype.SelectedValue + "&transmode=" + cmbtransmode.SelectedValue;
            url = url + "&from=" + txtfrom.Text + "&to=" + txtto.Text + "&chargecode=" + hdnchargecode.Value;
            url = url + "&chargetype=" + hdnchargetype.Value + "&basedon=" + hdnbasedon.Value;
            url = url + "&basecode=" + hdnbasecode.Value;
            Response.Redirect("CCMLocWiseOtherCharges.aspx?" + url);
        }

    }

}
