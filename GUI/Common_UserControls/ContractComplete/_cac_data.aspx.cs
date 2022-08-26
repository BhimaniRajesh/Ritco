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

public partial class GUI_Operation_xac_data : System.Web.UI.Page
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

            if (tp.CompareTo("BRANCH") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetLocationTable(code1, filtstr);
            }
            else if (tp.CompareTo("CITY") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetFromCityTable(code1, "");
            }
            else if (tp.CompareTo("REGION") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetRegionTable(code1, filter1);
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

                tr.Attributes.Add("onmouseover", "javascript:dacItemMouseOver('" + tc.ClientID + "')");
                tr.Attributes.Add("onmouseout", "javascript:dacItemMouseOut('" + tc.ClientID + "')");

                if (tp.CompareTo("BRANCH") == 0)
                {
                  

                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("CITY") == 0)
                {
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("REGION") == 0)
                {
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }

                if (target2.CompareTo("") == 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text + "','" + t_val3.Text + "','" + target1 + "',null,null,'" + divid + "')");
                else if (target2.CompareTo("") == 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text + "','" + t_val3.Text + "','" + target1 + "',null,'" + target3 + "','" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text + "','" + t_val3.Text + "','" + target1 + "','" + target2 + "',null,'" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:return dacItemClick('" + cval.Text + "','" + nval.Text + "','" + t_val3.Text + "','" + target1 + "','" + target2 + "','" + target3 + "','" + divid + "')");

                tr.Controls.Add(tc);
                tr.Controls.Add(cval);
                tr.Controls.Add(nval);
                tr.Controls.Add(t_val3);
                tbl.Controls.Add(tr);
            }
            Page.Controls.Add(tbl);
        }
    }
    
    private DataTable GetLocationTable(string pref_cst, string filt)
    {
        string strsql = "";

        strsql = "SELECT loccode,locname,codedesc FROM webx_location l WITH(NOLOCK) INNER JOIN webx_master_general g WITH(NOLOCK) ";
        strsql = strsql + " ON g.codeid=l.locregion  WHERE g.statuscode='Y' AND l.activeflag='Y'";
        strsql = strsql + " AND g.codetype='ZONE'";
        strsql = strsql + " AND (loccode LIKE '" + pref_cst + "%' OR locname LIKE '" + pref_cst + "%' OR locname LIKE '% " + pref_cst + "%' ";
        strsql = strsql + " OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '% " + pref_cst + "%')";
        strsql = strsql + " AND PATINDEX ('%' + CONVERT(VARCHAR,loc_level) + '%','" + filt + "')>0";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetFromCityTable(string pref_cst, string loc)
    {
        string strsql = "";
        strsql = "SELECT location, codedesc FROM webx_citymaster c INNER JOIN webx_master_general g ";
        strsql = strsql + " ON g.codeid=c.region WHERE g.statuscode='Y' AND c.activeflag='Y'";
        strsql = strsql + " AND g.codetype='ZONE'";
        strsql = strsql + " AND (location LIKE '" + pref_cst + "%' OR location LIKE '% " + pref_cst + "%' ";
        strsql = strsql + " OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '% " + pref_cst + "%')";

        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetCustomerAddress(string pref_addr, string custcd, string city)
    {
        string sqlstr = "SELECT c.addid,c.address,c.city,c.pincode,c.phoneno,c.email,cm.custcd,";
        sqlstr = sqlstr + " custname=(select custcd + ' : ' + custnm from webx_custhdr where custcd=cm.custcd) ";
        sqlstr = sqlstr + " FROM webx_master_custaddresses c INNER JOIN webx_master_custaddr_mapping cm ON c.addid=cm.addid";
        sqlstr = sqlstr + " WHERE cm.custcd='" + custcd + "' AND city='" + city + "' AND c.Cust_Active='Y'";
        sqlstr = sqlstr + " AND (c.address LIKE '" + pref_addr + "%' OR c.address LIKE '% " + pref_addr + "%' ";
        sqlstr = sqlstr + " OR c.city LIKE '" + pref_addr + "%')";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
    }


 	private DataTable GetRegionTable(string pref_cst, string filt)
    {
        string strsql = "";
        strsql = "select  CodeDesc,codetype from webx_master_general where  codetype='ZONE' AND StatusCode='Y' ";

        strsql = strsql + " AND CodeDesc LIKE '" + pref_cst + "%' ";


        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

}
