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

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("thc") == 0)
        {
            string thcno = Request.QueryString["code"].ToString();
            string qry = "select thcno as doc_no,convert(varchar,thcdt,106) as doc_dt,thcbr as doc_loc,certify_by as doc_entryby,cancelled as doc_cancelled from WEBX_thc_summary where thcno='" + thcno + "' and thcsf='.' and Cancelled is not null";

            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                if (dr["cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|THC is already Cancelled.|");
                }
                else
                {
                    Response.Write("true|");
                }
            }

            if (i == 0)
                Response.Write("false|InValid THC No.|");


        }
        else if (mode.CompareTo("doc") == 0)
        {
            string docno = Request.QueryString["code"].ToString();
            //string qry= "SELECT d.dockno,d.docksf,c.dkt_cancel FROM webx_docket d INNER JOIN webx_docket_detain_cancel c ON d.dockno=c.dockno WHERE d.dockno='" + docno  + "' AND d.docksf='.'";
            string qry = "Select * from WebX_Trans_Docket_Status where dockno='" + docno + "' AND docksf='.'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                if (dr["Cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|Docket is already Cancelled.|");
                }
                else if(dr["Delivered"].ToString().CompareTo("Y") == 0)
                {
                Response.Write("false|Docket is Delivered.|");
                }
                else
                {
                    Response.Write("true|");
                }
            }

            if (i == 0)
                Response.Write("false|InValid Docket No.|");
        }

        else if (mode.CompareTo("manifest") == 0)
        {
            string manifest = Request.QueryString["code"].ToString();
            string qry = "select tcno as doc_no,convert(varchar,tcdt,106) as doc_dt,tcbr as doc_loc,entryby as doc_entryby,cancelled as doc_cancelled from WEBX_tchdr where tcno='" + manifest + "' and tcsf='.' and cancelled is not null";

            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                if (dr["cancelled"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|Manifest is already Cancelled.|");
                }
                else
                {
                    Response.Write("true|");
                }
            }

            if (i == 0)
                Response.Write("false|InValid Manifest No.|");
        }
        
        con.Close();
    }
}
