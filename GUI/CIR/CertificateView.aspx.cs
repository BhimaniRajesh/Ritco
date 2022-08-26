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

public partial class GUI_CIR_CertificateView : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    SqlConnection conn;
    string strrightnow = ""; string mDoc = "", wDoc = "", mCIRNo = "";
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
        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");
        lblDate.Text = strrightnow.ToString();
        mDoc = Request.QueryString["DOCNo"];
        wDoc = Request.QueryString["id"];



        if (mDoc != "" && mDoc != null)
        {
            Inetialized();

        }
        if (wDoc != "" && wDoc != null)
        {

       //     btnCommit.Visible = false;
            //lblDate.ReadOnly = true;
            //lblconditions.ReadOnly = true;
            //txtAmtLoss.ReadOnly = true;
            //lblIssuedParty.ReadOnly = true;
            //txtDFacts.ReadOnly = true;
            Inetialized();
            Inetial();

        }


        if (!IsPostBack)
        {

            //Do Work
        }
    }



    
    public void Inetial()
    {


        conn.Open();
        string sql1 = "usp_getCOFDetails";
        SqlCommand sqlcmd1 = new SqlCommand(sql1, conn);
        sqlcmd1.CommandType = CommandType.StoredProcedure;

    

         sqlcmd1.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = wDoc;


        
        SqlDataReader dr1 = sqlcmd1.ExecuteReader();

        if (dr1.HasRows)
        {

            while (dr1.Read())
            {

                lblDate.Text = Convert.ToString(dr1["COFDT"]);

                lblconditions.Text = dr1["PKGS_COND"].ToString();
               txtAmtLoss.Text = dr1["AmtLoss"].ToString();

               txtDFacts.Text = dr1["COFREM"].ToString();

                lblDValue.Text  =dr1["DECVAL"].ToString();

                lblIssuedParty.Text=  dr1["COF_Inspty"].ToString();
            }
        }

        dr1.Close();
        conn.Close();


        








    }


    public void Inetialized()
    {





        conn.Open();
        string sql = "usp_CIRData_List1";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;


        if (mDoc != "" && mDoc != null)
        {
            sqlcmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = mDoc;
            //  sqlcmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = Session["DocketSf"];
        }
        if (wDoc != "" && wDoc != null)
        {

            sqlcmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = wDoc;


        }

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if (dr.HasRows)
        {

            while (dr.Read())
            {

                lblClaimParty.Text = dr["clmpty"].ToString();
                if (lblClaimParty.Text.ToString().Trim() == "Consignor")
                {
                    lblPName.Text = dr["csgnnm"].ToString();
                    lblCLPAdd.Text = dr["csgnaddr"].ToString();


                }
                if (lblClaimParty.Text.ToString().Trim() == "Consignee")
                {
                    lblPName.Text = dr["csgenm"].ToString();
                    lblCLPAdd.Text = dr["csgeaddr"].ToString();

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


                lblClaimBasis.Text = dr[""].ToString();



                //lblStnCode
                lblStnCode.Text = dr["CIRBR"].ToString() + ':' + dr["orgn_nm"].ToString();
                lblIssueOff.Text = dr["orgn_nm"].ToString();
              //  lblStnName.Text = dr["orgn_nm"].ToString();


                lblBKGStation1.Text = dr["CIRBR"].ToString() + ':' + dr["orgn_nm"].ToString();
               // lblBKGStation2.Text = dr["orgn_nm"].ToString();


                lblDelOff.Text = dr["reassign_destcd"].ToString() + ':' + dr["destn_nm"].ToString();

             //   lblDestStn.Text = dr["destn_nm"].ToString();

                lblPkgB.Text = dr["pkgsno"].ToString();
                lblPkgD.Text = dr["pkgsno"].ToString();

                mCIRNo = dr["CIRNO"].ToString();





                lblABW.Text = dr["ACTUWT"].ToString();

                lblDWt.Text = dr["ACTUWT"].ToString();

                lblDOn.Text = dr["Dely_date"].ToString();

                lblSaidtocontain.Text = dr["proddesc"].ToString();
             //   lblBookedAt.Text = dr["CIRBR"].ToString();

                lblDValue.Text = dr["DECVAL"].ToString();
                lblClaimBasis.Text = Claimstr.ToString().ToString().Trim();

                lblDocNote.Text = dr["DOCKNO"].ToString();
                lblDocDate.Text = dr["dockdt"].ToString();

                lblCompany.Text = Session["Client"].ToString();
                lblInvoice.Text = dr["INVNO"].ToString();
                //lblPDesc.Text = dr["proddesc"].ToString();

                //lblBookedAt.Text = dr["orgn_nm"].ToString();

                //lblFAmt.Text = dr["tot_frtamt"].ToString();
                //lblVGoods.Text = dr["DECVAL"].ToString();
                //// lblLDLoc.Text

                //lblIFrom.Text = dr["IncomingFrom"].ToString();



                //lblTcNo.Text = dr["mf"].ToString();
                //lblThcNo.Text = dr["thc"].ToString();
                //lblTHCDt.Text = dr["thcdate"].ToString();
                //lblVehicleNo.Text = dr["vehno"].ToString();
                ////   lblRMarket.Text=dr["vehno"].ToString();
                //lblRCName.Text = dr["route"].ToString();


            }

        }

        dr.Close();
        conn.Close();

    }

    protected void btnCommit_Click1(object sender, EventArgs e)
    {


        //conn.Open();
        //string sql = "usp_InsertCOFinfo";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;

        //DateTime dt1 = new DateTime();
        //DateTime dt2 = new DateTime();




        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";
        //// if (usercode == "")
        //{
        //    dt1 = Convert.ToDateTime(lblDate.Text, dtfi);
        //    // dt2 = Convert.ToDateTime(lblDOn.Text, dtfi);
        //}




        ////  sqlcmd.Parameters.Add("@COFNO", SqlDbType.VarChar).Value = Session["DocketNo"].ToString();
        //sqlcmd.Parameters.Add("@COFDT", SqlDbType.DateTime).Value = dt1;
        //sqlcmd.Parameters.Add("@COFBR", SqlDbType.VarChar).Value = Session["mainbrcd"].ToString();
        //sqlcmd.Parameters.Add("@COFAmt", SqlDbType.Decimal).Value = Convert.ToDecimal(txtAmtLoss.Text);

        ////   sqlcmd.Parameters.Add("@DelvOnDt", SqlDbType.DateTime).Value = dt2;
        //sqlcmd.Parameters.Add("@AmtLoss", SqlDbType.Decimal).Value = Convert.ToDecimal(txtAmtLoss.Text);
        //sqlcmd.Parameters.Add("@PKGS_COND", SqlDbType.VarChar).Value = lblconditions.Text;
        //sqlcmd.Parameters.Add("@COF_CUSTISSDT", SqlDbType.DateTime).Value = dt1;
        //sqlcmd.Parameters.Add("@DECVAL", SqlDbType.VarChar).Value = lblDValue.Text;
        //sqlcmd.Parameters.Add("@COFREM", SqlDbType.VarChar).Value = txtDFacts.Text;
        //sqlcmd.Parameters.Add("@COF_Inspty", SqlDbType.VarChar).Value = lblIssuedParty.Text;
        //sqlcmd.Parameters.Add("@CIRNO", SqlDbType.VarChar).Value = mCIRNo.ToString();

        //sqlcmd.ExecuteNonQuery();


       
    }
}
