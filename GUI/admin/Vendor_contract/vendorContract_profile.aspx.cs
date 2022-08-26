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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Admin_Vendor_contract_vendorContract_profile : System.Web.UI.Page
{
    public static string VendorCode, ContractID, Flag, vendnm = "", vendtyp, ContID, vendcd, TDSAPP;
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {
            Flag = Request.QueryString.Get("Flag");
            //Response.Write("<br> Flag : " + Flag);

            if (Flag == "Y")
            {


                ContractID = Request.QueryString.Get("VendorEdit");
                RetriveData();
            }
            else
            {
                VendorCode = Request.QueryString.Get("VendorADD");

                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                txtContractDt.Text = strrightnow;
                txtEffectDt.Text = strrightnow;
                txtValidDt.Text = strrightnow;
                txtContractloccode.Text = Session["brcd"].ToString().Trim();

                String SQL_Vendor = "Select vendorCode,vendorName,vencd=(vendorCode+' : '+vendorName),vendor_type as typ,vendor_type=(select top 1 codedesc from webx_master_general where codetype='vendty' and codeid=vendor_type)   from webx_vendor_hdr where vendorcode='" + VendorCode + "' ";

                SqlDataReader dreader;

                SqlCommand cmd = new SqlCommand(SQL_Vendor, conn);
                dreader = cmd.ExecuteReader();

                while (dreader.Read())
                {
                    vendor.Text = dreader["vencd"].ToString();
                    vendnm = dreader["vendorName"].ToString();
                    vendtyp = dreader["typ"].ToString();
                    vendcd = dreader["vendorCode"].ToString();
                    vendortype.Text = Convert.ToString(dreader["vendor_type"]);


                }

                dreader.Close();
            }
                String SQL_Service = "select  codedesc,codeid  from webx_master_general where  codetype='trn' order by codeid";

                SqlDataReader dreader1;

                SqlCommand cmd12 = new SqlCommand(SQL_Service, conn);
                dreader1 = cmd12.ExecuteReader();

                while (dreader1.Read())
                {
                    String ABC = dreader1["codeid"].ToString();

                    if (ABC == "1")
                    {
                        lblAir.Text = dreader1["codedesc"].ToString();
                    }
                    if (ABC == "2")
                    {
                        lblRoad.Text = dreader1["codedesc"].ToString();
                    }

                    if (ABC == "3")
                    {
                        lblTrain.Text = dreader1["codedesc"].ToString();
                    }

                    if (ABC == "4")
                    {
                        lblEXp.Text = dreader1["codedesc"].ToString();
                    }


                }
                dreader1.Close();

                String sql_loc = "Select loccode from webx_location where ActiveFlag='Y'";

                SqlDataReader dreader2;

                cmd12 = new SqlCommand(sql_loc, conn);
                dreader2 = cmd12.ExecuteReader();
                String wstr = "";

                while (dreader2.Read())
                {

                    if (wstr == "")
                        wstr = dreader2["loccode"].ToString();
                    else
                        wstr = wstr + "," + dreader2["loccode"].ToString();

                }


           
        }

        //onblur="this.value=this.value.toUpperCase();"
        txtSecDepAmt.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtMonPhChrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtTdsRate.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtVendorPin.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtVendorAdd.Attributes.Add("onblur", "this.value=this.value.toUpperCase();");
        btnShow.Attributes.Add("onclick", "javascript:return Submitdata(" + txtContractDt.ClientID + "," + txtContractloccode.ClientID + "," + txtValidDt.ClientID + "," + txtVendorPerName.ClientID + "," + txtEffectDt.ClientID + "," + cboVendorCategory.ClientID + "," + cboVendorContractCat.ClientID + "," + txtVendorPin.ClientID + "," + txtSecDepDt.ClientID + "," + txtPayLoccode.ClientID + "," + chkRoad.ClientID + "," + chkAir.ClientID + "," + chkRail.ClientID + "," + chkExpress.ClientID + "," + btnShow.ClientID + ")");
      //btnShow.Attributes.Add("onclick", "javascript:return Submitdata(" + txtContractDt.ClientID + "," + txtContractloccode.ClientID + "," + txtValidDt.ClientID + "," + btnShow.ClientID + ")");

        conn.Close();
        
    }


    private void RetriveData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        String SQL_EDIT = "select CONTRACTCD,vendorCode,vendorName,vencd=(vendorCode+' : '+vendorName),vendor_type as typ,vendor_type=(select top 1 codedesc from webx_master_general where codetype='vendty' and  codeid=vendor_type),contdt=convert(varchar,contractdt,103),contract_loccode,vaildt=convert(varchar,valid_uptodt,103),exp_dt=convert(varchar,Start_dt,103),vendorpername,vendorperdesg,vendorwitness,compempname,compempdesg,compwitness,vendorcity,vendorpin,vendorcategory,vendorcontractCat,tdsrate,noofcheques,secdepdt=convert(varchar,secdepdt,103),transtype,secdepAmt,payloccode,payinterval,monphchrg,serroad,serair,serrail,vendoradd,serexpress ,tdsappl_yn from webx_vendor_contract_summary where CONTRACTCD='" + ContractID + "'";

        SqlCommand cmd1 = new SqlCommand(SQL_EDIT, cn);
        SqlDataReader dr = cmd1.ExecuteReader();

        while (dr.Read())
        {
            lblConrtaID.Text = Convert.ToString(dr["CONTRACTCD"]);

            vendor.Text = dr["vencd"].ToString();
            vendnm = dr["vendorName"].ToString();
            vendtyp = dr["typ"].ToString();
            vendcd = dr["vendorCode"].ToString();
            vendortype.Text = Convert.ToString(dr["vendor_type"]);
            txtContractDt.Text = dr["contdt"].ToString();
            txtContractloccode.Text = dr["contract_loccode"].ToString();
            txtValidDt.Text = dr["vaildt"].ToString();
            txtEffectDt.Text = dr["exp_dt"].ToString();
            txtVendorPerName.Text = dr["vendorpername"].ToString();
            txtVendorPerDesg.Text= dr["vendorperdesg"].ToString();
            txtVendorWitness.Text = dr["vendorwitness"].ToString();

            txtCompEmpName.Text = dr["compempname"].ToString();
            txtCompEmpDesg.Text = dr["compempdesg"].ToString();
            txtCompWitness.Text = dr["compwitness"].ToString();
            txtVendorCity.Text = dr["vendorcity"].ToString();
            txtVendorPin.Text = dr["vendorpin"].ToString();
            cboVendorCategory.SelectedValue=dr["vendorcategory"].ToString();
            cboVendorContractCat.SelectedValue=dr["vendorcontractCat"].ToString();
            txtTdsRate.Text= dr["tdsrate"].ToString();
            txtNoOfCheques.Text= dr["noofcheques"].ToString();
            txtSecDepDt.Text= dr["secdepdt"].ToString();
            txtSecDepAmt.Text= dr["secdepAmt"].ToString();
            cboTransType.SelectedValue= dr["transtype"].ToString();
            cboPayInterval.SelectedValue= dr["payinterval"].ToString();
            txtPayLoccode.Text= dr["payloccode"].ToString();
            txtVendorAdd.Text=dr["vendoradd"].ToString();
            txtMonPhChrg.Text=dr["monphchrg"].ToString();
            //txtVendorAdd.Text

            String lbroad,ldair,lbrail,lbexp,tdsappl;

            lbroad=dr["serroad"].ToString();
            ldair=dr["serair"].ToString();
            lbrail=dr["serrail"].ToString();
            lbexp=dr["serexpress"].ToString();
            tdsappl = dr["tdsappl_yn"].ToString();

            if (tdsappl == "Y")
            {
               TDSChk.Checked = true;
               txtTDS.Text = "Yes";
            }
            else
            {
                TDSChk.Checked = false;
                txtTDS.Text = "No";
            }
            

            if (lbroad == "Y")
            {
                chkRoad.Checked = true;
            }
            else
            {
                chkRoad.Checked = false;
            }

            if (ldair == "Y")
            {
                chkAir.Checked = true;
            }
            else
            {
                chkAir.Checked = false;
            }

            if (lbrail == "Y")
            {
                chkRail.Checked = true;
            }
            else
            {
                chkRail.Checked = false;
            }

            if (lbexp == "Y")
            {
                chkExpress.Checked = true;
            }
            else
            {
                chkExpress.Checked = false;
            }
           
           
        }



        cn.Close();
    }
    
    protected void TDSChk_CheckedChanged(object sender, EventArgs e)
    {
        if (TDSChk.Checked == true)
        {
            txtTDS.Text = "Yes";
            TDSAPP = "Y";
        }
        else
        {
            txtTDS.Text = "No";
            TDSAPP = "N";
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql;
        if (Flag == "Y")
        {


            sql = "webx_vendor_contract_summary_updateData_Net";
           ContID = ContractID;
        }
        else
        {
             sql = "Webx_vendor_contract_summary_insertData";

            String SQL_ContID = "exec usp_get_next_Contract_code 'VC'";
            SqlCommand validate = new SqlCommand(SQL_ContID, conn);

             ContID =Convert.ToString(validate.ExecuteScalar());
        }

        
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        
        // da = new SqlDataAdapter(sqlcmd);
        String dtFrom = "";
        String Vendorname = vendnm;
        //String Vendortype = vendtyp;

        String txtRoad, txtAir, txtRail, txtExp;
        int nochq;


        if (txtNoOfCheques.Text == "")
        {
            nochq = 0;
        }
        else
        {
            nochq = Convert.ToInt32(txtNoOfCheques.Text);
        }

        if (TDSChk.Checked == true)
        {
           
            TDSAPP = "Y";
        }
        else
        {
           
            TDSAPP = "N";
        }

        if(chkAir.Checked==true)
        {
            txtAir = "Y";
        }
        else
        {
            txtAir = "N";
        }

        if( chkRoad.Checked==true)
        {
            txtRoad = "Y";
        }
        else
        {
            txtRoad = "N";
        }

         if(chkRail.Checked==true)
        {
            txtRail = "Y";
        }
        else
        {
            txtRail = "N";
        }

         if( chkExpress.Checked==true)
        {
            txtExp = "Y";
        }
        else
        {
            txtExp = "N";
        }

        sqlcmd.Parameters.AddWithValue("@VendorCode_1",vendcd.Trim());
        
       // sqlCommand.Parameters.AddWithValue("@Fromdt", strArrDtFromTo[0]));
        sqlcmd.Parameters.AddWithValue("@VendorName_2",Vendorname.Trim());
        sqlcmd.Parameters.AddWithValue("@Vendor_Type_3",vendtyp);
        sqlcmd.Parameters.AddWithValue("@CONTRACTCD_4",ContID.Trim());
        sqlcmd.Parameters.AddWithValue("@ContractDt_5",Mydate1(txtContractDt.Text.Trim()));
        sqlcmd.Parameters.AddWithValue("@Contract_loccode_6",txtContractloccode.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@Valid_uptodt_7", Mydate1(txtValidDt.Text.Trim()));
        sqlcmd.Parameters.AddWithValue("@Start_Dt_8", Mydate1(txtEffectDt.Text.Trim()));
        sqlcmd.Parameters.AddWithValue("@VendorPerName_9",txtVendorPerName.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorPerDesg_10",txtVendorPerDesg.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorWitness_11",txtVendorWitness.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@CompEmpName_12",txtCompEmpName.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@CompEmpDesg_13",txtCompEmpDesg.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@CompWitness_14",txtCompWitness.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorCity_15",txtVendorCity.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorPin_16",txtVendorPin.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorCategory_17",cboVendorCategory.SelectedValue.ToString());
        sqlcmd.Parameters.AddWithValue("@VendorContractCat_18",cboVendorContractCat.SelectedValue.ToString());
        sqlcmd.Parameters.AddWithValue("@Tdsappl_yn_19",TDSAPP.Trim());

        sqlcmd.Parameters.AddWithValue("@EntryBy_20",dtFrom.Trim());
        sqlcmd.Parameters.AddWithValue("@TdsRate_22",txtTdsRate.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@NoOfCheques_23", nochq);
        sqlcmd.Parameters.AddWithValue("@SecDepDt_24",Mydate1(txtSecDepDt.Text.Trim()));
        sqlcmd.Parameters.AddWithValue("@TransType_25",cboTransType.SelectedValue.ToString());
        sqlcmd.Parameters.AddWithValue("@SecDepAmt_26",txtSecDepAmt.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@PayLoccode_27",txtPayLoccode.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@PayInterval_28",cboPayInterval.SelectedValue.ToString());
        sqlcmd.Parameters.AddWithValue("@MonPhChrg_29",txtMonPhChrg.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@SerRoad_30",txtRoad.Trim());
        sqlcmd.Parameters.AddWithValue("@SerAir_31", txtAir.Trim()); 
        sqlcmd.Parameters.AddWithValue("@SerRail_32",txtRail.Trim());
        sqlcmd.Parameters.AddWithValue("@VendorAdd_33", txtVendorAdd.Text.Trim());
        sqlcmd.Parameters.AddWithValue("@SerExpress",txtExp.Trim());

        sqlcmd.ExecuteNonQuery();

        


        string final;
        final = "?ContID=" + ContID;
        final += "&Flag=" + Flag;

        Response.Redirect("vendorContract_step2.aspx" + final);
        //cn.Close();

    }
    public string Mydate1(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);

            string tempDate = "";
            int tempMonth, tempYear;
            tempMonth = 0;
            tempYear = 0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }

            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + System.Convert.ToString(tempYear);
            return fdt;
        }

    }

    public string MonthName(int month)
    {
        switch (month)
        {
            case 1: return ("Jan");
            case 2: return ("Feb");
            case 3: return ("Mar");
            case 4: return ("Apr");
            case 5: return ("May");
            case 6: return ("Jun");
            case 7: return ("Jul");
            case 8: return ("Aug");
            case 9: return ("Sep");
            case 10: return ("Oct");
            case 11: return ("Nov");
            case 12: return ("Dec");
            default: return ("Illegal month");
        }
    }

    
   
    
}
