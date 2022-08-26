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

public partial class GUI_UNI_MIS_Loc_Performance_Loc_Performance_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 1000;
    static string RO, Location, Report_Type;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!(IsPostBack))
        {
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");
            lblRO.Text = Request.QueryString["RO"];
            lblBookLoc.Text = Request.QueryString["Location"];
            Report_Type = Request.QueryString["Report_Type"];
            if (Report_Type == "1")
            {
                lblReportType.Text = "Booked At This Location";
            }
            if (Report_Type == "2")
            {
                lblReportType.Text = "Not Booked At This Location";
            }
            if (Report_Type == "3")
            {
                lblReportType.Text = "Both";
            }
            RO = Request.QueryString["Ro_Code"];
            Location = Request.QueryString["Loc_Code"];

            BindGrid();
        }
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "WEbx_location_Performance";

        sqlCommand.Parameters.AddWithValue("@fromdt", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@todt", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@fromRo", RO);
        sqlCommand.Parameters.AddWithValue("@fromloc", Location);
        sqlCommand.Parameters.AddWithValue("@Reporttype", Report_Type);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        ds = new DataSet();
        dsPages = new DataSet();

        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtMRDetails");
        sqlDA.Fill(dsPages);

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
            HIDCurrentPageNo.Value = "1";
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;

            // trForTotalValues.Visible = false;
            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;
            //lblComment.Visible = false;
        }
        else
        {
            double dblTotalRecords = dsPages.Tables[0].Rows.Count;
            double dblTotalPages = Convert.ToDouble(System.Math.Ceiling(Convert.ToDecimal(dblTotalRecords / intPageSize)));

            if (dblTotalPages <= 1)
            {
                tblPageNavigation.Visible = false;
            }
            //Logic for Managing Page Navigation Links
            if (intCurrentPageNo == 1)
            {
                FirstPage.Enabled = false;
                PreviousPage.Enabled = false;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }
            else if (intCurrentPageNo == dblTotalPages)
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = false;
                LastPage.Enabled = false;
            }
            else
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }

            ddlPages.Items.Clear();

            ListItem lItem;

            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                ddlPages.Items.Add(lItem);

                if (i == Convert.ToInt32(HIDCurrentPageNo.Value))
                {
                    ddlPages.SelectedIndex = ddlPages.Items.Count - 1;
                }

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("Location", typeof(string));
            dt.Columns.Add("Location1", typeof(string));
            dt.Columns.Add("Docket", typeof(string));
            dt.Columns.Add("Stock", typeof(string));
            dt.Columns.Add("Tot_Dep", typeof(string));
            dt.Columns.Add("Depart1", typeof(string));
            dt.Columns.Add("Percentage1", typeof(string));
            dt.Columns.Add("Depart2", typeof(string));
            dt.Columns.Add("Percentage2", typeof(string));
            dt.Columns.Add("Depart3", typeof(string));
            dt.Columns.Add("Percentage3", typeof(string));
            dt.Columns.Add("Depart4", typeof(string));
            dt.Columns.Add("Percentage4", typeof(string));
            dt.Columns.Add("Depart5", typeof(string));
            dt.Columns.Add("Percentage5", typeof(string));
            dt.Columns.Add("LabelVisible", typeof(bool));
            dt.Columns.Add("LinkVisible", typeof(bool));
            dt.Columns.Add("LabelVisible1", typeof(bool));
            dt.Columns.Add("LinkVisible1", typeof(bool));
            dt.Columns.Add("LabelVisible2", typeof(bool));
            dt.Columns.Add("LinkVisible2", typeof(bool));
            dt.Columns.Add("LabelVisible3", typeof(bool));
            dt.Columns.Add("LinkVisible3", typeof(bool));
            dt.Columns.Add("LabelVisible4", typeof(bool));
            dt.Columns.Add("LinkVisible4", typeof(bool));
            dt.Columns.Add("LabelVisible5", typeof(bool));
            dt.Columns.Add("LinkVisible5", typeof(bool));
            dt.Columns.Add("LabelVisible6", typeof(bool));
            dt.Columns.Add("LinkVisible6", typeof(bool));
            dt.Columns.Add("LabelVisible7", typeof(bool));
            dt.Columns.Add("LinkVisible7", typeof(bool));

            DataRow dr;

            TimeSpan ts;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double Docket = 0;
            double Stock = 0;
            double Tot_Dep = 0;
            double Depart1 = 0;
            double Percentage1 = 0;
            double Depart2 = 0;
            double Percentage2 = 0;
            double Depart3 = 0;
            double Percentage3 = 0;
            double Depart4 = 0;
            double Percentage4 = 0;
            double Depart5 = 0;
            double Percentage5 = 0;


            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                
                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                string sql = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["loccode"].ToString() + "'";
                sqlCommand1 = new SqlCommand(sql, conn);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Location1"] = dr1["Location"];

                }
                dr1.Close();

                dr["Location"] = drRows["loccode"].ToString();
                dr["Docket"] = drRows["Total_docket"].ToString();
                dr["LabelVisible"] = (Convert.ToInt32(drRows["Total_docket"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible"] = (Convert.ToInt32(drRows["Total_docket"].ToString()) == 0.00 ? false : true);
                Docket += Convert.ToDouble(drRows["Total_docket"].ToString());

                dr["Stock"] = drRows["Docket_InStock"].ToString();
                dr["LabelVisible1"] = (Convert.ToInt32(drRows["Docket_InStock"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible1"] = (Convert.ToInt32(drRows["Docket_InStock"].ToString()) == 0.00 ? false : true);
                Stock += Convert.ToDouble(drRows["Docket_InStock"]);

                dr["Tot_Dep"] = drRows["Totaldeparted_Docket"].ToString();
                dr["LabelVisible2"] = (Convert.ToInt32(drRows["Totaldeparted_Docket"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible2"] = (Convert.ToInt32(drRows["Totaldeparted_Docket"].ToString()) == 0.00 ? false : true);
                Tot_Dep += Convert.ToDouble(drRows["Totaldeparted_Docket"]);

                dr["Depart1"] = drRows["departed_0"].ToString();
                dr["LabelVisible3"] = (Convert.ToInt32(drRows["departed_0"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible3"] = (Convert.ToInt32(drRows["departed_0"].ToString()) == 0.00 ? false : true);
                Depart1 += Convert.ToDouble(drRows["departed_0"]);

                dr["Percentage1"] = drRows["departed_0_per"].ToString() + " %";
                //Percentage1 += Convert.ToDouble(drRows["departed_0_per"]);
                dr["Depart2"] = drRows["departed_1"].ToString();
                dr["LabelVisible4"] = (Convert.ToInt32(drRows["departed_1"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible4"] = (Convert.ToInt32(drRows["departed_1"].ToString()) == 0.00 ? false : true);
                Depart2 += Convert.ToDouble(drRows["departed_1"]);

                dr["Percentage2"] = drRows["departed_1_per"].ToString() + " %";
                //Percentage2 += Convert.ToDouble(drRows["departed_1_per"]);
                dr["Depart3"] = drRows["departed_2"].ToString();
                dr["LabelVisible5"] = (Convert.ToInt32(drRows["departed_2"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible5"] = (Convert.ToInt32(drRows["departed_2"].ToString()) == 0.00 ? false : true);
                Depart3 += Convert.ToDouble(drRows["departed_2"]);

                dr["Percentage3"] = drRows["departed_2_per"].ToString() + " %";
                //Percentage3 += Convert.ToDouble(drRows["departed_2_per"]);
                dr["Depart4"] = drRows["departed_3"].ToString();
                dr["LabelVisible6"] = (Convert.ToInt32(drRows["departed_3"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible6"] = (Convert.ToInt32(drRows["departed_3"].ToString()) == 0.00 ? false : true);
                Depart4 += Convert.ToDouble(drRows["departed_3"]);

                dr["Percentage4"] = drRows["departed_3_per"].ToString() + " %";
               //Percentage4 += Convert.ToDouble(drRows["departed_3_per"]);
                dr["Depart5"] = drRows["departed_4"].ToString();
                dr["LabelVisible7"] = (Convert.ToInt32(drRows["departed_4"].ToString()) == 0.00 ? true : false);
                dr["LinkVisible7"] = (Convert.ToInt32(drRows["departed_4"].ToString()) == 0.00 ? false : true);
                Depart5 += Convert.ToDouble(drRows["departed_4"]);

                dr["Percentage5"] = drRows["departed_4_per"].ToString() + " %";
                //Percentage5 += Convert.ToDouble(drRows["departed_4_per"]);

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();
                

                lblLocBook.Text = Docket.ToString();
                lblStock.Text = Stock.ToString();
                lblTotDep.Text = Tot_Dep.ToString();
                lblDepart1.Text = Depart1.ToString();
                Percentage1 = (Depart1 * 100) / Docket;
                lblPercentage1.Text = Percentage1.ToString("0.00");
                lblDepart2.Text = Depart2.ToString();
                Percentage2 = (Depart2 * 100) / Docket;
                lblPercentage2.Text = Percentage2.ToString("0.00");
                lblDepart3.Text = Depart3.ToString();
                Percentage3 = (Depart3 * 100) / Docket;
                lblPercentage3.Text = Percentage3.ToString("0.00");
                lblDepart4.Text = Depart4.ToString();
                Percentage4 = (Depart4 * 100) / Docket;
                lblPercentage4.Text = Percentage4.ToString("0.00");
                lblDepart5.Text = Depart5.ToString();
                Percentage5 = (Depart5 * 100) / Docket;
                lblPercentage5.Text = Percentage5.ToString("0.00");
            }
        }
    }

    protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "First":
                intCurrentPageNo = 1;
                break;
            case "Last":
                intCurrentPageNo = Int32.Parse(TotalPages.Text);
                break;
            case "Next":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
                break;
            case "Prev":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
                break;
        }
        HIDCurrentPageNo.Value = intCurrentPageNo.ToString();
        BindGrid();
    }

    protected void btnXLS_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Location_Performance.csv"), false);

        //DataTable dt = ds.Tables[0];
        //int iColCount = dt.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(ds.Tables[0].Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);

        //foreach (DataRow dr in dt.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();

        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("Location_Performance.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Location_Performance.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        Loc_Perfomance.Border = 1;
        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Loc_Performance.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Loc_Perfomance.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
