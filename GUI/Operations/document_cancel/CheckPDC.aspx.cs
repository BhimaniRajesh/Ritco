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

public partial class GUI_Operations_document_cancel_CheckPDC : System.Web.UI.Page
{
    public string PDC;
    public string date, from, to, manualno;

    protected void Page_Load(object sender, EventArgs e)
    {
        PDC = Request.QueryString["PDC"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "select * from webx_PDCHDR p where isnull(Cancelled,'N') !='Y' and (PDC_STATUS !='AD' or PDC_STATUS !='FC') and isnull(PDCUpdated,'N') !='Y' and PDCNO='" + PDC + "' and (select count(*) from webx_pdctrn where dkt_dly='Y' and pdcno=p.pdcno)=0";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            date = Convert.ToString(dr["PDCDT"]);
            from = Convert.ToString(dr["PDCBR"]);
            //to = Convert.ToString(dr["tobh_code"]);
            manualno = Convert.ToString(dr["ManualPDCNo"]);
            i = 1;
            break;
        }
        dr.Close();

        Response.Clear();
        if (i == 0)
            Response.Write("false|");
        else if (i == 1)
            Response.Write("true|" + date + "|" + from + "|" + manualno + "|");
        con.Close();
    }
    
}
