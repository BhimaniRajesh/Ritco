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

public partial class ViewCustomerContractStep3 : System.Web.UI.Page
{
    string custcode = "";
    SqlConnection con;

    static DataTable dtbranch;
    static DataTable dtzone;
    static DataTable dtcity;

    MyFunctions fn = new MyFunctions();
    string strtrnmodes = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToUpper();

        dtbranch = new DataTable();
        dtzone = new DataTable();
        dtcity = new DataTable();

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        lblcustcode.Text = custcode;
        
        // RETRIVIN TRANSPORT MODES
        string sqlval = "SELECT  road_yn,express_yn,air_yn,rail_yn,sundry_yn,ftl_yn FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
        SqlCommand cmd = new SqlCommand(sqlval, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = "R";
            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",E";
            if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",A";
            if (dr["rail_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                strtrnmodes = strtrnmodes + ",T";
        }
        dr.Close();

        

        //RETRIEVING DATA OF BRANCH
        string strretrieve = "SELECT rate_type,fromlocode,tolocode,air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_locdet WHERE custcode='" + custcode + "'";
        cmd = new SqlCommand(strretrieve, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dtbranch);
        if (dtbranch.Rows.Count <= 0)
        {
            dtbranch.Rows.Add();
        }
        else
        {
            lblratetype.Text = dtbranch.Rows[0]["rate_type"].ToString();
        }
        grvbranch.DataSource = dtbranch;
        grvbranch.DataBind();


        // RETRIEVING DATA OF ZONES
        strretrieve = "SELECT fromregion=(select codedesc from webx_master_general where codetype='zone' and ( codeid=fromregion or codedesc=fromregion )),toregion=(select codedesc from webx_master_general where codetype='zone' and ( codeid=toregion or codedesc=toregion )),air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_regdet WHERE  custcode='" + custcode + "'";
        cmd = new SqlCommand(strretrieve, con);
        da = new SqlDataAdapter(cmd);

        da.Fill(dtzone);
        if (dtzone.Rows.Count <= 0)
        {
            dtzone.Rows.Add();
        }
        else
        {
            lblratetype.Text = dtbranch.Rows[0]["rate_type"].ToString();
        }


        grvzone.DataSource = dtzone;
        grvzone.DataBind();


        // RETRIEVING DATA OF CITY
        strretrieve = "SELECT fromcity,tocity,air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM webx_custcontract_citydet WHERE custcode='" + custcode + "'";
        cmd = new SqlCommand(strretrieve, con);
        da = new SqlDataAdapter(cmd);

        da.Fill(dtcity);
        if (dtcity.Rows.Count <= 0)
        {
            dtcity.Rows.Add();
        }
        else
        {
            lblratetype.Text = dtbranch.Rows[0]["rate_type"].ToString();
        }


        grvcity.DataSource = dtcity;
        grvcity.DataBind();
    }




    protected void grvbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        rowBind(e);
    }

    protected void grvzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        rowBind(e);
    }

    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        rowBind(e);
    }

    protected void rowBind(GridViewRowEventArgs e)
    {
        if (strtrnmodes.IndexOf('A') == -1)
        {
            e.Row.Cells[2].Style["display"] = "none";
            e.Row.Cells[3].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('R') == -1)
        {
            e.Row.Cells[4].Style["display"] = "none";
            e.Row.Cells[5].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('T') == -1)
        {
            e.Row.Cells[6].Style["display"] = "none";
            e.Row.Cells[7].Style["display"] = "none";
        }

        if (strtrnmodes.IndexOf('E') == -1)
        {
            e.Row.Cells[8].Style["display"] = "none";
            e.Row.Cells[9].Style["display"] = "none";
        }
    }
    
}


