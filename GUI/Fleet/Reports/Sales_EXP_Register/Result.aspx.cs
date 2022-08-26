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
using System.Collections.Generic;
using System.Reflection;
using Microsoft.Reporting.WebForms;
using System.Xml; 
public partial class GUI_UNI_Net_MIS_Sales_EXP_Register_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string select_list = Request.QueryString["select_list"].ToString();
            //string select_Text = Request.QueryString["select_Text"].ToString();

            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
            string MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();

            string selectView = Request.QueryString["selectView"].ToString();
            string st_status = Request.QueryString["st_status"].ToString();
            string str_status = Request.QueryString["str_status"].ToString();

            string DocketLsit = "", strcustcd = "";
            DocketLsit = Request.QueryString["DocketLsit"].ToString();
            strcustcd = Request.QueryString["strcustcd"].ToString();
            if (strcustcd == "")
                strcustcd = "All";
            if (DocketLsit == "")
                DocketLsit = "All";



            string st_paybasis = Request.QueryString["st_paybasis"].ToString();
            string st_trnmod = Request.QueryString["st_trnmod"].ToString();
            string st_type = Request.QueryString["st_type"].ToString();
            string st_busttype = Request.QueryString["st_busttype"].ToString();
            string str_paybasis = Request.QueryString["str_paybasis"].ToString();
            string str_trnmod = Request.QueryString["str_trnmod"].ToString();
            string str_busttype = Request.QueryString["str_busttype"].ToString();
            string str_type = Request.QueryString["str_type"].ToString();
            string DTTYPE = Request.QueryString["DTTYPE"].ToString();
            string company = Request.QueryString["company"].ToString();
            //LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
            //LBLBRANCH.Text = MAxStr_VAL;
            //lblPaybasis.Text = str_paybasis;
            //lblmode.Text = str_trnmod;
            //lblBKGTYP.Text = str_type;
            //Label1.Text = str_busttype;
            //lblStatus.Text = str_status;
            //Response.Write(st_status);


            string abcd = "exec WebxNet_Sales_Register_ver2_1 '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + dtFrom + "',        '" + dtTo + "','" + DTTYPE + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "',        '" + select_list + "','" + selectView + "','" + st_status + "'  ";
            // Response.Write("<br> st_status" + abcd);
            //  Response.End();
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("location_to", MAxStr_VAL_to.ToString()));
            parameters.Add(new ReportParameter("locLevel_to", MAxSTR_LV_to.ToString()));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("DTTYP", DTTYPE.ToString()));
            parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
            parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
            parameters.Add(new ReportParameter("custcode", strcustcd));
            parameters.Add(new ReportParameter("DocketLsit", DocketLsit));
            parameters.Add(new ReportParameter("SelectLsit", select_list.ToString()));
            parameters.Add(new ReportParameter("SelectView", selectView.ToString()));
            parameters.Add(new ReportParameter("Status", st_status.ToString()));
            parameters.Add(new ReportParameter("EmpCode", Session["empcd"].ToString()));
            //if (company != "All")
            //    parameters.Add(new ReportParameter("Company", company.ToString()));
            //else
            string[] strArr = company.Split(',');
            parameters.Add(new ReportParameter("Company", strArr));
            /*
             *     
             * */
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            //Response.Write("path"+ReportServiceUtilities.ReportPathPrefix);
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/SalesRegister_Ver2_1";
            ReportViewer1.ServerReport.SetParameters(parameters);

            List<MyRSService.ParameterValue> pList = new List<MyRSService.ParameterValue>();
            foreach (ReportParameter rp in parameters)
            {
                MyRSService.ParameterValue p = new MyRSService.ParameterValue();
                p.Name = rp.Name;
                p.Value = "";
                foreach (string s in rp.Values)
                {
                    if (p.Value == "")
                        p.Value = s;
                    else
                        p.Value += ","+s;
                }
                pList.Add(p);
            }
            XmlDocument XDOC = new XmlDocument();
            XmlElement xParameters = XDOC.CreateElement("Parameters");
            foreach (MyRSService.ParameterValue p in pList)
            {
                XmlElement nParameter = XDOC.CreateElement("Parameter");
                XmlElement nName = XDOC.CreateElement("Name");
                nName.InnerText = p.Name;
                nParameter.AppendChild(nName);

                XmlElement nDefaultValues = XDOC.CreateElement("DefaultValues");
                XmlElement nValues = XDOC.CreateElement("Values");
                XmlElement nValue = XDOC.CreateElement("Value");

                if (p.Name != "Company")
                    nValue.InnerText = p.Value;
                else
                    nValue.InnerText = company;

                nDefaultValues.AppendChild(nValue);
                nValues.AppendChild(nValue);

                nParameter.AppendChild(nDefaultValues);
                nParameter.AppendChild(nValues);
                xParameters.AppendChild(nParameter);
            }
            XDOC.AppendChild(xParameters);


            LnkRPT1.xml_EmailParameter = XDOC.InnerXml;
            LnkRPT1.Report_NM = "SalesRegister_Ver2_1";
            LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "/SalesRegister_Ver2_1";
        }
    }



}
