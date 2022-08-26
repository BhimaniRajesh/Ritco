<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_Tracking_New_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();


    </script>

   
    <br />
    <div align="left">
    
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>



<font class=bluefnt><strong> &gt; </strong>
		  <strong>Tracking</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="./../images/clear.gif" width="2" height="1"></td>
        </tr>
     
   
        
        <tr> 
          <td align=right><img src="./../images/back.gif" border=0></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
        <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="7" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                </td>
            </tr>
            <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                <td align="left" colspan="2">
                    <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type"
                        runat="server"></asp:Label></td>
                
                <td align="left" colspan="5" valign="top">
                    <asp:DropDownList ID="documet_type" runat="server">
                        
                        <asp:ListItem Text="Loading Sheet" Value="LS"></asp:ListItem>
                        <asp:ListItem Text="Manifest" Value="MF"></asp:ListItem>
                        <asp:ListItem Text="PRS" Value="PRS"></asp:ListItem>
                        <asp:ListItem Text="DRS" Value="DRS"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="ROWLO" visible="true" runat="server" style="background-color: white">
                <td align="left" colspan="2">
                    <asp:Label ID="Label8" CssClass="blackfnt" Text="Select RO" runat="server" ></asp:Label>
                </td>
                <td align="left" colspan="2" valign="top">
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged">
                                <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td align="left" colspan="3" valign="top">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_TO" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO" >
                   <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                    </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <asp:Label ID="Label7" CssClass="blackfnt" Text="Select Location" runat="server"
                        ></asp:Label>
                </td>
                <td align="left" colspan="2" valign="top">
                    <asp:UpdatePanel ID="updatepanel8" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo" runat="server" Mode="Conditional" RenderMode="Inline"
                                Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO" --%>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td> 
                <td align="left" colspan="3" valign="top">
                    <asp:UpdatePanel ID="updatepanel1" runat="server">
                        <ContentTemplate>
                          <asp:DropDownList ID="cboRO_Lo_TO" runat="server" AutoPostBack="true" Mode="Conditional" RenderMode="Inline" Width="102px">
                                   
                          </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <%-- <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                    <td align="left" colspan="2">
                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Paybas" runat="server" Width="100%"></asp:Label>
                    </td>
                    <td align="left" colspan="5" valign="top">
                        <asp:DropDownList ID="DLLpaybas" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="Tr2" visible="true" runat="server" style="background-color: white">
                    <td align="left" colspan="2">
                        <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Mode" runat="server" Width="100%"></asp:Label>
                    </td>
                    <td align="left" colspan="5" valign="top">
                        <asp:DropDownList ID="DLLMode" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="Tr3" visible="true" runat="server" style="background-color: white">
                    <td align="left" colspan="2">
                        <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Status" runat="server" Width="100%"></asp:Label>
                    </td>
                    <td align="left" colspan="5" valign="top">
                        <asp:DropDownList ID="DLLDly" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            <asp:ListItem Value="Y" Text="Delivered"></asp:ListItem>
                            <asp:ListItem Value="N" Text="Not - Delivered"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>--%>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            Width="210px">
                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                        </asp:RadioButtonList>
                    </td>
                    <td valign="top" colspan="5">
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="anchor1">
                            <img src="./../images/calendar.jpg" border="0"></img>
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a1">
                            <img src="./../images/calendar.jpg" border="0"></img>
                        </a>
                    </td>
                </tr>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Text=" Document No(s). (Manual No./Invoice No.):� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtmanbo" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label9" CssClass="blackfnt" runat="server" Text=" Customer Ref. No./Vehicle No. :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtCustRefno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label11" CssClass="blackfnt" runat="server" Text=" Free Text :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtFreeText" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[Insert Remak Word]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();s"
                        runat="server" Text="Show" Width="75px" />
                </td>
            </tr>
        </table>
        
         </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
