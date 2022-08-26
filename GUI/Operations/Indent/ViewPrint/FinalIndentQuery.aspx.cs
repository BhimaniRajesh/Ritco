using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_Indent_IndentView_FinalIndentQuery : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }

    }
    public void BindReptIndentWise()
    {
        var objIndent = new Indent();
        var objIndentController = new IndentController();


        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Yesterday";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Yesterday")
        {
            strrightnow = righnow.AddDays(-1).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.AddDays(-1).ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();


        objIndent.IndentNumber = txtIndentNo.Text.Trim();

        DataTable dt = objIndentController.FinalIndentPendingdDetails(st_ro, st_lo, dtFrom, dtTo, objIndent);
        if (dt.Rows.Count > 0)
        {
            rptFinnalIndentList.DataSource = dt;
            rptFinnalIndentList.DataBind();
        }
    }

    public void BindReptGrWise()
    {
        var objGr = new Indent();
        var objIndentController = new IndentController();


        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Yesterday";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Yesterday")
        {
            strrightnow = righnow.AddDays(-1).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.AddDays(-1).ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();

        if(txtGrNo.Text.Trim()!="")
        { 

        char last_char = txtGrNo.Text.Trim()[txtGrNo.Text.Trim().Length - 1];
        if(last_char.ToString().Trim()==",")
        { objGr.GrNumber = txtGrNo.Text.Trim(); }
        else { objGr.GrNumber = txtGrNo.Text.Trim() + ","; }
        }
        DataTable dt = objIndentController.FinalIndentPendingdDetailsGrWise(st_ro, st_lo, dtFrom, dtTo, objGr);
        if (dt.Rows.Count > 0)
        {
            rptFinnalGrList.DataSource = dt;
            rptFinnalGrList.DataBind();
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rblIndentGrWise.SelectedValue == "rbIndentWise")
        {
        BindReptIndentWise();
        trrepeter.Style["display"] = "block";
trrepeterGr.Style["display"] = "none";
        //btnSubmit.Enabled = false;
        }
        else
        {
            BindReptGrWise();
            trrepeterGr.Style["display"] = "block";

            trrepeter.Style["display"] = "None";
            //btnSubmit.Enabled = false;
        }
    }
    
}