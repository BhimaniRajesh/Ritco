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

public partial class GUI_UNI_MIS_accounts_mis_chequemgt_result : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataAccess DAccess = new DataAccess();
    DataView dvwProducts;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strFinYear = Session["YearVal"].ToString();
        string FromDate = Request.QueryString["dateFrom"].ToString();
        string ToDate = Request.QueryString["dateTo"].ToString();
        string acccode = Request.QueryString["strdlstSalesAmount"].ToString();
        string accTable = "webx_acctrans_" + strFinYear;
        string acode = "";
        if (acccode != "All")
        {
            acode = " AND m.ACCCODE='" + acccode + "'";
        }

        string sql = "SELECT t.acccode + ' : ' + m.ACCDESC as accname,t.chqno,convert(varchar,t.chqdate,106) as chqdate,(pbov_code + ' : ' + pbov_name) as Party,pbov_typ,t.transdate, t.acccode, M.ACCDESC,t.transtype, t.voucherno, t.narration,t.payto, t.debit,t.credit, srno,t.oppaccount from " + accTable + " t,webx_acctinfo m where  t.acccode=m.acccode  and t.voucher_cancel='N' and  m.acccategory='BANK' AND convert(varchar,CHQDATE,106) BETWEEN convert(DATETIME,'" + FromDate + " ',106)  AND convert(DATETIME,'" + ToDate + "',106)" + acode + " Order by t.acccode";
        ds = DAccess.getdataset(sql);
        dvwProducts = ds.Tables["temp"].DefaultView;
        GridViewHelper helper = new GridViewHelper(this.GrdLoadUnload);
        string[] cols = new string[1];
        cols[0] = "accname";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        GrdLoadUnload.DataSource = ds;
        GrdLoadUnload.DataBind();
    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "accname")
        {
            row.Cells[0].VerticalAlign = VerticalAlign.Top;
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            row.CssClass = "blackfnt";
            row.Cells[0].Font.Bold = true;
            row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
        }
    }
   
}
