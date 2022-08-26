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

public partial class GUI_admin_AllTest_MultipleSlabSundryRange : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        MyFunctions fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToString();
        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        lblcontractid.Text = hdncontractid.Value;
        lblcustcodename.Text = hdncustcode.Value + " : " + fn.Getcustomer(hdncustcode.Value);

        if (!IsPostBack)
        {
            string strsql = "";

            SqlCommand cmd;
            strsql = "SELECT contract_type FROM webx_custcontract_hdr WHERE contractid='" + hdncontracttype.Value + "'";
            cmd = new SqlCommand(strsql, con);
            hdncontracttype.Value = Convert.ToString(cmd.ExecuteScalar());

            strsql = "SELECT slab_code,slab_from,slab_to,matrix_type FROM webx_custcontract_frtmatrix_slabhdr ";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "' ORDER BY srno";
            cmd = new SqlCommand(strsql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB1") == 0)
                {
                    txtfrom1.Text = dr["slab_from"].ToString();
                    txtto1.Text = dr["slab_to"].ToString();
                    cmbratetype1.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB2") == 0)
                {
                    txtfrom2.Text = dr["slab_from"].ToString();
                    txtto2.Text = dr["slab_to"].ToString();
                    cmbratetype2.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB3") == 0)
                {
                    txtfrom3.Text = dr["slab_from"].ToString();
                    txtto3.Text = dr["slab_to"].ToString();
                    cmbratetype3.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB4") == 0)
                {
                    txtfrom4.Text = dr["slab_from"].ToString();
                    txtto4.Text = dr["slab_to"].ToString();
                    cmbratetype4.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB5") == 0)
                {
                    txtfrom5.Text = dr["slab_from"].ToString();
                    txtto5.Text = dr["slab_to"].ToString();
                    cmbratetype5.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
                if (dr["slab_code"].ToString().ToUpper().CompareTo("SLAB6") == 0)
                {
                    txtfrom6.Text = dr["slab_from"].ToString();
                    txtto6.Text = dr["slab_to"].ToString();
                    cmbratetype6.SelectedValue = Convert.ToString(dr["matrix_type"]);
                }
            }
            dr.Close();


        }

    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlTransaction trn = con.BeginTransaction();
        string strsql = "";
        SqlCommand cmd;
        try
        {

            if (txtfrom1.Text.CompareTo("") == 0)
                txtfrom1.Text = "0";

            if (txtfrom2.Text.CompareTo("") == 0)
                txtfrom2.Text = "0";

            if (txtfrom3.Text.CompareTo("") == 0)
                txtfrom3.Text = "0";

            if (txtfrom4.Text.CompareTo("") == 0)
                txtfrom4.Text = "0";

            if (txtfrom5.Text.CompareTo("") == 0)
                txtfrom5.Text = "0";

            if (txtfrom6.Text.CompareTo("") == 0)
                txtfrom6.Text = "0";


            if (txtto1.Text.CompareTo("") == 0)
                txtto1.Text = "0";

            if (txtto2.Text.CompareTo("") == 0)
                txtto2.Text = "0";

            if (txtto3.Text.CompareTo("") == 0)
                txtto3.Text = "0";

            if (txtto4.Text.CompareTo("") == 0)
                txtto4.Text = "0";

            if (txtto5.Text.CompareTo("") == 0)
                txtto5.Text = "0";

            if (txtto6.Text.CompareTo("") == 0)
                txtto6.Text = "0";



            strsql = "DELETE FROM webx_custcontract_frtmatrix_slabhdr WHERE contractid='" + hdncontractid.Value + "'";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype1.SelectedValue + "',";
            strsql = strsql + "'SLAB1'," + txtfrom1.Text + "," + txtto1.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype2.SelectedValue + "',";
            strsql = strsql + "'SLAB2'," + txtfrom2.Text + "," + txtto2.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype3.SelectedValue + "',";
            strsql = strsql + "'SLAB3'," + txtfrom3.Text + "," + txtto3.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();

            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype4.SelectedValue + "',";
            strsql = strsql + "'SLAB4'," + txtfrom4.Text + "," + txtto4.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();


            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype5.SelectedValue + "',";
            strsql = strsql + "'SLAB5'," + txtfrom5.Text + "," + txtto5.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();


            strsql = "INSERT INTO webx_custcontract_frtmatrix_slabhdr";
            strsql = strsql + "(custcode,contractid,matrix_type,slab_code,slab_from,slab_to,contract_type)";
            strsql = strsql + "VALUES('" + hdncustcode.Value + "','" + hdncontractid.Value + "',";
            strsql = strsql + "'" + cmbratetype6.SelectedValue + "',";
            strsql = strsql + "'SLAB6'," + txtfrom6.Text + "," + txtto6.Text + ",'" + hdncontracttype.Value + "')";
            cmd = new SqlCommand(strsql, con, trn);
            cmd.ExecuteNonQuery();


        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error.&detail1=" + ex.Message.Replace('\n','_') + "&detail2=" + strsql);
            return;
        }
        trn.Commit();

        Response.Redirect("ContractEditList.aspx?custcode=" + hdncustcode.Value);

    }

}
