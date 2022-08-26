using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterDone : System.Web.UI.Page
{
    protected string Finalized = "", DocTypeFlag;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                DocTypeFlag = Request.QueryString["DocTypeFlag"];
                lnkBtnNewDocket.Text = "Click Here to ADD More General Asset Item";    
                lnkBtnNewDocket.PostBackUrl = "~/GUI/Finance/GeneralizedPO/AssetMaster/AssetMasterAdd.aspx?Operation=ADD";
                lnkEdit.Text = "Click Here To Edit the General Asset Item";
                lnkEdit.PostBackUrl = "~/GUI/Finance/GeneralizedPO/AssetMaster/AssetMasterEditCriteria.aspx";
                if (DocTypeFlag == "ADD")
                {
                    lblTitle.Text = "Following Asset Item Inserted Successfully";
                    tdFinalizedDocket.Text = "ASSET CODE";
                    lblFinalizedDocket.Text = Convert.ToString(Request.QueryString["ASSETCODE"]);
                    Finalized = lblFinalizedDocket.Text;                        
                }
                else if (DocTypeFlag == "EDIT")
                {
                    lblTitle.Text = "Following Asset Item Updated Successfully";
                    tdFinalizedDocket.Text = "ASSET CODE";
                    lblFinalizedDocket.Text = Convert.ToString(Request.QueryString["ASSETCODE"]);
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
