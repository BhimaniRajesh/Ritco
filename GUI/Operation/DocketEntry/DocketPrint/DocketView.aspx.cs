using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;

public partial class GUI_Operation_DocketEntry_DocketPrint_DocketView : System.Web.UI.Page
{
    SqlConnection con;
    protected string dkt_call = "", dockno = "";
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString());
        con.Open();

        fn = new MyFunctions();

        dkt_call = "Docket".ToString();
        dockno = Request.QueryString["dockno"].ToString();

        divfinancial.Style["display"] = "none";
        divstatus.Style["display"] = "none";
        divparties.Style["display"] = "none";
        divinvoice.Style["display"] = "none";
        divuserinfo.Style["display"] = "none";

        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;

        DataTable dtoperation = new DataTable();
        strsql = "SELECT ";
        strsql = strsql + "CONVERT(VARCHAR,dockdt,106) AS dockdate,";
        strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='TRN' AND codeid=trn_mod) AS transmode,";
        strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='SVCTYP' AND codeid=service_class) AS servicetype,";
        strsql = strsql + "(SELECT codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND codeid=ftl_types) AS ftltype,";
        strsql = strsql + "* FROM webx_master_docket WHERE dockno='" + dockno + "'";
        cmd = new SqlCommand(strsql, con);
        da = new SqlDataAdapter(cmd);
        da.Fill(dtoperation);


        lbldockno.Text = dtoperation.Rows[0]["dockno"].ToString();
        lbldockdate.Text = dtoperation.Rows[0]["dockdate"].ToString();
        lblpaybas.Text = fn.Getpaybas(dtoperation.Rows[0]["paybas"].ToString());
        lblorgnloc.Text = dtoperation.Rows[0]["orgncd"].ToString() + " : " + fn.GetLocation(dtoperation.Rows[0]["orgncd"].ToString());
        lbldelloc.Text = dtoperation.Rows[0]["destcd"].ToString() + " : " + fn.GetLocation(dtoperation.Rows[0]["destcd"].ToString());
        lbltransmode.Text = fn.Gettrnmod( dtoperation.Rows[0]["destcd"].ToString());
        lblservicetype.Text = dtoperation.Rows[0]["servicetype"].ToString();
        lblftltype.Text = dtoperation.Rows[0]["ftltype"].ToString();



    }
}
