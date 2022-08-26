<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage.master" CodeFile="RequestFollowReport.aspx.cs" Inherits="Request_RequestFollowReport" %>

 

<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Module  > Reports >Journey/Trip Register</asp:Label>
                <hr align="center" size="1" color="#8ba0e5"> 
            </td> 
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
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
                            <td align="center" valign=top style="width: 250px">
                                &nbsp;<asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Request Created in Date Range:</asp:Label></td>
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
                            <td valign="top" align="left" style="width: 292px">
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
                        
                        <tr   class="bgbluegrey">
                            <td align="center"  colspan="4">
                                <asp:Label ID="lblheading2"  CssClass="blackfnt" Font-Bold="true"   runat="server" Text="Select Request Status" ></asp:Label>
                                
                     
                              </td>
                           
                        </tr>
                         <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1">
                                 <asp:Label ID="lblStatus" runat="server" Text="Status" Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem>Both</asp:ListItem>
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Completed</asp:ListItem>
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                        	   
                        
                   


                        
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShow" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShow_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>

<br />
 <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                &nbsp;<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="50"  OnPageIndexChanging="pgChange" >
                            <Columns>
                   <asp:BoundField   DataField="origin" HeaderText="Location"   />
                             <asp:BoundField DataField="RequestNo" HeaderText="Total Request">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="ReqAck" HeaderText="Request Acknowledged">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReqNAck" HeaderText="Request Not Acknowledged">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripIssued" HeaderText="Trip Sheet Issued">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripNIssued" HeaderText="TripSheet Not Issued">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="JCNo" HeaderText="Trip/Journey Completed"  />
                                <asp:BoundField DataField="JTNo" HeaderText="Trip/Journey In-transit"   />
                      
   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

</asp:Content> 