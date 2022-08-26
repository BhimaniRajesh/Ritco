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

public partial class GUI_admin_RouteMaster_RouteMaster : System.Web.UI.Page
{
    SqlConnection con; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    static DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        if (!IsPostBack)
        {
            dt = new DataTable();
            dt.Rows.Add();
            hdnclient.Value = Session["client"].ToString().ToUpper();

            grvdocket.DataSource = dt;
            grvdocket.DataBind();
        }
    }

    protected void CmdAddRows_Click(object sender, EventArgs e)
    {

        int rows = 0;
        try
        {
            rows = Convert.ToInt16(TxtRows.Text.Trim());
        }
        catch (Exception ex) { rows = 0; }

        for (int i = 0; i < rows; i++)
        {
            dt.Rows.Add();
        }

        grvdocket.DataSource = dt;
        grvdocket.DataBind();
    }


    protected void btnUpdt_Click(object sender, EventArgs e)
    {
        SqlTransaction trn;
        SqlCommand cmd;
        trn = con.BeginTransaction();
        string strone = "", strtwo = "";
        try
        {
            foreach (GridViewRow grv in grvdocket.Rows)
            {
                TextBox txtdockno = (TextBox)grv.FindControl("txtdockno");
                TextBox txtdelloc = (TextBox)grv.FindControl("txtdelloc");
                TextBox txtnextloc = (TextBox)grv.FindControl("txtnextloc");
                if (txtdockno.Text.Trim().CompareTo("") != 0 && txtdelloc.Text.Trim().CompareTo("") != 0 && txtnextloc.Text.Trim().CompareTo("") != 0)
                {

                    strone = "SELECT drs FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text.Trim() + "'";
                    cmd = new SqlCommand(strone, con, trn);
                    string drs = Convert.ToString(cmd.ExecuteScalar());

                    strone = "SELECT delivered FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text.Trim() + "'";
                    cmd = new SqlCommand(strone, con, trn);
                    string delivered = Convert.ToString(cmd.ExecuteScalar());

                    strone = "SELECT GATEPASSNO=ISNULL(GATEPASSNO,'') FROM webx_trans_docket_status WHERE dockno='" + txtdockno.Text.Trim() + "'";
                    cmd = new SqlCommand(strone, con, trn);
                    string Gatepassno = Convert.ToString(cmd.ExecuteScalar());

                    if (delivered.CompareTo("Y") == 0)
                    {
                        if (Gatepassno != "")
                        {
                            Response.Redirect("ErrorPage.aspx?heading=Docket is Delivered&detail1=Not Possible to Change Delivery location&detail2=&suggestion2=");
                            return;
                        }
                    }
                    else if (delivered.CompareTo("L") == 0)
                    {
                        Response.Redirect("ErrorPage.aspx?heading=Docket is Delivered&detail1=Not Possible to Change Delivery location&detail2=&suggestion2=");
                        return;                    
                    }


                    strone = "SELECT loccode FROM webx_location WHERE loccode='" + txtdelloc.Text.Trim() + "' AND activeflag='Y'";
                    cmd = new SqlCommand(strone, con, trn);
                    string delloc = Convert.ToString(cmd.ExecuteScalar());
                    if (delloc.CompareTo("") == 0)
                    {
                        Response.Redirect("ErrorPage.aspx?heading=" + txtdelloc.Text.Trim() + " not From Location Master&detail1=Not Possible to Change Delivery location&detail2=&suggestion2=");
                        return;
                    }

                    strone = "SELECT loccode FROM webx_location WHERE loccode='" + txtnextloc.Text.Trim() + "' AND activeflag='Y'";
                    cmd = new SqlCommand(strone, con, trn);
                    string nextloc = Convert.ToString(cmd.ExecuteScalar());
                    if (nextloc.CompareTo("") == 0)
                    {
                        Response.Redirect("ErrorPage.aspx?heading=" + txtnextloc.Text.Trim() + " not From Location Master&detail1=Not Possible to Change Delivery location&detail2=&suggestion2=");
                        return;
                    }


                    if (drs.CompareTo("") == 0)
                    {
                        strone = "UPDATE webx_master_docket set reassign_destcd='" + txtdelloc.Text.Trim() + "' WHERE dockno='" + txtdockno.Text.Trim() + "'";
                        cmd = new SqlCommand(strone, con, trn);
                        cmd.ExecuteNonQuery();

                        strone = "UPDATE webx_trans_docket_status set Delivery_Mr_Location='" + txtdelloc.Text.Trim() + "' WHERE dockno='" + txtdockno.Text.Trim() + "'";
                        cmd = new SqlCommand(strone, con, trn);
                        cmd.ExecuteNonQuery();
                                             
                    }
                    else
                    {
                        trn.Rollback();
                        Response.Redirect("ErrorPage.aspx?heading=DRS No " + drs + " is Generated for Docket No " + txtdockno.Text.Trim() + "&detail1=Not Possible to Change Delivery location&detail2=&suggestion2=");
                        return;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Problem&detail1=Problem in Reassign Utility&detail2=" + strex + "&suggestion2=");
            return;
        }

        trn.Commit();
        Response.Redirect("~/GUI/Default.aspx");
    }



    protected void grvdocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtdockno = (TextBox)e.Row.FindControl("txtdockno");
            TextBox txtdelloc = (TextBox)e.Row.FindControl("txtdelloc");
            TextBox txtnextloc = (TextBox)e.Row.FindControl("txtnextloc");
            Button btndelloc = (Button)(e.Row.FindControl("btndelloc"));
            Button btnnextloc = (Button)(e.Row.FindControl("btnnextloc"));

            txtdockno.Attributes.Add("onblur", "return  dockNoBlur(this.getAttribute('id'))");
            txtdelloc.Attributes.Add("onblur", "javascript:return locTest('" + txtdelloc.ClientID + "','delloc')");
            txtnextloc.Attributes.Add("onblur", "javascript:return locTest('" + txtnextloc.ClientID + "','delloc')");
            btndelloc.Attributes.Add("onclick", "javascript:return openpopUp('" + txtdelloc.ClientID.Trim() + "')");
            btnnextloc.Attributes.Add("onclick", "javascript:return openpopUp('" + txtnextloc.ClientID.Trim() + "')");
        }
    }
}
