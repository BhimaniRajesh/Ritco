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
    protected string tbl = "",tp="";
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        ctlid=Request.QueryString["ctlid"].ToString();
        tbl = Request.QueryString["tbl"].ToString();
        
        
        // TP IS USED FOR IMPORTANT PURPOSE IT DEFINES WHICH FUNCTION TO ALLOCATE
        // THIS PAGE IS USED BY MANY OTHER PAGES IT IDENTIFIES TYPE OF FUNCION AND ACCORDINGLY ALLOCATES FUNCIONS
        tp=Request.QueryString["tp"].ToString();



        string qry = "";
        if (mode.CompareTo("branch") == 0)
        {
            qry = "SELECT loccode,locname FROM webx_location";
        }
        else if (mode.CompareTo("zone") == 0)
        {
            qry = "SELECT codedesc,codedesc FROM webx_master_general WHERE UPPER(codetype)='ZONE'";
        }
        else if (mode.CompareTo("city") == 0)
        {
            qry = "SELECT location,location FROM webx_citymaster";
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

            tcheadlocname.Text = "Location Name";
            tcheadname.Text = "Location Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass="blackfnt";
            tcheadname.CssClass="blackfnt";

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
                if(tp.CompareTo("head")==0)
                    rad.Attributes.Add("onclick", "javascript:return radHeadClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");
                else if(tp.CompareTo("4head")==0)
                    rad.Attributes.Add("onclick", "javascript:return rad4HeadClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");
                else if(tp.CompareTo("4head")==0)
                    rad.Attributes.Add("onclick", "javascript:return rad4RowClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");
                else if (tp.CompareTo("4row") == 0)
                    rad.Attributes.Add("onclick", "javascript:return rad4RowClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");
                else
                    rad.Attributes.Add("onclick", "javascript:return radClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");


                tcname.Text = dr[0].ToString();
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

    protected void btnpartysubmit_Click(object sender, EventArgs e)
    {
        string qry = "";


        if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
        {
            qry = "SELECT distinct custcd,custnm from webx_custhdr";
        }
        else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
        {
            qry = "SELECT distinct custcd,custnm from webx_custhdr WHERE custcd like '" + txtcustcode.Text.ToString() + "%'";
        }
        else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
        {
            qry = "SELECT distinct custcd,custnm from webx_custhdr WHERE custnm like '" + txtcustname.Text.ToString() + "%'";        
        }
        else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
        {
            qry = "SELECT distinct custcd,custnm from webx_custhdr WHERE custnm like '" + txtcustname.Text.ToString() + "%' and custcd like '" + txtcustcode.Text.ToString() + "%'";
        }
       
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            TableRow tr = new TableRow();

            TableCell tcra = new TableCell();
            TableCell tccode = new TableCell();
            TableCell tcname = new TableCell();
            RadioButton rad = new RadioButton();

            tr.BackColor = System.Drawing.Color.White;
            tcname.CssClass = "blackfnt";
            tbllist.CssClass = "blackfnt";
            tccode.CssClass = "blackfnt";
            tccode.HorizontalAlign = HorizontalAlign.Left;
            tcname.HorizontalAlign = HorizontalAlign.Left;
            
            rad.GroupName = "grplist";
            rad.ID = "rad" + dr["custcd"].ToString();
            rad.Attributes.Add("onclick", "javascript:return radClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");

            tccode.Text = dr[0].ToString();
            tcname.Text = dr[1].ToString();
            tcra.Controls.Add(rad);

            tr.Cells.Add(tcra);
            tr.Cells.Add(tccode);           
            tr.Cells.Add(tcname);

            tbllist.Rows.Add(tr);
        }
        dr.Close();
        con.Close();
    }
}
