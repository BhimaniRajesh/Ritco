using System;
using System.IO;
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
 
public partial class ClaimsInvstReport : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    SqlConnection conn;

    string BRATTPCL = "", BRATTPCL_FILENAME = "", BRATTPIC = "", BRATTPIC_FILENAME = "", BRATTPOD = "", BRATTPOD_FILENAME = "", BRATTTCTHC = "", BRATTTCTHC_FILENAME = "", BRATTFIR = "", BRATTFIR_FILENAME = "", BRATTSRPT = "", BRATTSRPT_FILENAME = "", BRATTPHOTO = "", BRATTPHOTO_FILENAME = "";

    string Str1 = "",   Str2 = "", Str3 = "", Str4 = "", Str5 = "", Str6 = "", Str7 = "";
    string mBusiness = "", Booking="", Delivery = "";

    string CLetter_Name="", ICOPY_Name="", POD_Name="", TC_Name="", FIR_Name="", SRPT_Name="", Photo_Name="";
      public string rev_strDate_time, tempYear, tempDate;
    string tempMonth = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        Inetialized();


        if (!IsPostBack)
        {

            //Do Work
        }


    //    System.DateTime righnow = System.DateTime.Today;
     //   string strrightnow = righnow.ToString("dd/MM/yyyy");
        //txtSalesDt.Text = strrightnow;
     //   txtDate.SetCalenderText(strrightnow);
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


    public void Inetialized()
    {




        
        conn.Open();
        string sql = "usp_CIRData_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;


        sqlcmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = Session["DocketNo"];
  //      sqlcmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = Session["DocketSf"];

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if(dr.HasRows)
        {

            while (dr.Read())
            {

                lblCIRPreaparedBy.Text = Session["empnm"].ToString();

                lblCIRNumber.Text = Session["CIRNo"].ToString();

               // System.DateTime righnow = System.DateTime.Today;
               // string strrightnow = righnow.ToString("dd/MM/yyyy");


               //// txtDate.SetCalenderText(return_date_fun(strrightnow.ToString().Trim()));
               //      txtCIRDate.Text = strrightnow;

                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
              
                txtDate.SetCalenderText(strrightnow);

                lblDocNumber.Text = Session["DocketNo"].ToString();

                lblDocDate.Text = dr["dockdt"].ToString();

                lblOrigin.Text = dr["orgncd"].ToString();



                lblDestination.Text = dr["reassign_destcd"].ToString();



                lblName1.Text = dr["csgnnm"].ToString();

                lblName2.Text = dr["csgenm"].ToString();
                lblAdd1.Text = dr["csgnaddr"].ToString();
                lblAdd2.Text = dr["csgeaddr"].ToString();

                lblPhone1.Text = dr["csgnteleno"].ToString();
                lblPhone2.Text = dr["csgeteleno"].ToString();
                lblPin1.Text = dr["csgnpincode"].ToString();
                lblPin2.Text = dr["csgepincode"].ToString();
                lblCLParty.Text = Session["ClaimParty"].ToString();


                lblPartyGrade.Text = "-";
                if (Session["ClaimParty"].ToString().Trim() == "Consignor")
                {
                    lblPName.Text = dr["csgnnm"].ToString();
                    lblPAdd.Text = dr["csgnaddr"].ToString();
                    lblPPin.Text = dr["csgnpincode"].ToString();
                    lblPPhone.Text = dr["csgnteleno"].ToString();

                }
                if (Session["ClaimParty"].ToString().Trim() == "Consignee")
                {
                    lblPName.Text = dr["csgenm"].ToString();
                    lblPAdd.Text = dr["csgeaddr"].ToString();
                    lblPPin.Text = dr["csgepincode"].ToString();
                    lblPPhone.Text = dr["csgeteleno"].ToString();
                }


                string Claimstr = "";
                if (Session["NonDel"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Non Delivery";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Non Delivery";
                    }




                }
                if (Session["Short"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Shortage";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Shortage";
                    }




                }
                if (Session["Dam"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Damage";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Damage";
                    }




                }
                if (Session["Leak"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Leakage";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Leakage";
                    }




                }
                if (Session["Pil"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Pilferage";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Pilferage";
                    }




                }
                if (Session["Other"].ToString() == "Y")
                {
                    if (Claimstr == "")
                    {
                        Claimstr = "Other";
                    }
                    else
                    {
                        Claimstr = Claimstr + "," + "Other";
                    }




                }
                lblTClaim.Text = Claimstr.ToString().ToString().Trim();

                //   lblTPackage.Text=dr[""].ToString();



                lblPDesc.Text = dr["proddesc"].ToString();

            //    lblBooking.Text = dr["orgn_nm"].ToString();

                lblFAmt.Text = dr["tot_frtamt"].ToString();
                lblVGoods.Text = dr["DECVAL"].ToString();
                // lblLDLoc.Text

                lblIFrom.Text = dr["IncomingFrom"].ToString();



                lblTcNo.Text = dr["mf"].ToString();
                lblThcNo.Text = dr["thc"].ToString();
                lblTHCDt.Text = dr["thcdate"].ToString();
                lblVehicleNo.Text = dr["vehno"].ToString();
                //   lblRMarket.Text=dr["vehno"].ToString();
                lblRCName.Text = dr["route"].ToString();


            }
           
        }

        dr.Close();
        conn.Close();








    }







    protected void cmdCalcel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Prepareclaims.aspx");
    }
    //protected void cmdApprove_Click(object sender, EventArgs e)
    //{
      
        
    //        conn.Open();
    //        SqlCommand cmd = new SqlCommand("usp_getDocketNo", conn);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = Session["DocketNo"] ;
    //        cmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = Session["DocketSf"];
    //        cmd.Parameters.Add("@NonDel", SqlDbType.VarChar).Value = Session["NonDel"];
    //        cmd.Parameters.Add("@Shortage", SqlDbType.VarChar).Value = Session["Shortage"];
    //        cmd.Parameters.Add("@Damage", SqlDbType.VarChar).Value = Session["Damage"];
    //        cmd.Parameters.Add("@Leakage", SqlDbType.VarChar).Value = Session["Leakage"];
    //        cmd.Parameters.Add("@Pilferage", SqlDbType.VarChar).Value = Session["Pilferage"];
    //        cmd.Parameters.Add("@Other", SqlDbType.VarChar).Value = Session["Other"];


           
    //        cmd.Parameters.Add("@COF", SqlDbType.VarChar).Value = Session["COF"];

    //        cmd.Parameters.Add("@ClmParty", SqlDbType.VarChar).Value = Session["ClaimParty"];
    //      //  cmd.Parameters.Add("@Consignee", SqlDbType.VarChar).Value = Consignee;
    //      // cmd.Parameters.Add("@Other1", SqlDbType.VarChar).Value =Other1;
    //        cmd.ExecuteNonQuery();

      
    //}
    //protected void chkPLetter_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkPLetter.Checked == true)
    //    {

    //        FileUpload1.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload1.Visible = false;

    //    }
    //}
    //protected void chkICopy_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkICopy.Checked == true)
    //    {

    //        FileUpload2.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload2.Visible = false;

    //    }
    //}
    //protected void chkDPOD_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkDPOD.Checked == true)
    //    {

    //        FileUpload3.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload3.Visible = false;

    //    }
    //}
    //protected void chkPhoto_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkPhoto.Checked == true)
    //    {

    //        FileUpload4.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload4.Visible = false;

    //    }
    //}
    //protected void chkFIR_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkFIR.Checked == true)
    //    {

    //        FileUpload5.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload5.Visible = false;

    //    }
    //}
    //protected void chkSReport_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkSReport.Checked == true)
    //    {

    //        FileUpload6.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload6.Visible = false;

    //    }
    //}
    //protected void chkPhotographs_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (chkPhotographs.Checked == true)
    //    {

    //        FileUpload7.Visible = true;
    //    }
    //    else
    //    {
    //        FileUpload7.Visible = false;

    //    }
    //}
  
   
    protected void cmdApprove_Click(object sender, EventArgs e)
    {

        string[] selvaluesArr1; string[] selvaluesArr2; string[] selvaluesArr3; string[] selvaluesArr4; string[] selvaluesArr5;
        string[] selvaluesArr6; string[] selvaluesArr7;

        string mCLetter = "", mICopy = "", mPOD = "", mTC = "", mFIR = "", mSRPT = "", mPhoto = "";
        string path = Server.MapPath("~/UploadedImages/");

        string List1 = "", List2 = "", List3 = "", List4 = "", List5 = "", List6 = "", List7 = "", List8 = "", List9 = "", List10 = "";




        if (fileCLetter.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileCLetter.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = fileCLetter.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

           //     string path = Server.MapPath("~/UploadedImages/");
          //      FileUpload1.PostedFile.SaveAs(path + FileUpload1.FileName);
                Str1 = path + fileCLetter.FileName;
            }


        }
        if (fileICopy.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileICopy.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = fileICopy.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

           //     string path = Server.MapPath("~/UploadedImages/");
            //    FileUpload2.PostedFile.SaveAs(path + FileUpload2.FileName);
                Str2 = path + fileICopy.FileName;
            }


        }
        if (filePOD.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePOD.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = filePOD.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

             //   string path = Server.MapPath("~/UploadedImages/");
             //   FileUpload3.PostedFile.SaveAs(path + FileUpload3.FileName);
                Str3 = path + filePOD.FileName;
            }


        }
        if (fileTC.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileTC.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = fileTC.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

           //     string path = Server.MapPath("~/UploadedImages/");
           //     FileUpload4.PostedFile.SaveAs(path + FileUpload4.FileName);
                Str4 = path + fileTC.FileName;
            }


        }
        if (fileFIR.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileFIR.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = fileFIR.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

           //     string path = Server.MapPath("~/UploadedImages/");
            //    FileUpload5.PostedFile.SaveAs(path + FileUpload5.FileName);
                Str5 = path + fileFIR.FileName;
            }


        }
        if (fileSRPT.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileSRPT.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = fileSRPT.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

              //  string path = Server.MapPath("~/UploadedImages/");
               // FileUpload6.PostedFile.SaveAs(path + FileUpload6.FileName);
                Str6 = path + fileSRPT.FileName;
            }


        }
        if (filePhoto.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePhoto.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < 50000)
            {
                string picname = filePhoto.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

         //       string path = Server.MapPath("~/UploadedImages/");
          //      FileUpload7.PostedFile.SaveAs(path + FileUpload7.FileName);
                Str7 = path + filePhoto.FileName;
            }


        }



   

        if (fileCLetter.PostedFile.FileName != "")
        {
            selvaluesArr1 = fileCLetter.FileName.Split(new char[] { '.' });
            int maxarr1 = selvaluesArr1.GetUpperBound(0);
            for (int i = 0; i <= maxarr1; i++)
            {
                List1 = selvaluesArr1[1].ToString().Trim();

            }
        }

        if (fileICopy.PostedFile.FileName != "")
        {
            selvaluesArr2 = fileICopy.FileName.Split(new char[] { '.' });
            int maxarr2 = selvaluesArr2.GetUpperBound(0);
            for (int i = 0; i <= maxarr2; i++)
            {
                List2 = selvaluesArr2[1].ToString().Trim();

            }
        }
        if (filePOD.PostedFile.FileName != "")
        {
            selvaluesArr3 = filePOD.FileName.Split(new char[] { '.' });
            int maxarr3 = selvaluesArr3.GetUpperBound(0);
            for (int i = 0; i <= maxarr3; i++)
            {
                List3 = selvaluesArr3[1].ToString().Trim();

            }
        }

        if (fileTC.PostedFile.FileName != "")
        {
            selvaluesArr4 = fileTC.FileName.Split(new char[] { '.' });
            int maxarr4 = selvaluesArr4.GetUpperBound(0);
            for (int i = 0; i <= maxarr4; i++)
            {
                List4 = selvaluesArr4[1].ToString().Trim();

            }


        }
        if (fileFIR.PostedFile.FileName != "")
        {
            selvaluesArr5 = fileFIR.FileName.Split(new char[] { '.' });
            int maxarr5 = selvaluesArr5.GetUpperBound(0);
            for (int i = 0; i <= maxarr5; i++)
            {
                List5 = selvaluesArr5[1].ToString().Trim();

            }

        }
        if (fileSRPT.PostedFile.FileName != "")
        {
            selvaluesArr6 = fileSRPT.FileName.Split(new char[] { '.' });
            int maxarr6 = selvaluesArr6.GetUpperBound(0);
            for (int i = 0; i <= maxarr6; i++)
            {
                List6 = selvaluesArr6[1].ToString().Trim();

            }

        }
        if (filePhoto.PostedFile.FileName != "")
        {
            selvaluesArr7 = filePhoto.FileName.Split(new char[] { '.' });
            int maxarr7 = selvaluesArr7.GetUpperBound(0);
            for (int i = 0; i <= maxarr7; i++)
            {
                List7 = selvaluesArr7[1].ToString().Trim();

            }
        }


        conn.Open();

        SqlCommand sqlc = new SqlCommand("usp_createFileName", conn);
        sqlc.CommandType = CommandType.StoredProcedure;


        sqlc.Parameters.Add("@BRATTPCL_FILENAME", SqlDbType.VarChar).Value = Str1.ToString().Trim();

        sqlc.Parameters.Add("@BRATTPIC_FILENAME", SqlDbType.VarChar).Value = Str2.ToString().Trim();

        sqlc.Parameters.Add("@BRATTPOD_FILENAME", SqlDbType.VarChar).Value = Str3.ToString();

        sqlc.Parameters.Add("@BRATTTCTHC_FILENAME", SqlDbType.VarChar).Value = Str4.ToString().Trim();
        sqlc.Parameters.Add("@BRATTFIR_FILENAME", SqlDbType.VarChar).Value = Str5.ToString();
        sqlc.Parameters.Add("@BRATTSRPT_FILENAME", SqlDbType.VarChar).Value = Str6.ToString();
        sqlc.Parameters.Add("@BRATTPHOTO_FILENAME", SqlDbType.VarChar).Value = Str7.ToString();
     



        SqlDataReader sdr = sqlc.ExecuteReader();

        if (sdr.HasRows)
        {
            while (sdr.Read())
            {

                mCLetter = Convert.ToString(sdr["CLetter"]).ToString();
                mICopy = Convert.ToString(sdr["ICopy"]).ToString();



                mPOD = Convert.ToString(sdr["POD"]).ToString();

                mTC = Convert.ToString(sdr["TC"]).ToString();

                mFIR = Convert.ToString(sdr["FIR"]).ToString();

                mSRPT = Convert.ToString(sdr["SRPT"]).ToString();

                mPhoto = Convert.ToString(sdr["Photo"]).ToString();
       
            }
        }

        sdr.Close();

        if (fileCLetter.PostedFile.FileName != "")
        {


            string CLetter = mCLetter + '.' + List1;

            fileCLetter.PostedFile.SaveAs(path + CLetter);


            CLetter_Name = CLetter;

        }

        if (fileICopy.PostedFile.FileName != "")
        {
            string ICopy = mICopy + '.' + List2;

            fileICopy.PostedFile.SaveAs(path + ICopy);


          ICOPY_Name = mICopy;
        }


        if (filePOD.PostedFile.FileName != "")
        {
            string POD = mPOD + '.' + List3;

            filePOD.PostedFile.SaveAs(path + POD);


            POD_Name = POD;

        }


        if (fileTC.PostedFile.FileName != "")
        {
            string TC = mTC + '.' + List4;

            fileTC.PostedFile.SaveAs(path + TC);


           TC_Name = TC;
        }



        if (fileFIR.PostedFile.FileName != "")
        {
            string FIR = mFIR + '.' + List5;

            fileFIR.PostedFile.SaveAs(path + FIR);


            FIR_Name = FIR;

        }

        if (fileSRPT.PostedFile.FileName != "")
        {

            string SRPT = mSRPT + '.' + List6;

            fileSRPT.PostedFile.SaveAs(path + SRPT);


            SRPT_Name = SRPT;
        }

        if (filePhoto.PostedFile.FileName != "")
        {
            string Photo = mPhoto + '.' + List7;

            filePhoto.PostedFile.SaveAs(path + Photo);


            Photo_Name = Photo;
        }


   






   //        conn.Open();
            SqlCommand cmd = new SqlCommand("usp_ClaimInsert_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = Session["DocketNo"].ToString();
            cmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = Session["DocketSf"].ToString();

            cmd.Parameters.Add("@CIRNo", SqlDbType.VarChar).Value = Session["CIRNO"].ToString();

            cmd.Parameters.Add("@Branch", SqlDbType.VarChar).Value = Session["CIRBR"].ToString();


            cmd.Parameters.Add("@PrepBy", SqlDbType.VarChar).Value = Session["BR_PrePBy"].ToString().Trim();

            cmd.Parameters.Add("@PRName", SqlDbType.VarChar).Value = Session["BR_PreName"].ToString();

            //@LOCEMPCD


            cmd.Parameters.Add("@LOCEMPCD", SqlDbType.VarChar).Value = Session["BR_PrePBy"].ToString();
            cmd.Parameters.Add("@LOCEMPNM", SqlDbType.VarChar).Value = Session["BR_PreName"].ToString();


            cmd.Parameters.Add("@NonDel", SqlDbType.VarChar).Value = Session["NonDel"].ToString();
            cmd.Parameters.Add("@Shortage", SqlDbType.VarChar).Value = Session["Short"].ToString();
            cmd.Parameters.Add("@Damage", SqlDbType.VarChar).Value = Session["Dam"].ToString();
            cmd.Parameters.Add("@Leakage", SqlDbType.VarChar).Value = Session["Leak"].ToString();
            cmd.Parameters.Add("@Pilferage", SqlDbType.VarChar).Value = Session["Pil"].ToString();
            cmd.Parameters.Add("@Other", SqlDbType.VarChar).Value = Session["Other"].ToString();



            cmd.Parameters.Add("@COF", SqlDbType.VarChar).Value = Session["COF"].ToString();

            cmd.Parameters.Add("@ClaimParty", SqlDbType.VarChar).Value = Session["ClaimParty"].ToString();

            DateTime dt= new DateTime();
          
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            // if (usercode == "")
            //{
            //    dt = Convert.ToDateTime(txtCIRDate.Text, dtfi);
              
            //}


            cmd.Parameters.Add("@CLPartyName", SqlDbType.VarChar).Value = lblPName.Text;
            cmd.Parameters.Add("@ClPartyAdd", SqlDbType.VarChar).Value = lblPAdd.Text;
            cmd.Parameters.Add("@ClPartyPin", SqlDbType.VarChar).Value = lblPPin.Text;
            cmd.Parameters.Add("@ClPartytel", SqlDbType.VarChar).Value = lblPPhone.Text;





            cmd.Parameters.Add("@CIRDate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.CalenderText().ToString().Trim(), dtfi); 
            cmd.Parameters.Add("@ClaimAmt", SqlDbType.Decimal).Value = Convert.ToDecimal(txtCAmt.Text);
            cmd.Parameters.Add("@CName", SqlDbType.VarChar).Value = txtCName.Text;
            cmd.Parameters.Add("@CValue", SqlDbType.VarChar).Value = txtCValue.Text;
            cmd.Parameters.Add("@SName", SqlDbType.VarChar).Value = txtSName.Text;
            cmd.Parameters.Add("@SValue", SqlDbType.VarChar).Value = txtSValue.Text;
            cmd.Parameters.Add("@SEName", SqlDbType.VarChar).Value = txtEName.Text;
            cmd.Parameters.Add("@SEValue", SqlDbType.VarChar).Value = txtEValue.Text;

            cmd.Parameters.Add("@IncCoName", SqlDbType.VarChar).Value = txtCoName.Text;
            cmd.Parameters.Add("@IncPNo", SqlDbType.VarChar).Value = txtPolNo.Text;

          //  cmd.Parameters.Add("@Challan", SqlDbType.VarChar).Value = ddlChallanNo.SelectedItem.Text;

            if (txtMBusiness.Text == "")
            {
                mBusiness = "0";

            }
            else
            {
                mBusiness=txtMBusiness.Text;
            }


            if (txtBooking.Text == "")
            {
                Booking = "0";

            }
            else
            {
                Booking = txtBooking.Text;
            }


            if (txtDelivery.Text == "")
            {
                Delivery = "0";

            }
            else
            {

                Delivery = txtDelivery.Text;

            }
            cmd.Parameters.Add("@MBusiness", SqlDbType.Decimal).Value = Convert.ToDecimal(mBusiness);
            cmd.Parameters.Add("@Booking", SqlDbType.Decimal).Value = Convert.ToDecimal(Booking);
            cmd.Parameters.Add("@Delivery", SqlDbType.Decimal).Value = Convert.ToDecimal(Delivery);
            cmd.Parameters.Add("@NBusiness", SqlDbType.VarChar).Value = txtNBusiness.Text;

            cmd.Parameters.Add("@BFlag", SqlDbType.VarChar).Value =  "Y";
            cmd.Parameters.Add("@AFlag", SqlDbType.VarChar).Value =  "N";
            cmd.Parameters.Add("@HFlag", SqlDbType.VarChar).Value =  "N";



            if (chkPLetter.Checked == true)
            {
                BRATTPCL = "Y";
             

            }
            else
            {
                BRATTPCL = "N";
               
            }
            if (chkICopy.Checked == true)
            {
                BRATTPIC = "Y";


            }
            else
            {
                BRATTPIC = "N";

            }
            if (chkDPOD.Checked == true)
            {
                BRATTPOD = "Y";


            }
            else
            {
                BRATTPOD = "N";

            }
            if (chkPhoto.Checked == true)
            {
                BRATTTCTHC = "Y";


            }
            else
            {
                BRATTTCTHC = "N";

            }

           
            if (chkFIR.Checked == true)
            {
                BRATTFIR = "Y";


            }
            else
            {
                BRATTFIR = "N";

            }


            if (chkSReport.Checked == true)
            {
                BRATTSRPT = "Y";


            }
            else
            {
                BRATTSRPT = "N";

            }


            if (chkPhotographs.Checked == true)
            {
                BRATTPHOTO = "Y";


            }
            else
            {
                BRATTPHOTO = "N";

            }



            cmd.Parameters.Add("@BRATTPCL", SqlDbType.VarChar).Value = BRATTPCL;
            cmd.Parameters.Add("@BRATTPCL_FILENAME", SqlDbType.VarChar).Value = CLetter_Name;

            cmd.Parameters.Add("@BRATTPIC", SqlDbType.VarChar).Value = BRATTPIC;
            cmd.Parameters.Add("@BRATTPIC_FILENAME", SqlDbType.VarChar).Value = ICOPY_Name;

            cmd.Parameters.Add("@BRATTPOD", SqlDbType.VarChar).Value =BRATTPOD;
            cmd.Parameters.Add("@BRATTPOD_FILENAME", SqlDbType.VarChar).Value =POD_Name ;

            cmd.Parameters.Add("@BRATTTCTHC", SqlDbType.VarChar).Value =BRATTTCTHC ;
            cmd.Parameters.Add("@BRATTTCTHC_FILENAME", SqlDbType.VarChar).Value = TC_Name;

            cmd.Parameters.Add("@BRATTFIR", SqlDbType.VarChar).Value =BRATTFIR ;
            cmd.Parameters.Add("@BRATTFIR_FILENAME", SqlDbType.VarChar).Value =FIR_Name ;

            cmd.Parameters.Add("@BRATTSRPT", SqlDbType.VarChar).Value = BRATTSRPT;
            cmd.Parameters.Add("@BRATTSRPT_FILENAME", SqlDbType.VarChar).Value = SRPT_Name;

            cmd.Parameters.Add("@BRATTPHOTO", SqlDbType.VarChar).Value = BRATTPHOTO;
            cmd.Parameters.Add("@BRATTPHOTO_FILENAME", SqlDbType.VarChar).Value = Photo_Name;




            //  cmd.Parameters.Add("@Consignee", SqlDbType.VarChar).Value = Consignee;
            // cmd.Parameters.Add("@Other1", SqlDbType.VarChar).Value =Other1;
            cmd.ExecuteNonQuery();

            conn.Close();

            string DocNo = Session["DocketNo"].ToString();

            Response.Redirect("Certificate.aspx?DocNo=" + DocNo);



    }
}
