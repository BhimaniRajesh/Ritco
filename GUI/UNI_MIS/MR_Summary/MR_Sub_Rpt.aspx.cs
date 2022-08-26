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

public partial class GUI_UNI_MIS_MR_Summary_MR_Sub_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string Number, sql, i;
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

            lblBranch.Text = Request.QueryString["MRBranch"];
            lblMRBranch.Text = Request.QueryString["Branch"];
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            lblDtFrom.Text = From.ToString("dd MMM yy");
            lblDtTo.Text = To.ToString("dd MMM yy");
            Number = Request.QueryString["rep"];

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

        sqlCommand.CommandText = "webx_MR_DETAIL_summary";

        sqlCommand.Parameters.AddWithValue("@CUSTCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@DATEFROM", lblDtFrom.Text);
        sqlCommand.Parameters.AddWithValue("@DATETO", lblDtTo.Text);
        sqlCommand.Parameters.AddWithValue("@MRTYP", Number);
        sqlCommand.Parameters.AddWithValue("@MRSTATUS", "ALL");
        sqlCommand.Parameters.AddWithValue("@MRAMT", "0");
        sqlCommand.Parameters.AddWithValue("@MRBRCD", lblBranch.Text);
        sqlCommand.Parameters.AddWithValue("@BOOKBRCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@DELBRCD", "ALL");
        sqlCommand.Parameters.AddWithValue("@MRcash", "ALL");
        sqlCommand.Parameters.AddWithValue("@RO", "ALL");

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
            dt.Columns.Add("MR_Number", typeof(string));
            dt.Columns.Add("DocNo", typeof(string));
            dt.Columns.Add("MR_Type", typeof(string));
            dt.Columns.Add("MR_Date", typeof(string));
            dt.Columns.Add("MR_Party", typeof(string));
            dt.Columns.Add("MR_Branch", typeof(string));
            dt.Columns.Add("Pay_Mode", typeof(string));
            dt.Columns.Add("Chq_No", typeof(string));
            dt.Columns.Add("Chq_Amt", typeof(string));
            dt.Columns.Add("MR_Status", typeof(string));
            dt.Columns.Add("Amt", typeof(string));
            dt.Columns.Add("Cl_Amt", typeof(string));
            dt.Columns.Add("MR_Close", typeof(string));
            dt.Columns.Add("Dedu", typeof(string));
            dt.Columns.Add("Add", typeof(string));
            dt.Columns.Add("Remark", typeof(string));
            dt.Columns.Add("NavURL", typeof(string));

            DataRow dr;

            TimeSpan ts;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double Amount = 0;
            double CloseAmt = 0;
            double Deduction = 0;
            double Addition = 0;
            

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["NavURL"] = "javascript:OpenPopup('" + drRows["MRSNo"].ToString() + "')";
                dr["MR_Number"] = drRows["MRSNo"].ToString();
                dr["DocNo"] = drRows["dockno"].ToString();
                string MrType = drRows["MRSTYPE"].ToString();
                if (MrType == "1")
                {
                    dr["MR_Type"] = "Paid";
                }
                if (MrType == "2")
                {
                    dr["MR_Type"] = "TBB";
                }
                if (MrType == "3")
                {
                    dr["MR_Type"] = "To Pay";
                }                
                dr["MR_Date"] =Convert.ToDateTime(drRows["MRSDT"]).ToString("dd MMM yyyy");
                dr["MR_Party"] = drRows["PTCD"].ToString() + " : " + drRows["PTNAME"].ToString();

                SqlCommand sqlCommand2 = new SqlCommand();
                sqlCommand2.Connection = conn;
                sql = "select distinct CHQNO + '/' + convert(varchar,chqdt,106) as CHQNO from WEBX_BILLCHQDETAIL where DOCNO='" + dr["MR_Number"] + "'";
                sqlCommand2 = new SqlCommand(sql, conn);
                                
                SqlDataReader dr2 = sqlCommand2.ExecuteReader();

                while (dr2.Read())
                {
                    dr["MR_Branch"] = dr2["CHQNO"].ToString();
                }
                dr2.Close();

                dr["Pay_Mode"] = drRows["paymode"].ToString();
                if (drRows["finclosedt"] is DBNull)
                {
                    dr["Chq_No"] = "-";
                }
                else
                {
                    dr["Chq_No"] = Convert.ToDateTime(drRows["finclosedt"]).ToString("dd MMM yyyy");
                }
                dr["Chq_Amt"] = drRows["chq_amt"].ToString();
                string strclose = drRows["MRS_Closed"].ToString();
                string strcancel = drRows["MR_CANCEL"].ToString();

                if(strclose =="N" && strcancel =="N")
                {
                    dr["MR_Status"] = "MR - Generated ";
                }
                if (strclose=="Y" && strcancel=="N")
                {
                    dr["MR_Status"] = "MR - Close ";
                }
                if(strcancel=="Y")
                {
                    dr["MR_Status"] = "Cancelled MR";
                }                
                //dr["MR_Status"] = "MR - Close";
                dr["Amt"] = drRows["MRSAMT"].ToString();

                if (dr["Pay_Mode"].ToString().Trim() == "Cash" || dr["Pay_Mode"].ToString().Trim() == "Cheque")
                {
                    dr["Cl_Amt"] = drRows["NETAMT"].ToString();
                }
                else
                {
                    dr["Cl_Amt"] = drRows["Closeamt"].ToString();
                }
                if (drRows["finclosedt"] is DBNull)
                {
                    dr["MR_Close"] = "-";
                }
                else
                {
                    dr["MR_Close"] = Convert.ToDateTime(drRows["finclosedt"]).ToString("dd MMM yyyy");
                }
                dr["Dedu"] = drRows["DEDUCTION"].ToString();
                dr["Add"] = drRows["miscchrg"].ToString();
                dr["Remark"] = drRows["remark"].ToString();



                if (drRows["NETAMT"] is DBNull)
                {
                    dr["Amt"] = "0.00";
                }
                else
                {
                    dr["Amt"] = Convert.ToDouble(drRows["NETAMT"]) + Convert.ToDouble(drRows["DEDUCTION"]);
                    Amount += Convert.ToDouble(dr["Amt"]);
                }

                if (dr["Pay_Mode"].ToString().Trim() == "Cheque" || dr["Pay_Mode"].ToString().Trim() == "cash")
                {
                    dr["Cl_Amt"] = drRows["NETAMT"];
                    CloseAmt += Convert.ToDouble(drRows["NETAMT"]);
                }
                else
                {
                    if (drRows["Closeamt"] is DBNull)
                    {
                        dr["Cl_Amt"] = "0";
                    }
                    else
                    {
                        dr["Cl_Amt"] = Convert.ToDouble(drRows["Closeamt"]).ToString("0.00");
                    }
                    CloseAmt += Convert.ToDouble(dr["Cl_Amt"]);
                }

                if (drRows["DEDUCTION"] is DBNull)
                {
                    dr["Dedu"] = "0.00";
                }
                else
                {
                    dr["Dedu"] = Convert.ToDouble(drRows["DEDUCTION"]).ToString("0.00");
                    Deduction += Convert.ToDouble(drRows["DEDUCTION"]);
                }

                if (drRows["miscchrg"] is DBNull)
                {
                    dr["Add"] = "0.00";
                }
                else
                {
                    dr["Add"] = Convert.ToDouble(drRows["miscchrg"]).ToString("0.00");
                    Addition += Convert.ToDouble(drRows["miscchrg"]);
                }                

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                lblAmt.Text = Amount.ToString();
                lblClAmt.Text = CloseAmt.ToString();
                lblDedu.Text = Deduction.ToString();
                lblAdd.Text = Addition.ToString();                
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
        
    protected void btnXLS_Click1(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("MR_Summary.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("MR_Summary.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "MR_Summary.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

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
