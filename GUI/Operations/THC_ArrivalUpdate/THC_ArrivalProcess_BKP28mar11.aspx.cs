using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Operations_THC_ArrivalUpdate_THC_ArrivalProcess : System.Web.UI.Page
{
    public string FinYear = "", currdate;
    protected void Page_Load(object sender, EventArgs e)
    {
        currdate = DateTime.Now.ToString("dd/MM/yyyy");

        lblPageHead.Text = Session["THCCalledAs"] + " Arrival/Update";
        lbkThcno.Text = Session["THCCalledAs"] + " No #";
        lblTHCNO.Text = Request.QueryString["THCNO"].ToString();
        btnSubmit.Text = "Update "+Session["THCCalledAs"] ;
        lbltotMF.Text = "Total MF For " + Session["brcd"] + " #";
        lbltotDKT.Text = "Total "+Session["DocketCalledAs"]+" For " + Session["brcd"] +" #";

        PRSTYP.Value = Request.QueryString["TYP"].ToString();

        MySQLDataSource_DelyReasons.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_ArrivalConditions.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Godowns.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (Request.QueryString["TYP"].ToString() == "S")
        {
            ViewArrivalDetails("none");
        }
        else
        {
            ViewArrivalDetails("block");
            tr7.Style["display"] = "none";
        }

        if (Request.QueryString["TYP"].ToString() == "A")
        {
            ViewUpdateDetails("none"); 
        }
        else
        {
            ViewUpdateDetails("block");
        }
       
       
        if (!IsPostBack)
        {

            txtarrvdt.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtStockUpdateDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtArrivalTimeHH.Text = System.DateTime.Now.ToString("HH");
            txtArrivalTimeMM.Text = System.DateTime.Now.ToString("mm");
            txtUnloader.Text = Session["EMPCD"].ToString();
            string strquery = "select *,ETA1=convert(varchar,ETA,6) + ' ' + convert(varchar,ETA,108) from VWNET_THC_Arrival_update where thcno='" + Request.QueryString["THCNO"].ToString() + "' and (Arr_loc='" + Session["brcd"] + "'  or Stock_loc='" + Session["brcd"] + "') and (Arr_status='Arrival'  or Stock_Status='Stock Update' or Stock_Status='Pending Arrival')";

            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand CMD = new SqlCommand(strquery, sqlConn);
              SqlDataReader dr = CMD.ExecuteReader();

              while (dr.Read())
              {
                  lblvehicledep.Text = dr["PreviousBranch"].ToString() + " @ " + dr["ATD"].ToString();
                  hdnDeptDate.Value = dr["ATD1"].ToString();
                  lblexparr.Text = dr["ETA1"].ToString();
                  lblopnekm.Text = "( <b>Opening KM # </b> " + dr["OPENKM"].ToString() + " )";
                  lblopnekm.Font.Bold = true;
                  lblopnekm.ForeColor = System.Drawing.Color.Red;
                  lblCntMF.Text = dr["MF"].ToString();
                  lblCntDKt.Text = dr["DKT"].ToString();
                  lblvehicle.Text = dr["Vehicle"].ToString();
                  lblarrrvatDt.Text = dr["ATA"].ToString();
                  HDKM.Value = dr["OPENKM"].ToString();
              }

              dr.Close();
               sqlConn.Close();
        }


    }
    public void ViewUpdateDetails(string abcd)
    {
        Table1.Style["display"] = abcd;
    }
    public void ViewArrivalDetails(string abcd)
    {
        tr1.Style["display"] = abcd;
        tr2.Style["display"] = abcd;
        tr3.Style["display"] = abcd;
       // tr4.Style["display"] = abcd;
        tr5.Style["display"] = abcd;
        tr6.Style["display"] = abcd;
        
    }
    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strArrivalXML = "<root><THCarrival>";
        strArrivalXML += "<sealno_in>"+txtIncomingSealNo.Text.ToString()+"</sealno_in>";
        strArrivalXML += "<THCNO>"+Request.QueryString["THCNO"].ToString()+"</THCNO>";
        strArrivalXML += "<actarrv_dt>" + getDateInddMMMyyFormat(txtarrvdt.Text.ToString()) + "</actarrv_dt>";
        strArrivalXML += "<actarrv_tm>"+txtArrivalTimeHH.Text.ToString()+":"+txtArrivalTimeMM.Text.ToString()+"</actarrv_tm>";
        strArrivalXML += "<thc_inrem>"+txtIncrmk.Text.ToString()+"</thc_inrem>";
        strArrivalXML += "<unloader>"+txtUnloader.Text.ToString()+"</unloader>";
        strArrivalXML += "<LateArrivalReason>"+ddlLateArrivalReason.SelectedValue.ToString()+"</LateArrivalReason>";
        strArrivalXML += "<closekm>"+txtopenkm.Text.ToString()+"</closekm>";
        strArrivalXML += "</THCarrival></root>";

        string strStockXML = "<root><THCStock>";
        strStockXML += "<StockUpDt>" + getDateInddMMMyyFormat(txtStockUpdateDate.Text.ToString()) + "</StockUpDt>";
        strStockXML += "<THCNO>"+Request.QueryString["THCNO"].ToString()+"</THCNO>";
        strStockXML += "<StockCondition>"+cboArrivalConditions_All.SelectedValue.ToString()+"</StockCondition>";
        strStockXML += "<Godown>" + cboGodowns_All.SelectedValue.ToString() + "</Godown>";
        strStockXML += "</THCStock></root>";
         SqlTransaction trans;


        string strquery = "exec Usp_THC_Arrival_update '" + strArrivalXML + "','" + strStockXML + "','" + Session["brcd"].ToString() + "','" + Session["FinYear"].ToString() + "','" + Request.QueryString["TYP"].ToString() + "','" + Session["empcd"].ToString() + "'";
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

Response.Write("strquery "+ strquery );
//Response.End();
        trans = sqlConn.BeginTransaction();
        try
        {

            SqlCommand CMD = new SqlCommand(strquery, sqlConn);
           
            CMD.Transaction = trans;
            CMD.ExecuteNonQuery();
           trans.Commit();
           // trans.Rollback();
            sqlConn.Close();

        }
        catch (Exception e1)
        {
            if (e1.Message == "")
            {
                //abc = "Insert Susccessfully !!!!!!!";
            }
            trans.Rollback();
            //trans.Commit();


            sqlConn.Close();
           
        }

          // trans.Rollback();
       
         Response.Redirect("StockUpdateResult.aspx");
    }
}
