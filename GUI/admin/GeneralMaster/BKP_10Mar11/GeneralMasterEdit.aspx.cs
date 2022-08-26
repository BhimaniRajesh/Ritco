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

public partial class GUI_admin_GeneralMaster_GeneralMasterEdit : System.Web.UI.Page
{
    string mastercode = "",statuscode,mastertype,headeraccess;
    int i = 0;
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {

            mastercode = Request.QueryString["mastercode"].ToString();
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string s = "SELECT * FROM webx_master_codetypes WHERE headercode='" + mastercode + "' AND activeflag_YN='Y'";
            con.Open();
            SqlCommand cd = new SqlCommand(s, con);
            SqlDataReader dr = cd.ExecuteReader();
            dr.Read();
            lblmasterheader.Text = dr["headerdesc"].ToString();
            lblheadcode.Text = dr["id_desc"].ToString();
            lblheaddesc.Text = dr["name_desc"].ToString();
            dr.Close();

            s = "SELECT * FROM webx_master_general WHERE codetype='" + mastercode + "'";
            cd = new SqlCommand(s, con);
            dr = cd.ExecuteReader();
           
            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tccode = new TableCell();
                TableCell tcdesc = new TableCell();
                TableCell tcedit = new TableCell();
                TableCell tcdele = new TableCell();

                Label lblcode = new Label();
                Label lbldesc = new Label();
                TextBox txtdesc = new TextBox();
                Button btnedit = new Button();
                Button btnsave = new Button();
                Button btndele = new Button();

                lblcode.ID = "lblcode" + dr["codeid"].ToString();
                lbldesc.ID = "lbldesc" + dr["codeid"].ToString();
                txtdesc.ID = "txtdesc" + dr["codeid"].ToString();
                btnedit.ID = "btnedit" + dr["codeid"].ToString();
                btnsave.ID="btnsave" + dr["codeid"].ToString();
                btndele.ID = "btndele" + dr["codeid"].ToString();

                btndele.Attributes.Add("onclick", "javascript:return confirmDel()");
                btndele.Style["cursor"] = "pointer";
                btnedit.Style["cursor"] = "pointer";
                btnsave.Style["cursor"] = "pointer";

                lblcode.Text = dr["codeid"].ToString();
                lbldesc.Text = dr["codedesc"].ToString();
                btnedit.Text = "Edit";
                btnsave.Text = "Save";
                btndele.Text = "Delete";

                lblcode.CssClass = "blackfnt";
                lbldesc.CssClass = "blackfnt";
                txtdesc.CssClass = "blackfnt";
                btnedit.CssClass = "blackfnt";
                btnsave.CssClass = "blackfnt";
                btndele.CssClass = "redfnt";

                btnedit.Click += new System.EventHandler(editClick);
                btnsave.Click += new System.EventHandler(saveClick);
                btndele.Click += new System.EventHandler(deleClick);

                txtdesc.Style["display"] = "none";
                btnsave.Style["display"] = "none";

                tccode.Controls.Add(lblcode);
                tcdesc.Controls.Add(lbldesc);
                tcdesc.Controls.Add(txtdesc);
                tcedit.Controls.Add(btnedit);
                tcedit.Controls.Add(btnsave);
                tcdele.Controls.Add(btndele);

                tr.BackColor = System.Drawing.Color.White;
                
                tr.Cells.Add(tccode);
                tr.Cells.Add(tcdesc);
                tr.Cells.Add(tcedit);
                tr.Cells.Add(tcdele);

                tblitemlist.Rows.Add(tr);
            }
            dr.Close();       
    }

    protected void editClick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;       

        string subid = btn.ID.Substring(7,btn.ID.Length-7);
        TextBox txt = (TextBox)btn.Parent.Parent.FindControl("txtdesc" + subid);
        Label lbl = (Label)btn.Parent.Parent.FindControl("lbldesc" + subid);
        Button btnsave = (Button)btn.Parent.Parent.FindControl("btnsave" + subid);
        txt.Text = lbl.Text;

        txt.Style["display"] = "block";
        lbl.Style["display"] = "none";
        btn.Style["display"] = "none";
        btnsave.Style["display"] = "block";
        i++;
    }

    protected void saveClick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string subid = btn.ID.Substring(7, btn.ID.Length - 7);
        TextBox txt = (TextBox)btn.Parent.Parent.FindControl("txtdesc" + subid);
        Label lbl = (Label)btn.Parent.Parent.FindControl("lbldesc" + subid);
        Button btnedit = (Button)btn.Parent.Parent.FindControl("btnedit" + subid);
        lbl.Text = txt.Text;        

        //  UPDATION DEATILS LIKE name of employee, date of updation, ETC. ALSO NEEDED
        string s = "UPDATE webx_master_general SET codedesc='" + txt.Text + "',lastupdatedby='" + Session["empcd"].ToString() + "',lastupdateddate='" + DateTime.Now.ToString() + "' WHERE codeid='" + subid + "' AND codetype='" + mastercode + "'";
        
        SqlCommand cd = new SqlCommand(s, con);
        cd.ExecuteNonQuery();
        txt.Text = "";
        txt.Style["display"] = "none";
        lbl.Style["display"] = "block";
        btn.Style["display"] = "none";
        btnedit.Style["display"] = "block";
        i--;
    }

    protected void deleClick(object sender, EventArgs e)
    {
        //  DELETE RECORD FROM TABLE
        Button btn = (Button)sender;
        string subid = btn.ID.Substring(7, btn.ID.Length - 7);
        string s = "DELETE FROM webx_master_general WHERE codeid='" + subid + "' AND codetype='" + mastercode + "'";

        SqlCommand cd = new SqlCommand(s, con);
        cd.ExecuteNonQuery();
        Response.Redirect("GeneralMasterEdit.aspx?mastercode=" + mastercode);        
        
    }
}
