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

public partial class GUI_admin_Extra_EditQuickDocket : System.Web.UI.Page
{

    SqlConnection con;
    protected string sdkt_call = "";
    protected string START_YEAR = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con=new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        //FINANTIAL_YEAR creation
        DateTime dt1 = new DateTime();
        dt1 = DateTime.Now;

        if (dt1.Month < 4)
            START_YEAR = ((int)(dt1.Year - 1)).ToString();
        else
            START_YEAR = ((int)(dt1.Year)).ToString();
        sdkt_call = Session["DocketCalledAs"].ToString();

        txtdelivery.Attributes.Add("onblur", "javascript:return delLocBlur(this.getAttribute('id'))");
        btneditsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        string sql = "Select dockno,convert(varchar,dockdt,103) as dockdt,orgncd,destcd,actuwt,chrgwt,pkgsno From vw_docket_net Where dockno='" + txtdocno.Text + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        divedit.Style["display"] = "none";
        while (dr.Read())
        {
            divedit.Style["display"] = "block";
            lbldockno.Text = dr["dockno"].ToString();
            txtdocdate.Text = dr["dockdt"].ToString();
            lblorigin.Text = dr["orgncd"].ToString();
            txtdelivery.Text = dr["destcd"].ToString();

            lbltotactwt.Text = "(" + dr["actuwt"].ToString() + ")";
            lbltotnopack.Text = "(" + dr["pkgsno"].ToString() + ")";
            lblchrgwt.Text = "(" + dr["chrgwt"].ToString() + ")";
        }
        dr.Close();

        if (divedit.Style["display"].ToString().CompareTo("none") == 0)
            divexcept.Style["display"] = "block";
        else
            divexcept.Style["display"] = "none";
    }


    protected void btneditsubmit_Click(object sender, EventArgs e)
    {
        if (txttotnopack.Text.CompareTo("") == 0)
            txttotnopack.Text = "0";
        if (txttotactwt.Text.CompareTo("") == 0)
            txttotactwt.Text = "0";
        if (txtchrgwt.Text.CompareTo("") == 0)
            txtchrgwt.Text = "0";


        string sql = "UPDATE webx_master_docket SET dockdt=convert(datetime," + txtdocdate.Text + ",106),destcd='" + txtdelivery.Text + "',pkgsno=" + txttotnopack.Text + ",actuwt=" + txttotactwt.Text + ",chrgwt=" + txtchrgwt.Text + " WHERE dockno='" + txtdocno.Text + "'";
        SqlCommand cmd = new SqlCommand(sql,con);
        cmd.ExecuteNonQuery();

        Response.Redirect("../docket_operation.aspx");
    }
}
