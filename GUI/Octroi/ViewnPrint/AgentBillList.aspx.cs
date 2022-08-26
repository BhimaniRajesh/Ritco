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

public partial class GUI_Octroi_AgentBillList : System.Web.UI.Page
{

    public string billno,location,agent,date1,date2,tp,sqlstr;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        billno = Request.QueryString["billno"].ToString();
        location = Request.QueryString["location"].ToString();
        agent = Request.QueryString["customer"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        tp = Request.QueryString["type"].ToString();

        lblbillbranch.Text = location;
        lblagentcode.Text = agent;
        if (agent == "")
            lblagentcode.Text = agent;


        lbldate.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);

     


        string datestr = "", BILLNOstr = "";
        if (tp.CompareTo("0") == 0)
        {
            datestr = "And 1=1";
            BILLNOstr = "OCBILLNO='" + billno + "'";
        }
        else if (tp.CompareTo("1") == 0)
        {
            date1 = Request.QueryString["date1"].ToString();
            if (date1 != "")
            {
                date1 = fn.Mydate1(date1);
            }
            date2 = Request.QueryString["date2"].ToString();
            if (date2 != "")
            {
                date2 = fn.Mydate1(date2);
            }
            datestr = "and convert(varchar,OCBILLDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
        }
        else if (tp.CompareTo("2") == 0)
        {
            DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));

            date1 = Convert.ToString(date_tmp.ToString("dd/MM/yyyy"));
            if (date1 != "")
            {
                date1 = fn.Mydate1(date1);
            }
            date2 = System.DateTime.Now.ToString("dd/MM/yyyy");
            if (date2 != "")
            {
                date2 = fn.Mydate1(date2);
            }
            datestr = "and convert(varchar,OCBILLDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
        }
        else if (tp.CompareTo("3") == 0)
        {
            date1 = System.DateTime.Now.ToString("dd/MM/yyyy");
            if (date1 != "")
            {
                date1 = fn.Mydate1(date1);
            }
            date2 = date1;
            datestr = "and convert(varchar,OCBILLDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
        }
        string Custr;
        if (agent.Trim() == "-- All --" || agent.Trim() == "--All--")
        {
            Custr = "And 1=1";
        }
        else
        {
            Custr = "AND OCAGNM='" + agent + "'";
        }
        string locstr = "";
        if (tp.CompareTo("0") != 0)
            locstr = locstr + " AND OCBRCD='" + location + "'";
        else
            locstr = locstr + " AND 1=1";

        string sqlstr1 = BILLNOstr + "  " + datestr + "  " + Custr + " " + locstr;

        //sqlstr = "SELECT OCBILLNO,OCBRCD=OCBRCD +'~'+(select locname from webx_location a where  a.loccode=OCBRCD),OCAGOCTAMT,OCAGSERCHRG,OCAGOTHCHRG,OCTOTALDUE,OCBILLDT=convert(varchar,OCBILLDT,106) FROM webx_oct_hdr WHERE " + sqlstr1 + "";
        //sqlstr = "select (isnull(OCAGOCTAMT,0)-(isnull(OCAGOTHCHRG,0)+isnull(OCAGSERCHRG,0)+isnull(sundrychrg,0)+isnull(clearchrg,0)+isnull(formchrg,0))) as oct_paid,(isnull(OCAGOCTAMT,0)+(isnull(OCAGOTHCHRG,0)+isnull(OCAGSERCHRG,0)+isnull(sundrychrg,0)+isnull(clearchrg,0)+isnull(formchrg,0))) as netamt,ocbillno,ocagbillno,convert(varchar,ocagbilldt,106) as ocagbilldt,ocagoctamt,ocbrcd,ocagserchrg,ocagothchrg,clearchrg,formchrg,sundrychrg,actserchrg,ocagserchrg,isnull(ocagoctamt,0)-isnull(octotaldue,0) as  servchargeper,convert(varchar,ocduedt,106)as ocduedt,octotaldue,isnull(tds_rate,0) as tds_rate,isnull(tdsamt,0) as tdsamt,convert(varchar,ocagbilldt,103) as HndOcbilldt from webx_oct_hdr where " + sqlstr1 + "";
        sqlstr = "select oct_paid=(select sum(octamt) from webx_oct_det where ocbillno=A.ocbillno) ,((select sum(octamt) from webx_oct_det where ocbillno=A.ocbillno)+(isnull(OCAGOTHCHRG,0)+isnull(OCAGSERCHRG,0)+isnull(sundrychrg,0)+isnull(clearchrg,0)+isnull(formchrg,0))) as netamt,ocbillno,ocagbillno,convert(varchar,ocagbilldt,106) as ocagbilldt,ocagoctamt,ocbrcd,ocagserchrg,ocagothchrg,clearchrg,formchrg,sundrychrg,actserchrg,ocagserchrg,isnull(ocagoctamt,0)-isnull(octotaldue,0) as servchargeper,convert(varchar,ocduedt,106)as ocduedt,octotaldue,convert(varchar,ocagbilldt,103) as HndOcbilldt,Cancel_YN from webx_oct_hdr A where " + sqlstr1 + "";
        dataBind();
    }

    protected void dataBind()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmdoct = new SqlCommand(sqlstr);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvagentbill.CssClass = "redfnt";
            gvagentbill.HorizontalAlign = HorizontalAlign.Center;
        }
        gvagentbill.DataSource = ds;
        gvagentbill.DataBind();

        con.Close();
    
    }

    

    protected void gvagentbill_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvagentbill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    HiddenField hidBillno = (HiddenField)e.Row.FindControl("hidBillno");
        //    Label lblnetamount = (Label)e.Row.FindControl("lblNetamount");
        //    Label lblOctroiAmount = (Label)e.Row.FindControl("lblOctroiAmount");

        //    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //    con.Open();
        //    string sqlqry = "exec Usp_Show_result_Bill '" + hidBillno.Value + "'";
        //    SqlCommand cmd = new SqlCommand(sqlqry);
        //    cmd.Connection = con;
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();

        //    while (dr.Read())
        //    {
        //        lblOctroiAmount.Text = dr["oct_paid"].ToString();
        //        lblnetamount.Text = dr["CurrPaidamt"].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
            
        //}

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");
            if (lblStatus.Text == "Y")
            {
                lblStatus.Text = "Cancelled";
            }
            else
            {
                lblStatus.Text = "Generated";
            }
        }

    }
}
