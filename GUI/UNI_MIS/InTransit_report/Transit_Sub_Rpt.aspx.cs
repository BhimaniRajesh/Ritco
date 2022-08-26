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

public partial class GUI_UNI_MIS_InTransit_report_Transit_Sub_Rpt : System.Web.UI.Page
{
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string Last_Loc, Next_Loc;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!(IsPostBack))
        {
            Last_Loc = Request.QueryString["Last_Loc"];
            Next_Loc = Request.QueryString["Next_Loc"];
            lblDay1.Text = Request.QueryString["Day1"];
            lblDay2.Text = Request.QueryString["Day2"];

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

        sqlCommand.CommandText = "Webx_Intransit_docket_DET_HR";

        sqlCommand.Parameters.AddWithValue("@fromloc", Last_Loc);
        sqlCommand.Parameters.AddWithValue("@toloc", Next_Loc);
        sqlCommand.Parameters.AddWithValue("@fromdays", lblDay1.Text);
        sqlCommand.Parameters.AddWithValue("@todays", lblDay2.Text);

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
            dt.Columns.Add("Doc_no", typeof(string));
            dt.Columns.Add("Dly_Loc", typeof(string));
            dt.Columns.Add("Consignor", typeof(string));
            dt.Columns.Add("Consignee", typeof(string));
            dt.Columns.Add("Doc_Date", typeof(string));
            dt.Columns.Add("Doc_Entry_Dt", typeof(string));
            dt.Columns.Add("Comm_Dly_Dt", typeof(string));
            dt.Columns.Add("Last_Loc", typeof(string));
            dt.Columns.Add("Dep_Dt", typeof(string));
            dt.Columns.Add("Curr_Loc", typeof(string));
            dt.Columns.Add("Actual_Loc", typeof(string));
            dt.Columns.Add("Pkg_No", typeof(string));
            dt.Columns.Add("Chrg_Wg", typeof(string));
            dt.Columns.Add("Arrival_Dt", typeof(string));
            dt.Columns.Add("Thc_Date", typeof(string));
            dt.Columns.Add("Days", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Doc_no"] = drRows["dockno"].ToString() + "" + drRows["docksf"].ToString();

                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                string sql = "select LocName as Location from webx_location where LocCode='" + drRows["reassign_destcd"].ToString() + "'";
                sqlCommand1 = new SqlCommand(sql, conn);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Dly_Loc"] = dr1["Location"];

                }
                dr1.Close();
                 
                dr["Consignor"] = drRows["csgncd"].ToString();
                dr["Consignee"] = drRows["csgecd"].ToString();
                if (drRows["dockdt"] is DBNull)
                {
                    dr["Doc_Date"] = "-";
                }
                else
                {
                    dr["Doc_Date"] =Convert.ToDateTime(drRows["dockdt"]).ToString("dd MMM yyyy");
                }
                if (drRows["Dockdt_entry"] is DBNull)
                {
                    dr["Doc_Entry_Dt"] = "-";
                }
                else
                {
                    dr["Doc_Entry_Dt"] =Convert.ToDateTime(drRows["Dockdt_entry"]).ToString("dd MMM yyyy");
                }
                if (drRows["cdeldt"] is DBNull)
                {
                    dr["Comm_Dly_Dt"] = "-";
                }
                else
                {
                    dr["Comm_Dly_Dt"] =Convert.ToDateTime(drRows["cdeldt"]).ToString("dd MMM yyyy");
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
                    dr["Dep_Dt"] =Convert.ToDateTime(drRows["dep_dt"]).ToString("dd MMM yyyy");
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
                dr["Chrg_Wg"] = drRows["chrgwt"].ToString();
                if (drRows["arrv_dt"] is DBNull)
                {
                    dr["Arrival_Dt"] = "-";
                }
                else
                {
                    dr["Arrival_Dt"] =Convert.ToDateTime(drRows["arrv_dt"]).ToString("dd MMM yyyy");
                }
                if (drRows["thcdt"] is DBNull)
                {
                    dr["Thc_Date"] = "-";
                }
                else
                {
                    dr["Thc_Date"] =Convert.ToDateTime(drRows["thcdt"]).ToString("dd MMM yyyy");
                }
                dr["Days"] = drRows["diff_days"].ToString();

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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("In_Transit_Report.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("In_Transit_Report.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "In_Transit_Report.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=In_Transit_Rpt.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Sub_Rpt.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
