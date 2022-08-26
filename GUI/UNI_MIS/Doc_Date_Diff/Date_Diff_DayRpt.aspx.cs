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

public partial class GUI_UNI_MIS_Doc_Date_Diff_Date_Diff_DayRpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    string Number;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 100;
    string sql, i, LocCode, RoCode, DateType;
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
            lblFromDt.Text = From.ToString("dd MMM yy");
            lblToDt.Text = To.ToString("dd MMM yy");
            lblRo.Text = Request.QueryString["Ro"];
            lblBookLoc.Text = Request.QueryString["Loc"];
            lblDtFrom.Text = Request.QueryString["FromDt"];
            lblDtTo.Text = Request.QueryString["ToDt"];
            RoCode = Request.QueryString["RoCode"];
            LocCode = Request.QueryString["LocCode"];
            DateType = Request.QueryString["DateType"];

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

        sqlCommand.CommandText = "webx_Datediff_report_new";

        sqlCommand.Parameters.AddWithValue("@fromdt", From);
        sqlCommand.Parameters.AddWithValue("@todt", To);
        sqlCommand.Parameters.AddWithValue("@fromRo", RoCode);
        sqlCommand.Parameters.AddWithValue("@fromloc", LocCode);
        sqlCommand.Parameters.AddWithValue("@custcode", "");
        sqlCommand.Parameters.AddWithValue("@fromdays", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@todays", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@datetype", DateType);
        sqlCommand.Parameters.AddWithValue("@reporttype", "S");

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
            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;

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
            dt.Columns.Add("TotBook", typeof(string));
            dt.Columns.Add("Delay", typeof(string));
            dt.Columns.Add("Percent", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = 1;
            //double dobTotDocket = 0;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Location"] = drRows["from_loccode"].ToString();
              
                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                string sql = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["from_loccode"].ToString() + "'";
                sqlCommand1 = new SqlCommand(sql, conn);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Location1"] = dr1["Location"];

                }
                dr1.Close();                   
                
                dr["TotBook"] = drRows["docktot"].ToString();
                //dr["TotBook"] = drRows["days_dkttot"].ToString();
                dr["Delay"] = drRows["days_dkttot"].ToString();
                dr["Percent"] = drRows["days_dkttot_per"].ToString() + " %";

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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Doc_Dt_Diff.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("Doc_Dt_Diff.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Doc_Dt_Diff.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        int ind = 0;
        int a = 0;
        Day_Rpt.Border = 1;
        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Docket_Date_Diff.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Day_Rpt.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
