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

public partial class GUI_Operations_GatePass_UpdateGatePass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string startdate, enddate, partycode, tp, gatepassnos, docknos;
            tp = Request.QueryString["tp"].ToString();
            startdate = Request.QueryString["startdate"].ToString();
            enddate = Request.QueryString["enddate"].ToString();
            partycode = Request.QueryString["partycode"].ToString();
            gatepassnos = Request.QueryString["gatepassnos"].ToString();
            docknos = Request.QueryString["docknos"].ToString();
            DateTime dtstart, dtend;
            dtstart = DateTime.Now;
            dtend = DateTime.Now;
            if (tp.CompareTo("2") == 0)
            {
                string[] arrstart = new string[3];
                string[] arrend = new string[3];
                arrstart = startdate.Split('/');
                arrend = enddate.Split('/');

                dtstart = new DateTime(Convert.ToInt16(arrstart[2]), Convert.ToInt16(arrstart[1]), Convert.ToInt16(arrstart[0]));
                dtend = new DateTime(Convert.ToInt16(arrend[2]), Convert.ToInt16(arrend[1]), Convert.ToInt16(arrend[0]));

            }
            lbldaterange.Text = dtstart.ToString("dd MMM yyyy") + " ~ " + dtend.ToString("dd MMM yyyy");
            if (partycode.CompareTo("") == 0)
                lblpartyname.Text = "NA";
            else
                lblpartyname.Text = partycode;

            if (partycode.CompareTo("") == 0)
                lblgatepass.Text = gatepassnos;
            else
                lblgatepass.Text = "NA";
            DataTable dtgatepass = new DataTable();
            try
            {
                dtgatepass = GatePassController.GetGatePass(tp, dtstart, dtend, partycode, gatepassnos, docknos, SessionUtilities.CurrentBranchCode);
            }
            catch (Exception ex)
            { }
            grvgatepass.DataSource = dtgatepass;
            grvgatepass.DataBind();
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
        con.Open();
        SqlTransaction trn = con.BeginTransaction();
        string gatepassnos = "";
        try
        {
            foreach (GridViewRow grv in grvgatepass.Rows)
            {

                CheckBox chkyes = (CheckBox)grv.FindControl("chkyes");
                if (chkyes.Checked == true)
                {
                    GatePass gp = new GatePass();
                    Label lblgatepassno = (Label)grv.FindControl("lblgatepassno");
                    gp.GatePassNo = lblgatepassno.Text;
                    gp.UpdateBy = Session["empcd"].ToString();
                    GatePassController.GatePassUpdate(gp, trn);
                    GatePassController.SelDeliveryDetails(gp, trn);
                    gatepassnos = gatepassnos + gp.GatePassNo + ",";
                }
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataUpdation Failed.&suggesion1=Re-Enter again");
            return;
        }
        trn.Commit();
        con.Close();
        Response.Redirect("UpdateGatePassDone.aspx?gatepassnos=" + gatepassnos);
        Response.Redirect("~/GUI/Default.aspx");
    }
}
