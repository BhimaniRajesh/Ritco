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
        //Gets a New Contract ID for this Customer
        if (!IsPostBack)
        {
            string sql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='CMOD'";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            cmbcontractmode.DataSource = dt;
            cmbcontractmode.DataBind();
        }

        lblSelectedCustomer.InnerHtml = " " + custcode;
    }


    private string getContractID()
    {
        string sql = "SELECT contractid FROM webx_custcontract_hdr";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        string oldcnid = "";
        int ab = 0;
        int greatno = 0;
        while (dr.Read())
        {
            oldcnid = dr["contractid"].ToString();
            if (oldcnid.Length <= 3)
                continue;
            oldcnid = oldcnid.Substring(2, oldcnid.Length - 2);
            
            ab = Convert.ToInt16(oldcnid);
            if (greatno < ab)
            {
                greatno = ab;
            }
            
        }
        dr.Close();

        greatno = greatno + 1;
        string newcnid = "CN" + greatno.ToString().PadLeft(6, '0');

        return newcnid;
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        contractid = getContractID();
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

        string strSQL = "DELETE FROM webx_custcontract_hdr where custcode='" + custcode + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, con);
        sqlCommand.ExecuteNonQuery();

        strSQL = "INSERT INTO webx_custcontract_hdr (ContractId,Custcode,contractcat,custcat,contract_type," +
                         "contract_stdate,contract_eddate,contract_effectdate," +
                         "cust_represent,comp_empname,custdesig," +
                         "comp_desig,custwitness,comp_witness,bill_address," +
                         "bill_city,bill_pin,contract_sign_loccode," +
                         "entryby,entrydt,acc_rep,stax_yn,remarks,contractmode," 

                         + "custemail,custphone,accperemail,accperphone,custaccperson,compphone,compemail,"
        +"csename,csephone,cseemail) VALUES ("
        + "'" + contractid + "','" + custcode + "', '" + ddlcontractcategory.SelectedValue + "',"
        + "'" + ddlpartycategory.SelectedValue + "', '" + "" + "', '" + fn.Mydate(txtcontractdate.Text) + "', '" + fn.Mydate(txtvaliduntil.Text) + "', '" + fn.Mydate(txtefffromdate.Text) + "', "
        + "'" + txtcustomerrepresentative.Text + "','" + txtcoempname.Text + "','" + txtcustrepdesignation.Text + "',"
        + "'" + txtcoempdesignation.Text + "','" + txtcustwitness.Text + "','" + txtcowitness.Text + "','" + txtbillingaddress.Text + "',"
        + "'" + txtcity.Text + "'," + txtpincode.Text + ",'" + txtcontractsigninglocation.Text + "',"
        + "'" + Session["empcd"].ToString() + "','" + System.DateTime.Today.ToString("dd MMM yyyy") + "','" + txtaccountsrepresentative.Text + "','" + chkstaxappl + "','" + txtremarks.Text + "',"
        + "'" + cmbcontractmode.SelectedValue + "','"
        + txtcustemail.Text + "',"
        + txtcustphone.Text + ",'" + txtaccperemailid.Text + "'," + txtaccperphone.Text + ","
        + "'" + txtcustaccperson.Text + "',"
        + txtcompphone.Text + ",'" + txtcompemail.Text + "','" + txtcseperson.Text + "',"
        + txtcsephone.Text + ",'" + txtcseemail.Text + "')";

        sqlCommand = new SqlCommand(strSQL, con);
        sqlCommand.ExecuteNonQuery();


        //Redirect to step 2 screen
        Response.Redirect("AddCustomerContractStep2.aspx?custcode=" + custcode + "&contractid=" + contractid);
    }

   
}
