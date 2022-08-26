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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Operations_FM_FM_report_query : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        Fromlc.Width = "100";
        if (!IsPostBack)
        {    
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string st_ro = "", st_lo = "";
        string fromdt = DT.FromDate, todt = DT.ToDate;

        st_ro = Fromlc.SelectedRO;
        if (st_ro == "")
        {
            st_ro = "All";
        }

        st_lo = Fromlc.SelectedLocation;
        if (st_lo == "")
        {
            st_lo = "All";
        }

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&FMNo=" + txtFMNo.Text;
        final += "&RO_Text=" + Fromlc.SelectedRO_Text;
        final += "&LO_Text=" + Fromlc.SelectedLocation_Text;
        // final += "&St_paylist=" + St_paylist;
        //final += "&st_trnlist=" + st_trnlist;
        //final += "&st_delist=" + st_delist;
        Response.Redirect("Result.aspx" + final);

    }
}
