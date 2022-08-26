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
using Microsoft.ApplicationBlocks.Data;
using System.IO;
using System.Xml;

public partial class GUI_Fleet_Operations_Issue_AutoComplete2_mac_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack && !IsCallback)
        {
            string tp = Request.QueryString["tp"].ToString().ToUpper();
            string code1 = "", target1 = "", target2 = "", target3 = "", filter1 = "", filter2 = "", filtstr = "", map_dloc_pin = "", divid = "";
            target1 = Request.QueryString["target1"].ToString();
            target2 = Request.QueryString["target2"].ToString();
            target3 = Request.QueryString["target3"].ToString();
            filter1 = Request.QueryString["filt1"].ToString();
            filter2 = Request.QueryString["filt2"].ToString();
            filtstr = Request.QueryString["filtstr"].ToString();
            divid = Request.QueryString["divid"].ToString();

            DataTable dt = new DataTable();
            if (tp.CompareTo("CUSTOMER") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetCustomerTable(code1, filter1);
            }


            Table tbl = new Table();
            tbl.ID = "tblmain";
            tbl.CssClass = "blackfnt";
            tbl.Style["width"] = "100%";

            Int32 id = 1;
            Response.Clear();


            foreach (DataRow dtr in dt.Rows)
            {
                TableRow tr = new TableRow();
                tr.CssClass = "bgwhite";
                TableCell tc = new TableCell();
                TableCell cval = new TableCell();
                TableCell nval = new TableCell();
                TableCell t_val3 = new TableCell();

                tc.ID = "tcd" + id;
                tc.Style["border"] = "solid black 1px";
                cval.ID = "cval" + id;
                nval.ID = "nval" + id;
                t_val3.ID = "t_val3" + id;
                tr.ID = "tr" + Convert.ToString((id++));

                cval.Style["display"] = "none";
                nval.Style["display"] = "none";
                t_val3.Style["display"] = "none";
                cval.Text = dtr[0].ToString();
                nval.Text = dtr[1].ToString();

                tr.Attributes.Add("onmouseover", "javascript:dacItemMouseOver(" + tc.ClientID + ",'" + cval.Text + "')");
                tr.Attributes.Add("onmouseout", "javascript:dacItemMouseOut(" + tc.ClientID + ",'" + cval.Text + "')");

                if (tp.CompareTo("CUSTOMER") == 0)
                {
                    t_val3.Text = dtr[2].ToString();
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }

                if (target2.CompareTo("") == 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + ",null,null,'" + divid + "')");
                else if (target2.CompareTo("") == 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + ",null," + target3 + ",'" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + "," + target2 + ",null,'" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + "," + target2 + "," + target3 + ",'" + divid + "')");


                tr.Controls.Add(tc);
                tr.Controls.Add(cval);
                tr.Controls.Add(nval);
                tr.Controls.Add(t_val3);
                tbl.Controls.Add(tr);
            }

            Page.Controls.Add(tbl);

        }

    }

    private DataTable GetCustomerTable(string pref_cst, string loc)
    {
        string strsql = "SELECT CUSTCD,CUSTNM,BRANCHNAME FROM webx_CUSTHDR ";
        strsql = strsql + " WHERE CUST_ACTIVE='Y' and (CUSTNM LIKE '" + pref_cst + "%' OR CUSTCD LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR CUSTCD LIKE '% " + pref_cst + "%' OR PATINDEx ('%" + pref_cst + "%',BRANCHNAME)>0 )";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

}
