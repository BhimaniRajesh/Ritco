    <%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="Tracking" EnableEventValidation="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="JavaScript" src="./../Images/CalendarPopup.js"></script> 
<script type="text/javascript" language="javascript" src="./../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>

<script type="text/javascript" language="javascript">

function btnShowVal()
{


var txtfrom=document.getElementById("ctl00$MyCPH1$txtDateFrom");
var txtto=document.getElementById("ctl00$MyCPH1$txtDateFrom");



if(!isValidDate(txtfrom.value,"From"))
    return false;
    
    if(!isValidDate(txtto.value,"To"))
    return false;


}
</script> 
    
  
    <div>
    <br /><br />
    <table  align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" >
        <tr bgcolor="white" class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman;
            height: 25px">
            <td align="center" class="bgbluegrey" colspan="4" style="height: 25px">
             <asp:Label CssClass="blackfnt" Text="Select Criteria"  runat="server"></asp:Label>  
            </td>
        </tr>
        <tr bgcolor="white"  style="font-size: 12pt; font-family: Times New Roman;
            height: 25px">
            <td  nowrap   style="width: 2px; height: 25px">
                <asp:Label CssClass="blackfnt" Text="Select Document Type" Width="150" runat="server" ></asp:Label></td>
            <td align="left" colspan="3" style="height: 25px">
                <asp:DropDownList   ID="documet_type" runat="server">
                <%--<asp:ListItem   Selected="True"  "D"></asp:ListItem>--%>
                <asp:ListItem Text="Loading Sheet" Value="L"></asp:ListItem>
                <asp:ListItem Text="Manifest" Value="M"></asp:ListItem>
                <asp:ListItem Text="THC" Value="T"></asp:ListItem>
                <asp:ListItem Text="PRS/DRS" Value="P"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr bgcolor="white" class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td align="center" class="bgbluegrey" style="width: 2px; height: 25px">
            </td>
            <td align="center" class="bgbluegrey" style="width: 2px; height: 25px"><font class="blackfnt">
                   From 
                  </font>
            </td>
            <td  align="center" colspan="2"  style="height: 25px">&nbsp;&nbsp;&nbsp;<font class="blackfnt">
                   To 
                  </font>
            </td>
        </tr>
        <tr id="ROWLO" visible="true"  runat="server" style="background-color: white">
                        <td align="left" ><asp:Label ID="Label8"  CssClass="blackfnt" Text="Select RO" runat="server" Width="100%"></asp:Label>
                        </td>
                        <td align="left" colspan="2"  valign="top">
                         
                    <asp:UpdatePanel Id="UP" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cboRO" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged" >
                   <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                    </asp:DropDownList>
                   </ContentTemplate>
        </asp:UpdatePanel>
                        </td>
                            <td align="left" colspan="1" valign="top">
                              <asp:UpdatePanel Id="UpdatePanel7" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cboRO_TO" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO" >
                   <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                    </asp:DropDownList>
                   </ContentTemplate>
        </asp:UpdatePanel>
                            </td>
                            
                    </tr>
         <tr   style="background-color: white">
                        <td align="left"><asp:Label ID="Label7"  CssClass="blackfnt" Text="Select Location" runat="server" Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top"> 
                        <asp:UpdatePanel Id="updatepanel8" runat="server"> <ContentTemplate>
                          <asp:DropDownList ID="cboRO_Lo" runat="server" AutoPostBack="true" Mode="Conditional" RenderMode="Inline" Width="102px">
                                    <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                          </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                    </Triggers>
                    
                    </asp:UpdatePanel>
                        </td>
                        <td align="left" colspan="1" valign="top">
                        <asp:UpdatePanel Id="updatepanel1" runat="server"> <ContentTemplate>
                          <asp:DropDownList ID="cboRO_Lo_TO" runat="server" AutoPostBack="true" Mode="Conditional" RenderMode="Inline" Width="102px">
                                    <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                          </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboRO_TO" EventName="SelectedIndexChanged" />
                    </Triggers>
                    
                    </asp:UpdatePanel>
                        </td>
                        
                    </tr>
       <%-- <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td  nowrap align="Left" style="width: 2px; height: 25px"><asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer " Width="150" runat="server" ></asp:Label>
            </td>
            <td colspan="3" style="height: 25px">
                <asp:TextBox ID="custcode" runat="server"></asp:TextBox></td>
        </tr>--%>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="height: 25px;"  align="center" colspan="4">
                <table height="100%" width="100%">
                    <tr>
                        <td align="left" style="width: 281px">
                            <asp:UpdatePanel id="UpdatePanel9" runat="server">
                                <contenttemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange" Width="282px" CellPadding="3">
                                        <asp:ListItem Selected="True" Value="0" Text="Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Today:"></asp:ListItem>
                                        <asp:ListItem  Enabled="False" Text="Till Date:"></asp:ListItem>
                                                            
                                        <asp:ListItem Value="4" Text="Document No(s). (System Generated No.) :"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="Document No(s). (Manual No./Invoice No.):"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </contenttemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel id="UpdatePanel10"  runat="server" >
                                <contenttemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="./../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../images/calendar.jpg" border="0"></img>
			</A>&nbsp;<br />
                                    &nbsp;<br />
                                    &nbsp;<br />
                                    &nbsp;<br />
                                    &nbsp;<br />
                                    
                                </contenttemplate>
                                <triggers>
                                <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </triggers>
                            </asp:UpdatePanel>
                            
                            <asp:TextBox ID="docketlist" runat="server" Width="200px"
                             style="left: 2px; position: relative; top: 8px; z-index: 101;"></asp:TextBox>
                             
                             <asp:TextBox ID="manuallist" runat="server"  
                            Style="left: -207px; position: relative; top: 31px; z-index: 101;" Width="200px" ></asp:TextBox></td>
                    </tr>
                </table>
            </td>
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td align="center" colspan="4" style="height: 25px">
                <asp:Button ID="btnShow" runat="server" Text="Show"  OnClick="btnShow_Click"   Width="75px" />
            </td>
        </tr>
    </table>
    
    <br /><br />
    
    <%-- <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
      <ContentTemplate>
       <asp:GridView  align="center" ID="dgDocket" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" 
                              CssClass="boxbg"     BackColor="white" FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                             
                             EmptyDataText="No Records Found..."  OnPageIndexChanging="pgChange" >
                            <Columns >
                                 <asp:TemplateField  HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>    
                                                            
                               <asp:BoundField  DataField="Dockno"      HeaderText="Docket No" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                   <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                 <asp:BoundField   DataField="Dockdt" HeaderText="Docket Date" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                 <asp:BoundField   DataField="cdeldt" HeaderText=" EDD - ADD " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField   DataField="orgncd" HeaderText="Origin - Destination" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField   DataField="paybas" HeaderText="Paybas | Mode" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField   DataField="cnor" HeaderText="Consignor" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField   DataField="cnee" HeaderText="Consignee" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                
                                <asp:BoundField  DataField="docket_mode" HeaderText="Type" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                               </Columns>
                               <Columns>
                               
                               <asp:TemplateField  HeaderStyle-CssClass="bgblegrey"  HeaderText="Track" HeaderStyle-Width="15">
                               
                                    <ItemTemplate>
                                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DOCKNO") %>')">
                                           <font cssclass="Blackfnt">Track
                                        </a>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="bgpink" /></asp:TemplateField> </Columns>
                             
                            <RowStyle  />
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
           <FooterStyle CssClass="boxbg" />
                       
                       
                       
                        </asp:GridView>
                        
                        
              <asp:GridView  align="center" ID="dgMenifest" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" 
                              CssClass="boxbg"     BackColor="white" FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                             
                             EmptyDataText="No Records Found..."  OnPageIndexChanging="pgChange" >
                            <Columns >
                                 <asp:TemplateField  HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>              
                        
                         
                                                            
                               <asp:BoundField DataField="tcno" HeaderText="MF No" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="tcdt" HeaderText="MF Date" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tcbr" HeaderText="Origin" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                
                               </Columns>
                             
                            <RowStyle  />
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
           <FooterStyle CssClass="boxbg" />
                       
                       
                       
                        </asp:GridView>
    
     </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>--%>
    
    </div>
  <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>
