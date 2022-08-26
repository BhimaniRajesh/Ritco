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

public partial class GUI_admin_DocketCustomization_DocketCustomization_Step2 : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        string sqlstr = "";
        SqlCommand cmd;
        if (!IsPostBack)
        {
            sqlstr = "SELECT code=UPPER(code),defaultvalue FROM webx_rules_docket";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                try
                {
                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_COMPUTERISED") == 0)
                    {
                        optcomputerized.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("DCR_SERIAL") == 0)
                    {
                        optdcrserial.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_VOID") == 0)
                    {
                        optdcrvoid.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("DCR_BUSINESS") == 0)
                    {
                        optbusinessdcr.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("DCR_TRANSMODE") == 0)
                    {
                        opttranmodedcr.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("DOC_DTL") == 0)
                    {
                        optdocdetails.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("EDD_TRANSIT") == 0)
                    {
                        opteddtransit.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("EDD_NDAYS") == 0)
                    {
                        txttrdays.Text = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FCITY_MSTR") == 0)
                    {
                        optmastercities.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("CSGN_MSTR") == 0)
                    {
                        optmastercsgne.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }


                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_LOT") == 0)
                    {
                        optloadtype.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_DOPI") == 0)
                    {
                        optdopi.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_MULTI_PICKUPDEL") == 0)
                    {
                        optmultipickupdel.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_PRORATA") == 0)
                    {
                        optprorata.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_ROUND") == 0)
                    {
                        optround.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_FTL_FILTER") == 0)
                    {
                        optftlfilter.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }


                    if (dt.Rows[i]["code"].ToString().CompareTo("CHRG_RULE") == 0)
                    {
                        optchargerule.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("FLAG_INTRASTATE") == 0)
                    {
                        optintrastate.SelectedValue = Convert.ToString(dt.Rows[i]["defaultvalue"]);
                    }

                    if (dt.Rows[i]["code"].ToString().CompareTo("RANGE_DKTDT") == 0)
                    {


                        string[] arrvalue = Convert.ToString(dt.Rows[i]["defaultvalue"]).Split('|');

                        string[] arrdt = arrvalue[0].Split(',');
                        string[] arrhr = arrvalue[1].Split(',');

                        txtdtblwnodays.Style["display"] = "none";
                        txtdtabvnodays.Style["display"] = "none";

                        txthrblwhours.Style["display"] = "none";
                        txthrabvhours.Style["display"] = "none";

                        if (arrdt[0].CompareTo("Y") == 0)
                            chkbydate.Checked = true;

                        if (arrhr[0].CompareTo("Y") == 0)
                            chkbyhour.Checked = true;

                        try
                        {
                           if (arrdt[1].Substring(2, 1).CompareTo("D") == 0)
                            {
                                optdtblwnodays.Checked = true;
                                txtdtblwnodays.Style["display"] = "block";
                                txtdtblwnodays.Text = Convert.ToString(arrdt[3]);
                            }
                            else if (arrdt[1].Substring(2, 1).CompareTo("T") == 0)
                            {
                                optdtblwtilldate.Checked = true;
                                lblblwimage.Style["display"] = "block";
                                txtblwdate.Style["display"] = "block";
                                txtblwdate.Text = arrdt[5];
                            }

                            if (arrdt[2].Substring(2, 1).CompareTo("D") == 0)
                            {
                                optdtabvnodays.Checked = true;
                                txtdtabvnodays.Style["display"] = "block";
                                txtdtabvnodays.Text = Convert.ToString(arrdt[4]);
                            }
                            else if (arrdt[2].Substring(2, 1).CompareTo("T") == 0)
                            {
                                optdtabvtilldate.Checked = true;
                                lblabvimage.Style["display"] = "block";
                                txtabvdate.Style["display"] = "block";
                                txtabvdate.Text = arrdt[6];
                            }

                            if (arrhr[1].Substring(2, 1).CompareTo("D") == 0)
                            {
                                opthrblwhours.Checked = true;
                                txthrblwhours.Text = Convert.ToString(arrhr[3]);
                                txthrblwhours.Style["display"] = "block";
                            }

                            if (arrhr[2].Substring(2, 1).CompareTo("D") == 0)
                            {
                                opthrabvhours.Checked = true;
                                txthrabvhours.Text = Convert.ToString(arrhr[4]);
                                txthrabvhours.Style["display"] = "block";
                            }



                        }
                        catch (Exception ex) { }
                    }

                }
                catch (Exception ex) { }
            }





        } // End of IsPostBack
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string sqlstr = "";
        SqlCommand cmd;

        SqlTransaction trn;
        trn = con.BeginTransaction();
        try
        {
            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_COMPUTERISED'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_COMPUTERISED','Whether to allow computerised entry','" + optcomputerized.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////1

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='DCR_SERIAL'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('DCR_SERIAL','Whether to restrict serial wise docket number','" + optdcrserial.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            ////////////////////////2
            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_VOID'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_VOID','Whether to restrict void docket ','" + optdcrvoid.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            ///////////////////////////////////////////////////3

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='DCR_BUSINESS'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('DCR_BUSINESS','Whether to restrict business type from DCR','" + optbusinessdcr.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////////4

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='DCR_TRANSMODE'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('DCR_TRANSMODE','Whether to restrict transmode from business type','" + opttranmodedcr.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////5

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='DOC_DTL'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('DOC_DTL','Whether to restrict transmode from business type','" + optdocdetails.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////6

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='EDD_TRANSIT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('EDD_TRANSIT','Whether to get edd from transit master','" + opteddtransit.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////7

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='EDD_NDAYS'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('EDD_NDAYS','How many days to add in EDD','" + txttrdays.Text.Trim() + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////8

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FCITY_MSTR'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FCITY_MSTR','Whether to get from and to city from master','" + optmastercities.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////9

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='CSGN_MSTR'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('CSGN_MSTR','Whether to get consignor and consignee from master','" + optmastercsgne.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////9

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_LOT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_LOT','Whether to show load type or not','" + optloadtype.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////10

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_DOPI'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_DOPI','Whether to show dopi number or not','" + optdopi.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////11

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_MULTI_PICKUPDEL'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_MULTI_PICKUPDEL','Whether to Show MultiPickUp delivery feature','" + optmultipickupdel.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////12

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_PRORATA'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_PRORATA','Whether to apply prorata or not','" + optprorata.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////13

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_ROUND'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_ROUND','Whether to round off subtotal,servicetax,educess, hcess,dkttotal','" + optround.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////14


            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_FTL_FILTER'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_FTL_FILTER','whether to apply FTL filter from contract','" + optftlfilter.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////14

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='CHRG_RULE'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('CHRG_RULE','Charges Based On','" + optchargerule.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////14

            sqlstr = "DELETE FROM webx_rules_docket WHERE code='FLAG_INTRASTATE'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_rules_docket VALUES('FLAG_INTRASTATE','Whether to use Intra State or not','" + optintrastate.SelectedValue + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////14


            sqlstr = "DELETE FROM webx_rules_docket WHERE code='RANGE_DKTDT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            string dtrange = "", hrrange = "";

            if (chkbydate.Checked == true)
                dtrange = "Y,";
            else
                dtrange = "N,";

            if (optdtblwnodays.Checked == true)
                dtrange = dtrange + "B_D";
            else if (optdtblwtilldate.Checked == true)
                dtrange = dtrange + "B_T";

            if (optdtabvnodays.Checked == true)
                dtrange = dtrange + ",A_D";
            else if (optdtabvtilldate.Checked == true)
                dtrange = dtrange + ",A_T";

            string blwnodays, abvnodays;
            blwnodays = txtdtblwnodays.Text.CompareTo("") == 0 ? "0" : txtdtblwnodays.Text;
            abvnodays = txtdtabvnodays.Text.CompareTo("") == 0 ? "0" : txtdtabvnodays.Text;

            dtrange = dtrange + "," + blwnodays + "," + abvnodays + "," + txtblwdate.Text + "," + txtabvdate.Text;

            if (chkbyhour.Checked == true)
                hrrange = "Y," + hrrange;
            else
                hrrange = "N," + hrrange;

            if (opthrblwhours.Checked == true)
                hrrange = hrrange + "B_D";

            if (opthrabvhours.Checked == true)
                hrrange = hrrange + ",A_D";

            hrrange = hrrange + "," + txthrblwhours.Text + "," + txthrabvhours.Text;


            sqlstr = "INSERT INTO webx_rules_docket VALUES('RANGE_DKTDT','Range of Docket Date','" + dtrange + "|" + hrrange + "',0,0,'ALL','Y','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //////////////////////////////////////////////14
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Error.");
            return;
        }

        trn.Commit();
        Response.Redirect("DocketCustomization_Step3.aspx");
    }
}
