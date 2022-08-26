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
using System.Data.SqlClient;

public partial class admin_MFGDet : System.Web.UI.Page
{
   // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public string rev_strDate_time, tempYear, tempDate;
    string tempMonth;
    string mVehno = "", mLocName = "", MFGID = "", AddEditMode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        MFGID = Request.QueryString["id"];
        if (!IsPostBack)
        {

            if (MFGID != "" && MFGID != null)
            {
                lblDriverIDVal.Text = MFGID;
                Inetialiazed();
                AddEditMode = "U";
                ViewState["AddEditMode"] = AddEditMode;
            }
            else
            {
                AddEditMode = "I";
                ViewState["AddEditMode"] = AddEditMode;
            }

        }



    }


    protected string return_date_fun(string rev_strDate_time)
    {
        if (rev_strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = rev_strDate_time;

            string[] arDate_time = new string[3];
            char[] split_arDate_time = { ' ' };
            arDate_time = date_time.Split(split_arDate_time);

            string[] tarDate_time = new string[3];
            string tmparDate_time;
            tmparDate_time = arDate_time[0].ToString().Trim();
            char[] split_tmparDate_time = { '/' };

            tarDate_time = tmparDate_time.Split(split_tmparDate_time);
            for (int x = 0; x < tarDate_time.Length; x++)
            {
                tempDate = tarDate_time[1].ToString().Trim();
                tempMonth = (tarDate_time[0]).ToString();
                //tempDate = tarDate_time[0].ToString().Trim();
                //tempMonth = (tarDate_time[1]).ToString();
                tempYear = tarDate_time[2];
            }
            string fdt = Rev_DayName(tempDate) + "/" + Rev_MonthName(tempMonth) + "/" + System.Convert.ToString(tempYear);
            return fdt;
        }
    }

    static string Rev_DayName(string day)
    {
        switch (day)
        {
            case "1": return ("01");
            case "2": return ("02");
            case "3": return ("03");
            case "4": return ("04");
            case "5": return ("05");
            case "6": return ("06");
            case "7": return ("07");
            case "8": return ("08");
            case "9": return ("09");

            case "01": return ("01");
            case "02": return ("02");
            case "03": return ("03");
            case "04": return ("04");
            case "05": return ("05");
            case "06": return ("06");
            case "07": return ("07");
            case "08": return ("08");
            case "09": return ("09");


            case "10": return ("10");
            case "11": return ("11");
            case "12": return ("12");
            case "13": return ("13");
            case "14": return ("14");
            case "15": return ("15");
            case "16": return ("16");

            case "17": return ("17");
            case "18": return ("18");
            case "19": return ("19");
            case "20": return ("20");
            case "21": return ("21");
            case "22": return ("22");
            case "23": return ("23");
            case "24": return ("24");
            case "25": return ("25");
            case "26": return ("26");
            case "27": return ("27");
            case "28": return ("28");
            case "29": return ("29");
            case "30": return ("30");
            case "31": return ("31");

            default: return ("");
        }
    }

    //protected void doOnDataBound(object sender, EventArgs e)
    //{
    //    DropDownList cbo = (DropDownList)sender;
    //    cbo.Items.Insert(0, "");
    //    cbo.Items[0].Text = "Select";
    //    cbo.Items[0].Value = "";
    //    //cbo.Items[0].Selected = true;
    //    doSub(sender);
    //}


    //protected void doSub(object sender)
    //{
    //    DropDownList cbo = (DropDownList)sender;

    //    switch (cbo.ID)
    //    {
    //        case "cboStatus":
    //            for (int i = 0; i < cbo.Items.Count; i++)
    //            {
    //                if (cbo.Items[i].Value == hPrevStatus.Value)
    //                {
    //                    if (cbo.Items[i].Selected == false)
    //                    {
    //                        cbo.Items[i].Selected = true;
    //                    }
    //                    i = 1000;
    //                }
    //            }
    //            break;
    //    }
    //}

    static string Rev_MonthName(string month)
    {
        switch (month)
        {
            case "1": return ("01");
            case "2": return ("02");
            case "3": return ("03");
            case "4": return ("04");
            case "5": return ("05");
            case "6": return ("06");
            case "7": return ("07");
            case "8": return ("08");
            case "9": return ("09");

            case "01": return ("01");
            case "02": return ("02");
            case "03": return ("03");
            case "04": return ("04");
            case "05": return ("05");
            case "06": return ("06");
            case "07": return ("07");
            case "08": return ("08");
            case "09": return ("09");


            case "10": return ("10");
            case "11": return ("11");
            case "12": return ("12");
            default: return ("");
        }
    }


    public void Inetialiazed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd2 = new SqlCommand("usp_MFGData_List1", conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd2);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add("@MFGID", SqlDbType.VarChar).Value = MFGID.ToString().Trim();
        SqlDataReader dr = cmd2.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                txtManufacturer.Text = dr["MFG_NAME"].ToString().Trim();
                txtMFGAddr.Text = dr["MFG_ADDR"].ToString().Trim();
                txtMFGTelNo.Text = dr["MFG_TELNO"].ToString().Trim();
               // txtMFGEntry.Text = dr["MFG_ENTRYBY"].ToString().Trim();
               // txtMFGDate.Text = dr["MFG_ENTRYDT"].ToString().Trim();

                string mActive = dr["MFG_ACTIVEFLAG"].ToString();
                for (int i = 0; i < cboActive.Items.Count; i++)
                {
                    if (mActive == cboActive.Items[i].Value)
                    {

                        cboActive.SelectedIndex = i;


                    }

                }
            }
         }



        dr.Close();

        conn.Close();



    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        conn.Open();




        string DataFound = "N";

        string STR = "select MFG_NAME  from WEBX_FLEET_TYREMFG  where MFG_NAME='" + txtManufacturer.Text.ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                DataFound = "Y";

            }

        }
        dr.Close();


        lblErrMsg.Text = "";








        AddEditMode = ViewState["AddEditMode"].ToString();

        if (AddEditMode.ToString().Trim() == "I")
        {
            SqlCommand cmd3 = new SqlCommand("usp_CreateMFGID", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr3 = cmd3.ExecuteReader();
            if (dr3.HasRows)
            {
                while (dr3.Read())
                {
                    MFGID = Convert.ToString(dr3[0]);

                }

            }

            dr3.Close();

        }




        

        if (DataFound == "Y" && AddEditMode.ToString().Trim() == "I")
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Manufacturer Name already Exists!";

        }
        
        else
        {
            SqlCommand cmd1 = new SqlCommand("usp_MFG_InsertUpdate", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            da.SelectCommand.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
            da.SelectCommand.Parameters.Add("@MFGID", SqlDbType.VarChar).Value = MFGID.ToString().Trim();
            da.SelectCommand.Parameters.Add("@MFGName", SqlDbType.VarChar).Value = txtManufacturer.Text.ToString().Trim();

            da.SelectCommand.Parameters.Add("@MFGAddr", SqlDbType.VarChar).Value = txtMFGAddr.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@MFGTelNo", SqlDbType.VarChar).Value = txtMFGTelNo.Text.ToString().Trim();
            //  da.SelectCommand.Parameters.Add("@MFGENTRY", SqlDbType.VarChar).Value = txtMFGEntry.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboActive.SelectedItem.Value.ToString().Trim();


            cmd1.ExecuteNonQuery();



            conn.Close();
            string MFGName = txtManufacturer.Text;

            //Response.Redirect("MFGResult.aspx?MFGName=" + MFGName + "&MFGID=" + MFGID, true);
            Response.Redirect("MFG.aspx");
        }
        
        
        
        }
}
