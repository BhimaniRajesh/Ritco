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

public partial class ClaimInvstReportView : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    SqlConnection conn;
    string mDoc = "";
    
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

        mDoc = Request.QueryString["id"];
        if (mDoc != "" && mDoc != null)
        {
            Inetialized();
        }



        if (!IsPostBack)
        {

            //Do Work
        }
    }















    public void Inetialized()
    {





        conn.Open();
        string sql = "usp_CIRData_List2";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;


        sqlcmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = mDoc;
        //      sqlcmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = Session["DocketSf"];

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if (dr.HasRows)
        {

            while (dr.Read())
            {

                lblCIRPreaparedBy.Text = dr["BR_PREPNM"].ToString();

                lblCIRNumber.Text = dr["CIRNo"].ToString();





                lblCIRDate.Text = dr["CIR_ENTRYDT"].ToString();

               // txtCIRDate.Text = strrightnow;



                lblDocNumber.Text = dr["Dockno"].ToString();

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
                lblCLParty.Text = dr["clmpty"].ToString();


                lblPartyGrade.Text = "-";
                if (dr["clmpty"].ToString().Trim() == "Consignor")
                {
                    lblPName.Text = dr["csgnnm"].ToString();
                    lblPAdd.Text = dr["csgnaddr"].ToString();
                    lblPPin.Text = dr["csgnpincode"].ToString();
                    lblPPhone.Text = dr["csgnteleno"].ToString();

                }
                if (dr["clmpty"].ToString().Trim() == "Consignee")
                {
                    lblPName.Text = dr["csgenm"].ToString();
                    lblPAdd.Text = dr["csgeaddr"].ToString();
                    lblPPin.Text = dr["csgepincode"].ToString();
                    lblPPhone.Text = dr["csgeteleno"].ToString();
                }


                string Claimstr = "";
                if (dr["NONDELY"].ToString() == "Y")
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
                if (dr["Short"].ToString() == "Y")
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
                if (dr["Damg"].ToString() == "Y")
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
                if (dr["Leakg"].ToString() == "Y")
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
                if (dr["Pilfer"].ToString() == "Y")
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
                if (dr["Other"].ToString() == "Y")
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


                lblCAmt.Text = dr["CLMAMt"].ToString();

                txtCName.Text = dr["CUSTSRYRNM"].ToString();
                txtCValue.Text = dr["CUSTSRYRAMT"].ToString();

                txtSName.Text = dr["LOCSRYRNM"].ToString();
                txtSValue.Text = dr["LOCSRYRAMT"].ToString();

                txtEName.Text = dr["LOCEMPNM"].ToString();
                txtEValue.Text = dr["LOCEMPCLMAMT"].ToString();

                txtCoName.Text = dr["INSUCONM"].ToString();
                txtPolNo.Text = dr["INSUPL"].ToString();


                txtMBusiness.Text = dr["mnthbus"].ToString();
                txtBooking.Text = dr["BKGBUS"].ToString();
                txtDelivery.Text = dr["DELYBUS"].ToString();
                txtNBusiness.Text = dr["natbus"].ToString();


                lblPDesc.Text = dr["proddesc"].ToString();

               // lblBooke.Text = dr["orgn_nm"].ToString();

                lblFAmt.Text = dr["tot_frtamt"].ToString();
                lblVGoods.Text = dr["DECVAL"].ToString();
                // lblLDLoc.Text

                lblIFrom.Text = dr["IncomingFrom"].ToString();



                lblTcNo.Text = dr["mf"].ToString();
                lblThcNo.Text = dr["thc"].ToString();
                //lblThcD.Text = dr["thcdate"].ToString();
                lblVehicleNo.Text = dr["vehno"].ToString();
                //   lblRMarket.Text=dr["vehno"].ToString();
                lblRCName.Text = dr["route"].ToString();
             
                lblLetter.Visible=true;
                   lblPOD.Visible=true;
                   lblCopy.Visible=true;
                   lblFIR.Visible=true;
                   lblReport.Visible=true;
                   lblPhoto.Visible=true;
                   lblTC.Visible=true;
                   if (dr["BRATTPCL_FILENAME"].ToString() != "")
                   {
                       lblLetter.Text = "YES";
                   }
                   else
                   {
                       lblLetter.Text = "NO";

                   }

                   if (dr["BRATTPIC_FILENAME"].ToString() != "")
                {
                    lblCopy.Text = "YES";
                }
                else
                {
                    lblCopy.Text = "NO";

                }


                if (dr["BRATTPOD_FILENAME"].ToString() != "")
                {
                    lblPOD.Text = "YES";
                }
                else
                {
                    lblPOD.Text = "NO";

                }

                if (dr["BRATTTCTHC_FILENAME"].ToString() != "")
                {
                    lblTC.Text = "YES";
                }
                else
                {
                    lblTC.Text = "NO";

                }

                if (dr["BRATTFIR_FILENAME"].ToString() != "")
                {
                    lblFIR.Text = "YES";
                }
                else
                {
                    lblFIR.Text = "NO";

                }

                if (dr["BRATTSRPT_FILENAME"].ToString() != "")
                {
                    lblReport.Text = "YES";
                }
                else
                {
                    lblReport.Text = "NO";

                }

                if (dr["BRATTPHOTO_FILENAME"].ToString() != "")
                {
                    lblPhoto.Text = "YES";
                }
                else
                {
                    lblPhoto.Text = "NO";

                }
             

            }

        }

        dr.Close();
        conn.Close();








    }

}
