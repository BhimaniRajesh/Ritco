using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using ApplicationManager;


public partial class GUI_Fleet_Tyre_TyreUpload : System.Web.UI.Page
{
    string str_Connection_String = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        div_Invalid_Data.Visible = false;
        div_Not_In_Master.Visible = false; 
        div_Duplicate_Tyre.Visible = false;
        div_New_Data.Visible = false;
        if (!IsPostBack)
        {
            str_Connection_String = Session["SqlProvider"].ToString();
        }
    }

    private string GetFileName(HttpPostedFile file)
    {
        int i = 0, j = 0;
        string filename;

        filename = file.FileName;
        do
        {
            i = filename.IndexOf(@"\", j + 1);
            if (i >= 0) j = i;
        } while (i >= 0);
        filename = filename.Substring(j + 1, filename.Length - j - 1);

        return filename;
    }

    protected void btn_GetData_Click(object sender, EventArgs e)
    {
        Upload();
    }

    public void FileUpload(HtmlInputFile f, string fname)
    {
        HttpPostedFile file = f.PostedFile;
        if (file.FileName != "")
        {
            string filename = GetFileName(file);
            if (Server.MapPath(fname) != "") File.Delete(Server.MapPath(fname));
            //fu_Order.PostedFile.SaveAs(str_Save_Location);
            file.SaveAs(Server.MapPath(@"~\GUI\Fleet\Tyre\" + fname));
            //UpdateOrder();
        }
    }

    private void Upload()
    {
        bool Is_Valid_File_Format = false, Is_Valid_Data = false, Is_In_Master = false, Is_Already_Exist = false;
        bool Is_CheckTyre = false,Is_CheckPos = false;

        cls_Tyre_Upload tyre = new cls_Tyre_Upload(Session["SqlProvider"].ToString());

        DataTable dt_XLS_Column_Counter = new DataTable();
        DataTable dt_SQL_Column_Counter = new DataTable();
        //DataTable dt_SQL_Column = new DataTable();


        //DataTable dt_XLS_tyre = new DataTable();
        DataTable dt_XLS_Tyre_Details = new DataTable();

        //Is_Valid_DataDataTable dt_Invalid_Data = new Is_Valid_DataDataTable();

        DataTable dt_Invalid_Data = new DataTable();

        //DataTable dt_Invalid_Data = new DataTable();
        DataTable dt_Duplicate_Tyre = new DataTable();
        DataTable dt_XLS_Tyre = new DataTable();
        DataTable dt_Not_In_Master = new DataTable();
        DataTable dt_Already_Exist = new DataTable();
        DataTable dt_New_Data = new DataTable();

        DataRow dr;

        string str_File_Name;
        string str_Page_Error = "!! Invalid File format !!";
        string[] str_Line;
        string[] fileType;
        string[] sql_Column ={ "Tyre_No", "TYRE_OPKM_RUN", "TRUCK_TRAILER", "POS_ALLOWED", "TYREPOS_ID", "TYRE_VEHNO" };

        int int_Tyre_Count = 0;

        if (FileUpload_Tyre.PostedFile.FileName == "")
        {
            return;
        }
        else
        {
            HttpPostedFile postFile = FileUpload_Tyre.PostedFile;
            str_File_Name = GetFileName(postFile);
            fileType = str_File_Name.Split('.');
            if (Server.MapPath(str_File_Name) != "") File.Delete(Server.MapPath(str_File_Name));
            FileUpload(FileUpload_Tyre, str_File_Name);
        }

        ///////////////////////////////////////CHECK COLUMNS///////////////////////////////////
        if (fileType[fileType.Length - 1].ToLower() == "xls" || fileType[fileType.Length - 1].ToLower() == "xlsx")
        {
            dt_XLS_Column_Counter = tyre.XLS_Column_Counter(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));
           
            if (dt_XLS_Column_Counter.Columns.Count != sql_Column.Length)
            {
                Is_Valid_File_Format = false;
            }
            else
            {
                for (int i = 0; i < dt_XLS_Column_Counter.Columns.Count; i++)
                {
                    for (int j = 0; j < sql_Column.Length; j++)
                    {
                        if (sql_Column[j].ToString().Trim().ToUpper() == dt_XLS_Column_Counter.Columns[i].ColumnName.ToString().Trim().ToUpper())
                        {
                            Is_Valid_File_Format = true;
                            break;
                        }
                        else
                        {
                            Is_Valid_File_Format = false;
                        }
                    }

                    if (!Is_Valid_File_Format) break;
                }
            }
        }

        if (!Is_Valid_File_Format)
        {
            lbl_Error_Msg.Visible = true;
            lbl_Error_Msg.Text = "Invalid File Format.";
            return;
        }

        dt_XLS_Column_Counter.Clear(); dt_XLS_Column_Counter.Dispose();
        //sql_Column.Clear(); sql_Column.Dispose();

        ///////////////////////////////////////End of CHECK COLUMNS///////////////////////////////////

        dt_XLS_Tyre = tyre.XLS_Tyre_Header(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));

        //  Initialization of the temporary Data Tables with Column structure
        dt_XLS_Tyre_Details = tyre.XLS_Tyre_Columns(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));
        dt_Invalid_Data = dt_XLS_Tyre_Details.Clone();
        dt_Duplicate_Tyre = dt_XLS_Tyre_Details.Clone();
        dt_Already_Exist = dt_XLS_Tyre_Details.Clone();
        dt_Not_In_Master = dt_XLS_Tyre_Details.Clone();

        dt_New_Data = dt_XLS_Tyre_Details.Clone();
        //  End of Initialization of the temporary Data Tables with Column structure

        for (int int_Order_Header_Index = 0; int_Order_Header_Index < dt_XLS_Tyre.Rows.Count; int_Order_Header_Index++)
        {
            dt_XLS_Tyre_Details = tyre.XLS_Tyre_Details(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name), dt_XLS_Tyre.Rows[int_Order_Header_Index]["Tyre_No"].ToString());

            for (int int_Tyre_Details_Index = 0; int_Tyre_Details_Index < dt_XLS_Tyre_Details.Rows.Count; int_Tyre_Details_Index++)
            {
                //////////////////////////////Check Valid Data///////////////////////////////////////
                dr = dt_Invalid_Data.NewRow();

                Is_Valid_Data = true;

                dr["Tyre_No"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim();
                if ((dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim() == "") ||
                    (
                        cls_General.IsDecimal(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) &&
                        Convert.ToDecimal(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsInt(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) &&
                        Convert.ToInt32(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsDouble(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) &&
                        Convert.ToDouble(dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim()) == 0
                    ))
                {
                    Is_Valid_Data = false;
                }

                if (!Is_Valid_Data)
                {
                    dt_Invalid_Data.Rows.Add(dr);
                    break;
                }

                //////////////////////////////Check IN Master///////////////////////////////////////
                
                Is_Already_Exist = true;
                dr = dt_Already_Exist.NewRow();
                

                tyre.Tyre_No = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim();
                if (tyre.CheckTyre())
                {
                    tyre.TYRE_VEHNO = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_VEHNO"].ToString().Trim();
                    if (tyre.CheckVehNo())
                    {
                        dr["Tyre_No"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim();
                        dr["TYRE_OPKM_RUN"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_OPKM_RUN"].ToString().Trim();
                        dr["TRUCK_TRAILER"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TRUCK_TRAILER"].ToString().Trim();
                        dr["POS_ALLOWED"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["POS_ALLOWED"].ToString().Trim();
                        dr["TYREPOS_ID"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYREPOS_ID"].ToString().Trim();
                        dr["TYRE_VEHNO"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_VEHNO"].ToString().Trim();

                        Is_Already_Exist = false;
                        Is_CheckTyre = false;
                        Is_CheckPos = true;
                    }
                }
                

                ////////////////////////////////Check Position////////////////////////////////////////// 
                if (Is_Already_Exist == false)
                {

                    tyre.TYREPOS_ID = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYREPOS_ID"].ToString().Trim();
                    tyre.POS_ALLOWED = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["POS_ALLOWED"].ToString().Trim();
                    tyre.TRUCK_TRAILER = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TRUCK_TRAILER"].ToString().Trim();
                    if (tyre.CheckPosCategory())
                    {
                        dr["Tyre_No"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"].ToString().Trim();
                        dr["TYRE_OPKM_RUN"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_OPKM_RUN"].ToString().Trim();
                        dr["TRUCK_TRAILER"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TRUCK_TRAILER"].ToString().Trim();
                        dr["POS_ALLOWED"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["POS_ALLOWED"].ToString().Trim();
                        dr["TYREPOS_ID"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYREPOS_ID"].ToString().Trim();
                        dr["TYRE_VEHNO"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_VEHNO"].ToString().Trim();

                        Is_Already_Exist = false;
                        Is_CheckPos = false;

                    }
                }

                
                if (!Is_Already_Exist && !Is_CheckTyre && !Is_CheckPos)
                {
                    dt_Already_Exist.Rows.Add(dr);
                }

                //////////////////////////////Check IN Master///////////////////////////////////////

                Is_In_Master = true;
                dr = dt_Not_In_Master.NewRow();

                if (int_Tyre_Count > 1)
                {
                    dr = dt_Duplicate_Tyre.NewRow();

                    dr["Tyre_No"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["Tyre_No"];
                    dr["TYRE_OPKM_RUN"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_OPKM_RUN"];
                    dr["TRUCK_TRAILER"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TRUCK_TRAILER"];
                    dr["POS_ALLOWED"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["POS_ALLOWED"];
                    dr["TYREPOS_ID"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYREPOS_ID"];
                    dr["TYRE_VEHNO"] = dt_XLS_Tyre_Details.Rows[int_Tyre_Details_Index]["TYRE_VEHNO"];

                    dt_Duplicate_Tyre.Rows.Add(dr);
                    Is_Valid_Data = false;
                    break;
                }

            }
            if ((Is_Valid_Data && Is_In_Master && !Is_CheckTyre && Is_CheckPos) || Is_Already_Exist)
            {
                dt_New_Data.Merge(dt_XLS_Tyre_Details);
            }
        }

        if (dt_Invalid_Data.Rows.Count > 0)
        {
            div_Invalid_Data.Visible = true;
            gv_Invalid_Data.DataSource = dt_Invalid_Data;
            gv_Invalid_Data.DataBind();
        }

        if (dt_Not_In_Master.Rows.Count > 0)
        {
            div_Not_In_Master.Visible = true;
            gv_Not_In_Master.DataSource = dt_Not_In_Master;
            gv_Not_In_Master.DataBind();
        }

        if (dt_Duplicate_Tyre.Rows.Count > 0)
        {
            div_Duplicate_Tyre.Visible = true;
            gv_Duplicate_Tyre.DataSource = dt_Duplicate_Tyre;
            gv_Duplicate_Tyre.DataBind();
        }
        if (dt_Already_Exist.Rows.Count > 0)
        {
            UpdateData(dt_Already_Exist);
        }

        if (dt_New_Data.Rows.Count > 0)
        { 
            div_New_Data.Visible = true;
            gv_New_Data.DataSource = dt_New_Data;
            gv_New_Data.DataBind();
        }

        File.Delete(Server.MapPath(str_File_Name));
    }

    private void UpdateData(DataTable dt_Already_Exist)
    {
        cls_Tyre_Upload tyre = new cls_Tyre_Upload(Session["SqlProvider"].ToString());

        DataTable dt = new DataTable();

        dt = dt_Already_Exist;

        int Tyre_Count = 0;

        bool IsCommitted = false;

        try
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tyre.Tyre_No = dt.Rows[i]["Tyre_No"].ToString();
                tyre.TYRE_OPKM_RUN = Convert.ToDecimal(dt.Rows[i]["TYRE_OPKM_RUN"].ToString());
                tyre.TRUCK_TRAILER = dt.Rows[i]["TRUCK_TRAILER"].ToString();
                tyre.POS_ALLOWED = dt.Rows[i]["POS_ALLOWED"].ToString();
                tyre.TYREPOS_ID = dt.Rows[i]["TYREPOS_ID"].ToString();
                tyre.TYRE_VEHNO = dt.Rows[i]["TYRE_VEHNO"].ToString();

                tyre.UpdateTyre();
            }

            
            IsCommitted = true;

            //IsCommitted = tyre.CommitTransaction();
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted) lbl_Page_Error.Text = "!!  Tyre have been uploaded successfully  !!";
    }


}
