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
public partial class admin_TireMaster : System.Web.UI.Page
{
  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public string rev_strDate_time, tempYear, tempDate;
    string tempMonth;
    string mVehno = "", mLocName = "", mTyreID = "", AddEditMode="";
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        addVendor();
        addManufacturer();
        addLocation();
        addVehicleNo();
        addTyreType();
        addTyreSize();
        addTyreCategory();
        addTreadPattern();
        mTyreID = Request.QueryString["id"];
      //  mVehno=   Request.QueryString["id1"];

      //  mLocName = Request.QueryString["id2"];

        //if (mVehno != "" && mVehno != null)
        //{
        //    txtVehicleNo.Text = mVehno.ToString();
        //}

        //if (mLocName != "" && mLocName != null)
        //{
        //    txtLocation.Text = mLocName.ToString();
        //}
//            string scr = @"<script>  
//            function update(elemValue)
//          {
//            document.getElementById('ctl00$MyCPH1$txtVehicleno').value=elemValue[0];
//          }
//      
//             </script>";

//                Page.RegisterClientScriptBlock("update", scr);
//                btnVehicleNo.Attributes.Add("onclick", "window.open('VehicleNo.aspx',null,'left=0, top=0, height=500, width= 500, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar=no');");


//                string scr1 = @"<script>  
//            function update(elemValue)
//          {
//            document.getElementById('ctl00$MyCPH1$txtLocation').value=elemValue[0];
//          }
//         
//             </script>";

//                Page.RegisterClientScriptBlock("update", scr1);
//                btnLocation.Attributes.Add("onclick", "window.open('Location.aspx',null,'left=0, top=0, height=500, width= 500, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar=no');");
         if(ddlOE.SelectedItem.Text=="YES")
        {
               txtCost.Text = "0";
        }
        cmdSubmit.Attributes.Add("onClick", "javascript:return checkEvent();");

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");
        //txtDate.Text = strrightnow;
        txtDate.SetCalenderText(strrightnow);
        if (!IsPostBack)
        {

            if (mTyreID != "" && mTyreID != null)
            {
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




    public void addManufacturer()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select MFG_ID,MFG_Name from WEBX_FLEET_TYREMFG where MFG_ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr1 = cmd.ExecuteReader();
        ddlManufacturer.Items.Add(new ListItem("Select", ""));

        if (dr1.HasRows)
        {
            while (dr1.Read())
            {

                ddlManufacturer.Items.Add(new ListItem(Convert.ToString(dr1["MFG_Name"]), Convert.ToString(dr1["MFG_ID"])));
            }

        }

        dr1.Close();
        conn.Close();

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


    public void addVehicleNo()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select VEHNO  from webx_VEHICLE_HDR where ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlVehicleNo.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlVehicleNo.Items.Add(new ListItem(Convert.ToString(dr["VEHNO"])));
            }

        }

