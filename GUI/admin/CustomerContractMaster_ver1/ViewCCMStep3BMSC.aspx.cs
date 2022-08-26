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

public partial class GUI_admin_CustomerContractMaster_ViewCCMStep3BMSC : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    SqlConnection con;

    static DataSet dsroadfreightbranch;
    static DataSet dsairfreightbranch;
    static DataSet dsexpressfreightbranch;
    static DataSet dstrainfreightbranch;

    static DataSet dsroadfreightzone;
    static DataSet dsairfreightzone;
    static DataSet dsexpressfreightzone;
    static DataSet dstrainfreightzone;

    static DataSet dsroadfreightcity;
    static DataSet dsairfreightcity;
    static DataSet dsexpressfreightcity;
    static DataSet dstrainfreightcity;

    string sqlval = "",custcode="";


    protected void Page_Load(object sender, EventArgs e)
    {

        dsroadfreightbranch = new DataSet();
        dsexpressfreightbranch = new DataSet();
        dsairfreightbranch = new DataSet();
        dstrainfreightbranch = new DataSet();

        dsroadfreightzone = new DataSet();
        dsexpressfreightzone = new DataSet();
        dsairfreightzone = new DataSet();
        dstrainfreightzone = new DataSet();

        dsroadfreightcity = new DataSet();
        dsexpressfreightcity = new DataSet();
        dsairfreightcity = new DataSet();
        dstrainfreightcity = new DataSet();


        SqlCommand cmd;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        custcode = Request.QueryString["custcode"].ToString();

        // BRANCH FIDDING
        sqlval = "SELECT ratetype=(case when rtrim(ltrim(ratetype))='W' then 'Per Kg' when rtrim(ltrim(ratetype))='P' then 'Per Package' else 'unknown' end),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='L'";
        cmd = new SqlCommand(sqlval, con);

        dsroadfreightbranch = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);

        sda.Fill(dsroadfreightbranch, "tbl1");
        if (dsroadfreightbranch.Tables[0].Rows.Count > 0)
        {
            grvroadfreightbranch.DataSource = dsroadfreightbranch;
            grvroadfreightbranch.DataBind();
        }

        sqlval = "SELECT ratetype=(case when rtrim(ltrim(ratetype))='W' then 'Per Kg' when rtrim(ltrim(ratetype))='P' then 'Per Package' else 'unknown' end),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='L'";
        cmd = new SqlCommand(sqlval, con);

        dsexpressfreightbranch = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsexpressfreightbranch, "tbl1");
        if (dsexpressfreightbranch.Tables[0].Rows.Count > 0)
        {
            grvexpressfreightbranch.DataSource = dsexpressfreightbranch;
            grvexpressfreightbranch.DataBind();
        }


        sqlval = "SELECT ratetype=(case when rtrim(ltrim(ratetype))='W' then 'Per Kg' when rtrim(ltrim(ratetype))='P' then 'Per Package' else 'unknown' end),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='AIR' AND loc_reg='L'";
        cmd = new SqlCommand(sqlval, con);

        dsairfreightbranch = new DataSet();
        sda = new SqlDataAdapter(cmd);
        sda.Fill(dsairfreightbranch, "tbl1");

        if (dsairfreightbranch.Tables[0].Rows.Count > 0)
        {

            grvairfreightbranch.DataSource = dsairfreightbranch;
            grvairfreightbranch.DataBind();
        }


        sqlval = "SELECT ratetype=(case when rtrim(ltrim(ratetype))='W' then 'Per Kg' when rtrim(ltrim(ratetype))='P' then 'Per Package' else 'unknown' end),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='TRAIN' AND loc_reg='L'";
        cmd = new SqlCommand(sqlval, con);

        dstrainfreightbranch = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dstrainfreightbranch, "tbl1");

        if (dstrainfreightbranch.Tables[0].Rows.Count > 0)
        {
            grvtrainfreightbranch.DataSource = dstrainfreightbranch;
            grvtrainfreightbranch.DataBind();
        }





        // ZONE FIDDING

        sqlval = "SELECT from_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=from_loccode or codedesc=from_loccode )),to_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=to_loccode or codedesc=to_loccode )),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='R'";
        cmd = new SqlCommand(sqlval, con);

        dsroadfreightzone = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsroadfreightzone, "tbl1");

        if (dsroadfreightzone.Tables[0].Rows.Count > 0)
        {
            grvroadfreightzone.DataSource = dsroadfreightzone;
            grvroadfreightzone.DataBind();
        }


        sqlval = "SELECT from_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=from_loccode or codedesc=from_loccode )),to_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=to_loccode or codedesc=to_loccode )),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='R'";
        cmd = new SqlCommand(sqlval, con);

        dsexpressfreightzone = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsexpressfreightzone, "tbl1");

        if (dsexpressfreightzone.Tables[0].Rows.Count > 0)
        {
            grvexpressfreightzone.DataSource = dsexpressfreightzone;
            grvexpressfreightzone.DataBind();
        }



        sqlval = "SELECT from_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=from_loccode or codedesc=from_loccode )),to_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=to_loccode or codedesc=to_loccode )),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='AIR' AND loc_reg='R'";
        cmd = new SqlCommand(sqlval, con);

        dsairfreightzone = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsairfreightzone, "tbl1");

        if (dsairfreightzone.Tables[0].Rows.Count > 0)
        {
            grvairfreightzone.DataSource = dsairfreightzone;
            grvairfreightzone.DataBind();
        }


        sqlval = "SELECT (select codedesc from webx_master_general where codetype='zone' and ( codeid=from_loccode or codedesc=from_loccode )),to_loccode=(select codedesc from webx_master_general where codetype='zone' and ( codeid=to_loccode or codedesc=to_loccode )),* FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='TRAIN' AND loc_reg='R'";
        cmd = new SqlCommand(sqlval, con);

        dstrainfreightzone = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dstrainfreightzone, "tbl1");
        if (dstrainfreightzone.Tables[0].Rows.Count > 0)
        {
            grvtrainfreightzone.DataSource = dstrainfreightzone;
            grvtrainfreightzone.DataBind();
        }

        // CITY FIDDING
        sqlval = "SELECT * FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='ROAD' AND loc_reg='C'";
        cmd = new SqlCommand(sqlval, con);

        dsroadfreightcity = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsroadfreightcity, "tbl1");
        if (dsroadfreightcity.Tables[0].Rows.Count > 0)
        {
            grvroadfreightcity.DataSource = dsroadfreightcity;
            grvroadfreightcity.DataBind();
        }

        sqlval = "SELECT * FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='EXPRESS' AND loc_reg='C'";
        cmd = new SqlCommand(sqlval, con);

        dsexpressfreightcity = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsexpressfreightcity, "tbl1");
        if (dsexpressfreightcity.Tables[0].Rows.Count > 0)
        {
            grvexpressfreightcity.DataSource = dsexpressfreightcity;
            grvexpressfreightcity.DataBind();
        }

        sqlval = "SELECT * FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='AIR' AND loc_reg='C'";
        cmd = new SqlCommand(sqlval, con);

        dsairfreightcity = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dsairfreightcity, "tbl1");
        if (dsairfreightcity.Tables[0].Rows.Count > 0)
        {
            grvairfreightcity.DataSource = dsairfreightcity;
            grvairfreightcity.DataBind();
        }

        sqlval = "SELECT * FROM webx_custcontract_frtmatrix_slabdet WHERE custcode='" + custcode + "' AND UPPER(trans_type)='TRAIN' AND loc_reg='C'";
        cmd = new SqlCommand(sqlval, con);

        dstrainfreightcity = new DataSet();
        sda = new SqlDataAdapter(cmd);

        sda.Fill(dstrainfreightcity, "tbl1");

        if (dstrainfreightcity.Tables[0].Rows.Count > 0)
        {
            grvtrainfreightcity.DataSource = dstrainfreightcity;
            grvtrainfreightcity.DataBind();
        }

    }

    protected void grvroadfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "branch");
    }

    protected void grvexpressfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "branch");
    }

    protected void grvairfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "branch");
    }

    protected void grvtrainfreightbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "branch");
    }





    protected void grvroadfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "zone");
    }

    protected void grvexpressfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "zone");
    }

    protected void grvairfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "zone");
    }

    protected void grvtrainfreightzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "zone");
    }




    protected void grvroadfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "city");
    }

    protected void grvexpressfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "city");
    }

    protected void grvairfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "city");
    }

    protected void grvtrainfreightcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        gridBind(e, "city");
    }



    protected void gridBind(GridViewRowEventArgs e, string gtype)
    {
    }

}
