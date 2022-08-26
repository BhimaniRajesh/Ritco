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

public partial class GUI_admin_VehicleMaster_VehicleMasterAdd : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strToday;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        getstring();
        getallvehno();

        if (!IsPostBack)
        {
            strToday = System.DateTime.Today.ToString("dd/MM/yyyy");
            //ddVehicleType.Items.Add("--Select--");
            ddVndrNm.Items.Add(new ListItem("--Select--", ""));


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
            ddVehicleType.Items.Insert(0, new ListItem("--Select--", ""));


            SqlCommand cmdlstPermit = new SqlCommand("select CodeId,CodeDesc from webx_MAster_General where CodeType = 'PermitType'", cn);
            SqlDataAdapter dalstPermit = new SqlDataAdapter(cmdlstPermit);
            DataSet dslstPermit = new DataSet();
            dalstPermit.Fill(dslstPermit);
            //if (dslstPermit.Tables[0].Rows.Count > 0)
            //{
            ddlPermitType.DataSource = dslstPermit;
            ddlPermitType.DataTextField = "CodeDesc";
            ddlPermitType.DataValueField = "CodeId";
            ddlPermitType.DataBind();
            //}
            ddlPermitType.Items.Insert(0, new ListItem("--Select--", "A"));

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

        }
        string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00_MyCPH1_txtPayload\").disabled = true;document.getElementById(\"ctl00_MyCPH1_txtCapacity\").disabled = true</script>";

        //string js1 = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00_MyCPH1_txtCapacity\").disabled = true</script>";
        Page.RegisterStartupScript("abc", js);
        //Page.RegisterStartupScript("xyz", js1);
        btnSubmit.Attributes.Add("onclick", "javascript:return vehiclecheckonsubmit('ctl00_MyCPH1_txtVehicleNo'),Chk(" + ddVehicleType.ClientID + "," + txtVehicleNo.ClientID + "," + ddVndrNm.ClientID + "," + ddlPermitType.ClientID + "," + lstRut.ClientID + "," + txtVhclInsuranceDt.ClientID + "," + txtFitnessDt.ClientID + "," + txtManufacturerDt.ClientID + "," + txtNationalPermitDt.ClientID + "," + txt5YearPermitDt.ClientID + "," + txtRoadTaxDt.ClientID + "," + txtFuelEfficiencyDt.ClientID + "," + ddlBodyType.ClientID + "," + txtCNoPolicyNoDt.ClientID + "," + btnSubmit.ClientID + ")");

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
        //select top 1 '-- Select --' as a,'-- Select --' as b from webx_master_general union select codeid as a,codedesc as b from webx_master_general where codetype='VENDTY'

        SqlCommand cmd = new SqlCommand(sqldd, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cmbvendortype.DataSource = ds;
        cmbvendortype.DataTextField = "a";
        cmbvendortype.DataValueField = "b";
        cmbvendortype.DataBind();

    }

    private void getallvehno()
    {
        string sql = "SELECT vehno FROM webx_VEHICLE_HDR";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("vehno", "'" + Convert.ToString(dr_Location["vehno"] + "'"));
        }
        dr_Location.Close();
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
        //DateTime FitnessDate = Convert.ToDateTime(txtFitnessDt.Text);
        //DateTime SysDate = System.DateTime.Now.ToShortDateString("dd/MM/yyyy");
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
        //    else
        //    {
        string a;
        int j = 1;
        a = "";
        for (int i = 1; i < lstRut.Items.Count; i++)
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
        b = ddlPermitType.SelectedValue.ToString();
        //int k = 1;
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


        //fdate = DateTime.Today.ToString("dd/MM/yyyy");
        //str = fdate.Split('/');
        //string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        //date = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];


        //cn.Open();
        string vtype = "";
        if (cmbvendortype.Text == "-- Select --")
        {
            vtype = "";
        }
        else
        {
            vtype = cmbvendortype.Text;
        }
        //added by vidya on 23 May 2014

        int no_tyre_Axel = 0;
        if (txtNoTyres.Text != "")
        {
            no_tyre_Axel = Convert.ToInt16(txtNoTyres.Text);
        }
        //string sqlAdd = "insert into webx_VEHICLE_HDR(vehicle_type,VEHNO,Tyre_Attached,VENDORCODE,VENDORTYPE,VEHPERMIT,VEHROUTECD,VEHRCBKNO," +
        //               "VEHREGNO,VEHREGDT,VEHCHASISNO,VEHENGINENO,Insurance_Validity_Date,Fitness_Validity_Date,ACTIVEFLAG," +
        //               "UPDTBY,UPDTON,Conrtl_branch,Drivers,length,width,Height,GVW,Unld_Wt,Payload ,capacity,ManufacturerDt," +
        //                "NationalPermitDt,  RoadTaxDt, FuelEfficiencyDt,  BodyTypeDt,  CNoPolicyNoDt, FiveYearPermitDt,FuelEfficiancy,PolicyNo," +
        //                "RegisteredState,RegisteredRTO,HorseType,EngineType,invoiceno,ManufacturerName,InsuranceName)values(" +
        //               "'" + Convert.ToInt32(ddVehicleType.Text.Replace("'", "''")) + "','" + txtVehicleNo.Text.Replace("'", "''") + "','" + no_tyre_Axel + "','" + ddVndrNm.Text + "','" + vtype + "'," +
        //               "'" + txtRgnNo.Text.Replace("'", "''") + "','" + txtRgnDt.Text.Replace("'", "''") + "','" + ddlPermitType.SelectedValue.ToString() + "','" + a + "'," +
        //               "'" + txtRcBookNo.Text.Replace("'", "''") + "','"+txtRegisteredState.Text+"',"+
        //               "'"+txtRegisteredRTO.Text+"','"+ddlHorseType.SelectedValue.ToString()+"','"+ddlEngineType.SelectedValue.ToString()+"',"+
        //               "'"+txtInvoiceNo.Text+"','"+txtManufacturerName.Text+"','"+txtInsuranceName.Text +"'   ";

        string sqlAdd = "insert into webx_VEHICLE_HDR(vehicle_type,VEHNO,Tyre_Attached,VENDORCODE,VENDORTYPE,VEHPERMIT,VEHROUTECD,VEHRCBKNO," +
                      "VEHREGNO,VEHREGDT,VEHCHASISNO,VEHENGINENO,Insurance_Validity_Date,Fitness_Validity_Date,ACTIVEFLAG," +
                      "UPDTBY,UPDTON,Conrtl_branch,Drivers,length,width,Height,GVW,Unld_Wt,Payload ,capacity,ManufacturerDt," +
                      "NationalPermitDt,  RoadTaxDt, FuelEfficiencyDt,  BodyType,  CNoPolicyNoDt, FiveYearPermitDt,FuelEfficiancy," +
                      "RegisteredState,RegisteredRTO,HorseType,EngineType,invoiceno,ManufacturerName,InsuranceName,PolicyNo,FuelEconomy,attachdt,IsPrivateVehicle)values(" +
                      "'" + Convert.ToInt32(ddVehicleType.Text.Replace("'", "''")) + "','" + txtVehicleNo.Text.Replace("'", "''") + "','" + no_tyre_Axel + "','" + ddVndrNm.Text + "','" + vtype + "'," +
                      "'" + ddlPermitType.SelectedValue.ToString() + "','" + a + "'," +
                      "'" + txtRcBookNo.Text.Replace("'", "''") + "','" + txtRgnNo.Text.Replace("'", "''") + "' ";


        //  "'" + txtRegisteredState.Text + "','" + txtRegisteredRTO.Text + "','" + ddlHorseType.SelectedItem.ToString() + "',
        //  '" + ddlEngineType.SelectedItem.ToString() + "','" + txtInvoiceNo.Text + "','" + txtManufacturerName.Text + "','" + txtInsuranceName.Text + "'," +



        if (txtRgnDt.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtRgnDt.Text.Replace("'", "''")) + "'";
        }

        sqlAdd += ",'" + txtChasisNo.Text.Replace("'", "''").Trim() + "','" + txtEngineNo.Text.Replace("'", "''") + "'";

        if (txtVhclInsuranceDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtVhclInsuranceDt.Text.Replace("'", "''")) + "'";
        }

        if (txtFitnessDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtFitnessDt.Text.Replace("'", "''")) + "'";
        }

        sqlAdd += ",'" + txtActFlag.Text.Replace("'", "''").Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToString("MM/dd/yyyy") + "'," +
                  "'" + txtCntrlBranch.Text.Replace("'", "''") + "'";

        if (txtDrivers.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtDrivers.Text.Replace("'", "''")) + "'";
        }

        if (txtLength.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtLength.Text.Replace("'", "''")) + "'";
        }

        if (txtWidth.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtWidth.Text.Replace("'", "''")) + "'";
        }

        if (txtHeight.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtHeight.Text.Replace("'", "''")) + "'";
        }

        if (txtGVW.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtGVW.Text.Replace("'", "''")) + "'";
        }

        if (txtUnladen.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtUnladen.Text.Replace("'", "''")) + "'";
        }

        if (hdnPayload.Value.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(hdnPayload.Value.Replace("'", "''")) + "'";
        }

        //if (txtRate.Text.Replace("'", "''").Trim() == "")
        //{
        //    sqlAdd += ",'0'";
        //}
        //else
        //{
        //    sqlAdd += ",'" + Convert.ToDecimal(txtRate.Text.Replace("'", "''")) + "'";
        //}

        if (hdnCapacity.Value.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(hdnCapacity.Value.Replace("'", "''")) + "'";
        }


        //********************************* START 1 ***********************************
        if (txtManufacturerDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtManufacturerDt.Text.Replace("'", "''")) + "'";
        }


        if (txtNationalPermitDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtNationalPermitDt.Text.Replace("'", "''")) + "'";
        }


        //********************************** END  1 **************************************

        //********************************* START 2 ***********************************
        if (txtRoadTaxDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtRoadTaxDt.Text.Replace("'", "''")) + "'";
        }


        if (txtFuelEfficiencyDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtFuelEfficiencyDt.Text.Replace("'", "''")) + "'";
        }
        if (ddlBodyType.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + ddlBodyType.SelectedItem.ToString() + "'";
        }

        //if (ddlBodyType.Text.Replace("'", "''").Trim() == "")
        //{
        //    sqlAdd += ",NULL";
        //}
        //else
        //{
        //    sqlAdd += ",'" + getDateInddMMMyyyFormat(ddlBodyType.Text.Replace("'", "''")) + "'";
        //}
        //********************************** END  2 **************************************

        //********************************* START 3 ***********************************
        if (txtCNoPolicyNoDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtCNoPolicyNoDt.Text.Replace("'", "''")) + "'";
        }

        if (txt5YearPermitDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txt5YearPermitDt.Text.Replace("'", "''")) + "'";
        }
        if (txtFuelEfficiencyLtr.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",'0'";
        }
        else
        {
            sqlAdd += ",'" + Convert.ToDecimal(txtFuelEfficiencyLtr.Text.Replace("'", "''")) + "'";
        }



        if (txtRegisteredState.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + txtRegisteredState.Text + "'";
        }
        if (txtRegisteredRTO.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + txtRegisteredRTO.Text + "'";
        }
        if (ddlHorseType.SelectedItem.ToString() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + ddlHorseType.SelectedItem.ToString() + "'";
        }

        if (ddlEngineType.SelectedItem.ToString() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + ddlEngineType.SelectedItem.ToString() + "'";
        }
        if (txtInvoiceNo.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + txtInvoiceNo.Text + "'";
        }
        if (txtManufacturerName.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + txtManufacturerName.Text + "'";
        }
        if (txtInsuranceName.Text.Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + txtInsuranceName.Text + "'";
        }
        sqlAdd += ",'" + txtCNoPolicyNo.Text.Replace("'", "''") + "'";
		
		sqlAdd += ",'" + (txtFuelEconommy.Text == "" ? "0" : txtFuelEconommy.Text).Replace("'", "''") + "'";

        
        if (txtAttachingDt.Text.Replace("'", "''").Trim() == "")
        {
            sqlAdd += ",NULL";
        }
        else
        {
            sqlAdd += ",'" + getDateInddMMMyyyFormat(txtAttachingDt.Text.Replace("'", "''")) + "'";
        }

        if (chkPrivateVehicle.Checked)
        {
            sqlAdd += ",'Y')";
        }
        else
        {
            sqlAdd += ",'N')";
        }

        //********************************** END  3 **************************************




        //,'" + Convert.ToInt32(txtLength.Text) + "'," +
        //          "'" + Convert.ToInt32(txtWidth.Text) + "','" + Convert.ToInt32(txtHeight.Text) + "','" + Convert.ToInt32(txtGVW.Text) + "','" + Convert.ToInt32(txtUnladen.Text) + "','" + Convert.ToInt32(txtPayload.Text) + "','" + Convert.ToInt32(txtRate.Text) + "')";
        //                string sqlAdd = "insert into webx_VEHICLE_HDR(vehicle_type,VEHNO,VENDORCODE,VEHTONS,VEHPERMIT,VEHROUTECD,VEHMADEBY,VEHMODEL,VEHRCBKNO," +
        //                "VEHREGNO,VEHREGDT,VEHCHASISNO,VEHENGINENO,Insurance_Validity_Date,Fitness_Validity_Date,ACTIVEFLAG," +
        //                "UPDTBY,UPDTON,Conrtl_branch,VEHT_CAT,Drivers,length,width,Height,GVW,Unld_Wt,Payload ,rate_km)values(" +
        //                "'" + Convert.ToInt32(ddVehicleType.Text) + "','" + txtVehicleNo.Text + "','" + ddVndrNm.Text + "'," +
        //                "'" + Convert.ToInt32(ddTonnage.SelectedValue) + "','" + b + "','" + a + "'," +
        //                "'" + txtMadeBy.Text + "','" + txtModel.Text + "','" + txtRcBookNo.Text + "','" + txtRgnNo.Text + "','" + Convert.ToDateTime(txtRgnDt.Text) + "'," +
        //                "'" + txtChasisNo.Text + "','" + txtEngineNo.Text + "','" + Convert.ToDateTime(txtVhclInsuranceDt.Text) + "','" + Convert.ToDateTime(txtFitnessDt.Text) + "'," +
        //                "'" + txtActFlag.Text + "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now + "'," +
        //                "'" + txtCntrlBranch.Text + "', '" + ddVhclCategory.SelectedValue + "','" + txtDrivers.Text + "','" + Convert.ToInt32(txtLength.Text) + "'," +
        //                "'" + Convert.ToInt32(txtWidth.Text) + "','" + Convert.ToInt32(txtHeight.Text) + "','" + Convert.ToInt32(txtGVW.Text) + "','" + Convert.ToInt32(txtUnladen.Text) + "','" + Convert.ToInt32(txtPayload.Text) + "','" + Convert.ToInt32(txtRate.Text) + "')";

        SqlCommand cmdAdd = new SqlCommand(sqlAdd, cn);
        cmdAdd.ExecuteNonQuery();
        cn.Close();
        //lblMsg.Text = "Record successfully inserted";
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
}
