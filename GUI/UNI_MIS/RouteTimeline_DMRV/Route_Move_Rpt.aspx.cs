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

public partial class GUI_UNI_MIS_RouteTimeline_DMRV_Route_Move_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string sql, i, THCNO, Status, Loc, EndLoc, StartLoc, Trans, Stat, FromDt, ToDt, sql1;
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
            FromDt = From.ToString("dd MMM yy");
            lblFrromDt.Text = From.ToString("dd MMM yy");
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            ToDt = To.ToString("dd MMM yy");
            lblToDt.Text = To.ToString("dd MMM yy");
            THCNO = Request.QueryString["THCNO"];
            Status = Request.QueryString["Status"];
            Loc = Request.QueryString["Loc"];
            EndLoc = Request.QueryString["EndLoc"];
            StartLoc = Request.QueryString["StartLoc"];
            Trans = Request.QueryString["Trans"];            

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

        if(THCNO.ToString() =="")
        {
            sqlCommand.CommandText = "webx_rut_movement_2";

            sqlCommand.Parameters.AddWithValue("@FROMDT", FromDt);
            sqlCommand.Parameters.AddWithValue("@TODT", ToDt);
            sqlCommand.Parameters.AddWithValue("@thcno", "All");
            sqlCommand.Parameters.AddWithValue("@startloc", StartLoc);
            sqlCommand.Parameters.AddWithValue("@endloc", EndLoc);
            sqlCommand.Parameters.AddWithValue("@enrutloc", Trans);
            sqlCommand.Parameters.AddWithValue("@status", Status);
        }
        else
        {
            sql = "select routecd,thcno,thcdt,routename,tobh_code,rvn_self,sourcehb,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,vehno,ld_actuwt,ul_actuwt,routecost,actload,(select payload from webx_VEHICLE_HDR v where v.vehno=m.vehno ) as payload from VW_ROUTEmovement m  with(NOLOCK)   where  thcno in ('" + THCNO.ToString() + "')";
            sqlCommand = new SqlCommand(sql, conn);
        }
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
            dt.Columns.Add("Vhi_No", typeof(string));
            dt.Columns.Add("Route_Code", typeof(string));
            dt.Columns.Add("Route", typeof(string));
            dt.Columns.Add("THC_No", typeof(string));
            dt.Columns.Add("THC_Dt", typeof(string));
            dt.Columns.Add("Last_Loc", typeof(string));
            dt.Columns.Add("Depart", typeof(string));
            dt.Columns.Add("Next_Loc", typeof(string));
            dt.Columns.Add("Pay_Load", typeof(string));
            dt.Columns.Add("Actual_Load", typeof(string));
            dt.Columns.Add("Status", typeof(string));            

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            string Hiren;
            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Vhi_No"] = drRows["vehno"].ToString();
                dr["Route_Code"] = drRows["routecd"].ToString();
                dr["Route"] = drRows["routename"].ToString();
                dr["THC_No"] = drRows["thcno"].ToString();
                if (drRows["thcdt"] is DBNull)
                {
                    dr["THC_Dt"] = "-";
                }
                else
                {
                    dr["THC_Dt"] = Convert.ToDateTime(drRows["thcdt"]).ToString("dd MMM yy");
                }
                dr["Last_Loc"] = drRows["sourcehb"].ToString();
                dr["Depart"] = Convert.ToDateTime(drRows["actdept_dt"]).ToString("dd MMM yy") + "  " + drRows["actdept_tm"].ToString();
                dr["Next_Loc"] = drRows["tobh_code"].ToString();
                if (drRows["payload"] is DBNull)
                {
                    dr["Pay_Load"] = "0";
                }
                else
                {
                    dr["Pay_Load"] = drRows["payload"].ToString();
                }

                dr["Actual_Load"] = drRows["ld_actuwt"].ToString();

                if (drRows["tobh_code"].ToString() == "Null")
                {
                    Stat = "Completed";
                }
                if (drRows["rvn_self"].ToString() == "N")
                {
                    if (drRows["tobh_code"].ToString() != "")
                    {
                        Stat = "between " + drRows["sourcehb"] + " and " + drRows["tobh_code"];
                    }
                    else
                    {
                        Stat = "";
                    }
                }
                if (drRows["rvn_self"].ToString() == "Y")
                {
                    Stat = "In Transit";
                }
                dr["Status"] = Stat.ToString();

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();
            }
            conn.Close();
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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Route_Summary.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("DMRV_Summary.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DMRV_Summary.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Route_DMRV_Rpt.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Route_DMRV_Rpt.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
