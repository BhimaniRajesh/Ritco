<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Miss_Route_Register_Query" %>
<%@ Register TagName="LH1" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
       /* if(!FinDateCheck())
            return false;     */        
     }
     
     function cust(ID)
        {
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }    
        
    </script>

     <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 23/5/2014 --%>
  <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;</strong>
                            <strong>Operation </strong></font><font class="bluefnt"><strong>&gt;</strong> <strong>
                                Miss Route Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white" id="LocationID" runat="server">
                            <td align="left" colspan="4">
                                <Location:LH1 ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Date Type </font>&nbsp;<asp:DropDownList ID="ddlDtType"
                                    runat="server">
                                    <asp:ListItem Selected="True" Value="1">Document Date</asp:ListItem>
                                    <asp:ListItem Value="2">Entry Date</asp:ListItem>
                                </asp:DropDownList></td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Location</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtstartBranch" runat="server" Width="47px"></asp:TextBox>
                                <input type="button" onclick="cust('L');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                            </td>
                        </tr>--%>                        
                        <%--<tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Login Instance</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtLoginInstance" runat="server" Width="100px"></asp:TextBox>
                            </td>
                        </tr>--%>                        
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
