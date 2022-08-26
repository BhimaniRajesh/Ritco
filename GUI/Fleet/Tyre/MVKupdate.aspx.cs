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

public partial class GUI_Fleet_MVK_MVKupdate : System.Web.UI.Page
{
    //string str_Connection_String = ConfigurationManager.AppSettings["ConnectionString"].ToString();
    string str_Connection_String = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        div_Invalid_Data.Visible = false;
        div_Not_In_Master.Visible = false;
        div_Duplicate_MVK.Visible = false;
        div_New_Data.Visible = false;
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

        }
    }

    private void Upload()
    {
        bool Is_Valid_File_Format = false, Is_Valid_Data = false, Is_In_Master = false, Is_Already_Exist = false;

        cls_MVK_Upload MVK = new cls_MVK_Upload(str_Connection_String);

        DataTable dt_XLS_Column_Counter = new DataTable();
        DataTable dt_SQL_Column_Counter = new DataTable();
        //DataTable dt_SQL_Column = new DataTable();


        //DataTable dt_XLS_MVK = new DataTable();
        DataTable dt_XLS_MVK_Details = new DataTable();

        //Is_Valid_DataDataTable dt_Invalid_Data = new Is_Valid_DataDataTable();

        DataTable dt_Invalid_Data = new DataTable();

        //DataTable dt_Invalid_Data = new DataTable();
        DataTable dt_Duplicate_MVK = new DataTable();
        DataTable dt_XLS_MVK = new DataTable();
        DataTable dt_Not_In_Master = new DataTable();
        DataTable dt_Already_Exist = new DataTable();
        DataTable dt_New_Data = new DataTable();

        DataRow dr;

        string str_File_Name;
        string str_Page_Error = "!! Invalid File format !!";
        string[] str_Line;
        string[] fileType;
        string[] sql_Column ={"VEHNO","Odometer_reading","Month","Year"};
        string[] Months_Column ={ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

        int int_MVK_Count = 0;

        if (FileUpload_MVK.PostedFile.FileName == "")
        {
            return;
        }
        else
        {
            HttpPostedFile postFile = FileUpload_MVK.PostedFile;
            str_File_Name = GetFileName(postFile);
            fileType = str_File_Name.Split('.');
            if (Server.MapPath(str_File_Name) != "") File.Delete(Server.MapPath(str_File_Name));
            FileUpload(FileUpload_MVK, str_File_Name);
        }

        ///////////////////////////////////////CHECK COLUMNS///////////////////////////////////
        if (fileType[fileType.Length - 1].ToLower() == "xls" || fileType[fileType.Length - 1].ToLower() == "xlsx")
        {
            dt_XLS_Column_Counter = MVK.XLS_Column_Counter(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));

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
                        if (sql_Column[j].ToString().Trim().ToUpper() == dt_XLS_Column_Counter.Columns[i].ColumnName.ToString().Trim().ToUpper() )
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

        dt_XLS_MVK = MVK.XLS_MVK_Header(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));

        //  Initialization of the temporary Data Tables with Column structure
        dt_XLS_MVK_Details = MVK.XLS_MVK_Columns(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name));
        dt_Invalid_Data = dt_XLS_MVK_Details.Clone();
        dt_Duplicate_MVK = dt_XLS_MVK_Details.Clone();
        dt_Already_Exist = dt_XLS_MVK_Details.Clone();
        dt_Not_In_Master = dt_XLS_MVK_Details.Clone();

        dt_New_Data = dt_XLS_MVK_Details.Clone();
        //  End of Initialization of the temporary Data Tables with Column structure


        for (int int_Order_Header_Index = 0; int_Order_Header_Index < dt_XLS_MVK.Rows.Count; int_Order_Header_Index++)
        {
            dt_XLS_MVK_Details = MVK.XLS_MVK_Details(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Tyre\" + str_File_Name), dt_XLS_MVK.Rows[int_Order_Header_Index]["VEHNO"].ToString());

            for (int int_MVK_Details_Index = 0; int_MVK_Details_Index < dt_XLS_MVK_Details.Rows.Count; int_MVK_Details_Index++)
            {
                //////////////////////////////Check Valid Data///////////////////////////////////////
                dr = dt_Invalid_Data.NewRow();

                Is_Valid_Data = true;

                dr["VEHNO"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim();
                if ((dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim() == "") ||
                    (
                        cls_General.IsDecimal(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToDecimal(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsInt(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToInt32(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsDouble(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToDouble(dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ))
                {
                    Is_Valid_Data = false;
                }

                dr["Month"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Month"].ToString().Trim();
             
                    for (int i = 0; i < Months_Column.Length; i++)
                    {
                        if (Months_Column[i].ToString().Trim().ToUpper() == dr["Month"].ToString().ToUpper())
                        {
                            Is_Valid_Data = true;
                            break;
                        }
                        else
                        {
                            Is_Valid_Data = false;
                        }
                    }
                

                if (!Is_Valid_Data)
                {
                    dt_Invalid_Data.Rows.Add(dr);
                    break;
                }

                //////////////////////////////Check IN Master///////////////////////////////////////

                Is_Already_Exist = true;
                dr = dt_Already_Exist.NewRow();

                MVK.VEHNO = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim();
                if (MVK.CheckMVK())
                {
                    dr["VEHNO"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"].ToString().Trim();
                    dr["Odometer_reading"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Odometer_reading"].ToString().Trim();
                    dr["Month"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Month"].ToString().Trim();
                    dr["Year"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Year"].ToString().Trim();
                    
                    Is_Already_Exist = false;
                }

                if (!Is_Already_Exist) dt_Already_Exist.Rows.Add(dr);

                //////////////////////////////Check IN Master///////////////////////////////////////

                Is_In_Master = true;
                dr = dt_Not_In_Master.NewRow();

                if (int_MVK_Count > 1)
                {
                    dr = dt_Duplicate_MVK.NewRow();

                    dr["VEHNO"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["VEHNO"];
                    dr["Odometer_reading"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Odometer_reading"];
                    dr["Month"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Month"];
                    dr["Year"] = dt_XLS_MVK_Details.Rows[int_MVK_Details_Index]["Year"];

                    dt_Duplicate_MVK.Rows.Add(dr);
                    Is_Valid_Data = false;
                    break;
                }

            }
            if (Is_Valid_Data && Is_In_Master && Is_Already_Exist)
            {
                dt_New_Data.Merge(dt_XLS_MVK_Details);
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

        if (dt_Duplicate_MVK.Rows.Count > 0)
        {
            div_Duplicate_MVK.Visible = true;
            gv_Duplicate_MVK.DataSource = dt_Duplicate_MVK;
            gv_Duplicate_MVK.DataBind();
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

    private void UpdateData(DataTable dt_Valid_Data)
    {
        cls_MVK_Upload MVK = new cls_MVK_Upload(str_Connection_String);

        string str_XML = "";
        string str_Insert_Columns = "";
        string str_Select_Columns = "";
        string str_With_Columns = "";

        string str_SM_Header = "";
        string str_SM_Details = "";
        string[] sql_Column = { "VEHNO", "Odometer_reading", "Month", "Year"};

        DataTable dt = new DataTable();

        int SM_Count = 0;

        bool IsCommitted = false, IsNotInArray = false;

        str_XML = "<root>\n";

        dt = MVK.MVK_Cols_N_Size();

        foreach (DataRow dr in dt_Valid_Data.Rows)
        {
            str_XML += "<MKV_Details>";

            for (int j = 0; j < sql_Column.Length; j++)
            {
                str_XML += "<" + sql_Column[j].ToString() + ">" + dr[sql_Column[j].ToString()].ToString() + "</" + sql_Column[j].ToString() + ">";
            }
            str_XML += "<Entry_By>" + SessionUtilities.CurrentEmployeeID.ToString() + "</Entry_By>";
            str_XML += "</MKV_Details>";
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i < dt.Rows.Count - 1)
            {
                str_Insert_Columns += dt.Rows[i][0].ToString() + ",";
            }
            else
            {
                str_Insert_Columns += dt.Rows[i][0].ToString();
            }
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i < dt.Rows.Count - 1)
            {
                str_Select_Columns += dt.Rows[i][2].ToString() + ",";
            }
            else
            {
                str_Select_Columns += dt.Rows[i][2].ToString();
            }
        }

        str_Insert_Columns += ",Entry_By";
        str_Select_Columns += ",Entry_By VarChar(50) 'Entry_By'";
        str_XML += "</root>";

        str_SM_Header = "DECLARE @result int " + "\r\n";
        str_SM_Header += "EXEC sp_xml_preparedocument @result OUTPUT,'" + str_XML.Replace("'", "''").Trim() + "'" + "\r\n";

        str_SM_Details += "INSERT INTO Webx_Fleet_MVK_Master (" + str_Insert_Columns + ")" + "\r\n";
        str_SM_Details += "SELECT " + str_Insert_Columns + "\r\n";
        str_SM_Details += "FROM OPENXML (@result, '/root/MKV_Details') WITH (" + str_Select_Columns + ")" + "\r\n";

        str_SM_Details += "EXEC sp_xml_removedocument @result" + "\r\n";

        MVK.BeginTransaction();

        try
        {
            MVK.SQL_Data = str_SM_Header.Replace("&", "&amp").Trim() + str_SM_Details;
            MVK.InsertXml();

            for (int i = 0; i < dt_Valid_Data.Rows.Count; i++)
            {
                MVK.VEHNO = dt_Valid_Data.Rows[i]["VEHNO"].ToString();
                MVK.Odometer_reading = Convert.ToDecimal(dt_Valid_Data.Rows[i]["Odometer_reading"].ToString());

                MVK.UpdateMVK();
            }

            IsCommitted = MVK.CommitTransaction();
        }
        catch (Exception ex)
        {
            MVK.RollBackTransaction();
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted) lbl_Page_Error.Text = "!!  SM Vehicle Wise have been uploaded successfully  !!";


        
    }



}
