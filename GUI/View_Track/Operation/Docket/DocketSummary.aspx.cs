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

public partial class GUI_Tracking_ver1_Docket_DocketSummary : System.Web.UI.Page
{
    public static string call_dkt;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        //Response.Write("ABC" + Request.QueryString());
        //Response.End();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["DocketCalledAs"].ToString();
        string sqlstr = "exec WebxNet_DKT_Summary '" + str_dockno + "','" + str_docksf + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lbldockno.Text = dr["dockno"].ToString()+""+dr["docksf"].ToString();
           // lbldockno.Text = dr["docksf"].ToString();
            ///lbldockno.Text = dr["docket"].ToString();
            lblorgncd.Text = dr["origin"].ToString();
            lbldestcd.Text = dr["destcd"].ToString();
            lbldockst.Text = dr["dock_dt"].ToString();

            lblcurrloc.Text = dr["curr_loc"].ToString();
            lblnextloc.Text = dr["Nextloc"].ToString();
            lblfrom.Text = dr["from_loc"].ToString();
            lblto.Text = dr["to_loc"].ToString();

            lblstype.Text = dr["Service_Class"].ToString() + " | " + dr["PAYBASis"].ToString() + " | " + dr["tranportmode"].ToString();
            lblwtdet.Text = dr["pkgsno"].ToString() + " | " + dr["chrgwt"].ToString() + " | " + dr["actuwt"].ToString();
            lblConrcnee.Text = dr["Cnor"].ToString() + " <br/> " + dr["Cnee"].ToString();

            lblEDDADD.Text = dr["CDELDT"].ToString() + " | " + dr["dely_date"].ToString();
            lblarr.Text = dr["Arrv_dt"].ToString();
            lblattempt.Text = dr["DATE_OF_Last_aatempt"].ToString() + " | " + dr["NO_OF_aatempt"].ToString();
            lblreason.Text = dr["reason"].ToString();

            lblCodecodeno.Text = dr["codno"].ToString();
            lblCODAmt.Text = dr["codamt"].ToString();
            lblCODAmt1.Text = dr["codcollected"].ToString();
            lblCoddt.Text = dr["dely_date"].ToString();

            if (dr["cod_dod"].ToString() == "Y")
            {
                TBLCODCOD.Visible = true;
            }
            else
            {
                TBLCODCOD.Visible = false;
            }

        }
        dr.Close();

        string sql_STstus = "exec  webxNet_Docket_status '" + str_dockno + "','" + str_docksf + "'";
        SqlCommand cmd_STstus = new SqlCommand(sql_STstus, conn);
        SqlDataReader dr_STstus = cmd_STstus.ExecuteReader();
        
        while (dr_STstus.Read())
        {
            lblstatus.Text = dr_STstus["Docket_Status"].ToString();
        }
        dr_STstus.Close();

        string SQL_Time = "select CurLoc,NextLoc,ArrvDt,DeptDt,LS,MF,THC,PRS,DRS,THCveh,DRSVeh from VwNet_DKT_Time_Track where dockno='" + str_dockno + "' and docksf='" + str_docksf + "' order by srno";

        SqlCommand sqlcmd12 = new SqlCommand(SQL_Time, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;
    }
}
