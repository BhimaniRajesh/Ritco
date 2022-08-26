<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DDMRProcessCriteria.aspx.cs" Inherits="GUI_Operations_DocketNonDeliveryUpdate_DocketNonDeliveryCriteria" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="../../images/CalendarPopup.js" type="text/javascript"></script>

    <script language="javascript" src="../../images/commonJs.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
    
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function OnSub_DATACHECK()
     {
        if(!DateCheck())
            return false;
     }
    function validInt(e)
    {
	    var code;
	    if (!e) var e = window.event;
	    if (e.keyCode) 
	        code = e.keyCode;
	    else if (e.which) 
	        code = e.which;
	    else 
	        return true;
	
        if(code==13 || code==8 || code==9)
            return true;
        
        if(code<48 || code>57)
        {
            code=0;
            return false;
        }
    }
    function validHrs()
    {
        if(document.getElementById('ctl00_MyCPH1_txtNoOfHrs').value > 23)
        {
            alert('Please Enter the Value Between 0 to 23');
            document.getElementById('ctl00_MyCPH1_txtNoOfHrs').focus();
            document.getElementById('ctl00_MyCPH1_txtNoOfHrs').select();
            return false;
        }
    }
//    function validDocket()
//    {
//        if(document.getElementById('ctl00_MyCPH1_rdDocketCri').checked == true && document.getElementById('ctl00_MyCPH1_txtDocketNo').value == "")
//        {
//            alert('Please Enter Docket No');
//            document.getElementById('ctl00_MyCPH1_txtDocketNo').focus();
//            return false;
//        }
//    }    
        
    </script>

    <div align="left">
        <br />
        <table cellspacing="1" class="stbl" align="left" >
            <tr class="hrow">
                <td colspan="3" align="center">
                    <asp:Label ID="lblQry" CssClass="ffnt" Font-Bold="true" runat="server">DDMR Generation </asp:Label>
                </td>
            </tr>
            <tr class="nrow">
                <td >
                    <asp:RadioButton ID="rdDateRange" GroupName="grpcri" runat="server" /></td>
                <td align="left" >
                    <font class="nfnt">Select Date </font>&nbsp;
                </td>
                <td align="left" style="width:5in">
                    <Date:DT ID="DT" runat="server" />
                </td>
            </tr>
            <%--<tr class="nrow">
                <td>
                    <asp:Label ID="lblNoOfDays" runat="server" CssClass="nfnt">Enter No Of Days</asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtNoOfDays" BorderStyle="groove" runat="server" CssClass="rtxt"
                        Width="25px" MaxLength="2" onkeypress="javascript:return validInt(event);" Text=""></asp:TextBox>
                </td>
            </tr>--%>
            <%--<tr bgcolor="white" style="display:none">
                <td>
                    <asp:Label ID="lblNoOfHrs" runat="server" CssClass="nfnt">Enter No Of Hrs</asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtNoOfHrs" runat="server" BorderStyle="groove" CssClass="rtxt"
                        Width="25px" MaxLength="2" onblur="javascript:return validHrs();" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                </td>
            </tr>--%>
            <tr bgcolor="white">
                <td valign="middle">
                    <asp:RadioButton ID="rdDocketCri" GroupName="grpcri" runat="server" />
                </td>
                <td>
                    <asp:Label ID="lblDocketNo" runat="server" CssClass="nfnt">Enter <%=SessionUtilities.DocketCalledAs %> No</asp:Label>
                    </td>
                <td >
                    <asp:TextBox ID="txtDocketNo" runat="server" BorderStyle="groove" CssClass="ltxt"
                         Width="250"></asp:TextBox>
                    <font class="blackfnt">[Seperated By <i>Comma</i> If Multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td class="frow" colspan="3">
                    <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server"
                        Text="Show" Width="75px" CssClass="fbtn" OnClick="btnShow_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
