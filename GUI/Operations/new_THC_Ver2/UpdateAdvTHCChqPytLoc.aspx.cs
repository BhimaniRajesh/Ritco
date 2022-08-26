using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class GUI_Operations_new_THC_Ver2_UpdateAdvTHCChqPytLoc : System.Web.UI.Page
{
    bool success = false;
    string Status;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
        this.Title = pagetitle;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string brcd = Session["brcd"].ToString();
            string sql_level = "select isnull(loc_level,1) from webx_location with(NOLOCK) where activeFlag='Y' and loccode='" + brcd + "' ";
            SqlCommand cmd_level = new SqlCommand(sql_level, conn);
            SqlDataReader dr_level = cmd_level.ExecuteReader();
            while (dr_level.Read())
            {
                //   lv = dr_level[0].ToString();
            }
            dr_level.Close();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader drBr;
            drBr = sqlcmd1.ExecuteReader();
            drBr.Read();
            string loccd = drBr["loccode"].ToString();
            drBr.Close();
            String SQL_LOC, sqlall1;
            if (brcd == loccd)
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {
                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            ddlro.SelectedValue = loccd;
            conn.Close();
        }
    }

    protected void btn_GetThcDetails_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con1.Open();
            SqlCommand cmd1 = new SqlCommand("usp_UpdateAdvTHCChqPytLoc_FindTHC", con1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@ThcNo", SqlDbType.VarChar).Value = txtTHCNo.Text;
            cmd1.Parameters.Add("@GetThcNo", SqlDbType.VarChar, 30);
            cmd1.Parameters["@GetThcNo"].Direction = ParameterDirection.Output;
            cmd1.ExecuteNonQuery();
            con1.Close();
            Status = cmd1.Parameters["@GetThcNo"].Value.ToString();


            if (Status != "")
            {
                try
                {
                    tblThcUpdate.Visible = true;
                    lblError.Text = "";
                    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    con.Open();
                    SqlCommand cmd = new SqlCommand("usp_UpdateAdvTHCChqPytLoc_GetThcDetails", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ThcNo", SqlDbType.VarChar).Value = txtTHCNo.Text;
                    cmd.Parameters.Add("@BalAmt", SqlDbType.VarChar, 30);
                    cmd.Parameters.Add("@CurrLoc", SqlDbType.VarChar, 30);

                    cmd.Parameters["@BalAmt"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@CurrLoc"].Direction = ParameterDirection.Output;
                    cmd.ExecuteNonQuery();
                    con.Close();

                    lblThcNo.Text = txtTHCNo.Text;
                    lblBalAmt.Text = cmd.Parameters["@BalAmt"].Value.ToString();
                    lblCurrLoc.Text = cmd.Parameters["@CurrLoc"].Value.ToString();
                }

                catch (Exception e1)
                {

                }
            }

            else
            {
                lblError.Visible = true;
                lblError.Text = "Thc Number Not Found";
                tblThcUpdate.Visible = false;
            }
        }

        catch (Exception e1)
        {

        }

    }
    protected void btn_UpdateLocation_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trn;
        trn = con.BeginTransaction();
        string EntryBy = Session["empcd"].ToString();
        string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
        try
        {
            SqlCommand cmd = new SqlCommand("usp_UpdateAdvTHCChqPytLoc_Update", con, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ThcNo", txtTHCNo.Text.Trim());
            cmd.Parameters.AddWithValue("@NewLocation", ddlro.SelectedValue);
            cmd.Parameters.AddWithValue("@OldLocation", lblCurrLoc.Text);
            cmd.Parameters.AddWithValue("@EntryBy", EntryBy);
            cmd.Parameters.AddWithValue("@EntryDate", EntryDate);
            cmd.ExecuteNonQuery();
            trn.Commit();
            con.Close();
            success = true;
        }
        catch (Exception e1)
        {
            Response.Write("Error" + e1.Message);
            trn.Rollback();
        }

        if (success == true)
        {
            Response.Redirect("UpdateAdvTHCChqPytLocResult.aspx");
        }
    }
}