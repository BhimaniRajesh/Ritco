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
   // public static DataSet ds_san = new DataSet();
    public DataTable dt_san = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

        getstring();
        getstring2();
       // cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        { 
            creategrid();
            Validation();

        }
        else
        {
           
        }
        //btnSubmit.Attributes.Add("onClick", "javascript:return ch()");
        btnSubmit.Attributes.Add("onClick", "javascript:return locBlur(),ch()");

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


    private void getstring2()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select  trorgn+trdest as a from webx_trms";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["a"] + "'"));
        }
        dr_Location.Close();
    }




    public void creategrid()
    {
        dt_san.Clear();
        Int32 i;
        DataRow drow;
            
        
                for (i = 0; i < 10; i++)
                {
                      drow = dt_san.NewRow();
                       dt_san.Rows.Add(drow);
                   
                }
         
        
        GV_D.DataSource = dt_san;
        GV_D.DataBind();
        
    }

 
     
    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        foreach (GridViewRow gridrow in GV_D.Rows)
        {


            TextBox txtloc1 = (TextBox)gridrow.FindControl("txtloc1");
            TextBox txtloc2 = (TextBox)gridrow.FindControl("txtloc2");
            TextBox RL_DAYS = (TextBox)gridrow.FindControl("RL_DAYS");
            TextBox RL_DIST = (TextBox)gridrow.FindControl("RL_DIST");
            TextBox RL_RATE1 = (TextBox)gridrow.FindControl("RL_RATE1");
            TextBox RL_RATE2 = (TextBox)gridrow.FindControl("RL_RATE2");

            TextBox RD_DAYS = (TextBox)gridrow.FindControl("RD_DAYS");
            TextBox RD_DIST = (TextBox)gridrow.FindControl("RD_DIST");
            TextBox RD_RATE1 = (TextBox)gridrow.FindControl("RD_RATE1");
            TextBox RD_RATE2 = (TextBox)gridrow.FindControl("RD_RATE2");

            TextBox AIR_DAYS = (TextBox)gridrow.FindControl("AIR_DAYS");
            TextBox AIR_DIST = (TextBox)gridrow.FindControl("AIR_DIST");
            TextBox AIR_RATE1 = (TextBox)gridrow.FindControl("AIR_RATE1");
            TextBox AIR_RATE2 = (TextBox)gridrow.FindControl("AIR_RATE2");

            TextBox HSS_DAYS = (TextBox)gridrow.FindControl("HSS_DAYS");
            TextBox HSS_DIST = (TextBox)gridrow.FindControl("HSS_DIST");
            TextBox HSS_RATE1 = (TextBox)gridrow.FindControl("HSS_RATE1");
            TextBox HSS_RATE2 = (TextBox)gridrow.FindControl("HSS_RATE2");

            CheckBox chksrno = (CheckBox)gridrow.FindControl("chksrno");


            if (chksrno.Checked == true)
            {
                if (txtloc1.Text != "")
                {


                  /*  string sql = "Insert into webx_trms values('" + txtloc1.Text + "','" + txtloc2.Text + "','" + RD_DAYS.Text + "','" + RD_DIST.Text + "'," +
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
                }
            }
        }
        cn.Close();
        Response.Redirect("../operations.aspx");

    }


    public void Validation()
    {
        string test1 = "";
        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            TextBox txtloc1 = (TextBox)gridrow.FindControl("txtloc1");
            TextBox txtloc2 = (TextBox)gridrow.FindControl("txtloc2");
            TextBox RL_DAYS = (TextBox)gridrow.FindControl("RL_DAYS");
            TextBox RL_DIST = (TextBox)gridrow.FindControl("RL_DIST");
            TextBox RL_RATE1 = (TextBox)gridrow.FindControl("RL_RATE1");
            TextBox RL_RATE2 = (TextBox)gridrow.FindControl("RL_RATE2");

            TextBox RD_DAYS = (TextBox)gridrow.FindControl("RD_DAYS");
            TextBox RD_DIST = (TextBox)gridrow.FindControl("RD_DIST");
            TextBox RD_RATE1 = (TextBox)gridrow.FindControl("RD_RATE1");
            TextBox RD_RATE2 = (TextBox)gridrow.FindControl("RD_RATE2");

            TextBox AIR_DAYS = (TextBox)gridrow.FindControl("AIR_DAYS");
            TextBox AIR_DIST = (TextBox)gridrow.FindControl("AIR_DIST");
            TextBox AIR_RATE1 = (TextBox)gridrow.FindControl("AIR_RATE1");
            TextBox AIR_RATE2 = (TextBox)gridrow.FindControl("AIR_RATE2");

            TextBox HSS_DAYS = (TextBox)gridrow.FindControl("HSS_DAYS");
            TextBox HSS_DIST = (TextBox)gridrow.FindControl("HSS_DIST");
            TextBox HSS_RATE1 = (TextBox)gridrow.FindControl("HSS_RATE1");
            TextBox HSS_RATE2 = (TextBox)gridrow.FindControl("HSS_RATE2");


          

            //txtloc1.Attributes.Add("onblur", "javascript:return checklocation(this),checklocation2(" + txtloc1.ClientID + "," + txtloc2.ClientID + ")");
            //txtloc2.Attributes.Add("onblur", "javascript:return checklocation(this),checklocation2(" + txtloc1.ClientID + "," + txtloc2.ClientID + ")");

            txtloc1.Attributes.Add("onblur", "javascript:return checklocation(this)");
            txtloc2.Attributes.Add("onblur", "javascript:return checklocation(this)");
          
            RL_DAYS.Attributes.Add("onblur", "javascript:return check(this)");
            RL_DIST.Attributes.Add("onblur", "javascript:return check(this)");
            RL_RATE1.Attributes.Add("onblur", "javascript:return check(this)");
            RL_RATE2.Attributes.Add("onblur", "javascript:return check(this)");

            RD_DAYS.Attributes.Add("onblur", "javascript:return check(this)");
            RD_DIST.Attributes.Add("onblur", "javascript:return check(this)");
            RD_RATE1.Attributes.Add("onblur", "javascript:return check(this)");
            RD_RATE2.Attributes.Add("onblur", "javascript:return check(this)");

            AIR_DAYS.Attributes.Add("onblur", "javascript:return check(this)");
            AIR_DIST.Attributes.Add("onblur", "javascript:return check(this)");
            AIR_RATE1.Attributes.Add("onblur", "javascript:return check(this)");
            AIR_RATE2.Attributes.Add("onblur", "javascript:return check(this)");

            HSS_DAYS.Attributes.Add("onblur", "javascript:return check(this)");
            HSS_DIST.Attributes.Add("onblur", "javascript:return check(this)");
            HSS_RATE1.Attributes.Add("onblur", "javascript:return check(this)");
            HSS_RATE2.Attributes.Add("onblur", "javascript:return check(this)");

            test1 = txtloc1.Text + txtloc2.Text;

            
        
        
        }
    }


    public void row_hdr(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
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
            oTableCell.Text = " Srno";
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
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
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
