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

public partial class GUI_HR_Payroll_MultiEmpSelector : System.Web.UI.UserControl
{
    DataTable dt = new DataTable();
    string _DataTextField = "EMPNM";
    string _DataValueField = "EMPID";
    public DataTable DataSource
    {
        get { return dt; }
        set { dt = value; }
    }
    public string DataTextField
    {
        get { return _DataTextField; }
        set { _DataTextField = value;}
    }
    public string DataValueField
    {
        get { return _DataValueField; }
        set { _DataValueField = value;}
    }

    public ListBox Selected
    {
        get { return listSelected; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void linkAddSelected_Click(object sender, EventArgs e)
    {
        try
        {
            if (listEmp.Items.Count > 0)
            {
                if (listEmp.SelectedIndex < 0)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please select the record to move";
                }
                else
                {
                    lblMessage.Visible = false;
                    for (int i = 0; i < listEmp.Items.Count; i++)
                    {
                        if (listEmp.Items[i].Selected)
                        {
                            listSelected.Items.Add(listEmp.Items[i]);
                            listEmp.Items.Remove(listEmp.Items[i]);
                            i--;
                        }
                    }
                    ListBox lstbox = SortListBox(listSelected);
                    listSelected.Items.Clear();
                    for (int i = 0; i < lstbox.Items.Count; i++)
                    {
                        listSelected.Items.Add(lstbox.Items[i]);
                    }
                    listEmp.ClearSelection();
                    listSelected.ClearSelection();
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
    protected void linkRemoveSelected_Click(object sender, EventArgs e)
    {
        try
        {
            if (listSelected.Items.Count > 0)
            {
                if (listSelected.SelectedIndex < 0)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please select the record to move";
                }
                else
                {
                    lblMessage.Visible = false;
                    for (int i = 0; i < listSelected.Items.Count; i++)
                    {
                        if (listSelected.Items[i].Selected)
                        {
                            listEmp.Items.Add(listSelected.Items[i]);
                            listSelected.Items.Remove(listSelected.Items[i]);
                            i--;
                        }
                    }
                    ListBox lstbox = SortListBox(listEmp);
                    listEmp.Items.Clear();
                    for (int i = 0; i < lstbox.Items.Count; i++)
                    {
                        listEmp.Items.Add(lstbox.Items[i]);
                    }
                    listEmp.ClearSelection();
                    listSelected.ClearSelection();
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
    protected void linkAddAll_Click(object sender, EventArgs e)
    {
        try
        {
            if (listEmp.Items.Count > 0)
            {
                lblMessage.Visible = false;
                if (listEmp.Items.Count > 0)
                {
                    for (int i = 0; i < listEmp.Items.Count; i++)
                    {
                        listSelected.Items.Add(listEmp.Items[i]);
                        listEmp.Items.Remove(listEmp.Items[i]);
                        i--;
                    }
                }
                ListBox lstbox = SortListBox(listSelected);
                listSelected.Items.Clear();
                for (int i = 0; i < lstbox.Items.Count; i++)
                {
                    listSelected.Items.Add(lstbox.Items[i]);
                }
                listEmp.ClearSelection();
                listSelected.ClearSelection();
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
    protected void linkRemoveAll_Click(object sender, EventArgs e)
    {
        try
        {
            if (listSelected.Items.Count > 0)
            {
                lblMessage.Visible = false;
                if (listSelected.Items.Count > 0)
                {
                    for (int i = 0; i < listSelected.Items.Count; i++)
                    {
                        listEmp.Items.Add(listSelected.Items[i]);
                        listSelected.Items.Remove(listSelected.Items[i]);
                        i--;
                    }
                    ListBox lstbox = SortListBox(listEmp);
                    listEmp.Items.Clear();
                    for (int i = 0; i < lstbox.Items.Count; i++)
                    {
                        listEmp.Items.Add(lstbox.Items[i]);
                    }
                }
                listEmp.ClearSelection();
                listSelected.ClearSelection();
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

    public void BindList()
    {
        listEmp.DataSource = dt;
        listEmp.DataTextField = _DataTextField;
        listEmp.DataValueField = _DataValueField;
        listEmp.DataBind();

        listSelected.Items.Clear();
    }

    public void Clear()
    {
        listEmp.Items.Clear();
        listSelected.Items.Clear();
    }
}
