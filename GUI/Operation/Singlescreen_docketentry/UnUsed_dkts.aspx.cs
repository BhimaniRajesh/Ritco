using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Operation_Singlescreen_docketentry_UnUsed_dkts : System.Web.UI.Page
{
    SqlConnection conn;
    public static string Sr_from, Sr_to, brcd, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string[] sries_Arr = Request.QueryString["series"].ToString().Split('-');
        Sr_from = sries_Arr[0].ToString().Trim();
        Sr_to = sries_Arr[1].ToString().Trim();

        string SQL_grid = "EXEC usp_unused_dockets_in_range '" + Sr_from + "','" + Sr_to + "'";
        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataReader dr = sqlcmd12.ExecuteReader();


        TableRow tr2 = new TableRow();

        TableCell tr2c1 = new TableCell();
        tr2c1.Text = Sr_from + " - " + Sr_to;
        tr2c1.CssClass = "blackboldfnt";
        tr2c1.HorizontalAlign = HorizontalAlign.Center;
        // tr2c1.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2c1);

        tblUnUsedDktlist.Rows.Add(tr2);
        string dktlist = "";
        int i = 0,intResult;
        i = 1;
        
        while (dr.Read())
        {
            if (dktlist == "")
            {
                dktlist = dr[0].ToString();
            }
            else
            {
               
                dktlist = dktlist +","+ dr[0].ToString();

                
            }

            i = i + 1;
            System.Math.DivRem(i, 5, out intResult);
            if (intResult == 1)
            {
                dktlist = dktlist + "<br>";
            }
        }
        dr.Close();

        TableRow tr21 = new TableRow();

        TableCell tr21c1 = new TableCell();
        tr21c1.Text = dktlist;
        tr21c1.CssClass = "blackfnt";
        tr21c1.HorizontalAlign = HorizontalAlign.Center;
        // tr2c1.Wrap = false;
        
        tr21.Cells.Add(tr21c1);
        tr21.BackColor = System.Drawing.Color.White;
        tblUnUsedDktlist.Rows.Add(tr21);
        brcd = Session["brcd"].ToString();
        dkt_call = Session["DocketCalledAs"].ToString();
        conn.Close();
    }
}
