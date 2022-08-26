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

public partial class GUI_UNI_MIS_ServiceTax_Collected_STax_Coll_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string LocCode, outbo, RoCode;
    protected void Page_Load(object sender, EventArgs e)
    {
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
            lblRO.Text = Request.QueryString["Ro"];
            lblBookLoc.Text = Request.QueryString["Loc"];
            LocCode = Request.QueryString["LocCode"];
            RoCode = Request.QueryString["RoCode"];
            outbo = Request.QueryString["outbo"];
            if (outbo == "outbo")
            {
                lblRptType.Text="Outbound Dockets";
            }
            else
            {
                lblRptType.Text = "Inbound Dockets";
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

        if (outbo == "outbo")
        {
            sqlCommand.CommandText = "webx_svctax_coll_bkg";
        }
        else
        {
            sqlCommand.CommandText = "webx_svctax_coll_dly";
        }

        sqlCommand.Parameters.AddWithValue("@FROMDT", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@TODT", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@RO", RoCode);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", LocCode);
        

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
            dt.Columns.Add("DocNo", typeof(string));
            dt.Columns.Add("DocDt", typeof(string));
            dt.Columns.Add("Paybas", typeof(string));
            dt.Columns.Add("Consignor", typeof(string));
            dt.Columns.Add("Consignee", typeof(string));
            dt.Columns.Add("Tot_Freight", typeof(string));
            dt.Columns.Add("Ser_Tax", typeof(string));
            dt.Columns.Add("Ser_Tax_Dly", typeof(string));
            dt.Columns.Add("Tot_Ser", typeof(string));
            dt.Columns.Add("MRNo", typeof(string));
            dt.Columns.Add("MRDt", typeof(string));
            

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double Tto_Freight = 0;
            double Svr_Tax = 0;
            double Svr_Tax_Dly = 0;
            double Total_Svr = 0;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Location"] = drRows["orgncd"].ToString();
                dr["DocNo"] = drRows["dockno"].ToString();
                dr["DocDt"] =Convert.ToDateTime(drRows["dockdt"]).ToString("dd MMM yyyy");
                if (drRows["paybas"].ToString().Trim() == "P01")
                {
                    dr["Paybas"] = "Paid";
                }
                
                dr["Consignor"] = drRows["csgncd"].ToString() + " : " + drRows["csgnnm"].ToString();
                dr["Consignee"] = drRows["csgecd"].ToString() + " : " + drRows["csgenm"].ToString();


                if (drRows["tot_frt"] is DBNull)
                {
                    dr["Tot_Freight"] = 0;
                }
                else
                {
                    dr["Tot_Freight"] = drRows["tot_frt"].ToString();
                }

                Tto_Freight += Convert.ToDouble(dr["Tot_Freight"]);
                if (drRows["stax"] is DBNull)
                {
                    dr["Ser_Tax"] = "0";
                }
                else
                {
                    dr["Ser_Tax"] = drRows["stax"].ToString();
                }
                Svr_Tax += Convert.ToDouble(dr["Ser_Tax"]);
                if (drRows["mstax"] is DBNull)
                {
                    dr["Ser_Tax_Dly"] = "0";
                }
                else
                {
                    dr["Ser_Tax_Dly"] = drRows["mstax"].ToString();
                }
                Svr_Tax_Dly += Convert.ToDouble(dr["Ser_Tax_Dly"]);
                dr["Tot_Ser"] = (Convert.ToDouble(dr["Ser_Tax"])) - (Convert.ToDouble(dr["Ser_Tax_Dly"]));
                Total_Svr += Convert.ToDouble(dr["Tot_Ser"]);
                
                dr["MRNo"] = drRows["MRSNo"].ToString();

                if (drRows["MRSDT"] is DBNull)
                {
                    dr["MRDt"] = "-";
                }
                else
                {
                    dr["MRDt"] = Convert.ToDateTime(drRows["MRSDT"]).ToString("dd MMM yyyy");
                }

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblTot_Fright.Text = Tto_Freight.ToString("0.00");
                lblSer_Tax.Text = Svr_Tax.ToString("0.00");
                lblSer_Tax_Dly.Text = Svr_Tax_Dly.ToString("0.00");
                lblTot_Ser.Text = Total_Svr.ToString("0.00");
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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Svc_Tax_Collected.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("Svc_Tax_Collected.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Svc_Tax_Collected.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Svc_Tax_Coll.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Svc_Tax_Coll.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
