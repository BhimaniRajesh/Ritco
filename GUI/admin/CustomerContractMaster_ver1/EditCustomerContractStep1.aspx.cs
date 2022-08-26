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

public partial class AddCustomerContractStep1 : System.Web.UI.Page
{
    int intRandomNo = 0;
    string contractid = "",custcode="";
    SqlConnection con;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        custcode = Request.QueryString["CustomerCode"];

        lblSelectedCustomer.InnerHtml = Request.QueryString["CustomerCodeName"].Replace("^|^", "&");

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (!IsPostBack)
        {


            string sql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='CMOD'";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            cmbcontractmode.DataSource = dt;
            cmbcontractmode.DataBind();

            sql = "SELECT convert(varchar,contract_stdate,103) AS contract_stdate,convert(varchar,contract_eddate,103) AS contract_eddate,convert(varchar,contract_effectdate,103) AS contract_effectdate,* FROM webx_custcontract_hdr WHERE custcode='" + custcode + "'";
            cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblContractID.InnerText = dr["contractid"].ToString();
                contractid = dr["contractid"].ToString();
                txtcontractdate.Text = dr["contract_stdate"].ToString();
                txtvaliduntil.Text = dr["contract_eddate"].ToString();
                txtefffromdate.Text = dr["contract_effectdate"].ToString();

                txtcontractsigninglocation.Text = dr["contract_sign_loccode"].ToString();
                txtcustomerrepresentative.Text = dr["cust_represent"].ToString();

                txtcoempname.Text = dr["comp_empname"].ToString();
                txtcustrepdesignation.Text = dr["custdesig"].ToString();
                txtcoempdesignation.Text = dr["comp_desig"].ToString();
                txtcustwitness.Text = dr["custwitness"].ToString();
                txtcowitness.Text = dr["comp_witness"].ToString();
                txtbillingaddress.Text = dr["bill_address"].ToString();
                txtcity.Text = dr["bill_city"].ToString();
                txtpincode.Text = dr["bill_pin"].ToString();
                if (txtpincode.Text.CompareTo("0") == 0)
                    txtpincode.Text = "";
                ddlpartycategory.SelectedValue = dr["custcat"].ToString();
                ddlcontractcategory.SelectedValue = dr["contractcat"].ToString();

                if (dr["stax_yn"].ToString().CompareTo("Y") == 0)
                    chkstapp.Checked = true;
                else
                    chkstapp.Checked = true;

                txtaccountsrepresentative.Text = dr["acc_rep"].ToString();
                txtremarks.Text = dr["remarks"].ToString();
                cmbcontractmode.SelectedValue = dr["contractmode"].ToString();

                txtcustemail.Text = dr["custemail"].ToString();
                txtcustphone.Text = dr["custphone"].ToString();
                txtaccperemailid.Text = dr["accperemail"].ToString();
                txtaccperphone.Text = dr["accperphone"].ToString();
                txtcustaccperson.Text = dr["custaccperson"].ToString();
                txtcompphone.Text = dr["compphone"].ToString();
                txtcompemail.Text = dr["compemail"].ToString();
                txtcseperson.Text = dr["csename"].ToString();
                txtcsephone.Text = dr["csephone"].ToString();
                txtcseemail.Text = dr["cseemail"].ToString();

              
            }
            dr.Close();

        } // IsPostBack












    }


    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string chkstaxappl = "";
        if (chkstapp.Checked == true)
            chkstaxappl = "Y";
        else
            chkstaxappl = "N";
        if (txtpincode.Text == "")
            txtpincode.Text= "0";

        if (txtcustphone.Text.CompareTo("") == 0)
            txtcustphone.Text = "0";

        if (txtcompphone.Text.CompareTo("") == 0)
            txtcompphone.Text = "0";

        if (txtaccperphone.Text.CompareTo("") == 0)
            txtaccperphone.Text = "0";

        if (txtcsephone.Text.CompareTo("") == 0)
            txtcsephone.Text = "0";

       

        string sql = "UPDATE webx_custcontract_hdr SET contract_stdate='" + fn.Mydate(txtcontractdate.Text) + "',";
        sql = sql + "contract_eddate='" + fn.Mydate(txtvaliduntil.Text) + "',";
        sql = sql + "contract_effectdate='" + fn.Mydate(txtefffromdate.Text) + "',";

        sql = sql + "contract_sign_loccode='" + txtcontractsigninglocation.Text + "',";
        sql = sql + "cust_represent='" + txtcustomerrepresentative.Text + "',";
        sql = sql + "acc_rep='" + txtaccountsrepresentative.Text + "',";
        sql = sql + "comp_empname='" + txtcoempname.Text + "',";
        sql = sql + "custdesig='" + txtcustrepdesignation.Text + "',";
        sql = sql + "comp_desig='" + txtcoempdesignation.Text + "',";
        sql = sql + "custwitness='" + txtcustwitness.Text + "',";
        sql = sql + "comp_witness='" + txtcowitness.Text + "',";
        sql = sql + "bill_address='" + txtbillingaddress.Text + "',";
        sql = sql + "bill_city='" + txtcity.Text + "',";
        sql = sql + "bill_pin=" + txtpincode.Text + ",";
        sql = sql + "custcat='" + ddlpartycategory.SelectedValue + "',";
        sql = sql + "contractcat='" + ddlcontractcategory.SelectedValue + "',";
        sql = sql + "remarks='" + txtremarks.Text + "',";
        sql = sql + "contractmode='" + cmbcontractmode.SelectedValue + "',";
        sql = sql + "lasteditby='" + Session["empcd"].ToString() + "',";
        sql = sql + "lasteditdate=getdate(),";

        sql = sql + "custemail='" + txtcustemail.Text + "',";
        sql = sql + "custphone=" + txtcustphone.Text + ",";
        sql = sql + "accperemail='" + txtaccperemailid.Text + "',";
        sql = sql + "accperphone=" + txtaccperphone.Text + ",";
        sql = sql + "custaccperson='" + txtcustaccperson.Text + "',";
        sql = sql + "compphone=" + txtcompphone.Text + ",";
        sql = sql + "compemail='" + txtcompemail.Text + "',";
        sql = sql + "csename='" + txtcseperson.Text + "',";
        sql = sql + "csephone=" + txtcsephone.Text + ",";
        sql = sql + "cseemail='" + txtcseemail.Text + "'";

        sql = sql + " WHERE custcode='" + custcode + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();

        //Redirect to step 2 screen
        Response.Redirect("EditCustomerContractStep2.aspx?custcode=" + custcode + "&contractid=" + contractid);
    }

   
}
