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

public partial class GUI_admin_TransitionMaster_TransitionMaster : System.Web.UI.Page
{
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
     cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    }

    public void instCityVal()
    {
        if (chk1.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc1.Text + "','" + txtDestLoc1.Text + "','" + Convert.ToInt32(txtRoadDay1.Text) + "','" + Convert.ToInt32(txtRoadDist1.Text) + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + Convert.ToInt32(txtRoadRate1.Text) + "', '" + Convert.ToInt32(txtRoadPkg1.Text) + "'," +
            "'" + Convert.ToInt32(txtRailDay1.Text) + "','" + Convert.ToInt32(txtRailDist1.Text) + "','" + Convert.ToInt32(txtRailRate1.Text) + "','" + Convert.ToInt32(txtRailPkg1.Text) + "','" + Convert.ToInt32(txtAirDay1.Text) + "'," +
            "'" + Convert.ToInt32(txtAirDist1.Text) + "','" + Convert.ToInt32(txtAirRate1.Text) + "','" + Convert.ToInt32(txtAirPkg1.Text) + "','" + Convert.ToInt32(txtExpressDay1.Text) + "','" + Convert.ToInt32(txtExpressDist1.Text) + "'," +
            "'" + Convert.ToInt32(txtExpressRate1.Text) + "','" + Convert.ToInt32(txtExpressPkg1.Text) + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk2.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc2.Text + "','" + txtDestLoc2.Text + "','" + txtRoadDay2.Text + "','" + txtRoadDist2.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate2.Text + "', '" + txtRoadPkg2.Text + "'," +
            "'" + txtRailDay2.Text + "','" + txtRailDist2.Text + "','" + txtRailRate2.Text + "','" + txtRailPkg2.Text + "','" + txtAirDay2.Text + "'," +
            "'" + txtAirDist2.Text + "','" + txtAirRate2.Text + "','" + txtAirPkg2.Text + "','" + txtExpressDay2.Text + "','" + txtExpressDist2.Text + "'," +
            "'" + txtExpressRate2.Text + "','" + txtExpressPkg2.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk3.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc3.Text + "','" + txtDestLoc3.Text + "','" + txtRoadDay3.Text + "','" + txtRoadDist3.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate3.Text + "', '" + txtRoadPkg1.Text + "'," +
            "'" + txtRailDay3.Text + "','" + txtRailDist3.Text + "','" + txtRailRate3.Text + "','" + txtRailPkg3.Text + "','" + txtAirDay1.Text + "'," +
            "'" + txtAirDist3.Text + "','" + txtAirRate3.Text + "','" + txtAirPkg3.Text + "','" + txtExpressDay3.Text + "','" + txtExpressDist3.Text + "'," +
            "'" + txtExpressRate3.Text + "','" + txtExpressPkg3.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk4.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc4.Text + "','" + txtDestLoc4.Text + "','" + txtRoadDay4.Text + "','" + txtRoadDist4.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate4.Text + "', '" + txtRoadPkg4.Text + "'," +
            "'" + txtRailDay4.Text + "','" + txtRailDist4.Text + "','" + txtRailRate4.Text + "','" + txtRailPkg4.Text + "','" + txtAirDay4.Text + "'," +
            "'" + txtAirDist4.Text + "','" + txtAirRate4.Text + "','" + txtAirPkg4.Text + "','" + txtExpressDay4.Text + "','" + txtExpressDist4.Text + "'," +
            "'" + txtExpressRate4.Text + "','" + txtExpressPkg4.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk5.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc5.Text + "','" + txtDestLoc5.Text + "','" + txtRoadDay5.Text + "','" + txtRoadDist5.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate5.Text + "', '" + txtRoadPkg5.Text + "'," +
            "'" + txtRailDay5.Text + "','" + txtRailDist5.Text + "','" + txtRailRate5.Text + "','" + txtRailPkg5.Text + "','" + txtAirDay5.Text + "'," +
            "'" + txtAirDist5.Text + "','" + txtAirRate5.Text + "','" + txtAirPkg5.Text + "','" + txtExpressDay5.Text + "','" + txtExpressDist5.Text + "'," +
            "'" + txtExpressRate5.Text + "','" + txtExpressPkg5.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk6.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc6.Text + "','" + txtDestLoc6.Text + "','" + txtRoadDay6.Text + "','" + txtRoadDist6.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate6.Text + "', '" + txtRoadPkg6.Text + "'," +
            "'" + txtRailDay6.Text + "','" + txtRailDist6.Text + "','" + txtRailRate6.Text + "','" + txtRailPkg6.Text + "','" + txtAirDay6.Text + "'," +
            "'" + txtAirDist6.Text + "','" + txtAirRate6.Text + "','" + txtAirPkg6.Text + "','" + txtExpressDay6.Text + "','" + txtExpressDist6.Text + "'," +
            "'" + txtExpressRate6.Text + "','" + txtExpressPkg6.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk7.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc7.Text + "','" + txtDestLoc7.Text + "','" + txtRoadDay7.Text + "','" + txtRoadDist7.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate7.Text + "', '" + txtRoadPkg7.Text + "'," +
            "'" + txtRailDay7.Text + "','" + txtRailDist7.Text + "','" + txtRailRate7.Text + "','" + txtRailPkg7.Text + "','" + txtAirDay7.Text + "'," +
            "'" + txtAirDist7.Text + "','" + txtAirRate7.Text + "','" + txtAirPkg7.Text + "','" + txtExpressDay7.Text + "','" + txtExpressDist7.Text + "'," +
            "'" + txtExpressRate7.Text + "','" + txtExpressPkg7.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk8.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc8.Text + "','" + txtDestLoc8.Text + "','" + txtRoadDay8.Text + "','" + txtRoadDist8.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate8.Text + "', '" + txtRoadPkg8.Text + "'," +
            "'" + txtRailDay8.Text + "','" + txtRailDist8.Text + "','" + txtRailRate8.Text + "','" + txtRailPkg8.Text + "','" + txtAirDay8.Text + "'," +
            "'" + txtAirDist8.Text + "','" + txtAirRate8.Text + "','" + txtAirPkg8.Text + "','" + txtExpressDay8.Text + "','" + txtExpressDist8.Text + "'," +
            "'" + txtExpressRate8.Text + "','" + txtExpressPkg8.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk9.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc9.Text + "','" + txtDestLoc9.Text + "','" + txtRoadDay9.Text + "','" + txtRoadDist9.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate9.Text + "', '" + txtRoadPkg9.Text + "'," +
            "'" + txtRailDay9.Text + "','" + txtRailDist9.Text + "','" + txtRailRate9.Text + "','" + txtRailPkg9.Text + "','" + txtAirDay9.Text + "'," +
            "'" + txtAirDist9.Text + "','" + txtAirRate9.Text + "','" + txtAirPkg9.Text + "','" + txtExpressDay9.Text + "','" + txtExpressDist9.Text + "'," +
            "'" + txtExpressRate9.Text + "','" + txtExpressPkg9.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
        if (chk10.Checked == true)
        {
            cn.Open();
            string spsql = "Insert into webx_trms values('" + txtCityLoc10.Text + "','" + txtDestLoc10.Text + "','" + txtRoadDay10.Text + "','" + txtRoadDist10.Text + "'," +
            "'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','NULL','" + txtRoadRate10.Text + "', '" + txtRoadPkg10.Text + "'," +
            "'" + txtRailDay10.Text + "','" + txtRailDist10.Text + "','" + txtRailRate10.Text + "','" + txtRailPkg10.Text + "','" + txtAirDay10.Text + "'," +
            "'" + txtAirDist10.Text + "','" + txtAirRate10.Text + "','" + txtAirPkg10.Text + "','" + txtExpressDay10.Text + "','" + txtExpressDist10.Text + "'," +
            "'" + txtExpressRate10.Text + "','" + txtExpressPkg10.Text + "')";
            SqlCommand valCmd = new SqlCommand(spsql, cn);
            valCmd.ExecuteNonQuery();
            cn.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        instCityVal();
    }
}
