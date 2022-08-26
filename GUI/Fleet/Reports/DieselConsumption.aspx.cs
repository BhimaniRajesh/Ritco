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

public partial class Reports_DieselConsumption : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dvwProducts;
    private GridViewHelper helper;
    //private GroupEvent helper_GroupHeader, helper_GroupSummary;
    //   private GroupEvent helper_GroupSummary;
    string Status = "";
    string sql = "";
    string[] cols = new string[4];
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        addVehicle();

        addRouteCode();
        if (!IsPostBack)
        {

            //Do Work
        }
    }



    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
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


    public void addVehicle()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //string STR = "select VEHNO from webx_VEHICLE_HDR H, webx_Vehicle_Type  T where T.Type_code=H.Vehicle_type    ActiveFlag='Y'   and  Vendor_Own='O'  and t.Fleet_type=0 order by VEHNO";

        string STR = "select VEHNO from webx_VEHICLE_HDR H, webx_Vehicle_Type  T where T.Type_code=H.Vehicle_type and   H.ActiveFlag='Y'    and t.Fleet_type=0 order by VEHNO";
        
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




    public void addRouteCode()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //string STR = "select VEHNO from webx_VEHICLE_HDR H, webx_Vehicle_Type  T where T.Type_code=H.Vehicle_type    ActiveFlag='Y'   and  Vendor_Own='O'  and t.Fleet_type=0 order by VEHNO";

        string STR = "select distinct (Select Location  from webx_citymaster  where city_code= R.Orgn_City)  as Origin ,(Select Location  from webx_citymaster  where city_code= R.Destn_City) as Destn ,(Select Location  from webx_citymaster  where city_code= R.Orgn_City)+'-'+(Select Location  from webx_citymaster  where city_code= R.Destn_City) RouteCode from  WEBX_FLEET_VEHICLE_REQUEST R";

        conn.Open();
        SqlCommand cmd1 = new SqlCommand(STR, conn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        ddlRoutecode.Items.Add(new ListItem("All"));

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {

                ddlRoutecode.Items.Add(new ListItem(Convert.ToString(dr1["RouteCode"])));
            }

        }

        dr1.Close();
        conn.Close();

    }


    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {



        //    HeaderRow.Cells[0].Text = "VSLipNp";
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
        //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");

        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
        
        if (ddlCategory.SelectedItem.Text == "Vehicle-Wise")
        {
            row.Cells[0].Text = "Vehicle No: " + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
            // row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;
        }
        if (ddlCategory.SelectedItem.Text == "Route-Wise")
        {
            row.Cells[0].Text = "Route : " + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
            // row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;
        }



    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        GridView1.PageIndex = e.NewPageIndex;

        sql = "usp_Dieselconsumption_List";
        //  SqlConnection conn = new SqlConnection(mydbcon);
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand("sql", conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        //string prodtype = cboProdType.SelectedItem.Value;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
        conn.Close();
        // BindGrid();
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

    protected void btnShow_Click(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       // string[] selvaluesArr;
        {
            /////////Assign Procedure/////////////////
            sql = "usp_Dieselconsumption_List";
            //  SqlConnection conn = new SqlConnection(mydbcon);

            conn.Open();
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            //string prodtype = cboProdType.SelectedItem.Value;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            {
                dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            }


            //selvaluesArr = ddlVehicleNo.Text.Split(new char[] { ',' });
            //int maxarr = selvaluesArr.GetUpperBound(0);
            //for (int i = 0; i <= maxarr; i++)
            //{
            //    string List = selvaluesArr[i].ToString().Trim();
                 
            //}


             string strName = "";
             if (ddlVehicleNo.Items.Count != 0)
             {
                 for (int i = 0; i < ddlVehicleNo.Items.Count; i++)
                 {

                     if (ddlVehicleNo.Items[i].Selected == true)
                     {

                         if (strName == "")
                         {
                             strName = ddlVehicleNo.Items[i].Text;
                             strName = strName.Replace("&", ":");
                         }
                         else
                         {
                             strName = strName + "," + ddlVehicleNo.Items[i].Text;
                             strName = strName.Replace("&", ":");
                         }

                     }

                 }
             }

             string strName1 = "";
            if (ddlRoutecode.Items.Count != 0)
             {
                 for (int i = 0; i < ddlRoutecode.Items.Count; i++)
                 {
                                                                                 
                         if (ddlRoutecode.Items[i].Selected == true)
                         {
                             if (strName1 == "")
                             {
                                 strName1 = ddlRoutecode.Items[i].Text;
                                 strName1 = strName1.Replace("&", ":");
                             }
                             else
                             {
                                 strName1 = strName1 + "," + ddlRoutecode.Items[i].Text;
                                 strName1 = strName1.Replace("&", ":");
                             }

                         }
                     
                 }
             }
           






            da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
            da.SelectCommand.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
            da.SelectCommand.Parameters.Add("@Details1", SqlDbType.VarChar).Value = strName;
            da.SelectCommand.Parameters.Add("@Details2", SqlDbType.VarChar).Value = strName1;

          //  da.SelectCommand.Parameters.Add("@Category", SqlDbType.VarChar).Value = strName;


            DataSet ds = new DataSet();
            da.Fill(ds);
            //     GridView1.DataSouece = ds;
            //    GridView1.DataBind();

            ////////Assign Original Value//////////////
            //strCodeId = txtWarehousesID.Text;
            //strDateFrom = "";
            //strDateTo = "";
            //strTitle = "";
            //strGenre = "";
            //strFormat = "";
            //strLanguage = "";
            //strComId = "";
            /////////Assigning Data Fields//////////
            //strG_CodeId = "@CodeID";
            //strG_fromDate = "@fromDate";
            //strG_toDate = "@toDate";
            //strG_Title = "0";
            //strG_Genre = "0";
            //strG_Format = "0";
            //strG_Language = "0";
            //strG_ComId = Session["MasterPageCompanyCode"].ToString();

            //ds = GService.Class_Stock_Register(connString, Proc, strCodeId, strDateFrom, strDateTo, strTitle, strGenre, strFormat, strLanguage, strComId, strG_CodeId, strG_fromDate, strG_toDate, strG_Title, strG_Genre, strG_Format, strG_Language, strG_ComId);

            GridViewHelper helper = new GridViewHelper(this.GridView1);
            //string[] cols = new string[4];
            //cols[4] = "Total_Kms";
            //cols[0] = "VSlipNo";
            //cols[1] = "VehicleNo";
            //cols[2] = "V_Type";
            //cols[3] = "DriverName";
            //  helper.RegisterGroup(cols[0], true, true);
            //  helper.RegisterGroup("RouteCode", false, false);
             // helper.RegisterGroup("VehicleNo", false, false);
            if (ddlCategory.SelectedItem.Text == "Vehicle-Wise")
            {
                helper.RegisterGroup("VehicleNo", true, false);
                //helper.RegisterGroup("RouteCode", true, false);
               //  helper.RegisterGroup("RouteCode", false, true);
         
            }
           
            if (ddlCategory.SelectedItem.Text == "Route-Wise")
            {
                helper.RegisterGroup("RouteCode", true, false);
                //helper.RegisterGroup("VehicleNo", true, false);
                //helper.RegisterGroup("VehicleNo", false, true);
            }

           
          //  helper.RegisterGroup(cols, true, true);
            //  helper.RegisterGroup(cols[0], true, true);

            //helper.RegisterGroup("V_Type", true, true);
            //helper.RegisterGroup("DriverName", true, true);



            // helper.ApplyGroupSort();

            //    helper.RegisterSummary("Total_Kms", SummaryOperation.Sum);
            //  helper.SetSuppressGroup("VSlipNo");

            //     helper.RegisterSummary("Total_Kms", SummaryOperation.Sum, cols[0]);
           // helper.RegisterSummary("Total_Kms", SummaryOperation.Sum, "VSlipNo");
         //   helper.RegisterSummary("Total_Kms", SummaryOperation.Sum);

            helper.GroupHeader += new GroupEvent(helper_GroupHeader);
            //helper.RegisterSummary("NoOfDays", SummaryOperation.Sum);
            //helper.RegisterSummary("StockValue", SummaryOperation.Sum);
            //helper.RegisterSummary("QTY", SummaryOperation.Sum, "VehicleNo");
            //  helper.RegisterSummary("VSlipNo", SummaryOperation.Sum, "VSlipNo");
            //helper.RegisterSummary("ISSUE_QTY", SummaryOperation.Sum, "VehicleNo");
            ////helper.RegisterSummary("NoOfDays", SummaryOperation.Sum, "SKU_Code");
            //helper.RegisterSummary("StockValue", SummaryOperation.Sum, "VehicleNo");
            helper.GroupSummary += new GroupEvent(helper_GroupSummary);

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }



        conn.Close();
        //if (GridView1.Rows.Count != 0)
        //{
        //    LinkButton1.Visible = true;

        //}

        //else
        //{
        //    LinkButton1.Visible = false;
        //}
    }
}
