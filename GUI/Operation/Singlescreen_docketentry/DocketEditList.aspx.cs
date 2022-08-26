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

public partial class GUI_admin_DocketPrint_DocketList : System.Web.UI.Page
{
    protected string dockno, mode, agent, date1, date2, tp, sqlstr, dkt_call = "",partycode="";

    MyFunctions fn = new MyFunctions();
    static DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {

        dockno = Request.QueryString["dockno"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        partycode = Request.QueryString["partycode"].ToString();
        tp = Request.QueryString["tp"].ToString();

        lbldates.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);
        lbldockno.Text = dockno;

        try
        {
            dkt_call = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        try
        {
            sqlstr = "SELECT loc_level FROM webx_location WHERE loccode='" + Session["brcd"].ToString() + "'";
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        string loclevel = Convert.ToString(cmd.ExecuteScalar());



        string datestr = "", BILLNOstr = "";
        sqlstr = "SELECT convert(varchar,dockdt,106) as dockdt,party=(SELECT custnm FROM webx_custhdr WHERE custcd=a.party_code),paybas=(SELECT codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=a.paybas),* FROM vw_docket_net a ";
        if (tp.CompareTo("0") == 0)
        {

            if (loclevel.CompareTo("1") == 0)
                sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND billed='N'";
            else
                sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND (orgncd='" + Session["brcd"].ToString() + "' OR fincmplbr='" + Session["brcd"].ToString() + "') AND billed='N'";

            trdockdt.Style["display"] = "none";
            trdockno.Style["display"] = "block";
        }
        else if (tp.CompareTo("1") == 0)
        {

            if (loclevel.CompareTo("1") == 0)
                sqlstr = sqlstr + " WHERE dockdt BETWEEN '" + fn.Mydate(date1) + "' AND '" + fn.Mydate(date2) + "' AND billed='N' AND party_code='" + partycode.Trim() + "'";
            else
                sqlstr = sqlstr + " WHERE dockdt BETWEEN '" + fn.Mydate(date1) + "' AND '" + fn.Mydate(date2) + "' AND (orgncd='" + Session["brcd"].ToString() + "' OR fincmplbr='" + Session["brcd"].ToString() + "') AND billed='N' AND party_code='" + partycode.Trim() + "'";

            trdockno.Style["display"] = "none";
            trdockdt.Style["display"] = "block";
        }


        SqlCommand cmdoct = new SqlCommand(sqlstr, con);


        ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvdocklist.CssClass = "redfnt";
            gvdocklist.HorizontalAlign = HorizontalAlign.Center;
        }

        if (ds.Tables["tbl1"].Rows.Count <= 0)
        {
            gvdocklist.Style["display"] = "none";
            tblgrid.Style["display"] = "block";
        }


        dataBind();

    }
    protected void lnkdockedit_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;

        HiddenField hdn = (HiddenField)lnk.Parent.FindControl("hdndockno");
        Response.Redirect("DocketEdit.aspx?dockno=" + hdn.Value);
    }

    protected void dataBind()
    {

        gvdocklist.DataSource = ds;
        gvdocklist.DataBind();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvdocklist.PageIndex = e.NewPageIndex;
        dataBind();
    }

    protected void gvdocklist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
