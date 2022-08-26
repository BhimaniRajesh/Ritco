<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_RouteList_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">

    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
     

    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;</strong>
                            <strong>Operation </strong></font><font class="bluefnt"><strong>&gt;</strong> <strong>
                                Root Performance Report</strong> </font>
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
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Route Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter Route Start Location Name </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtstartBranch" runat="server"></asp:TextBox>
                                <input type="button" onclick="cust('L');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>--%>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter Route End Location Name </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtEndBranch" runat="server"></asp:TextBox>
                                <input type="button" onclick="cust('L1');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                            </td>
                        </tr>
                        <%-- <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>--%>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter EnRoute Location Name </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtEnrouteBranch" runat="server"></asp:TextBox>
                                <input type="button" onclick="cust('L2');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter Route Code </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtroutecode" runat="server"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
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
<%--OnClick="btnShow_Click"--%>
