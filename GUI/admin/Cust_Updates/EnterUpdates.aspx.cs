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

public partial class GUI_admin_Updates_EnterUpdates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
            btnsubmit.Attributes.Add("onclick", "javascript:return validateText()");
            btncolbar.Attributes.Add("onclick", "javascript:return setRowNum(this.getAttribute('id'))");
            btncolbar.Attributes.Add("onmouseover", "this.style.cursor='pointer'");

            string[,] arrstr = new string[6, 8];
            arrstr[0, 0] = "#ffffff";
            arrstr[0, 1] = "#ffc3c6";
            arrstr[0, 2] = "#ffe3c6";
            arrstr[0, 3] = "#ffffc6";
            arrstr[0, 4] = "#c6ffc6";
            arrstr[0, 5] = "#c6ffff";
            arrstr[0, 6] = "#c6c3ff";
            arrstr[0, 7] = "#ffc3ff";

            arrstr[1, 0] = "#e7e3e7";
            arrstr[1, 1] = "#ff8284";
            arrstr[1, 2] = "#ffc384";
            arrstr[1, 3] = "#ffff84";
            arrstr[1, 4] = "#84ff84";
            arrstr[1, 5] = "#84ffff";
            arrstr[1, 6] = "#8482ff";
            arrstr[1, 7] = "#ff82ff";


            arrstr[2, 0] = "#c6c3c6";
            arrstr[2, 1] = "#ff0000";
            arrstr[2, 2] = "#ff8200";
            arrstr[2, 3] = "#ffff00";
            arrstr[2, 4] = "#00ff00";
            arrstr[2, 5] = "#00ffff";
            arrstr[2, 6] = "#00ffff";
            arrstr[2, 7] = "#ff00ff";


            arrstr[3, 0] = "#848284";
            arrstr[3, 1] = "#c60000";
            arrstr[3, 2] = "#c6c300";
            arrstr[3, 3] = "#c6c300";
            arrstr[3, 4] = "#00c300";
            arrstr[3, 5] = "#00c3c6";
            arrstr[3, 6] = "#0000c6";
            arrstr[3, 7] = "#c600c6";


            arrstr[4, 0] = "#424142";
            arrstr[4, 1] = "#840000";
            arrstr[4, 2] = "#844100";
            arrstr[4, 3] = "#848200";
            arrstr[4, 4] = "#008200";
            arrstr[4, 5] = "#008284";
            arrstr[4, 6] = "#000084";
            arrstr[4, 7] = "#840084";


            arrstr[5, 0] = "#000000";
            arrstr[5, 1] = "#420000";
            arrstr[5, 2] = "#844142";
            arrstr[5, 3] = "#424100";
            arrstr[5, 4] = "#848200";
            arrstr[5, 5] = "#004142";
            arrstr[5, 6] = "#000042";
            arrstr[5, 7] = "#420042";


            for (int i = 0; i < 6; i++)
            {
                TableRow tr = new TableRow();
                for (int j = 0; j < 8; j++)
                {
                    TableCell tc = new TableCell();
                    Button lbl = new Button();
                    lbl.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
                    lbl.Attributes.Add("onclick", "javascript:document.getElementById('ctl00_MyCPH1_divcolorpan').style.display='none'");
                    lbl.Attributes.Add("runat", "server");
                    
                    lbl.Click += new System.EventHandler(lbl_Click);
                    lbl.BorderStyle = System.Web.UI.WebControls.BorderStyle.Groove;
                    lbl.Width = 15;
                    lbl.Height = 15;
                    lbl.BackColor = System.Drawing.Color.FromName(arrstr[i, j].ToString());

                    tc.Controls.Add(lbl);
                    tr.Cells.Add(tc);
                }
                tblcolorpan.Rows.Add(tr);
            }
            txtnews_colorname.Text = "#000000";

    }

    protected void lbl_Click(object sender, EventArgs e)
    {
        Button lnk = (Button)sender;
        txtnews_colorname.Text = lnk.BackColor.Name.ToString();
        btncolbar.BackColor = System.Drawing.Color.FromName(txtnews_colorname.Text);
    }

   
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
       
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "SELECT count(id) FROM webx_Customer_News_updates";
        SqlCommand cm =new SqlCommand(sql,con);
        int i = (int)cm.ExecuteScalar();
        string sq="";
        if (i == 0)
            sq = "INSERT INTO webx_Customer_News_updates(headline,news,updates,id,color) VALUES('','','" + txtupdates.Text + "','U','" + txtnews_colorname.Text + "')";
        else
        sq = "UPDATE webx_Customer_News_updates SET updates='" + txtupdates.Text + "',color='" + txtnews_colorname.Text + "' WHERE ID='U'";
        cm = new SqlCommand(sq, con);
        cm.ExecuteNonQuery();
        con.Close();

        Response.Redirect("../../welcome.aspx");
    }


}
