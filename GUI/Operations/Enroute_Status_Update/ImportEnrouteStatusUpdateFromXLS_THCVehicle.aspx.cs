using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text.RegularExpressions;
using System.Data.OleDb;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operations_Enroute_Status_Update_ImportEnrouteStatusUpdateFromXLS_THCVehicle : System.Web.UI.Page
{
    DataTable dtGrid = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            dtGrid = AssignTable();
        }
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUploader.HasFile)
            {
                pnlGrid.Visible = false;
                string filepath = FileUploader.PostedFile.FileName;
                string pat = @"(?:.*\\)(?'Name'.+)\.(?'EXT'.+)|(?'Name'.+)\.(?'EXT'.+)";
                Regex r = new Regex(pat);

                Match m = r.Match(filepath);
                string file_ext = m.Groups["EXT"].Captures[0].ToString();
                string filename = m.Groups["Name"].Captures[0].ToString();

                if (file_ext.ToLower() != "xls")
                    throw new Exception("Invalid File...");

                string path = Server.MapPath("~/GUI/Images/FileManager/Temp");

                if (Directory.Exists(path))
                {
                    DirectoryInfo dir = new DirectoryInfo(path);
                    FileInfo[] files = dir.GetFiles();
                    for (int i = 0; i < files.Length; i++)
                    {
                        files[i].Delete();
                    }
                }
                FileUploader.SaveAs(path + "\\" + filename + "." + file_ext);
                string hdrs = "VendorCode," + SessionUtilities.THCCalledAs + "No,VehicleNo,Date,Hour,Minute,Location,Remarks,MovementStatus,AwaitingAction,DaysSinceLastActon";

                ImportDataFromXLS(path + "\\" + filename + "." + file_ext, "Sheet1$", hdrs);

                if (File.Exists(path + "\\" + filename + "." + file_ext))
                    File.Delete(path + "\\" + filename + "." + file_ext);
            }
        }
        catch (Exception ex)
        {
            lblMsg.Visible = true;
            lblMsg.Text = ex.Message.Replace('\n', '_');
        }
    }
    public DataTable AssignTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("VendorCode");
        dt.Columns.Add("THCNo");
        dt.Columns.Add("VehicleNo");
        dt.Columns.Add("Date");
        dt.Columns.Add("Hour");
        dt.Columns.Add("Minute");
        dt.Columns.Add("Location");
        dt.Columns.Add("Remarks");
        dt.Columns.Add("MovementStatus");
        dt.Columns.Add("AwaitingAction");
        dt.Columns.Add("Days");
        dt.Columns.Add("ErrorMessage");
        return dt;
    }
    public DataTable getDataFromXLS(string path, string sheet, string headers)
    {
        DataTable dtCSV = new DataTable();
        try
        {
            string strConnectionString = string.Empty;
            strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
            "Data Source=" + path + ";" +
            "Extended Properties=" + (char)34 + "Excel 8.0;HDR=Yes;IMEX=1;" + (char)34;

            OleDbConnection cnCSV = new OleDbConnection(strConnectionString);
            cnCSV.Open();
            OleDbCommand cmdSelect = new OleDbCommand(@"SELECT " + headers + " FROM [" + sheet + "]", cnCSV);
            OleDbDataAdapter daCSV = new OleDbDataAdapter();
            daCSV.SelectCommand = cmdSelect;
            dtCSV = new DataTable();
            daCSV.Fill(dtCSV);
            cnCSV.Close();
            daCSV.Dispose();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dtCSV;
    }
    public void ImportDataFromXLS(string path, string sheet, string headers)
    {
        dtGrid = AssignTable();
        SqlTransaction trn;
        DataTable dt = getDataFromXLS(path, sheet, headers);
        SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
        //string[] header = headers.Split(',');
        con.Open();
        trn = con.BeginTransaction();
        try
        {
            foreach (DataRow dr in dt.Rows)
            {
                string strInsert = "", VendorCode = "", strVendorCode = "", THCNo = "", strTHCNo = "", VehicleNo = "", strVehicleNo = "";
                string DocketDate = "", strDocketDate = "", Hour = "", Minute = "", DocketTime = "", Location = "", Remarks = "";
                string MovementStatus="",strMovementStatus="",AwaitingAction="",strAwaitingAction="",Days="";

                int cntVCode = 0, cntTHC = 0, cntVehicle = 0, cntDocketDate = 0, cntMovementStatus = 0, cntAwaitingAction = 0;
                
                VendorCode = dr["VendorCode"].ToString().Trim();
                THCNo = dr[1].ToString().Trim();
                VehicleNo = dr["VehicleNo"].ToString().Trim();
                DocketDate = dr["Date"].ToString().Trim();

                Hour = dr["Hour"].ToString().Trim();
                if (Hour.Trim() == "")
                {
                    Hour = "00";
                }
                else
                {
                    Hour = dr["Hour"].ToString().Trim();
                }

                Minute = dr["Minute"].ToString().Trim();
                if (Minute.Trim() == "")
                {
                    Minute = "00";
                }
                else
                {
                    Minute = dr["Minute"].ToString().Trim();
                }

                DocketTime = Hour + ':' + Minute;
                Location = dr["Location"].ToString().Trim();
                Remarks = dr["Remarks"].ToString().Trim();
                MovementStatus = dr["MovementStatus"].ToString().Trim();
                AwaitingAction = dr["AwaitingAction"].ToString().Trim();
                Days = dr["DaysSinceLastActon"].ToString().Trim();
                
                strVendorCode = "select count(*) FROM webx_VENDOR_HDR where VendorCode = '" + VendorCode.ToString() + "' and Active='Y'";
                object objVendorCode = SqlHelper.ExecuteScalar(trn, CommandType.Text, strVendorCode);

                if (objVendorCode != DBNull.Value)
                    cntVCode = Convert.ToInt32(objVendorCode);

                if (cntVCode > 0)
                {
                    //VendorCode = dr["Vendor"].ToString();
                    strTHCNo = "select count(*) from usp_Enroute_getTHCDetails Where thcno='" + THCNo.ToString() + "' and VendorCode = '" + VendorCode.ToString() + "'";
                    object objTHC = SqlHelper.ExecuteScalar(trn, CommandType.Text, strTHCNo);

                    if (objTHC != DBNull.Value)
                        cntTHC = Convert.ToInt32(objTHC);

                    if (cntTHC > 0)
                    {
                        strVehicleNo = "select count(*) from usp_Enroute_getTHCDetails Where thcno='" + THCNo.ToString() + "' and VendorCode = '" + VendorCode.ToString() + "' and vehno='" + VehicleNo.ToString() + "'";
                        object objVehicle = SqlHelper.ExecuteScalar(trn, CommandType.Text, strVehicleNo);

                        if (objVehicle != DBNull.Value)
                            cntVehicle = Convert.ToInt32(objVehicle);

                        if (cntVehicle > 0)
                        {
                            string[] str = DocketTime.ToString().Split(':');
                            Int32 strHH = Convert.ToInt32(str[0]);
                            Int32 strMM = Convert.ToInt32(str[1]);
                            if (strHH <= 23 && strHH >= 0)
                            {
                                if (strMM <= 59 && strMM >= 0)
                                {
                                    strDocketDate = "select dbo.FN_Enroute_Status_THC_Vehicle_DateDiff('" + DocketDate.ToString() + "','" + DocketTime.ToString() + "','" + VendorCode.ToString() + "','" + THCNo.ToString() + "','" + VehicleNo.ToString() + "') as Status";
                                    object objDocketDate = SqlHelper.ExecuteScalar(trn, CommandType.Text, strDocketDate);

                                    if (objDocketDate != DBNull.Value)
                                        cntDocketDate = Convert.ToInt32(objDocketDate);

                                    if (cntDocketDate == 1)
                                    {
                                        if (Location != "")
                                        {
                                            if (Location.Length <= 250)
                                            {
                                                if (Remarks.Length <= 250)
                                                {
                                                    strMovementStatus = "select Count(*) from Webx_Master_General where CodeType='MOVST' and CodeDesc='" + MovementStatus.ToString() + "'";
                                                    object objMovementStatus = SqlHelper.ExecuteScalar(trn, CommandType.Text, strMovementStatus);

                                                    if (objMovementStatus != DBNull.Value)
                                                        cntMovementStatus = Convert.ToInt32(objMovementStatus);

                                                    if (cntMovementStatus > 0)
                                                    {
                                                        strAwaitingAction = "select Count(*) from Webx_Master_General where CodeType='AWTAC' and CodeDesc='" + AwaitingAction.ToString() + "'";
                                                        object objAwaitingAction = SqlHelper.ExecuteScalar(trn, CommandType.Text, strAwaitingAction);

                                                        if (objAwaitingAction != DBNull.Value)
                                                            cntAwaitingAction = Convert.ToInt32(objAwaitingAction);

                                                        if (cntAwaitingAction > 0)
                                                        {
                                                            if (Days != "")
                                                            {
                                                                string strDays = "select ISNUMERIC('" + Days.ToString() + "') as Status";
                                                                DataTable dtDays = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strDays).Tables[0];
                                                                if (Convert.ToInt32(dtDays.Rows[0]["Status"]) != 0)
                                                                {
                                                                    strInsert = "usp_Webx_Enroute_Status_THC_Vehicle_InsertData_ViaXLS";
                                                                    SqlParameter[] parm = new SqlParameter[11];
                                                                    parm[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar);
                                                                    parm[1] = ControllersHelper.GetSqlParameter("@THCNO", THCNo, SqlDbType.VarChar);
                                                                    parm[2] = ControllersHelper.GetSqlParameter("@VehicleNo", VehicleNo, SqlDbType.VarChar);
                                                                    parm[3] = ControllersHelper.GetSqlParameter("@Date", DateFunction.ConvertStringToDate(DocketDate).ToString("MM/dd/yyyy"), SqlDbType.DateTime);
                                                                    parm[4] = ControllersHelper.GetSqlParameter("@Time", DocketTime, SqlDbType.VarChar);
                                                                    parm[5] = ControllersHelper.GetSqlParameter("@Location", Location, SqlDbType.VarChar);
                                                                    parm[6] = ControllersHelper.GetSqlParameter("@Remarks", Remarks, SqlDbType.VarChar);
                                                                    parm[7] = ControllersHelper.GetSqlParameter("@MovementStatus", MovementStatus, SqlDbType.VarChar);
                                                                    parm[8] = ControllersHelper.GetSqlParameter("@Awaitingaction", AwaitingAction, SqlDbType.VarChar);
                                                                    parm[9] = ControllersHelper.GetSqlParameter("@Days", Days, SqlDbType.VarChar);
                                                                    parm[10] = ControllersHelper.GetSqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
                                                                    SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, strInsert, parm);
                                                                }
                                                                else
                                                                {
                                                                    DataRow drow = dtGrid.NewRow();
                                                                    drow["VendorCode"] = VendorCode;
                                                                    drow["THCNo"] = THCNo;
                                                                    drow["VehicleNo"] = VehicleNo;
                                                                    drow["Date"] = DocketDate;
                                                                    drow["Hour"] = Hour;
                                                                    drow["Minute"] = Minute;
                                                                    drow["Location"] = Location;
                                                                    drow["Remarks"] = Remarks;
                                                                    drow["MovementStatus"] = MovementStatus;
                                                                    drow["AwaitingAction"] = AwaitingAction;
                                                                    drow["Days"] = Days;
                                                                    drow["ErrorMessage"] = "Enter Numeric Values in Days Since Last Acton";
                                                                    dtGrid.Rows.Add(drow);
                                                                }
                                                            }
                                                            else
                                                            {
                                                                DataRow drow = dtGrid.NewRow();
                                                                drow["VendorCode"] = VendorCode;
                                                                drow["THCNo"] = THCNo;
                                                                drow["VehicleNo"] = VehicleNo;
                                                                drow["Date"] = DocketDate;
                                                                drow["Hour"] = Hour;
                                                                drow["Minute"] = Minute;
                                                                drow["Location"] = Location;
                                                                drow["Remarks"] = Remarks;
                                                                drow["MovementStatus"] = MovementStatus;
                                                                drow["AwaitingAction"] = AwaitingAction;
                                                                drow["Days"] = Days;
                                                                drow["ErrorMessage"] = "Days Since Last Acton Value Can not Blank";
                                                                dtGrid.Rows.Add(drow);
                                                            }
                                                        }
                                                        else
                                                        {
                                                            DataRow drow = dtGrid.NewRow();
                                                            drow["VendorCode"] = VendorCode;
                                                            drow["THCNo"] = THCNo;
                                                            drow["VehicleNo"] = VehicleNo;
                                                            drow["Date"] = DocketDate;
                                                            drow["Hour"] = Hour;
                                                            drow["Minute"] = Minute;
                                                            drow["Location"] = Location;
                                                            drow["Remarks"] = Remarks;
                                                            drow["MovementStatus"] = MovementStatus;
                                                            drow["AwaitingAction"] = AwaitingAction;
                                                            drow["Days"] = Days;
                                                            drow["ErrorMessage"] = "InValid Awaiting Action";
                                                            dtGrid.Rows.Add(drow);
                                                        }
                                                    }
                                                    else
                                                    {
                                                        DataRow drow = dtGrid.NewRow();
                                                        drow["VendorCode"] = VendorCode;
                                                        drow["THCNo"] = THCNo;
                                                        drow["VehicleNo"] = VehicleNo;
                                                        drow["Date"] = DocketDate;
                                                        drow["Hour"] = Hour;
                                                        drow["Minute"] = Minute;
                                                        drow["Location"] = Location;
                                                        drow["Remarks"] = Remarks;
                                                        drow["MovementStatus"] = MovementStatus;
                                                        drow["AwaitingAction"] = AwaitingAction;
                                                        drow["Days"] = Days;
                                                        drow["ErrorMessage"] = "InValid Movement Status";
                                                        dtGrid.Rows.Add(drow);
                                                    }
                                                }
                                                else
                                                {
                                                    DataRow drow = dtGrid.NewRow();
                                                    drow["VendorCode"] = VendorCode;
                                                    drow["THCNo"] = THCNo;
                                                    drow["VehicleNo"] = VehicleNo;
                                                    drow["Date"] = DocketDate;
                                                    drow["Hour"] = Hour;
                                                    drow["Minute"] = Minute;
                                                    drow["Location"] = Location;
                                                    drow["Remarks"] = Remarks;
                                                    drow["MovementStatus"] = MovementStatus;
                                                    drow["AwaitingAction"] = AwaitingAction;
                                                    drow["Days"] = Days;
                                                    drow["ErrorMessage"] = "Remarks Length can not more than 250.";
                                                    dtGrid.Rows.Add(drow);
                                                }
                                            }
                                            else
                                            {
                                                DataRow drow = dtGrid.NewRow();
                                                drow["VendorCode"] = VendorCode;
                                                drow["THCNo"] = THCNo;
                                                drow["VehicleNo"] = VehicleNo;
                                                drow["Date"] = DocketDate;
                                                drow["Hour"] = Hour;
                                                drow["Minute"] = Minute;
                                                drow["Location"] = Location;
                                                drow["Remarks"] = Remarks;
                                                drow["MovementStatus"] = MovementStatus;
                                                drow["AwaitingAction"] = AwaitingAction;
                                                drow["Days"] = Days;
                                                drow["ErrorMessage"] = "Location Length can not more than 250.";
                                                dtGrid.Rows.Add(drow);
                                            }
                                        }
                                        else
                                        {
                                            DataRow drow = dtGrid.NewRow();
                                            drow["VendorCode"] = VendorCode;
                                            drow["THCNo"] = THCNo;
                                            drow["VehicleNo"] = VehicleNo;
                                            drow["Date"] = DocketDate;
                                            drow["Hour"] = Hour;
                                            drow["Minute"] = Minute;
                                            drow["Location"] = Location;
                                            drow["Remarks"] = Remarks;
                                            drow["MovementStatus"] = MovementStatus;
                                            drow["AwaitingAction"] = AwaitingAction;
                                            drow["Days"] = Days;
                                            drow["ErrorMessage"] = "Location Value Can not Blank";
                                            dtGrid.Rows.Add(drow);
                                        }
                                    }
                                    else
                                    {
                                        DataRow drow = dtGrid.NewRow();
                                        drow["VendorCode"] = VendorCode;
                                        drow["THCNo"] = THCNo;
                                        drow["VehicleNo"] = VehicleNo;
                                        drow["Date"] = DocketDate;
                                        drow["Hour"] = Hour;
                                        drow["Minute"] = Minute;
                                        drow["Location"] = Location;
                                        drow["Remarks"] = Remarks;
                                        drow["MovementStatus"] = MovementStatus;
                                        drow["AwaitingAction"] = AwaitingAction;
                                        drow["Days"] = Days;
                                        drow["ErrorMessage"] = "Date Should be greater then Last Updated Date";
                                        dtGrid.Rows.Add(drow);
                                    }
                                }
                                else
                                {
                                    DataRow drow = dtGrid.NewRow();
                                    drow["VendorCode"] = VendorCode;
                                    drow["THCNo"] = THCNo;
                                    drow["VehicleNo"] = VehicleNo;
                                    drow["Date"] = DocketDate;
                                    drow["Hour"] = Hour;
                                    drow["Minute"] = Minute;
                                    drow["Location"] = Location;
                                    drow["Remarks"] = Remarks;
                                    drow["MovementStatus"] = MovementStatus;
                                    drow["AwaitingAction"] = AwaitingAction;
                                    drow["Days"] = Days;
                                    drow["ErrorMessage"] = "Invalid Minute";
                                    dtGrid.Rows.Add(drow);
                                }
                            }
                            else
                            {
                                DataRow drow = dtGrid.NewRow();
                                drow["VendorCode"] = VendorCode;
                                drow["THCNo"] = THCNo;
                                drow["VehicleNo"] = VehicleNo;
                                drow["Date"] = DocketDate;
                                drow["Hour"] = Hour;
                                drow["Minute"] = Minute;
                                drow["Location"] = Location;
                                drow["Remarks"] = Remarks;
                                drow["MovementStatus"] = MovementStatus;
                                drow["AwaitingAction"] = AwaitingAction;
                                drow["Days"] = Days;
                                drow["ErrorMessage"] = "Invalid Hour";
                                dtGrid.Rows.Add(drow);
                            }
                        }                    
                        else
                        {
                            DataRow drow = dtGrid.NewRow();
                            drow["VendorCode"] = VendorCode;
                            drow["THCNo"] = THCNo;
                            drow["VehicleNo"] = VehicleNo;
                            drow["Date"] = DocketDate;
                            drow["Hour"] = Hour;
                            drow["Minute"] = Minute;
                            drow["Location"] = Location;
                            drow["Remarks"] = Remarks;
                            drow["MovementStatus"] = MovementStatus;
                            drow["AwaitingAction"] = AwaitingAction;
                            drow["Days"] = Days;
                            drow["ErrorMessage"] = "Invalid Vehicle No.";
                            dtGrid.Rows.Add(drow);
                        }
                    }
                    else
                    {
                        DataRow drow = dtGrid.NewRow();
                        drow["VendorCode"] = VendorCode;
                        drow["THCNo"] = THCNo;
                        drow["VehicleNo"] = VehicleNo;
                        drow["Date"] = DocketDate;
                        drow["Hour"] = Hour;
                        drow["Minute"] = Minute;
                        drow["Location"] = Location;
                        drow["Remarks"] = Remarks;
                        drow["MovementStatus"] = MovementStatus;
                        drow["AwaitingAction"] = AwaitingAction;
                        drow["Days"] = Days;
                        drow["ErrorMessage"] = "Invalid " + SessionUtilities.THCCalledAs + " No.";
                        dtGrid.Rows.Add(drow);
                    }
                }
                else
                {
                    DataRow drow = dtGrid.NewRow();
                    drow["VendorCode"] = VendorCode;
                    drow["THCNo"] = THCNo;
                    drow["VehicleNo"] = VehicleNo;
                    drow["Date"] = DocketDate;
                    drow["Hour"] = Hour;
                    drow["Minute"] = Minute;
                    drow["Location"] = Location;
                    drow["Remarks"] = Remarks;
                    drow["MovementStatus"] = MovementStatus;
                    drow["AwaitingAction"] = AwaitingAction;
                    drow["Days"] = Days;
                    drow["ErrorMessage"] = "Invalid Vendor Code";
                    dtGrid.Rows.Add(drow);
                }
            }

            lblMsg.Visible = true;
            lblMsg.Text = "Enroute Status Update Sucessfully Uploaded...";
            if (dtGrid.Rows.Count > 0)
            {
                pnlGrid.Visible = true;
                gvInvalid.DataSource = dtGrid;
                gvInvalid.DataBind();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            con.Close();
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("ErrorPage.aspx?heading=Enroute Status Upload Error&detail1=Enroute Status Upload Error&detail2=" + strex, false);
        }
        trn.Commit();
        con.Close();
        con.Dispose();
    }
    //protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    //{        
    //    //export to excel
    //    StringWriter stringWrite;
    //    HtmlTextWriter htmlWrite;
    //    HtmlForm frm = new HtmlForm();
    //    Response.Clear();
    //    Response.AddHeader("content-disposition", "attachment;filename=InValidRecords.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-xls";
    //    stringWrite = new System.IO.StringWriter();
    //    htmlWrite = new HtmlTextWriter(stringWrite);
    //    Controls.Add(frm);
    //    frm.Controls.Add(gvInvalid);
    //    frm.RenderControl(htmlWrite);
    //    Response.Write(stringWrite.ToString());
    //    Response.End();
    //}
}

