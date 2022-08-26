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
public partial class GUI_admin_PinCodeMaster_FrmPincodeCriteria : System.Web.UI.Page
{
    SqlConnection cn;
    public static string mode, edstate, edcity, edpin;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            mode = edstate = edcity = edpin = "";
            if (Convert.ToString((Request.QueryString["md"])) == "edit")
            {
                mode = "edit";
            }
            else
            {
                mode = "add";
            }
            string sql = "select top 1 '--select one--' as stcd,'--select one--' as stnm union select distinct stcd,stnm from webx_state where activeflag='Y' order by stnm";
            SqlDataAdapter da = new SqlDataAdapter(sql, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "statetable");
            cmbstate.DataSource = ds.Tables["statetable"];
            cmbstate.DataTextField = "stnm";
            cmbstate.DataValueField = "stcd";
            cmbstate.DataBind();

            if (mode == "edit")
            {
                cmbstate.Text = edstate = Convert.ToString(Request.QueryString["stnm"]);
            }

            sql = "Select  top 1 '--select one--' as location union select location From webx_citymaster where state='" + cmbstate.Text + "'";
            da = new SqlDataAdapter(sql, cn);
            ds = new DataSet();
            da.Fill(ds, "citytable");
            cmbcity.DataSource = ds.Tables["citytable"];
            cmbcity.DataTextField = "location";
            cmbcity.DataValueField = "location";
            cmbcity.DataBind();

            if (mode == "edit")
            {
                cmbcity.Text = edcity = Convert.ToString(Request.QueryString["citynm"]);
                txtpincode.Text = edpin = Convert.ToString(Request.QueryString["pcode"]);
            }
        }

        btnSave.Attributes.Add("onclick", "return validatedata(" + cmbstate.ClientID + "," + cmbcity.ClientID + "," + txtpincode.ClientID + ")");
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("PinCodeListing.aspx");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (mode == "add")
        {
            SqlCommand cmd = new SqlCommand("Insert into webx_pincode_master values ('" + txtpincode.Text.Replace("'", "''") + "','" + cmbcity.Text + "','" + cmbstate.Text + "','" + Convert.ToString(Session["empcd"]) + "',getdate())", cn);
            cmd.ExecuteNonQuery();
        }
        else
        {
            SqlCommand cmd = new SqlCommand("update webx_pincode_master set pincode='" + txtpincode.Text.Replace("'", "''") + "',cityname='" + cmbcity.Text + "',stastename='" + cmbstate.Text + "',entryby='" + Convert.ToString(Session["empcd"]) + "',entrydt=getdate() where stastename='" + edstate + "' and cityname='" + edcity + "' and pincode='" + edpin + "'", cn);
            cmd.ExecuteNonQuery();
        }
        Response.Redirect("../company_structure.aspx");
    }
    protected void cmbstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = "Select  top 1 '--select one--' as location union select location From webx_citymaster where state='" + cmbstate.Text + "'";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "citytable");
        cmbcity.DataSource = ds.Tables["citytable"];
        cmbcity.DataTextField = "location";
        cmbcity.DataValueField = "location";
        cmbcity.DataBind();
    }
}