        dr.Close();
        conn.Close();

    }

    public void addLocation()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select LocCode,LocName from webx_location where ActiveFlag='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlLocation.Items.Add(new ListItem("Select",""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlLocation.Items.Add(new ListItem(Convert.ToString(dr["LocName"]), Convert.ToString(dr["LocCode"])));
            }

        }

        dr.Close();
        conn.Close();

    }

    public void addTyreCategory()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "SELECT CodeId,CodeDesc FROM Webx_Master_General where CodeType='TYCAT'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlTyreCategory.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlTyreCategory.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }
        dr.Close();
        conn.Close();
    }

    public void addTreadPattern()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "SELECT CodeId,CodeDesc FROM Webx_Master_General where CodeType='TYPAT'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlTreadPattern.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlTreadPattern.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }
        dr.Close();
        conn.Close();
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
                tempDate = tarDate_time[0].ToString().Trim();
                tempMonth = (tarDate_time[1]).ToString();
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

    public void addVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select VENDORNAME,VENDORCODE from webx_VENDOR_HDR where Active='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlVendor.Items.Add(new ListItem("Select",""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlVendor.Items.Add(new ListItem(Convert.ToString(dr["VENDORNAME"]), Convert.ToString(dr["VENDORCODE"])));
            }

        }

        dr.Close();
        conn.Close();

    }



    public void addTyreType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select TYRE_TYPEID,TYRE_TYPENAME from WEBX_FLEET_TYRETYPEMST where TYPE_ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlTyreType.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlTyreType.Items.Add(new ListItem(Convert.ToString(dr["TYRE_TYPENAME"]), Convert.ToString(dr["TYRE_TYPEID"])));
            }

        }

        dr.Close();
        conn.Close();

    }

    public void addTyreSize()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select TYRE_SIZEID,TYRE_SIZENAME from WEBX_FLEET_TYRESIZEMST where SIZE_ACTIVEFLAG='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        ddlSize.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                ddlSize.Items.Add(new ListItem(Convert.ToString(dr["TYRE_SIZENAME"]), Convert.ToString(dr["TYRE_SIZEID"])));
            }

        }

        dr.Close();
        conn.Close();

    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
       

        string DataFound = "N";
        AddEditMode = ViewState["AddEditMode"].ToString();


        //    if (AddEditMode.ToString().Trim() == "I")
        //    {

        //    string STR = "select * from WEBX_FLEET_TYREMST  where TYRE_NO='"+txtTyreNo.Text.ToString().Trim()+"'    and MFG_ID='"+ddlManufacturer.SelectedItem.Value.ToString().Trim()+"'";


        //    SqlCommand cmd4 = new SqlCommand(STR, conn);
        //   // cmd4.CommandType = CommandType.StoredProcedure;
        //    SqlDataReader dr4 = cmd4.ExecuteReader();
        //    if (dr4.HasRows)
        //    {
        //        while (dr4.Read())
        //        {
        //           // mTyreID = Convert.ToString(dr3[0]);
        //            DataFound = "Y";
        //        }

        //    }

        //    dr4.Close();

        //      lblErrMsg.Text="";

        //if (DataFound == "N")
        //{

        if (AddEditMode.ToString().Trim() == "I" )
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string STR = "select * from WEBX_FLEET_TYREMST  where TYRE_NO='"+txtTyreNo.Text.ToString().Trim()+"'    and MFG_ID='"+ddlManufacturer.SelectedItem.Value.ToString().Trim()+"'";

            SqlCommand cmd4 = new SqlCommand(STR, conn);
           // cmd4.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr4 = cmd4.ExecuteReader();
            if (dr4.HasRows)
            {
                while (dr4.Read())
                {
                   // mTyreID = Convert.ToString(dr3[0]);
                    DataFound = "Y";
                }
            }

            dr4.Close();

           lblErrMsg.Text="";

        if (DataFound == "N")
        {
            
          //  if (mTyreID == "" || mTyreID == null)
            //{


                SqlCommand cmd3 = new SqlCommand("usp_CreateTyreID", conn);
                cmd3.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr3 = cmd3.ExecuteReader();
                if (dr3.HasRows)
                {
                    while (dr3.Read())
                    {
                        mTyreID = Convert.ToString(dr3[0]);
                    }

                }

                dr3.Close();
          // }
          

            SqlCommand cmd1 = new SqlCommand("usp_Tyre_InsertUpadte", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
                                    
            da.SelectCommand.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = mTyreID.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreNo", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYPE", SqlDbType.VarChar).Value = ddlTyreType.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@MFGID", SqlDbType.VarChar).Value = ddlManufacturer.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@SIZE", SqlDbType.VarChar).Value = ddlSize.SelectedItem.Value.ToString().Trim();
          //  da.SelectCommand.Parameters.Add("@PDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtPDate.Text.ToString().Trim(), dtfi);
            da.SelectCommand.Parameters.Add("@PDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.CalenderText().ToString().Trim(), dtfi);
            
            da.SelectCommand.Parameters.Add("@PKms", SqlDbType.Int).Value = Convert.ToInt32(txtPKms.Text.ToString().Trim());
 
            
            da.SelectCommand.Parameters.Add("@OE", SqlDbType.VarChar).Value = ddlOE.SelectedItem.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Cost", SqlDbType.Int).Value = Convert.ToInt32(txtCost.Text.ToString().Trim());
            //if (ddlVehicleNo.SelectedItem.Text.ToString().Trim() != "")
            //{
            da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = ddlVehicleNo.SelectedItem.Text.ToString().Trim();
            //}

            //if (ddlLocation.SelectedItem.Value.ToString().Trim() != "")
            //{
                da.SelectCommand.Parameters.Add("@Location", SqlDbType.VarChar).Value = ddlLocation.SelectedItem.Value.ToString().Trim();

          //  }

                if (ddlVehicleNo.SelectedItem.Text.ToString().Trim() != "")
                {
                    da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = "M";
                }
                else if (ddlLocation.SelectedItem.Value.ToString().Trim() != "")
                {
                    da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = "A";
                }

                if (txtWarrantyDt.Text.Trim() != "")
                {

                    da.SelectCommand.Parameters.Add("@WarrantyExpDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtWarrantyDt.Text.ToString().Trim(), dtfi);
                }
                else
                {
                    da.SelectCommand.Parameters.Add("@WarrantyExpDt", SqlDbType.DateTime).Value = "01/01/1900";

                }


              if (txtWarrantyExpKms.Text.ToString().Trim() != "")
              {
                  da.SelectCommand.Parameters.Add("@WarrantyExpKms", SqlDbType.Int).Value = Convert.ToInt32(txtWarrantyExpKms.Text.ToString().Trim());
              }
              else
              {
                  da.SelectCommand.Parameters.Add("@WarrantyExpKms", SqlDbType.Int).Value = -1;
              }
            
            
            da.SelectCommand.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = ddlVendor.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TreadDepth", SqlDbType.Int).Value = Convert.ToInt32(txtTreadDepth.Text.ToString().Trim());
            da.SelectCommand.Parameters.Add("@Pressure", SqlDbType.Int).Value = Convert.ToInt32(txtPressure.Text.ToString().Trim());
            da.SelectCommand.Parameters.Add("@Axle", SqlDbType.VarChar).Value = txtAxle.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Wheel", SqlDbType.VarChar).Value = txtWheel.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboActive.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreCategory", SqlDbType.VarChar).Value = ddlTyreCategory.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreTreadPattern", SqlDbType.VarChar).Value = ddlTreadPattern.SelectedItem.Value.ToString().Trim();
            cmd1.ExecuteNonQuery();


            conn.Close();

            string Tyre = mTyreID;
            Response.Redirect("TyreResult.aspx?Tyre=" + Tyre, true);



           
        }
             else
        {
           lblErrMsg.Visible=true;
           lblErrMsg.Text = "This Tyre Entry is Already Exists in Tyre Master";


        }
      }                              
        
       
    


        else


        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd1 = new SqlCommand("usp_Tyre_InsertUpadte", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";




            da.SelectCommand.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = mTyreID.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreNo", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYPE", SqlDbType.VarChar).Value = ddlTyreType.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@MFGID", SqlDbType.VarChar).Value = ddlManufacturer.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@SIZE", SqlDbType.VarChar).Value = ddlSize.SelectedItem.Value.ToString().Trim();
           // da.SelectCommand.Parameters.Add("@PDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtPDate.Text.ToString().Trim(), dtfi);
            da.SelectCommand.Parameters.Add("@PDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.CalenderText().ToString().Trim(), dtfi);
           
            
            
            
            da.SelectCommand.Parameters.Add("@PKms", SqlDbType.VarChar).Value = txtPKms.Text.ToString().Trim();
            //string str = Convert.ToDateTime(txtDate.CalenderText());


            da.SelectCommand.Parameters.Add("@OE", SqlDbType.VarChar).Value = ddlOE.SelectedItem.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Cost", SqlDbType.VarChar).Value = txtCost.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = ddlVehicleNo.SelectedItem.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Location", SqlDbType.VarChar).Value = ddlLocation.SelectedItem.Value.ToString().Trim();

            if (ddlVehicleNo.SelectedItem.Text.ToString().Trim() != "")
            {
                da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = "M";
            }
            if (ddlLocation.SelectedItem.Value.ToString().Trim() != "")
            {
                da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = "A";
            }
            
            
            //da.SelectCommand.Parameters.Add("@WarrantyExpDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtWarrantyDt.Text.ToString().Trim(), dtfi);
            //da.SelectCommand.Parameters.Add("@WarrantyExpKms", SqlDbType.VarChar).Value = txtWarrantyExpKms.Text.ToString().Trim();
            if (txtWarrantyDt.Text.Trim() != "")
            {

                da.SelectCommand.Parameters.Add("@WarrantyExpDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtWarrantyDt.Text.ToString().Trim(), dtfi);
            }
            else
            {
                da.SelectCommand.Parameters.Add("@WarrantyExpDt", SqlDbType.DateTime).Value = "01/01/1900";

            }


            if (txtWarrantyExpKms.Text.ToString().Trim() != "")
            {
                da.SelectCommand.Parameters.Add("@WarrantyExpKms", SqlDbType.Int).Value = Convert.ToInt32(txtWarrantyExpKms.Text.ToString().Trim());
            }
            else
            {
                da.SelectCommand.Parameters.Add("@WarrantyExpKms", SqlDbType.Int).Value = -1;
            }
            
            
            da.SelectCommand.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = ddlVendor.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TreadDepth", SqlDbType.VarChar).Value = txtTreadDepth.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Pressure", SqlDbType.VarChar).Value = txtPressure.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Axle", SqlDbType.VarChar).Value = txtAxle.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Wheel", SqlDbType.VarChar).Value = txtWheel.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboActive.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreCategory", SqlDbType.VarChar).Value = ddlTyreCategory.SelectedItem.Value.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TyreTreadPattern", SqlDbType.VarChar).Value = ddlTreadPattern.SelectedItem.Value.ToString().Trim();
            cmd1.ExecuteNonQuery();


            conn.Close();

            string Tyre = mTyreID;
            Response.Redirect("TyreResult.aspx?Tyre=" + Tyre, true);

        }

   


     









    }






    public void Inetialiazed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd2 = new SqlCommand("usp_TyreData_List",conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd2);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = mTyreID.ToString().Trim();
        SqlDataReader dr = cmd2.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                string mType = dr["TYRE_TYPEID"].ToString().Trim();
                for (int i = 0; i < ddlTyreType.Items.Count; i++)
                {
                    if (mType == ddlTyreType.Items[i].Value.ToString().Trim())
                    {
                        ddlTyreType.SelectedIndex = i;
                    }

                }


             //   ddlTyreType.Text = dr["TYRE_TYPEID"].ToString().Trim();
                txtTyreNo.Text = dr["TYRE_NO"].ToString().Trim();
                                                     
                string mMFGID = dr["MFG_ID"].ToString().Trim();
                for (int i = 0; i < ddlManufacturer.Items.Count; i++)
                {
                    if (mMFGID == ddlManufacturer.Items[i].Value.ToString().Trim())
                    {
                        ddlManufacturer.SelectedIndex = i;
                    }

                }


                string mSize = dr["TYRE_SIZEID"].ToString().Trim();
                for (int i = 0; i < ddlSize.Items.Count; i++)
                {
                    if (mSize == ddlSize.Items[i].Value.ToString().Trim())
                    {
                        ddlSize.SelectedIndex = i;
                    }

                }
                
                
                
            //    ddlSize.SelectedItem.Text = dr["TYRE_SIZEID"].ToString().Trim();
               string STR= dr["PDate"].ToString().Trim();
              txtDate.SetCalenderText(return_date_fun(dr["PDate"].ToString().Trim()));

             //   txtPDate.Text=dr["PDate"].ToString().Trim();
                txtPKms.Text = dr["TYRE_PUR_KMS"].ToString().Trim();

                string mOE = dr["TYRE_OE"].ToString().Trim();
                for (int i = 0; i < ddlOE.Items.Count; i++)
                {
                    if (mOE == ddlOE.Items[i].Text.ToString().Trim())
                    {
                        ddlOE.SelectedIndex = i;
                    }

                }
             
                
                //  ddlOE.SelectedItem.Text = dr["TYRE_OE"].ToString().Trim();
               
                
                
                txtCost.Text = dr["TYRE_COST"].ToString().Trim();

                string mVehicleNo = dr["TYRE_VEHNO"].ToString().Trim();
                for (int i = 0; i < ddlVehicleNo.Items.Count; i++)
                {
                    if (mVehicleNo == ddlVehicleNo.Items[i].Text.ToString().Trim())
                    {
                        ddlVehicleNo.SelectedIndex = i;
                    }

                }

                string mLocation = dr["TYRE_LOCATION"].ToString().Trim();
                for (int i = 0; i < ddlLocation.Items.Count; i++)
                {
                    if (mLocation == ddlLocation.Items[i].Value.ToString().Trim())
                    {
                        ddlLocation.SelectedIndex = i;
                    }

                }
              
                
               // ddlLocation.SelectedItem.Text = dr["TYRE_LOCATION"].ToString().Trim();
               // txtDate1.SetCalenderText(return_date_fun(dr["WEDate"].ToString().Trim()));
                 txtWarrantyDt.Text = dr["WEDate"].ToString().Trim();
                txtWarrantyExpKms.Text = dr["TYRE_WARRANTY_EXPKMS"].ToString().Trim();

                string mVendor = dr["TYRE_VENDOR"].ToString().Trim();
                for (int i = 0; i < ddlVendor.Items.Count; i++)
                {
                    if (mVendor == ddlVendor.Items[i].Value.ToString().Trim())
                    {
                        ddlVendor.SelectedIndex = i;
                    }
                }


                string mCategory = dr["TYRE_CATEGORY"].ToString().Trim();
                for (int i = 0; i < ddlTyreCategory.Items.Count; i++)
                {
                    if (mCategory == ddlTyreCategory.Items[i].Value.ToString().Trim())
                    {
                        ddlTyreCategory.SelectedIndex = i;
                    }
                }

                string mTreadPattern = dr["TYRE_TREAD_PATTERN"].ToString().Trim();
                for (int i = 0; i < ddlTreadPattern.Items.Count; i++)
                {
                    if (mTreadPattern == ddlTreadPattern.Items[i].Value.ToString().Trim())
                    {
                        ddlTreadPattern.SelectedIndex = i;
                    }
                }


                txtTreadDepth.Text = dr["TYRE_TREAD_DEPTH_32NDS"].ToString().Trim();
                txtPressure.Text = dr["TYRE_PRESSURE_PSI"].ToString().Trim();
                txtAxle.Text = dr["TYRE_AXLE_CONFIG"].ToString().Trim();
                txtWheel.Text = dr["TYRE_WHEEL_CONFIG"].ToString().Trim();

                string mActive = dr["TYRE_ACTIVEFLAG"].ToString().Trim();
                for (int i = 0; i < cboActive.Items.Count; i++)
                {
                    if (mActive == cboActive.Items[i].Value.ToString().Trim())
                    {
                        cboActive.SelectedIndex = i;
                    }

                }
                
            }

        }

        dr.Close();

        conn.Close();

    }

    protected void ddlOE_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlOE.SelectedItem.Text == "YES")
        {
           txtCost.Text = "0";

        }
        else
        {
            txtCost.Text = "";
        }
    }
}
