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

public partial class GUI_View_Track_Operation_Docket_Movement : System.Web.UI.Page
{
    public static string call_dkt, THC_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();

        string sqlstr = "exec WebxNet_Movement '" + str_dockno + "','" + str_docksf + "' ";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();


        TableRow tr1 = new TableRow();
        TableCell tr1tc = new TableCell();
        tr1tc.Text = THC_call + " No.<br/>Vehicle No.";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1tc.RowSpan = 2;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Location";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.RowSpan = 2;
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Transit <br/>Time";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.RowSpan = 2;
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Stopage <br/>Time";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.RowSpan = 2;
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Arrivals [In]";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.ColumnSpan = 4;
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);


        tr1tc = new TableCell();
        tr1tc.Text = "Departures [Out]";
        tr1tc.ColumnSpan = 4;
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);

        tr1tc = new TableCell();
        tr1tc.Text = "Route";
        tr1tc.CssClass = "blackboldfnt";
        tr1tc.RowSpan = 2;
        tr1tc.Wrap = false;
        tr1.Cells.Add(tr1tc);


        tr1.CssClass = "bgbluegrey";
        tr1.BorderWidth = 1;
        tr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.BorderColor = System.Drawing.Color.Gray;

        tblMovement.Rows.Add(tr1);

        TableRow tr2 = new TableRow();
        TableCell tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;STA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;ETA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;ATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "Late/<br>Early [Hrs.]";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;STD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;ETD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;ATD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);

        tr2tc = new TableCell();
        tr2tc.Text = "Late/<br>Early [Hrs.]";
        tr2tc.CssClass = "blackboldfnt";
        tr2tc.Wrap = false;
        tr2.Cells.Add(tr2tc);


        tr2.CssClass = "bgbluegrey";
        tr2.BorderWidth = 1;
        tr2.HorizontalAlign = HorizontalAlign.Center;
        tr2.BorderColor = System.Drawing.Color.Gray;

        tblMovement.Rows.Add(tr2);


        while (dr.Read())
        {
            TableRow tr3 = new TableRow();
            TableCell tr3tc = new TableCell();
            tr3tc.Text = dr["THCNo"].ToString() + "<br/><font class='bluefnt' ><i>" + dr["vehno"].ToString() + "</i></font >";
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["sourcehb"].ToString() ;
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["Transit_Time"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["Stoppage_Time"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["STA"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.ForeColor = System.Drawing.Color.Blue;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["ETA"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.ForeColor = System.Drawing.Color.DeepPink;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["ATA"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["Arrv_L_E"].ToString();
            if (dr["Arrv_L_E"].ToString() != "")
            {
                if (dr["Arrv_L_E"].ToString().Substring(0, 4) == "Late")
                    tr3tc.CssClass = "redfnt";
                else if (dr["Arrv_L_E"].ToString().Substring(0, 5) == "Early")
                    tr3tc.ForeColor = System.Drawing.Color.DarkGreen;
                else
                    tr3tc.CssClass = "blackfnt";
            }
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["STD"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.ForeColor = System.Drawing.Color.Blue;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["ETD"].ToString();
            tr3tc.ForeColor = System.Drawing.Color.DeepPink;
            tr3tc.CssClass = "blackfnt";
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["ATD"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text = dr["Dept_L_E"].ToString();
            //tr3tc.CssClass = "blackfnt";
            if (dr["Dept_L_E"].ToString() != "")
            {
                if (dr["Dept_L_E"].ToString().Substring(0, 4) == "Late")
                    tr3tc.CssClass = "redfnt";
                else if (dr["Dept_L_E"].ToString().Substring(0, 5) == "Early")
                    tr3tc.ForeColor = System.Drawing.Color.DarkGreen;
                else
                    tr3tc.CssClass = "blackfnt";  
            }
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);

            tr3tc = new TableCell();
            tr3tc.Text =dr["rutcd"].ToString()+"<br/>"+ dr["RouteCd"].ToString();
            tr3tc.CssClass = "blackfnt";
            tr3tc.Wrap = false;
            tr3.Cells.Add(tr3tc);



            if (dr["Dept_L_E"].ToString() == "" && dr["Arrv_L_E"].ToString() == "") 
            tr3.BackColor = System.Drawing.Color.White;
            else
            tr3.BackColor = System.Drawing.Color.LightGray;
            tr3.BorderWidth = 1;
            tr3.HorizontalAlign = HorizontalAlign.Center;
            tr3.BorderColor = System.Drawing.Color.Gray;

            tblMovement.Rows.Add(tr3);
        }

        dr.Read();

        conn.Close();



    }
}
