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

public partial class GUI_Operations_LoadingSheet_ViewPrint_LoadingSheetSummaryList : System.Web.UI.Page
{
    string lsno = "";
    SqlConnection con;
    string sqlqry = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        lsno = Request.QueryString["lsno"].ToString();

        sqlqry = "SELECT * FROM vw_LS_Detail WHERE replace(LSNo,'.','')='" + lsno + "'";

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        string sql = "SELECT DISTINCT *,st_lsdate=convert(varchar,lsdate,6) FROM vw_ls_header WHERE REPLACE(lsno,'.','')='" + lsno + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lbllsno.Text = dr["lsno"].ToString();//.Text = dr[""].ToString();
            lbldate.Text = dr["lsdate"].ToString();
            lbllsloc.Text = dr["ls_branch"].ToString() + " : " + fn.GetLocation(dr["ls_branch"].ToString());
            lblvehno.Text = dr["ls_vehicleno"].ToString();
            lblroute.Text = dr["route_code"].ToString();
            //lblstaffname.Text = dr[""].ToString();
            //lblsign.Text = dr[""].ToString();
            lblpreparedby.Text = dr["entryby"].ToString();
            lblat.Text = dr["ls_branch"].ToString();
            lbldatetime.Text = dr["tcdt"].ToString();

        }
        dr.Close();

        dataBind();
    }

    protected void dataBind()
    {
        SqlCommand cmd = new SqlCommand(sqlqry, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "tbllslist");

        if (ds.Tables[0].Rows.Count <= 0)
        { 
            gvlslist.Style["display"]="none";
            tblgrid.Style["display"] = "block";
        }

        gvlslist.DataSource = ds;
        gvlslist.DataBind();

        da.Fill(ds, "tbllist");
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvlslist.PageIndex = e.NewPageIndex;
        dataBind();
    }

    protected void gvlslist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
