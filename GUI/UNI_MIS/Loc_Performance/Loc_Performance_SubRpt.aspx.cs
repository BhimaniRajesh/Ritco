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

public partial class GUI_UNI_MIS_Loc_Performance_Loc_Performance_SubRpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 1000;
    static string RO, Location, Report_Type, Status;
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
            lblRO.Text = Request.QueryString["Location"];
            Report_Type = Request.QueryString["Report_Type"];
            Status = Request.QueryString["Status"];

            if (Status == "1")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" List";
            }
            if (Status == "2")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which In Stock at location";
            }
            if (Status == "3")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed";
            }
            if (Status == "4")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed 0 hr";
            }
            if (Status == "5")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed 1-12 hr";
            }
            if (Status == "6")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed 12-24 hr";
            }
            if (Status == "7")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed 24-48 hr";
            }
            if (Status == "8")
            {
                lblBookLoc.Text = Session["DocketCalledAs"].ToString()+" which Departed > 48 hr";
            }

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
        sqlCommand.CommandText = "WEbx_location_Performance_Det";

        sqlCommand.Parameters.AddWithValue("@fromdt", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@todt", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@type", Status);
        sqlCommand.Parameters.AddWithValue("@fromloc", lblRO.Text);
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
            dt.Columns.Add("Doc_No", typeof(string));
            dt.Columns.Add("Dely_Loc", typeof(string));
            dt.Columns.Add("Consignor", typeof(string));
            dt.Columns.Add("Consignee", typeof(string));
            dt.Columns.Add("Doc_Dt", typeof(string));
            dt.Columns.Add("Doc_Entry", typeof(string));
            dt.Columns.Add("Comm_Dely", typeof(string));
            dt.Columns.Add("Last_Loc", typeof(string));
            dt.Columns.Add("Dep_Dt", typeof(string));
            dt.Columns.Add("Curr_Loc", typeof(string));
            dt.Columns.Add("Actual_Loc", typeof(string));
            dt.Columns.Add("Pkg_No", typeof(string));
            dt.Columns.Add("Charge", typeof(string));
            dt.Columns.Add("Arrival_Dt", typeof(string));
            dt.Columns.Add("Dely_dt", typeof(string));
            dt.Columns.Add("Diff_Hrs", typeof(string));


            DataRow dr;

            TimeSpan ts;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Doc_No"] = drRows["dockno"].ToString() + "" + drRows["docksf"].ToString();

                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                string sql = "select LocName as Location from webx_location where LocCode='" + drRows["reassign_destcd"].ToString() + "'";
                sqlCommand1 = new SqlCommand(sql, conn);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Dely_Loc"] = dr1["Location"];

                }
                dr1.Close();

                
                dr["Consignor"] = drRows["csgncd"].ToString() + " : " + drRows["csgnnm"].ToString();
                dr["Consignee"] = drRows["csgenm"].ToString();
                if (drRows["dockdt"] is DBNull)
                {
                    dr["Doc_Dt"] = "-";
                }
                else
                {
                    dr["Doc_Dt"] =Convert.ToDateTime(drRows["dockdt"]).ToString("dd MMM yyyy");
                }
                if (drRows["Dockdt_entry"] is DBNull)
                {
                    dr["Doc_Entry"] = "-";
                }
                else
                {
                    dr["Doc_Entry"] = Convert.ToDateTime(drRows["Dockdt_entry"]).ToString("dd MMM yyyy");
                }
                if (drRows["cdeldt"] is DBNull)
                {
                    dr["Comm_Dely"] = "-";
                }
                else
                {
                    dr["Comm_Dely"] = Convert.ToDateTime(drRows["cdeldt"]).ToString("dd MMM yyyy");
                }

                SqlCommand sqlCommand2 = new SqlCommand();
                sqlCommand2.Connection = conn;
                string sql2 = "select LocName as Location from webx_location where LocCode='" + drRows["last_loc"].ToString() + "'";
                sqlCommand2 = new SqlCommand(sql2, conn);

                SqlDataReader dr2 = sqlCommand2.ExecuteReader();

                while (dr2.Read())
                {
                    dr["Last_Loc"] = dr2["Location"];

                }
                dr2.Close();
                
                if (drRows["dep_dt"] is DBNull)
                {
                    dr["Dep_Dt"] = "-";
                }
                else
                {
                    dr["Dep_Dt"] = Convert.ToDateTime(drRows["dep_dt"]).ToString("dd MMM yyyy");
                }

                SqlCommand sqlCommand3 = new SqlCommand();
                sqlCommand3.Connection = conn;
                string sql3 = "select LocName as Location from webx_location where LocCode='" + drRows["curr_loc"].ToString() + "'";
                sqlCommand3 = new SqlCommand(sql3, conn);

                SqlDataReader dr3 = sqlCommand3.ExecuteReader();

                while (dr3.Read())
                {
                    dr["Curr_Loc"] = dr3["Location"];

                }
                dr3.Close();
                
                dr["Actual_Loc"] = drRows["dly_loc"].ToString();
                dr["Pkg_No"] = drRows["pkgsno"].ToString();
                dr["Charge"] = drRows["chrgwt"].ToString();
                if (drRows["arrv_dt"] is DBNull)
                {
                    dr["Arrival_Dt"] = "-";
                }
                else
                {
                    dr["Arrival_Dt"] = Convert.ToDateTime(drRows["arrv_dt"]).ToString("dd MMM yyyy");
                }
                if (drRows["dely_dt"] is DBNull)
                {
                    dr["Dely_dt"] = "-";
                }
                else
                {
                    dr["Dely_dt"] = Convert.ToDateTime(drRows["dely_dt"]).ToString("dd MMM yyyy");
                }
                dr["Diff_Hrs"] = drRows["diff_days"].ToString();


                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

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
        Loc_Performance.Border = 1;
        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Loc_Performance.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Loc_Performance.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
