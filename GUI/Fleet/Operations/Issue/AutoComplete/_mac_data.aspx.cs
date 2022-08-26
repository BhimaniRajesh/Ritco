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
using System.Data.SqlClient;

public partial class GUI_Fleet_Reports_AutoComplete__mac_data : System.Web.UI.Page
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
            if (tp.CompareTo("DRIVER") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetDriverTable(code1, filter1);
            }
            else if (tp.CompareTo("VEHICLE") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetVehicleTable(code1, filter1);
            }
            else if (tp.CompareTo("DRIVERVALIDATION") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetDriverTableWithValidation(code1, filter1);
            }
            else if (tp.CompareTo("VEHICLEVALIDATION") == 0)
            {
                code1 = Request.QueryString["code1"].ToString().ToUpper();
                dt = GetVehicleTableWithValidation(code1, filter1);
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

                if (tp.CompareTo("DRIVER") == 0)
                {
                    t_val3.Text = dtr[2].ToString();
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("VEHICLE") == 0)
                {
                    t_val3.Text = dtr[2].ToString();
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("DRIVERVALIDATION") == 0)
                {
                    t_val3.Text = dtr[2].ToString();
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }
                else if (tp.CompareTo("VEHICLEVALIDATION") == 0)
                {
                    t_val3.Text = dtr[2].ToString();
                    tc.Text = dtr[0].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + " : " + dtr[1].ToString().ToUpper().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "<br /><span style='font-weight:normal'>" + dtr[2].ToString().Replace(code1.ToUpper(), "<span style='color:red'>" + code1.ToUpper() + "</span>");
                    tc.Text = tc.Text + "</span>";
                }

                if (target2.CompareTo("") == 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:abc();return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + ",null,null,'" + divid + "')");
                else if (target2.CompareTo("") == 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:abc();return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + ",null," + target3 + ",'" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") == 0)
                    tc.Attributes.Add("onclick", "javascript:abc();return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + "," + target2 + ",null,'" + divid + "')");
                else if (target2.CompareTo("") != 0 && target3.CompareTo("") != 0)
                    tc.Attributes.Add("onclick", "javascript:abc();return dacItemClick('" + cval.Text + "','" + nval.Text.ToUpper() + "','" + t_val3.Text + "'," + target1 + "," + target2 + "," + target3 + ",'" + divid + "')");


                tr.Controls.Add(tc);
                tr.Controls.Add(cval);
                tr.Controls.Add(nval);
                tr.Controls.Add(t_val3);
                tbl.Controls.Add(tr);
            }

            Page.Controls.Add(tbl);

        }

    }

    private DataTable GetDriverTable(string pref_cst, string loc)
    {
        string strsql = "SELECT Driver_id,Driver_Name,VEHNO FROM WEBX_FLEET_DRIVERMST ";
        strsql = strsql + " WHERE (Driver_id LIKE '" + pref_cst + "%' OR Driver_Name LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR Driver_Name LIKE '% " + pref_cst + "%' OR PATINDEx ('%" + pref_cst + "%',VEHNO)>0 )";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }
    private DataTable GetVehicleTable(string pref_cst, string loc)
    {
        string strsql = "SELECT VEHNO,VT.[TYPE_NAME],CONRTL_BRANCH FROM WEBX_VEHICLE_HDR as VH inner join webx_Vehicle_Type as VT on VH.vehicle_type=vt.type_code  ";
        strsql = strsql + " WHERE (VEHNO LIKE '" + pref_cst + "%' OR TYPE_NAME LIKE '" + pref_cst + "%'";
        strsql = strsql + " OR TYPE_NAME LIKE '% " + pref_cst + "%' OR PATINDEx ('%" + pref_cst + "%',CONRTL_BRANCH)>0 )";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    private DataTable GetDriverTableWithValidation(string pref_cst, string loc)
    {
        var prm = new SqlParameter[]
         {
             new SqlParameter("@Prefix", pref_cst),
             new SqlParameter("@Location", loc),
         };
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GetDriverTableWithValidation", prm).Tables[0];
    }
    private DataTable GetVehicleTableWithValidation(string pref_cst, string loc)
    {
        var prm = new SqlParameter[]
         {
             new SqlParameter("@Prefix", pref_cst),
             new SqlParameter("@Location", loc),
         };
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GetVehicleTableWithValidation", prm).Tables[0];
    }
}
