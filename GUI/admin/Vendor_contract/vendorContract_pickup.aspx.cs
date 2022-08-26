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

public partial class GUI_Admin_Vendor_contract_vendorContract_pickup : System.Web.UI.Page
{
    int _lastEditedPage, srno, vehtype = 0, minval = 0, maxval = 0, a = 0, Rl = 0, Rla = 0, Rlb = 0, Rlc = 0,b=0;
    decimal slabfrom, Slabto, slabrate = 0, slabvalue = 0, chrgvalue=0;
    public static string vendorCode, ContID, Flag, docName, Chargetype,st_matrixcode, matrixcode, Matrixdesc, calmethod, calmethod1, kmrs, slabbasis = "Per Km.", chargebasis, Fixed_YN, Rate_YN, calbasoda, chrgbasis = "Per trip";
    public static string paybaspaid, paybastbb, paybastopay, Strpaybas, serRoad, serRail, serAir, serExpress;
    public int sno = 0;
    SqlConnection cn;
    public DataSet1 _dataSet = new DataSet1();
    protected void Page_Load(object sender, EventArgs e)
    {
        Flag = Request.QueryString.Get("Flag"); 
        vendorCode = Request.QueryString.Get("vendorCode");
        ContID = Request.QueryString.Get("ContID");
        st_matrixcode = Request.QueryString.Get("st_matrixcode");
         cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (ContID != "")
        {
            chrgbasis = "Per trip";
            slabbasis = "Rs. of freight";
            calbasoda = "Per Cnote";
            

            paybaspaid="P01";
		paybastbb="P02";
        paybastopay = "P03";
          
        }

        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {

             //select serRoad,serRail,serAir,serExpress from webx_vendor_contract_summary where CONTRACTCD='" & CONTRACTCD & "'


            String SQL_Step2 = "select serRoad,serRail,serAir,serExpress from webx_vendor_contract_summary where CONTRACTCD='" + ContID + "'";

            SqlCommand Step2 = new SqlCommand(SQL_Step2, cn);

            SqlDataReader dr = Step2.ExecuteReader();
            while (dr.Read())
            {
                serRoad = dr["serRoad"].ToString();
                serRail = dr["serRail"].ToString();

                serAir = dr["serAir"].ToString();
                serExpress = dr["serExpress"].ToString();
                
            }

            Inetialized();
            BindGrid();

            //Validation();
            intetilisedrows();
            roww.Text = "5";

            
            //txtmaxchrgoda.Text = "0.00";
            //txtminchrgoda.Text = "0.00";
            //txtvarperoda.Text = "0.00";
            txtmaxchrg.Text = "0.00";
            txtminchrg.Text = "0.00";

            if (Flag == "Y")
            {
                kmrs = "KM";
                RetriveData();
            }


            //txtmaxchrgoda.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtminchrgoda.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtvarperoda.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtmaxchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtminchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }


        cn.Close();

    }
    private void RetriveData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //String sql_insertDetails;

        String sql_edit = "select slabfrom,slabto from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and  chargetype='Fixed'";
        SqlCommand cmd3 = new SqlCommand(sql_edit, cn);
        SqlDataReader dr = cmd3.ExecuteReader();
        //String mcode = "";
        while (dr.Read())
        {
            //txtaddwtchrg.Text = dr["otherchrg"].ToString();
            // mcode = dr["matrixcode"].ToString();
           // cboapptrans.SelectedValue = dr["docname"].ToString();
            txtminchrg.Text = dr["slabfrom"].ToString();
            txtmaxchrg.Text = dr["slabto"].ToString();
        }
        dr.Close();


        if (serRoad == "Y")
        {
            String sql_edit2 = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "' and calmethod='2' order by chargeid";
            SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
            SqlDataReader dr2 = cmd32.ExecuteReader();

            string Slab_Rate = "", slab_from = "", slab_to = "", pay_bas = "";

            String abcd1 = "", abcd2 = "";
            while (dr2.Read())
            {
                String Temp1 = dr2["slabfrom"].ToString();
                String Temp2 = dr2["slabto"].ToString();

                if (Temp1 != abcd1 && Temp2 != abcd2)
                {
                    if (slab_from == "" && slab_to == "")
                    {
                        // ROute_cd = Convert.ToString(dr2["routecd"]);
                        slab_from = Convert.ToString(dr2["slabfrom"]);
                        slab_to = Convert.ToString(dr2["slabto"]);
                    }
                    else
                    {
                        //ROute_cd = ROute_cd + "~" + Convert.ToString(dr2["routecd"]);
                        slab_from = slab_from + "~" + Convert.ToString(dr2["slabfrom"]);
                        slab_to = slab_to + "~" + Convert.ToString(dr2["slabto"]);
                    }

                    abcd1 = dr2["slabfrom"].ToString();
                    abcd2 = dr2["slabto"].ToString();
                }


                if (pay_bas == "")
                {
                    pay_bas = Convert.ToString(dr2["routecd"]);
                }
                else
                {
                    pay_bas = pay_bas + "~" + Convert.ToString(dr2["routecd"]);
                }

                if (Slab_Rate == "")
                {
                    Slab_Rate = Convert.ToString(dr2["slabrate"]);
                }
                else
                {
                    Slab_Rate = Slab_Rate + "~" + Convert.ToString(dr2["slabrate"]);
                }
            }
            dr2.Close();

            int i2 = 0;
            string[] slab_from_arr = slab_from.Split('~');
            string[] slab_to_arr = slab_to.Split('~');
            string[] pay_bas_arr = pay_bas.Split('~');
            string[] Slab_Rate_arr = Slab_Rate.Split('~');
            Rl = slab_from_arr.Length;


            foreach (GridViewRow gridrow in GV_D.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromvalroad = (TextBox)gridrow.FindControl("txtfromvalroad");
                TextBox txttovalroad = (TextBox)gridrow.FindControl("txttovalroad");

                TextBox txtchrgroad = (TextBox)gridrow.FindControl("txtchrgroad0");
                TextBox txtchrgroad1 = (TextBox)gridrow.FindControl("txtchrgroad1");
                TextBox txtchrgroad2 = (TextBox)gridrow.FindControl("txtchrgroad2");

                if (i2 < Rl)
                {
                    String sbfrm = slab_from_arr[i2];
                    String sbto = slab_to_arr[i2];
                    txtfromvalroad.Text = slab_from_arr[i2];
                    txttovalroad.Text = slab_to_arr[i2];

                    if (sbfrm == "")
                    {
                        txtfromvalroad.Text = "0.00";
                    }
                    if (sbto == "")
                    {
                        txttovalroad.Text = "0.00";
                    }

                    String sql_edit3 = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and calmethod='2' and slabfrom='" + sbfrm + "' and slabto='" + sbto + "' order by chargeid";
                    SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                    SqlDataReader dr3 = cmd33.ExecuteReader();

                    while (dr3.Read())
                    {
                        String pbas = Convert.ToString(dr3["routecd"]);


                        if (pbas == "P01")
                        {
                            txtchrgroad2.Text = Convert.ToString(dr3["slabrate"]);

                        }
                        if (pbas == "P02")
                        {
                            txtchrgroad.Text = Convert.ToString(dr3["slabrate"]);
                        }
                        if (pbas == "P03")
                        {
                            txtchrgroad1.Text = Convert.ToString(dr3["slabrate"]);
                        }

                    }

                    txtfromvalroad.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttovalroad.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgroad.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgroad1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgroad2.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3.Close();
                    i2 = i2 + 1;
                }
            }
        }
        //////////////////////////T%rainn////////////////////

        if (serRail == "Y")
        {
            String sql_edit2a = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "' and calmethod='3' order by chargeid";
            SqlCommand cmd32a = new SqlCommand(sql_edit2a, cn);
            SqlDataReader dr2a = cmd32a.ExecuteReader();

            string Slab_Ratea = "", slab_froma = "", slab_toa = "", pay_basa = "";

            String abcd1a = "", abcd2a = "";
            while (dr2a.Read())
            {
                String Temp1a = dr2a["slabfrom"].ToString();
                String Temp2a = dr2a["slabto"].ToString();

                if (Temp1a != abcd1a && Temp2a != abcd2a)
                {
                    if (slab_froma == "" && slab_toa == "")
                    {
                        // ROute_cd = Convert.ToString(dr2["routecd"]);
                        slab_froma = Convert.ToString(dr2a["slabfrom"]);
                        slab_toa = Convert.ToString(dr2a["slabto"]);
                    }
                    else
                    {
                        //ROute_cd = ROute_cd + "~" + Convert.ToString(dr2["routecd"]);
                        slab_froma = slab_froma + "~" + Convert.ToString(dr2a["slabfrom"]);
                        slab_toa = slab_toa + "~" + Convert.ToString(dr2a["slabto"]);
                    }

                    abcd1a = dr2a["slabfrom"].ToString();
                    abcd2a = dr2a["slabto"].ToString();
                }


                if (pay_basa == "")
                {
                    pay_basa = Convert.ToString(dr2a["routecd"]);
                }
                else
                {
                    pay_basa = pay_basa + "~" + Convert.ToString(dr2a["routecd"]);
                }

                if (Slab_Ratea == "")
                {
                    Slab_Ratea = Convert.ToString(dr2a["slabrate"]);
                }
                else
                {
                    Slab_Ratea = Slab_Ratea + "~" + Convert.ToString(dr2a["slabrate"]);
                }
            }
            dr2a.Close();

            int i2a = 0;
            string[] slab_from_arra = slab_froma.Split('~');
            string[] slab_to_arra = slab_toa.Split('~');
            string[] pay_bas_arra = pay_basa.Split('~');
            string[] Slab_Rate_arra = Slab_Ratea.Split('~');
            int Rla = slab_from_arra.Length;


            foreach (GridViewRow gridrow in GV_D1.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromvalrail = (TextBox)gridrow.FindControl("txtfromvalrail");
                TextBox txttovalrail = (TextBox)gridrow.FindControl("txttovalrail");

                TextBox txtchrgrail = (TextBox)gridrow.FindControl("txtchrgrail0");
                TextBox txtchrgrail1 = (TextBox)gridrow.FindControl("txtchrgrail1");
                TextBox txtchrgrail2 = (TextBox)gridrow.FindControl("txtchrgrail2");

               

               

                if (i2a < Rla)
                {
                    String sbfrma = slab_from_arra[i2a];
                    String sbtoa = slab_to_arra[i2a];
                    txtfromvalrail.Text = slab_from_arra[i2a];
                    txttovalrail.Text = slab_to_arra[i2a];

                    if (sbfrma == "")
                    {
                        txtfromvalrail.Text = "0.00";
                    }
                    if (sbtoa == "")
                    {
                        txttovalrail.Text = "0.00";
                    }

                    String sql_edit3a = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='3' and slabfrom='" + sbfrma + "' and slabto='" + sbtoa + "' order by chargeid";
                    SqlCommand cmd33a = new SqlCommand(sql_edit3a, cn);
                    SqlDataReader dr3a = cmd33a.ExecuteReader();

                    while (dr3a.Read())
                    {
                        String pbasa = Convert.ToString(dr3a["routecd"]);


                        if (pbasa == "P01")
                        {
                            txtchrgrail2.Text = Convert.ToString(dr3a["slabrate"]);

                        }
                        if (pbasa == "P02")
                        {
                            txtchrgrail.Text = Convert.ToString(dr3a["slabrate"]);
                        }
                        if (pbasa == "P03")
                        {
                            txtchrgrail1.Text = Convert.ToString(dr3a["slabrate"]);
                        }

                    }

                    txtfromvalrail.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttovalrail.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrgrail.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgrail1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgrail2.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3a.Close();
                    i2a = i2a + 1;
                }
            }
        }



        //////////////////////////Air////////////////////

        if (serAir == "Y")
        {
            String sql_edit2b = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='1' order by chargeid";
            SqlCommand cmd32b = new SqlCommand(sql_edit2b, cn);
            SqlDataReader dr2b = cmd32b.ExecuteReader();

            string Slab_Rateb = "", slab_fromb = "", slab_tob = "", pay_basb = "";

            String abcd1b = "", abcd2b = "";
            while (dr2b.Read())
            {
                String Temp1b = dr2b["slabfrom"].ToString();
                String Temp2b = dr2b["slabto"].ToString();

                if (Temp1b != abcd1b && Temp2b != abcd2b)
                {
                    if (slab_fromb == "" && slab_tob == "")
                    {
                        // ROute_cd = Convert.ToString(dr2["routecd"]);
                        slab_fromb = Convert.ToString(dr2b["slabfrom"]);
                        slab_tob = Convert.ToString(dr2b["slabto"]);
                    }
                    else
                    {
                        //ROute_cd = ROute_cd + "~" + Convert.ToString(dr2["routecd"]);
                        slab_fromb = slab_fromb + "~" + Convert.ToString(dr2b["slabfrom"]);
                        slab_tob = slab_tob + "~" + Convert.ToString(dr2b["slabto"]);
                    }

                    abcd1b = dr2b["slabfrom"].ToString();
                    abcd2b = dr2b["slabto"].ToString();
                }


                if (pay_basb == "")
                {
                    pay_basb = Convert.ToString(dr2b["routecd"]);
                }
                else
                {
                    pay_basb = pay_basb + "~" + Convert.ToString(dr2b["routecd"]);
                }

                if (Slab_Rateb == "")
                {
                    Slab_Rateb = Convert.ToString(dr2b["slabrate"]);
                }
                else
                {
                    Slab_Rateb = Slab_Rateb + "~" + Convert.ToString(dr2b["slabrate"]);
                }
            }
            dr2b.Close();

            int i2b = 0;
            string[] slab_from_arrb = slab_fromb.Split('~');
            string[] slab_to_arrb = slab_tob.Split('~');
            string[] pay_bas_arrb = pay_basb.Split('~');
            string[] Slab_Rate_arrb = Slab_Rateb.Split('~');
            int Rlb = slab_from_arrb.Length;


            foreach (GridViewRow gridrow in GV_D2.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromvalair = (TextBox)gridrow.FindControl("txtfromvalair");
                TextBox txttovalair = (TextBox)gridrow.FindControl("txttovalair");

                TextBox txtchrgair = (TextBox)gridrow.FindControl("txtchrgair0");
                TextBox txtchrgair1 = (TextBox)gridrow.FindControl("txtchrgair1");
                TextBox txtchrgair2 = (TextBox)gridrow.FindControl("txtchrgair2");





                if (i2b < Rlb)
                {
                    String sbfrmb = slab_from_arrb[i2b];
                    String sbtob = slab_to_arrb[i2b];
                    txtfromvalair.Text = slab_from_arrb[i2b];
                    txttovalair.Text = slab_to_arrb[i2b];

                    if (sbfrmb == "")
                    {
                        txtfromvalair.Text = "0.00";
                    }
                    if (sbtob == "")
                    {
                        txttovalair.Text = "0.00";
                    }

                    String sql_edit3b = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='1' and slabfrom='" + sbfrmb + "' and slabto='" + sbtob + "' order by chargeid";
                    SqlCommand cmd33b = new SqlCommand(sql_edit3b, cn);
                    SqlDataReader dr3b = cmd33b.ExecuteReader();

                    while (dr3b.Read())
                    {
                        String pbasb = Convert.ToString(dr3b["routecd"]);


                        if (pbasb == "P01")
                        {
                            txtchrgair2.Text = Convert.ToString(dr3b["slabrate"]);

                        }
                        if (pbasb == "P02")
                        {
                            txtchrgair.Text = Convert.ToString(dr3b["slabrate"]);
                        }
                        if (pbasb == "P03")
                        {
                            txtchrgair1.Text = Convert.ToString(dr3b["slabrate"]);
                        }

                    }

                    txtfromvalair.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttovalair.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrgair.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgair1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgair2.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3b.Close();
                    i2b = i2b + 1;
                }
            }
        }


        //////////////////////////serExpress////////////////////

        if (serExpress == "Y")
        {
            String sql_edit2c = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='4' order by chargeid";
            SqlCommand cmd32c = new SqlCommand(sql_edit2c, cn);
            SqlDataReader dr2c = cmd32c.ExecuteReader();

            string Slab_Ratec = "", slab_fromc = "", slab_toc = "", pay_basc = "";

            String abcd1c = "", abcd2c = "";
            while (dr2c.Read())
            {
                String Temp1c = dr2c["slabfrom"].ToString();
                String Temp2c = dr2c["slabto"].ToString();

                if (Temp1c != abcd1c && Temp2c != abcd2c)
                {
                    if (slab_fromc == "" && slab_toc == "")
                    {
                        // ROute_cd = Convert.ToString(dr2["routecd"]);
                        slab_fromc = Convert.ToString(dr2c["slabfrom"]);
                        slab_toc = Convert.ToString(dr2c["slabto"]);
                    }
                    else
                    {
                        //ROute_cd = ROute_cd + "~" + Convert.ToString(dr2["routecd"]);
                        slab_fromc = slab_fromc + "~" + Convert.ToString(dr2c["slabfrom"]);
                        slab_toc = slab_toc + "~" + Convert.ToString(dr2c["slabto"]);
                    }

                    abcd1c = dr2c["slabfrom"].ToString();
                    abcd2c = dr2c["slabto"].ToString();
                }


                if (pay_basc == "")
                {
                    pay_basc = Convert.ToString(dr2c["routecd"]);
                }
                else
                {
                    pay_basc = pay_basc + "~" + Convert.ToString(dr2c["routecd"]);
                }

                if (Slab_Ratec == "")
                {
                    Slab_Ratec = Convert.ToString(dr2c["slabrate"]);
                }
                else
                {
                    Slab_Ratec = Slab_Ratec + "~" + Convert.ToString(dr2c["slabrate"]);
                }
            }
            dr2c.Close();

            int i2c = 0;
            string[] slab_from_arrc = slab_fromc.Split('~');
            string[] slab_to_arrc = slab_toc.Split('~');
            string[] pay_bas_arrc = pay_basc.Split('~');
            string[] Slab_Rate_arrc = Slab_Ratec.Split('~');
            int Rlc = slab_from_arrc.Length;


            foreach (GridViewRow gridrow in GV_D3.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromvalexp = (TextBox)gridrow.FindControl("txtfromvalexp");
                TextBox txttovalexp = (TextBox)gridrow.FindControl("txttovalexp");

                TextBox txtchrgexp = (TextBox)gridrow.FindControl("txtchrgexp0");
                TextBox txtchrgexp1 = (TextBox)gridrow.FindControl("txtchrgexp1");
                TextBox txtchrgexp2 = (TextBox)gridrow.FindControl("txtchrgexp2");





                if (i2c < Rlc)
                {
                    String sbfrmc = slab_from_arrc[i2c];
                    String sbtoc = slab_to_arrc[i2c];
                    txtfromvalexp.Text = slab_from_arrc[i2c];
                    txttovalexp.Text = slab_to_arrc[i2c];

                    if (sbfrmc == "")
                    {
                        txtfromvalexp.Text = "0.00";
                    }
                    if (sbtoc == "")
                    {
                        txttovalexp.Text = "0.00";
                    }

                    String sql_edit3c = "select slabfrom,slabto,slabvalue,slabrate,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='4' and slabfrom='" + sbfrmc + "' and slabto='" + sbtoc + "' order by chargeid";
                    SqlCommand cmd33c = new SqlCommand(sql_edit3c, cn);
                    SqlDataReader dr3c = cmd33c.ExecuteReader();

                    while (dr3c.Read())
                    {
                        String pbasc = Convert.ToString(dr3c["routecd"]);


                        if (pbasc == "P01")
                        {
                            txtchrgexp2.Text = Convert.ToString(dr3c["slabrate"]);

                        }
                        if (pbasc == "P02")
                        {
                            txtchrgexp.Text = Convert.ToString(dr3c["slabrate"]);
                        }
                        if (pbasc == "P03")
                        {
                            txtchrgexp1.Text = Convert.ToString(dr3c["slabrate"]);
                        }

                    }

                    txtfromvalexp.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttovalexp.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrgexp.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgexp1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrgexp2.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3c.Close();
                    i2c = i2c + 1;
                }
            }
        }


    }

    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");


    }

    private void Inetialized1()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");


    }

    public void Rowdatadisplq()
    {
        
        Records();

        //for (int i = 0; i < a; i++)
        //{
        //    Inetialized1();

        //}
        BindGrid();
        RetriveData();
    }
    public void Records()
    {

        string SQL_validate = "select top 1 count(distinct cast(slabfrom as varchar)+':'+cast(slabto as varchar)) from webx_vendor_contract_charges where vendorcode='" + vendorCode + "'  and chargetype='variable' group by   calmethod order by count(distinct cast(slabfrom as varchar)+':'+cast(slabto as varchar)) desc";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand validate = new SqlCommand(SQL_validate, cn);

        a = Convert.ToInt32(validate.ExecuteScalar());

        //if (roww.Text = Convert.ToString(a) || roww.Text < Convert.ToString(a))
        //{
        b = Convert.ToInt32(roww.Text);
        if (a == b)
        {

            roww.Text = Convert.ToString(a);
            a = a;
        }
        if (a > b)
        {

            roww.Text = Convert.ToString(a);
            a = a;
        }
        if (a < b)
        {
            //roww.Text = "1";
            a = a;
        }
        

    }

    protected void roww_TextChanged(object sender, EventArgs e)
    {
        int rowno, rowno1;
        rowno = Convert.ToInt32(roww.Text);

        Records();
        _dataSet.WorkExperianceData.Clear();


        if (a < rowno)
        {
            rowno1 = rowno - a;
        }
        else
        {
            if (Flag == "Y")
            {
                rowno1 = a;
            }
            else
            {
                rowno1 = rowno - 1;
            }
        }

        for (int i = 0; i < rowno1; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            //Inetialized();
            BindGrid();
            intetilisedrows();
        }
        Rowdatadisplq();
        roww.Text = Convert.ToString(rowno1);
        // Validation();
        // Validation();
    }
    private void BindGrid()
    {
        if (serRoad == "Y")
        {
            GV_D.DataSource = _dataSet.WorkExperianceData;
            GV_D.DataBind();
            _lastEditedPage = GV_D.PageIndex;
           //rd.visible = true;
        }
        if (serRail == "Y")
        {
            GV_D1.DataSource = _dataSet.WorkExperianceData;
            GV_D1.DataBind();
            _lastEditedPage = GV_D1.PageIndex;
        }

        if (serAir == "Y")
        {
            GV_D2.DataSource = _dataSet.WorkExperianceData;
            GV_D2.DataBind();
            _lastEditedPage = GV_D2.PageIndex;
        }
        

        if (serExpress == "Y")
        {
            GV_D3.DataSource = _dataSet.WorkExperianceData;
            GV_D3.DataBind();
            _lastEditedPage = GV_D3.PageIndex;
        }
    }

    private void intetilisedrows()
    {

        //cn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

            TextBox txtfromvalroad = (TextBox)gridrow.FindControl("txtfromvalroad");
            TextBox txttovalroad = (TextBox)gridrow.FindControl("txttovalroad");

            TextBox txtchrgroad = (TextBox)gridrow.FindControl("txtchrgroad0");
            TextBox txtchrgroad1 = (TextBox)gridrow.FindControl("txtchrgroad1");
            TextBox txtchrgroad2 = (TextBox)gridrow.FindControl("txtchrgroad2");

            txtfromvalroad.Text = "0.00";
            txttovalroad.Text = "0.00";

            txtchrgroad.Text = "0.00";
            txtchrgroad1.Text = "0.00";
            txtchrgroad2.Text = "0.00";

            txtfromvalroad.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txttovalroad.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtchrgroad.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgroad1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgroad2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }

        foreach (GridViewRow gridrow in GV_D1.Rows)
        {
            //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

            TextBox txtfromvalrail = (TextBox)gridrow.FindControl("txtfromvalrail");
            TextBox txttovalrail = (TextBox)gridrow.FindControl("txttovalrail");

            TextBox txtchrgrail = (TextBox)gridrow.FindControl("txtchrgrail0");
            TextBox txtchrgrail1 = (TextBox)gridrow.FindControl("txtchrgrail1");
            TextBox txtchrgrail2 = (TextBox)gridrow.FindControl("txtchrgrail2");

            txtfromvalrail.Text = "0.00";
            txttovalrail.Text = "0.00";

            txtchrgrail.Text = "0.00";
            txtchrgrail1.Text = "0.00";
            txtchrgrail2.Text = "0.00";

            txtfromvalrail.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txttovalrail.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtchrgrail.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgrail1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgrail2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }

        foreach (GridViewRow gridrow in GV_D2.Rows)
        {
            //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

            TextBox txtfromvalair = (TextBox)gridrow.FindControl("txtfromvalair");
            TextBox txttovalair = (TextBox)gridrow.FindControl("txttovalair");

            TextBox txtchrgair = (TextBox)gridrow.FindControl("txtchrgair0");
            TextBox txtchrgair1 = (TextBox)gridrow.FindControl("txtchrgair1");
            TextBox txtchrgair2 = (TextBox)gridrow.FindControl("txtchrgair2");

            txtfromvalair.Text = "0.00";
            txttovalair.Text = "0.00";

            txtchrgair.Text = "0.00";
            txtchrgair1.Text = "0.00";
            txtchrgair2.Text = "0.00";

            txtfromvalair.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txttovalair.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtchrgair.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgair1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgair2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }

        foreach (GridViewRow gridrow in GV_D3.Rows)
        {
            //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

            TextBox txtfromvalexp = (TextBox)gridrow.FindControl("txtfromvalexp");
            TextBox txttovalexp = (TextBox)gridrow.FindControl("txttovalexp");

            TextBox txtchrgexp = (TextBox)gridrow.FindControl("txtchrgexp0");
            TextBox txtchrgexp1 = (TextBox)gridrow.FindControl("txtchrgexp1");
            TextBox txtchrgexp2 = (TextBox)gridrow.FindControl("txtchrgexp2");

            txtfromvalexp.Text = "0.00";
            txttovalexp.Text = "0.00";

            txtchrgexp.Text = "0.00";
            txtchrgexp1.Text = "0.00";
            txtchrgexp2.Text = "0.00";

            txtfromvalexp.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txttovalexp.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtchrgexp.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgexp1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrgexp2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }


        cn.Close();
    }
   


    protected void Submit_Click(object sender, EventArgs e)
    {
        int a, b;
        string SQL_MAXSRNO = "select srno from webx_vendor_contract_matrix where vendorcode='" + vendorCode + "' and contractcd='" + ContID + "' and matrixcode='2'";

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand MAXSRNO = new SqlCommand(SQL_MAXSRNO, cn);

        a = Convert.ToInt32(MAXSRNO.ExecuteScalar());

        string SQL_MAXSRNO1 = "select max(srno) from webx_vendor_contract_matrix";
        SqlCommand MAXSRNO1 = new SqlCommand(SQL_MAXSRNO1, cn);

        b = Convert.ToInt32(MAXSRNO1.ExecuteScalar());


        if (Flag == "Y")
        {
            srno = a;
        }
        else
        {
            if (b == null)
            {
                srno = 1;
            }
            else
            {
                srno = b + 1;
            }
        }


        docName = "PRS";
        Chargetype = "NA";
        matrixcode = "7";
        Matrixdesc = "Pickup Charges";

        decimal OtherChrg = 0;


        OtherChrg = Convert.ToDecimal(txtmaxchrg.Text);
        calmethod = "Higher";

        SqlTransaction trans;
        trans = cn.BeginTransaction();
        try
        {
            String SQL_Insert_update, SQL_Delete, SQL_Delete1, SQL_Delete2, SQL_update_vendor, SQL_update_vendor_contract;

            if (Flag == "N")
            {
                SQL_Insert_update = "exec webx_vendor_contract_matrix_InsertData '" + vendorCode + "','" + matrixcode + "','" + Matrixdesc + "','" + Chargetype + "','" + docName + "','" + ContID + "'," + OtherChrg + "," + srno + ",'" + calmethod + "'";

            }
            else
            {
                SQL_Insert_update = "exec webx_vendor_contract_matrix_updateData " + srno + ",'" + matrixcode + "','" + Matrixdesc + "','" + Chargetype + "','" + docName + "'," + OtherChrg + ",'" + calmethod + "'";

                SQL_Delete = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','" + matrixcode + "','" + ContID + "'";
                //SQL_Delete1 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','6','" + ContID + "'";
                //SQL_Delete2 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','9','" + ContID + "'";

                SqlCommand sqlcmd1 = new SqlCommand(SQL_Delete, cn);
                sqlcmd1.Transaction = trans;
                sqlcmd1.ExecuteNonQuery();
               // SqlCommand sqlcmd2 = new SqlCommand(SQL_Delete1, cn);
                //sqlcmd2.Transaction = trans;
                //sqlcmd2.ExecuteNonQuery();
                //SqlCommand sqlcmd3 = new SqlCommand(SQL_Delete2, cn);
                //sqlcmd3.ExecuteNonQuery();
            }
            SqlCommand sqlcmd12 = new SqlCommand(SQL_Insert_update, cn);
            sqlcmd12.Transaction = trans;
            sqlcmd12.ExecuteNonQuery();


            insert_data();


            SQL_update_vendor = "update webx_vendor_hdr set contract_YN='Y' where VendorCode='" + vendorCode + "'";
            SqlCommand update_vendor = new SqlCommand(SQL_update_vendor, cn);
            update_vendor.Transaction = trans;
            update_vendor.ExecuteNonQuery();

            SQL_update_vendor_contract = "update webx_vendor_contract_summary set complete_YN='Y' where VendorCode='" + vendorCode + "' and CONTRACTCD='" + ContID + "'";
            SqlCommand update_vendor_contract = new SqlCommand(SQL_update_vendor_contract, cn);
            update_vendor_contract.Transaction = trans;
            update_vendor_contract.ExecuteNonQuery();

            trans.Commit();

            cn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<font class='redfnt' >Error : " + e1.Message + "</font>");

            trans.Rollback();


            cn.Close();
            Response.End();
        }
        string final;
        final = "?ContID=" + ContID;
        final += "&Flag=" + Flag;
        final += "&vendorCode=" + vendorCode;

        Response.Redirect("vendorContract_Done.aspx" + final);

    }

    protected void insert_data()
    {

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        String sql_insertDetails;
        SqlTransaction trans;
        trans = cn.BeginTransaction();
        try
        {
        if (calmethod == "Fixed" || calmethod == "Both" || calmethod == "Higher")
        {
            slabfrom = Convert.ToDecimal(txtminchrg.Text);
            Slabto = Convert.ToDecimal(txtmaxchrg.Text);
            slabrate = 0;

            chargebasis = Convert.ToString(cbochrgbasis.Value);
            Fixed_YN = "N";
            Rate_YN = "N";
            calmethod1 = "Fixed";
            slabvalue = 0;
            vehtype = 0;

            sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','NA','" + calmethod1 + "'";

            Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
            SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
            insertDetails.Transaction = trans;
            insertDetails.ExecuteNonQuery();
        }
        decimal chrgvalue = 0;


        ///////////////////////////////////////////////Road/Normal
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            calmethod1 = "2";
            TextBox txtfromvalroad = (TextBox)gridrow.FindControl("txtfromvalroad");
            TextBox txttovalroad = (TextBox)gridrow.FindControl("txttovalroad");

            TextBox txtchrgroad0 = (TextBox)gridrow.FindControl("txtchrgroad0");
            TextBox txtchrgroad1 = (TextBox)gridrow.FindControl("txtchrgroad1");
            TextBox txtchrgroad2 = (TextBox)gridrow.FindControl("txtchrgroad2");
            
                chargebasis = slabbasis;
                if (chargebasis == "")
                {
                    chargebasis = "% of freight";
                }

                Fixed_YN = "N";
                Rate_YN = "N";
                vehtype = 2;
                minval=0;
                maxval = 0;
                
                slabvalue = 0;
                for (int i = 0; i < 3; i++)
                {
                   
                    
                    
                    if (i == 0)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgroad0.Text);
                        Strpaybas = paybastbb;
                    }
                    else if (i == 1)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgroad1.Text);
                        Strpaybas = paybastopay;
                    }
                    else if (i == 2)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgroad2.Text);
                        Strpaybas = paybaspaid;
                    }

                    slabfrom = Convert.ToDecimal(txtfromvalroad.Text);
                    Slabto = Convert.ToDecimal(txttovalroad.Text);
                   
                    if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                    {

                        slabrate = chrgvalue;
                        sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'" + Strpaybas + "','" + calmethod1 + "','Variable'";
                                        
                        Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                        SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                        insertDetails.Transaction = trans;
                        insertDetails.ExecuteNonQuery();

                    }


                }
            



        }


        ///////////////////////////////////////////////Train
        foreach (GridViewRow gridrow in GV_D1.Rows)
        {
            calmethod1 = "3";
            TextBox txtfromvalrail = (TextBox)gridrow.FindControl("txtfromvalrail");
            TextBox txttovalrail = (TextBox)gridrow.FindControl("txttovalrail");

            TextBox txtchrgrail0 = (TextBox)gridrow.FindControl("txtchrgrail0");
            TextBox txtchrgrail1 = (TextBox)gridrow.FindControl("txtchrgrail1");
            TextBox txtchrgrail2 = (TextBox)gridrow.FindControl("txtchrgrail2");

            
                chargebasis = slabbasis;
                if (chargebasis == "")
                {
                    chargebasis = "% of freight";
                }

                Fixed_YN = "N";
                Rate_YN = "N";
                vehtype = 3;
                minval = 0;
                maxval = 0;

                slabvalue = 0;
                for (int i = 0; i < 3; i++)
                {



                    if (i == 0)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgrail0.Text);
                        Strpaybas = paybastbb;
                    }
                    else if (i == 1)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgrail1.Text);
                        Strpaybas = paybastopay;
                    }
                    else if (i == 2)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgrail2.Text);
                        Strpaybas = paybaspaid;
                    }

                    slabfrom = Convert.ToDecimal(txtfromvalrail.Text);
                    Slabto = Convert.ToDecimal(txttovalrail.Text);

                    if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                    {

                        slabrate = chrgvalue;
                        sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'" + Strpaybas + "','" + calmethod1 + "','Variable'";

                        Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                        SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                        insertDetails.Transaction = trans;
                        insertDetails.ExecuteNonQuery();

                    }


                }
            



        }
        

        ///////////////////////////////////////////////Air
        foreach (GridViewRow gridrow in GV_D2.Rows)
        {
            calmethod1 = "1";
            TextBox txtfromvalAir = (TextBox)gridrow.FindControl("txtfromvalAir");
            TextBox txttovalAir = (TextBox)gridrow.FindControl("txttovalAir");

            TextBox txtchrgAir0 = (TextBox)gridrow.FindControl("txtchrgAir0");
            TextBox txtchrgAir1 = (TextBox)gridrow.FindControl("txtchrgAir1");
            TextBox txtchrgAir2 = (TextBox)gridrow.FindControl("txtchrgAir2");

            
                chargebasis = slabbasis;
                if (chargebasis == "")
                {
                    chargebasis = "% of freight";
                }

                Fixed_YN = "N";
                Rate_YN = "N";
                vehtype = 1;
                minval = 0;
                maxval = 0;

                slabvalue = 0;
                for (int i = 0; i < 3; i++)
                {



                    if (i == 0)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgAir0.Text);
                        Strpaybas = paybastbb;
                    }
                    else if (i == 1)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgAir1.Text);
                        Strpaybas = paybastopay;
                    }
                    else if (i == 2)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgAir2.Text);
                        Strpaybas = paybaspaid;
                    }

                    slabfrom = Convert.ToDecimal(txtfromvalAir.Text);
                    Slabto = Convert.ToDecimal(txttovalAir.Text);

                    if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                    {

                        slabrate = chrgvalue;
                        sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'" + Strpaybas + "','" + calmethod1 + "','Variable'";

                        Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                        SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                        insertDetails.Transaction = trans;
                        insertDetails.ExecuteNonQuery();

                    }


                }
           


        }


        ///////////////////////////////////////////////Express
        foreach (GridViewRow gridrow in GV_D3.Rows)
        {
            calmethod1 = "4";
            TextBox txtfromvalexp = (TextBox)gridrow.FindControl("txtfromvalexp");
            TextBox txttovalexp = (TextBox)gridrow.FindControl("txttovalexp");

            TextBox txtchrgexp0 = (TextBox)gridrow.FindControl("txtchrgexp0");
            TextBox txtchrgexp1 = (TextBox)gridrow.FindControl("txtchrgexp1");
            TextBox txtchrgexp2 = (TextBox)gridrow.FindControl("txtchrgexp2");

            
                chargebasis = slabbasis;
                if (chargebasis == "")
                {
                    chargebasis = "% of freight";
                }

                Fixed_YN = "N";
                Rate_YN = "N";
                vehtype = 4;
                minval = 0;
                maxval = 0;

                slabvalue = 0;
                for (int i = 0; i < 3; i++)
                {



                    if (i == 0)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgexp0.Text);
                        Strpaybas = paybastbb;
                    }
                    else if (i == 1)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgexp1.Text);
                        Strpaybas = paybastopay;
                    }
                    else if (i == 2)
                    {
                        chrgvalue = Convert.ToDecimal(txtchrgexp2.Text);
                        Strpaybas = paybaspaid;
                    }

                    slabfrom = Convert.ToDecimal(txtfromvalexp.Text);
                    Slabto = Convert.ToDecimal(txttovalexp.Text);

                    if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                    {

                        slabrate = chrgvalue;
                        sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'" + Strpaybas + "','" + calmethod1 + "','Variable'";

                        Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                        SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                        insertDetails.Transaction = trans;
                        insertDetails.ExecuteNonQuery();

                    }


                }
            }


            trans.Commit();

            cn.Close();
        }
        catch (Exception e1)
        {
            Response.Write("<font class='redfnt' >Error : " + e1.Message + "</font>");

            trans.Rollback();


            cn.Close();
            Response.End();
        }

        
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
