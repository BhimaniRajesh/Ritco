<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_PRQEntry_PRQ_Report_Query" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="webxcomplete"
    TagPrefix="xac" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register TagName="LH1" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function OnSub_DATACHECK()
     {     
        if(!DateCheck())
            return false;      
     }
       
        function ChkSelection(val)
	    {		     
	        if(document.getElementById("ctl00_MyCPH1_rdOutputType_1").checked==true)
	        {
	            document.getElementById('ctl00_MyCPH1_LocationWise').style.display = "block";	        
	            document.getElementById('ctl00_MyCPH1_CustomerWise').style.display = "none";
	        }
	        else if(document.getElementById("ctl00_MyCPH1_rdOutputType_2").checked==true)
	        {
	            document.getElementById('ctl00_MyCPH1_LocationWise').style.display = "none";	        
	            document.getElementById('ctl00_MyCPH1_CustomerWise').style.display = "block";
	        }
	        else
	        {
	            document.getElementById('ctl00_MyCPH1_LocationWise').style.display = "block";
	            document.getElementById('ctl00_MyCPH1_CustomerWise').style.display = "block";
	        }
	    }
	    
//	    function onSubmitCheckValue()
//        {   
//            var ddlMode = document.getElementById("ctl00_MyCPH1_ddlMode").options.length;     
//            var ddlSvcType = document.getElementById("ctl00_MyCPH1_ddlSvcType").options.length;            
//            
//            if(ddlMode>1)
//            {
//                if(document.getElementById("ctl00_MyCPH1_ddlMode").value == "0")
//                {        
//                   alert("Please select Mode");  
//                   document.getElementById("ctl00_MyCPH1_ddlMode").focus();         
//                   return false;
//                }
//            }
//            
//            if(ddlSvcType>1)
//            {
//                if(document.getElementById("ctl00_MyCPH1_ddlSvcType").value == "0")
//                {        
//                   alert("Please select Service Type"); 
//                   document.getElementById("ctl00_MyCPH1_ddlSvcType").focus();          
//                   return false;
//                }
//            }
//            
//            if(document.getElementById("ctl00_MyCPH1_txtBillPartyCode").value == "")
//            {
//                alert("Please Enter Billing Party Code");
//                document.getElementById("ctl00_MyCPH1_txtBillPartyCode").focus();           
//                return false;
//            } 
//            return true;           
//        }
        
    </script>
     <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <div align="left">
                <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="30">
                            <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                                class="blklnkund"><strong>Octroi </strong></font><font class="bluefnt"><strong>&gt;</strong>
                                <strong>Octroi Bill View & Print</strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="./../../images/clear.gif" width="2" height="1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <%--<a href="javascript:window.history.go(-1)" title="back">
                                <img alt="Back" src="./../../images/back.gif" border="0">
                            </a>--%>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td colspan="7" align="center" class="hrow">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Selection Criteria </asp:Label>
                                    </td>
                                </tr>                               
                               
                                <tr bgcolor="white">
                                    <td align="left">
                                <font class="blackfnt">Select Date &nbsp;</font>&nbsp;</td>
                                    <td align="left" colspan="3">
                                        <Date:DT ID="DT" runat="server" />
                                    </td>
                                </tr>
                                 <tr id="CustomerWise" runat="server" bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Billing Party</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtBillPartyCode" runat="server" MaxLength="10" Width="90px" CssClass="ltxtm"
                                                        autocomplete="off"></asp:TextBox><asp:TextBox ID="txtBillPartynm" 
                                                        Width="220px" Enabled="false"
                                                            CssClass="ltxtm" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <xac:webxcomplete ID="xacBillParty" NameTarget="txtBillPartynm" MinPrefixLength="2"
                                                        WebxEntity="Customer" runat="server" CodeTarget="txtBillPartyCode" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr align="center" bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Enter Octroi Bill Number</font>
                                    </td>
                                    <td align="left" colspan="3">
                                    <asp:textbox runat="server" text="" id="txtBillNo" width="300"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>                                        
                                    </td>
                                </tr>
                                <tr align="center" class="bgbluegrey">
                                    <td colspan="7">
                                        <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" CssClass="fbtn" />
                                    </td>
                                </tr>                               
                            </table>
                        </td>
                    </tr>
                </table>
            </div>   
            </ContentTemplate>
            </asp:UpdatePanel>    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>    
</asp:Content>
