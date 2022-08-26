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

public partial class GUI_admin_TransitionMaster_TransitionMasterEdit : System.Web.UI.Page
{
    SqlConnection cn;

    public static string strtOrgnBranch;
    public static string strtTransLocCod;
    public static string strtDestBranch;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        strtTransLocCod = Session["tTransLocCod"].ToString().Trim();
        strtOrgnBranch = Session["tOrgnBranch"].ToString().Trim();
        strtDestBranch = Session["tDestBranch"].ToString().Trim();

        getData(); 
    }

    public void getData()
    {
        string sqlGet = "";
        cn.Open();
        if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
        {
            sqlGet = "Select TRORGN,TRDEST,trdays_Rail,TRDIST_Rail,STD_RATE_PER_KG_Rail,STD_RATE_PER_PKG_Rail,trdays,TRDIST,STD_RATE_PER_KG,STD_RATE_PER_PKG,trdays_Air,TRDIST_Air,STD_RATE_PER_KG_Air,STD_RATE_PER_PKG_Air,trdays_exp,isnull(trdays_exp,0) as trdays_exp,isnull(trdist_exp,0) as trdist_exp,isnull(std_rate_per_kg_exp,0) as  std_rate_per_kg_exp,isnull(std_rate_per_pkg_exp,0) as std_rate_per_pkg_exp From webx_trms where TRORGN='" + strtOrgnBranch + "' and TRDEST='" + strtDestBranch + "'";
        }
        if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
        {
            sqlGet = "Select TRORGN,TRDEST,trdays_Rail,TRDIST_Rail,STD_RATE_PER_KG_Rail,STD_RATE_PER_PKG_Rail,trdays,TRDIST,STD_RATE_PER_KG,STD_RATE_PER_PKG,trdays_Air,TRDIST_Air,STD_RATE_PER_KG_Air,STD_RATE_PER_PKG_Air,isnull(trdays_exp,0) as trdays_exp,isnull(trdist_exp,0) as trdist_exp,isnull(std_rate_per_kg_exp,0) as  std_rate_per_kg_exp,isnull(std_rate_per_pkg_exp,0) as std_rate_per_pkg_exp From webx_trms where TRORGN='" + strtTransLocCod + "'";  // or TRDEST='" + strtTransLocCod + "'";
        }
        SqlCommand cmd = new SqlCommand(sqlGet, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        int totRow = ds.Tables[0].Rows.Count;
        if (totRow == 0)
        {
            lblMsg.Text = "Record not found";
        }
        else
        {
            lblMsg.Text = "";
            for (int i = 0; i <= totRow - 1; i++)
            {
                if (i == 0)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[0][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[0][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[0][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[0][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[0][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[0][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[0][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[0][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[0][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[0][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[0][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[0][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[0][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[0][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[0][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[0][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[0][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[0][17].ToString();

                    chk1.Checked = true;
                }

                if (i == 1)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[1][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[1][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[1][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[1][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[1][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[1][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[1][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[1][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[1][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[1][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[1][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[1][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[1][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[1][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[1][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[1][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[1][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[1][17].ToString();

                    chk2.Checked = true;
                }

                if (i == 2)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[2][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[2][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[2][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[2][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[2][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[2][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[2][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[2][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[2][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[2][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[2][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[2][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[2][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[2][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[2][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[2][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[2][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[2][17].ToString();

                    chk3.Checked = true;
                }

                if (i == 3)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[3][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[3][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[3][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[3][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[3][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[3][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[3][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[3][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[3][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[3][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[3][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[3][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[3][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[3][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[3][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[3][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[3][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[3][17].ToString();

                    chk4.Checked = true;
                }

                if (i == 4)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[4][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[4][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[4][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[4][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[4][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[4][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[4][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[4][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[4][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[4][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[4][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[4][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[4][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[4][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[4][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[4][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[4][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[4][17].ToString();

                    chk5.Checked = true;
                }

                if (i == 5)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[5][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[5][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[5][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[5][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[5][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[5][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[5][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[5][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[5][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[5][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[5][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[5][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[5][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[5][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[5][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[5][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[5][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[5][17].ToString();

                    chk6.Checked = true;
                }

                if (i == 6)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[6][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[6][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[6][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[6][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[6][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[6][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[6][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[6][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[6][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[6][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[6][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[6][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[6][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[6][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[6][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[6][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[6][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[6][17].ToString();

                    chk7.Checked = true;
                }

                if (i == 7)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[7][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[7][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[7][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[7][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[7][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[7][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[7][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[7][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[7][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[7][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[7][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[7][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[7][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[7][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[7][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[7][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[7][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[7][17].ToString();

                    chk8.Checked = true;
                }

                if (i == 8)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[8][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[8][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[8][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[8][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[8][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[8][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[8][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[8][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[8][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[8][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[8][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[8][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[8][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[8][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[8][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[8][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[8][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[8][17].ToString();

                    chk9.Checked = true;
                }

                if (i == 9)
                {

                    txtCityLoc1.Text = ds.Tables[0].Rows[9][0].ToString();
                    txtDestLoc1.Text = ds.Tables[0].Rows[9][1].ToString();

                    txtRailDay1.Text = ds.Tables[0].Rows[9][2].ToString();
                    txtRailDist1.Text = ds.Tables[0].Rows[9][3].ToString();
                    txtRailRate1.Text = ds.Tables[0].Rows[9][4].ToString();
                    txtRailPkg1.Text = ds.Tables[0].Rows[9][5].ToString();

                    txtRoadDay1.Text = ds.Tables[0].Rows[9][6].ToString();
                    txtRoadDist1.Text = ds.Tables[0].Rows[9][7].ToString();
                    txtRoadRate1.Text = ds.Tables[0].Rows[9][8].ToString();
                    txtRoadPkg1.Text = ds.Tables[0].Rows[9][9].ToString();

                    txtAirDay1.Text = ds.Tables[0].Rows[9][10].ToString();
                    txtAirDist1.Text = ds.Tables[0].Rows[9][11].ToString();
                    txtAirRate1.Text = ds.Tables[0].Rows[9][12].ToString();
                    txtAirPkg1.Text = ds.Tables[0].Rows[9][13].ToString();

                    txtExpressDay1.Text = ds.Tables[0].Rows[9][14].ToString();
                    txtExpressDist1.Text = ds.Tables[0].Rows[9][15].ToString();
                    txtExpressRate1.Text = ds.Tables[0].Rows[9][16].ToString();
                    txtExpressPkg1.Text = ds.Tables[0].Rows[9][17].ToString();

                    chk10.Checked = true;
                }
            }
        }
    }
    
    public void instCityVal()
    {
        if (chk1.Checked == true)
        {
            string sqlUpdt1="";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt1 = "update webx_trms set TRORGN = '" + txtCityLoc1.Text + "',TRDEST = '" + txtDestLoc1.Text + "',trdays_Rail = '" + txtRailDay1.Text + "',TRDIST_Rail = '" + txtRailDist1.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate1.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg1.Text + "',trdays_Air = '" + txtAirDay1.Text + "',TRDIST_Air = '" + txtAirDist1.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate1.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg1.Text + "',trdays_exp = '" + txtExpressDay1.Text + "',trdist_exp = '" + txtExpressDist1.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate1.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg1.Text + "' where TRDEST = '" + strtDestBranch + "'";  
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt1 = "update webx_trms set TRORGN = '" + txtCityLoc1.Text + "',TRDEST = '" + txtDestLoc1.Text + "',trdays_Rail = '" + txtRailDay1.Text + "',TRDIST_Rail = '" + txtRailDist1.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate1.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg1.Text + "',trdays_Air = '" + txtAirDay1.Text + "',TRDIST_Air = '" + txtAirDist1.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate1.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg1.Text + "',trdays_exp = '" + txtExpressDay1.Text + "',trdist_exp = '" + txtExpressDist1.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate1.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg1.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'"; 
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt1, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk2.Checked == true)
        {
            string sqlUpdt2 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt2 = "update webx_trms set TRORGN = '" + txtCityLoc2.Text + "',TRDEST = '" + txtDestLoc2.Text + "',trdays_Rail = '" + txtRailDay2.Text + "',TRDIST_Rail = '" + txtRailDist2.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate2.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg2.Text + "',trdays_Air = '" + txtAirDay2.Text + "',TRDIST_Air = '" + txtAirDist2.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate2.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg2.Text + "',trdays_exp = '" + txtExpressDay2.Text + "',trdist_exp = '" + txtExpressDist2.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate2.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg2.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt2 = "update webx_trms set TRORGN = '" + txtCityLoc2.Text + "',TRDEST = '" + txtDestLoc2.Text + "',trdays_Rail = '" + txtRailDay2.Text + "',TRDIST_Rail = '" + txtRailDist2.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate2.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg2.Text + "',trdays_Air = '" + txtAirDay2.Text + "',TRDIST_Air = '" + txtAirDist2.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate2.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg2.Text + "',trdays_exp = '" + txtExpressDay2.Text + "',trdist_exp = '" + txtExpressDist2.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate2.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg2.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt2, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk3.Checked == true)
        {
            string sqlUpdt3 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt3 = "update webx_trms set TRORGN = '" + txtCityLoc3.Text + "',TRDEST = '" + txtDestLoc3.Text + "',trdays_Rail = '" + txtRailDay3.Text + "',TRDIST_Rail = '" + txtRailDist3.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate3.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg3.Text + "',trdays_Air = '" + txtAirDay3.Text + "',TRDIST_Air = '" + txtAirDist3.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate3.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg3.Text + "',trdays_exp = '" + txtExpressDay3.Text + "',trdist_exp = '" + txtExpressDist3.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate3.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg3.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt3 = "update webx_trms set TRORGN = '" + txtCityLoc3.Text + "',TRDEST = '" + txtDestLoc3.Text + "',trdays_Rail = '" + txtRailDay3.Text + "',TRDIST_Rail = '" + txtRailDist3.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate3.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg3.Text + "',trdays_Air = '" + txtAirDay3.Text + "',TRDIST_Air = '" + txtAirDist3.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate3.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg3.Text + "',trdays_exp = '" + txtExpressDay3.Text + "',trdist_exp = '" + txtExpressDist3.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate3.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg3.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt3, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk4.Checked == true)
        {
            string sqlUpdt4 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt4 = "update webx_trms set TRORGN = '" + txtCityLoc4.Text + "',TRDEST = '" + txtDestLoc4.Text + "',trdays_Rail = '" + txtRailDay4.Text + "',TRDIST_Rail = '" + txtRailDist4.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate4.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg4.Text + "',trdays_Air = '" + txtAirDay4.Text + "',TRDIST_Air = '" + txtAirDist4.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate4.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg4.Text + "',trdays_exp = '" + txtExpressDay4.Text + "',trdist_exp = '" + txtExpressDist4.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate4.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg4.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt4 = "update webx_trms set TRORGN = '" + txtCityLoc4.Text + "',TRDEST = '" + txtDestLoc4.Text + "',trdays_Rail = '" + txtRailDay4.Text + "',TRDIST_Rail = '" + txtRailDist4.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate4.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg4.Text + "',trdays_Air = '" + txtAirDay4.Text + "',TRDIST_Air = '" + txtAirDist4.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate4.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg4.Text + "',trdays_exp = '" + txtExpressDay4.Text + "',trdist_exp = '" + txtExpressDist4.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate4.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg4.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt4, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk5.Checked == true)
        {
            string sqlUpdt5 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt5 = "update webx_trms set TRORGN = '" + txtCityLoc5.Text + "',TRDEST = '" + txtDestLoc5.Text + "',trdays_Rail = '" + txtRailDay5.Text + "',TRDIST_Rail = '" + txtRailDist5.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate5.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg5.Text + "',trdays_Air = '" + txtAirDay5.Text + "',TRDIST_Air = '" + txtAirDist5.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate4.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg4.Text + "',trdays_exp = '" + txtExpressDay4.Text + "',trdist_exp = '" + txtExpressDist4.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate5.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg5.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt5 = "update webx_trms set TRORGN = '" + txtCityLoc5.Text + "',TRDEST = '" + txtDestLoc5.Text + "',trdays_Rail = '" + txtRailDay5.Text + "',TRDIST_Rail = '" + txtRailDist5.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate5.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg5.Text + "',trdays_Air = '" + txtAirDay5.Text + "',TRDIST_Air = '" + txtAirDist5.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate4.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg4.Text + "',trdays_exp = '" + txtExpressDay4.Text + "',trdist_exp = '" + txtExpressDist4.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate5.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg5.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt5, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk6.Checked == true)
        {
            string sqlUpdt6 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt6 = "update webx_trms set TRORGN = '" + txtCityLoc6.Text + "',TRDEST = '" + txtDestLoc6.Text + "',trdays_Rail = '" + txtRailDay6.Text + "',TRDIST_Rail = '" + txtRailDist6.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate6.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg6.Text + "',trdays_Air = '" + txtAirDay6.Text + "',TRDIST_Air = '" + txtAirDist6.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate6.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg6.Text + "',trdays_exp = '" + txtExpressDay6.Text + "',trdist_exp = '" + txtExpressDist6.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate6.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg6.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt6 = "update webx_trms set TRORGN = '" + txtCityLoc6.Text + "',TRDEST = '" + txtDestLoc6.Text + "',trdays_Rail = '" + txtRailDay6.Text + "',TRDIST_Rail = '" + txtRailDist6.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate6.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg6.Text + "',trdays_Air = '" + txtAirDay6.Text + "',TRDIST_Air = '" + txtAirDist6.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate6.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg6.Text + "',trdays_exp = '" + txtExpressDay6.Text + "',trdist_exp = '" + txtExpressDist6.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate6.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg6.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt6, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk7.Checked == true)
        {
            string sqlUpdt7 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt7 = "update webx_trms set TRORGN = '" + txtCityLoc7.Text + "',TRDEST = '" + txtDestLoc7.Text + "',trdays_Rail = '" + txtRailDay7.Text + "',TRDIST_Rail = '" + txtRailDist7.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate7.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg7.Text + "',trdays_Air = '" + txtAirDay7.Text + "',TRDIST_Air = '" + txtAirDist7.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate7.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg7.Text + "',trdays_exp = '" + txtExpressDay7.Text + "',trdist_exp = '" + txtExpressDist7.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate7.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg7.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt7 = "update webx_trms set TRORGN = '" + txtCityLoc7.Text + "',TRDEST = '" + txtDestLoc7.Text + "',trdays_Rail = '" + txtRailDay7.Text + "',TRDIST_Rail = '" + txtRailDist7.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate7.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg7.Text + "',trdays_Air = '" + txtAirDay7.Text + "',TRDIST_Air = '" + txtAirDist7.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate7.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg7.Text + "',trdays_exp = '" + txtExpressDay7.Text + "',trdist_exp = '" + txtExpressDist7.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate7.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg7.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt7, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk8.Checked == true)
        {
            string sqlUpdt8 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt8 = "update webx_trms set TRORGN = '" + txtCityLoc8.Text + "',TRDEST = '" + txtDestLoc8.Text + "',trdays_Rail = '" + txtRailDay8.Text + "',TRDIST_Rail = '" + txtRailDist8.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate8.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg8.Text + "',trdays_Air = '" + txtAirDay8.Text + "',TRDIST_Air = '" + txtAirDist8.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate8.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg8.Text + "',trdays_exp = '" + txtExpressDay8.Text + "',trdist_exp = '" + txtExpressDist8.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate8.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg8.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt8 = "update webx_trms set TRORGN = '" + txtCityLoc8.Text + "',TRDEST = '" + txtDestLoc8.Text + "',trdays_Rail = '" + txtRailDay8.Text + "',TRDIST_Rail = '" + txtRailDist8.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate8.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg8.Text + "',trdays_Air = '" + txtAirDay8.Text + "',TRDIST_Air = '" + txtAirDist8.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate8.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg8.Text + "',trdays_exp = '" + txtExpressDay8.Text + "',trdist_exp = '" + txtExpressDist8.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate8.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg8.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt8, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk9.Checked == true)
        {
            string sqlUpdt9 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt9 = "update webx_trms set TRORGN = '" + txtCityLoc9.Text + "',TRDEST = '" + txtDestLoc9.Text + "',trdays_Rail = '" + txtRailDay9.Text + "',TRDIST_Rail = '" + txtRailDist9.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate9.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg9.Text + "',trdays_Air = '" + txtAirDay9.Text + "',TRDIST_Air = '" + txtAirDist9.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate9.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg9.Text + "',trdays_exp = '" + txtExpressDay9.Text + "',trdist_exp = '" + txtExpressDist9.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate9.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg9.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt9 = "update webx_trms set TRORGN = '" + txtCityLoc9.Text + "',TRDEST = '" + txtDestLoc9.Text + "',trdays_Rail = '" + txtRailDay9.Text + "',TRDIST_Rail = '" + txtRailDist9.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate9.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg9.Text + "',trdays_Air = '" + txtAirDay9.Text + "',TRDIST_Air = '" + txtAirDist9.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate9.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg9.Text + "',trdays_exp = '" + txtExpressDay9.Text + "',trdist_exp = '" + txtExpressDist9.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate9.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg9.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt9, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk10.Checked == true)
        {
            string sqlUpdt10 = "";
            cn.Open();
            if (strtTransLocCod == "" && strtOrgnBranch != "" && strtDestBranch != "")
            {
                sqlUpdt10 ="update webx_trms set TRORGN = '" + txtCityLoc10.Text + "',TRDEST = '" + txtDestLoc10.Text + "',trdays_Rail = '" + txtRailDay10.Text + "',TRDIST_Rail = '" + txtRailDist10.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate10.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg10.Text + "',trdays_Air = '" + txtAirDay10.Text + "',TRDIST_Air = '" + txtAirDist10.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate10.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg10.Text + "',trdays_exp = '" + txtExpressDay10.Text + "',trdist_exp = '" + txtExpressDist10.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate10.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg10.Text + "' where TRDEST = '" + strtDestBranch + "'";
            }
            if (strtTransLocCod != "" && strtOrgnBranch == "" && strtDestBranch == "")
            {
                sqlUpdt10 = "update webx_trms set TRORGN = '" + txtCityLoc10.Text + "',TRDEST = '" + txtDestLoc10.Text + "',trdays_Rail = '" + txtRailDay10.Text + "',TRDIST_Rail = '" + txtRailDist10.Text + "'" +
                           "STD_RATE_PER_KG_Rail = '" + txtRailRate10.Text + "',STD_RATE_PER_PKG_Rail = '" + txtRailPkg10.Text + "',trdays_Air = '" + txtAirDay10.Text + "',TRDIST_Air = '" + txtAirDist10.Text + "'" +
                           "STD_RATE_PER_KG_Air = '" + txtAirRate10.Text + "',STD_RATE_PER_PKG_Air = '" + txtAirPkg10.Text + "',trdays_exp = '" + txtExpressDay10.Text + "',trdist_exp = '" + txtExpressDist10.Text + "'" +
                           "std_rate_per_kg_exp = '" + txtExpressRate10.Text + "',std_rate_per_pkg_exp = '" + txtExpressPkg10.Text + "' where strtTransLocCod = '" + strtTransLocCod + "'";
            }
            SqlCommand valCmd = new SqlCommand(sqlUpdt10, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        instCityVal();
    }
}

