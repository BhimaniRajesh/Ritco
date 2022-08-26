<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="VehicleOccupancyReport.aspx.cs" Inherits="Reports_VehicleOccupancyReport" %>


<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Module  > Reports >Vehicle Occupancy Report</asp:Label>
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
                            <td align="center" valign=top style="width: 250px; height: 186px;">
                                &nbsp;<asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Journey Start Date Range:</asp:Label></td>
                            <td align="left" style="height: 186px">
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
                            <td valign="top" align="left" style="width: 292px; height: 186px;">
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
                                        <atlas:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                      
                        <tr style="background-color: white">
                            <td align="center" colspan="1">
                                <asp:Label ID="lblVehicleType" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Select Vehicle Type"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="lstVehicleType"
                                            ErrorMessage="*" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                            </td>
                          
                             <td align="left" colspan="2">
                                   <asp:ListBox ID="lstVehicleType" SelectionMode="multiple" runat="server" >
                            </asp:ListBox>
                            </td>
                            
                            
                            
                        </tr>
                          <tr style="background-color: white">
                            <td align="left" colspan="1">
                                  <asp:RadioButton ID="rbtn1" CssClass="blackfnt" runat="server" Font-Bold="true" Text="WeekWise"/>
                            </td>
                           
                             <td align="left" colspan="2">
                                   <asp:RadioButton ID="rbtn2" CssClass="blackfnt" runat="server" Font-Bold="true" Text="DateWise"/>
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
                               <%--<asp:BoundField DataField="RouteCode" HeaderText="Vehicle Type">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="origin" HeaderText="Vehicle Nos.">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>--%>
                               <%-- <asp:BoundField DataField="Destn" HeaderText="Destination">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                  <asp:HyperLinkField    DataNavigateUrlFields="RequestNo"  DataTextField="RequestNo" DataNavigateUrlFormatString="~/Reports/DetailReport.aspx?id=Request"   HeaderText="Request">
                                   <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                   </asp:HyperLinkField>
                                  <asp:HyperLinkField   DataNavigateUrlFields="IssueNo" DataTextField="IssueNo" DataNavigateUrlFormatString="~/Reports/DetailReport.aspx?id=Issue" HeaderText="Issue">
                                   <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                   </asp:HyperLinkField>
                                  <asp:HyperLinkField DataNavigateUrlFields="JCNo"   DataTextField="JCNo"  DataNavigateUrlFormatString="~/Reports/DetailReport.aspx?id=JCNo"  HeaderText="Journey Trips Completed">
                                  <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                  </asp:HyperLinkField>
                                  <asp:HyperLinkField  DataNavigateUrlFields="JTNo" DataTextField="JTNo"  DataNavigateUrlFormatString="~/Reports/DetailReport.aspx?id=JTNo" HeaderText="Journey Trips In Transit">
                                 <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>--%>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        
                  <%--  </ContentTemplate>
                    <Triggers>
                        <atlas:ControlEventTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers> 
                </asp:UpdatePanel>--%>
            </td>
        </tr>
    </table>

 
  </td> </tr> </table>

 
  </td> </tr> </table>

 
  </td> </tr> </table>

 
 <%-- <p align="center">
  <table >
  <tr  align="center" style="background-color: white">
  <td align="center" style="height: 21px">
    <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server"  Visible="false" OnClick="LinkButton1_Click">Transform To XLS</asp:LinkButton>
  </td>
        </tr>
  </table>
  </p>--%>
                     </ContentTemplate>
                    <Triggers>
                        <atlas:ControlEventTrigger ControlID="btnShow" EventName="Click" />
                                          
                    </Triggers> 
                
                </asp:UpdatePanel>
              <%-- </form>--%>
</asp:Content> 
