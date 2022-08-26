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

public partial class GUI_Operation_Singlescreen_docketentry_DataPopUp : System.Web.UI.Page
{
    string poptp = "";
    string code1 = "", code2 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = "";
        poptp = Request.QueryString["poptp"].ToString();
        td1.Text = "Select";
        if (poptp.CompareTo("csgn") == 0)
        {
            // Setting Table Header
            td2.Text = "Consignor Code";
            td3.Text = "Consignor Name";

            tdlblsel1.Text = "Consignor Code";
            tdlblsel2.Text = "Consignor Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();

        }
        else if (poptp.CompareTo("party") == 0)
        {
            // Setting Table Header
            td2.Text = "Party Code";
            td3.Text = "Party Name";

            tdlblsel1.Text = "Party Code";
            tdlblsel2.Text = "Party Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();

        }
        else if (poptp.CompareTo("csge") == 0)
        {
            // Setting Table Header
            td2.Text = "Consignee Code";
            td3.Text = "Consignee Name";

            tdlblsel1.Text = "Consignee Code";
            tdlblsel2.Text = "Consignee Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("delloc") == 0)
        {
            td2.Text = "Location Code";
            td3.Text = "Location Name";

            tdlblsel1.Text = "Location Code";
            tdlblsel2.Text = "Location Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("billloc") == 0)
        {
            td2.Text = "Location Code";
            td3.Text = "Location Name";

            tdlblsel1.Text = "Location Code";
            tdlblsel2.Text = "Location Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("fromcity") == 0)
        {
            td2.Text = "From City";
            trsel2.Style["display"] = "none";
            td1.Style["display"] = "none";

            tdlblsel1.Text = "City Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("tocity") == 0)
        {
            td2.Text = "To City";
            trsel2.Style["display"] = "none";
            td1.Style["display"] = "none";

            tdlblsel1.Text = "City Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("csgncity") == 0)
        {
            td2.Text = "Consignor City";
            trsel2.Style["display"] = "none";
            td1.Style["display"] = "none";

            tdlblsel1.Text = "City Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("csgecity") == 0)
        {
            td2.Text = "Consignee City";
            trsel2.Style["display"] = "none";
            td1.Style["display"] = "none";

            tdlblsel1.Text = "City Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }
        else if (poptp.CompareTo("partyedit") == 0)
        {
            // Setting Table Header
            td2.Text = "Party Code";
            td3.Text = "Party Name";

            tdlblsel1.Text = "Party Code";
            tdlblsel2.Text = "Party Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();

        }
        else if (poptp.CompareTo("editsearchparty") == 0)
        {
            // Setting Table Header
            td2.Text = "Party Code";
            td3.Text = "Party Name";

            tdlblsel1.Text = "Party Code";
            tdlblsel2.Text = "Party Name";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();

        }
        else if (poptp.CompareTo("billedatedit") == 0)
        {
            td2.Text = "Location";
            trsel2.Style["display"] = "none";
            td1.Style["display"] = "none";

            tdlblsel1.Text = "Location Code";

            code1 = Request.QueryString["code1"].ToString();
            code2 = Request.QueryString["code2"].ToString();
        }



    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con;
        try
        {

             con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("../ErrorPage.aspx?headig=Session Expired&detail1=" + ex.Message.Replace('\n', '_') + "&suggestion1=Log on Again");
            return;
        }

        string sqlstr = "";
        if (poptp.CompareTo("csgn") == 0 || poptp.CompareTo("csge") == 0 || poptp.CompareTo("party") == 0 || poptp.CompareTo("partyedit") == 0)
        {
            //sqlstr = "SELECT  DISTINCT custcd,custnm  FROM webx_custhdr  WHERE custcd IS NOT NULL AND PATINDEX ('%" + Session["brcd"].ToString() + "%',CUSTLOC)>0 ORDER BY custnm";
            string custloc = Request.QueryString["code3"].ToString();
            sqlstr = "SELECT  DISTINCT custcd,custnm  FROM webx_custhdr  WHERE PATINDEx ('%" + custloc + "%',custloc)>0 AND cust_active='Y' AND custcd like '" + txt1.Text.Trim() + "%' AND custnm like '" + txt2.Text.Trim() + "%' AND custcd IS NOT NULL  ORDER BY custnm";
        }
        else if (poptp.CompareTo("delloc") == 0)
        {
            if (Session["client"].ToString().CompareTo("RLL") == 0)
                sqlstr = "SELECT DISTINCT loccode,locname FROM webx_location WHERE loc_level<>'1' AND loc_level<>'2' AND loccode like '" + txt1.Text.Trim() + "%' AND loccode IS NOT NULL AND locname like '" + txt2.Text + "%' AND activeflag='Y' ORDER BY loccode";
            else
                sqlstr = "SELECT DISTINCT loccode,locname FROM webx_location WHERE loccode like '" + txt1.Text.Trim() + "%' AND loccode IS NOT NULL AND locname like '" + txt2.Text + "%' AND activeflag='Y' ORDER BY loccode";
        }
        else if (poptp.CompareTo("billloc") == 0 || poptp.CompareTo("billedatedit") == 0)
        {
            sqlstr = "SELECT DISTINCT loccode,locname FROM webx_location WHERE loccode like '" + txt1.Text.Trim() + "%' AND loccode IS NOT NULL AND locname like '" + txt2.Text + "%' AND activeflag='Y' ORDER BY loccode";
        }
        else if (poptp.CompareTo("fromcity") == 0 || poptp.CompareTo("tocity") == 0)
        {
            if (Session["client"].ToString().CompareTo("ASL") == 0 || Session["client"].ToString().CompareTo("RLL") == 0)
            {
                string loccode = Request.QueryString["code2"].ToString();
                sqlstr = "SELECT DISTINCT location FROM webx_citymaster WHERE book_loc='" + loccode + "' AND location like '" + txt1.Text.Trim() + "%' AND activeflag='Y' ORDER BY location";
            }
            else
                 sqlstr = "SELECT DISTINCT location FROM webx_citymaster WHERE location like '" + txt1.Text.Trim() + "%' AND activeflag='Y' ORDER BY location";
        }
        else if (poptp.CompareTo("csgncity") == 0 || poptp.CompareTo("csgecity") == 0)
        {
            sqlstr = "SELECT DISTINCT location FROM webx_citymaster WHERE location like '" + txt1.Text.Trim() + "%' AND activeflag='Y' ORDER BY location";
        }
        else if (poptp.CompareTo("editsearchparty") == 0)
        {
            sqlstr = "SELECT  DISTINCT custcd,custnm  FROM webx_custhdr  WHERE cust_active='Y' AND custcd like '" + txt1.Text.Trim() + "%' AND custnm like '" + txt2.Text.Trim() + "%' AND custcd IS NOT NULL  ORDER BY custnm";
        }




        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            TableRow tr = new TableRow();
            tr.BackColor = System.Drawing.Color.White;
            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();

            RadioButton rad = new RadioButton();
            rad.GroupName = "one";


            if (poptp.CompareTo("csgn") == 0 || poptp.CompareTo("csge") == 0 || poptp.CompareTo("party") == 0 || poptp.CompareTo("partyedit") == 0)
            {
                rad.ID = "rad" + dr["custcd"].ToString();
                tc2.ID = "tc1" + dr["custcd"].ToString();
                tc3.ID = "tc2" + dr["custcd"].ToString();

                tc2.Text = dr["custcd"].ToString();
                tc3.Text = dr["custnm"].ToString();
            }
            if (poptp.CompareTo("editsearchparty") == 0)
            {
                rad.ID = "rad" + dr["custcd"].ToString();
                tc2.ID = "tc1" + dr["custcd"].ToString();
                tc3.ID = "tc2" + dr["custcd"].ToString();

                tc2.Text = dr["custcd"].ToString();
                tc3.Text = dr["custnm"].ToString();
            }
            else if (poptp.CompareTo("delloc") == 0 || poptp.CompareTo("billloc") == 0 || poptp.CompareTo("billedatedit") == 0)
            {
                rad.ID = "rad" + dr["loccode"].ToString();
                tc2.ID = "tc1" + dr["loccode"].ToString();
                tc3.ID = "tc2" + dr["loccode"].ToString();

                tc2.Text = dr["loccode"].ToString();
                tc3.Text = dr["locname"].ToString();
            }
            else if (poptp.CompareTo("fromcity") == 0 || poptp.CompareTo("tocity") == 0 || poptp.CompareTo("csgncity") == 0 || poptp.CompareTo("csgecity") == 0)
            {
                rad.ID = "rad" + dr["location"].ToString();
                tc2.ID = "tc1" + dr["location"].ToString();
                tc3.ID = "tc2" + dr["location"].ToString();

                tc2.Text = dr["location"].ToString();
                tc3.Text = dr["location"].ToString();

                tc3.Style["display"] = "none";
            }

            rad.Attributes.Add("onclick", "javascript:return selectItem('" + poptp + "','" + tc2.Text.ToUpper() + "','" + tc3.Text.ToUpper() + "')");

            tc1.Controls.Add(rad);

            rad.CssClass = "blackfnt";
            tc2.CssClass = "blackfnt";
            tc3.CssClass = "blackfnt";

            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            tr.Cells.Add(tc3);

            tblmain.Rows.Add(tr);
        }
        dr.Close();

    }

}
