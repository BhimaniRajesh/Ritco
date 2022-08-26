using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Tyre_TyreIssueRemoval_TyreInterchange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            BindDropDown("USP_BIND_VEHNO", "VEHNO", "VEHICLE_NO", ddlVHNO_1);
            BindDropDown("USP_BIND_VEHNO", "VEHNO", "VEHICLE_NO", ddlVHNO_2);

            linkAddAll.Attributes.Add("OnClick", "javascript:return CheckOnSubmit();");
            linkAddSelected.Attributes.Add("OnClick", "javascript:return CheckOnSubmit();");
            linkRemoveSelected.Attributes.Add("OnClick", "javascript:return CheckOnSubmit();");
            linkRemoveAll.Attributes.Add("OnClick", "javascript:return CheckOnSubmit();");

            txtKMReading_1.Attributes.Add("OnBlur", "javascript:return CheckKMReading_1();");
            txtKMReading_2.Attributes.Add("OnBlur", "javascript:return CheckKMReading_2();");
        }
    }
    /// <summary>
    /// Bind DropDown list for Vehicle no
    /// </summary>
    /// <param name="strProc"></param>
    /// <param name="text"></param>
    /// <param name="value"></param>
    /// <param name="d"></param>
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        System.Data.SqlClient.SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    /// <summary>
    /// Bind List of Tyre & Model  on selection  of vehicle no
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlVHNO1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();

        ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "USP_GetTyreModel_VH_Wise '" + ddlVHNO_1.SelectedValue.Trim() + "'");

        lstVhno_Left.DataSource = ds;
        lstVhno_Left.DataTextField = "TYRE_NO";
        lstVhno_Left.DataValueField = "TYRE_ID";
        lstVhno_Left.DataBind();

        lstModel_Left.DataSource = ds;
        lstModel_Left.DataTextField = "MODEL_DESC";
        lstModel_Left.DataValueField = "TYRE_MODEL_ID";
        lstModel_Left.DataBind();
    }

    /// <summary>
    /// Bind List of Tyre & Model on selection  of vehicle no
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlVHNO2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();

        ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "USP_GetTyreModel_VH_Wise '" + ddlVHNO_2.SelectedValue.Trim() + "'");

        lstVhno_Right.DataSource = ds;
        lstVhno_Right.DataTextField = "TYRE_NO";
        lstVhno_Right.DataValueField = "TYRE_ID";
        lstVhno_Right.DataBind();

        lstModel_Right.DataSource = ds;
        lstModel_Right.DataTextField = "MODEL_DESC";
        lstModel_Right.DataValueField = "TYRE_MODEL_ID";
        lstModel_Right.DataBind();

    }

    /// <summary>
    /// On click Button '>>'
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void linkAddAll_Click(object sender, EventArgs e)
    {
        try
        {
            if (lstVhno_Left.Items.Count > 0)
            {
                lblMessage.Visible = false;
                if (lstVhno_Left.Items.Count > 0)
                {
                    for (int i = 0; i < lstVhno_Left.Items.Count; i++)
                    {
                        //Left TYRE_NO  & Model -> Right TYRE_NO  & Model
                        lstVhno_Right.Items.Add(lstVhno_Left.Items[i]);
                        lstModel_Right.Items.Add(lstModel_Left.Items[i]);

                        //Remove from left list
                        lstVhno_Left.Items.Remove(lstVhno_Left.Items[i]);
                        lstModel_Left.Items.Remove(lstModel_Left.Items[i]);
                        i--;
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Item list is empty.";
            }
        }
        catch (Exception exc)
        {
            lblMessage.Visible = true;
            lblMessage.Text = exc.ToString();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="lstBox"></param>
    /// <returns></returns>
    private ListBox SortListBox(ListBox lstBox)
    {
        ListBox lstBoxUsers = new ListBox();
        ArrayList List = new ArrayList();
        int iLoop;
        for (iLoop = 0; iLoop < lstBox.Items.Count; iLoop++)
        {
            List.Add(lstBox.Items[iLoop].Text);
        }
        List.Sort();

        for (int i = 0; i < lstBox.Items.Count; i++)
        {
            for (int j = 0; j < lstBox.Items.Count; j++)
            {
                if (List[i].Equals(lstBox.Items[j].Text))
                {
                    lstBoxUsers.Items.Add(lstBox.Items[j]);
                    lstBox.Items.Remove(lstBox.Items[j]);
                    List.Remove(List[i]);
                    i--;
                    break;
                }
            }
        }
        return lstBoxUsers;
    }
    /// <summary>
    /// On click button '>'
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void linkAddSelected_Click(object sender, System.EventArgs e)
    {
        try
        {
            if (lstVhno_Left.Items.Count > 0)
            {
                if (lstVhno_Left.SelectedIndex < 0)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please select the Tyre No. first";
                }
                else
                {
                    lblMessage.Visible = false;
                    for (int i = 0; i < lstVhno_Left.Items.Count; i++)
                    {
                        if (lstVhno_Left.Items[i].Selected)
                        {
                            lstVhno_Right.Items.Add(lstVhno_Left.Items[i]);
                            lstVhno_Left.Items.Remove(lstVhno_Left.Items[i]);

                            lstModel_Right.Items.Add(lstModel_Left.Items[i]);
                            lstModel_Left.Items.Remove(lstModel_Left.Items[i]);
                            i--;
                        }
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Item list is empty.";
            }
        }
        catch (Exception exc)
        {
            lblMessage.Visible = true;
            lblMessage.Text = exc.ToString();
        }
    }
    /// <summary>
    /// On click Button '<'
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void linkRemoveSelected_Click(object sender, System.EventArgs e)
    {
        try
        {
            if (lstVhno_Right.Items.Count > 0)
            {
                if (lstVhno_Right.SelectedIndex < 0)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please select the Tyre No. first";
                }
                else
                {
                    lblMessage.Visible = false;
                    for (int i = 0; i < lstVhno_Right.Items.Count; i++)
                    {
                        if (lstVhno_Right.Items[i].Selected)
                        {
                            lstVhno_Left.Items.Add(lstVhno_Right.Items[i]);
                            lstVhno_Right.Items.Remove(lstVhno_Right.Items[i]);

                            lstModel_Left.Items.Add(lstModel_Right.Items[i]);
                            lstModel_Right.Items.Remove(lstModel_Right.Items[i]);
                            i--;
                        }
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Item list is empty.";
            }
        }
        catch (Exception exc)
        {
            lblMessage.Visible = true;
            lblMessage.Text = exc.ToString();
        }

    }
    /// <summary>
    /// On click Button '<<'
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void linkRemoveAll_Click(object sender, System.EventArgs e)
    {
        try
        {
            if (lstVhno_Right.Items.Count > 0)
            {
                lblMessage.Visible = false;
                if (lstVhno_Right.Items.Count > 0)
                {
                    for (int i = 0; i < lstVhno_Right.Items.Count; i++)
                    {
                        //Left TYRE_NO  & Model -> Right TYRE_NO  & Model
                        lstVhno_Left.Items.Add(lstVhno_Right.Items[i]);
                        lstModel_Left.Items.Add(lstModel_Right.Items[i]);

                        //Remove from right list
                        lstVhno_Right.Items.Remove(lstVhno_Right.Items[i]);
                        lstModel_Right.Items.Remove(lstModel_Right.Items[i]);
                        i--;
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Item list is empty.";
            }
        }
        catch (Exception exc)
        {
            lblMessage.Visible = true;
            lblMessage.Text = exc.ToString();
        }
    }
    /// <summary>
    /// Save record on Submit click
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        string final = "";
        Boolean IsCommited = false;
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

        CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.Trim();
        CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();

        string LeftVhNo = ddlVHNO_1.SelectedValue.Trim();
        string RightVhNo = ddlVHNO_2.SelectedValue.Trim();

        //For Left side Vehicle No
        
        //OLD VEHICLE=RightVhNo
        //NEW VEHICLE=LeftVhNo
        if (lstVhno_Left.Items.Count > 0)
        {
            for (int i = 0; i < lstVhno_Left.Items.Count; i++)
            {
                CTIM.TYRE_ID = lstVhno_Left.Items[i].Value;
                CTIM.VEH_NO = RightVhNo;
                CTIM.NEW_VEH_NO = LeftVhNo;
                CTIM.KM =Convert.ToDouble(txtKMReading_1.Text.Trim());

                CTIM.Update_InterchangeTyre();
                IsCommited = true;
            }
        }

        //For Right side Vehicle No

        //OLD VEHICLE=LeftVhNo
        //NEW VEHICLE=RightVhNo 

        if (lstVhno_Right.Items.Count > 0)
        {
            for (int i = 0; i < lstVhno_Right.Items.Count; i++)
            {
                CTIM.TYRE_ID = lstVhno_Right.Items[i].Value;
                CTIM.VEH_NO = LeftVhNo;
                CTIM.NEW_VEH_NO=RightVhNo;
                CTIM.KM = Convert.ToDouble(txtKMReading_2.Text.Trim());

                CTIM.Update_InterchangeTyre();
                IsCommited = true;

            }
        }
        if (IsCommited)
        {
            Response.Redirect("ResultTyre.aspx?VEHNO_1=" + ddlVHNO_1.SelectedValue + "&VEHNO_2="+ddlVHNO_2.SelectedValue);
        }
    }
}