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


public partial class GUI_Fleet_Webadmin_Job_SMvehiclewise_Upload : System.Web.UI.Page
{
    //string str_Connection_String = ConfigurationManager.AppSettings["ConnectionString"].ToString();
    string str_Connection_String = ConfigurationManager.AppSettings["AgilityERP_TestConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        div_Invalid_Data.Visible = false;
        div_Not_In_Master.Visible = false;
        div_Duplicate_SM.Visible = false;
        div_Already_Exist.Visible = false;
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
            file.SaveAs(Server.MapPath(@"~\GUI\Fleet\Webadmin\Job\" + fname));
            //UpdateOrder();
        }
    }

    private void Upload()
    {
        bool Is_Valid_File_Format = false, Is_Valid_Data = false, Is_In_Master = false, Is_Already_Exist = false;

        cls_SMvehiclewiseUpload SM = new cls_SMvehiclewiseUpload(str_Connection_String);   
       
        DataTable dt_XLS_Column_Counter = new DataTable();
        DataTable dt_SQL_Column_Counter = new DataTable();
        //DataTable dt_SQL_Column = new DataTable();


        //DataTable dt_XLS_SM = new DataTable();
        DataTable dt_XLS_SM_Details = new DataTable();

        DataTable dt_Invalid_Data = new DataTable();
        DataTable dt_Duplicate_SM = new DataTable();
        DataTable dt_XLS_SM = new DataTable();
        DataTable dt_Not_In_Master = new DataTable();
        DataTable dt_Already_Exist = new DataTable();
        DataTable dt_Valid_Data = new DataTable();

        DataRow dr;

        string str_File_Name;
        string str_Page_Error = "!! Invalid File format !!";
        string[] str_Line;
        string[] fileType;
        string[] sql_Column ={"SMTask_Id","VEHNO","LastSM_Dt","LastSM_KM_Read"};

        int int_SM_Count = 0;

        if (FileUpload_SM.PostedFile.FileName == "")
        {
            return;
        }
        else
        {
            HttpPostedFile postFile = FileUpload_SM.PostedFile;
            str_File_Name = GetFileName(postFile);
            fileType = str_File_Name.Split('.');
            if (Server.MapPath(str_File_Name) != "") File.Delete(Server.MapPath(str_File_Name));
            FileUpload(FileUpload_SM, str_File_Name);
        }

        ///////////////////////////////////////CHECK COLUMNS///////////////////////////////////
        if (fileType[fileType.Length - 1].ToLower() == "xls" || fileType[fileType.Length - 1].ToLower() == "xlsx")
        {
            dt_XLS_Column_Counter = SM.XLS_Column_Counter(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Webadmin\Job\" + str_File_Name));
            //dt_SQL_Column_Counter = sql_Column.Length; 

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
                        if (sql_Column[j].ToString().Trim().ToUpper() == dt_XLS_Column_Counter.Columns[i].ColumnName.ToString().ToUpper())
                        {
                            Is_Valid_File_Format = true;
                            break;
                        }
                        else
                            Is_Valid_File_Format = false;
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
        //dt_SQL_Column_Counter.Clear(); dt_SQL_Column_Counter.Dispose();

        ///////////////////////////////////////End of CHECK COLUMNS///////////////////////////////////

        dt_XLS_SM = SM.XLS_SM_Header(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Webadmin\Job\" + str_File_Name));

        //  Initialization of the temporary Data Tables with Column structure
        dt_XLS_SM_Details = SM.XLS_SM_Columns(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Webadmin\Job\" + str_File_Name));
        dt_Invalid_Data = dt_XLS_SM_Details.Clone();
        dt_Duplicate_SM = dt_XLS_SM_Details.Clone();
        dt_Already_Exist = dt_XLS_SM_Details.Clone();
        dt_Not_In_Master = dt_XLS_SM_Details.Clone();

        dt_Valid_Data = dt_XLS_SM_Details.Clone();
        //  End of Initialization of the temporary Data Tables with Column structure

     
        for (int int_Order_Header_Index = 0; int_Order_Header_Index < dt_XLS_SM.Rows.Count; int_Order_Header_Index++)
        {
            dt_XLS_SM_Details = SM.XLS_SM_Details(fileType[fileType.Length - 1].ToLower(), Server.MapPath(@"~\GUI\Fleet\Webadmin\Job\" + str_File_Name), dt_XLS_SM.Rows[int_Order_Header_Index]["SMTask_Id"].ToString());

            for (int int_SM_Details_Index = 0; int_SM_Details_Index < dt_XLS_SM_Details.Rows.Count; int_SM_Details_Index++)
            {
                //////////////////////////////Check Valid Data///////////////////////////////////////
                dr = dt_Invalid_Data.NewRow();

                Is_Valid_Data = true;

                dr["VEHNO"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim();

                if ((dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim() == "") ||
                    (
                        cls_General.IsDecimal(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToDecimal(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsInt(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToInt32(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ) ||
                    (
                        cls_General.IsDouble(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) &&
                        Convert.ToDouble(dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim()) == 0
                    ) )
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

                
                SM.VEHNO = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim();
                if (!SM.CheckSM())
                {      
                    dr["VehNo"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VehNo"].ToString().Trim();
                
                    Is_Already_Exist = false;
                }

                SM.SMTask_Id = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["SMTask_Id"].ToString().Trim();
                SM.VEHNO = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VEHNO"].ToString().Trim();
                if (SM.CheckSMTask_id())
                {
                    dr["SMTask_Id"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["SMTask_Id"].ToString().Trim();
                    dr["VehNo"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VehNo"].ToString().Trim();

                    Is_Already_Exist = false;
                }

                if (!Is_Already_Exist) dt_Already_Exist.Rows.Add(dr);

                //////////////////////////////Check IN Master///////////////////////////////////////

                Is_In_Master = true;
                dr = dt_Not_In_Master.NewRow();

                int_SM_Count = Convert.ToInt32(dt_XLS_SM_Details.Compute("Count(SMTask_Id)", "SMTask_Id = '" + dt_XLS_SM_Details.Rows[int_SM_Details_Index]["SMTask_Id"].ToString().Trim() + "'").ToString());

                if (int_SM_Count > 1)
                {
                    dr = dt_Duplicate_SM.NewRow();

                    
                    dr["SMTask_Id"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["SMTask_Id"];
                    dr["VehNo"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["VehNo"];
                    dr["LastSM_Dt"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["LastSM_Dt"];
                    dr["LastSM_KM_Read"] = dt_XLS_SM_Details.Rows[int_SM_Details_Index]["LastSM_KM_Read"];

                    dt_Duplicate_SM.Rows.Add(dr);
                    Is_Valid_Data = false;
                    break;
                }

            }
            if (Is_Valid_Data && Is_In_Master && Is_Already_Exist)
            {
                dt_Valid_Data.Merge(dt_XLS_SM_Details);
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

        if (dt_Duplicate_SM.Rows.Count > 0)
        {
            div_Duplicate_SM.Visible = true;
            gv_Duplicate_SM.DataSource = dt_Duplicate_SM;
            gv_Duplicate_SM.DataBind();
        }
        if (dt_Already_Exist.Rows.Count > 0)
        {
            div_Already_Exist.Visible = true;
            gv_Already_Exist.DataSource = dt_Already_Exist;
            gv_Already_Exist.DataBind();
        }
        if (dt_Duplicate_SM.Rows.Count > 0)
        {
            div_Duplicate_SM.Visible = true;
            gv_Duplicate_SM.DataSource = dt_Duplicate_SM;
            gv_Duplicate_SM.DataBind();
        }

        if (dt_Valid_Data.Rows.Count > 0) InsertData(dt_Valid_Data);

        File.Delete(Server.MapPath(str_File_Name));
    }

    private void InsertData(DataTable dt_Valid_Data)
    {
        cls_SMvehiclewiseUpload SM = new cls_SMvehiclewiseUpload(str_Connection_String);

        string str_XML = "";
        string str_SM_Code = "";
        string str_Insert_Columns = "";
        string str_Select_Columns = "";
        string str_With_Columns = "";

        string str_SM_Header = "";
        string str_SM_Details = "";
        string[] sql_Column ={ "SMTask_Id", "VEHNO", "LastSM_Dt", "LastSM_KM_Read" };

        DataTable dt = new DataTable();

        int SM_Count = 0;

        bool IsCommitted = false,IsNotInArray = false ;

        str_XML = "<root>\n";

        dt = SM.SM_Cols_N_Size();

        foreach (DataRow dr in dt_Valid_Data.Rows)
        {
            str_XML += "<SM_Details>";

            for (int j = 0; j < sql_Column.Length; j++)
            {
                str_XML += "<" + sql_Column[j].ToString() + ">" + dr[sql_Column[j].ToString()].ToString() + "</" + sql_Column[j].ToString() + ">";
            }
            str_XML += "</SM_Details>";
        }

        
        //str_Insert_Columns = "SMTask_Id,VehNo,LastSM_Dt,LastSM_KM_Read";
        //str_Select_Columns = "SMTask_Id varchar(10) 'SMTask_Id',VehNo varchar(50) 'VehNo',LastSM_Dt datetime 'LastSM_Dt',LastSM_KM_Read varchar(50) 'LastSM_KM_Read'";

        //for (int i = 0; i < sql_Column.Length; i++)
        //{
        //    str_Insert_Columns += sql_Column[i].ToString() + ",";
        //}

        //for (int i = 0; i < sql_Column.Length; i++)
        //{
        //    str_Select_Columns +=  sql_Column[i].ToString() + ",";
        //}

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

        str_XML += "</root>";
    
        str_SM_Header = "DECLARE @result int " + "\r\n";
        str_SM_Header += "EXEC sp_xml_preparedocument @result OUTPUT,'" + str_XML.Replace("'", "''").Trim() + "'" + "\r\n";

        str_SM_Details += "INSERT INTO WEBX_FLEET_SM_Master (" + str_Insert_Columns + ")" + "\r\n";
        str_SM_Details += "SELECT " + str_Insert_Columns + "\r\n";
        str_SM_Details += "FROM OPENXML (@result, '/root/SM_Details') WITH (" + str_Select_Columns + ")" + "\r\n";

        str_SM_Details += "EXEC sp_xml_removedocument @result" + "\r\n";

        SM.BeginTransaction();

        try
        {
            SM.SQL_Data = str_SM_Header.Replace("&", "&amp").Trim() + str_SM_Details;
            SM.InsertSMXml();

            IsCommitted = SM.CommitTransaction();
        }
        catch (Exception ex)
        {
            SM.RollBackTransaction();
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted) lbl_Page_Error.Text = "!!  SM Vehicle Wise have been uploaded successfully  !!";
    }
}
