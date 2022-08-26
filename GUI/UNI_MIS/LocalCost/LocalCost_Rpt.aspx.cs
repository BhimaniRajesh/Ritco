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

public partial class GUI_UNI_MIS_LocalCost_LocalCost_Rpt : System.Web.UI.Page
{
    static string VendorType, Vendor, Sql, VendorCode;
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    static DataSet ds, dsPages;
    DataView dv;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    string VenType;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!IsPostBack)
        {
            string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            Common objCommon = new Common();
            objCommon.doCacheRoutine();
            this.Title = pagetitle;

            lblVendorType.Text = Request.QueryString["VendorType"];
            lblVendor.Text = Request.QueryString["Vendor"];
            VenType = Request.QueryString["VendorCode"];
            From = Convert.ToDateTime(Request.QueryString["dateFrom"].ToString());
            To = Convert.ToDateTime(Request.QueryString["dateTo"].ToString());
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");            

            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "webx_localcost";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        
        

        sqlcmd.Parameters.Add("@vendor", SqlDbType.VarChar).Value = VenType;
        sqlcmd.Parameters.Add("@vendID", SqlDbType.VarChar).Value = "";
        sqlcmd.Parameters.Add("@FROMDT", SqlDbType.DateTime).Value = lblDtFrom.Text;
        sqlcmd.Parameters.Add("@TODT", SqlDbType.DateTime).Value = lblDtTo.Text;

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlcmd);

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
            dt.Columns.Add("Vendor", typeof(string));
            dt.Columns.Add("Ven_Type", typeof(string));
            dt.Columns.Add("Location", typeof(string));
            dt.Columns.Add("Tot_Doc", typeof(string));
            dt.Columns.Add("Days", typeof(string));
            dt.Columns.Add("Cost", typeof(string));
            dt.Columns.Add("Tot_Cost", typeof(string));
            dt.Columns.Add("Num_DRS", typeof(string));
            dt.Columns.Add("Tot_Kg", typeof(string));
            dt.Columns.Add("Tot_CNS", typeof(string));
            dt.Columns.Add("Num_PRS", typeof(string));
            dt.Columns.Add("Total_Kg", typeof(string));
            dt.Columns.Add("Total_CNS", typeof(string));
            dt.Columns.Add("Cost_Kg", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Vendor"] = drRows["vendorcode"].ToString() + " : " + drRows["vendorname"].ToString();
                dr["Ven_Type"] = "VENDOR - ROAD - LOCAL";//drRows["loccode"].ToString();
                dr["Location"] = drRows["Location"].ToString();
                dr["Tot_Doc"] = drRows["doc"].ToString();
                dr["Days"] = drRows["days"].ToString();
                if (drRows["cost_permonth"] is DBNull)
                {
                    dr["Cost"] = "0";
                }
                else
                {
                    dr["Cost"] = (Convert.ToDouble(drRows["cost_permonth"])) / 30;
                }
                dr["Tot_Cost"] = (Convert.ToDouble(dr["Days"])) * (Convert.ToDouble(dr["Cost"]));
                dr["Num_DRS"] = drRows["d_total"].ToString();
                dr["Tot_Kg"] = drRows["DRS_DOCkET_wt"].ToString();
                dr["Tot_CNS"] = drRows["DRS_DOCLET"].ToString();
                dr["Num_PRS"] = drRows["P_total"].ToString();
                if (drRows["PRS_DOCkET_wt"] is DBNull)
                {
                    dr["Total_Kg"]="0";
                }
                else
                {
                    dr["Total_Kg"] = drRows["PRS_DOCkET_wt"].ToString();
                }
                if (drRows["PRS_DOCLET"] is DBNull)
                {
                    dr["Total_CNS"] = "0";
                }
                else
                {
                    dr["Total_CNS"] = drRows["PRS_DOCLET"].ToString();
                }
                if (dr["Tot_Cost"].ToString() == "0")
                {
                    dr["Cost_Kg"] = "0";
                }
                else
                {
                    dr["Cost_Kg"] = (Convert.ToDouble(dr["Tot_Cost"])) / ((Convert.ToDouble(dr["Tot_CNS"])) * (Convert.ToDouble(dr["Total_Kg"])));
                }

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
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("LocalCost.csv"), false);

        DataTable dt = ds.Tables[0];
        int iColCount = dt.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(ds.Tables[0].Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);

        foreach (DataRow dr in dt.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();

        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("LocalCost.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "LocalCost.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
    }    
}
