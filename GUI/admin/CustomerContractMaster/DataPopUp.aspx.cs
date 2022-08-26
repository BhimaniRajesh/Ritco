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

public partial class GUI_Finance_Billing_BillEdit_DataPopUp : System.Web.UI.Page
{
    string ctlid = "";
    protected string tbl = "", tp = "", mode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        mode = Request.QueryString["mode"].ToString();
        ctlid = Request.QueryString["ctlid"].ToString();
        tbl = Request.QueryString["tbl"].ToString();

        // TP IS USED FOR IMPORTANT PURPOSE IT DEFINES WHICH FUNCTION TO ALLOCATE
        // THIS PAGE IS USED BY MANY OTHER PAGES IT IDENTIFIES TYPE OF FUNCION AND ACCORDINGLY ALLOCATES FUNCIONS
        tp = Request.QueryString["tp"].ToString();


        if (mode.CompareTo("branch") == 0)
        {
            lblcodename.Text = "Branch Code";
            lblname.Text = "Branch Name";
        }
        else if (mode.CompareTo("zone") == 0)
        {
            lblcodename.Text = "Zone Name";
            trlocname.Style["display"] = "none";
        }
        else if (mode.CompareTo("city") == 0)
        {
            lblcodename.Text = "City Name";
            trlocname.Style["display"] = "none";
        }

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string qry = "";
        if (mode.CompareTo("branch") == 0)
        {
            qry = "SELECT loccode,locname,loccode as val FROM webx_location WHERE loccode LIKE '" + txtlocation.Text + "%' AND locname LIKE '" + txtlocationname.Text.Trim() + "%' ORDER BY locname";
        }
        else if (mode.CompareTo("zone") == 0)
        {
            qry = "SELECT codeid,codedesc,codedesc as val FROM webx_master_general WHERE UPPER(codetype)='ZONE' AND codedesc LIKE '" + txtlocation.Text + "%' ORDER BY codedesc";
        }
        else if (mode.CompareTo("city") == 0)
        {
            qry = "SELECT location AS loccode,location,location as val FROM webx_citymaster WHERE location LIKE '" + txtlocation.Text + "%' ORDER BY location";
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand(qry, con);

        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        TableRow trhead = new TableRow();

        TableCell tcheadra = new TableCell();
        TableCell tcheadname = new TableCell();
        TableCell tcheadlocname = new TableCell();

        if (mode.CompareTo("branch") == 0)
        {
            tcheadlocname.Text = "Location Name";
            tcheadname.Text = "Location Code";
        }
        else if (mode.CompareTo("zone") == 0)
        {
            tcheadlocname.Text = "Zone Name";
            tcheadname.Text = "Zone Code";
            tcheadname.Style["display"] = "none";
        }
        else if (mode.CompareTo("city") == 0)
        {
            tcheadlocname.Text = "City Name";
            tcheadname.Text = "City Code";
        }
        tcheadra.Text = "Select";

        tcheadra.CssClass = "blackfnt";
        tcheadlocname.CssClass = "blackfnt";
        tcheadname.CssClass = "blackfnt";

        trhead.Cells.Add(tcheadra);
        trhead.Cells.Add(tcheadname);
        trhead.Cells.Add(tcheadlocname);
        trhead.CssClass = "bgbluegrey";

        tbllist.Rows.Add(trhead);

        while (dr.Read())
        {
            TableRow tr = new TableRow();

            TableCell tcra = new TableCell();
            TableCell tcname = new TableCell();
            TableCell tclocname = new TableCell();
            RadioButton rad = new RadioButton();
            

            tr.BackColor = System.Drawing.Color.White;
            tcname.CssClass = "blackfnt";
            tcname.HorizontalAlign = HorizontalAlign.Left;
            tclocname.HorizontalAlign = HorizontalAlign.Left;
            tbllist.CssClass = "blackfnt";
            tclocname.CssClass = "blackfnt";

            rad.GroupName = "grplist";
            rad.ID = "rad" + dr[0].ToString();

         
              string strvalue = Convert.ToString(dr["val"]);


            if (tp.CompareTo("head") == 0)
                rad.Attributes.Add("onclick", "javascript:return radHeadClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + strvalue + "')");
            else if (tp.CompareTo("4head") == 0)
                rad.Attributes.Add("onclick", "javascript:return rad4HeadClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + strvalue + "')");
            else if (tp.CompareTo("4row") == 0)
                rad.Attributes.Add("onclick", "javascript:return rad4RowClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + strvalue + "')");
            else
                rad.Attributes.Add("onclick", "javascript:return radClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + strvalue + "')");

            tcname.Text = dr[0].ToString();
            if (mode.CompareTo("zone") == 0)
                tcname.Style["display"] = "none";

            tclocname.Text = dr[1].ToString();
            tcra.Controls.Add(rad);

            tr.Cells.Add(tcra);
            tr.Cells.Add(tcname);
            tr.Cells.Add(tclocname);
            tbllist.Rows.Add(tr);
        }
        dr.Close();
        con.Close();


    }
}
