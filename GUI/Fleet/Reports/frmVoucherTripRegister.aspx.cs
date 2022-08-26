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
using System.Text;
using System.IO;
 
public partial class Request_frmVoucherTripRegister : System.Web.UI.Page
{

    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
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

        if (!IsPostBack)
        {

            //Do Work
        }
    }



    //private void ExportToExcel(string strFileName, GridView dg)
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.ContentType = "application/vnd.ms-excel";
    //    Response.AddHeader("content-disposition",
    //    "attachment;filename=" + strFileName);
    //    Response.Charset = "";
    //    this.EnableViewState = false;
    //    System.IO.StringWriter sw = new StringWriter();
    //    System.Web.UI.HtmlTextWriter htw = new HtmlTextWriter(sw);
    //    GridView1.RenderControl(htw);
    //    Response.Write(sw.ToString());
    //    Response.End();
    //}
    

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


    protected void btnShow_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        {
            /////////Assign Procedure/////////////////
            sql = "get_Voucher_Trip_Register";
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

            da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
            da.SelectCommand.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
            da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = ddlStatus.Text;
                                                                  
                                                     
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
        cols[0] = "VSlipNo";
        cols[1] = "VehicleNo";
        cols[2] = "V_Type";
         cols[3] = "DriverName";
           //  helper.RegisterGroup(cols[0], true, true);

            helper.RegisterGroup("VSlipNo", true, true);
            helper.RegisterGroup(cols, true, true);
          //  helper.RegisterGroup(cols[0], true, true);
       
           //helper.RegisterGroup("V_Type", true, true);
           //helper.RegisterGroup("DriverName", true, true);
         

     
            // helper.ApplyGroupSort();

            //    helper.RegisterSummary("Total_Kms", SummaryOperation.Sum);
          //  helper.SetSuppressGroup("VSlipNo");
          
          //     helper.RegisterSummary("Total_Kms", SummaryOperation.Sum, cols[0]);
            helper.RegisterSummary("Total_Kms", SummaryOperation.Sum, "VSlipNo");
            helper.RegisterSummary("Total_Kms", SummaryOperation.Sum);

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
        //string selvalues = "";
        //string[] selvaluesArr;
     
       
           //    HeaderRow.Cells[0].Text = "VSLipNp";
            row.Cells[0].VerticalAlign = VerticalAlign.Top;
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            row.CssClass = "blackfnt";
            row.Cells[0].Font.Bold = true;
            //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");

            row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
            //#FFFFFF

            //selvaluesArr = row.Cells[0].Text.Split(new char[] { ',' });
            //int maxarr = selvaluesArr.GetUpperBound(0);
            //for (int i = 0; i <= maxarr; i++)
            //{
            //    string List = selvaluesArr[i].ToString().Trim();





               
            //}
            //if(row.Cells[0].Text!=)

           // row.Cells[0].Text = "VSlipNo:" + selvaluesArr[0].ToString().Trim() + "&nbsp;&nbsp;VehicleNo:" + selvaluesArr[1].ToString().Trim() + "&nbsp;&nbsp;VehicleType:" + selvaluesArr[2].ToString().Trim() + "&nbsp;&nbsp;VehicleNo:" + selvaluesArr[2].ToString().Trim();
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";
        //   row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;
           
      



    }
         
         
        //if (groupName == "VehicleNo")
        //{
        //    row.BackColor = System.Drawing.Color.FromArgb(236, 236, 236);
        //    row.Cells[0].Text = "VehicleNo" + row.Cells[0].Text;


        //}
  
   // private void helper_GroupHeader1(string groupName, object[] values, GridViewRow row)
   // {

   //    if (groupName == "VehicleNo")
   //    {
   //        row.Cells[1].VerticalAlign = VerticalAlign.Top;

   //        row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
   //        row.CssClass = "blackfnt";
   //        row.Cells[1].Font.Bold = true;
   //        //  row.BackColor = System.Drawing.Color.FromName("#D4E0E7");

   //        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
   //        //#FFFFFF
   //        row.Cells[1].Text = "VehicleNo:" + row.Cells[1].Text;
   //        //row.Cells[1].Text = "&nbsp;&nbsp;" + row.Cells[1].Text;
   //    }

   //}
    //private void helper_GroupHeader2(string groupName, object[] values, GridViewRow row)
    //{
    //   if (groupName == "V_Type")
    //   {
    //       row.Cells[2].VerticalAlign = VerticalAlign.Top;

    //       row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
    //       row.CssClass = "blackfnt";
    //       row.Cells[2].Font.Bold = true;
    //       row.BackColor = System.Drawing.Color.FromName("#D4E0E7");

    //       row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
          
    //       //row.Cells[2].Text = "VehicleType" + row.Cells[2].Text;
    //       row.Cells[2].Text = "&nbsp;&nbsp;" + row.Cells[2].Text;

    //   }
    //}
    //private void helper_GroupHeader3(string groupName, object[] values, GridViewRow row)
    //{
    //   if (groupName == "DriverName")
    //   {
    //       row.Cells[3].VerticalAlign = VerticalAlign.Top;

    //       row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
    //       row.CssClass = "blackfnt";
    //       row.Cells[3].Font.Bold = true;
    //       row.BackColor = System.Drawing.Color.FromName("#D4E0E7");

    //       row.BackColor = System.Drawing.Color.FromName("#FFFFFF");
            
    //       //row.Cells[3].Text = "DriverName" + row.Cells[3].Text;
    //       row.Cells[3].Text = "&nbsp;&nbsp;" + row.Cells[3].Text;
    //   }
    //}




    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sql = "get_Voucher_Trip_Register";
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
    protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        //RadioButtonList rbl = new RadioButtonList();
        //rbl = (RadioButtonList)sender;
        //if (!(rbl.Items[0].Selected))
        //{
        //    txtDateFrom.Text = strrightnow;
        //    txtDateTo.Text = strrightnow;
        //    txtDateFrom.ReadOnly = true;
        //    txtDateTo.ReadOnly = true;
        //}
        //if (rbl.Items[1].Selected)
        //{
        //    righnow = righnow.AddDays(-7);
        //    strrightnow = righnow.ToString("dd/MM/yyyy");
        //    txtDateFrom.Text = strrightnows
        //}
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
