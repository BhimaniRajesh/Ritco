using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.Odbc;
using System.Data.SqlClient;
using System.Data.Sql;


public partial class GUI_Common_UserControls_MultiCheckCombo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (AllowAll)
            InnerPanelALL.Style[HtmlTextWriterStyle.Display] = "block";
        else
            InnerPanelALL.Style[HtmlTextWriterStyle.Display] = "none";

        lblAllText.Text = SelectAllText;
        txtCombo.Text = hidSelectedText.Value;
    }

    /// <summary>
    /// Set the Width of the CheckBoxList
    /// </summary>
    public int WidthCheckListBox
    {
        set
        {
            InnerPanel.Width = value;
            Panel111.Width = value + 20;
        }
    }
    /// <summary>
    /// Set the Width of the Combo
    /// </summary>
    public int Width
    {
        set
        {
            txtCombo.Width = value;
            ddlMultiSelection.Width = value + 30;
        }
        get { return (Int32)txtCombo.Width.Value; }
    }
    /// <summary>
    /// Set Control Enabled
    /// </summary>
    public bool Enabled
    {
        set { txtCombo.Enabled = value; }
    }
    /// <summary>
    /// Allow Select All Opetion
    /// </summary>
    public bool AllowAll
    {
        get { return (ViewState["MultiCheckCombo_AllowAll"] != null) ? Convert.ToBoolean(ViewState["MultiCheckCombo_AllowAll"]) : true; }
        set { ViewState["MultiCheckCombo_AllowAll"] = value; }
    }
    /// <summary>
    /// Set Display Text for Select ALL Opetion
    /// </summary>
    public string SelectAllText
    {
        get { return (ViewState["MultiCheckCombo_SelectAllText"] != null) ? ViewState["MultiCheckCombo_SelectAllText"].ToString() : "--Select All--"; }
        set { ViewState["MultiCheckCombo_SelectAllText"] = value; }
    }

    public FontUnit fontSizeTextBox
    {
        set { txtCombo.Font.Size = value; }
    }
    /// <summary>
    /// Get Total Items List
    /// </summary>
    public ListItemCollection Items
    {
        get
        {
            ListItemCollection itemList = new ListItemCollection();
            foreach (RepeaterItem ri in MultiSelection.Items)
            {
                HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
                Label lblText = ri.FindControl("lblText") as Label;
                ListItem li = new ListItem(lblText.Text, chkItem.Value);
                itemList.Add(li);
            }
            return itemList;
        }
    }
    /// <summary>
    /// Get Selected Items List
    /// </summary>
    public ListItemCollection SelectedItems
    {
        get
        {
            ListItemCollection itemList = new ListItemCollection();
            foreach (RepeaterItem ri in MultiSelection.Items)
            {
                HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
                Label lblText = ri.FindControl("lblText") as Label;
                if (chkItem.Checked)
                {
                    ListItem li = new ListItem(lblText.Text, chkItem.Value);
                    itemList.Add(li);
                }
            }
            return itemList;
        }
    }

    public string SelectedText
    {
        get
        {
            string strRet = "";
            foreach (RepeaterItem ri in MultiSelection.Items)
            {
                HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
                Label lblText = ri.FindControl("lblText") as Label;
                if (chkItem.Checked)
                {
                    strRet += ((strRet == "") ? lblText.Text : "," + lblText.Text);
                }
            }
            return strRet;
        }
    }

    public string SelectedValue
    {
        get
        {
            string strRet = "";
            foreach (RepeaterItem ri in MultiSelection.Items)
            {
                HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
                Label lblText = ri.FindControl("lblText") as Label;
                if (chkItem.Checked)
                {
                    strRet += ((strRet == "") ? chkItem.Value : "," + chkItem.Value);
                }
            }
            return strRet;
        }
        set
        {
            string strText = "";
            string[] strValues = value.Split(',');
            int i = 1;
            foreach (string s in strValues)
            {
                foreach (RepeaterItem ri in MultiSelection.Items)
                {
                    HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
                    Label lblText = ri.FindControl("lblText") as Label;

                    if (chkItem.Value == s)
                    {
                        chkItem.Checked = true;
                        strText += ((strText == "") ? lblText.Text : "," + lblText.Text);
                    }
                }
            }
            txtCombo.Text = strText;
            hidSelectedText.Value = strText;
            if (i == MultiSelection.Items.Count)
                MultiSelection_chkALL.Checked = true;
            else
                MultiSelection_chkALL.Checked = false;
        }
    }

    public object DataSource
    {
        set
        {
            MultiSelection.DataSource = value;
        }
    }

    public string DataTextField
    {
        get { return (ViewState["MultiCheckCombo_DataTextField"] != null) ? ViewState["MultiCheckCombo_DataTextField"].ToString() : ""; }
        set { ViewState["MultiCheckCombo_DataTextField"] = value; }
    }

    public string DataValueField
    {
        get { return (ViewState["MultiCheckCombo_DataValueField"] != null) ? ViewState["MultiCheckCombo_DataValueField"].ToString() : ""; }
        set { ViewState["MultiCheckCombo_DataValueField"] = value; }
    }

    public void DataBind()
    {
        ClearAll();
        MultiSelection_chkALL.Checked = false;
        MultiSelection.DataBind();
        MultiSelectionRows.Value = MultiSelection.Items.Count.ToString();
    }

    /// <summary>
    /// Uncheck of the Items of the CheckBox
    /// </summary>
    public void unselectAllItems()
    {
        foreach (RepeaterItem ri in MultiSelection.Items)
        {
            HtmlInputCheckBox chkItem = ri.FindControl("chkItem") as HtmlInputCheckBox;
            chkItem.Checked = false;
        }
    }

    /// <summary>
    /// Delete all the Items of the CheckBox;
    /// </summary>
    public void ClearAll()
    {
        txtCombo.Text = "";
    }

    /// <summary>
    /// Get or Set the Text shown in the Combo
    /// </summary>
    public string Text
    {
        get { return hidSelectedText.Value; }
        set { txtCombo.Text = value; }
    }
}