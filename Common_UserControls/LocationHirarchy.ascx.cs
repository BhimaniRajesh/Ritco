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

public partial class GUI_UNI_MIS_LocationHirarchy : System.Web.UI.UserControl
{
    public static string loc_level = "", brcd="";
    public static int loclevel = 0;
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
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


            if (loclevel >= 1)
            {
                //trRO.Visible = true;
                //trAO.Visible = true;
                //trLO.Visible = true;
                trRO.Style["display"] = "Marker";
                trAO.Style["display"] = "block";
                trLO.Style["display"] = "block";
                String SQL_RO = "";
                if (loclevel == 1)
                {
                    SQL_RO = " select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                    cboRO.Items.Add(new ListItem("All", "All"));
                }
                else
                {
                    SQL_RO = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                }

                cboAO.Items.Add(new ListItem("All", "All"));
               
                if (loclevel <= 2)
                {
                    cboLO.Items.Add(new ListItem("All", "All"));

                }

                SqlCommand cmd1 = new SqlCommand(SQL_RO, conn);
                SqlDataReader dread1 = cmd1.ExecuteReader();
                {

                    while (dread1.Read())
                    {
                        cboRO.Items.Add(new ListItem(dread1.GetValue(1).ToString(), dread1.GetValue(0).ToString()));

                    }

                }
                dread1.Close();
            }

            if (loclevel >= 2)
            {
                //trAO.Visible = true;
                //trLO.Visible = true;
                if (loclevel != 2)
                {
                    trRO.Style["display"] = "none";
                }
                trLO.Style["display"] = "block";
                trAO.Style["display"] = "block";
                String SQL_AO = "";
                if (loclevel == 2)
                {
                    SQL_AO = " select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='3'  order by locname";
                    cboAO.Items.Add(new ListItem("All", "All"));
                }
                else
                {
                    SQL_AO = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                }

               
                SqlCommand cmd2 = new SqlCommand(SQL_AO, conn);
                SqlDataReader dread2 = cmd2.ExecuteReader();
                {

                    while (dread2.Read())
                    {
                        cboAO.Items.Add(new ListItem(dread2.GetValue(1).ToString(), dread2.GetValue(0).ToString()));

                    }

                }
                dread2.Close();
            }
            if (loclevel <= 4)
            {
                //trLO.Visible = true;
                if (loclevel != 1)
                {
                    trLO.Style["display"] = "block";
                    String SQL_LO = "";
                    if (loclevel == 3)
                    {
                        SQL_LO = " select loccode,loccode + ' : '+ locname from webx_location where loccode='" + brcd + "'  order by locname";
                    }
                    if (loclevel == 4)
                    {
                        SQL_LO = " select loccode,loccode + ' : '+ locname from webx_location where loccode='" + brcd + "'  order by locname";
                    }
                    if (loclevel == 2)
                    {
                        SQL_LO = " select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + brcd + "'  order by locname";
                    }
                    ///cboLO.Items.Add(new ListItem("All", "All"));
                    SqlCommand cmd3 = new SqlCommand(SQL_LO, conn);
                    SqlDataReader dread3 = cmd3.ExecuteReader();
                    {
                        while (dread3.Read())
                        {
                            cboLO.Items.Add(new ListItem(dread3.GetValue(1).ToString(), dread3.GetValue(0).ToString()));

                        }

                    }
                    dread3.Close();
                }
            }
        }
        trAO.Style["display"] = "none";
    }
    protected void cboRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        String sqlstr = "";
        String sqlstr1 = "";

        sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        // Response.Write("<br> sqlstr : " + sqlstr);
        SqlCommand cmd11 = new SqlCommand(sqlstr, conn);
        SqlDataReader dread11 = cmd11.ExecuteReader();

        dread11.Read();
        loclevel = Convert.ToInt32(dread11.GetValue(0).ToString());
        loc_level = Convert.ToString(dread11.GetValue(0).ToString());
        //Response.Write("<br> sqlstr : " + loclevel);
        //Response.End();
        dread11.Close();

        if (loclevel <= 2)
        {
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where (loc_level='3' and  report_loc='" + cboRO.SelectedValue.ToString() + "') or loccode='" + cboRO.SelectedValue.ToString() + "' order by loccode";
            sqlstr1 = " select loccode,loccode + ' : '+ locname from webx_location where   (report_loc='" + cboRO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "' or report_loc in (select loccode  from webx_location where report_loc='" + cboRO.SelectedValue.ToString() + "')) order by loccode";
        }
        else
        {
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboAO.Items.Clear();
        cboAO.Items.Add(new ListItem("All", "All"));
        {

            while (dread.Read())
            {
                cboAO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo.SelectedValue = "All";      
            }

        }
        dread.Close();

        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataReader dread1 = cmd1.ExecuteReader();
        cboLO.Items.Clear();
        cboLO.Items.Add(new ListItem("All", "All"));
        {

            while (dread1.Read())
            {
                cboLO.Items.Add(new ListItem(dread1.GetValue(1).ToString(), dread1.GetValue(0).ToString()));
                //cboRO_Lo.SelectedValue = "All";      
            }

        }
        dread1.Close();
        conn.Close();
    }
    protected void cboAO_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        String sqlstr = "";
        String sqlstr1 = "";
        
        if (loclevel <= 3)
        {
            sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where loc_level='4' and  report_loc='" + cboAO.SelectedValue.ToString() + "' or loccode='" + cboAO.SelectedValue.ToString() + "'";
            sqlstr1 = " select loccode,loccode + ' : '+ locname from webx_location where loc_level='4' and  report_loc='" + cboAO.SelectedValue.ToString() + "' or loccode='" + cboAO.SelectedValue.ToString() + "'";
        }
        else
        {
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboLO.Items.Clear();
        cboLO.Items.Add(new ListItem("All", "All"));
        {

            while (dread.Read())
            {
                cboLO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo.SelectedValue = "All";      
            }

        }
        dread.Close();
        conn.Close();
    }
}
