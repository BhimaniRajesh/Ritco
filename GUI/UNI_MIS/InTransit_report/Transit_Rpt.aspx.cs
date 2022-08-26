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

public partial class GUI_UNI_MIS_InTransit_report_Transit_Rpt : System.Web.UI.Page
{
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 25;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!(IsPostBack))
        {
            lblRo1.Text = Request.QueryString["RoCode"];
            lblRo2.Text = Request.QueryString["NextRo"];
            lblLoc1.Text = Request.QueryString["LocCode"];
            lblLoc2.Text = Request.QueryString["NextLoc"];
            lblDay1.Text = Request.QueryString["No_Day"];
            lblDay2.Text = Request.QueryString["Number_Day"];

            BindGrid();
        }
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn3 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "Webx_Intransit_docket";

        sqlCommand.Parameters.AddWithValue("@fromRo", "All");
        sqlCommand.Parameters.AddWithValue("@fromloc", lblRo2.Text);
        sqlCommand.Parameters.AddWithValue("@toRo", lblLoc1.Text);
        sqlCommand.Parameters.AddWithValue("@toloc", lblLoc2.Text);
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
            dt.Columns.Add("Last_Loc", typeof(string));
            dt.Columns.Add("Next_Loc", typeof(string));
            dt.Columns.Add("Last_Loc1", typeof(string));
            dt.Columns.Add("Next_Loc1", typeof(string));
            dt.Columns.Add("TotDoc", typeof(string));
            dt.Columns.Add("Actual_Wg", typeof(string));
            dt.Columns.Add("Charge_Wg", typeof(string));
            dt.Columns.Add("Freigh_Wg", typeof(string));
            dt.Columns.Add("Doc_Tot", typeof(string));            
            dt.Columns.Add("LabelVisible", typeof(bool));
            dt.Columns.Add("LinkVisible", typeof(bool));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;
                dr["Last_Loc"] = drRows["from_loccode"].ToString();
                dr["Next_Loc"] = drRows["to_loccode"].ToString();

                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn3;
                string sql = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["from_loccode"].ToString() + "'";
                sqlCommand1 = new SqlCommand(sql, conn3);

                SqlDataAdapter daaa = new SqlDataAdapter(sqlCommand1);
                DataSet ddds = new DataSet();
                daaa.Fill(ddds);


                 foreach(DataRow dr1 in ddds.Tables[0].Rows)
                {
                    dr["Last_Loc1"] = dr1["Location"];
                    
                }
      
                conn3.Close();
                

                SqlCommand sqlCommand2 = new SqlCommand();
                sqlCommand2.Connection = conn2;
                string sql1 = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["to_loccode"].ToString() + "'";
                sqlCommand2 = new SqlCommand(sql1, conn2);

                SqlDataAdapter daaa2 = new SqlDataAdapter(sqlCommand2);
                DataSet ddds2 = new DataSet();
                daaa.Fill(ddds2);


                foreach (DataRow dr2 in ddds2.Tables[0].Rows)
                {
                    dr["Next_Loc1"] = dr2["Location"];
                }
       
                conn2.Close();

                
                dr["TotDoc"] = drRows["dockno"].ToString();
                dr["LabelVisible"] = (Convert.ToInt32(drRows["dockno"].ToString()) == 0 ? true : false);
                dr["LinkVisible"] = (Convert.ToInt32(drRows["dockno"].ToString()) == 0 ? false : true);

                dr["Actual_Wg"] = drRows["actuwt"].ToString();
                dr["Charge_Wg"] = drRows["chrgwt"].ToString();
                dr["Freigh_Wg"] = drRows["subtot"].ToString();
                dr["Doc_Tot"] = drRows["dkttot"].ToString();

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

        int ind = 0;
        int a = 0;
        try
        {
            // GV_Booking.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Docket_Flow_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            BindGrid_XLS();

     

            newtab.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }
    }

    private void BindGrid_XLS()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn3 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "Webx_Intransit_docket";

        sqlCommand.Parameters.AddWithValue("@fromRo", "All");
        sqlCommand.Parameters.AddWithValue("@fromloc", lblRo2.Text);
        sqlCommand.Parameters.AddWithValue("@toRo", lblLoc1.Text);
        sqlCommand.Parameters.AddWithValue("@toloc", lblLoc2.Text);
        sqlCommand.Parameters.AddWithValue("@fromdays", lblDay1.Text);
        sqlCommand.Parameters.AddWithValue("@todays", lblDay2.Text);


        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        ds = new DataSet();
     

         
        sqlDA.Fill(ds);

        
           

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("Last_Loc", typeof(string));
            dt.Columns.Add("Next_Loc", typeof(string));
            dt.Columns.Add("Last_Loc1", typeof(string));
            dt.Columns.Add("Next_Loc1", typeof(string));
            dt.Columns.Add("TotDoc", typeof(string));
            dt.Columns.Add("Actual_Wg", typeof(string));
            dt.Columns.Add("Charge_Wg", typeof(string));
            dt.Columns.Add("Freigh_Wg", typeof(string));
            dt.Columns.Add("Doc_Tot", typeof(string));
            dt.Columns.Add("LabelVisible", typeof(bool));
            dt.Columns.Add("LinkVisible", typeof(bool));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;
                dr["Last_Loc"] = drRows["from_loccode"].ToString();
                dr["Next_Loc"] = drRows["to_loccode"].ToString();

                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn2;

                string sql = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["from_loccode"].ToString() + "'";
                conn2.Open();
                sqlCommand1 = new SqlCommand(sql, conn2);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Last_Loc1"] = dr1["Location"];

                }
                dr1.Close();
                conn2.Close();
                conn3.Open();

                SqlCommand sqlCommand2 = new SqlCommand();
                sqlCommand2.Connection = conn3;
                string sql1 = "select LocCode+' : '+ LocName as Location from webx_location where LocCode='" + drRows["to_loccode"].ToString() + "'";
                sqlCommand2 = new SqlCommand(sql1, conn3);

                SqlDataReader dr2 = sqlCommand2.ExecuteReader();

                while (dr2.Read())
                {
                    dr["Next_Loc1"] = dr2["Location"];
                }
                dr2.Close();
                conn3.Close();

                dr["TotDoc"] = drRows["dockno"].ToString();
                dr["LabelVisible"] = (Convert.ToInt32(drRows["dockno"].ToString()) == 0 ? true : false);
                dr["LinkVisible"] = (Convert.ToInt32(drRows["dockno"].ToString()) == 0 ? false : true);

                dr["Actual_Wg"] = drRows["actuwt"].ToString();
                dr["Charge_Wg"] = drRows["chrgwt"].ToString();
                dr["Freigh_Wg"] = drRows["subtot"].ToString();
                dr["Doc_Tot"] = drRows["dkttot"].ToString();

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();
           
        }
    }
}


