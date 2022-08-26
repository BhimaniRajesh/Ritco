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

public partial class MainCustomerContractMaster : System.Web.UI.Page
{
    SqlCommand cmd;
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();
        string client = "";
        client = Session["client"].ToString();
        if (!IsPostBack)
        {
            string sqlstr = "SELECT custloc,custnm,custcd FROM webx_custhdr WHERE cust_active='Y' ORDER BY custnm";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            SqlDataReader dr = cmd.ExecuteReader();
            cmbeditcustomer.Items.Add(new ListItem("Select", "0"));
            while (dr.Read())
            {
                if (client.CompareTo("ASL") == 0)
                {
                    cmbeditcustomer.Items.Add(new ListItem(Convert.ToString(dr["custloc"]) + " : " + Convert.ToString(dr["custnm"]) + " : " + Convert.ToString(dr["custcd"]), Convert.ToString(dr["custcd"])));
                }
                else
                {
                    cmbeditcustomer.Items.Add(new ListItem(Convert.ToString(dr["custnm"]) + " : " + Convert.ToString(dr["custcd"]), Convert.ToString(dr["custcd"])));
                }
            }
            dr.Close();

           
        }
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        Response.Redirect("ContractEditList.aspx?custcode=" + cmbeditcustomer.SelectedValue);
    }
}
