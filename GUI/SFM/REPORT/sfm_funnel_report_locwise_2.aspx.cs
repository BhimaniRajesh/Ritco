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

public partial class REPORT_sfm_funnel_report_locwise_2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["dtfrm"] = dtFrom;
        //Session["dtt"] = dtTo;

        string dtrange, dtFrom, dtTo, loc,calltype,pro,value;
        //dtFrom = Session["dtfrm"].ToString();
        //dtTo = Session["dtt"].ToString();
        //string dtf, dtt;
        //dtf = dtFrom.Substring(0, 10);
        //dtt = dtTo.Substring(0, 10);
        //dtrange = dtf + " TO " + dtt;
        //lbldate.Text = dtrange.ToString();


        loc =  Session["loc"].ToString();

        lblLocation.Text = loc.ToString();
        calltype = Request.QueryString.Get("calltype");
        lblprospectType.Text = calltype.ToString();

        pro = Request.QueryString.Get("pro");
        lblProspect.Text = pro.ToString();

        value = Request.QueryString.Get("value");
        lblValue.Text = value.ToString();

    }
}
