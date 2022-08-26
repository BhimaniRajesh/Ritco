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

public partial class GUI_UNI_MIS_TDS_STMT_TDS_Report : System.Web.UI.Page
{
    string Code, Code1, Sql;
    public static string strDateRange,err;
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {  getstring();
        getstring2();
            BindGrid();
        }
        btn_csv.Attributes.Add("onclick", "javascript:return ch()");
        err = "";
    }
    
    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT empid FROM  webx_master_users";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["empid"] + "'"));
        }
        dr_Location.Close();
    }

    private void getstring2()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT loccode FROM  webx_location where activeflag='Y'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //    SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");

        // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
        conn.Open();

        strDateRange = Request.QueryString["strDateRange"].ToString();

        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt = strArrDtFromTo[0];
        string strtodt = strArrDtFromTo[1];

        string wheredtrange = " and (convert(datetime,b.FIXEDASSETdt,106)";

        wheredtrange = wheredtrange + "  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106))";

        string fcd=Request.QueryString["po"].ToString();

        string s1 = "";


        if (fcd == "")
        {
            s1 = "SELECT distinct A.FIXEDASSETCD,a.allotcd,a.assetcd,a.loccode,b.assign,Convert(varchar,b.billdt,106) as billdt,Convert(varchar,b.fixedassetdt,106) as fixedassetdt,(select assetname from webx_assetmaster where assetcd=a.assetcd) as assetnm fROM webx_FAALLOT_DET A, webx_FIXEDASSETS_DET B WHERE A.ACTIVEFLAG='N' AND ( b.ASSIGN='N'  or b.ASSIGN is null  ) AND A.FIXEDASSETCD=b.FIXEDASSETCD" + wheredtrange + " and b.grpcd=a.assetcd";
        }
        else
        {

            s1 = "SELECT distinct A.FIXEDASSETCD,a.allotcd,a.assetcd,a.loccode,b.assign,Convert(varchar,b.billdt,106) as billdt,Convert(varchar,b.fixedassetdt,106) as fixedassetdt,(select assetname from webx_assetmaster where assetcd=a.assetcd) as assetnm fROM webx_FAALLOT_DET A, webx_FIXEDASSETS_DET B WHERE A.ACTIVEFLAG='N' AND ( b.ASSIGN='N'  or b.ASSIGN is null  ) AND A.FIXEDASSETCD='" + fcd + "' and A.FIXEDASSETCD=b.FIXEDASSETCD" + wheredtrange + " and b.grpcd=a.assetcd";
        }


        SqlCommand sqlcmd = new SqlCommand(s1, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        ds = new DataSet();
        da.Fill(ds);
        dgTDSRpt.DataSource = ds;
        dgTDSRpt.DataBind();


    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgTDSRpt.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtloc1 = (TextBox)(e.Row.FindControl("txtloc"));



            ((Button)(e.Row.FindControl("btncodepopup"))).Attributes.Add("onclick", "javascript:return nwOpen2('" + txtloc1.ClientID.ToString() + "')");


        }


    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        conn.Open();
        string sql = "", sql2 = "", sql3 = "";


        //   string pocd = getnewcd();

 

        foreach (GridViewRow gridrow in dgTDSRpt.Rows)
        {

            CheckBox c = (CheckBox)gridrow.FindControl("chksrno");

            if (c.Checked == true)
            {

                TextBox txtloc = (TextBox)gridrow.FindControl("txtloc");
                TextBox txtdesc = (TextBox)gridrow.FindControl("txtdesc");
                TextBox txtdeptnm = (TextBox)gridrow.FindControl("txtdeptnm");
                TextBox txtemp = (TextBox)gridrow.FindControl("txtemp");
                TextBox txtdt = (TextBox)gridrow.FindControl("txtdt");


                string allocd = gridrow.Cells[1].Text;
                string actcd = gridrow.Cells[2].Text;
                string grncd = gridrow.Cells[3].Text;
                string grndt = gridrow.Cells[4].Text;


                string billdt = gridrow.Cells[5].Text;
                string actnm = gridrow.Cells[6].Text;
                string currloc = gridrow.Cells[7].Text;



                sql = "update webx_faallot_det set  assign='Y',activeflag='Y',next_loccode='" + txtloc.Text + "', next_loccaddress='" + txtloc.Text + "',nextloc_dept='" + txtdeptnm.Text + "',assgnempcd='" + txtemp.Text + "',instdate='" + txtdt.Text + "' where allotcd='" + allocd + "'";
              //  sql2 = "update webx_fixedassets_det set assign='Y' where fixedassetcd in('" + grncd + "') and grpcd='" + actcd + "'";
                sql3 = "update webx_fixedassets_hdr set postatus='A' where fixedassetcd='" + grncd + "'";



                try
                {
                    SqlCommand sqlcmd = new SqlCommand(sql, conn);
                  //  SqlCommand sqlcmd2 = new SqlCommand(sql2, conn);
                    SqlCommand sqlcmd3 = new SqlCommand(sql3, conn);

                    sqlcmd.ExecuteNonQuery();
                  //  sqlcmd2.ExecuteNonQuery();
                    sqlcmd3.ExecuteNonQuery();
                   // Response.Redirect("fa.aspx");

                }
                catch (Exception e1)
                {
                   err = e1.Message;
                }




            } // if

        } //for

        if (err == "")
        {
            Response.Redirect("fa.aspx");
        }
        else
        {
            lblerr.Text = err;
            pnl1.Visible = false;
            plnerr.Visible = true;

        }

    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("fa.aspx");
    }




}

