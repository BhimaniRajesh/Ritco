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

public partial class GUI_Octroi_ViewnPrint_PaymentTypeMasterEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnupdate.Attributes.Add("onclick", "javascript:return validateFields()");
        btncancel.Attributes.Add("onclick","javascript:return closeDiv()");
        chkeditflag.Attributes.Add("onclick", "javascript:return ticTac(this);");

        lbleditscreen.Attributes.Add("onmouseover", "this.style.cursor='move'");
        lbleditscreen.Attributes.Add("onmousedown", "drab(this.getAttribute('id'))");

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        string qrypos = "SELECT * FROM webx_typemst";
        SqlCommand cmd = new SqlCommand(qrypos, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {
                i++;
                TableRow tr = new TableRow();
                tr.BackColor = System.Drawing.Color.White;

                TableCell tcsrno = new TableCell();
                TableCell tccode = new TableCell();
                TableCell tcshort = new TableCell();
                TableCell tcflag = new TableCell();
                TableCell tcdel = new TableCell();

                TableCell tccheck = new TableCell();

                Label lblsrno = new Label();
                LinkButton lblcode = new LinkButton();
                Label lblshort = new Label();
                Label lblflag = new Label();
                Button btndel = new Button();

                lblsrno.CssClass = "blackfnt";
                lblshort.CssClass = "blackfnt";
                lblflag.CssClass = "blackfnt";
                
              
                lblcode.ID="lbl" + dr["codetype_new"].ToString();
                btndel.ID="btndel" + dr["codetype_new"].ToString();
               // btndel.Attributes.Add("Onclick","btndel_Click");
                btndel.Click += new System.EventHandler(btndel_Click);
                btndel.Text = "Delete";

                lblsrno.Text = i.ToString();
                lblcode.Text = dr["codetype_new"].ToString();
                lblshort.Text = dr["abbr_type"].ToString();
                lblflag.Text = dr["activeflag"].ToString();

                lblcode.Attributes.Add("onclick", "javascript:return openDiv('" + lblcode.ClientID.ToString() + "','" + lblcode.Text.ToString() + "')");

                tcsrno.Controls.Add(lblsrno);
                tccode.Controls.Add(lblcode);
                tcshort.Controls.Add(lblshort);
                tcflag.Controls.Add(lblflag);
                tcdel.Controls.Add(btndel);
                

                tr.Cells.Add(tcsrno);
                tr.Cells.Add(tccode);
                tr.Cells.Add(tcshort);
                tr.Cells.Add(tcflag);
                tr.Cells.Add(tcdel);

                tbltypelist.Rows.Add(tr);
            }
            dr.Close();
    }
       



    protected void btndone_Click(object sender, EventArgs e)
    {

    }

    protected void btnadd_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentTypeMaster.aspx");
    }

    protected void btndel_Click(object sender, EventArgs e)
    {

        Button btn = (Button)sender;
        string id=btn.ID;
        int len = 0;
        len = id.Length;

        string code = id.Substring(6, len-6);

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string qry = "DELETE FROM webx_typemst WHERE codetype_new='" + code + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("PaymentTypeMasterEdit.aspx");

    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "UPDATE  webx_typemst SET abbr_type='" + txteditshortdesc.Text + "',typedesc='" + txteditdetdesc.Text + "',activeflag='" + txteditflag.Text + "' WHERE codetype_new='" +  hdncode.Value + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("PaymentTypeMasterEdit.aspx");
    }


 }
