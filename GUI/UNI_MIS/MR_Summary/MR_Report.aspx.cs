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
using System.Text;
using System.IO;

public partial class GUI_UNI_MIS_MR_Summary_MR_Report : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
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
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            lblRo.Text = Request.QueryString["LocationCode"];
            lblLoc.Text = Request.QueryString["Location"];
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");

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
        sqlCommand.CommandText = "webx_UNI_MR_Summry";

        sqlCommand.Parameters.AddWithValue("@FROMDT", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@TODT", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@RO", lblRo.Text);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", lblLoc.Text);
        sqlCommand.Parameters.AddWithValue("@LOCTYP", "");

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
            btnXLS.Visible = false;
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
            dt.Columns.Add("loccode", typeof(string));
            dt.Columns.Add("locname", typeof(string));
            dt.Columns.Add("Paid_MR", typeof(string));
            dt.Columns.Add("Paid_amt", typeof(string));
            dt.Columns.Add("DEL_MR", typeof(string));
            dt.Columns.Add("DEL_amt", typeof(string));
            dt.Columns.Add("DUE_MR", typeof(string));
            dt.Columns.Add("DUE_amt", typeof(string));
            dt.Columns.Add("CAN_MR", typeof(string));
            dt.Columns.Add("CAN_amt", typeof(string));
            dt.Columns.Add("TotalDocKet", typeof(string));
            dt.Columns.Add("TotalAmt", typeof(string));
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
            //dt.Columns.Add("UNDLY_TOTDKTS", typeof(string));

            DataRow dr;

            TimeSpan ts;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double PaidMR = 0;
            double PaidAmt = 0;
            double DELMR = 0;
            double DELAmt = 0;
            double DUEMR = 0;
            double DUEAmt = 0;
            double CANMR = 0;
            double CANAmt = 0;
            double TotalDoc = 0;
            double TotalAmt = 0;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["loccode"] = drRows["loccode"].ToString();

                //*********dr[" "] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();


                dr["locName"] = drRows["locName"].ToString();
                dr["Paid_MR"] = drRows["Paid_MR"].ToString();
                dr["Paid_amt"] = drRows["Paid_amt"].ToString();
                dr["DEL_MR"] = drRows["DEL_MR"].ToString();
                dr["DEL_amt"] = drRows["DEL_amt"].ToString();
                dr["DUE_MR"] = drRows["DUE_MR"].ToString();
                dr["DUE_amt"] = drRows["DUE_amt"].ToString();
                dr["CAN_MR"] = drRows["CAN_MR"].ToString();
                dr["CAN_amt"] = drRows["CAN_amt"].ToString();

                dr["TotalDocKet"] = Convert.ToDouble(drRows["Paid_MR"].ToString()) + Convert.ToDouble(drRows["DEL_MR"].ToString()) + Convert.ToDouble(drRows["DUE_MR"].ToString()) + Convert.ToDouble(drRows["CAN_MR"].ToString());
                dr["TotalAmt"] = Convert.ToDouble(drRows["Paid_amt"].ToString()) + Convert.ToDouble(drRows["DEL_amt"].ToString()) + Convert.ToDouble(drRows["DUE_amt"].ToString()) + Convert.ToDouble(drRows["CAN_amt"].ToString());

                if (drRows["Paid_MR"] is DBNull)
                {
                    dr["Paid_MR"] = "0.00";
                    dr["LabelVisible"] = (Convert.ToInt32(drRows["Paid_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible"] = (Convert.ToInt32(drRows["Paid_MR"].ToString()) == 0.00 ? false : true);
                }
                else
                {
                    dr["Paid_MR"] = Convert.ToDouble(drRows["Paid_MR"]).ToString("0.00");
                    PaidMR += Convert.ToDouble(drRows["Paid_MR"]);
                    dr["LabelVisible"] = (Convert.ToInt32(drRows["Paid_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible"] = (Convert.ToInt32(drRows["Paid_MR"].ToString()) == 0.00 ? false : true);
                }

                if (drRows["Paid_amt"] is DBNull)
                {
                    dr["Paid_amt"] = "0.00";

                }
                else
                {
                    dr["Paid_amt"] = Convert.ToDouble(drRows["Paid_amt"]).ToString("0.00");
                    PaidAmt += Convert.ToDouble(drRows["Paid_amt"]);
                }

                if (drRows["DEL_MR"] is DBNull)
                {
                    dr["DEL_MR"] = "0.00";
                    dr["LabelVisible1"] = (Convert.ToInt32(drRows["DEL_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible1"] = (Convert.ToInt32(drRows["DEL_MR"].ToString()) == 0.00 ? false : true);
                }
                else
                {
                    dr["DEL_MR"] = Convert.ToDouble(drRows["DEL_MR"]).ToString("0.00");
                    DELMR += Convert.ToDouble(drRows["DEL_MR"]);
                    dr["LabelVisible1"] = (Convert.ToInt32(drRows["DEL_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible1"] = (Convert.ToInt32(drRows["DEL_MR"].ToString()) == 0.00 ? false : true);

                }

                if (drRows["DEL_amt"] is DBNull)
                {
                    dr["DEL_amt"] = "0.00";
                }
                else
                {
                    dr["DEL_amt"] = Convert.ToDouble(drRows["DEL_amt"]).ToString("0.00");
                    DELAmt += Convert.ToDouble(drRows["DEL_amt"]);
                }

                if (drRows["DUE_MR"] is DBNull)
                {
                    dr["DUE_MR"] = "0.00";
                    dr["LabelVisible2"] = (Convert.ToInt32(drRows["DUE_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible2"] = (Convert.ToInt32(drRows["DUE_MR"].ToString()) == 0.00 ? false : true);
                }
                else
                {
                    dr["DUE_MR"] = Convert.ToDouble(drRows["DUE_MR"]).ToString("0.00");
                    DUEMR += Convert.ToDouble(drRows["DUE_MR"]);
                    dr["LabelVisible2"] = (Convert.ToInt32(drRows["DUE_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible2"] = (Convert.ToInt32(drRows["DUE_MR"].ToString()) == 0.00 ? false : true);
                }

                if (drRows["DUE_amt"] is DBNull)
                {
                    dr["DUE_amt"] = "0.00";
                }
                else
                {
                    dr["DUE_amt"] = Convert.ToDouble(drRows["DUE_amt"]).ToString("0.00");
                    DUEAmt += Convert.ToDouble(drRows["DUE_amt"]);
                }

                if (drRows["CAN_MR"] is DBNull)
                {
                    dr["CAN_MR"] = "0.00";
                    dr["LabelVisible3"] = (Convert.ToInt32(drRows["CAN_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible3"] = (Convert.ToInt32(drRows["CAN_MR"].ToString()) == 0.00 ? false : true);
                }
                else
                {
                    dr["CAN_MR"] = Convert.ToDouble(drRows["CAN_MR"]).ToString("0.00");
                    CANMR += Convert.ToDouble(drRows["CAN_MR"]);
                    dr["LabelVisible3"] = (Convert.ToInt32(drRows["CAN_MR"].ToString()) == 0.00 ? true : false);
                    dr["LinkVisible3"] = (Convert.ToInt32(drRows["CAN_MR"].ToString()) == 0.00 ? false : true);
                }

                if (drRows["CAN_amt"] is DBNull)
                {
                    dr["CAN_amt"] = "0.00";
                }
                else
                {
                    dr["CAN_amt"] = Convert.ToDouble(drRows["CAN_amt"]).ToString("0.00");
                    CANAmt += Convert.ToDouble(drRows["CAN_amt"]);
                }

                if (drRows["Paid_MR"] is DBNull && drRows["DEL_MR"] is DBNull && drRows["DUE_MR"] is DBNull && drRows["CAN_MR"] is DBNull)
                {
                    dr["TotalDocKet"] = "0.00";
                }
                else
                {
                    dr["TotalDocKet"] = Convert.ToDouble(drRows["Paid_MR"].ToString()) + Convert.ToDouble(drRows["DEL_MR"].ToString()) + Convert.ToDouble(drRows["DUE_MR"].ToString()) + Convert.ToDouble(drRows["CAN_MR"].ToString());
                    TotalDoc += Convert.ToDouble(dr["TotalDocKet"].ToString());
                    dr["LabelVisible4"] = (Convert.ToInt32(dr["TotalDocKet"].ToString()) == 0 ? true : false);
                    dr["LinkVisible4"] = (Convert.ToInt32(dr["TotalDocKet"].ToString()) == 0 ? false : true);
                }

                if (drRows["Paid_amt"] is DBNull && drRows["DEL_amt"] is DBNull && drRows["DUE_amt"] is DBNull && drRows["CAN_amt"] is DBNull)
                {
                    dr["TotalAmt"] = "0.00";
                }
                else
                {
                    dr["TotalAmt"] = Convert.ToDouble(drRows["Paid_amt"].ToString()) + Convert.ToDouble(drRows["DEL_amt"].ToString()) + Convert.ToDouble(drRows["DUE_amt"].ToString()) + Convert.ToDouble(drRows["CAN_amt"].ToString());
                    TotalAmt += Convert.ToDouble(dr["TotalAmt"].ToString());
                }


                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblPMR.Text = PaidMR.ToString();
                lblPMRAmt.Text = PaidAmt.ToString();
                lblTBBMR.Text = DELMR.ToString();
                lblTBBAmt.Text = DELAmt.ToString();
                lblToPayMR.Text = DUEMR.ToString();
                lblToPayMRAmt.Text = DUEAmt.ToString();
                lblCMR.Text = CANMR.ToString();
                lblCMRAmt.Text = CANAmt.ToString();
                lblTotalDoc.Text = TotalDoc.ToString();
                lblTotalAmt.Text = TotalAmt.ToString();
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
        ////System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("MR_Summary.csv"), false);

        ////DataTable dt = ds.Tables[0];
        ////int iColCount = dt.Columns.Count;
        ////for (int i = 0; i < iColCount; i++)
        ////{
        ////    sw.Write(ds.Tables[0].Columns[i]);
        ////    if (i < iColCount - 1)
        ////    {
        ////        sw.Write(",");
        ////    }
        ////}
        ////sw.Write(sw.NewLine);

        ////foreach (DataRow dr in dt.Rows)
        ////{
        ////    for (int i = 0; i < iColCount; i++)
        ////    {
        ////        if (!Convert.IsDBNull(dr[i]))
        ////        {
        ////            sw.Write(dr[i].ToString());
        ////        }
        ////        if (i < iColCount - 1)
        ////        {
        ////            sw.Write(",");
        ////        }
        ////    }
        ////    sw.Write(sw.NewLine);
        ////}
        ////sw.Close();

        ////System.IO.FileStream fs = null;
        ////fs = System.IO.File.Open(Server.MapPath("MR_Summary.csv"), System.IO.FileMode.Open);
        ////byte[] btFile = new byte[fs.Length];
        ////fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        ////fs.Close();
        ////Response.ContentType = "application/vnd.ms-excel";
        ////Response.AddHeader("Content-disposition", "attachment; filename=" + "MR_Summary.csv");
        //////Response.ContentType = "application/octet-stream";
        ////Response.BinaryWrite(btFile);
        ////Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=MR_Summary.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        MR_Summary.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
