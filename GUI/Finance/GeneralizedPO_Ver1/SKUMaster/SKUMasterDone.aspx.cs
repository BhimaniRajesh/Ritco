using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_GeneralizedPO_SKUMaster_SKUMasterDone : System.Web.UI.Page
{
    protected string Finalized = "", DocTypeFlag;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                DocTypeFlag = Request.QueryString["DocTypeFlag"];
                lnkBtnNewDocket.Text = "Click Here to ADD More SKU Item";
                lnkBtnNewDocket.PostBackUrl = "~/GUI/Finance/GeneralizedPO/SKUMaster/SKUMasterADD.aspx?Operation=ADD";
                lnkEdit.Text = "Click Here To Edit the SKU Item";
                lnkEdit.PostBackUrl = "~/GUI/Finance/GeneralizedPO/AssetMaster/AssetMasterEditCriteria.aspx";
                if (DocTypeFlag == "ADD")
                {
                    lblTitle.Text = "Following SKU Items Inserted Successfully";
                    tdFinalizedDocket.Text = "SKU Code";
                    lblFinalizedDocket.Text = Convert.ToString(Request.QueryString["SKUCode"]);
                    Finalized = lblFinalizedDocket.Text;
                }
                else if (DocTypeFlag == "EDIT")
                {
                    lblTitle.Text = "Following Asset Item Updated Successfully";
                    tdFinalizedDocket.Text = "SKU Code";
                    lblFinalizedDocket.Text = Convert.ToString(Request.QueryString["SKUCode"]);
                    Finalized = lblFinalizedDocket.Text;
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
}
