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

public partial class GUI_admin_RouteMaster_RouteMaster : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strRutCd;
    static DataTable dt = new DataTable("table1");
    DataRow drow;
    String strtRutCd, strdRutSel,mode;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open(); 
        getstring();
        getallroutes();
        //js = "<script language=\"javascript\" type=\"text/javascript\">var i = 2; var count= document.getElementById(\"gvSales\").rows.length; for(i=2;i<count-1;i++) { if(i<=9){document.getElementById(\"gvSales_ctl0\" + i + \"_txtPrice\").disabled = true;}else{document.getElementById(\"gvSales_ctl\" + i + \"_txtPrice\").disabled = true;}}</script>";
        //Page.RegisterStartupScript("abc", js); 
        string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00$MyCPH1$txtDist\").disabled = true;document.getElementById(\"ctl00$MyCPH1$txttransithrs\").disabled = true</script>";
        Page.RegisterStartupScript("aaa", js);
        mode = Request.QueryString["mode"];  
        if (mode == "edit")
        {
            strtRutCd = Session["tRutCd"].ToString().Trim();
            strdRutSel = Session["dRutSel"].ToString().Trim();
            getData();
            getloopdata();
        }
    }
    protected void CmdAddRows_Click(object sender, EventArgs e)
    {

        Int32 i;
        dt.Rows.Clear();  
        if (dt != null)
        {
            //if (mode != "edit")
            //{
                //if (dt.Rows.Count > 0)
                //{
                //    dt.Rows.Clear();
                //}
            //}
            i = Convert.ToInt32(TxtRows.Text);
            if (i > 0)
            {
                for (Int32 j = i; j > 0; j--)
                {
                    drow = dt.NewRow();
                    dt.Rows.Add(drow);
                }
            }
        }
        GrdPaidFollow.DataSource = dt;
        GrdPaidFollow.DataBind();
        btnUpdt.Visible = true;
        //btnSubmit.Visible = true;
    }
    protected void getloopdata()
    {
        string sqlGetLoop = "select LOCCD,DIST_KM,TRTIME_HR,TRTIME_MIN,STTIME_HR,STTIME_MIN from webx_ruttran where rutcd = '" + lblRutCd.Text + "'";
        SqlDataAdapter da = new SqlDataAdapter(sqlGetLoop, cn);
        da.Fill(dt);
        GrdPaidFollow.DataSource = dt;
        GrdPaidFollow.DataBind();
    }
    public void getData()
    {
        string sqlGet;
        //cn.Open();
        if (strtRutCd != "")
        {
            sqlGet = "select rutcd,RUTCAT,RUTKM,ACTIVEFLAG,SCHDEP_HR,SCHDEP_MIN,STD_CONTAMT,RUTMOD,transhrs from webx_rutmas where rutcd='" + strtRutCd + "'";
        }
        else
        {
            sqlGet = "select rutcd,RUTCAT,RUTKM,ACTIVEFLAG,SCHDEP_HR,SCHDEP_MIN,STD_CONTAMT,RUTMOD,transhrs from webx_rutmas where rutnm='" + strdRutSel + "'";
        }
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {
            ddRouteCategory.Text = getDr["RUTCAT"].ToString();
            txtDist.Text = getDr["RUTKM"].ToString();
            txtActFlag.Text = getDr["ACTIVEFLAG"].ToString();
            txtSchHH.Text = getDr["SCHDEP_HR"].ToString();
            txtSchMM.Text = getDr["SCHDEP_MIN"].ToString();
            txtStandRate.Text = getDr["STD_CONTAMT"].ToString();
            ddRouteMode.Text = getDr["RUTMOD"].ToString();
            lblRutCd.Text = getDr["rutcd"].ToString();
            txttransithrs.Text = Convert.ToString(getDr["transhrs"]);
            if (txtActFlag.Text == "Y")
            {
                chkActiveFlag.Checked = true;
            }
        }
        getDr.Close();
        cn.Close();
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
    private void getallroutes()
    {
        string sql = "SELECT rutnm FROM webx_rutmas";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("routes", "'" + Convert.ToString(dr_Location["rutnm"] + "'"));
        }
        dr_Location.Close();
    }
    public string getNewCd(string strGrpCd)
    {
        int intCustCode = 1;
       // cn.Open();
        SqlCommand cmdGet = new SqlCommand("select cast(right(max(rutcd),4) as integer) + 1 from webx_rutmas where substring(rutcd,1,1)='" + strGrpCd + "'", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0] == System.DBNull.Value ? 1 : drGet[0]);
        }

        drGet.Close();
        return strGrpCd + intCustCode.ToString().PadLeft(4, '0');
        
    }

    public void instCityVal()
    {
        string routenm = "", chkbranch = "";
        Int32 k = 0;
        for (int i = 0; i < GrdPaidFollow.Rows.Count; i++)
        {
            if (((CheckBox)GrdPaidFollow.Rows[i].FindControl("ChkSelect")).Checked == true)
            {
                strRutCd = getNewCd(ddRouteCategory.SelectedValue);
                TextBox txtdistance, txtttimehr, txtttimemn, txtstimehr, txtstimemn, txtbranchname;
                txtdistance = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtdistance");
                txtttimehr = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtttimehr");
                txtttimemn = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtttimemn");
                txtstimehr = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtstimehr");
                txtstimemn = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtstimemn");
                txtbranchname = (TextBox)GrdPaidFollow.Rows[i].FindControl("txtbranchname");
                chkbranch = txtbranchname.Text;
                if (chkbranch != "")
                {
                    k += 1;
                    routenm = routenm + "-" + txtbranchname.Text;
                    String sqlAdd1 = "insert into webx_ruttran(RUTNO,RUTCD,LOCCD,DIST_KM,TRTIME_HR,TRTIME_MIN,STTIME_HR,STTIME_MIN) values('" + k + "','" + strRutCd + "','" + txtbranchname.Text + "','" + (txtdistance.Text.Trim() != "" ? Convert.ToInt32(txtdistance.Text) : Convert.ToInt32("0")) + "','" + (txtttimehr.Text.Trim() != "" ? Convert.ToInt32(txtttimehr.Text) : Convert.ToInt32("0")) + "','" + (txtttimemn.Text.Trim() != "" ? Convert.ToInt32(txtttimemn.Text) : Convert.ToInt32("0")) + "','" + (txtstimehr.Text.Trim() != "" ? Convert.ToInt32(txtstimehr.Text) : Convert.ToInt32("0")) + "','" + (txtstimemn.Text.Trim() != "" ? Convert.ToInt32(txtstimemn.Text) : Convert.ToInt32("0")) + "')";
                    SqlCommand valCmd1 = new SqlCommand(sqlAdd1, cn);
                    valCmd1.ExecuteNonQuery();
                }
                
            }
        }
        routenm = routenm.Substring(1, routenm.Length - 1);
        Array a1;
        a1 = routenm.Split('-');
        String RUTSTBR = ((string[])(a1))[0];
        String RUTENDBR = ((string[])(a1))[a1.Length - 1];
        string sqlAdd2 = "insert into webx_rutmas(RUTCD,RUTSTBR,RUTENDBR,RUTCAT,RUTKM,ACTIVEFLAG,UPDTBY,UPDTON,RUTNM,SCHDEP_HR,SCHDEP_MIN,STD_CONTAMT,RUTMOD,ControlLoc,transhrs) VALUES ('" + strRutCd + "','" + RUTSTBR + "','" + RUTENDBR + "','" + ddRouteCategory.SelectedValue + "','" + Convert.ToInt32(txtDist.Text) + "','" + txtActFlag.Text + "','" + Session["brcd"].ToString() + "','" + System.DateTime.Now.ToShortDateString() + "','" + routenm + "','" + (txtSchHH.Text.Trim() != "" ? Convert.ToInt32(txtSchHH.Text) : Convert.ToInt32("0")) + "','" + Convert.ToInt32(txtSchMM.Text) + "','" + (txtStandRate.Text.Trim() != "" ? Convert.ToInt32(txtStandRate.Text) : Convert.ToInt32("0")) + "','" + ddRouteMode.Text + "','" + txtctlloc.Text.Trim() + "','" + txttransithrs.Text + "')";
        SqlCommand valCmd2 = new SqlCommand(sqlAdd2, cn);
        valCmd2.ExecuteNonQuery();
    }
        
    

    protected void btnUpdt_Click(object sender, EventArgs e)
    {
        instCityVal();
        Response.Redirect("RouteMasterEdSelect.aspx");
    }
    protected void chkActiveFlag_CheckedChanged(object sender, EventArgs e)
    {
        if (chkActiveFlag.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);


            oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Route Master Detail";
            oTableCell.Font.Bold = true;   
            oTableCell.ColumnSpan = 7;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            
            oGridViewRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
           oTableCell = new TableCell();

            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            

             oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

             oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Transition Time";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Stoppage Time";
            oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);

        }

    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowIndex == 0)
            {
                CheckBox c1;
                c1 = (CheckBox)e.Row.FindControl("ChkSelect");
                c1.Checked = true;
                c1.Enabled = false; 
                TextBox t0,t1, t2, t3, t4;
                t0 = (TextBox)e.Row.FindControl("txtdistance");
                t1 = (TextBox)e.Row.FindControl("txtttimehr");
                t2 = (TextBox)e.Row.FindControl("txtttimemn");
                t3 = (TextBox)e.Row.FindControl("txtstimehr");
                t4 = (TextBox)e.Row.FindControl("txtstimemn");
                t0.Text = "0";
                t1.Text = "0";
                t2.Text = "0";
                t3.Text = "0";
                t4.Text = "0";
                t0.Visible = false; 
                t1.Visible = false;
                t2.Visible = false;
                t3.Visible = false;
                t4.Visible = false;
                Label l0,l1, l2, l3, l4;
                l0 = (Label)e.Row.FindControl("lbldistance"); 
                l1 = (Label)e.Row.FindControl("lblttimehr");
                l2 = (Label)e.Row.FindControl("lblttimemn");
                l3 = (Label)e.Row.FindControl("lblstimehr");
                l4 = (Label)e.Row.FindControl("lblstimemn");
                l0.Text = "0";
                l1.Text = "0";
                l2.Text = "0";
                l3.Text = "0";
                l4.Text = "0";
                l0.CssClass = "blackfnt";
                l1.CssClass = "blackfnt";
                l2.CssClass = "blackfnt";
                l3.CssClass = "blackfnt";
                l4.CssClass = "blackfnt";
                l0.Visible = true; 
                l1.Visible = true;
                l2.Visible = true;
                l3.Visible = true;
                l4.Visible = true;
            }
            CheckBox c2;
            c2 = (CheckBox)e.Row.FindControl("ChkSelect");
            c2.Checked = true;
            //((CheckBox)e.Row.FindControl("ChkSelect")).Attributes.Add("onclick", "distancetotal(" + ((CheckBox)e.Row.FindControl("ChkSelect")).ClientID + "," + ((TextBox)e.Row.FindControl("txtdistance")).ClientID + ")");
            ((CheckBox)e.Row.FindControl("ChkSelect")).Attributes.Add("onclick", "totalkm(),totalhour(),footertotal(),checkduplicate(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + ")");
            //((TextBox)e.Row.FindControl("txtdistance")).Attributes.Add("onblur", "Nagative_Chk_wDecimal(" + ((TextBox)e.Row.FindControl("txtdistance")).ClientID + ");totalkm(" + ((TextBox)e.Row.FindControl("txtdistance")).ClientID + ")");
            ((TextBox)e.Row.FindControl("txtdistance")).Attributes.Add("onblur", "Nagative_Chk_wDecimal(" + ((TextBox)e.Row.FindControl("txtdistance")).ClientID + ");totalkm()");
            ((TextBox)e.Row.FindControl("txtbranchname")).Attributes.Add("onblur", "checklocation(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + ");checkduplicate(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + ")");
            ((TextBox)e.Row.FindControl("txtttimehr")).Attributes.Add("onblur", "checkhour(" + ((TextBox)e.Row.FindControl("txtttimehr")).ClientID + ");footertotal();totalhour()");
            ((TextBox)e.Row.FindControl("txtttimemn")).Attributes.Add("onblur", "checkminute(" + ((TextBox)e.Row.FindControl("txtttimemn")).ClientID + ");footertotal();totalhour()");
            ((TextBox)e.Row.FindControl("txtstimehr")).Attributes.Add("onblur", "checkhour(" + ((TextBox)e.Row.FindControl("txtstimehr")).ClientID + ");footertotal();totalhour()");
            ((TextBox)e.Row.FindControl("txtstimemn")).Attributes.Add("onblur", "checkminute(" + ((TextBox)e.Row.FindControl("txtstimemn")).ClientID + ");footertotal();totalhour()");  

        }
    }
}

