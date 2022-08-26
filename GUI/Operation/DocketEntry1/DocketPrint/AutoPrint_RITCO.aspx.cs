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
using System.Drawing.Printing;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Operation_DocketEntry_DocketPrint_AutoPrint : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strdockno = Request.QueryString["docknos"].ToString();

        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        fn = new MyFunctions();

        if (!IsPostBack)
        {
            SqlCommand cmd;
            SqlDataAdapter da;
            string strsql = "SELECT CONVERT(VARCHAR,dockdt,103) AS dockdate,";
            strsql = strsql + "addr_csgn=(SELECT custaddress FROM webx_custhdr WHERE custcd=csgncd),";
            strsql = strsql + "addr_csge=(SELECT custaddress FROM webx_custhdr WHERE custcd=csgecd),";
            strsql = strsql + "saidto=(SELECT codedesc FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd),";
            strsql = strsql + "packtype=(SELECT codedesc FROM webx_master_general WHERE codetype='PKGS' AND codeid=pkgsty),";
            strsql = strsql + " * FROM webx_master_docket WHERE dockno='" + strdockno + "'";
            cmd = new SqlCommand(strsql, con);
            da = new SqlDataAdapter(cmd);
            DataTable dtdocket = new DataTable();
            da.Fill(dtdocket);



            strsql = "SELECT * FROM webx_master_docket_charges WHERE dockno='" + strdockno + "'";
            cmd = new SqlCommand(strsql, con);
            da = new SqlDataAdapter(cmd);
            DataTable dtdocketcharge = new DataTable();
            da.Fill(dtdocketcharge);

            strsql = "SELECT invamt,invno FROM webx_trans_docket_status WHERE dockno='" + strdockno + "'";
            cmd = new SqlCommand(strsql, con);
            da = new SqlDataAdapter(cmd);
            DataTable dtdocketinvoice = new DataTable();
            da.Fill(dtdocketinvoice);

            string strorgnaddr = "", strcsgnaddr = "", strcsgeaddr = "", strdelladdr = "";

            strsql = "SELECT locaddr FROM webx_location WHERE loccode='" + dtdocket.Rows[0]["reassign_destcd"].ToString() + "'";
            cmd = new SqlCommand(strsql, con);
            strdelladdr = Convert.ToString(cmd.ExecuteScalar());

            strsql = "SELECT locaddr FROM webx_location WHERE loccode='" + dtdocket.Rows[0]["orgncd"].ToString() + "'";
            cmd = new SqlCommand(strsql, con);
            strorgnaddr = Convert.ToString(cmd.ExecuteScalar());

            if (dtdocket.Rows[0]["csgncd"].ToString().CompareTo("8888") != 0 && dtdocket.Rows[0]["csgncd"].ToString().CompareTo("") != 0)
            {
                strcsgnaddr = dtdocket.Rows[0]["addr_csgn"].ToString();
            }
            else
            {
                strcsgnaddr = dtdocket.Rows[0]["csgnaddr"].ToString();
            }

            if (dtdocket.Rows[0]["csgecd"].ToString().CompareTo("8888") != 0 && dtdocket.Rows[0]["csgecd"].ToString().CompareTo("") != 0)
            {
                strcsgeaddr = dtdocket.Rows[0]["addr_csge"].ToString();
            }
            else
            {
                strcsgeaddr = dtdocket.Rows[0]["csgeaddr"].ToString();
            }

            string[] arrorgnaddr = new string[3];
            string[] arrdelladdr = new string[3];
            string[] arrcsgnaddr = new string[3];
            string[] arrcsgeaddr = new string[3];


            try
            {
                arrorgnaddr[0] = strorgnaddr.Substring(0, 25);
            }
            catch (Exception ex)
            {
                try
                {
                    arrorgnaddr[0] = strorgnaddr.Substring(0, strorgnaddr.Length - 1);
                }
                catch (Exception exi) { }
            }

            try
            {
                arrorgnaddr[1] = strorgnaddr.Substring(25, 25);
            }
            catch (Exception ex)
            {
                try
                {
                    arrorgnaddr[1] = strorgnaddr.Substring(25, strorgnaddr.Length - 25);
                }
                catch (Exception exi) { }
            }

            try
            {
                arrorgnaddr[2] = strorgnaddr.Substring(50, 25);
            }
            catch (Exception ex)
            {
                try
                {
                    arrorgnaddr[2] = strorgnaddr.Substring(50, strorgnaddr.Length - 25);
                }
                catch (Exception exi) { }
            }





            try
            {
                arrdelladdr[0] = strdelladdr.Substring(0, 25);
            }
            catch (Exception ex)
            {
                try
                {
                    arrdelladdr[0] = strdelladdr.Substring(0, strdelladdr.Length - 1);
                }
                catch (Exception exi) { }
            }

            try
            {
                arrdelladdr[1] = strdelladdr.Substring(25, 25);
            }
            catch (Exception ex)
            {
                try
                {
                    arrdelladdr[1] = strdelladdr.Substring(25, strdelladdr.Length - 25);
                }
                catch (Exception exi) { }
            }

            try
            {
                arrcsgnaddr[0] = strcsgnaddr.Substring(0, 50);
            }
            catch (Exception ex)
            {
                try
                {
                    arrcsgnaddr[0] = strcsgnaddr.Substring(0, strcsgnaddr.Length - 1);
                }
                catch (Exception exi) { }
            }

            try
            {
                arrcsgeaddr[0] = strcsgeaddr.Substring(0, 50);
            }
            catch (Exception ex)
            {
                try
                {
                    arrcsgeaddr[0] = strcsgeaddr.Substring(0, strcsgeaddr.Length - 1);
                }
                catch (Exception exi) { }
            }

            lbldockno.Text = strdockno;
            lbldeladdr.Text = arrdelladdr[0] + "<br />" + arrdelladdr[1] + "<br />" + arrdelladdr[2];

            if (dtdocket.Rows[0]["csgecd"].ToString().CompareTo("8888") == 0)
                lblcsgeaddr.Text = dtdocket.Rows[0]["csgenm"].ToString() + "<br />" + arrcsgeaddr[0] + "<br />" + arrcsgeaddr[1];
            else
                lblcsgeaddr.Text = fn.Getcustomer(dtdocket.Rows[0]["csgecd"].ToString()) + "<br />" + arrcsgeaddr[0] + "<br />" + arrcsgeaddr[1];


            if (dtdocket.Rows[0]["csgncd"].ToString().CompareTo("8888") == 0)
                lblcsgnaddr.Text = dtdocket.Rows[0]["csgnnm"].ToString() + "<br />" + arrcsgnaddr[0] + "<br />" + arrcsgnaddr[1];
            else
                lblcsgnaddr.Text = fn.Getcustomer(dtdocket.Rows[0]["csgncd"].ToString()) + "<br />" + arrcsgnaddr[0] + "<br />" + arrcsgnaddr[1];



            lblorgnaddr.Text = arrorgnaddr[0] + arrorgnaddr[1] + arrorgnaddr[2];

            lbldockdate.Text = dtdocket.Rows[0]["dockdate"].ToString();
            lblfromcity.Text = dtdocket.Rows[0]["from_loc"].ToString();
            lbltocity.Text = dtdocket.Rows[0]["to_loc"].ToString();
            string prodname = "";
            if (dtdocket.Rows[0]["packtype"].ToString().Length < 12)
                prodname = dtdocket.Rows[0]["packtype"].ToString();
            else
                prodname = dtdocket.Rows[0]["packtype"].ToString().Remove(12);

            if (dtdocket.Rows[0]["saidto"].ToString().Length < 12)
                prodname = prodname + " - " + dtdocket.Rows[0]["saidto"].ToString();
            else
                prodname = prodname + " - " + dtdocket.Rows[0]["saidto"].ToString().Remove(12);

            lbldesc.Text = prodname;
            lblprivatemark.Text = dtdocket.Rows[0]["privatemark"].ToString();
            lblremarks.Text = dtdocket.Rows[0]["spl_svc_req"].ToString();
            lblpkgsno.Text = returnDouble(dtdocket.Rows[0]["pkgsno"].ToString()).ToString("F0");
            lblactwt.Text = returnDouble(dtdocket.Rows[0]["actuwt"].ToString()).ToString("F0");
            lblchrgwt.Text = returnDouble(dtdocket.Rows[0]["chrgwt"].ToString()).ToString("F0");

            lbldeclval.Text = returnDouble(dtdocketinvoice.Rows[0]["invamt"].ToString()).ToString("F0");
            lblinvno.Text = dtdocketinvoice.Rows[0]["invno"].ToString();

            lblrate.Text = returnDouble(dtdocketcharge.Rows[0]["frt_rate"].ToString()).ToString("F2");
            lblfreightcharge.Text = returnDouble(dtdocketcharge.Rows[0]["freight"].ToString()).ToString("F2");
            lbldockettotal.Text = returnDouble(dtdocketcharge.Rows[0]["dkttot"].ToString()).ToString("F2");

            string chargerule = DocketRules.GetDefaultValue("CHRG_RULE");
            string basecode = dtdocket.Rows[0]["businesstype"].ToString();
            string sqlstr = "SELECT chargecode,chargename,chargevalue='0'";
            sqlstr = sqlstr + " FROM webx_master_charge  ";
            sqlstr = sqlstr + " WHERE activeflag='Y' AND basedon='" + chargerule + "'";
            sqlstr = sqlstr + " AND basecode='" + basecode + "' AND booktimeflag='Y' AND chargetype='DKT'";


            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];


            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["chargevalue"] = DocketController.ToDouble(dtdocketcharge.Rows[0][dt.Rows[i]["chargecode"].ToString()].ToString()).ToString("F2");
            }


            grvcharges.DataSource = dt;
            grvcharges.DataBind();

            switch (dtdocket.Rows[0]["paybas"].ToString())
            {
                case "P01":
                    lblpaynote.Text = "PAID " + lbldockettotal.Text;
                    break;
                case "P02":
                    lblpaynote.Text = "TBB " + lbldockettotal.Text;
                    break;
                case "P03":
                    lblpaynote.Text = "TO PAY  " + lbldockettotal.Text;
                    break;
            }
        }
    }

    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception ex)
        {
            return 0.00;
        }
    }

}
