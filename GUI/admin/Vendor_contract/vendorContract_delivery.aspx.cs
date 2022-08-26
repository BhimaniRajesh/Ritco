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

public partial class GUI_Admin_Vendor_contract_vendorContract_delivery : System.Web.UI.Page
{
    int _lastEditedPage, srno, vehtype = 0,a=0,b=0;
    decimal slabfrom, Slabto, slabrate = 0, slabvalue = 0;
    public static string vendorCode, ContID, Flag, docName, Chargetype, st_matrixcode, matrixcode, Matrixdesc, calmethod, calmethod1, kmrs, slabbasis = "Per Km.", chargebasis, Fixed_YN, Rate_YN, calbasoda, chrgbasis = "Per trip", serRoad, serRail, serAir, serExpress;
    public int sno = 0;
    SqlConnection cn;
    public DataSet1 _dataSet = new DataSet1();
    protected void Page_Load(object sender, EventArgs e)
    {
        Flag = Request.QueryString.Get("Flag");
        vendorCode = Request.QueryString.Get("vendorCode");
        ContID = Request.QueryString.Get("ContID");
        st_matrixcode = Request.QueryString.Get("st_matrixcode");
        if (ContID != "")
        {
            chrgbasis = "Per trip";
            slabbasis = "Per Kg";
            calbasoda = "Per Cnote";
            cbocalbasisoda.Value = "Higher";
            txtcalbasoda.Value = calbasoda;
        }



        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
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

        dr.Close();
        cn.Close();
        if (!IsPostBack)
        {
            Inetialized();
            BindGrid();

            txtcalbasoda.Value = calbasoda;
                
            // popAgnt();
            //Validation();
            intetilisedrows();
            roww.Text = "5";

           

            txtmaxchrgoda.Text = "0.00";
            txtminchrgoda.Text = "0.00";
            txtvarperoda.Text = "0.00";
            txtmaxchrg.Text = "0.00";
            txtminchrg.Text = "0.00";


            if (Flag == "Y")
            {
                kmrs = "KM";
                RetriveData();
                RetriveData1();
            }

            txtmaxchrgoda.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtminchrgoda.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtvarperoda.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtmaxchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtminchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
        }

      
        

    }
    private void RetriveData1()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        if (serAir == "Y")
        {
            String sql_edit2 = "select slabfrom,slabto,slabrate,minval,maxval,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "'  and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='1' order by chargeid";
            SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
            SqlDataReader dr2 = cmd32.ExecuteReader();

            // Boolean a;
            // a = dr2.Read();

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
                    pay_bas = Convert.ToString(dr2["vehtype"]);
                }
                else
                {
                    pay_bas = pay_bas + "~" + Convert.ToString(dr2["vehtype"]);
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
            int Rl = slab_from_arr.Length;

            foreach (GridViewRow gridrow in GV_D.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromval");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttoval");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
                //TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                //TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                //TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");

                if (i2 < Rl)
                {
                    String sbfrm = slab_from_arr[i2];
                    String sbto = slab_to_arr[i2];
                    txtfromval.Text = slab_from_arr[i2];
                    txttoval.Text = slab_to_arr[i2];

                    if (sbfrm == "")
                    {
                        txtfromval.Text = "0.00";
                    }
                    if (sbto == "")
                    {
                        txttoval.Text = "0.00";
                    }

                    String sql_edit3 = "select slabfrom,slabto,slabvalue,slabrate,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "'  and slabfrom='" + sbfrm + "' and slabto='" + sbto + "' and calmethod='1' order by chargeid";
                    SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                    SqlDataReader dr3 = cmd33.ExecuteReader();

                    while (dr3.Read())
                    {
                        String pbas = Convert.ToString(dr3["vehtype"]);


                        if (pbas == "1")
                        {
                            txtchrg.Text = Convert.ToString(dr3["slabrate"]);

                        }
                        if (pbas == "2")
                        {
                            txtchrg1.Text = Convert.ToString(dr3["slabrate"]);
                        }
                        //if (pbas == "P03")
                        //{
                        //    txtchrgroad1.Text = Convert.ToString(dr3["slabrate"]);
                        //}

                    }

                    txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3.Close();
                    i2 = i2 + 1;
                }
            }
        }


        if (serRoad == "Y")
        {
            String sql_edit2 = "select slabfrom,slabto,slabrate,minval,maxval,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "'  and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='2' order by chargeid";
            SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
            SqlDataReader dr2 = cmd32.ExecuteReader();

            // Boolean a;
            // a = dr2.Read();

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
                    pay_bas = Convert.ToString(dr2["vehtype"]);
                }
                else
                {
                    pay_bas = pay_bas + "~" + Convert.ToString(dr2["vehtype"]);
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
            int Rl = slab_from_arr.Length;

            foreach (GridViewRow gridrow in GV_D_Road.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRoad");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRoad");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0Road");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Road");
                //TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                //TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                //TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");

                if (i2 < Rl)
                {
                    String sbfrm = slab_from_arr[i2];
                    String sbto = slab_to_arr[i2];
                    txtfromval.Text = slab_from_arr[i2];
                    txttoval.Text = slab_to_arr[i2];

                    if (sbfrm == "")
                    {
                        txtfromval.Text = "0.00";
                    }
                    if (sbto == "")
                    {
                        txttoval.Text = "0.00";
                    }

                    String sql_edit3 = "select slabfrom,slabto,slabvalue,slabrate,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "'  and slabfrom='" + sbfrm + "' and slabto='" + sbto + "' and calmethod='2' order by chargeid";
                    SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                    SqlDataReader dr3 = cmd33.ExecuteReader();

                    while (dr3.Read())
                    {
                        String pbas = Convert.ToString(dr3["vehtype"]);


                        if (pbas == "1")
                        {
                            txtchrg.Text = Convert.ToString(dr3["slabrate"]);

                        }
                        if (pbas == "2")
                        {
                            txtchrg1.Text = Convert.ToString(dr3["slabrate"]);
                        }
                        //if (pbas == "P03")
                        //{
                        //    txtchrgroad1.Text = Convert.ToString(dr3["slabrate"]);
                        //}

                    }

                    txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3.Close();
                    i2 = i2 + 1;
                }
            }
        }
        if (serRail == "Y")
        {
            String sql_edit2 = "select slabfrom,slabto,slabrate,minval,maxval,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "'  and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='3' order by chargeid";
            SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
            SqlDataReader dr2 = cmd32.ExecuteReader();

            // Boolean a;
            // a = dr2.Read();

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
                    pay_bas = Convert.ToString(dr2["vehtype"]);
                }
                else
                {
                    pay_bas = pay_bas + "~" + Convert.ToString(dr2["vehtype"]);
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
            int Rl = slab_from_arr.Length;

            foreach (GridViewRow gridrow in GV_D_Rail.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRail");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRail");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0Rail");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Rail");
                //TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                //TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                //TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");

                if (i2 < Rl)
                {
                    String sbfrm = slab_from_arr[i2];
                    String sbto = slab_to_arr[i2];
                    txtfromval.Text = slab_from_arr[i2];
                    txttoval.Text = slab_to_arr[i2];

                    if (sbfrm == "")
                    {
                        txtfromval.Text = "0.00";
                    }
                    if (sbto == "")
                    {
                        txttoval.Text = "0.00";
                    }

                    String sql_edit3 = "select slabfrom,slabto,slabvalue,slabrate,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "'  and slabfrom='" + sbfrm + "' and slabto='" + sbto + "' and calmethod='3' order by chargeid";
                    SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                    SqlDataReader dr3 = cmd33.ExecuteReader();

                    while (dr3.Read())
                    {
                        String pbas = Convert.ToString(dr3["vehtype"]);


                        if (pbas == "1")
                        {
                            txtchrg.Text = Convert.ToString(dr3["slabrate"]);

                        }
                        if (pbas == "2")
                        {
                            txtchrg1.Text = Convert.ToString(dr3["slabrate"]);
                        }
                        //if (pbas == "P03")
                        //{
                        //    txtchrgroad1.Text = Convert.ToString(dr3["slabrate"]);
                        //}

                    }

                    txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3.Close();
                    i2 = i2 + 1;
                }
            }
        }

        if (serExpress == "Y")
        {
            String sql_edit2 = "select slabfrom,slabto,slabrate,minval,maxval,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "'  and matrixcode='" + st_matrixcode + "' and chargetype='Variable' and calmethod='4' order by chargeid";
            SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
            SqlDataReader dr2 = cmd32.ExecuteReader();

            // Boolean a;
            // a = dr2.Read();

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
                    pay_bas = Convert.ToString(dr2["vehtype"]);
                }
                else
                {
                    pay_bas = pay_bas + "~" + Convert.ToString(dr2["vehtype"]);
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
            int Rl = slab_from_arr.Length;

            foreach (GridViewRow gridrow in GV_D_EXP.Rows)
            {
                //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");

                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalEXP");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalEXP");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0EXP");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1EXP");
                //TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                //TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                //TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");

                if (i2 < Rl)
                {
                    String sbfrm = slab_from_arr[i2];
                    String sbto = slab_to_arr[i2];
                    txtfromval.Text = slab_from_arr[i2];
                    txttoval.Text = slab_to_arr[i2];

                    if (sbfrm == "")
                    {
                        txtfromval.Text = "0.00";
                    }
                    if (sbto == "")
                    {
                        txttoval.Text = "0.00";
                    }

                    String sql_edit3 = "select slabfrom,slabto,slabvalue,slabrate,routecd,vehtype from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' and matrixcode='" + st_matrixcode + "'  and slabfrom='" + sbfrm + "' and slabto='" + sbto + "' and calmethod='4' order by chargeid";
                    SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                    SqlDataReader dr3 = cmd33.ExecuteReader();

                    while (dr3.Read())
                    {
                        String pbas = Convert.ToString(dr3["vehtype"]);


                        if (pbas == "1")
                        {
                            txtchrg.Text = Convert.ToString(dr3["slabrate"]);

                        }
                        if (pbas == "2")
                        {
                            txtchrg1.Text = Convert.ToString(dr3["slabrate"]);
                        }
                        //if (pbas == "P03")
                        //{
                        //    txtchrgroad1.Text = Convert.ToString(dr3["slabrate"]);
                        //}

                    }

                    txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                    txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
                    dr3.Close();
                    i2 = i2 + 1;
                }
            }
        }
            cn.Close();
}

    private void RetriveData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //String sql_insertDetails;

        String sql_edit = "select slabfrom,slabto from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='Fixed' ";
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


        String sql_edit1 = "select slabfrom,slabto,slabrate from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and matrixcode='" + st_matrixcode + "' and chargetype='ODA'";
        SqlCommand cmd31 = new SqlCommand(sql_edit1, cn);
        SqlDataReader dr1 = cmd31.ExecuteReader();
        //String mcode = "";
        while (dr1.Read())
        {
            //txtaddwtchrg.Text = dr["otherchrg"].ToString();
            // mcode = dr["matrixcode"].ToString();
            // cboapptrans.SelectedValue = dr["docname"].ToString();

            txtminchrgoda.Text = dr1["slabfrom"].ToString();
            txtmaxchrgoda.Text = dr1["slabto"].ToString();
            txtvarperoda.Text = dr1["slabrate"].ToString();
        }
        dr1.Close();


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



        for (int i = 0; i < a; i++)
        {
            Inetialized1();

        }
        BindGrid();
        intetilisedrows();
        RetriveData1();

    }
    public void Records()
    {

        string SQL_validate = "select top 1 count(distinct cast(slabfrom as varchar)+':'+cast(slabto as varchar)) from webx_vendor_contract_charges where vendorcode='" + vendorCode + "' and  matrixcode='7'  and chargetype='variable'  order by count(distinct cast(slabfrom as varchar)+':'+cast(slabto as varchar)) desc";
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
        int rowno, rowno1,abc;
        rowno = Convert.ToInt32(roww.Text);

        Records();
        _dataSet.WorkExperianceData.Clear();


        if (a < rowno)
        {
            rowno1 = rowno - a;
            abc = rowno;
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

            abc = a;
        }



        for (int i = 0; i < rowno1; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            //Inetialized();
            BindGrid();
           // intetilisedrows();
        }
        Rowdatadisplq();
        roww.Text = Convert.ToString(abc);
        // Validation();
    }
      
    private void BindGrid()
    {
        

        if (serAir == "Y")
        {
            lblhadair.Visible = true;
            GV_D.DataSource = _dataSet.WorkExperianceData;
            GV_D.DataBind();
            _lastEditedPage = GV_D.PageIndex;
        }
        if (serRoad == "Y")
        {
            lblhadroad.Visible = true;
            GV_D_Road.DataSource = _dataSet.WorkExperianceData;
            GV_D_Road.DataBind();
            _lastEditedPage = GV_D_Road.PageIndex;
        }

        if (serRail == "Y")
        {
            lblhadrail.Visible = true;
            GV_D_Rail.DataSource = _dataSet.WorkExperianceData;
            GV_D_Rail.DataBind();
            _lastEditedPage = GV_D_Rail.PageIndex;
        }
        if (serExpress == "Y")
        {
            lblHadEXP.Visible = true;
            GV_D_EXP.DataSource = _dataSet.WorkExperianceData;
            GV_D_EXP.DataBind();
            _lastEditedPage = GV_D_EXP.PageIndex;
        }
    }

    private void intetilisedrows()
    {

        cn.Open();

        if (serAir == "Y")
        {
            foreach (GridViewRow gridrow in GV_D.Rows)
            {
                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromval");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttoval");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");


                txtfromval.Text = "0.00";
                txttoval.Text = "0.00";

                txtchrg.Text = "0.00";
                txtchrg1.Text = "0.00";


                txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");

            }
        }
        if (serRoad == "Y")
        {

            foreach (GridViewRow gridrow in GV_D_Road.Rows)
            {
                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRoad");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRoad");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0Road");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Road");


                txtfromval.Text = "0.00";
                txttoval.Text = "0.00";

                txtchrg.Text = "0.00";
                txtchrg1.Text = "0.00";


                txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");

            }
        }
        
        if (serRail == "Y")
        {
            foreach (GridViewRow gridrow in GV_D_Rail.Rows)
            {
                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRail");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRail");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0Rail");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Rail");


                txtfromval.Text = "0.00";
                txttoval.Text = "0.00";

                txtchrg.Text = "0.00";
                txtchrg1.Text = "0.00";


                txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");

            }
        }
        
        if (serExpress == "Y")
        {
            foreach (GridViewRow gridrow in GV_D_EXP.Rows)
            {
                TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalEXP");
                TextBox txttoval = (TextBox)gridrow.FindControl("txttovalEXP");

                TextBox txtchrg = (TextBox)gridrow.FindControl("txtchrg0EXP");
                TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1EXP");


                txtfromval.Text = "0.00";
                txttoval.Text = "0.00";

                txtchrg.Text = "0.00";
                txtchrg1.Text = "0.00";


                txtfromval.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txttoval.Attributes.Add("onblur", "javascript:return Check_num(this)");

                txtchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
                txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");

            }

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


        docName = "DRS";
        Chargetype = "NA";
        matrixcode = "6";
        Matrixdesc = "Delivery Charges";

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
                //SQL_Delete1 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','7','" + ContID + "'";
                //SQL_Delete2 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','9','" + ContID + "'";

                SqlCommand sqlcmd1 = new SqlCommand(SQL_Delete, cn);
                sqlcmd1.Transaction = trans;
                sqlcmd1.ExecuteNonQuery();
              //  SqlCommand sqlcmd2 = new SqlCommand(SQL_Delete1, cn);
                //sqlcmd2.Transaction = trans;
               // sqlcmd2.ExecuteNonQuery();
                //SqlCommand sqlcmd3 = new SqlCommand(SQL_Delete2, cn);
                //sqlcmd3.ExecuteNonQuery();
            }
            SqlCommand sqlcmd = new SqlCommand(SQL_Insert_update, cn);
            sqlcmd.Transaction = trans;
            sqlcmd.ExecuteNonQuery();


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

            calmethod = Convert.ToString(cbocalbasisoda.Value);
            slabfrom = Convert.ToDecimal(txtminchrgoda.Text);
            Slabto = Convert.ToDecimal(txtmaxchrgoda.Text);
            chargebasis = Convert.ToString(txtcalbasoda.Value);
            slabrate = Convert.ToDecimal(txtvarperoda.Text);
            Fixed_YN = "N";
            Rate_YN = "N";
            //calmethod1 = "Fixed";
            slabvalue = 0;
            vehtype = 0;
            String chargeType = "ODA";

            sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','" + calmethod + "','" + chargeType + "'";

            Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
            SqlCommand insertDetails1 = new SqlCommand(sql_insertDetails, cn);
            insertDetails1.Transaction = trans;
            insertDetails1.ExecuteNonQuery();
            if (serAir == "Y")
            {
                foreach (GridViewRow gridrow in GV_D.Rows)
                {
                    //DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
                    //DropDownList Vehtype0 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype");
                    //DropDownList Vehtype1 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype1");
                    //DropDownList Vehtype2 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype2");
                    //DropDownList Vehtype3 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype3");
                    //DropDownList Vehtype4 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype4");

                    TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromval");
                    TextBox txttoval = (TextBox)gridrow.FindControl("txttoval");

                    TextBox txtchrg0 = (TextBox)gridrow.FindControl("txtchrg0");
                    TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
                    //TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                    //TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                    //TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");



                    if (calmethod == "Variable" || calmethod == "Both" || calmethod == "Higher")
                    {
                        chargebasis = slabbasis;
                        if (chargebasis == "")
                        {
                            chargebasis = "Per Km.";
                        }

                        Fixed_YN = "N";
                        Rate_YN = "N";

                        slabvalue = 0;
                        for (int i = 0; i < 2; i++)
                        {
                            //Response.Write("<br> Route : " + Route);

                            decimal chrgvalue = 0;
                            //int vehtype = 0;
                            //  String chargebasis, Fixed_YN, Rate_YN, routecd, calmethod1;



                            //if(slabrate=="")
                            //{
                            //    slabrate = 0;
                            //}

                            if (i == 0)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg0.Text);
                                vehtype = 1;
                            }
                            else if (i == 1)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg1.Text);
                                vehtype = 2;
                            }
                            //else if (i == 2)
                            //{
                            //    chrgvalue = Convert.ToDecimal(txtchrg2.Text);
                            //    vehtype = Convert.ToInt32(Vehtype2.SelectedValue);
                            //}
                            //else if (i == 3)
                            //{
                            //    chrgvalue = Convert.ToDecimal(txtchrg3.Text);
                            //    vehtype = Convert.ToInt32(Vehtype3.SelectedValue);
                            //}
                            //else if (i == 4)
                            //{
                            //    chrgvalue = Convert.ToDecimal(txtchrg4.Text);
                            //    vehtype = Convert.ToInt32(Vehtype4.SelectedValue);
                            //}

                            // routecd = Route.SelectedValue.ToString();
                            slabfrom = Convert.ToDecimal(txtfromval.Text);
                            Slabto = Convert.ToDecimal(txttoval.Text);
                            // Response.Write("<br> Route : " + chrgvalue);
                            //Response.Write("<br> Route : " + vehtype);
                            if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                            {

                                slabrate = chrgvalue;
                                sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','1','Variable'";

                                Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                                SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                                insertDetails.Transaction = trans;
                                insertDetails.ExecuteNonQuery();

                            }


                        }
                    }



                }
            }

            if (serRoad == "Y")
            {
                foreach (GridViewRow gridrow in GV_D_Road.Rows)
                {


                    TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRoad");
                    TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRoad");

                    TextBox txtchrg0 = (TextBox)gridrow.FindControl("txtchrg0Road");
                    TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Road");
                   
                    if (calmethod == "Variable" || calmethod == "Both" || calmethod == "Higher")
                    {
                        chargebasis = slabbasis;
                        if (chargebasis == "")
                        {
                            chargebasis = "Per Km.";
                        }

                        Fixed_YN = "N";
                        Rate_YN = "N";

                        slabvalue = 0;
                        for (int i = 0; i < 2; i++)
                        {
                            //Response.Write("<br> Route : " + Route);

                            decimal chrgvalue = 0;
                           

                            if (i == 0)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg0.Text);
                                vehtype = 1;
                            }
                            else if (i == 1)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg1.Text);
                                vehtype = 2;
                            }
                            

                            // routecd = Route.SelectedValue.ToString();
                            slabfrom = Convert.ToDecimal(txtfromval.Text);
                            Slabto = Convert.ToDecimal(txttoval.Text);
                            // Response.Write("<br> Route : " + chrgvalue);
                            //Response.Write("<br> Route : " + vehtype);
                            if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                            {

                                slabrate = chrgvalue;
                                sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','2','Variable'";

                                Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                                SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                                insertDetails.Transaction = trans;
                                insertDetails.ExecuteNonQuery();

                            }


                        }
                    }



                }
            }


            if (serRail == "Y")
            {
                foreach (GridViewRow gridrow in GV_D_Rail.Rows)
                {


                    TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalRail");
                    TextBox txttoval = (TextBox)gridrow.FindControl("txttovalRail");

                    TextBox txtchrg0 = (TextBox)gridrow.FindControl("txtchrg0Rail");
                    TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1Rail");

                    if (calmethod == "Variable" || calmethod == "Both" || calmethod == "Higher")
                    {
                        chargebasis = slabbasis;
                        if (chargebasis == "")
                        {
                            chargebasis = "Per Km.";
                        }

                        Fixed_YN = "N";
                        Rate_YN = "N";

                        slabvalue = 0;
                        for (int i = 0; i < 2; i++)
                        {
                            //Response.Write("<br> Route : " + Route);

                            decimal chrgvalue = 0;


                            if (i == 0)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg0.Text);
                                vehtype = 1;
                            }
                            else if (i == 1)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg1.Text);
                                vehtype = 2;
                            }


                            // routecd = Route.SelectedValue.ToString();
                            slabfrom = Convert.ToDecimal(txtfromval.Text);
                            Slabto = Convert.ToDecimal(txttoval.Text);
                            // Response.Write("<br> Route : " + chrgvalue);
                            //Response.Write("<br> Route : " + vehtype);
                            if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                            {

                                slabrate = chrgvalue;
                                sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','3','Variable'";

                                Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                                SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                                insertDetails.Transaction = trans;
                                insertDetails.ExecuteNonQuery();

                            }


                        }
                    }



                }
            }


            if (serExpress == "Y")
            {
                foreach (GridViewRow gridrow in GV_D_EXP.Rows)
                {


                    TextBox txtfromval = (TextBox)gridrow.FindControl("txtfromvalEXP");
                    TextBox txttoval = (TextBox)gridrow.FindControl("txttovalEXP");

                    TextBox txtchrg0 = (TextBox)gridrow.FindControl("txtchrg0EXP");
                    TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1EXP");

                    if (calmethod == "Variable" || calmethod == "Both" || calmethod == "Higher")
                    {
                        chargebasis = slabbasis;
                        if (chargebasis == "")
                        {
                            chargebasis = "Per Km.";
                        }

                        Fixed_YN = "N";
                        Rate_YN = "N";

                        slabvalue = 0;
                        for (int i = 0; i < 2; i++)
                        {
                            //Response.Write("<br> Route : " + Route);

                            decimal chrgvalue = 0;


                            if (i == 0)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg0.Text);
                                vehtype = 1;
                            }
                            else if (i == 1)
                            {
                                chrgvalue = Convert.ToDecimal(txtchrg1.Text);
                                vehtype = 2;
                            }


                            // routecd = Route.SelectedValue.ToString();
                            slabfrom = Convert.ToDecimal(txtfromval.Text);
                            Slabto = Convert.ToDecimal(txttoval.Text);
                            // Response.Write("<br> Route : " + chrgvalue);
                            //Response.Write("<br> Route : " + vehtype);
                            if (chrgvalue > 0 && (slabfrom > 0 || Slabto > 0))
                            {

                                slabrate = chrgvalue;
                                sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','4','Variable'";

                                Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                                SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                                insertDetails.Transaction = trans;
                                insertDetails.ExecuteNonQuery();

                            }


                        }
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
