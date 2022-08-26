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

public partial class GUI_Operation_xac_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string tp = Request.QueryString["tp"].ToString().ToUpper();
            string code1 = "", target1 = "", target2 = "", filter1 = "", filter2 = "";
            target1 = Request.QueryString["target1"].ToString();
            target2 = Request.QueryString["target2"].ToString();
            filter1 = Request.QueryString["filt1"].ToString();
            filter2 = Request.QueryString["filt2"].ToString();
            DataTable dt = new DataTable();
            if (tp.CompareTo("CUSTOMER") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetCustomerTable(code1, filter1);
            }
            else if (tp.CompareTo("BRANCHCODE") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetLocationTable(code1, filter2);
            }
            else if (tp.CompareTo("CITY") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetCityTable(code1, "");
            }
            else if (tp.CompareTo("PINCODE") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetPincode(code1, filter1);
            }
            else if (tp.CompareTo("CUSTOMERADDRESS") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetCustomerAddress(code1, filter1, filter2);
            }
            else if (tp.CompareTo("VENDOR") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetVendorTable(code1, filter1, filter2);
            }
            else if (tp.CompareTo("VENDORCODE") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetVendorCodeTable(code1, filter1, filter2);
            }
            else if (tp.CompareTo("VEHICLE") == 0)
            {
                code1 = Request.QueryString["code1"].ToString();
                dt = GetVehicle(code1, filter2);
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


                tc.ID = "tcd" + id;
                tc.Style["border"] = "solid black 1px";
                cval.ID = "cval" + id;
                nval.ID = "nval" + id;
                tr.ID = "tr" + Convert.ToString((id++));

                cval.Style["display"] = "none";
                nval.Style["display"] = "none";
                cval.Text = dtr[0].ToString();
                nval.Text = dtr[1].ToString();

                tr.Attributes.Add("onmouseover", "javascript:itemMouseOver(" + tc.ClientID + ",'" + cval.Text + "')");
                tr.Attributes.Add("onmouseout", "javascript:itemMouseOut(" + tc.ClientID + ",'" + cval.Text + "')");
                if (target2.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:return " + target1 + "_ItemClick('" + cval.Text + "','" + nval.Text + "'," + target1 + ",null)");
                else
                    tc.Attributes.Add("onclick", "javascript:return " + target1 + "_ItemClick('" + cval.Text + "','" + nval.Text + "'," + target1 + "," + target2 + ")");

                if (tp.CompareTo("CUSTOMER") == 0)
                {
                    tc.Text = dtr[1].ToString().Replace(code1, "<span style='color:red;font-weight:bold;'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[0].ToString() + "</span>";
                    tc.Text = tc.Text + " : <span style='font-weight:normal'>";
                    if (filter1.CompareTo("") > 0)
                        tc.Text = tc.Text + dtr[2].ToString().Replace(filter1, "<span style='color:red;font-weight:bold'>" + filter1 + "</span>") + "</span>";
                    else
                        tc.Text = tc.Text + dtr[2].ToString();

                }
                else if (tp.CompareTo("BRANCHCODE") == 0)
                {
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("CITY") == 0)
                {
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("PINCODE") == 0)
                {
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("CUSTOMERADDRESS") == 0)
                {
                    tc.Text = dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    //                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[0].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(filter2.ToUpper(), "<span style='color:red'>" + filter2.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                    tc.ToolTip = "" + dtr[7].ToString() + "\n" + dtr[1].ToString() + "\n" + dtr[2].ToString();
                    tc.ToolTip = tc.ToolTip + " - " + dtr[3].ToString() + "\nPhone : " + dtr[4].ToString() + "\nE-mail : " + dtr[5].ToString();
                }
                else if (tp.CompareTo("VENDOR") == 0)
                {
                    tc.Text = dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red;font-weight:bold;'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[0].ToString() + "</span>";
                    tc.Text = tc.Text + " : <span style='font-weight:normal'>";
                    if (filter1.CompareTo("") > 0)
                        tc.Text = tc.Text + dtr[2].ToString().Replace(filter1, "<span style='color:red;font-weight:bold'>" + filter1 + "</span>") + "</span>";
                    else
                        tc.Text = tc.Text + dtr[2].ToString();
                }
                else if (tp.CompareTo("VENDORCODE") == 0)
                {
                    tc.Text = dtr[1].ToString().Replace(code1.ToUpper(), "<span style='color:red;font-weight:bold;'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[0].ToString() + "</span>";
                    tc.Text = tc.Text + " : <span style='font-weight:normal'>";
                    if (filter1.CompareTo("") > 0)
                        tc.Text = tc.Text + dtr[2].ToString().Replace(filter1, "<span style='color:red;font-weight:bold'>" + filter1 + "</span>") + "</span>";
                    else
                        tc.Text = tc.Text + dtr[2].ToString();
                }
                else if (tp.CompareTo("VEHICLE") == 0)
                {

                    tc.Text = dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red;font-weight:bold;'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[0].ToString() + "</span>";
                    tc.Text = tc.Text + " : <span style='font-weight:normal'>";
                    if (filter1.CompareTo("") > 0)
                        tc.Text = tc.Text + dtr[2].ToString().ToUpper().Replace(filter1, "<span style='color:red;font-weight:bold'>" + filter1 + "</span>") + "</span>";
                    else
                        tc.Text = tc.Text + dtr[2].ToString().ToUpper();
                }

                tr.Controls.Add(tc);
                tr.Controls.Add(cval);
                tr.Controls.Add(nval);
                tbl.Controls.Add(tr);
            }
            Response.Clear();
            Page.Controls.Add(tbl);
        }
    }

    private DataTable GetLocationTable(string pref_cst, string filt)
    {
        string strsql = "SELECT loccode,locname,codedesc FROM webx_location l WITH(NOLOCK) INNER JOIN webx_master_general g WITH(NOLOCK) ";
        strsql = strsql + " ON g.codeid=l.locregion  WHERE g.statuscode='Y' AND l.activeflag='Y'";
        strsql = strsql + " AND g.codetype='ZONE'";
        strsql = strsql + " AND (loccode LIKE '" + pref_cst + "%' OR locname LIKE '" + pref_cst + "%' OR locname LIKE '% " + pref_cst + "%' ";
        strsql = strsql + " OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '" + pref_cst + "%' OR codedesc LIKE '% " + pref_cst + "%')";
        strsql = strsql + " AND PATINDEX ('%' + CONVERT(VARCHAR,loc_level) + '%','" + filt + "')>0";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetCustomerTable(string pref_cst, string loc)
    {
        string strsql = "SELECT custcd,custnm,custloc FROM webx_custhdr";
        strsql = strsql + " WHERE (custcd LIKE '" + pref_cst + "%' OR custnm LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR custnm LIKE '% " + pref_cst + "%')";
        strsql = strsql + " AND custcd NOT IN ('P018888','P028888','P038888','P048888')";
        if (loc.CompareTo("") != 0)
        { strsql = strsql + " AND PATINDEx ('%" + loc + "%',custloc)>0 "; }
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }


    private DataTable GetCityTable(string pref_cst, string loc)
    {
        string strsql = "SELECT location,codedesc FROM webx_citymaster c INNER JOIN webx_master_general g ";
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
        sqlstr = sqlstr + " WHERE cm.custcd='" + custcd + "' AND city='" + city + "'";
        sqlstr = sqlstr + " AND (c.address LIKE '" + pref_addr + "%' OR c.address LIKE '% " + pref_addr + "%' ";
        sqlstr = sqlstr + " OR c.city LIKE '" + pref_addr + "%')";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
    }


    private DataTable GetPincode(string pref_pin, string city)
    {
        string strsql = "SELECT pincode,area,l.loccode FROM webx_pincode_loc_master p,webx_location l";
        strsql = strsql + " WHERE p.loccode=l.loccode AND l.loccity='" + city + "' AND l.activeflag='Y'";
        strsql = strsql + " AND (pincode LIKE '" + pref_pin + "%' OR area LIKE '% " + pref_pin + "%' ";
        strsql = strsql + " OR area LIKE '" + pref_pin + "%')";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetVendorTable(string pref_cst, string loc, string filterstr)
    {
        string strsql = "SELECT '8888' AS vendorcode,'Market Vendor' As vendorname,'8888' AS vendorbrcd UNION ALL SELECT h.vendorcode,h.vendorname,d.vendorbrcd FROM webx_vendor_hdr h WITH(NOLOCK) ";
        strsql = strsql + " INNER JOIN webx_vendor_det d WITH(NOLOCK) ON h.vendorcode=d.vendorcode  ";
        strsql = strsql + " WHERE (h.vendorcode LIKE '" + pref_cst + "%' OR vendorname LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR vendorname LIKE '% " + pref_cst + "%')";
        strsql = strsql + " AND h.vendorcode NOT IN ('8888','P018888','P028888','P038888','P048888')";
        if (loc.CompareTo("") != 0)
        { strsql = strsql + " AND PATINDEx ('%" + loc + "%',vendorbrcd)>0 "; }
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }
    private DataTable GetVendorCodeTable(string pref_cst, string loc, string filterstr)
    {
        string strsql = "SELECT '9888' AS vendorcode,'Market Vendor' As vendorname,'9888' AS vendorbrcd UNION ALL SELECT h.vendorcode,h.vendorname,d.vendorbrcd FROM webx_vendor_hdr h WITH(NOLOCK) ";
        strsql = strsql + " INNER JOIN webx_vendor_det d WITH(NOLOCK) ON h.vendorcode=d.vendorcode  ";
        strsql = strsql + " WHERE (h.vendorcode LIKE '" + pref_cst + "%' OR vendorname LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR vendorname LIKE '% " + pref_cst + "%')";
        strsql = strsql + " AND h.vendorcode NOT IN ('9888','P018888','P028888','P038888','P048888')";
        if (loc.CompareTo("") != 0)
        { strsql = strsql + " AND PATINDEx ('%" + loc + "%',vendorbrcd)>0 "; }
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetVehicle(string pref_cst, string VehicleType)
    {
        string strsql = "SELECT Distinct VEHNO,Type_Name,VENDORNAME FROM vw_VehicleDetails WITH(NOLOCK) ";
        strsql = strsql + " WHERE (VEHNO LIKE '" + pref_cst + "%' OR Type_Name Like '" + pref_cst + "%' OR ";
        strsql = strsql + " VENDORCODE Like '" + pref_cst + "%' OR VENDORNAME Like '" + pref_cst + "%')";
        if (VehicleType != "")
        {
            strsql = strsql + " AND Vehicle_Type = '" + VehicleType + "'";
        }
        //strsql = strsql + " order by Vehicle_Type";

        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }
}
