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
    public static string loc, dest, src, Stateid;
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
            Stateid = Session["state"].ToString();

            lbstcd.Text = Stateid;
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

        btnSubmit.Attributes.Add("onclick", "javascript:return ch()");

        
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

      
        string msg;
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        //string dno = dockno;
        Stateid = Session["state"].ToString();
      

        string sql = "select * from webx_state where STCD='" + Stateid + "' ";


        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

      //  DataSet ds = new DataSet();

        da.Fill(SAN_DS);

        sql = "select * from webx_state where STCD='" + Stateid + "' ";

        SqlCommand cd = new SqlCommand(sql, conn);
        SqlDataReader dr = cd.ExecuteReader();
         
        while (dr.Read())
        {
            txtStateName.Text = dr["stnm"].ToString();


        }
        dr.Close();

        //foreach (DataRow ddr in ds.Tables[0].Rows)
        //{
        //    GV_D.Rows

        //}

        GV_D.DataSource = SAN_DS;

        GV_D.DataBind();

        if (GV_D.Rows.Count == 0)
        {
            btnSubmit.Visible = false;
        }
        for (Int32 i = 0; i < GV_D.Rows.Count; i++)
        {

            CheckBox actch = (CheckBox)GV_D.Rows[i].FindControl("actch");
            TextBox txtch = (TextBox)GV_D.Rows[i].FindControl("txtch");
            HiddenField h1 = (HiddenField)GV_D.Rows[i].FindControl("h1");

           // actch.Attributes.Add("onclick", "javascript:return chchg(" + actch.ClientID + "," + txtch.ClientID + ")");
            //actch.Attributes.Add("On")
            
            actch.Attributes.Add("onClick", "javascript:return chchg(" + actch.ClientID + "," + txtch.ClientID + "," + h1.ClientID + ")");


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

            TextBox txtdoc = (TextBox)GV_D.Rows[i].FindControl("txtdoc");
            TextBox txtdoc_h = (TextBox)GV_D.Rows[i].FindControl("txtdoc_h");

            DropDownList ddlbound = (DropDownList)GV_D.Rows[i].FindControl("ddlbound");

            CheckBox chksrno = (CheckBox)GV_D.Rows[i].FindControl("chksrno");

            CheckBox actch = (CheckBox)GV_D.Rows[i].FindControl("actch");
            TextBox txtch = (TextBox)GV_D.Rows[i].FindControl("txtch");
            HiddenField h1 = (HiddenField)GV_D.Rows[i].FindControl("h1");




           // actch.Attributes.Add("onclick", "javascript:chchg()");
            //txtloc2.Attributes.Add("onblur", "javascript:checklocation(this)");


            string str = "";
            if (actch.Checked == true)
            {
                str = "Y";
            }
            else
            {
                str = "N";
            }

            if (chksrno.Checked == true)
            {
                string sq = "Update  webx_state set stnm='" + txtStateName.Text + "', stform='" + txtdoc.Text + "', activeflag='" + str + "', inoutbound='" + ddlbound.SelectedValue + "' where stcd='" + Stateid + "' and stform ='"+ txtdoc_h.Text+"' ";
                SqlCommand cmddel = new SqlCommand(sq, cn);
                cmddel.ExecuteNonQuery();
   
            }
        }
    

        cn.Close();
        Response.Redirect("../COMPANY_STRUCTURE.aspx");
        

    }




    //public void getdata(object sender, GridViewPageEventArgs e)
    //{

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //       // HyperLink h1 = (HyperLink)e.Row.FindControl("hy1");

    //        DropDownList d = (DropDownList)e.Row.FindControl("ddlbound");
    //        TextBox t =(TextBox)e.Row.FindControl("ddl_h");

    //        d.SelectedItem = t.Text;           


            
    //    }

        

    //}    



    protected void getdata(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // HyperLink h1 = (HyperLink)e.Row.FindControl("hy1");

            DropDownList d = (DropDownList)e.Row.FindControl("ddlbound");
            TextBox t = (TextBox)e.Row.FindControl("d_h");
            CheckBox c = (CheckBox)e.Row.FindControl("actch");
            TextBox t2 = (TextBox)e.Row.FindControl("txtch");


            //d.Items.Add("--Select--");
            //d.Items.Add(
            //d.Items.Add("In-Bound","I");
            //d.Items.Add("Out-Bound","O");
           
            //if (t.Text == "I")
            //{
            //    d.SelectedIndex = 1;
            //}
            //else if (t.Text == "O")
            //{
            //    d.SelectedIndex = 2;
            //}
            //else
            //{
            //    d.SelectedIndex = 0;
            //}
            d.Text = t.Text;

            if (t2.Text == "Y")
            {
                c.Checked = true;

            }
            else
            {
                c.Checked = false;
            }

        }
    }
    

}
