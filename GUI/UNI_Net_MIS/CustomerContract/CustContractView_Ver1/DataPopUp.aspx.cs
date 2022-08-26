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
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_Operation_Singlescreen_docketentry_DataPopUp : System.Web.UI.Page
{
    string poptp = "";
    string code1 = "", code2 = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        string scr = "";
        poptp = Request.QueryString["poptp"].ToString();
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sqlstr = "";
        td2.Text = "Customer Code";
        td3.Text = "Customer Name";
              
        sqlstr = "SELECT custcd,custnm FROM webx_custhdr WHERE cust_active='Y' ORDER BY custnm";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            TableRow tr = new TableRow();
            tr.BackColor = System.Drawing.Color.White;
            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();

            CheckBox chk = new CheckBox();

            if (poptp.CompareTo("custcd") == 0)
            {
                chk.ID = "chk" + i.ToString();
                tc2.ID = "tc1" + i.ToString();
                tc3.ID = "tc2" + i.ToString();

                tc2.Text = dr["custcd"].ToString();
                tc3.Text = dr["custnm"].ToString();
            }

            tc1.Controls.Add(chk);

            chk.CssClass = "blackfnt";
            tc2.CssClass = "blackfnt";
            tc3.CssClass = "blackfnt";

            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            tr.Cells.Add(tc3);

            tblmain.Rows.Add(tr);
            i++;
        }
        dr.Close();
    }


}
