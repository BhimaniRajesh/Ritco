<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="frmRequestApprovalQuery.aspx.cs" Inherits="Request_frmRequestApprovalQuery" %>
<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Requests >> Approval/Confirmation</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Vehicle Request ID:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input" ID="txtRequestID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRequestID"
                                            ErrorMessage="*" ValidationGroup="VGRequestID" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                         
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClick="btnShowMultipleRequest_Click"
                                             />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="3">
                                <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign=top>
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Request Created in Date Range:</asp:Label>
                            </td>
                            <td align="left">
                                <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td valign="top" align="left">
                                <asp:UpdatePanel ID="UpdatePanel7" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateFrom"
                                            ErrorMessage="Date From cannot be blank" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3"  runat="server" ErrorMessage="Invalid Date From"
                                            ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            CssClass="redfnt"></asp:RegularExpressionValidator>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateTo"
                                            ErrorMessage="Date To cannot be blank" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Invalid Date To"
                                            ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            CssClass="redfnt"></asp:RegularExpressionValidator>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Requested by:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:TextBox  ID="txtRequestBy" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        	     <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label11" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Journey start date:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                      <DateCalendar:header id="DtCal" runat="server" ></DateCalendar:header>
                            </td>
                        </tr>

                        
                             <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Font-Bold="True">Select Origin City:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:DropDownList ID="cboOrgnCity" runat=server ></asp:DropDownList><%--OnSelectedIndexChanged="FillPickupLoc"  AutoPostBack=true--%>
                            </td>
                        </tr>
                        
                         <%--<tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label10" CssClass="blackfnt" runat="server" Font-Bold="True">Select Pickup location:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate> 
                                <asp:Panel runat="server" ID="Panel1" Visible="true">
                                       <asp:DropDownList ID="cboOrgnLoc" runat=server ></asp:DropDownList>
                                </asp:Panel>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cboOrgnCity" EventName="SelectedIndexChanged" />
                            </Triggers>
                            </asp:UpdatePanel>
                            </td>
                        </tr>--%>
                        
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label9" CssClass="blackfnt" runat="server" Font-Bold="True">Select Vehicle Type:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:DropDownList ID="cboVehType" runat=server ></asp:DropDownList>
                            </td>
                        </tr>


                        
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShowMultipleRequest_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>

<br />


</asp:Content> 