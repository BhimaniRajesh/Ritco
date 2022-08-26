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

public partial class GUI_admin_VehicleMaster_VehicleMasterEdit : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strTVhclNo;
    public static string strDVhclNo;
    public static string strToday;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        strToday = System.DateTime.Today.ToString("dd/MM/yyyy");
        getstring();
        btnSubmit.Attributes.Add("onclick", "javascript:return Chk(" + ddVehicleType.ClientID + "," + ddVndrNm.ClientID + "," + ddlPermitType.ClientID + "," + lstRut.ClientID + "," + txtVhclInsuranceDt.ClientID + "," + txtFitnessDt.ClientID + "," + txtManufacturerDt.ClientID + "," + txtNationalPermitDt.ClientID + "," + txt5YearPermitDt.ClientID + "," + txtRoadTaxDt.ClientID + "," + txtFuelEfficiencyDt.ClientID + "," + ddlBodyType.ClientID + "," + txtCNoPolicyNoDt.ClientID + "," + btnSubmit.ClientID + ")");
        if (IsPostBack == false)
        {

            strTVhclNo = Session["ssTVhclNo"].ToString().Trim();
            strDVhclNo = Session["ssDVhclNo"].ToString().Trim();

            if (strTVhclNo != "")
            {
                lblVhclNo.Text = strTVhclNo;
            }
            else
            {
                lblVhclNo.Text = Convert.ToString(Session["vehno"]);//strDVhclNo; 
            }

            //ddVehicleType.Items.Add("--Select--");
            ddVndrNm.Items.Add("--Select--");


            SqlCommand cmdddVndrNm = new SqlCommand("select VENDORNAME,vendorcode from webx_VENDOR_HDR order by VENDORNAME", cn);
            SqlDataReader drddVndrNm = cmdddVndrNm.ExecuteReader();
            while (drddVndrNm.Read())
            {
                ddVndrNm.Items.Add(new ListItem(drddVndrNm.GetValue(0).ToString(), drddVndrNm.GetValue(1).ToString()));
            }
            drddVndrNm.Close();


            ddVehicleType.Items.Clear();
            string strSQL = "Select Type_Code, [Type_Name] AS VehicleType From webx_vehicle_type";
            SqlCommand cmdVhclType = new SqlCommand(strSQL, cn);
            SqlDataAdapter daVhclType = new SqlDataAdapter(cmdVhclType);
            DataSet dsVehicleType = new DataSet();
            daVhclType.Fill(dsVehicleType);
            //if (dsVehicleType.Tables[0].Rows.Count > 0)
            //{

            ddVehicleType.DataTextField = "VehicleType";
            ddVehicleType.DataValueField = "Type_Code";
            ddVehicleType.DataSource = dsVehicleType;
            ddVehicleType.DataBind();
            //}
            ddVehicleType.Items.Insert(0, new ListItem("--Select--", "-1"));


            //SqlCommand cmdlstPermit = new SqlCommand("select distinct STNM as StatePermit, STCD from webx_STATE order by STNM", cn);
            //SqlDataAdapter dalstPermit = new SqlDataAdapter(cmdlstPermit);
            //DataSet dslstPermit = new DataSet();
            //dalstPermit.Fill(dslstPermit);
            ////if (dslstPermit.Tables[0].Rows.Count > 0)
            ////{
            //ddlPermitType.DataSource = dslstPermit;
            //ddlPermitType.DataTextField = "StatePermit";
            //ddlPermitType.DataValueField = "STCD";
            //ddlPermitType.DataBind();
            ////}
            //ddlPermitType.Items.Insert(0, new ListItem("National Permit", "A"));

            SqlCommand cmdlstPermit = new SqlCommand("select CodeId,CodeDesc from webx_MAster_General where CodeType = 'PermitType'", cn);
            SqlDataAdapter dalstPermit = new SqlDataAdapter(cmdlstPermit);
            DataSet dslstPermit = new DataSet();
            dalstPermit.Fill(dslstPermit);

            ddlPermitType.DataSource = dslstPermit;
            ddlPermitType.DataTextField = "CodeDesc";
            ddlPermitType.DataValueField = "CodeId";
            ddlPermitType.DataBind();

            ddlPermitType.Items.Insert(0, new ListItem("National Permit", "A"));



            SqlCommand cmdlstBodyType = new SqlCommand("select CodeId,CodeDesc from webx_MAster_General where CodeType = 'BodyType'", cn);
            SqlDataAdapter dalstBodyType = new SqlDataAdapter(cmdlstBodyType);
            DataSet dslstBodyType = new DataSet();
            dalstBodyType.Fill(dslstBodyType);
            //if (dslstPermit.Tables[0].Rows.Count > 0)
            //{
            ddlBodyType.DataSource = dslstBodyType;
            ddlBodyType.DataTextField = "CodeDesc";
            ddlBodyType.DataValueField = "CodeId";
            ddlBodyType.DataBind();
            //}
            ddlBodyType.Items.Insert(0, new ListItem("--Select--", "A"));

            SqlCommand cmdlstHorseType = new SqlCommand("select CodeId,CodeDesc from webx_MAster_General where CodeType = 'HorseType'", cn);
            SqlDataAdapter dalstHorseType = new SqlDataAdapter(cmdlstHorseType);
            DataSet dslstHorseType = new DataSet();
            dalstHorseType.Fill(dslstHorseType);
            //if (dslstPermit.Tables[0].Rows.Count > 0)
            //{
            ddlHorseType.DataSource = dslstHorseType;
            ddlHorseType.DataTextField = "CodeDesc";
            ddlHorseType.DataValueField = "CodeId";
            ddlHorseType.DataBind();
            //}
            ddlHorseType.Items.Insert(0, new ListItem("--Select--", "A"));

            SqlCommand cmdlstEngineType = new SqlCommand("select CodeId,CodeDesc from webx_MAster_General where CodeType = 'EngineType'", cn);
            SqlDataAdapter dalstEngineType = new SqlDataAdapter(cmdlstEngineType);
            DataSet dslstEngineType = new DataSet();
            dalstEngineType.Fill(dslstEngineType);
            //if (dslstPermit.Tables[0].Rows.Count > 0)
            //{
            ddlEngineType.DataSource = dslstEngineType;
            ddlEngineType.DataTextField = "CodeDesc";
            ddlEngineType.DataValueField = "CodeId";
            ddlEngineType.DataBind();
            //}
            ddlEngineType.Items.Insert(0, new ListItem("--Select--", "A"));

            SqlCommand cmdlstRut = new SqlCommand("select distinct(RUTCD + ' : ' + RUTNM) as Rut,rutcd from webx_RUTMAS where RUTNM is not Null order by Rut,rutcd", cn);
            SqlDataAdapter dalstRut = new SqlDataAdapter(cmdlstRut);
            DataSet dslstRut = new DataSet();
            dalstRut.Fill(dslstRut);
            //if (dslstRut.Tables[0].Rows.Count > 0)
            //{
            lstRut.DataSource = dslstRut;
            lstRut.DataTextField = "Rut";
            lstRut.DataValueField = "Rutcd";
            lstRut.DataBind();
            //}
            popVentype();
            cn.Close();
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtFuelEfficiencyDt.Text = strrightnow;
            txtCNoPolicyNoDt.Text = strrightnow;
            getData();
        }
        string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00_MyCPH1_txtPayload\").disabled = true;document.getElementById(\"ctl00_MyCPH1_txtCapacity\").disabled = true</script>";
        Page.RegisterStartupScript("abc", js);
    }
    protected void popvendorname(object sender, EventArgs e)
    {

        ddVndrNm.Items.Clear();
        ddVndrNm.Items.Add(new ListItem("--Select--", ""));
        SqlCommand cmdddVndrNm;
        if (cmbvendortype.Text != "-- Select --")
        {
            cmdddVndrNm = new SqlCommand("select VENDORNAME,vendorcode from webx_VENDOR_HDR where vendor_type='" + cmbvendortype.Text + "' order by VENDORNAME", cn);
        }
        else
        {
            cmdddVndrNm = new SqlCommand("select VENDORNAME,vendorcode from webx_VENDOR_HDR order by VENDORNAME", cn);
        }
        SqlDataReader drddVndrNm = cmdddVndrNm.ExecuteReader();
        while (drddVndrNm.Read())
        {
            ddVndrNm.Items.Add(new ListItem(drddVndrNm.GetValue(0).ToString(), drddVndrNm.GetValue(1).ToString()));
        }
        drddVndrNm.Close();
    }
    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_VENDOR_type union select type_name + ' : ' + type_code as a, type_code as b from webx_VENDOR_type  where type_code in (2,3,5,8)";
        string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from  webx_master_general union select codedesc + ' : ' + codeid as a, codeid as b from  webx_master_general where codetype='VENDTY' and codeid in ('02','03','05','08')";
        SqlCommand cmd = new SqlCommand(sqldd, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cmbvendortype.DataSource = ds;
        cmbvendortype.DataTextField = "a";
        cmbvendortype.DataValueField = "b";
        cmbvendortype.DataBind();

    }
    private void getstring()
    {
        //holidaystr = "";
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }
    string state, route;
    public void getData()
    {
        string sql;
        cn.Open();
        if (strTVhclNo != "")
        {
            sql = "select IsPrivateVehicle,* from webx_VEHICLE_HDR where vehno='" + strTVhclNo + "'";
        }
        else
        {
            sql = "select IsPrivateVehicle,* from webx_VEHICLE_HDR where vehno='" + Convert.ToString(Session["vehno"]) + "'";
        }

        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            cmbvendortype.Text = Convert.ToString(dr["VENDORTYPE"]);
            ddVehicleType.Text = dr["vehicle_type"].ToString();
            ddVndrNm.Text = dr["VENDORCODE"].ToString();
            //ddTonnage.SelectedValue = dr["VEHTONS"].ToString();
            //lstPermitStates.Text = dr["VEHPERMIT"].ToString();
            state = Convert.ToString(dr["VEHPERMIT"]);
            route = Convert.ToString(dr["VEHROUTECD"]);
            Array a1, a2;
            a1 = state.Split(',');
            a2 = route.Split(',');
            //((string[])(str))[0] + " " + ((string[])(str))[2];
            //for (int i = 0; i < a1.Length; i++)
            //{
            //    String strelement = ((string[])(a1))[i];
            //    for (int j = 0; j < ddlPermitType.Items.Count; j++)
            //    {
            //        if (ddlPermitType.Items[j].Value.Trim() == strelement.Trim())
            //        {
            //            ddlPermitType.Items[j].Selected = true;
            //        }
            //    }
            //}
            ddlPermitType.Text= Convert.ToString(dr["VEHPERMIT"]);
            //ddVndrNm.Text = dr["VENDORCODE"].ToString();
            ddlHorseType.Text = Convert.ToString(dr["HorseType"]);
            ddlEngineType.Text = Convert.ToString(dr["EngineType"]);
            ddlBodyType.Text = Convert.ToString(dr["BodyType"]);

            txtInvoiceNo.Text= Convert.ToString(dr["invoiceno"]);
            txtRegisteredState.Text = Convert.ToString(dr["RegisteredState"]);
            txtRegisteredRTO.Text = Convert.ToString(dr["RegisteredRTO"]);
            txtManufacturerName.Text = Convert.ToString(dr["ManufacturerName"]);
            txtInsuranceName.Text = Convert.ToString(dr["InsuranceName"]);
            if (dr["FuelEconomy"] != null) {
                txtFuelEconommy.Text = Convert.ToString(dr["FuelEconomy"]);
            }

            

            //txtCapacity.Text= Convert.ToString(dr["capacity"]);

            for (int i = 0; i < a2.Length; i++)
            {
                String strelement = ((string[])(a2))[i];
                for (int j = 0; j < lstRut.Items.Count; j++)
                {
                    if (lstRut.Items[j].Value.Trim() == strelement.Trim())
                    {
                        lstRut.Items[j].Selected = true;
                    }
                }
            }
            //lstRut.Text = dr["VEHROUTECD"].ToString();
            //txtMadeBy.Text = dr["VEHMADEBY"].ToString();
            //txtModel.Text = dr["VEHMODEL"].ToString();
            txtRcBookNo.Text = dr["VEHRCBKNO"].ToString();
            txtRgnNo.Text = dr["VEHREGNO"].ToString();
            string vehregdt = dr["VEHREGDT"].ToString();
            txtRgnDt.Text = (vehregdt == "" || vehregdt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vehregdt).ToString("dd/MM/yyyy"));
            //dr["VEHREGDT"].ToString();
            txtChasisNo.Text = dr["VEHCHASISNO"].ToString();
            txtEngineNo.Text = dr["VEHENGINENO"].ToString();
            string vhclInsDt = dr["Insurance_Validity_Date"].ToString();
            txtVhclInsuranceDt.Text = (vhclInsDt == "" || vhclInsDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclInsDt).ToString("dd/MM/yyyy"));

            
            string vhAttachingDt = dr["attachdt"].ToString();
            txtAttachingDt.Text = (vhAttachingDt == "" || vhAttachingDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhAttachingDt).ToString("dd/MM/yyyy"));

            string vhclFitnessDt = dr["Fitness_Validity_Date"].ToString();
            txtFitnessDt.Text = (vhclFitnessDt == "" || vhclFitnessDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclFitnessDt).ToString("dd/MM/yyyy"));
            txtActFlag.Text = dr["ACTIVEFLAG"].ToString();


            //********************************** START 1 *************************************//

            string vhclManufacturerDt = dr["ManufacturerDt"].ToString();
            txtManufacturerDt.Text = (vhclManufacturerDt == "" || vhclManufacturerDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclManufacturerDt).ToString("dd/MM/yyyy"));

            string vhclNationalPermitDt = dr["NationalPermitDt"].ToString();
            txtNationalPermitDt.Text = (vhclNationalPermitDt == "" || vhclNationalPermitDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclNationalPermitDt).ToString("dd/MM/yyyy"));

            string vhclRoadTaxDt = dr["RoadTaxDt"].ToString();
            txtRoadTaxDt.Text = (vhclRoadTaxDt == "" || vhclRoadTaxDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclRoadTaxDt).ToString("dd/MM/yyyy"));

            //**********************************END 1 *************************************//

            //********************************** START 2 *************************************//

            string vhclFuelEfficiencyDt = dr["FuelEfficiencyDt"].ToString();
            txtFuelEfficiencyDt.Text = (vhclFuelEfficiencyDt == "" || vhclFuelEfficiencyDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclFuelEfficiencyDt).ToString("dd/MM/yyyy"));

          
            //string vhclBodyTypeDt = dr["BodyTypeDt"].ToString();
            //txtBodyTypeDt.Text = (vhclBodyTypeDt == "" || vhclBodyTypeDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclBodyTypeDt).ToString("dd/MM/yyyy"));

            string vhclCNoPolicyNoDt = dr["CNoPolicyNoDt"].ToString();
            txtCNoPolicyNoDt.Text = (vhclCNoPolicyNoDt == "" || vhclCNoPolicyNoDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclCNoPolicyNoDt).ToString("dd/MM/yyyy"));


            string vhclFiveYearPermitDt = dr["FiveYearPermitDt"].ToString();
            txt5YearPermitDt.Text = (vhclFiveYearPermitDt == "" || vhclFiveYearPermitDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclFiveYearPermitDt).ToString("dd/MM/yyyy"));

            //**********************************END 2 *************************************//




            txtCntrlBranch.Text = dr["Conrtl_branch"].ToString();
            //ddVhclCategory.Text = dr["VEHT_CAT"].ToString();
            txtDrivers.Text = dr["Drivers"].ToString();
            txtLength.Text = dr["length"].ToString();
            txtWidth.Text = dr["width"].ToString();
            txtHeight.Text = dr["Height"].ToString();
            txtGVW.Text = dr["GVW"].ToString();
            txtUnladen.Text = dr["Unld_Wt"].ToString();
            txtPayload.Text = dr["Payload"].ToString();
            hdnPayload.Value = dr["Payload"].ToString();
            // txtRate.Text = dr["rate_km"].ToString();
            if (txtActFlag.Text == "Y")
            {
                c1.Checked = true;
            }
            txtCapacity.Text = Convert.ToString(dr["capacity"]);
            hdnCapacity.Value = Convert.ToString(dr["capacity"]);

            if (dr["Tyre_Attached"] != "")
            {
                txtNoTyres.Text = Convert.ToString(dr["Tyre_Attached"]);
            }
            txtFuelEfficiencyLtr.Text = Convert.ToString(dr["FuelEfficiancy"]);
            txtCNoPolicyNo.Text = Convert.ToString(dr["PolicyNo"]);

            if (Convert.ToString(dr["IsPrivateVehicle"]) == "Y")
            {
                chkPrivateVehicle.Checked = true;
            }
            else {
                chkPrivateVehicle.Checked = false;
            }
        }
        dr.Close();
        cn.Close();
    }
    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (Convert.ToDateTime(txtFitnessDt.Text) < System.DateTime.Today)
        //{
        //    lblMsg.Text = "Please insert date after current date in Fitness Certificate Date";
        //    lblMsg.Focus();
        //}
        //else
        //    if (Convert.ToDateTime(txtVhclInsuranceDt.Text) < System.DateTime.Today)
        //    {
        //        lblMsg.Text = "Please insert date after current date in Vehicle Insurance Date";
        //        lblMsg.Focus();
        //    }
        //else
        //{
        string a;
        int j = 1;
        a = "";
        for (int i = 0; i < lstRut.Items.Count; i++)
        {
            if (lstRut.Items[i].Selected == true)
            {
                Array Ar;
                if (j == 1)
                {

                    Ar = lstRut.Items[i].Text.Split(':');
                    a = ((string[])(Ar))[0].Trim();
                    j += 1;
                }
                else
                {
                    j += 1;
                    Ar = lstRut.Items[i].Text.Split(':');

                    a = a + "," + ((string[])(Ar))[0].Trim();
                }
            }
        }

        string b = "";
        int k = 1;
        b = ddlPermitType.SelectedItem.ToString();
        //for (int l = 0; l < lstPermitStates.Items.Count; l++)
        //{
        //    if (lstPermitStates.Items[l].Selected == true)
        //    {

        //        if (k == 1)
        //        {
        //            //ar1 = lstPermitStates.Items[l].Text.Split(':');
        //            b = lstPermitStates.Items[l].Value;
        //            k += 1;
        //        }
        //        else
        //        {
        //            k += 1;
        //            //ar1 = lstPermitStates.Items[l].Text.Split(':');

        //            b = b + "," + lstPermitStates.Items[l].Value;
        //        }

        //    }
        //}
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        string vtype = "";
        if (cmbvendortype.Text == "-- Select --")
        {
            vtype = "";
        }
        else
        {
            vtype = cmbvendortype.Text;
        }
        string sqlAdd = "update webx_VEHICLE_HDR set vehicle_type = '" + Convert.ToInt32(ddVehicleType.Text) + "', VENDORCODE = '" + ddVndrNm.Text + "',VENDORTYPE='" + vtype + "'," +
                        "VEHPERMIT = '" + b + "',VEHROUTECD = '" + a + "'," +
                        "VEHRCBKNO = '" + txtRcBookNo.Text.Replace("'", "''") + "'," +
						"EntryBy = '" + Session["empcd"].ToString().Trim() + "',"+
                        "EntryDate = '" + System.DateTime.Now + "',"+
                        "VEHREGNO = '" + txtRgnNo.Text.Replace("'", "''") + "'";

        if (txtRgnDt.Text.Trim() == "")
        {
            sqlAdd += ",VEHREGDT = NULL";
        }
        else
        {
            sqlAdd += ",VEHREGDT = '" + getDateInddMMMyyyFormat(txtRgnDt.Text.Replace("'", "''")) + "'";
        }

        sqlAdd += ",VEHCHASISNO = '" + txtChasisNo.Text.Replace("'", "''").Trim() + "',VEHENGINENO = '" + txtEngineNo.Text.Replace("'", "''") + "'";

        if (txtVhclInsuranceDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Insurance_Validity_Date = NULL";
        }
        else
        {
            sqlAdd += ",Insurance_Validity_Date ='" + getDateInddMMMyyyFormat(txtVhclInsuranceDt.Text.Replace("'", "''")) + "'";
        }

        if (txtFitnessDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Fitness_Validity_Date = NULL";
        }
        else
        {
            sqlAdd += ",Fitness_Validity_Date ='" + getDateInddMMMyyyFormat(txtFitnessDt.Text.Replace("'", "''")) + "'";
        }

        sqlAdd += ",PolicyNo='" + txtCNoPolicyNo.Text.Replace("'", "''") + "',ACTIVEFLAG = '" + txtActFlag.Text.Replace("'", "''").Trim() + "',UPDTBY = '" + Session["empcd"].ToString().Trim() + "',UPDTON = '" + System.DateTime.Now + "',Conrtl_branch = '" + txtCntrlBranch.Text.Replace("'", "''") + "'";

        if (txtDrivers.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Drivers = '0'";
        }
        else
        {
            sqlAdd += ",Drivers = '" + Convert.ToDecimal(txtDrivers.Text.Replace("'", "''")) + "'";
        }

        if (txtLength.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",length = '0'";
        }
        else
        {
            sqlAdd += ",length = '" + Convert.ToDecimal(txtLength.Text.Replace("'", "''")) + "'";
        }

        if (txtWidth.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",width = '0'";
        }
        else
        {
            sqlAdd += ",width = '" + Convert.ToDecimal(txtWidth.Text.Replace("'", "''")) + "'";
        }

        if (txtHeight.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Height = '0'";
        }
        else
        {
            sqlAdd += ",Height = '" + Convert.ToDecimal(txtHeight.Text.Replace("'", "''")) + "'";
        }

        if (txtGVW.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",GVW = '0'";
        }
        else
        {
            sqlAdd += ",GVW = '" + Convert.ToDecimal(txtGVW.Text.Replace("'", "''")) + "'";
        }

        if (txtUnladen.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Unld_Wt = '0'";
        }
        else
        {
            sqlAdd += ",Unld_Wt = '" + Convert.ToDecimal(txtUnladen.Text.Replace("'", "''")) + "'";
        }

        if (hdnPayload.Value.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",Payload = '0'";
        }
        else
        {
            sqlAdd += ",Payload = '" + Convert.ToDecimal(hdnPayload.Value.Replace("'", "''")) + "'";
        }

        //if (txtRate.Text.Replace("'", "''").Trim() == "")
        //{
        //    sqlAdd += ",rate_km = '0'";
        //}
        //else
        //{
        //    sqlAdd += ",rate_km = '" + Convert.ToDecimal(txtRate.Text.Replace("'", "''")) + "'";
        //}

        if (hdnCapacity.Value.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",capacity = '0'";
        }
        else
        {
            sqlAdd += ",capacity = '" + Convert.ToDecimal(hdnCapacity.Value.Replace("'", "''")) + "'";
        }
        //added by vidya on 23 May 2014

        if (txtNoTyres.Text == "")
        {
            sqlAdd += ",Tyre_Attached = '0'";
        }
        else
        {
            sqlAdd += ",Tyre_Attached = '" + Convert.ToInt16(txtNoTyres.Text.Replace("'", "''")) + "'";
        }


        //*********************************************************************//

        //********************************* START 1 ***********************************
        if (txtManufacturerDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",ManufacturerDt = NULL";
        }
        else
        {
            sqlAdd += ",ManufacturerDt ='" + getDateInddMMMyyyFormat(txtManufacturerDt.Text.Replace("'", "''")) + "'";
        }



        if (txtNationalPermitDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NationalPermitDt = NULL";
        }
        else
        {
            sqlAdd += ",NationalPermitDt ='" + getDateInddMMMyyyFormat(txtNationalPermitDt.Text.Replace("'", "''")) + "'";
        }


        //********************************** END  1 **************************************

        ////********************************* START 2 ***********************************

        if (txtRoadTaxDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",RoadTaxDt = NULL";
        }
        else
        {
            sqlAdd += ",RoadTaxDt ='" + getDateInddMMMyyyFormat(txtRoadTaxDt.Text.Replace("'", "''")) + "'";
        }



        if (txtFuelEfficiencyDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",FuelEfficiencyDt = NULL";
        }
        else
        {
            sqlAdd += ",FuelEfficiencyDt ='" + getDateInddMMMyyyFormat(txtFuelEfficiencyDt.Text.Replace("'", "''")) + "'";
        }

        if (ddlBodyType.Text.Trim() == "")
        {
            sqlAdd += ",BodyType = NULL";
        }
        else
        {
            sqlAdd += ",BodyType = '" + ddlBodyType.SelectedItem.ToString() + "'";
        }

        //if (txtBodyTypeDt.Text.Replace("'", "''").Trim() == "")
        //{
        //    sqlAdd += ",BodyTypeDt = NULL";
        //}
        //else
        //{
        //    sqlAdd += ",BodyTypeDt ='" + getDateInddMMMyyyFormat(txtBodyTypeDt.Text.Replace("'", "''")) + "'";
        //}

        //********************************** END  2 **************************************

        //********************************* START 3 ***********************************

        if (txtCNoPolicyNoDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",CNoPolicyNoDt = NULL";
        }
        else
        {
            sqlAdd += ",CNoPolicyNoDt ='" + getDateInddMMMyyyFormat(txtCNoPolicyNoDt.Text.Replace("'", "''")) + "'";
        }


        if (txt5YearPermitDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",FiveYearPermitDt = NULL";
        }
        else
        {
            sqlAdd += ",FiveYearPermitDt ='" + getDateInddMMMyyyFormat(txt5YearPermitDt.Text.Replace("'", "''")) + "'";
        }
        if (txtFuelEfficiencyLtr.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",FuelEfficiancy='0'";
        }
        else
        {
            sqlAdd += ",FuelEfficiancy='" + Convert.ToDecimal(txtFuelEfficiencyLtr.Text.Replace("'", "''")) + "'";
        }
        //********************************** END  3 **************************************
        //*********************************************************************//

        if (txtRegisteredState.Text.Trim() == "")
        {
            sqlAdd += ",RegisteredState= NULL";
        }
        else
        {
            sqlAdd += ",RegisteredState='" + txtRegisteredState.Text + "'";
        }
        if (txtRegisteredRTO.Text.Trim() == "")
        {
            sqlAdd += ",RegisteredRTO = NULL";
        }
        else
        {
            sqlAdd += ",RegisteredRTO = '" + txtRegisteredRTO.Text + "'";
        }
        if (ddlHorseType.SelectedItem.ToString() == "")
        {
            sqlAdd += ",HorseType = NULL";
        }
        else
        {
            sqlAdd += ", HorseType = '" + ddlHorseType.SelectedItem.ToString() + "'";
        }

        if (ddlEngineType.SelectedItem.ToString() == "")
        {
            sqlAdd += ",EngineType=NULL";
        }
        else
        {
            sqlAdd += ",EngineType='" + ddlEngineType.SelectedItem.ToString() + "'";
        }
        if (txtInvoiceNo.Text.Trim() == "")
        {
            sqlAdd += ",invoiceno = NULL";
        }
        else
        {
            sqlAdd += ",invoiceno ='" + txtInvoiceNo.Text + "'";
        }
        if (txtManufacturerName.Text.Trim() == "")
        {
            sqlAdd += ",ManufacturerName = NULL";
        }
        else
        {
            sqlAdd += ",ManufacturerName = '" + txtManufacturerName.Text + "'";
        }
        if (txtInsuranceName.Text.Trim() == "")
        {
            sqlAdd += ",InsuranceName = NULL";
        }
        else
        {
            sqlAdd += ",InsuranceName = '" + txtInsuranceName.Text + "'";
        }
        if (txtFuelEconommy.Text == "")
        {
            sqlAdd += ",FuelEconomy = NULL";
        }
        else {
            sqlAdd += ",FuelEconomy = '" + txtFuelEconommy.Text + "'";
        }

        if (txtAttachingDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",attachdt = NULL";
        }
        else
        {
            sqlAdd += ",attachdt ='" + getDateInddMMMyyyFormat(txtAttachingDt.Text.Replace("'", "''")) + "'";
        }
        if (chkPrivateVehicle.Checked)
        {
            sqlAdd += ",IsPrivateVehicle = 'Y'";
        }
        else
        {
            sqlAdd += ",IsPrivateVehicle = 'N'";
        }

        

        sqlAdd += " where VEHNO = '" + lblVhclNo.Text + "'";

        //                "VEHT_CAT = '" + ddVhclCategory.SelectedValue + "',Drivers = '" + txtDrivers.Text + "',length = '" + Convert.ToInt32(txtLength.Text) + "'," +
        //                "width = '" + Convert.ToInt32(txtWidth.Text) + "',Height = '" + Convert.ToInt32(txtHeight.Text) + "',GVW = '" + Convert.ToInt32(txtGVW.Text) + "'," +
        //                "Unld_Wt = '" + Convert.ToInt32(txtUnladen.Text) + "',Payload = '" + Convert.ToInt32(txtPayload.Text) + "',rate_km = '" + Convert.ToInt32(txtRate.Text) + "' where VEHNO = '" + lblVhclNo.Text + "'";



        //string sqlAdd = "update webx_VEHICLE_HDR set vehicle_type = '" + Convert.ToInt32(ddVehicleType.Text) + "', VENDORCODE = '" + ddVndrNm.Text + "'," +
        //                "VEHTONS = '" + Convert.ToInt32(ddTonnage.SelectedValue) + "',VEHPERMIT = '" + b + "',VEHROUTECD = '" + a + "'," +
        //                "VEHMADEBY = '" + txtMadeBy.Text + "',VEHMODEL = '" + txtModel.Text + "',VEHRCBKNO = '" + txtRcBookNo.Text + "'," +
        //                "VEHREGNO = '" + txtRgnNo.Text + "',VEHREGDT = '" + Convert.ToDateTime(txtRgnDt.Text) + "',VEHCHASISNO = '" + txtChasisNo.Text + "'," +
        //                "VEHENGINENO = '" + txtEngineNo.Text + "',Insurance_Validity_Date = '" + Convert.ToDateTime(txtVhclInsuranceDt.Text) + "'," +
        //                "Fitness_Validity_Date = '" + Convert.ToDateTime(txtFitnessDt.Text) + "',ACTIVEFLAG = '" + txtActFlag.Text + "'," +
        //                "UPDTBY = '" + Session["empcd"].ToString().Trim() + "',UPDTON = '" + System.DateTime.Now + "',Conrtl_branch = '" + txtCntrlBranch.Text + "'," +
        //                "VEHT_CAT = '" + ddVhclCategory.SelectedValue + "',Drivers = '" + txtDrivers.Text + "',length = '" + Convert.ToInt32(txtLength.Text) + "'," +
        //                "width = '" + Convert.ToInt32(txtWidth.Text) + "',Height = '" + Convert.ToInt32(txtHeight.Text) + "',GVW = '" + Convert.ToInt32(txtGVW.Text) + "'," +
        //                "Unld_Wt = '" + Convert.ToInt32(txtUnladen.Text) + "',Payload = '" + Convert.ToInt32(txtPayload.Text) + "',rate_km = '" + Convert.ToInt32(txtRate.Text) + "' where VEHNO = '" + lblVhclNo.Text + "'";
        SqlCommand cmdAdd = new SqlCommand(sqlAdd, cn);
        cmdAdd.ExecuteNonQuery();
        cn.Close();
        //lblMsg.Text = "Record successfully updated";
        //lblMsg.Focus();
        //Response.Redirect("VehicleMasterEdSelect.aspx");
        Response.Redirect("VehicleMasterDonePage.aspx", false);
        //}
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddVehicleType.SelectedValue = "";
        ddVndrNm.SelectedValue = "";
        //ddTonnage.SelectedValue = "";
        ddlPermitType.SelectedValue = "";
        lstRut.Text = "";
        //txtMadeBy.Text = "";
        //txtModel.Text = "";
        txtRcBookNo.Text = "";
        txtRgnNo.Text = "";
        txtRgnDt.Text = "";
        txtChasisNo.Text = "";
        txtEngineNo.Text = "";
        txtVhclInsuranceDt.Text = "";
        txtFitnessDt.Text = "";
        txtActFlag.Text = "";
        txtCntrlBranch.Text = "";
        //ddVhclCategory.SelectedValue = "";
        txtDrivers.Text = "";
        txtLength.Text = "";
        txtWidth.Text = "";
        txtHeight.Text = "";
        txtGVW.Text = "";
        txtUnladen.Text = "";
        txtPayload.Text = "";
        //txtRate.Text = "";

    }
}

