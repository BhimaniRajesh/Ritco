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
public partial class GUI_News_news: System.Web.UI.Page
{ SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        
         conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();


           string sql_News = "select Headline,News,color from webx_Customer_News_updates with(NOLOCK)  where id='N'";
        SqlCommand cmd1 = new SqlCommand(sql_News, conn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        tblNews.Visible = true;
        string st_news = "", st_colornews = "#000000", st_headline = "";
        while (dr1.Read())
        {

            if (dr1["Headline"] != null)
            {
                st_headline = dr1["Headline"].ToString();
            }
            if (dr1["News"] != null)
            {
                st_news = dr1["News"].ToString();
            }
            if (dr1["color"] != null)
            {
                st_colornews = dr1["color"].ToString();
            }

            if (st_colornews == "")
            {
                st_colornews = "#000000";
            }

            TableRow tr1 = new TableRow();

            TableCell tctr1 = new TableCell();


            tctr1.Text = "<font class=blackfnt color='" + st_colornews + "'> <p align=justify><Li><B>" + st_headline + "</B></Li> </p><font class=blackfnt color='" + st_colornews + "'> <p align=justify>" + st_news + " </p><br/>";
            tctr1.CssClass = " blackboldfnt";
            //tctr1.Wrap = false;
            //tctr1.ColumnSpan = ";
            tr1.BackColor = System.Drawing.Color.White;
            tr1.Cells.Add(tctr1);

            tblNews.Rows.Add(tr1);

            //TableRow tr12 = new TableRow();

            //TableCell tctr12 = new TableCell();

            //tctr12.Text = "<font class=blackfnt color='+st_colornews+'> <p align=justify>" + st_headline + " </p>";
            //tctr12.CssClass = " blackboldfnt";
            ////tctr1.Wrap = false;
            ////tctr1.ColumnSpan = ";
            //tr12.BackColor = System.Drawing.Color.White;
            //tr12.Cells.Add(tctr12);

            //tblNews.Rows.Add(tr12);

        }
        dr1.Close();

    }
}
