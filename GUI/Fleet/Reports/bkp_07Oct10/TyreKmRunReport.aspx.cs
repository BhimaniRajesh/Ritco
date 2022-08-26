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
public partial class Reports_TyreKmRunReport : System.Web.UI.Page
{
   // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dvwProducts;
    private GridViewHelper helper;
    //private GroupEvent helper_GroupHeader, helper_GroupSummary;
    //   private GroupEvent helper_GroupSummary;
    string Status = "";
    string sql = "";
    string[] cols = new string[1];
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        addVehicleNo();
        addVehicleModel();

        if (!IsPostBack)
        {

            //Do Work
        }
    }

    public void addVehicleNo()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select VEHNO  from webx_VEHICLE_HDR where ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlVehicleNo.Items.Add(new ListItem("All"));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlVehicleNo.Items.Add(new ListItem(Convert.ToString(dr["VEHNO"])));
            }

        }

        dr.Close();
        conn.Close();

    }


    public void addVehicleModel()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select distinct VEHMODEL  from webx_VEHICLE_HDR where ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlVehModel.Items.Add(new ListItem("All"));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlVehModel.Items.Add(new ListItem(Convert.ToString(dr["VEHMODEL"])));
            }

        }

        dr.Close();
        conn.Close();

    }




    protected void btnShow_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        {
            /////////Assign Procedure/////////////////
            sql = "get_TyreRunHistory";
            //  SqlConnection conn = new SqlConnection(mydbcon);

            conn.Open();
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            //string prodtype = cboProdType.SelectedItem.Value;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);



            da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = ddlVehicleNo.SelectedItem.Text.ToString().Trim();



            da.SelectCommand.Parameters.Add("@VehModel", SqlDbType.VarChar).Value = ddlVehModel.SelectedItem.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreNo", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();


            DataSet ds = new DataSet();
            da.Fill(ds);


            GridViewHelper helper = new GridViewHelper(this.GridView1);
            //string[] cols = new string[4];
            //cols[4] = "Total_Kms";
            cols[0] = "TYRE_VEHNO";




            helper.RegisterGroup("TYRE_VEHNO", true, true);
                //  helper.RegisterGroup(cols[0], true, false);


          


            helper.GroupHeader += new GroupEvent(helper_GroupHeader);


            helper.GroupSummary += new GroupEvent(helper_GroupSummary);

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }



        conn.Close();
        if (GridView1.Rows.Count != 0)
        {
            LinkButton1.Visible = true;

        }

        else
        {
            LinkButton1.Visible = false;
        }


    }

    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {


        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].Text = "Sub Total ";
    }


    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {



        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;


        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");






     

            row.Cells[0].Text = "Vehicle No:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
            // row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;
       
        



    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sql = "get_TyreRunHistory";
        //  SqlConnection conn = new SqlConnection(mydbcon);
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand("sql", conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;



        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
        conn.Close();

    }



    private void PrepareGridViewForExport(Control gv)
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
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        // ExportToExcel("Report.xls", GridView1);
        PrepareGridViewForExport(GridView1);
        ExportGridView();
    }
}
