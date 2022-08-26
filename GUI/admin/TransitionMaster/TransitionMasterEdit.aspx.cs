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

public partial class GUI_admin_TransitionMaster_TransitionMaster : System.Web.UI.Page
{
    SqlConnection cn;
    public static string loc, dest, src;
 //   public static  string locarr;
    public static DataSet SAN_DS = new DataSet();
  //  public DataTable dt_san = new DataTable();
     
    
    protected void Page_Load(object sender, EventArgs e)
    {  
      getstring();

      
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        { 
           creategrid();
         

           //locarr = "";
           //for (Int32 i = 0; i < GV_D.Rows.Count; i++)
           //{
           //    TextBox txtloc1 = (TextBox)GV_D.Rows[i].FindControl("txtloc1");
           //    TextBox txtloc2 = (TextBox)GV_D.Rows[i].FindControl("txtloc2");
           //    locarr = locarr + txtloc1.Text + "," + txtloc2.Text + "|";

           //}
         
            
        }
        else
        {
               //  btnSubmit.Attributes.Add("onClick", "javascript:return locCheck('" + locarr + "')");
        }

        btnSubmit.Attributes.Add("onClick", "javascript:return ch()");

        
    }



    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }
    

    public void creategrid()
    {
        SAN_DS.Clear();

      loc=  Session["tTransLocCod"].ToString();
      src = Session["tOrgnBranch"].ToString();
      dest = Session["tDestBranch"].ToString();
       

        string msg;
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        //string dno = dockno;

        string sql=""; 

        if (loc == "" && src != "" && dest != "")
        {
            sql = "Select TRORGN,TRDEST,trdays_Rail,TRDIST_Rail,STD_RATE_PER_KG_Rail,STD_RATE_PER_PKG_Rail,trdays,TRDIST,STD_RATE_PER_KG,STD_RATE_PER_PKG,trdays_Air,TRDIST_Air,STD_RATE_PER_KG_Air,STD_RATE_PER_PKG_Air,trdays_exp,isnull(trdays_exp,0) as trdays_exp,isnull(trdist_exp,0) as trdist_exp,isnull(std_rate_per_kg_exp,0) as  std_rate_per_kg_exp,isnull(std_rate_per_pkg_exp,0) as std_rate_per_pkg_exp From webx_trms where TRORGN='" + src + "' and TRDEST='" + dest + "'";
        }
        if (loc != "" && src == "" && dest == "")
        {
            sql = "Select TRORGN,TRDEST,trdays_Rail,TRDIST_Rail,STD_RATE_PER_KG_Rail,STD_RATE_PER_PKG_Rail,trdays,TRDIST,STD_RATE_PER_KG,STD_RATE_PER_PKG,trdays_Air,TRDIST_Air,STD_RATE_PER_KG_Air,STD_RATE_PER_PKG_Air,isnull(trdays_exp,0) as trdays_exp,isnull(trdist_exp,0) as trdist_exp,isnull(std_rate_per_kg_exp,0) as  std_rate_per_kg_exp,isnull(std_rate_per_pkg_exp,0) as std_rate_per_pkg_exp From webx_trms where TRORGN='" + loc + "' or TRDEST='" + loc + "'";
        }

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

      //  DataSet ds = new DataSet();

        da.Fill(SAN_DS);

        //SqlCommand cd = new SqlCommand(sql, conn);
        //SqlDataReader dr = cd.ExecuteReader();
        //locarr="";
        //while (dr.Read())
        //{
        //    locarr = locarr + dr["trorgn"].ToString() + "," + dr["TRDEST"].ToString() + "|";
        //}
        //dr.Close();

        //foreach (DataRow ddr in ds.Tables[0].Rows)
        //{
        //    s1 = ddr["octamt"].ToString();
        //    s2 = ddr["recptno"].ToString();
        //    s3 = ddr["recptdt"].ToString();
            
        //}

        GV_D.DataSource = SAN_DS;
        GV_D.DataBind();

        if (GV_D.Rows.Count == 0)
        {
            btnSubmit.Visible = false;
        }
 

    }


     
    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
         
          string lll = "";
        int g = 1;

         

        for (Int32 i = 0; i < GV_D.Rows.Count; i++)
        {

            TextBox txtloc1 = (TextBox)GV_D.Rows[i].FindControl("txtloc1");
            TextBox txtloc2 = (TextBox)GV_D.Rows[i].FindControl("txtloc2");

            TextBox RL_DAYS = (TextBox)GV_D.Rows[i].FindControl("RL_DAYS");
            TextBox RL_DIST = (TextBox)GV_D.Rows[i].FindControl("RL_DIST");
            TextBox RL_RATE1 = (TextBox)GV_D.Rows[i].FindControl("RL_RATE1");
            TextBox RL_RATE2 = (TextBox)GV_D.Rows[i].FindControl("RL_RATE2");

            TextBox RD_DAYS = (TextBox)GV_D.Rows[i].FindControl("RD_DAYS");
            TextBox RD_DIST = (TextBox)GV_D.Rows[i].FindControl("RD_DIST");
            TextBox RD_RATE1 = (TextBox)GV_D.Rows[i].FindControl("RD_RATE1");
            TextBox RD_RATE2 = (TextBox)GV_D.Rows[i].FindControl("RD_RATE2");

            TextBox AIR_DAYS = (TextBox)GV_D.Rows[i].FindControl("AIR_DAYS");
            TextBox AIR_DIST = (TextBox)GV_D.Rows[i].FindControl("AIR_DIST");
            TextBox AIR_RATE1 = (TextBox)GV_D.Rows[i].FindControl("AIR_RATE1");
            TextBox AIR_RATE2 = (TextBox)GV_D.Rows[i].FindControl("AIR_RATE2");

            TextBox HSS_DAYS = (TextBox)GV_D.Rows[i].FindControl("HSS_DAYS");
            TextBox HSS_DIST = (TextBox)GV_D.Rows[i].FindControl("HSS_DIST");
            TextBox HSS_RATE1 = (TextBox)GV_D.Rows[i].FindControl("HSS_RATE1");
            TextBox HSS_RATE2 = (TextBox)GV_D.Rows[i].FindControl("HSS_RATE2");



            TextBox txtloc1_h = (TextBox)GV_D.Rows[i].FindControl("txtloc1_h");
            TextBox txtloc2_h = (TextBox)GV_D.Rows[i].FindControl("txtloc2_h");
            TextBox RL_DAYS_h = (TextBox)GV_D.Rows[i].FindControl("RL_DAYS_h");
            TextBox RL_DIST_h = (TextBox)GV_D.Rows[i].FindControl("RL_DIST_h");
            TextBox RL_RATE1_h = (TextBox)GV_D.Rows[i].FindControl("RL_RATE1_h");
            TextBox RL_RATE2_h = (TextBox)GV_D.Rows[i].FindControl("RL_RATE2_h");

            TextBox RD_DAYS_h = (TextBox)GV_D.Rows[i].FindControl("RD_DAYS_h");
            TextBox RD_DIST_h = (TextBox)GV_D.Rows[i].FindControl("RD_DIST_h");
            TextBox RD_RATE1_h = (TextBox)GV_D.Rows[i].FindControl("RD_RATE1_h");
            TextBox RD_RATE2_h = (TextBox)GV_D.Rows[i].FindControl("RD_RATE2_h");

            TextBox AIR_DAYS_h = (TextBox)GV_D.Rows[i].FindControl("AIR_DAYS_h");
            TextBox AIR_DIST_h = (TextBox)GV_D.Rows[i].FindControl("AIR_DIST_h");
            TextBox AIR_RATE1_h = (TextBox)GV_D.Rows[i].FindControl("AIR_RATE1_h");
            TextBox AIR_RATE2_h = (TextBox)GV_D.Rows[i].FindControl("AIR_RATE2_h");

            TextBox HSS_DAYS_h = (TextBox)GV_D.Rows[i].FindControl("HSS_DAYS_h");
            TextBox HSS_DIST_h = (TextBox)GV_D.Rows[i].FindControl("HSS_DIST_h");
            TextBox HSS_RATE1_h = (TextBox)GV_D.Rows[i].FindControl("HSS_RATE1_h");
            TextBox HSS_RATE2_h = (TextBox)GV_D.Rows[i].FindControl("HSS_RATE2_h");


            CheckBox chksrno = (CheckBox)GV_D.Rows[i].FindControl("chksrno");

            txtloc1.Attributes.Add("onblur", "javascript:checklocation(this)");
            txtloc2.Attributes.Add("onblur", "javascript:checklocation(this)");



            if (RL_DAYS_h.Text == "")
            {
                RL_DAYS_h.Text = null;
            }
            if (RL_DIST_h.Text == "")
            {
                RL_DIST_h.Text = null;
            }
            if (RL_RATE1_h.Text == "")
            {
                RL_RATE1_h.Text = null;
            }
            if (RL_RATE2_h.Text == "")
            {
                RL_RATE2_h.Text = null;
            }

            if (RD_DAYS_h.Text == "")
            {
                RD_DAYS_h.Text = null;
            }
            if (RD_DIST_h.Text == "")
            {
                RD_DIST_h.Text = null;
            }
            if (RD_RATE1_h.Text == "")
            {
                RD_RATE1_h.Text = null;
            }
            if (RD_RATE2_h.Text == "")
            {
                RD_RATE2_h.Text = null;
            }

            if (AIR_DAYS_h.Text == "")
            {
                AIR_DAYS_h.Text = null;
            }
            if (AIR_DIST_h.Text == "")
            {
                AIR_DIST_h.Text = null;
            }
            if (AIR_RATE1_h.Text == "")
            {
                AIR_RATE1_h.Text = null;
            }
            if (AIR_RATE2_h.Text == "")
            {
                AIR_RATE2_h.Text = null;
            }

            if (HSS_DAYS_h.Text == "")
            {
                HSS_DAYS_h.Text = null;
            }
            if (HSS_DIST_h.Text == "")
            {
                HSS_DIST_h.Text = null;
            }
            if (HSS_RATE1_h.Text == "")
            {
                HSS_RATE1_h.Text = null;
            }
            if (HSS_RATE2_h.Text == "")
            {
                HSS_RATE2_h.Text = null;
            }


            string s1, s2, s3, s4;


            s1 = txtloc1.Text;
            s2 = txtloc1_h.Text;

            s3 = RD_DAYS.Text;
            s4 = RD_DAYS_h.Text;



            if (s1 != "")
            {

                //if (chksrno.Checked == true)
                //{


                    string sqldel = "delete  webx_trms where TRORGN='" + txtloc1_h.Text + "'and TRDEST='" + txtloc2_h.Text + "' ";


                    SqlCommand cmddel = new SqlCommand(sqldel, cn);
                    cmddel.ExecuteNonQuery();

                /*    string sql = "Insert into webx_trms values('" + txtloc1.Text + "','" + txtloc2.Text + "','" + RD_DAYS.Text + "','" + RD_DIST.Text + "'," +
                    "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','" + null + "','" + RD_RATE1.Text + "', '" + RD_RATE2.Text + "'," +
                    "'" + RL_DAYS.Text + "','" + RL_DIST.Text + "','" + RL_RATE1.Text + "','" + RL_RATE2.Text + "','" + AIR_DAYS.Text + "'," +
                    "'" + AIR_DIST.Text + "','" + AIR_RATE1.Text + "','" + AIR_RATE2.Text + "','" + HSS_DAYS.Text + "','" + HSS_DIST.Text + "'," +
                    "'" + HSS_RATE1.Text + "','" + HSS_RATE2.Text + "')";*/

                    string sql = "Insert into webx_trms values('" + txtloc1.Text + "','" + txtloc2.Text + "','" + RD_DAYS.Text + "','" + RD_DIST.Text + "'," +
                  "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','" + null + "','" + RD_RATE1.Text + "', '" + RD_RATE2.Text + "'," +
                  "'" + RL_DIST.Text + "','" + RL_DAYS.Text + "','" + RL_RATE1.Text + "','" + RL_RATE2.Text + "','" + AIR_DIST.Text + "','" + AIR_DAYS.Text + "'," +
                  "'" + AIR_RATE1.Text + "','" + AIR_RATE2.Text + "','" + HSS_DIST.Text + "','" + HSS_DAYS.Text + "'," +
                  "'" + HSS_RATE1.Text + "','" + HSS_RATE2.Text + "')";

                    SqlCommand cmd = new SqlCommand(sql, cn);
                    cmd.ExecuteNonQuery();
                //}
            }
        }

        cn.Close();
        Response.Redirect("../operations.aspx");
        

    }


     
    public void row_hdr(Object sender, GridViewRowEventArgs e)
    {
        //  BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************
            oTableCell = new TableCell();
            oTableCell.Text = " Sr.No.";
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Origin Branch ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Destination Branch ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Transition Mode - Rail ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 4;

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "Transition Mode - Road ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Transition Mode - Air ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Transition Mode - HSS ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);



            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridViewRow.CssClass = "bgbluegrey";

            //oGridView.Controls[0].Controls.RemoveAt(1);

            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //Build custom header.


            //GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
            oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
            oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************

            //oTableCell1 = new TableCell();
            //oTableCell1.Text = "";
            //// oTableCell.RowSpan = 2;
            //oGridViewRow1.Cells.Add(oTableCell1);


            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);



            oTableCell1 = new TableCell();
            oTableCell1.Text = "Days ";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Dist.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/Kg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/PKg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Days ";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Dist.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/Kg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/PKg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Days ";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Dist.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/Kg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/PKg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Days ";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Dist.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/Kg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Rate/PKg. ";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
        }
         

    }

}
