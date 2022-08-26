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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Common_UserControls_LOC_HRCHY : System.Web.UI.UserControl
{
    public static string loc_level = "", brcd = "";
    public static int loclevel = 0;
    SqlConnection conn;
    int maxID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //if (!IsPostBack)
        //{
            brcd = Session["brcd"].ToString();
            String sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br> sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
            loc_level = Convert.ToString(dread.GetValue(0).ToString());
            //Response.Write("<br> sqlstr : " + loclevel);
            dread.Close();

            sqlstr = "select codeid,codedesc from webx_master_general where codetype='HRCHY' and codeid<>'1' and  codeid>=" + loclevel + " order by codeid ";
             cmd = new SqlCommand(sqlstr, conn);
             SqlDataAdapter DA = new SqlDataAdapter(cmd);
             DataSet DS = new DataSet();

             DA.Fill(DS);

             foreach (DataRow  dr in DS.Tables [0].Rows )
             {
                 DropDownList dl= new DropDownList ();
                 string sqlstr1="";


                 //if(dr["codeid"].ToString()=="1")
                 // sqlstr1 = "select loccode,LOCNAME=LocCode+' : '+LocName  from webx_location where loc_level='" + dr["codeid"] + "'";
                 //else
                 // sqlstr1 = "select top 1 loccode='All',LOCNAME='All' from webx_location union select loccode,LOCNAME=LocCode+' : '+LocName  from webx_location where loc_level='" + dr["codeid"] + "'";

                 int locl=0;

                 locl=loclevel+1;

                 if (dr["codeid"].ToString() == loc_level)
                     sqlstr1 = "select loccode,LOCNAME=LocCode+' : '+LocName  from webx_location where loccode='" + brcd + "'";
                 else if (dr["codeid"].ToString() == locl.ToString())
                     sqlstr1 = "select top 1 loccode='All',LOCNAME='All' from webx_location union select loccode,LOCNAME=LocCode+' : '+LocName  from webx_location where loccode='" + brcd + "' or Report_loc='" + brcd + "'";
                 else
                     sqlstr1 = "select top 1 loccode='All',LOCNAME='All' from webx_location ";

                 SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
                 SqlDataAdapter DA1 = new SqlDataAdapter(cmd1);
                 DataSet DS1 = new DataSet();

                  DA1.Fill(DS1);
                 dl.DataSource = DS1;
                 dl.DataTextField = "LocName";

                 
                 dl.DataValueField ="LocCode";
                 dl.DataBind();

                 dl.ID = "DL_" + dr["codeid"];

                 maxID = Convert.ToInt32(dr["codeid"].ToString());

                 if (dr["codeid"].ToString() != "1")
                 {
                     dl.Attributes.Add("All", "All");
                     dl.SelectedValue = "All";
                     dl.AutoPostBack = true;
                     dl.SelectedIndexChanged += new EventHandler(dl_SelectedIndexChanged);
                 }

                 TableRow tr1 = new TableRow();
                 TableCell tr1tc1 = new TableCell();
                 TableCell tr1tc2 = new TableCell();

                 tr1tc1.Text = dr["codeDESC"].ToString();
                 tr1tc1.CssClass = "blackfnt";
                 tr1tc1.Wrap = false;
                 tr1.CssClass = "bgbluegrey";
                 tr1.Cells.Add(tr1tc1);

                 tr1tc2.Controls.Add(dl);
                 tr1tc2.CssClass = "blackboldfnt";
                 tr1tc2.Wrap = false;
                 tr1.CssClass = "bgbluegrey";
                 tr1.Cells.Add(tr1tc2);

                 tr1.BorderWidth = 1;
                 tr1.BorderColor = System.Drawing.Color.Gray;
                 tr1.HorizontalAlign = HorizontalAlign.Left;
                // tr1.HorizontalAlign = HorizontalAlign.Center;
                 tr1.BackColor = System.Drawing.Color.White;
                 TBL_HRCHY.Rows.Add(tr1);



             //}

          

        }

        
    }

    private void dl_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        DropDownList DL = (DropDownList)sender;

        //DL.ID.ToString DL.SelectedValue
        int nextDLIDint = Convert.ToInt32(DL.ID.ToString().Substring(3, 1)) + 1;
        if (nextDLIDint <= Convert.ToInt32(maxID))
        {
            string nextDLID = "DL_" + nextDLIDint;

            DropDownList DDL = (DropDownList)this.FindControl(nextDLID);

            string sqlstr = "select top 1 loccode='All',LOCNAME='All' from webx_location union select loccode,LOCNAME=LocCode+' : '+LocName  from webx_location where  Report_loc='" + DL.SelectedValue.ToString() + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            DDL.Items.Clear();
            SqlDataReader dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDL.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();
            DDL.SelectedValue = "All";
        }

        conn.Close();
    }
}
