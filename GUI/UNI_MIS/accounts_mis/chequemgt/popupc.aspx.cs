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

public partial class GUI_UNI_MIS_accounts_mis_chequemgt_popupc : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        //string chqno = ;
        //string chqdt = ;
        dt = DAccess.gettable("select chqno,convert(varchar,chqdt,106) as chqdt,(brcd + ':' + brnm) as IssueLocation, Convert(varchar,transdate,106) as IssueDate,voucherNo,banknm as IssueFrom,chqamt,(ptmsptcd + ':' + ptmsptnm) as IssueTo from webx_chq_det where chqno='" + Request.QueryString["no"].ToString() + "' and convert(varchar,chqdt,106)=convert(datetime,'" + Request.QueryString["chqdt"].ToString() + "',106)");
        lblchqno.Text = dt.Rows[0]["chqno"].ToString();
        lblChqDt.Text = dt.Rows[0]["chqdt"].ToString();
        lblIssueLocation.Text = dt.Rows[0]["IssueLocation"].ToString();
        lblIssueDt.Text = dt.Rows[0]["IssueDate"].ToString();
        lblVoucherNo.Text = dt.Rows[0]["voucherNo"].ToString();
        lblIssueFrom.Text = dt.Rows[0]["IssueFrom"].ToString();
        lblchqamt.Text = dt.Rows[0]["chqamt"].ToString();
        lblIssueTo.Text = dt.Rows[0]["IssueTo"].ToString();
       

    }
}
