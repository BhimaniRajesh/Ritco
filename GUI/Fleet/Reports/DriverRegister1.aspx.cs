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
using System.IO;
using System.Text;
public partial class Reports_DriverRegister : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        addLocation();
        addDriverName();
        btnSubmit.Attributes.Add("onClick", "javascript:return checkEvent();");
        if (!IsPostBack)
        {

            //Do Work
        }





    }



    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand("usp_DriverRegister_List", conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

     

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                   
        da.SelectCommand.Parameters.Add("@Location", SqlDbType.VarChar).Value = ddlLocation.SelectedItem.Text;


        if (txtLExpiry.Text != "")
        {

            da.SelectCommand.Parameters.Add("@LExpiry", SqlDbType.VarChar).Value = txtLExpiry.Text;

        }
        else
        {
            da.SelectCommand.Parameters.Add("@LExpiry", SqlDbType.VarChar).Value = "0";

        }
        
        
        if (ddlDname.SelectedItem.Text != "")
        {
            da.SelectCommand.Parameters.Add("@DName", SqlDbType.VarChar).Value = ddlDname.SelectedItem.Text;
        }
        else
        {
            da.SelectCommand.Parameters.Add("@DName", SqlDbType.VarChar).Value = txtDriverName.Text;
        }
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BindGrid();

        //if (GridView1.Rows.Count != 0)
        //{
        //    LinkButton1.Visible = true;

        //}

        //else
        //{
        //    LinkButton1.Visible = false;
        //}
    }

    public void addLocation()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select distinct  LocCode,LocName from webx_location where ActiveFlag='Y' order by LocName";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlLocation.Items.Add(new ListItem("All"));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlLocation.Items.Add(new ListItem(Convert.ToString(dr["LocName"]), Convert.ToString(dr["LocCode"])));
            }

        }

        dr.Close();
        conn.Close();

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
                BindGrid();
    }

    public void addDriverName()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select Driver_Id,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr1 = cmd.ExecuteReader();
        ddlDname.Items.Add(new ListItem("All"));

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {

                ddlDname.Items.Add(new ListItem(Convert.ToString(dr1["Driver_Name"]), Convert.ToString(dr1["Driver_Id"])));
            }

        }

        dr1.Close();
        conn.Close();

    }



    /*   private void PrepareGridViewForExport(Control gv)
       {

           LinkButton lb = new LinkButton();

           Literal l = new Literal();

           string name = String.Empty;

           for (int i = 0; i < gv.Controls.Count; i++)
           {

               if (gv.Controls[i].GetType() == typeof(LinkButton))
               {

                   l.Text = (gv.Controls[i] as LinkButton).Text;

                   gv.Controls.Remove(gv.Controls[i]);

                   gv.Controls.AddAt(i, l);

               }

               else if (gv.Controls[i].GetType() == typeof(DropDownList))
               {

                   l.Text = (gv.Controls[i] as DropDownList).SelectedItem.Text;

                   gv.Controls.Remove(gv.Controls[i]);

                   gv.Controls.AddAt(i, l);

               }

               else if (gv.Controls[i].GetType() == typeof(CheckBox))
               {

                   l.Text = (gv.Controls[i] as CheckBox).Checked ? "True" : "False";

                   gv.Controls.Remove(gv.Controls[i]);

                   gv.Controls.AddAt(i, l);

               }

               if (gv.Controls[i].HasControls())
               {

                   PrepareGridViewForExport(gv.Controls[i]);

               }

           }

       }


       private void ExportGridView()
       {

           string attachment = "attachment; filename=Contacts.xls";

           Response.ClearContent();

           Response.AddHeader("content-disposition", attachment);

           Response.ContentType = "application/ms-excel";

           StringWriter sw = new StringWriter();

           HtmlTextWriter htw = new HtmlTextWriter(sw);



           // Create a form to contain the grid

           HtmlForm frm = new HtmlForm();

           GridView1.Parent.Controls.Add(frm);

           frm.Attributes["runat"] = "server";

           frm.Controls.Add(GridView1);



           frm.RenderControl(htw);

           //GridView1.RenderControl(htw);

           Response.Write(sw.ToString());

           Response.End();

       }
       */
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        //ExportToExcel("Report.xls", GridView1);
        //PrepareGridViewForExport(GridView1);
        // ExportGridView();
    }
    
}

